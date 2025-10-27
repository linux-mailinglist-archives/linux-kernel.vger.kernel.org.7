Return-Path: <linux-kernel+bounces-870872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268D0C0BE0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF7418A201B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337D62D7DC3;
	Mon, 27 Oct 2025 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8APmqqA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA902D7812
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544505; cv=fail; b=DQXhUqRkjBDFq42vMvupf+2pdn4QZQyiXxQvkgRdJw9KXU0nDVNoQy98Grg/z4sEkgFFT7O2Fa7wh4uJLe3JzaNNOlprd3ZVg2jPuTCq1jB9jUJWpchbDzO/yhcv5FzZMOQGVj7EYYQSK6JOtpPS1WWsLzP8kCp4fRJgwuXoeKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544505; c=relaxed/simple;
	bh=f4/JUsMMjG+guta/Or1dVrLR/HI6y22o2y7sP51HSNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikfS6pecEEr4pKt+cht21H4U3Ib/jLDaYXnqApfQNI97SS/6eKS9oy9r0buy4coMRoj8s36itbsygDGW344l4lzOMzPryr13DCNdB2U0s0Au4LDL3FJuLx88ObLRLVWDWQZv6l/2MHrUkZ/KsP2kfnCxiTtlx1/a/+l/SSs2DDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8APmqqA; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761544504; x=1793080504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f4/JUsMMjG+guta/Or1dVrLR/HI6y22o2y7sP51HSNM=;
  b=E8APmqqAKX2IImIVzSu8O3wHPgO0iYTiaGfp5Bu6bbqHfvUv8OXzIjdd
   5fQqi0DwE4b2bCc8/YtyaECbxdpzx5h61axBWh2TSyymKApaLZIDwo4dH
   X99H1aCRjqwSnEIlKELlUiBeq0ni1zAKhhDp5pA6avuNffqZbZ0jGhPxX
   auvtf0AZUYvrZEJ3hXTGGRR9UCISJmrgRJcbNuyrmlZkeknxjheYprecu
   lSgaU/nyZSVBRw4pS/9W4OQ4G05u5Zn5iFBjEvN8jIskddvPtlYinyaec
   TJJspzWE0baR8VMJ8gOtxIyQ+TXDlmZtTaaDlWX1YEBnWUotvHmJf7FAB
   g==;
X-CSE-ConnectionGUID: M/1sFkTWTHKQ7pM7sgZGSQ==
X-CSE-MsgGUID: 2tpe0Q64Tvu27o06WMrscA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63542103"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63542103"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 22:55:03 -0700
X-CSE-ConnectionGUID: dX2HMqcYRPCD5mOWBiaHdA==
X-CSE-MsgGUID: JirCGzgqTxabbpH3CC/uDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="215853136"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 22:55:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 22:55:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 26 Oct 2025 22:55:02 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 22:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiWBKWpUzdpO6Du6IRXHxQpBLJVpiOoAd3Zd21HlKLdss4JdntXmOumeeXya2TUax9+mi3NGBJU041dhyWTCdI5BOwXt75i7BPjM03zH5/N8d1qYixvfnBRuI7R41TTD/b7fVIgVdDLzxJSV1ibAX5SKk5yOwRjLfiXmz1F5j5pElpx+pzpgbJ+SQMIB5mo4DLoX6u2nwJGG+d23s3jZRakxI2ls87o8Pmm3hYrcktfP58RGawtneck/VhnoVTTrXv86y7vQDKfxQ3lPSs5j4MwO8LgWGj3UIzJqKXJnUj8qycl+UQai1g7y7lGsjN744Q68DNJNlfLDpzYnUpoSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4/JUsMMjG+guta/Or1dVrLR/HI6y22o2y7sP51HSNM=;
 b=n3AxlFq0yN83fPd9p78w2a7KjAjDg+FMbpFbWUCezWPMtKuIAFOgtoPP54fuQ1sNpUZQ+TJKtHE80qDzHwirJNmdxGbkGHWJ76ISrsDYqKG2pUWJmIHAqFfWHbsdezH2fBvEVFtkFEaVtBNXmooFSyUWcRx0B3IOO7syr8eb96NjTTDiU5nRgpLl8JIJXrvY2FaVUi7x1OKzO35fQVexWv8SOi+8gZFkeWAt7a5P1Lv+EhrfaBVBYdkl5zzQePzQtnF4Ft+3GYaUdx7s36rqyQ88d7glJbRgI/zyf9ffMMsR4/n+kfCe7SbiStaaoE4Idvq/mGZzaMgUIWkd1+qMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 05:55:00 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 05:54:59 +0000
From: "Li, Fei1" <fei1.li@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "acrn-dev@lists.projectacrn.org" <acrn-dev@lists.projectacrn.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
Thread-Topic: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
Thread-Index: AQHcRKChkqxb1RMa2UOKI3cGmiOHe7TQyh6QgAAFKwCAAACWUIAA4/eAgAPMIxA=
Date: Mon, 27 Oct 2025 05:54:59 +0000
Message-ID: <SJ1PR11MB6153A77684F68B592851A32EBFFCA@SJ1PR11MB6153.namprd11.prod.outlook.com>
References: <20251024044226.480531-1-rdunlap@infradead.org>
 <SJ1PR11MB615389E066F50BBB68686A26BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <213c918b-b4aa-4174-af89-a4d17e8c30dc@infradead.org>
 <SJ1PR11MB61536DC1E7A32387FCA400E5BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <8950bbb2-f1a7-4ae8-971f-7331c7eceff0@infradead.org>
In-Reply-To: <8950bbb2-f1a7-4ae8-971f-7331c7eceff0@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6153:EE_|CH3PR11MB7345:EE_
x-ms-office365-filtering-correlation-id: 2665ff27-dce5-4adc-4dff-08de151d5d08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K2FCR1NaWkNlc3NUMmNPZnVqb0x2cnhvMjM2SDVtaE5Bc1VDeENOY2VlbHoy?=
 =?utf-8?B?UHA4ZUN1OXJyZlEydXB6YUMxa0JWckU4OU1HOFNSeDhpUTd4eTZFaTFiNmxB?=
 =?utf-8?B?NTd0ZXA2MllNUXcxK2dsNWNEOW5lZnMxLy9KQTI3QVNkbDArWmNPakNHMW4z?=
 =?utf-8?B?V0ZjWjNsMURpR1ZHM2R2R0N2TjlqSEg5dXFsdFMxc0Z4L3NqajJpMDFzTlla?=
 =?utf-8?B?S2lKMVhzZXFrbmdwUm9jaG1sVDkvY3l4aWphMzZBcDFPWktSRnlERU1uNURE?=
 =?utf-8?B?SkwydlU0VFdHaVZWWlN3Z3VjdURDL1pTeDl0ZW1GZG4zTFN4M0FOUjlwcDZz?=
 =?utf-8?B?VkxxeDhrT3JPMW1INTVMUitKd0dtWFNHN2paVGJrYzE5SFNhVmowVWI3c1dw?=
 =?utf-8?B?dDA2MFFTWXFpbGgrcE15U0x1WTZRMVpDZXAxTnRVMktlZ3l5c2dDK20rblVu?=
 =?utf-8?B?cDJQWWhXMWh0czRKQi9YOE1aVU92TGdiLzZ2dWo4OXJHK2xFTUE0aDNSaGZv?=
 =?utf-8?B?QW9JNzZCQ1lqVkw1RGtreTR1MWNiOEd4VlFJNWFIbHpXK0NjV09lQ2gwUkdZ?=
 =?utf-8?B?NnZhb0tvTStRL0FIOXh0am4rY1QvWnQ1bnJDR3ZRTkdyKzVEOXhEa1MxV3dr?=
 =?utf-8?B?ZFR2L2ZWYkV5alRwSUhGN1VZUTlqQTEyVlVQRHFZVTRJdWR4Z0ZORm9kbUxn?=
 =?utf-8?B?YU5LRy9TZlNWekJLV3JXQkFOcWcwbmNqZUtOVnRQc2w0TUNTQzlpNjQ0Ui8z?=
 =?utf-8?B?K0RIQUlxWlB3VkJ0eDNuWEI5SU44U2tPaXJYdkRvTFVFcDZNSDlFWHRhS0Ez?=
 =?utf-8?B?Q1ZZQ3B2TU5ING4yNDRudi93Q1VlK2U0TXdNSE9tWWx3NTByWTIvS2dudGlY?=
 =?utf-8?B?cUlGK3k3UW1tOTFHRUpSSndmRlFLZHZKYzhaYXAwOXJlQWtqWXlqOVpMSm1w?=
 =?utf-8?B?S1RlcjFLc25zeVpSbk9ZdjZSQ1h5d01zL2hhL04rOFBybzhMbjJ1WFRLcVBE?=
 =?utf-8?B?TzNmRitRTTRkLzl1WThtMDBEQ3FwZnZkWFZZU0ZuTXllZHkydUlxbGFNd0lF?=
 =?utf-8?B?aldyY1Nrc0hEM1BlQWhRTWpKYjFhbjVzT3ZzVnpyaGM5ODljYWErTVEvZFVV?=
 =?utf-8?B?KzVGYVVpblc5VXVnMWdjQ2J1N2JGbVV0cWVTNkpxR1QvZnAyMy9nWGdOTm12?=
 =?utf-8?B?TkNEWUwwa2R2cnJZbGowTHFZbTZjNEs0cHFZbGIxeUt3OWg1L0ZLVUZIUnhQ?=
 =?utf-8?B?SlROMFRCOThlU1d5ZWk2bWJkVVJRM29QUVJQN294dnZCUXVqVDZnV3FLaHda?=
 =?utf-8?B?TEt2MFZ6Y0lqczg2ZXNjNkhDMG5TSVd3WEFUQ1JaM0VHTmsrbFkyTnpCZnVE?=
 =?utf-8?B?bTVqN0tDT2s3bUdObFdaRG1IVlcwOFNNWE1sYnlHeUg0VlBtY3J5ZzU5YjJS?=
 =?utf-8?B?V0FOVXR4UnJDVnlCNDhTWitNMkxCeXErTUFhd0NYcURjU0wwOEVuNXc2VXFH?=
 =?utf-8?B?N3FJN0trYjlJOXRvTENtd3hWN2hONXZkWFBra2d0SUxKc29lREpldWZBODF3?=
 =?utf-8?B?djRXeGZiZ2tBUGR0aUNnNlB5empnK0ZXS2FlQStxZThMcDNNK1cyMmMwRWNW?=
 =?utf-8?B?SjU5ZE40K3Q1VVY2M0ZaSWhOSVh1TTVvUWVCWXJoUDdXRFhUQnprcWlTRlNK?=
 =?utf-8?B?UUZWYW8vS29kL3RBM1Z1Sk5hOW9Yam1Uc1ZUOGFsTk5YN29QQjRmUTJCc0hQ?=
 =?utf-8?B?ME10TmZHOC9MQWZ5OWdhdGpYZEZsOU5Pb3lzQ3ZZZmZ3MFZUSmNKdG5PS1lk?=
 =?utf-8?B?b01tYmFCaEhNOTJvSmpBbUs3UW8wWEtLREsvaEtwQ3BQdVN0YjlJazJjK0to?=
 =?utf-8?B?eVM5N2twK25UYmZIalRQWjZMV05MMC9QRytUakNxZTBDMmRiSzNZTkY3SjFG?=
 =?utf-8?Q?VpEwhDSIItT+Ib8oeJada2Yy8PAR8u92?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmR6emtvVXRiRmNyTlp1MlVSTEdXR2RUemJGQXRIVHpCWWxsTTZCVjR3NGI1?=
 =?utf-8?B?a1JBd3llbnZlS1pSQ2g2Skh4UWU1dW5jdVJWdHRKYndwbzJHMDdhTjdkRWlI?=
 =?utf-8?B?UTBrZWx1b2NGcVF4eEtMRk9HcmpzVjlZSVNNUmlVT1VqQi9FWm1oWi9wTFh2?=
 =?utf-8?B?cEU3bjVKb3RjeUJOdGxqRXhXNnFIRXluemJ4UHd0NjliRDlsMjJqTmxOdm8z?=
 =?utf-8?B?bVFnYTMzUDBQY0RHbUQ2a1VaenNrd3lLWExSSkxkMUsyRW1PcHFLZ2hjZ1gx?=
 =?utf-8?B?WWtiZGRZb2tiSHlKeHdrUnBTbXFpRFdGMWVwMXJnQXdYcjg2UGdOZlpIZE4x?=
 =?utf-8?B?Ti9xb0QwaDUzTkd1cTAycjMzR0lDb3NUQmdNeTVadjZCUlFZdERXTzV4L016?=
 =?utf-8?B?bDVQSlRHRi8yc3ZxYmFYbUpya3ovaWhKaDhqejNjcXJmT2x4TTNCY2VOOTRp?=
 =?utf-8?B?K2ZYTDFZd2pHNDlmeFNaQVQyV1dZenZqVXY1bTZBaHFWbExHN2M5R1VjWnkz?=
 =?utf-8?B?cll3aWdpc0VVeStvZTVFZWlMNXRudHBhQUYyRzhlT2pFSVlSYU96cWVmNVF2?=
 =?utf-8?B?cW1qQlRvVXNIQ3V1TVlucU8xQ3o5THhtR3JVY2t5d01DUFVtRENlQ1VzbXJu?=
 =?utf-8?B?SU84bFJFSnhMYzBhSGUzYVJsUy93MndhbWY1cEx6aXExVFhQVm9TaDhEdG9m?=
 =?utf-8?B?NDJyL05mdkhqZllrUFc0M2hhc0F6Zkw4bG1CTjRzQ0tzeXNmUmRsbTZYRGVU?=
 =?utf-8?B?RkI5Zm5FVHVCT2JGbEZnK1VlK21yekhsOE8yK0ROTUliU3pIaTh3bGRrRmN6?=
 =?utf-8?B?VC9VMjdPdWprdWhBaVRoVEQwem5JTklmbC9kR1RIM2kxQnJUS01SSzJ4cnFh?=
 =?utf-8?B?TWtuYWJxZmxuREtsZ3pCSDAyU1gzWjdmYmxhSEtablhzZUhZT1ovZlJOdDll?=
 =?utf-8?B?Y3d3bDRlQ1RwcmpJRjFNbEN6ejR1MkUzaTFraU5BbTNHcFJqOUVHWVVlN2Vk?=
 =?utf-8?B?YUc0bW1aYXJDVDkrSmMzcFAvcUFLdWVGK1Y3eHY5U21pQ3RjeWUwNGVpYjVM?=
 =?utf-8?B?RTdZNEt3STVrUmZOVldIc1krVDhhK3VoSVZLNGNlb0lpYzkyaVBZZ1VGWElu?=
 =?utf-8?B?R1hSTzZ1Y244aXhlODJQK3pFTXBWM1pBeHU5eDhrV0ZzZG40c1Y0R2s2V3pt?=
 =?utf-8?B?LzJ3S0NlUVJoNTVZbkMrOC93Rzh6VEw1WkxuZ2tTajFDcVVtZmkxbGtNYVVs?=
 =?utf-8?B?Qm0rbittb3p2bmp2TVFrR2owWm1zeVIzQ2NrNFhTcjJIcDN2S0VjdWJMcncx?=
 =?utf-8?B?ZUNCUFJzZndBYStoR29DRHp3ZXhWelpXNFVIejNNeC9zWG1JamlFdEl6ZnpE?=
 =?utf-8?B?V1R3QlpMU1dLaDZLaWx1bytJOSttL2ppSVhPM2pXVHZJUzRwdGNLM0dpc0x3?=
 =?utf-8?B?N3hvY3VRQ0lyUFFGaEEwK0RJNEI2eUFKWHVLc2pRTENjd2pWY1FJMHlWSkhk?=
 =?utf-8?B?NTJPNUI1NlRkMElCbll5UGppZVJlMitmYmppZjM4RXYzdTF1VU11dFoyTGpN?=
 =?utf-8?B?bjJicVJrUmJVbDhaNTluQ0hWcGdtQUNyL2tlSUdRTkxDUVpQMnVUbktpeW1L?=
 =?utf-8?B?eFh1Z0trRXVUeXJ3Y0Q5cDdoMHdpY0NFSVZvbzBrZ2l0Zll1bURJU1lpYk9r?=
 =?utf-8?B?M1cwVzNCSzJxbEE1K3p6NXZFc2JIQW02eGs5eGt4MzdkRTQ4UGk4NkhaWGFn?=
 =?utf-8?B?TTkvTVRVc29LelYyK2RkcWdDN2F2WmpxU1p2MWlaMFBpNVF1RkNBZ2pGampv?=
 =?utf-8?B?aFBJZFhoaVQ4WVdPM3N0VzE5bkNSTnRDSlI0b3YrRlFyajI1UEtBby83TlJT?=
 =?utf-8?B?MEJUTThzajFmbzNPZmRLa2F2cHZNSmNpSStCWHd6Z3RSR1B5bExqR1VHN3Er?=
 =?utf-8?B?RmNyL1V6TWNVeU9vblF3citUMDVzVFJpU0tNOWdNWm1LTlJhcVhJdFV3TDBN?=
 =?utf-8?B?allTZThhcE1vNFVMRCtVSzRsNVJRWnk2NUtCSm5jU1hDeXB4SER4MUswcVYx?=
 =?utf-8?B?SmxldTNIV1NoYVkrTURtSUtDUFB4MWRFYlk0eVZQUkFtZ0ZPUUVCMU1ndHNu?=
 =?utf-8?Q?l6qk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2665ff27-dce5-4adc-4dff-08de151d5d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 05:54:59.1925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Ga4QM3xKKGaZ8YNIxezDYCjN3GfCo6qNnRr8JcpWiAxZ53SNLYiNZFUr8bhCthfnbQ/pYVgWIHCagtz+Tuhug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com

PiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gU2VudDogU2F0
dXJkYXksIE9jdG9iZXIgMjUsIDIwMjUgMzo0NCBBTQ0KPiBUbzogTGksIEZlaTEgPGZlaTEubGlA
aW50ZWwuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogYWNybi1kZXZA
bGlzdHMucHJvamVjdGFjcm4ub3JnOyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB2aXJ0OiBhY3JuOiBmaXgg
a2VybmVsLWRvYyBpbiA8dWFwaS9saW51eC9hY3JuLmg+DQo+IA0KPiBIaSwNCj4gDQo+IE9uIDEw
LzIzLzI1IDExOjIyIFBNLCBMaSwgRmVpMSB3cm90ZToNCj4gPj4NCj4gPj4gSGksDQo+ID4+DQo+
ID4+IE9uIDEwLzIzLzI1IDExOjAwIFBNLCBMaSwgRmVpMSB3cm90ZToNCj4gPj4+PiBGcm9tOiBS
YW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gPj4+PiBTZW50OiBGcmlkYXks
IE9jdG9iZXIgMjQsIDIwMjUgMTI6NDIgUE0NCj4gPj4+PiBUbzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiA+Pj4+IENjOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9y
Zz47IExpLCBGZWkxDQo+ID4+Pj4gPGZlaTEubGlAaW50ZWwuY29tPjsgYWNybi1kZXZAbGlzdHMu
cHJvamVjdGFjcm4ub3JnOyBHcmVnDQo+ID4+Pj4gS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+DQo+ID4+Pj4gU3ViamVjdDogW1BBVENIXSB2aXJ0OiBhY3JuOiBmaXgg
a2VybmVsLWRvYyBpbiA8dWFwaS9saW51eC9hY3JuLmg+DQo+ID4+Pj4NCj4gPj4+PiBGaXggdGhl
IGtlcm5lbC1kb2MgY29tbWVudHMgZm9yIHN0cnVjdCBhY3JuX21taW9kZXYgc28gdGhhdCBhbGwN
Cj4gPj4+PiBzdHJ1Y3QgbWVtYmVycyBhcmUgcmVuZGVyZWQgY29ycmVjdGx5Lg0KPiA+Pj4+IENv
cnJlY3QgaW9fYmFzZSB0byBpb19hZGRyIGluIHN0cnVjdCBhY3JuX3ZkZXYuDQo+ID4+Pj4NCj4g
Pj4+PiBhY3JuLmg6NDQxOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Igc3RydWN0IG1l
bWJlciAncmVzJw0KPiA+Pj4+ICBub3QgZGVzY3JpYmVkIGluICdhY3JuX21taW9kZXYnDQo+ID4+
Pj4gYWNybi5oOjQ3OTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIHN0cnVjdCBtZW1i
ZXIgJ2lvX2FkZHInDQo+ID4+Pj4gIG5vdCBkZXNjcmliZWQgaW4gJ2Fjcm5fdmRldicNCj4gPj4+
PiBhY3JuLmg6NDc5OiB3YXJuaW5nOiBFeGNlc3Mgc3RydWN0IG1lbWJlciAnaW9fYmFzZScgZGVz
Y3JpcHRpb24gIGluDQo+ID4+Pj4gJ2Fjcm5fdmRldicNCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiA+Pj4+IC0tLQ0K
PiA+Pj4+IENjOiBGZWkgTGkgPGZlaTEubGlAaW50ZWwuY29tPg0KPiA+Pj4+IENjOiBhY3JuLWRl
dkBsaXN0cy5wcm9qZWN0YWNybi5vcmcNCj4gPj4+PiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgaW5jbHVkZS91
YXBpL2xpbnV4L2Fjcm4uaCB8ICAgMTEgKysrKysrLS0tLS0NCj4gPj4+PiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPj4+Pg0KPiA+Pj4+IC0tLSBs
aW51eC1uZXh0LTIwMjUxMDIyLm9yaWcvaW5jbHVkZS91YXBpL2xpbnV4L2Fjcm4uaA0KPiA+Pj4+
ICsrKyBsaW51eC1uZXh0LTIwMjUxMDIyL2luY2x1ZGUvdWFwaS9saW51eC9hY3JuLmgNCj4gPj4+
PiBAQCAtNDIwLDEyICs0MjAsMTMgQEAgc3RydWN0IGFjcm5fcGNpZGV2IHsNCj4gPj4+PiAgLyoq
DQo+ID4+Pj4gICAqIHN0cnVjdCBhY3JuX21taW9kZXYgLSBJbmZvIGZvciBhc3NpZ25pbmcgb3Ig
ZGUtYXNzaWduaW5nIGEgTU1JTw0KPiBkZXZpY2UNCj4gPj4+PiAgICogQG5hbWU6CQkJTmFtZSBv
ZiB0aGUgTU1JTyBkZXZpY2UuDQo+ID4+Pj4gLSAqIEByZXNbXS51c2VyX3ZtX3BhOgkJUGh5c2lj
YWwgYWRkcmVzcyBvZiBVc2VyIFZNIG9mIHRoZQ0KPiA+PiBNTUlPDQo+ID4+Pj4gcmVnaW9uDQo+
ID4+Pj4gKyAqIEByZXM6CQkJTU1JTyByZXNvdXJjZSBkZXNjcmlwdG9yIGluZm8uDQo+ID4+Pg0K
PiA+Pj4gSGkgUmFuZHkNCj4gPj4+DQo+ID4+PiBUaGFua3MgZm9yIGNvb2tpbmcgdGhpcyBwYXRj
aCB0byBoZWxwIGZpeCB0aGVzZSB3YXJuaW5nLg0KPiA+Pj4gQ291bGQgeW91IGp1c3QgYWRkIHRo
ZSBjb21tZW50IGZvciBgcmVzYCBhbmQga2VlcCB0aGUgb3RoZXIgY29tbWVudHMNCj4gPj4+IGZv
cg0KPiA+PiB0aGUgZmllbGRzIG9mIGAgc3RydWN0IGFjcm5fbW1pb2RldiBgID8NCj4gPj4+DQo+
ID4+DQo+ID4+IERvIHlvdSBtZWFuIGxlYXZlIHRoZSBbXSBzcXVhcmUgYnJhY2tldHMgaW4gdGhl
IGZpZWxkIG5hbWU/DQo+ID4geWVzDQo+ID4+IElmIHRoYXQncyB3aGF0IHlvdSBtZWFuLCB0aGF0
J3Mgbm90IHZhbGlkIGtlcm5lbC1kb2Mgbm90YXRpb24uDQo+ID4gV291bGQgeW91IHBsZWFzZSBw
b3N0IHRoZSBxdW90ZSBob3cga2VybmVsLWRvYyBwcmVmZXIgdG8gYWRkIHRoaXMNCj4gPiBjb21t
ZW50cyA/IEkgZGlkbid0IHNlZSBhbiBleGFtcGxlIGluIHRoZSBrZXJuZWwtZG9jLnJzdA0KPiAN
Cj4gVGhlcmUgaXMgbm90IGFueXRoaW5nIGluIGtlcm5lbC1kb2MgdGhhdCBpbmRpY2F0ZXMgYXJy
YXlzIHNvIEkgY2FuJ3QgcG9zdCBhIHF1b3RlDQo+IHRoYXQgc2hvd3MgdGhhdC4NCj4gVGhlIHBh
dGNoIHNob3dzIHRoZSBwcmVmZXJyZWQga2VybmVsLWRvYyBoZXJlLg0KDQpIaSBSYW5keQ0KDQpJ
TUhPLCAgdGhlIHBhdGNoIHNob3dzIGhlcmUgaXMgYW4gZXhhbXBsZSBvZiBgTmVzdGVkIHN0cnVj
dHMvdW5pb25zYCwgbm90IGFuIGV4YW1wbGUgb2YNCmBOZXN0ZWQgc3RydWN0cy91bmlvbnMgYXJy
YXlgLiANCkZvciB0aGUgYCBOZXN0ZWQgc3RydWN0cy91bmlvbnMgYXJyYXkgYCwgdGhlIGBJbi1s
aW5lIG1lbWJlciBkb2N1bWVudGF0aW9uIGNvbW1lbnRzYA0Kc3R5bGUgaXMgbW9yZSBzdWl0YWJs
ZSwgb3IgY291bGQgd2UganVzdCBrZWVwIHdoYXQgaXQgaXMgZm9yOiAoMSkgdGhlcmUncmUgbWFu
eSBrZXJuZWxzJyBjb2Rlcw0Kc3RpbGwgdXNlIHRoaXMgY29tbWVudCBzdHlsZSBmb3IgdGhlaXJz
IGZ1bmN0aW9uIGNvbW1lbnRzLCBJLkUuLCBpbiBrZXJuZWwvcmN1L3NyY3V0cmVlLmMNCigyKSB0
aGUga2VybmVsLWRvYyBkb2Vzbid0IGNvbXBsYWluIGFib3V0IHRoaXMgd2FybmluZy4NCldoYXQg
ZG8geW91IHRoaW5rID8NCg0KVGhhbmtzLg0KDQo+IA0KPiA+Pj4+ICsgKiBAcmVzLnVzZXJfdm1f
cGE6CQlQaHlzaWNhbCBhZGRyZXNzIG9mIFVzZXIgVk0gb2YgdGhlDQo+ID4+IE1NSU8NCj4gPj4+
PiByZWdpb24NCj4gPj4+PiAgICoJCQkJZm9yIHRoZSBNTUlPIGRldmljZS4NCj4gPj4+PiAtICog
QHJlc1tdLnNlcnZpY2Vfdm1fcGE6CVBoeXNpY2FsIGFkZHJlc3Mgb2YgU2VydmljZSBWTSBvZiB0
aGUgTU1JTw0KPiA+Pj4+ICsgKiBAcmVzLnNlcnZpY2Vfdm1fcGE6CQlQaHlzaWNhbCBhZGRyZXNz
IG9mIFNlcnZpY2UgVk0gb2YgdGhlDQo+ID4+Pj4gTU1JTw0KPiA+Pj4+ICAgKgkJCQlyZWdpb24g
Zm9yIHRoZSBNTUlPIGRldmljZS4NCj4gPj4+PiAtICogQHJlc1tdLnNpemU6CQkJU2l6ZSBvZiB0
aGUgTU1JTyByZWdpb24gZm9yIHRoZQ0KPiA+PiBNTUlPDQo+ID4+Pj4gZGV2aWNlLg0KPiA+Pj4+
IC0gKiBAcmVzW10ubWVtX3R5cGU6CQlNZW1vcnkgdHlwZSBvZiB0aGUgTU1JTyByZWdpb24gZm9y
DQo+ID4+IHRoZQ0KPiA+Pj4+IE1NSU8NCj4gPj4+PiArICogQHJlcy5zaXplOgkJCVNpemUgb2Yg
dGhlIE1NSU8gcmVnaW9uIGZvciB0aGUNCj4gPj4gTU1JTw0KPiA+Pj4+IGRldmljZS4NCj4gPj4+
PiArICogQHJlcy5tZW1fdHlwZToJCU1lbW9yeSB0eXBlIG9mIHRoZSBNTUlPIHJlZ2lvbiBmb3IN
Cj4gPj4gdGhlDQo+ID4+Pj4gTU1JTw0KPiA+Pj4+ICAgKgkJCQlkZXZpY2UuDQo+ID4+Pj4gICAq
DQo+ID4+Pj4gICAqIFRoaXMgc3RydWN0dXJlIHdpbGwgYmUgcGFzc2VkIHRvIGh5cGVydmlzb3Ig
ZGlyZWN0bHkuDQo+ID4+Pj4gQEAgLTQ0OSw3ICs0NTAsNyBAQCBzdHJ1Y3QgYWNybl9tbWlvZGV2
IHsNCj4gPj4+PiAgICogQGlkLmZpZWxkcy5sZWdhY3lfaWQ6CUlEIG9mIHRoZSB2aXJ0dWFsIGRl
dmljZSBpZiBub3QgYSBQQ0kgZGV2aWNlDQo+ID4+Pj4gICAqIEBzbG90OgkJCVZpcnR1YWwgQnVz
L0RldmljZS9GdW5jdGlvbiBvZiB0aGUgdmlydHVhbA0KPiA+Pj4+ICAgKgkJCQlkZXZpY2UNCj4g
Pj4+PiAtICogQGlvX2Jhc2U6CQkJSU8gcmVzb3VyY2UgYmFzZSBhZGRyZXNzIG9mIHRoZQ0KPiA+
PiB2aXJ0dWFsIGRldmljZQ0KPiA+Pj4+ICsgKiBAaW9fYWRkcjoJCQlJTyByZXNvdXJjZSBiYXNl
IGFkZHJlc3Mgb2YgdGhlDQo+ID4+IHZpcnR1YWwgZGV2aWNlDQo+ID4+Pj4gICAqIEBpb19zaXpl
OgkJCUlPIHJlc291cmNlIHNpemUgb2YgdGhlIHZpcnR1YWwgZGV2aWNlDQo+ID4+Pj4gICAqIEBh
cmdzOgkJCUFyZ3VtZW50cyBmb3IgdGhlIHZpcnR1YWwgZGV2aWNlIGNyZWF0aW9uDQo+ID4+Pj4g
ICAqDQo+ID4+DQo+ID4+IC0tDQo+ID4+IH5SYW5keQ0KPiA+DQo+IA0KPiAtLQ0KPiB+UmFuZHkN
Cg0K

