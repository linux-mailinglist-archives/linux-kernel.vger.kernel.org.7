Return-Path: <linux-kernel+bounces-843871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC471BC075A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88569348B35
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F023507B;
	Tue,  7 Oct 2025 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffSpke6p"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B129202F7B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820664; cv=none; b=YqvZ0JJfEpm5aFc9K9QTf+iwdFHOdHx2izPU2du3BbXE1Qenoj0NwVwFap6Cr4G9R1fgJrtI9s/HMbn1UD4RZ8XZhfqv/K6CJAyxki/7pvxaSvGbauZdeysVuHSVw0xGTqfdaXJ2d8b66Y3KzcnfCv6ApOYeEC2L7dy3fOn7oRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820664; c=relaxed/simple;
	bh=bm/XxuLbuJjEERWca3veD6Y2ATrNprN8+avE4IFimfE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=o7DpAJDsC/fb/GpT6agGC8/JHwRMy2pi+6uCTeSCC6zpQRiS7ZeoeexFQWWU/wUhEpkdwbL2A90ZyRtRFvit9dc6mJVvS5g0XpjR2wyFq5n9NGhK1acH8IKtRP+ZR1zfQRGrNvLTDmzvDF6Gbplv2/0M/C+nPfWXxExLXHOdGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffSpke6p; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso47240495e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 00:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759820660; x=1760425460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5jfYhct40BBgGb9CM8b7f7J0vVnmlW3SBqVjL9y/Jw=;
        b=ffSpke6pr6TLvqL6dU7fFhmjQC+TTyOnIUd2tkl6hxBXfzSStKqGsHlFBDFl/eds9R
         VGhvJZG3lMVY2+v07hbbss9DuCW0TB2yPtLik+7aNrQBg+EnStd5sj68zU/6uwl5hqbD
         1eDOCudk/JUawyqwMXwM1Rklivl+Wp2UlDqCx/e8CIcMGXEV1N/jqLRUr4r0OfaSCZ7c
         DTbNeop33GLpYYCpaums6DAAObeq3zO66aG2rUm7E7w1vS2hGzelc1Az7C44FquBvWBL
         Y6TFNEkqrdxiA7Zi3itMbNzgw4UdGZYVFpugD0QgSNKiBzSOFmKrEgdZl2ljUrl2ioQi
         XSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759820660; x=1760425460;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q5jfYhct40BBgGb9CM8b7f7J0vVnmlW3SBqVjL9y/Jw=;
        b=qHnZRhWttcrjp8cx3HYZsfTGgiQPOHdJU9DTJl6AVrj4T35FOJQe+29whcWkCiLOak
         QbuTrB0LdhCEAwTU3NcuPvWqGnB09VXcBj/Vc2rwKbAzI6eXmfaT+MzNrpR0Zzq8sYjP
         EJbQl/mhrWhQUQxaAtrlzH8j8NI5Ns/P1ENxMwYLPwLwVhmwTcfylWQ7VU7hcGYD5pjB
         Fww6aMYN1ndwy7dT5RczZhOaAO4UTN1WFx016IXM5emaAZ1KkMqRgBLxAOVWLJR6anM0
         aQamgp97uqIdfryCMljmKFq5mol4up7M925fmmlXIHtCDq0xQS19z/cB5d6BVKFXrzwW
         y60g==
X-Forwarded-Encrypted: i=1; AJvYcCWEDjm6KBKUq4MbHD1zWFrHUkCoE24siOCig3NPawyvGmv6xkoEjo+BPRyO0mW81dC7Q5wJ83EhH+Ymz4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7FTOAyLgvQ5SxH/d0vFzJ32BEJ4NKY38IUeJ5n4M+amKzdbig
	NIN78C1kKvrLvScRmzv6flwJhVo5ZPKRM5A4TP1RTSYJhesPhwjH7ZmNNkwv3vstjlQ=
X-Gm-Gg: ASbGncsD9+weC3Kl70rwAU5qQBIbCMAG2tbv7bK2pr586ujBjK4ldaTNBLj+tabWjN0
	hZVQni44gippYt/q2ahLJfWYH1ewdIPf+8FeDX8xdcaVSoCpnGd43szGcxZucMeum/uiSWamKdX
	b9A1TbKw46V9qalaJx8BN0S/GLH0XIx8wl7WwZ8msDdRX7Ftj4egXoKRqx0gmeCimWTqtsupSRt
	0r8ZGYxDleORjF+MjhgROpk7KPKgbQ39rui5gDsTyQdCr8WdytTQEE8F7Hy6iDtgjLqBArgFPWU
	623qe7TNNvCtOgtGx3SaBOzunJuACQvKjLBTpQsAWi4ydehM87LFiHmH/jST+qlEHmKkBLdBUFw
	QSzVWk8/nrmfBpExzNgagAc5TpingrL4YDB8YB1cqfYEtxgFLsIb/jTrnj+Ok9rfar3UdN4yzfD
	vQI+4/bKmkNbWdGrjXsOlLrshTjoU=
X-Google-Smtp-Source: AGHT+IGoN1vXyfIWvY9dZBg/by2aVbZ4Hg/Ny705+ggR23c2qEnyCMbvNJdHUHW82VdZhcisvUmTmw==
X-Received: by 2002:a05:600c:8284:b0:46e:3d50:360e with SMTP id 5b1f17b1804b1-46e7113f799mr110498325e9.18.1759820659679;
        Tue, 07 Oct 2025 00:04:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bd88:41d2:33ce:f74a? ([2a01:e0a:3d9:2080:bd88:41d2:33ce:f74a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0846sm24397888f8f.45.2025.10.07.00.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 00:04:19 -0700 (PDT)
Message-ID: <de955ab3-26de-43ed-a450-d58ffe0df7af@linaro.org>
Date: Tue, 7 Oct 2025 09:04:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 4/6] sm8650-hdk: Enable I2S for HDMI
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org>
 <20251006-topic-sm8x50-next-hdk-i2s-v1-4-184b15a87e0a@linaro.org>
 <DDBPGIDN8SKS.2GF6TZC6KGXVI@linaro.org>
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
In-Reply-To: <DDBPGIDN8SKS.2GF6TZC6KGXVI@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/25 03:39, Alexey Klimov wrote:
> On Mon Oct 6, 2025 at 7:37 PM BST, Neil Armstrong wrote:
>> Add the necessary nodes to configure the right I2S interface
>> to output audio via the DSI HDMI bridge.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 30 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sm8650.dtsi    | 40 +++++++++++++++++++++++++++++++++
>>   2 files changed, 70 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>> index 87d7190dc991b11f5d1162aabb693dcadd198c51..1286ce95235d5544322a1877292cbdd426298c11 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>> @@ -171,6 +171,19 @@ sound {
>>   				"TX SWR_INPUT1", "ADC2_OUTPUT",
>>   				"TX SWR_INPUT3", "ADC4_OUTPUT";
>>   
>> +		pinctrl-0 = <&i2s0_default_state>, <&audio_mclk0_default_state>;
>> +		pinctrl-names = "default";
>> +
>> +		clocks = <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +			 <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>> +		clock-names = "pri-mi2s",
>> +			      "pri-mclk";
>> +
>> +		assigned-clocks = <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				  <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>> +		assigned-clock-rates = <1536000>,
>> +				       <24576000>;
>> +
>>   		wcd-playback-dai-link {
>>   			link-name = "WCD Playback";
>>   
>> @@ -218,6 +231,22 @@ platform {
>>   				sound-dai = <&q6apm>;
>>   			};
>>   		};
>> +
>> +		pri-mi2s-dai-link {
>> +			link-name = "Primary MI2S Playback";
> 
> Is it HDMI only audio playback or does it have switches to playback it as raw i2s
> (when external DAC is needed)?

The HDK has i2s lines of the secondary i2s on the LS connector, but without any additional
boards connected it has no on-board i2s dacs.

Neil

> 
> 
>> +			cpu {
>> +				sound-dai = <&q6apmbedai PRIMARY_MI2S_RX>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&lt9611_codec 0>;
>> +			};
>> +
>> +			platform {
>> +				sound-dai = <&q6apm>;
>> +			};
>> +		};
>>   	};
> 
> [..]
> 
> Best regards,
> Alexey


