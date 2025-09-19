Return-Path: <linux-kernel+bounces-824741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB35B8A0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E61BC5732
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549A225A38;
	Fri, 19 Sep 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuHlC55X"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B3313D71
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293121; cv=none; b=RsYqBf5u1aupj7h1x83MZL8HyPXJKnESofLk+9Kk38Imxl56X5HSxJg/V0OFWj8+rv87XGCESMUM25uGqnk9oloGzWRd+PQPU2JWh/kkGVTHvL4VjHZDn5FYXuwnOTD5efmG60rZ23EOzTy6qbUTbVKyQ/S4HQexJMg9TuipPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293121; c=relaxed/simple;
	bh=q5GTIDOH6nNGTWtSpjuk6PU/ndO/Nf+ZFH5Pj5u31/o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fbMV+061cwhhjXNnOcRu5Y50Kn/zfKjaFxbSvjvfAyWhLuBmxXCgt66FVQLKumWh94REnBwcIlBrfJcXwybYns6bSNfo/deB3n8SGTUoI1NQ4nYQ6lY9jxiwFEJTMAv7EIb8yJHHlJAiqkF9qU4UbmqOdkWG3olMHg0VMbjalyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FuHlC55X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so21346955e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758293118; x=1758897918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJj1y8HqXNnf98ADR5kQhDmwOZyt1Xf4VxjtZZ9P8no=;
        b=FuHlC55XGE75NnFuxZVpJ777sqLFZ1zXbQz4WSo3bPUwTAlN/cWYS4zUUjyU1w8137
         MeGYn34Cbr9xe4Acyp/hl6mJBu9aHq8Dnb/bmd6GTyWNWX0FVC4O42/oc3hTTre34RGb
         a7Trd73WhQbtnRb4eLCMNhjqi22/Te7jHOksXqn0eZGDxgGRn30FGzM3uXzfv80upgQt
         68RzV9ELz/HRC8tIhtNzPTTgR6wGXCQfMtILjm6eoE97OPt2F/ELSap/sZOME8iZ6AbS
         pS6/cQ+DKOsysiMXjsEPxAfqjYVuaDwDmX0RNmslr+Sc128vqtCUA7kXVBAVvwNWnyET
         2oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293118; x=1758897918;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EJj1y8HqXNnf98ADR5kQhDmwOZyt1Xf4VxjtZZ9P8no=;
        b=rlIZXE1Pk+yry9S7MfYvpn+9/XUNL8nmQScsG6qceVFMAavW6jUETZtLdmpgmqEnzl
         9uMh+UumiMWhzkSWTdZTwnLR3xBJe380+71cpJMBca+ysUXRPf4PKUAGJKBgam24smX6
         ZGT5ozJV31BUUqOTmdOIq5UzFQe8c6RVh9/+GpyNnjDj3WiE8QPoXqxF62GCD25wyjmR
         mp6lKPPGDOgplXW/N/PIYXb5OmCuOxsyNiq3yre8EqlXKjblwbGDHOOc7HF1gSHx8x4m
         VEd7MOYFTcn8E1VIkw03/QX1CebKR87iyzZiDnbpczf6K/H7Iq/DLN67L1zG6XnzppJh
         0MMQ==
X-Gm-Message-State: AOJu0Yw6pHAQlH5pWKddB0vb8uWvzNniBqcA/HfqFkC9WDwWeVmpJlsp
	oJAPESRFo7ZcH3ZYwP43iHDDXMO/Mn/7tIPFo/D88yMpfazUgfL8LLataE8VtcJ0hJ4=
X-Gm-Gg: ASbGncvjueJc8EfcKLUQW4ropbC0LaKJBWfQyLOPdx1um3DRzyVol99qELhKsKBDyv3
	smfOXpFz29rOkQQm0tPypUcHSUrkcZpDQx6Azy3gpmQF4gjJ8vGiudfeZ8Dce5JZB9tfwJ0m7kI
	L+8xlpPBgguX/c06YRuSUwH+QVmZ5LnFcBSLqFpX06gSYeQwN83FHCmqemV5RDqpYiFUhkBDm+j
	nDffJYIg+DXzeLXkbYPDl49g+Bk/7JDrOu3vRJjxlnXsulgslYWzVJWXIXiQI3QNkSPOwcYmuHw
	4YMKTw96P6yvnVcdmNe5ofKm69CldUAeCSIR9Gn66tyQfSUZhCc84oZi9tpjlYZI8RhOIaeRdvi
	iA0jvDvCEFvW12k47wbph2LsA5PwXxCzDDGB7fGkbKpMLar/iINW+02XKW9Wri0fg+V7HcQSk
X-Google-Smtp-Source: AGHT+IFxWL+PQqZanQNlYmC61Jl0EglExICuzzye9odcz+14oOJKf1NTLs6pstSwIMChvW2GI7XGEw==
X-Received: by 2002:a05:600c:468a:b0:45d:e326:96e7 with SMTP id 5b1f17b1804b1-467eaa86e42mr31110285e9.29.1758293118114;
        Fri, 19 Sep 2025 07:45:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:77b3:66a:b2a0:c20f? ([2a01:e0a:3d9:2080:77b3:66a:b2a0:c20f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d73sm8046942f8f.8.2025.09.19.07.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 07:45:17 -0700 (PDT)
Message-ID: <272d8cd6-e151-4bab-b8fb-438182a575be@linaro.org>
Date: Fri, 19 Sep 2025 16:45:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/3] Add LG SW49410 Panel Driver
To: Paul Sajna <sajattack@postmarketos.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>,
 phone-devel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>
References: <20250915-judyln-panel-v2-0-01ab2199fea5@postmarketos.org>
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
In-Reply-To: <20250915-judyln-panel-v2-0-01ab2199fea5@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2025 04:32, Paul Sajna wrote:
> This patch series adds a drm panel driver for the LG SW49410 panel found
> in the LG G7 ThinQ (codename judyln).
> 
> The basic driver skeleton was generated by https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
> from the vendor device-tree.
> 
> The panel driver works but during testing we noticed sometimes the
> display goes blank. Source of this problem is unknown but seems to be external.
> i.e. It could be a conflict with another driver or an issue with
> aftermarket panels.
> 
> Comments were added explaining magic numbers, and devicetree
> documentation was also added
> 
> Once this patch has been accepted, I'll follow up with
> a devicetree update for sdm845-lg-judyln
> that includes this driver, along with several other improvements
> 
> Co-authored-by: Amir Dahan <system64fumo@protonmail.com>
> Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
> Changes in v2:
> - use "multi" versions of functions
> - remove DRM_DISPLAY_DP_HELPER
> - change dt-bindings to panel-simple
> - Link to v1: https://lore.kernel.org/r/20250910-judyln-panel-v1-0-825c74403bbb@postmarketos.org
> 
> ---
> Amir Dahan (1):
>        drm: panel: Add LG SW49410 Panel
> 
> Paul Sajna (2):
>        Update MAINTAINERS for lg,sw49410

This patch hasn't been reviewed, and anyway the subject is wrong, it should start with MAINTAINERS:
please fix ans send a v3.

Thanks,
Neil

>        dt-bindings: display: panel: panel-simple: Add lg,sw49410 compatible
> 
>   .../bindings/display/panel/panel-simple.yaml       |   2 +
>   MAINTAINERS                                        |   5 +
>   drivers/gpu/drm/panel/Kconfig                      |  13 +
>   drivers/gpu/drm/panel/Makefile                     |   1 +
>   drivers/gpu/drm/panel/panel-lg-sw49410.c           | 502 +++++++++++++++++++++
>   5 files changed, 523 insertions(+)
> ---
> base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
> change-id: 20250910-judyln-panel-948f177c5c5c
> 
> Best regards,


