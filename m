Return-Path: <linux-kernel+bounces-784877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D97B342D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81306164EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E1A2EF64A;
	Mon, 25 Aug 2025 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DfmbQ3xm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B592222D1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131046; cv=none; b=T2uI3GW3ZbIX24Rax44Sm2pqJ7icTBSVkVqHnOoSw4bD76t5+Et/Hayp+fzVXNQru6KaOdbtjh6a8G8Ms9mEkkiN5Muu5LnAEXqp/ukoWQ8qXaZmS/QZR3qYH+23WktZc2/im7dX8YryjIfsYXNrYX2vKp8PFkRm53BzUUTle0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131046; c=relaxed/simple;
	bh=JYLoJUwGKBDQEO1UVLrz1emWoAwB4K2kdLEIX8eP7tE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=K5wRUvXRnY70V5Wxc3z77fASbywBEkxhlvakheJ+3ZXDGm2dclYEvQgm7WER8CWTOXBJrUdnf37z+ygR5x688jnHJsWK9nLi0YS2cbIKAePkj8pg/wTZKp8XoCgEJQWQ83cky95ulOQJ/av1WsZ9nNUuI/1gRg7flaDpZgT2qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DfmbQ3xm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756131044; x=1787667044;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=JYLoJUwGKBDQEO1UVLrz1emWoAwB4K2kdLEIX8eP7tE=;
  b=DfmbQ3xml2uvN15l0TQEIF7FihZncHar1UBNSU4iRaC8hm/yZUVpMvI1
   jpBfa/3jMoHarPo4qH8YQvhEWJk+6QArGAo3MNxe/P77J28itMnMV4guN
   mhI1DLYVuwFug/Ws6OKSX9AR7AC5L5qMCVoEdVrTD+mb4XihGCoFAnrUz
   K2CjmlkNNubIM7T6g1qrbF9SXqjjbWMAiiWxyCR6cVhG8pHmZljnDLYRt
   iebHZYExsNWiGB46/X2W5nMJQwq3OGsDlvhSx3c2oJbtZed8cY+OOnX7R
   MtmNmGP48hHCFrurIvsVBMFTfWnfzwlT815cAXD9ndbzzZ+6kv7pI9ePC
   g==;
X-CSE-ConnectionGUID: cdlPPhXJQGaFbMdbODqVXg==
X-CSE-MsgGUID: X+/vD80ySrWUJey6ExoCDQ==
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="213036058"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2025 07:10:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 25 Aug 2025 07:10:30 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 25 Aug 2025 07:10:28 -0700
Message-ID: <786c7e37-f8d0-45ca-9a8f-c1468318ac2a@microchip.com>
Date: Mon, 25 Aug 2025 16:10:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ISSUE + PATCH] Interrupts were enabled early by spinlock guard
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Edgar Bonet <bonet@grenoble.cnrs.fr>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
 <CAMuHMdWJ3im+k9uQgRhUh52Z_tJ+KQjAGY_Y8FjbEu6gB=0UKw@mail.gmail.com>
 <62be0896-6c90-4a27-81cb-7bd897d0e6f2@grenoble.cnrs.fr>
 <e3199e23-0973-44d2-a882-405892290e73@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <e3199e23-0973-44d2-a882-405892290e73@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 25/08/2025 at 14:35, Nicolas Ferre wrote:
> On 14/08/2025 at 17:28, Edgar Bonet wrote:
>> Hello Geert, and thanks for you prompt review!
> 
> Yep, Geert, many thanks!
> 
>>> I think the conversions in
>>> drivers/irqchip/irq-atmel-aic.c:aic_irq_domain_xlate() and
>>> drivers/irqchip/irq-loongson-liointc.c:liointc_set_type()
>>> are also wrong, and need a similar change.
>>
>> The one in irq-atmel-aic.c looks indeed strikingly similar. The one in
>> irq-loongson-liointc.c is slightly different though. Instead of:
>>
>>       irq_gc_lock_irqsave() -> guard(raw_spinlock_irq)
>>
>> it does:
>>
>>       irq_gc_lock_irqsave() -> guard(raw_spinlock)
>>
>> I don't know what the implications are though.
>>
>>> Unfortunately I have no hardware to verify.
>>
>> Neither do I.
> 
> I'm on it. Expect feedback later today...

Answering to myself: tested working okay on at91sam9x35ek board (with 
IRQ controller matching compatible string "atmel,at91rm9200-aic" 
(handled by file irq-atmel-aic.c) and your modification:

--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -188,7 +188,7 @@ static int aic_irq_domain_xlate(struct irq_domain *d,

         gc = dgc->gc[idx];

-       guard(raw_spinlock_irq)(&gc->lock);
+       guard(raw_spinlock_irqsave)(&gc->lock);
         smr = irq_reg_readl(gc, AT91_AIC_SMR(*out_hwirq));
         aic_common_set_priority(intspec[2], &smr);
         irq_reg_writel(gc, smr, AT91_AIC_SMR(*out_hwirq));

Thanks, best regards,
   Nicolas



> Thanks so much for the heads-up.
> 
> Best regards,
>     Nicolas
> 


