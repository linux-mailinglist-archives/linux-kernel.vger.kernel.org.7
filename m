Return-Path: <linux-kernel+bounces-862442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46967BF54AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EB2B4FECF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B351305042;
	Tue, 21 Oct 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qB5LIpGN"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F927F759;
	Tue, 21 Oct 2025 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035824; cv=none; b=BkJaHUaDhyFZzlZ45vByoxloTEenvQBIkQsrbtHZNNVSP2SNWjOzqv1YmQnGnw3fX76iaUaPA9n83Wh08WiOaYSj8idiN3Z5nNronzk/bT8ZmS7kNB98n217e3fNQ4jcC2504R2oN5ZKuBtTlDIzHo3q5bYADBhBo+rfb7Zl/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035824; c=relaxed/simple;
	bh=kxUPe6KqLh2DKKLMP1TMTBCbRdceZpYNV75wfyCVXps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfuYszT7pLZQhrd7h9RWkcyrSi7I8cx7xpYT44CW7lceBKV98Fw0znIyTBqspetrybcAIq2KAl8jg+6M6auAuNf9Yn54RAwoZyU1/KA3+0KzJDhUJGW/oP33kfpzu2sL86pBxpiXq7o76Xcx/zkFkrBGekUMNvB6cv2OvbtVxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qB5LIpGN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=uzjSzcMiMfvyxgchJvQg0UkKHrfCLh0KZ54XotRuE78=; b=qB5LIpGNS6VFKFLCsQ7oi+wSOg
	/gArHf6epn6m21W3unoEXDPGUQAXZ9m7K7Rn+oeJ7JoBTN+ERYRDShJuirU885aLX5XyGLpHTXBSC
	E1YaPDNxlmOwHcY/a/j2vCuQvvkr2tNAxR5Y2lJh7dynyISUinvs6ndeDB5YVgvegEbddLJbE+3r3
	sita/nZb3YjX638SsaONPcDcq/p9RieF4Nv9+pKLjxP4esookDF/TG2wvF1AkNtYYF3h8sVihnN5a
	hCy0rvV3e/Eq3GOpFSmgjhDapqEmqGYm44wguRibcHutYarOgTIftclczed7RRtZhSD9Y+Z+PoJaK
	zMCyixjQ==;
Received: from [212.111.240.218] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB7rS-0001TP-CV; Tue, 21 Oct 2025 10:36:54 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
 zhangqing@rock-chips.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, Elaine Zhang <zhangqing@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
 finley.xiao@rock-chips.com
Subject:
 Re: [PATCH v4 6/7] dt-bindings: clock: rockchip: Add RK3506 clock and reset
 unit
Date: Tue, 21 Oct 2025 10:36:53 +0200
Message-ID: <24128799.6Emhk5qWAg@phil>
In-Reply-To: <20251021065232.2201500-7-zhangqing@rock-chips.com>
References:
 <20251021065232.2201500-1-zhangqing@rock-chips.com>
 <20251021065232.2201500-7-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Elaine,

Am Dienstag, 21. Oktober 2025, 08:52:31 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Elaine Zhang:
> From: Finley Xiao <finley.xiao@rock-chips.com>
>=20
> Add device tree bindings for clock and reset unit on RK3506 SoC.
> Add clock and reset IDs for RK3506 SoC.
>=20
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,rk3506-cru.yaml   |  45 +++
>  .../dt-bindings/clock/rockchip,rk3506-cru.h   | 285 ++++++++++++++++++
>  .../dt-bindings/reset/rockchip,rk3506-cru.h   | 211 +++++++++++++
>  3 files changed, 541 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk35=
06-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rk3506-cru.h
>  create mode 100644 include/dt-bindings/reset/rockchip,rk3506-cru.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.=
yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
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
> +  The RK3506 CRU generates the clock and also implements reset for SoC
> +  peripherals.
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3506-cru
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

I think we want clocks and clock-names properties here for xin24m
similar to the rv1126b binding (and other modern soc bindings)

Also, I think we'll need

   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Phandle to the syscon managing the "general register files" (GRF),
       if missing pll rates are not changeable, due to the missing pll
       lock status.

because, you're using RK3506_GRF_SOC_STATUS
for the PLL locking status.


Heiko



