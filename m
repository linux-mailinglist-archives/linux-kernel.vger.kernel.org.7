Return-Path: <linux-kernel+bounces-890240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B136FC3F962
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA5B134A236
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7078A31B102;
	Fri,  7 Nov 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCyXOSn2"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3AA31AF16
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512729; cv=none; b=JKSPyHYho1jvdCwRnDh2amyx3LmanrsP92XVz4es9uoB10wPI6Qz2NrO2bxeQDRYSV1CVmckgPODtr/jS+Ci1Xh3bB02MRKZzKPhLNovBTNKrwhvhi6wjQxm7K0JgDrsUOtbCIUn5aJOl1dE/0+VgvW9TIECg4XBHsJeGU1AZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512729; c=relaxed/simple;
	bh=WuHzMktzE6gbPcCa9AaFK1s/gMpegfguRgYRmiSyxo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bVde+p5pZZlSqwKRlU2QiXZ9uH3wjG7ZiNELGUouxASR/a7Y3O9uQv99x0ng7p5Bte5GtwaVAcMjN9dIpGgNtVQfjcx+ifwtQ+6z8wRpLc6QPVUcf7NE5pWnkA5PYYMz951d12QAXaKrRjaWrCIeWm8WKLuxf8hdYFLiSRofcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YCyXOSn2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429bf011e6cso591728f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762512724; x=1763117524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTrexb0u6tSYPr3HO84uJPMTbVPfnWUR58r8WEvnPcg=;
        b=YCyXOSn26JSpAkjThdkp+9EF6KFbaMlmVThB1xNQ+mxGSlYeg5fbBcAFcNdpwlOuFj
         sAj+t1F/zsGYg6l+w4ixyB0NLbD0vOgAhOM/B+PPHy35DfuVKdAtujicuCr2Zk8msj20
         JqNmbzIvgkfQMPJcPq2GgpzWWrQ/HdoygPD9ON8Keq5I3iVQRNtgIF0KB7s7Zp86q4si
         TDlLw/OX0LjO4mD7SD7uBHVvd8gXTYJLhnFzfd/32PmoXJzNdV6g42sDFYZsX+iJ1EYh
         4BOM6oq87rC+U1g/3Vwe24YAdDCPb66jHBduO4VvWhjC802Z5FL6L6I9+6ZNUvZN/ayr
         gCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762512724; x=1763117524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTrexb0u6tSYPr3HO84uJPMTbVPfnWUR58r8WEvnPcg=;
        b=n31isUDUiTbnF/6AgepcGzVGIiftmSamaeH5JEvAZuAt/1j7lw43kwizf+E/NN5jK3
         +P5hi8QoaLdRrSoPZsxqT/CVAKmtSrF/bQEfbwlmN4x1C9RIbh80JMQnH9E1QbuEjMAT
         ZHkAV+rS+aNdUvxma2hGa3/Zs17Wyt1whlJ9Ziv+PTxHEAgsGVdE7/xO+XbZd5sKoBfm
         BywdTRYWlxaMohJmsIfpqLycPy5syjIlnxeXNlMTleEc5PtrBpaG4/7SQMkDs6SfKfdL
         s04gee1h4Y9MG9BmEp5zfP6npzcScJCZeJlQm6vnkGeX7jgF9WXbNN6atMKtr2fPxZfh
         M4Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU274X8yyW/jstSG7URezA2yKJX/QEAwkRzuiHO3tsNx3Jdb7SixBDFAWAl1mdV8eNYfwioOTfjQPpr9Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYpqSd7BLwYL3vK/uhRVfvxOz8q+R9/0OjS56pMvGXb1kWmz4
	ArnP+cmnWYtf1a/91K1tvej3z6VNF7iny6ZLAcJGwwLDlZWQRtF7uA3P/HoIulHnHalDodBT7CJ
	jy0gcxknH0w==
X-Gm-Gg: ASbGncsG4yD90IIRtugGKLOYvZyYiJNn7dF6Rbi+WGVmHGcMdCMwWtBCE6zhpXtc1ax
	yCAVFJSbsOEoH9Xa3Z+zDzp+drDLYHLMayDLHq4wOANqhfKcpsCS5oYxNVFsHg2IIUeriJIOY8I
	8jKu/t7vE6CFN6ahf5986A9yl2gPYJuZ9w8x7MaozQ90mkg+qXtVWYvoCOuU7Qw087DQBtMuDHZ
	1kKgz0KKSJNPA8G+9ts9CK4kNj3gdCGcC5/yQb8d5Kj2CoCHEI150HfRe3ATucyFllclDBLfXg1
	Zo42BFYXlovSe4NC5guy8dNgjmrjWabiOgPEUfqiRdC8F0xGfS+Us6JmhwIHpxEHU6/2uSeVlY5
	PhVaO0MHkmLmccAAnVDtfi0yLYbYWW+i366gQ3Lpoya1kICdQbzKjT3ZYDSSZ+P2cbxAbgUlCc8
	EQ2qI3PeouCSZo/AT2Z60J7YOsxWSMij4FW2fj
X-Google-Smtp-Source: AGHT+IEmQpnNBFYWzpfJdKuD1IaHFPWhGTqjX28uqEOqjFbhNv4n2SYqLCAXXGRJGGs0tqEhtXHmkw==
X-Received: by 2002:a05:6000:40c7:b0:429:cf88:f787 with SMTP id ffacd0b85a97d-42ae5ac44ecmr2296949f8f.32.1762512723615;
        Fri, 07 Nov 2025 02:52:03 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac677abeasm4446514f8f.33.2025.11.07.02.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:52:03 -0800 (PST)
Message-ID: <a0ae7361-7270-463d-864a-5f30591bd16c@linaro.org>
Date: Fri, 7 Nov 2025 11:52:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] clocksource/drivers/sprd: Enable register for timer
 counter from 32 bit to 64 bit
To: Enlin Mu <enlin.mu@linux.dev>, cixi.geng@linux.dev, tglx@linutronix.de,
 orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, enlin.mu@unisoc.com
References: <20251106021830.34846-1-enlin.mu@linux.dev>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251106021830.34846-1-enlin.mu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/25 03:18, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> Using 32 bit for suspend compensation, the max compensation time is 36
> hours(working clock is 32k).In some IOT devices, the suspend time may
> be long, even exceeding 36 hours. Therefore, a 64 bit timer counter
> is needed for counting.
> 
> Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

