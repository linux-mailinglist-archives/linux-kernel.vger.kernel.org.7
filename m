Return-Path: <linux-kernel+bounces-708981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFEDAED7C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 10:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1D517536E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E91D9663;
	Mon, 30 Jun 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCw5bIws"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C431C36
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273370; cv=none; b=cCrlcs+JV3BoOXmguEaDU5TYYjo5540m/YwOAj0OSvV5EroFsytQkO3WAWrXZgYppDlwAhip8evQkaxffVP5Zr2y4zG5hi9BcjQkQhmT+ohWrQKsHW8Q7g9z+673QgGaTdYxhTxbb6My69SKQrcJdsDL9OQ81a8FTiAEmFg77O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273370; c=relaxed/simple;
	bh=A/FhntS8eFEZhMzLnD4DJamP3SsPmIOY7WsWgKkfBVE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eAuaUtV50x1qListvvTfEOsTCDWG4poVNbSsmLyadjC49+E15+e/KWyA/YqBYoQwKCMUF4yehCa4WYxyzDtWUJrxHObPoWmkfa/AOENvE2GfWgn7RqL32diHCkuE7EJA7sAcdJmrcZNWOSOlvvVuMgdIOeEqytQK/xatR9W30+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QCw5bIws; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4537deebb01so8552665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751273367; x=1751878167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MISBxH0XuSyXy+C/TYjaTySl9YOe1cZiATahy1hfgDM=;
        b=QCw5bIws4if5Ypvl14DHj/QF3X5/Pifj8lOjXND079NJgHG3b1FmJ4VHO7ffQ2LlcB
         hHCHbatq0fzJm16zLgOu5fpJBLwRJ5cteFZBknfWeUunmb+Jcp4yS+qlv7jDF8MST2G/
         3Bb0KT/vea65oPpVktc/jK2X+D4+3NyQNrP1rqXPWLgvbLXdn/WWQ6h//vr08B7gfdyU
         1bOUWhCXdTI7zskjnd8q/4yw2BxCQkB2KL1TwNRzz+yY3UvM0PPxSICbneZs8Lx8ldm0
         Jz077cfX3rrFI/AbXS9z127rlra+1S+KQNElfAPZN6q3J5jzbPw1E1RKqCa6vl7wKERf
         BHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751273367; x=1751878167;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MISBxH0XuSyXy+C/TYjaTySl9YOe1cZiATahy1hfgDM=;
        b=txSJ0YnYKgYI74Hgv4NphwtM+tyhKSoH229nGFQoDPGPW2UC2a504tAK/uBX5358td
         mIrRrQ9G8p5Q5901i08ZvTFEOg/Sy4ii8MXoxbT9DHlbyO7uf6NQaOji7ZaA6gq+lgZf
         635mXM6PyqzztraoejEDYGWBmr4+beKueNGfA1/fWrZtiqaMcooXaOUwnM/d7C0Nq3gD
         ajRASyK0gtFo6jSa+Z3xf/QO1+D/q1Nv3eLzwiCWuxpuC1jic4pAjZW7JrWEg42//xZv
         EOnmA40qHG4RIHJaNcZTBvfe1cYAp8aqMkaPsRJOMZhLpPdHYzmh65vxlQGf7gmALRw3
         DOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsDau1mfp3krdqT58JMQH1ecnscRArsqzlvuB+LmJ9NZECZPL9/cv/HKqSfhXTBUwrXukPsdZorn3zZB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlf6/eQ2aUyags5WeD1ICvVJ4mXOmVrXhEED0nbmsUKEGcZko8
	VtWyfdqWYn7v1TajXQNqwABP/VRvJrs9jYyOMM9aqmZ/PmY3DafCt7c0fGf71eDbHEM=
X-Gm-Gg: ASbGncuFa3VJ8065Tzi2HW+4EH0V/PvXqLyC8RNDmE1l1dbMafgyUITZGk4/OarMBIQ
	HE1oiF/HHtbYUfvA2NHPuWKO+Mb9AliWpaaRQI4COEn7pmoCpFp6x6sbNaAmNVtz5tgc3iK0imm
	c83frPJ068Pxrzi63zYbDk3DNPJMI9iiOCNLNLTSsUVLGdExVoU3nz+zQjM2wgRVs1gP6pgcMYR
	1DHdWWPQfpyOZ/HZJPwoCzjAeO4xdIWwcvjNx3gu/1W5lKRa7wDxznue0GcUK+wo+197jJPDB9L
	zEvIlzqSA7KaOmTFGX9OgXqflJxIj3IN9nDJFZt5NK+tDEQosYonI+YjpzO4qQZH/vW4QpRt+uf
	KZoqS5hnCwUCrYd4UvBmhBJ8y782U3+Tn+uAbL24=
X-Google-Smtp-Source: AGHT+IEoOWdkiUn0oYLh3+j07RBJUY1yte0/p3yAqsDtquxOIPyV6ZkmjtiSOM06yWJQH3qb+003CA==
X-Received: by 2002:a05:600c:c172:b0:453:6183:c443 with SMTP id 5b1f17b1804b1-4538ee33209mr119959955e9.5.1751273366776;
        Mon, 30 Jun 2025 01:49:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:abe8:a49c:efe7:4dfb? ([2a01:e0a:3d9:2080:abe8:a49c:efe7:4dfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a40766csm129134515e9.32.2025.06.30.01.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 01:49:26 -0700 (PDT)
Message-ID: <b3130adb-87e8-4c24-8267-0d5e53e363e8@linaro.org>
Date: Mon, 30 Jun 2025 10:49:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 4/4] phy: rockchip-pcie: Properly disable TEST_WRITE
 strobe signal
To: Geraldo Nascimento <geraldogabriel@gmail.com>,
 linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rick wertenbroek <rick.wertenbroek@gmail.com>,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1751200382.git.geraldogabriel@gmail.com>
 <60ad1985a0de0a6b47044ea9c0acefe6ff865aad.1751200382.git.geraldogabriel@gmail.com>
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
In-Reply-To: <60ad1985a0de0a6b47044ea9c0acefe6ff865aad.1751200382.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/06/2025 14:48, Geraldo Nascimento wrote:
> pcie_conf is used to touch TEST_WRITE strobe signal. This signal should
> be enabled, a little time waited, and then disabled. Current code clearly
> was copy-pasted and never disables the strobe signal. Adjust the define.
> While at it, remove PHY_CFG_RD_MASK which has been unused since
> 64cdc0360811 ("phy: rockchip-pcie: remove unused phy_rd_cfg function").
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>   drivers/phy/rockchip/phy-rockchip-pcie.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index f22ffb41cdc2..4e2dfd01adf2 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -30,9 +30,8 @@
>   #define PHY_CFG_ADDR_SHIFT    1
>   #define PHY_CFG_DATA_MASK     0xf
>   #define PHY_CFG_ADDR_MASK     0x3f
> -#define PHY_CFG_RD_MASK       0x3ff
>   #define PHY_CFG_WR_ENABLE     1
> -#define PHY_CFG_WR_DISABLE    1
> +#define PHY_CFG_WR_DISABLE    0
>   #define PHY_CFG_WR_SHIFT      0
>   #define PHY_CFG_WR_MASK       1
>   #define PHY_CFG_PLL_LOCK      0x10

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

