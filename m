Return-Path: <linux-kernel+bounces-728195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B3B02487
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70DEA47402
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0D61E0DE8;
	Fri, 11 Jul 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvwLEJ5Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F9B1DDA14
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261909; cv=none; b=olaX0pTAF2V0tIDxRJrl/2LbXrEMBuAksYIqK4DZc+jt13om6ftiki1QJHZ+62GWeHxQQp28Dx5jbsj34MKHtI10XUcK6ytFVuH/HPXlYpMVtnfVpLuEMcw2dRRnrswL0zzFXgVxFYi+Nweom4KfIHpb8a6V1QVg2miODpCIg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261909; c=relaxed/simple;
	bh=QSN8tr91By5Xs+j7L0e7TDyrheCqYWYDuZBKMhLTanw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DoakmGIUy4wb5C0ZsDvpQBlCk43oMPGnKq1+55rp+8UFfveQxfZjaY3PkXJkMILo1tXkWbQdLawJt2oC/AoUeSMIiE+7hzehB5nVOomHABs02DKHtyNomFMNlV3yfBCC7QFHKc4CxyeJmt0JzO+l0WPr5ZLvNKGzqo2FlU4EAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvwLEJ5Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752261906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kGO4vRGgXGLL3hZnBNYmBbSAWGoCIWSfs9lOrm3uA2M=;
	b=KvwLEJ5Z3u+vttPe00KNwYO85ujysHT3e7ZMcD/Qfw97sYJUfdtodKsBrTMJRXDj4rGxHQ
	V2OxBcUda1pBa0sNGdVGhJLJKIYC8jxlmptJzvW9pWEwhBKqH0Y0LFY64FHT7YMkvpbWnp
	+NGuFAZelkY82pcPDN6R1ENbmGiC8Do=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-yAaOmg5TNfyZ1_v_4VO0vg-1; Fri, 11 Jul 2025 15:25:04 -0400
X-MC-Unique: yAaOmg5TNfyZ1_v_4VO0vg-1
X-Mimecast-MFC-AGG-ID: yAaOmg5TNfyZ1_v_4VO0vg_1752261904
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455e918d690so4309745e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261903; x=1752866703;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGO4vRGgXGLL3hZnBNYmBbSAWGoCIWSfs9lOrm3uA2M=;
        b=lD1UJbWip9UImyHhZy9TPtBByyC1459d6x9kvvRXiA9Y2aZoJmYLxuuzI/YcEP1H9c
         LETFCL7xjrZD1sKkTlda50gUaRCN5cf+cWQwF5bh1tRKVAhtqCCuhAY2qhUdfCrXfHpX
         hJ6X14Ft+q5l8yMMSbGq40CZzFDjjVqC60HOIPJP9ka6U0ZXK9cmfV4a6qvyfpnY0WXb
         RDp2CXsG8mZq2oEJQXwbZdDg0qiAEWA+kVx1Fc7zdutajSjeHEgFpJeJvdPunKhrekvt
         yM93zEvSQLZDBt5VvjMFYLpUU6xGal0E35D2XCqD8uHqp0/MrumG/yaNDCJ4VNlG/Ky+
         IlIg==
X-Gm-Message-State: AOJu0YyZcSn+oiGyn4uBl0ZWge86LCkl1UwlmsZSqFse93zpHAlzHegl
	1z1dbAmDrO+U5dwDfsKvcgLo1hUGOWKbIoke7Krqt9/erIPH7dSl5xE8/0RLDw4bcKZVzr8+YHw
	TP4ypP95eyqcm6Yjzh/C/stlyWhhuCFdRquRlqS1iTQb3S4SEqoT/U4b2A89me7j+nA==
X-Gm-Gg: ASbGncvCKezivy0rF5vUlH+zTW8Sk9qjbw+36CwWInj/Eizu5uLwgfjiu9rwUMUdjvg
	xULmFxZAnPcYfx9fgRVpt/rhrn0PEsSvYQ0QnAqhFerGk3k7wbeBUFTh21BArTHfcLWizph7GwG
	zHIhHZ+sSAtLqWiqc3jfAy3nsWfRiFaf0f23GObAohwXARzjegQx5al8JnIJDmOTWZSRBXmROwW
	+ILHGeJn9JN8NBMIoFjYIs0IUGACpaPkOA08YhazTBiqPoB5RTOiHxzjAzLdCXEsAw6GlweJ8f7
	nN53La1gtS+dpJkj+Rm7gNmgdXwFa5XCEo21pSwTaUV4/uWvIG2VeKzUZMmVMBoT3mfwaImVkZG
	2vf59QaabDResEoRYErMDeA==
X-Received: by 2002:a05:600c:1e02:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-454e2a426afmr43642525e9.0.1752261903403;
        Fri, 11 Jul 2025 12:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsVTpi9JlkuFNtnbmvXjIbTw8+Bi0t6SWJf6PftBV3tD/DcW6zZ9OovWNlJ03/UuP8WcYcUg==
X-Received: by 2002:a05:600c:1e02:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-454e2a426afmr43642385e9.0.1752261902955;
        Fri, 11 Jul 2025 12:25:02 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d88dsm5328231f8f.65.2025.07.11.12.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:25:02 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-kernel@vger.kernel.org, ipedrosa@redhat.com, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/sitronix/st7571-i2c: Make the reset GPIO to be
 optional
In-Reply-To: <aG-ftUl7l2zNm_eH@gmail.com>
References: <20250710102453.101078-1-javierm@redhat.com>
 <20250710102453.101078-3-javierm@redhat.com> <aG-aXTgycE4JEJEZ@gmail.com>
 <87jz4gfgyu.fsf@minerva.mail-host-address-is-not-set>
 <aG-ftUl7l2zNm_eH@gmail.com>
Date: Fri, 11 Jul 2025 21:25:00 +0200
Message-ID: <875xfyedir.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

Hello Marcus,

> Hello Javier,
>
> On Thu, Jul 10, 2025 at 01:00:41PM +0200, Javier Martinez Canillas wrote:
>> >
>> > devm_gpiod_get_optional() returns -ENOENT when the GPIO is not found,
>> > and that is no error we want to propagage upwards.
>> >
>> > Maybe something like this instead:
>> > if (IS_ERR(st7571->reset) && IS_ERR(st7571->reset) != -ENOENT)
>> >
>> 
>> Are you sure about that? As far as I know, that is exactly the
>> difference between gpiod_get() and gpiod_get_optional() variants.
>> 
>> From the gpiod_get_optional() function helper kernel-doc [0]:
>> 
>> /**
>>  * gpiod_get_optional - obtain an optional GPIO for a given GPIO function
>>  * @dev: GPIO consumer, can be NULL for system-global GPIOs
>>  * @con_id: function within the GPIO consumer
>>  * @flags: optional GPIO initialization flags
>>  *
>>  * This is equivalent to gpiod_get(), except that when no GPIO was assigned to
>>  * the requested function it will return NULL. This is convenient for drivers
>>  * that need to handle optional GPIOs.
>>  *
>>  * Returns:
>>  * The GPIO descriptor corresponding to the function @con_id of device
>>  * dev, NULL if no GPIO has been assigned to the requested function, or
>>  * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
>>  */
>> 
>> while the gpiod_get() kernel-doc says the following:
>> 
>> /**
>>  * gpiod_get - obtain a GPIO for a given GPIO function
>>  * @dev:	GPIO consumer, can be NULL for system-global GPIOs
>>  * @con_id:	function within the GPIO consumer
>>  * @flags:	optional GPIO initialization flags
>>  *
>>  * Returns:
>>  * The GPIO descriptor corresponding to the function @con_id of device
>>  * dev, -ENOENT if no GPIO has been assigned to the requested function, or
>>  * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
>>  */
>> 
>
> You are completely righ.
>
> Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>

Thanks for your review! Do you plan to look at the other patches too ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


