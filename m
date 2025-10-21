Return-Path: <linux-kernel+bounces-862445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E737BF54EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B941E3A4A32
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D030CDA5;
	Tue, 21 Oct 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="iEdMi9lI"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F52311953;
	Tue, 21 Oct 2025 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035937; cv=none; b=nCgi+94vADBMbTM8THAOOGHlr35gM73+3a6i0D1VsAGqJz3GJaJ+21Dn0h/hpEoldZpNMGbds4iO3vPn9eXgLWS+a9/A5sZaDo8jL4inopeRvKN/Kvbd5qAOQt8PrYz0D8iRNGq5U9aJvdowN4DosIzM5dtjy+v7mpS0SbcF8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035937; c=relaxed/simple;
	bh=OkTTOs8u5Z/zCBGUclr/sqSWwZZH1BXU6gWLVeYZeYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GX7Qd3F/+urxoP+B+JAI5kj93EvsEMG+XyOEUPmGAdWA6Ik+J/vjbn6T7jnGuUpiO+d+9wdMn37poVswCIzRFEz+KOUFTCYgqd/2SGF/+c/5FV/arC+ImUEfB+uDJn0Al10C30J6QAjl7VnpVLXbYxiFs4iAB3bCFBdzJx+Yypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=iEdMi9lI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=GXbqGEqtn7uQLSJTDpkbfTb/HIT9zRnLyNNGASNhKDc=; b=iEdMi9lIca+YqotIqGbMIEpwR8
	z073jtgmRswef6NyTJsXqw8tvedCaf67afY5Up+KyW2MoL+XrmFr6G0+2reuEJ1HdXbvIuA/ePs9r
	4HuGjGADqCQMBO5DJUxD9RGGTzwtzzVZQbtXvdCyc+Og6PCT8aRmiSeSIibQK9GdBz9a7q4OfO/Qv
	LYiRKWrveDlm8s1T2cmeKVum+KxCcyQ2QAagVs+BL5OKQGhMuMNl+hWVX6tHFAydUkonqZo6hQctF
	OWPz21P82+fVZd+CujyborfqXwX5kOqBvc+Rt7XmC5ST7WdLe3S3mT1nEbi8LQhEXwSxW4HrXf3gx
	uaNGptCA==;
Received: from [212.111.240.218] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB7tH-0001Ua-Sv; Tue, 21 Oct 2025 10:38:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
 zhangqing@rock-chips.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, Elaine Zhang <zhangqing@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
 finley.xiao@rock-chips.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: clock, reset: Add support for rv1126b
Date: Tue, 21 Oct 2025 10:38:46 +0200
Message-ID: <4463339.ejJDZkT8p0@phil>
In-Reply-To: <20251021065232.2201500-3-zhangqing@rock-chips.com>
References:
 <20251021065232.2201500-1-zhangqing@rock-chips.com>
 <20251021065232.2201500-3-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Elaine,

Am Dienstag, 21. Oktober 2025, 08:52:27 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Elaine Zhang:
> Add clock and reset ID defines for rv1126b.
> Also add documentation for the rv1126b CRU core.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/clock/rockchip,rv1126b-cru.yaml  |  52 +++
>  .../dt-bindings/clock/rockchip,rv1126b-cru.h  | 392 +++++++++++++++++
>  .../dt-bindings/reset/rockchip,rv1126b-cru.h  | 405 ++++++++++++++++++
>  3 files changed, 849 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv11=
26b-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rv1126b-cru.h
>  create mode 100644 include/dt-bindings/reset/rockchip,rv1126b-cru.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru=
=2Eyaml b/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
> new file mode 100644
> index 000000000000..04b0a5c51e4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rv1126b-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RV1126B Clock and Reset Unit
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description:
> +  The rv1126b clock controller generates the clock and also implements a
> +  reset controller for SoC peripherals.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rv1126b-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: xin24m

I think we're missing the optional

   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Phandle to the syscon managing the "general register files" (GRF),
       if missing pll rates are not changeable, due to the missing pll
       lock status.


because RV1126B_GRF_SOC_STATUS0 contains the PLL lock status.


Heiko




