Return-Path: <linux-kernel+bounces-783327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64307B32BB0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 21:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCD71BA0A27
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4122222A0;
	Sat, 23 Aug 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kpjjSYAs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LhBHeOCd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51851E51D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977713; cv=none; b=Jvq5rnydxdcx8UC9bAEJRMFTIMPZjJW0Q5j+zda3ll9pveliVsU7WP8WFiexK7RLwqOxVilDDDGZyjdQUei4Yg78WTRyyOTReoZFwtG3CBBnvs7Al8F/nsnGvpmUxzCczqUqkqBYChww7xu/WHqgPSlUtTJ6STT8XDB2g9YLJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977713; c=relaxed/simple;
	bh=/8SLiLObV5/T4MfrcsrUljz/ICRQoAWwC/2fVoQ7Zb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6H4zdfF5QGiymB7el7YqbJypL2Rd/mfqeu1sYTKdiX2hJxVTWA/8iCwNDsZVYqFwXOw80iZuMZzPQAialt1Xk+yf6sqMcljpOIYrE/s1x03JyIG4iED+/9KOsBdvUwzb8jYePdE7lC8nTwYcdJpafFMI7CIOr7DVpwaTxTaq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kpjjSYAs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LhBHeOCd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755977710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw7qDMq4IWv3isIdSX8wUcFvOZfQTQyXCeO+c5P2T+M=;
	b=kpjjSYAsTSUY3GXZCMttuvjGqpNgxP+ddkVzLzo/ix0+flOM+MxhZ+KsSWkki/X+1aiwlK
	6J0DavZA+6BKF/xQLanEnIvPZVqtj71VOCJYpzPq4cKhoqvB7oH2HSumqbBxYiJSxKDujx
	ZZzUhnGMznWT/EZnIC6pd5giuTQFIe4/dY85Q5ksrhrYCIF9laJtv36kHTCvmLmjXss4TZ
	UdY8IDoF38IXcsZ5MxYzDaOCNBOKs0EiU1b565/PVVzi8AqP8oCfUoRvH/Lf3RXdJrmLZY
	Q3LDWgEnGDM4zErpZrbUlFWWI3b43X6ACV25JKXEBr0YwyV1/gImImVYTVe4MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755977710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw7qDMq4IWv3isIdSX8wUcFvOZfQTQyXCeO+c5P2T+M=;
	b=LhBHeOCd5VeYkfaw+9+QtECtxroT5M1Y5XwXSvzEZe/huRteaZZNKHV6o26rJRLLbdzo41
	ReW+aTBm+jypKJBQ==
To: Edgar Bonet <bonet@grenoble.cnrs.fr>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [ISSUE + PATCH] Interrupts were enabled early by spinlock guard
In-Reply-To: <877byt4yub.ffs@tglx>
References: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
 <CAMuHMdWJ3im+k9uQgRhUh52Z_tJ+KQjAGY_Y8FjbEu6gB=0UKw@mail.gmail.com>
 <62be0896-6c90-4a27-81cb-7bd897d0e6f2@grenoble.cnrs.fr>
 <877byt4yub.ffs@tglx>
Date: Sat, 23 Aug 2025 21:35:09 +0200
Message-ID: <874itx4ys2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 23 2025 at 21:33, Thomas Gleixner wrote:
> On Thu, Aug 14 2025 at 17:28, Edgar Bonet wrote:
>>> I think the conversions in
>>> drivers/irqchip/irq-atmel-aic.c:aic_irq_domain_xlate() and
>>> drivers/irqchip/irq-loongson-liointc.c:liointc_set_type()
>>> are also wrong, and need a similar change.
>
>> The one in irq-atmel-aic.c looks indeed strikingly similar.
>
> Yes. My bad.
>
> I missed the fact, that this can be invoked during early boot when
> interrupts are still disabled. After early boot they are always enabled
> when xlate() is invoked.
>
>> The one in irq-loongson-liointc.c is slightly different
>> though. Instead of:
>>
>>     irq_gc_lock_irqsave() -> guard(raw_spinlock_irq)
>>
>> it does:
>>
>>     irq_gc_lock_irqsave() -> guard(raw_spinlock)
>>
>> I don't know what the implications are though.
>
> That's in the set_type() callback which is always invoked with the
> interrupt decriptor lock held and interrupts disabled, so doing the
> 'save/restore' dance there is pointless.
>
> Can you send a patch for that atmel-aic thing too please?

Nah. Let me just fold it into your patch and be done with it.

