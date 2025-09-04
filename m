Return-Path: <linux-kernel+bounces-801567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BCCB446C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843B35A3143
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293912773EA;
	Thu,  4 Sep 2025 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aKv8YI0Q"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FB842050
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015622; cv=none; b=UJR5346AJfX+pLlB7asC7380ZOAa9clStp0R5EBH0qBUcdtK97EdsqfANEtQWSjHXOGtoWTv2U9s1vLBWQCrOf5sTwa470z8S8NxWvkVqcxytlh7384hL9BP0Dg3fRsDLRT3/lywU1gFiEKJpTaudlwW4xlpw0vzXJfx6flLPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015622; c=relaxed/simple;
	bh=fBjqFXU8KSE6oNfNfCuHGg0jP8OoSyKM469VWseXGxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RX6+aLyGUd7f/nGq5M4gub9wV692oPtsrLl9vNVrQoFLsnOXp8y/wy8eoT2DLOLBbQ2LNgz1jCbg6tEbtGNZaFWH6z3lk4LI9RvJ5By+HgaXg7VR8HmLK8x4e0fgi2DEagcPvGIjB3FtYwCJd7wjOwWXoNaLT2URXD3wyP5DbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aKv8YI0Q; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-31d6e39817fso1814197fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757015619; x=1757620419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycqTB6thnqwhb8b/SV8IvlspkQDNTFgpikundNYbTBE=;
        b=aKv8YI0QWlRvtvHPcY37//scbXPhhR0mlDD9ecBgwcVubi3Z8UTXWGXJ1seO/DJwA7
         1TCRur06rHayBL5w/YJtS03hdY6xzuzmALsHRRQcn9bdepjYPiFVzSxPOrvtCJC8DEcb
         MvhA/Qr1wCBqnMQkJ6R2n2bIvg+IfmcMQ0y13hXgrV4lipy5Wg8J94ox2Um+7/bV7JIE
         wjfJi8QKxvfnf5GWmNoi1+9i+Y4kwhV0OeEzniwWDlkmtzOGOIoyTtkA8IcA7Jd6gfWL
         yVsrjcx1k9PKsgLyzsDFBmqkIH6sxAjL1nkemoC2efvb+FaJ8ckIrGyaaQLncRk6M6N2
         K4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015619; x=1757620419;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycqTB6thnqwhb8b/SV8IvlspkQDNTFgpikundNYbTBE=;
        b=IDJ8j54/TU7sFTYeVgRxursEDEO5ajsgbj5ADlmucTgVgYkb2/SAXcSTuURc4Z+3ss
         byjE0OcWyjsTMnYU/FtkLOB+PbD87AVuqUmfJtkkxTgdwkNAGGKSHYj6KbhpyQPZFU89
         wPwo/59wH/evglO+nVROMByJ7hd8X6qH+Nr//5WubVm3J5ymfLlq9EU35yCrQkBA9e3n
         DjhECqH6oXDyp+ev9WDzJC2yGOdKQwNk9p0YiVPiF0GdOz6QmZgEihM+XIB/1h42aaTd
         DQB5eta284ikxup/9F0S3R+O0CU6jh7IYnTehRIxcaP2FjYrJkWOYu/CH2HcvkpFIK//
         UbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfRC8XcCMGsXz4vo2TG6nRnX2rhwxYQGvBk8JC/dIdf65HxWMn0tcceNpNwHDa9AbhMgKspxz4GEFqJjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWT9WvY9S/a7tlqipaR/7MQu3qKpAy+d20fkz/Gj6oESSOGvVN
	5o8J2dA5JzUZxfCcknsU0BHk2IC2x+vC5bsNFJMn+PoZfoHHZT6GBl/TC2yxLvGnna8=
X-Gm-Gg: ASbGncuH1ApX+EkBVSDK7nV+z3XR5kTSLu55seffxKL9pjRlLJKjjMVn/lencv9JAe9
	bWXdJID9ChUcpo1ll1OZ40hCa5CBGPcTL8WUmURsci9FbTk2aMJZ2iMp6ghDXPnN3nydG8A8oZk
	kSDNjvHyQWDVp63df1VpqS7lDeyMFMnn8KdzZmaGRMZQBUKElUJP7YppfHTglUCP4SdAe3VB04w
	ZkTrNT9+yvgxFten7VkFIZZvfYiERwQPxH3P8kmYsOPzmnqUz4f/3rZ9mPxJpgeSh7lIK12x5nl
	BmdI3SQXsKIIrbbcDB/uD8CcDsHKM22GGiH4LRuH+IkbuMmcDPpUNNXoXtuUgl8u95VJJUVjPMm
	tYeqp4I2d30h+tO2gKGa8zqIOkQha96V6RBpagk5y6UlCFuoRnTnaYZNeW774tUfdHQEKAvLoMa
	k=
X-Google-Smtp-Source: AGHT+IFwyubfgv5poWj9WA8rdnupYn5EFdHy40gVluAmFGy+k3jo+vFXnyG+qPRFeM1YEV/SGQn+GA==
X-Received: by 2002:a05:6870:d293:b0:315:a160:ec6c with SMTP id 586e51a60fabf-319630c80eamr11849895fac.14.1757015619486;
        Thu, 04 Sep 2025 12:53:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a178:aa1c:68f0:444a? ([2600:8803:e7e4:1d00:a178:aa1c:68f0:444a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74647c1c2f9sm966799a34.1.2025.09.04.12.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 12:53:39 -0700 (PDT)
Message-ID: <1ae7994c-4943-4a91-aea0-218c5bd331b2@baylibre.com>
Date: Thu, 4 Sep 2025 14:53:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad7124: fix sample rate for multi-channel
 use
To: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 11:19 AM, David Lechner wrote:
> Change how the FS[10:0] field of the FILTER register is calculated to
> get consistent sample rates when only one channel is enabled vs when
> multiple channels are enabled in a buffered read.
> 
> By default, the AD7124 allows larger sampling frequencies when only one
> channel is enabled. It assumes that you will discard the first sample or
> so to allow for settling time and then no additional settling time is
> needed between samples because there is no multiplexing due to only one
> channel being enabled. The conversion formula to convert between the
> sampling frequency and the FS[10:0] field is:
> 
>     fADC = fCLK / (FS[10:0] x 32)
> 
> which is what the driver has been using.
> 
> On the other hand, when multiple channels are enabled, there is
> additional settling time needed when switching between channels so the
> calculation to convert between becomes:
> 
>     fADC = fCLK / (FS[10:0] x 32 x (4 + AVG - 1))
> 
Additional testing on top of this patch while implementing filter types has
shown that this formula is actually not what we will need in the future.
Rather, we will need a whole series of undocumented formulas that depends
on the filter type.

I will send a v3 that drops all of the AVG stuff.


