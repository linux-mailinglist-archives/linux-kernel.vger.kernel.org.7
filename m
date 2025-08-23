Return-Path: <linux-kernel+bounces-783325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF4FB32BAD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 21:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564CA7AE710
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D775A248869;
	Sat, 23 Aug 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S2jjDfDD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNn8rL8p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D42248BE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977633; cv=none; b=ptIWbleUOVH+qoeBnEWiOyGrIHhPtn1BoaM1wvBLpHUE+/42mkAlHGvrSUBEccb9kzxk0gphx09XFdztWXF3OJ8dZYYeFm2GNpmr/nJUnjfOLbhxXnSr/X8HHNrfZdUwqK40RHSZ87a3CCa1wiixdtEMdQBGDyOQYyI87nI52VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977633; c=relaxed/simple;
	bh=N+EYeq2QB7Bkr46JgFNROdSB9wUgEj32hzxCsmklTIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=suyYGz/+CksZZJG/cvsiPq9c6TQqybIhoUqbMokzuOAnxawQAmENySLak7Wy5+Pbcxx9AYAVhNb5ofmtW4i7rNS+bkDglYALzDENONYX3takemdhpeJw1pJrzUBqvlKi6QejP8n8JKY0uc5LGburjUjMsmaGnq9qJx9NdYlggKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S2jjDfDD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNn8rL8p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755977630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkW88smFjgLCFmSxj1fkAwEP7mKymD54ZrxB+tKL5CI=;
	b=S2jjDfDD2mCdJl8gMu89Tghj5bq/r3HbkNCvcOxQGSoCSngTNKIcH0IXAcw3MUqKjQtn+9
	62PlyqGMqnMl2Dd1zoKLgjf7Plim1mHFbbuaQnoEGz56MLkkd2D6dAavRcj8BYga4wqpM8
	6nE0ENxcOfyHgLOqiRSnKVHFeNgRgN7sorLrXXH5tx7eWPX9eRoER13D3zBeYduHv3GHBU
	NwZU/bypmfNP2u+j62NcLAD/aTbFjQmzCzgrITTW7V26VjQoWlPxUye6zNdQk2b0UzoAXk
	rvPyh4RuhHY3H3ss2DVjSKN+1AMDwKC9VRSOAL+B5Ij8+gvAQeKKoSgHDWXsdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755977630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkW88smFjgLCFmSxj1fkAwEP7mKymD54ZrxB+tKL5CI=;
	b=uNn8rL8pXfB/NjR1BcJkCOcm/vXyxiqQI4AHb5QqidW7GOpjMYblXxvTLtwiZLnqnYld99
	17o7HrZ0QNJcM4CQ==
To: Edgar Bonet <bonet@grenoble.cnrs.fr>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [ISSUE + PATCH] Interrupts were enabled early by spinlock guard
In-Reply-To: <62be0896-6c90-4a27-81cb-7bd897d0e6f2@grenoble.cnrs.fr>
References: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
 <CAMuHMdWJ3im+k9uQgRhUh52Z_tJ+KQjAGY_Y8FjbEu6gB=0UKw@mail.gmail.com>
 <62be0896-6c90-4a27-81cb-7bd897d0e6f2@grenoble.cnrs.fr>
Date: Sat, 23 Aug 2025 21:33:48 +0200
Message-ID: <877byt4yub.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 14 2025 at 17:28, Edgar Bonet wrote:
>> I think the conversions in
>> drivers/irqchip/irq-atmel-aic.c:aic_irq_domain_xlate() and
>> drivers/irqchip/irq-loongson-liointc.c:liointc_set_type()
>> are also wrong, and need a similar change.

> The one in irq-atmel-aic.c looks indeed strikingly similar.

Yes. My bad.

I missed the fact, that this can be invoked during early boot when
interrupts are still disabled. After early boot they are always enabled
when xlate() is invoked.

> The one in irq-loongson-liointc.c is slightly different
> though. Instead of:
>
>     irq_gc_lock_irqsave() -> guard(raw_spinlock_irq)
>
> it does:
>
>     irq_gc_lock_irqsave() -> guard(raw_spinlock)
>
> I don't know what the implications are though.

That's in the set_type() callback which is always invoked with the
interrupt decriptor lock held and interrupts disabled, so doing the
'save/restore' dance there is pointless.

Can you send a patch for that atmel-aic thing too please?

Thanks,

        tglx

