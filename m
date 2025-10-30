Return-Path: <linux-kernel+bounces-878416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67043C20880
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4563434EA08
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA175464D;
	Thu, 30 Oct 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dtQ5Mz5W"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022123.outbound.protection.outlook.com [40.107.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0853258ECB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833710; cv=fail; b=RfWA7DY/xWgu+d3/KmgTdSd8hs7wN3FgG33m1XqnwTelgJmY3hD+K2PD9zkgTqWqv08CssUVrtlmFPE8u0w9bvRkxxqp/jEgDjoehveURE8/VauXf2gFFsJIJBQi0inHeGKFieI6pmNKVXNwm7h5ortrwAIQ8ndCJ9CY7TOznKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833710; c=relaxed/simple;
	bh=4fGdJcz9e67z0M1m7VP8pOk2uvhoikJQsBisV9F5LXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pEskgIRDPAKuzrhvNeL4EectPqhXm4jFhN7L9x9UpreSYSs88iaq4COdPhXZXGItnYOoe0yKp8Tokbdtc51CGrskQynfH8T2aJDYwmFnNS5gmiJGGFFjqD/XV5z+KyJGDMkJK3tc7I1JVxaFQ1g8bDmVz6Id6qKni5w47UFfxoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dtQ5Mz5W; arc=fail smtp.client-ip=40.107.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS9mjdl2UbyrmGBqL7ela5a7HahvlXh3oMWNj/EGZ2/Dil2ZuWqsTmvBwxpmas7G9s9MUrG+vT6NdyHm5CD53dgslIr8coQO3pkXJ/Utgp3rE74g8KN6Ep+wqVvXuZWt72NFgXZ5XJhufpwr3PujczYqrCmfxiR2anpUmWb7vx49zflzzdi6SwBx1MbDVz0BHgCwayeoBPPYSucGbrsCQ6HFKt6/bemeQY+JFBI6S/zoJeGl2sYTSqZiDl/SfamZF9ZhwoW7sg/o70Iyako18K69n3wsMDEiQ1EGkNMseclPsvtHdhPSgm/yjKATOrhiEH+vXsU5XYFfulp4/Rkbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNwCsRp1FAbJE9CDSb++f+8Ns3VziNP+dKeWbaRwM9M=;
 b=lHohyTiUASlGB65CMFOcbYmJh64F3C4PMqM6kYTF1SiDXgbHd3JHzw4kFKceELJ8PQSiUfcN2OiuqNB+6zVapDvlikPD74NItxalDBFedfsImmZU/Ex8G/g5F33ohQTrFIZzPPAT5sy1R7sXgWTcPrRHQm1l8JMi6fgzj1qKvzUGe+jcgcy8fNOiQ+idXWqLnuqlqniLoGtscclfiCyo+zzlnXX2lji/LFJbYAcDCSswVKlRmPWCeKowls6rfHWtH3GXnXT+rxwimjNY6oM47kNEsgKFuIscJkDLc3p9aReuBH/oMhomq0D1O135jDRQJ/x3GFVl3j9PKnwuKRBUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNwCsRp1FAbJE9CDSb++f+8Ns3VziNP+dKeWbaRwM9M=;
 b=dtQ5Mz5Wr4MFTlbOEUomHdKpELVg4/pPKBzq20nULcJyjrSD7YfBlQ3Gx1R54q7y32FelC48+vmxAjbCzjkWIo/fQUEdbznlw/YAL4dx40co9+/uFD29Jldoho1eIBGyzQ6Ax7BL9/CHIblN08hWlfOBw9Nopw+oixAeYvV9ud5QIV83Ds6u20fMEciF3vv6BaBxulrYzcQMRd82Y3HYQjLHjYaejZ5dRNFDSYqoPpBQCWFZGc3CQlvOpFvcfeOsofhTbVmJSg5ubtAu5vIUS/AITjvOM3i8QNkLIAs0wWIcD1CrVKy6U+k+onwEoWb99brnxP/oA7mTRRsmxZLDxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 14:15:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:15:05 +0000
Message-ID: <da2016d8-cd10-444a-ade8-005250cf03ee@efficios.com>
Date: Thu, 30 Oct 2025 10:15:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 03/20] sched/mmcid: Cacheline align MM CID storage
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.466070081@linutronix.de>
 <996b1e7a-59df-4638-9dd8-ff6edbe8d1d4@efficios.com> <87y0ottny9.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87y0ottny9.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::37) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cbfc0e-fffa-41a0-cd92-08de17beb925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjFONmhaalplZDJzM083MTVGaFQ0OURYS2hKL3Z4L0phS3c3N3FHcCt3WWxD?=
 =?utf-8?B?QVBJSS84U25DWXJuMGh3anlscVY3WTdDVTVka1dBbzgzVVluWC9MQTRkeWMz?=
 =?utf-8?B?eldZZVdWT3Z0Z3hTcmNKQnBFWTRjVldtUGRGWlZMYzdUbFNiTW5jTGVhQmVa?=
 =?utf-8?B?S3hKVC9ReVZESTlxQldENjZmUXNkUjYwOVVYTmRjZjBRL1h2QXlkeTgzYk9m?=
 =?utf-8?B?dERQRkpBK2RWeFhEZmd3clFvbkFxMXZwUCtDNjUxK3MzMUV2NnFtNGd5bzhH?=
 =?utf-8?B?R1laVnB2MUp2N0QzcmJ5OU5Ickpxd20xRzFucllBKy9vSkdhNVBZNUxLQWs3?=
 =?utf-8?B?V1g5RGdRUW9BVy9ORGtYN01HajlvM0RqQ2dKd1A0WTBheGdCWWJuVFFOT0d1?=
 =?utf-8?B?ZWRReEM0S1FSUjZlMXNXZGkyNkVQU0EwYWJLRDNubnV6a3MzTGs3b2NZOWRl?=
 =?utf-8?B?V3ZBMElCb2ZWNDZVcUcybnIvOXozdk5hS2FpRGIxcm8vRkRYSGV0ZmFqOEw5?=
 =?utf-8?B?N2ZtRGM5TlZPRktZempxZkxBUXRqaHY0bVluTnROd2FEUHFiM21YUDlGM1dV?=
 =?utf-8?B?M2R2d25IelpSdkp5aWhTU3VSZDFVOE5LMnUzU0J0UDRCb3R3U0I0WjBLbmVs?=
 =?utf-8?B?dlRMSFlNdmVOZHgwc1NVZGRBcVhZTlBEaEJyMStzbHhpTHpCRnUzck1SZHAx?=
 =?utf-8?B?ZmFYWkZNeE9wbEYzU3F3MzJvN2VJMEE1VDd1NWFwT2F1QVFGVzAxTm9RUWdh?=
 =?utf-8?B?Tm9uZVdVUlpaZDNLYUlENHhIY0p1OGsvR0lleTBCY3JWajNOL2tDaDZzQ0E1?=
 =?utf-8?B?cU9rM2lINzBSZjlMUDVYay9Gek1JVThwQVYwazR5QkR0bkdPSUVqcEE2UWUz?=
 =?utf-8?B?eU0vUjVEclVuK3c1QTRCWkVmQjM0aWhHUGdpNnV5Y1FQcVZaWlNwY2NwazdU?=
 =?utf-8?B?M3JxS2xDUm5qRUFoSVdHQTBtclNsOEZTVlN0WEc4clFERGlCSHJRMExOYy8y?=
 =?utf-8?B?bnk4T3lsazJLNWdOOGRMdm5YUVMrSWtodlJQN2kyZEk5YktzTE5zdXF5TTNo?=
 =?utf-8?B?dWdNTVdubm0zQjdaWTZ1enE1b3pQK1BWY0V3Rkt4T0czNit5QXlyU215UTVa?=
 =?utf-8?B?eG9rMTZ0MCtkaGJRUWlaRENOenVOUG1DMHVVZVgzSWNpQVNZOEcxUVNNQlFu?=
 =?utf-8?B?eG83eDZhMnZrVFVFdU1Qeml4TlVSeGRVV01ZN2xCWmxFb3VaVmpZSGp6UHRO?=
 =?utf-8?B?ZnJsVFV2ZDR3ZWlENzUxU3pyN0pJYzBLREZrRld4Y1dFaXJMMFVVZ25OeHNI?=
 =?utf-8?B?SWlzU1g2STIvU1I2THlWK1VNcnNqMlQ0eEs2V0pOekNsVUt6U3JKUTNGR1ds?=
 =?utf-8?B?OGIvYml0Q2tsTjhUMHU1ZkpYcXdGd1orN1NZVGYyMkQreDZDZjZmT0JPSzNC?=
 =?utf-8?B?NGpOMG5BK1hsT29OYjkzR0VBb2ozbStHOHN6ZHl5TFV1SGxsUzlnZXl3RVMv?=
 =?utf-8?B?NmZ6S01qUzM3SUQ2MmZEYTZpMmVzckcwSUNpaWJTeXMzWnozNGlOVnR6Z0x3?=
 =?utf-8?B?UzdsM2taOTJkWGZKbTc1U2pOYm5PcEZBaVZId0o5NmRIMUdqRU5oOVpBRDJK?=
 =?utf-8?B?clBTaFNlaXYxYzZFdEp2SmZWbFFEU01qbVFtWDhsUmFQR1VIQXV2YjBQSHds?=
 =?utf-8?B?OWxNcC9aNUZjaXY4aWZQaTN4ai9GYUFocHlLMGZBLzhyRVA4TFNpbzJHZDJL?=
 =?utf-8?B?V1BtOHlCY3ppRmp6YU5VV2NzdkRYdkZHODg5R0hlR1NXRVNvTnVIem9hTjFJ?=
 =?utf-8?B?cDIxOGI3azFZZUlIZUZ4UHhXeXFmaU9BWWY1R1RTU3NnVUpTNWJMN0hqQWlF?=
 =?utf-8?B?eEI4QWUybW9EK1lIYnV3QS94TTI4SFpINkRuREpoTlNtWnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXZFdHhmZXFQTXlWcTZONG85RFFONjc2OHVEL3FZZGZEYUhLU21YVFQ0eUZJ?=
 =?utf-8?B?YUJFR1RNbnplM29lSFl1T3BEcU9TNXpGSExnYzBkQ0hqQ0tSOFUwSW8vRm5s?=
 =?utf-8?B?Z0ZKQkR1UzAzK0l2SFNPU0w2MXczU1ZwV0Jmd2FSY2hmVFY1emU3aWt5dzFI?=
 =?utf-8?B?RStmUmtZcVJCalpjOHRtQXhOcHloSkRCb2xDM3U1TkMybnhhVkdGL0YyVFpS?=
 =?utf-8?B?Yjhab0krWUJMVHdPSmRLZEkyKzY1V3dqSnFRR3YrdUdaenp1YXBqazNsbVYy?=
 =?utf-8?B?M0JPRlU3Vmhnem1uQkpDY1QvUnVoY2hiYWFMRGtSSXVWNkIwTlFZeHNDY1hz?=
 =?utf-8?B?SllrNUNVSUljeDIxUGI4VDN0RjZnV3FvOGJGdWIyZHBrZGZxdkF5bWJpem16?=
 =?utf-8?B?amlhZkVaMllLUGFaWlpDb1BEMkhIY0swdDNBVlVFVVlRdWFUOVg4Vy9YeWNV?=
 =?utf-8?B?ZVNCUzlGZ1N4UnMrZVhaY0paYzhQMDJMeUpaSVVnWW1xYk9nZ005Y3lOSitR?=
 =?utf-8?B?YzB3ekZ0SU9DOGFsTUpMWU9GOEplZWpuKzdrZkdaVTNWU3VEcU81RzcwK0th?=
 =?utf-8?B?VXNWeVNybGphSkk3ZkxrYkxnRjE2S1NEQmJGd0MrSWlPd2hhNk5FckdoY1ll?=
 =?utf-8?B?R2d2eTdILzdHemNpaUxSUWpzK3gvR1VKWVZzVUNnOHliODFxQWFWYWNVTUsz?=
 =?utf-8?B?a2wzaEJWRUxtVHR5cHh5RTNCN1k5WmkvSWhjVjJVd3Z4TysyanpjMFZ1dVBK?=
 =?utf-8?B?WWMrWnQyM0tSSHB1YmQ5KzF3Rk5WUUVVUEZ3Y1JUdlVkaUxIelphSXdKamZw?=
 =?utf-8?B?QjN5bEVLOHZIcUp2S0E1TDRxRzdTdkRHTFFCZ2Y5YWdFbTFuMDg5czEyT0hD?=
 =?utf-8?B?MVhTUTFNU2w4VjI1ZmNSRVgyZ2ZxN1NoNmNBZExyYzhBZENYbG1ZR09QbGt3?=
 =?utf-8?B?ZTV2T0M2U2p0NnJhN2t3RVZORHB5Sy9vMTRNS1YwYWg0d2RDWWc4dlBxNEds?=
 =?utf-8?B?elEyR2p6SG8vWTMwb2VPaTBWalRGa0xCRUZ1d1FocXloUXZPU0dhZDNwOXg5?=
 =?utf-8?B?WS92OVpxL28wRDlJazcyeG11RWgzVUY4VVBlMHR0NUdCRG5MNVNneHFock94?=
 =?utf-8?B?bmt2NjZnWlNvWlhtQ0RLTXBPdzEzaE9Pd0FuQ1IyK1ZqNmdGOFhheVoyVFRx?=
 =?utf-8?B?TmtmR3hZQjNKbzhSWmYzellpNUJTMVRxb29zS0U0YW5VajlOZ0lVOUNJazBq?=
 =?utf-8?B?Z3o4QWJ3cEtaTnNRWDJ4ZUZ5TFF3dFZ3S1hQUkJJR3VyazRnSG5jRXkyWWRo?=
 =?utf-8?B?bURUejV6UndxM2U4RTRCWkVGYVlwNHRoZkVQT0hPU2xxbUdFUDlaNzlPRm5G?=
 =?utf-8?B?YmJHaHRUOEZWUS9BM01aejJqTlF0K1JkNkRwN3piRi9tNlM0R3QzT0wwV0FP?=
 =?utf-8?B?MFpEVUlCWW5mRjhJYlMrS21yT0N0YSsrR1cvNDRvQlJheWwydVlRTHlIYU93?=
 =?utf-8?B?YzZOeUN4TG5GYUdRZytOUGVMellVZUUzYlA0clJNVFNpYXhIbEZCTnFUMlp3?=
 =?utf-8?B?cmdvVGxEdVdJazBaTWN6emFvbXlKbHdoQkQ1Tm5vNDlTdHRZa1JDOVhwc01k?=
 =?utf-8?B?YllCMDJTZTBLOFdaTStTVmxtTGpvZkRpRmZ3bjNDais5REVlbTFnL1RSRHZt?=
 =?utf-8?B?cjNkZGoya3BmdEVWV0F3aWx1WDdiaHVPN3IvMW5BNXh0ZTdUTHJ3YWE4T3I5?=
 =?utf-8?B?U0hFL2ZBMlpqeWFucjluYkw5TjdLbFVjL0NCeGE1RnI4NHAyTTgzcFdxblQ2?=
 =?utf-8?B?TC9PVEhSd2Fta3U2UGJzUnZDT0pKS0pjNjNES3FPcy9yaFMvSFo3ZnIySExl?=
 =?utf-8?B?cVFHaDhhNGNMRXJzaXZvallGeGYzZEpFTUMwbFk4ZDJDVGxvdXZyZ0xZTXFl?=
 =?utf-8?B?cDg1MVFTZGlUeEZDdlBLc2VmanFBbWFqZ3I4N3FzdXpZZXk1NzExcndwU2E0?=
 =?utf-8?B?STM5SHFHbVRiL2ZWQUpRd3Bjdm9YRXQ4Zm56Ykd0eEVieFppQms0ZjJVWmFu?=
 =?utf-8?B?THR6bU9MUzdlTHB6TERLa3MrSC9na2xkbWRzMGRZOG83dkVseVBEblJqSXFO?=
 =?utf-8?B?TUppNXh5WDhKQmU1NjBaakdVU0N5aFRPNXhEVjJzem1LTDBuK25hVkMwSEdQ?=
 =?utf-8?Q?B5L65l1Qy9lV61l5diCInR4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cbfc0e-fffa-41a0-cd92-08de17beb925
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:15:05.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRv+ZvRcJEV9ZVxRxquYFpdesogT2g7YRb2LWqUyQqgGOBa81K+xt/k7mnoK0v/Plg4hhqcZu9ssUNWZQoNkvaoLQ9PfHoXAGkbdCaa4kc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8537

On 2025-10-29 17:09, Thomas Gleixner wrote:
> On Wed, Oct 29 2025 at 11:39, Mathieu Desnoyers wrote:
>> On 2025-10-29 09:08, Thomas Gleixner wrote:
>> [...]
>>>    struct mm_cid_pcpu {
>>>    	unsigned int	cid;
>>> -};
>>> +}____cacheline_aligned_in_smp;
>>
>> What's the point in cacheline aligning this per-CPU variable ?
>> Should we expect other accesses to per-CPU variables sharing the
>> same cache line to update them frequently from remote CPUs ?
>>
>> I did not cacheline align it expecting that per-CPU variables are
>> typically updated from their respective CPUs. So perhaps reality
>> don't match my expectations, but that's news to me.
> 
> It depends. While per CPU variables are typically updated only on the
> local CPU there are situations where there is cross CPU access and it
> really depends in which proximity it ends up. I made it that way because
> I saw the accesses prominent in perf top, which means there is
> contention on the cache line.
I did notice false sharing in the past within the mm_struct between
the mm_count field and the mm_cid percpu _pointer load_:

commit c1753fd02a00 ("mm: move mm_count into its own cache line")

Before understanding that this was actually the pointer load
that was false-sharing with mm_count, I initially thought that the
per-cpu memory somehow had false sharing because I was reading
the perf profiles incorrectly.

I just want to make sure that what you have identified in the perf
profiles is indeed false sharing of the per-cpu memory and not false
sharing of the per-cpu pointer load. Otherwise we'd been adding entirely
useless padding to percpu structures.

Note that in the current layout, atomic_t mm_users is right besides
the pcpu_cid percpu pointer, which may cause false sharing if mm_users
is updated often. But if that's indeed the culprit, then just adding
the cacheline align on the new struct mm_mm_cid suffices.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

