Return-Path: <linux-kernel+bounces-794608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7A2B3E3E6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9627A480ABD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8AF14AD20;
	Mon,  1 Sep 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8fz/yV6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB103D994
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731874; cv=none; b=c9nc1eHrQaVMs83EM5myOn7AlVJNr3ZEjkZu2X1W8uh78Sk/IM3ka029mYqP2+swnbt+9KDdT3up+1S/jMgz07iLZKhHVleBIZWAD0+9SkdqyK4HfR7SOktollWXei1zwZtFJGpTF1JPe7PJ5yHBF960qCxgP4pZmmsz9jcIyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731874; c=relaxed/simple;
	bh=qxtn++jl/A2cDDCNmu3hp9+YqNrbk+Srl8xLLVBBqnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=au/hDO0ybxoZoWSblwalmW9yRZX+Xe/rzJbWFvriJ8NN5iWaNoLS591E+WhA8iaUH/usIQeSivnb4Z/9Wy29IIHc4DJgx1aLuaeeHEq6yfdneOTVVVKzQ6bHgQk3+KSGzXYJoF2vAuUxIIxbwF9nOQlYHdNNgyqd0b2vRxJYj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8fz/yV6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756731871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpIKwW3gznYfnUhlO4VCeOwyi2CheHtVR2JcZ4mTmv4=;
	b=E8fz/yV63jIRl45UdLxAhEKbqZfgu+/p7ZXVabI9urfjAJb+WQwvRL9nHahHkrYTvPYrXn
	VnujY9koxLxPYSB+QtgG/IM4KNSAj5Zkz0QYSwqJJBrobHDEAf2nN2Hz/TAf1KC3n83YwW
	tsIHwBqZImMzoE+uyXsKExE0VZ42zuI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-tr2qE6s7Nf2HngbcD9oUqQ-1; Mon, 01 Sep 2025 09:04:30 -0400
X-MC-Unique: tr2qE6s7Nf2HngbcD9oUqQ-1
X-Mimecast-MFC-AGG-ID: tr2qE6s7Nf2HngbcD9oUqQ_1756731869
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b87609663so9348525e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731869; x=1757336669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpIKwW3gznYfnUhlO4VCeOwyi2CheHtVR2JcZ4mTmv4=;
        b=IrAU4LklgAoBMB6lMvLPX4hDUcbQnRa8tKiP40dTBhTBA6I2I3O4b7SYsQuyw7xH2d
         altlJvWrGje5lb//jqve/6MNeAr3UDl4pcC9v3W69/iVf0EDtYtAbdM+BxLB5GnKFhmV
         8/pNrC1JxDMzyqhxrlibfmJdc3mXQKctI6ieb6iYf5M9R5Gj1lusdCH/IXpFPSO/dTds
         fpkjwDYUIxH35r3R9uD9z0otZryIdFSgJ5xm4ATFPgCTkI+3+hq8DDnEKRvPtDUs05GQ
         7DRjEFcFjA0/Ne9axVTmuSHFO3e0f0AI6gEFbtFX809xHWkf3ENv+h9nq6vS/Sa+zO1E
         PKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhDulOMcWeYuYpcOWjzsy8XrzodWoHu9/YBduainxKmEu73z657wERWyfYHzrv0QCpF6a9EhXJqJ23pfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOX6PzgA/tCL0fs6Czl1Vbp7p3x/Hqv7GpcVPxuyRSPSikCqQ
	neqOA2S4Wz/rSzVody8z1xt6/IQ0KY6UuDQERKGErbG98ZPalmC/MHWJT60CvZLQqKbpx4KXDiw
	aNmK2NWwALwjsEBbkmafA6jtUYmD3DWctw3uPS8gKvJKrNDaEmppyrNCUF5Bo+frj8NsbYlNLBA
	==
X-Gm-Gg: ASbGnctjg0dscBqBWqq8DFGOJDz1+/gY1N/m0Kw8+O2rmvLEQra6fAM5yCUFWds/NSE
	Fi/OsMdzZ62zR8ETufMl1mBSQBsRYttTIhg1fM5GHUs0x6xdeLuRBd/N+MF6h4rx8w60FzBANE8
	gux4itYLEb7ktr1ePol291jDD17oWakiIFGc3pHczm1lzT54qzbv8+EU+7NT0g4HW0q+VQ5IxsM
	fAnTMVaDiV3gA99dKp959IOg/XeFjrVCg3C/nB4DfdjtNPExNihS+ruDsZafuGiWe6sxtqqAD3d
	XHRjuUV20Atny8un1eoaAZbSgcSMEm4DjGI7H+u9DWWBexmdooKdg90SsdjzY+lkGB9w86le7it
	Vk3M=
X-Received: by 2002:a05:600c:4fcd:b0:45b:7185:9e5 with SMTP id 5b1f17b1804b1-45b85525cddmr69509465e9.5.1756731868521;
        Mon, 01 Sep 2025 06:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh8rUbp89BWNpGKBZY2UYzRFvCLdT9yJz8XIJrWL/ukpmEd5bm2NkRg3KJWLKHFrGa1zBbLQ==
X-Received: by 2002:a05:600c:4fcd:b0:45b:7185:9e5 with SMTP id 5b1f17b1804b1-45b85525cddmr69508925e9.5.1756731867976;
        Mon, 01 Sep 2025 06:04:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d141esm161986315e9.2.2025.09.01.06.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:04:27 -0700 (PDT)
Message-ID: <7ff51c5b-939e-47d9-8c3b-3c596565d114@redhat.com>
Date: Mon, 1 Sep 2025 15:04:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/panic: Add a kconfig option to dump kunits
 results to png
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250821095228.648156-1-jfalempe@redhat.com>
 <20250821095228.648156-4-jfalempe@redhat.com>
 <923276d2-9240-48bd-95df-13b4e9e23dcd@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <923276d2-9240-48bd-95df-13b4e9e23dcd@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/08/2025 12:45, Thomas Zimmermann wrote:
> Hi
> 
> Am 21.08.25 um 11:49 schrieb Jocelyn Falempe:
>> This is a bit hacky, but very handy if you want to customize the
>> panic screen.
>> It allows to dump the generated images to the logs, and then a python
>> script can convert it to .png files. It makes it easy to check how
>> the panic screen will look on different resolutions, without having
>> to crash a VM.
>> To not pollute the logs, it uses a monochrome framebuffer, compress
>> it with zlib, and base64 encode it.
> 
> May I suggest to export the raw image via debugfs? Debugfs can also 
> export additional information in additional files, such as width/height/ 
> stride/format. This could provide the real/last image on the fly, simply 
> by reading the files. No workarounds or encodings needed.

I'm looking into that. The difficulty is to get the debugfs content 
outside of the test kernel. As I'm using a uml kernel for testing, I 
will need a special initrd, and a way to share files with the host.

Best regards,

-- 

Jocelyn
> 
> Best regards
> Thomas
> 
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/Kconfig.debug          |  14 ++++
>>   drivers/gpu/drm/tests/drm_panic_test.c | 111 +++++++++++++++++++++++++
>>   scripts/kunitpanic2png.py              |  53 ++++++++++++
>>   3 files changed, 178 insertions(+)
>>   create mode 100755 scripts/kunitpanic2png.py
>>
>> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/ 
>> Kconfig.debug
>> index 05dc43c0b8c5..d8ae85132d32 100644
>> --- a/drivers/gpu/drm/Kconfig.debug
>> +++ b/drivers/gpu/drm/Kconfig.debug
>> @@ -84,6 +84,20 @@ config DRM_KUNIT_TEST
>>         If in doubt, say "N".
>> +config DRM_PANIC_KUNIT_TEST_DUMP
>> +    bool "Enable screen dump to logs in KUnit tests for drm_panic"
>> +    default n
>> +    depends on DRM && DRM_PANIC && DRM_KUNIT_TEST
>> +    select ZLIB_DEFLATE
>> +    help
>> +      This allows to dump the panic screen to the KUnit tests logs.
>> +      It's possible with a small python script to write pngs from the 
>> logs.
>> +
>> +      This is only to help developers customizing the drm_panic screen,
>> +      checking the result for different resolutions.
>> +
>> +      If in doubt, say "N"
>> +
>>   config DRM_TTM_KUNIT_TEST
>>       tristate "KUnit tests for TTM" if !KUNIT_ALL_TESTS
>>       default n
>> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/ 
>> tests/drm_panic_test.c
>> index 46ff3e5e0e5d..8cddb845aea9 100644
>> --- a/drivers/gpu/drm/tests/drm_panic_test.c
>> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
>> @@ -115,24 +115,135 @@ static void 
>> drm_test_panic_screen_user_page(struct kunit *test)
>>       kfree(pages);
>>   }
>> +#ifdef CONFIG_DRM_PANIC_KUNIT_TEST_DUMP
>> +#include <linux/base64.h>
>> +#include <linux/delay.h>
>> +#include <linux/zlib.h>
>> +
>> +#define LINE_LEN 128
>> +
>> +#define COMPR_LEVEL 6
>> +#define WINDOW_BITS 12
>> +#define MEM_LEVEL 4
>> +
>> +static int compress_image(u8 *src, int size, u8 *dst)
>> +{
>> +    struct z_stream_s stream;
>> +
>> +    stream.workspace = 
>> kmalloc(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),
>> +                   GFP_KERNEL);
>> +
>> +    if (zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
>> +                  MEM_LEVEL, Z_DEFAULT_STRATEGY) != Z_OK)
>> +        return -EINVAL;
>> +
>> +    stream.next_in = src;
>> +    stream.avail_in = size;
>> +    stream.total_in = 0;
>> +    stream.next_out = dst;
>> +    stream.avail_out = size;
>> +    stream.total_out = 0;
>> +
>> +    if (zlib_deflate(&stream, Z_FINISH) != Z_STREAM_END)
>> +        return -EINVAL;
>> +
>> +    if (zlib_deflateEnd(&stream) != Z_OK)
>> +        return -EINVAL;
>> +
>> +    kfree(stream.workspace);
>> +
>> +    return stream.total_out;
>> +}
>> +
>> +static void dump_image(u8 *fb, unsigned int width, unsigned int height)
>> +{
>> +    int len = 0;
>> +    char *dst;
>> +    char *compressed;
>> +    int sent = 0;
>> +    int stride = DIV_ROUND_UP(width, 8);
>> +    int size = stride * height;
>> +
>> +    compressed = vzalloc(size);
>> +    if (!compressed)
>> +        return;
>> +    len = compress_image(fb, size, compressed);
>> +    if (len < 0) {
>> +        pr_err("Compression failed %d", len);
>> +        return;
>> +    }
>> +
>> +    dst = vzalloc(4 * DIV_ROUND_UP(len, 3) + 1);
>> +    if (!dst)
>> +        return;
>> +
>> +    len = base64_encode(compressed, len, dst);
>> +
>> +    pr_info("KUNIT PANIC IMAGE DUMP START %dx%d", width, height);
>> +    while (len > 0) {
>> +        char save = dst[sent + LINE_LEN];
>> +
>> +        dst[sent + LINE_LEN] = 0;
>> +        pr_info("%s", dst + sent);
>> +        dst[sent + LINE_LEN] = save;
>> +        sent += LINE_LEN;
>> +        len -= LINE_LEN;
>> +    }
>> +    pr_info("KUNIT PANIC IMAGE DUMP END");
>> +    vfree(compressed);
>> +    vfree(dst);
>> +
>> +}
>> +
>> +// Ignore pixel format, use 1bit per pixel in monochrome.
>>   static void drm_test_panic_set_pixel(struct drm_scanout_buffer *sb,
>>                        unsigned int x,
>>                        unsigned int y,
>>                        u32 color)
>>   {
>> +    int stride = DIV_ROUND_UP(sb->width, 8);
>> +    size_t off = x / 8 + y * stride;
>> +    u8 shift = 7 - (x % 8);
>> +    u8 *fb = (u8 *) sb->private;
>> +
>> +    if (color)
>> +        fb[off] |= 1 << shift;
>> +    else
>> +        fb[off] &= ~(1 << shift);
>>   }
>> +#else
>> +static void dump_image(u8 *fb, unsigned int width, unsigned int 
>> height) {}
>> +static void drm_test_panic_set_pixel(struct drm_scanout_buffer *sb,
>> +                     unsigned int x,
>> +                     unsigned int y,
>> +                     u32 color)
>> +{
>> +}
>> +#endif
>> +
>>   static void drm_test_panic_screen_user_set_pixel(struct kunit *test)
>>   {
>>       struct drm_scanout_buffer *sb = test->priv;
>>       const struct drm_test_mode *params = test->param_value;
>> +    int fb_size;
>> +    u8 *fb;
>>       sb->format = drm_format_info(params->format);
>> +    fb_size = DIV_ROUND_UP(params->width, 8) * params->height;
>> +
>> +    fb = vzalloc(fb_size);
>> +    KUNIT_ASSERT_NOT_NULL(test, fb);
>> +    sb->private = fb;
>>       sb->set_pixel = drm_test_panic_set_pixel;
>>       sb->width = params->width;
>>       sb->height = params->height;
>>       params->draw_screen(sb);
>> +    if (params->format == DRM_FORMAT_XRGB8888)
>> +        dump_image(fb, sb->width, sb->height);
>> +
>> +    vfree(fb);
>>   }
>>   static void drm_test_panic_desc(const struct drm_test_mode *t, char 
>> *desc)
>> diff --git a/scripts/kunitpanic2png.py b/scripts/kunitpanic2png.py
>> new file mode 100755
>> index 000000000000..e292afd7422c
>> --- /dev/null
>> +++ b/scripts/kunitpanic2png.py
>> @@ -0,0 +1,53 @@
>> +#!/usr/bin/env python3
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# Copyright (c) 2025 Red Hat.
>> +# Author: Jocelyn Falempe <jfalempe@redhat.com>
>> +
>> +from argparse import ArgumentParser
>> +from PIL import Image
>> +import base64
>> +import zlib
>> +
>> +def get_dim(s):
>> +    (w, h) = s.split('x')
>> +    return (int(w), int(h))
>> +
>> +def draw_image(img_data, width, height, n_img):
>> +
>> +    decoded = base64.b64decode(img_data)
>> +    unzipped = zlib.decompress(decoded)
>> +
>> +    img = Image.frombytes("1", (width, height), unzipped)
>> +    fname = f"panic_screen_{n_img}.png"
>> +    img.save(fname)
>> +    print(f"Image {width}x{height} saved to {fname}")
>> +
>> +def main():
>> +    parser = ArgumentParser(
>> +        prog="kunitpanic2png",
>> +        description="Read drm_panic kunit logs and translate that to 
>> png files")
>> +
>> +    parser.add_argument("filename", help="log file from kunit, 
>> usually test.log")
>> +
>> +    parsing_img = False
>> +    img_data = ""
>> +    n_img = 0
>> +
>> +    args = parser.parse_args()
>> +    with open(args.filename, "r") as f:
>> +        for line in f.readlines():
>> +            if line.startswith("KUNIT PANIC IMAGE DUMP START"):
>> +                parsing_img = True
>> +                width, height = get_dim(line.split()[-1])
>> +                continue
>> +            if line.startswith("KUNIT PANIC IMAGE DUMP END"):
>> +                draw_image(img_data, width, height, n_img)
>> +                parsing_img = False
>> +                img_data = ""
>> +                n_img += 1
>> +                continue
>> +            if parsing_img:
>> +                img_data += line.strip()
>> +
>> +main()
> 


