Return-Path: <linux-kernel+bounces-797879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4229B41698
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B06163249
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE9B2DCBF3;
	Wed,  3 Sep 2025 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpaHD6s3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112982DAFC8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884634; cv=none; b=Oo8n4WLHM3PV2CGu5WlpLfVmWN9bbBKX4TOEFCBbkmc0TOUtzWuAnBGmKCBVaWYwF3g/STmJ3THmNwn9QxyQbx5DXmWS+aJk2qcNCVKk/tDuYpj3GMtmPHsA5t+GUZhn4/yMzQRj5b8NXdoFtajqBJPGwjfK90IeB9D4rLLcq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884634; c=relaxed/simple;
	bh=NT/1Mvekt5OW8mhwxSo+mm9jCZ729mSljswE3eNX1qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kki+vapCa4i8taERL4fUsLXdsImuMAa1T968Q2FJdsQWH93Pzt41BkujcvL9k2ZC4qU3HD8MIVuj0fjSX/EcC5BGL8jETbAuRFGLnAyt8g7kB60jxmwL2AsC7y/k+ZEhwIM+5nMDHI+eEjNIyQHUswHSa7+AznA1B/yA77J8lp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpaHD6s3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756884631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXmaQRePHfDReiwofqlEfi0BOpZUaSKRj4v6EH2Y820=;
	b=FpaHD6s3pNqWbieyGUHR1trg22CWqwvJT+2n/5QWbZkSeyQr9uRsCvDBl/XpQaTuFG8qx3
	XT50JV+p7G0ejsQR4t1TiASANl4CMMcwOuhY173wy6cBjdW6kneCj6cIQo8aO4KphWeRoR
	O1VqGXHNmowYPVVaDBjOLyF3I6X6Cxc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-VhMYghezOayu7MobRyjj3w-1; Wed, 03 Sep 2025 03:30:26 -0400
X-MC-Unique: VhMYghezOayu7MobRyjj3w-1
X-Mimecast-MFC-AGG-ID: VhMYghezOayu7MobRyjj3w_1756884626
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b467f5173so56349645e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756884625; x=1757489425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXmaQRePHfDReiwofqlEfi0BOpZUaSKRj4v6EH2Y820=;
        b=oAQxw2kJC/qd+TCew1k7OhQ1iw5ciIAAxoKmUPKzYe7HzANE4R1dDCZeKiqIz4zT56
         OaYzRMMbNWtT10dAXGC88uMsvpvs6G+Y+/2EVQiYKsRsaBWfi2r/jOdBqoLXELPxk+kJ
         l5z5MsBYyZj7Q4VNYds/Qu2F8xd+YyMS1kB/Z15E/F4nKEN3pyciAyCjSMK7GwM7hq40
         W4DOT+EbVUXjo7C/3vKZsr7jJLGaSD/MQyCRgNYje+3sazZTLeml2AnwwWMEjcbWRI7K
         cNzFAzShWFDKgs8RISfB0CLQKppeK0IKw5v5Zy+ONdoBphfyIiSK7jZ/n8adjF2o6ONx
         2gzA==
X-Forwarded-Encrypted: i=1; AJvYcCWEUKPuxuaAdMU37V67vy0sTJ+PGBdlLsFVOVD2OIE2NEg8F1rEdkpVtUNP0xkSM7ne8r91BtIAuyvjsDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ooMif+v78tzSF3Lyl++xckqWic1eG0+cSs8mXwL+nGzE3MLp
	TX0LTvzISz0oG//WKyKTsysb2O8w4jMWIpvA/2XlRCNj3nJkPDEL8vMgUxytjWXXRlty1r218ht
	W52m0j9+uCnt8YmAjHoqiPZxHzUy1v3azcGF6qjgpCeAQmrq/0zURFjjzP90zqds2lQ==
X-Gm-Gg: ASbGncvSSkSOEE/BntGqkr4rR7teqLVi0ENsfntN2dR1PxH28+RfKFMskGkwPqFgMin
	nJZQxMzNHMK09pPeIE/M/0JGqVzFz3CgEwR86tZosG2IW3syaKy+pedvBIwzSLJQSysf1W0ys38
	+5qQ624NJTwAbZEWyYBHW34LPHnIdAYfxlas70+dcPs8+bGSWYoPXh6m47LLke9jGR3PBCu2cQD
	Q8GGR2/urbk1YMg3vk1Hm1p+4SVGB2qeZhzuiKhiVgOk4WHCY/Ram1N/+YZBpjXYKb0RWi2JGA+
	19ki2zAIKJpk+GRCmS2cI3iDaK0n9am0lTK+LXpQCHZClDwobSTjPN72dvdLn7EGJ2owCdZYCy7
	be2Y=
X-Received: by 2002:a05:600c:1914:b0:45b:8ac2:9759 with SMTP id 5b1f17b1804b1-45b8ac29906mr91627895e9.23.1756884625597;
        Wed, 03 Sep 2025 00:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaVr+3Y4NDc+K+0OyYUG0bUKRoYgq+8faNbeSCpPYw+Mg8KIRDjAtneuQoDPGA1D39j0MUBQ==
X-Received: by 2002:a05:600c:1914:b0:45b:8ac2:9759 with SMTP id 5b1f17b1804b1-45b8ac29906mr91627565e9.23.1756884625164;
        Wed, 03 Sep 2025 00:30:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66bbcf19sm183497005e9.4.2025.09.03.00.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:30:24 -0700 (PDT)
Message-ID: <533c2197-d7bb-4294-a094-c4f993a5893c@redhat.com>
Date: Wed, 3 Sep 2025 09:30:23 +0200
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
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <pucvcimuuyz7f7ih7hx7l6bmutarlryvzwiqh7a26bk65ya5sf@uj7agoqm4lm3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2025 18:58, Maxime Ripard wrote:
> On Mon, Sep 01, 2025 at 03:04:26PM +0200, Jocelyn Falempe wrote:
>> On 27/08/2025 12:45, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 21.08.25 um 11:49 schrieb Jocelyn Falempe:
>>>> This is a bit hacky, but very handy if you want to customize the
>>>> panic screen.
>>>> It allows to dump the generated images to the logs, and then a python
>>>> script can convert it to .png files. It makes it easy to check how
>>>> the panic screen will look on different resolutions, without having
>>>> to crash a VM.
>>>> To not pollute the logs, it uses a monochrome framebuffer, compress
>>>> it with zlib, and base64 encode it.
>>>
>>> May I suggest to export the raw image via debugfs? Debugfs can also
>>> export additional information in additional files, such as width/height/
>>> stride/format. This could provide the real/last image on the fly, simply
>>> by reading the files. No workarounds or encodings needed.
>>
>> I'm looking into that. The difficulty is to get the debugfs content outside
>> of the test kernel. As I'm using a uml kernel for testing, I will need a
>> special initrd, and a way to share files with the host.
> 
> Yeah, I agree that it's not very practical. If only because the test
> context doesn't stick around once it's been executed, so you would
> effectively leak an arbritrarily long buffer with no hope of getting
> back its memory.

I've made a prototype with debugfs, a small ramdisk with busybox, and 
using hostfs to mount the host filesystem in the uml kernel, and it 
allows to dump the raw panic buffer easily.
Even if it's a bit more complex to setup, I think this use case is not 
really a kunit test, so it's probably better that way.

Let me a few days to clean that up, and I will send a v2 of the kunit 
tests, and a new series to add a debugfs interface.

Thanks for your reviews,

-- 

Jocelyn

> 
> Maxime


