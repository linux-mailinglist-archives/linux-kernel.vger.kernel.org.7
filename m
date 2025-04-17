Return-Path: <linux-kernel+bounces-609410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C18DA921E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D8119E63CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E241253929;
	Thu, 17 Apr 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiLQXYGL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96723192D8F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744904801; cv=none; b=NXtOIDKqOnEFDxH4OIJqCDE8BMl6o3gLGB+2BjIaFsPtvBOqEDOO8QChyKq5mxgctEAbbque3tzJWJXJnXx2ieFRQoPv7P2N8yQ8z1x2n62Zevv5m9/zU4xImQG9NEKyFy27dJ4jQZ2iJ8n8Tv0TJqkSESnTRiRZMaWQ7+Ax68k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744904801; c=relaxed/simple;
	bh=iHM0/JATaw0Rhpd8DMq+GWRGIRy0INTDt5N7o2Yt808=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ttqwbRh6W7O+YglNIl5Ezrh0MltVYNYtpUHsAAV1i7g6t0IffSc/tmNsFOtuz7ks0wS3sBKlhezXDtQ1lMQvLnbf8zlI08v+QfSmEiq2CJxBw/Q+m1UB5tgTSeeG6utjuLFACXNUy6GV3HgHix/iW69QGq7mHAEIwRLBI7PWCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oiLQXYGL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so9109945e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744904798; x=1745509598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9aaMCuzqkcLFnGt1mdv/nspPtYR2d3K7Y5FHZPd5iE=;
        b=oiLQXYGLGgw5Yy2uAjHDEG8cvIQMxwW/4fy1Z2J2d2aiTAYID2SbHQLsvZcbCUbtVK
         OoF77aCghGGAFBYNGL/CBjtw0TJ/cmjrt0XGQwA1Gh930gJZDLtOa/eQi6VD6lNSAo75
         Mt8u3vCHomj0yFDhh0ItTOnBNyVzrIAWx8+DzYvI0dJJb1CaLPtV8V4V6x4CMA1x3jYv
         uwhQTP8z61jw7NzWW6Lng/C3bCjF9fkLP1BhdBKfSJ11ESgmWJDENBoaeNfjGbupISZ0
         XFSY+mOtCSRZQeE8Vsyu04u0tNMw6+lhMWLEquJFMMOkLM+v4CApM8/pZStIAR+QxKvD
         aJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744904798; x=1745509598;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k9aaMCuzqkcLFnGt1mdv/nspPtYR2d3K7Y5FHZPd5iE=;
        b=GudPBdnYkQS+ddJ/wxxRi+LdL2cIspCJ5pd2deN6PC/cPUQJNXiJPj1SBvVf+QujkU
         C6mPBqnKjvuSiv2rkGMidwGZr82EtEseF6NZcbqdfgbQYAKch9awA1V/H7IEc+5LfYt0
         kD182wFAOdFXtUUlHbp5A41qTaaJvzdqAba8U0pQAphTBoDah53MXHUGiYNYjc/+2gxN
         ER72cYREAhfWdIf2kqHvRAxvrAUBeaNFFYOdx9e8JDb7WIEo6QLvVA0q4JnOatYvQpYw
         pYnAnWrPZaHItWqm9wuhEj9aOB09VdRn9SYIhsQDlhHPRdQ/kA/np7G/MYATO0lXODRz
         3D7g==
X-Forwarded-Encrypted: i=1; AJvYcCWXz1YaD9erOhs6jCxN5nT2ybH3YyLgN0/zFNWVGQWTXWrT5gqEfYwpj1iHGPTeYT5f95/YOgZJdzip30U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXe5Q856pVH+cDQinTmF+S7JYZpfyjwCJyBDcl2fiexoedDbG
	AFDxAweQpotf/FF0lFZftZyD/AG5J1KIy9NO0WAnSGJthVvqM9VF+retqGDtJbk=
X-Gm-Gg: ASbGncs3xkeVg6dcfKppaayFUelT0YafZlyRahlg2qqPKzwnpeZlbREIail+cKVGihT
	a1R0pEUwP/RdIGonqFJwAIU8q6lswcqEZePcbKZldvB6iKOokw5fQVQBZk062Ll4xXVirgfRy0d
	g1ZI1Qgiq+OZ0BQBshfbrHZSZ1aEmLsKL+zLx4D9Z8yyFqMkBoXvVJ1O5v/zEpzSHxe8lTabxMO
	EUa4JnSqbfklQ48JlE/i4m3dGZUBg0Mnrx4BgLpv8gDKyu+6b6yMysum6DYaBz+W1evG5MBI3B7
	ocl545Ku6bpG32emn0prYyit8R7PZUelzjw9ktjwcE1sPp66FDw4+IHVlidAVSPyg3hCVzUWihq
	JG4WXvmPHHR5djU8=
X-Google-Smtp-Source: AGHT+IGgXij9vrKLTY0luZtINa4N/TV4YimxUEXPo+0Kea36LPVR8W8Ln1lPTHq41iF4KCTK5tf2zw==
X-Received: by 2002:a5d:64ab:0:b0:38f:30a3:51fe with SMTP id ffacd0b85a97d-39ee5b9d97dmr5526601f8f.42.1744904797932;
        Thu, 17 Apr 2025 08:46:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a7f9:634b:42d:1546? ([2a01:e0a:3d9:2080:a7f9:634b:42d:1546])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ee3f12dc9sm5426249f8f.8.2025.04.17.08.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 08:46:37 -0700 (PDT)
Message-ID: <729958d5-6daf-4056-95ae-c6b685e120f3@linaro.org>
Date: Thu, 17 Apr 2025 17:46:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/7] drm/bridge: analogix_dp: drop unused argument to
 analogix_dp_prepare_panel()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250401-panel-return-void-v1-0-93e1be33dc8d@oss.qualcomm.com>
 <20250401-panel-return-void-v1-2-93e1be33dc8d@oss.qualcomm.com>
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
In-Reply-To: <20250401-panel-return-void-v1-2-93e1be33dc8d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2025 07:11, Dmitry Baryshkov wrote:
> After previous cleanup all calling sites pass true as is_modeset_prepare
> argument to analogix_dp_prepare_panel(). Drop dead code depending on
> that argument being false.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index ab1cfc340aa95bbf13fe021bd33227b565a5458d..82dc4b01806f9728dc882b0128171838e81f21b0 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -963,13 +963,13 @@ static int analogix_dp_disable_psr(struct analogix_dp_device *dp)
>    * If @prepare is true, this function will prepare the panel. Conversely, if it
>    * is false, the panel will be unprepared.
>    *
> - * If @is_modeset_prepare is true, the function will disregard the current state
> + * The function will disregard the current state
>    * of the panel and either prepare/unprepare the panel based on @prepare. Once
>    * it finishes, it will update dp->panel_is_modeset to reflect the current state
>    * of the panel.
>    */
>   static int analogix_dp_prepare_panel(struct analogix_dp_device *dp,
> -				     bool prepare, bool is_modeset_prepare)
> +				     bool prepare)
>   {
>   	int ret = 0;
>   
> @@ -978,13 +978,6 @@ static int analogix_dp_prepare_panel(struct analogix_dp_device *dp,
>   
>   	mutex_lock(&dp->panel_lock);
>   
> -	/*
> -	 * Exit early if this is a temporary prepare/unprepare and we're already
> -	 * modeset (since we neither want to prepare twice or unprepare early).
> -	 */
> -	if (dp->panel_is_modeset && !is_modeset_prepare)
> -		goto out;
> -
>   	if (prepare)
>   		ret = drm_panel_prepare(dp->plat_data->panel);
>   	else
> @@ -993,8 +986,7 @@ static int analogix_dp_prepare_panel(struct analogix_dp_device *dp,
>   	if (ret)
>   		goto out;
>   
> -	if (is_modeset_prepare)
> -		dp->panel_is_modeset = prepare;
> +	dp->panel_is_modeset = prepare;
>   
>   out:
>   	mutex_unlock(&dp->panel_lock);
> @@ -1072,7 +1064,6 @@ analogix_dp_detect(struct drm_connector *connector, bool force)
>   {
>   	struct analogix_dp_device *dp = to_dp(connector);
>   	enum drm_connector_status status = connector_status_disconnected;
> -	int ret;
>   
>   	if (dp->plat_data->panel)
>   		return connector_status_connected;
> @@ -1194,7 +1185,7 @@ static void analogix_dp_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   	if (old_crtc_state && old_crtc_state->self_refresh_active)
>   		return;
>   
> -	ret = analogix_dp_prepare_panel(dp, true, true);
> +	ret = analogix_dp_prepare_panel(dp, true);
>   	if (ret)
>   		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
>   }
> @@ -1294,7 +1285,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
>   
>   	pm_runtime_put_sync(dp->dev);
>   
> -	ret = analogix_dp_prepare_panel(dp, false, true);
> +	ret = analogix_dp_prepare_panel(dp, false);
>   	if (ret)
>   		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

