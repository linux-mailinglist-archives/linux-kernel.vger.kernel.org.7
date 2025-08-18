Return-Path: <linux-kernel+bounces-773109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A152B29B85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82D6171B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FC72C08D5;
	Mon, 18 Aug 2025 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o98quNTP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585D51F0E58
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504083; cv=none; b=W3OdNwMpR6nNjwlhLy75aVfJGhW7z41LPQvq1751/zzKsdk+y29y75Jxoo9DJVfZ7SXZjkPCccrDdY1312bk5bl2B3byNvk9VE8fZZNgxOPoVR3H/hTPcwiiSBFSjBGNErXaIw53AuDRn/RCDFUgE8XAI0+SIHVViiUasIynApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504083; c=relaxed/simple;
	bh=18mtWKEFsdav4OvyZA1tG7X3awLgBHkMmVqwbQ0u4us=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QG0W222aBh9+EGu8c7E4xSphnlI3XsIaOUBncAueYv92Nomm03UA6+PDcvNJv8WlJXc0oYcy/doRcginF8L3Eot9XVhhN67z11NnuUng5N1HDAMOvGOWPIhcgO/BdMjlpyFl+pehAHimW8UtYkmmijD8oVbweCzih6EB2h31okY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o98quNTP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0b6ac4so17696745e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755504079; x=1756108879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mHPM8YQkeb5dzUYP/jWeZGNM27XcN6UAt7s92fAKeg=;
        b=o98quNTP6LqvBpm0yXsnDwGY3kXZNMj+RHppyS+TlGv9Z/w+N8HGI9A6mu2sLroPlb
         M4K+4GpMZkWXOCtT9sYnCAfADFI6qDLyrsV1tQK1sSDeZHwvFHN56JPT1OE0LSJl9vml
         A/OvqFw2xaNTkhOiapLBpEmeyFH0MHnm/QTsSzh9EayC5aAyXkXFUYEgcR7binSIzOEm
         axLt+WTARERcs2FmDhdDP/w/Tm7CsIrQPe+/k0jfSJTw3FCeyaFvt8FLKfwKdb23Eg5k
         5nfLdA3X3RMI4tR/1O3NBdZ2dzNKKVc21QX21roJ2s4NUrmWGsoa4227j0DG1wydHpPX
         S7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504079; x=1756108879;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8mHPM8YQkeb5dzUYP/jWeZGNM27XcN6UAt7s92fAKeg=;
        b=iYY6PGHMn7Q9p7/JA8VrugOH/P6fP4veD1vQIlIOk4GIqzcMslZKROOqH4p9cG7Lww
         ZhA1wzK2qSj4IXIzKUEwsGHajo+R5dF9ovoj6lDqFZOHz+fQN/GbkDfGjcl/LA8uE+u8
         i/TLl4kP+sSOnbbhxOyQkhOt7k6xIKkJg/NJX5wg3K8fTZPfSPHR/ZxCtccxHY95JB/4
         FItI3TVZupXT+/fkhcBfQqmj2s2z46PMgYY8IdKApJ4gZojtWZpJzXh1Xk3tPZuc5aQg
         CbvWDBupIYvuzIAr2zl6JY0HVp6ERyBDk/0NcVC+AfwUBIWt8dHCs4Jbk7lqbMpGXg7q
         0Tiw==
X-Forwarded-Encrypted: i=1; AJvYcCWviizNxajxokgN2km9dxq6UhDb0MQ6gNVMjGzUUA9tdB5Bbf2iHhDkeckViBPK4GUKeKfBU0fc/OzN3/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRho0fMpICh+aHgY/wnqkNtQ1LpT++1Re3zGJRfHcwc90zj1b
	Fje2kW6ofUI/EcYPzcTAraVibypwmPunOHZrvEBwkHx89L+GDLm9E4345hCtopKirhA=
X-Gm-Gg: ASbGncsgvCIlW4B46qYqeo0hUZQybfJ6G0PwUGSlatDiIvAblp9kuG9kSDRsaTTfCK7
	FdNMrz3TZTu82iTkP/CcKe9BToQzPJqiwRuBCqQ+sBqgWAn/O4g0oQ/Bf463+geYRB9txQdSbkK
	RUIkk9lqhoH09guqPU7iu6JE+8zT3ZokzJDm+Se67zvmN7ys4Bb6xIp7WUTSHx5W+Q/Dyfcqih+
	9qRhshDN8fayMk7nmh65OtwkUrRb6I5IKfAfvGAPdgdT5/mhXMLAaz0EvgP7op+k5fvU2BX8OhN
	nNgFqaUXlqMV2eFll+lUEzsBzQ2vxgMoG9qB2UWIXR4x5PS3UXKzjAgKOOP8Tc9hqOl3T02Lcoi
	SRZHiNsFchyJnMJApBw0f1sc41excHun2gw/pYwv0wirGnvauV1OWQFeshMgj+/kzknTFOmZK
X-Google-Smtp-Source: AGHT+IHtNmeWv71R/NzuJ6rCmd2YleYZrdpfO+N7HxQ/sX3ETEDLXy8M/w4CZrrEkHpyLEzRMlluuA==
X-Received: by 2002:a05:600c:c059:10b0:458:bc58:850c with SMTP id 5b1f17b1804b1-45a218013abmr48669965e9.1.1755504078483;
        Mon, 18 Aug 2025 01:01:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:70d:8646:e014:cc6e? ([2a01:e0a:3d9:2080:70d:8646:e014:cc6e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a209c25a1sm132617325e9.22.2025.08.18.01.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 01:01:17 -0700 (PDT)
Message-ID: <8e64245a-d7ce-40b7-b884-84a7234c4a3e@linaro.org>
Date: Mon, 18 Aug 2025 10:01:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 00/13] soc: amlogic: clk-measure: Add more SoCs to support
 clk-measure
To: chuan.liu@amlogic.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
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
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 15/08/2025 10:37, Chuan Liu via B4 Relay wrote:
> As support for clk-measure expands across more SoCs, the current
> approach of defining all SoC-specific clk-measure table data in the
> driver .c file results in progressively larger compiled images,
> resulting in memory wastage.
> 
> Move SoC-specific clk-measure tables to DTS definitions and extend
> support for additional SoCs (A4, A5, S7, S7D and S6).

This breaks ABI and most importantly the clk measure feature on new kernel
and old DTs. So instead keep it as-is for current platforms and try to
add this for new platforms.

But the fact you need clkmsr-reg-v2 means you at least need to add a generic
compatible for v2 register map and drop this property.

Overall, I'm not a great fan of this, it moves data to DT and duplicates
the strings in _all_ board DTs, which is worse in fine.

Neil

> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
> Chuan Liu (13):
>        dt-bindings: soc: amlogic: Add clk-measure related properties
>        soc: amlogic: clk-measure: Remove the msr_data from clk-measure
>        ARM: dts: amlogic: add clk-measure IDs and names for meson SoC family
>        arm64: dts: amlogic: add clk-measure IDs and names for Amlogic SoCs
>        dt-bindings: soc: amlogic: Unify the compatible property for clk-measure
>        soc: amlogic: clk-measure: Unify the compatible property
>        ARM: dts: amlogic: Unify the compatible property for clk-measure
>        arm64: dts: amlogic: Unify the compatible property for clk-measure
>        arm64: dts: amlogic: A4: Add clk-measure controller node
>        arm64: dts: amlogic: A5: Add clk-measure controller node
>        arm64: dts: amlogic: S7: Add clk-measure controller node
>        arm64: dts: amlogic: S7D: Add clk-measure controller node
>        arm64: dts: amlogic: S6: Add clk-measure controller node
> 
>   .../soc/amlogic/amlogic,meson-gx-clk-measure.yaml  |  66 +-
>   arch/arm/boot/dts/amlogic/meson8.dtsi              |  94 ++-
>   arch/arm/boot/dts/amlogic/meson8b.dtsi             |  94 ++-
>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 212 +++++
>   arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 202 +++++
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 275 +++++-
>   arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        | 312 +++++++
>   arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        | 253 ++++++
>   arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       | 243 ++++++
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 144 +++-
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   2 +-
>   arch/arm64/boot/dts/amlogic/meson-g12a.dtsi        | 229 +++++
>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 136 ++-
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 301 ++++++-
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         | 255 +++++-
>   drivers/soc/amlogic/meson-clk-measure.c            | 930 ++-------------------
>   16 files changed, 2877 insertions(+), 871 deletions(-)
> ---
> base-commit: e5624eb63c452efa753759e74eb27fe132eb577c
> change-id: 20250731-add-more-socs-to-support-clk_measure-b2a43590d5aa
> 
> Best regards,


