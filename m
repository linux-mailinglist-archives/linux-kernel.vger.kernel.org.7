Return-Path: <linux-kernel+bounces-757881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9947DB1C7D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4262E189D769
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FDF28DB6D;
	Wed,  6 Aug 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9H4ngx6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lASAwrt6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309AC9463;
	Wed,  6 Aug 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491499; cv=none; b=Ru90g5Eb3sWzuo8x7BgH+/AMi6Zq1McqFPcpjjB/stZT0d4SZyYEwtI4QnWSLQ8jomvOk53tIxb1zr3RMpEEs6g4fQMfhXnyUnnpYnQTrbJ4wauncxxaDacVf/CuwGfx340LaTpNHJfmdGXs/FrjbzT+B7isrjZNF2qEoTltw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491499; c=relaxed/simple;
	bh=rCbH2iPI+uyyouoQK9xPomgE62XvVdeIuPwdHrAXxdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tshHHQve2EbgMhatsBqTulp9UyLWAjp3+xxW93sxotk79CM1tWkZLhMu6BjlhLQnndehoEyimxYUA0qPZSro2VgqfBEsCIntLMMZSQM62D8dPXoHZtKwi80kNIlDS2sp/FceWo0sSzAoh55W0T7ILQy42kj5H0Dg9tOsXqVEsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9H4ngx6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lASAwrt6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754491495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9dKSnmyZhBtsAHpcDfwkp4+zP/Y5X/HnAHpBN0o8UN4=;
	b=N9H4ngx68JBjI+CbEYzUEvOnNXD/Q6OJGe1uzRJazZvmOAOq21F1qC9dAupcKLSxl4q3SO
	79ebFfOGuYvCJVjSHAOz4Fb1BP2cSfdb7HwM1sOOVNmCDOpw3LPqVNsEIyzwVfiNfKzbFR
	pnHyoy1SSxeiaDdh4J7V9mi/bfHRx/GRD5W3virKQZOYw2BFY4AuUcXuzlpVsn5a7eTayU
	ALC26UxbEr4FBDdtG2IhRLh7mHfmehwyKSM37iYyYmVbFAJqE8GzWyqTGmsV2P9Z4p/ZdM
	fDorgcfgO18MHPF93cg2Um9Qm0yoZcjnun7pcBGtlKKivz6ecZvAjUVfhMX6/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754491495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9dKSnmyZhBtsAHpcDfwkp4+zP/Y5X/HnAHpBN0o8UN4=;
	b=lASAwrt6n8amrUQUmEoeShj8JgZ2xMaBO+EriCZrbtsqgS+AkjEQPlEGR8itBoqhSxEygY
	Z5pRdhqRdttGdDAA==
To: Eddie James <eajames@linux.ibm.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
In-Reply-To: <5c46082a-c31b-4d12-a1d6-f315c8ce7aaa@linux.ibm.com>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
 <20250805153908.GA1807801-robh@kernel.org>
 <OS8PR06MB75414ECA0290018D5D113B62F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <5c46082a-c31b-4d12-a1d6-f315c8ce7aaa@linux.ibm.com>
Date: Wed, 06 Aug 2025 16:44:54 +0200
Message-ID: <8734a4ecgp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 06 2025 at 08:41, Eddie James wrote:
> On 8/6/25 2:14 AM, Ryan Chen wrote:
>
> How much is common with 2500/2600? I wonder if it would be easier to 
> just create a new driver only for AST2700, instead of all in the same 
> file/driver?

There is enough consolidation potential to keep them in the same file.

