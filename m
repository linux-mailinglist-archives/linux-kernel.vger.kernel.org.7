Return-Path: <linux-kernel+bounces-794500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F06B3E2A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8C92025CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244E22EE26E;
	Mon,  1 Sep 2025 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzL933ZH"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3A2727E0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729519; cv=none; b=Om71jPVL8WjFvcb7B7yj2IUIYC9kgF/atnpluCZqNV3ANsuw3ezJUyu0WuqyXXpw2KFnd5cwPu6jvSYGYq1ainxMv4wXZkMeA4LZmqtlRixdlyl7IPfVb3nz8n0h8Kq8pp6UO5VD6kOqKASVqbEgp2MbNJghL3aV14+f1ncoAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729519; c=relaxed/simple;
	bh=1yaBM7rIfjL/fHdH2FOWwsQ4RBNvHl0TGkm8yWeYV4k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ODrR9CkCj8w6TOnWW8fhhcAoUUhDJ4rN7k3G5MHPZBPnqFmBalrNBzvUcdNlGoatJMvxc+I0djJ5ZD3IeO70xTfg8u0f4cbkdTbFhEcGr6U2pCbOeAsXn7RnJ9a10lo6KIzY85Sjw3HtzNqcuFq2DNvnUiVWCmiwT8/715F34p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qzL933ZH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3cf48ec9fa4so2146589f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756729514; x=1757334314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lLMjniQ1/cKQ9SFpYSeLnFNup3YUhmHr3nqDPdCoFU=;
        b=qzL933ZHTwjey+BmKyRHUJsdAsNbqd1HGvCFUYjU/jl3YjcK3Z2tUiPZNOOYry/jnv
         ZaaOWn1RTTveZF9Duwj1XZQcIyG+xKDJsrHOK0KzFdt2YH+c9WdSy8vMlWaEsLY5xqGk
         H/RbqImcgwRkLiNjAYBUDGZ9gYP86nlFKWjxyAMQzcy95wQR6gXWLcNCHtRF+1ClLLRG
         a6Vbaz5dxiyddfaGi1Ne8Hx2rJdCKKBelwe7vH9+Wwng6G8ZBu5y2UyMTb9BgMMo6Kyg
         suh01PRoIu/egi7f0Cle3xLwzxMliZCY4UQrObC4hOuUuK9/8+dIw8lMYliRpHYaysER
         rx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729514; x=1757334314;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9lLMjniQ1/cKQ9SFpYSeLnFNup3YUhmHr3nqDPdCoFU=;
        b=BB4ReDnISWXLFrC1kxDuX/72uS1nMnvC2w9w+0De1o9M6nOC4+hx9Z8OkZ90r1lIET
         9ut+IEpC+GNzaoAaneoEBxV1Qffkp3IFQEsv/NGFCy+l0V8CksNJaLs9OQ2DqtTkRbid
         C7yySHFbHo/3XmoszvzDxlhkKTiirGutjrpKGf7UmpsTFhmzZQpOp95H+xO47VU8t7uo
         L3dMVIf7SVK2N8NPGXZ2iWr6svvBRwN4sX6jGPceLnGMT/3Y3oo/6kADqXfTV9fPdo5d
         6OJLTN3aVduyIlswaZGZ7EgtUvsxfJ1AdQwStLzAtmNNvmFzlmlyyweRwsqrdkgJj/FD
         HFUA==
X-Forwarded-Encrypted: i=1; AJvYcCU4400RdQm8UYLoq7UH5mzHtS7xI78xYE0AwwIDyNSkmHoCR1ykbZxGmOsLIByvmuRk00P3paikshdnc9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSHqygbtrqifj53tFmAQu+Jzt5GOGTCVSnBDSvVwI8x/IYrXn
	3JE+xUaz+FxKRCzGMmnqpmoaqqF+qKvNOwyck6d8K13ML8mzZzicpm0WLS+jxP7Jg/c=
X-Gm-Gg: ASbGncsjWRwIZ5VGPM/LyBlnVSJQmZLOiNFPwMEr52EQ6wqCXs4k8olTg5MqR8DyWve
	s5CRPtlWWx+s8CcRsqYckdv8nDT2h6OO/xYEXZT/gvzdVxPLJr7uGxmcFnvfck9xS5sDTaOraVz
	M4+4YiGooNTtE9zld8HFnGFh7NlbneEH6DoNJ2lkUZgJVkHYyTDnNJ6Vq50byzqobALQteFStPM
	kBHiNjdCE3y/ot8Wgbdz7sj3NvW1lxSoPpuS6IBIdsK4/wRz8DBlrmprQiZZIMW0kwLKMBG5+nt
	hz7SCD8VqJNVNxZRzifnNhEPkgqlvh6q0uTvXzbM9CHiAL++LE0grUMujUmAHshvQcFTbZpz/0o
	3mx3b4sbvZX3Ip9jJWJLZRr+jC5cBbIWtT7S7+aL16WsD34BJ4vFoNMxDeoaxZa81Fu4d9ZAp
X-Google-Smtp-Source: AGHT+IF5dX8kQFF8BXALlKdkwINlMLM/NUWY3UDwGCZ6dH+7AxQ+/AYzUJQq7aUHMzaI02mBKQkM8Q==
X-Received: by 2002:a05:6000:1786:b0:3d1:4c3d:1933 with SMTP id ffacd0b85a97d-3d1dea8c5e9mr6340755f8f.43.1756729513811;
        Mon, 01 Sep 2025 05:25:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a? ([2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d60d93b949sm5169999f8f.2.2025.09.01.05.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:25:13 -0700 (PDT)
Message-ID: <d0b6bc2d-f191-4025-b97f-c6d234214b69@linaro.org>
Date: Mon, 1 Sep 2025 14:25:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: lvds: Remove unused members from main
 structure
To: Liu Ying <victor.liu@nxp.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250829-panel-lvds-remove-width-height-v1-1-acecf0c84dc4@nxp.com>
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
In-Reply-To: <20250829-panel-lvds-remove-width-height-v1-1-acecf0c84dc4@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/08/2025 09:53, Liu Ying wrote:
> Since commit 03fa454bb666 ("drm/panel: lvds: Simplify mode parsing"),
> the width and height members of struct panel_lvds are no longer used.
> Remove them.  No functional change.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>   drivers/gpu/drm/panel/panel-lvds.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
> index 23fd535d8f479045a87b0f51bec17cd7c66b0f75..46b07f38559f35aa3b0a41662cc29480e53e885f 100644
> --- a/drivers/gpu/drm/panel/panel-lvds.c
> +++ b/drivers/gpu/drm/panel/panel-lvds.c
> @@ -28,8 +28,6 @@ struct panel_lvds {
>   	struct device *dev;
>   
>   	const char *label;
> -	unsigned int width;
> -	unsigned int height;
>   	struct drm_display_mode dmode;
>   	u32 bus_flags;
>   	unsigned int bus_format;
> 
> ---
> base-commit: 3cace99d63192a7250461b058279a42d91075d0c
> change-id: 20250829-panel-lvds-remove-width-height-1d063f0bb178
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

