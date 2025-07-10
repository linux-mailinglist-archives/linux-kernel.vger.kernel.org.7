Return-Path: <linux-kernel+bounces-724845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA63AFF784
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4D3483C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5114127F759;
	Thu, 10 Jul 2025 03:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RG2fDgS+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E5236A73
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118461; cv=fail; b=dJi82jSbh9f89vrCdj/uKa2cR9mFfuuAkB5qP5N6aLiDOtOEC9X+96XqqGrp04ddIYzdv72KkFSybBGgskEYv9Cib4tgfBBAUzKfvgws0ie5ZV95chV4s+WUpwKHR7CGVZ3d8cE4Pq95Uo9TKtbnWQN3/SYM1as/eOhFBGghZE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118461; c=relaxed/simple;
	bh=8q9ssX3gnRs1nMjxlVSPlYlw3AEk6bxpOmJJw3Bax40=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hv22a/9GF6Hf78F6jYAo3Ta7jUfNHhUEDxhsLiPNcCFyYejKdHNJNpblAOVa/tM5nArdTG/7qhf1FBu2+rrXciBDY9b8aEHr3OHCZ/LsX48HsrRIdGTHPV8IqzvIFav7FveH/A42z7A96UwRFaDMjyBc7DS+TR8NQoDlX9tAMXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RG2fDgS+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752118460; x=1783654460;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8q9ssX3gnRs1nMjxlVSPlYlw3AEk6bxpOmJJw3Bax40=;
  b=RG2fDgS+2tjrW4XhinSuekdgAsGL/E4Wv+/yloWwhkT3SeI7l8FxQmJn
   1x6QLthTs0vOE6xHMGwS2lS34oicT0h91u1mYgPfCKaro2sfA9T268cYS
   FfT6ZdgouzfDU4cwYalOlSKj5LPh07snJhKyAO9xASZye1lnNw9MOl67o
   /+VgQ672zr/4hi15OJfG8KmBywMZ1fqwdUjgcu+5eMHh8imqdmTm5X7H2
   YfhXDXvv1SIpyRMiA9Of4IxCiFTDSQLY5HuHMUaeGm1vbroetPfsLLt46
   vGxfiuwhj/Q6QVvKsW5gTaRhpD9MkbhHygUYQLA9KsJfLBRCfYgXTtlmO
   g==;
X-CSE-ConnectionGUID: 3RCZSxo0Tk2hkCvumES8FA==
X-CSE-MsgGUID: 8FAKkiJPSw2GW3wUrUyJUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="42016319"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="42016319"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 20:34:19 -0700
X-CSE-ConnectionGUID: MjOkrUDhQLSVTVw/lwEmHQ==
X-CSE-MsgGUID: W53i1lKoQP6Q3r9LJop2JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="160493766"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 20:34:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 20:34:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 20:34:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 20:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPT899gbPXQLSh3aovepK1PTG48lmmTQSZz5A+wS+3h5ohAT2aWbBx5UVL7p9CQpzAJsKR/tJnOxtTk4zlDv7hUuakSqz8bTqkLn7cA2FzBZzhxS9srziBSJT5kHwJpCDQNSxM3gg3mJ6sKU0geSnrCU/vxpWhW1I+A8Awn5dbb5ZIHEXAsvat0hr5qjd8Ymald+dG8LoSAbIqKbhfjxL7JLJL/L9hGL1bHMJGeScZCU1HXcZB5xpb1TzeiPeAfAwi8Pswx+nuSb2td5RTitBdzUG+f7q5HoM5fN+B7FiIFpA+84hzRAxL2jerdmeSNAttLsmnY8BGGPbuB40GFU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWVuZ8HJ5dSLcCvIsjj22J+o5vGMlrXIS2bf8t3Gax8=;
 b=xVtlAKdYZpixC7Z1GmFaj0W5PQxMJe2EQ+2OfceLyPBc4wzThTY/4nPixcakw9wXUP97j1aTnIY61oo6v+eji9Iq1JmYYP0y9TBRyNMMIiXgBxp2yHEJXcdSBxNjwyyaSwZ8IgcY/tKXaUni3lQBlI4ymMpD7icFnUvMIdLDiR5ISVoboMVi52dEqMyXO2WBUyJVdOfSHJXCgLdJr5w+xC8uArWR+tj/9Z0FFubIFotlJ5GFQCe73YmMf4E81Yp3z5kcnvqkM97NWwT01mMlVm+/1ZMZbp434nY/XZmXlNfpPIO1KxwHdu03cmhZZS4YDCx2hR5c+NIKaassTCkpIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB8287.namprd11.prod.outlook.com (2603:10b6:510:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 10 Jul
 2025 03:33:59 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Thu, 10 Jul 2025
 03:33:59 +0000
Message-ID: <a71f676d-7ffe-44d6-92c8-b34e5339507b@intel.com>
Date: Thu, 10 Jul 2025 11:33:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC patch v3 00/20] Cache aware scheduling
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Tim Chen
	<tim.c.chen@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Tim Chen <tim.c.chen@intel.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, Libo Chen <libo.chen@oracle.com>,
	"Abel Wu" <wuyun.abel@bytedance.com>, Hillf Danton <hdanton@sina.com>, Len
 Brown <len.brown@intel.com>, <linux-kernel@vger.kernel.org>,
	<vernhao@tencent.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
 <8f6c7c69-b6b3-4c82-8db3-96757f09245f@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <8f6c7c69-b6b3-4c82-8db3-96757f09245f@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH8PR11MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 436669f0-f833-4280-dccf-08ddbf629b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXlhVVhNa2JYSks3eG54c2xqTXU5OVBOOUxaTGJQTTVCZFNPUk8xUUZLZUEw?=
 =?utf-8?B?WTVsa1Q2MXRBK1hLdmNsS2t3UmcvM0VGbHpudlBOY2VpM3p6cUZ1Z2Fpcmta?=
 =?utf-8?B?a3VGUjhBY2FRdm1sTXpsOGJ0N1Z5MXphaFZibDVQMGZnUkRHZy8wRGdhSjRL?=
 =?utf-8?B?VXRmNW9HU3drd0xrU2NSeGZKRDEwN0drNWltcEFzMUNLdTltczJBMzRqclZr?=
 =?utf-8?B?aTNVVm1QZ2d2bW5yZm9oZ3ZpOHFZT1FVQU1DRjIzRWZoZXNlZE5pdzJGVmY3?=
 =?utf-8?B?MTA3bytzM1ZneHZUeGJCSW0waytYR2ExWTJqNnZWZFNOQjB0MCt1a0d0eVND?=
 =?utf-8?B?Y1BXNUpsVkdwaEVIZjc0ZDZhZlVjRkZCQkd3VU0yQitqQ3ptdjVKSzJtcjFF?=
 =?utf-8?B?M3VIazVCVXowRTVBRndYL25pTnRMS3RWMmxqSk9PbG8xWHF5c0orRjNTN0hY?=
 =?utf-8?B?bXJ3OHpLR29vekRvVUI4TXJjc1VzSGxESzBTb0Q1ZHEvaVlBNU1HcU9wWFJi?=
 =?utf-8?B?RWNoQStoN0xQSFZQUjlIQStzM09mdjIxVkN2WUJpQU8wSUNvbC9DdklzV0Jv?=
 =?utf-8?B?eTVuUDdIODdXNFBFY21LNjBoM1hCZ1g1SzBxWlZKdXFLOStKdm13T2FDSUhD?=
 =?utf-8?B?RnpKd0UzM2ZaZlZaaHpEWmxqV1pyaFI5VVM1T0g5N0tIZ01SaVRPMC9zY1Y1?=
 =?utf-8?B?OGV5SUd6SWhIR2d2WGNhYW81OFMvczZqc1BJTWFialZZSjF6QU1uQTJiZTlH?=
 =?utf-8?B?QlhjNk1DYU0yNkUxdnl1YldWR3RwQllPYTNrWDBlRHdLTC9odStKRkZCampH?=
 =?utf-8?B?aC9ERUJRR00vOW5UZGNDUUJEZmRYdzdUejQ0blExcXl6Zi9nZGp0ZFZUQ1ds?=
 =?utf-8?B?d2VmTFNLUFo0R3FYNXAwK25zUUhQV29ObVFWZ3JxZWpxYTNNVlNUYTluZ1Zr?=
 =?utf-8?B?Qi80Z2hSeFE1aXY5M3FCK3J6VzlVYVNpUkdFYys1UXhlWVFtMG5uQlJ0a1oz?=
 =?utf-8?B?WDg5U2xod2hZK2YwRkxRWGV2Z3lQSTFYOHV6aDlUYU90a1JUN201WXJvNnp1?=
 =?utf-8?B?UGpxV0doT0NKaUpwTzBSY2dCUU84OWwwZjQ2SUJ6cXJVVTRjcFJQbWFoaGt1?=
 =?utf-8?B?bm42QmQwc0ltc01Ealh3YmlIRFIyaFVuWnNMNkNhYlpxTkJaVnh4SDQ0L2Rj?=
 =?utf-8?B?b0lRRGp0NEk4cTBscUNLbm16NUNqelZPSTl5M0FTcEFFK1BPend6K2xveEJr?=
 =?utf-8?B?dkpKb3d3YXBNNmoweUwvdmd5WXk0endkOXhYdXhtaUR4OGdkTlhlWDRMeEFs?=
 =?utf-8?B?dUxMeFVET1lHbmdzQWMvRmlra0xTMS85ZlowRUxtT2JQeDFWb3Ntbkw5YldL?=
 =?utf-8?B?QzZKNVArMTBHZ1V2bFBQcHp4d0JPbktRRy9rWUVpQk1qQm9ScmxxVW9tUTVn?=
 =?utf-8?B?VTkwSEFHWHIyMWpJc1gzem50SmlEaWFLZnQ1MjQrVXg0RHlHR3o0V3RoQWps?=
 =?utf-8?B?Q0NrNDB3bmtSS3JmeExaOHhKS2p4MTN3Ky9PbTdKQlk0NjhSRm5TZUNEbmJs?=
 =?utf-8?B?N0tFakMxK2NBZXNJNUNiZllBalQ1YngvUzNIbXliMHVOTy9wd2xxNkpsZEhB?=
 =?utf-8?B?cGQzUWIvanJZbS9zRlM3M1RYMEhSOU1YN1Jqc3RUQTZteW5ORnpIdWZQREdO?=
 =?utf-8?B?cG41U0NGNlAzNk0zdjdyOXRjam1RVkRFOE9vc0d5YWVCZzNFVXAzVVFsbCt2?=
 =?utf-8?B?MkxjaHVhVk5va1FFNXpGNkFGcDkxQlZJa2h2aVJNYi8xaWduczA2T3YzSzFn?=
 =?utf-8?B?Nml1bUVUd1E0eE1GUHZIakRENWpVN0JCSGpCY25jMnFTWEppMm5tcmU0YWl6?=
 =?utf-8?B?QjBrV0tSenJNNFEvZXd4U2tIQlJUanlTRngxdmxvbnBzRktKNXFlUUFiWVJz?=
 =?utf-8?Q?Cg4H/pPh+gg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHp1c3NaY2UydXZQUGxyRW44YUxJcHRCUzlZZjRkSUh1cnNWUXRiUTdYOHF2?=
 =?utf-8?B?SzF6TFFmZ092RDVhY0RHTmNZOHVQQ1NhbDNFOW5QcHNySW9jSFZtUXZZK2Fh?=
 =?utf-8?B?aU84eXJyRitmZVdpazBFaitzeGhnRVE0ZUpmYkJGZkRlV1JybHJwd1JXcTVB?=
 =?utf-8?B?NnUrNjJOZS9yTnQ2aUtsUmpwOVBrd2laOHowQmZEbzVURUFFMjZYdVhZM1Ir?=
 =?utf-8?B?NU9jU2w1d2VCR1E1a25GYkV5MHhLNlh6OTZIU0NTc0lzdm1NS0JvNDlOU2RF?=
 =?utf-8?B?NENOZjlTYzVCMUtjVVJsd1pNSnRBUVNvb3pSSnJxd2l2amt3Zy9HSDJoeU5w?=
 =?utf-8?B?Q0UvTElLVS82NkV1WExXczYxTld6L2ViWU00d3BaKzQ2cTFhWGxUOUZqU05i?=
 =?utf-8?B?RmZzK0pmMHk2bEc1TWFXZ2ZYYXBSbWFJSHdEZE5vTFc0RHlBcWNiQTlRQS9P?=
 =?utf-8?B?S1daZFZtZHA4V0lWa1NWVXl2Y1BNMGNuRzREU1F2cGFXQUIzZnRGaFRKb2Z1?=
 =?utf-8?B?bG0vTmVGTEdKK1Z4ZGg1M1ViV0drVjFONFVrTzhwb1VZcTNPRFVxUWhZWDd4?=
 =?utf-8?B?T2sweFpJaWwzbDhVWlFKZFM1RGFSaEVobFJ3b1VUM1c5a2NnRVJvRkd1eVlL?=
 =?utf-8?B?clBJRS8zUFA5NFRyM05zYmFtRkRjL09YUERMcHNyWmlobDE3L2QrbWlxR1da?=
 =?utf-8?B?bDVLVzN1SzgvTFpMNlluOVNyQ3ZBbzNxTkVMZlgrblhtQnpDb2ZGWEN2dnlJ?=
 =?utf-8?B?WVY5VEJQcnN2T2MwZjJpK3k1aVN2UytKRzEwTDMzVUZJR2VKTFpRL0dzK21w?=
 =?utf-8?B?UklQRXl5RGlaYjVjaVYxdE5PcFlxZEFML05RMWd2ZVhVZEZNdGVWZStHV2xI?=
 =?utf-8?B?MVdYOGVIdSt2VGFLSlAzUmhGWHo1aUdCMDJUZEtTcUNwUkExd2JwZ2gxSzll?=
 =?utf-8?B?ODFOLzB3bDBETTZ2TXZEZlRoUXpDQmdtMnpMRk5IbUxXdGJ5cGQveTgxVGxS?=
 =?utf-8?B?T1dNNUlNNjJ0SHZYWHludVhYTVo0Q1l6SFFlVnFCUUV6cElrZXpZUUlNa1Jj?=
 =?utf-8?B?Ymw4SjRnbzVQUHdsYUtDUEZJZnVmQmNzcW5uei9Yd1hFZ2ZRZVJpRzdBTnlK?=
 =?utf-8?B?NEtLT3lxSXpMK3dwOFBlZEs1UXdsSXBNcmlWUlAvZkdvYUU4SXRQUXNOMFhu?=
 =?utf-8?B?S1VTd3ByZmJyZVkzMlVzalBVMG1BQzVIVWZJMVJtYjY0ZC9wRk8vRi9aOXpC?=
 =?utf-8?B?WkswVytVdmx0R1Y1WUhLMnRLMnBwa1YrR2JHQjg1YzZaaUorTkFPak9kWm1r?=
 =?utf-8?B?Qlc4YlB5UFZ3aFpGcXFUbk5QVzc0N1pWbGJSSkR0M0lRVmxmUjJ0eTBSRzh2?=
 =?utf-8?B?algvKzZLZlFWTnlla2pDU2NQdENqbWhSQkpFU1poKzVkUElKdHZDLzJXU2VT?=
 =?utf-8?B?bm1FMVV1M3JlY0x0VTZ3aEUrWFdNYnU4STNzU3JrZlFQdE9HanBQNXJRSnVC?=
 =?utf-8?B?SHNkYy9kdHdrUHI1bmtrTUswY2h4UW1pbCs1TUtCdUt5QWliOFU2OEtNTjhI?=
 =?utf-8?B?ekRmL3hqSXFyU1c1TGJxeHIxVHF6Z2xBVU1IWURiRG1iejJOaUFlenJ3Vlhq?=
 =?utf-8?B?WkNvK0RXUjUrVnVieWVzTTd3ZzV3eUJyaGx1VzZFTVg0aVozcWo5NFVTZ0FP?=
 =?utf-8?B?UkRhQjNuZ0FtbUdpbk9ZL3NmUDBEdzBodFY3N0o4VDVBcXB2TEtraXl5Zmxv?=
 =?utf-8?B?Y2p5MlVMTTZkQkhkNFIrN2syejRVZUd3YURyaS9IMkRFTDFTeE96dFV3VnR4?=
 =?utf-8?B?VGhXdm1rMTRoZHBVYmhvL2JyZjdGUjJmSzI3cFBWV0xGc0JJdTh4THY5SjR2?=
 =?utf-8?B?bXc3VDF0MWkzSzM0UWUzNkUvMGoxRHJpWmFzWmo2UEd4QUpSakRMU0w2NE01?=
 =?utf-8?B?d25TK3VXL1ZuVTJsMkN6Vkwxa3E1RUNSd0pKUzF6aDBjbGtFYy80TnQ0VG5F?=
 =?utf-8?B?Zkl5cjVDRGQ5T01zS0NGQ2k3Rk5vWjVqZWs3dlVvMnFieUlsdjlEVW1IV1kr?=
 =?utf-8?B?UktqWFh4YzNPREtQbVU4ZExBV3JqaUFUZ1RPazk2Tmg0WDJ0bEdDd3lXRWZ3?=
 =?utf-8?Q?318MppxSQlsVWNVojpmNoigT0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 436669f0-f833-4280-dccf-08ddbf629b60
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 03:33:59.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7fAheqs3nrp0yAWEEe484UuW+TCey2VvqzlIVLLegCpwWARbvIv2XkVkDC4KZnwGNEw0guFLz3L59aMKLPwjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8287
X-OriginatorOrg: intel.com

On 7/10/2025 3:39 AM, Madadi Vineeth Reddy wrote:
> On 18/06/25 23:57, Tim Chen wrote:
>> This is the third revision of the cache aware scheduling patches,
>> based on the original patch proposed by Peter[1].
>>   
>> The goal of the patch series is to aggregate tasks sharing data
>> to the same cache domain, thereby reducing cache bouncing and
>> cache misses, and improve data access efficiency. In the current
>> implementation, threads within the same process are considered
>> as entities that potentially share resources.
> 
> [..snip..]
> 
>>
>> Comments and tests are much appreciated.
> 
> When running ebizzy as below:
> ebizzy -t 8 -S 10
> 
> I see ~24% degradation on the patched kernel, due to higher SMT2 and
> SMT4 cycles compared to the baseline. ST cycles decreased.
> 
> Since both P10 and P11 have LLC shared at the SMT4 level, even spawning
> fewer threads easily crowds the LLC with the default llc_aggr_cap value
> of 50. Increasing this value would likely make things worse, while
> decreasing it to 25 effectively disables cache-aware scheduling
> (as it limits selection to just one CPU).
> 
> I understand that ebizzy itself doesn't benefit from cache sharing, so
> it might not improve but here it actually *regresses*, and the impact
> may be even larger on P10 /P11 because of its smaller LLC shared by 4
> CPUs, even with fewer threads. IPC drops.
> 
> By default, the SCHED_CACHE feature is enabled. Given these results for
> workloads that don't share cache and on systems with smaller LLCs, I think
> the default value should be revisited.
> 

Thanks for the test. I agree with you. The SMT number,
the L3 cache size, the workload's working set size should
all be considered to find a proper threshold to enable/disable
task aggregation.

thanks,
Chenyu

> Thanks,
> Madadi Vineeth Reddy
> 


