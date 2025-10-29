Return-Path: <linux-kernel+bounces-877126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E1C1D444
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638C618878A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF51FECD4;
	Wed, 29 Oct 2025 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XE6j4Fb5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05419A2A3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770739; cv=none; b=OhTAcNXfnMv/XXCJciPWpWn/QdtW9QKJjST6kOeZP2mzygzgCG0qFs3LK3Yb3vJVU2ADKE3JfMziGi1ijFtnimrWhytqmxof9E5lRZQ1XAHAOIUS7a5AfxLRWj4ppKsjvi8SmbgBCuz4ETsWuBYNrmQ61RbyrN4ncGbch4xRzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770739; c=relaxed/simple;
	bh=Onvt1kW9GwIcagCPWHKfFl9D0ZZJtoY37dqUXYuGU5o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OvTUIdm+KVT2GBK7NMQG7pKuUKawy182pCBmictkX4v1b7akjvmQQIrAksfjXdSZ4mHLGdi1HpPYkVX6JHD/YvyMckSIuL7SDl9JXExXby0KlqD50iQ57c2+zCZfq29mh186df+g7vGz/FKZL0kqoBVGLWuQvn7eE3/pp1RSvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XE6j4Fb5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-474975af41dso1862515e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761770736; x=1762375536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ey7w7K3RTZ04w+y+uIDIFH1cBIW1mg9eOnArx4/wBFA=;
        b=XE6j4Fb5ZxrSxuOEW9jitC7WgxymLuGfCGMc44xUklXQIhwMNu6ydsqOyhg5mxAjLd
         1LfguBCeFkZLxRpXb+xFBhc0tKhxwkBeA93jTqH4SX+i6HfLg+cEyzdZtIfeLkeiMqvs
         7QgOc3n87Nj4iSi0Bw86QzIXigHtf75xMJdhlb2X/EWk8DmHpJILNhOOVC0rQ9+An9+7
         H8fdboKliyThpSXUqmNWg80w+DPh7LiMMSs2W3MGSq7eRe+KPKMtNynOZJ3JCUGaXo2U
         bQp7OJFksxjk/gYXRhqK+mELEmYl20xmkkYhPe6JUj2yj7Od2uI528UcDEqSGa2Cqn6D
         0r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761770736; x=1762375536;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ey7w7K3RTZ04w+y+uIDIFH1cBIW1mg9eOnArx4/wBFA=;
        b=epalwtUDkAxA1EPzkLdPKVPHw6b8TKfE0vTcdxQh0cefXx8wmcU9sUtYY2lr6xffXB
         uNiM6MeTZDVrmGZjuRgg+GTbz5Rojkk6PSLyIJFPJWvVqMy43RMUiEoslm8gKVz8qQlz
         4xqtr2fzRjYPR7yz1hpbDRGhktctmkJls6AWs/hRc7EwNp+iP+xMkfx6I62SwmujwXLW
         lEPPqiRMkcoQWmpgnvwR2gVASc6tlLmNmAzFEjsNvaQggsdZW89PEgrytifOlzOXD9ES
         1i+nMXrCa3nlcuTv6rJbWy1lOOPZA1z7nYZm1jQV8Pxsb8b6tj3HgwQJHO+khTrnMATZ
         mupA==
X-Forwarded-Encrypted: i=1; AJvYcCVnYaW27E0OeGmryhJc/ZDgeEUGvIGUiy6rB/jzKswd0cmkKdsurvd9+viV/mmECq8MOSqq3vPj7hpsYHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+xVaercBZsjwPUBjy7fh2WjQLug0WdOFxeAcXWknVf9fmcCK
	hUZPY4RMK10lWLIe0KdX3xXU9W5YKZBPjhLRecQBFo7fqftGC2DpBh7J3QGjqnkKMM8=
X-Gm-Gg: ASbGncsgwyVT9N4ptVv+2ZP60ollp33kh1UaUSVQDNbld5bgiZwxz32rvUqsmtQcQWD
	puq4EZ2s6xDoKbvbpnUaVfkoRePnNonsxDhoYfsaWyNkoLI3axsrTrLbIVmyJrEHL/8T7Aub+KW
	rJWUkLYf/4uJwdCuVZGaxdW3i7abdxSbERWTNd0Kgc6F0FjQgig7QDFucSUlRziT64SihJy9mLB
	qqLk85zPHp+17sTXHm33IXElhLiWIZJzO9oorbpd3lfP/87RFKa0TNsYpWRyCmT9SO1N89RKELV
	2ZTsRFlVE749z4hHfGbnELXxcVddQp6ttyxOSEA9unIH0KNrSeqKnjqqzNud4hboEHrjNR5TmkE
	nDCdRzE9grDI3fAqXjz8G4fProLSQ8j5kHcag40iBi+/36blBI63o/xTPfPiei1RxfKLaKpJE+n
	/XyWzaBICHO4P00nkL79ZOH3RyIGbxzamr4SS0yjbJYCbFb02gLw==
X-Google-Smtp-Source: AGHT+IHi1ot8650JXICHh1jN6wJNDL624tOSuE6MQUiS0ahjtbdGicnNvGC8hvyGqPxoKLp4axy1yA==
X-Received: by 2002:a05:600c:4e0c:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-477266f4079mr5627615e9.4.1761770736364;
        Wed, 29 Oct 2025 13:45:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0? ([2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771902fa8dsm50511675e9.8.2025.10.29.13.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 13:45:36 -0700 (PDT)
Message-ID: <148f0b63-124a-444b-9c61-921eef2f2207@linaro.org>
Date: Wed, 29 Oct 2025 21:45:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add the Leadtek LTK028QV25BYL panel
 driver entry
To: Herve Codina <herve.codina@bootlin.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20251021073408.195959-1-herve.codina@bootlin.com>
 <20251021073408.195959-4-herve.codina@bootlin.com>
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
In-Reply-To: <20251021073408.195959-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 09:34, Herve Codina wrote:
> After contributing the driver, add myself as the maintainer for the
> Leadtek LTK028QV25BYL panel driver.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>   MAINTAINERS | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968..67c085cd1dae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7811,6 +7811,13 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
>   F:	drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
>   
> +DRM DRIVER FOR LEADTEK LTK028QV25BYL PANELS
> +M:	Herve Codina <herve.codina@bootlin.com>
> +S:	Maintained
> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:	Documentation/devicetree/bindings/display/panel/leadtek,ltk028qv25byl.yaml
> +F:	drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c
> +
>   DRM DRIVER FOR LG SW43408 PANELS
>   M:	Sumit Semwal <sumit.semwal@linaro.org>
>   M:	Casey Connolly <casey.connolly@linaro.org>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

