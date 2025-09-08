Return-Path: <linux-kernel+bounces-805362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41187B487A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A097188936E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE52E174B;
	Mon,  8 Sep 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG4uvJLc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52BF510
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321726; cv=none; b=DfWb/e8z1XrQQWgbAB0cCbabdFcSD/Sg1lvFjcqsreqxeX6uYjcomRN62dK2LrYdzilZg5k32+wC78B0po5hYPqBXi2l4tXXfVNP0wBjiAi8oLYqeZbMmWCrgy5APvmRhB/pf7AGAgCzpAG29KDhzAQmXeGd7uO6vsvDIzvUgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321726; c=relaxed/simple;
	bh=HTUGQUIT+y0NFtRHW7IDPo1ua534JkKx8LjTvVVYLGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQg4sJu5SpMDTAdHZ2dy5rOtXgzAUGgjVqUXo/ZYn06yrO9vFQrmJvTYL1i3FPVkP9kewB24pLMaolSc1RViI2v8wNhnd2qAycUdCRYsNPGQkVF+dmAlpk0DslUyFuhinFLEgs8o3dZwpEDJUv2Pxnp4pEM7Dtcbw50FetPJcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG4uvJLc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757321723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNfR+0QhjgvaYk/b7nG+gvPpjX04LiJCblG/QpBq/XQ=;
	b=OG4uvJLcBFHEP2lhcc2lUF8h7mToLJYH4ygkQ0TNqBnCcOoBYhfdhjTSNZUV2oegJ3Z0rV
	Xr1J4GujPEAkrsWOPhAQ1234/x4+qj46o/s9HT1GUqkSKRZWUa5Dzp/md2P/E/5VtHewWZ
	NMNv+Fhyu9qk9XhLRjs4Y5muagtgQaM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-RN-SwWVFPV6xuysW1q-lRQ-1; Mon, 08 Sep 2025 04:55:20 -0400
X-MC-Unique: RN-SwWVFPV6xuysW1q-lRQ-1
X-Mimecast-MFC-AGG-ID: RN-SwWVFPV6xuysW1q-lRQ_1757321720
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b920e0c25so31906045e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757321719; x=1757926519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNfR+0QhjgvaYk/b7nG+gvPpjX04LiJCblG/QpBq/XQ=;
        b=SK8JZes0ABVf+0IVZO7YU7pI9JJkW6eR8VbCcRpx0vklm1HI9ZTb7M5LmFZC4fU2V7
         gOl8dk4sTwemFAyNrz43QxjWY5yKJYo5l5/387+4x7tsCsI8s8z+kbCfsU+7V1TMJhkJ
         7t9eIitITfRgI8NHFvl05bGVC1SXri+jplbvntfApOMaJI0r+2IXN9JIaJhM3XjF8EaQ
         5a9NZ+NJYu/y/wLDr7KIOGyzdK26zJVf9X3sib5ZMuAIlvvjgU6T/+zGH/3BFh8XilDH
         48ABM8olUX03ZudKCCMptkBXDrv5jQ8NZWcTR9RholUXim2n+74C/HxQGqA6YIbGOo9q
         VmCw==
X-Forwarded-Encrypted: i=1; AJvYcCX8WDK3aRbRLIk3m4CQlguRvpRiO4Xwc8YTdbAqMRCN5HXovBdidK0PXveN/m3NyEutABwmSxqSFtfBYEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdxHrltor9SXjMwQ2w21reAz2QhCj3dWW6K6Aam8biZA+xahJ1
	rGTDcve0xfJV+rpJZCSxZlU4Ia8+5eUO1r41vOEYopsovzL808FGaQP96Jsc4ec/jCjITaOFxck
	csuH97/MrSMVFvJnQ66l+AJ13Grpu7LPe4SSc9cU5mJMA+vwawOvvl8+QePZ53VsX6Q==
X-Gm-Gg: ASbGnctp0lA5YyJlpXWh7JhqAV9P5jjoEfQ4wMhD2yE4Cz0uGZ0+4rAL0LYahaB+AWa
	G0B1Xt1vYZcsaW29dl9r53ulpiHXpA6MEJXc+PBVr5dmeUSPQKxM3N+TWEWZJHNWfT0wUJGHPoA
	caW8nmfYe9bQNpWKP2deQB6yRXFd6evlULJZmvVeGi3026B+6TaJuX8yndfvBc6qax5XbkUWU5S
	EkRkBhXO66T50uptBkcZwcPxh7JvIHWXnqXM7X9uKTLNlpXCtQRZkzdcninyez+wvVD7TydqHV5
	LvEy37iZu3g2VPgnOFs5LYVyXUN7SSAekdO0QEaRZsWeKVvseevF9daj59QFfGFF8cav8h1iXF9
	8arg=
X-Received: by 2002:a05:600c:46ca:b0:45d:d197:fecf with SMTP id 5b1f17b1804b1-45ddde31722mr59274775e9.0.1757321719486;
        Mon, 08 Sep 2025 01:55:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6XSLL6N3kyaYsfSJrygSaFMVrRxBumfGrLU36La1GPURRAo/SfoPxGhuX7H1KyprlrrFQTw==
X-Received: by 2002:a05:600c:46ca:b0:45d:d197:fecf with SMTP id 5b1f17b1804b1-45ddde31722mr59274465e9.0.1757321718972;
        Mon, 08 Sep 2025 01:55:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de229238fsm67095045e9.16.2025.09.08.01.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:55:18 -0700 (PDT)
Message-ID: <a8af8630-043f-4bdf-af77-8f02f992f221@redhat.com>
Date: Mon, 8 Sep 2025 10:55:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/panic: Add a kconfig option to dump kunits
 results to png
To: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250821095228.648156-1-jfalempe@redhat.com>
 <20250821095228.648156-4-jfalempe@redhat.com>
 <923276d2-9240-48bd-95df-13b4e9e23dcd@suse.de>
 <7ff51c5b-939e-47d9-8c3b-3c596565d114@redhat.com>
 <pucvcimuuyz7f7ih7hx7l6bmutarlryvzwiqh7a26bk65ya5sf@uj7agoqm4lm3>
 <533c2197-d7bb-4294-a094-c4f993a5893c@redhat.com>
 <20250903-benevolent-boobook-of-wholeness-e631f9@penduick>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250903-benevolent-boobook-of-wholeness-e631f9@penduick>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2025 10:19, Maxime Ripard wrote:
> On Wed, Sep 03, 2025 at 09:30:23AM +0200, Jocelyn Falempe wrote:
>> On 02/09/2025 18:58, Maxime Ripard wrote:
>>> On Mon, Sep 01, 2025 at 03:04:26PM +0200, Jocelyn Falempe wrote:
>>>> On 27/08/2025 12:45, Thomas Zimmermann wrote:
>>>>> Hi
>>>>>
>>>>> Am 21.08.25 um 11:49 schrieb Jocelyn Falempe:
>>>>>> This is a bit hacky, but very handy if you want to customize the
>>>>>> panic screen.
>>>>>> It allows to dump the generated images to the logs, and then a python
>>>>>> script can convert it to .png files. It makes it easy to check how
>>>>>> the panic screen will look on different resolutions, without having
>>>>>> to crash a VM.
>>>>>> To not pollute the logs, it uses a monochrome framebuffer, compress
>>>>>> it with zlib, and base64 encode it.
>>>>>
>>>>> May I suggest to export the raw image via debugfs? Debugfs can also
>>>>> export additional information in additional files, such as width/height/
>>>>> stride/format. This could provide the real/last image on the fly, simply
>>>>> by reading the files. No workarounds or encodings needed.
>>>>
>>>> I'm looking into that. The difficulty is to get the debugfs content outside
>>>> of the test kernel. As I'm using a uml kernel for testing, I will need a
>>>> special initrd, and a way to share files with the host.
>>>
>>> Yeah, I agree that it's not very practical. If only because the test
>>> context doesn't stick around once it's been executed, so you would
>>> effectively leak an arbritrarily long buffer with no hope of getting
>>> back its memory.
>>
>> I've made a prototype with debugfs, a small ramdisk with busybox, and using
>> hostfs to mount the host filesystem in the uml kernel, and it allows to dump
>> the raw panic buffer easily.
>> Even if it's a bit more complex to setup, I think this use case is not
>> really a kunit test, so it's probably better that way.
>>
>> Let me a few days to clean that up, and I will send a v2 of the kunit tests,
>> and a new series to add a debugfs interface.
>>
>> Thanks for your reviews,
> 
> We also have to think about how it's going to be shipped and used. If
> your debugfs integration has to be disabled everytime we're running
> kunit through uml, qemu, and in CI (because we can't retrieve the
> result), on a live system (because it would leak memory indefinitely),
> how is it useful?

There is already a kconfig for this:
CONFIG_DRM_PANIC_DEBUG

Also I have an implementation that doesn't leak memory. (memory is freed 
when the debugfs file is closed).
It's also more flexible, as you can change the parameters, and test any 
color format, and check the binary result.

I think the goal of this is not to test for regression, but to help 
building a new panic screen.

> 
> The diagnostic lines are part of the test result, are in the logs, and
> can be distributed. You're having all those problems solved already,
> without having any additional work to do.

I feel sending an image through log is not really efficient, and I don't 
want to pollute all the CI with that.
I will send the v2 soon.

Best regards,

-- 

Jocelyn

> 
> Maxime


