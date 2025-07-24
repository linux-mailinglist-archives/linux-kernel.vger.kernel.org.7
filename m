Return-Path: <linux-kernel+bounces-743692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15DB101ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00343A5C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B9D217F31;
	Thu, 24 Jul 2025 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gn/1d7Yi"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90668224891
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342481; cv=none; b=Rvz/7otzyVKTWkHBFeMW1IgesmptzwNtlh8DgoNyTc0+K94M27GKd5nkxYeVbLB34vCwpWX+hTzbA5ffACUnyqbkxjbcoVsDW+PMrogshgNcgUhF3Vez3APdctNFWMWi0CQzU3gEgRmQB33Y7UKwChuJyLmFiRuMakoYndLxjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342481; c=relaxed/simple;
	bh=TYgN8U9wXkI2grtnzziutELEQhN3M8VMDw6/GErLUtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fR51TpepwKzE3PI6pviFNqy1KW5+5Qu/WJAVqdfX3Y8sxiu2EoClyYcWCnCAw/Es3I2vB4j+E1N3jxibgQtvHkYQ6NGGYqwbIjczI3xjIvzOGLtn/kVBi3B2TMhlaw4zCKoSipATLM3OuJKf8/DRJ7/jwBCNI6tomiZWRcj8iHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gn/1d7Yi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aec46b50f33so105942966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753342478; x=1753947278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWI57Slc6aJyyVyKYETscKzj1A9LG5NFExHcyZfN1I4=;
        b=gn/1d7YidnBxGz/Y34PucXcLjHa4Vt6XEtTgiprTpO50KI9Hvbg/6q5oXoRd/UpAkP
         lAC60NParhqqkOamh4pb1IcsIr4fqoO3DEOFiWOyDwkvD2HoDSZnWe0OnL0BT5k5XzVe
         8ldCwFaH4WCnJJxDXbfsmUn9DdnotGlD8LQsgturkV8P9fIHxRmig2cRXdLZt22X9TR9
         uziPrZnF0QWagttgGPlYnnuna+EC40FJhINc/qPaL5K7nmGjGPi0N2GVhTRZD/YoFI5+
         1NkD26L653XSi4mmz5neGSXDkP4ijypYYI+ymW7/4SIb+gykaS/RqRO1Mc7a4Igp5n4I
         tOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342478; x=1753947278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWI57Slc6aJyyVyKYETscKzj1A9LG5NFExHcyZfN1I4=;
        b=LsQxbzpC84dW93eRBOdiRYvOe/6MvLDRGCU/tq2C5w1UZvnjWOEYVNX5Lss1Nc8Kib
         wEstq46jIFf/QjMWCeDZUMdLZRAuHhdwvyBLolHl7jgvUNw9CN+lPzNgDWumFN9piI0A
         wSXHTB/FNOxEFe6yHrGHn3x4wluQIxtM5Q0g3wukW2Eb/ZJ124ty/W7mwUe0M2dIk1ma
         T3JXsUK8LI2hbg96/M4sg6LLv0JnOYNuoJGmOge5HBO8ITJnT/tNU+xMgZl/8WFFAG6G
         zVkqS2/0FqGHfLy9VFDwDHawnmR6RyC7AxOkXPMMhWdA5vls5DUmpzhQRtw/PPW7tzJr
         id3g==
X-Forwarded-Encrypted: i=1; AJvYcCWdbK7iyVxidjwzqw0z+gs9HHXKY1fZ5bcE2ZoipF7MF1B+nY89rrGvbG/JFp9zSisIZYex8JOg/JWj5fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytofEwLwdFzZkrEFJJcka+Erc7zXJ4omGPz2ozEJ1PEkUjiGzr
	V+KCUoVS+iQf4jD5joy8sNd9gj3mUbx5JcdUkM2pOM62ewr3iU2w3mMRgwDpCKWIUnoEw2QgVZB
	fn9B3
X-Gm-Gg: ASbGncs261qY1v9fok/Evt0zEAxmxx4uYaxYHj7QZuhp4zhdoNOpaQ1zJVoCGYzT2of
	l7/yOj2CBFOm2XSUZtRnXbh0RcH8YCQn0T2o+fVOK3LjS6cPyO8FjrFnnV5q1P+AP3XIU6Iz06D
	Mb2Ipqt5nPSEbleYxGqR9E6Id0dZ7dELCXLFvzGGrhhnmW0I4Zs2KmeXta0e44fs69SpZk165js
	MWQdrISSEWPAYTg1EhHMLesHbDNqNAcUF0eLZmwEgjZDc1DPhJwnubbXzgeMEEbwsytZBXfQVd8
	AnCU18hoTmFi6Uxp4TJ90Sit+u6kUoUFBMYYVW+gjG5ikUNm8U9I7gh3HaO/oRfc2A1++OYDvwg
	eK+G7Mo0QTqxTDEib4uLDMH9mCT8ZbBDQ3Q==
X-Google-Smtp-Source: AGHT+IGOU5tq53uFmqt87ujSJNnr8Psuegs3IGpCOBKNBhU1Xd+EFhtxeNP1kjGPl47XUHyqRueUIw==
X-Received: by 2002:a17:906:d54b:b0:ae3:7b53:31bd with SMTP id a640c23a62f3a-af2f865d730mr626970666b.28.1753342477755;
        Thu, 24 Jul 2025 00:34:37 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:706f:1fb4:134c:465d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c58b3c4sm72543666b.10.2025.07.24.00.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:34:37 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:34:35 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: srinivas.kandagatla@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/23] arm64: dts: qcom: sc7280: use dedicated
 elite-audio dtsi
Message-ID: <aIHiCwj5NeVdeuLR@linaro.org>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-13-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723222737.35561-13-srinivas.kandagatla@oss.qualcomm.com>

On Wed, Jul 23, 2025 at 11:27:26PM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
> This move removes duplication.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |  1 +
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |  1 +
>  .../boot/dts/qcom/qcm6490-shift-otter.dts     |  1 +
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  1 +
>  arch/arm64/boot/dts/qcom/sc7280-audio.dtsi    |  8 +++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  1 +
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  1 +
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          | 68 +------------------
>  arch/arm64/boot/dts/qcom/sm7325.dtsi          |  1 +
>  9 files changed, 16 insertions(+), 67 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio.dtsi
> 
> [...]
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 5fbcd48f2e2d..8b4717ba0be5 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sc7280.dtsi"
> +#include "sc7280-audio.dtsi"

^

>  #include "pm7250b.dtsi"
>  #include "pm7325.dtsi"
>  #include "pm8350c.dtsi"
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-audio.dtsi b/arch/arm64/boot/dts/qcom/sc7280-audio.dtsi
> new file mode 100644
> index 000000000000..4ff49550460a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-audio.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#include "elite-audio.dtsi"
> +&q6asmdai{
> +	iommus = <&apps_smmu 0x1801 0x0>;
> +};

As far as I understand, RB3Gen2 uses AudioReach [1], so we shouldn't
have an Elite-based "sc7280-audio.dtsi" included in all boards. In this
case, I think we need separate sc7280-audio-elite.dtsi and
sc7280-audio-audioreach.dtsi and include what is relevant for the board.

[1]: https://lore.kernel.org/linux-arm-msm/20250720173215.3075576-1-quic_pkumpatl@quicinc.com/T/

Thanks,
Stephan

