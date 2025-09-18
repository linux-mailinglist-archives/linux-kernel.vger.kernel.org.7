Return-Path: <linux-kernel+bounces-800521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A3B438BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA07E1669DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D7D2EC571;
	Thu,  4 Sep 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qx7LdcBW"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2813F2DCF77
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981701; cv=none; b=WJ+eTUos3pBZt6yNr5lvuasO4YK/vjCZykNKwOTn8J/OvlsxyPWLfHxDYHGBMS0p1peQH4aoRFjCwclEwAaLnjykMsJEB6eb6vk+xU6omvOR72aWH99XI6mlTJnK97miOAsRvrXVYMsWRNajWBnUPom9Uek6V2m2CfjQ2LIWoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981701; c=relaxed/simple;
	bh=qbUdaJpkZUNHp9jHGrfzQUVMcgv61VMXD3m2CVITtec=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HtmDfS8wRMwv/W/+btSh76Y3ZnD8Nb+pb4/FZaKrMtD7Pyd/Am8yPGHg56oh6ekfNt00cTrcfbD/G6ujgPYv2FuWevDM6V8a0uJOrkgxbhfrY7l95+FLDZrRc6fUgV/4A2CznFhWcOnwHqatIWXt06n26aau9PiVcxfrvAi2g2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qx7LdcBW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb731ca55so11581366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756981698; x=1757586498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1WbBVjWxA4EfQgsM8BlOAO7GONdCMwV9UB8qyjfBQA=;
        b=Qx7LdcBWQ0fhRzuIrdTdWZtzB4n8dmSU43bz2M9IdsoeauM8unxVW4pQoSl7HIVARI
         oLJHjl9D58gzs4wl9fzbKiU2rNhbB2jNo13GIWiWlNJ3QHMDN10nomk6yjltXiBucar8
         ONSNQgS92fjW1t0x30Aevj9O9DaJrO5smQDmCIIagFBFTTNXruXLPdOQlrD+6wB7v4iM
         DFP/YdzZUDH3DfnPvkWoo0o50lnNauHRXaewRx2fvvLW78Q/4cBWNT3szywx9+eo7XHC
         O/pp1eE57H4EDXSsHkbQl6p5TncMX1C1BqJHRt3Riv3XdrGieJXABveQRGClEkyvhy4Z
         Eg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981698; x=1757586498;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1WbBVjWxA4EfQgsM8BlOAO7GONdCMwV9UB8qyjfBQA=;
        b=P8CDQRl+cZ+n7SEwidFw/bmTXH61+NTf3LZ2700Va3W4NDnc8GOcbmOp3XNSfKJ/Jw
         0AkbtcVGS1andmqeQBs2dMsWKJOH4ecoR7tivCciHBn2ZpVq5Z987iTElZq05EQ9HV0x
         3VD6iknYhaz3EywWDinY6FPZqf23gXYz/qQCyJhl6ebi8dMJyfUWLdrB3SxE+heBBacO
         QUepHtu7TiX5OEWLrZ0AFFLWoCXLvW8lzFZWgDfwuiyVqpJ15Mg0DfbmxSEGtveHkjUZ
         62+qN7QG4ep49O3GZwo9bAWXR1MhFllg0SCmETQ+aEO3dMSwIFCnmYz79BeY+2FgT+cT
         nXIA==
X-Forwarded-Encrypted: i=1; AJvYcCVMbx8F5Isux1Py3XKbCgGy9Q+f9aUN0+8Gyd+VAMGJRI6Wvx4uJ+PuetZVzQcekir+URzXyFq0Rq9VIhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwvY+/ouFzZuAnSAWYmqFvnXY3xFmw5eaDfI53dXFjmdxc9J1d
	uz8gjUx64hY3TEMDWIMYDQEG972ErIwWunOGegOCqLKGX+4Rqb7uLlAbvSalb3VjQBU=
X-Gm-Gg: ASbGnctOh9mdpyUKb9acuTcLRu8BJHZf4D8foIg4VZpvm63uaVdfawpBbOddHAl5doi
	of35D61IfXH6QuuKSsE3ASTHphtOCVYVQ+Ld7CkzPdzehnMfSjiAllyCUr3cy/qOSo6QH7Y8zGe
	2SF7F24Cz2MhVQ/R22e5ZHeYmF5P+LOyfAM2tO/WtAKkrKyAYEj/8GrzdXLLnn/XMUxQXZxZdLX
	+XXwHlYUGYPqZK/P6YSECXe/YxkcFQxa/38XFQkaIrgY2eQxU2XaMGrx3cQMlR81bPYQht+VFVA
	sauNxIdDGrAuzZxYSED2LtoCGILlSnqDowED7f/FXMSa0sEpgqCXzY3pPuKUCFaLnC+N0rnsjIN
	4qZ6WENimztxym1oTN24NfA010lWFWaRa/aL+N3f7WZ0=
X-Google-Smtp-Source: AGHT+IGm0SQo3pUnsDlRExnSN4uloFxusrJCYADHHQqT05DYpckwZlVlB1+5UK2fMt5CUtQdDfixag==
X-Received: by 2002:a17:907:9455:b0:afe:ed61:b3d8 with SMTP id a640c23a62f3a-aff042497a5mr1221075366b.5.1756981698516;
        Thu, 04 Sep 2025 03:28:18 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042258f4ffsm1031853466b.91.2025.09.04.03.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 03:28:17 -0700 (PDT)
Message-ID: <59deb4ea-0364-4abc-bb99-36a032cc4464@linaro.org>
Date: Thu, 4 Sep 2025 12:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: qcom: audioreach: Add support for VI Sense
 module
To: Srinivas Kandagatla <srini@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904102558.143745-3-krzysztof.kozlowski@linaro.org>
 <20250904102558.143745-4-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250904102558.143745-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/09/2025 12:26, Krzysztof Kozlowski wrote:
> +	cm_cfg->cfg.num_channels = num_channels * 2;
> +	for (i = 0; i < num_channels; i++) {
> +		/*
> +		 * Map speakers into Vsense and then Isense of each channel.
> +		 * E.g. for PCM_CHANNEL_FL and PCM_CHANNEL_FR to:
> +		 * [ 1, 2, 3, 4]
I forgot to change this to [1

I'll wait for reviews and sent v3 later.

Best regards,
Krzysztof

