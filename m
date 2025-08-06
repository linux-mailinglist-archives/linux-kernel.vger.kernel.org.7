Return-Path: <linux-kernel+bounces-757843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B863AB1C754
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A383A5908
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757428C87E;
	Wed,  6 Aug 2025 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Delc9JxC"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC71C8633
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489278; cv=none; b=IhPlPeL03IgGPN3kzmwlmAepTB8Jfh/khGfrfx1zjjEWtuqHdndu7SOpzevF8cMygyzx1EJHBp9pzT48wjinGDD6sPsd9Ytn85R4BiDCqOulaqhP7Y8v7FYRaTBbgHHtwe7PiTC86U3uWFi8YoFdye6r4gwzCI4TMOc+2g1zRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489278; c=relaxed/simple;
	bh=5ClgcGgo+fcnd+8D57GTJTfiQF9syoEA+kAp4PAKd/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfCHlNRYmEYUelmnbNkidn2XavwUgPOD15Tk/numHHlF9nmLIcVebfP76G6ed8woMcmeUZK/j+4FkCJgZjp5WgM8rWwODrZjMfJLX6yCnY4gkNF/kFfJ8JaPb9KNUeIi6L8TGEuTpyy776kfgjlxg50qEzYCi0vOPUMr+nCnZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Delc9JxC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459e3926cbbso9864685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754489275; x=1755094075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8Pm5cYrQInMJGl5+hX9jruWqynnloC64HQ1dkE8Byo=;
        b=Delc9JxCsY5eTnL5rNllonFu1BMz9wDykIBaYyBDWyRTMIUsnqWC4HoTyBs1vo0f0e
         WGe1RBieQeT89x8MWTo90Xz1DfgM3Xs7FvnhI2DJ0Amu9yzAVb9eZG6CEmgGEPccJ+ir
         ilwkMHvVBovhhoPLNvI7lS9krjNZNJByKZQwJzLFzK3piBp267c0k8vy40AY1Ig28W2p
         cdCAReIjSg0Geyn2Gr6uMwKv1cSMLgvbbjSGnVzLWk1ZUGqdFg110cYNI54e3fTk1UP+
         GqA4bmnkYLmaGzd/5dAD/mNb6A/fS87tM/lk/sw3LeERlmIxqmp6nZOyu9/YBKlJfyVU
         pO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754489275; x=1755094075;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q8Pm5cYrQInMJGl5+hX9jruWqynnloC64HQ1dkE8Byo=;
        b=QPC+RLzMzlwEgQEKp2RPaPhKk1z9SxnDt0LjWvrUgUc9s9bW4WrIs+y7CSNevwYZFM
         AuujJkq651y5jsIOA04bxrRPGFz02O3DWkpo+udSu4IyrgvCHYEs1XUkYc7WRep9ax5q
         nCMXaJpS6tD3ofpp2KF8pCizG/i95Kof6qYzpHpYmYnsHVo/+ZAXHBIdF0DHAO1YBi43
         j2qUA4J3KtV0RcDQUxJd0jG8mZ2Ff5aq50WCZ+Jj/Bvg1elqiAEaBGaH+90dd4g6PpN2
         YS4dvcr0oPoz4UhvAtrfW5CLgX9Re/MiE9RLAoGUY+OPfn0pTKxXjKbAT9LC2UYz466M
         +ijQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVmFaIZrWLH6gpiCVOX/FVwOKPOuUj8hr9Tdmf01AgKMsJa8bxfDLuI45FqejA4OTJHnJ/RxSEyp2zYww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjrZinD3r71hKAIogmD3ERwJESz96E6k9gDAJ0Td+tTLcQH1nU
	LLk27Nlk4UuDqTRJNquNKrp6nuVjpnWiezIQoCNjH1ViOiE4kyuCLbjJEe68SFSXqP4=
X-Gm-Gg: ASbGncvQENo4kRb/7QZkAMMTemu7ze3RaK0BJXUvomhG3NdZWO7Y96YopNY0CCr9DqA
	HTmCFs/j53AKI7EWn1Dj5RsDF81PuAjwNvIIU13Z8oRnFNebYEJEBbmoVamcCFw0Tu+GQLkUhLl
	82z4cXZ3YCKIWrz2cMsD5jLhgkTN8Fjp8ODP7R/TvLKyZobNGshUFy5nktHjBxNMWoiIEyTKy+9
	NUdijwfEKDZRYHRhAid5r1N4J06CKiUofW0KxEIOYnswmH7QTQ+Ltci7/qvkm9bNDUp8PbX+bBG
	VB6Yxzfd+w0IfFiSoJaeVyC9cUG99EhRDWstKwTIYYmVE0c4QTXwBNeFENiIIYZ5SZXlja7KxzF
	/S80NfzlsVy7BxElS9QlctG8E7M8Ybi1Ou0iePShN/MjUXFMsx3Xhr40XShWpQ9HqRUncuuD2gQ
	xzw8/GjbBx1A==
X-Google-Smtp-Source: AGHT+IHyy3f0kKEfQMWCY8d3Nqb03JJf0GPhRnQICd+XwnofzSDkX6gRuK7WSpYOcTRPtt5zNiAXUg==
X-Received: by 2002:a05:600c:a03:b0:458:b068:777a with SMTP id 5b1f17b1804b1-459e9ee8b3bmr23272885e9.30.1754489275136;
        Wed, 06 Aug 2025 07:07:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:96df:e381:55b8:1990? ([2a01:e0a:3d9:2080:96df:e381:55b8:1990])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5862fd9sm54780515e9.16.2025.08.06.07.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:07:54 -0700 (PDT)
Message-ID: <6ecd2cac-87cb-4921-8c8c-0f04112dff2d@linaro.org>
Date: Wed, 6 Aug 2025 16:07:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/5] phy: renesas: rcar-gen3-usb2: Add support for RZ/T2H
 SoC
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
 <20250805122529.2566580-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
In-Reply-To: <20250805122529.2566580-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/08/2025 14:25, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add initial support for the Renesas RZ/T2H SoC to the R-Car Gen3 USB2 PHY
> driver. The RZ/T2H SoC requires configuration of additional
> hardware-specific bits for proper VBUS level control and OTG operation.
> 
> Introduce the `vblvl_ctrl` flag in the SoC-specific driver data to enable
> handling of VBUS level selection logic using `VBCTRL.VBLVL` bits. This is
> required for managing the VBUS status detection and drive logic based on
> SoC-specific needs.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/phy/renesas/phy-rcar-gen3-usb2.c | 85 ++++++++++++++++++++++--
>   1 file changed, 78 insertions(+), 7 deletions(-)
> 
<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

