Return-Path: <linux-kernel+bounces-843869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6F3BC0745
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070703C40BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D823312D;
	Tue,  7 Oct 2025 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYEMfcjr"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA021FF48
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820574; cv=none; b=e7lCzd8aT9NOoSgOiXu2gtS24Rt9osq9TePcQDlP1lVe8SKzdU4l3ynaN7Xm9oyfpZsVHLdTk9MkBhu4L3ITRZQXsS6ZMJwu8iimiiEJqBB3eYO+pQcjh5iBSHfCnvAVGu7ZampbgXESY2JNKRvgyoshOr3z1TbNtbAL9QLNJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820574; c=relaxed/simple;
	bh=VQt2nmURfiv22OOUeiqX8iNfEzqj2c7uxemMqI9UcU0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fwgzux67iFC+tTD13khRXNxaObZWaYdya3qVEsE6/b5uNytt3V9MFJEu/0YHkiVqL+6sFoZxwZ5PFkpOE8rEVZ+GsNYguISVPqZPt+0Vp5nYVqbnZfHTK8qWNOp+QkZSNF7XJZxnrXziGhljFPCv1PnkDiKOMVYlCko6o/YCyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VYEMfcjr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so35238495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759820571; x=1760425371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eu9SG7BZFTKEWgYnY27MGUVrVuv+Cxtn/DX2TywVQ7c=;
        b=VYEMfcjroRUsOmMVUh5KGcQOmpPftmDvpn0cniHeyKY19mdFVrUuVBL7Qvuqeu+ngt
         wuSw8V4V9Pk/0awrhwcve03T119soaLD+g+Lm+0xdJsIaZyJ2da//emVWYCGAXFuhc3m
         IKCqmBxq713Ffvzrl5tCFXD4KWNZj625+UDze0BTvO5T33xi3CL4bl5BzB0cJGIM9bXX
         Pxnrx8yEhMjlFz5wxCMesE2GaOTV/gHN6HrNHHH/n6AjNLw73h1sQHc0TjplR7AhhBX2
         0s4yrMqeaaPiNfNpbLwRLAza5vajr2AvByLexA64T6TnGdlhJpCcib/2QvapM+Y78aXg
         f5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759820571; x=1760425371;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eu9SG7BZFTKEWgYnY27MGUVrVuv+Cxtn/DX2TywVQ7c=;
        b=Isrg1j9ZBVeYwlediz9O7V9gFrOJp8xG0rxAt40nB4fd0wbw+hRxdKf37LN8xBVUoR
         hrNd3iWPkvJUapJ3NsABNJDmyL8ZM8DM8FzkylS+xqeFlm5cGR7nKtZ7kKM9xQ5hnmEA
         xnNXyTZnqjzYVGB32jIl87cPmp3iLBks+UN78EoOWXPoYErIpsKhLwLMeB01Irds5qJ+
         0jstA9f++cA2NPRpLxkuv8xUxLlqKj5rO8jC5dRhCyVVQYrYFDZo6uqRZTX7p/mDz5p7
         mtr4xlZx5MXQuKTWjEJZ5orW8OQK0cmkWAp1xcnjJ5/AUg01Dg72ZWnVU6M0/s/A9jXw
         uuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSIxdq9xwH99odtTGadRgVONg5T7Ly7/WBCcFjxXtIbsIsA/9K6/YDOGH4QNN9mI8sAlDdOb8Dz5O8ZvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgOok9qphnn2DU0/oosCrrd0iKfkvI0739UrIAYDZBBIaHpsaV
	+zQp0ek8EMhUZLCRqrXIZ8UBSkf6M7i7ZnXppDCwSiAes9E9dpUyLeCGashVPIudSsg=
X-Gm-Gg: ASbGnctWK6gT2clYxQPz6DS4ygZd8DtysJuBeTT5mgtw22ypM2Z+3iswUg6pu9qhMcG
	js+/8+RbC/btsCcxT3DNEQXBEicAAaFH3GYw6Gmwo0vrMnAAGhKD39f/xcQfmV4RQQJfDMVBbzh
	6K2xVoTIxowDeWMJicM8mEfZ9Nuy17XtUSyxaVQCoIW3C27sZX2SqTW7ntVp1BVnbyu3gGXZyM1
	iLxdYUfaVArcixf6dWb0/GrcT6KJ4O0STs2bvwS2dMriNsheOkpQrvr56b9Gky8PYIyeBwW/Raa
	jjzSpz9W/5cLjGwU1EqvwzfGI/1x21GyCeQ/eD/3tKPjvW7CWrBIphxwu1vDiM4CihLi/hJndin
	zUEeGtx0W+9I24bKJGTlxhF7r168MIb9d3oGWdQ0e5jeENe5CY5tCwQMaMPQItoESIZXLYQNhOy
	d4rrZnyXDdbPreXxzchL58l9Rx760=
X-Google-Smtp-Source: AGHT+IHu4c6+ptDhkN4aNfSg9CdsgG1+qNA6BXPpkqBLPR4xEgumTflTyMVuyYYTTO8lbW2LKQ7Lgg==
X-Received: by 2002:a05:600c:528d:b0:46e:6339:79c5 with SMTP id 5b1f17b1804b1-46fa298df05mr14854985e9.5.1759820571006;
        Tue, 07 Oct 2025 00:02:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bd88:41d2:33ce:f74a? ([2a01:e0a:3d9:2080:bd88:41d2:33ce:f74a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe49sm24270805f8f.21.2025.10.07.00.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 00:02:50 -0700 (PDT)
Message-ID: <87ce48a0-488e-428f-99ab-a203dcde5b0e@linaro.org>
Date: Tue, 7 Oct 2025 09:02:48 +0200
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
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org>
 <20251006-topic-sm8x50-next-hdk-i2s-v1-3-184b15a87e0a@linaro.org>
 <DDBPDACTUFEW.1VVHN1P0PC6YO@linaro.org>
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
In-Reply-To: <DDBPDACTUFEW.1VVHN1P0PC6YO@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/25 03:35, Alexey Klimov wrote:
> On Mon Oct 6, 2025 at 7:37 PM BST, Neil Armstrong wrote:
>> Add support for getting the I2S clocks used for the MI2S
>> interfaces, and enable/disable the clocks on the PCM
>> startup and shutdown card callbacks.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   sound/soc/qcom/sc8280xp.c | 104 +++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 103 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
>> index 78e327bc2f07767b1032f09af7f45b947e7eb67a..ad4ee5c6fab8994f18de572842f3dab6f4f5397e 100644
>> --- a/sound/soc/qcom/sc8280xp.c
>> +++ b/sound/soc/qcom/sc8280xp.c
>> @@ -4,6 +4,8 @@
>>   #include <dt-bindings/sound/qcom,q6afe.h>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/of_clk.h>
> 
> ^^

I'll fix that

> 
> [..]
> 
>>   static const struct snd_soc_ops sc8280xp_be_ops = {
>> -	.startup = qcom_snd_sdw_startup,
>> +	.startup = sc8280xp_snd_startup,
>>   	.shutdown = sc8280xp_snd_shutdown,
>>   	.hw_params = sc8280xp_snd_hw_params,
>>   	.hw_free = sc8280xp_snd_hw_free,
>> @@ -162,6 +222,44 @@ static void sc8280xp_add_be_ops(struct snd_soc_card *card)
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
>> +static int sc8280xp_get_i2c_clocks(struct platform_device *pdev,
>> +				   struct sc8280xp_snd_data *data)
>> +{
> 
> Could you please confirm that this should be _i2c_ clocks?

Damn, typo, it should obviously be i2s

Neil

> 
> [..]
> 
> Best regards,
> Alexey


