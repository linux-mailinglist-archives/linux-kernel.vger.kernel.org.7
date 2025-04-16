Return-Path: <linux-kernel+bounces-602307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BD7A8792F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 09:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2F31888ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 07:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044CB25D551;
	Mon, 14 Apr 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAD7AGOG"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D32580FE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616344; cv=none; b=t2YAGApbtmXcH1fWmtXfJ0wnHNGiFjZL59wGBSp/h2FrS4p228u3TSPSbCcD9grWg/Z9yi9YzuOhfJZ1e9qYRe7tQoarzNRdu1qt+QiHKzbW5cbmyC1MjxCvMXSFYvjp8cqcpDEjEL/cHe+z3/ei8cW6DyIXKdotac4bsDpNEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616344; c=relaxed/simple;
	bh=nHw6cNSgrXyUBGGQG32nv16YHFFOCsJq6XQivdiL/cE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xx0muMAX9jEw9MQ+Y+oCyg8zmwgNKWt+754Br23Naq0PgxxOm/hyovYhvlW+8akOx68H6g/LBZWciteg1jCzqTquEs+M/ImjCeR0kCkFwZNxjv4KDs+2x4UJb07sv4t4WMuVPk3GT7aU3GEy1oQZnBRd6mKgaP8Ip/4pfovhpbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jAD7AGOG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so3807917f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744616337; x=1745221137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YUJUK8AE+cB0J4Fwjv+9Xlb4mSQ/w0tsb8OhE4M4K8=;
        b=jAD7AGOGxHzhVTjBIo2k786MQ8YLxlZYjypPgRTfAxi82WmC3CWxISqf4z7JMkPUVo
         a1suBYY9e/4/zQ/nmHhCVNK+rGwuYQ7IPqx2SBrbEFE4Hr0QVCxA3nBN2kXjj0fpHNsD
         HVrzB+uZdAaO+Q2V18td9+KI0ByeUHVEKi2glUr2KaIn4Si+zi9IXbdytWJMsZzjjDlN
         X/BjknpLIz9YsMMXv3k3o0p0iicytNrIibNKs+GtJ8Lz1YocdWYkxYCOVa0wdrDmpC5P
         3vn9F3/U0HLFD+EAgBZxVPHILmWd/4nH+q1V6KjHWnMMVzAQP7p0CQq34fi0UpgLGTtf
         CXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744616337; x=1745221137;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1YUJUK8AE+cB0J4Fwjv+9Xlb4mSQ/w0tsb8OhE4M4K8=;
        b=utEClW4r8K11HO7/vmwhJWJrMLo+5xBgC/e5qKUBKK+AkbbV8rauRIrTWK6cCH+SuV
         LLeBk22iN5Om/d6Qf+6D5MCDdGN04O44A6qQCxIP2wnkpSImHuCUD9pyIWM4VweTaj1P
         HqfjCdBDK0FxTGP9tp5m7f+jzuip6SzSujW79wTqpeau0/o+lRC+y1jMxMJRKTAxKoC2
         rUjzvVATDKnFc+8Gxh3MUlbmPXOcqhXlVoBRSV7qYNTqP54vUZJLowyBUhE/aq8UC3sB
         rHDWyjgPzc/9bJORjXnLTuS9rWMlr6DaxNjJCh5dZJlA2u5LO75FIf7DDx0FvxPXYYBy
         Mh1w==
X-Forwarded-Encrypted: i=1; AJvYcCUwQYLa6ALcHEOHHLKIK8sDeySF8bZ2bwsfP5i1dwUzbw8h0QMYFMzWtbPpiSwOkWWTuPk+jZ61YMG4S2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9MgSa0IdlBelsqytXDJCLzO6GpqVNBqb+7Z+jgjb/Bfmlpsgd
	XLzBnF5LnjaAzuqN8i1TmQTi0EZ9O8+8ikTSSag+My+OwXgJoKWIg9E6GuOMswA=
X-Gm-Gg: ASbGnctC5hzSYPTRVaGgD/jIP2UdPgzVrBg8RbiLHwyaIkIkdS2JEEvFv6SKqYUAsRF
	un0v5rdDCBHnjKt5RFA57ST2g4fbFO6fKEYFI4v2hF/ZELT/78Y1CHvKJjgAZp17nbSvk/7Plhg
	HY/RMBXfBadGS+YVfbILb4ZiZ6jDDmR0yxjsgUUtRyMUhHndtQAeIkF99RSybRloEfOOGeBRDcZ
	gNl5OV/mqnlgt8Jy4TyeK6ZLuC+Rsg0cZJex7qYlS9JJ4B3Zm1bVHU6iCBcP8vK+yx+qrGGIRoW
	Z5YOGqZmuCn3rAy5RN+bmnX3FTpzRPtQjazv5VYmZch6Em6+zCqleRxAn0CcWOIFyaCyxuzUcJy
	5AiyBTPQLBnbFB3dE0A==
X-Google-Smtp-Source: AGHT+IEN00CGuVeGvTjeGWZNIExSe2bYWLZkw12uJCvQgEAsgQb68L2VMNOY2e3uMwjoUJbn6Vqjzw==
X-Received: by 2002:a5d:6daa:0:b0:39c:dfa:d347 with SMTP id ffacd0b85a97d-39ea51f4467mr9707081f8f.2.1744616337324;
        Mon, 14 Apr 2025 00:38:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bf8a:3473:5c13:9743? ([2a01:e0a:3d9:2080:bf8a:3473:5c13:9743])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cb29sm10148851f8f.76.2025.04.14.00.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 00:38:57 -0700 (PDT)
Message-ID: <cd7fcaec-af16-4364-9a5d-77c5ee50bcc3@linaro.org>
Date: Mon, 14 Apr 2025 09:38:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: select DRM_KMS_HELPER for AUX_BRIDGE
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250411-aux-select-kms-v1-1-c4276f905a56@oss.qualcomm.com>
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
In-Reply-To: <20250411-aux-select-kms-v1-1-c4276f905a56@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 17:09, Dmitry Baryshkov wrote:
> The aux bridge uses devm_drm_of_get_bridge() from the panel bridge (and
> correctly selects DRM_PANEL_BRIDGE). However panel bridge is not a
> separate module, it is compiled into the drm_kms_helper.o. Select
> DRM_KMS_HELPER too to express this dependency.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/bridge/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 09a1be234f7173bdf88e385507bbe5e5c6d583a6..b9e0ca85226a603a24f90c6879d1499f824060cb 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -16,6 +16,7 @@ config DRM_AUX_BRIDGE
>   	tristate
>   	depends on DRM_BRIDGE && OF
>   	select AUXILIARY_BUS
> +	select DRM_KMS_HELPER
>   	select DRM_PANEL_BRIDGE
>   	help
>   	  Simple transparent bridge that is used by several non-DRM drivers to
> 
> ---
> base-commit: 2bdde620f7f2bff2ff1cb7dc166859eaa0c78a7c
> change-id: 20250411-aux-select-kms-086618b92d6e
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

