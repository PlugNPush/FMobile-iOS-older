//
//  DataManager.swift
//  FMobile
//
//  Created by Nathan FALLET on 31/03/2019.
//  Copyright © 2019 Groupe MINASTE. All rights reserved.
//

import Foundation
import CoreTelephony
import SystemConfiguration.CaptiveNetwork
import CallKit
import UIKit

class DataManager {
    
    // Configuration
    let datas = Foundation.UserDefaults.standard
    var modeRadin = false
    var allow013G = true
    var allow012G = true
    var femtoLOWDATA = false
    var femto = true
    var verifyonwifi = false
    var stopverification = false
    var timecode = Date()
    var lastnet = ""
    var count = 0
    var wasEnabled = false
    var isRunning = false
    var lowbat = false
    var didChangeSettings = false
    var ntimer = Date().addingTimeInterval(-15 * 60)
    var dispInfoNotif = true
    var allowCountryDetection = true
    var timeLastCountry = Date().addingTimeInterval(-70 * 60)
    var lastCountry = "FR"
    var url = "http://test-debit.free.fr/512.rnd"
    var urlst = "http://test-debit.free.fr/1048576.rnd"
    var setupDone = false
    var minimalSetup = true
    var modeExpert = false
    var statisticsAgreement = false
    
    // Carrier vars
    var simData = String()
    var currentNetwork = String()
    var carrier = String()
    var carriersim = String()
    var mycarrier = CTCarrier()
    var mycarrier2 = CTCarrier()
    var carrierNetwork = String()
    var carrierNetwork2 = String()
    var carrierName = String()
    var checkSimMCC = "999"
    var checkSimMNC = "99"
    
    // Carrier setup
    var hp = "WCDMA"
    var nrp = "HSDPA"
    var targetMCC = "208"
    var targetMNC = "15"
    var itiMNC = "01"
    var nrDEC = true
    var out2G = "yes"
    var chasedMNC = ""
    var connectedMCC = ""
    var connectedMNC = ""
    var ipadMCC = ""
    var ipadMNC = ""
    var itiName = "Orange F"
    var homeName = "Free"
    var stms = 0.768
    var includedData = [String]()
    var includedVoice = [String]()
    var includedVData = [String]()
    var disableFMobileCore = false
    
    init() {
        print(Locale.current.languageCode ?? "...");
        if datas.value(forKey: "modeRadin") != nil && Locale.current.languageCode == "fr" {
            modeRadin = datas.value(forKey: "modeRadin") as? Bool ?? false
        }
        if datas.value(forKey: "allow013G") != nil {
            allow013G = datas.value(forKey: "allow013G") as? Bool ?? true
        }
        if datas.value(forKey: "allow012G") != nil {
            allow012G = datas.value(forKey: "allow012G") as? Bool ?? true
        }
        if datas.value(forKey: "femtoLOWDATA") != nil {
            femtoLOWDATA = datas.value(forKey: "femtoLOWDATA") as? Bool ?? false
        }
        if datas.value(forKey: "femto") != nil {
            femto = datas.value(forKey: "femto") as? Bool ?? true
        }
        if datas.value(forKey: "verifyonwifi") != nil {
            verifyonwifi = datas.value(forKey: "verifyonwifi") as? Bool ?? false
        }
        if datas.value(forKey: "stopverification") != nil {
            stopverification = datas.value(forKey: "stopverification") as? Bool ?? false
        }
        if datas.value(forKey: "timecode") != nil {
            timecode = datas.value(forKey: "timecode") as? Date ?? Date()
        }
        if datas.value(forKey: "lastnet") != nil {
            lastnet = datas.value(forKey: "lastnet") as? String ?? ""
        }
        if datas.value(forKey: "count") != nil {
            count = datas.value(forKey: "count") as? Int ?? 0
        }
        if datas.value(forKey: "wasEnabled") != nil {
            wasEnabled = datas.value(forKey: "wasEnabled") as? Bool ?? false
        }
        if datas.value(forKey: "isRunning") != nil {
            isRunning = datas.value(forKey: "isRunning") as? Bool ?? false
        }
        if datas.value(forKey: "lowbat") != nil {
            lowbat = datas.value(forKey: "lowbat") as? Bool ?? false
        }
        if datas.value(forKey: "didChangeSettings") != nil {
            didChangeSettings = datas.value(forKey: "didChangeSettings") as? Bool ?? false
        }
        if datas.value(forKey: "NTimer") != nil {
            ntimer = datas.value(forKey: "NTimer") as? Date ?? Date().addingTimeInterval(-15 * 60)
        }
        if datas.value(forKey: "dispInfoNotif") != nil {
            dispInfoNotif = datas.value(forKey: "dispInfoNotif") as? Bool ?? true
        }
        if datas.value(forKey: "allowCountryDetection") != nil {
            femto = datas.value(forKey: "allowCountryDetection") as? Bool ?? true
        }
        if datas.value(forKey: "timeLastCountry") != nil {
            timeLastCountry = datas.value(forKey: "timeLastCountry") as? Date ?? Date().addingTimeInterval(-70 * 60)
        }
        if datas.value(forKey: "lastCountry") != nil {
            lastCountry = datas.value(forKey: "lastCountry") as? String ?? "FR"
        }
        if(datas.value(forKey: "HP") != nil){
            hp = datas.value(forKey: "HP") as? String ?? "WCDMA"
        }
        if(datas.value(forKey: "NRP") != nil){
            nrp = datas.value(forKey: "NRP") as? String ?? "HSDPA"
        }
        if(datas.value(forKey: "MCC") != nil){
            targetMCC = datas.value(forKey: "MCC") as? String ?? "208"
        }
        if(datas.value(forKey: "MNC") != nil){
            targetMNC = datas.value(forKey: "MNC") as? String ?? "15"
        }
        if(datas.value(forKey: "ITIMNC") != nil){
            itiMNC = datas.value(forKey: "ITIMNC") as? String ?? "01"
        }
        if(datas.value(forKey: "OUT2G") != nil){
            out2G = datas.value(forKey: "OUT2G") as? String ?? "yes"
        }
        if(datas.value(forKey: "ITINAME") != nil){
            itiName = datas.value(forKey: "ITINAME") as? String ?? "Orange F"
        }
        if(datas.value(forKey: "HOMENAME") != nil){
            homeName = datas.value(forKey: "HOMENAME") as? String ?? "Free"
        }
        if(datas.value(forKey: "STMS") != nil){
            stms = datas.value(forKey: "STMS") as? Double ?? 0.768
        }
        if(datas.value(forKey: "URL") != nil){
            url = datas.value(forKey: "URL") as? String ?? "http://test-debit.free.fr/512.rnd"
        }
        if(datas.value(forKey: "URLST") != nil){
            urlst = datas.value(forKey: "URLST") as? String ?? "http://test-debit.free.fr/1048576.rnd"
        }
        if(datas.value(forKey: "setupDone") != nil){
            setupDone = datas.value(forKey: "setupDone") as? Bool ?? false
        }
        if(datas.value(forKey: "minimalSetup") != nil){
            minimalSetup = datas.value(forKey: "minimalSetup") as? Bool ?? true
        }
        if(datas.value(forKey: "modeExpert") != nil){
            modeExpert = datas.value(forKey: "modeExpert") as? Bool ?? false
        }
        if(datas.value(forKey: "includedData") != nil){
            includedData = datas.value(forKey: "includedData") as? [String] ?? [String]()
        }
        if(datas.value(forKey: "includedVData") != nil){
            includedVData = datas.value(forKey: "includedVData") as? [String] ?? [String]()
        }
        if(datas.value(forKey: "includedVoice") != nil){
            includedVoice = datas.value(forKey: "includedVoice") as? [String] ?? [String]()
        }
        if(datas.value(forKey: "disableFMobileCore") != nil){
            disableFMobileCore = datas.value(forKey: "disableFMobileCore") as? Bool ?? false
        }
        if(datas.value(forKey: "statisticsAgreement") != nil){
            statisticsAgreement = datas.value(forKey: "statisticsAgreement") as? Bool ?? false
        }
        
        // Arrondi des valeurs
        if stms <= 0.5 {
            stms *= 2.100 // On arrondit à +110%
        } else if stms <= 1.50 {
            stms *= 1.750 // On arrondit à +75%
        } else if stms <= 2 {
            stms *= 1.500 // On arrondit à +50%
        } else if stms <= 3 {
            stms *= 1.250 // On arrondit à +25%
        }

        
        let operatorPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.operator.plist"
        let carrierPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.carrier.plist"
        
        // Déclaration du gestionaire de fichiers
        let fileManager = FileManager.default
        let operatorPListPath = try? fileManager.destinationOfSymbolicLink(atPath: operatorPListSymLinkPath)
        print(operatorPListPath ?? "UNKNOWN")
        
        
        // Obtenir le fichier de configuration de la carte SIM
        let carrierPListPath = try? fileManager.destinationOfSymbolicLink(atPath: carrierPListSymLinkPath)
        print(carrierPListPath ?? "UNKNOWN")
        
        simData = "-----"
        if !(carrierPListPath ?? "unknown").lowercased().contains("unknown") {
            let values = carrierPListPath?.groups(for: "[0-9]+")
            if let group = values?.first {
                simData = group[0]
            }
            
            print(simData)
        }
        
        currentNetwork = "-----"
        if !(operatorPListPath ?? "unknown").lowercased().contains("unknown"){
            let values = operatorPListPath?.groups(for: "[0-9]+")
            if let group = values?.first {
                currentNetwork = group[0]
            }
            
            print(currentNetwork)
        }
        
        carrier = "Carrier"
        
        let url = URL(fileURLWithPath: operatorPListPath ?? "Error")
        do {
            let test: NSDictionary
            if #available(iOS 11.0, *) {
                test = try NSDictionary(contentsOf: url, error: ())
            } else {
                // Fallback on earlier versions
                test = NSDictionary(contentsOf: url) ?? NSDictionary()
            }
            let array = test["StatusBarImages"] as? NSArray ?? NSArray.init(array: [0])
            let secondDict = NSDictionary(dictionary: array[0] as? Dictionary ?? NSDictionary() as? Dictionary<AnyHashable, Any> ?? Dictionary())
            
            carrier = (secondDict["StatusBarCarrierName"] as? String) ?? "Carrier"
        } catch {
            print("Une erreur s'est produite : \(error)")
        }
        
        
        carriersim = "Carrier"
        let urlcarrier = URL(fileURLWithPath: carrierPListPath ?? "Error")
        do {
            let testsim: NSDictionary
            if #available(iOS 11.0, *) {
                testsim = try NSDictionary(contentsOf: urlcarrier, error: ())
            } else {
                // Fallback on earlier versions
                testsim = NSDictionary(contentsOf: urlcarrier) ?? NSDictionary()
            }
            let arraysim = testsim["StatusBarImages"] as? NSArray ?? NSArray.init(array: [0])
            let secondDictsim = NSDictionary(dictionary: arraysim[0] as? Dictionary ?? NSDictionary() as? Dictionary<AnyHashable, Any> ?? Dictionary())
                    
            carriersim = (secondDictsim["StatusBarCarrierName"] as? String) ?? "Carrier"
        } catch {
            print("Une erreur s'est produite : \(error)")
        }
        
        
        connectedMCC = String(currentNetwork.prefix(3))
        connectedMNC = String(currentNetwork.count == 6 ? currentNetwork.suffix(3) : currentNetwork.suffix(2))
        
        checkSimMCC = String(simData.prefix(3))
        checkSimMNC = String(simData.count == 6 ? simData.suffix(3) : simData.suffix(2))
        
        mycarrier = CTCarrier()
        mycarrier2 = CTCarrier()
        
        let info = CTTelephonyNetworkInfo()
        
        if #available(iOS 12.1, *) {
        var simnum = 0
            for (service, carrier) in info.serviceSubscriberCellularProviders ?? [:] {
                simnum += 1
                if simnum == 1{
                    mycarrier = carrier
                    carrierNetwork = info.serviceCurrentRadioAccessTechnology?[service] ?? ""
                } else if simnum == 2 {
                    mycarrier2 = carrier
                    carrierNetwork2 = info.serviceCurrentRadioAccessTechnology?[service] ?? ""
                }
                let radio = info.serviceCurrentRadioAccessTechnology?[service] ?? ""
                print("For Carrier " + (carrier.carrierName ?? "null") + ", got " + radio)
                print(service)
            }
        } else {
            // Fallback on earlier versions
            mycarrier = info.subscriberCellularProvider ?? CTCarrier()
            carrierNetwork = info.currentRadioAccessTechnology ?? ""
            mycarrier2 = CTCarrier()
            carrierNetwork2 = ""
        }
        
        
        
        if (mycarrier2.mobileCountryCode == targetMCC && mycarrier2.mobileNetworkCode == targetMNC) || (mycarrier2.mobileCountryCode == checkSimMCC && mycarrier2.mobileNetworkCode == checkSimMNC) {
            swap(&mycarrier2, &mycarrier)
            swap(&carrierNetwork2, &carrierNetwork)
        }
        
        print(carrierNetwork)
        
        carrierName = mycarrier.carrierName ?? "Carrier"
        
        if carrierName == "Carrier" && carriersim != "Carrier" {
            carrierName = carriersim
        }
        
        ipadMCC = connectedMCC
        ipadMNC = connectedMNC
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            if (connectedMCC == "---" && connectedMNC == "--"){
                connectedMCC = mycarrier.mobileCountryCode ?? "---"
                connectedMNC = mycarrier.mobileNetworkCode ?? "--"
                
                if (connectedMCC != "---" && connectedMNC != "--"){
                    carrier = homeName
                }
            }
            
            if carrierName == "Carrier" && homeName != "null" && !homeName.isEmpty {
                carrierName = homeName
            }
            
        }
        
        
        nrDEC = self.isNRDEC()
        print("nrDEC: \(nrDEC)")
        
        if nrDEC {
            chasedMNC = targetMNC
        } else {
            chasedMNC = itiMNC
        }
        
    }
    
    static func isOnPhoneCall() -> Bool {
        if #available(iOS 10.0, *) {
            for call in CXCallObserver().calls {
                if call.hasEnded == false {
                    return true
                }
            }
        } else {
            let callCenter = CTCallCenter()
            for call in callCenter.currentCalls ?? [] {
                if call.callState == CTCallStateConnected {
                    return true
                }
            }
        }
        return false
    }
    
    static func isWifiConnected() -> Bool {
        if let interface = CNCopySupportedInterfaces() {
            for i in 0 ..< CFArrayGetCount(interface) {
                let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interface, i)
                let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                if let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString), let interfaceData = unsafeInterfaceData as? [String : AnyObject] {
                    print("BSSID: \(interfaceData["BSSID"] ?? "null" as AnyObject), SSID: \(interfaceData["SSID"] ?? "null" as AnyObject), SSIDDATA: \(interfaceData["SSIDDATA"] ?? "null" as AnyObject)")
                    return true
                } else {
                    print("Not connected to wifi.")
                    return false
                }
            }
        }
        return false
    }
    
    static func showWifiConnected() -> String {
        if let interface = CNCopySupportedInterfaces() {
            for i in 0 ..< CFArrayGetCount(interface) {
                let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interface, i)
                let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                if let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString), let interfaceData = unsafeInterfaceData as? [String : AnyObject] {
                    print("BSSID: \(interfaceData["BSSID"] ?? "null" as AnyObject), SSID: \(interfaceData["SSID"] ?? "null" as AnyObject), SSIDDATA: \(interfaceData["SSIDDATA"] ?? "null" as AnyObject)")
                    return interfaceData["SSID"] as? String ?? "null"
                } else {
                    print("Not connected to wifi.")
                    return "null"
                }
            }
        }
        return "null"
    }
    
    
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags : SCNetworkReachabilityFlags = []
        
        if defaultRouteReachability == nil {
            return false
        }
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    static func isEligibleForMinimalSetup() -> Bool {
        let carrierPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.carrier.plist"
        
        // Déclaration du gestionaire de fichiers
        let fileManager = FileManager.default
        
        // Obtenir le fichier de configuration de la carte SIM
        let carrierPListPath = try? fileManager.destinationOfSymbolicLink(atPath: carrierPListSymLinkPath)
        
        let test = NSMutableDictionary(contentsOfFile: carrierPListPath ?? "Error")
        let array = test?["SupportedPLMNs"] as? NSArray ?? NSArray.init(array: [0])
        
        if array.count <= 1 {
            return true
        } else {
            return false
        }
    }
    
    func isNRDEC() -> Bool {
        var valueToReturn = false
        
        if simData != "-----" && setupDone {
            let carrierPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.carrier.plist"
            
            // Déclaration du gestionaire de fichiers
            let fileManager = FileManager.default
            
            // Obtenir le fichier de configuration de la carte SIM
            let carrierPListPath = try? fileManager.destinationOfSymbolicLink(atPath: carrierPListSymLinkPath)
            
            let test = NSMutableDictionary(contentsOfFile: carrierPListPath ?? "Error")
            let array = test?["SupportedPLMNs"] as? NSArray ?? NSArray.init(array: [0])
            
            for index in 0..<array.count {
                let value = array[index] as? String ?? "-----"
                let plmnmcc = value.prefix(3)
                let plmnmnc = value.suffix(2)
                
                if plmnmcc == targetMCC && plmnmnc == itiMNC {
                    valueToReturn = true
                }
            }
        }
        return valueToReturn
    }
    
    func isNRDECstatus() -> Bool {
        var valueToReturn = false
        
        if simData != "-----" {
            let carrierPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.carrier.plist"
            
            // Déclaration du gestionaire de fichiers
            let fileManager = FileManager.default
            
            // Obtenir le fichier de configuration de la carte SIM
            let carrierPListPath = try? fileManager.destinationOfSymbolicLink(atPath: carrierPListSymLinkPath)
            
            let test = NSMutableDictionary(contentsOfFile: carrierPListPath ?? "Error")
            let array = test?["SupportedPLMNs"] as? NSArray ?? NSArray.init(array: [0])
            
            for index in 0..<array.count {
                let value = array[index] as? String ?? "-----"
                let plmnmcc = value.prefix(3)
                let plmnmnc = value.suffix(2)
                
                if plmnmcc == targetMCC && plmnmnc == itiMNC {
                    valueToReturn = true
                }
            }
        }
        return valueToReturn
    }
    
    func resetCountryIncluded(){
        let emptyList = [String]()
        
        datas.set(emptyList, forKey: "includedData")
        datas.set(emptyList, forKey: "includedVData")
        datas.set(emptyList, forKey: "includedVoice")
        datas.synchronize()
    }
    
    func zoneCheck() -> String {
        let country = CarrierIdentification.getIsoCountryCode(connectedMCC).uppercased()
        if country == CarrierIdentification.getIsoCountryCode(targetMCC).uppercased(){
            return "HOME"
        } else if country == "--"{
            return "UNKNOWN"
        } else if country == "DE" || country == "AT" || country == "BE" || country == "BG" || country == "CY" || country == "HR" || country == "DK" || country == "ES" || country == "EE" || country == "FI" || country == "GI" || country == "GR" || country == "HU" || country == "IE" || country == "IS" || country == "IT" || country == "LV" || country == "LI" || country == "LT" || country == "LU" || country == "MT" || country == "NO" || country == "NL" || country == "PL" || country == "PT" || country == "CZ" || country == "RO" || country == "GB" || country == "SK" || country == "SI" || country == "SE" || country == "GP" || country == "GF" || country == "MQ" || country == "YT" || country == "RE" || country == "BL" || country == "MF" {
            return "ALL"
        }
        
        for includedCountry in includedData {
            if country == includedCountry {
                return "INTERNET"
            }
        }
        
        for includedCountry in includedVData {
            if country == includedCountry {
                return "ALL"
            }
        }
        
        for includedCountry in includedVoice {
            if country == includedCountry {
                return "CALLS"
            }
        }
        
        return "OUTZONE"
    }
    
    func freeZoneCheck() -> String{
        let country = CarrierIdentification.getIsoCountryCode(connectedMCC).uppercased()
        if country == "FR"{
            return "HOME"
        } else if country == "--"{
            return "UNKNOWN"
        }
        else if country == "DE" || country == "AT" || country == "BE" || country == "BG" || country == "CY" || country == "HR" || country == "DK" || country == "ES" || country == "EE" || country == "FI" || country == "GI" || country == "GR" || country == "HU" || country == "IE" || country == "IS" || country == "IT" || country == "LV" || country == "LI" || country == "LT" || country == "LU" || country == "MT" || country == "NO" || country == "NL" || country == "PL" || country == "PT" || country == "CZ" || country == "RO" || country == "GB" || country == "SK" || country == "SI" || country == "SE" || country == "GP" || country == "GF" || country == "MQ" || country == "YT" || country == "RE" || country == "BL" || country == "MF" || country == "ZA" || country == "AU" || country == "CA" || country == "US" || country == "IL" || country == "NZ" {
            return "ALL"
        } else if country == "PM" {
            return "CALLS"
        } else if  country == "DZ" || country == "AR" || country == "AM" || country == "BD" || country == "BY" || country == "BR" || country == "GE" || country == "GG" || country == "IM" || country == "IN" || country == "JE" || country == "KZ" || country == "MK" || country == "MY" || country == "MX" || country == "ME" || country == "UZ" || country == "PK" || country == "RU" || country == "RS" || country == "LK" || country == "CH" || country == "TH" || country == "TN" || country == "TR" || country == "UA" {
            return "INTERNET"
        }
        return "OUTZONE"
    }
    
    func addCountryIncluded(country: String, list: Int){
        if list == 0 {
            includedVoice.append(country)
            datas.set(includedVoice, forKey: "includedVoice")
            datas.synchronize()
        } else if list == 1 {
            includedData.append(country)
            datas.set(includedData, forKey: "includedData")
            datas.synchronize()
        } else if list == 2 {
            includedVData.append(country)
            datas.set(includedVData, forKey: "includedVData")
            datas.synchronize()
        }
    }
    
}
