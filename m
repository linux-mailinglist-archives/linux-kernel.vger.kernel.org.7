Return-Path: <linux-kernel+bounces-755430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245F9B1A630
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E391163E81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A5321C195;
	Mon,  4 Aug 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNtb7NN5"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F5218845
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321936; cv=none; b=tOFcOFRDPiPtoh0VP/L9kdGKwed5AVfvLZXxCjL9MQFVRQ9nUT3k+LTXs+q4GAbJxRs/TBT+sY3iTt7Z/m/76bk0z+JEkTiW7cLyqKvtPfivGRUZaUkvMhvds2jWzmwgQKRwYVguTomW3QwS6de9bJ4EjKmXHoeK39FjJSwD4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321936; c=relaxed/simple;
	bh=WEO1UhuvbdnPIoTF7x03FGBQDQAGXd84v4HTU65y/IU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GjX27PsFrnxO5Qtg6B+kWTyhabVCmQ+0bbgx5hVBNvf6TiVlHwWqXKMxdINlm0QTKNNDsG/Z4X23nETxw69RBolN8YQ9y97BNPiWN7N+q5JmjGzIzxJHtHov8dzYiZYuN/bGyzDnK6kGSoms8FzeVOWkl8eFe9n/8kESrqrRau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zNtb7NN5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-458c063baeaso13430885e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321932; x=1754926732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BPn3AbWuSxRwJ/6Re7HP5uMU+47zMuqiT1XZS2qoc4=;
        b=zNtb7NN5WFMWwAqhdAvUGmihhR2d620VzHoXJSxEIop/7sAeHtkjfJ/7NrBLIeGDtF
         PR4b4Bpkgth39civtVaC2INStSCb0N5WF4zhgvcS7JQbWn54hOCWuU+jCmhEls+VbuUo
         swGLVHBWBwAB1aZHgK0fDUbRpglVFRNdgifbw1VieMoyCkh42n8oMNvwSuh74FGqA/DA
         mf3WyqPyUG56GJPAK+v3HJy0/QXGBaz3LwV76sdvEJ9gge+AHQHkxLVzN6nFwfXT+H98
         4as3tun5OtwdCcDhjaH8WZuKrhRCdF2K+JLPN1vrbbJKewnjs99UBrm/jyNDw64oLSZo
         M4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321932; x=1754926732;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6BPn3AbWuSxRwJ/6Re7HP5uMU+47zMuqiT1XZS2qoc4=;
        b=J+DGGOhVTNoHaxJdxhfqb3M5ZVHUCkGv7lg1/miIeSLxVjZTFA3CJUH8uU5LzLPGZs
         qEZhICaFiWEWGDVc8OiCHK+Ih5qJUkcZ+9unEaUkE29PlFA+iafXZpn91cSpgh7uG2vr
         B9lGWMVANKDfCr/NiYrL7Oa8NWZqWaA1gTSQWQkXCwpC0uJBgy9d3pdZso96p1NzYPS4
         S0vtdxqpRE/OOf7pap4D9vKAFAQ2e+rpNded4Q/4NI57ndMikrAEUBDP0NE8qBJ6nOmr
         nrY1q9VUHwBUaaLxDgZnPG9H8PWH8C71FRBegsKySUKxtzBGynphNGMejwjnwscddpyv
         r/1g==
X-Forwarded-Encrypted: i=1; AJvYcCXDx42u1/aYHS8zOKl3K5Ba0tAtsPXz4LV1BUHwcC6FxXQ4G9+9jtf7s43dekgmUuAoUMq77URGJ0WkOoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYE0g/HYJcg9ldMsxVMg74Aya0OplvgLO3dB2m8S4I1MSuZtC8
	0xqoZYRDtc/PyCdWO8fvk8keV8MIJmTOARb7NLjKANWFxf3M9RZeHYLasDmyl4vBYFI=
X-Gm-Gg: ASbGnctBGTp/o2M9PFh7kk9Dg/K6AY1kTlmEOCDwxkhnAZcB9PQ4ZS4gfG0IYdhS5f1
	uDwFKYAEUiggtgVfCL2cHLhdo6QwEQ6RW888tUKLp1i5mPXGYJROjRe0WW5ZP93JEK0EFRpboBN
	NAmBkqwYHfzpVFgxWP/A+DctiBILJRvubzmeCbXmuRd5YgM2QDMLkvYAYeAD4LZE6+/cfNL+Owu
	USDJMpSHAzCE4AV7H65tkv42+SBzNoV/i1p+8BbB55at3i6ZKIqaq+uazgpyPW2YNXOZSRTZrXE
	zUfjr0FIhwXybZPXAJ00gJsW+7fcjPzfJKOC75peSvlzBwvqzsEsqGHbqiKNuSgHBzMz9yeSXxe
	h6dvEpiY0QtZMoED09gP31eZycF2jiMDeNakNFNudEeo7THXI1HsQ8BR7KOMoGhppcg9ad9IO1M
	o=
X-Google-Smtp-Source: AGHT+IGYTWGxkQKie5QO6F0JNgsVYGtEI2yYnTV43Whp5cJoUxF4Ip21+CPLjlvybn1jEjpvZY+ucA==
X-Received: by 2002:a05:600c:3b1a:b0:459:d3ce:2cea with SMTP id 5b1f17b1804b1-459d3ce2f76mr49030625e9.6.1754321931765;
        Mon, 04 Aug 2025 08:38:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3030:f63e:fedd:700f? ([2a01:e0a:3d9:2080:3030:f63e:fedd:700f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458ba5ef18asm96602345e9.12.2025.08.04.08.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 08:38:51 -0700 (PDT)
Message-ID: <db6ae287-88f8-4f05-97ad-458930f9f429@linaro.org>
Date: Mon, 4 Aug 2025 17:38:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/bridge: document HDMI CEC callbacks
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250801-drm-hdmi-cec-docs-v1-1-be63e6008d0e@oss.qualcomm.com>
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
In-Reply-To: <20250801-drm-hdmi-cec-docs-v1-1-be63e6008d0e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2025 12:46, Dmitry Baryshkov wrote:
> Provide documentation for the drm_bridge callbacks related to the
> DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag.
> 
> Fixes: a74288c8ded7 ("drm/display: bridge-connector: handle CEC adapters")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/r/20250611140933.1429a1b8@canb.auug.org.au
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   include/drm/drm_bridge.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 8ed80cad77ec4b40d0aa6159e802a2839d5b8792..b0e6653ee42ecc088f420a9a32cf3b0428737a4a 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -866,13 +866,61 @@ struct drm_bridge_funcs {
>   				      struct drm_connector *connector,
>   				      bool enable, int direction);
>   
> +	/**
> +	 * @hdmi_cec_init:
> +	 *
> +	 * Initialize CEC part of the bridge.
> +	 *
> +	 * This callback is optional, it can be implemented by bridges that
> +	 * set the @DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag in their
> +	 * &drm_bridge->ops.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise
> +	 */
>   	int (*hdmi_cec_init)(struct drm_bridge *bridge,
>   			     struct drm_connector *connector);
>   
> +	/**
> +	 * @hdmi_cec_enable:
> +	 *
> +	 * Enable or disable the CEC adapter inside the bridge.
> +	 *
> +	 * This callback is optional, it can be implemented by bridges that
> +	 * set the @DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag in their
> +	 * &drm_bridge->ops.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise
> +	 */
>   	int (*hdmi_cec_enable)(struct drm_bridge *bridge, bool enable);
>   
> +	/**
> +	 * @hdmi_cec_log_addr:
> +	 *
> +	 * Set the logical address of the CEC adapter inside the bridge.
> +	 *
> +	 * This callback is optional, it can be implemented by bridges that
> +	 * set the @DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag in their
> +	 * &drm_bridge->ops.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise
> +	 */
>   	int (*hdmi_cec_log_addr)(struct drm_bridge *bridge, u8 logical_addr);
>   
> +	/**
> +	 * @hdmi_cec_transmit:
> +	 *
> +	 * Transmit the message using the CEC adapter inside the bridge.
> +	 *
> +	 * This callback is optional, it can be implemented by bridges that
> +	 * set the @DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag in their
> +	 * &drm_bridge->ops.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise
> +	 */
>   	int (*hdmi_cec_transmit)(struct drm_bridge *bridge, u8 attempts,
>   				 u32 signal_free_time, struct cec_msg *msg);
>   
> 
> ---
> base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
> change-id: 20250801-drm-hdmi-cec-docs-541ee6afa5fa
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

