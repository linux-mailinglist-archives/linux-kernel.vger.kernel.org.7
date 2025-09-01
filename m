Return-Path: <linux-kernel+bounces-794052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E09B3DC2E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E417AB117
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F3A26B769;
	Mon,  1 Sep 2025 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zc76uvj5"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B226F29B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714832; cv=none; b=StmMDVyl+MUX445pJTDUAVsLqqFA29qnkDf0SBpgyk/bB2gYGgcJt8K4ZT+bwQa2yyTD72Iu1MpM9893f3GQWdx3DToSRvulYDBDQZVz/buEWhQA1GjqbBUeavK9jTRgqpeI+rVx8BA997sz8Ty1Z+puEhLtPgZ9YkhFk0t7c8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714832; c=relaxed/simple;
	bh=aZzb5Dnjpt87o6rinPuQ4mDWJUz0l4tbIBjHhqUstH8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=isRgd83S0oQ6w5GwfzKFGoIGdTMunt6e9b7zh6yGY/SBVwe14ysV9rS5c5/5fJ5By5xq4UJPQVf7jqh/CSEjD6LQdiRI1zRYKKGL8gWoFS2+wqujgpAn27lnPYaByI3LhQxJ3i5FsZhqMAxuGsWHGtwrRRCOhBy/1wwKv3uutqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zc76uvj5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d3f46e231fso762959f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756714827; x=1757319627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIDbvw0dQVZGx06wUE3YhwCSQsoehVltdwHmuGJe+Vo=;
        b=zc76uvj5iBbAJ6yTesnHqGMf8InG7pgKmyOzOIoyw3vF8dc29Chh6CxQhUvPIT0nuC
         6bG+ZX7CIRdu56wbCz5C2M+t2COynZcr9/beNDjyPrgL6wuzgWVRewZywcD50bOaUSjA
         5Idk+QrK0Cd3Sf5jrqm6VI0gNnZUuq1c+/z9sl2X05VWDevAsl9JvS6ILpftuhBgzOik
         986lOSYK6D2GoiiUQj+3pCDliKFvKVyhFgO5fXC8bhimDJQFM/2k/JrDE2rwM5T6RBdD
         gIxBg87NDKeJYsOvELKVFo8u65TBvoBA+/HKH6ErJVNcw+FTn4HQB9FoqQnBKy+gdP0G
         uWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714827; x=1757319627;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vIDbvw0dQVZGx06wUE3YhwCSQsoehVltdwHmuGJe+Vo=;
        b=qWmoa9kGm7SoHTFMMwDRAQegQaYkfhANlCSXuHI8DJElEZfcXo55lRyaYkJtO8bZ4h
         rYfqIf1A+i8huB/9xpMqn8gF0B2ywRQlX7xGokMXD2Y5wCc2Q9wOoFjzHd8jNpEuFQgx
         cVOiRvuOnoyt/p922CweYu27bLuZgXrFZBu00pBGjuNVeQ2cPgcYb4uugmbgvDtrkZD8
         7t6qgadzYIQqximGUbc9ibgG2mO9cONMPV0qLD3bsbkKRsday1cwIKw2904DoOyybgLh
         TVZSf6bMZ7+yvQ+avpM84ouOWfFZH6SELYpqr6NXlbOGsSpEhav33/ArtQoXdvHWsKPY
         dwKA==
X-Forwarded-Encrypted: i=1; AJvYcCVH5rD3yGP+TBuhBaq97KlnCaF+n5LoKKCyI70/trnp3DHf7KRg6gm+jW3cLW5STZW2Ra3WYeyMzaPHozs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqO3qgCuSNRpgBkPKJaxn4FJoYcWTgOZU0EOHZtggSgDIVNxTW
	jqNS7qWzelyNN1u1D/qcguOAN31jan9Zmh8+ikGxA2zt4RkbbGuiWVJRtuG6QKKGpOQ=
X-Gm-Gg: ASbGncsvCIDUukIARtuRcLxZ06ugWSWALbeArhfCjj+dwI9BoOlMP13L39DLxQlmKmr
	cpLBC48ksURbo6t/j6U2DyZPz4v/QI1Mj7+0FOE3f8gueq/2l6uUvnnTY0mUH05yO5EI67GzHXu
	pBwMCqIwaUCvMvicxt8huyJK6FoUBAId3EcmyU1dt/hv/nE3fQ+71j9aGwP3b9MZiYj2IeaMOit
	bR0Cy3fasSyvL8rWvuki7gwqarOjDqBcdRkLmDMqVd9dUmUZAtn9en+adM3ZdadNwBKJUoouo5J
	vee8pFQXNdTRc8c7iUWCHQNmGtboKEsTvWmvdfJHdIydPshW8KI18lG9DgHcuQDiHQ91k7Zu+1Y
	MwkV0508wCd52cSBY2dyLIzSnGBGWN2D9hlOe7r42r2dR74CapUpsPsDeGIJoW0Nhi2sdqb+FEZ
	AGe+I8kFs=
X-Google-Smtp-Source: AGHT+IGJECIIAmi+nv+q6Nvy1Sm8F6AtGZk4avjvD5iwXIfWzvYFQu4NlHq9yjXiW+lQZxu/bSQpRg==
X-Received: by 2002:a05:6000:200b:b0:3ca:4b59:2715 with SMTP id ffacd0b85a97d-3d1dcf56456mr5038229f8f.20.1756714827333;
        Mon, 01 Sep 2025 01:20:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a? ([2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e68c83asm154115295e9.20.2025.09.01.01.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:20:26 -0700 (PDT)
Message-ID: <fcd4161d-45ad-4915-a6a4-5819eeaff98d@linaro.org>
Date: Mon, 1 Sep 2025 10:20:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v6 00/15] pinctrl: introduce the concept of a GPIO pin
 function category
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Alexey Klimov <alexey.klimov@linaro.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP S32 Linux Team <s32@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Tony Lindgren <tony@atomide.com>, Haojian Zhuang
 <haojian.zhuang@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Mark Brown <broonie@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250828-pinctrl-gpio-pinfuncs-v6-0-c9abb6bdb689@linaro.org>
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
In-Reply-To: <20250828-pinctrl-gpio-pinfuncs-v6-0-c9abb6bdb689@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/08/2025 18:00, Bartosz Golaszewski wrote:
> Problem: when pinctrl core binds pins to a consumer device and the
> pinmux ops of the underlying driver are marked as strict, the pin in
> question can no longer be requested as a GPIO using the GPIO descriptor
> API. It will result in the following error:
> 
> [    5.095688] sc8280xp-tlmm f100000.pinctrl: pin GPIO_25 already requested by regulator-edp-3p3; cannot claim for f100000.pinctrl:570
> [    5.107822] sc8280xp-tlmm f100000.pinctrl: error -EINVAL: pin-25 (f100000.pinctrl:570)
> 
> This typically makes sense except when the pins are muxed to a function
> that actually says "GPIO". Of course, the function name is just a string
> so it has no meaning to the pinctrl subsystem.
> 
> We have many Qualcomm SoCs (and I can imagine it's a common pattern in
> other platforms as well) where we mux a pin to "gpio" function using the
> `pinctrl-X` property in order to configure bias or drive-strength and
> then access it using the gpiod API. This makes it impossible to mark the
> pin controller module as "strict".
> 
> This series proposes to introduce a concept of a sub-category of
> pinfunctions: GPIO functions where the above is not true and the pin
> muxed as a GPIO can still be accessed via the GPIO consumer API even for
> strict pinmuxers.
> 
> To that end: we first clean up the drivers that use struct function_desc
> and make them use the smaller struct pinfunction instead - which is the
> correct structure for drivers to describe their pin functions with. We
> also rework pinmux core to not duplicate memory used to store the
> pinfunctions unless they're allocated dynamically.
> 
> First: provide the kmemdup_const() helper which only duplicates memory
> if it's not in the .rodata section. Then rework all pinctrl drivers that
> instantiate objects of type struct function_desc as they should only be
> created by pinmux core. Next constify the return value of the accessor
> used to expose these structures to users and finally convert the
> pinfunction object within struct function_desc to a pointer and use
> kmemdup_const() to assign it. With this done proceed to add
> infrastructure for the GPIO pin function category and use it in Qualcomm
> drivers. At the very end: make the Qualcomm pinmuxer strict.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Changes in v6:
> - Select GENERIC_PINMUX_FUNCTIONS when using generic pinmux helpers in
>    qcom pinctrl drivers to fix build on ARM 32-bit platforms
> - Assume that a pin can be requested in pin_request() if it has no
>    mux_setting assigned
> - Also check if a function is a GPIO for pins within GPIO ranges
> - Fix an issue with the imx pinctrl driver where the conversion patch
>    confused the function and pin group radix trees
> - Add a FIXME to the imx driver mentioning the need to switch to the
>    provided helpers for accessing the group radix tree
> - Link to v5: https://lore.kernel.org/r/20250815-pinctrl-gpio-pinfuncs-v5-0-955de9fd91db@linaro.org
> 
> Changes in v5:
> - Fix a potential NULL-pointer dereference in
>    pinmux_can_be_used_for_gpio()
> - Use PINCTRL_PINFUNCTION() in pinctrl-airoha
> - Link to v4: https://lore.kernel.org/r/20250812-pinctrl-gpio-pinfuncs-v4-0-bb3906c55e64@linaro.org
> 
> Changes in v4:
> - Update the GPIO pin function definitions to include the new qcom
>    driver (milos)
> - Provide devm_kmemdup_const() instead of a non-managed kmemdup_const()
>    as a way to avoid casting out the 'const' modifier when passing the
>    const pointer to devm_add_action_or_reset()
> - Use devm_krealloc_array() where applicable instead of devm_krealloc()
> - Fix typos
> - Fix kerneldocs
> - Improve commit messages
> - Small tweaks as pointed out by Andy
> - Rebased on top of v6.17-rc1
> - Link to v3: https://lore.kernel.org/r/20250724-pinctrl-gpio-pinfuncs-v3-0-af4db9302de4@linaro.org
> 
> Changes in v3:
> - Add more patches in front: convert pinctrl drivers to stop defining
>    their own struct function_desc objects and make pinmux core not
>    duplicate .rodata memory in which struct pinfunction objects are
>    stored.
> - Add a patch constifying pinmux_generic_get_function().
> - Drop patches that were applied upstream.
> - Link to v2: https://lore.kernel.org/r/20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org
> 
> Changes in v2:
> - Extend the series with providing pinmux_generic_add_pinfunction(),
>    using it in several drivers and converting pinctrl-msm to using
>    generic pinmux helpers
> - Add a generic function_is_gpio() callback for pinmux_ops
> - Convert all qualcomm drivers to using the new GPIO pin category so
>    that we can actually enable the strict flag
> - Link to v1: https://lore.kernel.org/r/20250702-pinctrl-gpio-pinfuncs-v1-0-ed2bd0f9468d@linaro.org
> 
> ---
> Bartosz Golaszewski (15):
>        devres: provide devm_kmemdup_const()
>        pinctrl: ingenic: use struct pinfunction instead of struct function_desc
>        pinctrl: airoha: replace struct function_desc with struct pinfunction
>        pinctrl: mediatek: mt7988: use PINCTRL_PIN_FUNCTION()
>        pinctrl: mediatek: moore: replace struct function_desc with struct pinfunction
>        pinctrl: imx: don't access the pin function radix tree directly
>        pinctrl: keembay: release allocated memory in detach path
>        pinctrl: keembay: use a dedicated structure for the pinfunction description
>        pinctrl: constify pinmux_generic_get_function()
>        pinctrl: make struct pinfunction a pointer in struct function_desc
>        pinctrl: qcom: use generic pin function helpers
>        pinctrl: allow to mark pin functions as requestable GPIOs
>        pinctrl: qcom: add infrastructure for marking pin functions as GPIOs
>        pinctrl: qcom: mark the `gpio` and `egpio` pins function as non-strict functions
>        pinctrl: qcom: make the pinmuxing strict
> 
>   drivers/base/devres.c                            | 21 ++++++++
>   drivers/pinctrl/freescale/pinctrl-imx.c          | 43 +++++++--------
>   drivers/pinctrl/mediatek/pinctrl-airoha.c        | 19 +++----
>   drivers/pinctrl/mediatek/pinctrl-moore.c         | 10 ++--
>   drivers/pinctrl/mediatek/pinctrl-moore.h         |  7 +--
>   drivers/pinctrl/mediatek/pinctrl-mt7622.c        |  2 +-
>   drivers/pinctrl/mediatek/pinctrl-mt7623.c        |  2 +-
>   drivers/pinctrl/mediatek/pinctrl-mt7629.c        |  2 +-
>   drivers/pinctrl/mediatek/pinctrl-mt7981.c        |  2 +-
>   drivers/pinctrl/mediatek/pinctrl-mt7986.c        |  2 +-
>   drivers/pinctrl/mediatek/pinctrl-mt7988.c        | 44 ++++++---------
>   drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |  2 +-
>   drivers/pinctrl/pinctrl-equilibrium.c            |  2 +-
>   drivers/pinctrl/pinctrl-ingenic.c                | 49 ++++++++---------
>   drivers/pinctrl/pinctrl-keembay.c                | 26 +++++----
>   drivers/pinctrl/pinctrl-single.c                 |  4 +-
>   drivers/pinctrl/pinmux.c                         | 68 ++++++++++++++++++++----
>   drivers/pinctrl/pinmux.h                         |  9 ++--
>   drivers/pinctrl/qcom/Kconfig                     |  1 +
>   drivers/pinctrl/qcom/pinctrl-ipq5018.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-ipq5332.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-ipq5424.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-ipq6018.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-ipq8074.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-ipq9574.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-mdm9607.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-mdm9615.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-milos.c             |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm.c               | 45 ++++++----------
>   drivers/pinctrl/qcom/pinctrl-msm.h               |  5 ++
>   drivers/pinctrl/qcom/pinctrl-msm8226.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8660.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8909.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8916.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8917.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8953.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8960.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8976.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8994.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8996.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8998.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-msm8x74.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-qcm2290.c           |  4 +-
>   drivers/pinctrl/qcom/pinctrl-qcs404.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-qcs615.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-qcs8300.c           |  4 +-
>   drivers/pinctrl/qcom/pinctrl-qdu1000.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sa8775p.c           |  4 +-
>   drivers/pinctrl/qcom/pinctrl-sar2130p.c          |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sc7180.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sc7280.c            |  4 +-
>   drivers/pinctrl/qcom/pinctrl-sc8180x.c           |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sc8280xp.c          |  4 +-
>   drivers/pinctrl/qcom/pinctrl-sdm660.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sdm670.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sdm845.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sdx55.c             |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sdx65.c             |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sdx75.c             |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm4450.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm6115.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm6125.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm6350.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm6375.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm7150.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm8150.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm8250.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm8350.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm8450.c            |  4 +-
>   drivers/pinctrl/qcom/pinctrl-sm8550.c            |  2 +-
>   drivers/pinctrl/qcom/pinctrl-sm8650.c            |  4 +-
>   drivers/pinctrl/qcom/pinctrl-sm8750.c            |  4 +-
>   drivers/pinctrl/qcom/pinctrl-x1e80100.c          |  2 +-
>   drivers/pinctrl/renesas/pinctrl-rza1.c           |  2 +-
>   drivers/pinctrl/renesas/pinctrl-rza2.c           |  2 +-
>   drivers/pinctrl/renesas/pinctrl-rzg2l.c          |  2 +-
>   drivers/pinctrl/renesas/pinctrl-rzv2m.c          |  2 +-
>   include/linux/device/devres.h                    |  2 +
>   include/linux/pinctrl/pinctrl.h                  | 14 +++++
>   include/linux/pinctrl/pinmux.h                   |  2 +
>   80 files changed, 287 insertions(+), 224 deletions(-)
> ---
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> change-id: 20250701-pinctrl-gpio-pinfuncs-de82bd9aac43
> 
> Best regards,

Tested on a bunch on qcom boards, no issues observed, regression of v5 no longers appears.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>

Probably only applies on patches 1, 9, 10, 11, 12, 13, 14, & 15

Neil

