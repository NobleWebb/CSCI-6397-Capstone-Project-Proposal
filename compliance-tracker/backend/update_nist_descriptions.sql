-- Update NIST 800-53 Rev 5 Requirement Descriptions from Arkansas Cybersecurity Rubric
-- Covers ALL phases (Phase 1, 2, and 3)
-- Run with: psql -U postgres -d compliance_tracker -f update_nist_descriptions.sql
BEGIN;

-- ===== AC (Phase 1/2) =====
-- ===== AT (Phase 1/2) =====
-- ===== CP (Phase 1/2) =====
-- ===== IA (Phase 1/2) =====
-- ===== IR (Phase 1/2) =====
-- ===== SI (Phase 1/2) =====
-- ===== AU (Phase 1/2) =====
-- ===== CM (Phase 1/2) =====
-- ===== PL (Phase 1/2) =====
-- ===== PT (Phase 1/2) =====
-- ===== SA (Phase 1/2) =====
-- ===== SC (Phase 1/2) =====
-- ===== CA (Phase 3) =====
-- ===== MA (Phase 3) =====
-- ===== MP (Phase 3) =====
-- ===== PE (Phase 3) =====
-- ===== PM (Phase 3) =====
-- ===== PS (Phase 3) =====
-- ===== RA (Phase 3) =====
-- ===== SR (Phase 3) =====
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] access control policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the access control policy and the associated access controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the access control policy and procedures;
c. Review and update the current access control:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'AC-1';
UPDATE controls SET nist_standard = 'a. Define and document the types of accounts allowed and specifically prohibited for use within the system;
b. Assign account managers;
c. Require [Assignment: organization-defined prerequisites and criteria] for group and role membership;
d. Specify:
1. Authorized users of the system;
2. Group and role membership; and
3. Access authorizations (i.e., privileges) and [Assignment: organization-defined attributes (as required)] for each account;
e. Require approvals by [Assignment: organization-defined personnel or roles] for requests to create accounts;
f. Create, enable, modify, disable, and remove accounts in accordance with [Assignment: organization-defined policy, procedures, prerequisites, and criteria];
g. Monitor the use of accounts;
h. Notify account managers and [Assignment: organization-defined personnel or roles] within:
1. [Assignment: organization-defined time period] when accounts are no longer required;
2. [Assignment: organization-defined time period] when users are terminated or transferred; and
3. [Assignment: organization-defined time period] when system usage or need-to-know changes for an individual;
i. Authorize access to the system based on:
1. A valid access authorization;
2. Intended system usage; and
3. [Assignment: organization-defined attributes (as required)];
j. Review accounts for compliance with account management requirements [Assignment: organization-defined frequency];
k. Establish and implement a process for changing shared or group account authenticators (if deployed) when individuals are removed from the group; and
l. Align account management processes with personnel termination and transfer processes.' WHERE control_id = 'AC-2';
UPDATE controls SET nist_standard = 'Support the management of system accounts using [Assignment: organization-defined automated mechanisms].' WHERE control_id = 'AC-2(1)';
UPDATE controls SET nist_standard = 'Automatically [Selection: remove; disable] temporary and emergency accounts after [Assignment: organization-defined time period for each type of account].' WHERE control_id = 'AC-2(2)';
UPDATE controls SET nist_standard = 'Disable accounts within [Assignment: organization-defined time period] when the accounts: 
(a) Have expired;
(b) Are no longer associated with a user or individual;
(c) Are in violation of organizational policy; or
(d) Have been inactive for [Assignment: organization-defined time period].' WHERE control_id = 'AC-2(3)';
UPDATE controls SET nist_standard = 'Automatically audit account creation, modification, enabling, disabling, and removal actions.' WHERE control_id = 'AC-2(4)';
UPDATE controls SET nist_standard = 'Require that users log out when [Assignment: organization-defined time period of expected inactivity or description of when to log out].' WHERE control_id = 'AC-2(5)';
UPDATE controls SET nist_standard = 'Disable accounts of individuals within [Assignment: organization-defined time period] of discovery of [Assignment: organization-defined significant risks].' WHERE control_id = 'AC-2(13)';
UPDATE controls SET nist_standard = 'Enforce approved authorizations for logical access to information and system resources in accordance with applicable access control policies.' WHERE control_id = 'AC-3';
UPDATE controls SET nist_standard = 'Provide [Assignment: organization-defined mechanisms] to enable individuals to have access to the following elements of their personally identifiable information: 
[Assignment: organization-defined elements].' WHERE control_id = 'AC-3(14)';
UPDATE controls SET nist_standard = 'Enforce approved authorizations for controlling the flow of information within the system and between connected systems based on [Assignment: organization-defined 
information flow control policies].' WHERE control_id = 'AC-4';
UPDATE controls SET nist_standard = 'a. Identify and document [Assignment: organization-defined duties of individuals requiring separation]; and
b. Define system access authorizations to support separation of duties.' WHERE control_id = 'AC-5';
UPDATE controls SET nist_standard = 'Employ the principle of least privilege, allowing only authorized accesses for users (or processes acting on behalf of users) that are necessary to accomplish assigned 
organizational tasks.' WHERE control_id = 'AC-6';
UPDATE controls SET nist_standard = 'Authorize access for [Assignment: organization-defined individuals or roles] to:
(a) [Assignment: organization-defined security functions (deployed in hardware, software, and firmware)]; and
(b) [Assignment: organization-defined security-relevant information].' WHERE control_id = 'AC-6(1)';
UPDATE controls SET nist_standard = 'Require that users of system accounts (or roles) with access to [Assignment: organization-defined security functions or security-relevant information] use non-privileged 
accounts or roles, when accessing nonsecurity functions.' WHERE control_id = 'AC-6(2)';
UPDATE controls SET nist_standard = 'Restrict privileged accounts on the system to [Assignment: organization-defined personnel or roles].' WHERE control_id = 'AC-6(5)';
UPDATE controls SET nist_standard = 'Prohibit privileged access to the system by non-organizational users.' WHERE control_id = 'AC-6(6)';
UPDATE controls SET nist_standard = '(a) Review [Assignment: organization-defined frequency] the privileges assigned to [Assignment: organization-defined roles or classes of users] to validate the need for 
such privileges; and
(b) Reassign or remove privileges, if necessary, to correctly reflect organizational mission and business needs.' WHERE control_id = 'AC-6(7)';
UPDATE controls SET nist_standard = 'Log the execution of privileged functions.' WHERE control_id = 'AC-6(9)';
UPDATE controls SET nist_standard = 'Prevent non-privileged users from executing privileged functions.' WHERE control_id = 'AC-6(10)';
UPDATE controls SET nist_standard = 'a. Enforce a limit of [Assignment: organization-defined number] consecutive invalid logon attempts by a user during a [Assignment: organization-defined time period]; 
b. Automatically [Selection (one or more): lock the account or node for an [Assignment: organization-defined time period]; lock the account or node until released by an 
administrator; delay next logon prompt per [Assignment: organization-defined delay algorithm]; notify system administrator; take other [Assignment: 
organization-defined action]] when the maximum number of unsuccessful attempts is exceeded.' WHERE control_id = 'AC-7';
UPDATE controls SET nist_standard = 'a. Display [Assignment: organization-defined system use notification message or banner] to users before granting access to the system that provides privacy and 
security notices consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines and state that:
1. Users are accessing a U.S. Government system;
2. System usage may be monitored, recorded, and subject to audit;
3. Unauthorized use of the system is prohibited and subject to criminal and civil penalties; and
4. Use of the system indicates consent to monitoring and recording;
b. Retain the notification message or banner on the screen until users acknowledge the usage conditions and take explicit actions to log on to or further access the 
system; and c. For publicly accessible systems:
1. Display system use information [Assignment: organization-defined conditions], before granting further access to the publicly accessible system;
2. Display references, if any, to monitoring, recording, or auditing that are consistent with privacy accommodations for such systems that generally prohibit those 
activities; and
3. Include a description of the authorized uses of the system.' WHERE control_id = 'AC-8';
UPDATE controls SET nist_standard = 'a. Prevent further access to the system by [Selection (one or more): initiating a device lock after [Assignment: organization-defined time period] of inactivity; requiring 
the user to initiate a device lock before leaving the system unattended]; and
b. Retain the device lock until the user reestablishes access using established identification and authentication procedures.' WHERE control_id = 'AC-11';
UPDATE controls SET nist_standard = 'Conceal, via the device lock, information previously visible on the display with a publicly viewable image.' WHERE control_id = 'AC-11(1)';
UPDATE controls SET nist_standard = 'Automatically terminate a user session after [Assignment: organization-defined conditions or trigger events requiring session disconnect].' WHERE control_id = 'AC-12';
UPDATE controls SET nist_standard = 'a. Identify [Assignment: organization-defined user actions] that can be performed on the system without identification or authentication consistent with organizational 
mission and business functions; and
b. Document and provide supporting rationale in the security plan for the system, user actions not requiring identification or authentication.' WHERE control_id = 'AC-14';
UPDATE controls SET nist_standard = 'Employ automated mechanisms to monitor and control remote access methods.' WHERE control_id = 'AC-17(1)';
UPDATE controls SET nist_standard = 'Implement cryptographic mechanisms to protect the confidentiality and integrity of remote access sessions.' WHERE control_id = 'AC-177(2)';
UPDATE controls SET nist_standard = 'Route remote accesses through authorized and managed network access control points.' WHERE control_id = 'AC-17(3)';
UPDATE controls SET nist_standard = '(a) Authorize the execution of privileged commands and access to security-relevant information via remote access only in a format that provides assessable 
evidence and for the following needs: [Assignment: organization-defined needs]; and
(b) Document the rationale for remote access in the security plan for the system.' WHERE control_id = 'AC-17(4)';
UPDATE controls SET nist_standard = 'a. Establish configuration requirements, connection requirements, and implementation guidance for each type of wireless access; and
b. Authorize each type of wireless access to the system prior to allowing such connections.' WHERE control_id = 'AC-18';
UPDATE controls SET nist_standard = 'Protect wireless access to the system using authentication of [Selection (one or more): users; devices] and encryption.' WHERE control_id = 'AC-18(1)';
UPDATE controls SET nist_standard = 'Disable, when not intended for use, wireless networking capabilities embedded within system components prior to issuance and deployment.' WHERE control_id = 'AC-18(3)';
UPDATE controls SET nist_standard = 'a. Establish configuration requirements, connection requirements, and implementation guidance for organization-controlled mobile devices, to include when such 
devices are outside of controlled areas; and
b. Authorize the connection of mobile devices to organizational systems.' WHERE control_id = 'AC-19';
UPDATE controls SET nist_standard = 'Employ [Selection: full-device encryption; container-based encryption] to protect the confidentiality and integrity of information on [Assignment: organization-defined 
mobile devices].' WHERE control_id = 'AC-19(5)';
UPDATE controls SET nist_standard = 'a. [Selection (one or more): Establish [Assignment: organization-defined terms and conditions]; Identify [Assignment: organization-defined controls asserted to be 
implemented on external systems]], consistent with the trust relationships established with other organizations owning, operating, and/or maintaining external systems, 
allowing authorized individuals to:
1. Access the system from external systems; and
2. Process, store, or transmit organization-controlled information using external systems; or
b. Prohibit the use of [Assignment: organizationally-defined types of external systems].' WHERE control_id = 'AC-20';
UPDATE controls SET nist_standard = 'Permit authorized individuals to use an external system to access the system or to process, store, or transmit organization-controlled information only after:
(a) Verification of the implementation of controls on the external system as specified in the organization’s security and privacy policies and security and privacy plans; or
(b) Retention of approved system connection or processing agreements with the organizational entity hosting the external system.' WHERE control_id = 'AC-20(1)';
UPDATE controls SET nist_standard = 'Restrict the use of organization-controlled portable storage devices by authorized individuals on external systems using [Assignment: organization-defined restrictions].' WHERE control_id = 'AC-20(2)';
UPDATE controls SET nist_standard = 'a. Enable authorized users to determine whether access authorizations assigned to a sharing partner match the information’s access and use restrictions for 
[Assignment: organization-defined information sharing circumstances where user discretion is required]; and
b. Employ [Assignment: organization-defined automated mechanisms or manual processes] to assist users in making information sharing and collaboration decisions.' WHERE control_id = 'AC-21';
UPDATE controls SET nist_standard = 'a. Designate individuals authorized to make information publicly accessible;
b. Train authorized individuals to ensure that publicly accessible information does not contain nonpublic information;
c. Review the proposed content of information prior to posting onto the publicly accessible system to ensure that nonpublic information is not included; and
d. Review the content on the publicly accessible system for nonpublic information [Assignment: organization-defined frequency] and remove such information, 
if discovered.' WHERE control_id = 'AC-22';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] awareness and training policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the awareness and training policy and the associated awareness and training controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the awareness and training policy and 
procedures; and
c. Review and update the current awareness and training:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'AT-1';
UPDATE controls SET nist_standard = 'a. Provide security and privacy literacy training to system users (including managers, senior executives, and contractors):
1. As part of initial training for new users and [Assignment: organization-defined frequency] thereafter; and
2. When required by system changes or following [Assignment: organization-defined events];
b. Employ the following techniques to increase the security and privacy awareness of system users [Assignment: organization-defined awareness techniques];
c. Update literacy training and awareness content [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
d. Incorporate lessons learned from internal or external security incidents or breaches into literacy training and awareness techniques.' WHERE control_id = 'AT-2';
UPDATE controls SET nist_standard = 'Provide literacy training on recognizing and reporting potential indicators of insider threat.' WHERE control_id = 'AT-2(2)';
UPDATE controls SET nist_standard = 'Provide literacy training on recognizing and reporting potential and actual instances of social engineering and social mining.' WHERE control_id = 'AT-2(3)';
UPDATE controls SET nist_standard = 'a. Provide role-based security and privacy training to personnel with the following roles and responsibilities: [Assignment: organization-defined roles and responsibilities]:
1. Before authorizing access to the system, information, or performing assigned duties, and [Assignment: organization-defined frequency] thereafter; and
2. When required by system changes;
b. Update role-based training content [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
c. Incorporate lessons learned from internal or external security incidents or breaches into role-based training.' WHERE control_id = 'AT-3';
UPDATE controls SET nist_standard = 'Provide [Assignment: organization-defined personnel or roles] with initial and [Assignment: organization-defined frequency] training in the employment and operation of 
personally identifiable information processing and transparency controls.' WHERE control_id = 'AT-3(5)';
UPDATE controls SET nist_standard = 'a. Document and monitor information security and privacy training activities, including security and privacy awareness training and specific role-based security and 
privacy training; and
b. Retain individual training records for [Assignment: organization-defined time period].' WHERE control_id = 'AT-4';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] contingency planning policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the contingency planning policy and the associated contingency planning controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the contingency planning policy and 
procedures; and
c. Review and update the current contingency planning:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'CP-1';
UPDATE controls SET nist_standard = 'a. Develop a contingency plan for the system that:
1. Identifies essential mission and business functions and associated contingency requirements;
2. Provides recovery objectives, restoration priorities, and metrics;
3. Addresses contingency roles, responsibilities, assigned individuals with contact information;
4. Addresses maintaining essential mission and business functions despite a system disruption, compromise, or failure; 
5. Addresses eventual, full system restoration without deterioration of the controls originally planned and implemented;
6. Addresses the sharing of contingency information; and
7. Is reviewed and approved by [Assignment: organization-defined personnel or roles];
b. Distribute copies of the contingency plan to [Assignment: organization-defined key contingency personnel (identified by name and/or by role) and organizational 
elements];
c. Coordinate contingency planning activities with incident handling activities;
d. Review the contingency plan for the system [Assignment: organization-defined frequency];
e. Update the contingency plan to address changes to the organization, system, or environment of operation and problems encountered during contingency plan 
implementation, execution, or testing;
f. Communicate contingency plan changes to [Assignment: organization-defined key contingency personnel (identified by name and/or by role) and organizational 
elements];
g. Incorporate lessons learned from contingency plan testing, training, or actual contingency activities into contingency testing and training; and
h. Protect the contingency plan from unauthorized disclosure and modification.' WHERE control_id = 'CP-2';
UPDATE controls SET nist_standard = 'Coordinate contingency plan development with organizational elements responsible for related plans.' WHERE control_id = 'CP-2(1)';
UPDATE controls SET nist_standard = 'Plan for the resumption of [Selection: all; essential] mission and business functions within [Assignment: organization-defined time period] of contingency plan activation.' WHERE control_id = 'CP-2(3)';
UPDATE controls SET nist_standard = 'Identify critical system assets supporting [Selection: all; essential] mission and business functions.' WHERE control_id = 'CP-2(8)';
UPDATE controls SET nist_standard = 'a. Provide contingency training to system users consistent with assigned roles and responsibilities: 
1. Within [Assignment: organization-defined time period] of assuming a contingency role or responsibility;
2. When required by system changes; and
3. [Assignment: organization-defined frequency] thereafter; and
b. Review and update contingency training content [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'CP-3';
UPDATE controls SET nist_standard = 'a. Test the contingency plan for the system [Assignment: organization-defined frequency] using  the following tests to determine the effectiveness of the plan and the 
readiness to execute the plan: [Assignment: organization-defined tests].
b. Review the contingency plan test results; and
c. Initiate corrective actions, if needed.' WHERE control_id = 'CP-4';
UPDATE controls SET nist_standard = 'Coordinate contingency plan testing with organizational elements responsible for related plans.' WHERE control_id = 'CP-4(1)';
UPDATE controls SET nist_standard = 'a. Establish an alternate storage site, including necessary agreements to permit the storage and retrieval of system backup information; and
b. Ensure that the alternate storage site provides controls equivalent to that of the primary site.' WHERE control_id = 'CP-6';
UPDATE controls SET nist_standard = 'Identify an alternate storage site that is sufficiently separated from the primary storage site to reduce susceptibility to the same threats.' WHERE control_id = 'CP-6(1)';
UPDATE controls SET nist_standard = 'Identify potential accessibility problems to the alternate storage site in the event of an area-wide disruption or disaster and outline explicit mitigation actions.' WHERE control_id = 'CP-6(3)';
UPDATE controls SET nist_standard = 'a. Establish an alternate processing site, including necessary agreements to permit the transfer and resumption of [Assignment: organization-defined system operations] 
for essential mission and business functions within [Assignment: organization-defined time period consistent with recovery time and recovery point objectives] when the 
primary processing capabilities are unavailable;
b. Make available at the alternate processing site, the equipment and supplies required to transfer and resume operations or put contracts in place to support delivery to 
the site within the organization-defined time period for transfer and resumption; and
c. Provide controls at the alternate processing site that are equivalent to those at the primary site.' WHERE control_id = 'CP-7';
UPDATE controls SET nist_standard = 'Identify an alternate processing site that is sufficiently separated from the primary processing site to reduce susceptibility to the same threats.' WHERE control_id = 'CP-7(1)';
UPDATE controls SET nist_standard = 'Identify potential accessibility problems to alternate processing sites in the event of an area-wide disruption or disaster and outlines explicit mitigation actions.' WHERE control_id = 'CP-7(2)';
UPDATE controls SET nist_standard = 'Develop alternate processing site agreements that contain priority-of-service provisions in accordance with availability requirements (including recovery time objectives).' WHERE control_id = 'CP-7(3)';
UPDATE controls SET nist_standard = 'Establish alternate telecommunications services, including necessary agreements to permit the resumption of [Assignment: organization-defined system operations] for 
essential mission and business functions within [Assignment: organization-defined time period] when the primary telecommunications capabilities are unavailable at 
either the primary or alternate processing or storage sites.' WHERE control_id = 'CP-8';
UPDATE controls SET nist_standard = '(a) Develop primary and alternate telecommunications service agreements that contain priority-of-service provisions in accordance with availability requirements 
(including recovery time objectives); and
(b) Request Telecommunications Service Priority for all telecommunications services used for national security emergency preparedness if the primary and/or 
alternate telecommunications services are provided by a common carrier.' WHERE control_id = 'CP-8(1)';
UPDATE controls SET nist_standard = 'Obtain alternate telecommunications services to reduce the likelihood of sharing a single point of failure with primary telecommunications services.' WHERE control_id = 'CP-8(2)';
UPDATE controls SET nist_standard = 'a. Conduct backups of user-level information contained in [Assignment: organization-defined system components] [Assignment: organization-defined frequency 
consistent with recovery time and recovery point objectives];
b. Conduct backups of system-level information contained in the system [Assignment: organization-defined frequency consistent with recovery time and 
recovery point objectives];
c. Conduct backups of system documentation, including security- and privacy-related documentation [Assignment: organization-defined frequency consistent 
with recovery time and recovery point objectives]; and  
d. Protect the confidentiality, integrity, and availability of backup information.' WHERE control_id = 'CP-9';
UPDATE controls SET nist_standard = 'Test backup information [Assignment: organization-defined frequency] to verify media reliability and information integrity.' WHERE control_id = 'CP-9(1)';
UPDATE controls SET nist_standard = 'Implement cryptographic mechanisms to prevent unauthorized disclosure and modification of [Assignment: organization-defined backup information].' WHERE control_id = 'CP-9(8)';
UPDATE controls SET nist_standard = 'Provide for the recovery and reconstitution of the system to a known state within [Assignment: organization-defined time period consistent with recovery time and 
recovery point objectives] after a disruption, compromise, or failure.' WHERE control_id = 'CP-10';
UPDATE controls SET nist_standard = 'Implement transaction recovery for systems that are transaction-based.' WHERE control_id = 'CP-10(2)';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] identification and authentication policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the identification and authentication policy and the associated identification and authentication controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the identification and authentication policy 
and procedures; and
c. Review and update the current identification and authentication:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'IA-1';
UPDATE controls SET nist_standard = 'Uniquely identify and authenticate organizational users and associate that unique identification with processes acting on behalf of those users.' WHERE control_id = 'IA-2';
UPDATE controls SET nist_standard = 'Implement multi-factor authentication for access to privileged accounts.' WHERE control_id = 'IA-2(1)';
UPDATE controls SET nist_standard = 'Implement multi-factor authentication for access to non-privileged accounts.' WHERE control_id = 'IA-2(2)';
UPDATE controls SET nist_standard = 'Implement replay-resistant authentication mechanisms for access to [Selection (one or more): privileged accounts; non-privileged accounts].' WHERE control_id = 'IA-2(8)';
UPDATE controls SET nist_standard = 'Accept and electronically verify Personal Identity Verification-compliant credentials.' WHERE control_id = 'IA-2(12)';
UPDATE controls SET nist_standard = 'Uniquely identify and authenticate [Assignment: organization-defined devices and/or types of devices] before establishing a [Selection (one or more): local; remote; 
network] connection.' WHERE control_id = 'IA-3';
UPDATE controls SET nist_standard = 'Manage system identifiers by:
a. Receiving authorization from [Assignment: organization-defined personnel or roles] to assign an individual, group, role, service, or device identifier;
b. Selecting an identifier that identifies an individual, group, role, service, or device;
c. Assigning the identifier to the intended individual, group, role, service, or device; and
d. Preventing reuse of identifiers for [Assignment: organization-defined time period].' WHERE control_id = 'IA-4';
UPDATE controls SET nist_standard = 'Manage individual identifiers by uniquely identifying each individual as [Assignment: organization-defined characteristic identifying individual status].' WHERE control_id = 'IA-4(4)';
UPDATE controls SET nist_standard = 'Manage system authenticators by:
a. Verifying, as part of the initial authenticator distribution, the identity of the individual, group, role, service, or device receiving the authenticator;
b. Establishing initial authenticator content for any authenticators issued by the organization;
c. Ensuring that authenticators have sufficient strength of mechanism for their intended use;
d. Establishing and implementing administrative procedures for initial authenticator distribution, for lost or compromised or damaged authenticators, and for revoking 
authenticators;
e. Changing default authenticators prior to first use;
f. Changing or refreshing authenticators [Assignment: organization-defined time period by authenticator type] or when [Assignment: organization-defined events] occur;
g. Protecting authenticator content from unauthorized disclosure and modification;
h. Requiring individuals to take, and having devices implement, specific controls to protect authenticators; and
i. Changing authenticators for group or role accounts when membership to those accounts changes.' WHERE control_id = 'IA-5';
UPDATE controls SET nist_standard = 'For password-based authentication:
(a) Maintain a list of commonly-used, expected, or compromised passwords and update the list [Assignment: organization-defined frequency] and when organizational 
passwords are suspected to have been compromised directly or indirectly;
(b) Verify, when users create or update passwords, that the passwords are not found on the list of commonly-used, expected, or compromised passwords in IA-5(1)(a);
(c) Transmit passwords only over cryptographically-protected channels;
(d) Store passwords using an approved salted key derivation function, preferably using a keyed hash;
(e) Require immediate selection of a new password upon account recovery;
(f) Allow user selection of long passwords and passphrases, including spaces and all printable characters;
(g) Employ automated tools to assist the user in selecting strong password authenticators; and
(h) Enforce the following composition and complexity rules: [Assignment: organization-defined composition and complexity rules].' WHERE control_id = 'IA-5(1)';
UPDATE controls SET nist_standard = '(a) For public key-based authentication:
(1) Enforce authorized access to the corresponding private key; and
(2) Map the authenticated identity to the account of the individual or group; and
(b) When public key infrastructure (PKI) is used:
(1) Validate certificates by constructing and verifying a certification path to an accepted trust anchor, including checking certificate status information; and
(2) Implement a local cache of revocation data to support path discovery and validation.' WHERE control_id = 'IA-5(2)';
UPDATE controls SET nist_standard = 'Protect authenticators commensurate with the security category of the information to which use of the authenticator permits access.' WHERE control_id = 'IA-5(6)';
UPDATE controls SET nist_standard = 'Obscure feedback of authentication information during the authentication process to protect the information from possible exploitation and use by unauthorized 
individuals.' WHERE control_id = 'IA-6';
UPDATE controls SET nist_standard = 'Implement mechanisms for authentication to a cryptographic module that meet the requirements of applicable laws, executive orders, directives, policies, regulations, 
standards, and guidelines for such authentication.' WHERE control_id = 'IA-7';
UPDATE controls SET nist_standard = 'Uniquely identify and authenticate non-organizational users or processes acting on behalf of non-organizational users.' WHERE control_id = 'IA-8';
UPDATE controls SET nist_standard = 'Accept and electronically verify Personal Identity Verification-compliant credentials from other federal agencies.' WHERE control_id = 'IA-8(1)';
UPDATE controls SET nist_standard = '(a) Accept only external authenticators that are NIST-compliant; and
(b) Document and maintain a list of accepted external authenticators.' WHERE control_id = 'IA-8(2)';
UPDATE controls SET nist_standard = 'Conform to the following profiles for identity management [Assignment: organization-defined identity management profiles].' WHERE control_id = 'IA-8(4)';
UPDATE controls SET nist_standard = 'Require users to re-authenticate when [Assignment: organization-defined circumstances or situations requiring re-authentication].' WHERE control_id = 'IA-11';
UPDATE controls SET nist_standard = 'a. Identity proof users that require accounts for logical access to systems based on appropriate identity assurance level requirements as specified in applicable 
standards and guidelines; 
b. Resolve user identities to a unique individual; and
c. Collect, validate, and verify identity evidence.' WHERE control_id = 'IA-12';
UPDATE controls SET nist_standard = 'Require evidence of individual identification be presented to the registration authority.' WHERE control_id = 'IA-12(2)';
UPDATE controls SET nist_standard = 'Require that the presented identity evidence be validated and verified through [Assignment: organizational defined methods of validation and verification].' WHERE control_id = 'IA-12(3)';
UPDATE controls SET nist_standard = 'Require that a [Selection: registration code; notice of proofing] be delivered through an out-of-band channel to verify the users address (physical or digital) of record.' WHERE control_id = 'IA-12(5)';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] incident response policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the incident response policy and the associated incident response controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the incident response policy and 
procedures; and
c. Review and update the current incident response:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'IR-1';
UPDATE controls SET nist_standard = 'a. Provide incident response training to system users consistent with assigned roles and responsibilities:
1. Within [Assignment: organization-defined time period] of assuming an incident response role or responsibility or acquiring system access;
2. When required by system changes; and
3. [Assignment: organization-defined frequency] thereafter; and
b. Review and update incident response training content [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'IR-2';
UPDATE controls SET nist_standard = 'Provide incident response training on how to identify and respond to a breach, including the organization’s process for reporting a breach.' WHERE control_id = 'IR-2(3)';
UPDATE controls SET nist_standard = 'Test the effectiveness of the incident response capability for the system [Assignment: organization-defined frequency] using the following tests: [Assignment: 
organization-defined tests].' WHERE control_id = 'IR-3';
UPDATE controls SET nist_standard = 'Coordinate incident response testing with organizational elements responsible for related plans.' WHERE control_id = 'IR-3(2)';
UPDATE controls SET nist_standard = 'a. Implement an incident handling capability for incidents that is consistent with the incident response plan and includes preparation, detection and analysis, containment, 
eradication, and recovery;
b. Coordinate incident handling activities with contingency planning activities;
c. Incorporate lessons learned from ongoing incident handling activities into incident response procedures, training, and testing, and implement the resulting changes 
accordingly; and
d. Ensure the rigor, intensity, scope, and results of incident handling activities are comparable and predictable across the organization.' WHERE control_id = 'IR-4';
UPDATE controls SET nist_standard = 'Support the incident handling process using [Assignment: organization-defined automated mechanisms].' WHERE control_id = 'IR-4(1)';
UPDATE controls SET nist_standard = 'Track and document incidents.' WHERE control_id = 'IR-5';
UPDATE controls SET nist_standard = 'a. Require personnel to report suspected incidents to the organizational incident response capability within [Assignment: organization-defined time period]; and
b. Report incident information to [Assignment: organization-defined authorities].' WHERE control_id = 'IR-6';
UPDATE controls SET nist_standard = 'Report incidents using [Assignment: organization-defined automated mechanisms].' WHERE control_id = 'IR-6(1)';
UPDATE controls SET nist_standard = 'Provide incident information to the provider of the product or service and other organizations involved in the supply chain or supply chain governance for systems or 
system components related to the incident.' WHERE control_id = 'IR-6(3)';
UPDATE controls SET nist_standard = 'Provide an incident response support resource, integral to the organizational incident response capability, that offers advice and assistance to users of the system for 
the handling and reporting of incidents.' WHERE control_id = 'IR-7';
UPDATE controls SET nist_standard = 'Increase the availability of incident response information and support using [Assignment: organization-defined automated mechanisms].' WHERE control_id = 'IR-7(1)';
UPDATE controls SET nist_standard = 'a. Develop an incident response plan that:
1. Provides the organization with a roadmap for implementing its incident response capability;
2. Describes the structure and organization of the incident response capability;
3. Provides a high-level approach for how the incident response capability fits into the overall organization;
4. Meets the unique requirements of the organization, which relate to mission, size, structure, and functions;
5. Defines reportable incidents;
6. Provides metrics for measuring the incident response capability within the organization;
7. Defines the resources and management support needed to effectively maintain and mature an incident response capability;
8. Addresses the sharing of incident information;
9. Is reviewed and approved by [Assignment: organization-defined personnel or roles] [Assignment: organization-defined frequency]; and
10. Explicitly designates responsibility for incident response to [Assignment: organization-defined entities, personnel, or roles].
b. Distribute copies of the incident response plan to [Assignment: organization-defined incident response personnel (identified by name and/or by role) and 
organizational elements];
c. Update the incident response plan to address system and organizational changes or problems encountered during plan implementation, execution, or testing;
d. Communicate incident response plan changes to [Assignment: organization-defined incident response personnel (identified by name and/or by role) and 
organizational elements]; and
e. Protect the incident response plan from unauthorized disclosure and modification.' WHERE control_id = 'IR-8';
UPDATE controls SET nist_standard = 'Include the following in the Incident Response Plan for breaches involving personally identifiable information:
(a) A process to determine if notice to individuals or other organizations, including oversight organizations, is needed;
(b) An assessment process to determine the extent of the harm, embarrassment, inconvenience, or unfairness to affected individuals and any mechanisms to mitigate 
such harms; and
(c) Identification of applicable privacy requirements.' WHERE control_id = 'IR-8(1)';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] system and information integrity policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the system and information integrity policy and the associated system and information integrity controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the system and information integrity policy 
and procedures; and
c. Review and update the current system and information integrity:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'SI-1';
UPDATE controls SET nist_standard = 'a. Identify, report, and correct system flaws;
b. Test software and firmware updates related to flaw remediation for effectiveness and potential side effects before installation;
c. Install security-relevant software and firmware updates within [Assignment: organization-defined time period] of the release of the updates; and
d. Incorporate flaw remediation into the organizational configuration management process.' WHERE control_id = 'SI-2';
UPDATE controls SET nist_standard = 'Determine if system components have applicable security-relevant software and firmware updates installed using [Assignment: organization-defined automated 
mechanisms] [Assignment: organization-defined frequency].' WHERE control_id = 'SI-2(2)';
UPDATE controls SET nist_standard = 'a. Implement [Selection (one or more): signature based; non-signature based] malicious code protection mechanisms at system entry and exit points to detect and 
eradicate malicious code;
b. Automatically update malicious code protection mechanisms as new releases are available in accordance with organizational configuration management policy and 
procedures;
c. Configure malicious code protection mechanisms to:
1. Perform periodic scans of the system [Assignment: organization-defined frequency] and real-time scans of files from external sources at [Selection (one or more): 
endpoint; network entry and exit points] as the files are downloaded, opened, or executed in accordance with organizational policy; and
2. [Selection (one or more): block malicious code; quarantine malicious code; take [Assignment: organization-defined action]]; and send alert to [Assignment: 
organization-defined personnel or roles] in response to malicious code detection; and
d. Address the receipt of false positives during malicious code detection and eradication and the resulting potential impact on the availability of the system.' WHERE control_id = 'SI-3';
UPDATE controls SET nist_standard = 'a. Monitor the system to detect:
1. Attacks and indicators of potential attacks in accordance with the following monitoring objectives: [Assignment: organization-defined monitoring objectives]; and
2. Unauthorized local, network, and remote connections;
b. Identify unauthorized use of the system through the following techniques and methods: [Assignment: organization-defined techniques and methods];
c. Invoke internal monitoring capabilities or deploy monitoring devices:
1. Strategically within the system to collect organization-determined essential information; and
2. At ad hoc locations within the system to track specific types of transactions of interest to the organization;
d. Analyze detected events and anomalies;
e. Adjust the level of system monitoring activity when there is a change in risk to organizational operations and assets, individuals, other organizations, or the Nation;
f. Obtain legal opinion regarding system monitoring activities; and
g. Provide [Assignment: organization-defined system monitoring information] to [Assignment: organization-defined personnel or roles] [Selection (one or more): as 
needed; [Assignment: organization-defined frequency]].' WHERE control_id = 'SI-4';
UPDATE controls SET nist_standard = 'Employ automated tools and mechanisms to support near real-time analysis of events.' WHERE control_id = 'SI-4(2)';
UPDATE controls SET nist_standard = '(a) Determine criteria for unusual or unauthorized activities or conditions for inbound and outbound communications traffic;
(b) Monitor inbound and outbound communications traffic [Assignment: organization-defined frequency] for [Assignment: organization-defined unusual or unauthorized 
activities or conditions].' WHERE control_id = 'SI-4(4)';
UPDATE controls SET nist_standard = 'Alert [Assignment: organization-defined personnel or roles] when the following system-generated indications of compromise or potential compromise occur: 
[Assignment: organization-defined compromise indicators].' WHERE control_id = 'SI-4(5)';
UPDATE controls SET nist_standard = 'a. Receive system security alerts, advisories, and directives from [Assignment: organization-defined external organizations] on an ongoing basis;
b. Generate internal security alerts, advisories, and directives as deemed necessary;
c. Disseminate security alerts, advisories, and directives to: [Selection (one or more): [Assignment: organization-defined personnel or roles]; [Assignment: 
organization-defined elements within the organization]; [Assignment: organization-defined external organizations]]; and
d. Implement security directives in accordance with established time frames, or notify the issuing organization of the degree of noncompliance.' WHERE control_id = 'SI-5';
UPDATE controls SET nist_standard = 'a. Employ integrity verification tools to detect unauthorized changes to the following software, firmware, and information: [Assignment: organization-defined software, 
firmware, and information]; and
b. Take the following actions when unauthorized changes to the software, firmware, and information are detected: [Assignment: organization-defined actions].' WHERE control_id = 'SI-7';
UPDATE controls SET nist_standard = 'Perform an integrity check of [Assignment: organization-defined software, firmware, and information] [Selection (one or more): at startup; at [Assignment: 
organization-defined transitional states or security-relevant events]; [Assignment: organization-defined frequency]].' WHERE control_id = 'SI-7(1)';
UPDATE controls SET nist_standard = 'Incorporate the detection of the following unauthorized changes into the organizational incident response capability: [Assignment: organization-defined security-relevant 
changes to the system].' WHERE control_id = 'SI-7(7)';
UPDATE controls SET nist_standard = 'a. Employ spam protection mechanisms at system entry and exit points to detect and act on unsolicited messages; and
b. Update spam protection mechanisms when new releases are available in accordance with organizational configuration management policy and procedures.' WHERE control_id = 'SI-8';
UPDATE controls SET nist_standard = 'Automatically update spam protection mechanisms [Assignment: organization-defined frequency].' WHERE control_id = 'SI-8(2)';
UPDATE controls SET nist_standard = 'Check the validity of the following information inputs: [Assignment: organization-defined information inputs to the system].' WHERE control_id = 'SI-10';
UPDATE controls SET nist_standard = 'a. Generate error messages that provide information necessary for corrective actions without revealing information that could be exploited; and
b. Reveal error messages only to [Assignment: organization-defined personnel or roles].' WHERE control_id = 'SI-11';
UPDATE controls SET nist_standard = 'Manage and retain information within the system and information output from the system in accordance with applicable laws, executive orders, directives, regulations, 
policies, standards, guidelines and operational requirements.' WHERE control_id = 'SI-12';
UPDATE controls SET nist_standard = 'Limit personally identifiable information being processed in the information life cycle to the following elements of personally identifiable information: [Assignment: 
organization-defined elements of personally identifiable information].' WHERE control_id = 'SI-12(1)';
UPDATE controls SET nist_standard = 'Use the following techniques to minimize the use of personally identifiable information for research, testing, or training: [Assignment: organization-defined techniques].' WHERE control_id = 'SI-12(2)';
UPDATE controls SET nist_standard = 'Use the following techniques to dispose of, destroy, or erase information following the retention period: [Assignment: organization-defined techniques].' WHERE control_id = 'SI-12(3)';
UPDATE controls SET nist_standard = 'Implement the following controls to protect the system memory from unauthorized code execution: [Assignment: organization-defined controls].' WHERE control_id = 'SI-16';
UPDATE controls SET nist_standard = 'a. Check the accuracy, relevance, timeliness, and completeness of personally identifiable information across the information life cycle [Assignment: organization-defined 
frequency]; and
b. Correct or delete inaccurate or outdated personally identifiable information.' WHERE control_id = 'SI-18';
UPDATE controls SET nist_standard = 'Correct or delete personally identifiable information upon request by individuals or their designated representatives.' WHERE control_id = 'SI-18(4)';
UPDATE controls SET nist_standard = 'a. Remove the following elements of personally identifiable information from datasets: [Assignment: organization-defined elements of personally identifiable information];
b. Evaluate [Assignment: organization-defined frequency] for effectiveness of de-identification.' WHERE control_id = 'SI-19';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] audit and accountability policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the audit and accountability policy and the associated audit and accountability controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the audit and accountability policy and 
procedures; and
c. Review and update the current audit and accountability:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'AU-1';
UPDATE controls SET nist_standard = 'a. Identify the types of events that the system is capable of logging in support of the audit function: [Assignment: organization-defined event types that the system is 
capable of logging];
b. Coordinate the event logging function with other organizational entities requiring audit-related information to guide and inform the selection criteria for events to be 
logged;
c. Specify the following event types for logging within the system: [Assignment: organization-defined event types (subset of the event types defined in AU-2a.) along 
with the frequency of (or situation requiring) logging for each identified event type];
d. Provide a rationale for why the event types selected for logging are deemed to be adequate to support after-the-fact investigations of incidents; and
e. Review and update the event types selected for logging [Assignment: organization-defined frequency].' WHERE control_id = 'AU-2';
UPDATE controls SET nist_standard = 'Ensure that audit records contain information that establishes the following:
a. What type of event occurred;
b. When the event occurred;
c. Where the event occurred;
d. Source of the event;
e. Outcome of the event; and 
f. Identity of any individuals, subjects, or objects/entities associated with the event.' WHERE control_id = 'AU-3';
UPDATE controls SET nist_standard = 'Generate audit records containing the following additional information: [Assignment: organization-defined additional information].' WHERE control_id = 'AU-3(1)';
UPDATE controls SET nist_standard = 'Allocate audit log storage capacity to accommodate [Assignment: organization-defined audit log retention requirements].' WHERE control_id = 'AU-4';
UPDATE controls SET nist_standard = 'a. Alert [Assignment: organization-defined personnel or roles] within [Assignment: organization-defined time period] in the event of an audit logging process failure; and
b. Take the following additional actions: [Assignment: organization-defined additional actions].' WHERE control_id = 'AU-5';
UPDATE controls SET nist_standard = 'a. Review and analyze system audit records [Assignment: organization-defined frequency] for indications of [Assignment: organization-defined inappropriate or unusual 
activity] and the potential impact of the inappropriate or unusual activity;
b. Report findings to [Assignment: organization-defined personnel or roles]; and
c. Adjust the level of audit record review, analysis, and reporting within the system when there is a change in risk based on law enforcement information, intelligence 
+information, or other credible sources of information.' WHERE control_id = 'AU-6';
UPDATE controls SET nist_standard = 'Integrate audit record review, analysis, and reporting processes using [Assignment: organization-defined automated mechanisms].' WHERE control_id = 'AU-6(1)';
UPDATE controls SET nist_standard = 'Analyze and correlate audit records across different repositories to gain organization-wide situational awareness.' WHERE control_id = 'AU-6(3)';
UPDATE controls SET nist_standard = 'Provide and implement an audit record reduction and report generation capability that:
a. Supports on-demand audit record review, analysis, and reporting requirements and after-the-fact investigations of incidents; and
b. Does not alter the original content or time ordering of audit records.' WHERE control_id = 'AU-7';
UPDATE controls SET nist_standard = 'Provide and implement the capability to process, sort, and search audit records for events of interest based on the following content: [Assignment: organization-defined 
fields within audit records].' WHERE control_id = 'AU-7(1)';
UPDATE controls SET nist_standard = 'a. Use internal system clocks to generate time stamps for audit records; and
b. Record time stamps for audit records that meet [Assignment: organization-defined granularity of time measurement] and that use Coordinated Universal Time, have a 
fixed local time offset from Coordinated Universal Time, or that include the local time offset as part of the time stamp.' WHERE control_id = 'AU-8';
UPDATE controls SET nist_standard = 'a. Protect audit information and audit logging tools from unauthorized access, modification, and deletion; and
b. Alert [Assignment: organization-defined personnel or roles] upon detection of unauthorized access, modification, or deletion of audit information.' WHERE control_id = 'AU-9';
UPDATE controls SET nist_standard = 'Authorize access to management of audit logging functionality to only [Assignment: organization-defined subset of privileged users or roles].' WHERE control_id = 'AU-9(4)';
UPDATE controls SET nist_standard = 'Retain audit records for [Assignment: organization-defined time period consistent with records retention policy] to provide support for after-the-fact investigations of 
incidents and to meet regulatory and organizational information retention requirements.' WHERE control_id = 'AU-11';
UPDATE controls SET nist_standard = 'a. Provide audit record generation capability for the event types the system is capable of auditing as defined in AU-2a on [Assignment: organization-defined system 
components];
b. Allow [Assignment: organization-defined personnel or roles] to select the event types that are to be logged by specific components of the system; and
c. Generate audit records for the event types defined in AU-2c that include the audit record content defined in AU-3.' WHERE control_id = 'AU-12';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] configuration management policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the configuration management policy and the associated configuration management controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the configuration management policy and 
procedures; and
c. Review and update the current configuration management:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'CM-1';
UPDATE controls SET nist_standard = 'a. Develop, document, and maintain under configuration control, a current baseline configuration of the system; and
b. Review and update the baseline configuration of the system:
1. [Assignment: organization-defined frequency];
2. When required due to [Assignment: organization-defined circumstances]; and
3. When system components are installed or upgraded.' WHERE control_id = 'CM-2';
UPDATE controls SET nist_standard = 'Maintain the currency, completeness, accuracy, and availability of the baseline configuration of the system using [Assignment: organization-defined automated 
mechanisms].' WHERE control_id = 'CM-2(2)';
UPDATE controls SET nist_standard = 'Retain [Assignment: organization-defined number] of previous versions of baseline configurations of the system to support rollback.' WHERE control_id = 'CM-2(3)';
UPDATE controls SET nist_standard = '(a) Issue [Assignment: organization-defined systems or system components] with [Assignment: organization-defined configurations] to individuals traveling to locations 
that the organization deems to be of significant risk; and
(b) Apply the following controls to the systems or components when the individuals return from travel: [Assignment: organization-defined controls].' WHERE control_id = 'CM-2(7)';
UPDATE controls SET nist_standard = 'a. Determine and document the types of changes to the system that are configuration-controlled;
b. Review proposed configuration-controlled changes to the system and approve or disapprove such changes with explicit consideration for security and privacy impact 
analyses;
c. Document configuration change decisions associated with the system;
d. Implement approved configuration-controlled changes to the system;
e. Retain records of configuration-controlled changes to the system for [Assignment: organization-defined time period];
f. Monitor and review activities associated with configuration-controlled changes to the system; and
g. Coordinate and provide oversight for configuration change control activities through [Assignment: organization-defined configuration change control element] that 
convenes [Selection (one or more): [Assignment: organization-defined frequency]; when [Assignment: organization-defined configuration change conditions]].' WHERE control_id = 'CM-3';
UPDATE controls SET nist_standard = 'Test, validate, and document changes to the system before finalizing the implementation of the changes.' WHERE control_id = 'CM-3(2)';
UPDATE controls SET nist_standard = 'Require [Assignment: organization-defined security and privacy representatives] to be members of the [Assignment: organization-defined configuration change control 
element].' WHERE control_id = 'CM-3(4)';
UPDATE controls SET nist_standard = 'Analyze changes to the system to determine potential security and privacy impacts prior to change implementation.' WHERE control_id = 'CM-4';
UPDATE controls SET nist_standard = 'After system changes, verify that the impacted controls are implemented correctly, operating as intended, and producing the desired outcome with regard to meeting the 
security and privacy requirements for the system.' WHERE control_id = 'CM-4(2)';
UPDATE controls SET nist_standard = 'Define, document, approve, and enforce physical and logical access restrictions associated with changes to the system.' WHERE control_id = 'CM-5';
UPDATE controls SET nist_standard = 'a. Establish and document configuration settings for components employed within the system that reflect the most restrictive mode consistent with operational 
requirements using [Assignment: organization-defined common secure configurations];
b. Implement the configuration settings;
c. Identify, document, and approve any deviations from established configuration settings for [Assignment: organization-defined system components] based on 
[Assignment: organization-defined operational requirements]; and
d. Monitor and control changes to the configuration settings in accordance with organizational policies and procedures.' WHERE control_id = 'CM-6';
UPDATE controls SET nist_standard = 'a. Configure the system to provide only [Assignment: organization-defined mission essential capabilities]; and
b. Prohibit or restrict the use of the following functions, ports, protocols, software, and/or services: [Assignment: organization-defined prohibited or restricted functions, 
system ports, protocols, software, and/or services].' WHERE control_id = 'CM-7';
UPDATE controls SET nist_standard = '(a) Review the system [Assignment: organization-defined frequency] to identify unnecessary and/or nonsecure functions, ports, protocols, software, and services; and
(b) Disable or remove [Assignment: organization-defined functions, ports, protocols, software, and services within the system deemed to be unnecessary and/or 
nonsecure].' WHERE control_id = 'CM-7(1)';
UPDATE controls SET nist_standard = 'Prevent program execution in accordance with [Selection (one or more): [Assignment: organization-defined policies, rules of behavior, and/or access agreements 
regarding software program usage and restrictions]; rules authorizing the terms and conditions of software program usage].' WHERE control_id = 'CM-7(2)';
UPDATE controls SET nist_standard = '(a) Identify [Assignment: organization-defined software programs authorized to execute on the system];
(b) Employ a deny-all, permit-by-exception policy to allow the execution of authorized software programs on the system; and
(c) Review and update the list of authorized software programs [Assignment: organization-defined frequency].' WHERE control_id = 'CM-7(5)';
UPDATE controls SET nist_standard = 'a. Develop and document an inventory of system components that:
1. Accurately reflects the system;
2. Includes all components within the system;
3. Does not include duplicate accounting of components or components assigned to any other system;
4. Is at the level of granularity deemed necessary for tracking and reporting; and
5. Includes the following information to achieve system component accountability: [Assignment: organization-defined information deemed necessary to achieve effective 
system component accountability]; and
b. Review and update the system component inventory [Assignment: organization-defined frequency].' WHERE control_id = 'CM-8';
UPDATE controls SET nist_standard = 'Update the inventory of system components as part of component installations, removals, and system updates.' WHERE control_id = 'CM-8(1)';
UPDATE controls SET nist_standard = '(a) Detect the presence of unauthorized hardware, software, and firmware components within the system using [Assignment: organization-defined automated 
mechanisms] [Assignment: organization-defined frequency]; and
(b) Take the following actions when unauthorized components are detected: [Selection (one or more): disable network access by such components; isolate the 
components; notify [Assignment: organization-defined personnel or roles]].' WHERE control_id = 'CM-8(3)';
UPDATE controls SET nist_standard = 'Develop, document, and implement a configuration management plan for the system that:
a. Addresses roles, responsibilities, and configuration management processes and procedures;
b. Establishes a process for identifying configuration items throughout the system development life cycle and for managing the configuration of the configuration items;
c. Defines the configuration items for the system and places the configuration items under configuration management;
d. Is reviewed and approved by [Assignment: organization-defined personnel or roles]; and
e. Protects the configuration management plan from unauthorized disclosure and modification.' WHERE control_id = 'CM-9';
UPDATE controls SET nist_standard = 'a. Use software and associated documentation in accordance with contract agreements and copyright laws;
b. Track the use of software and associated documentation protected by quantity licenses to control copying and distribution; and
c. Control and document the use of peer-to-peer file sharing technology to ensure that this capability is not used for the unauthorized distribution, display, performance, 
or reproduction of copyrighted work.' WHERE control_id = 'CM-10';
UPDATE controls SET nist_standard = 'a. Establish [Assignment: organization-defined policies] governing the installation of software by users;
b. Enforce software installation policies through the following methods: [Assignment: organization-defined methods]; and
c. Monitor policy compliance [Assignment: organization-defined frequency].' WHERE control_id = 'CM-11';
UPDATE controls SET nist_standard = 'a. Identify and document the location of [Assignment: organization-defined information] and the specific system components on which the information is processed and 
stored;
b. Identify and document the users who have access to the system and system components where the information is processed and stored; and
c. Document changes to the location (i.e., system or system components) where the information is processed and stored.' WHERE control_id = 'CM-12';
UPDATE controls SET nist_standard = 'Use automated tools to identify [Assignment: organization-defined information by information type] on [Assignment: organization-defined system components] to ensure 
controls are in place to protect organizational information and individual privacy.' WHERE control_id = 'CM-12(1)';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] planning policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the planning policy and the associated planning controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the planning policy and procedures; and
c. Review and update the current planning:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'PL-1';
UPDATE controls SET nist_standard = 'a. Develop security and privacy plans for the system that:
1. Are consistent with the organization’s enterprise architecture;
2. Explicitly define the constituent system components;
3. Describe the operational context of the system in terms of mission and business processes;
4. Identify the individuals that fulfill system roles and responsibilities;
5. Identify the information types processed, stored, and transmitted by the system;
6. Provide the security categorization of the system, including supporting rationale;
7. Describe any specific threats to the system that are of concern to the organization; 
8. Provide the results of a privacy risk assessment for systems processing personally identifiable information;
9. Describe the operational environment for the system and any dependencies on or connections to other systems or system components;
10. Provide an overview of the security and privacy requirements for the system;
11. Identify any relevant control baselines or overlays, if applicable;
12. Describe the controls in place or planned for meeting the security and privacy requirements, including a rationale for any tailoring decisions;
13. Include risk determinations for security and privacy architecture and design decisions;
14. Include security- and privacy-related activities affecting the system that require planning and coordination with [Assignment: organization-defined individuals or 
groups]; and
15. Are reviewed and approved by the authorizing official or designated representative prior to plan implementation.
b. Distribute copies of the plans and communicate subsequent changes to the plans to [Assignment: organization-defined personnel or roles];
c. Review the plans [Assignment: organization-defined frequency]; 
d. Update the plans to address changes to the system and environment of operation or problems identified during plan implementation or control assessments; and
e. Protect the plans from unauthorized disclosure and modification.' WHERE control_id = 'PL-2';
UPDATE controls SET nist_standard = 'a. Establish and provide to individuals requiring access to the system, the rules that describe their responsibilities and expected behavior for information and system 
usage, security, and privacy;
b. Receive a documented acknowledgment from such individuals, indicating that they have read, understand, and agree to abide by the rules of behavior, before 
authorizing access to information and the system;
c. Review and update the rules of behavior [Assignment: organization-defined frequency]; and
d. Require individuals who have acknowledged a previous version of the rules of behavior to read and re-acknowledge [Selection (one or more): [Assignment: 
organization-defined frequency]; when the rules are revised or updated].' WHERE control_id = 'PL-4';
UPDATE controls SET nist_standard = 'Include in the rules of behavior, restrictions on:
(a) Use of social media, social networking sites, and external sites/applications;
(b) Posting organizational information on public websites; and
(c) Use of organization-provided identifiers (e.g., email addresses) and authentication secrets (e.g., passwords) for creating accounts on external sites/applications.' WHERE control_id = 'PL-4(1)';
UPDATE controls SET nist_standard = 'a. Develop security and privacy architectures for the system that:
1. Describe the requirements and approach to be taken for protecting the confidentiality, integrity, and availability of organizational information;
2. Describe the requirements and approach to be taken for processing personally identifiable information to minimize privacy risk to individuals;
3. Describe how the architectures are integrated into and support the enterprise architecture; and
4. Describe any assumptions about, and dependencies on, external systems and services;
b. Review and update the architectures [Assignment: organization-defined frequency] to reflect changes in the enterprise architecture; and
c. Reflect planned architecture changes in security and privacy plans, Concept of Operations (CONOPS), criticality analysis, organizational procedures, and 
procurements and acquisitions.' WHERE control_id = 'PL-8';
UPDATE controls SET nist_standard = 'Centrally manage [Assignment: organization-defined controls and related processes].' WHERE control_id = 'PL-9';
UPDATE controls SET nist_standard = 'Select a control baseline for the system.' WHERE control_id = 'PL-10';
UPDATE controls SET nist_standard = 'Tailor the selected control baseline by applying specified tailoring actions.' WHERE control_id = 'PL-11';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] personally identifiable information processing and transparency policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the personally identifiable information processing and transparency policy and the associated personally identifiable 
information processing and transparency controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the personally identifiable information 
processing and transparency policy and procedures; and
c. Review and update the current personally identifiable information processing and transparency:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'PT-1';
UPDATE controls SET nist_standard = 'a. Determine and document the [Assignment: organization-defined authority] that permits the [Assignment: organization-defined processing] of personally identifiable 
information; and
b. Restrict the [Assignment: organization-defined processing] of personally identifiable information to only that which is authorized.' WHERE control_id = 'PT-2';
UPDATE controls SET nist_standard = 'a. Identify and document the [Assignment: organization-defined purpose(s)] for processing personally identifiable information;
b. Describe the purpose(s) in the public privacy notices and policies of the organization; 
c. Restrict the [Assignment: organization-defined processing] of personally identifiable information to only that which is compatible with the identified purpose(s); and 
d. Monitor changes in processing personally identifiable information and implement [Assignment: organization-defined mechanisms] to ensure that any changes are 
made in accordance with [Assignment: organization-defined requirements].' WHERE control_id = 'PT-3';
UPDATE controls SET nist_standard = 'Implement [Assignment: organization-defined tools or mechanisms] for individuals to consent to the processing of their personally identifiable information prior to its 
collection that facilitate individuals’ informed decision-making.' WHERE control_id = 'PT-4';
UPDATE controls SET nist_standard = 'Provide notice to individuals about the processing of personally identifiable information that:
a. Is available to individuals upon first interacting with an organization, and subsequently at [Assignment: organization-defined frequency];
b. Is clear and easy-to-understand, expressing information about personally identifiable information processing in plain language;
c. Identifies the authority that authorizes the processing of personally identifiable information;
d. Identifies the purposes for which personally identifiable information is to be processed; and
e. Includes [Assignment: organization-defined information].' WHERE control_id = 'PT-5';
UPDATE controls SET nist_standard = 'Include Privacy Act statements on forms that collect information that will be maintained in a Privacy Act system of records, or provide Privacy Act statements on separate 
forms that can be retained by individuals.' WHERE control_id = 'PT-5(2)';
UPDATE controls SET nist_standard = 'For systems that process information that will be maintained in a Privacy Act system of records:
a. Draft system of records notices in accordance with OMB guidance and submit new and significantly modified system of records notices to the OMB and appropriate 
congressional committees for advance review;
b. Publish system of records notices in the Federal Register; and
c. Keep system of records notices accurate, up-to-date, and scoped in accordance with policy.' WHERE control_id = 'PT-6';
UPDATE controls SET nist_standard = 'Review all routine uses published in the system of records notice at [Assignment: organization-defined frequency] to ensure continued accuracy, and to ensure that 
routine uses continue to be compatible with the purpose for which the information was collected.' WHERE control_id = 'PT-6(1)';
UPDATE controls SET nist_standard = 'Review all Privacy Act exemptions claimed for the system of records at [Assignment: organization-defined frequency] to ensure they remain appropriate and necessary 
in accordance with law, that they have been promulgated as regulations, and that they are accurately described in the system of records notice.' WHERE control_id = 'PT-6(2)';
UPDATE controls SET nist_standard = 'Apply [Assignment: organization-defined processing conditions] for specific categories of personally identifiable information.' WHERE control_id = 'PT-7';
UPDATE controls SET nist_standard = 'When a system processes Social Security numbers:
(a) Eliminate unnecessary collection, maintenance, and use of Social Security numbers, and explore alternatives to their use as a personal identifier;
(b) Do not deny any individual any right, benefit, or privilege provided by law because of such individual’s refusal to disclose his or her Social Security number; and
(c) Inform any individual who is asked to disclose his or her Social Security number whether that disclosure is mandatory or voluntary, by what statutory or other authority 
such number is solicited, and what uses will be made of it.' WHERE control_id = 'PT-7(1)';
UPDATE controls SET nist_standard = 'Prohibit the processing of information describing how any individual exercises rights guaranteed by the First Amendment unless expressly authorized by statute or by 
the individual or unless pertinent to and within the scope of an authorized law enforcement activity.' WHERE control_id = 'PT-7(2)';
UPDATE controls SET nist_standard = 'When a system or organization processes information for the purpose of conducting a matching program:
a. Obtain approval from the Data Integrity Board to conduct the matching program;
b. Develop and enter into a computer matching agreement;
c. Publish a matching notice in the Federal Register;
d. Independently verify the information produced by the matching program before taking adverse action against an individual, if required; and
e. Provide individuals with notice and an opportunity to contest the findings before taking adverse action against an individual.' WHERE control_id = 'PT-8';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] system and services acquisition policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the system and services acquisition policy and the associated system and services acquisition controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the system and services acquisition policy 
and procedures; and
c. Review and update the current system and services acquisition:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'SA-1';
UPDATE controls SET nist_standard = 'a. Determine the high-level information security and privacy requirements for the system or system service in mission and business process planning;
b. Determine, document, and allocate the resources required to protect the system or system service as part of the organizational capital planning and investment 
control process; and
c. Establish a discrete line item for information security and privacy in organizational programming and budgeting documentation.' WHERE control_id = 'SA-2';
UPDATE controls SET nist_standard = 'a. Acquire, develop, and manage the system using [Assignment: organization-defined system development life cycle] that incorporates information security and privacy 
considerations;
b. Define and document information security and privacy roles and responsibilities throughout the system development life cycle;
c. Identify individuals having information security and privacy roles and responsibilities; and
d. Integrate the organizational information security and privacy risk management process into system development life cycle activities.' WHERE control_id = 'SA-3';
UPDATE controls SET nist_standard = 'Include the following requirements, descriptions, and criteria, explicitly or by reference, using [Selection (one or more): standardized contract language; [Assignment: 
organization-defined contract language]] in the acquisition contract for the system, system component, or system service:
a. Security and privacy functional requirements;
b. Strength of mechanism requirements;
c. Security and privacy assurance requirements;
d. Controls needed to satisfy the security and privacy requirements.
e. Security and privacy documentation requirements;
f. Requirements for protecting security and privacy documentation;
g. Description of the system development environment and environment in which the system is intended to operate;
h. Allocation of responsibility or identification of parties responsible for information security, privacy, and supply chain risk management; and
i. Acceptance criteria.' WHERE control_id = 'SA-4';
UPDATE controls SET nist_standard = 'Require the developer of the system, system component, or system service to provide a description of the functional properties of the controls to be implemented.' WHERE control_id = 'SA-4(1)';
UPDATE controls SET nist_standard = 'Require the developer of the system, system component, or system service to provide design and implementation information for the controls that includes: [Selection 
(one or more): security-relevant external system interfaces; high-level design; low-level design; source code or hardware schematics; [Assignment: 
organization-defined design and implementation information]] at [Assignment: organization-defined level of detail].' WHERE control_id = 'SA-4(2)';
UPDATE controls SET nist_standard = 'Require the developer of the system, system component, or system service to identify the functions, ports, protocols, and services intended for organizational use.' WHERE control_id = 'SA-4(9)';
UPDATE controls SET nist_standard = 'Employ only information technology products on the FIPS 201-approved products list for Personal Identity Verification (PIV) capability implemented within organizational 
systems.' WHERE control_id = 'SA-4(10)';
UPDATE controls SET nist_standard = 'a. Obtain or develop administrator documentation for the system, system component, or system service that describes:
1. Secure configuration, installation, and operation of the system, component, or service; 
2. Effective use and maintenance of security and privacy functions and mechanisms; and
3. Known vulnerabilities regarding configuration and use of administrative or privileged functions;
b. Obtain or develop user documentation for the system, system component, or system service that describes:
1. User-accessible security and privacy functions and mechanisms and how to effectively use those functions and mechanisms;
2. Methods for user interaction, which enables individuals to use the system, component, or service in a more secure manner and protect individual privacy; and
3. User responsibilities in maintaining the security of the system, component, or service and privacy of individuals;
c. Document attempts to obtain system, system component, or system service documentation when such documentation is either unavailable or nonexistent and take 
[Assignment: organization-defined actions] in response; and
d. Distribute documentation to [Assignment: organization-defined personnel or roles].' WHERE control_id = 'SA-5';
UPDATE controls SET nist_standard = 'Apply the following systems security and privacy engineering principles in the specification, design, development, implementation, and modification of the system and 
system components: [Assignment: organization-defined systems security and privacy engineering principles].' WHERE control_id = 'SA-8';
UPDATE controls SET nist_standard = 'Implement the privacy principle of minimization using [Assignment: organization-defined processes].' WHERE control_id = 'SA-8(33)';
UPDATE controls SET nist_standard = 'a. Require that providers of external system services comply with organizational security and privacy requirements and employ the following controls: [Assignment: 
organization-defined controls];
b. Define and document organizational oversight and user roles and responsibilities with regard to external system services; and
c. Employ the following processes, methods, and techniques to monitor control compliance by external service providers on an ongoing basis: [Assignment: 
organization-defined processes, methods, and techniques].' WHERE control_id = 'SA-9';
UPDATE controls SET nist_standard = 'Require providers of the following external system services to identify the functions, ports, protocols, and other services required for the use of such services: 
[Assignment: organization-defined external system services].' WHERE control_id = 'SA-9(2)';
UPDATE controls SET nist_standard = 'Require the developer of the system, system component, or system service to:
a. Perform configuration management during system, component, or service [Selection (one or more): design; development; implementation; operation; disposal];
b. Document, manage, and control the integrity of changes to [Assignment: organization-defined configuration items under configuration management];
c. Implement only organization-approved changes to the system, component, or service;
d. Document approved changes to the system, component, or service and the potential security and privacy impacts of such changes; and
e. Track security flaws and flaw resolution within the system, component, or service and report findings to [Assignment: organization-defined personnel].' WHERE control_id = 'SA-10';
UPDATE controls SET nist_standard = 'Require the developer of the system, system component, or system service, at all post-design stages of the system development life cycle, to:
a. Develop and implement a plan for ongoing security and privacy control assessments;
b. Perform [Selection (one or more): unit; integration; system; regression] testing/evaluation [Assignment: organization-defined frequency] at [Assignment: 
organization-defined depth and coverage];
c. Produce evidence of the execution of the assessment plan and the results of the testing and evaluation;
d. Implement a verifiable flaw remediation process; and
e. Correct flaws identified during testing and evaluation.' WHERE control_id = 'SA-11';
UPDATE controls SET nist_standard = 'a. Require the developer of the system, system component, or system service to follow a documented development process that:
1. Explicitly addresses security and privacy requirements;
2. Identifies the standards and tools used in the development process;
3. Documents the specific tool options and tool configurations used in the development process; and
4. Documents, manages, and ensures the integrity of changes to the process and/or tools used in development; and
b. Review the development process, standards, tools, tool options, and tool configurations [Assignment: organization-defined frequency] to determine if the process, 
standards, tools, tool options and tool configurations selected and employed can satisfy the following security and privacy requirements: [Assignment: 
organization-defined security and privacy requirements].' WHERE control_id = 'SA-15';
UPDATE controls SET nist_standard = 'Require the developer of the system, system component, or system service to perform a criticality analysis:
(a) At the following decision points in the system development life cycle: [Assignment: organization-defined decision points in the system development life cycle]; and
(b) At the following level of rigor: [Assignment: organization-defined breadth and depth of criticality analysis].' WHERE control_id = 'SA-15(3)';
UPDATE controls SET nist_standard = 'a. Replace system components when support for the components is no longer available from the developer, vendor, or manufacturer; or
b. Provide the following options for alternative sources for continued support for unsupported components [Selection (one or more): in-house support; [Assignment: 
organization-defined support from external providers]].' WHERE control_id = 'SA-22';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] system and communications protection policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the system and communications protection policy and the associated system and communications protection controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the system and communications protection 
policy and procedures; and
c. Review and update the current system and communications protection:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'SC-1';
UPDATE controls SET nist_standard = 'Separate user functionality, including user interface services, from system management functionality.' WHERE control_id = 'SC-2';
UPDATE controls SET nist_standard = 'Prevent unauthorized and unintended information transfer via shared system resources.' WHERE control_id = 'SC-4';
UPDATE controls SET nist_standard = 'a. [Selection: Protect against; Limit] the effects of the following types of denial-of-service events: [Assignment: organization-defined types of denial-of-service events]; 
and
b. Employ the following controls to achieve the denial-of-service objective: [Assignment: organization-defined controls by type of denial-of-service event].' WHERE control_id = 'SC-5';
UPDATE controls SET nist_standard = 'a. Monitor and control communications at the external managed interfaces to the system and at key internal managed interfaces within the system;
b. Implement subnetworks for publicly accessible system components that are [Selection: physically; logically] separated from internal organizational networks; and
c. Connect to external networks or systems only through managed interfaces consisting of boundary protection devices arranged in accordance with an organizational 
security and privacy architecture.' WHERE control_id = 'SC-7';
UPDATE controls SET nist_standard = 'Limit the number of external network connections to the system.' WHERE control_id = 'SC-7(3)';
UPDATE controls SET nist_standard = '(a) Implement a managed interface for each external telecommunication service;
(b) Establish a traffic flow policy for each managed interface;
(c) Protect the confidentiality and integrity of the information being transmitted across each interface;
(d) Document each exception to the traffic flow policy with a supporting mission or business need and duration of that need;
(e) Review exceptions to the traffic flow policy [Assignment: organization-defined frequency] and remove exceptions that are no longer supported by an explicit mission 
or business need;
(f) Prevent unauthorized exchange of control plane traffic with external networks;
(g) Publish information to enable remote networks to detect unauthorized control plane traffic from internal networks; and
(h) Filter unauthorized control plane traffic from external networks.' WHERE control_id = 'SC-7(4)';
UPDATE controls SET nist_standard = 'Deny network communications traffic by default and allow network communications traffic by exception [Selection (one or more): at managed interfaces; for 
[Assignment: organization-defined systems]].' WHERE control_id = 'SC-7(5)';
UPDATE controls SET nist_standard = 'Prevent split tunneling for remote devices connecting to organizational systems unless the split tunnel is securely provisioned using [Assignment: organization-defined 
safeguards].' WHERE control_id = 'SC-7(7)';
UPDATE controls SET nist_standard = 'Route [Assignment: organization-defined internal communications traffic] to [Assignment: organization-defined external networks] through authenticated proxy servers 
at managed interfaces.' WHERE control_id = 'SC-7(8)';
UPDATE controls SET nist_standard = 'For systems that process personally identifiable information:
(a) Apply the following processing rules to data elements of personally identifiable information: [Assignment: organization-defined processing rules];
(b) Monitor for permitted processing at the external interfaces to the system and at key internal boundaries within the system;
(c) Document each processing exception; and
(d) Review and remove exceptions that are no longer supported.' WHERE control_id = 'SC-7(24)';
UPDATE controls SET nist_standard = 'Protect the [Selection (one or more): confidentiality; integrity] of transmitted information.' WHERE control_id = 'SC-8';
UPDATE controls SET nist_standard = 'Implement cryptographic mechanisms to [Selection (one or more): prevent unauthorized disclosure of information; detect changes to information] during transmission.' WHERE control_id = 'SC-8(1)';
UPDATE controls SET nist_standard = 'Terminate the network connection associated with a communications session at the end of the session or after [Assignment: organization-defined time period] of 
inactivity.' WHERE control_id = 'SC-10';
UPDATE controls SET nist_standard = 'Establish and manage cryptographic keys when cryptography is employed within the system in accordance with the following key management requirements: 
[Assignment: organization-defined requirements for key generation, distribution, storage, access, and destruction].' WHERE control_id = 'SC-12';
UPDATE controls SET nist_standard = 'a. Determine the [Assignment: organization-defined cryptographic uses]; and
b. Implement the following types of cryptography required for each specified cryptographic use: [Assignment: organization-defined types of cryptography for each 
specified cryptographic use].' WHERE control_id = 'SC-13';
UPDATE controls SET nist_standard = 'a. Prohibit remote activation of collaborative computing devices and applications with the following exceptions: [Assignment: organization-defined exceptions where 
remote activation is to be allowed]; and
b. Provide an explicit indication of use to users physically present at the devices.' WHERE control_id = 'SC-15';
UPDATE controls SET nist_standard = 'a. Issue public key certificates under an [Assignment: organization-defined certificate policy] or obtain public key certificates from an approved service provider; and
b. Include only approved trust anchors in trust stores or certificate stores managed by the organization.' WHERE control_id = 'SC-17';
UPDATE controls SET nist_standard = 'a. Define acceptable and unacceptable mobile code and mobile code technologies; and
b. Authorize, monitor, and control the use of mobile code within the system.' WHERE control_id = 'SC-18';
UPDATE controls SET nist_standard = 'a. Provide additional data origin authentication and integrity verification artifacts along with the authoritative name resolution data the system returns in response to 
external name/address resolution queries; and
b. Provide the means to indicate the security status of child zones and (if the child supports secure resolution services) to enable verification of a chain of trust 
among parent and child domains, when operating as part of a distributed, hierarchical namespace.' WHERE control_id = 'SC-20';
UPDATE controls SET nist_standard = 'Request and perform data origin authentication and data integrity verification on the name/address resolution responses the system receives from authoritative sources.' WHERE control_id = 'SC-21';
UPDATE controls SET nist_standard = 'Ensure the systems that collectively provide name/address resolution service for an organization are fault-tolerant and implement internal and external role separation.' WHERE control_id = 'SC-22';
UPDATE controls SET nist_standard = 'Protect the authenticity of communications sessions.' WHERE control_id = 'SC-23';
UPDATE controls SET nist_standard = 'Protect the [Selection (one or more): confidentiality; integrity] of the following information at rest: [Assignment: organization-defined information at rest].' WHERE control_id = 'SC-28';
UPDATE controls SET nist_standard = 'Implement cryptographic mechanisms to prevent unauthorized disclosure and modification of the following information at rest on [Assignment: organization-defined 
system components or media]: [Assignment: organization-defined information].' WHERE control_id = 'SC-28(1)';
UPDATE controls SET nist_standard = 'Maintain a separate execution domain for each executing system process.' WHERE control_id = 'SC-39';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] assessment, authorization, and monitoring policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the assessment, authorization, and monitoring policy and the associated assessment, authorization, and monitoring 
controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the assessment, authorization, and 
monitoring policy and procedures; and
c. Review and update the current assessment, authorization, and monitoring:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'CA-1';
UPDATE controls SET nist_standard = 'a. Select the appropriate assessor or assessment team for the type of assessment to be conducted;
b. Develop a control assessment plan that describes the scope of the assessment including:
1. Controls and control enhancements under assessment;
2. Assessment procedures to be used to determine control effectiveness; and
3. Assessment environment, assessment team, and assessment roles and responsibilities;
c. Ensure the control assessment plan is reviewed and approved by the authorizing official or designated representative prior to conducting the assessment;
d. Assess the controls in the system and its environment of operation [Assignment: organization-defined frequency] to determine the extent to which the controls are 
implemented correctly, operating as intended, and producing the desired outcome with respect to meeting established security and privacy requirements;
e. Produce a control assessment report that document the results of the assessment; and
f. Provide the results of the control assessment to [Assignment: organization-defined individuals or roles].' WHERE control_id = 'CA-2';
UPDATE controls SET nist_standard = 'Employ independent assessors or assessment teams to conduct control assessments.' WHERE control_id = 'CA-2(1)';
UPDATE controls SET nist_standard = 'a. Approve and manage the exchange of information between the system and other systems using [Selection (one or more): interconnection security agreements; 
information exchange security agreements; memoranda of understanding or agreement; service level agreements; user agreements; nondisclosure agreements; 
[Assignment: organization-defined type of agreement]];
b. Document, as part of each exchange agreement, the interface characteristics, security and privacy requirements, controls, and responsibilities for each system, 
and the impact level of the information communicated; and
c. Review and update the agreements [Assignment: organization-defined frequency].' WHERE control_id = 'CA-3';
UPDATE controls SET nist_standard = 'a. Develop a plan of action and milestones for the system to document the planned remediation actions of the organization to correct weaknesses or deficiencies noted 
during the assessment of the controls and to reduce or eliminate known vulnerabilities in the system; and
b. Update existing plan of action and milestones [Assignment: organization-defined frequency] based on the findings from control assessments, independent audits or 
reviews, and continuous monitoring activities.' WHERE control_id = 'CA-5';
UPDATE controls SET nist_standard = 'a. Assign a senior official as the authorizing official for the system;
b. Assign a senior official as the authorizing official for common controls available for inheritance by organizational systems;
c. Ensure that the authorizing official for the system, before commencing operations:
1. Accepts the use of common controls inherited by the system; and
2. Authorizes the system to operate;
d. Ensure that the authorizing official for common controls authorizes the use of those controls for inheritance by organizational systems;
e. Update the authorizations [Assignment: organization-defined frequency].' WHERE control_id = 'CA-6';
UPDATE controls SET nist_standard = 'Develop a system-level continuous monitoring strategy and implement continuous monitoring in accordance with the organization-level continuous monitoring strategy 
that includes:
a. Establishing the following system-level metrics to be monitored: [Assignment: organization-defined system-level metrics];
b. Establishing [Assignment: organization-defined frequencies] for monitoring and [Assignment: organization-defined frequencies] for assessment of control 
effectiveness;
c. Ongoing control assessments in accordance with the continuous monitoring strategy;
d. Ongoing monitoring of system and organization-defined metrics in accordance with the continuous monitoring strategy;
e. Correlation and analysis of information generated by control assessments and monitoring;
f. Response actions to address results of the analysis of control assessment and monitoring information; and
g. Reporting the security and privacy status of the system to [Assignment: organization-defined personnel or roles] [Assignment: organization-defined frequency].' WHERE control_id = 'CA-7';
UPDATE controls SET nist_standard = 'Employ independent assessors or assessment teams to monitor the controls in the system on an ongoing basis.' WHERE control_id = 'CA-7(1)';
UPDATE controls SET nist_standard = 'Employ trend analyses to determine if control implementations, the frequency of continuous monitoring activities, and the types of activities used in the continuous 
monitoring process need to be modified based on empirical data.' WHERE control_id = 'CA-7(3)';
UPDATE controls SET nist_standard = 'Ensure risk monitoring is an integral part of the continuous monitoring strategy that includes the following:
(a) Effectiveness monitoring;
(b) Compliance monitoring; and
(c) Change monitoring.' WHERE control_id = 'CA-7(4)';
UPDATE controls SET nist_standard = 'a. Authorize internal connections of [Assignment: organization-defined system components or classes of components] to the system;
b. Document, for each internal connection, the interface characteristics, security and privacy requirements, and the nature of the information communicated;
c. Terminate internal system connections after [Assignment: organization-defined conditions]; and
d. Review [Assignment: organization-defined frequency] the continued need for each internal connection.' WHERE control_id = 'CA-9';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] maintenance policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the maintenance policy and the associated maintenance controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the maintenance policy and procedures;
c. Review and update the current maintenance:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'MA-1';
UPDATE controls SET nist_standard = 'a. Schedule, document, and review records of maintenance, repair, and replacement on system components in accordance with manufacturer or vendor specifications 
and/or organizational requirements;
b. Approve and monitor all maintenance activities, whether performed on site or remotely and whether the system or system components are serviced on site or 
removed to another location;
c. Require that [Assignment: organization-defined personnel or roles] explicitly approve the removal of the system or system components from organizational facilities 
for off-site maintenance, repair, or replacement;
d. Sanitize equipment to remove the following information from associated media prior to removal from organizational facilities for off-site maintenance, repair, or 
replacement: [Assignment: organization-defined information];
e. Check all potentially impacted controls to verify that the controls are still functioning properly following maintenance, repair, or replacement actions; and
f. Include the following information in organizational maintenance records: [Assignment: organization-defined information].' WHERE control_id = 'MA-2';
UPDATE controls SET nist_standard = 'a. Approve, control, and monitor the use of system maintenance tools; and
b. Review previously approved system maintenance tools [Assignment: organization-defined frequency].' WHERE control_id = 'MA-3';
UPDATE controls SET nist_standard = 'Inspect the maintenance tools used by maintenance personnel for improper or unauthorized modifications.' WHERE control_id = 'MA-3(1)';
UPDATE controls SET nist_standard = 'Check media containing diagnostic and test programs for malicious code before the media are used in the system.' WHERE control_id = 'MA-3(2)';
UPDATE controls SET nist_standard = 'Prevent the removal of maintenance equipment containing organizational information by:
(a) Verifying that there is no organizational information contained on the equipment;
(b) Sanitizing or destroying the equipment;
(c) Retaining the equipment within the facility; or
(d) Obtaining an exemption from [Assignment: organization-defined personnel or roles] explicitly authorizing removal of the equipment from the facility.' WHERE control_id = 'MA-3(3)';
UPDATE controls SET nist_standard = 'a. Approve and monitor nonlocal maintenance and diagnostic activities;
b. Allow the use of nonlocal maintenance and diagnostic tools only as consistent with organizational policy and documented in the security plan for the system;
c. Employ strong authentication in the establishment of nonlocal maintenance and diagnostic sessions;
d. Maintain records for nonlocal maintenance and diagnostic activities; and
e. Terminate session and network connections when nonlocal maintenance is completed.' WHERE control_id = 'MA-4';
UPDATE controls SET nist_standard = 'a. Establish a process for maintenance personnel authorization and maintain a list of authorized maintenance organizations or personnel;
b. Verify that non-escorted personnel performing maintenance on the system possess the required access authorizations; and
c. Designate organizational personnel with required access authorizations and technical competence to supervise the maintenance activities of personnel who do not 
possess the required access authorizations.' WHERE control_id = 'MA-5';
UPDATE controls SET nist_standard = 'Obtain maintenance support and/or spare parts for [Assignment: organization-defined system components] within [Assignment: organization-defined time period] of 
failure.' WHERE control_id = 'MA-6';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] media protection policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the media protection policy and the associated media protection controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the media protection policy and 
procedures; and
c. Review and update the current media protection:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'MP-1';
UPDATE controls SET nist_standard = 'Restrict access to [Assignment: organization-defined types of digital and/or non-digital media] to [Assignment: organization-defined personnel or roles].' WHERE control_id = 'MP-2';
UPDATE controls SET nist_standard = 'a. Mark system media indicating the distribution limitations, handling caveats, and applicable security markings (if any) of the information; and
b. Exempt [Assignment: organization-defined types of system media] from marking if the media remain within [Assignment: organization-defined controlled areas].' WHERE control_id = 'MP-3';
UPDATE controls SET nist_standard = 'a. Physically control and securely store [Assignment: organization-defined types of digital and/or non-digital media] within [Assignment: organization-defined controlled 
areas]; and
b. Protect system media types defined in MP-4a until the media are destroyed or sanitized using approved equipment, techniques, and procedures.' WHERE control_id = 'MP-4';
UPDATE controls SET nist_standard = 'a. Protect and control [Assignment: organization-defined types of system media] during transport outside of controlled areas using [Assignment: organization-defined 
controls];
b. Maintain accountability for system media during transport outside of controlled areas;
c. Document activities associated with the transport of system media; and
d. Restrict the activities associated with the transport of system media to authorized personnel.' WHERE control_id = 'MP-5';
UPDATE controls SET nist_standard = 'a. Sanitize [Assignment: organization-defined system media] prior to disposal, release out of organizational control, or release for reuse using [Assignment: 
organization-defined sanitization techniques and procedures]; and
b. Employ sanitization mechanisms with the strength and integrity commensurate with the security category or classification of the information.' WHERE control_id = 'MP-6';
UPDATE controls SET nist_standard = 'a. [Selection: Restrict; Prohibit] the use of [Assignment: organization-defined types of system media] on [Assignment: organization-defined systems or system 
components] using [Assignment: organization-defined controls]; and
b. Prohibit the use of portable storage devices in organizational systems when such devices have no identifiable owner.' WHERE control_id = 'MP-7';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] physical and environmental protection policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the physical and environmental protection policy and the associated physical and environmental protection controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the physical and environmental protection 
policy and procedures; and
c. Review and update the current physical and environmental protection:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'PE-1';
UPDATE controls SET nist_standard = 'a. Develop, approve, and maintain a list of individuals with authorized access to the facility where the system resides;
b. Issue authorization credentials for facility access;
c. Review the access list detailing authorized facility access by individuals [Assignment: organization-defined frequency]; and
d. Remove individuals from the facility access list when access is no longer required.' WHERE control_id = 'PE-2';
UPDATE controls SET nist_standard = 'a. Enforce physical access authorizations at [Assignment: organization-defined entry and exit points to the facility where the system resides] by:
1. Verifying individual access authorizations before granting access to the facility; and
2. Controlling ingress and egress to the facility using [Selection (one or more): [Assignment: organization-defined physical access control systems or devices]; guards];
b. Maintain physical access audit logs for [Assignment: organization-defined entry or exit points];
c. Control access to areas within the facility designated as publicly accessible by implementing the following controls: [Assignment: organization-defined physical access 
controls];
d. Escort visitors and control visitor activity [Assignment: organization-defined circumstances requiring visitor escorts and control of visitor activity];
e. Secure keys, combinations, and other physical access devices;
f. Inventory [Assignment: organization-defined physical access devices] every [Assignment: organization-defined frequency]; and
g. Change combinations and keys [Assignment: organization-defined frequency] and/or when keys are lost, combinations are compromised, or when individuals 
possessing the keys or combinations are transferred or terminated.' WHERE control_id = 'PE-3';
UPDATE controls SET nist_standard = 'Control physical access to [Assignment: organization-defined system distribution and transmission lines] within organizational facilities using [Assignment: 
organization-defined security controls].' WHERE control_id = 'PE-4';
UPDATE controls SET nist_standard = 'Control physical access to output from [Assignment: organization-defined output devices] to prevent unauthorized individuals from obtaining the output.' WHERE control_id = 'PE-5';
UPDATE controls SET nist_standard = 'a. Monitor physical access to the facility where the system resides to detect and respond to physical security incidents;
b. Review physical access logs [Assignment: organization-defined frequency] and upon occurrence of [Assignment: organization-defined events or potential indications 
of events]; and
c. Coordinate results of reviews and investigations with the organizational incident response capability.' WHERE control_id = 'PE-6';
UPDATE controls SET nist_standard = 'Monitor physical access to the facility where the system resides using physical intrusion alarms and surveillance equipment.' WHERE control_id = 'PE-6(1)';
UPDATE controls SET nist_standard = 'a. Maintain visitor access records to the facility where the system resides for [Assignment: organization-defined time period];
b. Review visitor access records [Assignment: organization-defined frequency]; and
c. Report anomalies in visitor access records to [Assignment: organization-defined personnel].' WHERE control_id = 'PE-8';
UPDATE controls SET nist_standard = 'Limit personally identifiable information contained in visitor access records to the following elements identified in the privacy risk assessment: [Assignment: 
organization-defined elements].' WHERE control_id = 'PE-8(3)';
UPDATE controls SET nist_standard = 'Protect power equipment and power cabling for the system from damage and destruction.' WHERE control_id = 'PE-9';
UPDATE controls SET nist_standard = 'a. Provide the capability of shutting off power to [Assignment: organization-defined system or individual system components] in emergency situations;
b. Place emergency shutoff switches or devices in [Assignment: organization-defined location by system or system component] to facilitate access for authorized 
personnel; and
c. Protect emergency power shutoff capability from unauthorized activation.' WHERE control_id = 'PE-10';
UPDATE controls SET nist_standard = 'Provide an uninterruptible power supply to facilitate [Selection (one or more): an orderly shutdown of the system; transition of the system to long-term alternate power] 
in the event of a primary power source loss.' WHERE control_id = 'PE-11';
UPDATE controls SET nist_standard = 'Employ and maintain automatic emergency lighting for the system that activates in the event of a power outage or disruption and that covers emergency exits and 
evacuation routes within the facility.' WHERE control_id = 'PE-12';
UPDATE controls SET nist_standard = 'Employ and maintain fire detection and suppression systems that are supported by an independent energy source.' WHERE control_id = 'PE-13';
UPDATE controls SET nist_standard = 'Employ fire detection systems that activate automatically and notify [Assignment: organization-defined personnel or roles] and [Assignment: organization-defined 
emergency responders] in the event of a fire.' WHERE control_id = 'PE-13(1)';
UPDATE controls SET nist_standard = 'a. Maintain [Selection (one or more): temperature; humidity; pressure; radiation; [Assignment: organization-defined environmental control]] levels within the facility 
where the system resides at [Assignment: organization-defined acceptable levels]; and
b. Monitor environmental control levels [Assignment: organization-defined frequency].' WHERE control_id = 'PE-14';
UPDATE controls SET nist_standard = 'Protect the system from damage resulting from water leakage by providing master shutoff or isolation valves that are accessible, working properly, and known to key 
personnel.' WHERE control_id = 'PE-15';
UPDATE controls SET nist_standard = 'a. Authorize and control [Assignment: organization-defined types of system components] entering and exiting the facility; and
b. Maintain records of the system components.' WHERE control_id = 'PE-16';
UPDATE controls SET nist_standard = 'a. Determine and document the [Assignment: organization-defined alternate work sites] allowed for use by employees;
b. Employ the following controls at alternate work sites: [Assignment: organization-defined controls];
c. Assess the effectiveness of controls at alternate work sites; and
d. Provide a means for employees to communicate with information security and privacy personnel in case of incidents.' WHERE control_id = 'PE-17';
UPDATE controls SET nist_standard = 'a. Include the resources needed to implement the information security and privacy programs in capital planning and investment requests and document all exceptions 
to this requirement;
b. Prepare documentation required for addressing information security and privacy programs in capital planning and investment requests in accordance with applicable 
laws, executive orders, directives, policies, regulations, standards; and
c. Make available for expenditure, the planned information security and privacy resources.' WHERE control_id = 'PM-3';
UPDATE controls SET nist_standard = 'a. Implement a process to ensure that plans of action and milestones for the information security, privacy, and supply chain risk management programs and associated 
organizational systems:
1. Are developed and maintained;
2. Document the remedial information security, privacy, and supply chain risk management actions to adequately respond to risk to organizational operations and 
assets, individuals, other organizations, and the Nation; and
3. Are reported in accordance with established reporting requirements.
b. Review plans of action and milestones for consistency with the organizational risk management strategy and organization-wide priorities for risk response actions.' WHERE control_id = 'PM-4';
UPDATE controls SET nist_standard = 'Establish, maintain, and update [Assignment: organization-defined frequency] an inventory of all systems, applications, and projects that process personally identifiable 
information.' WHERE control_id = 'PM-5(1)';
UPDATE controls SET nist_standard = 'Develop, monitor, and report on the results of information security and privacy measures of performance.' WHERE control_id = 'PM-6';
UPDATE controls SET nist_standard = 'Develop and maintain an enterprise architecture with consideration for information security, privacy, and the resulting risk to organizational operations and assets, 
individuals, other organizations, and the Nation.' WHERE control_id = 'PM-7';
UPDATE controls SET nist_standard = 'Address information security and privacy issues in the development, documentation, and updating of a critical infrastructure and key resources protection plan.' WHERE control_id = 'PM-8';
UPDATE controls SET nist_standard = 'a. Develops a comprehensive strategy to manage:
1. Security risk to organizational operations and assets, individuals, other organizations, and the Nation associated with the operation and use of organizational systems;
2. Privacy risk to individuals resulting from the authorized processing of personally identifiable information;
b. Implement the risk management strategy consistently across the organization; and
c. Review and update the risk management strategy [Assignment: organization-defined frequency] or as required, to address organizational changes.' WHERE control_id = 'PM-9';
UPDATE controls SET nist_standard = 'a. Manage the security and privacy state of organizational systems and the environments in which those systems operate through authorization processes;
b. Designate individuals to fulfill specific roles and responsibilities within the organizational risk management process; and
c. Integrate the authorization processes into an organization-wide risk management program.' WHERE control_id = 'PM-10';
UPDATE controls SET nist_standard = 'a. Define organizational mission and business processes with consideration for information security and privacy and the resulting risk to organizational operations, 
organizational assets, individuals, other organizations, and the Nation; and
b. Determine information protection and personally identifiable information processing needs arising from the defined mission and business processes; and
c. Review and revise the mission and business processes [Assignment: organization-defined frequency].' WHERE control_id = 'PM-11';
UPDATE controls SET nist_standard = 'Establish a security and privacy workforce development and improvement program.' WHERE control_id = 'PM-13';
UPDATE controls SET nist_standard = 'a. Implement a process for ensuring that organizational plans for conducting security and privacy testing, training, and monitoring activities associated with 
organizational systems:
1. Are developed and maintained; and
2. Continue to be executed; and
b. Review testing, training, and monitoring plans for consistency with the organizational risk management strategy and organization-wide priorities for risk response 
actions.' WHERE control_id = 'PM-14';
UPDATE controls SET nist_standard = 'a. Establish policy and procedures to ensure that requirements for the protection of controlled unclassified information that is processed, stored or transmitted on 
external systems, are implemented in accordance with applicable laws, executive orders, directives, policies, regulations, and standards; and
b. Review and update the policy and procedures [Assignment: organization-defined frequency].' WHERE control_id = 'PM-17';
UPDATE controls SET nist_standard = 'a. Develop and disseminate an organization-wide privacy program plan that provides an overview of the agency’s privacy program, and:
1. Includes a description of the structure of the privacy program and the resources dedicated to the privacy program;
2. Provides an overview of the requirements for the privacy program and a description of the privacy program management controls and common controls in place or 
planned for meeting those requirements;
3. Includes the role of the senior agency official for privacy and the identification and assignment of roles of other privacy officials and staff and their responsibilities;
4. Describes management commitment, compliance, and the strategic goals and objectives of the privacy program;
5. Reflects coordination among organizational entities responsible for the different aspects of privacy; and
6. Is approved by a senior official with responsibility and accountability for the privacy risk being incurred to organizational operations (including mission, functions, 
image, and reputation), organizational assets, individuals, other organizations, and the Nation; and 
b. Update the plan [Assignment: organization-defined frequency] and to address changes in federal privacy laws and policy and organizational changes and 
problems identified during plan implementation or privacy control assessments.' WHERE control_id = 'PM-18';
UPDATE controls SET nist_standard = 'Appoint a senior agency official for privacy with the authority, mission, accountability, and resources to coordinate, develop, and implement, applicable privacy 
requirements and manage privacy risks through the organization-wide privacy program.' WHERE control_id = 'PM-19';
UPDATE controls SET nist_standard = 'Maintain a central resource webpage on the organization’s principal public website that serves as a central source of information about the organization’s privacy 
program and that:
a. Ensures that the public has access to information about organizational privacy activities and can communicate with its senior agency official for privacy;
b. Ensures that organizational privacy practices and reports are publicly available; and
c. Employs publicly facing email addresses and/or phone lines to enable the public to provide feedback and/or direct questions to privacy offices regarding 
privacy practices.' WHERE control_id = 'PM-20';
UPDATE controls SET nist_standard = 'Develop and post privacy policies on all external-facing websites, mobile applications, and other digital services, that:
(a) Are written in plain language and organized in a way that is easy to understand and navigate;
(b) Provide information needed by the public to make an informed decision about whether and how to interact with the organization; and
(c) Are updated whenever the organization makes a substantive change to the practices it describes and includes a time/date stamp to inform the public of the date 
of the most recent changes.' WHERE control_id = 'PM-20(1)';
UPDATE controls SET nist_standard = 'a. Develop and maintain an accurate accounting of disclosures of personally identifiable information, including:
1. Date, nature, and purpose of each disclosure; and
2. Name and address, or other contact information of the individual or organization to which the disclosure was made;
b. Retain the accounting of disclosures for the length of the time the personally identifiable information is maintained or five years after the disclosure is made, 
whichever is longer; and
c. Make the accounting of disclosures available to the individual to whom the personally identifiable information relates upon request.' WHERE control_id = 'PM-21';
UPDATE controls SET nist_standard = 'Develop and document organization-wide policies and procedures for:
a. Reviewing for the accuracy, relevance, timeliness, and completeness of personally identifiable information across the information life cycle; 
b. Correcting or deleting inaccurate or outdated personally identifiable information;
c. Disseminating notice of corrected or deleted personally identifiable information to individuals or other appropriate entities; and
d. Appeals of adverse decisions on correction or deletion requests.' WHERE control_id = 'PM-22';
UPDATE controls SET nist_standard = 'Establish a Data Integrity Board to:
a. Review proposals to conduct or participate in a matching program; and
b. Conduct an annual review of all matching programs in which the agency has participated.' WHERE control_id = 'PM-24';
UPDATE controls SET nist_standard = 'a. Develop, document, and implement policies and procedures that address the use of personally identifiable information for internal testing, training, and research;
b. Limit or minimize the amount of personally identifiable information used for internal testing, training, and research purposes;
c. Authorize the use of personally identifiable information when such information is required for internal testing, training, and research; and
d. Review and update policies and procedures [Assignment: organization-defined frequency].' WHERE control_id = 'PM-25';
UPDATE controls SET nist_standard = 'Implement a process for receiving and responding to complaints, concerns, or questions from individuals about the organizational security and privacy practices that 
includes:
a. Mechanisms that are easy to use and readily accessible by the public;
b. All information necessary for successfully filing complaints;
c. Tracking mechanisms to ensure all complaints received are reviewed and addressed within [Assignment: organization-defined time period];
d. Acknowledgement of receipt of complaints, concerns, or questions from individuals within [Assignment: organization-defined time period]; and
e. Response to complaints, concerns, or questions from individuals within [Assignment: organization-defined time period].' WHERE control_id = 'PM-26';
UPDATE controls SET nist_standard = 'a. Develop [Assignment: organization-defined privacy reports] and disseminate to:
1. [Assignment: organization-defined oversight bodies] to demonstrate accountability with statutory, regulatory, and policy privacy mandates; and
2. [Assignment: organization-defined officials] and other personnel with responsibility for monitoring privacy program compliance; and
b. Review and update privacy reports [Assignment: organization-defined frequency].' WHERE control_id = 'PM-27';
UPDATE controls SET nist_standard = 'a. Identify and document:
1. Assumptions affecting risk assessments, risk responses, and risk monitoring;
2. Constraints affecting risk assessments, risk responses, and risk monitoring;
3. Priorities and trade-offs considered by the organization for managing risk; and
4. Organizational risk tolerance;
b. Distribute the results of risk framing activities to [Assignment: organization-defined personnel]; and
c. Review and update risk framing considerations [Assignment: organization-defined frequency].' WHERE control_id = 'PM-28';
UPDATE controls SET nist_standard = 'Develop an organization-wide continuous monitoring strategy and implement continuous monitoring programs that include:
a. Establishing the following organization-wide metrics to be monitored: [Assignment: organization-defined metrics];
b. Establishing [Assignment: organization-defined frequencies] for monitoring and [Assignment: organization-defined frequencies] for assessment of control 
effectiveness;
c. Ongoing monitoring of organizationally-defined metrics in accordance with the continuous monitoring strategy;
d. Correlation and analysis of information generated by control assessments and monitoring;
e. Response actions to address results of the analysis of control assessment and monitoring information; and
f. Reporting the security and privacy status of organizational systems to [Assignment: organization-defined personnel or roles] [Assignment: 
organization-defined frequency].' WHERE control_id = 'PM-31';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] personnel security policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the personnel security policy and the associated personnel security controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the personnel security policy and 
procedures; and
c. Review and update the current personnel security:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'PS-1';
UPDATE controls SET nist_standard = 'a. Assign a risk designation to all organizational positions;
b. Establish screening criteria for individuals filling those positions; and
c. Review and update position risk designations [Assignment: organization-defined frequency].' WHERE control_id = 'PS-2';
UPDATE controls SET nist_standard = 'a. Screen individuals prior to authorizing access to the system; and
b. Rescreen individuals in accordance with [Assignment: organization-defined conditions requiring rescreening and, where rescreening is so indicated, the frequency of 
rescreening].' WHERE control_id = 'PS-3';
UPDATE controls SET nist_standard = 'Upon termination of individual employment:
a. Disable system access within [Assignment: organization-defined time period];
b. Terminate or revoke any authenticators and credentials associated with the individual;
c. Conduct exit interviews that include a discussion of [Assignment: organization-defined information security topics];
d. Retrieve all security-related organizational system-related property; and
e. Retain access to organizational information and systems formerly controlled by terminated individual.' WHERE control_id = 'PS-4';
UPDATE controls SET nist_standard = 'a. Review and confirm ongoing operational need for current logical and physical access authorizations to systems and facilities when individuals are reassigned or 
transferred to other positions within the organization;
b. Initiate [Assignment: organization-defined transfer or reassignment actions] within [Assignment: organization-defined time period following the formal transfer action];
c. Modify access authorization as needed to correspond with any changes in operational need due to reassignment or transfer; and
d. Notify [Assignment: organization-defined personnel or roles] within [Assignment: organization-defined time period].' WHERE control_id = 'PS-5';
UPDATE controls SET nist_standard = 'a. Develop and document access agreements for organizational systems;
b. Review and update the access agreements [Assignment: organization-defined frequency]; and
c. Verify that individuals requiring access to organizational information and systems: 
1. Sign appropriate access agreements prior to being granted access; and
2. Re-sign access agreements to maintain access to organizational systems when access agreements have been updated or [Assignment: organization-defined 
frequency].' WHERE control_id = 'PS-6';
UPDATE controls SET nist_standard = 'a. Establish personnel security requirements, including security roles and responsibilities for external providers;
b. Require external providers to comply with personnel security policies and procedures established by the organization;
c. Document personnel security requirements;
d. Require external providers to notify [Assignment: organization-defined personnel or roles] of any personnel transfers or terminations of external personnel who 
possess organizational credentials and/or badges, or who have system privileges within [Assignment: organization-defined time period]; and
e. Monitor provider compliance with personnel security requirements.' WHERE control_id = 'PS-7';
UPDATE controls SET nist_standard = 'a. Employ a formal sanctions process for individuals failing to comply with established information security and privacy policies and procedures; and
b. Notify [Assignment: organization-defined personnel or roles] within [Assignment: organization-defined time period] when a formal employee sanctions process is 
initiated, identifying the individual sanctioned and the reason for the sanction.' WHERE control_id = 'PS-8';
UPDATE controls SET nist_standard = 'Incorporate security and privacy roles and responsibilities into organizational position descriptions.' WHERE control_id = 'PS-9';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] risk assessment policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the risk assessment policy and the associated risk assessment controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the risk assessment policy and 
procedures; and
c. Review and update the current risk assessment:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'RA-1';
UPDATE controls SET nist_standard = 'a. Categorize the system and information it processes, stores, and transmits;
b. Document the security categorization results, including supporting rationale, in the security plan for the system; and
c. Verify that the authorizing official or authorizing official designated representative reviews and approves the security categorization decision.' WHERE control_id = 'RA-2';
UPDATE controls SET nist_standard = 'a. Conduct a risk assessment, including:
1. Identifying threats to and vulnerabilities in the system;
2. Determining the likelihood and magnitude of harm from unauthorized access, use, disclosure, disruption, modification, or destruction of the system, the information it 
processes, stores, or transmits, and any related information; and
3. Determining the likelihood and impact of adverse effects on individuals arising from the processing of personally identifiable information;
b. Integrate risk assessment results and risk management decisions from the organization and mission or business process perspectives with system-level risk 
assessments;
c. Document risk assessment results in [Selection: security and privacy plans; risk assessment report; [Assignment: organization-defined document]];
d. Review risk assessment results [Assignment: organization-defined frequency];
e. Disseminate risk assessment results to [Assignment: organization-defined personnel or roles]; and
f. Update the risk assessment [Assignment: organization-defined frequency] or when there are significant changes to the system, its environment of operation, 
or other conditions that may impact the security or privacy state of the system.' WHERE control_id = 'RA-3';
UPDATE controls SET nist_standard = 'a. Monitor and scan for vulnerabilities in the system and hosted applications [Assignment: organization-defined frequency and/or randomly in accordance with 
organization-defined process] and when new vulnerabilities potentially affecting the system are identified and reported;
b. Employ vulnerability monitoring tools and techniques that facilitate interoperability among tools and automate parts of the vulnerability management process 
by using standards for:
1. Enumerating platforms, software flaws, and improper configurations;
2. Formatting checklists and test procedures; and
3. Measuring vulnerability impact; 
c. Analyze vulnerability scan reports and results from vulnerability monitoring;
d. Remediate legitimate vulnerabilities [Assignment: organization-defined response times] in accordance with an organizational assessment of risk;
e. Share information obtained from the vulnerability monitoring process and control assessments with [Assignment: organization-defined personnel or roles] to 
help eliminate similar vulnerabilities in other systems; and
f. Employ vulnerability monitoring tools that include the capability to readily update the vulnerabilities to be scanned.' WHERE control_id = 'RA-5';
UPDATE controls SET nist_standard = 'Update the system vulnerabilities to be scanned [Selection (one or more): [Assignment: organization-defined frequency]; prior to a new scan; when new vulnerabilities 
are identified and reported].' WHERE control_id = 'RA-5(2)';
UPDATE controls SET nist_standard = 'Implement privileged access authorization to [Assignment: organization-defined system components] for [Assignment: organization-defined vulnerability scanning 
activities].' WHERE control_id = 'RA-5(5)';
UPDATE controls SET nist_standard = 'Establish a public reporting channel for receiving reports of vulnerabilities in organizational systems and system components.' WHERE control_id = 'RA-5(11)';
UPDATE controls SET nist_standard = 'Respond to findings from security and privacy assessments, monitoring, and audits in accordance with organizational risk tolerance.' WHERE control_id = 'RA-7';
UPDATE controls SET nist_standard = 'Conduct privacy impact assessments for systems, programs, or other activities before:
a. Developing or procuring information technology that processes personally identifiable information; and
b. Initiating a new collection of personally identifiable information that:
1. Will be processed using information technology; and
2. Includes personally identifiable information permitting the physical or virtual (online) contacting of a specific individual, if identical questions have been posed to, or 
identical reporting requirements imposed on, ten or more individuals, other than agencies, instrumentalities, or employees of the federal government.' WHERE control_id = 'RA-8';
UPDATE controls SET nist_standard = 'Identify critical system components and functions by performing a criticality analysis for [Assignment: organization-defined systems, system components, or system 
services] at [Assignment: organization-defined decision points in the system development life cycle].' WHERE control_id = 'RA-9';
UPDATE controls SET nist_standard = 'a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]:
1. [Selection (one or more): Organization-level; Mission/business process-level; System-level] supply chain risk management policy that:
(a) Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and
(b) Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and
2. Procedures to facilitate the implementation of the supply chain risk management policy and the associated supply chain risk management controls;
b. Designate an [Assignment: organization-defined official] to manage the development, documentation, and dissemination of the supply chain risk management policy 
and procedures; and
c. Review and update the current supply chain risk management:
1. Policy [Assignment: organization-defined frequency] and following [Assignment: organization-defined events]; and
2. Procedures [Assignment: organization-defined frequency] and following [Assignment: organization-defined events].' WHERE control_id = 'SR-1';
UPDATE controls SET nist_standard = 'a. Develop a plan for managing supply chain risks associated with the research and development, design, manufacturing, acquisition, delivery, integration, operations 
and maintenance, and disposal of the following systems, system components or system services: [Assignment: organization-defined systems, system components, 
or system services];
b. Review and update the supply chain risk management plan [Assignment: organization-defined frequency] or as required, to address threat, organizational or 
environmental changes; and
c. Protect the supply chain risk management plan from unauthorized disclosure and modification.' WHERE control_id = 'SR-2';
UPDATE controls SET nist_standard = 'Establish a supply chain risk management team consisting of [Assignment: organization-defined personnel, roles, and responsibilities] to lead and support the following 
SCRM activities: [Assignment: organization-defined supply chain risk management activities].' WHERE control_id = 'SR-2(1)';
UPDATE controls SET nist_standard = 'a. Establish a process or processes to identify and address weaknesses or deficiencies in the supply chain elements and processes of [Assignment: organization-defined 
system or system component] in coordination with [Assignment: organization-defined supply chain personnel];
b. Employ the following controls to protect against supply chain risks to the system, system component, or system service and to limit the harm or consequences from 
supply chain-related events: [Assignment: organization-defined supply chain controls]; and
c. Document the selected and implemented supply chain processes and controls in [Selection: security and privacy plans; supply chain risk management plan; 
[Assignment: organization-defined document]].' WHERE control_id = 'SR-3';
UPDATE controls SET nist_standard = 'Employ the following acquisition strategies, contract tools, and procurement methods to protect against, identify, and mitigate supply chain risks: [Assignment: 
organization-defined acquisition strategies, contract tools, and procurement methods].' WHERE control_id = 'SR-5';
UPDATE controls SET nist_standard = 'Assess and review the supply chain-related risks associated with suppliers or contractors and the system, system component, or system service they provide 
[Assignment: organization-defined frequency].' WHERE control_id = 'SR-6';
UPDATE controls SET nist_standard = 'Establish agreements and procedures with entities involved in the supply chain for the system, system component, or system service for the [Selection (one or more): 
notification of supply chain compromises; results of assessments or audits; [Assignment: organization-defined information]].' WHERE control_id = 'SR-8';
UPDATE controls SET nist_standard = 'Inspect the following systems or system components [Selection (one or more): at random; at [Assignment: organization-defined frequency], upon [Assignment: 
organization-defined indications of need for inspection]] to detect tampering: [Assignment: organization-defined systems or system components].' WHERE control_id = 'SR-10';
UPDATE controls SET nist_standard = 'a. Develop and implement anti-counterfeit policy and procedures that include the means to detect and prevent counterfeit components from entering the system; and
b. Report counterfeit system components to [Selection (one or more): source of counterfeit component; [Assignment: organization-defined external reporting 
organizations]; [Assignment: organization-defined personnel or roles]].' WHERE control_id = 'SR-11';
UPDATE controls SET nist_standard = 'Train [Assignment: organization-defined personnel or roles] to detect counterfeit system components (including hardware, software, and firmware).' WHERE control_id = 'SR-11(1)';
UPDATE controls SET nist_standard = 'Maintain configuration control over the following system components awaiting service or repair and serviced or repaired components awaiting return to service: 
[Assignment: organization-defined system components].' WHERE control_id = 'SR-11(2)';
UPDATE controls SET nist_standard = 'Dispose of [Assignment: organization-defined data, documentation, tools, or system components] using the following techniques and methods: [Assignment: 
organization-defined techniques and methods].' WHERE control_id = 'SR-12';

COMMIT;
