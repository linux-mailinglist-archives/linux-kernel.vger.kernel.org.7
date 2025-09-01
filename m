Return-Path: <linux-kernel+bounces-794628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF41B3E46C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD9444E2AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78285276038;
	Mon,  1 Sep 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEmUUu1c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA342A1B2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732583; cv=none; b=AomkBQnhcmROmSvuqKi+c0sbj/ybKb425Yw4FykixoVcmUxbXkFCUJoGd1TxaFJEOy8ZSpaxhvjwL6RQL2lHwbwNcejoquwGp6mKaE3iN5fPgYFIOUAV2VO+Ieg+72wounHpiDxZJfn5vHZ2tahvz07tPisDlAZfhCbpIfmJPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732583; c=relaxed/simple;
	bh=gX/EAXoM/dONMYmXEMYJZOIob5MMJ1RbyfRP2W8w0wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkPX3x6TeBRxZJLhuseHKeHkqCRdfvNodtUueH+eN/7CXSSEAvB5GyZ8PjPJCyxnsGT2TN48Bobz8JEP/U3OepXyAEmbEt3v3gYiP532cxyx9PXbIbCcKlB0Y+jtzrHN7u1+O9Curlj7FwLsI5Bq1f2Uago3Sz+4L7RsMTGYwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEmUUu1c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756732580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/E9FHFC9caBJzTnTpVFypUS6buU8BbMb0alSV3yJyng=;
	b=DEmUUu1cfQCAD6brj3YA7E8YeKIwUQfmhjPJWFyeKaJC8kepJTQWiFY0ZJ+fe7yJqUW2f/
	JtFAeluwIRP68CMXeD+pqpkHUX8Bwbj7bybpWULXoRV0I9I26AY2w3rNBS/7GNbLq7TNrP
	e6qji+Te5WOQWE5AeRQ/w1SZTBMYWKg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-qTVe35A0NquiVI3eJsINBg-1; Mon, 01 Sep 2025 09:16:19 -0400
X-MC-Unique: qTVe35A0NquiVI3eJsINBg-1
X-Mimecast-MFC-AGG-ID: qTVe35A0NquiVI3eJsINBg_1756732578
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3cf48ec9dcbso3568344f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756732578; x=1757337378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/E9FHFC9caBJzTnTpVFypUS6buU8BbMb0alSV3yJyng=;
        b=nrvQ2PEP1bhBDNrkJnZNpGcLCYkmKK2bj+6KhNl8Y1Z8Oug0RMsAI66/deZtwrKQPR
         sAEFd1eVW1/PF7v1eofZLmdaO3+3K3bCCsfczXaBq20UobLFsClyoPuNvkQTckdxKjeN
         SoNDQVB+wKAu85FNcDjDGuOYLvtAe/q0UOeoRTkShvWmRstPOuG1SIcbB1tH1jRtikUn
         jp3qWQpV0ifCD81UIFvfflvlQrEVMvQtl3kinLfD82uLWPTe88fTyNxyjwUv5s2Q1Vz0
         6azSCfpDfSX26X8uH7pS6in714z+jWC6XZ3XinHsVtuxnJXdN/z4zG90C5MgLNGN2SYM
         m/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUnJsgis5OYzOAuz64EdhJCTaXXx0J3+hGYMGIvy8Gqi5aAXKa2sJnbhL8ubBHPWiOPMsa6w0rPRBWy3IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWxYEgPwmaEVHyYbGQ2vUxeEaeWx84NDzqQFnS9O07POvWzph
	YZHi8ZnAOhf8W3+QflNm0Hd6z+IZm/kwIefvDhp5nuGVXIltI7aUDsTPXrSHLkqGx23NesEEKZT
	q2Q8r7to9dDn1hhxoiU7dd22dBvoNVkKzmHor2d1xVTqmlELGACA3MBSgdVCDUMEsgQ==
X-Gm-Gg: ASbGnctG19J1iXWSEnw7cZ+u20DWKM3S4krdRxzioS1zPrWPJX/YzYTZZhmN2fGlQYo
	Lh9k0O5YaN9EUdlkkBBcA6vRVMbhrei5AmfEAn6KjcmQxCkm7m7w6vr/gleI36WaJhgVq+9F6ay
	CJAYWrQTqLU9uvFwBHO10WxQKEw3266M0cfErCQJsqWy37vtm2PjcYpzSdl7XTzD4qiKiFJPI4T
	q2q7/ShSLi1dimvDohCrHeOVLERSOp/78r1NzWQmYXQZNV4lYXIFymYFPvHJAbn8VDZXEp2JCPc
	xHhq4ZImPLPC6AmJwYt8CIu7wJtl2WCp0Mw5ihcYEgdG4kGfT8InNyd/m0WsNHb0rQQcnEkjPcC
	6ZE4=
X-Received: by 2002:adf:a350:0:b0:3d2:52e3:920c with SMTP id ffacd0b85a97d-3d252e39ae7mr4259414f8f.44.1756732578158;
        Mon, 01 Sep 2025 06:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMMo/FX6gLCbb9MPBn1nmMCgGwLpPc/FdeUFPte52EQzVd0EWOwOLg5M0J2p3dvJsJSOVvAw==
X-Received: by 2002:adf:a350:0:b0:3d2:52e3:920c with SMTP id ffacd0b85a97d-3d252e39ae7mr4259394f8f.44.1756732577622;
        Mon, 01 Sep 2025 06:16:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8efb280csm14242245e9.3.2025.09.01.06.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:16:17 -0700 (PDT)
Message-ID: <29f77752-a4df-4a12-96d3-4ccd52bd5b89@redhat.com>
Date: Mon, 1 Sep 2025 15:16:16 +0200
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
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250821095228.648156-1-jfalempe@redhat.com>
 <20250821095228.648156-4-jfalempe@redhat.com>
 <20250827-imperial-amigurumi-malkoha-b99a9d@houat>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250827-imperial-amigurumi-malkoha-b99a9d@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2025 11:52, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Aug 21, 2025 at 11:49:07AM +0200, Jocelyn Falempe wrote:
>> This is a bit hacky, but very handy if you want to customize the
>> panic screen.
>> It allows to dump the generated images to the logs, and then a python
>> script can convert it to .png files. It makes it easy to check how
>> the panic screen will look on different resolutions, without having
>> to crash a VM.
>> To not pollute the logs, it uses a monochrome framebuffer, compress
>> it with zlib, and base64 encode it.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/Kconfig.debug          |  14 ++++
>>   drivers/gpu/drm/tests/drm_panic_test.c | 111 +++++++++++++++++++++++++
>>   scripts/kunitpanic2png.py              |  53 ++++++++++++
>>   3 files changed, 178 insertions(+)
>>   create mode 100755 scripts/kunitpanic2png.py
>>
>> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
>> index 05dc43c0b8c5..d8ae85132d32 100644
>> --- a/drivers/gpu/drm/Kconfig.debug
>> +++ b/drivers/gpu/drm/Kconfig.debug
>> @@ -84,6 +84,20 @@ config DRM_KUNIT_TEST
>>   
>>   	  If in doubt, say "N".
>>   
>> +config DRM_PANIC_KUNIT_TEST_DUMP
>> +	bool "Enable screen dump to logs in KUnit tests for drm_panic"
>> +	default n
>> +	depends on DRM && DRM_PANIC && DRM_KUNIT_TEST
>> +	select ZLIB_DEFLATE
>> +	help
>> +	  This allows to dump the panic screen to the KUnit tests logs.
>> +	  It's possible with a small python script to write pngs from the logs.
>> +
>> +	  This is only to help developers customizing the drm_panic screen,
>> +	  checking the result for different resolutions.
>> +
>> +	  If in doubt, say "N"
>> +
>>   config DRM_TTM_KUNIT_TEST
>>   	tristate "KUnit tests for TTM" if !KUNIT_ALL_TESTS
>>   	default n
>> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
>> index 46ff3e5e0e5d..8cddb845aea9 100644
>> --- a/drivers/gpu/drm/tests/drm_panic_test.c
>> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
>> @@ -115,24 +115,135 @@ static void drm_test_panic_screen_user_page(struct kunit *test)
>>   	kfree(pages);
>>   }
>>   
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
>> +	struct z_stream_s stream;
>> +
>> +	stream.workspace = kmalloc(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),
>> +				   GFP_KERNEL);
>> +
>> +	if (zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
>> +			      MEM_LEVEL, Z_DEFAULT_STRATEGY) != Z_OK)
>> +		return -EINVAL;
>> +
>> +	stream.next_in = src;
>> +	stream.avail_in = size;
>> +	stream.total_in = 0;
>> +	stream.next_out = dst;
>> +	stream.avail_out = size;
>> +	stream.total_out = 0;
>> +
>> +	if (zlib_deflate(&stream, Z_FINISH) != Z_STREAM_END)
>> +		return -EINVAL;
>> +
>> +	if (zlib_deflateEnd(&stream) != Z_OK)
>> +		return -EINVAL;
>> +
>> +	kfree(stream.workspace);
>> +
>> +	return stream.total_out;
>> +}
>> +
>> +static void dump_image(u8 *fb, unsigned int width, unsigned int height)
>> +{
>> +	int len = 0;
>> +	char *dst;
>> +	char *compressed;
>> +	int sent = 0;
>> +	int stride = DIV_ROUND_UP(width, 8);
>> +	int size = stride * height;
>> +
>> +	compressed = vzalloc(size);
>> +	if (!compressed)
>> +		return;
>> +	len = compress_image(fb, size, compressed);
>> +	if (len < 0) {
>> +		pr_err("Compression failed %d", len);
>> +		return;
>> +	}
>> +
>> +	dst = vzalloc(4 * DIV_ROUND_UP(len, 3) + 1);
>> +	if (!dst)
>> +		return;
>> +
>> +	len = base64_encode(compressed, len, dst);
>> +
>> +	pr_info("KUNIT PANIC IMAGE DUMP START %dx%d", width, height);
>> +	while (len > 0) {
>> +		char save = dst[sent + LINE_LEN];
>> +
>> +		dst[sent + LINE_LEN] = 0;
>> +		pr_info("%s", dst + sent);
>> +		dst[sent + LINE_LEN] = save;
>> +		sent += LINE_LEN;
>> +		len -= LINE_LEN;
>> +	}
>> +	pr_info("KUNIT PANIC IMAGE DUMP END");
> 
> The kunit test output format is defined, and we should probably use a
> diagnostic line for this:
> https://docs.kernel.org/dev-tools/ktap.html#diagnostic-lines
> 
> We should probably cc the kunit maintainers about this too.

Thanks for the pointer, I will also experiment with debugfs, as 
suggested by Thomas.

Best regards,

-- 

Jocelyn



> 
> Maxime


