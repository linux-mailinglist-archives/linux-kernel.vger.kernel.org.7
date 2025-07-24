Return-Path: <linux-kernel+bounces-744432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE5EB10CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854BE3AF301
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA22D29B7;
	Thu, 24 Jul 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVnABKCZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499918E025
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366200; cv=none; b=BGoqF44IOwIvut1Ln3EpAuFYjLvGTgz7VBKH4bIf7lnNSH03vdD0arZ92HFusmuAhfpgHVik44e1Un1nZLzXa8AKKrJAYdwmxzBT2P1yVVEEIOSff01j5nICA0K4HCkV/bWZ3yThV6CLBZ9LCU+arT5Np3LGCwZqDW6n+pnV3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366200; c=relaxed/simple;
	bh=h+K0vmC3/TCo0nSo3dM3ozTwdyqP++usnAb3Eyga7r4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LmElx6msMf1gqyzJNShTXZ7GdoNIqMt+ftbhhdMDvPKuL9vatOxgr4oB+G0RBnw2+cKNBTwdyORjeLCjqGXIBxqmoi+lweUwE2/q15ENUyFOUsmogBOTrx33gW6oV+hkjHBFmzFgILHwh5jSRPK+tx9Cos7dA0NmppS5eWZI+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SVnABKCZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so12034595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753366197; x=1753970997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtkvbalbhW467Ci/TrHI2JYa3ewJ4y6lRxO5bgqakFk=;
        b=SVnABKCZJwuYkKSpYod2UM6gnXHDjLv5bpPspemiWXtdO32rcxuAnwj48oioQlHGwT
         KmXV1IWz5TrJXg760IhJ1N1QmhYYcHjqff12TUHLs4HcBTxDOZNsgwQEv2Ooq0M5ac4J
         lzPfH6c+ZwoWEMRjHEcF58dYb08mLJFo3j6NOjpeuR03tj4x1AgdIeXNxAc7Z4aoRItq
         jM4QBHx6zmNjFCu3a/JZ+55BAX1idWLE0CWAT5X1G3f1u9yqbASTckbqUMiTAGri7QgU
         T7ewQpOnqYuckoyTvo3fMe3wEJbOwkgvg8NTEwQ84r7pyd1E7dJaa0n4sUsAXifvk0fw
         I6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753366197; x=1753970997;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FtkvbalbhW467Ci/TrHI2JYa3ewJ4y6lRxO5bgqakFk=;
        b=wKdEG1stm3/KRTy1CMgHalZecUCny4+30uCF3rZwhdqakUlnB8mqzI4XWPFimvmYMO
         v1JY4J1IJCTdVzsfpwe6H1LeKjXAYMBCu44m8YpfBOPWZAgBsAttDRJdUZVk3oarkVVR
         LJL+0tLoaqwJlZkoUz394gyavsT/HrzE8b734OEHXO3XelyHPq479E9VBrpClu8NcavB
         zejSUbFxC1POKwpd1J/P7BsEkyd9itmeZF9mh9l9ePP5Jxl7CWX5WEeZGlyBkHFGbdHm
         WUwlyXFZrIef4M96z1MlNlebpENnnUzgG4WN5swfyWhtPWYJyl4pD0ysF6sU4T2N4On9
         UIww==
X-Gm-Message-State: AOJu0YyoF554vjvXtwMBmIYZZ6XQB9K/utEvi3exP0F8g5jXjAu8hpJY
	0F3O6eV27U7PCNh/lOhYZSBiQ1WmEQ3WqiQd4X52BiGrKXzRJ1hLNeuYsgal4Q+zGpg=
X-Gm-Gg: ASbGncvOxTbaMZCqdisuKJg3D78ZZkTktpIvhiuGMJayWuXzf8wNmdNdMgX0z8Jn9Cv
	FcTU/GHbamslDEo6+TOnyIw22CCtPxQuhaDhQIF3PpJ41IgHe9cpDz6XNQU20JMoAMMEUgOebqO
	4laplIxgBHl7tYPZLC44Q1l/lRe+CnEHukjil1Lv7iWt6VsqHeZ5uPxq2z372xbjAqv4KhqDdiD
	m27OWXyfsgMgsUQLBYdanvKu4mICLRWsGf1OY8F1C2EfUv+RrJar7kC0UT3hLL4+ntJ+RDLxhuI
	RyW5SM/tNUvG2lB0j0gqMrdrMfS8Yvl3bncKoKC6Af58nKmHg6H33Z6s/eO4yae/4p0isfCgkEE
	pJGVrx007X9eF41/CrRXGDXfIrUvK8Edh0jwHpLMB93hB41Pzzh1txOqlIpCXOsrzsfBzuAYSct
	o=
X-Google-Smtp-Source: AGHT+IEzBJZjwflpIGZm+EhCnzacJZTC2cyh5NeZ7fWUM4qCv/j+DuKgDh48awMiy/In3FsYO7BG9A==
X-Received: by 2002:a05:600c:529a:b0:456:26ad:46d2 with SMTP id 5b1f17b1804b1-45868c75dfamr58753125e9.6.1753366197052;
        Thu, 24 Jul 2025 07:09:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:e2d3:d328:dc00:f187? ([2a01:e0a:cad:2140:e2d3:d328:dc00:f187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377dasm22037195e9.4.2025.07.24.07.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:09:56 -0700 (PDT)
Message-ID: <d02c400f-d159-451c-b4ac-745e74986591@linaro.org>
Date: Thu, 24 Jul 2025 16:09:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 06/10] pinctrl: meson: Fix typo in device table macro
To: Alexey Gladkov <legion@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
 linux-gpio@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <cover.1753354215.git.legion@kernel.org>
 <c47f5e1ab68248cbc4d51dcd822829da8857ea00.1753354215.git.legion@kernel.org>
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
In-Reply-To: <c47f5e1ab68248cbc4d51dcd822829da8857ea00.1753354215.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 15:49, Alexey Gladkov wrote:
> The typo when using the MODULE_DEVICE_TABLE macro was not noticeable
> because the macro was defined only if the module was built as a separate
> module.
> 
> Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-gpio@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507220009.8HKbNP16-lkp@intel.com/
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>   drivers/pinctrl/meson/pinctrl-amlogic-a4.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-amlogic-a4.c b/drivers/pinctrl/meson/pinctrl-amlogic-a4.c
> index 385cc619df13..95525e66e5c0 100644
> --- a/drivers/pinctrl/meson/pinctrl-amlogic-a4.c
> +++ b/drivers/pinctrl/meson/pinctrl-amlogic-a4.c
> @@ -1023,7 +1023,7 @@ static const struct of_device_id aml_pctl_of_match[] = {
>   	{ .compatible = "amlogic,pinctrl-a4", },
>   	{ /* sentinel */ }
>   };
> -MODULE_DEVICE_TABLE(of, aml_pctl_dt_match);
> +MODULE_DEVICE_TABLE(of, aml_pctl_of_match);
>   
>   static struct platform_driver aml_pctl_driver = {
>   	.driver = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

