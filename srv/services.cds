using { apihub_sandbox } from './external/OP_API_BUSINESS_PARTNER_SRV';
using {sap.capire.incidents as my} from '../db/schema';

/**
 * Service used by support personell, i.e. the incidents' 'processors'.
 */
service ProcessorService {
    entity Incidents as projection on my.Incidents;

    @readonly
    entity Customers as projection on my.Customers;

    @cds.redirection.target
    entity A_BusinessPartner as
        projection on apihub_sandbox.A_BusinessPartner
        {
            BusinessPartner,
            Customer,
            Supplier,
            BusinessPartnerCategory,
            BusinessPartnerFullName,
            BusinessPartnerIsBlocked
        };
}

annotate ProcessorService.A_BusinessPartner with @cds.query.limit.default: 50;

annotate ProcessorService.Incidents with @odata.draft.enabled; 
//annotate ProcessorService with @(requires: 'support');

/**
 * Service used by administrators to manage customers and incidents.
 */
service AdminService {
    entity Customers as projection on my.Customers;
    entity Incidents as projection on my.Incidents;
}

//annotate AdminService with @(requires: 'admin');