Return-Path: <linux-kernel+bounces-846915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C60BC96B2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67C603502D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AE52EA16C;
	Thu,  9 Oct 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pSN99V5Z"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008812E9759
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018680; cv=none; b=F1Xn/hW2giYknp34DdPhDa+dX4tkrBmcYWtVvxCfvsEqGKbH1deTXX7E9MpfZzKVWfpzElnO+LJ7t33vlmA1sig5WiYpQJSXbm3lMUMLbMurJpHGN+ACSltCn1FaoZNxRh2K7A7dMuvyx8Sq2Yy/HHkfjq9LB1HarWvEwB18rLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018680; c=relaxed/simple;
	bh=tk/cYOn+RXP48pQqqYzLwpBvg60uwFm5MVuqdoh1pTU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q60IOGp3f2t04Op1+MPNK5SF7oBL2QVYyR7DhLIuBu6YyuubW1FFyFy+TKlemg8db7QI84wnCLCA6PlvLEGdFtHW7mhj2jd28lio7S4F1I+GCfFtVE6OhzWZcIhhMi0kzud/pz0MVAKc0RiGMTtFaZEGIdxuhGhIMknGHc5ulHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pSN99V5Z; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-421b93ee372so552760f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760018676; x=1760623476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUg0c3w0jdZyYUql6+ZPTRNjpOHUohwnlvc5D8U2HaQ=;
        b=pSN99V5ZCjD8uuHOwN9lciqvp5KLZo27ouUof8bAgvM2/TUzxandjvu80vdlJBc6bx
         KZxq9BrErfAEvHscKAkvBIascigyN5ZM03da8x+gWHN7EJtGsOsCJIuuAGfJ/ikdP9a2
         IMg8MyBblsGBw7CoirGHjsRS++GoC5I2ct1PN0tr3pvIHz+M7TPNwU/F5CO40KevbbcQ
         jAqCVSkiCux1voGdzH/cVWcsgPcgE3S4LjZXwsP70NIXSczkXERcqH6vJCyEV7Mk+5MH
         r7pbW2zOz/PCfejAGaN8iB/2FTNlkeRtu5iyBR35zNtbeRSkHK1Fj4sSV38BgmmQDsbo
         Nz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018676; x=1760623476;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUg0c3w0jdZyYUql6+ZPTRNjpOHUohwnlvc5D8U2HaQ=;
        b=HH203s+RRGAmwtJ8LGduErMI1X4uARW1TD9TE3MESEWpafBedliy/0TFBQU5ZEkCbi
         SacOp1DKXVLTGtu2Z+smsWlnTKJumpO3Q0HTg9V8dOrybWtFD+il1qJl6sbt69+6/cNo
         rIkGnuF8+KoWBV64IRjw13qUEkZnSs2FnHPZakXCT54duXpJ1M3L3x6JSlO8+lTQ20Bw
         oSzq+sRTW7zxbPPvm8lo3gkD478fUV8mgQqZ6ISftnwBzqYKYAC6ilqJltS6UrhHmjZV
         DumiFdumkqaMlP2FmNTBZ7uqlVq20N9g1nKpM2ZbfOoI4rsJU8wyuDPERIW5qHCbqJaa
         EAYw==
X-Forwarded-Encrypted: i=1; AJvYcCW6AB7DQ7w/HE5YnvtgBfvYeex5y+imPevVkTb2rE97ruLlRCgoz9Q2rMOeDTSVyfuvQjXJP0lin9zR1Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwaOBUFu16Qgxfd5oZxOZ2LyfX2N8h2QLC4JOwbm/SyMaQKph8
	ujJPOUrVFsRxIC6miPPg9yI0RcdxxA0uI5HY+W/1A7clAoThz07eJUbG46/gSnneu7E=
X-Gm-Gg: ASbGncu7TiCH8/FAJpvwewtpiPNGWR+0wXG6ZHdzCoC41Tkf1Il1nWxp9A1bzjXicXS
	q3QyZufpbpJZq2NAtJyStzoQPFiUkzSJ4OadiGg7kAYAywWUa0G9t6rH/+qyo38m/gF3wFNWf5K
	gtplPv17vmhfb6mdV0jDlkU8VhTb1+7Roj9hVm1oyjqIJCviLLpvXIW3N5FM5bXzpJQM7tFusa/
	K9nGXMajWfZU8BdlCQx9D2HgSYqOE3SmU60cxjtPrWc+/Ml5HlRwwKtp/pe3k+ePpUAYU3j4Iqt
	B7VAocECkwGvy+/u6/7Rm9o98vunB+GNzdD+ZYC4JdFqaP0LaAkXgGAGcb4sH+mQQV2vgqWYgNc
	ydwLDoH1S6JvgSfekhbqwYm9rX1Oma8HpBHm6ybm/Wkcb1bznmxNrR4MaXLchMWLJ01vqQcBtgg
	X0T/wCASEuXyf4u8h0JzxEtPW+Nig=
X-Google-Smtp-Source: AGHT+IE+o1t5QvfB9eeLq8N/WxEGFEjiMmBbv8c/nB7cNxr9l2X35Hizf22msINPfHaRe2Sk/sefng==
X-Received: by 2002:a05:6000:2389:b0:3fd:eb15:77a with SMTP id ffacd0b85a97d-42666ac2da4mr4664596f8f.6.1760018675981;
        Thu, 09 Oct 2025 07:04:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee? ([2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d869d50sm36000079f8f.0.2025.10.09.07.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:04:35 -0700 (PDT)
Message-ID: <977ab1fa-cd57-47eb-98a6-38f59c792be7@linaro.org>
Date: Thu, 9 Oct 2025 16:04:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC v2 3/6] ASoC: soc: qcom: sc8280xp: add support for I2S
 clocks
To: Srinivas Kandagatla <srini@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org>
 <20251008-topic-sm8x50-next-hdk-i2s-v2-3-6b7d38d4ad5e@linaro.org>
 <5aa30c94-33f1-4f40-9013-dfbac249ce91@kernel.org>
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
In-Reply-To: <5aa30c94-33f1-4f40-9013-dfbac249ce91@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 15:40, Srinivas Kandagatla wrote:
> 
> 
> On 10/8/25 7:56 PM, Neil Armstrong wrote:
>> Add support for getting the I2S clocks used for the MI2S
>> interfaces, and enable/disable the clocks on the PCM
>> startup and shutdown card callbacks.
>>
>> The rate can be easily calculated since the card forces 48Hz,
>> 2 channels at 16bit slot size.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   sound/soc/qcom/sc8280xp.c | 132 +++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 131 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
>> index 78e327bc2f07767b1032f09af7f45b947e7eb67a..82b173c2dabbd1478df49ba9f0cc53e82bf2f8d2 100644
>> --- a/sound/soc/qcom/sc8280xp.c
>> +++ b/sound/soc/qcom/sc8280xp.c
>> @@ -4,6 +4,8 @@
>>   #include <dt-bindings/sound/qcom,q6afe.h>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/of_clk.h>
>>   #include <sound/soc.h>
>>   #include <sound/soc-dapm.h>
>>   #include <sound/pcm.h>
>> @@ -15,15 +17,47 @@
>>   #include "common.h"
>>   #include "sdw.h"
>>   
>> +#define I2S_MAX_CLKS	5
>> +
>> +#define I2S_MCLKFS	256
>> +#define I2S_SLOTSIZE	16
>> +#define I2S_MCLK_RATE(rate, channels) \
>> +		((rate) * (channels) * I2S_MCLKFS)
>> +#define I2S_BIT_RATE(rate, channels) \
>> +		((rate) * (channels) * I2S_SLOTSIZE)
>> +
>> +#define I2S_DEFAULT_RATE	48000
>> +#define I2S_DEFAULT_CHANNELS	2
>> +
> 
> Sorry for not providing this feedback on v1, we should use
> snd_soc_dai_set_sysclk to do this whole clk handling.
> 
> and implment this set_sysclk in q6i2s_ops of q6apm-lpass-dais.c  like
> q6afe-lpass-dais.c

Why ? This makes no sense, why exposing all the clocks in DT ?

This works, so why going back to the hardcoded Elite path ?

Neil

> 
> 
> --srini
> 
>>   struct sc8280xp_snd_data {
>>   	bool stream_prepared[AFE_PORT_MAX];
>>   	struct snd_soc_card *card;
>>   	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
>>   	struct snd_soc_jack jack;
>>   	struct snd_soc_jack dp_jack[8];
>> +	struct clk *i2s_clk[I2S_MAX_CLKS];
>> +	struct clk *i2s_mclk[I2S_MAX_CLKS];
>>   	bool jack_setup;
>>   };
>>   
>> +static int sc8280xp_snd_i2s_index(struct snd_soc_dai *dai)
>> +{
>> +	switch (dai->id) {
>> +	case PRIMARY_MI2S_RX...PRIMARY_MI2S_TX:
>> +		return 0;
>> +	case  SECONDARY_MI2S_RX...SECONDARY_MI2S_TX:
>> +		return 1;
>> +	case TERTIARY_MI2S_RX...TERTIARY_MI2S_TX:
>> +		return 2;
>> +	case QUATERNARY_MI2S_RX...QUATERNARY_MI2S_TX:
>> +		return 3;
>> +	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
>> +		return 4;
>> +	default:
>> +		return -1;
>> +	}
>> +}
>> +
>>   static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>>   {
>>   	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
>> @@ -31,10 +65,22 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>>   	struct snd_soc_card *card = rtd->card;
>>   	struct snd_soc_jack *dp_jack  = NULL;
>>   	int dp_pcm_id = 0;
>> +	int index, ret;
>>   
>>   	switch (cpu_dai->id) {
>>   	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
>>   	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
>> +		index = sc8280xp_snd_i2s_index(cpu_dai);
>> +		ret = clk_set_rate(data->i2s_mclk[index],
>> +				   I2S_MCLK_RATE(I2S_DEFAULT_RATE,
>> +						 I2S_DEFAULT_CHANNELS));
>> +		if (ret)
>> +			dev_err(data->card->dev, "Unable to set mclk rate\n");
>> +		ret = clk_set_rate(data->i2s_clk[index],
>> +				   I2S_BIT_RATE(I2S_DEFAULT_RATE,
>> +						I2S_DEFAULT_CHANNELS));
>> +		if (ret)
>> +			dev_err(data->card->dev, "Unable to set bit rate\n");
>>   		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
>>   		break;
>>   	case WSA_CODEC_DMA_RX_0:
>> @@ -68,12 +114,54 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>>   	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
>>   }
>>   
>> +static int sc8280xp_snd_startup(struct snd_pcm_substream *substream)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
>> +	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>> +	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
>> +	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_BC_FC |
>> +				     SND_SOC_DAIFMT_NB_NF |
>> +				     SND_SOC_DAIFMT_I2S;
>> +	int index, ret;
>> +
>> +	switch (cpu_dai->id) {
>> +	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
>> +	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
>> +		index = sc8280xp_snd_i2s_index(cpu_dai);
>> +		ret = clk_prepare_enable(pdata->i2s_mclk[index]);
>> +		if (ret)
>> +			dev_err(pdata->card->dev, "Unable to enable bit clock\n");
>> +		ret = clk_prepare_enable(pdata->i2s_clk[index]);
>> +		if (ret)
>> +			dev_err(pdata->card->dev, "Unable to enable master clock\n");
>> +		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return qcom_snd_sdw_startup(substream);
>> +}
>> +
>>   static void sc8280xp_snd_shutdown(struct snd_pcm_substream *substream)
>>   {
>>   	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
>>   	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>>   	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
>>   	struct sdw_stream_runtime *sruntime = pdata->sruntime[cpu_dai->id];
>> +	int index;
>> +
>> +	switch (cpu_dai->id) {
>> +	case PRIMARY_MI2S_RX...TERTIARY_MI2S_RX:
>> +	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
>> +		index = sc8280xp_snd_i2s_index(cpu_dai);
>> +		clk_disable_unprepare(pdata->i2s_clk[index]);
>> +		clk_disable_unprepare(pdata->i2s_mclk[index]);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>>   
>>   	pdata->sruntime[cpu_dai->id] = NULL;
>>   	sdw_release_stream(sruntime);
>> @@ -141,7 +229,7 @@ static int sc8280xp_snd_hw_free(struct snd_pcm_substream *substream)
>>   }
>>   
>>   static const struct snd_soc_ops sc8280xp_be_ops = {
>> -	.startup = qcom_snd_sdw_startup,
>> +	.startup = sc8280xp_snd_startup,
>>   	.shutdown = sc8280xp_snd_shutdown,
>>   	.hw_params = sc8280xp_snd_hw_params,
>>   	.hw_free = sc8280xp_snd_hw_free,
>> @@ -162,6 +250,44 @@ static void sc8280xp_add_be_ops(struct snd_soc_card *card)
>>   	}
>>   }
>>   
>> +static const char * const i2s_bus_names[I2S_MAX_CLKS] = {
>> +	"primary",
>> +	"secondary",
>> +	"tertiary",
>> +	"quaternary",
>> +	"quinary",
>> +};
>> +
>> +static int sc8280xp_get_i2s_clocks(struct platform_device *pdev,
>> +				   struct sc8280xp_snd_data *data)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	int i;
>> +
>> +	if (!device_property_present(dev, "clocks"))
>> +		return 0;
>> +
>> +	for (i = 0; i < I2S_MAX_CLKS; ++i) {
>> +		char name[32];
>> +
>> +		snprintf(name, 32, "%s-mi2s", i2s_bus_names[i]);
>> +		data->i2s_clk[i] = devm_clk_get_optional(dev, name);
>> +		if (IS_ERR(data->i2s_clk[i]))
>> +			return dev_err_probe(dev, PTR_ERR(data->i2s_clk[i]),
>> +					     "unable to get %s clock\n",
>> +					     name);
>> +
>> +		snprintf(name, 32, "%s-mclk", i2s_bus_names[i]);
>> +		data->i2s_mclk[i] = devm_clk_get_optional(dev, name);
>> +		if (IS_ERR(data->i2s_mclk[i]))
>> +			return dev_err_probe(dev, PTR_ERR(data->i2s_mclk[i]),
>> +					     "unable to get %s clock\n",
>> +					     name);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int sc8280xp_platform_probe(struct platform_device *pdev)
>>   {
>>   	struct snd_soc_card *card;
>> @@ -185,6 +311,10 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = sc8280xp_get_i2s_clocks(pdev, data);
>> +	if (ret)
>> +		return ret;
>> +
>>   	card->driver_name = of_device_get_match_data(dev);
>>   	sc8280xp_add_be_ops(card);
>>   	return devm_snd_soc_register_card(dev, card);
>>
> 


