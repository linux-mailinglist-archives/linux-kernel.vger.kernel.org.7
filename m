Return-Path: <linux-kernel+bounces-799289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D9CB4299C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3653AF8B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758802D7DD5;
	Wed,  3 Sep 2025 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E3227o7i"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97F3FF1;
	Wed,  3 Sep 2025 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927017; cv=fail; b=K0j45HWt4CZ10UX2fVJXzhQxzSp8paBZKVce1ALC5tiiDia/ATByCYUzb0YpJQi3PMcBcvahHiVcRrADPuF39mixCN/L6mu+JRaGehQPsPCcLyBG9XcBM0ZdYBIqFhQW1wL284ApNE5CUqn7nPpfF0mheDgTCddpAS5LsMXTScU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927017; c=relaxed/simple;
	bh=zsKf/AFi46/RkTkjdunIGZSlvbY2KMup7EhqPWHQMJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hkj085walum2aleeEy/1nrVPonV40kBT2YZK+lwFe7HfO+GRNF8hNgXSof/gC7aG9ZDbC7O3YT/w5ESSCTd0Dbz3pmLGXFkjkUuj8S07Y5f/kE7ZVG7PfYIfBUpsSocDlflP44ikzxCW0pkOD4JgP9Rfl3LhzB/XaoF8XE4ww3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E3227o7i; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAUA3qxd1b1dYw8blnwj7qbwzcsTaBEtbZV80KqDipiLN0cMstf3C8GQ4007+sgF3BZlDRffK1FA2XamCZT9rWOBoH8+tWE/7I0qBGGlfPaJZkwcYqU/CprkIwC047KsLP20CfvEgFu5NvK5w8lP/UD6x8apgpyEhXV1RBbGqe1NkfvurCFnjhb3PKAW+klyPF2RVLz2eLsPOBjTT8i7q1+4DLOJcKRYiWpUxdvwB4BsKtLQQmtwZBHEpn1Sga5FqcEqCyrKpqotLYWDNKVgDBmJSAsxH+fFbPz4b+0j65W3AfVtFDC6FYqVsitdlLFzbZxd4A5tjoEZXx7MXsgvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzUkWm1XmgHdYEWbSPJCEua2egv+gMYD02JeeOr82Ns=;
 b=itVDr5pYo6KrQ9Rs/TA6hT5qBTOP/qgiGVZcx9BwsS9ttkTqZQNLzbiInwwEP2zf6Gbrtet5a3fE91QbBG5dvkQA61bUogeF6tR/MQ82IJne4y4cgtwIu3ZykLnwROpVsW5Kmzedu0Q7uSE7u11OnvmH2Ozcpgk4S85TuNIDzNqUgppBlGyb8NUor9wWbKokJhF2mxUuQqt7VD4Hy2oHtmpfVlH/Wv4XDgmB4TczpiZxw3D22F84KLn8CJFuS8Jos2dzGY0djQQlo6Y0sk1HOe3SZOJx2bLfPesVkJkZaWELkTQQUkLTgUF7G5pKh/LltCb6EvS7bsilPIGTv7JgfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzUkWm1XmgHdYEWbSPJCEua2egv+gMYD02JeeOr82Ns=;
 b=E3227o7iOX1lXKHxsavaX9LtqH4YdU+1OCPevBJksjr+DdeyP5RpzD4CsIF6ZFBcjARhQBCubS9XqrNIn0iwKvrrZ12mfGs0KdX4YTuBzbhMKvECStHA87AikMXfPOO9nQJyQYlgi7y6wpsloQ9eWHab4tOGnFxrl4AXEWqqa2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by LV8PR12MB9451.namprd12.prod.outlook.com
 (2603:10b6:408:206::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 19:16:50 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 19:16:50 +0000
Message-ID: <0bd46b44-8df2-425a-9ac9-242272e7a1a7@amd.com>
Date: Wed, 3 Sep 2025 14:16:46 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v17 28/33] fs/resctrl: Introduce mbm_L3_assignments to
 list assignments in a group
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, james.morse@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, rostedt@goodmis.org, paulmck@kernel.org,
 pawan.kumar.gupta@linux.intel.com, kees@kernel.org, arnd@arndb.de,
 fvdl@google.com, seanjc@google.com, thomas.lendacky@amd.com,
 yosry.ahmed@linux.dev, xin@zytor.com, sohil.mehta@intel.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 mario.limonciello@amd.com, xin3.li@intel.com, perry.yuan@amd.com,
 chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com,
 gautham.shenoy@amd.com
References: <cover.1755224735.git.babu.moger@amd.com>
 <ceb6a32f3d539fb52f5271242a4fa68b1a173279.1755224735.git.babu.moger@amd.com>
 <c7cfadb6-4751-4ea7-b602-896334014411@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c7cfadb6-4751-4ea7-b602-896334014411@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::43) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9d7cc7-5e1a-4455-2a80-08ddeb1e6f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFlrTzJIdk9YTmdtMlBYWEYzdFB1dW90bWowQjkwNHdVaExmSzl5WlVGT1FP?=
 =?utf-8?B?ek9HN2tMN2k3ZUdveDI2VmR1QUNpSlErNEpiZUFnOUhXbnF2VG84ak15V21K?=
 =?utf-8?B?U1MvZXRPUk03c1p3UGluRHNlcmllaG80RGkzaHBCdnBYa21xRnU0eTNCSEhm?=
 =?utf-8?B?SXBEOVkycERtSFNjVnQxUnNmUHFCRlI3d3RLNTlhV2w2UTJEWjUrVjZIeDhE?=
 =?utf-8?B?V3NOYklQTXNyekl6TDVPcFN6WXVibTkyZGQ5bVpRdmZVQlN6cEZVM3VKOFk2?=
 =?utf-8?B?V0lFaFBvSEZZM1lTeGZ5bWsyNXByU0twdFRoSFBHR0lRMlFoblQ0eEVHVDVL?=
 =?utf-8?B?V1d6dWorQmVFbE5tN0FoNjZvUjlpRU8vZEdjQVQ0UlRqL1FrVEx5cWpUUEdj?=
 =?utf-8?B?eWZVTWFWNXRFZDcxRzVRcW9hNFNHTDc3dllVK3hnd0ZEMEF1K3BWM3pabkc4?=
 =?utf-8?B?MTdNdS8yczdyWVhxYjNrS3owZjZlMEpmUHB1akllLzNWUDNXZEUxK21oRG11?=
 =?utf-8?B?bW53NjFKZDJsaW44SjdaQWNYU2tnYXBPdUlyTW1pN05lWDB0ZHFiNGF1ZW1U?=
 =?utf-8?B?dVYwSUR0ZWsyMXQ2YUt4M2UrNlBaUGtsdlJqQXlYOG4yTmpMVWpBSkh3aEtu?=
 =?utf-8?B?VjNUb2UvZEF2YUY5NUtPY3RDdldpd2xVUUZDTUo0Y0MwbmorNUhYejROOWNP?=
 =?utf-8?B?Y2NSN2djMEExWnVFdUpVbGVxeFRQNm1RTXpZNWFLL2hlTVplUFFvMHY2L2tB?=
 =?utf-8?B?RkFkZ3ZtTmpJM2pPUlFBYzZId3gyQ1FVcldiUk52N2VBWEZpR1J1TUcrMW9U?=
 =?utf-8?B?Q2I0amFqWUo0eEs0ZDRCRzBTTi8ybVVFZVpEL0llYzFMdnZrODNUdFRNMUZQ?=
 =?utf-8?B?cllhRUIwQ1ZOVGNjOGNGeEU0ZFU3RjFPcWtFMmdxNUZ4dnVNelB6dnllbWgz?=
 =?utf-8?B?dDkrYWVLS2U0UVQ0Y0gvaVZVTnp3czFibWJrMkJ2NzMydXpJRUFZTGR1T21M?=
 =?utf-8?B?TlplczdLaFZ6YnJmaEg1Z2ptU2ZoOFJmTEg3cVpJRXlIcGEzeGFxSERMSmRq?=
 =?utf-8?B?SUQ5aE11OEtpc3pKQmdqTjlxL0VUdCtxYU80N2x5OGo0UHFTT3NHVVY0NldN?=
 =?utf-8?B?cXdtdmh5Znh6bTE4bVc1MGNRR1pZMC9OSXlHWERNNFNNaWpYMVV0TlBiM1h4?=
 =?utf-8?B?RnNqbVNOK3dWcmdleU4yeDhaSkR6aDFDM2ZNd3ZjUk15SnhzOEpyUmV4SS9Y?=
 =?utf-8?B?aFdwYVlqU2dqWmpvcTU4SnRBQUVrWk56L2hIZHVySC9WVkk4blN6NGpjTDMw?=
 =?utf-8?B?WVh2MnVvZ1phaWFkVGkxYXRVUjJ0YnA0NTd3YWRqdXcxTExzRzg4SXNwMkt6?=
 =?utf-8?B?THFsblhmVzdOMjRjTk1JSXJZVmNKU2U1Ykx2bkp2dUcrc1FCekdLeGZUR3dv?=
 =?utf-8?B?WnVmL3QrK1dLOVhwbEtobnh4NHlEUmNOaVBNeWU5dTh5ZU5CaGZ1ZFFEVVNS?=
 =?utf-8?B?S2RpTXNvOE0rb3F5V1dYd3pNM29od1p2ZTF0V0xNbDgxNXlDcmdoS2U1cXIv?=
 =?utf-8?B?YUhLK3A3U0NQMFdLTGJjWTFPTzNkOWx5aVc5MFBQc1RPS0VMdzlBajVwbW43?=
 =?utf-8?B?eldRNE9wWWhQbm5lV09ibW42K0NRaHlTY2Y1U20rRXdsclY5TTB1Szc0Wms4?=
 =?utf-8?B?OUlITXVyNmxnU3hMMU51cU56V3V2UkgvS0diVEQwM2V0Q2toVUFJS3VHUUh1?=
 =?utf-8?B?c0JSR01JbWNmelc1cmVHdzJaU2Y4cEFSZy9JN01oSEdJV3QrTnU4T29yTzhD?=
 =?utf-8?B?YkpiSnhnTFVFYk0xTUpVQVcvT2xWdW1lWXlvUmVteEd3SmFsMU5WTmczME1X?=
 =?utf-8?B?VVlLaFM3RFFjRWlLNEVZcXdBZmZJMkMvc1UyTzJ3MVZJNlpoOUNWUFkrT1JN?=
 =?utf-8?Q?JshLP18UvWo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkpieDhxUHJxWWF5a3Fld0VVVWp0RUdIR3VRbnhQOGIzNmxyTzNFYnQ4eWI0?=
 =?utf-8?B?NDVRVGt1UmxhaS85amxHdHlNYmxSWFBOdXNKWnRYOEZwSHQ3TVBPWGRUOGpO?=
 =?utf-8?B?MThXVjFxR2RxaGtSK2I3MS9DYlRMeTd0MDVFRTNCRmpRb3ZITjhSN1c4TjFD?=
 =?utf-8?B?VGlsVmQ5WFFSYXlrdnNpS0w1aFpuM0wwMHpFZk5FcnlVbG1meGdOUDJjbS8x?=
 =?utf-8?B?NzRPODhWY1NUbGx6SHZrUkdHTVV5Y29rN1doSm40a1BVdnVuRzRJbGpqZm50?=
 =?utf-8?B?WWlZMHhsNWpmZ1JyYmp4SW1ZTTl0aVhJSWhyWm56TktZM1FoOWoyYlllU2xs?=
 =?utf-8?B?R1JkS0VpZGxkYTdnWUlqM0dWSXNTdGh6YnRtVVlVeTJ5Zk1Rdk44Uy9nYmdz?=
 =?utf-8?B?dWozZWNmd3dnUjZDNlEvQm5YUlovYkdZMm0zWjZySlgyVUU3Szh3SkJRdEZU?=
 =?utf-8?B?Vld2WnlWOFhWU0pmZGdqbFJSTUw4VlE0V1pmWU1aOGtPenJyWVNVMHdFek5W?=
 =?utf-8?B?NXNwNnB3RWJPWHkzMUlnRHBjQ3o2ZUNnUlFFYWd5RUpQbW5UMkxEclJ6T1V1?=
 =?utf-8?B?eFh5UzF1NWYzV2xmdmxleCt0STVoZFhaRDM2K000cHF5TjJIbjJnQWRHWEls?=
 =?utf-8?B?QlhzeW1oNFVaTG1zeEZTWnJXeEVTdmVBUysxUVo3OHdFc2JHWVFEQmFYOVpE?=
 =?utf-8?B?SHgzWEIrSlF6enhSZnlZVjZwQVFZTHBMRnl5WUsrdk9ZN2d6VmdUNFZibHh0?=
 =?utf-8?B?eHdrVjU3UXovSXJFV1hqcFRsM0ZURjZ1cGg4NjhXR1dXWkdUT21YSWZWWXdv?=
 =?utf-8?B?VERZbDREMWM4RHFUYzBxR0U2bVJ2eXZGbTdXYTF2dFFhcUFPYThpdlEzaHZI?=
 =?utf-8?B?YkVQdkdoblpwUWwySXJPbU53cFhGMjVmT0pSTkxSSlJ0LzRndmJ4aDhIMjlm?=
 =?utf-8?B?dnZNT3Y0RnA4aUM1alBuamJVdWR6dm03RnhaRC9KOFRCcWlJSm91OGFIVWpP?=
 =?utf-8?B?YUsrMFpxcExPUTEyR2VPR3l2RHlwalVGNk43Snlpc1hDRmZBSlBxVE1lZlov?=
 =?utf-8?B?RUNTSm1HOWVOVjJmTVZ6U1RjVTFVd29PN29JQWdNSmxZKzA0b3RtNUpaN0pQ?=
 =?utf-8?B?MHlyMkJ3NU90T0dudmlpV1doNkxIeWREWjdlZTBHMU14VThUcUl6VjkrV1Iy?=
 =?utf-8?B?ZTNvSlhlRVlKSmRHSVQ3UXpPNE1VYjI5WUJiaW52Y0NhWk1FTmt0cDU5amUz?=
 =?utf-8?B?S0hLQy8vK20rbnFvdFQyaEVOMWhnelV5SGV1YUlQK3YwTEJmRmE0Q2tRNDhk?=
 =?utf-8?B?YWlZMUNOUWpXNWlFbGZqb0kraFQrd0Q3bmlmRmZYOVhqQ2xUU3JzY1gvTXVV?=
 =?utf-8?B?b09UcHgzOGlqVjZCUXhuTEJURmx6THpuK0J0UWhVYUU3ZlQ1Y1RCc3AyYzVS?=
 =?utf-8?B?SjROMEtPc25lV291TTlBeGlKM1BCRFg4NnNKRzFHRWtnTWFDMjd3cGtzWjdp?=
 =?utf-8?B?ZTZnZWZFZUR4TlAxNllvWFd0VG1JY21FaHQ1YWszTHJTSHJ2eDhNSTVYMjlE?=
 =?utf-8?B?Q2FsbnZjSUZ5bW5ZcGNDb1grMC92dGtqWDlFc3Q4U2JsTCtBZjFXWjJJWmsw?=
 =?utf-8?B?QXdBR3lxbHdKT3VORmNHaVYwcWdKN244SkdlRVBtcnpaQi9GdFNWZjZKSXBR?=
 =?utf-8?B?UlFXSHN4Tm5kYzdmZFd6Z3FPYmV5YU51aTlyUUZzWG1wMWlRM1pqcytIZXlr?=
 =?utf-8?B?OXZYVlJmWEgzcGlrVlk2SCtXTHFRT3AvdTU5TGk1WXAweUZENlJjZ3lOSWRn?=
 =?utf-8?B?WXVaNG9SYWFGckoyTHVoTkEwdVFkcmtpNVBwNVRPWUpUK3cwZkI4V2U1Z0RO?=
 =?utf-8?B?VDBOU0VSRjc4bGdYRzNYckZxSktBZkRpakgxemVZT2w3U290d1hRYTlseE5V?=
 =?utf-8?B?Q2xYNm9heFBsYWpOUnUwOUVkMTIvSzNVWTZKL1ZHUGxFcEsyTXByakE1cG9r?=
 =?utf-8?B?QnFFQmhHbXBGZXp3VUdLemJjZTBvaUc3ZEJlQTVVaitDbTI0TXZRRTdMSzRq?=
 =?utf-8?B?NmZjc0J5bzRsM0I5TFVHMk9tajVQMTV2VytsUHdEaEVLQ01Wa1lFTlVYV1R6?=
 =?utf-8?Q?QmpA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9d7cc7-5e1a-4455-2a80-08ddeb1e6f1e
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 19:16:50.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3hxlnmar9zCoJ853KNEV8aphaBHTwMkJboBIWwsCTIKTKNLs1rok8EEdQLHTP7I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

Hi Reinette,

On 9/2/25 21:59, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/14/25 7:25 PM, Babu Moger wrote:
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 1de815b3a07b..af0c38206bab 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -519,6 +519,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
>>  	/sys/fs/resctrl/info/L3_MON/mon_features changes the input
>>  	event.
>>  
>> +"mbm_L3_assignments":
> 
> Looking at the final documentation this addition is made in unexpected section titled:
> "When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:"
> 
> How about placing this description in a new section titled "When monitoring is enabled all
> MON groups may also contain:" (note the word *may*) under the "mon_hw_id" description to complement
> the earlier "When monitoring is enabled all MON groups will also contain:" (note the
> word *will*). Open to other ideas of course.

Yea. It looks right place to add after "mon_hw_id" with the new section
"When monitoring is enabled all MON groups may also contain:".

-- 
Thanks
Babu Moger


