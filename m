Return-Path: <linux-kernel+bounces-773548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EECB2A1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD021B215EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A573203AE;
	Mon, 18 Aug 2025 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lp/J5IpQ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040B32039E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519950; cv=none; b=JHZY6zdft4YSTHYFZBI7OAeh7czrSdo1UdVD7fF2b5g5GRBFkpYJDG9N2cp4CM873nT9Wjz4dl/3KlYkez1KQ7YXchnJ64DllT1W3PwhxFcMdDGW0E0mbH3X0WlnvoMcBOf8ciTBdhAoAbDIMh8ny1bPpx5eMtwtulWr5gZkoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519950; c=relaxed/simple;
	bh=dVhyk1G5Gq1//rHIiPJwFgy5uZjhcvy3gBxIoLYcqhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOaPiQMWlQEfC7EG0OdMSlDs6mJeG+hOIOMU8dfFjxKwgc7cGCuzzkc6CCFLr6IA1E+/ZlwqfvDzQhlJKX4x+tFlf/Vg5d4xRoycTTzZsWg+Aow1FVpFfPGZPDGOO/sZVJKecav00OcsIo5B6+HDAoGI4YYFdAXExqOUBt7wNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lp/J5IpQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61a483149e8so80494a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755519947; x=1756124747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lCKl1INZi1fH3u0ijw9gQzqAqOnzdN2+4gkKEOfydEM=;
        b=Lp/J5IpQZOy5NhynB1XmLitCwu/bz4leKNLT2vxnLTBse8/NGWrRPMINXfHOWec2Kd
         +UYJRqsCmOhyTINNilW1UbPawxhCdoHQGBpFx1vAUZINXpnXLLXKcqpHN0qhnva7n7il
         XWDuahCt2Qup1qYkozyi1hg5ghDAn/Z4DCK7J7BP5TJu7fH9OgpU/7t8R4KcW6b1EeTp
         0Du2E8rZcoqXtdxHTUqXsYVQk8aQ3p9BxNh0LJo9zUIdcvHG3H0z31W/U7Ph6wRAurl1
         RkuljztrygfAuv33gnFcLCR+ljMUFxlTH91DAxoJUG9TxX9D1fhNJBbAKsp/uBzcowRN
         KYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519947; x=1756124747;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCKl1INZi1fH3u0ijw9gQzqAqOnzdN2+4gkKEOfydEM=;
        b=ZowMMjylC6xkadRajvOKkH2+gWvfM2LtxiydubzxFOsth440u6VcL5uxFFvxnN+NJM
         Oyl+UhG05Le0MwTKu3l8JQ3qcPHh0FZsNc5g9qHdKcQz9oiMqlYNY9ThCsM/t1GtLOhX
         ldx+0gsGWNLxJqCC6ua6h85bbIY9HsyY5KoxAAlU/UBuuGohiQZ0ADagLV2xe8ySu1of
         36Pc0gAc/CftHnRpsKA3tWzjSUyHzVzsO1t5X1z1bTeiKpj2Of5rP7LLt33eJolMlBNp
         FpinPUsjT17dcEgqKs8ik3toPr9ePPpCCNkTsVQeYkxqU2U1xqMgSQ5vPJ8K+DhdgwkP
         ZDEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH1vcMEh5PBwHkfhqOYYUWOzt5c4JoemL29PK8x7GEDWPQqDQXyihg7jPWJKZahrK5k7uPbee0/1/2AFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFwh820sMbF0mKh/lurE7HWx7AxwyDxJyPFlgPcgP41X7t4Dc
	1ZE1bXx6Sgxyk3aztV7HRd3sjiOyy6MVUJDy6dX5aHl9be4J50zwUpNfE6OeKGhdmhw=
X-Gm-Gg: ASbGncvNkd9e5n/qETK4+KwgyIOYVXhbOgGAWnpur6uEvmpMeQATgVUXGhoRFKhUYrQ
	O3s73eaCrXi5u0zLBOyOUJQ4oIQ6Gqt5TMdzq1L+IqTxWU+7OQtaSJxmMIR2AH+HDZXY3C2GnYk
	HISzw2Vzti97UYzM6j+yqmCgkTDzn7dtBPNmxBMlKieaLUiN5TlLAYQ1bJoRB+73Ykf+coLeWRt
	KEl4/eFktc2oPSka8Y+WC805VBiaUP/uiMB0Yj4Fks/OjmS5/i4aeJ20n+HgA1V+DYEtFMkJEwf
	Pxkt1+D1J4M+ezSIYiywocxYrjDSMtZ/vs2rZ9jbGn67Wbmu2t/aC+HuH4VHRSoKZhOwIN7ImAd
	nruK32zU+51/4ewQMyhagxU9JqWiSwxw2bvJvSS0uZdo=
X-Google-Smtp-Source: AGHT+IHAL6RttV2V8mfiJM2aCBf7bv1kC3+/mRUjXEwXD1bTUCvMPZjwu7fGU+5prLmwkqFl9h9zfQ==
X-Received: by 2002:a05:6402:2683:b0:615:182c:4ea1 with SMTP id 4fb4d7f45d1cf-618b075c599mr4783174a12.3.1755519946717;
        Mon, 18 Aug 2025 05:25:46 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618af9dc161sm7132733a12.24.2025.08.18.05.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:25:46 -0700 (PDT)
Message-ID: <6e0d3bbc-bc30-4ae0-8258-8dd19f7f29d4@linaro.org>
Date: Mon, 18 Aug 2025 14:25:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] ASoC: qcom: audioreach: fix typos in I2S_INTF_TYPE
To: srinivas.kandagatla@oss.qualcomm.com, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250818122240.1223535-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250818122240.1223535-5-srinivas.kandagatla@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250818122240.1223535-5-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 14:22, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> Fix spelling mistakes in I2S_INTF_TYPE defines.
> 
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/qcom/qdsp6/audioreach.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
> index 617bda051cf8..512886042224 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.h
> +++ b/sound/soc/qcom/qdsp6/audioreach.h
> @@ -27,6 +27,7 @@ struct q6apm_graph;
>  #define MODULE_ID_DATA_LOGGING		0x0700101A
>  #define MODULE_ID_AAC_DEC		0x0700101F
>  #define MODULE_ID_FLAC_DEC		0x0700102F
> +#define MODULE_ID_SMECNS_V2		0x07001031


I think two patches got inter-mixed.

Best regards,
Krzysztof

