module MyModule::CrossBorderLicense {
    use aptos_framework::signer;
    use aptos_framework::timestamp;

    /// Struct representing a professional license with cross-border recognition
    struct License has store, key {
        license_id: u64,           // Unique license identifier
        profession: u64,           // Professional field code (1=Doctor, 2=Engineer, etc.)
        issuing_country: u64,      // Country code that issued the license
        issue_date: u64,           // Timestamp when license was issued
        expiry_date: u64,          // License expiration timestamp
        is_recognized: bool,       // Cross-border recognition status
        recognition_count: u64,    // Number of countries recognizing this license
    }

    /// Function to register a new professional license
    public fun register_license(
        professional: &signer,
        license_id: u64,
        profession: u64,
        issuing_country: u64,
        expiry_date: u64
    ) {
        let current_time = timestamp::now_seconds();
        
        let license = License {
            license_id,
            profession,
            issuing_country,
            issue_date: current_time,
            expiry_date,
            is_recognized: false,
            recognition_count: 0,
        };
        
        move_to(professional, license);
    }

    /// Function to grant cross-border recognition to a license
    public fun grant_recognition(
        authority: &signer,
        professional_address: address,
        recognizing_country: u64
    ) acquires License {
        let license = borrow_global_mut<License>(professional_address);
        
        // Increment recognition count
        license.recognition_count = license.recognition_count + 1;
        
        // Set recognition status to true
        license.is_recognized = true;
    }
}