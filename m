Return-Path: <linux-kernel+bounces-759625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ABFB1E049
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA68F188D0C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50FB13C8EA;
	Fri,  8 Aug 2025 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEKRScvV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AA125B2;
	Fri,  8 Aug 2025 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617779; cv=fail; b=kAeZAPyyIrgXpR/qqh5sSunSB/T0NuXDaF39zslD+pyAim8UpXyHrXm1RRi7Ms6wlydtX/vcn2EYGxNjN8IJqjCuGBs+HxClEeGjCnN5MIblaLRVgjvA/4+oVNuHjeolJwpmOTHPe1pFwWASEy5wMgubxEMoB9IM4EDZf26l4cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617779; c=relaxed/simple;
	bh=2L8GTJq5XvBMLBJuPUCpwb/mpQ2Vu89un2JG7PiakeU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QirBNAWKC38wjJBqnsPOQAkGE3jYLwHqJN3e40PA2Stc7ePKgtHFhwa33sZZrXKAHoyLuz8DxlYudZuV5P2eYxY13hSXfIlcNuBgLSe/kI4XsOw+k8DqW3Ho7jxS3C3RmS0oBn2OZT9RkSI4LaeZviUlIcvfMfugxUlxFHYbXDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEKRScvV; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754617777; x=1786153777;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2L8GTJq5XvBMLBJuPUCpwb/mpQ2Vu89un2JG7PiakeU=;
  b=JEKRScvVdtnLqLzmTab91K/bhb/kcF9sGYCcuQ5vxMuUmzDYEjxdv0MN
   JQm/YMdSJAdfZc8rnFYvJoCAdYiDraFCpBSNcGgVMZkyLS6h5cTAHv5fU
   MabObHJOFwq9SG0D/IJM1Ci0nSnZloUZtEJBmjMbcIeHfkv9jjugPwEey
   j2vq+LyKzfSoW6tAs7y9ERYrDN2pPSLX4avx2kSVLSlHFuqi59qr5hP6G
   fIyTLEqzJVBM++BHIj9aY+JKMu2ZnaSR4EwtJhDKBJm3ubxF0yza52iKW
   AQMHPn9HIluXzc/zLwMoqN9UGdtxRrRyn+XdETn3KgG7vfHbEaOFB6wCT
   w==;
X-CSE-ConnectionGUID: oIRmIseNQVaDDPJv4xLDiw==
X-CSE-MsgGUID: hoPEhDXfQVibNk4t5BAHUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60772160"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60772160"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:49:36 -0700
X-CSE-ConnectionGUID: 25vrjs1OQhGdW7dAtwm5zg==
X-CSE-MsgGUID: jY9W8o55Q86uD6x9kYcwyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="164449714"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:49:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:49:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 18:49:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.63)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kp+NyzvUJzdqptFOlT9gYH6WGMv1hbloGDg9IoqSoOBzIGuvEm+XJYxMcVyWsom2jYoasA1z8NCEx+XMxYsWc+YOkEG8p0CKpw+s2/dt5Ca8hA9Rb4rpyxszmXx76ktNxWGCetxAbfdPJ4MQWXPfl4sd0xtulGQLxr6mED/oOYqAmu2EIZ9soCmkoWy53EnQxEZ/dcg77ZTaPzggbaaojZNbCaxgknzE8jDrCpZaRLKHaeUeV3MjeZh8uluXr4KGBQoPVIYLZcZ0sOoUORhtGdm+l6wsy2lmao8v7odeXeVWMRQtNO4C4XBl2rMk9tQMr242kXkBW9C9o6D0VdT+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5W3HuXv6NI+dRydy8zLq9Ny02EKZJCxyhjlWLgTxes=;
 b=jBW4c0Pg6dGBNeX7hYCoYx4AfB598NajkcgQ9YRfLyVDrFp/uRLekOH/DhqTOoF6fNoWJvH2+/oCQxrfe0AT9hbEeigeiw55+2IJlYgHEVJ9ZOCCQD+b1WuNdt/NBRpyAJL3Vk7S8Nl0D9E6IB6eWdXYJG/J5dHCDcDpgOBkLd0VCo/d8tYRwvxQopfk5+4KRWjvIxXzd8HMJ4HHtzoLiL0VHtIXaDU5f4bp/Y7GC5wthem44CJJoCs+TsVS8hyxlUV4f0Kqn7+nqKlYd0DMK7vxhWbhBO9U+9pTc7CPbezAS+BzmwwF+ETZtCUleVmCm7H88sIaYd5iBmt/VdANSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 01:49:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 01:49:32 +0000
Message-ID: <0dbdff85-1d32-4540-984c-e8eb4b940cc6@intel.com>
Date: Thu, 7 Aug 2025 18:49:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manali.shukla@amd.com>, <gautham.shenoy@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
 <f53db5c6dd7d0580c0cb1f252d947357d097842b.1754436586.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f53db5c6dd7d0580c0cb1f252d947357d097842b.1754436586.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0055.namprd16.prod.outlook.com
 (2603:10b6:907:1::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d7b248-f09e-4d15-bb82-08ddd61dd1ee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3hBMXZKUEdDWlpZN3F3aDFVNkkzc1Q4cDV2TnozMkkxZCs3dHFoZDNqcFFy?=
 =?utf-8?B?TXJLWStQYzNrWmVFU0N4WnVlUW5NNEpNWkRWQ05zdCtvZVRURW5RanFFcmQr?=
 =?utf-8?B?WU44VkV2RStkZkoxbi9kMFZSYmhScUVrQ1AraHMyVEZEZXRXdUNzZFdPeExE?=
 =?utf-8?B?SWZyekR2K0Q2anNrR0xmSDNIOGJLSVZJTk10Kyt0TUtqNzhUK3VyU1g2cFcw?=
 =?utf-8?B?aG4yblpZS0JjeXBmSXgxWWJDbHdYNVhhdWs3c1UxSDQ1dlB5anhhenBmcm5u?=
 =?utf-8?B?MTVrdTdmeXRBc3B2aGlzeFRDenhreG03bWc0MW5RZjkwd3Vhc1U3enFzcGlN?=
 =?utf-8?B?ZVQ0bTBrYnl1MGN6WHoycExOUU04RldRUVgxSFUybTRVek1PR2VOK2Q3cnVz?=
 =?utf-8?B?aHJrVjRIMHlwRVNUeHNvMHB1RmhaSkpCNk9oRUxBcmdwODg2Tm9nWFhSRnRi?=
 =?utf-8?B?cE9WWHJXY2YyNEpUTjN6Qm5remJBcmloWHA2Q3ltR2ovajh6SHh6NXp2MUtO?=
 =?utf-8?B?NEpWRnJ2c2MyazNybGpJazdTc0JwK2pVSkF6TGNnbkoxWWFDTHBQbFhKNmVx?=
 =?utf-8?B?VEMrd3ZNSEluQVNiZWpONWNvWFBFM0IzSTdzdlE4RFQvMTdNNFhMYXlPekhE?=
 =?utf-8?B?WEdHRUJ1ZTg5UGo0VFdDcFhhUlJHdUtQd3VlOGhWTkEvajhVUmE4WkJ3YWhx?=
 =?utf-8?B?S3k3b2g2VTNPL1F4U1RiWElrdkc0UG5NekFVaU91RnczU2VtRUJnU01aQkcr?=
 =?utf-8?B?cXFCVGxJVHEzdEc4SXFBNWtSNll0Uml0NHpyZkxVSmdQUUp0d0FvTGVZSVhk?=
 =?utf-8?B?ZTI2SzNvbVF0ZDVDSXg1a2hBZWpQMUFwQ0RndVJIckM3bTd6Qlg2TjdXOGsy?=
 =?utf-8?B?dmRMUUVTRlNSa20wN25UK0lWV0xMaDI4OFg5dDFQRExRRU5QbDRiaS80VWdP?=
 =?utf-8?B?bTdPa1E4cVNxWGEyWHA4V054S1hlc2tFMEd4UU5HUTRzL0Z0bU1BOC9ZcHpu?=
 =?utf-8?B?ZTE0Q1dVYXRKSFBYYlFzSUovN0VQbVNBUWF5UU1GRThFZ1A2ZVpzdHpPT1pG?=
 =?utf-8?B?c0ZrNk1aMnVzZC92V3BEU3dyZE9rdHRyWjlOck9iekxOdHM0b0srQWdHTWdF?=
 =?utf-8?B?L0tENm5VQXFMUVJvTk85SXhqQ0toR2lGYzk5b0xZVlEwL29tMWk2M1BwckJB?=
 =?utf-8?B?NFlPclZURncwbXlvZ0lqbUxrSExYQTBHT0ZUTFhCY0diNkRYTVAxZFc4c1Jp?=
 =?utf-8?B?RmxjaGpsY1FWNm44S0dtWlo2bUxzVG8rRDE5T0JCZE12S2NUa3psdFNsVkdM?=
 =?utf-8?B?S3F4SklhMnR5M1dJdTkzSm5XK0M3cDF6TVBZbjZGSHRiUUYyMUhuWkVFaDFE?=
 =?utf-8?B?QVp0Q0ZvTHZNa3pHbTY1ZGtWaDNoUWN6UDQ3MlBQT0tFTG9Ca2NBTkRnOTIr?=
 =?utf-8?B?R0VJbGxta1EzRThlWFNreGJPem83R2NpZXV1LzNOQzR4SXQ1TGozM25mL3pi?=
 =?utf-8?B?dFJqZFFhS1pjdHlSM29vU0t2bC9Rc2dta0Q1eGdJK0IzTk5ZbVgwL3JsdlRN?=
 =?utf-8?B?eEJXZXorZUtqMFA0Q213dXNwZ2RVSHd0bkJKZ3lsVGpGK1pvc3lqTkJHdjJC?=
 =?utf-8?B?eU1lUUtZSThzaEVFbjRadFM0MkN5TzkxcFpVRnJyb0JMNlkrNDYvZGZpYlpU?=
 =?utf-8?B?Z3B0K1FjMWNwTW9EbE42b2V0b1BydE1VSDd6ckJ1ZFpNUldqMWM0VGxIWmY1?=
 =?utf-8?B?ajFZOFY2Z1ZMTm5TdzFTYjJISmtNN1NqQS93dHh1QTRKeHlIdU9ObkxaS29M?=
 =?utf-8?B?dWdYTnlnL0JHV1B6ai9sWC92THYraDBReFRpU2p6cmdocGZZTmxzT29VTXI3?=
 =?utf-8?B?OWRZa1BXMVgrQ3ZreE1ERWdlM3pjaTNHRXNPckV3Y0x5V0hvczc2Q2lyM0wy?=
 =?utf-8?Q?ZQMriHxmy9A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ZncGRzVXM0NndpVDlBc05BalVXa3I0d0Y4bllFMDV0Y2ttSFhxY2ZKbHVL?=
 =?utf-8?B?VW1ueitSU2JUc29PL21mdytyRDkycm53TlgyMzVhV0FDZHloaW9EUkJnNCtB?=
 =?utf-8?B?NFdmOU9CQ0luanlHQzRRR1BJcE1WQTYyNjdsTUxzcmNqbTB4V1dGMjJodG1z?=
 =?utf-8?B?NG91Z0YzVzhDNEtrV1I5NVlURHdxMGJ3N2pNWXJaeUpuUWNxM05XVGtQRkFw?=
 =?utf-8?B?QzY1dUFhSkxmVnl3TGsxSWh6OHhUblVvTjNGajUzai9kMDB3UmJjVmtSWXdK?=
 =?utf-8?B?ZmZ6TWpndzRYbzJNSXNkK0prdEpLTWtWbHpkbDRtc3ZtVXRhc1R3eVFGR0ZG?=
 =?utf-8?B?b2JPa1dheTZZa3ZQd0Y2K3lVc3N2bG1sbDMxbFRkdlVvMEV6Y2xMUmMzUnJ6?=
 =?utf-8?B?R2Y3dWhvckVTVlNGMGg4VXk0Q2dqNFN4SDdXV2lvY3BnVUVyMlVaOWZvT1Ux?=
 =?utf-8?B?b2J0cjRZeEVodnhHR1p2aENIdFBTd2FGME5oNDQwSUZHN01oUThXS0IrL09D?=
 =?utf-8?B?WkdTMUZwdEZoalcxMjBXU2xJSExPS01UWkwvZTVibnhwQXRvWndwdGRrU1hp?=
 =?utf-8?B?MzFFZ0NxL2ZEbUlRd0VQWXhFbk80WDVJV211NWJMSHhqVlIxQWduVzlIdEx2?=
 =?utf-8?B?VThkNnhoeXM4ZWViTGdPaE5lNllrTC9iWEttMUJibTBZSEFYNXV4eEdqa1NR?=
 =?utf-8?B?RDBjRFpYQTRlbmtEYTBrMnNJa1BkdmlzbkVrMkZ5cm1KSGw5b3JndStuVFhY?=
 =?utf-8?B?UmxIOFFLMERQMUgyaHYyQ1JlamlYSjRTZ1czdFdzbWd0cVpYelN1Vk5NZlV6?=
 =?utf-8?B?NFRDK0tXZmFpV0ZIR0FKTS9hZVRkZlkxait6b0NFN2xBNkM4M09Nd2NYanRk?=
 =?utf-8?B?L3lZTmtXSVdvNm1RK2Vua3dwNWdaMnVHaVVFL3BCSDVJMmt0bFNNR1lxdzFa?=
 =?utf-8?B?MjliV1dMWHhVMWs3VXFucVZKelBRWG1uNHdia3lweSt1RXdFUVJXZ2tNNEZz?=
 =?utf-8?B?MDMySlVaUmppaURRRzJCTW81MnErRUFtcGVmd3JWQ0RvUTNCR1lLcEg1VERJ?=
 =?utf-8?B?dnViNHBUSVFXa2VscGI4ZS9Ud1R3Vk4xTlR6WW1XeFVrdkpxOUxtRHpZRmlm?=
 =?utf-8?B?Z1F1VkF5a25VaVlKTmFRWG5tblR1dEhReHF1Mys4b1FqYWJLR0pYMjB4aC9s?=
 =?utf-8?B?d3VtNHI0ZzdtRXBPQ2hiU1c2TDFSbG9lMHl5SkZNZlpKRUp0cHRvcWNZOUVt?=
 =?utf-8?B?NmxjTDBBYldPSHVlQ3dTb3BNRWZIY0FjdXRteEN1NTg2VlFhSFJOQ0dxOTU5?=
 =?utf-8?B?eExuMk9SZkp5YVdtZTBBR1o5K3JieUhVbG5mZTRJc1ZEaDNZOFFPNkJtZGJN?=
 =?utf-8?B?NjgwV05xMStGRUIrVHBOSUdiQkZkSVNNRFRRdFNxeUJEQlkzU28weTJEeEY4?=
 =?utf-8?B?d3FNT2lOdnZyRE9RR0xYblREWWZlK1dOZnNSTW5GcG1yWWRPNU9ZUG1UQ1lQ?=
 =?utf-8?B?cFkxY3VYOGxlNjVmOWltM2dkWnhPZkt6dHZ3TkJPaGhHSEVQZHpvZi95Wjc5?=
 =?utf-8?B?Znpmb1JmZGlRdi9MWjRZaEQ3b3VGNzJzVHBNbDIwVFFocXJzVU1qSldla2dn?=
 =?utf-8?B?MGU0YVlNMEFOaGtKVFloTVFLeDhtS0k4eTJrNmpidkI4R1FMcktSMjhjNUhu?=
 =?utf-8?B?WkZ4ZU1iczBXZG4wTU1pWldPcDdmaEhxSWlHRSt5d0tKUUprd212UXV0aU1w?=
 =?utf-8?B?OUVQM1hwY1VnRzcwbmpNbmd4K1pzbDNLdWFzL3RkZFp0M2NEY1N1bEhOVHds?=
 =?utf-8?B?MG0vaXNCc0VDUWNqOFRJalFFZXp5R1N4NUlvckV4NlVKNjBsa3NBKzhVenp3?=
 =?utf-8?B?UWNxQnFHcHpUcWRieDVmc1NQVDhsUTQ1VVozRU53ckRnUFB5K3dMa1hXM04x?=
 =?utf-8?B?NEdTcnF3a00yOWJnNFUva2xnR1A4NDVuRUFCNXUwcWFKYkxtUjg3cFdCS3gw?=
 =?utf-8?B?T3N2OTA5VDNkZFQyekg5d3NKZXhpb3VBK3pvTng2TmF4Nmt1TENDRHBQS25p?=
 =?utf-8?B?NWNrT3VEczlBS01pM3VlT0oxRDBBUDNDdmk1RzJXdml4aXJ5cEE0dkQwWDAy?=
 =?utf-8?B?QTVYOXVYVVFYdnl4T1Z0dlVLRlFpWjBMTWNkTFhkUkREUURJajFrNG1qN3dr?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d7b248-f09e-4d15-bb82-08ddd61dd1ee
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 01:49:32.2753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbBOvkGS/ept+l7DDeEijsujaHwrcXP8fARFe8Ms8ig+ep93JQm3QrsNKSb3j1QbTny3f4vaKYl96zMsNEIt3FbOvI1FyrU85xSJbjEmZAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

Hi Babu,

On 8/5/25 4:30 PM, Babu Moger wrote:
> "io_alloc" feature in resctrl enables direct insertion of data from I/O
> devices into the cache.
> 
> On AMD systems, when io_alloc is enabled, the highest CLOSID is reserved
> exclusively for I/O allocation traffic and is no longer available for
> general CPU cache allocation. Users are encouraged to enable it only when
> running workloads that can benefit from this functionality.
> 
> Since CLOSIDs are managed by resctrl fs, it is least invasive to make the
> "io_alloc is supported by maximum supported CLOSID" part of the initial
> resctrl fs support for io_alloc. Take care not to expose this use of CLOSID
> for io_alloc to user space so that this is not required from other
> architectures that may support io_alloc differently in the future.
> 
> Introduce user interface to enable/disable io_alloc feature.

Please include high level overview of what this patch does to enable
and disable io_alloc. Doing so will help connect why the changelog contains
information about CLOSID management.

> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index d495a5d5c9d5..bf982eab7b18 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -685,3 +685,140 @@ int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, voi
>  
>  	return 0;
>  }
> +
> +/*
> + * resctrl_io_alloc_closid_supported() - io_alloc feature utilizes the
> + * highest CLOSID value to direct I/O traffic. Ensure that io_alloc_closid
> + * is in the supported range.
> + */
> +static bool resctrl_io_alloc_closid_supported(u32 io_alloc_closid)
> +{
> +	return io_alloc_closid < closids_supported();
> +}
> +
> +static struct resctrl_schema *resctrl_get_schema(enum resctrl_conf_type type)
> +{
> +	struct resctrl_schema *schema;
> +
> +	list_for_each_entry(schema, &resctrl_schema_all, list) {
> +		if (schema->conf_type == type)
> +			return schema;

This does not look right. More than one resource can have the same configuration type, no?
Think about L2 and L3 having CDP enabled ...
Looks like this is missing a resource type as parameter and a check for the resource ...
but is this function even necessary (more below)?

> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * Initialize io_alloc CLOSID cache resource CBM with all usable (shared
> + * and unused) cache portions.
> + */
> +static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32 closid)
> +{
> +	struct rdt_resource *r = s->res;

Needs reverse fir.

> +	enum resctrl_conf_type peer_type;
> +	struct resctrl_schema *peer_s;
> +	int ret;
> +
> +	rdt_staged_configs_clear();
> +
> +	ret = rdtgroup_init_cat(s, closid);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* Initialize schema for both CDP_DATA and CDP_CODE when CDP is enabled */
> +	if (resctrl_arch_get_cdp_enabled(r->rid)) {
> +		peer_type = resctrl_peer_type(s->conf_type);
> +		peer_s = resctrl_get_schema(peer_type);
> +		if (peer_s) {
> +			ret = rdtgroup_init_cat(peer_s, closid);

This is unexpected. In v7 I suggested that when parsing the CBM of one of the CDP
resources it is not necessary to do so again for the peer. The CBM can be
parsed *once* and the configuration just copied over. See:
https://lore.kernel.org/lkml/82045638-2b26-4682-9374-1c3e400a580a@intel.com/

Generally when feedback is provided it is good to check all places in series where
it is relevant. oh ... but looking ahead you ignored the feedback in the patch
it was given also :(

Reinette

