Return-Path: <linux-kernel+bounces-729767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E68B03B49
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27935170C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12E24291A;
	Mon, 14 Jul 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+r1OYpU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B01E47A8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486464; cv=none; b=Cbm77VYWFAXX+BCwKXpJb7RXritd2VJj3MLvG5DaY/X1rohwbq1Zyd3HI0Sk/cYB0Uth7KfvP25/fa2eGoh28pjU4Cr23z1UgPBfcMTl4tmo7j6D8B7ruOtWFJweQ9/cZnmvGO8g+BP97QJnPIUrPKL6HW/h3UUDxCgLytcGPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486464; c=relaxed/simple;
	bh=r5e66zeaxN9i8i3lK6ipsXsQ7GIMLqpPS4m0J6vB65A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gmUCKtf1A5uVsKZNDaJa2GnummYhdWqkNNd8PRZ3gBWygPvV8cA1+L97bd4JbtG6dofMU812g6o90qffje8biU2WYCFTzJ2ONjoapcHm+TyA9ZEBVh1z40zPDNdtVtmnThfOHC/J9l3ABGITw2GRQ4c22Yvb0opNRLsBc5ECUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+r1OYpU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752486460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tg6OrG2lClZinE0UYtX6042I+em3JNwfWFCrJiRfTNs=;
	b=c+r1OYpUvZbN9zX/6t6xuYZ1Ngs8aU+ZhifVLCivAWREDtF5lnDSg4dPj1NYDjvvuiuegG
	tV/k/SUxxlQY2d5fk8b33bETbODJUs2hb7wF8/GyMgvPPLuA4b1WWnpvSz66I8bZ1yEFOU
	2XzrB0sdNXPiaiwcB36uQ2yP2B64vuk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-wguBNlp3MWCmTbHoa4Z8zQ-1; Mon, 14 Jul 2025 05:47:38 -0400
X-MC-Unique: wguBNlp3MWCmTbHoa4Z8zQ-1
X-Mimecast-MFC-AGG-ID: wguBNlp3MWCmTbHoa4Z8zQ_1752486458
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450df53d461so32041215e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486457; x=1753091257;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tg6OrG2lClZinE0UYtX6042I+em3JNwfWFCrJiRfTNs=;
        b=Isz4Ved2nZmjpO2v4hTW4YZpGV8sL/oaHs7GQPU7pISU6TrRB9slUBE2smaeJUe/Lk
         2BFppM46ZY2E06per4gPnqyUNp4DX/EBcJBNK1o6O1ag2SzSiJg58YHzMjri1zYCiNHc
         FcucTayynmgPFzFf6jKFTxPsgGCiaiDN/USM0Ul4erSSwh+2vxwknzlEvksaSzKT3iV+
         Q3oC2738Gyh97aDFAggCJ3EEdZiORReBM3wgzu6U5IbhNbYUh8g5SF50u1B0UAzracMZ
         7lzclobrFTCqU+6SRl2nbz2RGemMagBWpHlrelz9AGBYmzglsN2KeyALlNN9ueECdvnQ
         Su9A==
X-Forwarded-Encrypted: i=1; AJvYcCXH8djI8OHm1k4OR5iGLSehZ+D4mbCSpPz9Lm+EJszVcDIViZr2/w5y1L5JoO+V/bvJCuQfl6h4Y71rmD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyum3nWg9l9nBteg4CF94v9RnVqHAXmvF4/iVV3xLg64t9m6uC9
	e/MNcDt9QTbgdgVaQMm8SYAg/5yM6RhA9XO2awhs4N3GASeI9VFw3QRJufAXNpSYxNgBtTYOmOF
	vGdrSAqfHd7lSNQn01vJUP23sIEsrejcN3DJI75mgsTS5cY6/pDGId/zbMg0S3Xxk7A==
X-Gm-Gg: ASbGncvfCjhWc1liMfubQE+hrpw2j8rC5WbPn8erIdRg9jHowo/LaGJN5C2vGBO/f6t
	1W6d4trRHEOxHip+G/XT7p5n7MkqWd9mxBGMpw54pzgBBQ2UKIIV6rQIgyqZrwDMl3BzdHe4/kx
	77lGxjILu/XQPiKJb4nNwaVOvvrf/H1Hql3/2W09KmUb7jQ4oWG+RA0Y3Tc19BU7JxL+1LfDlUx
	TuD+RQsJ+vCCarwWNbDoHozOroNQekZbHpZO+J4lnQbgnvnW7nTg4Wazoo4EDpK+xiz45pl1+R8
	qigftAxYeprgl9JZFZGMJY7c1hJEYNFlXWxLbEkpwI0UDL6JCGE+uerQQMbwET8zbQ==
X-Received: by 2002:a05:600c:3512:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-454f425e54bmr104132945e9.23.1752486457487;
        Mon, 14 Jul 2025 02:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6GLJ/UoOdy4fat1894JkNggjKUy6Oe0jdCke5tLCOwZhy64jd93MzBjwuQH2IlasuWTc/rw==
X-Received: by 2002:a05:600c:3512:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-454f425e54bmr104132715e9.23.1752486456999;
        Mon, 14 Jul 2025 02:47:36 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456111574adsm49430775e9.11.2025.07.14.02.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:47:36 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com, David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Maxime Ripard <mripard@kernel.org>, Simona
 Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/sitronix/st7571-i2c: Make the reset GPIO to be
 optional
In-Reply-To: <a5cb70b2-f724-4d5e-910c-0b92dd759ebf@suse.de>
References: <20250710102453.101078-1-javierm@redhat.com>
 <20250710102453.101078-3-javierm@redhat.com>
 <a5cb70b2-f724-4d5e-910c-0b92dd759ebf@suse.de>
Date: Mon, 14 Jul 2025 11:47:35 +0200
Message-ID: <87tt3fksso.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 10.07.25 um 12:24 schrieb Javier Martinez Canillas:
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
>>   drivers/gpu/drm/sitronix/st7571-i2c.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
>> index eec846892962..73e8db25f895 100644
>> --- a/drivers/gpu/drm/sitronix/st7571-i2c.c
>> +++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
>> @@ -802,15 +802,19 @@ static int st7571_parse_dt(struct st7571_device *st7571)
>>   	st7571->nlines = dt.vactive.typ;
>>   	st7571->ncols = dt.hactive.typ;
>>   
>> -	st7571->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>> +	st7571->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>>   	if (IS_ERR(st7571->reset))
>> -		return PTR_ERR(st7571->reset);
>> +		return dev_err_probe(dev, PTR_ERR(st7571->reset),
>> +				     "Failed to get reset gpio\n");
>
> There's struct st7571_panel_data. It could store a flag signalling the 
> expected behavior.
>

Indeed.

> With more effort the panel_data could store a dedicated parse_dt pointer 
> for each panel type. ASAICT the st7567 features a subset of the other 
> type. So there might not be much code duplication.
>

This is a good idea too. I think that will do that for v2.

Thanks a lot for your feedback!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


