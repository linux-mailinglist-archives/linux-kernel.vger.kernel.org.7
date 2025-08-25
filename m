Return-Path: <linux-kernel+bounces-784686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F526B33F98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684FA18909F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112651C5485;
	Mon, 25 Aug 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P/dMOrV4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE441BA45
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125309; cv=none; b=Kjmb8/laeaGwd4eBdU2ZcLGPrsfs+/Fp9jM+RICpXpTfnSUwMECoQNO/xeXwueQUOr3NjZmTDHU/ZzqC3OnQn6AiR9BJCYeqiQyDtdODDkmNskQ8BiOFZoJ2OjSJr3OynoVVykF1Bf2ZoUJWL1UMfOj0wNYXumwPug2Ew7kpsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125309; c=relaxed/simple;
	bh=tOXezuRT38nCFJ4em80jfntzWPyfyswX+moPxT5fkw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rjts0gDtbjC8UswgVnWC6KvJh3fwNsvsaAhn0sgtfjrbHLJKxXWn5vRFrbFR5zSPg7xyze/ITGtR/nIkP1ZE0UW6d7ZMMOrCPnXBjlvmRP4z94n/OBpvH4fuL+sE6vkGhp6rHUbJY+jjbS1lthikBkgQ1lSl3Typxas7AfO5PAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P/dMOrV4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756125308; x=1787661308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tOXezuRT38nCFJ4em80jfntzWPyfyswX+moPxT5fkw8=;
  b=P/dMOrV4C8lg+9wX/N6XzAp7RtYm/DVwa0S70H7IeB5/LUL09njCDSYr
   BP1/0eTK0UQVEhKI+HxzovjsEuD4pSXwKGzWq71Q0Xk7amkkLziTx6Lrf
   NsOkTX8btiu9ZPYQyiwFHbv8wKDesfozCwWrEf1iv/JqHi6xu0qHkl8t2
   N82xulrG6IpvmzMQgHjoD3msnoQShgCu/+89fIzoM+nmIA+QPZz0pEmpm
   heFXfcoF4SDVhIo1hXFRfFjQ0/pRMG4Eizhk6OPM8QIvfL0GkH0TNOmI7
   aGlnUN85RaUjmmMm51b35OMsbsC0qlAiEfep5/VVJR6lPDPQY0F81KnA3
   g==;
X-CSE-ConnectionGUID: 8ezpgKBtSyytywR+CgZGpw==
X-CSE-MsgGUID: NTqnnqHtQfSBopmzUi+YwA==
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="45604422"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2025 05:35:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 25 Aug 2025 05:35:05 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 25 Aug 2025 05:35:03 -0700
Message-ID: <e3199e23-0973-44d2-a882-405892290e73@microchip.com>
Date: Mon, 25 Aug 2025 14:35:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ISSUE + PATCH] Interrupts were enabled early by spinlock guard
To: Edgar Bonet <bonet@grenoble.cnrs.fr>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
 <CAMuHMdWJ3im+k9uQgRhUh52Z_tJ+KQjAGY_Y8FjbEu6gB=0UKw@mail.gmail.com>
 <62be0896-6c90-4a27-81cb-7bd897d0e6f2@grenoble.cnrs.fr>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <62be0896-6c90-4a27-81cb-7bd897d0e6f2@grenoble.cnrs.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2025 at 17:28, Edgar Bonet wrote:
> Hello Geert, and thanks for you prompt review!

Yep, Geert, many thanks!

>> I think the conversions in
>> drivers/irqchip/irq-atmel-aic.c:aic_irq_domain_xlate() and
>> drivers/irqchip/irq-loongson-liointc.c:liointc_set_type()
>> are also wrong, and need a similar change.
> 
> The one in irq-atmel-aic.c looks indeed strikingly similar. The one in
> irq-loongson-liointc.c is slightly different though. Instead of:
> 
>      irq_gc_lock_irqsave() -> guard(raw_spinlock_irq)
> 
> it does:
> 
>      irq_gc_lock_irqsave() -> guard(raw_spinlock)
> 
> I don't know what the implications are though.
> 
>> Unfortunately I have no hardware to verify.
> 
> Neither do I.

I'm on it. Expect feedback later today...
Thanks so much for the heads-up.

Best regards,
   Nicolas


