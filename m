Return-Path: <linux-kernel+bounces-810487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA4B51B53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD4718999EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68B824DCFD;
	Wed, 10 Sep 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGx9rSCT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDA24A04A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517417; cv=none; b=JBZe/tnywaLD+JLYR7Vh4FkuHEULDA16B9lRF6BB1i/Eu4InOCL/8LFTp8if/xKEgS3gn0Z6Z7XT1ghyi7gFxCvuGGhar2bi86+iHlAdKVaDu258e9AOts7xDynbaD2IvRVqGldysAR/a15PiVkloO27l+CF2faeuCRcdZaT9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517417; c=relaxed/simple;
	bh=bCaWrOOv19v551VomOnMCJOunrRGUciE5BBsfEaEedE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPY1QeFvGpn9mX9fRuJS4ga6Jl+Rhlr8PPMAWZ99dXr0DninjpuCB1U1nzgErNXlEQuRlk/kwNq4GZh+FGDxXdpKdCuNbbe8hQ4EH1U6N11g63vT2Js3yP4Ch9mrCl1hMYNspYur+sHrpgG8oZeqD/mrYtomsnsXmnOSOEJUq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGx9rSCT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757517414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTaDACB4l26rOSYcf8BPat/9VEf+Ju7nr9jru3/iH8o=;
	b=OGx9rSCTbRIxWZrQ+pbk+ssZIlHShJC7QlT9LxeR6BdRKQkQmpp6ZTVZiq5IYc4hDdQzB/
	i0RyxzUWN4NGVJZCOfz7GXYkdpoXBrO+VNkEXLJVDhOqUyO/Yq7Qt6/0WbUu5R1u25I7Uy
	aAtYl+DRdD1AvhI/3QLvjerWe5oZXso=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-d8BUdNmMPy-KXGbfXssXpQ-1; Wed, 10 Sep 2025 11:16:53 -0400
X-MC-Unique: d8BUdNmMPy-KXGbfXssXpQ-1
X-Mimecast-MFC-AGG-ID: d8BUdNmMPy-KXGbfXssXpQ_1757517412
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45cb612d362so39302655e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757517412; x=1758122212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTaDACB4l26rOSYcf8BPat/9VEf+Ju7nr9jru3/iH8o=;
        b=QMZ7k6tMRzZk/YFN0UQvMRpko9otTWl8o8XgRZpBe9QbnLyF2Cyh9GjsrSW9LwWK+O
         q3hT3YzL/tAicbRX9u8xtEw6giw7V/YwfLfD2XaZuSOuVrCDyUd4iejH28+4llN6P9/W
         l9LqyS0EhBzFpfUUgLY2vaE/7+Uag6BhvcNgWGK+fmw6T//mMDVvqluqy7RJ4Kbs+Y75
         H63TpPlCdhdIR8oN7qOrY4tNpSa4aa+x8XePWHwQbpx3mmZfKN6pViw+Hosw1Ia6FCFr
         BMNC4LcuUSgjbufds1QZK1tV+svnOo6fvYjKOuzX4W+tqFjR3pvPqgXPm7SR23aKXLNO
         fbdg==
X-Forwarded-Encrypted: i=1; AJvYcCXnkR6J4v4nSlrk3R0ZA+7GKYE5wYrHyd/rlNqLBvtUCLnjKWHFAWjAMAStYT/3HtitNWyMZNGHWFfVu3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBAndmc48q1Y1dF8pT47Hh8Du9nE6+6lX914f8NLOmxM2lJvB
	NfDLRsIKpCqlGKMYbpkHvWbfzGPa/tevsbK6clRXhMqaj6i+YcPWqWPur235gjY3qdqPSKWIsrq
	WjkjDFdsFqt77W4Z24wEbcW1cxxm75jpf5avCzAphrG9KNCKpCyFGi4YO/ocge2Pq5Q==
X-Gm-Gg: ASbGncusyOVJAraALnpISlyajXyMysleQWn7Epyp2P10he7s7kXR6iAFxmnx0iI1lPK
	bLv60CPaCna5E1LXwzUOSSZxpKb/DK6nCHW9TGHbYBIMyDY2p8ATdfAP0T61IhVJLWLHqR8RTsx
	nH47lY0fEnfHqlS1ER2we5hdnUSmVvAZ8DXSDKhuCHsAPRSXomzyYSK2iUUnqRGQ3rVvbxE5VCJ
	Jx2DAEr7OHsR+C9AzVq9lnoMHb5TuDtYj7r/CKOTIvKaT5NY3f5QGbftw0rEyMU5DtTiTAoZs7f
	MMSMrZXO9SP747O/z57zSy2luevR0KMjO/eKLk4+yt9LaXL+dXwvo/gLZBE9fYNMakhbAJVlDZp
	7vsY=
X-Received: by 2002:a05:600c:1e8c:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-45dddef01e4mr122798625e9.27.1757517412076;
        Wed, 10 Sep 2025 08:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzhtY65zo214jeKk3uc6/bfpYCHiRF7m/w5yM+4Thwc9xD9ARqamRIoJw8cuMXHSIAD8repQ==
X-Received: by 2002:a05:600c:1e8c:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-45dddef01e4mr122797995e9.27.1757517411234;
        Wed, 10 Sep 2025 08:16:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81c72e0sm35573405e9.3.2025.09.10.08.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 08:16:50 -0700 (PDT)
Message-ID: <5e9dc5b5-9671-4a72-b926-8b526ebf9059@redhat.com>
Date: Wed, 10 Sep 2025 17:16:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/panic: Add kunit tests for drm_panic
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250908090341.762049-1-jfalempe@redhat.com>
 <20250908090341.762049-3-jfalempe@redhat.com>
 <20250910-fascinating-hungry-lemur-1d9f49@houat>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250910-fascinating-hungry-lemur-1d9f49@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2025 10:33, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Sep 08, 2025 at 11:00:30AM +0200, Jocelyn Falempe wrote:
>> Add kunit tests for drm_panic.
>> They check that drawing the panic screen doesn't crash, but they
>> don't check the correctness of the resulting image.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>
>> v2:
>>   * Add a few checks, and more comments in the kunit tests. (Maxime Ripard).
>>
>>   MAINTAINERS                            |   1 +
>>   drivers/gpu/drm/drm_panic.c            |   4 +
>>   drivers/gpu/drm/tests/drm_panic_test.c | 198 +++++++++++++++++++++++++
>>   3 files changed, 203 insertions(+)
>>   create mode 100644 drivers/gpu/drm/tests/drm_panic_test.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 402fe14091f1..e9be893d6741 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8480,6 +8480,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>   F:	drivers/gpu/drm/drm_draw.c
>>   F:	drivers/gpu/drm/drm_draw_internal.h
>>   F:	drivers/gpu/drm/drm_panic*.c
>> +F:	drivers/gpu/drm/tests/drm_panic_test.c
>>   F:	include/drm/drm_panic*
>>   
>>   DRM PANIC QR CODE
>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>> index 1e06e3a18d09..d89812ff1935 100644
>> --- a/drivers/gpu/drm/drm_panic.c
>> +++ b/drivers/gpu/drm/drm_panic.c
>> @@ -986,3 +986,7 @@ void drm_panic_exit(void)
>>   {
>>   	drm_panic_qr_exit();
>>   }
>> +
>> +#ifdef CONFIG_DRM_KUNIT_TEST
>> +#include "tests/drm_panic_test.c"
>> +#endif
>> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
>> new file mode 100644
>> index 000000000000..d5d20dd2aa7c
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
>> @@ -0,0 +1,198 @@
>> +// SPDX-License-Identifier: GPL-2.0 or MIT
>> +/*
>> + * Copyright (c) 2025 Red Hat.
>> + * Author: Jocelyn Falempe <jfalempe@redhat.com>
>> + *
>> + * KUNIT tests for drm panic
>> + */
>> +
>> +#include <drm/drm_fourcc.h>
>> +#include <drm/drm_panic.h>
>> +
>> +#include <kunit/test.h>
>> +
>> +#include <linux/units.h>
>> +#include <linux/vmalloc.h>
>> +
>> +/* Check the framebuffer color only if the panic colors are the default */
>> +#if (CONFIG_DRM_PANIC_BACKGROUND_COLOR == 0 && \
>> +	CONFIG_DRM_PANIC_FOREGROUND_COLOR == 0xffffff)
>> +#define DRM_PANIC_CHECK_COLOR
>> +#endif
>> +
>> +struct drm_test_mode {
>> +	const int width;
>> +	const int height;
>> +	const u32 format;
>> +	void (*draw_screen)(struct drm_scanout_buffer *sb);
>> +	const char *fname;
>> +};
>> +
>> +/*
>> + * Run all tests for the 3 panic screens: user, kmsg and qr_code
>> + */
>> +#define DRM_TEST_MODE_LIST(func) \
>> +	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_XRGB8888, func) \
>> +	DRM_PANIC_TEST_MODE(300, 200, DRM_FORMAT_XRGB8888, func) \
>> +	DRM_PANIC_TEST_MODE(1920, 1080, DRM_FORMAT_XRGB8888, func) \
>> +	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_RGB565, func) \
>> +	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_RGB888, func) \
>> +
>> +#define DRM_PANIC_TEST_MODE(w, h, f, name) { \
>> +	.width = w, \
>> +	.height = h, \
>> +	.format = f, \
>> +	.draw_screen = draw_panic_screen_##name, \
>> +	.fname = #name, \
>> +	}, \
>> +
>> +static const struct drm_test_mode drm_test_modes_cases[] = {
>> +	DRM_TEST_MODE_LIST(user)
>> +	DRM_TEST_MODE_LIST(kmsg)
>> +	DRM_TEST_MODE_LIST(qr_code)
>> +};
>> +#undef DRM_PANIC_TEST_MODE
>> +
>> +static int drm_test_panic_init(struct kunit *test)
>> +{
>> +	struct drm_scanout_buffer *priv;
>> +
>> +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, priv);
>> +
>> +	test->priv = priv;
>> +
>> +	drm_panic_set_description("Kunit testing");
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Test drawing the panic screen, using a memory mapped framebuffer
>> + * Set the whole buffer to 0xa5, and then check that all pixels have been
>> + * written.
>> + */
>> +static void drm_test_panic_screen_user_map(struct kunit *test)
>> +{
>> +	struct drm_scanout_buffer *sb = test->priv;
>> +	const struct drm_test_mode *params = test->param_value;
>> +	char *fb;
>> +	int fb_size;
>> +
>> +	sb->format = drm_format_info(params->format);
>> +	fb_size = params->width * params->height * sb->format->cpp[0];
>> +
>> +	fb = vmalloc(fb_size);
>> +	KUNIT_ASSERT_NOT_NULL(test, fb);
>> +
>> +	memset(fb, 0xa5, fb_size);
>> +
>> +	iosys_map_set_vaddr(&sb->map[0], fb);
>> +	sb->width = params->width;
>> +	sb->height = params->height;
>> +	sb->pitch[0] = params->width * sb->format->cpp[0];
>> +
>> +	params->draw_screen(sb);
>> +
>> +#ifdef DRM_PANIC_CHECK_COLOR
>> +	{
>> +		int i;
>> +
>> +		for (i = 0; i < fb_size; i++)
>> +			KUNIT_ASSERT_TRUE(test, fb[i] == 0 || fb[i] == 0xff);
>> +	}
>> +#endif
> 
> I'm not really fond of the ifdef here. Could you turn this into a
> function, and return that it's valid if the colors don't match what you
> expect?

Yes, I can rework this.
> 
>> +	vfree(fb);
>> +}
>> +
>> +/*
>> + * Test drawing the panic screen, using a list of pages framebuffer
>> + * No checks are performed
> 
> What are you testing then if you aren't checking anything?

It tests that there are no access to an unmapped page.
But I can add the same check that with the "map" case.
It just requires more work to map the pages.

> 
>> + */
>> +static void drm_test_panic_screen_user_page(struct kunit *test)
>> +{
>> +	struct drm_scanout_buffer *sb = test->priv;
>> +	const struct drm_test_mode *params = test->param_value;
>> +	int fb_size;
>> +	struct page **pages;
>> +	int i;
>> +	int npages;
>> +
>> +	sb->format = drm_format_info(params->format);
>> +	fb_size = params->width * params->height * sb->format->cpp[0];
>> +	npages = DIV_ROUND_UP(fb_size, PAGE_SIZE);
>> +
>> +	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, pages);
>> +
>> +	for (i = 0; i < npages; i++) {
>> +		pages[i] = alloc_page(GFP_KERNEL);
>> +		KUNIT_ASSERT_NOT_NULL(test, pages[i]);
> 
> KUNIT_ASSERT_* return immediately, so you're leaking the pages array
> here.
> 
yes, I can fix that, but is it important to not leak when the test fails?

-- 

Jocelyn

> Maxime


