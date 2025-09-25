Return-Path: <linux-kernel+bounces-833358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D381BA1C48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E6894E1ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C85C27381C;
	Thu, 25 Sep 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vq/Mt3Bt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7F2B9BA;
	Thu, 25 Sep 2025 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838740; cv=fail; b=XsVIAQMU3U0dB6CbQlAhM2d6hS4ellscpbRKnITc1zxySetkXX6N4CZ0EnsQrFwC4q3+ayUvy2/1yS+5LdsBSdpeMywuBJoHuU0xnsxpyqwLVxmD/PByCX8NA4Wn6KcmlzSJf95yLZLQ9pwP62exxotg5CR03rCRwKiTkVz4MCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838740; c=relaxed/simple;
	bh=2CevwIu2bvwWz84KDqpHcqMObsdU8o8r3dKDhwxy11g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F/wKNUYvxdsOGHZLbtaLa789jp8FDCcygtimPOTNnVr7p+50aHMBSdtFD75/kRmzr/LHi2g1u4JZ9+sQNF3VJSkGM4T9k32VAospZGG1XlpV82jDzGdA1gBX/ac5+ks+SAtDKuatYZEHsMWO1zW2VmoMnN9ySNFiyPIKrmgMorw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vq/Mt3Bt; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758838737; x=1790374737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2CevwIu2bvwWz84KDqpHcqMObsdU8o8r3dKDhwxy11g=;
  b=Vq/Mt3Bts6CEs4o6zIU+wyM8YB0EDBQP1sJKUqxodw7kcVuiDZcl/a25
   yhFSdfdnbJrmOIpRJytOK3tZnaKeA8VYrAaihTX4YV7B4bzZYhYex7tSS
   yMlD4NBJGwYghSKcBQLXbEDePPC+mykPcxmKDfNhqxJfXyZEiFd3Z5LIo
   cmSJjE0NGOx1Q5rG1WfWii9OFEld2CqSoVhM0WdsIuzhG1k3W3FD3YabY
   CZSnAWLg4N6uSSrR4wa/xy1+6Mf9JKuWThlfsABJwfPTVPCGqcyC4/aMQ
   u9HfE4BKZFZLMNWsmh+YnSus0J/3ew2vDA4SANvEEP1Y9l2DLp98hp5Zi
   g==;
X-CSE-ConnectionGUID: 5nxpWxbsTTmiw0Qcw1KRog==
X-CSE-MsgGUID: kJIEfveNS7e5GyqOaTVIjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64983155"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64983155"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 15:18:56 -0700
X-CSE-ConnectionGUID: qx+Te/vgQC+4Mghc9JPmWA==
X-CSE-MsgGUID: u276dcGwSu+mr3ymY+9M5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="176579744"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 15:18:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 15:18:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 15:18:55 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 15:18:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=up82c433py0LBOe/JKn3hreAzEmm8tL6S9v2kmLpAIDxARq9Tx9frwbnpWOWrGWjohg3NdFsrvEztElX+0yxieA7kBNDFFB5/8c6zCva2lMolRcYlbZ5LAAJlu59oWdGqsX2yD5AkIi2gt8Ky7v+po4cNkILrq0sAbk+ZVFc/7cJeGjlMC/iFrtXOm6NaDDrGN0DkEQXxQsVsvou136Gdmovfqq267yF/0/iGeBOI7AiGfrOeV0De3s0HrB8cxzaF+I8fd/WNI2zahBeLrAq6uVamlOPnptLfn5hboFfmOki0QLuwESsO9+t0THH8Mv9ndxnMHK7QoE9TXELboUa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIp1g2tVDFQZZEjpDqx6eM8SAghx3azT+MrTbXCBRts=;
 b=Mbv26wsS6/OXRTWTH3DBWINfvFBQ8BNi+4XrXpBxvjQy46iApCZhrysE/XDI4eF3Hf/smFnQC93jrAM+3tTdWJn5o6wUHw7Uy5upmnaUILRKKGhC59v2UNEq0q9JN9xSC1wgRRYnW4eMilCxSBAIrDvzW/3SvuWuw+jke7mlq4TZ4FslX9Pp3sDanoklpXSTTGuX2ehsAzOuef1koIhVGBHk3GeZHmUiMrnntBFhiepq6R8lc2jlU5HdMwDsI7OAO/GgtF9PU8mi9gamr+F3DCK8x57PTkfsrnBu5CKEAWEhT+DNEGIzLAw/SuXQj0eUI9kSJwSF2nfn1dBkAbCe+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7512.namprd11.prod.outlook.com (2603:10b6:806:345::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 22:18:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 22:18:52 +0000
Message-ID: <1c7cc78f-c5ba-4fbc-9b17-61e5b72415ad@intel.com>
Date: Thu, 25 Sep 2025 15:18:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: "Luck, Tony" <tony.luck@intel.com>
CC: Dave Martin <Dave.Martin@arm.com>, <linux-kernel@vger.kernel.org>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
 <5be54a14-a7ba-49ba-8ddc-db532f2cf318@intel.com>
 <aNU5nCklRhuc4u3X@e133380.arm.com>
 <9dba03c5-cf45-4510-ab6c-2a945e73fd1c@intel.com>
 <aNW1vAd6Jhq6IkyJ@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aNW1vAd6Jhq6IkyJ@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0015.namprd21.prod.outlook.com
 (2603:10b6:302:1::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9e6d49-149a-4ff0-0fda-08ddfc818282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2FqNkF2QkdTeHBscG5XL3J2Z2ROKzBOUkZCMldzWlZlMGJGbTdKWi82TWpn?=
 =?utf-8?B?TlFqdGlKSzlCenNObVRqOWh5ak1FNzNkNXJyejR5RnM3MExnSVI4YmtVbi9H?=
 =?utf-8?B?TGNPOE1Tc1dibGsyNXUvQXhabnVUNWRuU3hEdWtHUHdZNkxMRm0wT2FYSTVr?=
 =?utf-8?B?THhycXBWeEFsK0JDR3BQUzdncXVOT3BOTDdLYWZndEZZdjRWR0VoL1ZvcDFO?=
 =?utf-8?B?ZkNQRW1CdEFCS0JkYlowMVZBc0hnc2tNdXdPd2RsMm5pdVZndjFkYlI5b1Ji?=
 =?utf-8?B?QXVLS2dFdlJDOHM5VVFxV1EvUkkzSnVNQjNUL3VvTVEwYTVkM1ozdk5FWmZz?=
 =?utf-8?B?RVN2bG1QbUVvd090QmNxMjNPVVpRcVdpc0kveDlvTXRKNE5UVEpGais2Y2N6?=
 =?utf-8?B?TkJtcXRNZmIyRlFIenVPOE9SbyszZjhYd2tMbTR2aG9hOTVkcHBML3YxL29a?=
 =?utf-8?B?Tm8wVll3b3doVVFQSmxVR2RyeWViZFZ3ZHFQUElab3BxNVlPc1AzQXRnbG9h?=
 =?utf-8?B?U1dFYjc0ZnZpQUlyT3ZUZTRBZkxVSXF2K3J6SFpPTXNWVDNrWkd4dDg3bWVm?=
 =?utf-8?B?UldRODVycEh4SXQrZ01HaUlCaUpCekxjK0ZRQ1pVSTVoaS8yRnFMYks3amdX?=
 =?utf-8?B?c0RsNGp5ZFYxRDFzOTZjRmx3N0tFTnUzMTYwYUpSc1F1VGR2NnpCNEN3RHNN?=
 =?utf-8?B?RXplRGhtRnRyQkwwREZDK2J0Yk1aTlhjUkpIb2wxeWhyRW9GRlNsTEpMVnVX?=
 =?utf-8?B?NExsbkx2VThsMjFzd0FGVE5KV0xVODlHcitteDJyL09QdDV2UVFEaStsVFNY?=
 =?utf-8?B?WWsxZW1Wb0Z1VnlDWSs2Z3hFVUZnMTNtRTRlMEl2NXRPL1RValNJMG5qTXlz?=
 =?utf-8?B?cmFIbTFZQUVjVjRHRFdWdU84SXhQcmJ0bmFEWS90M0QvZmo0SGlkbVRqbkRu?=
 =?utf-8?B?VlVmMklybFJqYSt5Y1ZHSGRJbEUzcmN0Y0RrNFdrZnFzQU4zQkI3eEVleTl3?=
 =?utf-8?B?Tmt0SlowK2QzUWFwdU5aM2o0Q0xHR1ZnQWRwelJvMU1ZQ2xzRlN5ZGVZdS9o?=
 =?utf-8?B?L084d2ErUFdrd09uWW9Kclh1Z3hUQU9VMUhkOE43N0czTnBZSTA4MmZWdmlV?=
 =?utf-8?B?RWRCMUxsUHNpZWcydnY4RHZPUVdYVzVFV282aWdORGd6MDF2RWlBM0FGK2xF?=
 =?utf-8?B?eEFFenkyTVVlRFgyWjZlNEl2WjE1bE5lNjI5WEcyck8vbm1YYXQwa0VNTFBa?=
 =?utf-8?B?azFmSWIwZlJOQWw0eEpZb3ZFdmZkSDd0M0YwVmwrOThEWFZ0dHR4YmFEMVdR?=
 =?utf-8?B?YzZkNUpFd3VaVzRpS3QxUE5QUEhiVjErSUxxSFlZSVlxZEFhdnRLTEk3bUJa?=
 =?utf-8?B?emVhSXVmWmNpUytqai9HYjM1UWpLbkN0S0lzaEVwSEE5WFRlUmZVQ2sxUEdQ?=
 =?utf-8?B?aTRJN3RZSzMzakFYSWNUUVc3OTV6b2NwYW5OL3JGR3Bnb1Y1dkg1ZDAzWitw?=
 =?utf-8?B?UU5QbVR2RDMvSFdVU1dHSDdJemZVbzJZajRrNDdOMmdoSmlaVXdKZUNzd3E2?=
 =?utf-8?B?Ry9kZHo3MENmbkhSTHJpVEh5MnBGOTdhWFB1RGgxeS9ZU3dUcVV2WlhtcU15?=
 =?utf-8?B?dVhiWDZ6T1dTR212SlhVNUl4MGI5ZDQ4eXFxTGJoY0laWFlqdG5odHRFQ1BY?=
 =?utf-8?B?WUs5RytBMUVDdlVLZGdMYUtnL1grSnN5SVJ5R0dHWVpXR3lZZnBQTTFZMVVa?=
 =?utf-8?B?QnQxQ0RnZnpyQ3FSOEY1SmdPWXRyUTZtUjNPS3E0QkFXRStaOGttOWJlbmhh?=
 =?utf-8?B?SThxZHd0QVU3QVl1RW83NlJxd1NNV2pSRXJEZjFmQ3ZXZTdCUlo4c2tRaVpi?=
 =?utf-8?Q?htVmTZaijVFpt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVc2SzFYWDREajZnY29HUXNEUmpCVXJqMUhkcG9BUlJBekhBc2ExMk5IRU05?=
 =?utf-8?B?VDJQSGxHZG50UkRnZDQ1c0FFcks4K3U0bm5GNjFlZEVDOXRFaFY0SE5JbHNJ?=
 =?utf-8?B?emk4Qzl2bHR3NHpoUlF4RkEyOVg4TDhGa0N3dmNZclc1SWdObFN2emJvL05N?=
 =?utf-8?B?bzIzT3QwR285eWVoYnlaZDkwMmIrTHhXZnZ2OEp0OUd0Q1VrQjF2ajlkak5q?=
 =?utf-8?B?bWludTU0K01rTmh5aE1KOS9vVnNJQnQxK1lpbE95d042OVg2RUdRWmlSRzNm?=
 =?utf-8?B?cEJYRExFRlQzeDNjeGpJRW9XWmZwdjRhRUp4UWI4d3VoVllQNDl5eEVadnY3?=
 =?utf-8?B?QU95TG9najM2aGtEUnNTaEtMTm1JYnhYajEydmdZbFpjY1Z3dkIxYmJ0Rm5B?=
 =?utf-8?B?MWp3VVgzWnFZRER4b2NURnM5amxOQStnVjlReXRESnBBSGtJNHVWY0x6WFJV?=
 =?utf-8?B?dHI5R2FJTkN6Qis2MVZPTWRHZENrdCtkU1RLSDdSMEVINW5aZWRrU1l4b1Z6?=
 =?utf-8?B?M0p6OTdCM0FGZDZNeVI1MXAwdFhTSTdxSG5yckVBTmI2NlN5RU13WHdWNkcz?=
 =?utf-8?B?eUlRQmJtSkRiNWVyQndYU2dBYTFHb3N5SmNlZUtKSFFXSkVHOVJ5OC84c29W?=
 =?utf-8?B?b1JNNE1SOERpUnJGV1doaXFwb29WRTVqT3RLWC8wYXJ5WmVwaVBOUm5iWlQx?=
 =?utf-8?B?VXZRbXFFcitHWUQ4dU9GZERNNThuNklJSmxJeTRSMnpmTlM3YTJWVisrYWx3?=
 =?utf-8?B?MnFFcWVZYWNyUXBVVldUOXZ4SHl6NUMwUkZQNFFEaDI0c01EUEtUc3RRSXIr?=
 =?utf-8?B?bkhUSGNTeWNjV2cydDc4dWFhS2tCdFQvQnhiUERQaG42NG5ZY1JhNTJ5ZnFL?=
 =?utf-8?B?OWhJSzB4bkJtU3BlSzdwcXU4OTJjODhCbWxZcjVrVE5OUEZxbVhvUHl1OG5N?=
 =?utf-8?B?eXNiam5CWEdRaW83dDNJaytxWEdvV2dUaE1oSmlJeHV6VThQc0hwQndLam9n?=
 =?utf-8?B?ZW0wbVNKRzBSWHRYTDZIZm9zZGtKN0VyUHA3NVZaZWtuOGwyd3dPUUJvMGto?=
 =?utf-8?B?VFQzOThuUWFoV3VpZitzTlRsTTgxOURTa1g4YlJYWVpNMExhRktnRFovRmZm?=
 =?utf-8?B?cFFodEM5c2c5V0xkSVU0eE1pNDFDa0xlcXpCbmVNd0Y0UmNqeVB2cklWbHBI?=
 =?utf-8?B?Lzd4blg4Q0lVRUlMQ1hKdUQrbWxzQTFhc290ejk5SFVNaWZncGo0Zmh6STZQ?=
 =?utf-8?B?ZTc1Znd0eVpNVHd2R0xpQ2I5VDZsbFhFVHhWbnloQTNpaUc5OTRoWGJzWCtU?=
 =?utf-8?B?T2dKV2dnU3k1aE9nbDZvVmNBNTAxUm51aFIwZUsxREpxclZVTWV2TzQ0bnE2?=
 =?utf-8?B?TDhDeEVCajVuMSswWGlpcXZ2UnU4MHV6QVJCMjN0MkU4RHRTTStyVWxZeGxO?=
 =?utf-8?B?bGg5bVZOYzFUaUV4UG9RcC9hMzNoZzMrcTBsRyszMVRwV1pqWE4rci9rSTRW?=
 =?utf-8?B?NVNXRmhCSElwTzJnemUrRllDNlF3QUJ1RTBKY1RneFM0VVFrN1hrNmVibjVp?=
 =?utf-8?B?d3hCcDZ5Q0M3SDFwOHNTTmY3VHRkV2hLc3hMSmlJN1M2RitUM0lQQU9JMkFL?=
 =?utf-8?B?SURvNG5haUhaVWxPWjRINEpoVk14TEp5YjV4UTBGWXJrVENwZ3RhSlJZaGpX?=
 =?utf-8?B?UWJtNlNpS1c5Q3o2K0tlMGlrU1ZPcm15VGZVZWJaUFg2Rzh1OUdvQXhjc0FZ?=
 =?utf-8?B?NUdpSGwxYnJSR0REWU5WYzNWajJ3VzZzckhVWFZXVTVwVHpyNGpOSGFyby8z?=
 =?utf-8?B?QmFJTkVFOXBDZ29sK3RlTm53QWtwSXZFTlRMSEpEKyt4MGhOcnY4SERaWGRL?=
 =?utf-8?B?TWt3WXdKbmdQaVlqVytuZk02K3dqcWhPMTRSc0hKOCttU29xZWg2WW5kMFFa?=
 =?utf-8?B?Vm5pZy96eElZTkN4eHJXKzBNQjRBaGpKOVVhM0dyeUFvbEVBSzlUTlVIdjFz?=
 =?utf-8?B?SkkwN0laQ2RsMWQ4K1MvYUFZS2lSYzhZU1R2MDhRbUp4bTFGQloxRnhVd0dW?=
 =?utf-8?B?Ly84bDVLR1dEN05HOXdxU1dIOTRMTjJDR1Uvc2d4cnpTVHladm9ObS9Eb0pF?=
 =?utf-8?B?Q2tKbTMwNWZpaTFnaXlNUG9MQVd6ZW9TMk01RGRUZjdBazFuUFdRMHk4eFMr?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9e6d49-149a-4ff0-0fda-08ddfc818282
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:18:52.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd5bxbCPRvArP55qQ2P0cbHXvZZajjsSxBqFudNSrXh0Hn82qEialfOeZkRuFqJb+3Rju+6Q6Nt0tu8iWSPitxn6h3jmktMjchyTAy+IVU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7512
X-OriginatorOrg: intel.com

Hi Tony,

On 9/25/25 2:35 PM, Luck, Tony wrote:
> On Thu, Sep 25, 2025 at 01:53:37PM -0700, Reinette Chatre wrote:
>> On 9/25/25 5:46 AM, Dave Martin wrote:
>>> On Tue, Sep 23, 2025 at 10:27:40AM -0700, Reinette Chatre wrote:
>>>> On 9/22/25 7:39 AM, Dave Martin wrote:
>>>>> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:

...


>>>>> for which writing "MB: 0=x" and "MB: 0=y" yield different
>>>>> configurations for every in-range x and where y = x + g and y is also
>>>>> in-range.
>>>>>
>>>>> That's a bit of a mouthful, though.  If you can think of a more
>>>>> succinct way of putting it, I'm open to suggestions!
>>>>>
>>>>>> Please note that the documentation has a section "Memory bandwidth Allocation
>>>>>> and monitoring" that also contains these exact promises.
>>>>>
>>>>> Hmmm, somehow I completely missed that.
>>>>>
>>>>> Does the following make sense?  Ideally, there would be a simpler way
>>>>> to describe the discrepancy between the reported and actual values of
>>>>> bw_gran...
>>>>>
>>>>>  |  Memory bandwidth Allocation and monitoring
>>>>>  |  ==========================================
>>>>>  |
>>>>>  |  [...]
>>>>>  |
>>>>>  |  The minimum bandwidth percentage value for each cpu model is predefined
>>>>>  |  and can be looked up through "info/MB/min_bandwidth". The bandwidth
>>>>>  |  granularity that is allocated is also dependent on the cpu model and can
>>>>>  |  be looked up at "info/MB/bandwidth_gran". The available bandwidth
>>>>>  | -control steps are: min_bw + N * bw_gran. Intermediate values are rounded
>>>>>  | -to the next control step available on the hardware.
>>>>>  | +control steps are: min_bw + N * (bw_gran - e), where e is a
>>>>>  | +non-negative, hardware-defined real constant that is less than 1.
>>>>>  | +Intermediate values are rounded to the next control step available on
>>>>>  | +the hardware.
>>>>>  | +
>>>>>  | +At the time of writing, the constant e referred to in the preceding
>>>>>  | +paragraph is always zero on Intel and AMD platforms (i.e., bw_gran
>>>>>  | +describes the step size exactly), but this may not be the case on other
>>>>>  | +hardware when the actual granularity is not an exact divisor of 100.
>>>>
>>>> Have you considered how to share the value of "e" with users?
>>>
>>> Perhaps introducing this "e" as an explicit parameter is a bad idea and
>>> overly formal.  In practice, there are likely to various sources of
>>> skid and approximation in the hardware, so exposing an actual value may
>>> be counterproductive -- i.e., what usable guarantee is this providing
>>> to userspace, if this is likely to be swamped by approximations
>>> elsewhere?
>>>
>>> Instead, maybe we can just say something like:
>>>
>>>  | The available steps are spaced at roughly equal intervals between the
>>>  | value reported by info/MB/min_bandwidth and 100%, inclusive.  Reading
>>>  | info/MB/bandwidth_gran gives the worst-case precision of these
>>>  | interval steps, in per cent.
>>>
>>> What do you think?
>>
>> I find "worst-case precision" a bit confusing, consider for example, what
>> would "best-case precision" be? What do you think of "info/MB/bandwidth_gran gives
>> the upper limit of these interval steps"? I believe this matches what you
>> mentioned a couple of messages ago: "The available steps are no larger than this
>> value."
>>
>> (and "per cent" -> "percent")
>>
>>>
>>> If that's adequate, then the wording under the definition of
>>> "bandwidth_gran" could be aligned with this.
>>
>> I think putting together a couple of your proposals and statements while making the
>> text more accurate may work:
>>
>> 	 "bandwidth_gran":
>> 		The approximate granularity in which the memory bandwidth
>>  		percentage is allocated. The allocated bandwidth percentage
>> 		is rounded up to the next control step available on the
>> 		hardware. The available hardware steps are no larger than
>> 		this value.
>>
>> I assume "available" is needed because, even though the steps are not larger
>> than "bandwidth_gran", the steps may not be consistent across the "min_bandwidth"
>> to 100% range?
> 
> What values are allowed for "bandwidth_gran"? The "Intel® Resource

This is a property of the MB resource where the ABI is to express allocations
as a percentage. Current doc:
	"bandwidth_gran":                                                               
		The granularity in which the memory bandwidth                   
		percentage is allocated. The allocated                          
		b/w percentage is rounded off to the next                       
		control step available on the hardware. The                     
		available bandwidth control steps are:                          
		min_bandwidth + N * bandwidth_gran.

I do not expect we can switch it to fractions so I would say that
integer values are allowed, starting at 1.

I understand that the MB resource on AMD supports different ranges and
I find that ABI discrepancy unfortunate. I do not think this should be
seen as an opportunity that "anything goes" when it comes to MB and used as
an excuse to pile on another range of hardware dependent inputs. Instead I
believe we should keep MB interface as-is and instead work on a generic
interface that enables user space to interact with resctrl to have benefit
of all hardware capabilities without needing to know which hardware is
underneath.

> Director Technology (Intel® RDT) Architecture Specification"
> 
> 	https://cdrdv2.intel.com/v1/dl/getContent/789566
> 
> describes the upcoming region aware memory bandwidth allocation
> controls as being a number from "1" to "Q" (enumerated in an ACPI
> table). First implementation looks like Q == 255 which means a
> granularity of 0.392% The spec has headroom to allow Q == 511.
> 
> I don't expect users to need that granularity at the high bandwidth
> end of the range, but I do expect them to care for highly throttled
> background/batch jobs to make sure they can't affect performance of
> the high priority jobs.
> 
> I'd hate to have to round all low bandwidth controls to 1% steps.

This is the limitation if choosing to expose this feature as an MB resource
and seems to be the same problem that Dave is facing. For finer granularity
allocations I expect that we would need a new schema/resource backed by new
properties as proposed by Dave in
	https://lore.kernel.org/lkml/aNFliMZTTUiXyZzd@e133380.arm.com/
This will require updates to user space (that will anyway be needed if wedging
another non-ABI input into MB).

Reinette

