Return-Path: <linux-kernel+bounces-726055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31073B00794
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D1F16186E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A95275862;
	Thu, 10 Jul 2025 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BxatNQ8z"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581AB39ACF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162410; cv=none; b=bukqS0erexFe9JFQ1I3JojY81qePKOszRkkgFaltJOb8dwqfXT/+YvTEIyIzMMTMfXrNTbAEMzPbfN8wU1u5MHTiBn2fb4/TXxmQ9np1eYnkf7NlHdV2TER948TbPirgdX34btybevyINVOnaee/yit9WoluBQxrcnBT2QGx6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162410; c=relaxed/simple;
	bh=sk5MkTgT33G126yLu0cU6kvmDkC6SSCYrqJIAgQRCfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qH3D7rLRnZDidqqQswqJPuO613SSwUhwb7uygyrbgx6t4KyOa7dHHcJWipGGFy8veq7vSY+hqV+o1z43viuNtnXfTFGW/DwPlMF0dt97QprSCdoqqfjdWwRsirb4Knu3Asjuwf/bQRHS9/hGZI3I3wfpMEeSvTThTt5ESnsUJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BxatNQ8z; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2eb6c422828so1224884fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752162407; x=1752767207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxqC0ATm8XXXx24MpZdy05ScJSWmhlnLQqeCjqghw20=;
        b=BxatNQ8zTL/D8PDEvT/iYc8wJMHJpQIbwc9w1fofki7ZP55YcdFgbGjrPZbn4G5MWA
         VNkz5F3GesZ1e7K7IQcr5xy+35mEA4RCZ7lCVk35L+yy4KM9ay3XG54B0a/Wt3o/gAoV
         7qVVkrCXR+6IfHbGkgA/hl37QIIa0U6TQ0hhKv5Y6eTMyodRNe+I5xnRCtmDmgOG3YHp
         EIZ/iWxE+7IoPNLxet6Aj5AdX+pmJOrfPukiWBltJLssbBEvx752ywRuzLj+KSl7Y6Gw
         Ey+3oizZ0wdsuaVnz2CPhEyMUbFXjLgI+4hSsWbxxC++U1QAa3UTJx3JbsK6kUxFig5G
         vjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162407; x=1752767207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxqC0ATm8XXXx24MpZdy05ScJSWmhlnLQqeCjqghw20=;
        b=Ogw5AzIiwoaG39F+hPlNVvOjfybThg040SzXCYjmcThQV3i2bqqRVE4kJlZdsYxHRI
         Ag6FAQFtr7koH1bd3nRXTdmLAot4U9R08JRLfOnlWM8f7N7w0zrQ8uXL5EtV+vp+LuFe
         ysmZe2Hn4w3vNnd47Q99R1+tSNjqIhM0tJf0lCwJQieivQgy6+9VzyGgRAbLsPe2bFBR
         CkQThsFBP501KlGJ8N0HvYJsl/KCG059s0eMR/LGhYZOOZo70o0w0533Q6Bp9nE/hNNO
         A9Ou2S9HGLQRj0ftHH0VmF6NbE1bA2tXNCWIHmc7HDSG2P5D36HfJpT6Ut8gaAT85mvu
         R7NA==
X-Forwarded-Encrypted: i=1; AJvYcCWFvSk3FD9cRLKcVG/kXJKm/yIxZ05g/WHvM9Xbsj0aYhV7NG3IkJzqIxK1uk0BSdn6Fhk1SkNf6fZ5Ics=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwxnWoQAer/JpweDGYnd+dRoMNaOC+rmXa6YYLeLHk0BaLYao
	NdRLqK7HhBQkTLPjpLw0mAAJfkF1ydmnOEA7R7fkpRc5VTD2p9YeOntIxrt3Qqm6CKo=
X-Gm-Gg: ASbGncv+jj/EOv6rMpJHbEu1UOliZo7U8rU4jwyU/jOy2MLSTy8JwwyGq5bN8u+v0Te
	2Arv6jMcmi1n3N25y/vBnxnWOyEhNx38FRHOTpLWW0VM3yFtnD+InHMgVzuKYKoQtqsP37bjMrG
	RQLojRuyR5W5YcOnp/wXTOYE9MgAXiJ0T7nOJEcLqNKaVZRl9kYw71o3FXVKrDa64NDCFM7JNRf
	m26McYHJd+HOTbs2afdnzvLYyZ++lu/38zwXSV3JTbC7G1Hp/9Smm5pIv0RhKcVPmPmSP/t4C55
	11YTL2d5gZ5Sg+UFoZZw0a87xbtOvZ3C2uStWjEB1698MhdSM6l7KEA3nnfbuGBDPmO9DW2goVQ
	PGNednZ2IhWzLcPR3dPLaqzEHtpy2GKltO1lpH4k=
X-Google-Smtp-Source: AGHT+IGGnNYbfg3tRijwYJsTHxFrHe4ec9V4WbLcn63Mw2V3gA0rhenSRI8xr6ktDmmz0UyeTDfVCg==
X-Received: by 2002:a05:6870:7053:10b0:2eb:9fe5:d06c with SMTP id 586e51a60fabf-2ff0c5af786mr2100280fac.3.1752162407230;
        Thu, 10 Jul 2025 08:46:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7? ([2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116dd664sm343870fac.42.2025.07.10.08.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 08:46:46 -0700 (PDT)
Message-ID: <2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
Date: Thu, 10 Jul 2025 10:46:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
To: Primoz Fiser <primoz.fiser@norik.com>, Haibo Chen <haibo.chen@nxp.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de,
 andrej.picej@norik.com
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-2-primoz.fiser@norik.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250710073905.1105417-2-primoz.fiser@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 2:39 AM, Primoz Fiser wrote:
> From: Andrej Picej <andrej.picej@norik.com>
> 
> Document i.MX93 ADC calibration properties and how to set them.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> index c2e5ff418920..d1c04cf85fe6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> @@ -52,6 +52,27 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  nxp,calib-avg-en:
> +    default: 1
> +    description:
> +      Enable or disable calibration averaging function (AVGEN).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +
> +  nxp,calib-nr-samples:
> +    default: 512
> +    description:
> +      Selects number of samples (NRSMPL) to be used during calibration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 16, 32, 128, 512 ]
> +
> +  nxp,calib-t-sample:
> +    default: 22
> +    description:
> +      Selects sample time (TSAMP) of calibration conversions in ADC clock cycles
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 8, 16, 22, 32 ]
> +
>  required:
>    - compatible
>    - reg

This seem like things that should be set at runtime rather than
in the devicetree. Unless there is some justification on why
these values depend on how the chip is wired up?


