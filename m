Return-Path: <linux-kernel+bounces-873282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDE0C1394E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C9BA4E31C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7801F2D7D42;
	Tue, 28 Oct 2025 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4w28jer"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B11B425C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761640983; cv=none; b=Vox3V8griZRpYiffGpWAVSwnZLftu3KRIP0D6YIpI93fv6d8obBMMWpccU3iwS0VH2NBcfifpALPzNAYCtfqythDCxuYSUkXsSxHhbnGC1eKQqDLJXyVdcjla8aD8uBDIKqw4/UurDq3i8w5yTqOQ8tOxSHPeAXvmunDevaGNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761640983; c=relaxed/simple;
	bh=sPMLj2+gzqONVmj0i86jMJ1BYUAdNqaKTE73qOT8SY0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=h4fmOPLR9Jk9HRNwFxGln65eT+YIuFnR3riZh4o5wKJu7X4KiV+XbMshw65CIGxkqe748mtXXndqxxadTmGLlBf0nmxeSCJfGb9faSOxUdJOK2EN8KVg0COJUeorYxPpISh6lZooMMjIZ1uHTpL5DE2tUpa4OsDqAjg85W73Irw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D4w28jer; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so5802182f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761640980; x=1762245780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NXCKjRFgrYiAfp2xjDLu8YxTLQNZXtyNLdLhXM4zbE=;
        b=D4w28jer3xggzjI4CaE78EWQWoWxAXPDQONfFG2V+xsTDxzFAbdAOwsBPFYSWyVajE
         6PPSiJa9xyr5g2ANpKn+NEDQ7dzHvCUDw90rrvGMWhNg81qdhbE9Id7aQ3sMrDPJ3+8/
         7FAYtKavQU0k+KVv2PQs4ZDBVAQvhaYgc7+XpBKivhunwail0eSYXL7s7MePCGejqQOJ
         RxUM8v7Op6QaiFccqHZBJD6eEbWF03f4MLy4c/YucKoeJ9iU91ywHux/rA0Cm01tJzn3
         8rAQkLzk0jUtb5z/6lvoRhOAO/0wtlRR7tLCBv2Qc50ZPEknMWMoQN0eapC7rETQs8EC
         DrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761640980; x=1762245780;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6NXCKjRFgrYiAfp2xjDLu8YxTLQNZXtyNLdLhXM4zbE=;
        b=S/Yu5oRgMjbqlEENe14x/BT83TUJBqqi09k9T8p+bk6fCuBkkRDUFqDR+5qc0R4Nkl
         XqTqB0nH+fdPwdmHw9fM9BUenO2fBDYQa2lJbV4dRGhndIHwnbLtigD9JtZvrCb+L22y
         cpAaybacqbvcjga2p3/60eMjwmh3dwd60BgEbNeYXyDV2p/yPpn+FroEJ3h+dm+6Zc8h
         nv63l6hX8JgifO2D0Epvb5k2a0dCHg0n3Rn/fMwpx/yy7dXkC9TQ6HvCNRiTrp7X1uDf
         X1IHQh0OqSScoDnnvrt0JkC9qbh30h47V2AKQgZdVK/stCBx+zDs4jQFonxU8gqAPsoT
         v6VA==
X-Forwarded-Encrypted: i=1; AJvYcCVJHOMR6at3OJEdZ9OXTzIXEDjjLa6QYo7AP2NgHvXCx2hOUzLFTIazSBW97n0WkWLiK6DHO3rJrZTyPhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUE6LKGjX0oVy8LsYiZon7yGxZg+u59rrSUhKdqNjX4CUpAtIy
	qQ7ds2XtxJ8p7Z3OTCBW2nBG+AB2tvztSsITBepnS/6dR+wPv+JYt3qJjrT3uLLXgcg=
X-Gm-Gg: ASbGnctGfaScLRDiTgdoxsNlM4c7wjutmqUrXrLTT1W4ccNtejId4SiOao0NphsGdJt
	VSDTZQdlAQPWx+9EZUOxcsmBm6Xq4XHCzprIz1Y5RqKzFPUCaJvEitOj5BPv8TrpHFNLxJxM/Qz
	P78K3ul4WS7CDIiKvnA8QWSpaG/jtZudT7d+/w0K78NVLp7rcEwqlHP0nqeERko3grcrz8oFX3j
	aHbtsWpfM44J0pzByjxqR3eO+uAUyb7JzXChNsSn21k9HbUhnozHCEy7/ZERjiAWZG+jp6LnglN
	aabvN+tVbN7sYZUKAgp8oO6AWqF391rK5e056vknr0ZpkI+/iGns2zVScWRe0l/zfKR+k7HZZT1
	R5zUHUGEhvt20QgPinSjHfU4r+nlwF5261aE6lHLuRZ5Mh4FWr0SHLo51bAOcnFFnlNfkGHnESY
	N6b5zMQJIhzyTveUTcECN4kKbDCNTA8WV+05gyl0eT6HTI0VwFFA==
X-Google-Smtp-Source: AGHT+IGO/CrRm+czlEY/95+Qqx9U6VFPdwHdnit4aNOq5qYQYeiVQ3qkFspoLXuMWyUgnNASWVZ6rg==
X-Received: by 2002:a05:6000:1861:b0:427:928:787f with SMTP id ffacd0b85a97d-429a7e4ee59mr1933860f8f.21.1761640979509;
        Tue, 28 Oct 2025 01:42:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5? ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e2e06sm19118388f8f.46.2025.10.28.01.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 01:42:59 -0700 (PDT)
Message-ID: <6381550a-4c1a-429d-b6c1-8c7ae77bf325@linaro.org>
Date: Tue, 28 Oct 2025 09:42:57 +0100
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

This test doesn't take in account if the mode is for a bonded DSI mode, which
is the same mode on 2 interfaces doubled, but it's valid since we could literally
set both modes separately. In bonded DSI this mode_clk must be again divided bv 2
in addition to the fix:
https://lore.kernel.org/linux-arm-msm/20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com/

I'm trying to find a correct way to handle that, I have tried that:
===========================><========================================
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 48c3aef1cfc2..6aa5db1996e3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1684,8 +1684,10 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
  static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
  						const struct drm_display_mode *mode)
  {
+	struct drm_encoder *encoder = get_encoder_from_crtc(crtc);
  	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
  	u64 adjusted_mode_clk;
+	unsigned int intfs;

  	/* if there is no 3d_mux block we cannot merge LMs so we cannot
  	 * split the large layer into 2 LMs, filter out such modes
@@ -1700,12 +1702,18 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
  	if (dpu_kms->catalog->caps->has_3d_merge)
  		adjusted_mode_clk /= 2;

+	intfs = dpu_encoder_get_intf_count(encoder);
+	if (intfs)
+		adjusted_mode_clk /= intfs;
+
  	/*
  	 * The given mode, adjusted for the perf clock factor, should not exceed
  	 * the max core clock rate
  	 */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 3dd202e0ce94..862239b7d4bc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2892,6 +2892,23 @@ enum dpu_intf_mode dpu_encoder_get_intf_mode(struct drm_encoder *encoder)
  	return INTF_MODE_NONE;
  }

+/**
+ * dpu_encoder_get_intf_count - get interface count of the given encoder
+ * @encoder: Pointer to drm encoder object
+ */
+unsigned int dpu_encoder_get_intf_count(struct drm_encoder *encoder)
+{
+	struct dpu_encoder_virt *dpu_enc = NULL;
+
+	if (!encoder) {
+		DPU_ERROR("invalid encoder\n");
+		return 0;
+	}
+	dpu_enc = to_dpu_encoder_virt(encoder);
+
+	return dpu_enc->num_phys_encs;
+}
+
  /**
   * dpu_encoder_helper_get_cwb_mask - get CWB blocks mask for the DPU encoder
   * @phys_enc: Pointer to physical encoder structure
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index ca1ca2e51d7e..f10ad297b379 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -58,6 +58,8 @@ int dpu_encoder_wait_for_tx_complete(struct drm_encoder *drm_encoder);

  enum dpu_intf_mode dpu_encoder_get_intf_mode(struct drm_encoder *encoder);

+unsigned int dpu_encoder_get_intf_count(struct drm_encoder *encoder);
+
  void dpu_encoder_virt_runtime_resume(struct drm_encoder *encoder);

  uint32_t dpu_encoder_get_clones(struct drm_encoder *drm_enc);
====================================><========================================

But this doesn't work since the crtc hasn't been associated to the encoder yet....

Neil

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


