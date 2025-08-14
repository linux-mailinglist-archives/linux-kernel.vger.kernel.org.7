Return-Path: <linux-kernel+bounces-768302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2109B25F87
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A83D9E1CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6B2E9728;
	Thu, 14 Aug 2025 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tr7ERJbE"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEEF218EBA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161432; cv=none; b=ETkek457Oh8Dh5vfjSdrr90vXoiwnoQXAhLXi+1yMaCOzm5S2ID2pOi/MeiwlvbaB3it0P6HOCR7akQzY1MkAPK3XwmD5C2QL5UHTEkmC/vr3JV02XFccsoJhT1UtW6hmDZHfT4HcRzA/v/o1FQxsvmfLthjlgWSCggxnJ4ZOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161432; c=relaxed/simple;
	bh=hW/O9G7IgmILusfUj0IWPaVApb+q/27reNADXspEMho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9EX5xYIzHbz08TrLDCMFa2CdJSXXW+fHII6EUNZ4tGJtMA8j1RH0KnSPnkeuvhkZaXhF6O8oaVM6w4dSjd7othtHXmRZvAg+azmxxd2x87pYhfzkEncgFmK1qjXdda3dy1JYdaR/DTfhAA9ubrUfukF8Nh99BTArmKVyilDOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tr7ERJbE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7abfc5cso119556266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755161429; x=1755766229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTNSw9oc6wzrpyE+IZc30gYg25qmqZrCj3OycJEGey0=;
        b=Tr7ERJbEFVy3aXDtqrb5IqQ2x6B6H+NtG5E8YlJqQ5Ggv5Cq4oR6Zwzr6zQ42uf7j6
         GZsNE0g/59yU/75I/jy1XhtoHJl8aC8pd/elRlAJ7UdcRH7w6dxR3VVQxCcE6Borlf8z
         dLXg1fZj8atCk6FsOMhCjKSZKhflZwWf1WDU921NFxboBG5TcwgrHT1gTmCVqbgxrhFv
         rF5Ze0bg3QTH2Fz82JaHqE1QXiMWcJFDY/S7mapiL+4sRKi5ruZqRd4O8TAlPfMZnSO6
         jZSrpJqv/R/N8aHqaQywKeM3V7ZLhQxnAm7nj/jCBJfOSV45nQJqKjC01nv8bLLbweyf
         nDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161429; x=1755766229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTNSw9oc6wzrpyE+IZc30gYg25qmqZrCj3OycJEGey0=;
        b=vgm12DVleXZIFEfZ2DEH3RWouGsqiOH503aFnRj0N0GqtziciYDjTWM+AudmRwSIdD
         xhfz0qdSSlmTlC8c/YME/YBj1fDsGdHzrZt78mTA+BOPtlpvRMo5xI7mpX51Kz8eNFaD
         8vwsMRni6pt6Czf2C1WTPnHRKmQU8TaBC3cjPqIy2USJ0tZjVpFxMJLJcbmxBb8SLAMM
         7+Krq5JXcKDYG1vuYpZ+zmPaChG7EF22l1268GqT9MJ8/ETmL5Z9aAWXR3QBYxsU3IYN
         rwkI7o0TXLiSBqSse4hDnweAYJXSN6K1HVjtmHrkLeRyoYvrNltgZgopsVW+OrRiagdt
         hXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJa5BKuxMR52QlBQjzqDX8NccoO8Uh2pVi4v3DgfzhBLk6AyTd/yatvwRJewUuhLVqhrmEXjfvnzWJuEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1c8kDknlaDgpOyHi2Xd6mdOkMXsFkB/hIMFZoi3JpSKd/LXE
	kaoJwA6sfn/tDBBil4kqUsN7wKcTS8udFS5tgKx8jIF3UhfeIzvnOD7h0nOqxS9b3PjtTBfCeL/
	uHsnI
X-Gm-Gg: ASbGncsghjDXzH4hfvjR2AY2Q4aKukkadLDHCcwinQ8F9kRS8PqcEOMyJAcSaCDpnmk
	o+GIgSjqVkqVNZANTS6/YyJfDo198PeaaCHE/sNzT7qqbzgUhAUrh5Zlairhfz2kgG4dTu3gygx
	JTlXBmNfT46JDdnxwyGpDsnDhCEzFVQWTSu0WOrIwZoimuHWAMaGPnZOwTB3JuDrbGQlAKrKRAe
	Qe1IihOpf9E/Q52e/vxnrs/Q2FpMq8sAOcd6zbm0qHWm3nN5q+ELcCE8nXsDk/QWbzpNgzeNmaL
	jAI+dk0WUStmU+HTMPX7dK3rTWE5PKi79z5VVSdKR9AFe70Z+ZQE9X5F1paRbEUvQYMkMdjuFSB
	KmFfVssjq3MQENOSNUBnw7h+Q+C0VlcmUnc4=
X-Google-Smtp-Source: AGHT+IHLXrSfTIPAKGMxZ00QdZB/8mDbm+vGJBS91ORg//JjE3LnG31wgWeozZezROslUUb9Abi/4w==
X-Received: by 2002:a17:906:9f85:b0:af9:5260:9ed3 with SMTP id a640c23a62f3a-afcb9799755mr188094366b.14.1755161429200;
        Thu, 14 Aug 2025 01:50:29 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:b68e:8fe9:fd92:805e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99148eab9sm1604853966b.77.2025.08.14.01.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:50:28 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:50:24 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/9] arm64: dts: qcom: x1: Disable audio codecs by default
Message-ID: <aJ2jUDaBAgeRcYfz@linaro.org>
References: <20250813-x1e80100-disable-audio-codecs-v1-0-af82d9576f80@linaro.org>
 <5de00c2e-2b81-42f4-ab17-6db0f1daf7ff@oss.qualcomm.com>
 <c4a63197-9fef-4261-a0e0-9d57e009263a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4a63197-9fef-4261-a0e0-9d57e009263a@linaro.org>

On Thu, Aug 14, 2025 at 08:07:17AM +0200, Krzysztof Kozlowski wrote:
> On 14/08/2025 01:09, Konrad Dybcio wrote:
> > On 8/13/25 5:58 PM, Stephan Gerhold wrote:
> >> Currently, the macro audio codecs are enabled by default in x1e80100.dtsi.
> >> However, they do not probe without the ADSP remoteproc, which is disabled
> >> by default.
> > 
> > FWIW if the ADSP doesn't start, you can't really consider the platform
> > working.. It just does oversees too much of the SoC to even seriously
> > consider using the device without it
> 
> 
> I agree. ADSP is supposed to come up for every or almost every platform,
> because it is crucial for USB and charging.
> 

I agree with that as well, especially because I have an upcoming patch
series that allows reusing the "lite" ADSP firmware from UEFI for USB
and charging, so you don't even need to have firmware present for that.

The question for this patch series is separate though: Should we enable
the SoC audio codecs by default? What happens if a board does not make
use of them?

> It's true that LPASS macro codec nodes need resources from ADSP, but
> still these are resources internal to the SoC. We disable nodes in DTI
> which need an external resource. That's not really the case for LPASS.

The reason that triggered this patch series is that I was seeing an
error from the va_macro when testing on x1e001de-devkit. That board does
not have DMICs defined, so it doesn't make direct use of the va_macro:

 va_macro 6d44000.codec: qcom,dmic-sample-rate dt entry missing

We should fix this in the lpass-va-macro driver. You could take this
case one step further though: What if a board uses none of the audio
functionality? Apparently, X1E is also going to be an IoT platform. It's
very well possible we will end up with a board that doesn't have any
audio functionality. I would argue it's valid to use a minimal kernel
config in that case that has all of the audio subsystem disabled. That
won't work though, since we need to probe all the enabled audio codecs
to reach sync_state().

This might be a Linux issue unrelated to the device tree, but in my
opinion an audio codec without audio inputs/outputs is not
"operational", it should not be status = "okay". That's quite subjective
though.

At the end, I realized that x1e001de-devkit actually does have DMICs and
I just need to enable them properly to get rid of the error. I only sent
this series because I believe it fits better to our conventions. Given
that I don't need it anymore, I'm also happy to just drop it. Let me
know what you prefer.

Thanks,
Stephan

