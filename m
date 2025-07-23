Return-Path: <linux-kernel+bounces-743012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A9FB0F985
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F22AAC4440
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9254624500A;
	Wed, 23 Jul 2025 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dTEoClWJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/m9EQLS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB915C158;
	Wed, 23 Jul 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292251; cv=none; b=qGCxDMC7TqSk6/hF63KlgggkeEkgeR715CChXbUgyWvHkAXtz8o0yJcXMu4y+5Xrut6ijoKvgdths4qb+63d++ZFwK0xFgCluBuJY45Mvu5z2MGepIpP4/zTc033Dp/vxfYHAcLyy8XGhvq/Vh++CC05UQIdxOomR8yRaljpMUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292251; c=relaxed/simple;
	bh=SK0T/YPPJf5gjC7D4LgNCas0mCg0dqP26nQsyvEH/T4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RBXbBMYb/whvVQBxHa0DYg29tUcuAOJ7VeBjKa3JWseiJDVO0kHvoG4NlliyxVykQ0irnjy3vqiJ9V4+Bxg9Jdox/ESXHFry3xD1VAo0o065HnuyLtTYzE4YJKWtEI+bmo2vQq+LqT3+D/WRzsYAG61Y/zMpozGrXXLuI4p4L1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dTEoClWJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/m9EQLS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753292247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAN36tnPlVScqFyW8H2kecVmf43LbzR0LCpjmIdCB6k=;
	b=dTEoClWJpdbZ8dDT/H8RBibW5G3pXOOc7s0AFPsIuxm4wZIG3cAMH4PBg7kS9MSRq90Z7p
	mdkx7DyiIBN13jDTsP4J3u7cq80L9uQDFENlrOzvWmmllj4cYDp8CWrhP73KFXPFDLa5Rh
	ufDzvNPhC6DkMEy/jgY/NpIGpgsP+B3UQ2R+FnIHCYfKdbv+bgnfuL8jvPslRiwEdTRDM+
	auRoX4DfeM7cJO5PagYEI1rkPT+ts9Xzm58KVrqTNA68AAbhiW1Z3PZmG3VezBuwE8bywZ
	Wzlxur0f6tt0Lb1ZqpQkWyt9g+zWAgLuhXQHESNLqMoyf0QJyzB1S113gM9nsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753292247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAN36tnPlVScqFyW8H2kecVmf43LbzR0LCpjmIdCB6k=;
	b=V/m9EQLSeALkvLMUgne5PHhsAdv3wLFBWfmwy/iiP2pq1OL7lDqxS5TYhKlnJ2UF4PJaNs
	39ByRYfi3VRICtBw==
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 2/2] irqchip: aspeed: add debugfs support and AST2700
 INTC0/INTC1 routing/protection display
In-Reply-To: <OS8PR06MB7541516DD4FDEBD72A764042F25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-3-ryan_chen@aspeedtech.com> <8734aotfdq.ffs@tglx>
 <OS8PR06MB7541516DD4FDEBD72A764042F25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
Date: Wed, 23 Jul 2025 19:37:26 +0200
Message-ID: <87wm7yrep5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 23 2025 at 06:02, Ryan Chen wrote:
>> > +struct aspeed_intc {
>> > +	void __iomem *base;
>> > +	struct device *dev;
>> > +	struct dentry *dbg_root;
>> > +	int (*show_routing)(struct seq_file *s, void *unused);
>> > +	int (*show_prot)(struct seq_file *s, void *unused); };
>> 
>> See the chapter about struct declarations and initializers in the documentation
>> I linked to above.
>
> Sorry, I don't see the struct "> > +	int (*show_prot)(struct seq_file *s, void *unused); };"

I fatfingered that, but that's not the problem.

> My original submit is following, it should ok. Am I right?

No. Read the chapter I pointed you to.

> https://www.spinics.net/lists/kernel/msg5776957.html

I have replied to this very mail. No need to paste me this and the pointer
to some random mail archive


