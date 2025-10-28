Return-Path: <linux-kernel+bounces-872940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1161C12A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999DE401950
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125119DF4D;
	Tue, 28 Oct 2025 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ba8Jk6vQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700E16F265
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761618626; cv=fail; b=Q1auMtOqFCK3wJcq19iW1qJmY6M5lw+ygOkVMUqpWECVjzhP7OJ9JVEARAYdLGpcj2Q7k1AldQ2c0MQgXPGbVoQrIeDMKIgbPOO6z68NvIsJpbYGBSgcxtJwu2aAyZHWfWcNaGwsO5uoeFO4iIc+lyYwZ6ZVwwfdctjzNt4qZkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761618626; c=relaxed/simple;
	bh=1YarWfgPNryB9vaxPdmrz23ND+ampQvBYMLqdcNJjBk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3BQYrvi08u+W6jsR4O2ahH6DrygwEnWVOnLxvhDbFItr9j3bOutODF+CGSXOBaC37fHJ9ofXufaSD3AdJmeTA42FIAREr67f1YUX1EG4cG3FJ/xxi8r9rJ1LbbR2l8oJp9FkOjqMrSW9rt4pkdPHA9mQ3vE4wMFAqV8ErC+GNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ba8Jk6vQ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761618621; x=1793154621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1YarWfgPNryB9vaxPdmrz23ND+ampQvBYMLqdcNJjBk=;
  b=ba8Jk6vQcWSo4uyWnzbQpMDYuB5UzJbVgrLWc2NrQ4KYFXWwhwUvcoNy
   jrOrOjFd4mbTjdkyeAXcEuSC8SclnD5iA3eFgzHm5tOIzGLjycl8d7Azg
   nkXrYVA1lByVasiFCt+XGJGC1XlICz/xHMER4mDKlfRnCz79uQzFHsLz+
   RPVz6tdxRM9P5ww4gEB6+f9qLWnXgTJEHusvZHJoMEkTxnHv4ACAtQSp9
   XlIje5o6AraYv+UewNADh90uU//Gpt0EyfQYWArFTzUjJVQIschm+3VNc
   xHryRNcwDKUw2HnGt9mpEtekV/2pDYSWegyCXo9Q+V9Tv2XWxpu5oktEl
   w==;
X-CSE-ConnectionGUID: WcUNH5xcROaqexQWX1JMHA==
X-CSE-MsgGUID: 6HWn7jnLT2+vo7nVRSVE2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74830168"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="74830168"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 19:30:20 -0700
X-CSE-ConnectionGUID: sw2K4bCtQymlHjgW20ym8g==
X-CSE-MsgGUID: Epj+YQ1MSPKszaZVLEpbbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="184445443"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 19:30:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:30:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 19:30:19 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.50)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rocROSPfILeXvR9B/YWHxh6oUnxuXA4hs8SWVC3riVEv3u1f0RYRGIbHdOBDdXF9GhGYXefuLWVoNRQckhJ+6zb7gROvNYMcRFk9+veBaq8bLjHnIe2epSCcYSZ7582xwpFIM0cdMC206wYQ2dUJfvGPXjdobAMkNOY/3N7Qweu9OjFzb/m88ezKppUl39N/Nomu2uKhlji4p7P/EYklHLJ1dbp93lKJ07oYILOsopIb3kSAA5OA4hC9zPqTyvakw/6zxF9KMgkGUcv5Cppwdwp6K9TmU0wEOSyeT+k9d6l1zk2HUYfe/9mgd13wzVjByHIgTs/A8udIjp8ugbR3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NgPzTtrMn2P5Fod7p0GW1RAUIOJRTvEPp99+BDaV+Q=;
 b=AQKN738nEBgsbUsh5mUTF6UF66hgZjw6oZtKjLVghxyhd6qCXq2TMl0rp089hbvvpy0DbWMhd86UDkW64Lc9CTLkqmsF3SA5TpESC54E8CSpij8/dfClVW33/aLqTJSx56OmKOG9F3IyMTNaI7/coFKIPrpqrp4aSJhTZ+SkXcpiPtLU2a4A7hPB1Cy4GtruxKuLKkwc2rbz9lLpaUCcPqhKtAwuA7nHKExMSlcvVfY8hOMCd27kzwFm4FL+l7+/zBC/oZkReTxak4Tfm9YGjVJHE99Ehtzqq61/61X68yzYJSanWZLYvj/bj0GE6yViG00af6D3pWtJddiKfaWuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH0PR11MB8192.namprd11.prod.outlook.com (2603:10b6:610:191::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 02:30:17 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:30:17 +0000
Message-ID: <e9f705f3-3a8f-4952-b5d5-e36f4fa1515d@intel.com>
Date: Tue, 28 Oct 2025 10:30:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
To: Peter Zijlstra <peterz@infradead.org>
CC: kernel test robot <oliver.sang@intel.com>, Fernand Sieber
	<sieberf@amazon.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <aubrey.li@linux.intel.com>
References: <202510211205.1e0f5223-lkp@intel.com>
 <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
 <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
 <3b30e40b-f1fb-4145-b4d9-a9279b9602d8@intel.com>
 <20251027135516.GA3419281@noisy.programming.kicks-ass.net>
 <20251027140718.GT1386988@noisy.programming.kicks-ass.net>
 <20251027140959.GU1386988@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251027140959.GU1386988@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0031.apcprd04.prod.outlook.com
 (2603:1096:820:e::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH0PR11MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4bd14b-22fc-4c06-c9b3-08de15c9eeec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk9Pc29ScS9jNC9TWlNLRUk4N0tCMVMwN2dJNFF4MkptOS9ycDBrVkpwT1d1?=
 =?utf-8?B?S083NnV6cGtuVGJRdmJYMzFuYTNUSnBENW41TUVLM2prMjErVEpJNmVOSEt1?=
 =?utf-8?B?eCs1VFlDZ1ZUZG1DWHU2c2YveS9ieGlQWUNTcW13NEFhT0V2RHZQTHVCamdr?=
 =?utf-8?B?d0FSNlZCUUNlK3dtaVJlc09xMkorUEFCd0NNTzB5eGc2Z2FWVTJkS1IydFJI?=
 =?utf-8?B?SXVYdUtMN1c3TzI0TG83OVRHQmJXVDh1aXhCblJZZmh5R3Jmcy82VGpBcWto?=
 =?utf-8?B?YThuVVdrUzh6ZlpGU1RhODZwR3JDOFJCN29mcFFMb0RtQkhEMDYya2o4U2V1?=
 =?utf-8?B?MGw1d0xORnJwM3dWKzA1ZE1abEN2VmlNL2g1dzBYSWluVzg0dC9zZE44b2hZ?=
 =?utf-8?B?THpHT1o1Nk4xNnlOYmY1eGdtd3FoQkNUSVlSL3RPLzdwTkU1MHpmMkppU29i?=
 =?utf-8?B?QnZNQmNuK0JGRXFXV2l1SG1Lc2REVEx5L3NXNFdXOUx1dGxJdmtCVjlGUnRO?=
 =?utf-8?B?UXhXMDZ6V1JVUGtmeWNOOG8zUVJRQUlBN3hid1AxWllGK0RIcFMxYTl0T3FW?=
 =?utf-8?B?NXI2aHY2UGc1eFRWMTdEN2plWklreDJzaGcyeUhxcGFSNERmK1FZOE1mTHMx?=
 =?utf-8?B?OGZDdVV0WnpPbk9xRkdkMnRFbXpsQVNyWVFQOThtRlFFMWc3eklnclhCZ3E4?=
 =?utf-8?B?dlNiakFncjUyS29uWnJUWVU2dys5c21UNXBWUFcwYVJ3SzRrenduRjVEZVpF?=
 =?utf-8?B?c0p6Yy9ONXpZRU5UVk81V21QRkxrZU5vT0pidjNBblFzUStjSXZsOGg5bmRa?=
 =?utf-8?B?aHQ4RDZGM1ZaZDlmRlFpUFZPL0tkU0lmcmNLQ21NSE5ndzVRRE9rYnYrYmV1?=
 =?utf-8?B?RkU2UW1YRnJxNmxYTTVhL0t4QTFscHdhcVFreUczWXQ1c05UNkdFem5Td0c0?=
 =?utf-8?B?czIvUUo2cVU0ZXZTRU40YXdFYzdLT2JVdVNzMGxTSU5Ga0NNVHRDOTRSNTFL?=
 =?utf-8?B?U2xtYnRyekUzVXFZVjdLdTVvVFBRSDNnY2VldzhxamFqWlNlcWRXcjZTSSsv?=
 =?utf-8?B?WUlHWDA5Sk1wYkxaUGVhOWxGMHpwMHV0eFk2SXd0WUpaNUJrOXNxRHJkK25U?=
 =?utf-8?B?NTZ1M09XYkVTV252OTg2WWI2dDhWS3dOMzVPNUpFcmZ2am50cEVRd25rK2hw?=
 =?utf-8?B?d2VONWVqMUszUEd3MVVGK1JkYnhwWk1vbkdxU2VESmdQaW8xMjc4WUQwUlE0?=
 =?utf-8?B?QTZXay9zdDYycEQzTjh3SXpvNzIxOWdNbTFMcG9Bb1RXekpsQUVUR2xuMjY0?=
 =?utf-8?B?cWFGL0Vya0ZMVFFsYnFtTmpGTjlqZWRzWDVtaUxhYXk2dnFhTlVubXMva0wr?=
 =?utf-8?B?OHJGUCtxbzZtb2tsTXlGWFpyTVRSOW1QaDlUUHdOUGszNy9XVGV0MzlFV3Rj?=
 =?utf-8?B?azEwOHVwYk4xWVBGVktZQmc0dVBDdnlsQTVaNTQyck5Ic0FyeDg4VzNqczVT?=
 =?utf-8?B?azNNYTliWHJvd1NZRGhKYW82MnhKMXVCU25ZSk1UcVU5UmxoMU14blM1Z2lP?=
 =?utf-8?B?V0FxUDd2V0RNUmxhd09ic21zcTlNMlZNVkY2aVJvZFZuUzFhRjNrNlVveFdh?=
 =?utf-8?B?YTltRGtlejdzWkN1SUtzb2RlbmJyZS9Ndk5jOUhQdUFwaU0vdlh4UWxiWnJ0?=
 =?utf-8?B?Mk5rTEM5MktTbG8zZ0ZYQ1ZsRHBwRVpLNTRzaWs3ZWpqZEFMNGVHMnBXd1RM?=
 =?utf-8?B?NTlGQ3RkRWE3NkRRdjZaL0o0YXhzV1hoNDNOOW9TNGRuQjhvb2VuVzhUYkk5?=
 =?utf-8?B?dDg1cGFKb00vU3BPeFE3a1Jwc3ZHZGFQNEtVVmQyTVVmU0tkQkEyVVowMGNV?=
 =?utf-8?B?S1JGSnhtR0ZuM0lKQ3l0M0kwYkVTSjVWYUVMQTAyQ0hEMHhyK0tKWS93eGdU?=
 =?utf-8?B?OGs1d1FFSktTbVlFWFBLTm5mWStNaDZmREFnWEZ3b2Y4QjdXU1kxYlQzV1h1?=
 =?utf-8?B?NkprRnFsSEpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZNMmdUc3dxS3I2ZlZRNXlINjhyNUJSQ3g4bFJRZSs2M2tYMEJuRWNEa09p?=
 =?utf-8?B?SVRlZzNYMzBnTElPRHFyemdydGNaWnl6SkNyMVVUTytBT24xY0xpRUtRTTI2?=
 =?utf-8?B?TDRTdnRkUVVTZTZvVzdhNHY5M0YzR2VZTVhnWTlNQkphUmIrN2dpQ2c5T0dU?=
 =?utf-8?B?cjVKR01KK29CelpDc1ZoakQ5ME90SkVxaDU0Y01ueVFwZmdOTDk4dUd1N1Jw?=
 =?utf-8?B?UXlYcnhMZnZCVURlMjF4Q1d5Qmdla1grZG5JS3pOT05Ma1pXWEZQMUlScHc1?=
 =?utf-8?B?WFdDU2V1bzV2djllNk5ZRGFDUGFDcm9ud29Rb1FZaFl2cHgxWDh6ajdlbWZL?=
 =?utf-8?B?RG5HOVc0UGFBcVN4cFJsd2tIbGRPU0xvZDZEa1ZQT053Z0hpZHhmVGpEczdL?=
 =?utf-8?B?QVlZdXQ4MDVUTEZTSXM1amdZN2dmZjVZNzhBc3VhMnZuZW9BNjN5NDFhckRG?=
 =?utf-8?B?SmNUVEdTTUNXbUVuRHdrVXRRV1lFVjI3YWZKUk9pV2tEazZ5WWVUcXFha0xN?=
 =?utf-8?B?Tmhya2RURTlyaWN1YnhrUnVzQ2tiZnJvSDRpamtpcFk1eTFTQmtQQTlCK25l?=
 =?utf-8?B?M2dhQkt5THNyWlMwcTczL2J5MVhkdWZVUUlUbFFScDdpU1VRVTVkTnk0eGVj?=
 =?utf-8?B?MEsxTVY4bXVlNE45cjRyWnhzZWdSWnkxVVJ6QlNSSkxTN1paelZIL2tFQnpp?=
 =?utf-8?B?VGUycFUwN255b1d5M2RLd3hPeDYreHRGYnRWL3FoTE8xRHNYNkpXcksxSm03?=
 =?utf-8?B?YWRyUDhXSHdTWlBuNnkxWXJ3VmMxQ3hiV2Y4Q0JvWTIzMExxeVhpVHZvK3N5?=
 =?utf-8?B?U1NIWnM1VmRLMlFmSk5OYnJGZDM4VXk2NllXNmxNcFhSNHZFamkwa1VMVFJR?=
 =?utf-8?B?THFsdHhnWGphemhMNEQxRXdaK3RrQzdSUG1rN2h3Qlp5dmZvVmZaajhvSUJI?=
 =?utf-8?B?Z3FhbXh2bnFFWWxHdWFrOFN2QVZ6R001anBNemFoYXlnQjJTeURMOTZEUVEx?=
 =?utf-8?B?c1lXQmFFKzFvOERCa0lXRkl2UG5OZUFqL1dyK1pvZVZJQ2t3ZWFreFpGeWdi?=
 =?utf-8?B?STNPU1hvSEkzaDAzRmpnNHN2RGpQMWR5ZFc0aXdvRm5ORXBES0w1cFZTRzYy?=
 =?utf-8?B?by9KeDJlVm9vY0VXaU1oVUlNc3hpQkFYcldrU1ZpVjhpZVU4VVp4RHZhMVk3?=
 =?utf-8?B?VWQwcHlDWHJOcjZKanRUYVJuUTR4d2FMbXp0TVY3L1dmTm4weVIwZW1RQk03?=
 =?utf-8?B?MkNjT1JUTkIwMFBjMzhHNWY1VW81OWUyZWphREhCek1od29ONlBVeGthU3Uw?=
 =?utf-8?B?UDIwMDlIZnpuRzFhRkh6UFkrWTVFeG0yeHBWYXFUeXhEZzVNSFArcjRjcTFP?=
 =?utf-8?B?ZWNiYkV0OC9XczIwVDczM3JKYWFNYnF2K0luaFZoTmxVeGN3cW04OUhBWncy?=
 =?utf-8?B?SndnNk5YK0lrbkp6WGFhSXpnRkJqaW9OWWZLZ0RzcHRzYXY0a2FxelpFZktq?=
 =?utf-8?B?akNFcHo3ZWprSTA5bE9tNHpsWXZXZWpGenh4Y0QvZUVRNHFqT3RNb2RqNGU2?=
 =?utf-8?B?bmxzYk9ySDZJbXJ6U1g0dE9uZy9CUnRCNnduZVlidFZ6K1lPVUhhUnNsSmIx?=
 =?utf-8?B?d3dTaWRqQTF6aVRhSVJpWi9tU1grVTc1THcwb1dsNERwckhGaUVHVVFPSk1n?=
 =?utf-8?B?OGpQd0JFcEg5bkkwbkk4YkhUNWpucFJDSHdab0I2cXFSZlFVc0RVaWZJOUx6?=
 =?utf-8?B?c1VzT1VaZVVVazh1emlFM0VlTjJVaFIxNzR0YkgydVRKYlZpeHViK2x5bi9Q?=
 =?utf-8?B?WS9ydXVVV0pheC9hV0tRbVQ4VVl5UjZpU3VLOTJqYWhuYWJOOHduTTNlbmVT?=
 =?utf-8?B?Zjl4VnByNFI3dWdmbENRSVhhTDY4bU5VV1pacDFPdWVjNmdLdno1RGtDaVRx?=
 =?utf-8?B?T3JjY01aZmNuODdCRkVUdG45amxyUTEvNTl5YjJQMGh4cms1ZE9PSWk3eU9x?=
 =?utf-8?B?a200Wm9IeGdpck15M2ViTy9Pbk5mNE9iYjFURGpGaEpONXpkaTVTMDdBTEVG?=
 =?utf-8?B?UXZTM2NlYURqMGpXNkR3WTB6YkpOeFZFYitjQnRsRVNuQTBsYzE0dDFvVFEx?=
 =?utf-8?Q?Cn9BTEaV1Fhtrl0zVZiX0Vqmc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4bd14b-22fc-4c06-c9b3-08de15c9eeec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:30:17.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9Ra74e4jMSrCIqkkPr5Z1L+SVWsz7WPs+11+9963y0mv0H/noikwMDGvr/aIxbYvlPhbvzd9EC0l7dTF0NCYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8192
X-OriginatorOrg: intel.com

On 10/27/2025 10:09 PM, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 03:07:18PM +0100, Peter Zijlstra wrote:
>> On Mon, Oct 27, 2025 at 02:55:16PM +0100, Peter Zijlstra wrote:
>>
>>>> May I know if you are using the kernel config 0day attached?
>>>> I found that the config 0day attached
>>>> (https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-lkp@intel.com/config-6.18.0-rc1-00001-g79104becf42b)
>>>> has
>>>> CONFIG_IA32_EMULATION=y
>>>> CONFIG_IA32_EMULATION_DEFAULT_DISABLED=y
>>
>> Yep, deleting that entry makes it all work.
> 
> 'work' might be over stating, it boots and starts trinity, which then
> promptly (as in a handful of seconds) triggers OOM and dies. Not
> actually reproducing the NULL deref I was looking for.

Change the following line in job-script
export memory='16G'
to
export memory='64G'
?

I had a try and can reproduce the NULL except at first run:

[  137.151416][  T321] BUG: kernel NULL pointer dereference, address: 
0000000000000051
[  137.152128][  T321] #PF: supervisor read access in kernel mode
[  137.152661][  T321] #PF: error_code(0x0000) - not-present page
[  137.153155][  T321] PGD 100b76067 P4D 100b76067 PUD 115fd6067 PMD 0
[  137.153834][  T321] Oops: Oops: 0000 [#1]
[  137.154256][  T321] CPU: 0 UID: 65534 PID: 321 Comm: trinity-c1 Not 
tainted 6.18.0-rc1-g30682ad76ee6 #4 PREEMPT
[  137.155384][  T321] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + 
PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  137.156509][  T321] RIP: 0010:pick_task_fair+0x69/0x9d


thanks,
Chenyu

