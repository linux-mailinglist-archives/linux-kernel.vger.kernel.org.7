Return-Path: <linux-kernel+bounces-825771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F34B8CCBD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788DD5618E1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD16302157;
	Sat, 20 Sep 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErmjTj1f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1412AE90;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385493; cv=none; b=LfNLV0trYIKFY0IF9vPJOTEivxRL8Z1NI+qcIrA6DhvNSx9zG+9FDpGywCU6UvOc4idWI7O2agaTKLUl5NlWzcZORetTavMtaTsiDas+jbQ34Q9E2dHtvcEkraeJbmr50+eRKpbwukEtNJAygZXgnzRWBJxGbvgaIUiu41SaL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385493; c=relaxed/simple;
	bh=u840vuSdNA238eaEpBUXCICkOP9msH1ZivtGlgxyhXY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XPXQWl/MJL64qDODQmmMu6/umNRp6tEITqC/FXCIetNRlda8nnjlRNBlv4xmq1PhWB1QDa+ZHZNwDnDbAubZ3ltXHdjthUrAyugqQ3MeaPRS2lMwKcATHTfoxo97DlxSMwl0bOqOHFRMSAiVpgWefdIQdEjX3fKK+p9+rb2KIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErmjTj1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B18EC4CEEB;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=u840vuSdNA238eaEpBUXCICkOP9msH1ZivtGlgxyhXY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ErmjTj1foKcF6UARGZ7AW6uu0wLM47I32cf9nhIsCczl91jF2Y4j23rU5+Tjm+GEg
	 o9JQUxeC/hDe9CqDAXQi458yOguDzop/ETBLbqBjp9zy6JYAAHeu4W4gBMAMw7A80Q
	 P2a2uu9G+yaWF0z98iS10aPFLA8/5L0/k3eKUPH71cRWFrn58GWAySNA3SG0wsndUa
	 zua3NWit+RK+vWKT9bC+NPrWXyQi/QQgNfNYCFk1jvF0+JATpuBl/T/jvdq9SIw2s5
	 5SJxhaMdNxhwHMNAq5edahRzAT1OGVyPdnlhBIj/+DDG4kV/N3vtUIMCYrJnc3M91f
	 RYNeqzhSaKGTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A418CAC5A0;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Subject: [PATCH 00/10] ARM: Add support for yarisxl mt6582 board
Date: Sat, 20 Sep 2025 20:23:25 +0200
Message-Id: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB7xzmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMD3dwSM1MLI11LY2PLFPO05NQkYxMloOKCotS0zAqwQdGxtbUAIVX
 EO1gAAAA=
X-Change-ID: 20250920-mt6582-9339d7fceb34
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=1921;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=u840vuSdNA238eaEpBUXCICkOP9msH1ZivtGlgxyhXY=;
 b=f4PxI5rxzmphfC3mJqHuJLLtu74mC8xdE0jGsQiiZDg3Bhahc+aOijqzXFUCItKAZYB1hMVMj
 lXU7DXzkgbVBmoqDQ6RZfAdU6e6CAmTqrrYb1ssoPVQofruMMy5o98c
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

This series adds support for Alcatel Pop C7 (OT-7041D) smartphone
board, named yarisxl, based on MT6582 SoC. It also includes some
preliminary patches. More in detail:
- patches 1 and 2 add support for mt6582 to platform code 
  (verified by looking at generic mt6582 downstream source code)
- patches 3-6 do some maintenance work to mt6582.dtsi 
  (I was unsure if squashing timer node patches into one)
- patches 7 and 8 add devicetree and dt-bindings support for yarisxl

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
Cristian Cozzolino (10):
      ARM: mediatek: add board_dt_compat entry for the MT6582 SoC
      ARM: mediatek: add MT6582 smp bring up code
      ARM: dts: mediatek: mt6582: move MMIO devices under soc node
      ARM: dts: mediatek: mt6582: sort nodes and properties
      ARM: dts: mediatek: mt6582: remove compatible property from root node
      ARM: dts: mediatek: mt6582: add mt6582 compatible to timer
      ARM: dts: mediatek: mt6582: add clock-names property to uart nodes
      ARM: dts: mediatek: mt6582: add enable-method property to cpus
      dt-bindings: arm: mediatek: Add MT6582 yarisxl
      ARM: dts: mediatek: add basic support for Alcatel yarisxl board

 .../devicetree/bindings/arm/mediatek.yaml          |   1 +
 arch/arm/boot/dts/mediatek/Makefile                |   1 +
 .../boot/dts/mediatek/mt6582-alcatel-yarisxl.dts   |  61 +++++++++
 arch/arm/boot/dts/mediatek/mt6582.dtsi             | 142 +++++++++++----------
 arch/arm/mach-mediatek/Kconfig                     |   4 +
 arch/arm/mach-mediatek/mediatek.c                  |   1 +
 arch/arm/mach-mediatek/platsmp.c                   |   1 +
 7 files changed, 142 insertions(+), 69 deletions(-)
---
base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
change-id: 20250920-mt6582-9339d7fceb34

Best regards,
-- 
Cristian Cozzolino <cristian_ci@protonmail.com>



