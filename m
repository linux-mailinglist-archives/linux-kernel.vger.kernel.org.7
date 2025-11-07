Return-Path: <linux-kernel+bounces-891020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2AFC41A10
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB141899F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FB230CDB4;
	Fri,  7 Nov 2025 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="IZBUedsF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334C24DD1F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548536; cv=none; b=CVPt+lW01qzDoDr3Qpq6AYpoLaGTtVdM/sFHKr/BvDU8QdKI3MJHLwTWyjJ2ceB2AtX4B9pmCXSDS/BpGkHlOrY0ZPR6llxsYrRrxzAU0gg8BshI2A75W5AWSBDdCAvyRAt/2NQKuh7G++2fHWWDst73NC2Qb+pA3HJcz6/s9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548536; c=relaxed/simple;
	bh=BrwMqVzxSFSrumVtMhF3GpDchobZ71gat6R6EZQcTTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWWmdMdv51OCSTzAdd+U5xb9cI/zVfxIAwrH3tqT+CxgJvAvdG8FOc2Hf51EU5QpjK50qIfgnr2A9GjGtA36wfmqYveDs+s5LKrhg1S1Adz2mUWOrvGDtvLvS04wN+RLKs7r1/jbG5O7jQlfrijiaOwB1yWO3M/fh1MP3cy/WQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=IZBUedsF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47117f92e32so9948695e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762548533; x=1763153333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOrW5Q8xydcVXM43dd9aQAu40I7etAmkHTRU8lGajvI=;
        b=IZBUedsFas8cttJW5svw/qWQQR+xvoROw+Ms6hxBxIo0VCuQ3T345p5QgGbjChyE69
         XRI+3G7a9pUwFzLHRIVC+Rpb2mvZjqKhuthJyPx6C6GeEjNyzvMD/YoU6Y+qVuF27fHb
         E3yQodMqTyegwXEj3kqiCMg4kdKEFL7kzeK9000G76gZCb8ddAZtx5yMEaTsK4dLU5Me
         LZRS/SndpwOkLsPlo4BY9ygizPwD0U6002eMbzX9QUtxOk49wPjktgW050bbad8yzGP5
         oFvidsxbevO63WESjGHZcQH9dvbnAgPh3hMvGwsfy0U0belYHRIku5DTHU0GhvetAc5N
         OCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548533; x=1763153333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOrW5Q8xydcVXM43dd9aQAu40I7etAmkHTRU8lGajvI=;
        b=qSFlvP/6GZwQL1NORhX0BnJ52jvd9Dh6/xDdYzPF0xBpitVsdrAR0TBlT69bWdfZbt
         2wZF7ZO3UNVr5so/2O8Jb1iQ9ZRcy2NyCB+awy/DBqN6O2d46mfWBISFfFuE0C3nD6r/
         lFJ8QXCapdHKTaDXYLa4EQbM697/KC0bMGcNg10IhGtGOZcNtW1P0D7xxB6YkrJG9hvZ
         cxfWNgj6l68QLM2MIqCpkEn/2Vltx0M0MJRTx/igDLH1pyuQ3RjxTyvIQVV/y2tHU/aG
         cg0fUxgiLh2SbXoxuoVsEuY6Au+MwsDHWEyemIecAqu9cmLzY2tsWDihBclw3SdbAbn/
         FNWA==
X-Forwarded-Encrypted: i=1; AJvYcCWNcp0xRDFWr1ild9tLxfPqepE9xpb1pHYj5EgaC55uCloj40htMBYO9wdbE0WuQeiDJQk9hDplSPBB5qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYwciag14vqujsIo+m/nDKxn40f+Ii7qqvq9De7RoRfc/bgPm
	oFwOhZmf/CIAJr5oMZi/ezrprA/b9lrFjCVRXGI7N7T8jfyInTbG0SgwQ1J/ftWrSVQ=
X-Gm-Gg: ASbGncvtfVI99luFDHP8V1K1joq+HayB6RsrBTd5ThUcL4B/hggodx2C1lTwYdI2BNh
	lbjnDdxcqgpmI6tFT4Cu7SggUk50P/eiycgs0ZXhcZeAgGWNjC19C8kND8jyc8Vvu3TPYYUtWW5
	kiIM22S8N7vdP0ktvKUSItCqRZeCVHPpgcPTEFkSjUA98a8Ne9CaAb7GBsfR2IpHtt5rQztY8xk
	nSLhViMEiBvkP0ZOvZls/ex1w2ip9s91CGSy12jWgvJwABmb87MIMKxJGoyb95fbTDNLjIWXnxB
	JJ2Ru5P98GAu2zyBhfOal3pE9bkbptOzT4XyQ8T0WQMZZuCd1jM9UY4QgxyDqnlslOop6uKAcC+
	IVy787qIp30z+kS+yndcyFHZ1ZWuVFy286WNUW1Dg3z9zySG2AA3dW57GoNnwR91MgYDbQMjT2A
	zLfsSL62rub6Hy7z33
X-Google-Smtp-Source: AGHT+IGa8NQ+H5fu5Ot6rFuuXBzldd5AfEsvjMI89lcmjBY68BYTS+xXWss+yNFMorFaomhESv3lIA==
X-Received: by 2002:a05:600c:8b4c:b0:46e:4a60:ea2c with SMTP id 5b1f17b1804b1-47773293987mr2821745e9.37.1762548532683;
        Fri, 07 Nov 2025 12:48:52 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763b5359esm53398575e9.0.2025.11.07.12.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 12:48:52 -0800 (PST)
Message-ID: <14ca1b28-df1d-4065-ad7a-97a3ff81a5a4@ursulin.net>
Date: Fri, 7 Nov 2025 20:48:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i195: Fix format string truncation warning
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20251107164240.2023366-2-ardb+git@google.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251107164240.2023366-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 07/11/2025 16:42, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> GCC notices that the 16-byte uabi_name field could theoretically be too
> small for the formatted string if the instance number exceeds 100.
> 
> Given that there are apparently ABI concerns here, this is the minimal
> fix that shuts up the compiler without changing the output or the
> maximum length for existing values < 100.

What would be those ABI concerns? I don't immediately see any.
> drivers/gpu/drm/i915/intel_memory_region.c: In function ‘intel_memory_region_create’:
> drivers/gpu/drm/i915/intel_memory_region.c:273:61: error: ‘%u’ directive output may be truncated writing between 1 and 5 bytes into a region of size between 3 and 11 [-Werror=format-truncation=]
>    273 |         snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u",
>        |                                                             ^~
> drivers/gpu/drm/i915/intel_memory_region.c:273:58: note: directive argument in the range [0, 65535]
>    273 |         snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u",
>        |                                                          ^~~~~~
> drivers/gpu/drm/i915/intel_memory_region.c:273:9: note: ‘snprintf’ output between 7 and 19 bytes into a destination of size 16
>    273 |         snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u",
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    274 |                  intel_memory_type_str(type), instance);
>        |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> 
> This is unlikely to be the right fix, but sending a wrong patch is
> usually a better way to elicit a response than just sending a bug
> report.
> 
>   drivers/gpu/drm/i915/intel_memory_region.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_memory_region.c b/drivers/gpu/drm/i915/intel_memory_region.c
> index 59bd603e6deb..ad4afcf0c58a 100644
> --- a/drivers/gpu/drm/i915/intel_memory_region.c
> +++ b/drivers/gpu/drm/i915/intel_memory_region.c
> @@ -271,7 +271,7 @@ intel_memory_region_create(struct drm_i915_private *i915,
>   	mem->instance = instance;
>   
>   	snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u",
> -		 intel_memory_type_str(type), instance);
> +		 intel_memory_type_str(type), instance % 100);
It's a theoretical issue only since there is no hardware with a double 
digit number of instances.

But I guess much prettier fix would be to simply grow the buffer.

Also, hm, how come gcc does not find the mem->name vsnprintf from 
intel_memory_region_set_name?

Regards,

Tvrtko

>   
>   	mutex_init(&mem->objects.lock);
>   	INIT_LIST_HEAD(&mem->objects.list);


