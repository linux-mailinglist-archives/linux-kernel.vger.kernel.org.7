Return-Path: <linux-kernel+bounces-740192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F030B0D135
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775D13B2BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B7C28C5AF;
	Tue, 22 Jul 2025 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhBpBSOl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BC15C0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753162043; cv=fail; b=f97QH+Oi6SFqrsxRrivzANjCDqwpZdR73g2CRwYmL/AktY1jNF+Xk6hyoh+8k1GUIU8H5/EpHC9dgr+wVyb7jr7e63eoPF5UxBrdW8268zpT7new2b/zevNoCaAlb3/CyNwwGujMuKjQW7N+KH2U9ECgd2rpuHTU39qa+EZO5cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753162043; c=relaxed/simple;
	bh=IKcy9AL1KQ1pPXRY2vJ7ksN0RqsFvcGe/Q2AS4JsXoo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=l4WZ94GqPCMHCGezyOlZH1kF8e6cEf4bqrFLc5MWFWC8ExOU4mo2zzQ9Ds86DGZD18mQ3JVaubqb07pAJ4GexAFQ9S9uVrYliE2um3Nl5QDb3DlSaupZUNgsyaFceWLx8Zjrx/l/K11ICVj4Nf0RF12hjZ/g8kxYw4qzrwGLv5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhBpBSOl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753162041; x=1784698041;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IKcy9AL1KQ1pPXRY2vJ7ksN0RqsFvcGe/Q2AS4JsXoo=;
  b=jhBpBSOl0NqZOI5A4TjxTTdTyh8TkmwdMgzW8uedSqXch+to8eS6P12m
   ZPT6SKziymEmxmVJouPOA303c0d4wpvHrEJxBAKMLvySL0paOkPahDI23
   h+yqO5URdgW+kv27CXkklWuaOmY8peSZSqm0pWb1DSz20HMDRKtOioCI/
   pTRIAHntgJOw4uC/RDHn0RGDMWocnsuWyL7HmpLXamk/QA9a0gTlv1Fbq
   qyk5oaLu8/4wReoTAt/s4Vuj37buo5FEIfXZmaBxcMPCdTCXSSs1ViP81
   Lnp6J37q1KbuG/7o3ngIW4LbXZxoyRjarerw7pp5Tfxn3H79hFn0WL0wv
   w==;
X-CSE-ConnectionGUID: nQwjrRo5TAKXyN3lz7Ntxw==
X-CSE-MsgGUID: p0cZFBSBQXe+YF/W0+la3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43013459"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43013459"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 22:27:20 -0700
X-CSE-ConnectionGUID: ueR7WbiHQqSFZsuL2HuwWA==
X-CSE-MsgGUID: fK5cHnVoR/2IagNfPyRovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="158334005"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 22:27:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 22:27:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 22:27:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 22:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGz1hb/uJLZtIceCMrvFkcfSUVT3QmzKZYniHiLOD3GyHq4yYq/NPMZ9Ht9Ht7qUFLA7YxQjeE8+Sh72oWd7OUhcybIWPTxFkhUkKlBHTJr5fyMXsLSkEr4/MM5h+Qec1bkZhkspp3G520a1biaW4S4tRrneXU2vYBKMhE68Nm1T0Coo39IyILG3ow8ucnKjNl1Lvj8CNUN2XsDMXoUnsW0nhkd+Hrvs4OduuWNDyqcMf/fGZrKR0tcf94QZFmRw0Q6x7ROh/UcRErdjGx9Om/9MNk7OWsdv1dJ8P/X1jnokkcxHY2U0fD0eJ2QXb1oWeKr//Udq1fcukAIL1SQKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ5LE+/1Y0ssBVuGBOpOUJInjA5xGj2nf30XlmAXg24=;
 b=S2p/xJ/hEPkFkZBK3CSIpFe3VE+OaAH/mwFK70C0ENsluED0/zsLMlXWgzu+Qs3g+h/dYX+JNYeK4eBTJf+iakwgLW0NpHAqDi88qyMKVcSpkYEhzC5Wk9RKGGbdeMvr4+FaqSddH2B4WJffQhwRsdwPFzI5WiI7Aj8QU15T2gGs2IAadpH6d7wbcKvAzSSnB5WnD/C+bSTF519WjBEfl2gmoLST6KJHlbQgdPvk7wC2HN5O1eEzv9o1VHxswwSzGi4Ee38xkfgCSoW4kSdCcGWo6o6BDTfsNMCIR2hEOYB8l5V0OtgmqMie/IK6C/YSxsWQVMPca6cUKlrQpkzhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7542.namprd11.prod.outlook.com (2603:10b6:510:28b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 05:26:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 05:26:50 +0000
Date: Tue, 22 Jul 2025 13:26:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ingo Molnar <mingo@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	<oliver.sang@intel.com>
Subject: [tip:core/bugs] [bugs/core]  1d1c158ece:
 WARNING:at__seccomp_filter,CPU##:systemd-journal
Message-ID: <202507220719.dc58fb69-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: af1b3874-5a91-4cf8-2d76-08ddc8e05c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fOZX8lKE/zx3iJYPEILtJvgPaM62f2YyHTwRsPPBExrrSAVJ/DpHtSu6E5+5?=
 =?us-ascii?Q?fV5hHNIYDKM7ztagNBa7/czace6Bzz6KFTiv70FoIF29x/Ed5Oigzy5kSgp1?=
 =?us-ascii?Q?o8iIWTuURH3ML2iodCEQDttQ0PuXDAr4FLDH8spvD7UUvDQeiggmjBWuum8o?=
 =?us-ascii?Q?MsuAfugH/HVTWeALN0xjucBJpq21E577B2n4J0R7PXVFT2vQQzTSTPnTZ923?=
 =?us-ascii?Q?9vJROaOWW+XAwcuy3+1S2gORiNKqH0lCB/EhE2O1h33yHwf7fAMsWFGApybj?=
 =?us-ascii?Q?bs0sX7VPaxIyA3SHsKL+smjydoZJjT4NLFT8ql/TeAd+2KCM29SCsyTZR0D2?=
 =?us-ascii?Q?k3r28qM3/Ur29eb7CyH2OhtVAbj4+e9kaWR08fb/NgM0mXianpxBX2fEYV3W?=
 =?us-ascii?Q?MXH3YGLurXdHV4lxmuq8YGC3HOQuvWos1ZqlFaDyHpyrknMBpH8yU4448sC1?=
 =?us-ascii?Q?N9a2sn55UfgPuS/RdBregtxHDDdOn1XtuoL+ENrbKDZjJzcAV70ShwfmbEy2?=
 =?us-ascii?Q?fSNqTqCBXsm+mSXH2sc+HLNr3RzyBLYr+CSn+WGUEdSM6VO06AF/OWVDekQa?=
 =?us-ascii?Q?7kVAcS4anzq3RcceyilZGfbOF04LVfAvA5pstnLGpq/f2Qnx/+rUAKBmcUI4?=
 =?us-ascii?Q?5S8FCNXhi6op4h+gKwk8eCCxLxwQ4cFp7RmaUBNmteStM6ino6cV+MXDhSVB?=
 =?us-ascii?Q?C4J7PfBplqfdGJMC0Ki1mosbyHLrRf/sndraUXOrb0/FpkZASBHD3MAO3jt+?=
 =?us-ascii?Q?0PwreYwfOaSHX9HVPAMcB136mBMEIdja0J5uGVA8ktxyxcSMw4bl+DEvzqEO?=
 =?us-ascii?Q?isg++/Ql6zQYJNYfOh8Djqf0v1Wna9kCL/TRfUudcnLsbeeI0ID4tqq+n9KV?=
 =?us-ascii?Q?LwiLFNksO9nbmC6NKkM9HLKE5HsKT6sU9nWB4Fn+skn9OK+hmpyLTGYSG9kL?=
 =?us-ascii?Q?hNmGoRx0/hRfKZ8VKAVO/VzOSThfQJRVmvW81FNEdvoF+Uv+gydl8/lwxdFT?=
 =?us-ascii?Q?0ClISlGpHVRh6UAy/IKcYjO0SaB0w4/JbH7BAX3OOTWX7fkVHvCbvEs2GlOa?=
 =?us-ascii?Q?ijLyZFkxo3uGIrnzHWR55zk3uC3A50SV3Ng7MJWPzQ/wQkC3vsLAKVnHtJ0r?=
 =?us-ascii?Q?MMZl6xUOGV85KWqISqJYDjW9ek8JVqA2hNbRWglbSg03rorvPcrqLARl1nRA?=
 =?us-ascii?Q?1hWNtqUcWRPMSIeg6IVCSTmTLPTSA1mnkRapPCVIF7kXYi2kvPT8oI8YCdBp?=
 =?us-ascii?Q?a/JAX6FZfpzGM6whURi52fANZPTEHYIa5mk5zvwuwKYtZ1P+8wlxWYssNL8t?=
 =?us-ascii?Q?/AUJuMDMhWmknKSLvl3fkN61u9wpvLL4fxKfLd4dQWbEYhb3YYNdirXZO7om?=
 =?us-ascii?Q?VrxZdOekSh91d1S4zjzIHgnrg9yK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NgkqRWYGdr/FG7QPpTY/VduNge6oEwc3LyUYiJ49DT9jN/n6DKJWgBsOAxzy?=
 =?us-ascii?Q?Ux1EByBqytaxC0mPs31BjAYPNkb9Z4OvVrfay2gDeHv0uJfGYtDaXFrtwzbN?=
 =?us-ascii?Q?dJ1I/DL5b5PU5hV2K3cMrs13Tlk+lP4+uJByfgM7ykLR8YUul/j6V6nB5KBg?=
 =?us-ascii?Q?U9qgRSZeej3+kCz66eoVfMgP4+Pf6LMqsV1lJgoOobm7UkPK+IG1ic6rjvxC?=
 =?us-ascii?Q?14Bhib3bOt/Nt/pbAEg66oGs8EBGu2v0eS4zvghkyZ4dc0YE3lqj0xNU08w3?=
 =?us-ascii?Q?4KEjn1GlByQM6X43J0u2NNNomYKW0ZlQVrlWld0smSHVb5ZnMOP1MTdX8ZYo?=
 =?us-ascii?Q?VXJq0dVhKH/l9AixoZq6bHqdqjKVPE4uUsiV0L7g4iz7NYk9ZGiC/nm1owYb?=
 =?us-ascii?Q?i5b8gbmcq9r8ariRnJG4AldVfzBWYh2uN3oQ9qE9vaQrHryJmx94sJreCg0b?=
 =?us-ascii?Q?3FNnT/G/6VK2Wt2DxtwJo7pptg6izh3FqPxw8/pUSVQiIZffzrs1IjpFa2Tk?=
 =?us-ascii?Q?p1oHs5Ap8Toq87WVnFAwdguuw/O2XWRHoijMj6U0oG+7bBu/KCeXMmNViYof?=
 =?us-ascii?Q?3pqdCHkBbPGqNt+FZTM7O2p2g7A/5Hi3V16GQBGVRJ/NdwNDLCJRGXOZaewS?=
 =?us-ascii?Q?f+xnawvNUK/q/MJdRT0UT4ml6K5OUYPnkgH/FSupI+sgSp+HI6dVgLaDZG+c?=
 =?us-ascii?Q?54U/a5tloNZ4ju1geW8CLIrgA75Oi5Poe4VoPYfCBRGSgC+T6oTyHQhDcz8W?=
 =?us-ascii?Q?GM82HQSC2zp73lXAh5a++UlUXAiUouby+Q+9v6nsSWsN6KMHJg5Rxz0xApyu?=
 =?us-ascii?Q?j4LRoPDTrW35bh42/R5kQlY9jhcfoRwm+MeHDWqP8mij9adH9gmYFqz+qbBI?=
 =?us-ascii?Q?5oiMtbY0Og30UMKQD1ncW44bBeV8mJ6SocQnUSB/+H1gsFuaNwzxzAbwNFSw?=
 =?us-ascii?Q?ynMl9NrUlqju3NBG7H9sBQxJ0Eu5eQysNETkJRZAqadtW5Bipp9r6OASelk3?=
 =?us-ascii?Q?BS2QxQe5dQZw0zHJ6hx978PFU0FJB114UTiJyx+WVDUJUaO876BYZX50szLe?=
 =?us-ascii?Q?hPTXYbhBnOpNzDZHDoDYdVCnwn1jBr+fEkY6Uci70M+bMamXrvEv5BgdHFBm?=
 =?us-ascii?Q?kPP99gn71yooTw5BDTd5QQkzqXBF4EfCBnFDQJE/phnOoYKlVQX3mhwZlUZY?=
 =?us-ascii?Q?pSb8kze5lOh7CpHCydh9o4m/pAxmFL81Rgkel40+gRothH5Wgut63muAY+KF?=
 =?us-ascii?Q?LLgaQ5C7fXe2Tj78on13mF53Hnsrxd/gzpyxwJnjEGaUF5zCt04gBRunWZEN?=
 =?us-ascii?Q?XHlIHs2eokiLmez5KVmBBeUkKDist50f7PIGhLAFPkDUwrvhpjjjJBKgx10H?=
 =?us-ascii?Q?O6k19+nJGn7ilNLbCrFdH7aXFCbBX6VJTGRnT3j8uX4iVup4hEh4D/7O59et?=
 =?us-ascii?Q?871Tl4dp4kUNTNsIHKeo+xm9a2txX5cPRC6EUfpXtzGj4COBkbqlXWmhhi1W?=
 =?us-ascii?Q?JUaNqyFJWg7btdaQJ0QKvu+l4KuKJvftik9d3Ir5gBZzBDWlFTPmhiB/0OCg?=
 =?us-ascii?Q?xuhabQuv1Zq5Yj3/EkbYlgzV1kmWNJpCvOGAiRvBehz6AMaRZ/IGYD5KLAX6?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af1b3874-5a91-4cf8-2d76-08ddc8e05c11
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 05:26:50.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXD1O9mo3w6xeUNHYrYsOXcPCzhm1xoT2O5tmRGHYuWNWLh7RU6fLWGZ0BKkIAPAGaJnG4stgSQzYk+rNn6Oxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7542
X-OriginatorOrg: intel.com



Hello,

as we understand, by this commit, the stat (1) becomes stat (2)(3) are expected
and can supply more information.

0e271227ed4ba41e 1d1c158ece6cb7538026233d002
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6         -100%            :6     dmesg.WARNING:CPU:#PID:#at__seccomp_filter     <----- (1)
           :6          100%           6:6     dmesg.WARNING:at__seccomp_filter,CPU##:systemd-journal   <----- (2)
           :6          100%           6:6     dmesg.WARNING:at__seccomp_filter,CPU##:systemd-udevd     <----- (3)

however, we failed to bisect stat (1) so cannot capture the real first bad
commit for the WARNING.

we still make out this report FYI there is a WARNING captured in our tests.



kernel test robot noticed "WARNING:at__seccomp_filter,CPU##:systemd-journal" on:

commit: 1d1c158ece6cb7538026233d0020b18e183d39a9 ("bugs/core: Reorganize fields in the first line of WARNING output, add ->comm[] output")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git core/bugs

[test failed on linux-next/master d086c886ceb9f59dea6c3a9dae7eb89e780a20c9]

in testcase: boot

config: x86_64-randconfig-104-20250717
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507220719.dc58fb69-lkp@intel.com


[ 106.315928][ T80] WARNING: at __seccomp_filter+0x200/0xac0, CPU#1: systemd-journal/80 
[  106.316776][   T80] Modules linked in: autofs4
[  106.316807][   T80] CPU: 1 UID: 0 PID: 80 Comm: systemd-journal Not tainted 6.16.0-rc1-00016-g1d1c158ece6c #1 NONE
[ 106.316820][ T80] RIP: 0010:__seccomp_filter (include/linux/bpf.h:1322 include/linux/filter.h:718 include/linux/filter.h:725 include/linux/filter.h:742 kernel/seccomp.c:424 kernel/seccomp.c:1258) 
[ 106.318660][ T80] Code: 26 55 ea ff 66 90 e8 9f 20 ff ff 4d 8b 5e 30 49 83 c6 48 48 8d bc 24 c8 00 00 00 4c 89 f6 41 ba ee f2 9c cf 45 03 53 c1 74 02 <0f> 0b 41 ff d3 0f 1f 00 41 89 c5 e8 30 d6 e9 ff 45 89 ee 41 81 e6
All code
========
   0:	26 55                	es push %rbp
   2:	ea                   	(bad)
   3:	ff 66 90             	jmp    *-0x70(%rsi)
   6:	e8 9f 20 ff ff       	call   0xffffffffffff20aa
   b:	4d 8b 5e 30          	mov    0x30(%r14),%r11
   f:	49 83 c6 48          	add    $0x48,%r14
  13:	48 8d bc 24 c8 00 00 	lea    0xc8(%rsp),%rdi
  1a:	00 
  1b:	4c 89 f6             	mov    %r14,%rsi
  1e:	41 ba ee f2 9c cf    	mov    $0xcf9cf2ee,%r10d
  24:	45 03 53 c1          	add    -0x3f(%r11),%r10d
  28:	74 02                	je     0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	41 ff d3             	call   *%r11
  2f:	0f 1f 00             	nopl   (%rax)
  32:	41 89 c5             	mov    %eax,%r13d
  35:	e8 30 d6 e9 ff       	call   0xffffffffffe9d66a
  3a:	45 89 ee             	mov    %r13d,%r14d
  3d:	41                   	rex.B
  3e:	81                   	.byte 0x81
  3f:	e6                   	.byte 0xe6

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	41 ff d3             	call   *%r11
   5:	0f 1f 00             	nopl   (%rax)
   8:	41 89 c5             	mov    %eax,%r13d
   b:	e8 30 d6 e9 ff       	call   0xffffffffffe9d640
  10:	45 89 ee             	mov    %r13d,%r14d
  13:	41                   	rex.B
  14:	81                   	.byte 0x81
  15:	e6                   	.byte 0xe6
1;39mKernel Trac[  106.321891][   T80] RDX: 0000000000000000 RSI: ffffc90000075048 RDI: ffffc900012a3d40
m.[  106.323652][   T80] R10: 00000000cfa1f2ef R11: ffffffffa0000d58 R12: ffff8881a8e18600

[  106.328424][   T80] R13: ffffc900012a3f70 R14: ffffc90000075048 R15: 000000007fff0000
[  106.329818][   T80] FS:  0000000000000000(0000) GS:ffff8884ab26d000(0000) knlGS:0000000000000000
[  106.331921][   T80] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  106.332829][   T80] CR2: 00000000f7fcd01c CR3: 000000017d202000 CR4: 00000000000406b0
[  106.334346][   T80] Call Trace:
[  106.334870][   T80]  <TASK>
[ 106.335399][ T80] ? __free_frozen_pages (arch/x86/include/asm/preempt.h:85 (discriminator 9) mm/page_alloc.c:2735 (discriminator 9)) 
[ 106.337400][ T80] ? _raw_spin_unlock (arch/x86/include/asm/preempt.h:85 (discriminator 9) include/linux/spinlock_api_smp.h:143 (discriminator 9) kernel/locking/spinlock.c:186 (discriminator 9)) 
[ 106.338252][ T80] ? __free_frozen_pages (arch/x86/include/asm/preempt.h:85 (discriminator 9) mm/page_alloc.c:2735 (discriminator 9)) 
[ 106.339163][ T80] ? slab_free (mm/slub.c:4645) 
[ 106.339936][ T80] syscall_trace_enter (kernel/entry/common.c:53) 
[ 106.340888][ T80] ? asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[ 106.341785][ T80] do_int80_emulation (include/linux/entry-common.h:170 arch/x86/entry/syscall_32.c:171) 
[ 106.342700][ T80] ? asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[ 106.343611][ T80] ? do_int80_emulation (arch/x86/entry/syscall_32.c:176) 
[ 106.344554][ T80] ? do_user_addr_fault (include/linux/mmap_lock.h:?) 
[ 106.345555][ T80] ? do_user_addr_fault (arch/x86/mm/fault.c:1441 (discriminator 335708160)) 
[ 106.346550][ T80] ? trace_hardirqs_off_finish (include/trace/events/preemptirq.h:36 (discriminator 8)) 
[ 106.347721][ T80] ? do_int80_emulation (arch/x86/include/asm/jump_label.h:36 arch/x86/entry/syscall_32.c:148) 
[ 106.362839][ T80] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[  106.363662][   T80] RIP: 0023:0xf7febcb0
[ 106.364393][ T80] Code: 4c 24 34 89 44 24 0c 8b 44 24 44 8b 54 24 38 8b 74 24 3c 8b 7c 24 40 a9 ff 0f 00 00 75 1c c1 e8 0c 89 c5 b8 c0 00 00 00 cd 80 <3d> 00 f0 ff ff 77 21 83 c4 1c 5b 5e 5f 5d c3 90 83 c4 1c b8 ea ff
All code
========
   0:	4c 24 34             	rex.WR and $0x34,%al
   3:	89 44 24 0c          	mov    %eax,0xc(%rsp)
   7:	8b 44 24 44          	mov    0x44(%rsp),%eax
   b:	8b 54 24 38          	mov    0x38(%rsp),%edx
   f:	8b 74 24 3c          	mov    0x3c(%rsp),%esi
  13:	8b 7c 24 40          	mov    0x40(%rsp),%edi
  17:	a9 ff 0f 00 00       	test   $0xfff,%eax
  1c:	75 1c                	jne    0x3a
  1e:	c1 e8 0c             	shr    $0xc,%eax
  21:	89 c5                	mov    %eax,%ebp
  23:	b8 c0 00 00 00       	mov    $0xc0,%eax
  28:	cd 80                	int    $0x80
  2a:*	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax		<-- trapping instruction
  2f:	77 21                	ja     0x52
  31:	83 c4 1c             	add    $0x1c,%esp
  34:	5b                   	pop    %rbx
  35:	5e                   	pop    %rsi
  36:	5f                   	pop    %rdi
  37:	5d                   	pop    %rbp
  38:	c3                   	ret
  39:	90                   	nop
  3a:	83 c4 1c             	add    $0x1c,%esp
  3d:	b8                   	.byte 0xb8
  3e:	ea                   	(bad)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   5:	77 21                	ja     0x28
   7:	83 c4 1c             	add    $0x1c,%esp
   a:	5b                   	pop    %rbx
   b:	5e                   	pop    %rsi
   c:	5f                   	pop    %rdi
   d:	5d                   	pop    %rbp
   e:	c3                   	ret
   f:	90                   	nop
  10:	83 c4 1c             	add    $0x1c,%esp
  13:	b8                   	.byte 0xb8
  14:	ea                   	(bad)
  15:	ff                   	.byte 0xff
[  106.367884][   T80] RSP: 002b:00000000ffd23590 EFLAGS: 00000246 ORIG_RAX: 00000000000000c0
[  106.369233][   T80] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000002000
[  106.370445][   T80] RDX: 0000000000000003 RSI: 0000000000000022 RDI: 00000000ffffffff
[  106.371662][   T80] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  106.372873][   T80] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  106.374069][   T80] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  106.375321][   T80]  </TASK>
[  106.375877][   T80] irq event stamp: 7205
[ 106.376550][ T80] hardirqs last enabled at (7213): __console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:344 kernel/printk/printk.c:2885) 
[ 106.378146][ T80] hardirqs last disabled at (7230): __console_unlock (kernel/printk/printk.c:342 (discriminator 9) kernel/printk/printk.c:2885 (discriminator 9)) 
[ 106.379717][ T80] softirqs last enabled at (7228): __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:682) 
[ 106.381286][ T80] softirqs last disabled at (7221): __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:682) 
[  106.382872][   T80] ---[ end trace 0000000000000000 ]---
[ 106.384045][ T80] CFI failure at __seccomp_filter+0x200/0xac0 (target: 0xffffffffa0000cdc; expected type: 0x30630d12 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250722/202507220719.dc58fb69-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


