Return-Path: <linux-kernel+bounces-807513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29392B4A567
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D963C3A6F9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8714024E4A8;
	Tue,  9 Sep 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3IE4ixO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE122157F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406921; cv=none; b=Fv1hEicsk+WC7dK3PxKPu3q/yPLkmyYGM+ooJgMVEatOivqRe7YuXU1CKo5T2P2Z3SioOYzaNZvsboxMoPnK4J8hNxWsGodUVTmUnNXKjrs4ua+MbaD8K+pj894tNNizm6CGi3zy3bGknUw0NmGbtzuuXFw1Oe1g3C6K1J7hRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406921; c=relaxed/simple;
	bh=Fbiomid3/YmW4c7Zwki1raFurjyXRf7OORItt8JEWq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQmS8iZfWIbV61onUBl93d9eYbmuNzn1Clzhm+963Lj68ee1Rk6ZeqrfnszetTH5+KDwUjXY/cPi8FFBDWZOsPjMn0yc/ZwysDrgSJ/amVzWuk2UiOpzcBb+1e5OPCd+6OXQUMvEysryLpux3FlzdIlCMTYljCEUv+pb/nAcbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3IE4ixO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757406918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRwU3Tf4e9BAn16grpDelyCP6SF+f+tK6tH4I4H1cTI=;
	b=a3IE4ixOc8xOGiqJtp1x+Ls8DKsyxB9elwUwIVtE3YeyqAeKLHIaFDQ3OwgMuX4ZX1i86G
	sJve1CmDWVmavwNi4GuluG+Sa+HJJoMlzoWfnfLVhNHzNJafyDuzv3U/smqte+E4g/Dx4C
	MiVxUNF9zuQ5oBrw1JBj1gU2floTEgU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-qrFqtV-bNrOnRA27QWPurA-1; Tue, 09 Sep 2025 04:35:17 -0400
X-MC-Unique: qrFqtV-bNrOnRA27QWPurA-1
X-Mimecast-MFC-AGG-ID: qrFqtV-bNrOnRA27QWPurA_1757406916
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45d6c770066so27414945e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757406916; x=1758011716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRwU3Tf4e9BAn16grpDelyCP6SF+f+tK6tH4I4H1cTI=;
        b=rPR1RtQM3xeb+f7ud3PzwTPbNJsxTtv/j0ukHxluA/Y2JKxghpjNuWyA+lbK5Z+6Q6
         PBbhPP4w5jwr1BQcTz4/vm2QjeqqPWF5cjENHLlp1cBOsyd7E/eUfylI+iXS2yOFvLGk
         Kresrn0tx+H6ux+8X0aK6K3bgt4R3LBraXlqej2IKF2I6wAMUhYB4TcI2r1jzn1p1HPN
         dTuC9KxUG/pnH5gPNCmrPtEAoa8HdB78EfAHX0WMxFwaGFn670BGHIsCq1c7b/s9ZgDB
         MZCcAN8EZbiZirolcbTRu0+zhz/q/Sa8n6gCrJjOjkpgeH5Z4a03oLCmLlYjEYyW366O
         pN/g==
X-Forwarded-Encrypted: i=1; AJvYcCXiuREHAchtb7TLc2sd221unVh/DrJTUyFTx9Q86Mni9oA6BgpMf6mqA0EjUO3bRykWoTjjWJSJ6+3ucDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4pXf3j7QA4yPF5xKqVOgI/VTKT0C97GP1yum83tjcWGSDQfR
	0lX+4fW1B2qB1LN4DRcHtogkwpFUESoYWUbMfG+WmcLspXHfyoCPR1SL/RP69drG1jMMz9XzHtM
	yNL2nBzKBLAuYiNcKffywsM+va4eulx8D6GaLxef/HnqzKYRBu2OMiNpKB3Fqlzpc0w==
X-Gm-Gg: ASbGncut2flqs6E/Z3DebbEPTKIK1KCdCeKbk7LEhvCcHF2GsVRGg9869lh5IEYDJMU
	s2/PMmipRmg/QmXC3+YGAnXQZxyIhVS+CCRXIgHXW6RKVU7u9z/sJjdaEXlMurQjpsleXMXXIJx
	cfUz5PlI250ofkg+JixMrLyvyxjWjWNd5HFHi3gfSf0igtw2fPPQlg0YCEPD3N/Ltkzsv8d4trg
	ZXQKmCawejqJ7abh3AP/A/eA2WNAkJa3Dp/DDEVeUn+KGNmYjkdViDuNXFj6NyyTHgl726+wP2W
	G5vlWElq1Kky7JuHLZM0aOXTeRTqafkT9O9j6rHNmykTTiH3cgtL8QdKojz6KDouoX2ZJCgB4Ai
	oN24=
X-Received: by 2002:a05:600c:4f47:b0:45d:d903:beea with SMTP id 5b1f17b1804b1-45dec7992demr28468475e9.30.1757406915605;
        Tue, 09 Sep 2025 01:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUazJCUacJXQ6oBlfOIRmN1i8Vqv0hg7TTzbVGz98N/lGvO+upxJKi/IvXMF/CIovMGN8ywg==
X-Received: by 2002:a05:600c:4f47:b0:45d:d903:beea with SMTP id 5b1f17b1804b1-45dec7992demr28468065e9.30.1757406914960;
        Tue, 09 Sep 2025 01:35:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df026aa13sm5942365e9.4.2025.09.09.01.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:35:13 -0700 (PDT)
Message-ID: <d24559ab-9ab1-48cf-9621-05ab7af009ee@redhat.com>
Date: Tue, 9 Sep 2025 10:35:12 +0200
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
 <a8af8630-043f-4bdf-af77-8f02f992f221@redhat.com>
 <20250909-terrestrial-straight-piculet-c43bd6@houat>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250909-terrestrial-straight-piculet-c43bd6@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2025 10:01, Maxime Ripard wrote:
> On Mon, Sep 08, 2025 at 10:55:17AM +0200, Jocelyn Falempe wrote:
>> On 03/09/2025 10:19, Maxime Ripard wrote:
>>> On Wed, Sep 03, 2025 at 09:30:23AM +0200, Jocelyn Falempe wrote:
>>>> On 02/09/2025 18:58, Maxime Ripard wrote:
>>>>> On Mon, Sep 01, 2025 at 03:04:26PM +0200, Jocelyn Falempe wrote:
>>>>>> On 27/08/2025 12:45, Thomas Zimmermann wrote:
>>>>>>> Hi
>>>>>>>
>>>>>>> Am 21.08.25 um 11:49 schrieb Jocelyn Falempe:
>>>>>>>> This is a bit hacky, but very handy if you want to customize the
>>>>>>>> panic screen.
>>>>>>>> It allows to dump the generated images to the logs, and then a python
>>>>>>>> script can convert it to .png files. It makes it easy to check how
>>>>>>>> the panic screen will look on different resolutions, without having
>>>>>>>> to crash a VM.
>>>>>>>> To not pollute the logs, it uses a monochrome framebuffer, compress
>>>>>>>> it with zlib, and base64 encode it.
>>>>>>>
>>>>>>> May I suggest to export the raw image via debugfs? Debugfs can also
>>>>>>> export additional information in additional files, such as width/height/
>>>>>>> stride/format. This could provide the real/last image on the fly, simply
>>>>>>> by reading the files. No workarounds or encodings needed.
>>>>>>
>>>>>> I'm looking into that. The difficulty is to get the debugfs content outside
>>>>>> of the test kernel. As I'm using a uml kernel for testing, I will need a
>>>>>> special initrd, and a way to share files with the host.
>>>>>
>>>>> Yeah, I agree that it's not very practical. If only because the test
>>>>> context doesn't stick around once it's been executed, so you would
>>>>> effectively leak an arbritrarily long buffer with no hope of getting
>>>>> back its memory.
>>>>
>>>> I've made a prototype with debugfs, a small ramdisk with busybox, and using
>>>> hostfs to mount the host filesystem in the uml kernel, and it allows to dump
>>>> the raw panic buffer easily.
>>>> Even if it's a bit more complex to setup, I think this use case is not
>>>> really a kunit test, so it's probably better that way.
>>>>
>>>> Let me a few days to clean that up, and I will send a v2 of the kunit tests,
>>>> and a new series to add a debugfs interface.
>>>>
>>>> Thanks for your reviews,
>>>
>>> We also have to think about how it's going to be shipped and used. If
>>> your debugfs integration has to be disabled everytime we're running
>>> kunit through uml, qemu, and in CI (because we can't retrieve the
>>> result), on a live system (because it would leak memory indefinitely),
>>> how is it useful?
>>
>> There is already a kconfig for this:
>> CONFIG_DRM_PANIC_DEBUG
>>
>> Also I have an implementation that doesn't leak memory. (memory is freed
>> when the debugfs file is closed).
> 
> So, if userspace completely ignores it, you still leak it.

I think we should discuss that on the v2 I sent yesterday.
But basically memory is allocated when the debugfs file is written, and 
freed when the file is closed.

So if userspace ignores it, no memory is allocated, nothing happens.
The drawback is you can't do:
echo 1024x768:XR24 > /sys/kernel/debug/drm_panic/draw_test
cat /sys/kernel/debug/drm_panic/draw_test > panic_screen.raw

You need to keep the file opened in bash between write and read:

cd /sys/kernel/debug/drm_panic/
exec 3<> draw_test
echo 1024x768:XR24 >&3
cat <&3 > ~/panic_screen.raw
exec 3<&-

I hope that clarify things.

-- 

Jocelyn
> 
>> It's also more flexible, as you can change the parameters, and test any
>> color format, and check the binary result.
>>
>> I think the goal of this is not to test for regression, but to help building
>> a new panic screen.
>>
>>>
>>> The diagnostic lines are part of the test result, are in the logs, and
>>> can be distributed. You're having all those problems solved already,
>>> without having any additional work to do.
>>
>> I feel sending an image through log is not really efficient, and I don't
>> want to pollute all the CI with that.
> 
> Then maybe we should just ignore that part of your series for now. But
> having a framebuffer lingering around in the system is a no-go for me.
> 
> Maxime


