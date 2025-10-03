Return-Path: <linux-kernel+bounces-841432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 382BDBB74BE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 286984E5050
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5B285CB9;
	Fri,  3 Oct 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgnHF2AM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241482853F3
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759504516; cv=none; b=FSrQC2S4An2KP7G2LdeRoatNX9CRHM/ytQzGjq1150UBYd3/Av00mRJL5MGtsfYmBCLjZGw+FE2ksc4B/pWAsOZQJaOASfxy/cpG/C7ceeTVJhessaWLspoeTKlB11LtFbGcsU3/6whX605y7VivDTQinec0zWOgodDY/ea6wu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759504516; c=relaxed/simple;
	bh=vjTnMYgKEWlYDyGcZcrvZ+lDVpo9/FQDnitCcJ6Wb2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7B7xxuUsYXP3zO+Ywlcxy1pSf5QdsBYy3opBSm/0VdY8ajguCnUOV/Vkwyr7XZNTncJFyzlohjXxKeJxIvFwCrA55/hDPgoMLHJCPwLirS1BCKWfCeEoCMegfwToCZhi5Q8m1AIIjC0VPKbD4PM3qaGs49RMHeKY53H2mbIUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgnHF2AM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759504514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfo/6tGmvIxa8VbfOOXLsx8Rp2oR2UqVT/QEdSKhdQY=;
	b=WgnHF2AMWsPNrLY1940eoVt2/7OjColZwsnuzyC0Ql8uFWY4WrnpAqeQM0oy0AuB9cXiTH
	/a0jYkAu7MYKZ9q1REK6fDqUayziLVm3NOLA0fDAw5ouWYM9MQf3++w1PrufMgALuM9tv2
	RRayJqPYDwITw0pOqyu+/0JWtOpBnQg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-JcznnnaGMDKBQZ4CDq_m1Q-1; Fri, 03 Oct 2025 11:15:12 -0400
X-MC-Unique: JcznnnaGMDKBQZ4CDq_m1Q-1
X-Mimecast-MFC-AGG-ID: JcznnnaGMDKBQZ4CDq_m1Q_1759504511
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece14b9231so1143961f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759504511; x=1760109311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfo/6tGmvIxa8VbfOOXLsx8Rp2oR2UqVT/QEdSKhdQY=;
        b=ZFIL/xBt52YF/DBMNpEIgkWgsLKy1uFq/zKlOrrrZM8HmvvuOAI7szGBjFD/jzmrWt
         6B3Mr6AKvT2DcRkdOwoBdBiVvdAWmDqU0VIvoMuSo6RFRrH+ys/sY57TkHixGDkPaY72
         cKnaYNb+BgjXs3ZPPtXf8BlLwD0DZH+bjwXMk657tQeuh85liw7fm+uupT4TVL12r25T
         QF4V3JbN8wh6SsZ1XV6MPyRmT5j00qX7gRAg65M4lr/fpV8LMiipWgQ+leXqMH8SIGZB
         ubxEOyzPxdYIgVdXpvUGnxEbJB/HcocY+UAJ0bitYJB8ZtNQ8zmUwwobvOTazoSN7JBi
         3ioA==
X-Forwarded-Encrypted: i=1; AJvYcCXwnNbRJbZnfaBMUNlhiarPC6i+GjQyDaEH0HLccEhcVXpGsHu39fFmF7uIXpOY6AdRiqF407NyGU/4xZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfZTtELN2m1dLnbUx23Lc3BkEtIB+gvlv8rtBOlfRJBYqOsKR
	ViD1DGQF4DL7KiV9Op04yHHIpI8AaeVtQl/4LLsA4V0bT8k+u2WgpDTga1+217yG6vyq3qz5fja
	Ifj2z2CT2q4oigyVbgpchaoLrSpGDCF+wFVlDkAXUxCm3S3lywjImDwD3vkqhzNVHqg==
X-Gm-Gg: ASbGncskwrgBv75OQPhOzGig2/PgvVtcGusB+bL3lf+iCwRi/7Qsyev9qOHvaTByUTC
	KXa2ZXzDPPZFk6lURGeg3mIV8Nkj6kVx3EonnD6X1wHDCo314Vch/JWplbMnAxhv5HW0w0CN3kG
	o+riyBW5tePA6q8M2PpZSnOb8CIYPyDUfQMhrIHGooQhEOJ//Sf0tDNC0Cz8qH9nLDe0QaO5/jo
	7uVapXYgs3Og34M/CjNW/nMpqHXU9DFPHhpEpl1au97Rho/5bUDxTGDnxFyey6yw7VAc6IZyd1c
	ohnjuK4vd0+B14RPOrLa9TuZ61QpMa4NvKoFf7ZlcyvcSVJZC5RLXoON/u0GdrcdwZbdXTgWp43
	VIS20+nt0mg==
X-Received: by 2002:a05:6000:2c11:b0:3ec:d7c4:25b6 with SMTP id ffacd0b85a97d-4256713ff18mr2417448f8f.27.1759504511184;
        Fri, 03 Oct 2025 08:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtcnJtekHtQnXXJ9a+FzvQt/8qV7u7ycDIkPqz1URBrVhUei9CSCYg8V6xT96qeWh50+z2Jw==
X-Received: by 2002:a05:6000:2c11:b0:3ec:d7c4:25b6 with SMTP id ffacd0b85a97d-4256713ff18mr2417418f8f.27.1759504510819;
        Fri, 03 Oct 2025 08:15:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a4161bsm143036495e9.16.2025.10.03.08.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 08:15:10 -0700 (PDT)
Message-ID: <7a6eba4c-0d24-47c2-92ad-f63116d45a69@redhat.com>
Date: Fri, 3 Oct 2025 17:15:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/draw: fix color truncation in drm_draw_fill24
To: Francesco Valla <francesco@valla.it>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251003-drm_draw_fill24_fix-v1-1-8fb7c1c2a893@valla.it>
 <70cbbf88-7c1e-44f4-8091-ee76944d2f6b@redhat.com>
 <3881844.vuYhMxLoTh@fedora-2.fritz.box>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <3881844.vuYhMxLoTh@fedora-2.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 16:41, Francesco Valla wrote:
> Hi Jocelyn,
> 
> On Friday, 3 October 2025 at 14:48:03 Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> On 10/3/25 12:33, Francesco Valla wrote:
>>> The color parameter passed to drm_draw_fill24() was truncated to 16
>>> bits, leading to an incorrect color drawn to the target iosys_map.
>>> Fix this behavior, widening the parameter to 32 bits.
>>>
>> Oh, you're right, my mistake.
>> Did you find this by using a 24bit hardware, or by looking at the code?
>>
>> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
>>
>> Best regards,
>>
> 
> I am working on a graphical splash DRM client (which I hope I'll be
> able to post soon) and testing it on a Beagleplay - which is
> RG24-capable - I started to see a strange behavior with non-black
> colors. After some investigation I found the cuplrit, and strangely
> enough it wasn't me this time.

Thanks, I was wondering if this 24bit code would see a real usage, so it 
looks like this is still a thing in 2025.

Best regards,

-- 

Jocelyn

> 
> Best regards,
> 
> Francesco
> 
> 
> 
> 
> 
> 



