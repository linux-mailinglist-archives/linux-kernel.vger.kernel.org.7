Return-Path: <linux-kernel+bounces-751291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA062B16751
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEAF1764C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524AA1FFC59;
	Wed, 30 Jul 2025 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m96rEDCt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23301EEA40;
	Wed, 30 Jul 2025 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905830; cv=fail; b=VNPpAPAHmVNxZbqUSTDCD510Yra2/D0jxr4aEUUZB6YjM2NiRQbgqJWNrygi+5AYeD3LErvl8cu9dXY5zjlFUuhIdZmgfH/+fuInL8BSKngLxwAR35p0q/1B2XOVwI8pPk5hkhdguaC36Bg1z/NKpiFdJVPBvlsJV6awf5B/6b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905830; c=relaxed/simple;
	bh=sR25qLBqCfKZtId7RsQYQ8JN4Cim9oRuNRd4CjE/StM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SGP7adlO1iSMeL0tk9ecBohJ7iTCMB6o5FVO6F7TN+f14UxRswUZPvxPynrVoDLhI9x2BSu35YssCh0Yeb2m6iOUtRp5gvw6Dha1B0Ui9fMbMkp70CbX5YFb1LaFUZhd0Les+M+mYBPXzdG4/KdRxkHRp4yGPvmd7j/yonk83Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m96rEDCt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905828; x=1785441828;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sR25qLBqCfKZtId7RsQYQ8JN4Cim9oRuNRd4CjE/StM=;
  b=m96rEDCtSNl+LXLn/xcwqV8vuyAk0IJ6G+PPKMb1t14aWRxYdOS4DMaF
   CiS97gH+ATB5dIRKU0R33gxPhXzjJGg6pruXdeis3Pk+1cUYK2+nMc2hw
   qXaYc/7mYak02d2lXGqaLERTDcTYHG/yXe9Caf40V3WcfEQuXydKVJyIb
   IddpVj+4KJuA7LMBgstdZT66FN6sIR+02OyBXTN9fUKDUfc71yG6HsNbB
   u2GNl7/NT+dqvIVaPS8UJkLpkP9ZSC0kNj5MDIErARHMXIlawCkkNm1Jh
   X2nV3oDPentqTeTa4PNUwhjEiWqAAuyRycf6bmBcqCrU2OoQ7fLE1Crhu
   g==;
X-CSE-ConnectionGUID: a1XmgdTbTDm5X52mfC4DGg==
X-CSE-MsgGUID: RUBjE3bjTymc7f97t8SJsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73808871"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73808871"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:03:27 -0700
X-CSE-ConnectionGUID: JN92zrM3RHqCbNOuzWpNnw==
X-CSE-MsgGUID: 1MCF93EHRsW7vZEGU1uuxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162957439"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:03:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:03:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:03:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.83) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:03:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkpu47PmCLSVO+9Is1KQOuY3WjkO8Px5vBFfjbb1NBG8YJBdabA9+22anmBzX9wLjyw1Ei9P3Nsh7uuhT1+IZ3BAl6+9dV0qFEPAYcfnkWeQNSL/fB2JqdteUgiw46fPInn5J4vK7xgaoTB9Ds+RAwvFd+WxwPi7Eb3ZjTwk6+qSDkmZOuCW6U3S7VX4LlTKN2Tc2FVboONTvrOU9aBw69qDwxI/WWU1T3I9kITnqzszZXAm8Fu3LnSAJoYdZQcOZcAA7hua0si2ZH18TUzYL03FkpOSLL4TihOOFyd/G/o+xptmOlI9p0apBuBED+rDcUh0Ev7qAGYM6ItZ5oS3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/J3VMQ2Q/bYcu0STL6zXoNaZ5mCAcCQ4sSI0F5UFuk=;
 b=UA9K1J7xbJzekALTJ13raTGiXDuwlTzTr7pb0IJSu3Ecy307d9MPkGeCZ5+BbQuprFkenImZX5GCulyBK0vBc1yPMcuzEERugrX7jY//4SAlxHek4HGm9N0HXwmAW47XH6A5rg3AGG7jEbcpmZ/nrKmIK4aaifzn+3sT0PE+/GAsGino9GhbV2/p9Ivhy9Vhsd8uM9Z6tlymgT0/qXEOmP4FIekfcZ1oL5TjPe3erF8q0WKkzfXb+0EIX0k57Gzc3xmGoe9vwoy9ILRlZ2aeE6PaUh2opgsEq8st1P/RkqutE4yzXuBUUaG2Y7NkeLihxOPwAibSodMxnrrVCPY5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8582.namprd11.prod.outlook.com (2603:10b6:408:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 30 Jul
 2025 20:03:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:03:21 +0000
Message-ID: <26db5cff-dc25-417e-bac2-e05584e8f987@intel.com>
Date: Wed, 30 Jul 2025 13:03:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 23/34] fs/resctrl: Support counter read/reset with
 mbm_event assignment mode
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1753467772.git.babu.moger@amd.com>
 <dea9cd70b311b6a7e1eb85b1e6087c701bcb488e.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <dea9cd70b311b6a7e1eb85b1e6087c701bcb488e.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:303:8f::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c0636a-bb7d-45a7-e29e-08ddcfa4220d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDFXejRYNTgxbXlSeUd1RmdTdGFFbEsrUnNoVklQVGptd29iRHdRaDFWcjli?=
 =?utf-8?B?STFUOUJWUG9mK1NZckxvNFBQbzVXSUpveE55Yk5lZWpGaEVLVUZybWVJRVZQ?=
 =?utf-8?B?eGlwUVNaQ3owWjJHOFFseXpTUDQ4b2xnMURTR2xxeHZUTVdnVWxwQjI3TytC?=
 =?utf-8?B?VS83c3VMY0kzSnJ3eGh5QkVJUXlpelJjZHl0d1FZTmJsMlFmSFU2S2M1UExG?=
 =?utf-8?B?RWR1K0tHVDU1R0hDMjg3WWR0MDVzcVNvd25OVitjVUFpMmJEYlYyLyt4OXZR?=
 =?utf-8?B?ZmF1eHhNK0sxck9iSlhIc1Blbkkrb1Jla0J1UUVEYXlZSlZpdmpKMkp4VStk?=
 =?utf-8?B?ZlZxVjhJUXB3TzZCdGt1ZnE4S0g5eURERDc1eFlkZ1BmdXR2MVBOV2d5bXJS?=
 =?utf-8?B?Z3piMis4RVNxQjExUjFZaVRpZHZpRVFqVkdSVWtzaUw1QTMrZ0kzbjdMaWJS?=
 =?utf-8?B?bU9YcWdkVDJEcHRPZG9FejRMN3lmRzFjNHN3eS8zbWFGM0ZNdWNNM3R1TnQr?=
 =?utf-8?B?ZElBY25PZEQvd0FzcXFzdXVveUMwYm5wNmxtUHI1VXdybkREZUJlREpHRytM?=
 =?utf-8?B?NW5kRkU3RWNIK0kvdllZalBLUitmWmRmNldlQWhHS2hFNFJuMWF3K0ZlUzFQ?=
 =?utf-8?B?MFdES1I2TkpHaGpPakV1WmM0dDBPZnhXRDNZekxjbXNVa1dnSFNoN1dZVi9H?=
 =?utf-8?B?a1U3KzhobWViOVduT3NRdXg3NjdEMFgvWkdpczdEQmNGQ0ZERlFxeEx4TVJV?=
 =?utf-8?B?KzlWV1RzaUxtVnU3NFg4ay92MElnNTNVNWhYdC9yK0QxTmo2akZlR3B6Z01Z?=
 =?utf-8?B?Ty9uMmIzRXpWUVRVQitLa1JneHFZMTc1WS9pY3d6UVpTaVVNcS9KMUloa244?=
 =?utf-8?B?V3lxeFpyZ3BhSWdaNjhYTWQrM05yeVVCbE56YmJJaG1XeUhjY3dxK3BzQ0pM?=
 =?utf-8?B?RjM5ZDlRcDdKODMyMGVrQ0k0aURXajBQbHBoYXJZc0ZNM3NLbjRrSzQ0cklo?=
 =?utf-8?B?enJiMndiYkxaVXZzbnI4dGp5VS9vMSsrK1dCR0VIREIvdllJclJad1E1OTZT?=
 =?utf-8?B?Y0M3bDVsbWdkL1RPMFdmaHJha1J1OG9ic3k5dG85K3FsWUg1a0IrcGpScXlH?=
 =?utf-8?B?MjVMRjJ6SlRDN3BCbE1PaytEOCtwcEJKdFRuc1V4QWJBK21kZW14NEdQMUVQ?=
 =?utf-8?B?QU1QWWszRWsrUXZGN2hDWFNrbm5Nb2M3ZGMyK3hCMGVyK0dTMUxKeklqazJD?=
 =?utf-8?B?aUZkendGcHhaTUVYRkVoc291Yk5iQlFWM2FabVM5cjVEVlhDc2crWURCRFlK?=
 =?utf-8?B?dFNYTWN6ZHBuZ2RCUWUzV3haUkY5aWVUaXo0Q1E2SVJXeXB4RzRsR0JYUFJZ?=
 =?utf-8?B?V090Mmpid2hRS2djTFRHSk9FZ3JEYXNMVTNKMnI3cEw5ck9hRy9wZmJmc1Ja?=
 =?utf-8?B?MWFmRlNtTzNSWFprbllXa0JlRFpIZThqaG1taTJHTllWVk9RSFRhanNiUjVQ?=
 =?utf-8?B?VjBuYW41eWU2amozbW5veEU1d3B5UUJkYThDSDk0d013bGlFL3YzT2V0UTFN?=
 =?utf-8?B?WTg1aCs5WjhpbjFVWDU5dTVJVmFMNHF0OG9US1AxczJyOWlVZStKclpVc3lZ?=
 =?utf-8?B?QzlFSjBxTnpGeE1rU09wY2lGRnB5VVBYckNrWitTYTRSR053ajJQeXNJUE91?=
 =?utf-8?B?SnZqWXR2V0RjelFrMUxqNGdHY1p3UTIvOVZIZW54cXo5QUxYb05iZTZzWEMw?=
 =?utf-8?B?TEF4aWt6NytNNUp4Q1NJYWl4TlZxMkpmQmsrT0llM3M2NDVrcmFPbkJjNVpp?=
 =?utf-8?B?dmx2N1ZLK2psVVR0U2JCS3RmbHJrc1IyWVQ4Q3lINkM5NXMwMzNaK2hkbysr?=
 =?utf-8?B?dlIrcVV4N0hMTXJ4Z1Q1MDhyTXJLc2ZaR2I0SjJBcGp2bDFHeUZPTU85OE5G?=
 =?utf-8?Q?9wetebGed1o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkhJU3VUelovWERDL29jN0QzRFMvZnc5U0RLQmxnc3o4S0ZVenRHRzBqWGxW?=
 =?utf-8?B?SHlqOWk0b3U0YUtYazl2WE9qeGNiS3ZYUytDNWE5R0lxMlgvY1pidjlkOXFV?=
 =?utf-8?B?dDdoYmkvTnNlNlRYWkdLcU9WdDN1cXRpOU9RTnRnL1pZOFk4VWsxQ3JxVlU5?=
 =?utf-8?B?NW9IZjgzOUlqdzR0dGhqd3ViMUdOeUtNYXVyS3NQNjhxeERGc0JleUxiczdi?=
 =?utf-8?B?ak9DQkxWN2pCbEpIR0RIenVweEsxVm9nNXZlRWZ2Zm5KQXVwcUNYb3grSWE0?=
 =?utf-8?B?RFNLcitHTGxhVWVLekRDZkZtQWNrT3ZoK0R1Ti9rVmtXS3h4ZmNoeGlBcnoz?=
 =?utf-8?B?TXNDQ1FxNk1HSEZXQ1V1YjFKdGlCU3E5L25zdXRJVVJxM1JYN0ROV05pT3lF?=
 =?utf-8?B?VHV6UlNEZ0pQYnB2SEFIUWlPTzZiNUlYdU9OVzM3VlEwU3RsTk5raXVJcnhw?=
 =?utf-8?B?RFlNYXpjVVp1dUlXbGM5NERFYTJQbVRRNTNaNXRvL2M5VktsNEJaSklla3NG?=
 =?utf-8?B?NmhsbVFBRWNHSmY3OTdVVnpLQ0dtTUZqeC80TVhkVjdkMWZ6VmRjNW1FRW05?=
 =?utf-8?B?TllHek9oTnZ4Qk52blB6ZW1uQ0pLaDd5bU9vTXNkS0ljOFFiSkQxYkxyZU10?=
 =?utf-8?B?ZHBVeVFaRzhvejlQNjVRSjJ6OEJhWG1pTEE5SllnaU9oRm55MGdtUUhoY2lO?=
 =?utf-8?B?RWFJRGlhMUxQQTY5VGlJbzFsSWIyTlZkVUZRZDBwVlFadjBaZGxETHZMcS9t?=
 =?utf-8?B?L3lVakpSUGxYd29YKzJjaTVLblVGQS9aSG84ZCtDYzJvRFhjdlA1VTdnK3FX?=
 =?utf-8?B?ZXRoM29HVXgzeTZOV29BS2IrUDhDNkt5a0tybG9OY1IxRTYrTlBUa3c2N295?=
 =?utf-8?B?WmcxMkRTUTFKUlFHVkUxOVQyTmQ2ZEF2RTF3RExEb0dWb2E3R01teS9yeTNG?=
 =?utf-8?B?bUgzZHlyK3dWMDdFOWRQVjBmNmpGeWU0ZDIyZ0pDWGZQTml4ckpEcWNlVHht?=
 =?utf-8?B?akMvZXFIMnFmVzBUaGNDdTdudk5aUld3bzJETVU3RHB5eG5GaXROa0ZyLzJV?=
 =?utf-8?B?ZURzd2JkZ2kyOUhIMWpZZmxUd2xxTytjamViU09BRm9HeVhNaDlEdnIybDZz?=
 =?utf-8?B?SGtZZWdjMTYwTFJTcWhyS3hYY2pGNHdPd1JVa2VhclAzU2xvWFAwaVhwcVc2?=
 =?utf-8?B?REljczE3blFrcVEyOG01VDErR1BJQStSVmx2RUM2VFcvbnJNemwzWWdPNDB0?=
 =?utf-8?B?cW0weGZMaEFqNXBEZDloQWwwUG5qT0dlTzlPdTNKcnZGMHEvL0tRK0RDdThF?=
 =?utf-8?B?b0dLSDJsWHRtcCs5Z0MxQkhHOUxGUDJmRVIwcUp4YmNhc3B0aHVsOTE5cjBR?=
 =?utf-8?B?S21DcVJGUHo2U1ZlOTd6VEE3cndwWkN4YkkzUlltV1gxQ3FIQTRkRmc2UTE4?=
 =?utf-8?B?VlRBTTRud2NVMDhKWHoxd1gyQytYWWdiYjJQK0RJUHVvRnBsazlnMnFtT2lF?=
 =?utf-8?B?UU5jS295YnNFbG9zVWlLSzFxOVA1UUJKaXVpU0R1SXkzdEhjL0l4YVdFVFhE?=
 =?utf-8?B?bGh1RkRLTUlPZG5CWWR0dXdNTlRXS0xjZWQ0SlBWaEwxWFpCWlljSlpWU2pJ?=
 =?utf-8?B?UDUvOTZZVUtXcitGS3RnTlR6L01ZUVpDVUY4NDJ4dXNNb3VlRkJLQ1FiMGpr?=
 =?utf-8?B?R3ZRekVIQUdhcFJtdXNRTXdzN0duZXpJL2NQWHFxVHdFYUtwdjhxd0RTVlhu?=
 =?utf-8?B?VEZCYVZqYTkrR3Z1ZXIzWkdlMXNCbXRCckRSVWpjbDFFOGh2b04vZktsZXdT?=
 =?utf-8?B?WXl5VmZhcVlIeWxNaG0reUp3Zmc1REw3VVUwV3BLalVYT2pITENVTVlRK1ln?=
 =?utf-8?B?N1VPUmViYnVzSVJvWW5WS0RwQm4xTkpPYjB0dUhkb3dSTVZSeVA3UFhiUDB0?=
 =?utf-8?B?NkpjL1hseVJGeUdYMUU4aWV6RTZUUVRNVXNHVjVyYmNSdFM4TjEvSmxDTzdG?=
 =?utf-8?B?T2FRNEFVdGlwRzllcXBvNHpMWEp3Y0FDbjd1QXZxSUNJaU9CNEtuOTdncjRj?=
 =?utf-8?B?cjdldEM0dlBpUjhHOVhqWGpIN1hSS2NPS2ZhMWViRHZ4UEUrL2syY1dwcHRl?=
 =?utf-8?B?MStyeW1kYy8rWnZMSExKOVpyOG94SkhkZGtJMEpXdXJ3SGhBejhmdzdEYkJN?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c0636a-bb7d-45a7-e29e-08ddcfa4220d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:03:21.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkRZzkHefrD2c2IIAPUPZNhGtVCDnFDfTEaPptjhYXKnBrorFJxqat/RGENahQbGvdqb5J6sSZ0T3cYXYvgwXEIKyDcjW4C11Av66LidCc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8582
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> When "mbm_event" counter assignment mode is enabled, the architecture
> requires a counter ID to read the event data.
> 
> Introduce an is_mbm_cntr field in struct rmid_read to indicate whether
> counter assignment mode is in use.
> 
> Update the logic to call resctrl_arch_cntr_read() and
> resctrl_arch_reset_cntr() when the assignment mode is active. Report
> 'Unassigned' in case the user attempts to read the event without assigning
> a hardware counter.
> 
> Declare mbm_cntr_get() in fs/resctrl/internal.h to make it accessible to
> other functions within fs/resctrl.

From what I can tell this is not needed by this patch. It is also a hint that
there may be some monitoring specific code outside of monitor.c. Looks like this
is done to support later patch #29 "fs/resctrl: Introduce mbm_L3_assignments to
list assignments in a group" where mbm_L3_assignments_show() should rather
be in monitor.c

> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
...

> ---
>  Documentation/filesystems/resctrl.rst |  6 ++++
>  fs/resctrl/ctrlmondata.c              | 22 +++++++++---
>  fs/resctrl/internal.h                 |  5 +++
>  fs/resctrl/monitor.c                  | 52 ++++++++++++++++++++-------
>  4 files changed, 67 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 446736dbd97f..4c24c5f3f4c1 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -434,6 +434,12 @@ When monitoring is enabled all MON groups will also contain:
>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>  	where "YY" is the node number.
>  
> +	When the 'mbm_event' counter assignment mode is enabled, reading
> +	an MBM event of a MON group returns 'Unassigned' if no hardware
> +	counter is assigned to it. For CTRL_MON groups, 'Unassigned' is
> +	returned if the MBM event does not have an assigned counter in the
> +	CTRL_MON group nor in any of its associated MON groups.
> +
>  "mon_hw_id":
>  	Available only with debug option. The identifier used by hardware
>  	for the monitor group. On x86 this is the RMID.
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index ad7ffc6acf13..31787ce6ec91 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -563,10 +563,15 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	rr->r = r;
>  	rr->d = d;
>  	rr->first = first;
> -	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
> -	if (IS_ERR(rr->arch_mon_ctx)) {
> -		rr->err = -EINVAL;
> -		return;
> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
> +	    resctrl_is_mbm_event(evtid)) {
> +		rr->is_mbm_cntr = true;
> +	} else {
> +		rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
> +		if (IS_ERR(rr->arch_mon_ctx)) {
> +			rr->err = -EINVAL;
> +			return;
> +		}
>  	}
>  
>  	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
> @@ -582,7 +587,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	else
>  		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
>  
> -	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
> +	if (rr->arch_mon_ctx)
> +		resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
>  }
>  
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> @@ -653,10 +659,16 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  
>  checkresult:
>  
> +	/*
> +	 * -ENOENT is a special case, set only when "mbm_event" counter assignment
> +	 * mode is enabled and no counter has been assigned.
> +	 */
>  	if (rr.err == -EIO)
>  		seq_puts(m, "Error\n");
>  	else if (rr.err == -EINVAL)
>  		seq_puts(m, "Unavailable\n");
> +	else if (rr.err == -ENOENT)
> +		seq_puts(m, "Unassigned\n");
>  	else
>  		seq_printf(m, "%llu\n", rr.val);
>  
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index 216588842444..eeee83a5067a 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -110,6 +110,8 @@ struct mon_data {
>   *	   domains in @r sharing L3 @ci.id
>   * @evtid: Which monitor event to read.
>   * @first: Initialize MBM counter when true.
> + * @is_mbm_cntr: Is the counter valid? true if "mbm_event" counter assignment mode is
> + *	   enabled and it is an MBM event.

Since a counter may not be assigned to event being read I do not believe that "Is the counter
valid?" is accurate and should rather be dropped. Rest of text looks accurate to me.  

>   * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when summing domains.
>   * @err:   Error encountered when reading counter.
>   * @val:   Returned value of event counter. If @rgrp is a parent resource group,
> @@ -124,6 +126,7 @@ struct rmid_read {
>  	struct rdt_mon_domain	*d;
>  	enum resctrl_event_id	evtid;
>  	bool			first;
> +	bool			is_mbm_cntr;
>  	unsigned int		ci_id;
>  	int			err;
>  	u64			val;
> @@ -391,6 +394,8 @@ int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp
>  			       struct mon_evt *mevt);
>  void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>  				  struct mon_evt *mevt);
> +int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
> +		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
>  

Not necessary? mbm_cntr_get() can remain internal to monitor.c

>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 070965d45770..a8b53b0ad0b7 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -362,13 +362,25 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>  	u32 closid = rdtgrp->closid;
>  	u32 rmid = rdtgrp->mon.rmid;
>  	struct rdt_mon_domain *d;
> +	int cntr_id = -ENOENT;
>  	struct cacheinfo *ci;
>  	struct mbm_state *m;
>  	int err, ret;
>  	u64 tval = 0;
>  
> +	if (rr->is_mbm_cntr) {
> +		cntr_id = mbm_cntr_get(rr->r, rr->d, rdtgrp, rr->evtid);
> +		if (cntr_id < 0) {
> +			rr->err = -ENOENT;
> +			return -EINVAL;
> +		}
> +	}
> +
>  	if (rr->first) {
> -		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
> +		if (rr->is_mbm_cntr)
> +			resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
> +		else
> +			resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
>  		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
>  		if (m)
>  			memset(m, 0, sizeof(struct mbm_state));
> @@ -379,8 +391,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>  		/* Reading a single domain, must be on a CPU in that domain. */
>  		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
>  			return -EINVAL;
> -		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
> -						 rr->evtid, &tval, rr->arch_mon_ctx);
> +		if (rr->is_mbm_cntr)
> +			rr->err = resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
> +							 rr->evtid, &tval);
> +		else
> +			rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
> +							 rr->evtid, &tval, rr->arch_mon_ctx);
>  		if (rr->err)
>  			return rr->err;
>  
> @@ -405,8 +421,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>  	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
>  		if (d->ci_id != rr->ci_id)
>  			continue;
> -		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
> -					     rr->evtid, &tval, rr->arch_mon_ctx);
> +		if (rr->is_mbm_cntr)
> +			err = resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
> +						     rr->evtid, &tval);
> +		else
> +			err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
> +						     rr->evtid, &tval, rr->arch_mon_ctx);
>  		if (!err) {
>  			rr->val += tval;
>  			ret = 0;
> @@ -613,11 +633,16 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
>  	rr.r = r;
>  	rr.d = d;
>  	rr.evtid = evtid;
> -	rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> -	if (IS_ERR(rr.arch_mon_ctx)) {
> -		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> -				    PTR_ERR(rr.arch_mon_ctx));
> -		return;
> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
> +	    resctrl_arch_mbm_cntr_assign_enabled(r)) {

Duplicate check?

> +		rr.is_mbm_cntr = true;
> +	} else {
> +		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (IS_ERR(rr.arch_mon_ctx)) {
> +			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> +					    PTR_ERR(rr.arch_mon_ctx));
> +			return;
> +		}
>  	}
>  
>  	__mon_event_count(rdtgrp, &rr);
> @@ -629,7 +654,8 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
>  	if (is_mba_sc(NULL))
>  		mbm_bw_count(rdtgrp, &rr);
>  
> -	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
> +	if (rr.arch_mon_ctx)
> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
>  }
>  
>  static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
> @@ -983,8 +1009,8 @@ static void rdtgroup_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *
>   * Return:
>   * Valid counter ID on success, or -ENOENT on failure.
>   */
> -static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
> -			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
> +int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
> +		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
>  {
>  	int cntr_id;
>  

Not necessary?

Reinette

