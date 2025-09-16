Return-Path: <linux-kernel+bounces-819354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDABEB59F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942424E4AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC4125A331;
	Tue, 16 Sep 2025 17:23:45 +0000 (UTC)
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2096.outbound.protection.outlook.com [40.107.122.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46457247281
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043425; cv=fail; b=owttRxm91Avz7ulrUzzKb2QoNonU/8mTWanJcrfUHzBtSqx6Odi1Zo4CiKp8gN8fo1y9ak6LX3YkB++FvFYxiPVfvYOu267mE8/x/HR/HpzhA5kEJCno4/IZxe0L6l7i6VtNvam4eyH1WtOz5sd1OBbQ9WMIPv3i1YG2evGR6lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043425; c=relaxed/simple;
	bh=6GPkPpaEQVUpJQGVhpQQHYh0IY7/IbgN8Jge/I9ioG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nwRbTzl8AmJObepD07zSoo00DzAxaDyi7BcnaW1zTYo6PbPo6WG0iVk7/G2gQDwotTPjPLOnBd38kE1GJNGt+cRFq8U+zw+r65LjgrZ7rAz1whCbf1WeyoYMnAlXMc/wrHu1qTzLr/iue1LcVJw0SUNewHDGr54DoVM3mvoGeyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=40.107.122.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoaJ4QRuziRrINDyuTvTxYTh7xkCmT1Y8Cz9hDQrWE1MqSJKj4W+QyI7FvyfXVGEPlOHS3MBcq5xiESoz8olVmX95VSgTVblk4UPxV11fjGzCldGLSEAfIMlfwQVLOH1B7tcOodAIT8dXuIZxYlCiJzw1QjwbHdv0Yo84dgPNNSFQVJnbjPAfQbKz1WJ9puZEKSbYxuaWyxdSBH9HivJwMKK+YE83b6CXpIrnR4XEwTe4dJ8fwFtNiLhl6rCnrt0i784I6VHb9zyx92XZVSj8xNqloK9ZYC2Lni2D1x8y9za+8PRSzLWh6yZNC54QsTzUlF01vDSyfAn7GFMmlXIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9tm4zGroald3dJOXSEZiAsFPV5eEskoynkPqkMTa+I=;
 b=THsM9zcNpwFxWlukPI77jcPM1ZjkdPtN2YJdUHgN3zn3sY3wXRn0L9UCr4tCWG/I0r1N+hDcaNNTyWCin7rFHe2Ik8r/QsRTh19AoK2Wc8uEUVCg7h1XhpLO5/PHbTF10i1//l12UKCyrLr21ItUCYKAXRk/SCWa6trAiYmpgsuFYn1HzqZZ9/GfT/7RLWz8RRYSxFqq4aL+ULSKbgiVNFOpNEkltbMd01vX7DKeZLMaCjzf4npyAUIpofgtOldqPKk0G6RYARLlJp1yZCrI/Bxis9+AEix8RHT73BLhORswSO0j+V35Ja318Yk16uCOfkgYujybyY7gNDZb+ckcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB4072.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 17:23:40 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 17:23:40 +0000
Date: Tue, 16 Sep 2025 13:23:36 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Phil Auld <pauld@redhat.com>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, shashank.mahadasyam@sony.com, longman@redhat.com, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
Message-ID: <ttgdkklsa3dsni2i2yy2vf4qmu7vfwlwnkl3qpprikgb62li7u@5vcwgd3vgt46>
References: <20250916011146.4129696-1-atomlin@atomlin.com>
 <6zi6fp2kgs2hjychav3rrf22qwwskegdq53ew33tfn7rylueik@slugq2khaakw>
 <4nafhr4wqvta5uk4jfuxi7rc7fyaurflrfxa54ajaajy3o57mj@55qzh24m2u6s>
 <3emv4bx2o7mdv7oc72ffdinlltqohqjt5nxgccdiyw47xjgbww@drvkcpiy5zq5>
 <ziakoghx6xbfvcocc5kcrcw5gv4xlphto44bptadkfbbtyf6op@d2fvj7rbec26>
 <20250916170735.GA5293@pauld.westford.csb>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916170735.GA5293@pauld.westford.csb>
X-ClientProxiedBy: MN2PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:208:d4::25) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: c70655ca-d1a8-40b9-52c9-08ddf545c70c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1JmaE90RWgyY0JoQlJ4YTdTYWY2ZGZTTGl6OFBFYStOTDJ5VE96b0hGdDhI?=
 =?utf-8?B?YkU4MVg4VHluVEQ2U2JzZGhXVEt4eFZKU3VicTVHbEIrUTRqWi81KzMxRWF5?=
 =?utf-8?B?cVV0VHk5WHk4dm9nN28wRlA0K3ZKWHNRczlOTmZWTlZtbGpZeDdUcnBseVA5?=
 =?utf-8?B?VURNZGdJRy9wU0dNcWFSeldVVTYzSnFXUDJYMG5IYitWNGNLdFJaQU11RGxQ?=
 =?utf-8?B?YnZyZXlkUm9Gd3YxNFlBZmErNkx4cDB1blNDamdSREpOVERpYmhGdUlpdUpN?=
 =?utf-8?B?UE9XR3NjQ1pPQkVpT0xqUFB2cDJYZjljbWF4dU55MXB5Y3AwZDY1Q2o2Ry9m?=
 =?utf-8?B?V21UY2luUGdrWE1yelo3SjU0ZE1QeGIrTHpQZzdiQW9VWFJTTkhKdEdBano5?=
 =?utf-8?B?MlNuZ09qK0x0L2pqWUExamZPQ2ZFcTVINTNZZkNua0NOZUV4Z1Jnd240VXFD?=
 =?utf-8?B?bmFWL2hHVlN2emV1SDIvYjgrUjhXSHhYN1JQRjh6Mkp5bHZVelorMnpDVm50?=
 =?utf-8?B?a204S1ZtRGFuRmY3RVpQS2paYU1EQXVnQUhROTErSmNpNjNGRmdZSHdNVXE1?=
 =?utf-8?B?UTFsVHNQQUJkVmtxdjVoVitXeUtpMTI1ZmlQSjdpOWljSDNaWldIMmxnYnZ5?=
 =?utf-8?B?MTYyWTBETC9uWUlNY2RXOUNLVUN3YmlMdWs3QURVeE5ndlgzNDJrUUlnWllR?=
 =?utf-8?B?aW9ISkVsZWl1cXR3OGp1TUQ3N2duejZhY1pXa25QSU9tZDBUZ1lrVktCamlh?=
 =?utf-8?B?Y0VuN20wNnpPK0dFK21qblJrVlBUS0gvZGdEZWovRjlmaVQ3V3JEczFlaVVk?=
 =?utf-8?B?Tlg3UmphZFhBS2xFQm0yNUhpN1RVdGIyYmFkSzRrNXpMMWw5cHV2YWFCZXA4?=
 =?utf-8?B?aXpINzBiN0dwZ0xoRG1nUjkrRXBldEZUV1RJSFhyU1BxWmtyOEprMnFmdWZz?=
 =?utf-8?B?ZlYvY0c0MTRVT2J5S3hTamJSK3lxc1dzblpNcTRsMndQcG45cmhxVFZNVy9H?=
 =?utf-8?B?Uy9SUFJpc2RRUzA4WWNCK25BeGRqWllCc1hxcm1xakZ0ODM5T3lKWTBpRTBD?=
 =?utf-8?B?WExDb1BZZ3hGRTZhMHd1S1J3OG90bTVNNHl2MkhUY3pxN1JEclc3T0dFZ1hY?=
 =?utf-8?B?RU80c2JLSXZSTzJQUG5WNGNIdG0vK1hGbWplS3FOR0tidmZLZEIwT1loQWM1?=
 =?utf-8?B?emp1blcvVFZTYzhybm1zUlV6QXhzb3lJM1RnNkVUamhZTG5qTlY5Sk5BRFNZ?=
 =?utf-8?B?YkFBK1BhS2dvZHhhYnFlVFYxTktINFkvUDlXU2szc3BjM1ZHSjZZc0tzdzdL?=
 =?utf-8?B?a2lETTBFaHdOV0tLd3ZVSHoxblBvaWV4aUQxcmhyL1ViZkFYMHBZQVZaNHBT?=
 =?utf-8?B?SHFCeGUybVE5UlJkL25ESUN4ZXhVNHpURU42VllMMCtmTVBkV3dySm0rUFpr?=
 =?utf-8?B?REpncnVxb0F1MTZkcXJPZzV0MGcxMkkvUmd0WDZ2RGJJTk1hZytGOGgvNG1L?=
 =?utf-8?B?dXdFMU5KR1BUUjdVVTg3RmV2S0Z3R3J5MWczZE5Zb3VQalZVdEJSdSszcjVv?=
 =?utf-8?B?d1RiWW8ySHVDdFhEWWJSVzRENkREOUNublpoQWwyTGhXbUZ3ZGZHaFloUkxj?=
 =?utf-8?B?MHdqczFqS0VvY0lLYXUzaDZQTXV3TU1OMitqbzdRVk5SZlM5aGs4WFBGQk9I?=
 =?utf-8?B?SHdORkpneGZ5TEFmT3AxOFlURFJyZ1ZFcmkwb0swN2hQcHp2SFl4YkoyU3Zq?=
 =?utf-8?B?M1pmeFc4RXdWL2JtZHVBTkFoTlpCMmhDOXF3Q2RwRG15anVTdFVaSFZpM2xJ?=
 =?utf-8?B?d1dkcFg3ZkMyL0toL25xcnI3VmdXdkxDRDZsdDFPcTBLMGxhZVF5TWJUazlB?=
 =?utf-8?B?TVE1MG5SamExcnorS2V4K3lESUxIODNMaktVczNJYjNSdnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1JYTjROZC90MmJsT0ZvYUZlUW5YTm9yL1BiL0lVUm45Unc4QU44N2RrbHBo?=
 =?utf-8?B?dXcxaTZvTm1saFRZV2JJd2tvWDlVeVJJeC94Tk9lK0Jld1ZlQ3g1dnRjU2tK?=
 =?utf-8?B?cEVMMkJiTzdtcm00dTBQOW55ODRlaitrTHB5b1ZSNUtoL1E1SS9lcFUrYkRO?=
 =?utf-8?B?eFpqcTFnTDh2c0RtZlJxSTJobTFId2p4V2pyRXNoZmtMZ0dRakJUOTZiZlkv?=
 =?utf-8?B?NnFOUDRtdi96N1RERWxMT2JEVlM3WUlXUjhkNDdwaXZTL2hYS0ZVT1M1ZTdD?=
 =?utf-8?B?OXI3dTRuTzVSZndSOTJLL0hFVnRQbm5RZ0dnNGRUNStpMGowRmRXeUNMcTBl?=
 =?utf-8?B?cUFmWFNrMUdxTHRxbm5UOXRST0Z6eXdqeEQ3QWNmZ1NCVG01WTFnRVBPVGo2?=
 =?utf-8?B?akhob0xrcENYeUdGY2Y1R1NVNllBTG1oTkFPcnR3TmU1OUxGTmU4QkI4SXBu?=
 =?utf-8?B?RXdQUjQwNmdaUUdEMWtJY0ZkV2V4QzBJRVU2ZSt4QUtiN093T0U4bGVWWXB6?=
 =?utf-8?B?cGU4bkdaeko5R3pVbzRJSFlRQnZKbzJHQjBSaWFtanRHZWljQVZydVZUVWJ0?=
 =?utf-8?B?WFJyMHdZWVEzTXEvck9yU2JEQXNYWUhFS3R6TUlPc055emlNNEFvQ1Jyam5p?=
 =?utf-8?B?UmEvcHV3V21sakhNMjU5OEZDc0ZFekFtLzBJN1U0a0hQUDZPY1ArbGpvUkZK?=
 =?utf-8?B?aEUvZnB1aGw4TVV1aGZucElsTnc2MTV5Z0h3K0NXdS9vTG11NHVLOEdCYm96?=
 =?utf-8?B?T2cya0xWbllRcjVsdldRZlJtclliRkdDTnhaRDR0R2R5Q0dxSlJaU1FFTHJl?=
 =?utf-8?B?akI5ZWJGTzFOUEx5Wkx1YmYrd2p1R0UyUU5pbTVtbGJUUGR0QXRMeWVnc2wr?=
 =?utf-8?B?c2RxeitndkN2V2lzYWxzWFMydmwvOXBVaDltZ3VzQ2xEQlk0bHZ6NTRNUWo2?=
 =?utf-8?B?TEFoNjFEYWRYQldyekNiSGJnRlVncTZaUFpCeTRGUlZtbzlBNzNta2RNNkF3?=
 =?utf-8?B?QkRuV1FUQkwvSlRlZGFtVzQ2WHNVUmxsMUE4ZExOenFBblhpK2tyR2xaQmIr?=
 =?utf-8?B?Z1F4UlFsRld1YWtaTk9Rd0N5Rkc4N0tCMjl1NlpyZG1RRDJLbytKMGpLOFJj?=
 =?utf-8?B?Z2RIY0t1RGJsWDlPWTRucTlSdUdIaG9sakl0ZnM5N0twREVJM1V4cmZHdTIw?=
 =?utf-8?B?Sld6aW5oUllQMHBwTW1JeE1ab01mVlVVbEZ3QW93dzhkMmNwc2JsaDFWSUs3?=
 =?utf-8?B?S01EY29VdkdHSW91RDBvRlFYWEZjKyszT3JSczlLZnJGU2lWWkhSYjh3ejhp?=
 =?utf-8?B?ZS9YdktlSXQxcVcwY1NFNW8rMEM1WVduWk5MQ08yemNUMW42ZzFQL3BNanhz?=
 =?utf-8?B?OFJYZEo5WXNJVDFqWXVEOUdpTVRyVjUzMlBZMHBvKzI2djZ0MlZQVHJRM2ow?=
 =?utf-8?B?K3pYZXhSSDc5RVV1Zkh2MWFUcUpqQzJXakIwOGxNenlNRU9hNmgxMVpkVzh0?=
 =?utf-8?B?VGVMcWdQM1l0MEdaeVpZaWM0ZmxycVlyL2U5cDd2b3pZSjF1Vi9RUDJNSEJz?=
 =?utf-8?B?WXpjcDhyd3JFRG1Nd21pbzdiWWkrLytuZG80SnptUjBCTUdnMDRzSzgvZUlt?=
 =?utf-8?B?RklvZlRIdFJpUlcwMTBNYldWKzdYM3JxdDZ0RU9pWjVnSW1Yd3ZYak9ScGlU?=
 =?utf-8?B?OVlReVliWUNGRSszWTlOUmxBN2dQOGxFTW1WTDgzcFVpa0ZzTUNuU2FQSkV3?=
 =?utf-8?B?eFl1MmpaR21hT0czMWhENm1hTXFaWGo0OGRtL1MwQ2pWaHpON3B6VjdGT1hH?=
 =?utf-8?B?YndQUklLWExjbHQwSGo1SjBFcjBPU3ZReUJTZytsNW8ySE52VmFOaVpvYTIv?=
 =?utf-8?B?TnNFZVMzM2xUMG93c0tlaXVTWUdrNzZMaDYwMStLeGd3N3hDTHhXZE1FTFFQ?=
 =?utf-8?B?TWozR1BlN2hNWGhXYzdIS1dHbldvSHhlbktyNFRCYWoxWmpwSFJDazFrNHAw?=
 =?utf-8?B?dTdQbDBuVXhXdDV3cnY1MW8zNXhHK3BUWDlRNUo3NTN5VFp2ekR6ZWZScThT?=
 =?utf-8?B?bFdYQXUzNWdZZGJOMlJXaWk2Wkh0WjQ3ZFpRaklFNUc1ZkpEanI3SDRqdmpG?=
 =?utf-8?Q?VZigLOBdFsiG3Ti+E1tGrRYew?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70655ca-d1a8-40b9-52c9-08ddf545c70c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:23:39.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eg5ZuWdgmpM6QzIIehC3O4fQn4C04fl858hWPbpFlRwR66G3M7zs2JMvUhJQTYCqCckCtPSVb1D29BmyaJzm2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4072

On Tue, Sep 16, 2025 at 01:07:35PM -0400, Phil Auld wrote:
>  CONFIG_RT_GROUP_SCHED is not enabled in RHEL9 and later.  It was on in
>  RHEL8 which also defaulted to cgroupv1.

Hi Phil,

Sorry about that! It is only enabled on RHEL 8. I can see under
redhat/configs/kernel-5.14.0-x86_64.config it is indeed disabled.


Kind regards,
-- 
Aaron Tomlin

