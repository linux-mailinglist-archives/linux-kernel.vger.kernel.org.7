Return-Path: <linux-kernel+bounces-868130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB676C046F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74A6A4E385D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD6242D62;
	Fri, 24 Oct 2025 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PH5RI428"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C81E990E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285490; cv=none; b=hoxr9y3jteaKvtOURMA9WqakU3Kuue+A7DuAQJ6vluNSpfqKA/0kL/GyZM32m4OK8FCWwmAXKv0b4i1o4uYNAnvAdaf6C7F7RL2XUZNVW9S2Buf5y15oufTMBIJDUO7fAE9W8K8tpzEhtbahFtRymwlSKSxgOu+6WvssLtcafhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285490; c=relaxed/simple;
	bh=NmsrupTRkisYQFGhFjZ0bRbIdltnfvRER/RQe8hkLqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSk2KOFXbn5J7HtdDmvA6YqE9cvddgdiO2HVTteMphzv5ND5NvFyPsceJHrwwMsg3IfHjE9KwN9FYgLK/uNBahWaLIkJbYgxtUDYPh2/My4uOGeywbtVyQZpqu6QkiSISBo2T+7jd3gvl7VbycJD9Wy8oH9WWp7AohFPEyErbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PH5RI428; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42557c5cedcso1124593f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761285484; x=1761890284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlbgzRvJgE4Sx6EeAuF7s2GqiVQJOvGqllksow3opC4=;
        b=PH5RI428SNOsHpUF7L5WveuXG45u84EWGn778+3Wr8bMdv+wkVkqB49ktt4SK7xIHj
         Tncr5zM4G6R8tSxbmhiHD6juJAH2sQxz2za0S6PGE4mXwEaNctpDMKkn6STQASqJme2e
         pMIv19vxtvk/unKYgHvS5Dg3InBKAt9dmXDE2huuB1GxdXvdHTY8+tFrsNES3Rf382ae
         Kqgfv+/8L2sxsOqv9QtP2utjHEClW3Txz9Pup/PpINbpc/XbsbrLWgRsXHjyRAf8S1fG
         DbDFc+11K0EfswLo1VmQyR7wLkTmePf4g55KqAEzGPySCRFmcXzID++dMRKkWq8vhBoz
         FkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761285484; x=1761890284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlbgzRvJgE4Sx6EeAuF7s2GqiVQJOvGqllksow3opC4=;
        b=K/IIsakdKz/ge5FHtBwMX3CM6XA3bFyVZEknP0KTaIGvicD8hf9RzQ8aTjtUiqplhf
         /Y8p807EhGO4ksvqEIUGaikWADPLTEziZpQ6msX6+QDQn5RU+WiTPvSBehtXeU+9bp/i
         NwrU8ukUH9oVrUFmxjAAOQe+vD79Vzu9AN0DMJJiCjmj8C9V48IHy3vKl6UZWbIME7Gd
         qWa+c5bOqeNkM9rBcWrrX4tKJMb2EJFwYeZTXXzWFD0sjggydnAmXmNeO2eE4DtDMYqM
         H1pe2aV+3urePMmie61yI4ODprCk8853J1xQb+25kY4e9HVCpMrsFw5V7fxoldOkcwB1
         SkbA==
X-Forwarded-Encrypted: i=1; AJvYcCWMjEOWh7FticLlJMUiboz9tO1C3LH8q0qxmsTCjengW9rlu10jgYAzwgAqiXIMZKkd8Q0lHjHAb74nDeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpoh+VmFYY6L3NL2ZATVJhEF8qpUb6fz012ntvLt0tDlSxEGeB
	SFZhbkwoOEZCxbgh0F1GJ+9mjxLGmPmoQgHjXls1aIYb9hD20G09MMItUxpWuq6lCzc=
X-Gm-Gg: ASbGncuQaS5n7qRCFX1oo8ww0pB0tHnYrpKaBhn6YB6TasZSWLF5xK+z9JYaqvlroYF
	hRu3FbVk5SB+ahhVryxnEGnv8/xyyXc4PeoUWG8+6Wz/LDy0Tuj33blDm4Y2hk3+HVeBrypuo7k
	9IbkG4ZWa8TbYhz+CYyUpVR8LySvmpCvfmVy4159RbxC3guoOvr5l1UCQzOND04npDx2S7N8/xU
	Md6zuBaxxfhpu5lSxKU4GrnrnduJPxjkOVL6a9N7JHYf43LvihATAvT1VtURNpiZD9RGdvtbhpU
	WOXraA145y9Vqjn3MPUt/AICJ1E482M/IqiKPNLC1OdTbIVZWVKSfReuvLbGMzQRJvoUagHPt+V
	exBDRvp1UWeEafyUZrWP/ljGF23262D0jNuXQemWFC3IWEbn/BYFJ1FgXr8T4C/OM1H/hVdcIxy
	bCEjaSggJcnkyN9HQsxyQ=
X-Google-Smtp-Source: AGHT+IF4FcOKkucmDNCM2/KKpneCA+i1yPeXTsA/LVynPTPJC5AXKg32KTh4dcKAlcjbp/p6c5h7Xg==
X-Received: by 2002:a05:6000:2387:b0:429:8d0f:e92 with SMTP id ffacd0b85a97d-4298d0f106emr1607568f8f.6.1761285484311;
        Thu, 23 Oct 2025 22:58:04 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496c14a26sm76466825e9.4.2025.10.23.22.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 22:58:03 -0700 (PDT)
Message-ID: <b1b6271a-1f75-4cfb-9af0-4d60b578f2dd@linaro.org>
Date: Fri, 24 Oct 2025 06:57:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: rng: add google,gs101-trng compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: semen.protsenko@linaro.org, willmcvicker@google.com,
 kernel-team@android.com, linux-samsung-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251022-gs101-trng-v1-0-8817e2d7a6fc@linaro.org>
 <20251022-gs101-trng-v1-1-8817e2d7a6fc@linaro.org>
 <113ee339-566a-4cc2-9786-89252ae072e0@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <113ee339-566a-4cc2-9786-89252ae072e0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/25 5:31 PM, Krzysztof Kozlowski wrote:
> On 22/10/2025 13:19, Tudor Ambarus wrote:
>> Add support for the TRNG found on GS101. It works well with the current
>> exynos850 TRNG support.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  .../devicetree/bindings/rng/samsung,exynos5250-trng.yaml       | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> 
> No power domains here? I would prefer to see such additions together
> with the compatible, if that is possible.

It's part of the misc power domain.

I'll add the following in v2 and keep your R-b tag. Thanks!

+  power-domains:
+    maxItems: 1
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof


