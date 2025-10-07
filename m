Return-Path: <linux-kernel+bounces-844464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F6BC1FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6803E1D85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC52E6CA0;
	Tue,  7 Oct 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZFInhnsO"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0D2E1EF8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852140; cv=none; b=SlurbNU8NWhmflHn6lIZcZVqizHZGPgjbND5p5lhVsPnV2+3nw/kBd06LXVvmTQ8Vl7sDvTXPSz3BbfqFxisBzm+9jHf0SRDQIv8/ECf0EQtZfoJAJBv12/MLF9lLkOQ+kQ5h2JOrZVlRsuCKtZNJUJwDO/Yj3r0TWrTtyvWpYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852140; c=relaxed/simple;
	bh=idsLDC2Nv76ap5anKli8m472glzZKQst8172esv0100=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=txsCk6ylaSNfQpcgLiDuGXDtEnemVMhyGHrBsLv7zlNi4KzF8SbowUbTG10aUnZi444EcFcC/EBn7jhUrhiFB50mFOkmq/Wd4nmMN8jnIxSGgH5uZVUDQwXYiYvfERY5sHd+utdgXia5PmonTUouPdhX871Q5NgqJXaPhI8kU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZFInhnsO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso3918670f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759852136; x=1760456936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujqZTrSIRL5Br3jVEaXKCPK1WTB5adLLumme0kdn1es=;
        b=ZFInhnsO9qhM3O/HHfNTgrDRYv8gVabeM8l4nUyFUgIWCzqtulABXukRNPi7k9GtEN
         ducrv5yeGokrvoM2TaIWAepIhkm2QT6AEDJAoxXEQ9lQIg7EtR3gIfsljhuFn/uLS0Qp
         wfiQaREyKXSRwhPMs23C23ICE5H2zT+JBX2zlgxHwtA6eDinW/ujEX6zbX/l2Wv7gPNA
         7SV4joVUFwhunB1aP+iD52MfiNvoKAYRn+N5tCfzoGxW5QHQ74B1ADGVsNhnl+FIvsnp
         cIEtr/+QIBtp9cf0Vd+JQLJ5EL0qJMZKSW+VGJZDZHXhSl8GJ9W7DF1KaRkA9Dc4XKNM
         OcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852136; x=1760456936;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ujqZTrSIRL5Br3jVEaXKCPK1WTB5adLLumme0kdn1es=;
        b=xA76I32VVMWNN8GyU/3S6Npc8X1w8KR/0CDOst+oLYXSGSWgjyRWG91lqJ1y6SpMxq
         HXIlsPW4n6SpZM/Pr0OjAw3PwPw4kzhobY+/tPD9rrqnrlRrhCnvsfO9OnaHY25WoSdG
         tv8BNBdT536tk1qlzqOuJx1G7ALWM1D4PkSef1P7O/3Qghh8JiDzy5N0jrE8QOB+kOo7
         88GzGJBH4dgeYPbZ1LTRLy3c3qJ5TiMxplSueOKsAMZprPRkwlXm7ayYZVZfm1EgvTYt
         po5eXPZKyXj4zC5oG8RFzuYzew416dlnMkdEbqiV6yL+qI4iAx56Ea2hn/r5CMBOOZ+z
         PXMw==
X-Forwarded-Encrypted: i=1; AJvYcCVnh5GmDlp/8xoOvlPjrAQZ49qRTvPoJr6aao4laEyRh3LoFNE6AW6dRE5vLordlcccR2S/EjOBBbXSuYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSig0Dok1PbL/A/ld9UjirJ/CgYx/rehPD8uPABe2eYsY6/TA
	dIdH/MYMG+AS9N6aWLObofrvAl4OHhy4hB1aAqWBGdTFc7nuDTzXNHRnVfRbvvSi8rs=
X-Gm-Gg: ASbGncs/7lB+ObO4rEeb1Z1/1jxyuvU0JeFz0SxpvVwb/J3VdusXVFPWlYUqmAg6T3P
	DcGue+3bPb0tTLmMtT7axSbyhDETVaYozbmIPyY8s7cS1lG4ZR5NeHkL7WRL2IhKdT759L0OJLq
	wTM4ZS9zRph4gnvce9Tpyr45PsfjkzFX5B40Ll4Y5smylSP3bRco8ERZ6ongxYn4euaqUuEVZlu
	NQwIkQA/1KoZ2jOcqzXp87JJT5mOnmbrK+8FApw6sTjat6BBkwW0rHebm+hA++M9/cYPcPLm6rd
	HFBk6qkxOhtXZ6+mpxwzhb6acN+4scyEElJibMZRUzrJZq4ZceQ3FO4HFEmHCdYpflb6eBQZizw
	9BwkiRHGLPkMGILgMO8G0CIm5myJEc4KNC2RpHb8lupqyX0nmz3SbwE/aKZTHdeFu46vxhmGnF0
	0BY5ElTpd/i8huWM8AoBx2r0PBm3Y=
X-Google-Smtp-Source: AGHT+IGlCt3WNje/lItmY3GQsKoJPUs6M1EHh44EgkG7EO1ZdmP5CqynBnMwr5jKEwAuFYo6Szge1Q==
X-Received: by 2002:a05:6000:1a8b:b0:3fb:6f9d:2704 with SMTP id ffacd0b85a97d-42567174a0cmr10730399f8f.28.1759852136117;
        Tue, 07 Oct 2025 08:48:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bd88:41d2:33ce:f74a? ([2a01:e0a:3d9:2080:bd88:41d2:33ce:f74a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0170sm26770403f8f.49.2025.10.07.08.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 08:48:55 -0700 (PDT)
Message-ID: <a5dfaf2a-d2c8-468a-9bbe-38d11b1214a8@linaro.org>
Date: Tue, 7 Oct 2025 17:48:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 3/6] ASoC: soc: qcom: sc8280xp: add support for I2S
 clocks
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org>
 <20251006-topic-sm8x50-next-hdk-i2s-v1-3-184b15a87e0a@linaro.org>
 <6492e444-4196-4900-a741-a74a8c506a6d@kernel.org>
 <1eab5200-1292-4d39-bdf8-0c5084cfaab9@linaro.org>
 <f15ea346-43f7-49bc-bd5e-47510a48892d@oss.qualcomm.com>
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
In-Reply-To: <f15ea346-43f7-49bc-bd5e-47510a48892d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/25 12:23, Konrad Dybcio wrote:
> On 10/7/25 9:02 AM, Neil Armstrong wrote:
>> On 10/7/25 00:21, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 10/6/25 7:37 PM, Neil Armstrong wrote:
>>>> Add support for getting the I2S clocks used for the MI2S
>>>> interfaces, and enable/disable the clocks on the PCM
>>>> startup and shutdown card callbacks.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
> 
> [...]
> 
>>>> +static int sc8280xp_snd_startup(struct snd_pcm_substream *substream)
>>>> +{
>>>> +    unsigned int codec_dai_fmt = SND_SOC_DAIFMT_BC_FC | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
>>>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>>> +    struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
>>>> +    struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>>>> +    struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
>>>> +    int index;
>>>> +
>>>> +    switch (cpu_dai->id) {
>>>> +    case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
>>>> +    case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
>>>> +        index = sc8280xp_snd_i2s_index(cpu_dai);
>>>
>>> What is the mclk and bitclk rate set here, we can not rely on the
>>> default rate.
>>
>> The default rates are set in DT:
>> +        assigned-clocks = <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +                  <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>> +        assigned-clock-rates = <1536000>,
>> +                       <24576000>;
> 
> Is there a way to infer these rates based on the DT audio
> connection graph?

Good question, it's not done for pre-audioreach. Let me investigate.

Neil

> 
> Konrad


