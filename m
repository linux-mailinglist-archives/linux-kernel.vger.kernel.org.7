Return-Path: <linux-kernel+bounces-868216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA32C04A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16CF24F94F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE442C027A;
	Fri, 24 Oct 2025 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex1t4OPx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEB29D26E;
	Fri, 24 Oct 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290049; cv=none; b=dNU3t8d0OIVlTGQXmtuZY0WJWIzBfLy7/v2h9sIItLa/kl5NosToHi5QZI50lKiikpGkwmN94RURGBXLfd8Cskw6Bynlo3B2ViHExjekK5wWPagpUReEfP0fGAtN/VMuX76Yibej/6dmnsCaSEz7FK183zBdAa+BPyhVz6pQgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290049; c=relaxed/simple;
	bh=tixsbOhPpx+6hLtcafF4AhfrtkXskRGuW6voP6ka0TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjKS8wvZ2v/vaQX346M4FlILQuuNdY/UrCXXc5yWuWHgj9YZGcI+hsOoumui1qMgBRitElYrv1M1+uv/i0i7aYdbD0td7WNYQKPZUvLlfBb0QtkoVsmPVc73gIH9L9Bmbo/vdPpmXhudve8wImvhLkzy0w8pmhrvSIfhoPwHeco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex1t4OPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30551C4CEF1;
	Fri, 24 Oct 2025 07:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761290048;
	bh=tixsbOhPpx+6hLtcafF4AhfrtkXskRGuW6voP6ka0TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ex1t4OPx1GNhOGgxZG9mfTnTw6vg7QdtA/sCWg+iWh3jsuMYZI9yMUgqkPiIElcTp
	 qb6WczdXr4o3U9dAaNA5iG2HH1NfR16Ork7l3Il5Zta32w7HUou1h+s5ROTuFB1zAZ
	 TgZ8sYNWK60atK1vpk1vYQhxqwmgv/YHigW3PEYOBkNTMZzHD4preROzq6TB1w+QvX
	 taPyrRNHrs7o4UKI8Z/TqDPTTtlRHvf30sttXdLnsT1UVoPLFqTKXHW0V/5AKBqakB
	 777b+6NHPduvK/0TGOPWMTStTjCfsgOTZ2k4+VHN/5hPGL0VDcmWxRscQVMy4rcRtn
	 /zsWNUNhuc6Gg==
Date: Fri, 24 Oct 2025 09:14:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com, 
	heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	huangtao@rock-chips.com, finley.xiao@rock-chips.com
Subject: Re: [PATCH v4 6/7] dt-bindings: clock: rockchip: Add RK3506 clock
 and reset unit
Message-ID: <20251024-wonderful-banana-bumblebee-273c8f@kuoka>
References: <20251021065232.2201500-1-zhangqing@rock-chips.com>
 <20251021065232.2201500-7-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021065232.2201500-7-zhangqing@rock-chips.com>

On Tue, Oct 21, 2025 at 02:52:31PM +0800, Elaine Zhang wrote:
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
> new file mode 100644
> index 000000000000..43e192d9b2af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3506-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3506 Clock and Reset Unit (CRU)
> +
> +maintainers:
> +  - Finley Xiao <finley.xiao@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The RK3506 CRU generates the clock and also implements reset for SoC
> +  peripherals.
> +

...

> diff --git a/include/dt-bindings/clock/rockchip,rk3506-cru.h b/include/dt-bindings/clock/rockchip,rk3506-cru.h
> new file mode 100644
> index 000000000000..f629b6fa75c3
> --- /dev/null
> +++ b/include/dt-bindings/clock/rockchip,rk3506-cru.h
> @@ -0,0 +1,285 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023-2025 Rockchip Electronics Co., Ltd.
> + * Author: Finley Xiao <finley.xiao@rock-chips.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3506_H
> +#define _DT_BINDINGS_CLK_ROCKCHIP_RK3506_H
> +
> +/* cru plls */
> +#define PLL_GPLL			1

Other binding starts from 0, so be consistent.

> +#define PLL_V0PLL			2
> +#define PLL_V1PLL			3
> +
> +/* cru-clocks indices */

You should not have holes in indices. These are abstract numbers, not
hardware values.


> +#define ARMCLK				15

...


> +#ifndef _DT_BINDINGS_REST_ROCKCHIP_RK3506_H
> +#define _DT_BINDINGS_REST_ROCKCHIP_RK3506_H
> +
> +/* CRU-->SOFTRST_CON00 */
> +#define SRST_NCOREPORESET0_AC		0

Here ^^^ starts with 0, not 1.

Best regards,
Krzysztof


