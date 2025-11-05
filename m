Return-Path: <linux-kernel+bounces-885941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7136FC3456C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D75164E333F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297A2D3739;
	Wed,  5 Nov 2025 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4MlqhNA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4F25C6F1;
	Wed,  5 Nov 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328916; cv=fail; b=adQETAQLuo6nYdOE67AuOVGczEfPo9Xz44l9tSTud88juqgn6pAnFTOWMqtyV20D7Jz7VGWwFMyBh5caprsPAX/jruPx4K7cdtMh5daKkkAv89Y15EiU3fAX7+EB39T57Xg3QVsRrTlpTd02lcVvqfEu+6Y/9ihQM7Tn0ePOPw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328916; c=relaxed/simple;
	bh=xmx22ZNg9wYkfSOMjaet689y6TbaMJUddYb0H6iS1b8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NofO8OnniTwl7X+Wx1pXLIHV4avvNo4UelLl2mHCs1y2u7kRZaYuv673eMY+u7Hti02jRzbQD67B5hxGMEvPYJMRAIrQ2WUNToyQorF8mvnqPQ/JoKuqF+Ufc0dSgn/8JxTVyuH66gTdjgJQ+CXPU9sBVHyoLkHMO9NejnYpvSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4MlqhNA; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762328914; x=1793864914;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xmx22ZNg9wYkfSOMjaet689y6TbaMJUddYb0H6iS1b8=;
  b=N4MlqhNA/csjC87GbtSnU4CDHpa7+EBnj0/80hzKZ5uCdZmvU5KovWbS
   77GZAVjkVfy7/6SNWlcqPbFWBpnyxlZ0KM/siZoM+XsK/6ylpMgH8eFxI
   OFNcyzKBMIkObehwx3CWEMK1Hz0h3mr1mggX89g76kmvImFMrh5y1qlor
   80QX6kUUAlJiG8EYtoHVjAVhRSYEEXOVgxqWTTVIaWN6qODiiW0XnhjNa
   4TmMTnCHNkU7EL8lLks4LZGL3lAWCiWGAAdk9/wXPxMWcIu3kojC6FE0b
   KUmB/Q3sutdYitQI9e7Q5jtiv1/rtHfTlGc1OWxBUn6nWPo1mMjyUbhRv
   g==;
X-CSE-ConnectionGUID: gWSKNkeoR+29ls8ncKca2A==
X-CSE-MsgGUID: pWr3fCNFRomrAIi2w12eig==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75041401"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75041401"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 23:48:34 -0800
X-CSE-ConnectionGUID: DzetlgaURhm+I4oDH3tmMw==
X-CSE-MsgGUID: yFkkIXiMTwyc2yw+m3nNug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187230837"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 23:48:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 23:48:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 23:48:33 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 23:48:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpgLc89KNmbOcHdWIEgel5JjkPmL2yk8m1Tqc/pjQgRXOZEtgGoTrwB7oRuPi/PFVuUkZNQVgW2BFqAoxtgHKDG2NvxubcpgMqCmlkDo6LubpsCc8izff1ugy8PF5Fa2sCOiGB85qwmz1XSmxugwU6Qao6LCbaVWYhNYRadOsdzf9TQmSMaYkB5GRThNfwP9SdBhcCo0LTsG9M/NJ6pyJMKccffatG/cAsdg+IlvcVj6dUWbHFhCoxEOyBnljz0vV5xjI1y+6cWLxyieQZjLsGvRWRbBMcWUkPr0WXGGNnhpC2cB1a2+XGak1mDMnmWya8kUtVtxYpAf22wRytoACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWvZeRTsUxFPVcT9r7EfVT1o2BJ9yVbi064N0KRRjOc=;
 b=EIoRiXR/fS80zPhtFIStktZZHjxByKINCJZqMF2vzBP7CHwI0KRml4WfXEFtcsUSzaarPtr57LXGvfmItqu+TsTGg5a67ScVEe8lYYZuJOBLE09oFE0qNemtsHYhstMVtL5tQ6mRltaI2yb1cSUFJUckwGKWH91wQTBkRtIDWjzLyIY9SB/kNCs5YPplFvNGr/rxtmyRXJrForo1uEGUAsfyCXrPPdjak7nJ0OoxgeUsht+9uMl9M8YpwYtmXG1n3/1E8WrSPCWdgyhRyJcOxeio8/2C15bLQHNM3HP6+zhSRMrRlgFFMFVL4dIsGbEswluxN5mRxdKfaNfOl/M1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by MW4PR11MB6810.namprd11.prod.outlook.com (2603:10b6:303:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 07:48:31 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 07:48:31 +0000
Date: Wed, 5 Nov 2025 15:48:20 +0800
From: Philip Li <philip.li@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: kernel test robot <lkp@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <aQsBRFPwz0RJ/u9S@rli9-mobl>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <202511050706.NIxJwZER-lkp@intel.com>
 <aQrgMldkQIS7VTtV@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQrgMldkQIS7VTtV@smile.fi.intel.com>
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|MW4PR11MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 87acd2e7-18dd-405b-29b8-08de1c3fb6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BK1cv1uktfjDCtsEIwDDTGYCGOAJWHh5E5TeB4dNvPm6qI7d5Esdk6grWfi0?=
 =?us-ascii?Q?B1Nung2Ay8UQp3kMbiLzRX/K3RM6hGZCMOPcsbPNgBJBCndMIEVgRUwR54eY?=
 =?us-ascii?Q?KCgghd3mXkUuW0M1360X8jcxumXqzCC+o/uBgfn8ERiEc3C1Fq5IRfohMTqj?=
 =?us-ascii?Q?E/0kNKmlz1Fqqq6gA3+Bw2DdSdiQseS3CylIHj4RaPCbwDyQPADkAXqw08xL?=
 =?us-ascii?Q?4+2THtWZcBOh6USZqvLjlR6JjYOJJTNJOHS9AAEd//e3uyiOxiF7d167doj7?=
 =?us-ascii?Q?JRDOetUBBYEuZGpaTastaRYTgBl5jZC+5K9SjUocl7PO1LiOZJAs6y/DNsY7?=
 =?us-ascii?Q?0q4UAaTTmou7heI3spEyeVMCvJpgo7ZnJeDobe78dw/MV7NJVuT2DfHf4Mnk?=
 =?us-ascii?Q?dMDA1t181i+hcHcbeYZXWZlygLXL7yEegxsiXkgyJy1+vUdS1VzAPLnjXEa8?=
 =?us-ascii?Q?F/QW2d0d5nmL0FzrCBsTHmPEy6AYt18ma3laGIZDNLOJvzZ8V+lxcqrcleVS?=
 =?us-ascii?Q?DkYtNkvAXXFNcw3rp2zbD9UeMN0Zs68/wJH81SOo/QPGJKbaNG3t0YvjydvK?=
 =?us-ascii?Q?49aNnebMRmo8uCafCx8EWlmp4+ss0ociY7nkiKGmSvJC9BOLvZhlmCnZT0vV?=
 =?us-ascii?Q?7SuzyFx+YcptG/nBuySeBfw9huRumlmmfeJxv/sL2BFSuxUVu5kcsKKKv7Qf?=
 =?us-ascii?Q?0lPFu16zWTQhtHY5IWrJQeGVvERi/F8kfbgjWDMx7SppnZO+VuvfsFn1pQPm?=
 =?us-ascii?Q?kIQFEUiCbnNWYGMJW/NrDwzsXNkg6yb1J6MBZyDT8Zn1nFxWb+Iz39XuN95n?=
 =?us-ascii?Q?4T6otfqOiolGuLz3bB5HbHZq72xYkPQQAcZ3bxnMpLNyiSj8yCTmOpMgFiFv?=
 =?us-ascii?Q?WSfXMOo82C1DwELEOxI1NkXNo+sHaJ7iXbtYrOg6tQ2ARoHj1aRqipup+RO2?=
 =?us-ascii?Q?SfSfSbAHn/IluAJtL5rF3LtZaJiFFt2KdbeMojDausA/YflCysnE1OvJJEPl?=
 =?us-ascii?Q?7F6FpkSfMbMAevXRAHU4G+/U6BouuWVX42/aOvTno/Ng1g16fG3GwcZNz+QK?=
 =?us-ascii?Q?S+IcQP0yrdMk3Eq70o3LrnxM7oqAOJnENl150e+yZCbEsPb3JZ8bGCRrmHDc?=
 =?us-ascii?Q?FrXMz+L+Tffwx9NeD4BP8gOiHEGj/VzwD88XHtdK9YJwcKqvCwFDSr2S3/1J?=
 =?us-ascii?Q?1eEB7ow6CrTNdPItGfLPYMD0Qs+lV4nwhPa77dcdinERvmWNNInaxC9P3uIu?=
 =?us-ascii?Q?/kos5z43vdUN0ANm+ZyCIAhnW81pW6p1uid51CC8PtFSgK6G+71Gbo8KEFXC?=
 =?us-ascii?Q?0NEUXjYKZ+d0fjfVoSCNgFHXLhl9BMIZ1WovfEpMqIGOaZutCv1T1GsH+oqS?=
 =?us-ascii?Q?BTGkr+gjfZQFsRMy9/aiKPKa2MqZ34rB2WC5aBB1ZOqm56QWGRt07BLqjV0A?=
 =?us-ascii?Q?X2NXAc0EwRWfUPcBgwP9yu1otO73pKVBzFCyJPApcZzpEmZREK/Tiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oJU1FC1JsC/zJWb0RY/rA5LuuV2npZ3ilGujpJ+ViiAaLst5hK6MPmOB4VMm?=
 =?us-ascii?Q?7XtRMW2oeivssfBavDH/Xib0qQZOAosATGGzwnznhDJcAvv+Ns2h8DC10Yn1?=
 =?us-ascii?Q?MaSCkOGhhkWH/JIG0EOhXVdOY2x3W3tKdJF2y4I02ePgBcHyhCfrrmiAYv8u?=
 =?us-ascii?Q?ZxoZCojN8If9vzdvDuXUPv3DIALAaJDVnwU4Sz+MS71BA46wVVqogkWtERf7?=
 =?us-ascii?Q?j6ypkb6Yc5lCt8cad+wPj2tTQbNKuI5dTiy+uZw5ymcoDjOQrkwQH9yYteDk?=
 =?us-ascii?Q?ou2aZupfb1YudVk7jqVjDDtE8wPS7QPwVEVp9lzo29DucP7U9zLPAZ0JCLRy?=
 =?us-ascii?Q?r02WZwvDROWcK5iF8KFLR+mUZznRpA7BFoHBWUDiLC9mCxPCtA2IerU180Yz?=
 =?us-ascii?Q?k1n4/4gAwL9pcORLa54nBsm+CY22SNHItbm3DDMoa5Y6Eog0VfzPp/ZZnZJ7?=
 =?us-ascii?Q?OWq2GNrIuFt2snfq23NipiuBI/VPsWm1iY061nKPTRaiLW24OY2+80kSUzG+?=
 =?us-ascii?Q?7ieMYTAOvjCdcKRNXqHuEZrQvT+OcdDAV7vxSysuoyvTBc8hsr1V389PZh7u?=
 =?us-ascii?Q?ndQJNk1/hdhSIN+9lN8gn/Jz3iX+akQSpFpo6AXDnuTE3TLl0NbzWto6MYYD?=
 =?us-ascii?Q?qUr5DO7dnuSO53xzoE9f4sp+50m5Fvpqq/mLuNcse9iwlirOS0XFuy3QVJG5?=
 =?us-ascii?Q?Z9l/PrtSrdD4egQRc8a5POuS4rekr/AbIRVhRCls8Q3NOFFdIsF/fp5t9mJI?=
 =?us-ascii?Q?rfgoeCfAkWS/wQHeBaFmMhw2LtuzI75P9hdp+/7MK9m8hLKNDyb+Qo/s9Z8g?=
 =?us-ascii?Q?qmmtXSV4B2aKkfnU3bgRZO6klWbXJYnep5psOmUI0LfOFzFkFvvEAOFKHSza?=
 =?us-ascii?Q?MujFUtksZsd4JRrv2VpM33jnnwVLGlgkKjJXxP2PbTdELCJ0GXCF5ULMAVT7?=
 =?us-ascii?Q?Q69V5Zbhhmt5Exjutz3zzBUsnZJ0zYtWriTRx22M/evT+EbMgNBXLLeCrPgG?=
 =?us-ascii?Q?07uZT/DO1kA7Ff0vIdNQL1gDOeh9lfM5aYkyds5akdf/p3vGtDKQ0gOlgkpn?=
 =?us-ascii?Q?rkf7LW9ps9e1DwWKcUxb2+14kV6KldBmM24VMaPbjIIb3cyKLQhCXFN8LEi7?=
 =?us-ascii?Q?wUA+KEZ0dki1nVRp0+ZAjvQDNfzhnUCgo+glihR6RNBVuW+2Xcr4ZiR8cWD/?=
 =?us-ascii?Q?O1RYV9DjJaklBMJJL42nfKYxLj7aIbsQckx2/Dw0tvvsP4mXaiSg3Ash9QhS?=
 =?us-ascii?Q?BCdb/Yqe7U9maZdeQg+FzTSMNJg578Hl6NX0yoHW4DCAnpQMHK6oBBRSVTc2?=
 =?us-ascii?Q?3OM7yYJ1DmEAXq40FCVjG/uudlMw54EpqS2Y9KfTgLou/RTDoO+X8xlbIgGx?=
 =?us-ascii?Q?qxakyQFZvNtt+2OnsvHyVVrexFcq6OBpSFcLybTqGkrXZHnhyuFsfkU9PeHQ?=
 =?us-ascii?Q?8m4G4o1LGlzlM0KNBmjLZ0orL8OoKEAGhGj0a3/sOLgNhMq3WeU4x8RgBkxU?=
 =?us-ascii?Q?HV37t3fUHpTDCk10GY9vEWmR1JCBv786Tthls1f7K4vLrr/FnS9IOBiBMhQW?=
 =?us-ascii?Q?lQsTHH0w7niDdVq+2QxuHIOSCgj2YS/hB3lPgGOT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87acd2e7-18dd-405b-29b8-08de1c3fb6bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 07:48:31.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Co0ErTzVPVhpC7hYIIND8okahVr7zcdhkuK4i17m5qSm5SrvPJkldj2ljGO/1n+xkECMaHKPfXjBo99M2Bc58A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6810
X-OriginatorOrg: intel.com

On Wed, Nov 05, 2025 at 07:27:14AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 05, 2025 at 07:14:58AM +0800, kernel test robot wrote:
> > Hi Andy,
> > 
> > kernel test robot noticed the following build warnings:
> 
> So do these...

Got it, thanks for the info, I will update the bot to ignore the further
reports on this commit. Sorry for the false positive.

Thanks

> 
> > [auto build test WARNING on lwn/docs-next]
> > [also build test WARNING on next-20251104]
> > [cannot apply to linus/master v6.18-rc4]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/kernel-doc-Issue-warnings-that-were-silently-discarded/20251105-055629
> > base:   git://git.lwn.net/linux.git docs-next
> > patch link:    https://lore.kernel.org/r/20251104215502.1049817-1-andriy.shevchenko%40linux.intel.com
> > patch subject: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently discarded
> > config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20251105/202511050706.NIxJwZER-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 15.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511050706.NIxJwZER-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202511050706.NIxJwZER-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'd' not described in 'intc_evt_xlate'
> > >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'ctrlr' not described in 'intc_evt_xlate'
> > >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'intspec' not described in 'intc_evt_xlate'
> > >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'intsize' not described in 'intc_evt_xlate'
> > >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'out_hwirq' not described in 'intc_evt_xlate'
> > >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'out_type' not described in 'intc_evt_xlate'
> > >> Warning: drivers/sh/intc/irqdomain.c:29 expecting prototype for intc_irq_domain_evt_xlate(). Prototype was for intc_evt_xlate() instead
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

