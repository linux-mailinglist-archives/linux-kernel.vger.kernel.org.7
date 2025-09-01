Return-Path: <linux-kernel+bounces-794603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61978B3E3CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B208D1A83C34
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA44334369;
	Mon,  1 Sep 2025 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ppn1hfB9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F724DCF9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731557; cv=none; b=FAnk/08fqRKAZzCVtc373qUFn/PALLvFzHmE0lYZoLP6oEmRbd0HgVcTHDlQLCnoTawKR8U2T9YqJTmeYLbYKbts+gAJJQMPTaElzH/XFYcvNJiUp80y2quFiyzGOdNbWjiczr4WDiofn3hy0Nbo9EgchLP2w6bp1wXSecwfrvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731557; c=relaxed/simple;
	bh=OFKsATxtQXJF2NlguXWfAwQleNtNPmWLQYOHwaIcSCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nq8Q3vhW9fB8KAkFtQOPORBsY9W2wRhSKedc5fIMkwyOlduiRSrWrpMS6nRlnR6nv0w2LPujWlJMgea+OwU8xOzbdgayZuDEqaaVqc0sgPQ9tdB5y2vaZBesvzBf00pH5zjW+GxOVafoMUCzR1i7RD59Xr/CuAJIrsQPnHT9NNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ppn1hfB9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756731555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RoiIEnJ0ic7SzUloB3/lyFFbxaN9NLIbcmrNtiHaEk4=;
	b=Ppn1hfB93PkbDR9CBtLtzac+na2muwt6xfTUpVJcOjCgPlCsOU+/LsiQ67LpFp2h+chrUM
	S/Xe6J5uEd+IXuE90442t1rKPbckva9Dofta5lpFSAVC2xb4ZbPoIGxrssBJPdRyVU42L5
	kODku+1KJpnHXQzfMm0bhRiFL01Wuus=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-bxh7vP_tNQSsgDBPgoUmzg-1; Mon, 01 Sep 2025 08:59:13 -0400
X-MC-Unique: bxh7vP_tNQSsgDBPgoUmzg-1
X-Mimecast-MFC-AGG-ID: bxh7vP_tNQSsgDBPgoUmzg_1756731551
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b87609538so17408305e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731551; x=1757336351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoiIEnJ0ic7SzUloB3/lyFFbxaN9NLIbcmrNtiHaEk4=;
        b=LQKFU7ywlZVotkJYHkiWXDe2tFvE/zfJK7LFbv2fPQP59pj9GA3WpsbBZvaJapjSmh
         nc7AkVD6W9StFlpFFPTcMJfmOcYBF0ne92vxqEGsI+j+OYtE4i4PeYe4sX9s8zEgfqjl
         xBDP4TlilNHwJQgCLNhvdocBIj0BLtlPJyM8XgkKH5aXjkmMPm14ThXkb0TPhQ9LQHoT
         5B/WY0mNnofOlPQp9SQEDl9KIWFOAgEo48eC1RL9lYzS4J5zy1F+9m2EbmUYvcX1CFir
         tkuH4f9SM0rb9fMOjP74XFJrGs4UfD+J5lA6ab0P5ADQ1g0LtkCKGxu9j6Y5r/dunBj1
         mRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQh7gLPvZtvNq6E9utz4p2Yg7NdzzOyOTRYkZlhyM/QyqSzN+fag6JyPEqa3MdhNRivJsPcENp4s0Nu1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywynh60QOco3WSMnOGhcjvitTIYT273a1vKbcrrFRGSGSKc3m2n
	PHUCbxwXKG2AtT/zyS5FoVuWl5IydJQYstfaeesWcFoBvt2+isnIIpOQSYWRFzaJr5XUwJR97r/
	pjkAOIdPNvMwk0m58MXzFOzArrC/Wh53rgkxXPb5+sPv4oRy5c22LkLXyoR8tLAHPWg==
X-Gm-Gg: ASbGnctmf4dy0JPzxg3jdRtHWlfmUMjkA3WHppoEbVewtmST3rAdkNvJjr10+0Mk++J
	BRIzW7B7IrspKqOf0nlwfEVBlL/r1vVTCTnO+SS+Sb5jYQNYeRZo5W6yM9+RHNICanTagn5Atim
	BK0fZguZy8NnvK+u9FVdVWMmG2D74yfh+KUFDkWBMbAu6lfNFmBD1GXskS0t1WMyYKD6iSlnjas
	jAd+4jZ+ZI71hMSpsA1bVWewK70uNlGb4b3wQ+QyuBjPpV5CdI2xSzwrejfEXIl3VjO5M/f2X1q
	DfBa0BK/CqnDvUzeH1F0djPAFcWKyro2934K8MWQnJbGR53j2EHHBr7KlFuXaoO6PTnOPwqfGLD
	jeHA=
X-Received: by 2002:a05:6000:22c8:b0:3d4:d572:b8ea with SMTP id ffacd0b85a97d-3d4d582029dmr4076266f8f.34.1756731551292;
        Mon, 01 Sep 2025 05:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwwiOlbgDAUXiL5u9+hhsxXPHF3nih+OFrmTVITUV0olcPvLjVNle5d7dLd+XfIou16DK1DA==
X-Received: by 2002:a05:6000:22c8:b0:3d4:d572:b8ea with SMTP id ffacd0b85a97d-3d4d582029dmr4076243f8f.34.1756731550807;
        Mon, 01 Sep 2025 05:59:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc3fasm15108222f8f.5.2025.09.01.05.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:59:10 -0700 (PDT)
Message-ID: <a43fea8c-4c62-422e-a3f0-7192ab51992a@redhat.com>
Date: Mon, 1 Sep 2025 14:59:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/panic: Add kunit tests for drm_panic
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250821095228.648156-1-jfalempe@redhat.com>
 <20250821095228.648156-3-jfalempe@redhat.com>
 <20250827-wooden-kakapo-of-defense-0c4273@houat>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250827-wooden-kakapo-of-defense-0c4273@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2025 11:44, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Aug 21, 2025 at 11:49:06AM +0200, Jocelyn Falempe wrote:
>> Add kunit tests for drm_panic.
>> They check that drawing the panic screen doesn't crash, but they
>> don't check the correctness of the resulting image.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   MAINTAINERS                            |   1 +
>>   drivers/gpu/drm/drm_panic.c            |   4 +
>>   drivers/gpu/drm/tests/drm_panic_test.c | 164 +++++++++++++++++++++++++
>>   3 files changed, 169 insertions(+)
>>   create mode 100644 drivers/gpu/drm/tests/drm_panic_test.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cfa28b3470ab..285d1e27734f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8465,6 +8465,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
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
>> index 000000000000..46ff3e5e0e5d
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
>> @@ -0,0 +1,164 @@
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
>> +static void drm_test_panic_screen_user_map(struct kunit *test)
>> +{
>> +	struct drm_scanout_buffer *sb = test->priv;
>> +	const struct drm_test_mode *params = test->param_value;
>> +	void *fb;
>> +	int fb_size;
>> +
>> +	sb->format = drm_format_info(params->format);
>> +	fb_size = params->width * params->height * sb->format->cpp[0];
>> +
>> +	fb = vmalloc(fb_size);
>> +	KUNIT_ASSERT_NOT_NULL(test, fb);
>> +
>> +	iosys_map_set_vaddr(&sb->map[0], fb);
>> +	sb->width = params->width;
>> +	sb->height = params->height;
>> +	sb->pitch[0] = params->width * sb->format->cpp[0];
>> +
>> +	params->draw_screen(sb);
>> +	vfree(fb);
>> +}
> 
> You need to document what you're testing, and what the expected result
> is.

Sure, I will add some comments.
I think I can also add a few checks, as this doesn't check the result at 
all.

> 
> Maxime


