Return-Path: <linux-kernel+bounces-852074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2EDBD81B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A838E34E876
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38330F558;
	Tue, 14 Oct 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jzql7MQ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346C30EF98;
	Tue, 14 Oct 2025 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429377; cv=none; b=H2xx15KibLETfYR5JFVWKcK+FecqzMx1lGs/LLL0axsc/iXINOSe9pHPWtfD/T2dCBhFa0Q/fsV67IhxrYK1Hm5SH9qxOkWj02jgmcBlGkGNyW8jYrVObzHsG4n0STHWqk2/BsbK8tz/wPnJII+qXdBVNZfx5CvAOpiuBvZ6WJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429377; c=relaxed/simple;
	bh=aod1SyLTuA8l9vg6WTwLEHjQq4wmSw6FgH1FjGpTX9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olIo4jh8hrsbhN51K2gZeTHRiiFohTp+KdA76Hqs/CLfz07oOZSjzpUYm/rg+dlYEXRWqRpsS11hzeW1BQ+a1o8khEa9Tg83gHKrV1XRVB/U3bz7St9ZThOMRq0MdRE6HJiNF4SgTOQgeIkef3XHUCILbef8zxDh7/797sURFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jzql7MQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A130DC4CEE7;
	Tue, 14 Oct 2025 08:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760429376;
	bh=aod1SyLTuA8l9vg6WTwLEHjQq4wmSw6FgH1FjGpTX9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jzql7MQ10q+YZCucKA5N988SKunyz3/4BxYsHwt/dfNEgNaGWj6mdI/P1x+PjaR5e
	 +LZFrfj/8KAjK5mRkvr+6txwTGE4T2ClQ0EJKHW9wXsQ/0x+kczVv5gKZh3fgFBKFd
	 e04P+Y519liUIsDjciV0ag5TW+I40EcLNhh9urCfmNEzR0FkxLz07qpVHyA2dTm022
	 cFrrkqW4wT7aEZgk2d+QMB36oZqjt2KrzRIiWvOWdeh+/kP4gWLkbIQYnMIqi4Y0Xd
	 ySTMGqPiPfZjdAA8qV+XAP+6itCrtJUFGHHd8yOYbs7ioCItmj887THgKXMp3ipvpi
	 UxVOejTv+F+ug==
Message-ID: <b6af124c-6d51-437e-bf51-d799ffbaaf55@kernel.org>
Date: Tue, 14 Oct 2025 10:09:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: regulator: Add MAX77675 binding
 header
To: Joan-Na-adi <joan.na.devcode@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
References: <20251014053142.15835-1-joan.na@analog.com>
 <20251014053142.15835-2-joan.na@analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251014053142.15835-2-joan.na@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 07:31, Joan-Na-adi wrote:
> From: Joan Na <joan.na@analog.com>
> 
> Add binding header for the MAX77675 PMIC regulator. This header defines
> voltage ID and regulator index macros used both in device tree sources
> and in the driver implementation.
> 
> Fixes:
> - Removed unused macros
> - Renamed macros for clarity


This makes no sense. Fixes what? There are no macros before.

Please read submitting patches how to write proper changelogs.

> 
> Signed-off-by: Joan Na <joan.na@analog.com>
> ---
>  .../regulator/maxim,max77675-regulator.h      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 include/dt-bindings/regulator/maxim,max77675-regulator.h
> 
> diff --git a/include/dt-bindings/regulator/maxim,max77675-regulator.h b/include/dt-bindings/regulator/maxim,max77675-regulator.h
> new file mode 100644
> index 000000000000..b3b52d1668c2
> --- /dev/null
> +++ b/include/dt-bindings/regulator/maxim,max77675-regulator.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD 2-Clause */
> +/*
> + * This header provides macros for MAXIM MAX77675 device bindings.
> + *
> + * Copyright (c) 2025, Analog Device inc.
> + * Author: Joan Na <joan.na@analog.com>
> + */
> +
> +#ifndef _DT_BINDINGS_REGULATOR_MAX77675_
> +#define _DT_BINDINGS_REGULATOR_MAX77675_
> +
> +/* FPS source */
> +#define MAX77675_FPS_SLOT_0       0x0
> +#define MAX77675_FPS_SLOT_1       0x1
> +#define MAX77675_FPS_SLOT_2       0x2
> +#define MAX77675_FPS_SLOT_3       0x3
> +#define MAX77675_FPS_DEF          0x4
> +
> +/* nEN Manual Reset Time Configuration (MRT) */
> +#define MAX77675_MRT_4S           0x0
> +#define MAX77675_MRT_8S           0x1
> +#define MAX77675_MRT_12S          0x2
> +#define MAX77675_MRT_16S          0x3

None of these are bindings.


> +
> +/* nEN Mode Configuration */
> +#define MAX77675_EN_PUSH_BUTTON   0x0
> +#define MAX77675_EN_SLIDE_SWITCH  0x1
> +#define MAX77675_EN_LOGIC         0x2

Neither these.

> +
> +/* Debounce Timer Enable (DBEN_nEN) */
> +#define MAX77675_DBEN_100US       0x0
> +#define MAX77675_DBEN_30000US     0x1
> +
> +/* Rising slew rate control for SBB0 when ramping up */
> +#define MAX77675_SR_2MV_PER_US    0x0  // 2 mV/us
> +#define MAX77675_SR_USE_DVS       0x1  // Use DVS slew rate setting (maxim,dvs-slew-rate)
> +
> +/* Dynamic Voltage Scaling (DVS) Slew Rate */
> +#define MAX77675_DVS_SLEW_5MV_PER_US    0x0  // 5 mV/us
> +#define MAX77675_DVS_SLEW_10MV_PER_US   0x1  // 10 mV/us
> +
> +/* Latency Mode */
> +#define MAX77675_HIGH_LATENCY_MODE  0x0   // High latency, low quiescent current (~100us)
> +#define MAX77675_LOW_LATENCY_MODE   0x1   // Low latency, high quiescent current (~10us)
> +
> +/* SIMO Buck-Boost Drive Strength (All Channels) */
> +#define MAX77675_DRV_SBB_STRENGTH_MAX  0x0  // Maximum drive strength (~0.6 ns transition time)
> +#define MAX77675_DRV_SBB_STRENGTH_HIGH 0x1  // High drive strength (~1.2 ns transition time)
> +#define MAX77675_DRV_SBB_STRENGTH_LOW  0x2  // Low drive strength (~1.8 ns transition time)
> +#define MAX77675_DRV_SBB_STRENGTH_MIN  0x3  // Minimum drive strength (~8 ns transition time)
> +


Drop entire header. Not a binding. Otherwise explain me which ABI are
you binding?


Best regards,
Krzysztof

