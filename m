Return-Path: <linux-kernel+bounces-876035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F5BC1A7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68D1D561EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196B347FD8;
	Wed, 29 Oct 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeyXunuZ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE4347BD7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741296; cv=none; b=IEMoaoY9yOcgb15p1J/ga9entnbR4NzVLGb6yYoyzXXLdXH7ADd/ed78zadBy0VkWK7XVlHZdisCM/yn3VqznEqVEgMDQ6DB5vt7CY1JDz+4GvN5oGKZs+Wl0RyX9TitS9iY+8sGN1yPFI2yINqliyxvcl5c2AJX+PaIzrzlnjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741296; c=relaxed/simple;
	bh=HNtCmirIHk+sh+voOIV9GTRqfZiI3FU2VFpp1LNOBD0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YEqIhZZP9bx+bfMkm0Ls77oRluMi0Kjj1g8TsWu5Fse54Jr3rY5sI6djdeDU+CkFVAfh4UD1Dh+7mZwQnJRvNYi1oy4f7XbQEgL/AdHBiUzP350Qmcqp9+VY9nrPPHvVnzMeRJMTcDzkv4NDmAqM2FO+Km7WNw300yJz0EAH9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeyXunuZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d53684cfdso1592941166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761741293; x=1762346093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/8DZoPJ8aqVOkZWIQZ+0wffxazBftDICjqU1ayLbAL0=;
        b=QeyXunuZb02utMUa34oymzu2d0V8XSPRf6yg27clHxLqBWurfmfUIYMaHq5AoE9zye
         DxhGRLAXSTBq53VuxzOqgu0f/JSacEmONQuM4nQXifXNHKQpxv/nZQqDMQbD8Y8TgAtT
         1f1dw0eujpDHo8JauxLRIDjk7BkBf4Q7IuOQm6dO402qZeE5j+yRRH/dl3kjTdciBlrk
         Axt77hz3SUfXSVK2U2CYDSi/K7W+N2v4yZJ1vA7IwtCRqygqxSClq7gzZglIyruXMOT/
         O9BAWXmSN6xgmIJkFjmWGMHReRbqWlxx6wvdDFPgvkNhdrWgOZ6GkWq5WIvXFBTJI7Uv
         LIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741293; x=1762346093;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8DZoPJ8aqVOkZWIQZ+0wffxazBftDICjqU1ayLbAL0=;
        b=Z9GcSFRiBgaxN2ii4KryNS6OTzGGqJ0hsM9LVa5ocQkaW6EcYexUlAELr6Ww3VabT/
         4X7yDCKvnqs/iHI3tS2dY2xWu4nK5fZI4GHhVfa9XqBhxFx9oa7TIUrkhXFyWWtmekeI
         wW8uFjvVrPorT2SionP3+2UrrNW9g9EWidmenwQnZhXYO4wJQBoQHeU+354g2IOGyYIM
         kPmbzYnkEQR72kRWdwzp3m+ueOC8Y1/pxEwthp0WNoJFgITT6sZOGD69qNwZ2NqpS51C
         2a0OaemqO4ECD52vcSq5iZboTwjaZgkXXHZq/D1x0rs0I5L668WF2xDofpXxlv7WrgEH
         DOYA==
X-Gm-Message-State: AOJu0Yyc3AgqkE0wiMNShOXc8i7FdltTL7Vj5LbBom2jQwUnVSJmgVWn
	8KMj0xbKtK7lG49Y8rX5rHVgJTVzBy8lJspKovbfxL0LLd0YpwVEJz+H
X-Gm-Gg: ASbGncsHRPgVTJSyQk5u+I2HvHA2wiHmTDaz4TbAUeNKrt8oT08jxlOqU6tQ3LPLBFQ
	oGwblA8CGEPNzTyAbcLmyEWX+w6NpF1YHtnwuiHA2vqfhQEHO6jck6tCJThSOwWq/treRdplAjI
	TQna8ZoPAX/NtxNHC8jQclTg/YhYGiGyiciJFR74J5DighL9gpSH8ERhQpp8GsXf50bVqaZ6rxx
	veAHIfM2NqiCp/cbp9WiTOx0XzPPu+ZD6neOA96EzlCxAkuB6Ita16zp6yrN4ivG4vZdQPG1f2k
	q0ZIXplVwHG5nNTKHtSR2elsa/w39ClRWgfHtp7ctVJG1Yga5stVYol01VYY2w5nsQ0xA0y+hUI
	2fxtR0y8CbJ7SWHcYdsLFMOkH3wgWS91n+on37u5YA0jHdxVGqgFtP9z/FeliUvBpVJ+TRgZXlY
	nG7xQhg5yucAc=
X-Google-Smtp-Source: AGHT+IEm/jQ9FpLLfVE96+QdjuVUzD0Ukqy8zEutOY7AHNQJYGiK4J4IQ0uCzx5/Ly7C0dEvCYJ5kQ==
X-Received: by 2002:a17:907:5ce:b0:b6d:5c4e:b0b8 with SMTP id a640c23a62f3a-b703d2bba1bmr254091266b.8.1761741293116;
        Wed, 29 Oct 2025 05:34:53 -0700 (PDT)
Received: from [150.254.44.155] ([150.254.44.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85398463sm1377869766b.34.2025.10.29.05.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:34:52 -0700 (PDT)
Message-ID: <b0cffa2f-6ad2-40a3-a5ee-5df6b2918524@gmail.com>
Date: Wed, 29 Oct 2025 13:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH v3] mfd: bcm590xx: Add support for interrupt handling
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht,
 Stanislav Jakubek <stano.jakubek@gmail.com>
References: <20251013-bcm590xx-irq-v3-1-0ceb060d2ee8@gmail.com>
 <20251023130335.GM475031@google.com>
Content-Language: en-US
In-Reply-To: <20251023130335.GM475031@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.2025 15:03, Lee Jones wrote:
> On Mon, 13 Oct 2025, Artur Weber wrote:
> 
>> The BCM590XX supports up to 128 internal interrupts, which are used by
>> various parts of the chip. Add regmap_irq-based interrupt handling and
>> helper functions to allow subdevice drivers to easily use the interrupts.
>>
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>>
>> (...)>>
>> diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
>> index 5a8456bbd63f..fb6afe277ebf 100644
>> --- a/drivers/mfd/bcm590xx.c
>> +++ b/drivers/mfd/bcm590xx.c
>> @@ -26,16 +26,29 @@
>>   #define BCM590XX_PMUREV_ANA_MASK	0xF0
>>   #define BCM590XX_PMUREV_ANA_SHIFT	4
>>   
>> +#define BCM590XX_REG_IRQ1		0x20
>> +#define BCM590XX_REG_IRQ1MASK		0x30
> 
> This isn't better.
> 
> And now the nomenclature is inconsistent with the one above.
> 
> What is a mask register?  I don't understand.

The IRQxMASK registers store the interrupt masks for each interrupt. To
explain this more clearly:

The BCM590xx chips have up to 128 internal interrupts (the exact number
is different between the BCM59054 and BCM59056, but both reserve the
exact same amount of registers for them).

The status of each interrupt is stored in the IRQx registers
(0x20-0x2f), and each bit represents a single interrupt.

The interrupt masks (that is, whether the interrupt is enabled or
disabled) are stored in the IRQx_MASK registers (0x30-0x3f), and each
bit represents the mask for a single interrupt, in the same order as the
IRQx registers. (...would IRQMASKx be more consistent?)

Each register stores 8 bits of data, meaning the {status, mask} for 8
interrupts can fit into one {status, mask} register.

> 
>> +{
>> +	/*
>> +	 * IRQ registers are clear-on-read, make sure we don't cache them
>> +	 * so that they get read/cleared correctly
>> +	 */
>> +	return (reg >= BCM590XX_REG_IRQ1 && reg <= (BCM590XX_REG_IRQ1 + 15));
>> +}
>> +
>>   static const struct regmap_config bcm590xx_regmap_config_pri = {
>>   	.reg_bits	= 8,
>>   	.val_bits	= 8,
>>   	.max_register	= BCM590XX_MAX_REGISTER_PRI,
>> +	.volatile_reg	= bcm590xx_volatile_pri,
>>   	.cache_type	= REGCACHE_MAPLE,
>>   };
>>   
>> @@ -46,6 +59,258 @@ static const struct regmap_config bcm590xx_regmap_config_sec = {
>>   	.cache_type	= REGCACHE_MAPLE,
>>   };
>>   
>> +#define BCM590XX_REGMAP_IRQ_REG(id)	REGMAP_IRQ_REG_LINE(id, 8)
> 
> It looks like this may benefit more than just this driver.
> 
> Please create a generic helper in include/linux/regmap.h.
> 
> Perhaps REGMAP_IRQ_REG_LINE_BYTE, or whatever the 8 represents.

I would rather avoid modifying the regmap code if possible.

I've seen another driver (drivers/power/supply/max77705_charger.c) use
REGMAP_IRQ_REG_LINE(id, BITS_PER_BYTE), which is more descriptive than
just leaving the raw number of bits. Would that be a good alternative?

Best regards
Artur

