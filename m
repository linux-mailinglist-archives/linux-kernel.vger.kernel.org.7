Return-Path: <linux-kernel+bounces-763486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D34B2153F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FD67A8BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903A2C325B;
	Mon, 11 Aug 2025 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k35B6yyD"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6E20468D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939894; cv=none; b=CozO3Ers2/uUiYNO/CDsbZ/n2b8sRqY1JBHrPByFb3la3Ga/3g1De+YFbkor7nZMD/bJaj3Fu8RQKSSuqA9Hki5g6xFv3+ReZ0xYWpJwKigLYHv84CTtptdYx/7nvqvl2RatA1JxpFxkQqz1ZEIYRPFsSD6YkkUshsHsTCKbCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939894; c=relaxed/simple;
	bh=NQZV9bm3Gom84bDFKkgr3+KlA71bM5X2Com280Owt/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGQEreQrynKsab4waTdK5+AhR4hIlzW5GVIBEymyzpDsi0HW0LTq8YcnrCLGbTy8lLyW4AJDGloeGUZbqRN0jmVkd3S+rQP4OzQRHLtH11o+Uryb2jaqJmeaCIgJSwGQnS/42qcWdbCxMwy150pP7BgZ8Q25gynJ6pP9gtwc+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k35B6yyD; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30c45b0f717so604287fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754939891; x=1755544691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AI/sGQsL/aW+QHdvLDtUmPvb4wNwg5knHWyurN/Guw=;
        b=k35B6yyDOeXzytZZKiVTgoIHEQl0/t+rH+JZu+0sBEjzVJ+lDYk863Dldr4k7m+YNW
         RvcNC1Ny4i2lxScHc/RNw0UY0qk553Jq9qt3ir7eurWtmxgW1Tk1pTTXUEkbQFagqZG9
         Mgdi+AmkZ/fz+/fEbuqytv7IeSRCknDcQjazdSZdtuM+e49XToKd4FMZ89Y8gr0BedLG
         iMHt+M8omYWB00buLb54cSZvlNLHGhZw4KUWdlVoK3HS6ksS9KKW96olI7mUFQX9F6Wt
         f8gzXR7eBLoPBLEVKVAh+q49dZy0iADVOFG1cJvAgT+9KmirICcqGbHas8nCNSP+RTnH
         hNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939891; x=1755544691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AI/sGQsL/aW+QHdvLDtUmPvb4wNwg5knHWyurN/Guw=;
        b=NVbTffuWEE4kqcIdc5w7XD/OU+ARt7y3GYXE16/200llkbLi26XYg6HbSq9DrXUyEQ
         BPVUQRv6+B5dM6CmCqTpGdHIbQs8vsU1PypN6+pLXtwQ//CS02EggGKwcf9V1xyqpkAs
         /tw+TYeM3mrdHQE2ig6Vff0eYfKMtQHuWzvS2nMC+eR12vhPYoX1BvZu2xZ4Ti9UwS+R
         pS1GQ7t31qM5XZOF79kIbCV7Kq6knJbaW9S/14WA7Ogdlp954o8jKyUEsgEynBgVqbhy
         /633mfEZL3LMcE0K5BK7jAIITA8XvB4pfaCqKB6Lnz1MlWzzPXDgYEV4Hv1xJra65UI3
         vtpw==
X-Forwarded-Encrypted: i=1; AJvYcCXg3zY2E14/AFvCeIMqGKe2QU4Vj9T29LzlpG1dm+zFSyo2iB1O7Z50VX2nko9VSlXnu2xTtrKJ0iOmPEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZj8SjjF9ReCcbGB4dx2fUtsLqWMjuCNhjlbUcW6k+Z3bNxeA
	eUZDcSUzlWmDvTFMGrKQ0ITz4IQDXKbpJ2L8Fr9EKL+wSKxtwL03pd9GVSwb5ptQKy0=
X-Gm-Gg: ASbGncuS9PDKchNv7aJGmL5NHSAYdSBYclfYqFTeZuvQRNpfQr/Ta2w43MOirepjx3g
	aEiyYGy9prfJ8IajKxCthonGcpq0uOTnXfOfVM0kViuVMEawa189NnD0WWpZqdnMxeoNTVDzuB3
	qoFZAZMZv68Ns+pgMgkp72txG02hKtMA+oTavrUHUdfNUsYSg6EiHSWz9818G3n7KXbuFajaist
	r0s+Qx8x/l59HEJni4qrYC6F17JyJESenaLCHcNmvgbEcUAACMoE8a4qp0llZjpYiTZGCOSoiBJ
	XPKYVFC/Nv0uYehHZS+auZ6WvIc5MJuSCPZI5z0WdPPcPCn+5AsTc6cGRT8bpPP7pwuNOySSUIV
	OeObiHo0r5QiIwIOjGg/IWB5ZjmFAoXLCCr5ssED0TAmqxgLVPgDG0FMOIKdPnh4ZVgkMUqFQlM
	o=
X-Google-Smtp-Source: AGHT+IEk4tJYU293i2xanK9PPMki/B/oadFN1LAk0tX3PXUVY4o8rCfhXdsvnLhc2bj8rE/LJaOkBw==
X-Received: by 2002:a05:6871:e486:b0:30b:cba0:31d2 with SMTP id 586e51a60fabf-30c950a75ccmr627923fac.31.1754939891168;
        Mon, 11 Aug 2025 12:18:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4a4f:fe55:51b4:b5ba? ([2600:8803:e7e4:1d00:4a4f:fe55:51b4:b5ba])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30b8d44e03asm6293482fac.31.2025.08.11.12.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 12:18:10 -0700 (PDT)
Message-ID: <5732b907-ccb8-4302-8fd7-ded63a5d852b@baylibre.com>
Date: Mon, 11 Aug 2025 14:18:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7380: fix missing max_conversion_rate_hz on
 adaq4381-4
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-v1-1-ffb728d7a71c@baylibre.com>
 <CAHp75Vc_-2czsaZ_-3+cSWAzyvz-PASR5mjCyoAxTu9qSEYyLA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75Vc_-2czsaZ_-3+cSWAzyvz-PASR5mjCyoAxTu9qSEYyLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/25 2:07 PM, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 8:32 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Add max_conversion_rate_hz to the chip info for "adaq4381-4". Without
>> this, the driver fails to probe because it tries to set the initial
>> sample rate to 0 Hz, which is not valid.
> 
> ...
> 
>> +       .max_conversion_rate_hz = 4 * MEGA,
> 
> MEGA --> HZ_PER_MHZ

If we do this, we should fix up all of the other similar ones
in a separate patch. So I would leave this patch as-is.

> 
> With that done
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> 


