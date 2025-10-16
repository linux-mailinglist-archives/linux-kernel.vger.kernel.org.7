Return-Path: <linux-kernel+bounces-855575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63877BE1AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 914A94F264A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB7A2882B2;
	Thu, 16 Oct 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhkhkbEQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CAF28C006
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595437; cv=none; b=cGrreOx/heLmUZlbUufQfDM++saVKoQLcbUDK3Pn3zqL7gBjVQGlrXjOSYiDcaHsvwx3GqWnzOqH66olOKTCNVK3hJ4VX+BlX3VuAqGT7WDl8p7A3z+DcgAQFNOTSj5M6Jn2Ad+lyasLlmY30TrN4PUnskMxLrfiOlKFNFmz2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595437; c=relaxed/simple;
	bh=sQaB1M1HPBGBYtwxkEwYML6Pn/QhduJqbQWnc4tCjz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/XwfRUGnGfQ+GR9UQid2rtpr4DH+iNf7SoeU5+77nrOKWJm0uB37WoUWd4D/3C+0HET6OEM7VldoCcT9D1EIb98sTB0DS2Iz8UeFSpjBBeqH4GGKRH2DYNm6VpTHydGv389I1UU2/3t4DoFeAo1D2ON4eoJeX6DWJb7YSvA7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhkhkbEQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4710dc94cf0so155835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760595433; x=1761200233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WoIwPesL5XpR61/TvXRYE4HZ1QXML3AmqwHjRG6wUdA=;
        b=NhkhkbEQGYXyCJbK70KXZaBfJda/Lr2PL6EMlGiufP4GCwcOPhsnS+CKW3hlhHPnbY
         Bk3dYzzZCbf6OeL5hxUeAl4kphrTX6csSGiZHnhT9EAtFwqA2m9BlBMBEjsJnr1XSrHb
         QMiQ9/OixMxFhyBKdof/BBX2XM38RPyW5cVJtK5d0SvF/vO6gwJ44qnFR4hoyO1I7AaY
         NggRy5KjOGfy7LPSdgQ64dgkcHNL1pLHSX/SFUhdzN0O8V/y7zBsCwk8MUirssmWB8pa
         Nk2kbLVQBhZHG6Ff8GYwbcKMi5oyO35O7E/VeRWny4cpHOWsT2uEesUNAWmAipg5XJCf
         aFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760595433; x=1761200233;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoIwPesL5XpR61/TvXRYE4HZ1QXML3AmqwHjRG6wUdA=;
        b=ESb/r1pJPLqcyeBjwHxaMpVlen+niidFnCkrybqGFjIuIMFip0bldUt9moltt33YqD
         sSRSqvrN3Rw+nAHMJmCIX4XliHg1poatRH9iPs29DSP7/7DUuUlOoEUStC3OG4wbqSf/
         n+qZAcsovXWTUSUyg/m8WQ7sjDRz5MlolksTnuyp3/JioiDYFgl8sbQfBrHLrRj7fchX
         CLU6HoZ86FdmiC0UsPYBfy5bkPv1ix9UL8XnrJ9JD8NHspkcvD6KQ66pJUFo7cODD1dc
         Z7vllA2lezfvFXcvNV9WHi3nL+9y6QflkR1qymAOp+tQ36UODTillI5q0sn0uUWUvzhq
         pFeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMsTgpqLyo7uWacqRsQxW5IYyGer0zFChRFlOOalVV+icMwiuO/57yHrqTvBFK615eKmkEcW0cNkeviP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPFxEUw55xRDe1iRyP2oW35MWIsKJw5L/IMT+504Zunn4K40O
	DAzKS+xicgS/Mn2FgTZqFbYGYaSA3v0BgwRqd2+ritlAeOw3JgCBUlNQNA08AztDyHg=
X-Gm-Gg: ASbGnctWbQ2OsdPkZB6TiAgjvnCSGzLW3FruOzPPajPdtsBDF0C0dQiUet+dFx62TU8
	8B8JTWQTRt1JD3lk4LhBCOwS2xayEQwYMV8gyz2bJHg8vf+oOspFvZBycY/NfQNRM38sd1xch4N
	HlKsdQMqmi/nqZVu6CC1VOZJgmuLLNRUSeqkvxEnstjQ9jAveLVoKpCoHDmGoTeZwId4a3SWfZj
	RVbIZLcYipZSOcjpulFk3nREcN6Ig2D1Vb8VJoYlUBBy9MAIWXpPwZ3IBee6xQ+zvSjYi+A73Ox
	GXOtDSH+X5dZglRJQDmsLMJjzpk9ySL414M/8eNRDLjfsBlcrowWBRLGKrcnIVgHdeBUP6TTAin
	8OueRQNXmYhIDJC2KfkJv80pjaWqoYGO2tyMJagW6bS1RB5eY7UVJUOvfWBmgs5jTCrntAIun2K
	078y2RRO6TcjKEcr2kSSPCk23Uajqr5y0STYM=
X-Google-Smtp-Source: AGHT+IG/IYomOG5XaNPBZPm/Glkc9oa077sabUFANBbP3yRl+yJ/TdbVQrDC5CKEbYhdr97UhgnaGQ==
X-Received: by 2002:a05:6000:604:b0:3f3:1695:7c49 with SMTP id ffacd0b85a97d-4266e8e0af6mr10653642f8f.7.1760595433112;
        Wed, 15 Oct 2025 23:17:13 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ff65596csm1598217f8f.24.2025.10.15.23.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 23:17:12 -0700 (PDT)
Message-ID: <df04c765-5db1-42f8-946a-e56739e45d7d@linaro.org>
Date: Thu, 16 Oct 2025 08:17:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coccinelle: of_table: Update Keywords for SPI device ID
 tables
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org
References: <843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert+renesas@glider.be>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 17:12, Geert Uytterhoeven wrote:
> When adding support for SPI device ID tables, the keywords in the header
> were not updated.
> 
> Fixes: 347b564599fb01d8 ("coccinelle: of_table: handle SPI device ID tables")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

