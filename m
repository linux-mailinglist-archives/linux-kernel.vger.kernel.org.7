Return-Path: <linux-kernel+bounces-796888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BD7B408DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A586189EAE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50184314B82;
	Tue,  2 Sep 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cauk4XG/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EA311592
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826638; cv=none; b=QmTXfOjVeTyj77y9S0BE7jAfi0qK+HCkkvCyAoOHkSMRH+I0iPgOuz/752IgsmpHkAUWUVbcZRPSMnyPI+3PYHzlAhEa+hWxOQKA+HFHx8fuXuZCfQnD6pZ5wlyqNZvhRQYdsnZNv+j0NUsXpeXMkzQ+EGV2wt6XcQi09Yc+78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826638; c=relaxed/simple;
	bh=OqY3SiwgvNyKvsyjANWshqbGUQpj2fGjQ77ChSyYS6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nblkbDWEjwL19G1TJg/0z0golmMjm0f+YFoxDiMBmYx+8Oqom/O+vP3fwEiOtpjh1D7mGfORvr2O4UUK5y+OrO8UWBld6yRopgm38iTeNZ6L9qRtTtkz80rMtxBNyQbq4/eP1zglqqY6+T+wjNzvb3ChIRj8mxi24WDsMr9mAFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cauk4XG/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0431c12df3so326004466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756826635; x=1757431435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xy7lqC8l+fpzdKDTj3MBSjONsHATI2B+twLZZeWyMug=;
        b=cauk4XG/pcr//V9Zj3thUiKtfdbNgBlsn+Lky0rN5G57vLasMl6+NvPiOmea8JkScC
         oyzLaHnwW/NJXzg1TP/ONFeC23ijhi3nv4b63+wiLpd6uitEaT2IxObDHA4GLavAvujd
         T1G8q7q8YpcK2dBExoe5pVA7pEYRl7TrtQgZuoqGxia3KQjllBvjfkxCyndL3JcSeB1F
         c1o5kz4e7hYdHW/CWsKYZncmuZ8/EMbpZyqUDCPStVSqY/Is+DfmWddMZ4bFoQ46B3CZ
         jZ7Qt/5Joj+vebkc74QEfqHFzGljMMODnEJ1qZi99MIhn3Stivk9wTKUEfa7T1lEYd0A
         0taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756826635; x=1757431435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xy7lqC8l+fpzdKDTj3MBSjONsHATI2B+twLZZeWyMug=;
        b=VdcPn1zw6kbY0nrd/42exGGraDXV6fy3mWc3qVXLnmAvLQk76OE68f1vM3A9yqXcrp
         1tGYutyNM1EG7jwzlutjUv5aejKNpplleghYjR96PmweW4uap4neY4mxaDNmD68Guaeb
         cv0CwDJxau5+BWcFkwGrHBOdN2vczLwnSaXMNXfl5FY7brj9ceLEBMBooOW2WHE4/Vi6
         CoitU141c9ir6xEQBGUh5ynCmQRiWnw88wQlOqGj5bihKj32x4Z56oFzQz0pd4doGrPk
         8IJeWcDyDjA1V/W4lWJ3fU08HZkko6oDVxRT0rXYS/NAmHHi+uw4uAJlV9az08KO8QZJ
         8iOQ==
X-Gm-Message-State: AOJu0Yw0q9oulw0C+VuHqk74Kmo1UhuIkAlPlyZd9l20Dv3TjGUJsiay
	KMu5EVQp6cwMamnQsVrmyPQp1JvDHqQ4vOjmAyLXiuVE+bPDRWzgiRHX
X-Gm-Gg: ASbGncvAaT6TKbPcFvZEkM6v2Ma1B8bVcBGvXWYlj0V2E3NvlfZNRDo2qFgMA3RwpDd
	Bp/LsbHrPM+qUTHRqarjW5Vq0U56u/J4uYgjCiHSvC7hzBOR4br4Wh74pjT8PhfU3WIBHmxwoeB
	/LFImyAWLuBVLrQhF5kPlwx+zDMbvAYx362rKXUC83BUECvdIOtpTya1ppt7Bntm0jgTWhSUYKR
	WCeJMFUkYwnKs/bu/1H7Hpg0KKEZLRk6gsF0J2GPP51ZmAZj5D5x8Z9eZxZnLV0XkJ2RhyjgM2W
	5ykm6Znku1uJKn51IiqwfXXP7qX2rT10LtXrcUmnCG2qhpJILrnr/bh9GjSTlm5nQNqilHfov6h
	66yVygob0edYX87gCtsfHbYcPH0lIQvXviG1ZjAn5ITz0ffUETE++X6cebYSRCK6fSaQ3tkTUXb
	dJMUJAdAdwjQ==
X-Google-Smtp-Source: AGHT+IFp+IUw9yuDTbtrISQBv+qHdY8dOa2hi8I2mTJWLVGZ8Gyy+GuufzcGp+vT+jjt32eI0l+kcA==
X-Received: by 2002:a17:907:5c1:b0:afe:d2e1:9018 with SMTP id a640c23a62f3a-b01d8c86721mr1249602466b.25.1756826634772;
        Tue, 02 Sep 2025 08:23:54 -0700 (PDT)
Received: from [192.168.50.203] (83.11.209.234.ipv4.supernova.orange.pl. [83.11.209.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc51e109sm9755731a12.41.2025.09.02.08.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 08:23:54 -0700 (PDT)
Message-ID: <5fb06bdd-b1d2-4625-9e9a-1679c5e69713@gmail.com>
Date: Tue, 2 Sep 2025 17:23:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: bcm590xx: Add support for interrupt handling
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Stanislav Jakubek <stano.jakubek@gmail.com>
References: <20250816-bcm590xx-irq-v1-1-ccbb490628dd@gmail.com>
 <20250902075057.GB2163762@google.com>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20250902075057.GB2163762@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/25 09:50, Lee Jones wrote:
> On Sat, 16 Aug 2025, Artur Weber wrote:
> 
>> The BCM590XX supports up to 128 internal interrupts, which are used by
>> various parts of the chip. Add regmap_irq-based interrupt handling and
>> helper functions to allow subdevice drivers to easily use the interrupts.
>>
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>> ---
>> This patch is a prerequisite for future subdevice additions, since
>> many of them rely on the interrupts; I have a power-on key driver and
>> an RTC driver ready which both use the IRQ data/helper functions included
>> in this patch (they will be sent in subsequent patch series), and more
>> are on the way.

(...)

>> diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
>> index 5a8456bbd63f65b9260f05ef6546c026bf822bae..d688abd08c12b621a38586650843e55bd71ca715 100644
>> --- a/drivers/mfd/bcm590xx.c
>> +++ b/drivers/mfd/bcm590xx.c
>> @@ -26,16 +26,30 @@
>>   #define BCM590XX_PMUREV_ANA_MASK	0xF0
>>   #define BCM590XX_PMUREV_ANA_SHIFT	4
>>   
>> +#define BCM590XX_REG_IRQ1		0x20
>> +#define BCM590XX_REG_IRQ1_MASK		0x30
> 
> REG and MASK mean different things.  What is it?

IRQ1_MASK is the corresponding IRQ mask register for IRQ1. I agree that
the naming is confusing, would "IRQ1MASK" (without the underscore
separator) sound better?

> 
>> +
>>   static const struct mfd_cell bcm590xx_devs[] = {
>>   	{
>>   		.name = "bcm590xx-vregs",
>>   	},
>>   };
>>   
>> +static bool bcm590xx_volatile_pri(struct device *dev, unsigned int reg)
> 
> What does pri mean?

Primary I2C subdev/regmap, named after the bcm590xx_regmap_config_pri
struct (where the BCM590XX_REGMAP_PRI/SEC constants got their name as
well). Should I add a comment here?

> 
>> +{
>> +	/*
>> +	 * IRQ registers are clear-on-read, make sure we don't cache them
>> +	 * so that they get read/cleared correctly
>> +	 */
>> +	return (reg >= BCM590XX_REG_IRQ1 &&
>> +		reg <= (BCM590XX_REG_IRQ1 + 15));
> 
> Use up to 100-chars to prevent these line feeds.

Ack, will fix this.

> 
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
>> @@ -46,6 +60,268 @@ static const struct regmap_config bcm590xx_regmap_config_sec = {
>>   	.cache_type	= REGCACHE_MAPLE,
>>   };
>>   
>> +/** Interrupt handling **/
> 
> This is obvious with the alerting header comment.
IMO it makes scrolling through the driver code a bit less confusing (the
interrupt list is clearly split from the regmap config and later model
detection and probe code), but I'll remove it if needed.>
>> +/* IRQ IDs in the MFD header follow the IRQ order in hardware. */
> 
> Not sure I the helpfulness of this comment.

Indeed I suppose it's not particularily helpful. I'll remove it.

> 
>> +#define BCM590XX_REGMAP_IRQ_REG(id)	REGMAP_IRQ_REG_LINE(id, 8)
> 
> What does the 8 mean?

IRQ register width - 8-bit wide registers. Each IRQ gets one bit for
status in the IRQx registers, and one bit for mask in the IRQxMASK
registers. See REGMAP_IRQ_REG_LINE in include/linux/regmap.h.

> 
>> +
>> +/* BCM59054 IRQs */
> 
> We can see this by the nomenclature.

(...)

>> +/* BCM59056 IRQs */
> 
> As above.
> 

Ack, will drop these.
>> +	switch (bcm590xx->pmu_id) {
>> +	case BCM590XX_PMUID_BCM59054:
>> +		irq_chip = &bcm59054_irq_chip;
>> +		break;
>> +	case BCM590XX_PMUID_BCM59056:
>> +		irq_chip = &bcm59056_irq_chip;
>> +		break;
>> +	default:
>> +		dev_err(bcm590xx->dev,
>> +			"Unknown device type, this is a driver bug!\n");
> 
> Prevent the wrap here.
> 
> No, this is not a driver bug.
> 
> Just "Unsupported device type %d" will be fine.
Ack, I'll reword the message.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = devm_regmap_add_irq_chip(bcm590xx->dev, bcm590xx->regmap_pri,
>> +			bcm590xx->irq, IRQF_TRIGGER_FALLING, 0,
>> +			irq_chip, &bcm590xx->irq_data);
>> +	if (ret) {
>> +		dev_err(bcm590xx->dev, "Failed to reguest IRQ %d: %d\n",
> 
> "Failed to add IRQ Chip for IRQ: %d (%d)"
> 
>> +			bcm590xx->irq, ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/** Chip version parsing **/
> 
> Not needed.
> 

See my reply to "/** Interrupt handling **/" comment part.

(...)
>> diff --git a/include/linux/mfd/bcm590xx.h b/include/linux/mfd/bcm590xx.h
>> index 5a5783abd47b9a6bb6f9bb3a8cafddbd01aa7fcc..e6ea643766ab1a9d579c94605b54c53dc1d742d7 100644
>> --- a/include/linux/mfd/bcm590xx.h
>> +++ b/include/linux/mfd/bcm590xx.h
>> @@ -50,6 +50,237 @@ struct bcm590xx {
>>   	/* Chip revision, read from PMUREV reg */
>>   	u8 rev_digital;
>>   	u8 rev_analog;
>> +
>> +	/* Interrupts */
>> +	int irq;
>> +	struct regmap_irq_chip_data *irq_data;
>> +};
>> +
>> +/* Interrupt handling helper functions */
>> +
>> +static inline int
>> +bcm590xx_devm_request_irq(struct device *dev, struct bcm590xx *bcm590xx, int irq,
>> +			  irq_handler_t handler, unsigned long flags,
>> +			  const char *name, void *data)
>> +{
>> +	if (!bcm590xx->irq_data)
>> +		return -EINVAL;
>> +
>> +	return devm_request_threaded_irq(dev,
>> +				regmap_irq_get_virq(bcm590xx->irq_data, irq),
>> +				NULL, handler, flags, name, data);
>> +}
>> +
>> +static inline void
>> +bcm590xx_devm_free_irq(struct device *dev, struct bcm590xx *bcm590xx, int irq,
>> +		       void *data)
>> +{
>> +	if (!bcm590xx->irq_data)
>> +		return;
>> +
>> +	devm_free_irq(dev, regmap_irq_get_virq(bcm590xx->irq_data, irq), data);
>> +}
> 
> These functions are abstracted for the sake of abstraction.  Please remove.

OK, will do.

Best regards
Artur

