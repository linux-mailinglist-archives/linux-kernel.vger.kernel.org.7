Return-Path: <linux-kernel+bounces-877116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED81EC1D3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1FF3B7CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4483559FB;
	Wed, 29 Oct 2025 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLTuqlvs"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F133346E41
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770383; cv=none; b=uFArXitiF+Qv1chIduuT8iPpFhOlDLVek00NCiWDvwK1vpicAseuSRDAg6CTbfULDYb2LxHSIjTLOvXlB8M7sPSYy5jCYuRDfyMHviz9HYiTFHD85NwUuvxqxIMNxOyjcoQ6+4P3+tgjQWRydlaHA7iggzZihPRrJfhF9ePZrow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770383; c=relaxed/simple;
	bh=YRP5+n0MQVrzWZpZNKPg5H9f+NO+XVMGzLp4rJuU9lg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eN0bfNssZD4mnruR/Imj+e8r/8JNovoG3C0LAHHAhJbn9BQRM6WiLqxrVN0Z4J0u9uJAw8BoD+nRdbcLXkzKThBsRBfnpaPlIWKtXO35zkQjOTeb5M4ZG1xymrDPb8I9zcUHaI0lCVg5Rf1mWpidqMU2Evlf6ilnD27CpDJ34EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLTuqlvs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47710acf715so1414035e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761770380; x=1762375180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5I7C6ZgZBcD6qnL0xn/jbMAlnZlBa2bm2Wl3A8ISkBw=;
        b=FLTuqlvsTQBFRwHMwPvUAAr+hBeMmOKON0ni5vIwjP5B3Xq3zHQZ3Up4HzcBrKTKLn
         LtE6AnQFeW/TmOJoZBR5TwTgzp1PE04vQW/euqHxjZBUht3kZ2TICztNfso2kLBzi7Bm
         X99MraCllOYJ18/d1kdhMZPsuzcwmuNCuw3ch98zwbcOMEJCaZLqYSnuTCNORv4k/QDa
         8R9iiAGEYFsf6CyayJAq7Xmji4B2gNKoBeIBC4OLHgB34+X7o3RE7tefnOXy/M4TwZge
         86bDvFoFi7Zu6UQT42JkQaehzTLjLDRpmsvN6jQ7FBDingJV7rE1kR4+hOxElVr4x3Ym
         ilmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761770380; x=1762375180;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5I7C6ZgZBcD6qnL0xn/jbMAlnZlBa2bm2Wl3A8ISkBw=;
        b=JlsUW27sw7kuro2U+25o/ua2JFFDETah6lW19Pdvfi3jyTESMRpugFXzNu8EDgFNTA
         C/oiVMjNEfUptnbf619KVRuU7/6tc/pXjGQ7J47xij8dp1WCxw9TfkJwYcLJnEBMdbZR
         U0vtvD5cDSHearrHd353UTV79a8uyPbNeybzD366C5+FAKVbChnTDFPo2YVyZLDrPbbK
         N1rJiJ1UHX9K3CU2Z47LWRRZUNF6+7gGHuhdwq0vzmA8jCuWPg7UI2ioaHQTk2mMoXVU
         Qvhrtmv1t2Mu+lJX9VGiaWfqoc7o2DkPt2scklaHxY4qGaEKji2pjN6C1frOxNnKk8VQ
         9i8g==
X-Forwarded-Encrypted: i=1; AJvYcCVsoj8p1AU259LR6xkMB93rvVvs4h9JBfbm3YkZ7M3KQtuiqhW/YACsCVu229OdApAhiPln9b/gaXXtt/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YydMJFJaNAnYeXcoruesfIO1L/eJ3kiseVo3NsjmeML7WZaMbJ3
	r4Vqz1f80G2hiJAEqxH56A6bzPRdIaq3zCmgOUElJMrtAXjyeggwhUmTsz4eK8/w8oY=
X-Gm-Gg: ASbGncspMazrBTwHjrEIoXIfF50M1Kf76vooku9jlHtQ1BXl/aKW/5orLMGkrdMLSCD
	08G9DVrCaF3yBtGB9wWtoembo1rdZNe3TR+wrSERz2ILOogkrBfXmEN2ggHgUWHBsBxAyN2QxtM
	WlXGa2K9X1nQIuHuwZD7RQff+chrBo8Z/6zSrMCUJPPyT7frONjUJCQGoyguMJTwA3DyY6GjRuM
	CPhlGfFbslL/V/lWOwBmXjQyERMePogTUNbYi0UzPdmRd0P+Zj8n8A98y10OntOdbaqXWlHCU4m
	4mrG6pAqlUA0kr37KnkmgTxFBOtw//VKhpZauWd5R8kna5cgIHS+b/veEJg3ljZAthLiiJldIcB
	Lw6jXvR5O3l/lVgXiPc7xCBjkygsSNM+0q7weoHcsWCQWwMdjS7vVBqAzfUt99hCCWa85NjTXBO
	z0JQMDvZa7WpZsY8rS5A6IBRm3wKESLJ34314FPxQDlI9qjx8OuQ==
X-Google-Smtp-Source: AGHT+IED4MnHuoUIY/M09MCRLyO+H754ZygSqy9/2M/qMze54F1qyR8E8hz3TcZxMmaNL41buVyjHA==
X-Received: by 2002:a05:600c:528f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-47726872581mr5311295e9.25.1761770379759;
        Wed, 29 Oct 2025 13:39:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0? ([2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289998f3sm2404735e9.4.2025.10.29.13.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 13:39:39 -0700 (PDT)
Message-ID: <cdb7ab69-3037-44c9-834b-1d747b299ea4@linaro.org>
Date: Wed, 29 Oct 2025 21:39:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] drm/panel: kingdisplay-kd097d04: Disable EoTp
To: Sebastian Fleer <dev@dwurp.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Christoph Fritz <chf.fritz@googlemail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jens Reidel <adrian@postmarketos.org>
References: <20251029124007.232333-1-dev@dwurp.de>
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
In-Reply-To: <20251029124007.232333-1-dev@dwurp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 13:35, Sebastian Fleer wrote:
> Since commit d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable EoTp by
> default") panel output on an Acer Chromebook Tab 10 (google-dru) is corrupted.
> The tablet I use is equipped with a kingdisplay-kd097d04 panel, disabling EoTp
> restores the correct functionality.
> 
> Fixes: 2a994cbed6b2 ("drm/panel: Add Kingdisplay KD097D04 panel driver")
> Suggested-by: Jens Reidel <adrian@postmarketos.org>
> Signed-off-by: Sebastian Fleer <dev@dwurp.de>
> ---
> 
> Changes in v2:
> - Reference correct commit in Fixes tag
> - Added Suggested-by
> 
> ---
>   drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> index 2fc7b0779b37..893af9b16756 100644
> --- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> +++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> @@ -359,7 +359,7 @@ static int kingdisplay_panel_probe(struct mipi_dsi_device *dsi)
>   	dsi->lanes = 4;
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> -			  MIPI_DSI_MODE_LPM;
> +			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET;
>   
>   	kingdisplay = devm_drm_panel_alloc(&dsi->dev, __typeof(*kingdisplay), base,
>   					   &kingdisplay_panel_funcs,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

