Return-Path: <linux-kernel+bounces-801057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26002B43F59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A716B3B6695
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5631A343208;
	Thu,  4 Sep 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOj+5XHY"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C5342CBB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996562; cv=none; b=LZXHLgdqrmHTLM0KYDCv1TTZu9f8gBu6q2NTjYviE+YgggK8cteLF5Rffq3abcI7+5rbOERerGsT+BrrhViVg5+oTM/nQASLvmk0yDNYpg+6jVUYvj/R/G3TlhYG349CI/64VJ4EydlKCoakIjp9OvTdQq8L6qN0oVaYbHA5xWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996562; c=relaxed/simple;
	bh=2Knd2P0iOB5JzjpHNmPDbX2uHeBqvBGbNPeYzdNyIF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWOrRQZzK6BiVx2UuF2Pv2FWEd+tDPbKjZBHkr89JGEAqsq0PuTi9cLRKTPjfEh7aEuuTB4TzV76Z1uAt0asn31aomYy4fRrtg/+pflxTecFtW/+nWpvs8Owvb3E0kutvx4hzE0GB2P+Edz3gLQsS/K47F8F2Geyh2rLbRP8WYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fOj+5XHY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so8798125e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756996559; x=1757601359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LG0FGlXd3G2peuym8Yly6U3jFni4sREv4yKdwNH+S4w=;
        b=fOj+5XHY3DHADCSJM3xo15HikfYqzv5tp829rtQMwKDmGVsiFPj2JOcM+18oim3NGr
         hhze5bcjYAMYitvve3qTnRg4/wcsRe0/Aw76qwNVUqwPcrmBsXtXAFs/wxsCIa7AGuuW
         2s44MfsrfTVKMiuae15hxGmubCKcDEQKGTRrZTPwhmJ63UJLEXImqIqncL0AxiEY1UPF
         B9n/5gqpu88L75oR9rOUgM5mANs3VDG/GA6yC/UGC5B8Q4AJXna8qCfbvc0Idv6ldtYf
         YlDLm4cQN+58p/cC9W0JZOYpb8gDP9PtWN/tAGKmZpXEVTHbkplgQsRRyGaLtuHa8GyB
         kvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996559; x=1757601359;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LG0FGlXd3G2peuym8Yly6U3jFni4sREv4yKdwNH+S4w=;
        b=mFUB4HoW6z5r+OuyWYdWn07UJLN4cpEa2EmcpeRxme9wsIR84JDIkrHYJuy8AKz+jt
         CIB1/zVcRhrc7oVKEwXqNI/6SrcS9NkrsrBeN/bkPSl6X49JXHxmoagvuCPHC73j9yhu
         2Tv/ag179m8jFFlHJq72uLMgu3i04pYxwfqcJG7mGYNkcshPIlqvBSgGrCv7x5qh0Qka
         Q43V+sTNgDX4ovwI58r7kZyS7yWVrWowZefDLzil9R0xKR0tCGDqc/FRlzcLbGmqd6fJ
         f0AxaMFF48TWZjW7CevHB0DaWG9mQHD6jjpM7G75tfj4+kQ/6cedfI0FfHqAu9p/ScwJ
         ar3w==
X-Forwarded-Encrypted: i=1; AJvYcCXhm+Ex/A1l2Ics9QyuPfC2Dtev1sq+OzEpFpzv8AJ/YojP6hvKX448esUvR1HR/oFwgSfD9+tx4N5b9vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCBQiHPdX91vXmotaMezM3bpJcrfiqmx6L+n8yt8d2Jf39SC9
	S3EuLW2Afesn0Wu2XZaaZ/tfCO1kCSsrOIGWUaA8ivzarmdmXDdKCJj/eGmtdyaKs0Y=
X-Gm-Gg: ASbGncuh+u8TVbAyFQij45lh4Y5Qz/+k2nTYyDSlOXu7v4yIsuWNBFr0oDHKJG8aLBP
	rnYfCnWGDAwMw5A6dh4GfbelbnwQp8psQEWgfiLkqoWsCltbuAp1tWGYa6RKa6/B/WNhBpbW9+9
	C4CqILjgiH4FsTVnutQgolQfET6HG5vwSUUpZ1O/RZLwgncwysOVIFo5QKHNoSMA8wA9y6ZCBIM
	G1uz0fAT4EWraXDqEm1J9JdBH56PcflnHCKtuxnSBzekpB483HZinf2/YlO8KbuhH7/Cwk1FGrN
	dPSkIIE0Jw0oVlPy7gb3u+t/drQldir2xeMg7DJwvE58j4ovFYVkfrPFqufrrCobMAWXGn8Ux8R
	cMNf1hoqLUh+btXHXIAFPlFKlkGCYyGmVNO6mb8FTDYIl9D9Hs0HKR94b3U5bvhb+XhD8VTe9f9
	EwlNmIJmWQh5kng1VVECcNel7DVxwP6Vo60CYQ8JaI
X-Google-Smtp-Source: AGHT+IGyPierysmXnmRPi654yCW/A9/i3MYkNNKVapSa3C2rY0Gnc8sqzngSNP7cLDSR+ketpOcIWg==
X-Received: by 2002:a05:600c:35cd:b0:45b:8b3e:9f66 with SMTP id 5b1f17b1804b1-45cb674d60emr49772295e9.13.1756996559062;
        Thu, 04 Sep 2025 07:35:59 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd05d0c43sm19336345e9.2.2025.09.04.07.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:35:58 -0700 (PDT)
Message-ID: <7672bb66-b987-44c6-9b58-dee5de2298b4@linaro.org>
Date: Thu, 4 Sep 2025 15:35:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: qcom: sc8280xp: Fix CCI3 interrupt
To: Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
 <20250904-topic-cci_updates-v1-1-d38559692703@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250904-topic-cci_updates-v1-1-d38559692703@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2025 15:31, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This was evidently wrong, as exemplified by the core failing to reset
> at probe (which would be completed by the IRQ firing).
> 
> Fix it.
> 
> Fixes: 7cfa2e758bf4 ("arm64: dts: qcom: sc8280xp: camss: Add CCI definitions")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 225233a37a4fd9f3d65735915c0338a993a322d1..18b5cb441f955f7a91204376e05536b203f3e28b 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -4292,7 +4292,7 @@ cci3: cci@ac4d000 {
>   			compatible = "qcom,sc8280xp-cci", "qcom,msm8996-cci";
>   			reg = <0 0x0ac4d000 0 0x1000>;
>   
> -			interrupts = <GIC_SPI 650 IRQ_TYPE_EDGE_RISING>;
> +			interrupts = <GIC_SPI 771 IRQ_TYPE_EDGE_RISING>;
>   
>   			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
>   				 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

