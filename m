Return-Path: <linux-kernel+bounces-851778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD8BD73AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17953B24F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0662F7AAD;
	Tue, 14 Oct 2025 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtwR0fUu"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27643F9C0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760415462; cv=none; b=Jny7vn3HVZiL4qfVYqDbnvmldaBdv76h6Rp0eYHGdJyQFXUiVGfmqwN46peDgI+Fiw3CAz+LbfG0czlLCLLWWQOLzqSXirnCXDDDSaQja4zmZPA8DFxq957e9Ka+f0G+OF145cqqFKkc70b9w+DZ5vMOd6alN52OIb3jxdfFf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760415462; c=relaxed/simple;
	bh=5vYCe86Mb1HKAnBIUju9Gwlynye3K2vfk/zvcQRnmAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuGn/XsEbPF5IlOTP6jPlX8GwfHFX8ynKg0IOWo/qS8qx8EaHwfhH/tFvVD9OGcFotJXXs014/dr+n63bEIXvuvNpqUt4eDVF10gIlCtbfMj42OwTBqdMi48sd1wRRU+sJyqPFhsigPXZPuEfCQwv9vIH/7z242D/SFtoyUSlEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtwR0fUu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7811d363caaso388560b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760415460; x=1761020260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=arjU8c0gMWG/kpgGcSvie4tGWMyvwYL1JUgLMfyHiAA=;
        b=DtwR0fUutxGD9wHwuzAIc0MWrPqsKTTOI5hGv6oDMeH+WtBqoQzN9gAcoZCVyPT5cg
         1d79vB4MXIwmtDvtnU1BiVvbwAu+hMOJ93EBWplLOATvd1hsOHKQSlQoqaobcx4bulli
         qz63PtdmXOLsDq1TaOlFjWs/ELVJhSncBn7LkuM91UY1mb+9j8vhbbO78afhfy6ZniSi
         XEPX5MB/XWvivqRhEpQb6eDEbBt5I+X60T1hr39Snj/MN0Zkr//Thja0Z68MMsYKp42g
         hh1IsLPbmThAjoezSunQdvKiwYN9+5gtbbtZBwd9oogz8nZQ7JYjF3tiwB+8caZmGUOX
         7Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760415460; x=1761020260;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arjU8c0gMWG/kpgGcSvie4tGWMyvwYL1JUgLMfyHiAA=;
        b=cZwqxipcx2Vh+mKWgNszmCeR3WXAdOAE1qMZDElc/Qjs7ZnXt7qooqG+AMEHfFWwrx
         u+FT98N0mWE1c4HmYgb9ZzysrB2110iOvNeprbbVVRZ9Oi2CbKRQTTS1MFkzABjn9Xlo
         z85umeI1ASlalx3ozmBFI7VS8JUOob9/MUMfPRkPZ4PmS2wx3qehXUU7gLygl7iR6vrr
         e2YAzkvV3U6MkAePrBZFUw3IQGJ7LO+XsNUaxgj2p0yKcKJdjn0chs2tC5jJxB57ZdHr
         tafkrINxPKtrRINo9JSI9Xdg1JFNaP+bAY+7xgQQdBJGsdRUoDN4rEW2GC37vGsTGCj3
         9Zow==
X-Forwarded-Encrypted: i=1; AJvYcCXANSMR90Z4jhfryF9u+mvAlLB6mEOReS04GIJMRb7i66XCdthtjoIqs7ym2IWFFyV5FJOdCFjnHUeKHpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXEP2tuJKyhY2YeBXV0eGwhIW02qVd6YVzWjdAVX/VFRZV4Q0
	3gxoWdnywg+XRk7iXL9aLP5pyQpWILbiQxr4qI47TISu5GDN7FprJ6n31Bk8l2l6iYE=
X-Gm-Gg: ASbGncu2zk66DSrVcFlP8+tJm5JCNsqdQzaxyYiF0N4Yy/1o4mTkEbsGrsxROQsXwt+
	w+ZTzTv2jibnykuHOffOqQ6OtfdpwzWAQtuP8TB6nMAO6gka3R7FRbL4BU98q5RESe8ytaDIpDO
	ymtJkDG9I9NZ5MclqYEXNG6KlWQFidyKnLFHTTvtM9uGJ3vRgVylcdwmwY988F0rsR9CQqbh11V
	ej/KCdpRg+ECAmbMTsXDGEI91YYUdeIyoTlphUcEBZpIyFtEZXMJSCJ97exLLPMlwwSBT+5IR81
	3s09zggWNKl6lxsqdADQ6EHJIXQ/v2aGVTWVO2ZnWBAzqTYr7GhKb76hHpXR4CKznRNe69/zzD7
	0BOJixqpIeyjuR2Ol4K16HnswiDCkkbV2mHkvlyuok+YNJ6vf7cCSYNbyxfQQnXTZ3Bc=
X-Google-Smtp-Source: AGHT+IHFEXB/njPZl5vxE8uZyWSWxsbxvMZmEol6YVsnCuQe564yWg6QCF5koIs1s2vhnIhRyiS0kg==
X-Received: by 2002:a05:6a00:3903:b0:742:94fe:c844 with SMTP id d2e1a72fcca58-79387431905mr12997458b3a.4.1760415460242;
        Mon, 13 Oct 2025 21:17:40 -0700 (PDT)
Received: from [192.168.50.149] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb19d3csm13348773b3a.31.2025.10.13.21.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 21:17:39 -0700 (PDT)
Message-ID: <19c67d4d-ed6e-4471-bec7-893d93ba7a00@linaro.org>
Date: Tue, 14 Oct 2025 06:17:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Remove the redundent SCHED_MC/SCHED_SMT
To: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 geert+renesas@glider.be, arnd@arndb.de, linux-kernel@vger.kernel.org,
 peterz@infradead.org
References: <20251014023158.500932-1-shijie@os.amperecomputing.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251014023158.500932-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 04:31, Huang Shijie wrote:
> The patch "7bd291abe2d sched: Unify the SCHED_{SMT,CLUSTER,MC} Kconfig"
> has enabled the SCHED_MC/SCHED_SMT by default for arm64.
> 
> So remove the redundent code in defconfig.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

You should send it to soc@, probably.

Best regards,
Krzysztof

