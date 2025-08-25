Return-Path: <linux-kernel+bounces-784669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7FBB33F68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C08616934C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC57189919;
	Mon, 25 Aug 2025 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/Zwb/FI"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B281991BF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124984; cv=none; b=n7qLMdvc3GWXAhG2d37tMn/psM04tM91reV0cmSn1EcK9N3Jw+NRXsq5eqnu7KAQZT5ChPftTqO5+yS2cNXF/QMjZ5lMzanddNJOfYUzPfCjD42NUSPQxJ1HpHw58IHW+oRDzr2tRq2x4zrzdoKe18u0UnZ63pTbXCckUUnScGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124984; c=relaxed/simple;
	bh=jiQL7tU9QbcztiQhi7qKT01sqNx/0iK61wo4QpQbNgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzH29Oj7YPG93MwgZ6iPQFAYLtQ/XmHoj74DW5lgJeBfgyed4KuVtCF66QD9lSnzrKSDj9LTY6FOD519/cD1r09s/r40XpClqLlVB5I15iQ60U1biIfD2UOklnxtAbXMyhjMeBm1rOKiJnY1aVojitKHuAojD0ksuFKclMPIPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/Zwb/FI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so32992135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756124981; x=1756729781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eai2SOVFyKY7uDjz0RBz4QRcfaX15jQWQ/bFhzOuBu8=;
        b=S/Zwb/FIRNe9MsvoC+QVHiPggARJmZwqMDvtikOcrW+YkNC1NCTqpcg+74e4/nuZAP
         IAUOdS0c5FhdSMDXxEWqZaYSfOmKIJ/jFr41cqnS2c+0NXh8WkWDBJnQYDPOSKHQqwu6
         LEUpWzq8GFVZYnqQgHeNFckYNbuutje3AzRD8KzDQtz23RoeZWDd+FGNHPOioiTN2uZK
         36EYHvgrmkthWTwmFQWbXT3xQGsQ4dAtc7lnuqYTBVJyNd0uHL1xuL0vtdSF6uYZYCMR
         HD4EfNF75qyoFUj2r73ETIYFTF416+fqgvOEy4cYB3AnXVSObLUQVd9npoo3n66m4nON
         ypgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756124981; x=1756729781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eai2SOVFyKY7uDjz0RBz4QRcfaX15jQWQ/bFhzOuBu8=;
        b=RuFm2nJLsttM16OgCCuKY/dqOo1WcpjjGErG1vqMBquZl8LzRhHpg0Jnkzv68G1TmC
         Ld0Lt/NXUdqjztI+JW8nVxsY8SA5+VXx6Yy4xJrshbWW7k0ykNGVd8uNNmmCfwhtfeIy
         gmYyO2347BMAD0CpNTRnL6d/G1CYtAMJUbt2UT/iPBu7VsXTXBwyMcUqYqCbNzQ7b37s
         s0oSe3jOvJERjGwvefhl3qp8pL9Ky8adtKGo4Mnrl6Da45tazUr5WeWIs7bI71pOxybk
         OXvAwjd9O7H5hkZPLP5CDR+KVGPMkP4Rblk0h9ihQI4n2H+llJORvdY7+TJEeNxaFCom
         Si7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMUYLNQ6viI2plYy5sEqHfFFhXkzT923awcET+truWQihq6JCYewZHGQh+nQ1loZMw9VPdyx7IBKkOgMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqxyntO0XjqkeujqzDGd1FjPRzS+T+gUHm+cOhF2txNwXK1Vd6
	kYnJ8x2737mJKgiDZDhTkuvxV55gw94xymw7QDa8cI7THHYCNfWqzGhYd3W1hGKtcbs=
X-Gm-Gg: ASbGncuKWugr9yLMuyLu9MLfDEM96Dj8jHxmot7pnsoYsq0zNig2asdq6Sjcjm9zjQk
	Rr/SPKEI23lkb95OIVNj30Gob/vd8NimgKnEGNHS/9fJR28ZIlUZ2knsWN+g/yrGVpfE9a7iNkX
	64OOEoR3as2gAuf5kmEG+bCVUR1w3VDeuIckCMT25ToBTMYwe9MksbzuQL4pUV7XPOkb1DgPqkK
	4XEkT60Cwx3whp0MT0BBgZ4isPrOUe0zXXqlhWJcmpOf8OenH1rVj9I/hokzXqJ/njbQNeLfNBg
	442rJxwp+icOuQQEi2pRUHL5IT/lGWUa68WIix6Sufx59EPVApc88zHgNkxB6kHAkYr5+/rL0s6
	ihb1hwUusaQennhYprZvlXL6HSg3zvrg=
X-Google-Smtp-Source: AGHT+IEv1kH6bqyVtAllBNsNRCwow2nM6JC//3mmwEWBmo85Nw3V+P3tVEs7CQiOJz1KhUJg0ZYTeQ==
X-Received: by 2002:a05:600c:3b95:b0:458:bda4:43df with SMTP id 5b1f17b1804b1-45b517cba02mr109565765e9.17.1756124980706;
        Mon, 25 Aug 2025 05:29:40 -0700 (PDT)
Received: from [192.168.0.251] ([82.76.204.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753b77dsm113994195e9.10.2025.08.25.05.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:29:40 -0700 (PDT)
Message-ID: <c89c7670-01c6-4002-a269-08cf19e1abcd@linaro.org>
Date: Mon, 25 Aug 2025 13:29:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: enable Exynos ACPM clocks
To: Krzysztof Kozlowski <krzk@kernel.org>, alim.akhtar@samsung.com,
 linux-samsung-soc@vger.kernel.org
Cc: peter.griffin@linaro.org, andre.draszik@linaro.org,
 willmcvicker@google.com, kernel-team@android.com,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250819-acpm-clk-defconfig-v1-1-70f5963ef90a@linaro.org>
 <aafe8482-7017-47e8-b035-7adc49e69a06@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <aafe8482-7017-47e8-b035-7adc49e69a06@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/24/25 6:00 PM, Krzysztof Kozlowski wrote:
> On 19/08/2025 14:21, Tudor Ambarus wrote:
>> Enable the Exynos ACPM clocks driver. Samsung Exynos platforms
>> implement ACPM to provide support for clock configuration, PMIC
>> and temperature sensors.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>> The patch should go through the Samsung SoC tree.
>>
>> The driver is proposed at:
>> https://lore.kernel.org/linux-samsung-soc/20250819-acpm-clk-v1-0-6bbd97474671@linaro.org/
> 
> 
> Please send it with above patchset - it target's same maintainer: me.
> 

I noted it down for the next time, thanks.

