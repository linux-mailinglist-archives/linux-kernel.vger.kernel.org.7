Return-Path: <linux-kernel+bounces-836562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E052BAA069
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C769189041A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39630C110;
	Mon, 29 Sep 2025 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6a9xwnb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E83090C6;
	Mon, 29 Sep 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163883; cv=fail; b=C9PZ1n0Cm1rrvPddreICstxreMQvLMyUxyQzIgjTLvwg5O42ox8DiANUlMR4s90BCRpPwc9/TRcQz1KqRGWrzXiKfmi9niUVNZEollhiiRyhHmVyiHKmLQeDe2gCrFargUqjl8OKy0nMhYYKVhhbByJ35kzJxrDm/GgGwKITMus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163883; c=relaxed/simple;
	bh=hdlzDHd4AQvEttKLw1kEHiliNcMymLgK7K4I3smCqV8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TitaT8p5mn/hzAsgxD5qdn6ZJab0WyxtWihYlHLtY6m72MucvUargSd7Db2vN8kdRACVCe+59QGXuGCHqOq6jJDiStB9r2L62Ve0Lok18zUr+ljgj58Y6YHEBR5XtdSP4/8ZtIA2zkcwD39/YnW7rPViugIWOPBckHeqGvDiZJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6a9xwnb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759163881; x=1790699881;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hdlzDHd4AQvEttKLw1kEHiliNcMymLgK7K4I3smCqV8=;
  b=Q6a9xwnbZS0BAdtrFxjD0cGq6wzj8LFeR32961Iux/tgk9CcPI5maw0f
   F0RnBPKXHbMqLdhA3qh9rZiQTSX/I98vtzZz6iUEtxpNfl1lsHPmPcxeR
   uGMG16wVY3jANir9tGe6f5S62JDtWi7Pn7EHLVoytakLQFNGXLT7C6fVP
   NlHHolmF970Mh2a0BdzDT0KPbWgptniu4Wh+QE4vCx9s/uh/GQCMOmwDp
   JYqya6AP/ivwTNlC3oANeplU2Vxria3trQnDUlCEWDd0MZBkQoByy5u7+
   kxi9DzMBVLch9BFKIHLBImeNjcyiz4XPjoIyA9ODGhdxogFeaoLWVD76j
   w==;
X-CSE-ConnectionGUID: J3V49PBfSiiFPcgnCMzRgw==
X-CSE-MsgGUID: x3am7JA9T6OHJ2jWZBqvJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61518294"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="61518294"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:37:46 -0700
X-CSE-ConnectionGUID: YwwKWSCzQrCg8AzgA4ExZQ==
X-CSE-MsgGUID: jRak0CnTQvieBhnZMxupsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="201959937"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:37:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 09:37:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 09:37:45 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 09:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrUGKpfJm9HWRIluY/LEZTsEePL12zKuN+tmrvRz9mM275+4uy+My8dipWizuMdnDm3o+5G3ximfvvwLYqA1JVCs+AiRinCTCWYaGrSCbtrnEpX6d9S5yg8Adw6O6iJ/5/NcZ0rcVcLWd2jjKjUku7I3jzjiQfExE4pAgfqN2pTWxnPqTtIiOXx0UyzW8SYgZQJxAiZpEf4QqpvDwlNCRyNvdxPx3lupvBsHT2kKM9O4VZxQs9HhVq1Tp5wPPR9vhggWdLj+jxxlry7ebhVjz346on4tKjanYH1fozmJUwHrhIg9is/tYmaL3PgadhDatdPhxaA4fD5lPFaBosZRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbzNsZsBSfPlRTSmoceWP6g8eR7pHvcFMR8PxAPZX5c=;
 b=Wh6tqYM7ztYc2eE2mWPlUk9giOkQUBgQSWSFZrOy9xUznv+BGaxoh1eTtQmnt94uAjrHf9m4S6wq0PDE+qCDEMRCN90ZhjiuE7dFzBulUrUMU7kQQVO0c7Sns7/ntam0EIM93LuwIp3025/t/a+XK2SNMJAsvXBZ+IcXxC4uIiP+bx6pZz94h2xURBZKr1+T7HQ5AVCGTqY0l6I/pPY8iiYQws+3ar7W9Ni+oipXRE8rHCptizx6grB5K6lmWn27iWRnUx946VkqlS8zXUHtuIbFJSU7TODseYB+GjUR8TJvxsFIlKsF41n2cAnxIbTKyx+TKO1XvvLRs6vmdokrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH8PR11MB9482.namprd11.prod.outlook.com (2603:10b6:610:2bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 16:37:43 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 16:37:43 +0000
Date: Mon, 29 Sep 2025 09:37:41 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>
CC: <linux-kernel@vger.kernel.org>, Reinette Chatre
	<reinette.chatre@intel.com>, James Morse <james.morse@arm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aNq11fmlac6dH4pH@agluck-desk3>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aNqQAy8nOkLRYx4F@e133380.arm.com>
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|CH8PR11MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: caad7e0e-2e05-455d-26d5-08ddff76836d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T78jxNAMhEy1cdH3TboQcc8PEEuKGxLPxRK/pTjEsOIZy+bPQd7DZFevLc0/?=
 =?us-ascii?Q?HdL6qe5wDMhb3A1p4hygPg0LBqz+9m8OCWD0keemW3Uhh6PpmHCSooBf/vzh?=
 =?us-ascii?Q?iXVTJ04NaC74K48IJZ24C+DVhv4LoSx1k9FJqbbkAoQ7UcuBMTN1YLVsV0tt?=
 =?us-ascii?Q?ztaK6k1+P9QpENuDJCqb7B6yqTjhClVVfRMDEhTgz76csurxZgLOVhDU7lvC?=
 =?us-ascii?Q?zRPHAHnFEqDvYpV/EU78fsJelbc4CbfoMuxGoXXYI7OblF2HWsLJ9jRoDvGG?=
 =?us-ascii?Q?UYPUshrlx0Fac2G8nC8aCUFFbVzhmSdwXeXZHL7/c1clwZW0Pfp43Ew9jjFY?=
 =?us-ascii?Q?4n3BiGd+jLb/U9cpp/iHn9WohoIcc4ogDSK+lDvIUs+eZCNNk6UXfjD+ov6Y?=
 =?us-ascii?Q?THGAkGvEZyHJg/si+2Xpse8jOKWEZRdJpSml+ELbcJUepdQXMrYVGg6rUdpY?=
 =?us-ascii?Q?HxLL0jg67mJF3JxbPE4JLUTd18h0EFz1L8pfsFl4hh6EWbCJKwBcONocxRJO?=
 =?us-ascii?Q?Rqg9+ZKEwshSIJN1+dEGGS3GEbi16j7wBFJPVuxHMW30r6utzSwZknVFGd3S?=
 =?us-ascii?Q?1dS0xZGAMj1zIX4gIjQyP+pHNHlM1L+Pp8DGXZPeX5FsKsosdaKz2vVcsmPl?=
 =?us-ascii?Q?sjTLDbXw/dGU4TcWkeF+DMEnAdaaSkCQWDS7ea/CY58Y+blvGCb+tmbFnjyP?=
 =?us-ascii?Q?DXyk+VPYAF0V85IJdszng07oHmLhgqpR9K1FZ6jWQ+tci++SOLhHsqc/jfo+?=
 =?us-ascii?Q?+rMaiL39OTzzrURCfXyzl0K5VnUGUx5AdWmfEcxNQ3SgQk1H5dQOdRAnkJpJ?=
 =?us-ascii?Q?z70ZogyXh4RGQTK5kKwTjuAy/bVQz+6vWNUyw0+Db/9XjtgRtkYaNWwq5YUj?=
 =?us-ascii?Q?A9JJkxi0Mia/6GfwuWoSCegiN9CLzPbcmsbBTIz2mP9VR86RGr+u1ianjmK6?=
 =?us-ascii?Q?XqKDmauEH7FlwUmwg2x1Hfnr3SCoEglEG959jrWIrzo28puxiSyXKjfQj5Vt?=
 =?us-ascii?Q?YCbfZ/xVpTetPQChGDA4is33s7SvglKQQslF2MN6FQPc0DPzzFKq7/4qPF7T?=
 =?us-ascii?Q?ExLpwiFOBf6EG/bdfWESNo/MPvcJAHfunFCIKnINHZn+ujcpKNKzzjxwEKC2?=
 =?us-ascii?Q?zQjYd9DEWi15poM4tMyRfni5+S0nx6HEiaQHU4ya3ivV9hkcdR8Nxqi3qZQZ?=
 =?us-ascii?Q?Ad9UKDO6/PvKUCPWb0eha2H5l9jjcJoA3jJv2l2osS2XVwDV81xlClgfNB2n?=
 =?us-ascii?Q?EJ8v1iSr2tfqDwkz95jUjRgPWtsuEJ2goskJHTrujpfOxldJ3HcJT9QEdClv?=
 =?us-ascii?Q?d6tqqtpy2MNIA4J3mKR1IqS4Y0vndzyAaRjCbtZlsjsdsz6UipyIfPTlI0RP?=
 =?us-ascii?Q?ep1cyTUSXOnf8NvjGaWsYYjYhwTl+w9aN/SvK5iJCJu9hEZNmZe7kBbHFyUt?=
 =?us-ascii?Q?Hn9KSDEIkFNLi1cZQxXTGAqETSdePHRk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/9IV64HfcDCDrNll7TpdRvMoFUMX74hzhic57oJvZ+ipvQt8j8234jjXSZ7E?=
 =?us-ascii?Q?HXHPcPzOq1+TGLN/NrpNNaoVmyDaYvjj3PA8q/bHX9aHzP/ZpY/49ewJoiJG?=
 =?us-ascii?Q?dLG6bNIUNs60i4OCfynHpXnvPdfoddwGQzA4XH5HZ320LGvuQRS/tHRzw6I7?=
 =?us-ascii?Q?vIwzdwUxsgMYZu3bEb8ISzcUo+9PF1zIrg4/dh1ljwA1yK5DBU+vMk4Vy43E?=
 =?us-ascii?Q?luP3VUQz5DVDZIZHbZ+kUXVoOmkFdtHuQidJeKglLYHN/J7aO0IG4yYw1Qst?=
 =?us-ascii?Q?lzDFVQCoKCqLmYkw6e83/1ibJ2i/LIJznYP42P+niBFAQHTQKkbd0NW3CUko?=
 =?us-ascii?Q?F6fCc/auHBfC+nSY2kceVwqydUZlrVmPten2ypp7egtmM7YtzRsYaw/sfMIi?=
 =?us-ascii?Q?L7Go2P5XOB0auUWZRXG36oVTgCD/b3PxOdUDbchlMeeBentplTrcuIj5Cke8?=
 =?us-ascii?Q?Ghrh9EO7D+IVDzjt3KPewFoOBTexkivNOnzCYZCXJpyjlusdyCeOH1iQ6dhv?=
 =?us-ascii?Q?EBajs50ZiyhsC8lfs++ccB42ShDgCFDN8iQnrCNXhbwgEOp1X4CivIyETS46?=
 =?us-ascii?Q?hhEJzd7vZ/FZjT2xmj65+xQ7sB6ILyYakcQBsa19CwlicNLjgdaWeI8lnx9s?=
 =?us-ascii?Q?RTrJ8Tb7BbQZJoi4uyyvZQy+Oo9u9s8rhl8z0JcMLxE4vzDs0LvlFRjwjOut?=
 =?us-ascii?Q?DJot+Lwwvfn8vGz+ZARTA/WUt5mbVp5lh9qfbx3Ya4bUWEsmuy1zF03iGGFL?=
 =?us-ascii?Q?HNi4SuTpHxnjCXJJokjTlO5CsymYT2atNkO6dKWk6VOTq2usZ1wYq+2AcCci?=
 =?us-ascii?Q?PzcIXhHJY7TwAjbn0sCiIGmLk8sGI6AzynHmj2BUVNSEaSNsPCTqgmH8mUc0?=
 =?us-ascii?Q?pMT/NZa6cuFv69g0HHJsWJwyi2edWScSsLhiAm9cAZcaIvoKe0hFeji8apyL?=
 =?us-ascii?Q?x8vatUiy/oKHRe63YIWjjZmEdNkK9XbZ89nmbYU2DXO3e0iCamrNImTpTVE5?=
 =?us-ascii?Q?E0A52VnCZ10+tyfYbUqquqfweegkGb2xA2OUsQp9GxHWNEx9xRKz6IjjgrJq?=
 =?us-ascii?Q?kLFdtAZWJ28yc9CTWpIcqfHJ9aGMIxA6JaUuZOcEOu15SKw0gUjswlzrXT1s?=
 =?us-ascii?Q?2dMhhWy6U3R5X3W6+lRW17BXny/lWFNnhniRlaUljTxVOcpqP1oi6TI1O2+s?=
 =?us-ascii?Q?Kkcax62IaJTkRJ6/LWA71K4NiotesN9bNqALVxH4M84sf/SyI0mypO1U0MZC?=
 =?us-ascii?Q?f1y4ciWL1AaFhc4hYZjwpgF7LVkDBa11gILN4LqtEsi+pD9cPee5L36wxpcW?=
 =?us-ascii?Q?HA5D1tbXnIETTAJZZoyr9iR1AORu8FL7i5DNrFLdpWHowGhWOJQ9GWDLL5rR?=
 =?us-ascii?Q?wL0DlaeOWVj7TI7hs6NdvXLcq40NUN9Bw9qVrAfSXMBFzSqux9xTSvHmm0Ve?=
 =?us-ascii?Q?v5LyriMVYvO1hRPY2mbHAmZgH6dkQDPFUCcc8lTdDVm1oYx3EIv8SwRwaBXQ?=
 =?us-ascii?Q?CsaPzFEtEA/f/5/P0yLsf4oyUxiEduyU/NEK5YdqtFp+46dj/bixKkQ8XRWM?=
 =?us-ascii?Q?GT2evqkqoj3P1tI0t0qCtrf9i8fo3913lYEjUxtt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caad7e0e-2e05-455d-26d5-08ddff76836d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 16:37:43.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdNsoazK90gm69DYOitSg6PvFFm0N/PZsXS9+Ww9M9JePS6c3syMpVIvGcqMqh9e+aVmfcE5yXOwfjWtprwNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9482
X-OriginatorOrg: intel.com

On Mon, Sep 29, 2025 at 02:56:19PM +0100, Dave Martin wrote:
> Hi Tony,
> 
> Thanks for taking at look at this -- comments below.
> 
> [...]
> 
> On Thu, Sep 25, 2025 at 03:58:35PM -0700, Luck, Tony wrote:
> > On Mon, Sep 22, 2025 at 04:04:40PM +0100, Dave Martin wrote:
> 
> [...]
> 
> > > Would something like the following work?  A read from schemata might
> > > produce something like this:
> > > 
> > > MB: 0=50, 1=50
> > > # MB_HW: 0=32, 1=32
> > > # MB_MIN: 0=31, 1=31
> > > # MB_MAX: 0=32, 1=32
> 
> [...]
> 
> > > I'd be interested in people's thoughts on it, though.
> > 
> > Applying this to Intel upcoming region aware memory bandwidth
> > that supports 255 steps and h/w min/max limits.
> 
> Following the MPAM example, would you also expect:
> 
> 	scale: 255
> 	unit: 100pc
> 
> ...?

Yes. 255 (or whatever "Q" value is provided in the ACPI table)
corresponds to no throttling, so 100% bandwidth.

> 
> > We would have info files with "min = 1, max = 255" and a schemata
> > file that looks like this to legacy apps:
> > 
> > MB: 0=50;1=75
> > #MB_HW: 0=128;1=191
> > #MB_MIN: 0=128;1=191
> > #MB_MAX: 0=128;1=191
> > 
> > But a newer app that is aware of the extensions can write:
> > 
> > # cat > schemata << 'EOF'
> > MB_HW: 0=10
> > MB_MIN: 0=10
> > MB_MAX: 0=64
> > EOF
> > 
> > which then reads back as:
> > MB: 0=4;1=75
> > #MB_HW: 0=10;1=191
> > #MB_MIN: 0=10;1=191
> > #MB_MAX: 0=64;1=191
> > 
> > with the legacy line updated with the rounded value of the MB_HW
> > supplied by the user. 10/255 = 3.921% ... so call it "4".
> 
> I'm suggesting that this always be rounded up, so that you have a
> guarantee that the steps are no smaller than the reported value.

Round up, rather than round-to-nearest, make sense. Though perhaps
only cosmetic as I would be surprised if anyone has a mix of tools
looking at the legacy schemata lines while programming using the
direct h/w controls.

> 
> (In this case, round-up and round-to-nearest give the same answer
> anyway, though!)
> 
> > 
> > The region aware h/w supports separate bandwidth controls for each
> > region. We could hope (or perhaps update the spec to define) that
> > region0 is always node-local DDR memory and keep the "MB" tag for
> > that.
> 
> Do you have concerns about existing software choking on the #-prefixed
> lines?

Do they even need a # prefix? We already mix lines for multiple
resources in the schemata file with a separate prefix for each resource.
The schemata file also allows writes to just update one resource (or
one domain in a single resource). The schemata file started with just
"L3". Then we added "L2", "MB", and "SMBA" with no concern that the
initial "L3" manipulating tools would be confused.

> > Then use some other tag naming for other regions. Remote DDR,
> > local CXL, remote CXL are the ones we think are next in the h/w
> > memory sequence. But the "region" concept would allow for other
> > options as other memory technologies come into use.
> 
> Would it be reasnable just to have a set of these schema instances, per
> region, so:
> 
> MB_HW: ... // implicitly region 0
> MB_HW_1: ...
> MB_HW_2: ...

Chen Yu is currently looking at putting the word "TIER" into the
name, since there's some precedent for describing memory in "tiers".

Whatever naming scheme is used, the important part is how will users
find out what each schemata line actually means/controls.

> etc.
> 
> Or, did you have something else in mind?
> 
> My thinking is that we avoid adding complexity in the schemata file if
> we treat mapping these schema instances onto the hardware topology as
> an orthogonal problem.  So long as we have unique names in the schemata
> file, we can describe elsewhere what they relate to in the hardware.

Yes, exactly this.

> 
> Cheers
> ---Dave

-Tony

