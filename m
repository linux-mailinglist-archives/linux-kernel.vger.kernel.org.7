Return-Path: <linux-kernel+bounces-782771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87818B32520
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E1CB60609
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB3E2D027F;
	Fri, 22 Aug 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgFlj0eF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49FF8248B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902572; cv=fail; b=j3s35zmcBSbXsY4DLmubvC4IGttbFgYE5YuGuKnduKyBFJrB9HPSGmUbzTC4Q1IqhbicVrvpG5vx+dzF7TR6w9xtQHdlGBQmDrYv9A0ysUkEckHAJ3z9BkbJWOXCbOgJGdAmD0Y4kI0M+6AjoHzIbw6OwofEk7d7HYzYivJBDjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902572; c=relaxed/simple;
	bh=WCyuKtcrq1A9uCb7Egt8ON498SIQBJCWWCgiNHhvzMM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C0jJbAGdXQX79+lFSt3KcB0hl9GOHSgCIi4hl78SRS/nze5HPWqd7p1x6dQSvb9wkFdyawcEbp6H3r0P8h9MgCxpqyhkn4fq1JhS2BwITd5/SDHUI1uQ7/KgE3Rl9lZ1FOJPhGYU2FnDlhz4oxcChotVCtKM42lfXFQya6ZOkfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgFlj0eF; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755902571; x=1787438571;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WCyuKtcrq1A9uCb7Egt8ON498SIQBJCWWCgiNHhvzMM=;
  b=AgFlj0eFCPcRTyNKGwOk/CuqKQLmh+G4SXxg/bBcZ3Wl7hy9PZpqmrOZ
   GmXtZCCgVVFzjSaOoLqGAt2NNm11CeC83wsCMOa1mmMlxXXGEsm2maGoT
   Iwhvl+NS7WxMQD8WOL927usiP/HBqH8NRKEh2ZXmdoF7AiKIrX1e5h8lw
   zsdFoimUGwJJWhZCzPU8JFRTNfV12mbo+Ik9foFDGmRGmbKdzkcxhwfpU
   3If7VlerdOmA7pf9X8xUDkSupYtqbaeMI/KCQUcmcTnvnuXzkW67QDXRV
   YasBxqD1B2VzPCP3ITdgYjlptAHbguH09+Do4hRTrNQI+FRua2UyRmzp5
   w==;
X-CSE-ConnectionGUID: VNjCVu6ESMKd21UGfzsFlw==
X-CSE-MsgGUID: FdI1RRx5RyKXYjLgeyMCxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80813387"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="80813387"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 15:42:50 -0700
X-CSE-ConnectionGUID: EmOwhm3gS26YxwkJddJHlQ==
X-CSE-MsgGUID: PSAB0vaGTomLADyjmz2SnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173005069"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 15:42:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 15:42:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 15:42:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.86)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 15:42:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRuWIxKamneNAAw7H2zfrvzwgIWJk0OblVPJoKQxlALMjq7AsL3141IfRLUaOtx7pJg16mJAaz+1BPZm6QRH6kO0HnKSUcr/EWvptXcEkYn1PlhPbi+vxNSSYH88LwO2UfC/kX42qw7mm215/U85UQTh6Is1+8waRGdzAlrmp00dJmObQ/NvlVRHgDaOjlSDLHAroSv8cdCfGWbLyyjZ7bMJ34h//WctMeuU0DExCCTx/okbzrbNors75a3tzLcnA3Tm/W+EKebmPCFn4xces5MRkFhFRqmmGk1CZngw34AyHfAoQS28wWoum+10P0px1nMFs6DpBTgmuR49pzhIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktvTO9QUiNg31T2duchNW7GgaOIJ326F97kO936R0X8=;
 b=umID69UU+7sG75o0jWxBlXY6Qfj6+cVBHvpT/iQBRakMPT7O5ZyquI/oWY6wdmUlW7IQ0OKrdAKixo+J1+gFHbhzWEW+/DlTRKUrfvuVINRkLHSslMTWz25g0RGlq9F1Xb+JkFSsrrphVwmEEUsx0Vyckii9GKPI6dremne2Axi94GqXzq6rEuKZVRALkzrUFgzUVNYb27KjNJH1F5gi9KCJtQ8Uch+UVjQH2jz8kXihXN+VLjEjmMYctrylfke38m07swxz6Y4h9fMWlbIOxbb1Q18GRHkoolF2sQ9ycJyB3UENfsabTguXkzqfh/gicS3Sws5vgLAiC94nNogUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SN7PR11MB6752.namprd11.prod.outlook.com (2603:10b6:806:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 22:42:45 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%5]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 22:42:45 +0000
Message-ID: <5ff26455-b94e-463f-8f6e-e2a1375f4a9b@intel.com>
Date: Fri, 22 Aug 2025 15:42:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Enable staging when available
To: Chao Gao <chao.gao@intel.com>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <colinmitchell@google.com>,
	<abusse@amazon.de>, <linux-kernel@vger.kernel.org>
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250813172649.15474-7-chang.seok.bae@intel.com>
 <aKLl010zQ1dFn/bk@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <aKLl010zQ1dFn/bk@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SN7PR11MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 93008e31-a388-46a9-cec1-08dde1cd3607
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzVCdXFWeDZDTmhDUHNLTGFCeVM0bEcwSjJGKzU2OEVONlJXS3JDWEFGLzFl?=
 =?utf-8?B?NVU0TWV2d01mdTEvMGlta1d6Y3MybkUvSEV1VlJ3dDdqd3k1ZHNHREhLM01D?=
 =?utf-8?B?UU9sYmNaV1ZVd1FqS3pkZ1Z2TStvaGVYU1VwbUM5dFpDdVBZcmRGcjhOOE9u?=
 =?utf-8?B?ai83QTRJSXAvRzFMYkpVMDhoZmxKSDNVcU15VUUxVVdZWFFMQnVNaGQ3TERt?=
 =?utf-8?B?aDFkaTFCcktRVzdETSt5MWl0Ymd3SHF1bU1lRy9PZTM5cEpXaHZQUlpMbUk3?=
 =?utf-8?B?QzJKRS9OaHBYOS9nb2kxV2Z2bkJOYWFINmxSN0l4K04xZEd6WEpoSDBJczRB?=
 =?utf-8?B?ZCtIN3lzOWovY2NUWXhhd3g5cnJmU3BkNmRyMDA4bEN0SFhRQkpxTmZzUVND?=
 =?utf-8?B?dnhka1FXWVMrVzRkVml1KzJWdC9YbHp5RVd0SG5CN21uWmprQjFLT05KbGJp?=
 =?utf-8?B?bm43d1JxMDNkYlc4bHlGd2hJbnhjY1EzRFMra2dYMXhqS01jOFcwdFF2bWtY?=
 =?utf-8?B?RFhER050NitvUVdpMCtkNWsvQ0UvNERNVXY5eGJ3OVBNTjBHaGJoOTVKS05C?=
 =?utf-8?B?RzZ1UHViUXhiTzBGWnVGTXZqcG0rZXVLZ1llamUyMkVvZWpSQmtOSG40MDNF?=
 =?utf-8?B?WUpoYjVGdjlLOXhRVnBOczRLSEdpVW0yUENlZStGMWkzcXlicjlTbStaaXNE?=
 =?utf-8?B?azNQdFd3T3E0YXZ4TldHQWNqdmhpVnNpMXQ3VjdudVN2Y09KMmIzSGcwdXVD?=
 =?utf-8?B?OGtaampmVmN2WVBtMDNHaDZDRllQdkVkTDU5WE94UXB5eTJwdjczSklnV1pp?=
 =?utf-8?B?L1gyd2FrSmlrNlN6ektaVUx3UUFiK2JTUGJ6cFU2M0N6UjJ6UHVEV09wOWE2?=
 =?utf-8?B?clZRZlZmK2FZWnRiL1kyNklxV1lNc3ozeXdpNFlnKzFyd1Q0dEVNU2dUd1o5?=
 =?utf-8?B?Y2wvZnNFY1AxTDUzdU9TcFlYZS9EV25MS3FRL3NzR3ZKalA2M3pjVmxxcGpq?=
 =?utf-8?B?VjJuVXZheHp4c0pVb0hzMUpXYTJFd3R1YmxnZ3RQQXZWemJDekYwM0RDck4v?=
 =?utf-8?B?M2ZKMk8wU1AxUWNObmwxcXlLTXJJMGgxUFpVSTM0UmtXTTNua0tsMmZEdjBD?=
 =?utf-8?B?SVl6VkdRZUNMZXJZNnZjQm1yZlpvUXJ0NnZUUGorcEd1WEZQZEk1eG9PemNL?=
 =?utf-8?B?bjhrWms0M0J1TjBkYW0vVWJiVXlnNEVNdGNGdCtZY0NuVFVJM29PR2lNV3Ji?=
 =?utf-8?B?U2l6MkNoQW1JazkvdUhiMkhnZUV2RWt1Q0o3Y3dCRjRKbTdwMDd1Q1JXc0pQ?=
 =?utf-8?B?aEtETE81TlVGWS9wUnVoZzJKOXU3OWhZSElOWHNMbll0bFduMHZRTWxOWUYz?=
 =?utf-8?B?TmtmMmw5bTNzdTNuWEtuR2JEc0xxZi9DQzh2Wld4ZWFzSkVPdU4wY2N5N1Jz?=
 =?utf-8?B?MmZMZXlsaW9MdTZXZ0NqbCtTenZMaUlhNENDMm1HUUNMbmhxRVRkcm1MV1ha?=
 =?utf-8?B?SnB1Z2ZDOFpLcVdEb2JDbFUxZUdwVnNXVjlucTFLZC9IekJXRWtNM21QUGlS?=
 =?utf-8?B?M3huc041WnlNY3NWR3hxViswWFZuOVBSL3FUamVDYlN6L2xubTBJTGVRdlpF?=
 =?utf-8?B?YWNHTXozSzdaODJwTEE2Z0ZlTHBaRnpFMzdid0F3OFhLNDM4N3F3Y1JKZEh1?=
 =?utf-8?B?d21hNncxNENhbGF4b01nTTl3Wll1bUZ6ekFUc0RWRDNPRXkrSHBUb3BCb3NE?=
 =?utf-8?B?TlcwcHRXYUNGVkR1QUQ2aHpXNk04bm9jL1NEaThRc05zYzRSTE1MdjQwTjJM?=
 =?utf-8?B?RnJaczUzRGttcE1ISE0yVXNERFRkVy9YQ0J4bHZqUVNVWFYyUUloNVpiSWNV?=
 =?utf-8?B?bTdlR0ZFUWs4OEtMbWlDcnY4N1FrSGVvSFlzOGl4SUdWYjQ1K3VQdWRha3pw?=
 =?utf-8?Q?5hhAeb36p+I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBNNUt1KzNlZ2d3d0t0aXdybW1WZDVtMGlvSGJUOTRFMzNENnB3aER6Rnpo?=
 =?utf-8?B?dVhvUXdaZHFGVFptL2I2VUtQNVRyR0UvZERSVHhjOHpiY2ZRQVdGK1d0NHZ2?=
 =?utf-8?B?VXF0RTA1Y3p1bFN6Umw4djdYWU42U3ZYT1N3R2doVGRtRDIyVjAzYlpBa2px?=
 =?utf-8?B?RUxrUEcvcGU5K0hnY25uTlB2ZTlHSVlZVUtWUnFKekxiZ093b2pRaXRJd0li?=
 =?utf-8?B?ZGY3R01BQzA1R1h5N1FCdW9McGtSek1hNnpQeTkydFNTR0NycFdxQlFhU2ZN?=
 =?utf-8?B?ci9XN1RmWmR3L1hIVXFiZHBZS3ZEQXczY1RqK3dLZ2hEbTQ5T2hRcmNVOHJi?=
 =?utf-8?B?Zms2TU9mQkFLRU5lMXNOUWgxUzE1MTZzekU5YllFbGtqTk9RM1JYcW5DdWpZ?=
 =?utf-8?B?aVdwaHk1Um5BSVFjT0YyM2VUejlvY0dNbFYrOVdQR2Q3SUNWU0ZSWkhXNGhF?=
 =?utf-8?B?TFVKblRVL1MyQ2Q2L0RGb20yWWt6QUI1UEE0L1NLUXRPUEFoQ1FHL2dxakla?=
 =?utf-8?B?T0ZNek83aU5Ed0ZlOTNwbDRVVEJOb0g1dzcwQTROTzVSc3F3RUR6UDAzQ3Yz?=
 =?utf-8?B?dTM2cmVmTTFUTlNuVzZVMzFEOS9PbGRnc2NYWVdLeVhjSVBrWk1sSTVzV1lp?=
 =?utf-8?B?ZmxwL3NsWUpmdFBNZ1EzNVJIaEJZY3J1NkZ4cHVkQWxkUUwrV3lOQ0R2NzRS?=
 =?utf-8?B?V1J5VS9tUHNGQ21OeDdmRXNIejFXZ1hKUjBKUHZOYW5nR2JjcUdTOUNFeFRX?=
 =?utf-8?B?MTVaWHlQNDlPQ3ZxWnpZcDhZUGJFM3Bmb082RUdiQ2hwT29VV0hVYlV2Qzlu?=
 =?utf-8?B?Nko1VmdieTlvWGlwY0tnbVlvWlNuQW1kMkVFVzEwSDZBR2xydXVEZUNramJH?=
 =?utf-8?B?NmVRZ1pmRjFiMzZJdFgrcThpMjJGTFBlTnBOZjY1VnBVRlhBNWtrWWFaVEJx?=
 =?utf-8?B?S1RoSytaeS9saW96SjE1UGxMWHBJbGJjRGxhTGk3MGt2TnFtM0VrZ25PV0NG?=
 =?utf-8?B?Z2Z5enVkQzZRTUVmNjRpUVJIVTJqWE8zWnNLNHJjSGxZSjhsdU1WVTExMkhQ?=
 =?utf-8?B?SS9kWW5aTCtxOEsrZW0rNFpySVdwWVZMdnlYdFZDVXpWZGc4ZnpIVldEbDVY?=
 =?utf-8?B?S0VVZ09ReVZBdWdzaGNVeG1kQWcxcnhCSElwbVNkcUZiTGY0bzhEOGxlQ3E2?=
 =?utf-8?B?ZGdTaEcwcnAyTlNZcWNpTC93QVA3SFpEY0RrbVQ0RzRjQmdORjhtdC9zc3dh?=
 =?utf-8?B?SG90OGxQZDlZQWNncXZQSGZ3OFJ0YW1BMEY3L3MrMk04VGJRSWlsUGc0L0hy?=
 =?utf-8?B?SjV1SkhCNURjL251R0JtajFEbEN1dFlUcW9NMDJFRUg2aHRhUm8zMFlIM09h?=
 =?utf-8?B?cnVZY2x0UUFRb0JxWFVScGdJTFNaYmh4NTZ5WHpxU041SGN1dmZKOE1xSzBI?=
 =?utf-8?B?TnBMenBCOUJjUjRaOFJNRmpIN2gyb3VVTlg2VzZuQmVzMjVrUlFkelVWZmd6?=
 =?utf-8?B?L2dpUHFBZ2c1d2ZWVXNXWmhCamlneVc1WW9QUExrbnF6V3NSeHo2QmliNXZ1?=
 =?utf-8?B?Q29OdG00emQ1cHhteDZGVHRHZlUvTHNoNzhYZ2F6L1FlSCtoeDZZalA2YXJo?=
 =?utf-8?B?ZmRBazlyMlp2cHpLSmhCWEhUNk9obGhrSjIxS0FWZWszelhyQk5zbVdJak9n?=
 =?utf-8?B?WTIvMG5xc2xLVUJ5KzlOTXhwZlpiTmZtQnd1QjlEbmcwajhkTFo1SVJoMFd1?=
 =?utf-8?B?TjR6b2E0WFhnQkpmbW9ycC8zdCsxY3I5WWd2RVpyVnJnNzRYdVpuR09TZXo4?=
 =?utf-8?B?MmFaQmJiY0I1RzNna1pHRm1PWnZEb09pTXlKa1RFN1pHamFLTHFTOTE5S3NF?=
 =?utf-8?B?eTFacGhQd0tQQXR3SXdCNVh5L0JNL0xUNXZQU3VoZDMyL3lwUitLZjduUzRW?=
 =?utf-8?B?QUorZk1PanZsQUlmUHBXbW4wVEFxdGE0K0JqeHhuTjJZZ2JKdkVFTUlpcHdV?=
 =?utf-8?B?ZEVTczcxNWJIMVdOOEk5R0k0bzZBYXVKTjdHeEV5bmxJVmpWWFQyNHFJaFdB?=
 =?utf-8?B?RXozb2dpTWcwVmxsUVNzL0F0SGhwRzg2bjJUUE1VcFhnMEsrc2JCbVJXS2hw?=
 =?utf-8?B?bGl5WXplYWF5ekROZzJTcjlrbDRob0owUmVxdU5pVFhOaXZMY21IK2I0M25l?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93008e31-a388-46a9-cec1-08dde1cd3607
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 22:42:44.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwLPAmmtFsXr8c2S92u8EMCiccECxAAMUQry+dLf+RGZfCeo3y1Vh+v/tO3nuNjHVYOj/pTTiZIJsB1rAYWIbQGQ4eQx3cwPFAlrj1o3PTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6752
X-OriginatorOrg: intel.com

On 8/18/2025 1:35 AM, Chao Gao wrote:
> 
> Reviewed-by: Chao Gao <chao.gao@intel.com>

Thanks.

>> +	rdmsrl(MSR_IA32_MCU_ENUMERATION, val);
> 
> nit: s/rdmsrl/rdmsrq
> 
> rdmsrl has been renamed to rdmsrq.

Yeah, right. Thanks for the catch!

