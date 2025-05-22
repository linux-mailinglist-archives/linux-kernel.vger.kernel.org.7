Return-Path: <linux-kernel+bounces-659609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBEBAC12A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 19:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5C53AB00E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 17:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0219994F;
	Thu, 22 May 2025 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPYIz4wA"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66834DDAD
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936160; cv=none; b=hT0Xn9w3jPM8gmf3nF9unVSyIpCIVTCDyMv6J8BortEsyTEXG1Q9E45v5M7v/bfOsy61WSjrrWyEB0EH2+lsSe3vIsD2xhVYkkbSNzMdMpBLdFnC9excn5bV1JImbZgaOVbv76QlGjW1obNpO8uwsr2VaKvVbb1es//k9IHCT5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936160; c=relaxed/simple;
	bh=qWO9DMSfIG61mtWKoaewuFspZ8EMYaI4xLADpGdJvio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RF0C1E8vUYfGwa9EIbSoYCXMFWY8Sgic+Exgvr1xZqyNu65ZFMSmvaN3Pf2lWWmL1my9lgq0MfPDyGMMhRBr9tVSYvrWBZalQ9arWir5j/ECjIjrzMCXO4ghpnvgVXvbaxyh/IKSNGIKbyTYsUMIlWXgYiJZ9cnhM8/WDXxq4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPYIz4wA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a36255d0f6so987495f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747936157; x=1748540957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=epHtLezLMdJyHIaR21zANyD6mo2PDLHwUqkxzHQUEkM=;
        b=LPYIz4wA4NjNbrRjtduUk74yRJ8DDHKxHWYZNrk769xynu46EEbgxnm3pHKwuKelSU
         R2hPJLkvIZ8TRRwK3BxYhRgW8Tqaaf3QmNHQ7KmdUznn1pxtzZQGr40eMea30Qtf89dA
         LOH5rZ9sF1yLVIL/ZDzrb3oAwEp5tK2ymZpxR8Cs+4H1ztqSTbCO5BowS30Shtf/EOT1
         FIlQa3RC9zu3/ywik0Fddo1Z9ikeWEL/0zLjJQQuMPAYzHsd7qf9mLqpkkcuAEYshwCX
         MTS6aPbRNaJh+c6ioRjC+F/iiJRoAL/wAhVTWqV7jH8zq6L0E+Fe6c/rpGRTK4j5Vd94
         uM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747936157; x=1748540957;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epHtLezLMdJyHIaR21zANyD6mo2PDLHwUqkxzHQUEkM=;
        b=M3DwjH7v9qRkJaUtjRZKjn39MB548nZpqZgyfO9ZOJRdY6xN8npP+MzpFUdu5IxLv+
         BHqV+8uLUCUrAhBlV69+insV7A1+ysErgo2J0fQ2xilR90I8Idre3NA2P0opIRzmXHKI
         KK3HV2X5/obGAMBlQmHFwhKbF7tP1hHTyYkIsfkrEBo6msm8COPh7Z712YmWRauy2fPu
         dX/ZxPia+/+TI8pFFR9ugji+Hje7ln1losAFS5HPfjmdpaPJCc2v9DQEe2FGmI7Pcl/t
         jy1zYz+mQLBFQNd1ZykLus3Dctx7nM4iss7WHx0qd7X9M1MeKyq/F6/VIBPkmugsd0h3
         +LBg==
X-Forwarded-Encrypted: i=1; AJvYcCWXzmy42IpAHniBtr6EHsEPwYBf+WWEbvlf66tUoULWAnoKNG11pamUGWwpfI79A32xUqfWbIyvhtJOBcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNfKCKqB52+Ct0ut/6rj1RyxFRvlSQZbmiBA6rgcIt3U5AIvt
	0wFFUqq74PFyrNNVdeaG8hBU3iPu2LHj0yTd/ph95/FcY5Mvpjpbh/m/Pp65IDAiJqE=
X-Gm-Gg: ASbGncuehi3NySRl4wbNSz4prBbWqpUkCRT/V54LvRmCykyYpVnJB78V3JnvT7Ng3hg
	3IUGWWsgNOLjubMINtUSj9H9CKBrTODdIn9A8JPPE3yj0F+KT1qWqDGk7+UIZkUmE9RgaJ8T58Y
	Jd1bc5WJsbsR3li00cNRwNfsys49vZikzUYBN60R46AaySyYI2JsUlP3OjfJJlZ0usAeV6G/4SK
	Beux5FHC+pf6KNp/PvfErV4GiU7gvUPCyfbNyl1NjCkwCcGVUbkp1+6nmsAiWJ2zEdDfIo/PYsE
	E9BxK88nh0F+do2iX0zPc1XhoIkP85o0fq1lzPhlQscb9crMYuse4+LSvHJ/hpsJSjEyYRU=
X-Google-Smtp-Source: AGHT+IEJra81q33bwANLGYFPFrMy0Dodu4U4LuZogq/miQLd07qZyabsFZriokIHn7NTm38qgxxtHw==
X-Received: by 2002:a05:600c:198d:b0:439:9a40:aa27 with SMTP id 5b1f17b1804b1-442fd66dea4mr97969985e9.5.1747936156703;
        Thu, 22 May 2025 10:49:16 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f05581sm113164245e9.13.2025.05.22.10.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 10:49:15 -0700 (PDT)
Message-ID: <ca732f89-d217-479b-a0ee-131b177dda20@linaro.org>
Date: Thu, 22 May 2025 19:49:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] ASoC: dt-bindings: qcom: Add SM6115 LPASS
 rxmacro and vamacro codecs
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Srinivas Kandagatla <srini@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-sound@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250522-rb2_audio_v3-v3-0-9eeb08cab9dc@linaro.org>
 <20250522-rb2_audio_v3-v3-1-9eeb08cab9dc@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250522-rb2_audio_v3-v3-1-9eeb08cab9dc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2025 19:40, Alexey Klimov wrote:
> Document compatibles for Qualcomm SM6115 SoC digital RX and
> VA (voice activation) macro codecs and their clocks.
> 
> Cc: Srinivas Kandagatla <srini@kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-rx-macro.yaml        | 19 +++++++++++++++++++
>  .../bindings/sound/qcom,lpass-va-macro.yaml        | 22 ++++++++++++++++------
>  2 files changed, 35 insertions(+), 6 deletions(-)
> 

You did not respond to my comments, I don't see any changelog. I also do
not understand the changes done later

> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> index 92f95eb74b1928fde11ad86ab6344f274bdf7790..697c5591ae7cb82633ff0159fb31d08b57c11b97 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> @@ -14,6 +14,7 @@ properties:
>      oneOf:
>        - enum:
>            - qcom,sc7280-lpass-rx-macro
> +          - qcom,sm6115-lpass-rx-macro
>            - qcom,sm8250-lpass-rx-macro
>            - qcom,sm8450-lpass-rx-macro
>            - qcom,sm8550-lpass-rx-macro
> @@ -80,6 +81,24 @@ allOf:
>                  - const: npl
>                  - const: fsgen
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm6115-lpass-rx-macro
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: mclk
> +            - const: npl
> +            - const: dcodec
> +            - const: fsgen
> +
>    - if:
>        properties:
>          compatible:
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> index f41deaa6f4df57c8186acf4cd7bb99e38dbf89f0..a70c0f36389269756b724889c335c1b0bae157d2 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> @@ -14,10 +14,15 @@ properties:
>      oneOf:
>        - enum:
>            - qcom,sc7280-lpass-va-macro
> +          - qcom,sm6115-lpass-va-macro
>            - qcom,sm8250-lpass-va-macro
>            - qcom,sm8450-lpass-va-macro
>            - qcom,sm8550-lpass-va-macro
>            - qcom,sc8280xp-lpass-va-macro
> +      - items:
> +          - enum:
> +              - qcom,sm6115-lpass-va-macro
> +          - const: qcom,sm8450-lpass-va-macro
>        - items:
>            - enum:
>                - qcom,sm8650-lpass-va-macro
> @@ -109,14 +114,19 @@ allOf:
>      then:
>        properties:
>          clocks:
> -          minItems: 4
> +          minItems: 3

Why? Nothing in commit msg explains why existing devices changed.


Best regards,
Krzysztof

