Return-Path: <linux-kernel+bounces-764241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4637FB22051
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389A81A27788
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C02A2E11DD;
	Tue, 12 Aug 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ux+jFxnT"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FE2E03EA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986006; cv=none; b=iR6KL5QzHiZYqkbJI191OHXYkwtE9wOaBDoJIl/t6IXEZZk2o5cWmnWBqe0ROnkmvse3C9pFI8ain9FgXsP0VYJ91LK/S9jmQsh/Apd5CoK4+6bpgrz+R1j2jy6hA2LrtV84M/dXvzH3kRIDiWIho/QlCa2Bwq8kTWQZMvl2M+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986006; c=relaxed/simple;
	bh=bik/ZxUCbsiXR2/hrDV2nu377/7N0cOxs2aUthTSLgw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F94rdK7bDg+GOrSrtTJzq+thSZc+4Dfjjw76xGdjGGQ9VhzUAFa7ieA1Bkv+jK9/M7k539Ve8M+OyyeUiUb+3I48yGL8DwBBkcRglv9xZD1Rqle/iKgGJ0ba3B6JdigYVB83b5vn4+f/ucb6NcpMdqYXuTmb64qI66ub8likFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ux+jFxnT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b914a9c77dso71777f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754986001; x=1755590801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KB/9AiQUNaaeoTiNfFmXrTqb4RmKBU2EHYLBB9k4Yeg=;
        b=ux+jFxnTmNFmE2PgEOW3qdafEsdddQxyPTpkj46m02roJvgnRrFv3KXfoQr1q41NBR
         /PhKeruEqUPAQCzN/GK9TvVsBVeSCKKFyRnF4r2lKJRX2605h7QaJoOA2eo6ObYc7viK
         Wz9EDnLjs0r0b89QR6/u0tVWBYjkunZ5nAMkqwYSQV+e2LE8fCvognLE8aYKyevT9p+0
         ODXS/FUDeZePbGtHmZ9sFtJSO69/+m30slIO+Ajdj3apXQmCT12gIdS2N/1ra6C0s7/8
         xp8ryiv29fsmtJMV1GdSxMps2BneEROjjdgXR9K9LPkGh0YjOkbKu+fxh6D3F5odNUBc
         AQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986001; x=1755590801;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KB/9AiQUNaaeoTiNfFmXrTqb4RmKBU2EHYLBB9k4Yeg=;
        b=cz3x5LJZ7JrzFrBKa7kaFsO1gmrStGYOVN1PCdQAbPLemdaUpp11OjkiQDNPlGhPUf
         RXc7LvcVXfAILfVFicT/Qda7TasdFfG88CJ+jmiqMeKnlEIJbNDU3+scX62T8Lv2M6GR
         3imczeLwkKrj7vTbWCzV/H2kQWfNDUB/aCK+3kgA0yI92yVlYf+X3JT9+R6AOJpspEmU
         0KRlUcMSpgjWYm18ne58a5vyanxdEM5U+xaq8abklVU+tmWdgNFWWblMSofA7vSa7y+u
         KQnab+P/InouoKw+k11WidYB9/pzcRxI+0wT9sEJFwFxercLKIOwalwUr5wfW677ETAx
         r3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCW+BAUbuNIG2G9JcLNYEGiyFBgiFn8i9bMcUj57kNAS65vptUQ+QWNa6Wz0pODAAqPPgxmknjoOQXRigKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRdWsZGImXeTU7o/1mBQpVU2J+FjXPiy8HlOuzo56X80ySUWH
	Te7H9wJuBo+5sy3ovSPEQ0O4nOlcC2s1OMCutsDRz8ofpq7vsKF+00H0Y7oj4Wm0tZQ=
X-Gm-Gg: ASbGnct8I0M88p9PMrByyIxOCK+BBLon0+47yJums9YG3kHCo7uUMlmrkvn+KgdlQak
	LmbjGURmw2Xla8zbu7glJOGdTiWX1CYCJI27YIkaEdmzXFbGzQrdmwhmg65u8BbP4i6hyje0SIY
	dl3jhwxV9ko5LkdPEOkfCM5yifpC1ttsl+EyAbwHf5rBjDA3Wq4OtDe42zNDl2S4opV6r3UwPNr
	iRJvu81iby6nDB0sOmC5U0Wd6nZv2Iwo0P5vynwqnQAQMG2BsP6pGqXq+Nq/54MBPs2AAKhXn/M
	xpHe6J7/YNRuKs0y4lzUjjwQEr9r7sm/pL9JTQIbiRPplhhkj1d04zVnOkWdcHsKn5k9J6efu2r
	CnO2NVejwx8oJ887ph87HLygNHkwMCM2+AS6JP/8a+Zf8ij+CyQMGSnwRKexLqQL2hBvwnGWYm+
	E=
X-Google-Smtp-Source: AGHT+IETI+UV2HZkfItiK02d7e6yOOmac7nlYx0JTMj896CyxMKBI5HQuVCk7U+zzLBdJUldXLTRuA==
X-Received: by 2002:a5d:5849:0:b0:3b7:8ddc:87a1 with SMTP id ffacd0b85a97d-3b90092cafemr13572895f8f.4.1754986001129;
        Tue, 12 Aug 2025 01:06:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9086:bd36:16a7:1f8b? ([2a01:e0a:3d9:2080:9086:bd36:16a7:1f8b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm43290824f8f.39.2025.08.12.01.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:06:40 -0700 (PDT)
Message-ID: <acdff7a4-bd9f-45c1-b620-25e667d1f628@linaro.org>
Date: Tue, 12 Aug 2025 10:06:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] media: iris: vpu3x: Add MNoC low power handshake during
 hardware power-off
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250812-sm8650-power-sequence-fix-v1-1-a51e7f99c56c@quicinc.com>
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
In-Reply-To: <20250812-sm8650-power-sequence-fix-v1-1-a51e7f99c56c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2025 09:48, Dikshita Agarwal wrote:
> Add the missing write to AON_WRAPPER_MVP_NOC_LPI_CONTROL before
> reading the LPI status register. Introduce a handshake loop to ensure
> MNoC enters low power mode reliably during VPU3 hardware power-off with
> timeout handling.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vpu3x.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> index 9b7c9a1495ee2f51c60b1142b2ed4680ff798f0a..c2e6af575cbe4b3e3f2a019b24eecf3a5d469566 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> @@ -110,6 +110,7 @@ static void iris_vpu3_power_off_hardware(struct iris_core *core)
>   static void iris_vpu33_power_off_hardware(struct iris_core *core)
>   {
>   	u32 reg_val = 0, value, i;
> +	u32 count = 0;
>   	int ret;
>   
>   	if (iris_vpu3x_hw_power_collapsed(core))
> @@ -128,13 +129,31 @@ static void iris_vpu33_power_off_hardware(struct iris_core *core)
>   			goto disable_power;
>   	}
>   
> +	/* set MNoC to low power */
> +	writel(REQ_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> +
> +	value = readl(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS);
> +
> +	while (!(value & BIT(0)) && (value & BIT(2) || value & BIT(1))) {
> +		writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> +
> +		usleep_range(10, 20);
> +
> +		writel(REQ_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> +
> +		value = readl(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS);
> +		if (++count >= 1000) {
> +			dev_err(core->dev, "LPI handshake timeout\n");
> +			break;
> +		}
> +	}
> +
>   	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
>   				 reg_val, reg_val & BIT(0), 200, 2000);
>   	if (ret)
>   		goto disable_power;
>   
> -	/* set MNoC to low power, set PD_NOC_QREQ (bit 0) */
> -	writel(BIT(0), core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> +	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>   
>   	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE,
>   	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
> 
> ---
> base-commit: d968e50b5c26642754492dea23cbd3592bde62d8
> change-id: 20250812-sm8650-power-sequence-fix-ba9a92098233
> 
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

Thanks,
Neil

