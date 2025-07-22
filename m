Return-Path: <linux-kernel+bounces-740623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9477DB0D6DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF2B7A6D71
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D728F2E1722;
	Tue, 22 Jul 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axD680Rq"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00EE2E11CA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178651; cv=none; b=kmLLI5ORLwXWaXAHtnjFzPZBSLUZoBLhmr479gQMsNuNkqS6oiERSB5XyBjvvxsUBK2PoAOK3RJawNxgy92T+Zz/CvV/vSFvE2exAVTZSRfbj1cfNSGoZWqkHHcWQKmmlwKzOF5doKx1q4SQz1Jn4WAlWuNFBpP9LgFdL7nmbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178651; c=relaxed/simple;
	bh=KYrcl1G4+4SA6Q7asi6gBbxGb0BlID+2kqdvhbksLG0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UNwR0z2x49u+isRrllqkKLzyLLpXB/WgmB2Hqh+5sFCH/6NIGgt8P/YDkic6bf8ss0uJUiiKL9G+jdVMGgSAuaVjJUqzHq7dcIh5aIoXWcmCWDPxU0uDErGdXppgetAyUb9yK8ily/kwl1rucB4WLrN2J4hg5dwGWE32Vss0IO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=axD680Rq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so36292795e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753178647; x=1753783447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8p5LfuSX/Mmlw4uTxhLrmQy+4Ez8VbT/jSY03w1rUEM=;
        b=axD680Rq/8JHBildBDBZRdqAjkS8quoQxP1kfYqjqbXSM2/iv7Inz+Z5Lq9no/kwOk
         umAmlpTVvXoCeqO8Z01Qejnu3xBSMPnC3w+6s8yx8I3DMzLTboqBTQ6AxIBAuAE6OKAJ
         zeOftFlARz0vqKM3blN/6JI/KSHGh+ElaQ+uhetiXASyZxm+IMAmi+MKgbTWHpoKJt9a
         yhg5sxbQY29aQwKgEYUtIlF+sfYbGtpNLPpL7yixdtIv1RDyMeYcZTtpS4jX2dsjZ5cJ
         EQH8awFobTJWDX2yVvpghx5AC2ZrHfn7rrG3Zt0DWHKD5U1aqawvEl6kROh0qZAShTzg
         FbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753178647; x=1753783447;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8p5LfuSX/Mmlw4uTxhLrmQy+4Ez8VbT/jSY03w1rUEM=;
        b=FysHW8nIaJsH2Kb2CuU5oWI8uznMvTgRAOFSI9HHqTWccZuSE1ECYYke44zlUAv0mu
         OGn4C1D2O1W1GPoBUFFxbBcS6g/fuijRG0hqKNkw1IBJYv7FLlDIhvEBmwIe9Clqc5DA
         J0N+85u3GoU96qtCJjeHXbFFtTjybTegNugpiJem4cHqtRiQAknB2CGSlNHUaMD8v89Z
         /WrUwtPLD/6svzOsLGN1SeDXLHZna0ZqgS8C8h2YLjdizr/4uHjXF5DqM1fQLThDy/bp
         W2Qe1dByYy7/+VTVoemVx2tzShHEbqCk9OLlltW5MbGw/aKbxF09wpvtb7YVADS2vvu7
         kPDA==
X-Forwarded-Encrypted: i=1; AJvYcCUaXzouJJ0Ml+V3yv+hDJpdoGJ36QvgQVVT3TbFUTo/lT/9SYNNxL3ui2Ybg/dFKGoNTifpfg7EY53gJYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY18J0vwUOQjpIw1o0Scwlo8wzsl0bOrtlbW397xb6tOMWzG7Y
	PqnDcNOYX7PCuD5Aq7cIDUGN7UlpZoGVSdu8ACCVrs5H4vJK10rXjvrLre48r6Qn+tD+fVBxORu
	F0KqK
X-Gm-Gg: ASbGncve+gZwKypaGp+141xxQcyNfvRq7/n7dwsZSjiLbUIowZ79DlkIiIglky6HqVg
	kEM3GqUkcepKg9xFcicrmPtkrIIocytXlvETWzaIEWFvli43FfzFIA+C1cAK0f6zVVdP5wC8KF5
	/utgRuSOmKFACLDkaAIGlcEWpu73MDkMzSffEoq69OZnTIyRFx0M3LkoG15/549YUckz48jXqzG
	anlGMkVNadR92EknMH7ViPpSi6JXsCXhGQSikdtCodTRWikQsU7CoBsWGWm0zE3EL/QUgngZV0f
	c490gApeYuBOTPo2rQGnhy43gIBY5wdQuXTIuH7LQrMaoTi6HXKBUnY8CRg7kKtTBrx3zcrA1ci
	7c9RWjZml6H1FhX0woW0u3ZkWbJcCVpUpZ1XD59sQYI71iwA+VUPHmakp5s7vdoBgfT+C5fM271
	s=
X-Google-Smtp-Source: AGHT+IH5isWZZMV6lAZUl2wzToF7WffjH1cxA2l1CmGXi9Cw3lTE/r5VaLV4Z3CfBiDjNOhMbKQDEg==
X-Received: by 2002:a05:600c:4e03:b0:456:8eb:a35c with SMTP id 5b1f17b1804b1-4562e38b16emr259056935e9.31.1753178647077;
        Tue, 22 Jul 2025 03:04:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bce4:725d:6922:d1ba? ([2a01:e0a:3d9:2080:bce4:725d:6922:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b75baa6f78sm6114413f8f.3.2025.07.22.03.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 03:04:06 -0700 (PDT)
Message-ID: <3bc3e7f9-ef8f-4d09-8da8-c965540f624c@linaro.org>
Date: Tue, 22 Jul 2025 12:04:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] soc: amlogic: clk-measure: Optimize measurement
 accuracy
To: chuan.liu@amlogic.com, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250722-optimize_clk-measure_accuracy-v2-1-cb121fd57e6d@amlogic.com>
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
In-Reply-To: <20250722-optimize_clk-measure_accuracy-v2-1-cb121fd57e6d@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 22/07/2025 08:06, Chuan Liu via B4 Relay wrote:
> From: Chuan Liu <chuan.liu@amlogic.com>
> 
> The cycle count register has a 20-bit effective width, but the driver
> only utilizes 16 bits. This reduces the sampling window when measuring
> high-frequency clocks, resulting in (slightly) degraded measurement
> accuracy.
> 
> The input clock signal path from gate (Controlled by MSR_RUN) to internal
> sampling circuit in clk-measure has a propagation delay requirement: 24
> clock cycles must elapse after mux selection before sampling.
> 
> The measurement circuit employs single-edge sampling for clock frequency
> detection, resulting in a ±1 cycle count error within the measurement window.
> 
> +1 cycle: 3 rising edges captured in 2-cycle measurement window.
>      __    __    __
>   __↑  |__↑  |__↑  |__
>    ^             ^
> 
> -1 cycle: 2 rising edges captured in 3-cycle measurement window.
>      __    __    __
>   __↑  |__↑  |__↑  |__↑
>      ^               ^
> 
> Change-Id: If367c013fe2a8d0c8f5f06888bb8f30a1e46b927

Please drop Change-Id

> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
> Improve measurement accuracy by increasing the bit width of the cycle
> counter register and adding delay during measurement.
> 
> The 800μs delay between enabling the input clock gate and activating
> sampling is determined by the minimum sampling frequency of 30kHz (the
> lowest commonly used frequency in applications is 32.768kHz).
> 
> Here are the test comparisons based on C3:
> 
> Pre-optimization:
> cat /sys/kernel/debug/meson-clk-msr/measure_summary
>    clock                     rate    precision
> ---------------------------------------------
>   sys_clk               166664063    +/-5208Hz
>   axi_clk               499968750    +/-15625Hz
>   rtc_clk                23982813    +/-3125Hz
>   p20_usb2_ckout        479968750    +/-15625Hz
>   eth_mpll_test         499992188    +/-15625Hz
>   sys_pll              1919875000    +/-62500Hz
>   cpu_clk_div16         119998162    +/-3676Hz
>   ts_pll                        0    +/-3125Hz
>   fclk_div2             999843750    +/-31250Hz
>   fclk_div2p5           799953125    +/-31250Hz
>   fclk_div3             666625000    +/-20833Hz
>   fclk_div4             499914063    +/-15625Hz
>   fclk_div5             399987500    +/-12500Hz
>   fclk_div7             285709821    +/-8928Hz
>   fclk_50m               49982813    +/-3125Hz
>   sys_oscin32k_i            26563    +/-3125Hz
> 
> Post-optimization:
> cat /sys/kernel/debug/meson-clk-msr/measure_summary
>    clock                     rate    precision
> ---------------------------------------------
>   sys_clk               166665625    +/-1562Hz
>   axi_clk               499996875    +/-1562Hz
>   rtc_clk                24000000    +/-1562Hz
>   p20_usb2_ckout        479996875    +/-1562Hz
>   eth_mpll_test         499996875    +/-1562Hz
>   sys_pll              1919987132    +/-1838Hz
>   cpu_clk_div16         119998438    +/-1562Hz
>   ts_pll                        0    +/-1562Hz
>   fclk_div2             999993750    +/-1562Hz
>   fclk_div2p5           799995313    +/-1562Hz
>   fclk_div3             666656250    +/-1562Hz
>   fclk_div4             499996875    +/-1562Hz
>   fclk_div5             399993750    +/-1562Hz
>   fclk_div7             285712500    +/-1562Hz
>   fclk_50m               49998438    +/-1562Hz
>   sys_oscin32k_i            32813    +/-1562Hz
> ---
> Changes in v2:
> - Change "HACK" in comments to "NOTE" according to Martin's suggestion.
> - Link to v1: https://lore.kernel.org/r/20250717-optimize_clk-measure_accuracy-v1-1-3b82d7ccd743@amlogic.com
> ---
>   drivers/soc/amlogic/meson-clk-measure.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
> index d862e30a244e..df395e015f26 100644
> --- a/drivers/soc/amlogic/meson-clk-measure.c
> +++ b/drivers/soc/amlogic/meson-clk-measure.c
> @@ -22,7 +22,7 @@ static DEFINE_MUTEX(measure_lock);
>   #define MSR_CLK_SRC		GENMASK(26, 20)
>   #define MSR_BUSY		BIT(31)
>   
> -#define MSR_VAL_MASK		GENMASK(15, 0)
> +#define MSR_VAL_MASK		GENMASK(19, 0)
>   
>   #define DIV_MIN			32
>   #define DIV_STEP		32
> @@ -805,14 +805,23 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
>   	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_DURATION,
>   			   FIELD_PREP(MSR_DURATION, duration - 1));
>   
> -	/* Set ID */
> -	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_CLK_SRC,
> -			   FIELD_PREP(MSR_CLK_SRC, clk_msr_id->id));
> +	/* Set the clock channel ID and enable the input clock gate. */
> +	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_CLK_SRC | MSR_RUN,
> +			   FIELD_PREP(MSR_CLK_SRC, clk_msr_id->id) | MSR_RUN);
>   
> -	/* Enable & Start */
> -	regmap_update_bits(priv->regmap, reg->freq_ctrl,
> -			   MSR_RUN | MSR_ENABLE,
> -			   MSR_RUN | MSR_ENABLE);
> +	/*
> +	 * NOTE: The input clock signal path from gate (Controlled by MSR_RUN)
> +	 * to internal sampling circuit in clk-measure has a propagation delay
> +	 * requirement: 24 clock cycles must elapse after mux selection before
> +	 * sampling.
> +	 *
> +	 * For a 30kHz measurement clock, this translates to an 800μs delay:
> +	 * 800us = 24 / 30000Hz.
> +	 */
> +	fsleep(800);
> +
> +	/* Enable the internal sampling circuit and start clock measurement. */
> +	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_ENABLE, MSR_ENABLE);
>   
>   	ret = regmap_read_poll_timeout(priv->regmap, reg->freq_ctrl,
>   				       val, !(val & MSR_BUSY), 10, 10000);
> @@ -846,7 +855,7 @@ static int meson_measure_best_id(struct meson_msr_id *clk_msr_id,
>   	do {
>   		ret = meson_measure_id(clk_msr_id, duration);
>   		if (ret >= 0)
> -			*precision = (2 * 1000000) / duration;
> +			*precision = 1000000 / duration;
>   		else
>   			duration -= DIV_STEP;
>   	} while (duration >= DIV_MIN && ret == -EINVAL);
> 
> ---
> base-commit: 58abdca0eb653c1a2e755ba9ba406ee475d87636
> change-id: 20250523-optimize_clk-measure_accuracy-9e16ee346dd2
> 
> Best regards,


Thanks a lot for this great work, please send a v3 without the Change-Id and add my:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil


