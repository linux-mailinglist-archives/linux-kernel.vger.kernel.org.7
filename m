Return-Path: <linux-kernel+bounces-824321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C35F5B88A74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 704074E2C22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE78214286;
	Fri, 19 Sep 2025 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p93MOybz"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC31EA7D2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275489; cv=none; b=jAzcIbhYHkpIH8Lj9+bAq8MjadWArHziJ9RnNXFQVYLPNiCC3rAhLbMn4fagnu9B31pj5Hwri/RW1CgyTjl+RxRVKARIagbglllQZ4FUvPEJvDiJKSNJkn0QI8Vb6OD85C//lYd6Dq9XFjBi02GAnQ9ZA1P0aYo/XKJXVCaIO8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275489; c=relaxed/simple;
	bh=ZSmfod8F0xP5B3jG9EIL8Nfki4rJA5Bjeq3d861kBBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aforDNiIP88IoCiNn7PthZy4YH7/iozNGInRK7OzSkA+Wyx9tLNVpAz6lTMJ+XRFZhiKiOCHMsuo8OjnZmz2lvb164SeDR3ghhyOH1erFvglB6OXHpeg7dCWwgu1xjpca3JDyRTXznoAT+/cOBuSknAhhqnE4YHAe/IobVWwZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p93MOybz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-467f6fd4e82so1972255e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758275485; x=1758880285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wJ+eUcDOTPF44U3mduQyHn2F0Lz48mZcohYBzJ4Fi4=;
        b=p93MOybzDZatwJXlKYjGftHbVuIvGx+jN34t2QxvzfeJVK9ynH3RNLAjVxiIlXxJJY
         IbfQiUMHcgDkaonKXjHsYNb6luWdKbIgZD05Q+dYLQUQixBI+OXjUHkZzdQECbqZ6qhE
         llnq1FObXNltPyPNZYfBV0A+3Ddxo9cltGorl39FmE9n+2QJOa4iZqkcVHcGBJrucQ0f
         w0/OEvKg79rZneGril9nwGE3SB8NAbBaoPNZbNz8CMB4xw7hnqWoVDyqvUrhELEKLVLe
         K7g6DNHSD4XcEwz5px3kzuStQ02poLY6ywlCfE6GWz+8geEF8PWdG7O2fMmjOQb5cpQE
         6CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275485; x=1758880285;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7wJ+eUcDOTPF44U3mduQyHn2F0Lz48mZcohYBzJ4Fi4=;
        b=XHS8nAbwwu8hkWPAdFbzQiCgYcIaTd0qTeEhfWtPHHd2tF4oeYxa4o7k0jBD+LcQj3
         iPOpabK39ZXu1dAYvmWNQgRxx56fPB08BBLCnuC4CmAtreCjI5AAqaNguD8WYZWVlWd0
         ExYGfdy7X+PJ8jMa95wWvlGIf3cVzx4js419OxQjjBg4Wmdpu8PYapp2ZeN/QRjhgRH4
         zR4BUM99IIts6cUhpIzDV+ge+E2NNjUd2GSgikwGkbdr0vwS7LyI7zGm4sOKnR2KkqfX
         PoOXl5oLd9uoerBdGm27l5SYJxg5wGzbMH47Cw6UnxxyIcT9nDGM0GOaW+ZbtWsRrz8q
         zkSA==
X-Forwarded-Encrypted: i=1; AJvYcCU+N7Kdsidhk3hB3PvIOq3y2Pf2M0b6oV8kHLFwd6ETOopOMpTMk8Gy+XQgCV/xoFqXqgAO6705jcq/kKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG959bBXxA+cJVOIYhVUUnoO/BqQH7layYZxYdk6lsc+/xlfMo
	Xp4jYCCz+oKN9A7u13vZXZ3n5huGHeDtRidTOAz3m51cEN27lhlNBp97fIZk1k4xnuM=
X-Gm-Gg: ASbGnctmHpYRTuyy5tvNfuJFAc3xtV4KNcdYRRIkYma2JBxGHcJ075PDnnGon1cjnl2
	V/xjDW9Z/0ZGBkBlu3Ao034oa24BQtA3sARuOXh78SUrZOoH4neKzWop3rGY5py3AzMBLqnJ17J
	i72xp4MZj11doPcYMR6t6HJtYAGQgykYJMCwKxxntElo9c0YQ/414ZrjGAf5PBVdr3LZ2EmiHas
	tVth/rkdXpwGu/h1OLZnRMTXdlOjOiZniLRA5K4j0mG9Qwb+WXxmiUXvt8UBSqPpmpyQiypdKxh
	w17XdS0ko00q7MOCEU4bZIayJgSB8z85/tm96wvokTrYdhDLVFlMk+ma6/SUB12C2nh3wjObc3L
	dpAMquybBg7mj5QlbqzPp9lUt4bjzR2/iCfhw4hmCgkhXZYqc+2UtJghHz1l3oWP3lYpZjf2A
X-Google-Smtp-Source: AGHT+IEPEEJJkjuWsT4BwFdj108NDrZKSdA4XLz/Cg5WWb25sMDN3Mti31DRvEdjU7bjwZ3BmKBBGg==
X-Received: by 2002:a05:600c:4f16:b0:465:a51d:ab with SMTP id 5b1f17b1804b1-468e610fc93mr14666845e9.15.1758275485399;
        Fri, 19 Sep 2025 02:51:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:77b3:66a:b2a0:c20f? ([2a01:e0a:3d9:2080:77b3:66a:b2a0:c20f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325cec0fsm79482155e9.4.2025.09.19.02.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 02:51:24 -0700 (PDT)
Message-ID: <9b0ace7d-2330-4152-b88c-b5d6ccb90b39@linaro.org>
Date: Fri, 19 Sep 2025 11:51:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RESEND PATCH v4 0/3] Fix lpaif_type and DAI configuration for
 I2S interface
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
 prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com
References: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
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
In-Reply-To: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2025 08:36, Mohammad Rafi Shaik wrote:
> Fix the lpaif_type configuration for the I2S interface.
> The proper lpaif interface type required to allow DSP to vote
> appropriate clock setting for I2S interface and also Add support
> for configuring the DAI format on MI2S interfaces to allow setting
> the appropriate bit clock and frame clock polarity, ensuring correct
> audio data transmissionover MI2S.
> 
> changes in [v4]:
> 	- Updated commit message in patch v4-0003, suggested by Srinivas Kandagatla.
> 	- Link to V3: https://lore.kernel.org/linux-sound/20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com/
> 
> changes in [v3]:
> 	- Added Cc: <stable@vger.kernel.org>, suggested by Srinivas Kandagatla.
> 	- Added QUINARY MI2S case in patch 3, suggested by Konrad.
> 	- Link to V2: https://lore.kernel.org/lkml/20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com/
> 
> changes in [v2]:
> 	- Used snd_soc_dai_set_fmt() API to set the current clock settings,
> 	  instead of the default WS source setting, as suggested by Srinivas Kandagatla.
> 	- Link to V1: https://lore.kernel.org/lkml/20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com/
> 
> Mohammad Rafi Shaik (3):
>    ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S
>      interface
>    ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
>    ASoC: qcom: sc8280xp: Enable DAI format configuration for MI2S
>      interfaces
> 
>   sound/soc/qcom/qdsp6/audioreach.c       | 1 +
>   sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
>   sound/soc/qcom/sc8280xp.c               | 4 ++++
>   3 files changed, 6 insertions(+)
> 

Fixes a long-term issue I had with I2S with audioreach platforms, thanks!

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

Neil

