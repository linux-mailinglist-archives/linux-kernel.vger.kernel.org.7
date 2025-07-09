Return-Path: <linux-kernel+bounces-723701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B3CAFEA1B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A884E714C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C92E54D2;
	Wed,  9 Jul 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="xmn443zN"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7A2E54B5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067426; cv=none; b=gODU3uKEG/4gVtf/IyCEvVrDLKT71mkzUPZpFc+MiaJUzM3A11UAEGL1M4FzMfVgNKKbG8FkfBlGSkx5wiu5cJkkR3X0h9hUwExGskvt9+G4LpRQ5E3/I2P5ICSw6BypEM3cfVb7969xSVYBZbDL+siexXg5IlQckPbpLYkVOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067426; c=relaxed/simple;
	bh=S2JBHxE2A0fF5iG6RyVzhdwcE1CqCzzD/2/R8qpHEAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAOuFmmSHRv2GjISZ0KBRP8+TZeMHjKNTEaf//RIDrwGH/3jH7dzFkQy0CAb44SWEJ4/t7t3T3gSrXcrxdrftRU5aB32LNY54oZgH/nN+LIjFs4aSEobJnHdYvyVk7UGOL3fQ4xyjDraD3zHEM9EumqiWbFsrA6t1wf0RXJnsho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=xmn443zN; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752067411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h3oB83QFgAXtjWOjOKu/2nsCUQVsRZtax03o5JAM6Y8=;
	b=xmn443zN8ZCqi+yE0svYjy3EEAA/aL5PrNO+deNCU4758v55UA1ZIGh2qzcJDL6VwXCYuQ
	7Cg73xcyw68fomcZXRgcV/1tHzS8jwhbSn/L8yw9IqISeMngjRo4dbwDCwIm/vyqQw1Ikh
	5OjIghyN/8GXcP0LCmco4LiJjC0ofu2LWkgLgb7vkomlE4krN+mxwE257oEVjBCTJ0sIqJ
	dhzCK3XfNcj3AdAZaHjMd/duHBDxdeIzgnpk13qA3lMimKlydMg9XjCnQVbWLTAMHXSZDk
	xtQHNDL+lQp1yTQv/HaIT2z2LrpA/bYiS/U4crmLUrJafCGviL+zkOyZXCKuVw==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH v4 00/10] rockchip: Fix several DTB validation issues
Date: Wed,  9 Jul 2025 15:15:13 +0200
Message-ID: <20250709132323.128757-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch set fixes several DTB validation issues and consists of 2
parts:
1) dsi refactoring
2) various low-hanging fruit

ad 1) The display/rockchip/rockchip,dw-mipi-dsi.yaml binding had:
- #address-cells
- #size-cells

My guess is that those properties were added for panel(s) which could
be connected. While convenient, it caused DTB validation issues when a
panel was not defined on a board. So add the #address/#size-cells
properties to the board dts[i] file where there is a panel and then
remove the properties from the SoC dtsi file.
Also remove the properties from this binding as they were already
defined in "dsi-controller.yaml".

ad 2) There were a number of issues which were obvious to me how to fix,
so I fixed those as well. One of those was the addition of port(s) or
endpoints, but for that the context (ie parent nodes) got redefined ...
to the same values they had in the SoC dsi node. The SoC dsi node
already defined the structure where each port got a label/phandle. That
allows for a simplification of the port/endpoint by referencing that
label/phandle.

My changes were based Heiko's v6.17-armsoc/dts64 branch at commit
7f9509791507 ("arm64: dts: rockchip: add DTs for Firefly ROC-RK3588S-PC")

Then applied the following patches:
86491c2b99e5 ("dt-bindings: pinctrl: rockchip: increase max amount of device functions")
6f446bbe412a ("dt-bindings: gpu: mali-utgard: Add Rockchip RK3528 compatible")
ab9be0b75af5 ("dt-bindings: display: himax-hx8394: Add Huiling hl055fhav028c")
8358102806c6 ("dt-bindings: power: rockchip: Add support for RK3528")
233eda069994 ("dt-bindings: rockchip: pmu: Add compatible for RK3528")

And then validated it with W=1 using dtschema-2025.6.1.
The validation log file sizes:
- base: 99.9 KiB
- dsi: 82.2 KiB
- low-hanging-fruit: 69.0 KiB

I then checked whether dmesg wouldn't indicate problem on these boards:
- Rock64 (rk3328)
- RockPro64 (rk3399)
- PineTab2 (rk3566)

And I didn't find any. I don't have any px30 or rk3399-gru-* based
boards, so I couldn't test with those.

Changes in v2:
- Move refactoring of port/endpoint definition to its own patch
  (Quentin)
- Move re-ordering of nodes to its own patch (Quentin)
Link to v1:
https://lore.kernel.org/linux-rockchip/20250627152645.740981-1-didi.debian@cknow.org/

Changes in v3:
- Fix syntax error in RP64 screen dtso (kernel test robot)
Link to v2:
https://lore.kernel.org/linux-rockchip/20250628144915.839338-1-didi.debian@cknow.org/

Changes in v4:
- Fix commit message in patch 3 wrt dt-bindings (Rob)
Link to v3:
https://lore.kernel.org/linux-rockchip/20250629123840.34948-1-didi.debian@cknow.org/


Cheers,
  Diederik

Diederik de Haas (10):
  arm64: dts: rockchip: Move dsi address+size-cells from SoC to px30
    boards
  arm64: dts: rockchip: Move dsi address+size-cells from SoC to rk3399
    boards
  dt-bindings: display: rockchip,dw-mipi-dsi: Drop address/size cells
  arm64: dts: rockchip: Simplify VOP port definition on rk3328
  arm64: dts: rockchip: Simplify edp endpoints on several rk3399 boards
  arm64: dts: rockchip: Simplify mipi_out endpoint on rk3399 RP64 dtso
  arm64: dts: rockchip: Move mipi_out node on rk3399 haikou demo dtso
  arm64: dts: rockchip: Fix LCD panel port on rk3566-pinetab2
  arm64: dts: rockchip: Drop unneeded address+size-cells on px30
  arm64: dts: rockchip: Drop regulator-compatible property on rk3399

 .../rockchip/rockchip,dw-mipi-dsi.yaml        |  6 -----
 .../rockchip/px30-cobra-ltk050h3146w-a2.dts   |  2 ++
 .../dts/rockchip/px30-cobra-ltk050h3146w.dts  |  2 ++
 .../dts/rockchip/px30-cobra-ltk050h3148w.dts  |  2 ++
 .../dts/rockchip/px30-cobra-ltk500hd1829.dts  |  2 ++
 arch/arm64/boot/dts/rockchip/px30-evb.dts     |  2 ++
 .../rockchip/px30-pp1516-ltk050h3146w-a2.dts  |  2 ++
 .../dts/rockchip/px30-pp1516-ltk050h3148w.dts |  2 ++
 arch/arm64/boot/dts/rockchip/px30.dtsi        |  6 -----
 .../dts/rockchip/rk3326-anbernic-rg351m.dtsi  |  2 ++
 .../dts/rockchip/rk3326-gameforce-chi.dts     |  2 ++
 .../boot/dts/rockchip/rk3326-odroid-go.dtsi   |  2 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  6 +----
 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi |  4 ----
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 15 ++++---------
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  4 +++-
 .../boot/dts/rockchip/rk3399-hugsun-x99.dts   |  2 --
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts | 15 ++++---------
 .../dts/rockchip/rk3399-pinephone-pro.dts     |  2 ++
 .../rk3399-puma-haikou-video-demo.dtso        | 12 +++++-----
 .../boot/dts/rockchip/rk3399-rock-4c-plus.dts |  2 --
 .../dts/rockchip/rk3399-rockpro64-screen.dtso | 22 ++++++-------------
 .../rockchip/rk3399-sapphire-excavator.dts    | 16 ++++----------
 .../boot/dts/rockchip/rk3566-pinetab2.dtsi    |  6 ++---
 24 files changed, 54 insertions(+), 84 deletions(-)

-- 
2.50.0


