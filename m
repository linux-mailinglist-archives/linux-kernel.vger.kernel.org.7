Return-Path: <linux-kernel+bounces-800832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 663BCB43CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094EB18962F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B029D301025;
	Thu,  4 Sep 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2wJsqmp"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958E3002A3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991566; cv=none; b=mXAJBcKtlYifzn+mGhD1LzB0yKxzfwfI2cdStCQE/agmSLzCaM7K2WR+PREnxUW0nGepvZuRT1xRzCpZYGFk4LVZWvMo/CyA8ileO7NE+6kQ9vh2BVGMCo4OHKxlZAsclsVK2uwtpfDn1SUNI5FmQJjIguBhieS9Kcm0pp2e5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991566; c=relaxed/simple;
	bh=tTD8/KZNPK7y/Zsh9BIyKd25zvynGbP8RvxqqF37kKw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xv5ajNNBGVw5k9/GWfC6hlMn5MHYhcUHKGuupE9wV+/RfFeTqtvHKm5tP9OA6DgK8IUZo86IDQCd6pnpjvKouOGD26GKiF618VOaqwWfmxVdJWtfTmOP+/IOQpFrmKvoJA8HeM8n0x1+u3wlr/BuAoFqu1r73ADZ6SiT63UAZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b2wJsqmp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e2055ce7b3so331935f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756991563; x=1757596363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q37h+ky8KgDI6nxANYK2Pjj3yAESYs3p69Lz9iQGACo=;
        b=b2wJsqmpvry0Pgnor/spiEfJQDOGcfYT4SIPP/wVjIfvJysofaehAJFIP8xlcyk4zI
         wwzwrHzMVh6cRmiqpOOGdGBxhtvcQKkIEv17ZnYBuvrYMAAfp1hwgrdJYb24gZlch4M4
         pQdPYTrnbVBIWOGMA2i3lWoIYwR3tnjhDUnBOxahEKTGz/aFs93F5YtTcWDochk7Wcjm
         lTNXHLdqIWn6m9DDgAY+INaK+lJFP/PtWjEtx57zXlch+SiiPM049TRNfdDoQjkTjyIN
         VUF1Vt1H+qzyG2kCU0r44ql7flQ3QCv1hr+NbAu0lr4rHzMusdBODiBRagqoFD++gKNb
         NGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756991563; x=1757596363;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q37h+ky8KgDI6nxANYK2Pjj3yAESYs3p69Lz9iQGACo=;
        b=AOaiiFacYukcssDt4AiLb+UN4u2BiyPIMFdvfTlIq/TcBbZXdrOo6AxUIQo1v3I/mC
         XDRmDgXbXFFE6OWqJmXiXKWpT3kcAeUlelZXgGMs2YoDkTPEbmQj0FZfPiA8ZynNQxWV
         hiIbfC85BPT4vNHlidyRuFymn03rIFmY3/pUE7A60PTPEitvyQpvnUFCm6wy1U6S6My0
         8dXEvV5rNrCrG9GB6bHoFd7fZe8m6nBXh4uryCUTfQNcxWDx12XHnygbM061b0p1mFQO
         qwOlbnzo2xVq1a0/MPOEBpBVD9Seiwkrli0fweNQPbZd2jVcPmTu8zHjbJkfcry84Fdy
         Ncuw==
X-Forwarded-Encrypted: i=1; AJvYcCVTvjLh/TQ92bUw088uG+IFKK2m59C0n7UPbqc2+SshlM/iR6r+pMglfwk0gvBWILD7K2Skr2fjc78K+aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfb3IBvEqVmJd87O2C5jRMIK61ZS+wfjRl+34xpLrTVz/jT/9
	dBjKr3c2TteB467IwBF5V4gSSQ5xCi30pAviKGNpMeKOfN+9TUe75/SNpaBt8Wl4QW8=
X-Gm-Gg: ASbGncsBFnDgvVsvmzIrtPIrp2RNFPpll4d5YHn4lOIPAMwj/j9ib7FpO4SfEdL0yOR
	j+XXuU3z3fsiF71FNZinnLznQQF5f3cHnQAs+BNwruchYbcVSxC3glpdOLyRQXGRS9nBj3Ih6uS
	XLn8YTlsGPVFC+Dz5pYEpEwVWs2b6BVQVDjCWyzNi5jKyCp/BadQ3W+X+F3PmhxaF5SN+cWgd/C
	N8Cn1wnrxFTBB/VI8bhb9g53u3d7Uk0Y3+BiQOpSIIFdCcJlVx2DIs+VVZeguvX3lbv+yBEYMku
	B9gR+xlqUCLyHx2Y/bwwFf/Skl385sjxq2ZTgoiyHxjXpQmqkuCIG183W1FQXx7e/neq6gQqcUf
	e2kVlNiW3m5C6MZKGOMjluRdKWad4xlOesrGEE0bPJWOAtJUN4X5F/GsHoTt9aujEDXJDtKFn5r
	emhrtewgJSWzF447jRyuQg
X-Google-Smtp-Source: AGHT+IGiI9xIKpNtw87Z8iocXL4dnNY2WYRgffXXE5zlClWZ1Pvq/OnWmVDZhVEmIgZmS+YQ1COScQ==
X-Received: by 2002:a05:6000:2890:b0:3de:c5b3:dda3 with SMTP id ffacd0b85a97d-3dec5b3e22emr5042055f8f.44.1756991562729;
        Thu, 04 Sep 2025 06:12:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:8c14:335d:24b1:fa98? ([2a01:e0a:3d9:2080:8c14:335d:24b1:fa98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd063fc8dsm16757225e9.7.2025.09.04.06.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 06:12:42 -0700 (PDT)
Message-ID: <a36b3ded-23d4-414d-ba3c-485a9fa2fe36@linaro.org>
Date: Thu, 4 Sep 2025 15:12:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/3] thermal: Support Amlogic C3 thermal
To: xianwei.zhao@amlogic.com, Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Liming Xue <liming.xue@amlogic.com>
References: <20250722-c3-thermal-v2-0-b2231b4be79e@amlogic.com>
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
In-Reply-To: <20250722-c3-thermal-v2-0-b2231b4be79e@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 22/07/2025 13:26, Xianwei Zhao via B4 Relay wrote:
> Add Amlogic C3 thermal compatible string, private_data
> of driver and device node.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Changes in v2:
> - Modify the binding file according to Rob's suggestion.
> - Link to v1: https://lore.kernel.org/r/20250718-c3-thermal-v1-0-674f9a991690@amlogic.com
> 
> ---
> Xianwei Zhao (3):
>        dt-bindings: thermal: amlogic: Add compatible string for C3
>        thermal: amlogic: Support C3 thermal controller driver
>        arm64: dts: amlogic: c3: Add tempsensor controller node
> 
>   .../devicetree/bindings/thermal/amlogic,thermal.yaml          |  4 +++-
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi                   | 11 +++++++++++
>   drivers/thermal/amlogic_thermal.c                             | 10 ++++++++++
>   3 files changed, 24 insertions(+), 1 deletion(-)
> ---
> base-commit: 58abdca0eb653c1a2e755ba9ba406ee475d87636
> change-id: 20250718-c3-thermal-cfdf0a2bbf52
> 
> Best regards,

Patches 1 & 2 are reviewed and ready to be merged. I'll take patch 3 for next cycle.

Thanks,
Neil

