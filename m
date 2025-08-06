Return-Path: <linux-kernel+bounces-757845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EA3B1C75D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A9718C3994
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30628A3EA;
	Wed,  6 Aug 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iC1nArsS"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE328D8EB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489303; cv=none; b=uc6J1hixugSw3padFwRNh+qdgAZGipdXskU64hZA+XQijpwj10vBsaRr9l9wVa8SuDQkOWNaLaa8KRTWnq5PzK3ODJoCdtoubDukhlIY6Q2eXtjDMGD6w21cmVY7mxC4eljwsQWYnDX8fohirmyMlf0/1CkyEHKcmCLE+enSzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489303; c=relaxed/simple;
	bh=fOem8/Drn9fO4S7BgBEZAM8Qym4SdMGfgwgEwyW+A1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFEm/bIK+SYXvMqJHHo+pEfIYelZtFTDl9sDLvqwZni2BeHjGLlaZp54be6ZyKbtOFhtolobdDr6FP4br+m5Z7/ok5kgHxARQLWvR3PQM8qQmV47OzyRRGBT0ZZGnog4GpL+kR1OuS6lOya69hMKBdkUjTtOr+503lDsVJiO7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iC1nArsS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459e1338565so20553935e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754489299; x=1755094099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCGd7O4GoIlOmdTKiKq8YgxWKegKI2Il/UfNC/LUBwo=;
        b=iC1nArsSKAnRC+xLRDtB34wRGER+7fR8Ya2r4oMCx5Fk1CNXWC9f2qfCRGkZ6waTBs
         twcBIg0occLSmXpZet7BEk64V8C3CKQCfgvIfBjvwgZgDxecv2EL6pPFc9oUvCoSNFOL
         ESNP5JLEhF5M2bhwAdc3ZqKuJFoY7Rh6u2hw4+k9T/O1iJn7Si2nstJBnp4IWSfIH98P
         IBMQRt5/ZbRv22KiTNlGOHMm4welf8mI4H4zysLtJiYMBjvz8g2HOx0cafatAO8HUN6A
         VqVR4SxOsfyxTmOaL6zgQXcx75ACFXuCIoT/RI61BPwnvpggNg8PIlGG1Bl6HExX/9Cr
         nY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754489299; x=1755094099;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCGd7O4GoIlOmdTKiKq8YgxWKegKI2Il/UfNC/LUBwo=;
        b=YqE1YVaBAafqYh2qKvT4ZqXI0iRwI8/9ttJH8HFod0iFzuWvL1ldKr/8thcU6hSsZN
         NehA6cmt7l7RFC3bwn/mtLOFHGDti9OoTgYmlggwuSmA6zlyLSuzizFu07HDyWoy/Sph
         4o+nES61eYRQfNdf3/aI8VXXcD36CCbKUtY1CWhq8AwWQbL3UKp6XttDCwutCja073nX
         RNVG8KcwyefWb+re1G188pIoynH6KMtT35rAz0Sx5/Lri0tcjKpG7UajJ8engspG1Mwm
         T9ctDOwudXIck5R6HcMreWrC0ZOWe+y7LTK1K25elBS9z+V6UfLhvxXT5jWKB0ykcgBB
         pNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEe+GzfY58AjfI20cmFWI0In2QSb82p9E8fCe1WdZPZeQppLhRjlF0gk0Qg68jC5yYuasHED2GLOW4oOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYLeS4gxn5ryieMN/nSlXOfKw3aToENJrWgwsfoxK/I/e8Whp
	zxMd4+qDi6kNcI780wElODTdFpfPg5lkYDomCE+QEnYi5g3C5DPLXu4nAWJYY5TS5yo=
X-Gm-Gg: ASbGncuNTVT3+8kcMhO6pDP1weE6GiHOQhxjUq0eLXm5rVNYTIls2vIjoO6VAkcit7A
	GPkyB20XYJXSWYnNOiX6m4U36S6hJ2ueW1BJkiPf2Ry/x/Eh4HywhRwaieZ+fZRlQ6LGUfZu24t
	TWaC/PqNtcmtoLRErSaBSH7xMCLi7Zz9XjvE7Dn7SA6Ax/Gbp+AlGcju4TAcBX8XACOIAq820Tw
	W2KCBG24R6/GE0EQELn2WRXHO1lcuiOfC5RsHi5237If1BzHfpi5QoZzV/J1GvS2Zbz6snoEqyB
	D6lKTLiOTGOlaNg7wQWxqCcC5wkuGn2pMqsqr3Xib0bxPGSdNG6rtgrpRTMXozE2bV7EWjzoH1W
	4wz4N6+2NIQub5uu3CVo4LboDx3pPMNknI1XyrEfpIK6kSzG2RkJdbPm0BL7LDGh8998pEDVIPD
	o=
X-Google-Smtp-Source: AGHT+IFOELUtC52z9Q26FCR174suBx8TNGvfiZiHi0AzwFaFFL6FW1oxmFvuk08xuGo3H6BQgIw75g==
X-Received: by 2002:a05:600c:34c2:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-459e7bfdeb1mr32593785e9.3.1754489298722;
        Wed, 06 Aug 2025 07:08:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:96df:e381:55b8:1990? ([2a01:e0a:3d9:2080:96df:e381:55b8:1990])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm319154575e9.25.2025.08.06.07.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:08:18 -0700 (PDT)
Message-ID: <8f1ded5f-430d-4e9d-a328-aecaef1e6d60@linaro.org>
Date: Wed, 6 Aug 2025 16:08:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/5] phy: renesas: rcar-gen3-usb2: Move debug print after
 register value is updated
To: Prabhakar <prabhakar.csengg@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250805122529.2566580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250805122529.2566580-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20250805122529.2566580-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/08/2025 14:25, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Relocate the debug print in rcar_gen3_enable_vbus_ctrl() to appear after
> the `val` variable is assigned and updated based on the VBUS state. This
> ensures that the debug log reflects the actual register value being
> written, improving debugging accuracy.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/phy/renesas/phy-rcar-gen3-usb2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

