Return-Path: <linux-kernel+bounces-729756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84774B03B26
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA21F7ACAB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B74246796;
	Mon, 14 Jul 2025 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1A0od89"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2724169E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486145; cv=none; b=ofY9Rzwli4IyPj3Fep676EDj6gj5UrTOwBYfgw9mQkk92aZdVWYLmOU2Q2hoUG0BvehMm4p1vrnhDFc8tOECzDHj/OnMT+jWAhSTDY5AAMfwgv+iDnULnLnxz9Ji3EStf0qaCbNhTVvWnGHj8H5lajcaSPYIRN3N/X6DLcLlmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486145; c=relaxed/simple;
	bh=Dd9i81Xapcv/kaa13b0TBnS+b8vIavnUthhIGe/u6rA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pk554IctEqT9RBiEh3NobY3a2tvIPlNAQaoMMXXXlK1pmQdxqJfhrWQNjQgg/UrHasrtEqmo/oj4JQrr+gCU+PqrLgxeTkFbK7S64xJtvSdWrKCpTXIpNzGwQVYS8EFqAbmnE31Y2vsP6DcBIUAWlCb73xDT+znD8lOG4WfUPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1A0od89; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752486142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8Tx95/WvSTK8NTF77+QTvu/+GuQhrx4IJVb9WBQk78=;
	b=I1A0od89ycCever5Vtx0SydAmas267vL95XMAZCkCHk2xiA/PdDa4GJgcYhqa/zFzPuD4x
	uwZVOC/Pw9OZ5FDU+mjVF7A6DzR9BzEi5kP8epta2MhrGxBXANABuanzNiJG4L5W9teVXi
	DYS52No8v69VmpBKK/y5l+kPg8E5Wnk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-kak6T9klPW6FrGj4axX_KQ-1; Mon, 14 Jul 2025 05:42:19 -0400
X-MC-Unique: kak6T9klPW6FrGj4axX_KQ-1
X-Mimecast-MFC-AGG-ID: kak6T9klPW6FrGj4axX_KQ_1752486138
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso1801246f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486138; x=1753090938;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8Tx95/WvSTK8NTF77+QTvu/+GuQhrx4IJVb9WBQk78=;
        b=Cdb0Uq04XeAvqtriRbuJJknn2I9uNzI5LEGRirlKyuZyy3EjkchisJiW/B7r1aCMy1
         aYqSKRwv/Cuo02GCk/wjcLMYgbYAwgQrVvBn4L8djQolhcfDc5PurKzkhh2gxAsG2FGc
         8AgRI0SqIvD9QNvsYRvn8thilQeRA9fOrM2Y+Kc7kwbvfvr3QY5cMqy1OE7q60Gs+I5t
         SA+x/KU2grWIYDAyJybsTKFG3rgCkZh3BHFVzagF/yoBOV5sT6mcK2LVB6pfdeJGcPKU
         dLTYGVWKRIxm6tiGHx2GpoQm1nr4scDJxd+6C4VRGZfNiV2+jy2Uthas5KGVTPNpgv3P
         AWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMkYtoe2Drb3Jz5RFyZ8eXKUUlDPiJ84FPFi7l0liptUaNpgo7nmSlIOZxGZN2sqvGv8I33nJxG/1n1Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFUbn3n0aIlRkreiRyPo5t6dFzS1iBnLLpESmBAzqrLnq9GtK
	m94XVMxabsH2YByhCTDVngMmiAhm1HvUlKsZRr8p33MYUwa6gFhXwp7QBkvy3YOgxVfrYXP7lNI
	war233OLTaRdjbMnPIAyHQas56y9J1jUsPHCZLsOllUN6VTNIRRCr9bcyyWKWlvTYMw==
X-Gm-Gg: ASbGnctlW/tYYk/prKRGLFJ9G5UIUjWZpj9NBzNqlEWf1YKlZFvxv1hidIfsx1oSe/F
	NGFVnbtVoapdIuiUNWbiQy1BUoJLJUUHhlH8GhYM7vrscd3Pj7/0m5SXJZK8epzIHgxVKFE49OQ
	CszXvNegJj4K1+FmAKIYLM3ZfqFHuHlnmeRD0pPmeQtwQ1evIyywOh32zoiNj69CodjWO007mmO
	KQ2rQRLlqZEFx4AM64XlysEt+SZUuzD9/vwkKNTT+tmPlzL/0jfqf+dzoU5Ren4qAr/X9+0ICZG
	pqEI4QUtBfbc5FZlv70+ptjOq5S0xqdMTvOsQUqs0XezgDWqEpK5qF6/pxhLkcxxgw==
X-Received: by 2002:a05:6000:e0a:b0:3a4:e841:b236 with SMTP id ffacd0b85a97d-3b5f18cebeemr8726634f8f.33.1752486137665;
        Mon, 14 Jul 2025 02:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5V4Ve8BAPt6NU+cG8lX/fpEurIJIrdqdQxfcQNaUpGgaXzhyffw4d2Lxh8B67YSliB2bm2g==
X-Received: by 2002:a05:6000:e0a:b0:3a4:e841:b236 with SMTP id ffacd0b85a97d-3b5f18cebeemr8726599f8f.33.1752486137180;
        Mon, 14 Jul 2025 02:42:17 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455ef31717dsm91187365e9.6.2025.07.14.02.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:42:16 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com, David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Maxime Ripard <mripard@kernel.org>, Simona
 Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/sitronix/st7571-i2c: Make the reset GPIO to be
 optional
In-Reply-To: <10bb159a-0c6a-4950-b038-68608e2a771d@suse.de>
References: <20250710102453.101078-1-javierm@redhat.com>
 <20250710102453.101078-3-javierm@redhat.com>
 <10bb159a-0c6a-4950-b038-68608e2a771d@suse.de>
Date: Mon, 14 Jul 2025 11:42:15 +0200
Message-ID: <87zfd7cdmw.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

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
>>   
>>   	return 0;
>>   }
>>   
>>   static void st7571_reset(struct st7571_device *st7571)
>>   {
>> +	if (!st7571->reset)
>> +		return;
>> +
>
> My interpretation of this function is that calling it guarantees a 
> device reset (or an error). So I'd push this test into the caller.
>

That's a good point. I'll then do the check in the caller.

Actually... at the end I didn't need a st7571_reset() call for ST7567
since it has its own struct st7571_panel_data .init callback function.

So I can just drop the test for st7571->reset being NULL.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


