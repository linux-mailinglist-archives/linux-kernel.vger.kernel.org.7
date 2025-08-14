Return-Path: <linux-kernel+bounces-769170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED290B26B11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AABF684CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C234221F00;
	Thu, 14 Aug 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenoble.cnrs.fr header.i=@grenoble.cnrs.fr header.b="gwu70pnV"
Received: from mailgw-out1.grenoble.cnrs.fr (mailgw-out1.grenoble.cnrs.fr [147.173.1.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD752040A8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.173.1.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185388; cv=none; b=rSJP+SZld3EobQewlZpRpp+M8CTkPOP05S25YQf1aCvFu95dk+qXgj40cHctmbAIrk2/V3mh19fW9BdyXcfMgTmvy1GPH1eW1GS7kzxgO/EliQsCUf9gACx8lErbQ8RC1WTBZl11a9Lwb0TMXpQ8Ox0pG97kbT5nbb7SxNqbhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185388; c=relaxed/simple;
	bh=mB6OKzKyG6cbfcvnrXnFLBKytUJ5OK9CtmAOs83Nfjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNwnA0gF78jTrY3V2rYONqLkTllFvgLunR3kCBQHRaiAmAtOpSp0cukYcUKbkTef+1cGZJizYYivtT93htMHjkpeXfMJAhXmLmTj3qi1jkwHxXqXqbkjg6nll7o1QCH5ZCFvfFS5MfeVvSrvzB4OEAS+yUKPlbIfEbA+FbBhlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenoble.cnrs.fr; spf=pass smtp.mailfrom=grenoble.cnrs.fr; dkim=pass (2048-bit key) header.d=grenoble.cnrs.fr header.i=@grenoble.cnrs.fr header.b=gwu70pnV; arc=none smtp.client-ip=147.173.1.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenoble.cnrs.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grenoble.cnrs.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble.cnrs.fr;
	s=202106-grenoble.cnrs.fr; t=1755185381;
	bh=PnoRkmxCOsnpNNweD2fYCgajGFbsDIeSlUkdZHGlISs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gwu70pnVBHOmmdvpFPm3fohpywuDUu8SUQdH+LFyCc10KgnUyMf0C88TaUu34Qb67
	 gx2oalm2Zh2oL85qhXe12Or+DdldZ8k8xdgUWRCu5Qqj3vMWtOT4bhIzY9K5v2Dj9J
	 +dQFEO6JvMbycrmrzP0n2LbzU+tGO4cPMHHx4T6ll7QlbQtKdNY06CTqiWYZ+cCov9
	 ifkuYByvMNyPvBNNZneu36Dq1OYSLYPSsti6XNfu8zbbuuWbMPfsqfpnbjCqa8lbtZ
	 LnAuIsNbYkq57wI3V6Gx+N07SXaPZzlaVjvzH2fxXweAPyntF9ApwAYwthcWDHcTdz
	 1YSa7/s42dVZQ==
Received: from [147.173.65.159] (unknown [147.173.65.159])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailgw-out1.grenoble.cnrs.fr (Postfix) with ESMTPSA id A128ABFBA8;
	Thu, 14 Aug 2025 17:29:40 +0200 (CEST)
Message-ID: <62be0896-6c90-4a27-81cb-7bd897d0e6f2@grenoble.cnrs.fr>
Date: Thu, 14 Aug 2025 17:28:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ISSUE + PATCH] Interrupts were enabled early by spinlock guard
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
 <CAMuHMdWJ3im+k9uQgRhUh52Z_tJ+KQjAGY_Y8FjbEu6gB=0UKw@mail.gmail.com>
Content-Language: en-US, fr
From: Edgar Bonet <bonet@grenoble.cnrs.fr>
In-Reply-To: <CAMuHMdWJ3im+k9uQgRhUh52Z_tJ+KQjAGY_Y8FjbEu6gB=0UKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Geert, and thanks for you prompt review!

> I think the conversions in
> drivers/irqchip/irq-atmel-aic.c:aic_irq_domain_xlate() and
> drivers/irqchip/irq-loongson-liointc.c:liointc_set_type()
> are also wrong, and need a similar change.

The one in irq-atmel-aic.c looks indeed strikingly similar. The one in
irq-loongson-liointc.c is slightly different though. Instead of:

    irq_gc_lock_irqsave() -> guard(raw_spinlock_irq)

it does:

    irq_gc_lock_irqsave() -> guard(raw_spinlock)

I don't know what the implications are though.

> Unfortunately I have no hardware to verify.

Neither do I.

Regards,

Edgar.

