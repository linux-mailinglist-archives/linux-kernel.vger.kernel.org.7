Return-Path: <linux-kernel+bounces-757810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260D4B1C6F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30CF3B257F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A239228C2BF;
	Wed,  6 Aug 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jzhBVf2t"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308728B516;
	Wed,  6 Aug 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487737; cv=none; b=CpVJR5QJX3aHz6TVDx8diMkUW8rqmfg6aSLp3ybruJaZlbp2Hrrv2hypFWkfvbFp6/rmHgcMAaDWHBQ/qx0VesZeKrWnbsAgT+BrVVgH17tJr3NtI5HR7PisnuJrbgJlE5+Ph77fGI3SDGI5P2JCo9toX68OqTNsNGFUjX5UrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487737; c=relaxed/simple;
	bh=iwBE8/1WsePrRl6bUAuDhDJFqL3xQyMFGryT2lYbl44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8qVsw7g7TcXobQhwFUx3ZIuLCvtjOEr22Nw99ZvbWloFtPwW/KI9B9E1yogBNRDQ/YuM6zJJVLkPPNTzW0wN4zT5DTiMc3AHPrgrYdZN6S/3/NKUD/5xWl7hN15YtNVuTYeQu1O5uBcGPudZDiTU5U0GB8y40mbEPwQIwynT14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jzhBVf2t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766tEDi019425;
	Wed, 6 Aug 2025 13:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5UsBIc
	hovt9EWpZnlUinnSrJBmdoMS/ZpDSRkPsV+mc=; b=jzhBVf2tz7dmcXmdxLW//p
	tQ4Z1/yiGokejR4HzByaiH/p14eIsA2q2NYwTpi+hmAvtwcP1u4nZAg8g5RrhCQa
	1CpKICj+5SWrf5gXZNio6i3FCIfbGn9nKjFTfd+pDdOk6kabsSjZVnhYnoN+aLtu
	JJwuJchu6LdopLu3GjgmxuK+hix8VeHFaREs0FxssHvsoyBTvbaeNgG4EARq8s02
	viNn779538X6SSDKPgXx4bEZEfyhHI5nW1iKKKoabckjPYwYw3yChiSOfcQgNHfQ
	zpJKcxeN1sFa9MXJzUYAuJOabmx8g7dDgMWfI2uWECmVg+/aNNXCDCQpuU1+jp1Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26tss7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 13:41:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CUqlQ022699;
	Wed, 6 Aug 2025 13:41:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqbthk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 13:41:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576DfVsB20447790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 13:41:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EDA85805E;
	Wed,  6 Aug 2025 13:41:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D323558059;
	Wed,  6 Aug 2025 13:41:30 +0000 (GMT)
Received: from [9.61.84.78] (unknown [9.61.84.78])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 13:41:30 +0000 (GMT)
Message-ID: <5c46082a-c31b-4d12-a1d6-f315c8ce7aaa@linux.ibm.com>
Date: Wed, 6 Aug 2025 08:41:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
 <20250805153908.GA1807801-robh@kernel.org>
 <OS8PR06MB75414ECA0290018D5D113B62F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <OS8PR06MB75414ECA0290018D5D113B62F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 03D1pbTw5JGzcyddECfokn0F8WPMrqqq
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=68935b8d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=V2NxCb60AAAA:8 a=VnNF1IyMAAAA:8
 a=nVsl0sAMtunpyIQNhTUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-GUID: 03D1pbTw5JGzcyddECfokn0F8WPMrqqq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA4NSBTYWx0ZWRfXz8LNxi6u9BlM
 fB+NgT8RZjvtebALNZ94xA6LJKBfnjWS/kVpYubo2dT7ak9l2QDVI0Xgtahnv7OwcRQ6S0DKoNj
 rl2NId7uCA4xBW9phCE2EVFOygPyWl0WQFzWlJbh85FaDiem46UElmOWsoP+aJiP6Fp5lfTOj2P
 vWATmvoJ/2iPsJ6cN4MnNqOv1wzhdOMNb8sN2yqrYL/4TBh8iW1n1+dcgR2WH5ArowDalu8XtX4
 Q4HI4z81AdJfIdPDQLsv8yVMmNm7t4jN6Tzrs4Dsn41F0I1UGOESNJzdRwR0ijFKQOofJVZlBOb
 H6efciLeE2l/tzedZCj6sGU+cDhAbDfuxhOhQzZuSKL1sQ+Vavvmfr/UmgXmVaeih8qxCr/+hpe
 ON2jMI9vK76TPUWHzW1IByGCkr0o+/7gY49X4O4tcPyOHBtQuIUJEH8QGqpxedD9cRlzoUNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060085


On 8/6/25 2:14 AM, Ryan Chen wrote:
>> Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
>> interrupt controllers
>>
>> On Mon, Aug 04, 2025 at 01:34:45PM +0800, Ryan Chen wrote:
>>> The AST2700 SoC follows the multi-instance interrupt controller
>>> architecture introduced in the AST2600, where each SCU interrupt group
>>> (IC0–IC3) is treated as an independent interrupt domain.
>>>
>>> Unlike the AST2600, which uses a combined register for interrupt
>>> enable and status bits, the AST2700 separates these into distinct
>>> registers: one for interrupt enable (IER) and another for interrupt
>>> status (ISR). This architectural change requires explicit handling of split
>> registers for interrupt control.
>>> - Register definitions and configuration for AST2700 SCU IC instances
>>>    (compatible: aspeed,ast2700-scu-ic0/1/2/3)
>>> - Initialization logic for handling split IER/ISR registers
>>> - Chained IRQ handling and mask/unmask logic
>>> - Table-driven registration using IRQCHIP_DECLARE per compatible
>>>
>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>> ---
>>>   drivers/irqchip/irq-aspeed-scu-ic.c | 240
>>> ++++++++++++++++++++++------
>>>   1 file changed, 195 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c
>>> b/drivers/irqchip/irq-aspeed-scu-ic.c
>>> index 1c7045467c48..b6f3ba269c5b 100644
>>> --- a/drivers/irqchip/irq-aspeed-scu-ic.c
>>> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
>>> @@ -1,6 +1,6 @@
>>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>>   /*
>>> - * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
>>> + * Aspeed AST24XX, AST25XX, AST26XX, AST27XX SCU Interrupt Controller
>>>    * Copyright 2019 IBM Corporation
>>>    *
>>>    * Eddie James <eajames@linux.ibm.com> @@ -34,11 +34,42 @@
>>>   	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
>>>   #define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
>>>
>>> +#define ASPEED_AST2700_SCU_IC0_EN_REG	0x1d0
>>> +#define ASPEED_AST2700_SCU_IC0_STS_REG	0x1d4
>>> +#define ASPEED_AST2700_SCU_IC0_SHIFT	0
>>> +#define ASPEED_AST2700_SCU_IC0_ENABLE	\
>>> +	GENMASK(3, ASPEED_AST2700_SCU_IC0_SHIFT)
>>> +#define ASPEED_AST2700_SCU_IC0_NUM_IRQS	4
>>> +
>>> +#define ASPEED_AST2700_SCU_IC1_EN_REG	0x1e0
>>> +#define ASPEED_AST2700_SCU_IC1_STS_REG	0x1e4
>>> +#define ASPEED_AST2700_SCU_IC1_SHIFT	0
>>> +#define ASPEED_AST2700_SCU_IC1_ENABLE	\
>>> +	GENMASK(3, ASPEED_AST2700_SCU_IC1_SHIFT)
>>> +#define ASPEED_AST2700_SCU_IC1_NUM_IRQS	4
>>> +
>>> +#define ASPEED_AST2700_SCU_IC2_EN_REG	0x104
>>> +#define ASPEED_AST2700_SCU_IC2_STS_REG	0x100
>>> +#define ASPEED_AST2700_SCU_IC2_SHIFT	0
>>> +#define ASPEED_AST2700_SCU_IC2_ENABLE	\
>>> +	GENMASK(3, ASPEED_AST2700_SCU_IC2_SHIFT)
>>> +#define ASPEED_AST2700_SCU_IC2_NUM_IRQS	4
>>> +
>>> +#define ASPEED_AST2700_SCU_IC3_EN_REG	0x10c
>>> +#define ASPEED_AST2700_SCU_IC3_STS_REG	0x108
>>> +#define ASPEED_AST2700_SCU_IC3_SHIFT	0
>>> +#define ASPEED_AST2700_SCU_IC3_ENABLE	\
>>> +	GENMASK(1, ASPEED_AST2700_SCU_IC3_SHIFT)
>>> +#define ASPEED_AST2700_SCU_IC3_NUM_IRQS	2
>>> +
>> The reason for ic0/ic1 compatibles before was the enable field was different.
>> Now it's at least at the same shift. Do you really need a different value for IC3?
>>
> OK, I can remove this define.
>
>> The register addresses should come from "reg". I don't understand why they
>> are hardcoded in the driver.
> The original code register is come from parent. scu_ic->scu = syscon_node_to_regmap(node->parent);
> I keep the original code logic, and add AST2700.


Hi Ryan,


How much is common with 2500/2600? I wonder if it would be easier to 
just create a new driver only for AST2700, instead of all in the same 
file/driver?


Thanks,

Eddie


>> Rob

