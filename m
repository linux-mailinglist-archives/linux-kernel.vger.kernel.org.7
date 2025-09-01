Return-Path: <linux-kernel+bounces-793897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B423B3D9D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381AB16FFE5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F9F254841;
	Mon,  1 Sep 2025 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDKvjeYO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA281E9B3F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707910; cv=none; b=WcjN+BdG7egubtCt1osW5rD+MlAyrq5yZWz6Y3LmZucLD7oH8sxzyelRvbySvhgP9mAUcb3+wFnRc498HKeL+81WNEbYu6Z0aLkdg6PWQIyiPW22rRtZmLlJB03PTMxDtVjm5Ovwkzo98tNX0qbzcp8HYy8cNJ+IVmXoPliQ/rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707910; c=relaxed/simple;
	bh=5tEFRvyGeKDN+x2Ei9Cj+rHE7MmPIKyHBlDmb1SmtGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7Hl5dmxTxLGzUjup9dvL4QCE8LvNL15zawZ/QGCLFPdy3ubyWzP5zKQTlna1J5DA+G7TilwIlKrHGftqQwWwdigjiWHmRdaRkuxi39j1t1a1+uPLhP738dxqvshuHk819239HhBi0gJTwSj6cGTdQgf+OOBai2xolB+xnFYOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JDKvjeYO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b873a2092so12061125e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756707906; x=1757312706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YeKuNtpPLqtxqq8gC2tE+cTRtA0VGDqCWttaxdOw1c=;
        b=JDKvjeYOO/6HDrP0X+HHkWGd75rKWnbeZl/5VBOLYpQoPKXtFqX5dbwIKAm8QysPGT
         5NpMTn9JKuXTSluQyPoG/yGxLVvODNUlVtXus+Kfd7ZVGScS+WPnURCutJ0IaVALK1wK
         Vf9DzIZI+Eol67nnigq6GhdsFYfI/frYX2huZmoMPN0P8PM2mvtKGUI2O1bkSerWURug
         0F9+k3ANaVx++ezFQm9KylhlTxs3gXztLa/oFi0ABlD1u7o4fJ3BJMUSA/LTywiTo7+D
         zrqwfcMSevmVKE0qRzeZrV61g12N3gPKC+/eznUYvIcWbohVkQGzFByDt3BWq95YfMjo
         4nbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707906; x=1757312706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YeKuNtpPLqtxqq8gC2tE+cTRtA0VGDqCWttaxdOw1c=;
        b=Fu3wdjY4n2J58HCGh2ShcHWwYG08R04OMw9DzEVn5rExRoEYIjyMD5ijYz9p6J0+aJ
         kDsBnfMIXAPtWCJqDR66xf/56ywFoHAnrQPm8MDvMze3bMPXP8jDxYxvBrKIB3y/GFEz
         gLjP1ukcVOmTeUgd74K9cOVq5pU9q5VnosGELpAz0KEPCH94SWz34SQz2g3UB4Sg2KLR
         /KPkCbGQK5rL9HhU+WZbMedaavekOid9hnVrBpcgU38c0Ep842hy5fNFSrTFCBQAv2sD
         G+zlrxrd/0B9kDtOVL+52xmppJr0xUGl+dQHhVZxxJ/+7C9YjtunHcHmlRY6nSZdxozr
         dpBQ==
X-Gm-Message-State: AOJu0YxDyDWCEpiDCK3hHEta5amcvpHTXjnsfWz3Bysd2BrQYYup/bT7
	5XnAm0uPqQKIIRAq5JJr/LXKNDoQjIKomRUZnhdLuZw7tBlnVBJ8+0ns7m2no01hzz0=
X-Gm-Gg: ASbGnctlDfuuxtNW/dnGiNxz8In/jrmgQIWyd4c9hNBu15LdhH3jBAMiTFQJJ/fseP4
	DJu2V5N5rKwUUU77SIyOEffinAEcf8sh90oq0uZdqyUqK1rWZU8YZGHkk3OUWirtsr3u+rIVl5O
	/qN9JtovdexUHCmvjnuKqiiehUPHsOFQuIziwqWAoZDkvzzafayG4pXcSQ1tmmd86uB3Mlrl7lV
	GMCa07cFibYGSMxPDJmXio7P5EE7+qyUH4pBXAwi64S4MuJxH/gS/AMJLFWx6dnXJdZSMjIyZ6X
	1azz80+bRhZVHsMb8vx5tL8gtT/uAKN2bPzQB9LwuG7Hg55XRya0mMfCTzWIyw38LoHe8C63AtB
	+7EnIxBeTBkLhMEg9U+FZ0zYCPki3aonvqr/Nj2ge
X-Google-Smtp-Source: AGHT+IHnke2GT0NOJivpigEQtNHBZdI155ZzMIvdBsIqtx3ducDptv4HE++iJXeOAgJzi8Q9MoWEvg==
X-Received: by 2002:a05:600c:3b9a:b0:45b:8866:50fd with SMTP id 5b1f17b1804b1-45b88665357mr41091535e9.32.1756707905579;
        Sun, 31 Aug 2025 23:25:05 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d3a7492001sm7507997f8f.42.2025.08.31.23.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 23:25:05 -0700 (PDT)
Message-ID: <788c3aba-568d-4297-bc8e-f47921859d57@linaro.org>
Date: Mon, 1 Sep 2025 07:25:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: firmware: google,gs101-acpm-ipc: add
 #clock-cells
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
References: <20250827-acpm-clk-v2-0-de5c86b49b64@linaro.org>
 <20250827-acpm-clk-v2-1-de5c86b49b64@linaro.org>
 <b5d0e355-2681-4eaa-8a67-82a364312ec5@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <b5d0e355-2681-4eaa-8a67-82a364312ec5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/25 11:40 AM, Krzysztof Kozlowski wrote:
> On 27/08/2025 14:42, Tudor Ambarus wrote:
>> diff --git a/include/dt-bindings/clock/google,gs101.h b/include/dt-bindings/clock/google,gs101.h
>> index 442f9e9037dc33198a1cee20af62fc70bbd96605..f1d0df412fdd49b300db4ba88bc0b1674cf0cdf8 100644
>> --- a/include/dt-bindings/clock/google,gs101.h
>> +++ b/include/dt-bindings/clock/google,gs101.h
>> @@ -634,4 +634,19 @@
>>  #define CLK_GOUT_PERIC1_CLK_PERIC1_USI9_USI_CLK		45
>>  #define CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK		46
> 
> I missed it last time - this is a header for SoC clock controller
> bindings. ACPM firmware is completely different device, so should go to
> its own binding header.

right. Will do, thanks!

