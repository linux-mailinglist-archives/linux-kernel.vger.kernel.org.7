Return-Path: <linux-kernel+bounces-855107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A9BE03FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A3540464
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785773009E7;
	Wed, 15 Oct 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMPp73cQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911713019B2;
	Wed, 15 Oct 2025 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554141; cv=fail; b=hLhwT2uLX0YwzXyNWYjIDtjWNxdO7a08z+J7XtF8yh51VtCdruxpG0kArJ55vOtTYCuzKRKoetlzwgPQYXCmZixPu94LLOB/7cVxfekisXqB9yK6xyBjIaGaEuIQA/5dvzaTmMBxtaeUb6/5E/tuwR56z11/yT/EUrwa8PXGhG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554141; c=relaxed/simple;
	bh=uzQWdLYk2frk2aNxshVMDxp7A+46yqOCvAdeN0IyHH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aU56hETUX847rmCELYWO4f+9PDP9MtFFUZTbU8Te0HJQOY8I1hjjOgr9J2r6ffDHPmCYwf24JTX0Fwhlyie7ovL8WIZjs4Q0Bk+MfKDwYusF2u49Y0PadHLdM549c0t8o7dBU8JYNBIkpCzcM9fuLuD+/ZGADtsPX6+2gNOvOp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMPp73cQ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760554139; x=1792090139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uzQWdLYk2frk2aNxshVMDxp7A+46yqOCvAdeN0IyHH8=;
  b=hMPp73cQ46BffpFQeMoK1dEw3RZptf6HAU35jZJAh+tOCW4BCb7XyA2r
   Tw2T2yuYTrDijM/9YrClWNFwDlYssdk+7WI7Pwf7/xmyEHhfTBKK0Biyp
   Q/IoXg1AiPDGvjLnbG8xq4dmburwL6X6XYjc50uEq8P6zJ1ISz4YCst9D
   OH65de9cjFQsNf8wDkCoUFyJlqRvtUX1OX1mIwHO1QW4CY5hf+wewT4y9
   s9D8iV76JXJGkO3HT2CcjnYJkZIDb4ybVudVnR6y3NJ1kJ/snKMUup7+V
   0fdzQEEUb6AVLYbyl2hf04fyh7ybhU4Jgas4/jFRmw5cFMVzFWJpGZsGZ
   A==;
X-CSE-ConnectionGUID: Nxj5gKELRjuPs+V4+aUHig==
X-CSE-MsgGUID: WAo+qetFSXKXH3HuaVRDwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62668614"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62668614"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 11:48:59 -0700
X-CSE-ConnectionGUID: MS29/nyIQ8eXkWRmYi3LWA==
X-CSE-MsgGUID: 9a1goxkQRBuliNgnZG4MEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="212859399"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 11:48:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 11:48:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 11:48:58 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 11:48:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqLecNxpW2xjBNN7da/f9Z02P/TMZTUB5POqcFLadWiYTIwWr/L7+NsnVZOu839zigKglrx5Hbpt0L1fMg3H8CUwjcUVdeE1c9u/wGJRx3eB2ACOh8BMj8Xb4gNqLPXoFQXtR6Lr9xvyMqNBC1E7e68yPIM89BhEtb65yLYk2abIWjHYPviZ8YI4wdZlU+eqvtY7CR5QQtlYMLJ1HPK/5tgrEsIUoXAnXE6XWYc6HbHbcK5JGTYHYxOos3mE0H5UkI9Hxd7Le9R9ZFxW0yuJSRg7RW3sXGlBF9uY/Pt+YYE9gYv7QD+9t6zEr81GWT5QEL7e6spgQv9pPezHVuHA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzQWdLYk2frk2aNxshVMDxp7A+46yqOCvAdeN0IyHH8=;
 b=nHXflnPZzXxpdye0rYhJERMS2m/x17P0P+0MCkR4L/mpvnghQm9CmeDtGew3S3qY+PNi6QEaDEoWusNWtSpXurVj8b2miAPApYHK0DE8100K9e8rBISAz08JQqBX9PK8hoQxfrPIlaZ3cyGsAaYB6dcopjqh9Eu/hjU4XmOdUAEh3YfOT+egk8pftxXjWqnJ10hrTspehBOmf5ISgv43r8zpy1mh5snVyXRhULc8NK9vrl4muWvWCPMyPD6PNNdLHTMd1ECm/47PNDthSAzbKQWkoBrX/4dRDZAwwz1yLq1/KeQxI3ACb179dmEmY9ld4BDYOP+fCTRytSLq9mULVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5146.namprd11.prod.outlook.com (2603:10b6:806:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 18:48:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 18:48:55 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, James Morse
	<james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "x86@kernel.org" <x86@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Thread-Topic: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Thread-Index: AQHcHCY4c4HVqMw7CEaMcDAeu2aTP7SfbCMAgAU7aICABbHRgIAAJTyAgAGKIYCAD8pZgIAEkiWAgAIdzwCAARq0AIAAMgrA
Date: Wed, 15 Oct 2025 18:48:55 +0000
Message-ID: <SJ1PR11MB608386E5B83880643B23E159FCE8A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
 <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
 <aO/CEuyaIyZ5L28d@e133380.arm.com>
In-Reply-To: <aO/CEuyaIyZ5L28d@e133380.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5146:EE_
x-ms-office365-filtering-correlation-id: a944189e-41b9-4585-0da2-08de0c1b7e3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?R0dLeFFDRUwvYXNPaDF6K3E4QW5OTXdUSDM5a281RGtrRXdnYWdpaUJEdk95?=
 =?utf-8?B?Rm5CZzFDSlRhNlgyMUtNMGtrUjZDNThxbFJERnVPMjhCS0hHQXhGV3J6UjRT?=
 =?utf-8?B?RVNmMFVlVVBHb29SK2V6OW5DV09nSkdnWTBNcjgwTXY3NXhXMDJCVjl5STdI?=
 =?utf-8?B?SWkyMmZaSmNCWXorTHYybDcrTXVyR1M4dzNab1lZVnl1THl4K2E3NmJ3a2NF?=
 =?utf-8?B?OEM3eFljcU50MnVld3RzSXJyZWh6QkxFRTNvZldzOFhxRG9iaDlQbXRmbVpw?=
 =?utf-8?B?clNBa2VmcGVCNy9HTkREN2k2YUM5eFN0TVNqQktRTU5oZVpoc0NOQk5xZmxs?=
 =?utf-8?B?L3RObTB1SlJ4Yjh3b0JydmxZM2JETWMyRlp3cldZQmlZYXBMUFdBZG82Yjg0?=
 =?utf-8?B?clQ0UThSSGFrMEYyM0pzcnpXYlVtRG52R1JVZGhJZDdIVHBmeTZJWFB5dUF6?=
 =?utf-8?B?dFFzVTJlTzRMdEFzRzhjMkVDS0tnZFhRVDMvUUI4VUR5aTlhUEQ5SkFtVDVB?=
 =?utf-8?B?aDFaK0lkdFArR2xEQWhvamhhYWV4N0hORUVKeS95dHMzcUdLK3R2emQ3US8v?=
 =?utf-8?B?aTNQOG9rWFpjZ0Nac2ozTzRYM3EvR0R0RTZ4ZC9QUWdjdHZGTkpDSWNMeStk?=
 =?utf-8?B?OS8xRGgxejRJbEZzYUhBOG96WlovVnl5QWx1MnJVbVNqcEZTU012UkoxNVBl?=
 =?utf-8?B?ZFFDVkpHeXhyZGtzOSt1V0NWQVdSYnBpTExvS0ROZGtOajgyV3A1Rm5tVnQ1?=
 =?utf-8?B?Mk1Ga3Fua296VzQ2T0FobFlqTG9tQTRRRm1PYnEyT24xSkhveEhYWi9Vd0Ev?=
 =?utf-8?B?VEZrdmE1dDFNZWpjdDFXRG9wR1dHWGl2aWVKNUpoOWd4OEg5bk0wekFoY2Ry?=
 =?utf-8?B?akg5RjJlZnNHR05UQ2Q3ZDJyNjBiUzJxNnZ1MU1nQmJnYk5DNVRSWS84VXU4?=
 =?utf-8?B?Ym5GYXBEd0FkSHBSU2FMdVRyaW9XNWJ0ajlncEV0UDdzUHpNeWNYUUxINUJx?=
 =?utf-8?B?ZU5KMXlBVU5UZ2dMTDJOZVNSdDB5YkNjSkd5OXVjVHdRU1ZQaE5rR2huaERZ?=
 =?utf-8?B?S3BFU1RXaFd5cEloeDZ4K240bUJYSFBJTzBsNE1zS3RtTTMvTHBzWm1FTVZ2?=
 =?utf-8?B?bng5K21JSjF5ZVRZa2dQejFneE5WQ0hyZ3NZaHowcjRmSWhKR0gvTVRqeDFM?=
 =?utf-8?B?bGNONzVyeTZpYnYyMUVYbTkyN2hFQnpoWmZzSXB1QjYvMVF4REpPZy9pMUox?=
 =?utf-8?B?SEQxMG0zOVp3MW8zQ0tQTHNPM2RDK2lhMzBzeHlrSTRjK2JWZ3NFR1pTdXdG?=
 =?utf-8?B?TUJoVnVYNHRIeEJ2ZlFJSDFvYTBjY3IvblA2SHY3cTF5NVFBSldpS1pVYlpk?=
 =?utf-8?B?WUFGb2dCcGdleUlMS1NvQ2Z1ODd6R3dmVTJnVi9SZjNxZjFkZjEzR3hvMmZz?=
 =?utf-8?B?NDB2amhBdkFIdExIcDhwYzRmT0Y2Zko5WjJWN056UklWVHVJa2dMUU9ONVpG?=
 =?utf-8?B?VDdBQUx4ZFhWa1JCS0t5Vk9DTysveS91djM5V0VORnhsNHRTR0IyU3NMQldH?=
 =?utf-8?B?aFoyY25QTW1kd1NSSkhJRVd4UlBXZHJpNGMyT0RrS2U5TkpSV2NSVlRCNi9s?=
 =?utf-8?B?WTR0WExkajNJanVFS0YwcTZBVHVFZ1RlY1FjbEgxYWxnUzE2OERxbG5RQnFr?=
 =?utf-8?B?MTh4TTBKQkcyRklkaXlJalowc3RJTGMvKzJQQTVmYmdJODRaaFVFekF3VmtY?=
 =?utf-8?B?azZmVmMyQjNsNWV1REVZYXcwVFFHOUUyOUJ4dGVtNVdCN3JBS2l6REJ4Q09E?=
 =?utf-8?B?eEpUTnE2dzlTSEZwR2tqZjVqNkVmVG5qUTQ1YVllc1hZc1lVN2ZSblNYdFhh?=
 =?utf-8?B?d0lQN2p2NytIRlR5a01QTDllQkRzbXZZOWNuRTA0VDB3WUNGOFN4WStXWCtG?=
 =?utf-8?B?V0JwOUc4dW4vYWE3aTBhd3R1SFZzeEdGRFBXRE52TEtZRTk5Y3JhTVRnWllR?=
 =?utf-8?B?blFxVVNoMldkVk9mVS9YZUF3bm92YWpzUnlnejBlbC9veTd3RWw0L2Z6Tzl1?=
 =?utf-8?Q?JklTrt?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW1ydnJCWFdYaDZGWFNPVTFKejVHNW8yWjdMTU1KRWlQZi9SNFJrVUc0THBJ?=
 =?utf-8?B?SzNsc1pTLzk5UHpIREVqSThWc2pQTi9tOThRWHBGclhCQkdSWmlrNU1GMDBP?=
 =?utf-8?B?NXgzRTJCL1pvK3VkR2VCcDBYWWdyUDVaem9YYzNCNFlHVnlyN2p2ZHB6Sk81?=
 =?utf-8?B?NHBoYXBSSHVlZkgwdXdQRzduZGJESUIrSm81SlUwdUVpSnVoc0dMQ1pEZjht?=
 =?utf-8?B?TmRwVVBVT2d5aFJWV0g1ZDROanVHSTluTTJLc1UxZ0xsb1JhdjQwcFkvOHF1?=
 =?utf-8?B?WXVLSTJuSXk1dmRQanVDaFpRUkY0YU5iQk8yM0Jqd2xjVmd6QkNEWHdVR09H?=
 =?utf-8?B?elcveStWMVUrQlMwYkJWWHZYTTA4VzVMYjJsQ0ZTVFAxa0VXa0VDa29Ta3gv?=
 =?utf-8?B?YUlKRytKQUFydWVqaWh0OE5wdlVzMlArSDdGOERpQVlQbmd4OS9ENTVrcWlo?=
 =?utf-8?B?TWNnUldId1pPZnFuSXBsSCswTmxCS0lVQTE5eHJTeDNoa1UrcTNwMTAvNkg0?=
 =?utf-8?B?dDVWLzh4L1lKM3c4bHM4NGdIVm04cU1rWEtlWmJ0ZkRmdjRrNUhmMHVHRUF6?=
 =?utf-8?B?WUNYVUREOFRONVRRSkRoWDRrTGZqMVNKQy9QSWcwc1FjdWpvbzJIOVRIQ05Q?=
 =?utf-8?B?RXZKU3lreHIwT3FRYzhjakdMWEkxalFrK09vTVZTeHFqaVliVVBxMHN2Rllr?=
 =?utf-8?B?d3pIb1dMWm8yNXhBMUYwVTZWNGhEUmhycEIvOWN6aVV5Y0VzOU51RG9ESGsr?=
 =?utf-8?B?a2lnRWJVRlluS2FJdDVyZC9BTGUrd25qbkxlajFSdmZ5Nm1JUGpTRFhKTDhm?=
 =?utf-8?B?QkxiemNGZHJjTEcxTWw3L2h3ZERidk4zVXRoNGg5eVJkK2s1RWZTUzBhRWJS?=
 =?utf-8?B?Uzl3TnRRMmVCeHp4dkIzL3NFS1hma0lpcDZ6ZlIzSlltZGtwbFNhU096d1pE?=
 =?utf-8?B?M1RNSXB1TEJnSVJNL0tSOWxiaWQ0WW1EcHBnajdTYzlOZmo0RDlvOGs4Mm9B?=
 =?utf-8?B?MXU5R0Y1SU80THhROWNMU0dydlZEdlJGNG1oU0xnVEJkeE5RVkpkUDI5bDlv?=
 =?utf-8?B?TWFIMXVIeHRMRnUzdUlLK1kwWitHTW15RmFXeTBRY1lHekRZRzJwbDBBUGcr?=
 =?utf-8?B?VzVHejNrY3h1Sk1sdFpDcXNaTEthVTduZ1ZUMG5pT05ad1h4ZVVPWEFCK2Vn?=
 =?utf-8?B?ZU9CblRBTHIvVVF0QnJuc1RYQlc1QU1uMVRndTE4LzlvdGFNTVZRZ3JqM1Fh?=
 =?utf-8?B?bWlrSDlydWNaR0NmcXk4WTUvL3B0dFdoV1ZxWW5aSWk1em1PQjg1S3htVEp3?=
 =?utf-8?B?NFFDanpseHhWVi9jSnVSNjFLTGhpNFZLWWxXbkt4SlNOWTYwaldhWHgvRTRX?=
 =?utf-8?B?aVNXd0JXdTFEV2dkc2xhQ05CVjBiM2FsVlJFUXFpejFwWFk5TTBIY0lod0g2?=
 =?utf-8?B?WGFkMnpxTXVlRXZPenNFeGxBcXZnRUpiK1JaZU13MXRuY1EzeVptbWd4OHkx?=
 =?utf-8?B?anptOW9FWUVKcVRaWVZFbno1akN5ZmduV09iR2JGVVVxeG9FbDBYZlo3L0xh?=
 =?utf-8?B?M2luM1AvS283N1NVOXVSMTRqK0YxR2FhU0xVQ1dINVBQWmlWa3Zjb2ZRWDlM?=
 =?utf-8?B?OS9FbFl6WFQrUjUzMnNVNklhQ2xWS2ZkcVl6bVdJdmNobTlRZEovZ1E5dFVP?=
 =?utf-8?B?YXlmZ2Q1SGdzekRwbEVWMFhSS0R3MHllaW43NVFZSkJBZzVTQllDb2FTWGhT?=
 =?utf-8?B?UkU5ZlYvNmFLYitIZFJ2K0hHelRFQWlwT3pQVlh4RC9iSkd5ODRLdFdKVzRL?=
 =?utf-8?B?c3NpUndzV3VNbTE2alVMaDBsTVl2akRoSzVTN3VQM2lVTDVDZm52ZFBROXo0?=
 =?utf-8?B?WTRmYzR6cEJnY1VRRlNQZExkcDNwRWlTZU9LSTNRYVpCQS9vUUJGNU9UaUxK?=
 =?utf-8?B?Z2JHWUZsOW5USDhZWXYyeUxzSVRiRXUzQnRGby8rVjlNODcwVEk3OU50ZldO?=
 =?utf-8?B?bGo4WmFDZkRQR2FBbzdQZmE4SWtFSjVMWFB2QmJCNDlJNzhIVGFZM3NQRlR1?=
 =?utf-8?B?eFNNNHdCV1JZRWNVVGQwUnZUV0srdHNsNG1OMUZaMEZQR1A0eHlERWFUclN6?=
 =?utf-8?Q?yDwO75+dD5w9BBYoLTm0zkfhg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a944189e-41b9-4585-0da2-08de0c1b7e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 18:48:55.4298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Urx78giWrAWe0XqZ3XJNVSol2PYGLqZKlrWM68pW6JYYxEt0h/GiyQQOnSAtfhNKKDcPiuRDjGzKyXUHAVIFjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5146
X-OriginatorOrg: intel.com

PiBJJ2xsIHRyeSB0byBwdWxsIHRoZSBzdGF0ZSBvZiB0aGlzIGRpc2N1c3Npb24gdG9nZXRoZXIg
LS0gbWF5YmUgYXMgYQ0KPiBkcmFmdCB1cGRhdGUgdG8gdGhlIGRvY3VtZW50YXRpb24sIGRlc2Ny
aWJpbmcgdGhlIGludGVyZmFjZSBhcyBwcm9wb3NlZA0KPiBzbyBmYXIuICBEb2VzIHRoYXQgd29y
ayBmb3IgeW91Pw0KDQpEYXZlLA0KDQpZZXMgcGxlYXNlLiBUaGlzIGRpc2N1c3Npb24gaGFzIGV4
cGxvcmVkIGEgYnVuY2ggb2Ygb3B0aW9ucy4gQSBzdW1tYXJ5DQp3b3VsZCBiZSBwZXJmZWN0Lg0K
DQotVG9ueQ0K

