Return-Path: <linux-kernel+bounces-833218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8EFBA170B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42EA560D62
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79A1321287;
	Thu, 25 Sep 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOa9b0Wi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5404E1114;
	Thu, 25 Sep 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833634; cv=fail; b=R11trMEVGP6NlZFHRJLHFE9u2dpWvYB7MzXcuJDe4hUlawANhqCwJ8Q2xD5XdqS4N1sEWqMaYhC/2SxnYRWw+2+cHOMRix4N6cTkUU0knlUZ4B5iTmibmjTA1KUAiltnfW5I0oA34H8InGwOWESAUrLH1oEjBEN3tfNiyJj+z7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833634; c=relaxed/simple;
	bh=JGhN4OP1p7NXWxzyW9RdDxzvcFnpQ7vDhxWJK45mw5A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nM1gn6E2WpnR6afFOaQaegdBNgPZVKrUbZzT3PYzQPj5XrXgoIEX/leqYFQQjhJmPvfccRSAOK9ZqZb3t4Cae20+6FNedYY70jhr/8hv5P/BqBPL9Pp70NfK+bstDOA8wLr+rVssuT84cMHrJWUX+OyGEmdUX40Ea5JGoJIYmSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOa9b0Wi; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758833632; x=1790369632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JGhN4OP1p7NXWxzyW9RdDxzvcFnpQ7vDhxWJK45mw5A=;
  b=MOa9b0WiREWBBwxQ8uwlhKyxrgiRjLfYRKyj6MTlMzQGQLQnBA1rOp92
   ZKCoIYNjpbD4FaZEmNPPrBtycCoq8UQ9dZhv/9BOgqg7DNbo47hJXzdiA
   R91cY6L9KyhdR39ZN5qdwhNtifWNyU9XWEtWQiPeA7GNCEunVMk9SqXLU
   f6hhVPLNBosFNuNv/Gt105b62T6djvV/UUz2d9OcJr/uRS48Yna7nTIAA
   fCNzzFQQ6Qx/unT7w24bqh7l8zdmLyrYF9S4DeZES2hewYVqK2sEr0rwA
   KtFcvyAho2l5NgGqtM5/FctarD4UkMffRRZWYwH0KIZPymvAekloTaTDB
   w==;
X-CSE-ConnectionGUID: JH/lYorEReSAah64/dFNIQ==
X-CSE-MsgGUID: jKbQH43pSCmZXccA0rrH4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71413302"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="71413302"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:53:48 -0700
X-CSE-ConnectionGUID: 3y7BEeAKSJOA5puYTcZDiQ==
X-CSE-MsgGUID: sOX4GkSnQtib7U2LjiVhxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="176713417"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:53:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 13:53:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 13:53:47 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 13:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEi8BaYy0kCFeXOe/raPYLIUUBzKsvoHeeHpH3B5qbMRn2guz1cNIaCoqB3Z1y+goUaqjhYtLSx1fKPGXDIkvcDNYomP17BHntPGk1uY812MQh0MGRBWJpHrm3IQQ236PMdxMiazt4eh3EtF5Asu/3tLpwX1gDnK9fIuAqMhyvDC0EF9boKOxTQEAHO7UYH0EbBm1SZmEm0nwk41yAogmNP1ALsRdYwbP33Wx/u5mjADcCxnNmT9ikKWpmsylCQQFr4+9B+Ock7zkSeig2wXmxWVprnJoeg6pgygb6YGNjcA0UlzmDVQS2FY114iU6cNzA/aIJjfBCvSPSPhCEe1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE3w/7gcFIlQBH2DnRnhPxprMxBXj6rt1nuCQnnWF/0=;
 b=JyxN8n1lmw7wTaD9V+XuOiNPUuCMneYhyAJM71VB4K1rIjCd87vwU4r4ko/oj23jz9lBwJNYmEoP6m7E6zrDqBvEZCP//JJ/33CQ1PqgW7CdbyT2TA4/SNfyzrikvH6BYszkhal058uS22QMYFIKATTRntDIFZ5ICvnSi6Bu4Cn0JfIVqAbCniok5Axqr8eI5iqM4xI519elHpn/Y/5PscJW+U8DlC2nFu1zFbBHaASIUzkHiVx+OjeYbRx+fM03W/B38VAKTTgzXM5XK81C/mIkqm/0Qncm+Dd6yotu4NvPzfVMHEIG6c3JXbQ8RZ7mMpghQ6NKB8ZnPyxw6wcA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 20:53:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 20:53:39 +0000
Message-ID: <9dba03c5-cf45-4510-ab6c-2a945e73fd1c@intel.com>
Date: Thu, 25 Sep 2025 13:53:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>
CC: <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
 <5be54a14-a7ba-49ba-8ddc-db532f2cf318@intel.com>
 <aNU5nCklRhuc4u3X@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aNU5nCklRhuc4u3X@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7d01aa-8f9d-4234-1183-08ddfc759a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0ZQTW50NUNmbmlYTURGbEdxR1BwZkVkSUVOVENCRkJqZ0RhdHR0bTg1RitF?=
 =?utf-8?B?K3o3dC9MaEIvN1ZnaWV4MUtXdi9FZlNnUHpmQVNsK0x6aS8rQXRXV202azl6?=
 =?utf-8?B?WS91cUMzdXNNRCsrN0N6R25VYWdhODM4SmQxVEJkOFJaUHVhaTZ1TS9GY0Q5?=
 =?utf-8?B?NVoxUzFSY2NJc2kxMFY4MUN6M3Vqa2JwUGswdlZ3SXVJcEZNRmhRS0tybm5P?=
 =?utf-8?B?a05tR09tTzlEN3IxS3M3dEUrUDJCN2JnNEtLS2ZyZnpERnpHMWw2a0tYV2c0?=
 =?utf-8?B?RmdRd2VDQzZ5UnUrVVF5NGNRV2pNZGJEamJmb1llRnJKT0V2SXFZUWp5aTVo?=
 =?utf-8?B?cFIxNWYyeDRSWkhYczJHaFlRYnJBajJkdCsxazYzaHdrOTNZb2xtN011eVVQ?=
 =?utf-8?B?MUdEWGYwQWlpc2pmSGFaanJ2UzFNdENWZzRwd2RpMXZrT3hpTWlra0NEdERw?=
 =?utf-8?B?ZnVOeEpGd1RjZU9vZ25jV2dYSExKSFZPR3lwcElLWDZLTlpyN29ud0YzWUV3?=
 =?utf-8?B?TGNYM3NFZENPdkt3RkEvZzhLdjRRL1ZCeTdESFRhaENoWU42cThPNm5vWUR5?=
 =?utf-8?B?QU9qYmxBaUxmQjdtaXV2TVUzYmlvK1BQRFRFT01QRTBMNkwzeE5EbzdyUHdp?=
 =?utf-8?B?Y3RLT3QwUnMwakRrQWF0aE9XSEcrYjIrM0E5aDJZYThRejd2QlhIYkUyck1U?=
 =?utf-8?B?N2M0ZTFON2M3KzYySk5mM2ZtSitweU1RZWxiNWY4U3RJc0QvRG52YlFxVS8x?=
 =?utf-8?B?V3VqUWp1SGNtUHM5OW9vL2taa2IvUHAvYjF4NkthWEpVL0p0NnkvQjdQcy81?=
 =?utf-8?B?a2VtUDlnV1FLMGRwOUFwNngvZEVHM3FsYXRISnhnNGFiTm1OdzlmNDR4aGFm?=
 =?utf-8?B?dnhraGIzMU94c1ZYT3hDaTczVTd5WDdHazRKZmI0R2tzVG94TWwyQXV4L1Rx?=
 =?utf-8?B?bWlCaTE4em94eFJQTk1yZklac2tibEZJa1ZDeS8vSHpaVlF3Q1JHR1FFTzRP?=
 =?utf-8?B?N2hpNFBQN0l5dXgrb0dpVVBldVRLbWxmbGlDTnZxTTlaOXhEWmY4ZEwyNVJI?=
 =?utf-8?B?WmlxVkJqQVdYOXA1ci94MVBRK1hobG4reWE1UnlrbkFLRkFNQWZGUENFVnhz?=
 =?utf-8?B?TGdVU0E1c3VHU2Y5cDVWMHBCUjRKZ01zLzIyQ2poS0FOL28raWZ3cWhuSWFp?=
 =?utf-8?B?OGdob1hEVnBvRHlJTmVjRWVDK21KVFRYS1hCVXFVTzVYRDFrdjBleXkvdjF3?=
 =?utf-8?B?Sm9aL0pObzFiOUJsVlFCRnVjcUc0YTE3elF1UjB2UDdxMEt0VVB2TVV6S0w5?=
 =?utf-8?B?Y3djTG9TbWp5YmN1UHNzT1Q3Ym8xM29idktpT0lPa2xEZk1Rbm1UV1JKcy80?=
 =?utf-8?B?VmVzY3paYzhucVdWSEQ5UHVWdm1JQld1S29GTHJnVkdueUxNd3ZyVVpDY09p?=
 =?utf-8?B?MWwvVUgxbnBocmROR2VqMndOWTdqWnpTQW1FQk0yVW9Cd1FIdzM5NjExSnpB?=
 =?utf-8?B?enNCYXVES1JuL0hvY1J5WHhTdUdEa0RWN3AvUjlQNzROdFhNd2c4YmkwYUx4?=
 =?utf-8?B?eUFUV1dvUU1Hak9abFlic0ViSi8vY29iZ0VMMGgzT1VrNFZVbGF4VlN1eHlq?=
 =?utf-8?B?dlIvVEZMWDVidkxlYXVVeWd4dlZ1QkJzMFpWMXlRc2l6QmhDSjVPbmd1cEo3?=
 =?utf-8?B?KzhxcXNqNGVMM2ZnR0g4dTdMV2toK2J1blVMK3N4dzlPVWpzRFZESisybGk5?=
 =?utf-8?B?N2dzRExuZFRtYVZuOFpSV2k3NVRpQzM0VFgrMktRZFIwVlVrUWM4TEk5WnhZ?=
 =?utf-8?B?Y0FkOE5sMThabjIvK1h1eU8xVG92cFFVUVBQTEF4WXlaSkxrSzNRM0gwN1pL?=
 =?utf-8?B?bTIvQXBZcVdvK3ppOUlLWWw3QVFTSjFielViaThnYkk4dGIvUzRab1FiK3Q5?=
 =?utf-8?Q?QDFksSGf67E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGVFcmpDSGdtQXlVSzVCd1Y5RzlIRFhZS1F4b3FtK1Z0YXFHdnhQaEJBSlho?=
 =?utf-8?B?a1F1KzcvcHJkNEY4bFlkVWtGMTE3Q3o0MmF6TUl1QWFxdmJVM2M5L2F6MGJl?=
 =?utf-8?B?YWlLNGtPVkVvTngxMTIrd011amhQRjRucTFSNVNXZmU0WWYzZDlNd3BRblZ2?=
 =?utf-8?B?WnJ4Yll0WFVUK3VoUzNKWVpWd05adkg0L21USzVocmpEY2UxL2ZlMkY5S1NO?=
 =?utf-8?B?cVFTSjdnNTRmVEsrMThnak9POXJ6dE5FeWxSdllpSjhKOE5haTlrYXNEY081?=
 =?utf-8?B?N1U5Qks0RXhTSmp2R0pMUjErKzVXOHZGdy9kNDRmSEpld2ZIU3V2cElnRVVv?=
 =?utf-8?B?TnR1N3o5VFpURXk3bFAzMlp1UU9obVBMd0YwbXJDd0RZYzNGMFVNSXI0OWZZ?=
 =?utf-8?B?VFBFTUdXTjJuVHBDNjVuYWlyL0U4c0Nsdytqc0tINS9pWkl4ZXc5U0w1clRQ?=
 =?utf-8?B?ZDRWNmx4dUg2YlU1VllNOWIxTWdnRUdaMWtwS2ZiZEJsTmRTRCtiOFgzVmpi?=
 =?utf-8?B?S3NrekMzNHlWRmU2ck5nYkJlQ1Iyb213U2Fob29kRmw4Q0dBdkNYZnZZeHFa?=
 =?utf-8?B?MExBS3ZLYXdMbXV5Vlp0MUxMMlBRUzcyR3lGZGVFMDZEeGF4VHJPbHNWb3g5?=
 =?utf-8?B?WVBlbkltUGJZdFBreml0UzVyWTQ1bFR5MUNhbElRandtVjN5bjZ6QUExcFV1?=
 =?utf-8?B?dVBRRHQwdGZyM25zZnlzTm9RS0NpOXNWMTkwZG51TUJDdWZkWWswOHRsU3l6?=
 =?utf-8?B?TmQ0YWJrYjI5VytycTRldVFqN0NtaCswbnhET1o1YW4yeHFnTEV6cElwNTg3?=
 =?utf-8?B?SFBhT3YxNUE2NXFmVmNkZ1NQMGRpMUl3cE9GMVdNYUJQU1Q5R0w2SWJDemY2?=
 =?utf-8?B?UGdvcGxNRnAwZVNFVTgybmlHWWQxLzE4SEdLOEdsc1l1M1JzbERWZzBaODdU?=
 =?utf-8?B?Qk5iSVc1UzEzTVZxc2NOQXNCa0hzZEcyUUZISU1XMWh1eC8ySzJVQ2tWQlpW?=
 =?utf-8?B?dTZsY1ZjOFlEN3EyMzJVY2x5SDVnOFJkdXZpeCt6dnQ5ZjJXc0txZUNKL2V5?=
 =?utf-8?B?OGhIM0pWbkwvNUZTbFRIMkRFcnoyckJvZ1pRbFk0L2RObGNrRXA5WitteVdv?=
 =?utf-8?B?bFMrZlpvYmNXVWpHaElSaWU3VmU3T3IrVk9JQ3QrM2gyZnc3SkptWmV6Z0Rt?=
 =?utf-8?B?dEdwYTJ6MWVCSkkyY0VkLzFDOUxRY1ZIRzFvZFZtK3Z1WVpleVV1UjkrSEpU?=
 =?utf-8?B?K3F0N3JVRytWV0lVTlBacjRVeVNvRlFzZW1lTDVKZ25PaGtZL1I1MlhPYWxW?=
 =?utf-8?B?UDFacCtKQncrQlcra2E4N1loRFJyOEM4WS9QWFJubmdOZEwxTVY1bDEvaStr?=
 =?utf-8?B?OHZuMTVmcmMxUWJ2TUszT3p5K1RvSTA1eVZYd1FseEFOd01HMnlsMUlBb2Jq?=
 =?utf-8?B?T0JPQ0RtUS9FbkNPR1FLdTdNbHdBUEVmN2psaitaOXYyZnBSYndSbC9XbFMx?=
 =?utf-8?B?TjJITityMGdnMm9SNVJhNUw0eStlSnB2c1NPd0lRTi9qMFJWa0N1M3NLNExl?=
 =?utf-8?B?ZG9BcmUzRisxMG9wZFU5cUZNVnJ4STZrVWtYTnhJellMYlhXRnM1QjM5Zk0x?=
 =?utf-8?B?U1M4ODRvZ3I5ekFKd3MxQXZuOXo2aHNvaEdtOTllVmpWUW5mZXY0WWk1bjRT?=
 =?utf-8?B?WTA3ekVlOTlaaWQzdFVuS2JtTGxjU0gza1Z1aDhJY0dmUnozd2treXFJM2FX?=
 =?utf-8?B?Vy9QNWpMMXBEMll3ZnZFVFJLeDZiWEdNeWZ3QndOMnM2VXZabThIZHBVVmFz?=
 =?utf-8?B?d28vbmkwS1lBMG53a3A3SmZmWjNzNXBYckFWWTVNSG9FMk16R2ZySkJWRHAr?=
 =?utf-8?B?bG5JQVlkVlZ3Qk5MU0E3SDA1dkdEekhMZU9wS2dzRVd0ZG4rbm1aSERnaVlN?=
 =?utf-8?B?KzRXcWtiTVVvUEY4UmkzZy95dytOOUdZbkdsMXc2cnJoTFZhK1VEbWtXb28v?=
 =?utf-8?B?blZmS2hXa01KTEVqSE1XZnYzMWhwZXJJYWhmckdKTGw2N2V5QzZ0L09oMGlQ?=
 =?utf-8?B?ZDhYU081ek5hRlVUblNYMHgzZzBUS3JYWkxqL0FTVzNPS2NlaWY5UkxjMzcx?=
 =?utf-8?B?U2twdjdtby9TVUlReDJIVWhIeWJwN2NMMVNVdXFqRWx6eHBvRnFzVEllMHBi?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7d01aa-8f9d-4234-1183-08ddfc759a92
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 20:53:39.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21kok1E1anVxtBGT3eqhDcABgdUenRgdAlbUJhRs/4vLmNUNIQB8MwgiwgLhw7JYREqve1VN3jwVnV/DLooxh5mLKfJiX51dNJT+ycgbVkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com

Hi Dave,

On 9/25/25 5:46 AM, Dave Martin wrote:
> On Tue, Sep 23, 2025 at 10:27:40AM -0700, Reinette Chatre wrote:
>> On 9/22/25 7:39 AM, Dave Martin wrote:
>>> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
>>>> Hi Dave,
>>>>
>>>> nits:
>>>> Please use the subject prefix "x86,fs/resctrl" to be consistent with other
>>>> resctrl code (and was established by Arm :)).
>>>> Also please use upper case for acronym mba->MBA.
>>>
>>> Ack (the local custom in the MPAM code is to use "mba", but arguably,
>>> the meaning is not quite the same -- I'll change it.)
>>
>> I am curious what the motivation is for the custom? Knowing this will help
>> me to keep things consistent when the two worlds meet.
> 
> I think this has just evolved over time.  On the x86 side, MBA is a
> specific architectural feature, but on the MPAM side the architecture
> doesn't really have a name for the same thing.  Memory bandwidth is a
> concept, but a few different types of control are defined for it, with
> different names.
> 
> So, for the MPAM driver "mba" is more of a software concept than
> something in a published spec: it's the glue that attaches to "MB"
> resource as seen through resctrl.
> 
> (This isn't official though; it's just the mental model that I have
> formed.)

I see. Thank you for the details. My mental model is simpler: write acronyms
in upper case.

...

>>>>> On MPAM systems, this results in somewhat worse-than-worst-case
>>>>> rounding, since bw_gran is in general only an approximation to the
>>>>> actual hardware granularity on these systems, and the hardware
>>>>> bandwidth allocation control value is not natively a percentage --
>>>>> necessitating a further conversion in the resctrl_arch_update_domains()
>>>>> path, regardless of the conversion done at parse time.
>>>>>
>>>>> Allow the arch to provide its own parse-time conversion that is
>>>>> appropriate for the hardware, and move the existing conversion to x86.
>>>>> This will avoid accumulated error from rounding the value twice on MPAM
>>>>> systems.
>>>>>
>>>>> Clarify the documentation, but avoid overly exact promises.
>>>>>
>>>>> Clamping to bw_min and bw_max still feels generic: leave it in the core
>>>>> code, for now.
>>>>
>>>> Sounds like MPAM may be ready to start the schema parsing discussion again?
>>>> I understand that MPAM has a few more ways to describe memory bandwidth as
>>>> well as cache portion partitioning. Previously ([1] [2]) James mused about exposing
>>>> schema format to user space, which seems like a good idea for new schema.
>>>
>>> My own ideas in this area are a little different, though I agree with
>>> the general idea.
>>
>> Should we expect a separate proposal from James?
> 
> At some point, yes.  We still need to have a chat about it.
> 
> Right now, I was just throwing an idea out there.

Thank you very much for doing so. We are digesting it.


...

>>> For this patch, my aim was to avoid changing anything unnecessarily.
>>
>> Understood. More below as I try to understand the details but it does not
>> really sound as though the current interface works that great for MPAM. If I
>> understand correctly this patch enables MPAM to use existing interface for
>> its memory bandwidth allocations but doing so does not enable users to 
>> obtain benefit of hardware capabilities. For that users would want to use
>> the new interface?
> 
> In ideal world, probably, yes.
> 
> Since not all use cases will care about full precision, the MB resource
> (approximated for MPAM) should be fine for a lot of people, but I
> expect that sooner or later somebody will want more exact control.

ack.

> 
>>>>> Testing: the resctrl MBA and MBM tests pass on a random x86 machine (+
>>>>> the other tests except for the NONCONT_CAT tests, which do not seem to
>>>>> be supported in my configuration -- and have nothing to do with the
>>>>> code touched by this patch).
>>>>
>>>> Is the NONCONT_CAT test failing (i.e printing "not ok")?
>>>>
>>>> The NONCONT_CAT tests may print error messages as debug information as part of
>>>> running, but these errors are expected as part of the test. The test should accurately
>>>> state whether it passed or failed though. For example, below attempts to write
>>>> a non-contiguous CBM to a system that does not support non-contiguous masks.
>>>> This fails as expected, error messages printed as debugging and thus the test passes
>>>> with an "ok".
>>>>
>>>> # Write schema "L3:0=ff0ff" to resctrl FS # write() failed : Invalid argument                                      
>>>> # Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected                             
>>>> ok 5 L3_NONCONT_CAT: test                             
>>>
>>> I don't think that this was anything to do with my changes, but I don't
>>> still seem to have the test output.  (Since this test has to do with
>>> bitmap schemata (?), it seemed unlikely to be affected by changes to
>>> bw_validate().)
>>
>> I agree that this should not have anything to do with this patch. My concern
>> is that I understood that the test failed for a feature that is not supported.
>> If this is the case then there may be a problem with the test. The test should
>> not fail if the feature is not supported but instead skip the test.
> 
> I'll try to capture more output from this when I re-run it, so that we
> can figure out what this is.

Thank you.


...

>>>
>>> [...]
>>>
>>>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>>>>> index c7949dd44f2f..a1d0469d6dfb 100644
>>>>> --- a/Documentation/filesystems/resctrl.rst
>>>>> +++ b/Documentation/filesystems/resctrl.rst
>>>>> @@ -143,12 +143,11 @@ with respect to allocation:
>>>>>  		user can request.
>>>>>  
>>>>>  "bandwidth_gran":
>>>>> -		The granularity in which the memory bandwidth
>>>>> +		The approximate granularity in which the memory bandwidth
>>>>>  		percentage is allocated. The allocated
>>>>>  		b/w percentage is rounded off to the next
>>>>> -		control step available on the hardware. The
>>>>> -		available bandwidth control steps are:
>>>>> -		min_bandwidth + N * bandwidth_gran.
>>>>> +		control step available on the hardware. The available
>>>>> +		steps are at least as small as this value.
>>>>
>>>> A bit difficult to parse for me. 
>>>> Is "at least as small as" same as "at least"?
>>>
>>> It was supposed to mean: "The available steps are no larger than this
>>> value."
>>
>> This is clear to me, especially when compared with the planned addition to
>> "Memory bandwidth Allocation and monitoring" ... but I do find it contradicting
>> the paragraph below (more below).
>>
>>>
>>> Formally My expectation is that this value is the smallest integer
>>> number of percent which is not smaller than the apparent size of any
>>> individual rounding step.  Equivalently, this is the smallest number g
>>
>> Considering the two statements:
>> - "The available steps are no larger than this value."
>> - "this value ... is not smaller than the apparent size of any individual rounding step"
>>
>> The "not larger" and "not smaller" sounds like all these words just end up saying that
>> this is the step size?
> 
> They are intended to be the same statement: A <= B versus
> B >= A respectively.

This is what I understood from the words ... and that made me think that it
can be simplified to A = B ... but no need to digress ... onto the alternatives below ...

> 
> But I'd be the first to admit that the wording is a bit twisted!
> (I wouldn't be astonshed if I got something wrong somewhere.)
> 
> See below for an alternative way of describing this that might be more
> intuitive.
> 
>>
>>> for which writing "MB: 0=x" and "MB: 0=y" yield different
>>> configurations for every in-range x and where y = x + g and y is also
>>> in-range.
>>>
>>> That's a bit of a mouthful, though.  If you can think of a more
>>> succinct way of putting it, I'm open to suggestions!
>>>
>>>> Please note that the documentation has a section "Memory bandwidth Allocation
>>>> and monitoring" that also contains these exact promises.
>>>
>>> Hmmm, somehow I completely missed that.
>>>
>>> Does the following make sense?  Ideally, there would be a simpler way
>>> to describe the discrepancy between the reported and actual values of
>>> bw_gran...
>>>
>>>  |  Memory bandwidth Allocation and monitoring
>>>  |  ==========================================
>>>  |
>>>  |  [...]
>>>  |
>>>  |  The minimum bandwidth percentage value for each cpu model is predefined
>>>  |  and can be looked up through "info/MB/min_bandwidth". The bandwidth
>>>  |  granularity that is allocated is also dependent on the cpu model and can
>>>  |  be looked up at "info/MB/bandwidth_gran". The available bandwidth
>>>  | -control steps are: min_bw + N * bw_gran. Intermediate values are rounded
>>>  | -to the next control step available on the hardware.
>>>  | +control steps are: min_bw + N * (bw_gran - e), where e is a
>>>  | +non-negative, hardware-defined real constant that is less than 1.
>>>  | +Intermediate values are rounded to the next control step available on
>>>  | +the hardware.
>>>  | +
>>>  | +At the time of writing, the constant e referred to in the preceding
>>>  | +paragraph is always zero on Intel and AMD platforms (i.e., bw_gran
>>>  | +describes the step size exactly), but this may not be the case on other
>>>  | +hardware when the actual granularity is not an exact divisor of 100.
>>
>> Have you considered how to share the value of "e" with users?
> 
> Perhaps introducing this "e" as an explicit parameter is a bad idea and
> overly formal.  In practice, there are likely to various sources of
> skid and approximation in the hardware, so exposing an actual value may
> be counterproductive -- i.e., what usable guarantee is this providing
> to userspace, if this is likely to be swamped by approximations
> elsewhere?
> 
> Instead, maybe we can just say something like:
> 
>  | The available steps are spaced at roughly equal intervals between the
>  | value reported by info/MB/min_bandwidth and 100%, inclusive.  Reading
>  | info/MB/bandwidth_gran gives the worst-case precision of these
>  | interval steps, in per cent.
> 
> What do you think?

I find "worst-case precision" a bit confusing, consider for example, what
would "best-case precision" be? What do you think of "info/MB/bandwidth_gran gives
the upper limit of these interval steps"? I believe this matches what you
mentioned a couple of messages ago: "The available steps are no larger than this
value."

(and "per cent" -> "percent")

> 
> If that's adequate, then the wording under the definition of
> "bandwidth_gran" could be aligned with this.

I think putting together a couple of your proposals and statements while making the
text more accurate may work:

	 "bandwidth_gran":
		The approximate granularity in which the memory bandwidth
 		percentage is allocated. The allocated bandwidth percentage
		is rounded up to the next control step available on the
		hardware. The available hardware steps are no larger than
		this value.

I assume "available" is needed because, even though the steps are not larger
than "bandwidth_gran", the steps may not be consistent across the "min_bandwidth"
to 100% range?
 
>>>> I think that using const to pass data to architecture is great, thanks.
>>>>
>>>> Reinette
>>>
>>> I try to constify by default when straightforward to do so, since the
>>> compiler can then find which cases need to change; the reverse
>>> direction is harder to automate...
>>
>> Could you please elaborate what you mean with "reverse direction"?
> 
> I just meant that over-consting tends to result in violations of the
> language that the compiler will detect, but under-consting doesn't:
> 
> static void foo(int *nonconstp, const int *constp)
> {
> 	*constp = 0; // compiler error
> 	(*nonconstp); // silently accpeted, though it could have been const
> }
> 
> So, the compiler will tell you places where const needs to be removed
> (or something else needs to change), but to find places where const
> could be _added_, you have to hunt them down yourself, or use some
> other tool that is probably not part of the usual workflow.

Got it, thanks.

Reinette



