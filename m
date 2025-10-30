Return-Path: <linux-kernel+bounces-877754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E6DC1EEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BDD1884834
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367F24DCEB;
	Thu, 30 Oct 2025 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3HIYDqY"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7A2F60D8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812191; cv=none; b=MBuljxc5u+DICuVICaHfJHiG0M8sqsmyWw1joZbck6mju7aV3fld0R7vsynJsIaNeDEMcRiKQ7NHZzY00EZQIa2pzk3ZmxC0xblyRoZoH8DCsYFq3BqR+Bj9TC8tcVmTytlPdsGvB3gc7/grjVt+IWnhlpeZxU3OPOZgRL2uss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812191; c=relaxed/simple;
	bh=3pr3bE37JQekr4KteuJZhkqEhETeS9zVBmYKEXCpNBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwHEvVG68ZkGNaJlonm66iJtxcrluns6Hh3Qpg+qbM5BM9SpdRbW1H/hSuVgzvamDdwjgOVuEX3ZxVGnEnBqJwt7+WabUvowDvUmG4pvP8pj6XPn0EuCEH1Xrpd+0lw0/UUL95yKG8RoULNNlEbyKzFAT/LniLuqo3ym9BQgifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G3HIYDqY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-472cbd003feso520535e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761812188; x=1762416988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4G1KZQl6cfiM/1J2+KFKVe0bth/8npRuFzDKYpdfXY=;
        b=G3HIYDqY2EKikOV/FyYL7VAxpw3M8Ha803qNMCbKHNpi4/br4ETfGkpRgVoLG7dWam
         90SVCko25GrK4arydrJVm6zWvzELmXU8fmkN4DQ6/mQrhHKxIbsyoFThu66+84QAS2fv
         pKl03heLbaZFeLqwFF6kJ61Jhh2ykJN6EqIa5xRts7nHybQkqMKgtB1dyqBVdZ6G2Rf1
         WtceGL+l+LzWwLHgLtvbc8Z+W5r+oxLTz66/9VIZ1OzaM9rihHNYW9UCPJvYS+8/ddTE
         YX1E6IyMM3uiRvL+Q/dLKtMf+oCqSrAAkq0l90EoW5tukTQMB/awbfQ3nuq5MAjD+re6
         0h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812188; x=1762416988;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4G1KZQl6cfiM/1J2+KFKVe0bth/8npRuFzDKYpdfXY=;
        b=KADRP1knn0LpoLywZANkieKUorVhi+SqgxlbCrgMeqAlCCXEj2fNGgGQELFSQVeiK/
         YEl4UabpRxr1auGYGXSgmo+7FJP1qajv79U5LX79lwX3C+utM+f3ydrqPs9jCyJTS7oh
         xI3L9Ksu61iF3LVZ6LcBC+tuOm0bo0rVVJ4kVEr00TjCKiUOnm66iHjXHH1+v7nu9LyD
         kyGxharuCaDaRg26jabduFts0KWGa58jbTKrFtXFu0hoTAshCMx69L+OxAF/PbuOP9Oo
         5DctOFUIHHFy8joWGBWiSkbnZyKkUuZ7PHcHzzLF1W1TidqHPuq73plwNRNz7rNAzJxk
         MRQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV619IUNeleceKxhAh8sD+hLMKZkpq+Vl6fVgc9V7zkI+nmA++BwBiCt7Qz03W1y07Z2A7knRhhLBDImiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1vyOkrm+asvKY2B8fqzgg+R6BispWI6OUvdGbUasnKryLz7J
	f+wczt6pAJGEhc5NgoRm+0g3MMkc5jXuFHLzxczCSLTWCZhL1npSxZkA8m5c90vi8DA=
X-Gm-Gg: ASbGncvK/6ysVrP1LsGsfOd9gOJFG88xF1c+ST3bx9Bh2CNKmQzM0S0uwx24cDmemHG
	L59lsR8IyNsxYy7eb2LglLngwZA080U/xSRatH3SfUep8zlBBluG+tDL3rTlMrG0A5KgovkkM+Y
	gSCqOmsKK4zSrfec22sHiQ8jV08ILKYYu3BWPjZLKV0kmYQdbQLQzTm2SfUMNpkpkqybWDLbS7i
	Wz6AhI6PmPJJKUzFl39ZFhVgGx6pR2+DuU7RLQwhjveFqTkd01UHxGNc55sEakuPAwDUvvR+svp
	dzs7+g+mlVCtWkUyoNTAyqnBbv2LPgoqeJrHu4GRQsBW2inG/lSIialMquP4AgPfW09cpyHzhip
	DfM2DNFWEHCIl99eRgzgQbj9ktkvnfOVirwavEoFIe20RELn1iwW2CXw0ieqwGUfHP5249XULMZ
	Mpb0w2+Mt8a+JzLdqOi25K
X-Google-Smtp-Source: AGHT+IGwDYhY1y/SPYtXSVRvAki1Qhjtezt3Dx8lpKGDfc9ZEto5uWUnib3MEpqw2Tpt3iFbZQ1uAw==
X-Received: by 2002:a05:600c:5251:b0:471:161b:4244 with SMTP id 5b1f17b1804b1-4771e1e3c66mr29643195e9.5.1761812187736;
        Thu, 30 Oct 2025 01:16:27 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289a5625sm26670275e9.5.2025.10.30.01.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:16:26 -0700 (PDT)
Message-ID: <a0d9d5b8-8c6c-4da9-a660-4cbe0bfc444a@linaro.org>
Date: Thu, 30 Oct 2025 09:16:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] dt-bindings: PCI: qcom,pcie-x1e80100: Add missing
 required power-domains
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
 <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-9-da7ac2c477f4@linaro.org>
 <aQJE5kkOGh76dLvf@hovoldconsulting.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aQJE5kkOGh76dLvf@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2025 17:46, Johan Hovold wrote:
> On Wed, Oct 29, 2025 at 04:40:46PM +0100, Krzysztof Kozlowski wrote:
>> Power domains should be required for PCI, so the proper SoC supplies are
>> turned on.
>>
>> Cc: <stable@vger.kernel.org>
> 
> I have a feeling I've pointed this out before, but these kind of binding
> patches really does not seem to qualify for stable backporting (e.g.
> does not "fix a real bug that bothers people").

I wish stable users of DT bindings (so some 3rd party projects or
product trees) keep testing their stable kernels, their stable DTS with
the bindings, whenever they upgrade their LTS kernel. And if they keep
testing then they should be told about lack of the power domain. That's
why this is for.

Of course fix impact is pretty small, so I don't mind if the stable tag
is being dropped here, but I will not resend just for that unless PCI or
stable maintainers ask me.

Best regards,
Krzysztof

