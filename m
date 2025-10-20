Return-Path: <linux-kernel+bounces-861074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 119F5BF1BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B8524F5E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E72D3195FC;
	Mon, 20 Oct 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwchXysS"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3695320A03
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969165; cv=none; b=WKGhDftBMW57J1BsaMty2rEaEQeQ2KAfnJlnKfKbwYnXPqFRJ6iwyL0FUoPQ3t3DmVoVKl57CCODWlSiBi+ZFrfmeH2xGYNXGJBEoOrNa61AW0uEbrXDL0mr5WF3sfZ9O7TBSmEGoF2gH+uSZtBiRVkyKcwUwXNdIEkrlG+CoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969165; c=relaxed/simple;
	bh=xf2YiKAWBcs2heIcllZIlB9X2poyHyPfwbedljEIBJ4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rbImDEBzi/4PMqIzUdmLWHnYs79ITtBI5d77K+8ERWgYWbrjcKKqChzrLKCszzBPiU/WaEfKP6VciRl+sagTJDk3wmuYK7bpom4dVxW+uMh/3ANucuSCqLDEVAWdVTNlOiSLrHG6W19cYLeoyiuga7Pfl65C09YCMZ/MnkFsSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PwchXysS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so23422335e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760969161; x=1761573961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sd6YgMZ0EvLCVMfSrtsFSXjlb0MkGk3ybivpWnrAPLc=;
        b=PwchXysS7QyttwmClVBZp/xbYcYZD5QNsReIILgQPD4sETZbKeZX9YttjXXqQ4clUH
         gsyG31RDr0en1AGN0jj34PqqfZygB3kt8thHMaayE9oZMSDJSyRwLOMGIzjozVqYz6Pb
         cuZ+EGwUqx4AksgujiFgLpQDdgIBHpuHCw+6KaDHiK9O0wmbjB+1poZyR+zDwPPRWqAB
         I8i95ojw27SiK8g+LrfMNV9Hxj9CZbHTLFiDIOkxLo09cDoElkEjKSbw9W4KYLuUMjCJ
         G3E3KYoyi6Q2h/jaYObf4mFWH8+J1Y6BB28CmGhWowH7DlPwEkvYnyz0RxIX8UpvYBEW
         RL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969161; x=1761573961;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sd6YgMZ0EvLCVMfSrtsFSXjlb0MkGk3ybivpWnrAPLc=;
        b=m1vwW97yX7ptz3T2ZaVV9lY80vjbY1XYjhhbEhziSsSoI89ahYSrg/LvBkFoM0wIex
         ZR6ak9FZ+WocHdD25opUm7eQUaznVcptQ/LKPVryZIyKfG/7cTsfAjvh+nOlJKJM82wn
         wQaJrkDw9FXRT8wcuAeUxUznlG9hxWgWLFfeqbrG8PL/SKjLd0hW1+V/eQxfPLWgjnIB
         N3PEnkwmgP/lRVtL4yy9IQCeqc1n6YfaKym7JWIeeLujwwD0Rmt0saGPpN0vuXFanZcL
         RMA7FAXMGloS7lzYDaxeOol23mz0bBZwxOqmp+x21Wb9GWNfNBuu+9VqwgT8FcI80XJ0
         EygQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKwSBM+l2xpzK7yIYBTbTvVq50NI3W2a2091ZGXActR1FCBOitJCeu/Ai47mh/2IUrs5Njz1XgbKwVSbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCH6L2rvfWz6/R1QXasxpQLtUpFvBc95wMwY2PPzTOyuvUb17Z
	+kepqGz2OWXsFDmi7Co1bDue4Hs5r306h7HhdUGW3Yq/6xG+y/Dy9VsjxhZrY4d1lLM=
X-Gm-Gg: ASbGncsSG5xtcBe089rEnXpI9EnrRz2O2Ge7qt5EzM/phcWlsDVlJEJbzJilJhQbQHi
	wPfkWZLmLgKVX08e9Jg1nBQfEeyyTCMImowlcb8SsLHnV7dfOdTpYT6rOhcGk9MFrFfYAN2mepk
	aKd3++oxsYJ4cuDAr20/0VQi4rlnmsmQN24D/Ii68EVZTqC0kooRRGh9ePA0vIfBHZDtGif0PJr
	7fqcDc9yxiIiLWZp5oxaFhEMVkpyJtYmrmnGegYV+mrqVcU6ue3O9hT96EVsPuq/UFONw036wD/
	d+L86iTmSZnU4qwklCbPDCegjtc0f5H48caCv6du3LVK7v+L/UNdQbWWTMr+SfAs90kYRJtKklQ
	YzRJMKQyqzcv0UrtYdMDEc1/awSAQ6Q5SfexPvIPH1uvjp4QdumlM20bsYTjeafVXHTTLwObBqp
	5U43ElhqklV3wqpIwh2fPYezpIYdQ7CTKUeJHyHX4hWpOKraXozg==
X-Google-Smtp-Source: AGHT+IElds44AnSuk+S+AOVQ8FVT5v16YAL1G1ZowhiBJ5/rHMYiBeguB3q2TELyHFS/vYMlf6gFlw==
X-Received: by 2002:a05:600c:8b0c:b0:471:58f:601f with SMTP id 5b1f17b1804b1-47117912389mr105066595e9.30.1760969160728;
        Mon, 20 Oct 2025 07:06:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4f9c:f978:568:7b9c? ([2a01:e0a:3d9:2080:4f9c:f978:568:7b9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239f4sm232439905e9.2.2025.10.20.07.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:06:00 -0700 (PDT)
Message-ID: <1b783a60-39c7-49b5-8932-e77230f6cddd@linaro.org>
Date: Mon, 20 Oct 2025 16:05:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] drm/msm/dpu: Filter modes based on adjusted mode clock
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Rob Clark <robdclark@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250506-filter-modes-v2-1-c20a0b7aa241@oss.qualcomm.com>
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
In-Reply-To: <20250506-filter-modes-v2-1-c20a0b7aa241@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/7/25 03:38, Jessica Zhang wrote:
> Filter out modes that have a clock rate greater than the max core clock
> rate when adjusted for the perf clock factor
> 
> This is especially important for chipsets such as QCS615 that have lower
> limits for the MDP max core clock.
> 
> Since the core CRTC clock is at least the mode clock (adjusted for the
> perf clock factor) [1], the modes supported by the driver should be less
> than the max core clock rate.
> 
> [1] https://elixir.bootlin.com/linux/v6.12.4/source/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c#L83
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

This change breaks the T14s OLED display, no modes are reported on the eDP connector.
msm_dpu ae01000.display-controller: [drm:update_display_info.part.0 [drm]] [CONNECTOR:41:eDP-1] Assigning EDID-1.4 digital sink color depth as 10 bpc.
msm_dpu ae01000.display-controller: [drm:update_display_info.part.0 [drm]] [CONNECTOR:41:eDP-1] ELD monitor
msm_dpu ae01000.display-controller: [drm:update_display_info.part.0 [drm]] [CONNECTOR:41:eDP-1] ELD size 20, SAD count 0
[drm:drm_mode_object_put.part.0 [drm]] OBJ ID: 113 (1)
msm_dpu ae01000.display-controller: [drm:drm_mode_prune_invalid [drm]] Rejected mode: "2880x1800": 120 652260 2880 2912 2920 2980 1800 1808 1816 1824 0x48 0x9 (CLOCK_HIGH)
msm_dpu ae01000.display-controller: [drm:drm_mode_prune_invalid [drm]] Rejected mode: "2880x1800": 60 652260 2880 2888 2920 2980 1800 1808 1816 3648 0x40 0x9 (CLOCK_HIGH)

With this reverted on v6.18-rc, display works again.

Neil

> ---
> Changes in v2:
> - *crtc_clock -> *mode_clock (Dmitry)
> - Changed adjusted_mode_clk check to use multiplication (Dmitry)
> - Switch from quic_* email to OSS email
> - Link to v1: https://lore.kernel.org/lkml/20241212-filter-mode-clock-v1-1-f4441988d6aa@quicinc.com/
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 35 ++++++++++++++++++---------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h |  3 +++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      | 12 +++++++++
>   3 files changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> index 0fb5789c60d0..13cc658065c5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> @@ -31,6 +31,26 @@ enum dpu_perf_mode {
>   	DPU_PERF_MODE_MAX
>   };
>   
> +/**
> + * dpu_core_perf_adjusted_mode_clk - Adjust given mode clock rate according to
> + *   the perf clock factor.
> + * @crtc_clk_rate - Unadjusted mode clock rate
> + * @perf_cfg: performance configuration
> + */
> +u64 dpu_core_perf_adjusted_mode_clk(u64 mode_clk_rate,
> +				    const struct dpu_perf_cfg *perf_cfg)
> +{
> +	u32 clk_factor;
> +
> +	clk_factor = perf_cfg->clk_inefficiency_factor;
> +	if (clk_factor) {
> +		mode_clk_rate *= clk_factor;
> +		do_div(mode_clk_rate, 100);
> +	}
> +
> +	return mode_clk_rate;
> +}
> +
>   /**
>    * _dpu_core_perf_calc_bw() - to calculate BW per crtc
>    * @perf_cfg: performance configuration
> @@ -75,28 +95,21 @@ static u64 _dpu_core_perf_calc_clk(const struct dpu_perf_cfg *perf_cfg,
>   	struct drm_plane *plane;
>   	struct dpu_plane_state *pstate;
>   	struct drm_display_mode *mode;
> -	u64 crtc_clk;
> -	u32 clk_factor;
> +	u64 mode_clk;
>   
>   	mode = &state->adjusted_mode;
>   
> -	crtc_clk = (u64)mode->vtotal * mode->hdisplay * drm_mode_vrefresh(mode);
> +	mode_clk = (u64)mode->vtotal * mode->hdisplay * drm_mode_vrefresh(mode);
>   
>   	drm_atomic_crtc_for_each_plane(plane, crtc) {
>   		pstate = to_dpu_plane_state(plane->state);
>   		if (!pstate)
>   			continue;
>   
> -		crtc_clk = max(pstate->plane_clk, crtc_clk);
> -	}
> -
> -	clk_factor = perf_cfg->clk_inefficiency_factor;
> -	if (clk_factor) {
> -		crtc_clk *= clk_factor;
> -		do_div(crtc_clk, 100);
> +		mode_clk = max(pstate->plane_clk, mode_clk);
>   	}
>   
> -	return crtc_clk;
> +	return dpu_core_perf_adjusted_mode_clk(mode_clk, perf_cfg);
>   }
>   
>   static struct dpu_kms *_dpu_crtc_get_kms(struct drm_crtc *crtc)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
> index d2f21d34e501..3740bc97422c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
> @@ -54,6 +54,9 @@ struct dpu_core_perf {
>   	u32 fix_core_ab_vote;
>   };
>   
> +u64 dpu_core_perf_adjusted_mode_clk(u64 clk_rate,
> +				    const struct dpu_perf_cfg *perf_cfg);
> +
>   int dpu_core_perf_crtc_check(struct drm_crtc *crtc,
>   		struct drm_crtc_state *state);
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 0714936d8835..5e3c34fed63b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1501,6 +1501,7 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
>   						const struct drm_display_mode *mode)
>   {
>   	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
> +	u64 adjusted_mode_clk;
>   
>   	/* if there is no 3d_mux block we cannot merge LMs so we cannot
>   	 * split the large layer into 2 LMs, filter out such modes
> @@ -1508,6 +1509,17 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
>   	if (!dpu_kms->catalog->caps->has_3d_merge &&
>   	    mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width)
>   		return MODE_BAD_HVALUE;
> +
> +	adjusted_mode_clk = dpu_core_perf_adjusted_mode_clk(mode->clock,
> +							    dpu_kms->perf.perf_cfg);
> +
> +	/*
> +	 * The given mode, adjusted for the perf clock factor, should not exceed
> +	 * the max core clock rate
> +	 */
> +	if (dpu_kms->perf.max_core_clk_rate < adjusted_mode_clk * 1000)
> +		return MODE_CLOCK_HIGH;
> +
>   	/*
>   	 * max crtc width is equal to the max mixer width * 2 and max height is 4K
>   	 */
> 
> ---
> base-commit: db76003ade5953d4a83c2bdc6e15c2d1c33e7350
> change-id: 20250506-filter-modes-c60b4332769f
> 
> Best regards,


