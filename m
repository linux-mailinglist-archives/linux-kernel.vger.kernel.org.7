Return-Path: <linux-kernel+bounces-725504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BAAFFFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC611C874B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C718D2E5421;
	Thu, 10 Jul 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCPKoT0j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BC24501E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145253; cv=none; b=Vc5YkC0tszq2X6UTuIciKS2CAeOpLMI62p4JYB7QjOugnx9vbndJJqKRPlRmlmPQbLSlhJIttWeJixyJVIaDzLU2O7VCwpiZWbfrop4YdchXDRXfrkdyYoQFpr4mWvsac+eYkiuZ4m1v2JKoHT/Yhcvw8XkHgBUaD8BYzUPOhyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145253; c=relaxed/simple;
	bh=RrjB1QLm+V0qWk8Din64wfVsUefhp8haaJMzWZZWjck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHHgn4M8qj/w8vIHi/m/Py0Urq7+VncTGRdSX0lQRaCo6RNASFb371+aWt8XnUUdz6TTr17jX6PPs0K2C1DcdvyXH10UGAj5EhZh0Q+sJlyiorlD3qqcVl57RL2/A7oji/zrRW2gp4ve3PzT2ChCYLfiUk+yFMdSIkERZAsZREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCPKoT0j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752145250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gomE3MBXXGfxhr5npCwS6+iwSNbCirqyEk3ljYY0xkk=;
	b=UCPKoT0jXuQRDRHHguNbm8G/Kc8broBXpoxCHfpwmwabTXGagIcQZDlNGghi0NyKgX2rAl
	C4vJ3wE0hKszULvaPwqScVtwbiAwlDteG+gbmMNrTymc1iuXa2hRM1NFOwphf3YKcbxubu
	rQ97bQ2x4Oon30bvViPmB4dsa+cGaM8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-uiDJT9LcP-WqQQ1AxeNTYQ-1; Thu, 10 Jul 2025 07:00:48 -0400
X-MC-Unique: uiDJT9LcP-WqQQ1AxeNTYQ-1
X-Mimecast-MFC-AGG-ID: uiDJT9LcP-WqQQ1AxeNTYQ_1752145247
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4532ff43376so7715885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752145246; x=1752750046;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gomE3MBXXGfxhr5npCwS6+iwSNbCirqyEk3ljYY0xkk=;
        b=MRo4YRbtKAbJd2iMxS2j8+LqWq1td7SjyXUqXOPnFyJWbZSlwXWWU1j2si2qeNV2eI
         Jc6Zf03vp76vhVkKypzO2NaEf5zhE2EJqWG8ZqryFPpF/ZhKoCMydqrjNcspdJXJa+1f
         XmDZzuvxpIrVLs2CglnJt7DNH27TOnF3NW0gebldh/1W2Adw3cW2wljhGNfTK5+tiD46
         04mMCTrTDqJPv1grt5QKge3pijIxkrbr5S0N4ngQZYhwnlKy6Gf8o1Foaz8WFaONBhVq
         hbg+NBAnRH7/B7n2dJcqb0gZ0Wo9ilkAvlELOSuG49zOAJDHtIhC2p2QEaY3uRUtwmIe
         4T2Q==
X-Gm-Message-State: AOJu0YyxLzEB9kompxgB70cj11a44vey0AYnmzGJBOvqY29nu7nW4gaO
	vJUgXuzaGOlOWZUJCsuU37rzWG3dEz1zwi9vSxxJQ7N9cvDWSxjW+sbSBWGYOG7KH7wVup6MByp
	2D6apJ2SXqXjvRbhKYRbHU63H1uQvmJHMPp+782BYSrdJtNKa1t1SpnQm39Yzjs9K43N8UkebkQ
	==
X-Gm-Gg: ASbGncsaXjlvIMw6lp6ONdlEJVo88LQ+YZpAhT6jtVJ8UDRuVnHjTzkiyTOX84Bv23e
	POExb9dcaqlxtDgu7pEL6RCFbvu2qjBm8EHgY1DUQgXSI9BiVE8pP5RFs6oXn/+J0C7u48xoCOa
	FpFPMCzHcqLQ8/DRbQT20bKSZ8wnUb5a2mzf1PBzVQjWFViGfR9psmE+Hphhm9ttAW2Yo6ze8fs
	g+D98XVlxaqdljAlYnlSTganNZ1OfVG+5CeWos0NqgScGWWBxLFmuotYAf+V6WbyUxGtByHWRlo
	6wdCfU/p/g/UdMu9P0YRWquVImXG+V8FIM9ucbzswoybLYdMmGBOj4KyhPvvltnPs8PHmYwc2Gf
	6LC1T
X-Received: by 2002:a05:600c:6092:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-454dd12d764mr21215075e9.0.1752145245321;
        Thu, 10 Jul 2025 04:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwjvEZSbjGBPdvjbpTjZORnYH8PHW0YCHE4yPTmzJg1yY7nN5xlDWDPbulbRm+wpcocA2RuA==
X-Received: by 2002:a05:600c:6092:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-454dd12d764mr21214605e9.0.1752145244788;
        Thu, 10 Jul 2025 04:00:44 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d512c2bfsm54037455e9.39.2025.07.10.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:00:43 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-kernel@vger.kernel.org, ipedrosa@redhat.com, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/sitronix/st7571-i2c: Make the reset GPIO to be
 optional
In-Reply-To: <aG-aXTgycE4JEJEZ@gmail.com>
References: <20250710102453.101078-1-javierm@redhat.com>
 <20250710102453.101078-3-javierm@redhat.com> <aG-aXTgycE4JEJEZ@gmail.com>
Date: Thu, 10 Jul 2025 13:00:41 +0200
Message-ID: <87jz4gfgyu.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

Hello Marcus,

Thanks for your feedback.

> On Thu, Jul 10, 2025 at 12:24:34PM +0200, Javier Martinez Canillas wrote:
>> Some Sitronix LCD controllers (such as the ST7567) don't have a reset pin,
>> so lets relax this in the driver and make the reset GPIO to be optional.
>> 
>> The devm_gpiod_get_optional() helper is similar to devm_gpiod_get(), but
>> returns NULL when there isn't a reset-gpios property defined in a DT node.
>> 
>> The DT binding schema for "sitronix,st7571" that require a reset GPIO will
>> enforce the "reset-gpios" to be present, due being a required DT property.
>> But in the driver itself the property can be made optional if not defined.
>> 
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>>  drivers/gpu/drm/sitronix/st7571-i2c.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
>> index eec846892962..73e8db25f895 100644
>> --- a/drivers/gpu/drm/sitronix/st7571-i2c.c
>> +++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
>> @@ -802,15 +802,19 @@ static int st7571_parse_dt(struct st7571_device *st7571)
>>  	st7571->nlines = dt.vactive.typ;
>>  	st7571->ncols = dt.hactive.typ;
>>  
>> -	st7571->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>> +	st7571->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>>  	if (IS_ERR(st7571->reset))
>> -		return PTR_ERR(st7571->reset);
>> +		return dev_err_probe(dev, PTR_ERR(st7571->reset),
>> +				     "Failed to get reset gpio\n");
>
> devm_gpiod_get_optional() returns -ENOENT when the GPIO is not found,
> and that is no error we want to propagage upwards.
>
> Maybe something like this instead:
> if (IS_ERR(st7571->reset) && IS_ERR(st7571->reset) != -ENOENT)
>

Are you sure about that? As far as I know, that is exactly the
difference between gpiod_get() and gpiod_get_optional() variants.

From the gpiod_get_optional() function helper kernel-doc [0]:

/**
 * gpiod_get_optional - obtain an optional GPIO for a given GPIO function
 * @dev: GPIO consumer, can be NULL for system-global GPIOs
 * @con_id: function within the GPIO consumer
 * @flags: optional GPIO initialization flags
 *
 * This is equivalent to gpiod_get(), except that when no GPIO was assigned to
 * the requested function it will return NULL. This is convenient for drivers
 * that need to handle optional GPIOs.
 *
 * Returns:
 * The GPIO descriptor corresponding to the function @con_id of device
 * dev, NULL if no GPIO has been assigned to the requested function, or
 * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
 */

while the gpiod_get() kernel-doc says the following:

/**
 * gpiod_get - obtain a GPIO for a given GPIO function
 * @dev:	GPIO consumer, can be NULL for system-global GPIOs
 * @con_id:	function within the GPIO consumer
 * @flags:	optional GPIO initialization flags
 *
 * Returns:
 * The GPIO descriptor corresponding to the function @con_id of device
 * dev, -ENOENT if no GPIO has been assigned to the requested function, or
 * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
 */

[0]: https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/gpio/gpiolib.c#L4755

>
> Best regards,
> Marcus Folkesson

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


