Return-Path: <linux-kernel+bounces-802276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A8BB45036
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10107A2E3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4530E26CE36;
	Fri,  5 Sep 2025 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wbJMk1A9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NJs6nJbE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456314E2F2;
	Fri,  5 Sep 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058470; cv=none; b=B7Ubu/wPbl69xfKtBmXTjcVT0xloYhFeJMq9IX6U7zprFhnKR6TbAl1B46mGVH4ChQpzD38WZASIQkRQoxs0xWVeayoNi5Ip9NO+2Te1g/K8vCC1xK9sQGqJwvVdf4hYuG9/Akok4cvK1qNVcYJu4gztmIqpR1WZ5exoAo0wRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058470; c=relaxed/simple;
	bh=HLkYXnaKFnKg9RHeCPeZV5JwIDK/Kr/j0SnlsRF7EK8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y4ZNwzwG8N35UNYTaSyUkpX17x5IRk76rH1ilwOKkOoRPE1tFfiIymMKi3hK9F+Eov7noTqbsU93ETuMzMv+QWZeb1DP8tDP03Ni3/stJHqCcfhiptR3PnrauiAamPa0bssrHcai1uOQu0VLZTr+h7XFMimadMU7/UXhnncC584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wbJMk1A9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NJs6nJbE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757058467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBtkAe6H+jyGj4tt5HXrxDOSNwUiyry3aDabLs2QBuI=;
	b=wbJMk1A9M/sLp/JYaMOxP5tGNweS3NYiR5ynw15kjZMAZ5rUMMSzHOnG1xBv+8gq4Vxhj+
	oI1zFvBrXNGizVzbHofs4WCKcyD7In5isJOgPj+8Vc8aIWO2wap9DplKViLeXEQvFB8dPm
	7gY5pnY/L4llUs8PDxJdWy3PUK7IXezT+B8lUw59CJpDwBlURZ2PzaLH6DlsQOawbKMPvJ
	guPWRrINA9tUjXJ9RppdoorgcwTpGQJ3k7WnJkAgcttp7blEXkozcrCNWGk+LIl2jBelZk
	J66iUGfBnBHmZecbdPkARyTfSWWr6SglxrlRTY/2RM77NlSX7RQ+PPrxzTIH6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757058467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBtkAe6H+jyGj4tt5HXrxDOSNwUiyry3aDabLs2QBuI=;
	b=NJs6nJbEfespe8MIIJCa7ECvbrIBkCIhMite81FenHjk7bkCHnKDVUp/y1C6hXCIANO45v
	SdDXOIvxzzqVzYBg==
To: Ryan Chen <ryan_chen@aspeedtech.com>, Eddie James
 <eajames@linux.ibm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU
 interrupt controllers
In-Reply-To: <OS8PR06MB7541CD16E659666868EAECB9F203A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-5-ryan_chen@aspeedtech.com> <87y0qx0zqu.ffs@tglx>
 <OS8PR06MB7541CD16E659666868EAECB9F203A@OS8PR06MB7541.apcprd06.prod.outlook.com>
Date: Fri, 05 Sep 2025 09:47:46 +0200
Message-ID: <87tt1hwdb1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05 2025 at 05:55, Ryan Chen wrote:
>> So you have two different handlers. Why can't you provide two different
>> mask/unmask/ functions along with a seperate irq chip instead of cluttering
>> the code with conditionals. Thes two variants share no code at all.
>
> I will add irq_chip in SCU_VARIANT, like following.
>
> struct aspeed_scu_ic_variant {
> ..
> +	struct irq_chip	*irq_chip;	
> };
>
> #define SCU_VARIANT(_compat, _shift, _enable, _num,  +_irq_chip, _split, _ier, _isr) { \
> +	.irq_chip		=	_irq_chip,	\
> .....
> }
>
> static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst = {
> 	SCU_VARIANT("aspeed,ast2400-scu-ic",	0, GENMASK(15, 0),	7, &aspeed_scu_ic_chip_combined,	false,	0,	0),
> 	SCU_VARIANT("aspeed,ast2500-scu-ic",	0, GENMASK(15, 0),	7, &aspeed_scu_ic_chip_combined,	false,	0,	0),
> 	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0, GENMASK(5, 0),	6, &aspeed_scu_ic_chip_combined,	false,	0,	0),
> 	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4, GENMASK(5, 4),	2, &aspeed_scu_ic_chip_combined,	false,	0,	0),
> 	SCU_VARIANT("aspeed,ast2700-scu-ic0",	0, GENMASK(3, 0),	4, &aspeed_scu_ic_chip_split,	true,	0x00, 0x04),
> 	SCU_VARIANT("aspeed,ast2700-scu-ic1",	0, GENMASK(3, 0),	4, &aspeed_scu_ic_chip_split,	true,	0x00, 0x04),
> 	SCU_VARIANT("aspeed,ast2700-scu-ic2",	0, GENMASK(3, 0),	4, &aspeed_scu_ic_chip_split,	true,	0x04, 0x00),
> 	SCU_VARIANT("aspeed,ast2700-scu-ic3",	0, GENMASK(1, 0),	2, &aspeed_scu_ic_chip_split,	true,	0x04, 0x00),
> };

You have this split_ier_isr field already, which should be good enough
to select the chip to assign, similar to what you do with the handler, no?

Thanks,

        tglx

