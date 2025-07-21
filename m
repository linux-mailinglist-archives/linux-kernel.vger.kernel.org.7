Return-Path: <linux-kernel+bounces-739991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0DB0CE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200101AA0879
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72424503B;
	Mon, 21 Jul 2025 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qw5u3TVT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452A1D63E8;
	Mon, 21 Jul 2025 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141036; cv=fail; b=Pq9wrS/BKJ7ZmP9OqQs5Jpxw0p1eTeRgm4s3ariKQ7dy5hkQ+ASXgsaLvJDwh1Odnr0FcUuv4A6XrSJxtQBilFa1y0vpSKwOKmmrR1SJapEEOFQrZY/evpffY6v9wW76FQ/zIz1EuLmPoA83+WSe2odRyRwfLmaM3KZ+ChR1NTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141036; c=relaxed/simple;
	bh=J5+pM6Ee6RFUePnzNJoQErBfZArblEEm2T6KMzCuRAg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eJS8UdRAolIS+so/kaPthdIUojxT83HePmVGj4uswcnxjUSGZhFNQLkfY0lAl+bHJi1XUYrAj0ZcPsoSRMqDr3bJGPE3RfFnXQdNqUoDpEddA5HbmU5PCnvYpOS39vj0manF63Ayq83OqC1zmnVaIr4YkHPXa7OO93urqz++0J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qw5u3TVT; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753141034; x=1784677034;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J5+pM6Ee6RFUePnzNJoQErBfZArblEEm2T6KMzCuRAg=;
  b=Qw5u3TVTfYNco1gMEmSAcZ4hx7zGkKtIPpycyo2H3O6sNs98lWeg7pD8
   Khi1rbRffacn9VXiyVFZCLn+i+aJs+5esMh707QT1qNoUDEn2Qz4Dc7NL
   HZ3z5e1scawtpPjX4RZmCSEvDE3bcd4L8akRnfGWig3NvOsZgl4AKsoWB
   klAvUfyaQJqTTKCTNGBS14aZnJ0YLtTYj0Y7nYkerDvR4bwfb6pCWlJlN
   cq37+AhtbxvfGCX26oiBdYf91tLaNQTDZbdbbLCXQyzvjhi/BV5WevhN1
   2Rn4rZBZCtJMxePMo5IJqspc6KSJ4kjMUgt7+xLT/9MRmckWH5ljM1zPP
   Q==;
X-CSE-ConnectionGUID: mQoGAp7vQO+dtO/iwjsL+A==
X-CSE-MsgGUID: NtMeUlffTBS9NKPIsBxZLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59034111"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="59034111"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:37:14 -0700
X-CSE-ConnectionGUID: Z+vjqNcbSaeJES3IzHvJfw==
X-CSE-MsgGUID: hc2m3ZDDR6qEu7Tft5OEtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="164637809"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:37:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:37:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:37:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:37:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwhkQoC7XX0zt82W4HZDZAHy5W6ddABmC6x3yZpA21ICobINLPoZ+R4e5CA+P7uDtl1RZFFRnCPR0lQZ08KCXz+qxZVYats4LKyQFrlIsIaoJmvCGVYhhuRDsj0XJX8u7AyaA7db1+WZEFVLk/kTBZ/5Hnuvl+BpefaXo9sVDBC4x/2RKQlSUpUfhzRV2h/EQ7V55F0P5sNo+Dk7SBcl4vcGTgNVM532eqnPdWZ3aTDekZLHkQ37bMt9/PfuUq2fn7BFJ089mDc35qGOOHXRTuEG2kTAhC60BjrKfa54Yyig69ZaDk2q6r+ZSmdj75hsad53H1+uoIFBNK6ija5cIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU14UufuEot2+Copk4of8Gyz4J/J+B4AQ2R2pq827ls=;
 b=a/CKha84eHuBX1ugqOcp50lucjed/Y8zzwrVXirMO31xKNAq1LVL4sgK43Jl3U8D3WNM67n8Rhr+7R1d4yy8EkEwaVPWLrfj1/vOfTmmU87JYdNVXWbalYGvaGD+1HydX5XKvE8D+uyJkpss6tSpOK/ydcrQp3frSl7D5u6kHZFqL6t9ahL9tX4NmD4yaNRKF0N/+FfKFy6+ocAl2VPPkX+1E0BQTSgMNO3ht+6h9GbLMUraeeJ9sM3zQ/UjCMuIqrutOW9jwtOxT9RfFe47G5zqVS2amsr5o5iOH5LE7335b/TbUaTbYUhJsC1+rTVaEBH5o503c2esanPAXGuL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:36:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:36:52 +0000
Message-ID: <ccff50fc-c802-4352-9859-107138f103c8@intel.com>
Date: Mon, 21 Jul 2025 16:36:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] fs/resctrl: Introduce interface to display
 "io_alloc" support
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
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1752167718.git.babu.moger@amd.com>
 <4e275fadf59e36e38ac60406a19cdf67d640f7d2.1752167718.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4e275fadf59e36e38ac60406a19cdf67d640f7d2.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0377.namprd04.prod.outlook.com
 (2603:10b6:303:81::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c95dfc9-87e2-42da-345f-08ddc8af786d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGtLTWI0YzZ3eURvdlRIMC9lWDRFRElSell5VG9qWDNRKy9oZXpyK1JwUEF4?=
 =?utf-8?B?dVk4QzQrRGppTERkOVdMRDJVQ3YyUTBjQzBMN2Mwb25QdXFWTmwvUWdZYlNy?=
 =?utf-8?B?NkViRngvbGlFMTh1cGYwemJpalEyQStnTGlZQlN2Vmsvd21KbysrSnk1K002?=
 =?utf-8?B?NENPWnZnUmwvQWczK3d5TU1ieUswK1lrWWwwOHU3OTA1Z3FFOS9JVllSZ1B6?=
 =?utf-8?B?QVFaSnpSM2NjTXNublNIVG83QVcvcnJzeGRST0dsWXg4eDRpekFjQjFGZ3k1?=
 =?utf-8?B?QVdGTUFuSDZOVDJXQnIzaDdHQTh6bm5hcmRsdWUrU01yNDlSV25OWGRndDVs?=
 =?utf-8?B?SFVmVWJwM2NjZmRtdWZReXo2VWJWVGFVbFU1QlpjVnpQVmdPMlN3WFlTSXFJ?=
 =?utf-8?B?MkV4NUpnYnNBbDdzY3lmVWVSa3BsanBuajMvaG1MalR2UCt0NE9xM0xUVEhK?=
 =?utf-8?B?YXhzWTlXVjh1Q1h1Y2tkbzk1bUN3Z1VkOWFHTmRUZFNuQVViUmJWOGlpWWJ6?=
 =?utf-8?B?N0EvTHp4VUhYRHJMazF4d21xaEIzYzljMytYbWJENVVzQ0kvWndyOHBQbHlh?=
 =?utf-8?B?V2pmS004ZGFqU1hBWkh3akFmWVdKZ3FGUUx6eGNyNmphSnZWYWQ2QnpFaGMr?=
 =?utf-8?B?WEIvSzZjaG0rYWFoaEdvWWdLbGhqNWw4aFQrUzN0TDFyZHZlQ2pXZ0lTb0Jz?=
 =?utf-8?B?ZXlPcG1mbE1JL1RkSzcyQUdleUxPTStaRjJXVGg5Qm5nQlM0bVVaMDFHTjhL?=
 =?utf-8?B?UHoyYTZjWVptRHBoUEpGVFpLSFhpdk1rZ1NMcjdWWGdVTDJFR0h0c2RCV3l3?=
 =?utf-8?B?Q2R6SzZEK2JsZllRL0pQSG1TSFI2Yklrb29PbUh1L2VUVWlUVVNXWXJqd1lO?=
 =?utf-8?B?RnZhamJqSDVFa0paWExFM2poSUEwTWlDOVhpY1NNd1NVbUk3NEJaS0pzd1hz?=
 =?utf-8?B?VEcvYkxzZzBFaGEvMkdERXlpdU5LY2FITndRRk5mMlNBQWN4Qkl3cjk4NElX?=
 =?utf-8?B?OEFrUzFVUXIxemdFSWxuTmRnZmhXTytaaTJXTkp2QXNHOG5Od25kTFhOaUlR?=
 =?utf-8?B?RThMTTNnQkZGck42dGMxYnMrczg0MHVzUGNKc3RJRDVpYm1DY2NhZS9ITFZG?=
 =?utf-8?B?VVZXMlF1czRoengweURySU90VFFVYzZyU1JtQ0VlVVVoaG1HZThNcjZOZGM4?=
 =?utf-8?B?OFlmaFBsS1BRa3lVUmZYa1RLZXBiTXVsdTV1OHNwQ3llR3VrY05oVlVENEFt?=
 =?utf-8?B?bGRSR1QvdU1aMmNLTjVudVBWUXFEaFQrek4vMTVhdjNxNW5PVWZ6bVBDMDhp?=
 =?utf-8?B?VlZPMGRST0E3N1RuVEptOUxyNXIzblQ5VGo5YjJqb0M0VldoUzBNb3ZnL1dL?=
 =?utf-8?B?VXh3cGdMc2FXTm9IWUlDSXNBeTEyRUZ3MmQ5YkZUWlFvTzkva290R2x1dUJZ?=
 =?utf-8?B?WU55NzgxRStTem9FYk5qNG9QUlpwc3Rnc3FGdndOM0JMT1UwbVVraEsxTmJZ?=
 =?utf-8?B?RlRDTTZybW14Kzh1a1RmVjEzcW5PVzYwUWJDVGdkK3FiTEFZSTVQTURicTYz?=
 =?utf-8?B?ZUZtRUtSNFZpanJRREdwTTJWS2E3dXExeU51bDE3Qnhmd0VrYTBBZFVHK2JZ?=
 =?utf-8?B?UlM2aEdMdkVVbk5EUnpNSVlBNHRWZVBiZTBkbWl3a1d5bGlCZjF2aGpHNjIz?=
 =?utf-8?B?R1pWaWp3ZjFlb1J4YVhNWjZObkZyL2JZbDlpQVV3ZElyYmJHY29LNHM1NlNF?=
 =?utf-8?B?blcrdnVyd0pIckRtdXEzOFBuUlBhenN0OWlvSUU3ajVZN2FNL0JBRDBkRnNn?=
 =?utf-8?B?WWVFODczMUs0QXN0aFJQVHJ0K29QRE9VWXNGMWdpalBMdU03aGUzS2xtb3hV?=
 =?utf-8?B?YTVHaDFBeENxOEppRm1VTFp4c3hvOHRxa2duM3RFVENaWDEwcXNaaE1zSGJi?=
 =?utf-8?Q?Vfgo2i9mIw4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNDOFJvZEhydnNoZnRGeUJqOEFnR0FCWTRPKzRyZ3NLMGErZ3NMTUM4NW1J?=
 =?utf-8?B?UHQybnVWL2d2NE5iVVBkckRqSGNEMjVHWTh3YW5mRTMrYTQ4TlJic1R2TWF6?=
 =?utf-8?B?a09DYWVoYThUVGFQbkxsMUF5QTlBWEp2dERPYVk3RWNMZEpEK0JPcEI0ZVIv?=
 =?utf-8?B?U1dDS3E1eFUvdWRnQnhsRit0YUNpc3hjTFBNVjVkVDNXSFNiV3ZnQzh5M0Qr?=
 =?utf-8?B?ZGxzUmljdGNucUlYVjN3RVdjV2theG13aEJoeHFqdzJBeTl2RFN1VUVvT1FL?=
 =?utf-8?B?U3c5Z3dsSm5Fa2VXT0RUZDZPTFRwYzkvdTFtWk5wendVd1pYR0hYaG5USVpo?=
 =?utf-8?B?dFpkdFNPeXJKN1lGRXgxV3VsZ1JueWs2SnZ6djR5ZVM0UWVIOUVQeGNyR281?=
 =?utf-8?B?QkE3aWxBS0lSZE83b0FPSmZZcEdrZ2p1T2dMT1hqWERZK1VMclRIOEhmRFZ1?=
 =?utf-8?B?SlpQNncvU0xma1BzUUpDQ1RkeVE0STVBRnZiMWl2eFRuRmRmUHdDWHV1QWF3?=
 =?utf-8?B?cFpGaEMvTVRPR3A0cjNidmZPcWF0eDBBNU9oSlJKQS9lR2IvbHhkekdQc0xa?=
 =?utf-8?B?RkNwWjNCb2FHQlplc2RnQzJzQjNOK0pqMzNtUVVBd2U2dmtvcjVjYVRWdGps?=
 =?utf-8?B?ZjBXS2pscHBaTlpscnp3K1BFYUVXUDVWODJCc0pWdlpQSjFPaVJhaEN4MjFJ?=
 =?utf-8?B?UnAzejdXYmcvMGZFTWcxZ3E2b0RWcWl5Y3BlNE94clljN0lwSFh5NXNEK2tx?=
 =?utf-8?B?dEpmZm5CK0tTVmtHQzI5eDBkYk5kOFVMc2YydEw5bXZBS2VjUVBOV0VZL2Yw?=
 =?utf-8?B?cnhNYzVNMnF5eERleTNmbExkRm1HaGhsOEdRbEQ1MkttREdqQzd0bzVZcktL?=
 =?utf-8?B?M3ZTVFVyaDNoMjJjV25rRDRFTU9WNGYzQ0NNQnBhSW9UeWRBQkM4eTdMQkE4?=
 =?utf-8?B?cWxTZi82anlJVXZSWnN0Y2JmY05SSm1ZZTlsQ05NYnlqZXdldUZEZHFac2d1?=
 =?utf-8?B?VnRIdG5RRjJzTHh5b2ZQQnBhUm9wSUwySWhicEFvc05CSmJLSU9iUk1VNkNQ?=
 =?utf-8?B?a2lWSWxhUmpmRFhuRDk1a25LNWtPYXNOVGNXM2hsNENIVTVGVDlyN20xcjRt?=
 =?utf-8?B?c0NxVk5aKzhmRkVGV2FDRlZwVU5qblF3QVQ3K2E5ZVpyS3dIamozN1ZtdGVi?=
 =?utf-8?B?TzZkazA2Q2Ixb0VmMXAyb0ZGSWdDeFNHdTF2NHRzbXlHRzV1QkVNWXg4SFB2?=
 =?utf-8?B?djhibGk5elFvSWJvNGhZZDVWSFJEVnpBUHpZOEVINW5nZGNzbTdKWks4bkJH?=
 =?utf-8?B?Z2tPNVFqdThOTFNuVDYwMGNrc3R5WVBacnU5WThqY1AvaTJySHBuUm5OTG5N?=
 =?utf-8?B?eENQbFYzcGtrTmNBbXcwYmgxSGdyU3BJdDNoZHB1WWJNVkp2Sm04VTdtRCs5?=
 =?utf-8?B?RGJzNXJYclliNlpKTldDVy9ud0tOd2NraXNGbWZFSDB4aHYrM2dSaUZPekRj?=
 =?utf-8?B?MzNuL013N2V1d3FibnU4ZW5vby9rOVhkYjBvU0ZRZVhkTWM5aWVIWmoyZXpQ?=
 =?utf-8?B?cDhmTndCcW5nVFgxYnZUQzlzT1oxK0pMTERzZWxiUklhNzlKQ2VUekpka1o5?=
 =?utf-8?B?ZUI5Z2xRS0ptY1V1TEtwQnQ3c1dHcWw2RmJUNEVjMTlNR1VxeXp2NjA0THVa?=
 =?utf-8?B?SE0wUUNSdmxycG8xT1cvNk8xa3cyZk4xL0VON0E2QnBIV2dGTlAvbjRwU0t6?=
 =?utf-8?B?SUlmQUNuMnFydnBGYXBHbUZjZ0xBQUVhTWNzT20ybTRFbmUvNFRPbDFSTTZG?=
 =?utf-8?B?TUIvUXM5Ly9pekFraEtHK3g1SnBvM2FLNlN4TFJ3STlBemwvWGpTdGRvZUV4?=
 =?utf-8?B?ZnFpemF1ckZIeFRSZVoyMjQ2RE9HMGNlMmxsR2ljTG5kTXl5Rm9UaHFKcjRG?=
 =?utf-8?B?ZXIyOVM0NW1CKzB2SStTMm44ZDcrQm50QnR3L2Raa2ZwNzAxM2NiTnhBRGdM?=
 =?utf-8?B?elRUMzRocnZGWDVUNUxUYk1mRFN1WFcvMmhoVmF2RVpyck9va1RwVFdqbTdB?=
 =?utf-8?B?Z2wrYW9qS1pNbVdBTklzTDVyT3VhV2NId2NZMXExTmpFSEtEb21HV0JGWmhp?=
 =?utf-8?B?Mm1NRkt5Q0VPZTYrdHhQelpSU1c3RGlYY01zd2pGVGIzcWRITExXMlNHRFZX?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c95dfc9-87e2-42da-345f-08ddc8af786d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:36:52.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLE2rci9u3gCF0dd8MFuZ0GpIG/dZf35ZpYiX9q7xXdXFnk3AhLkSD8Lj+mSgVWP9yz0tyx0+1YVdjBMkUmbTl5YR87+3GGCc6+PD9qPDZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> "io_alloc" feature in resctrl allows direct insertion of data from I/O
> devices into the cache.
> 
> Introduce the 'io_alloc' resctrl file to indicate the support for the
> feature.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst | 25 +++++++++++++++++
>  fs/resctrl/rdtgroup.c                 | 39 +++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index c3c412733632..354e6a00fa45 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -143,6 +143,31 @@ related to allocation:
>  			"1":
>  			      Non-contiguous 1s value in CBM is supported.
>  
> +"io_alloc":
> +		"io_alloc" enables system software to configure the portion of
> +		the cache allocated for I/O traffic. File may only exist if the
> +		system supports this feature on some of its cache resources.
> +
> +			"disabled":
> +			      Portions of cache used for allocation of I/O traffic
> +			      cannot be configured.
> +			"enabled":
> +			      Portions of cache used for allocation of I/O traffic
> +			      can be configured using "io_alloc_cbm".
> +			"not supported":
> +			      Support not available on the system.

"Support not available on the system." -> "Support not available for this resource."?

> +
> +		The underlying implementation may reduce resources available to
> +		general (CPU) cache allocation. See architecture specific notes
> +		below. Depending on usage requirements the feature can be enabled
> +		or disabled:

"disabled:" -> "disabled."?

> +
> +		On AMD systems, the io_alloc feature is supported by the L3 Smart
> +		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
> +		io_alloc is determined by the highest CLOSID supported by the resource.

"is determined by the" -> "is the"?

To make clear connection with previous paragraph you can append something like:
	When io_alloc is enabled on an AMD system the highest CLOSID is dedicated to
	io_alloc and no longer available for general (CPU) cache allocation.

> +		When CDP is enabled, io_alloc routes I/O traffic using the highest
> +		CLOSID allocated for the instruction cache (L3CODE).

To clear up what happens with L3DATA, what do you think of appending something like:
		, making this CLOSID no longer available for general (CPU) cache
		allocation for both the L3CODE and L3DATA resources.

> +
>  Memory bandwidth(MB) subdirectory contains the following files
>  with respect to allocation:
>  
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index a2eea85aecc8..d7c4417b4516 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1836,6 +1836,28 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>  	return ret ?: nbytes;
>  }
>  
> +static int resctrl_io_alloc_show(struct kernfs_open_file *of,

Please move to ctrlmondata.c


> +				 struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
> +	struct rdt_resource *r = s->res;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (r->cache.io_alloc_capable) {
> +		if (resctrl_arch_get_io_alloc_enabled(r))
> +			seq_puts(seq, "enabled\n");
> +		else
> +			seq_puts(seq, "disabled\n");
> +	} else {
> +		seq_puts(seq, "not supported\n");
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return 0;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1926,6 +1948,12 @@ static struct rftype res_common_files[] = {
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= rdt_thread_throttle_mode_show,
>  	},
> +	{
> +		.name		= "io_alloc",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= resctrl_io_alloc_show,
> +	},
>  	{
>  		.name		= "max_threshold_occupancy",
>  		.mode		= 0644,
> @@ -2095,6 +2123,15 @@ static void thread_throttle_mode_init(void)
>  				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
>  }
>  
> +static void io_alloc_init(void)

This function's comment can benefit from a snippet that highlights that
even though this operates on hardcoded L3 resource it results in this file
being visible for *all* cache resources (eg. L2 cache also), whether they
support io_alloc or not.

> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +
> +	if (r->cache.io_alloc_capable)
> +		resctrl_file_fflags_init("io_alloc", RFTYPE_CTRL_INFO |
> +					 RFTYPE_RES_CACHE);
> +}
> +
>  void resctrl_file_fflags_init(const char *config, unsigned long fflags)
>  {
>  	struct rftype *rft;
> @@ -4282,6 +4319,8 @@ int resctrl_init(void)
>  
>  	thread_throttle_mode_init();
>  
> +	io_alloc_init();
> +
>  	ret = resctrl_mon_resource_init();
>  	if (ret)
>  		return ret;

Reinette

