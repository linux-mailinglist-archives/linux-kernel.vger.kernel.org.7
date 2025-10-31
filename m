Return-Path: <linux-kernel+bounces-879418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7611DC230EA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EABA3A4360
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8315C30BB95;
	Fri, 31 Oct 2025 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rcXq//Gc"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020134.outbound.protection.outlook.com [52.101.193.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4612EC0B9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878818; cv=fail; b=qUsezhMQZGtBA33LytDFprNz140TZuNsuAsgk7nhBgVJbgL5JTOO4RZgnSKdnlMJFURemISOSfBzaHwHMDUZ2Q97V4xA4GdTP/3tskL+vDl96tB8qx1VZ4Y7n5vDCgRZ+f5c/0tM5bKy4OxRcjRXqb5IXiGsG/yx9zZHjEO5Fg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878818; c=relaxed/simple;
	bh=3EBJ2X1eWqZWKw7QAbuTVQyt+bsvAnvdiet+GqqLPH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T87Z4aVuqwgbUp9xmoQC7vZ9eyRnFzHye8r8cJy3E0ZAfaF9Z+3KvhlKG7eQ3+kiUJUBflS0uSoUrbKzTidntT4AD1N3uXhnyNtoygSrns0a5regF7wvQBbrsNvQCb203FoyUD0DqjrycAcUrvJZBAe4m3wxh/ltyVsT1qnlDY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rcXq//Gc; arc=fail smtp.client-ip=52.101.193.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loz3Ead7SO9vrvE7TZdZoJGF51xaHdHMqxDTnVgT8Dn9D7W2U4p6rBNIXwt2QxzCEzYWUoW2rwv/WYSCB7ncfADLxGtKD9VEiMRruHg2ZADB2lCnz2pwHvNdD27QV9hQwo7Nzr1pMdS4v7GtyscG2/ocjWe0C3vhprgI+m+y7MqGE0IG8VI71FwMQbVxl4ukaI4k4aTelUFeM3OIIBYJDxXoXRy6R63djrFkdTm63MHZYgDmdfiZLgiiPBjnrn/xlGAskxRcAHqAIjAXmoAYTiHfhBWHH9lakpc0JfOQlPy5xFZnFWiAu9eaaaJ3m2vfJ6CmwigojKX0CJAywjaOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch0o2Y9s5dWNyujYCywWk/0F9yYwo4nYXAT+76Y2IfE=;
 b=Pe43DI5ARlxTlT3HX75PrzJ9zV4kaQWVLwGiDwZE65r94aqkk6JgEsjjqJK4w9eMf8A6nqqgmwDvrfkN2B3mCi5fgGQ2yg0uW0nV+JCv2qt+mJ4S+f+XuOuW0zK/SqdnfzVlGs4d0o0oZpX4m1ctZffdC1GYD+Fa3dabw54bW1yeLyMpICPxJYbZBhPHWkNyQyyeb07hiHPZY0NKDp2NV94GzQAB+f63YfULFXDI0WIy2gCuxOrFa/JGZobdTbHx4QljmcTkCiSWYWRxVe5rjO24GHNypXPxG3N2XiJUYHQkncIiJjahvQz8vao1ygsRPfTzyILTLupfAXQS7HmCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch0o2Y9s5dWNyujYCywWk/0F9yYwo4nYXAT+76Y2IfE=;
 b=rcXq//GcoVD4HzTh50erLVNlGbOAToNQ2T71x+85MdzT0t1jkIKThm/pTpsDYQgN+mf0bkc5zWFjIQy8yjwAB6wD2sVblL0QSsQMZVWPpxsxFvDz9SA+kCTqX+ijYjGsQvscPX6b3FuG1DVeIFBc/dPp839IfamvhTpf6VZPeSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 BY3PR01MB6579.prod.exchangelabs.com (2603:10b6:a03:355::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Fri, 31 Oct 2025 02:46:53 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 02:46:53 +0000
Message-ID: <55869094-17ef-4291-b706-4600c919a0ea@os.amperecomputing.com>
Date: Fri, 31 Oct 2025 10:46:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [REGRESSION][v6.17-rc1]sched/fair: Bump
 sd->max_newidle_lb_cost when newidle balance fails
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>, Chris Mason
 <clm@meta.com>, clm@fb.com, Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 LKML <linux-kernel@vger.kernel.org>
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
 <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
 <20251007113459.GF3245006@noisy.programming.kicks-ass.net>
 <36545e62-9947-43ef-9bc1-776f5663a45c@oracle.com>
 <20251010170937.GG4067720@noisy.programming.kicks-ass.net>
 <2aa7380b-bebd-4bb9-8597-49e06d1dcc6d@os.amperecomputing.com>
 <20251030093013.GI4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <20251030093013.GI4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|BY3PR01MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: b464d80e-080a-4b2b-0711-08de1827bfc6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWt4emFrcGUxSzVvQjVUanBMK0prVGE2M2pUcGFZRGxodEt6bytLUWVucFk2?=
 =?utf-8?B?RnBtc2Z2QzI1UXhsZU8vODdaSnA4eFIvcXduc1NHcTc2WGd2RjNTL1pmUFJD?=
 =?utf-8?B?QTZBRHFBNzNTYXB2TkF4TU9zT0ZQWnNsNm9pT09URm9vQ1p4cWFVaEdrY0Rq?=
 =?utf-8?B?djZKQ29vMXNYT1hVZFFVMFVXNkkxNnRvSDd1QUJYakZLeHB4bWo3WkJ4dEt1?=
 =?utf-8?B?WWpaQ3BVZzZnSGxIQ3FQWGF0QTlTQU9mMXhLTUxLZkVhdFlBSGp1NDRLWTZC?=
 =?utf-8?B?bFdUK1F1VnRUNmVUTHJhaVZkWExTZ1VUU1Z6NlJhMzJuOUZtYXRyMWtxVDNw?=
 =?utf-8?B?MGxvd1pHM0d4eERFS0NEYi9BaEx1dzBHRnF5amI5YjkwOGNpQXhYN3BxVmhm?=
 =?utf-8?B?ckNkdHdadVcxTlc4RHRhVEV0T2Q1R3hVc2c2L3dKUWRleVZXdFl2K016WHEv?=
 =?utf-8?B?a1Vvb3pDUVZBREVKRGxETk50QUl5L0l1dEJKMStFMk9McDFnQTRwYU5yY1BQ?=
 =?utf-8?B?TW5PQ29qcHFHMHlHb0czdDdnZGV5Q1dwY1owZnVENi8xdk9HTHV2RGFLZXUr?=
 =?utf-8?B?d2VmZzZkSFBCTGxud2NtWmFBRUVHQXNvOXYyRUZ1azlNZ1JqNUJsR1pGZWZy?=
 =?utf-8?B?dG9Kb1hmNzcwN0JrcVdUbVJsYWtmRnI2NFp3L1l3bnBxNFROSytiKzFsOXpN?=
 =?utf-8?B?NnJ2UjlWMmJTak96RktIeFhNaExTak13Q3VWWTV0YXhlSURVL0Z6OHo4RzhN?=
 =?utf-8?B?MEF2NFhFeXFuSFUxQWxpRGdtOGp0bnQ2YWNVRGRRbGx3ekFjalZrQUhMR1VT?=
 =?utf-8?B?eXBwdTBEVE5EcjhDaTRnODU0aXdacXViZ0FleW9KTWhUamNTcVNOam1KZDd3?=
 =?utf-8?B?RERjY1lsc2piSFpHWFo2NzZXOWJsVHp0dW5HeklWTTh2cnpLTGh3Sml3bHZB?=
 =?utf-8?B?cnVHOVJ5dGdOZUd3dkRHVXVJdFlSdHUvY1NYMmc1NjJxODdHaURqdVFVKzZS?=
 =?utf-8?B?OXNBdGt5RkROaFNOR0trbUNiWFdYUGw4Nm80RDdyczBxSmdCVWhpVXRwRG9G?=
 =?utf-8?B?b3c5VWZ5bWhWMUwxSjllbzk2eU1Ob25WdUx6dWJ0Ui9GckgwNkpKb0dIK1Nt?=
 =?utf-8?B?dHlwd0RyZ2RxOVlndEtnUHd6OUVuT3VyRVUva1IyaUkyY0x0MThkS0Zycm83?=
 =?utf-8?B?ZlF0WnRwTlVPT0J1Um93OEg3RkZDcEJSckVCWnFFSUcvUHBSTHpjZlNDYXVV?=
 =?utf-8?B?ZVdrL2t0d0VRKzQrbGdGejY1Yko2U04zdHAxK3hvUmJsWXFpbXdmR2h6RS9O?=
 =?utf-8?B?WThSSVJyZmY0UmF5SEtTVFYwTDNtdjEyUkNNSy8zK0IxN0Q4ak9rSnZ3c0JW?=
 =?utf-8?B?dmVWU3hPeDRjQnQxV2R2KzNvZTA3eXBZejV0eGVzN2xrMGtQeU9icjljd3g1?=
 =?utf-8?B?S2Z6YUNuQ2VjWm5rQ0R4QXhPQlo3dFA1ZHpEUUpQN1diWVMvNDBHL0lxUUVK?=
 =?utf-8?B?QUM3bmUrWm1vTG5MVjBCTThacWg2ejVwZ3Avb1RwelhuQ3cwTmMwazlsTmps?=
 =?utf-8?B?MWNMMlhSazluZWkxM1g4a1kzTGQwRE9MVmJ3SnRVajFHeUl3VGFxbFFXUUVC?=
 =?utf-8?B?a2JBK1NMQUNyUHFNdFFnbWFjUHRzT1dMemJFMUJVeUVhc0F1NHNTN2R3eUxE?=
 =?utf-8?B?OUljdFZ4UmFodHA1STR5WHdseVFNMjhIaExBWEZoOUtSUzV1VHhodEs5OVM3?=
 =?utf-8?B?MFdxUGJvMjgyQnlNdzFaZng4clZkaWNvMlg1Njk0ME5IajM0R3JZNUlBWXo3?=
 =?utf-8?B?dHFLSjVtcUJkYVlBSkhBN2RKK3hDOFRkaFNBemVUSTVUbzVUZ3dTWTFEL1R4?=
 =?utf-8?B?RmJvZ1IvaDRrVkhGbUVzVndxQTYycUdNL2s4cXloVWkwWStmS1oxZFNQSjV2?=
 =?utf-8?Q?PokFt0w1pWDrkruL2165GzMo5Ydhh5Zo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ci9EbE9wRC9zeGZCeFRKeXdtbmJHYnZIRlhpbGNiNHd6Z2tRUFN3Rm9mSm01?=
 =?utf-8?B?QzgrM2hkRXpiWG1DVFpqbFAvb093ei9samM0ZW9XNXlvUWpxb0tHSmpZVUI2?=
 =?utf-8?B?UythN2VQWTNjQ0lyd0tjQXBlaFRsVElPZHZSRGdObU9WdFlCSmEvZi9yV1Y3?=
 =?utf-8?B?UXFNV0FTbWFGUTRub0pUUVZHZHhnY3dVa1UvNTNtOE9CTER4WTJRKzdFUk1o?=
 =?utf-8?B?U214SHdGUmRzbXQyZnhxcm1oUkM1c1NuVXk5SUZuRzE0bUtRTTB1NkVaa2li?=
 =?utf-8?B?WWxhZHZiQVZaWE1QQktaWVJvaWNsVGE1YUhCU1IvL25MLzgxcU9hZDVrMUFq?=
 =?utf-8?B?dTdoRHZzS0V1dlYwWUlpdUxZdTlINEdoV2FPaXZmNDBNVDR4QnZjaG1kVWZ5?=
 =?utf-8?B?U3NnckxoYTRrMlpqeExDV21helNoenorU2ZGSFZwR0l2QWt5aXhIT2xqQ2lz?=
 =?utf-8?B?blREM055UFgrR3BEUlU1QWg5OUx1REVoNnBER3Y3SWpkSzdZcm1mbG1EMFVO?=
 =?utf-8?B?K1pVQkRMYlF3K1l4MmNJR0IvZmRReG94VWtObSsyMjhhbTdRVEFqaXQwMHdu?=
 =?utf-8?B?RnltTnl5eEdkbmQ2dVptektkMmw5S2Juc3JTbG1nUVQvOHE3VWt6R2h4ejBL?=
 =?utf-8?B?cFlodGdOK0JHUmp3Nk8vWWlWeE5vME13eHZYZzRNbVVXZzFGMUQ0MTVmTWZY?=
 =?utf-8?B?b1U5M2VONGp0MGxTcFRKY3FqdUFOdFErL2Y4NmNiTlF2OU1LaHh3eFpGaWl3?=
 =?utf-8?B?dStYbnBWdjFMbzJEMGhzdkJZZGhYSzdqcWF4dFJIU1RqN0VUZm4raTlocUJP?=
 =?utf-8?B?QkxjcHo4NG1rUlQ2TjlTUWk4eEw5eURWZ25Wb0lXQUVXSHRDZ3JlRm1NRmJF?=
 =?utf-8?B?RGhBakFGanZzcTlkRTF2ZW8yQVV5cEJWRnNqQzJWVzU4TEwwNGNDVm1FWUhC?=
 =?utf-8?B?QzNoSTR2Si83bGpndEZ4K01TSVpycndhKzRJdXRsam84cGdib0gxUFhJMjRO?=
 =?utf-8?B?NWxYYlp4Wk9CczBqWkpxZElkaDdUQkk0WTc0MGpjY2JKNDFzT2VwaEpMeE0v?=
 =?utf-8?B?eFg1VkptcndHZ3BPeFFGQ3d4M20xYTVCUnhwaEVYcnJNWnMrZEZkV09XMEF5?=
 =?utf-8?B?bHZNWHkzdGdRR2xoRFFtKzZaVzR4RnBWRytRaEp2RVJKbWpQOTNSd3ZubW01?=
 =?utf-8?B?b0ZSVUdqRTE2WVBUb0FRbzJRRGNGSEIwbjhHWkZFKzg2bWlZS0JhQUJHQTRu?=
 =?utf-8?B?TERGMmlSelhCOUFCN1N1Z1JGQ0VTWjJUcWZ1UWIzS0VaMlE0ZXY5bEJWRGdQ?=
 =?utf-8?B?d3NoOWkwT3p2bGtsMFY4dmVLTmZhcDBlZWt3KzNNL2FzMGdjNjlUSkllaG5V?=
 =?utf-8?B?QTlJeUNlUUNvekQ2QXBtaFN5R0ZLOVhadHp5Zm00amppS2lBUVNXMWVnYVRZ?=
 =?utf-8?B?dUhDUkZYek5CZnRpc20yUlRnNnp1WS9yYXR3QXo0dnBNVG1jTXNKbi9tWitL?=
 =?utf-8?B?VUVSL3p1c2pTNjNKWTFKZW5ldFZXYmc0VlVkQXd3SHllREVSZ2dreSt3bGY4?=
 =?utf-8?B?MmtTSU5EcnNqdmEySnhwakFBRVZFUmErN3ZVYkdFTk1jaTEzclN0Rk1ockcz?=
 =?utf-8?B?eXZlUWloS1BKcGVKdSsyWU5GM2VML0FIQjl6Y291dEJJTEppMGR0UE45MHB4?=
 =?utf-8?B?bUxwcTBmU1JXWHpvc0k1S2drVllna1FLeGRITkwrMGdqenFidnd6TkJNODlF?=
 =?utf-8?B?SXlVYU5LanpBbXRwME9RZXJ1NytxOTFaZDR4djBHWFFveFJUSXZRTVVKNkdI?=
 =?utf-8?B?b1kyMmZadFVsSWN1Ulh2VFlkTVdGMlFHRnVpYkV2eEFFZnpwSE9lNWxqVTJN?=
 =?utf-8?B?SDFpbytJM0xjTmwrdmxqWnNSQk5yak5KMDliNmEyaElZaTdSU2ZGZjB5WSsr?=
 =?utf-8?B?NUxlRS9wRlAzeVgxcUErZTA3c0FlUUxwQW5VMUlNdDZFTmZKQU4rZHZaNks5?=
 =?utf-8?B?UXkyQzhvaVRJdXV1MmN1NXduam1raXdiZXJkcHE0ZEFQdHlxdC9aVWkwOHhm?=
 =?utf-8?B?dzBUM3JaL3c4N1pVdy9wc3RSRTZrVnVpUHlWWURJUm5DWHllVnBMbTBybzRQ?=
 =?utf-8?B?UDJmR09YKzZnM0cyU3g1UmtFWGVRMUUyc0NmaWJyeWxFOFRGQmlZcE90VXYv?=
 =?utf-8?Q?Ba4g8cVws5lUyi7Z0UMVe3Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b464d80e-080a-4b2b-0711-08de1827bfc6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 02:46:53.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNGCLpBp21El5X3BVOgkyU6QrKBlKnmjstz5pyTaH0nEWPL9szpShTvm6JQH8YsP6I612L9TJGbQCAHE71InGMNDgfoHm+cRNPYtrNPAthQjg3dJgN/iTIsWnTeMZgNV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6579

On 10/30/2025 5:30 PM, Peter Zijlstra wrote:
> 
> Hi Adam,
> 
> On Thu, Oct 30, 2025 at 03:22:34PM +0800, Adam Li wrote:
> 
>> Commit 155213a2aed4 brings ~6% regression for SpecJBB critical-jOPS on
>> AmpereOne server. 
>>
>> Baseline: v6.17 kernel + patch. Compared with baseline:
>> NI_TARGET	+7%
>> NI_SPARE	-3%
>> NI_RUNNABLE	-4%
>> NI_RANDOM	-3%
>>
>> So NI_TARGET reverts the performance regression.
>> The other options brings more regression for SpecJBB.
> 
> Excellent, how does NI_TARGET+NI_RANDOM work for you? Like Chris, I
> found that the schbench workload was really suffering from doing too
> many idle balance attempts that weren't really working out.
> 
> NI_RANDOM reduces the number of newidle balances based on the success
> ratio. Eg. if you have successful balancing 25% of the time, it will do
> 1 in 4 balances and count a successful balance as 4 to keep the
> accounting straight.
> 
> So workloads with a high success rate will keep newidle balance calls
> frequent, while workloads with a low success rate (like schbench) will
> greatly reduce the number of calls.

Please see the test result of SpecJBB critical-jOPS on AmpereOne:

Baseline: v6.17+patch
NI_TARGET:		+6%
NI_TARGET+NI_RANDOM:	+5%
NI_TARGET+NI_SPARE:	+4%
NI_TARGET+NI_RUNNABLE:	+2%

"NI_TARGET+NI_RANDOM" and "NI_TARGET" are very close.
I will do more test.

Thanks,
-adam



	


