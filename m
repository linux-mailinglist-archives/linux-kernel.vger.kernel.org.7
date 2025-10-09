Return-Path: <linux-kernel+bounces-846820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A91EBC9209
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E7F3E2922
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1502E11A6;
	Thu,  9 Oct 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtfwD2fi"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812F2E092E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014381; cv=none; b=e0MdlAhZdmWuFW0Z2ZXHO2zmSyeHhM/Gn2PwuOau5B212skARd7Wqwvi0TMC1wS+kQnqg2NM/pBxie9bqyLxhNSfxVrNBwVWJEkPvV+piIPmYkpc7p7UCtMg8RPw8Be/flkGdc+rypBRwjX8oedvwchji6eoT1yRnXY/0ggQfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014381; c=relaxed/simple;
	bh=oHmAYYmBYTRgLg0G9VZWm0tEmWvRwHCDyhkyoHqAr5s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kEnI+2mbmOy5EXglFaXw28KAxAoooel7nSaZUnZKR3f4MC3wZQgvbWzC5RgwQrSFM/+GfjmiVtNlQC45aMj/8gx0Fml57hJ58qv4XqfuvtVWmHZnHGdlcs71sh2t+auBxO+CrVoL3Mwm5kK0fQ5qaUfV7GQ3yI50Jq/DKSDCpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtfwD2fi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e2e363118so8022915e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760014378; x=1760619178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRtylrFTnY/RG87DO6cfv9SyY42tBE2nSVvu8MAsJcY=;
        b=rtfwD2fir4E5htRQ1iMTydGys7Dw1iA1UwnC1gdYsE0IpGRMHt7zdXqdAvng4T8bh/
         S6Qqb19rsxe7/A5cAADl56rHLpBh51GjyTnCC2GCwW8/IxlzlwjO6vEWJIkKxGjCqFSp
         lu5y0gFQXizLySgqel1BXkOPpkUFsckJ5GCj9xu9IUqod5oVDgjA6fsY45iHzE7LHWe9
         8f7BZYS1kNK008neqLZZ4IbSSSKRgJJ/UVv1c7kSUrL/+sesTO9EMI3OjILtoQE9LcXt
         Gtw1IEJf31HgiU2xGWAQrdRwj6qGtktCkv/guORzvpuIYEUKruuBE5zqAn8K13l59wIb
         GLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760014378; x=1760619178;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZRtylrFTnY/RG87DO6cfv9SyY42tBE2nSVvu8MAsJcY=;
        b=LhRE+FjoP1RROXPv4mS+f4yVgs79EwzOH4wpQT9v3THumy25vQeefvzTTEGX7k/YFc
         l//UxK3tOtQ+QEIA1X5zT44GmW8zYM8X3RddgIQHIRcfV+4vJJTVC+DQzMr7aIla5vq6
         kqPwp4K+WTkUJnlz3woslO7OlVN6/cwOIJoXoSMPcwEwFgCnb6l/BsMgr2R3Q3i2pydf
         7N0irgOL/fiFptynFJvdTbub+EECtq+7eWzyK8yDJUbFmEcZ3zHHgeq3lNcOumdj95vy
         QZWx4yI/4Dk8NgAvv+4Y+pbIAlMHd/9vsB8Z04t4fr8nX8U21HjD6gNT+ZE3o1e+hwB1
         UHzg==
X-Forwarded-Encrypted: i=1; AJvYcCUsCn54shkjoTWEUVx/Te061nGlW3+ofsNewY6ql8GtDKB/jqxoJnwXQQsf7w2FOJ6M1XUOtE+rwKBgRew=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9WoQO1AlKI6t5++DNtubJwIUTeZrV/67V/sNI+JUvpHy/rEb
	VJcHi09Sb1Qch/pA/9KUZWNQLsw8BExa4rP1QX4SwuqD/Bo3k3hIt7PkA+5XVM5Csa0=
X-Gm-Gg: ASbGncse3EE1uxj6cfe1cQ7kHOl7GcRD/FtMgbttNZ6OsN0MU8vwqxDnpi3/n0Tvq/l
	A5MS49szalfHYpuUVdeBHjdJY53tTdZ5GjjFsdTzh1myaZ4k8RKQhLEXJhfmLqvVsd22jfgrcTI
	dkFSEzLoqoucvUSRgitgLI8eJy5kQOesOQ5cps09G5s6fPe/wd1WYnnmD7Y6LDsZ580Wa6UsgrU
	8dr1Gnbrh7tepkRNMLqYYP/OaGXi7XGVZQveK+ZARM1s5jjBu6taPhOzGeIBJuVt9MmOHo/phSz
	QSq9xKnqUqGjPu42jYEnpUi1WT1Clb5g/UKdWSAL47cQJttzdcIT7dJIDjZ5y5nouAKJ+O0Sob+
	u2ae+40aYQqnOTfMw4XzCmU6CYCnBEggLMWz1D9FfekFtJBJ7b8UneesOnBRDfGxeAIEr1JPjr6
	wwAzqpALRqkcYZ7JzteGLIIFQCVtq/tHJWsHZlgA==
X-Google-Smtp-Source: AGHT+IGRW0VgRpdPRqZKnwEt2a74cE0bxiKcQVyqAB6CmaLRieyQoIUZBI/ty0xAJli/ZygNnj4dqA==
X-Received: by 2002:a05:6000:2504:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-4266e8e61dfmr4927007f8f.55.1760014377777;
        Thu, 09 Oct 2025 05:52:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee? ([2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6daasm34964676f8f.7.2025.10.09.05.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 05:52:57 -0700 (PDT)
Message-ID: <d8e202fb-f494-4b5e-bfb9-c94c1fd3af4d@linaro.org>
Date: Thu, 9 Oct 2025 14:52:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC v2 4/6] arm64: dts: qcom: sm8450-hdk: Enable I2S for
 HDMI
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org>
 <20251008-topic-sm8x50-next-hdk-i2s-v2-4-6b7d38d4ad5e@linaro.org>
 <488d9182-175e-47a9-9dc1-f43753d6fdbc@oss.qualcomm.com>
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
In-Reply-To: <488d9182-175e-47a9-9dc1-f43753d6fdbc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 14:37, Konrad Dybcio wrote:
> On 10/8/25 8:56 PM, Neil Armstrong wrote:
>> Add the necessary nodes to configure the right I2S interface
>> to output audio via the DSI HDMI bridge.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 26 +++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi    | 40 +++++++++++++++++++++++++++++++++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>> index 0c6aa7ddf43263f30595b3f0733ec3e126e38608..7b822086a57c600ae9b5668d6d7a375d0ec55fa7 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>> @@ -667,6 +667,8 @@ lt9611_codec: hdmi-bridge@2b {
>>   		pinctrl-names = "default";
>>   		pinctrl-0 = <&lt9611_irq_pin &lt9611_rst_pin>;
>>   
>> +		#sound-dai-cells = <1>;
>> +
>>   		ports {
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> @@ -1016,6 +1018,14 @@ &sound {
>>   			"TX SWR_INPUT0", "ADC3_OUTPUT",
>>   			"TX SWR_INPUT1", "ADC4_OUTPUT";
>>   
>> +	pinctrl-0 = <&i2s0_default_state>, <&audio_mclk0_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	clocks = <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +		 <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>> +	clock-names = "primart-mi2s",
> 
> "primary-mi2s"
> 
> [...]

Damn typo

> 
>> +			audio_mclk0_default_state: audio-mclk0-default-state {
>> +				pins = "gpio125";
>> +				function = "pri_mi2s";
>> +				drive-strength = <8>;
>> +				bias-disable;
>> +				output-high;
>> +			};
>> +
>> +			i2s0_default_state: i2s0-default-state {
>> +				sck-pins {
>> +					pins = "gpio126";
>> +					function = "mi2s0_sck";
>> +					drive-strength = <8>;
>> +					bias-disable;
>> +					output-high;
> 
> I doubt output-high for a clock pin is what you want..

This was copied from downstream:

================><============================
		i2s0_sck_active: i2s0_sck_active {
<snip>
			config {
				pins = "gpio126";
				drive-strength = <8>;   /* 8 mA */
				bias-disable;           /* NO PULL */
				output-high;
			};
<snip>
		i2s0_ws_active: i2s0_ws_active {
<snip>
			config {
				pins = "gpio129";
				drive-strength = <8>;   /* 8 mA */
				bias-disable;           /* NO PULL */
				output-high;
			};
================><============================

And also set the same way arch/arm64/boot/dts/qcom/sm4250.dtsi

And I guess this level would only set when the function is not active.

Neil

> 
>> +				};
>> +
>> +				data0-pins {
>> +					pins = "gpio127";
>> +					function = "mi2s0_data0";
>> +					drive-strength = <8>;
>> +					bias-disable;
>> +				};
>> +
>> +				data1-pins {
>> +					pins = "gpio128";
>> +					function = "mi2s0_data1";
>> +					drive-strength = <8>;
>> +					bias-disable;
>> +				};
>> +
>> +				ws-pins {
>> +					pins = "gpio129";
>> +					function = "mi2s0_ws";
>> +					drive-strength = <8>;
>> +					bias-disable;
>> +					output-high;
> 
> here too
> 
> Konrad


