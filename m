Return-Path: <linux-kernel+bounces-805415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB3B48849
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7EC1B23D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92D72F28E0;
	Mon,  8 Sep 2025 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksF5sW35"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A22F1FD7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323492; cv=none; b=bwtvKbTWWb+vbLA1U6sRlyT1+t9ZyZDzskjL8CNVJVidMN0J+Qc2/FV/Cl1M0pNDe/oZ7qnxM8dLYMW6UYgEXqsVPutJlrDG7hqHx1fTMgwMObM8B/oXhc9cjFdMW14bU92WJVtKwV56f7S9O1b9xLFbZTholexKSS3MocPKN8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323492; c=relaxed/simple;
	bh=dfJNPkrTOpkEEhc+9QDoYgNbI69mXVsLrNLVNR/awW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UpAB8HQlOXK1+rtH2qO1RuuQpOurP+MQb0iUMjnhnJSLxHtV0fZaEOd8E4YsVWdIJEQdgpBQTkh46noRCvi7qSbaDyGqDR1qO94iFvADuwNNlHkX0BMjCXOhlJ/A6M2t9NXucw5WYOAmx5sGZKLm2ForlhkwqSB0k3ioZO4GZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ksF5sW35; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so33819165e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757323489; x=1757928289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvtNzKNCsdK/8SXCNlSwhnqFWwpANSZsdsQDxPDRBQE=;
        b=ksF5sW35mX63Qlrx40z1rTxws2QPffWXNoEWCZ91d3qFmRRIYu2nidJJXbPwKYE/Os
         hLhzEzUCeZLh2XhZUkU7RbKVbUZ1CBMuFpTDiRUZS7z+OK1bvxqPdWKn0x4u/qLKT5x4
         33u+2Ofe8XnY0TWbMjepF4b8ApM0G3yNIckamoGGnmNXc43BvG1xXzADRWbQfAFqVYm1
         yqoJ0g+jlq9l++2GjurPUY052sG5XdEcUemFnxbronm/uVqyW8839nGOsiNDMQYbaEhU
         2PVjLiRl4cjVYiiS5gwZKtAsTNIBAqPWe7Dwm++jnKoWyZf1rxb0o7KpdL8zyIEek8rZ
         s8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323489; x=1757928289;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YvtNzKNCsdK/8SXCNlSwhnqFWwpANSZsdsQDxPDRBQE=;
        b=BJISD9JlziEOl6tomacbyGnm50+STJ586k0mG6V0j4xCJYr7RjJvreCdEXH6i9kRVj
         OeaZj8RXqZ9RLTEy7YVumOCPxLPSaePlHona9Q+ik1Qdp+6SZ3ePT0O7ampH5QyR4Axj
         rvGuxctREmlMkmiwSl6gwp+HhjKnyohG+VL5vXDFHWbK7FEYJO5TggA7LcGBfAk9j9jM
         FCr7aByEQ01T3b+dI4h4k1901j2j9dwtRkGZJo3PLYsZKyM7qgSijK5rBnolet1Xi97Z
         2jpIx7DEEJzeHjeIa5BuLOlZ0QM/K9elAEgM72wth78qt894xvhvueTbFFx/PsOuzD7T
         V3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaDr0gpsbmQv09wjjo7Ij3cgqwmGa/6TAKa4toMH7QkEHmFLMyzPGTxZy5W3Te4c3V1BE0/PMBY7RF548=@vger.kernel.org
X-Gm-Message-State: AOJu0YzacWG/rR0y5TfHw9WZcKJWaWStwQSFQopoTkr7lFZc3zUzQe8H
	v8CvRj9OYS2Ifha+t64XeTf3nciAuYwUX/BwkYdkKAxlALbjm5OJqcyj3MkYdIEC0E+xqOEOj7I
	BhLdpmTU=
X-Gm-Gg: ASbGncuCxcHxknPUyFs6DLiLWLjUniwAjyYsNSBTySdlf+8VD81y6EqskaPk1cxfjHS
	NlvkjNPLkna/K1GOkI0w8D4RqaRvDPEVQHuq/LRtPp09MMbPkzUWXrqMCuipd0+r61vKQ7++uFM
	VXGEavAMxaxM9keK1fkuVJNYrRpMZUjuoT6gk0XUzYK27y7QvdMseavB4p1jtEhmj3atMFbegeT
	TVK3tdwtbSlkXsLzZla7Qxf99uY0deNWxbQSzI/4CD+1lO4jXUBTkYXGLJVbudSTkVJ9aTdgh0v
	q5Ylfz6HCE8E2uBzYbWQaOFoPCKXkKCZMAzmIgn/JwBEeqGnt9U5CoiNLeY3rfnUxrwZekwKWSO
	WmAKV9dzLVCxD6GuVKsI2dYPAgpuMkvXiQsXu0sIZjH1gTzLC8E1SwiW8Tjn5FH2vWtNVtAhH6G
	INBRtSzxtZYt0Mf/S1b2Er
X-Google-Smtp-Source: AGHT+IHzX8Q01a+hqWGPpDGkTTKqxMz+LrVQigb+Z+l1VuNmGS1hRHuL7vcWAwfeuOY+jFSs6IAj9A==
X-Received: by 2002:a05:600c:474a:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-45dddea4cccmr66201115e9.12.1757323488588;
        Mon, 08 Sep 2025 02:24:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b? ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de2132cd3sm70098965e9.9.2025.09.08.02.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:24:48 -0700 (PDT)
Message-ID: <11e75f65-078a-49d6-9032-e8647bdc0ef8@linaro.org>
Date: Mon, 8 Sep 2025 11:24:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Drop redundant status from
 PMK8550 RTC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250908085331.56478-2-krzysztof.kozlowski@linaro.org>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250908085331.56478-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2025 10:53, Krzysztof Kozlowski wrote:
> The PMK8550 RTC is always enabled in its DTSI file since
> commit a791fc19965e ("arm64: dts: qcom: pmk8550: always enable RTC PMIC
> device"), so drop redundant status=okay in SM8650 boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Previous patch (not really v1...):
> https://lore.kernel.org/linux-arm-msm/b266b190-1c6b-4899-85bc-d3e4083410b5@linaro.org/T/#t
> ---
>   arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 4 ----
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 4 ----
>   2 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> index a00da76a6062..dd5f63ef5f67 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> @@ -1050,10 +1050,6 @@ &pm8550b_eusb2_repeater {
>   	vdd3-supply = <&vreg_l5b_3p1>;
>   };
>   
> -&pmk8550_rtc {
> -	status = "okay";
> -};
> -
>   &pon_pwrkey {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> index 081b7e40f574..0c5e9c22565a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> @@ -1006,10 +1006,6 @@ &pm8550b_eusb2_repeater {
>   	vdd3-supply = <&vreg_l5b_3p1>;
>   };
>   
> -&pmk8550_rtc {
> -	status = "okay";
> -};
> -
>   &qup_i2c3_data_clk {
>   	/* Use internal I2C pull-up */
>   	bias-pull-up = <2200>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

