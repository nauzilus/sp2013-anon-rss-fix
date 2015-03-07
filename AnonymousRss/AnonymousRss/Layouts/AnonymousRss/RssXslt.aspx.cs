using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;

namespace AnonymousRss.Layouts.AnonymousRss
{
    public partial class RssXslt : Microsoft.SharePoint.ApplicationPages.RssXsltPage
    {
        protected override SPBasePermissions RightsRequired
        {
            get
            {
                return base.RightsRequired & ~SPBasePermissions.ViewFormPages;
            }
        }
    }
}
