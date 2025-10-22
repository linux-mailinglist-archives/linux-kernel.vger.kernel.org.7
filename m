Return-Path: <linux-kernel+bounces-864631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7709BFB39A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 067BD4E8F61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23C6315D41;
	Wed, 22 Oct 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="fA20Bhol"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8B1A317D;
	Wed, 22 Oct 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126756; cv=none; b=FEQf+suWMK7EWM5tfO1TIW5TyvKsY92VqI1cYT3tSNjNeEOWDKhhjnQJg7lWB5nMTIgVNrO3/q+9I6+Ttf3m0LJ367KOpsurtE8svdsV+0WLWNMc95yNWqNOD2G+fG7UzSVh0y+qHNRmuS45pvTxpSyDrNY+l4xISnqodeT6KFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126756; c=relaxed/simple;
	bh=cVjcunS8h1jqTIUejZ/Xq/wEq3N5kc+C9hdZmV/2aZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYGEQ7jj/+viEqLRNyNFT8OnsE++FciQNIG709eOFVeSZSX/roWOncS767ILu4bpk4rlyPJfQDsdt7Q7VfZzNIpt3/0CCmX/SwA89xXkfzYmT25Zy53df4g/9SzQ7TzIqJQr49W+QZad2Wm9vxMrT+EGYnob/Xl41sQBPCYXBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fA20Bhol; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=IRzW4TIfXqA8U8VyFhl4a5nR+JpRyPOHWAWMvoNSBog=; b=fA20BholhvJ7oFwc8aYVXE2OrK
	QjmyiUqQbpuRqoxZ+ov/1s2x79Oq5rPYjUrhl9DPId2GhGLbZqtiykPQFIvR/6h5tHc58MyrJeV3T
	8O3t0i8QBYjRFBJmTVw0E91OigGD6TNXcOoihDOeLxh7R3AYtgHPwRvj/J+bzH2ruAkf2WLUC+5/Z
	1wcyMleDF0U1wMB7ysgv16Z0TPkayX3+cE4KSntcTzTnnGiuWNbTucD8PWCP8peCuyioOY9sf3DTp
	UjAuzab7XyvRpTVIlzGqrQ9oojXWZ7iWnmWupjwZZ8I9f6XY9JgG8Y079cHBJJX8aTHKSiC+JVPG6
	PKkkGKRg==;
Received: from [141.76.253.241] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBVVt-00027D-MX; Wed, 22 Oct 2025 11:52:13 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 zhangqing <zhangqing@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
 finley.xiao@rock-chips.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: clock, reset: Add support for rv1126b
Date: Wed, 22 Oct 2025 11:52:12 +0200
Message-ID: <3346817.AJdgDx1Vlc@phil>
In-Reply-To: <5a551943-141a-4842-a4d0-b66b32cf3e70@rock-chips.com>
References:
 <20251021065232.2201500-1-zhangqing@rock-chips.com> <4463339.ejJDZkT8p0@phil>
 <5a551943-141a-4842-a4d0-b66b32cf3e70@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Elaine,

Am Mittwoch, 22. Oktober 2025, 05:21:43 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb zhangqing:
> =E5=9C=A8 2025/10/21 16:38, Heiko Stuebner =E5=86=99=E9=81=93:
> > Am Dienstag, 21. Oktober 2025, 08:52:27 Mitteleurop=C3=A4ische Sommerze=
it schrieb Elaine Zhang:
> >> Add clock and reset ID defines for rv1126b.
> >> Also add documentation for the rv1126b CRU core.
> >>
> >> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>   .../bindings/clock/rockchip,rv1126b-cru.yaml  |  52 +++
> >>   .../dt-bindings/clock/rockchip,rv1126b-cru.h  | 392 +++++++++++++++++
> >>   .../dt-bindings/reset/rockchip,rv1126b-cru.h  | 405 ++++++++++++++++=
++
> >>   3 files changed, 849 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/clock/rockchip,=
rv1126b-cru.yaml
> >>   create mode 100644 include/dt-bindings/clock/rockchip,rv1126b-cru.h
> >>   create mode 100644 include/dt-bindings/reset/rockchip,rv1126b-cru.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rv1126b-=
cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
> >> new file mode 100644
> >> index 000000000000..04b0a5c51e4e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
> >> @@ -0,0 +1,52 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/clock/rockchip,rv1126b-cru.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Rockchip RV1126B Clock and Reset Unit
> >> +
> >> +maintainers:
> >> +  - Elaine Zhang <zhangqing@rock-chips.com>
> >> +  - Heiko Stuebner <heiko@sntech.de>
> >> +
> >> +description:
> >> +  The rv1126b clock controller generates the clock and also implement=
s a
> >> +  reset controller for SoC peripherals.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - rockchip,rv1126b-cru
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  "#clock-cells":
> >> +    const: 1
> >> +
> >> +  "#reset-cells":
> >> +    const: 1
> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +
> >> +  clock-names:
> >> +    const: xin24m
> > I think we're missing the optional
> >
> >     rockchip,grf:
> >       $ref: /schemas/types.yaml#/definitions/phandle
> >       description:
> >         Phandle to the syscon managing the "general register files" (GR=
=46),
> >         if missing pll rates are not changeable, due to the missing pll
> >         lock status.
> >
> >
> > because RV1126B_GRF_SOC_STATUS0 contains the PLL lock status.
> The pll lock truly uses bit10 of the PLL_CON1 register of CRU and does=20
> not use grf. Does that mean there is no need to increase rockchip,grf=EF=
=BC=9F

correct ... in that case we don't need the GRF reference.
As we're not accessing the GRF.

Please also drop the RV1126B_GRF_SOC_STATUS0 constant from the driver
in that case.

Thanks
Heiko



