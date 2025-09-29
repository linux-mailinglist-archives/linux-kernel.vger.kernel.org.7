Return-Path: <linux-kernel+bounces-836274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 088A5BA92B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21083AC804
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10367304BB4;
	Mon, 29 Sep 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="i+u4pbLQ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6852BEC55;
	Mon, 29 Sep 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148045; cv=pass; b=tpBvrtDuhdoC+Cvy8To1eAzrkkEFTqvyvKcxgLEIG+7y1Z4pCKOEE1yaTJtBHfdR3IOrcXcWA9hza3iRvVwgh0HPtq4C1vA+ZyzKo5olSVxYy887gajaBl0zPUJQ6hWD7h6UBdLzVPmTxfgFo+wkoo7nagzUgQoGTQZFxquRctI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148045; c=relaxed/simple;
	bh=AzB3xqZbFmCbEC/d+P6cEGogfEPVZA8utIJRfEDrFko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dfvFluLrsHFOJnG4CY8D0CHsIWcwgRO0dIYouGQVgNH509+moqvsvDEgPrSBSa5FO/l9Cj//BUcsjKLNdAtJFBubDOh0Bds8/ChibCdaE99LhrapRXFMigq33A/wNYR94TV4H9IxtN00j1qDIM4Kw+eGA7T7BcnzeGUhpD/m8BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=i+u4pbLQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759148024; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OPRvw2SuOTlPCN4iRCgazJ6iZVAlqLpU31kCPzPkWjpIeyD5k7BRbqeWm0DUGPNuKV7q6nojSF+PS6XeKo+KBep8CmFq9gzg61wPBEe8JPi+YyCSGv9h8UMBzD3BXt5c/vmTBqZydfuEEsQXI+HqVBkU2+5hQm3lTPckdtWXOpw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759148024; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HwAyrfJ+V4TSwmK/GgziWOx7QhcaPkNR2KkH4uHRG+s=; 
	b=neGYy6YgC4TDXDaeBcprVqAqGRChKkLD6nJ3hnJKhGg31s7OUja+G72+RC4WxCipeMHWZWOQ1S2lqNywWabzkUxMW5xumSF4/M+hXHH1/KX64Id2UiQu4r5Bw2bE5kY/nf38kV7yLyDU+jsnAyQZHvaMJJC+eb0cmhI0iRtEreI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759148024;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=HwAyrfJ+V4TSwmK/GgziWOx7QhcaPkNR2KkH4uHRG+s=;
	b=i+u4pbLQZ961vYBzWtan6sX2DrD0VeHkM0TJaWNHGxbpn9tK07SONW9ikKLYLSCb
	ytOvyHMB8SLvlTodju2opQ+3Nxpfe0vcD/RGqiJT4SldQdn2PkgS+n504gw97znD42C
	J5KZc2/EaEOVPUFiEGXrFcvgv0W5D1io81gANa0I=
Received: by mx.zohomail.com with SMTPS id 1759148023555626.6296011238145;
	Mon, 29 Sep 2025 05:13:43 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/4] MediaTek Runtime Power Management Clocks for PLL
Date: Mon, 29 Sep 2025 14:13:19 +0200
Message-Id: <20250929-mtk-pll-rpm-v1-0-49541777878d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN932mgC/y3MQQqDMBCF4auEWXcgCVQar1JcqBnboSamk1gE8
 e4Ntcv/wft2yCRMGVq1g9CHMy+xhrkoGJ99fBCyrw1W26t21mEoL0zzjJICDpO9GWe916aB+kh
 CE28/7d6dLfReK1rOEYY+E45LCFxaFWkr+Icb6I7jC9OcVxiOAAAA
X-Change-ID: 20250929-mtk-pll-rpm-bf28192dd016
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Guangjie Song <guangjie.song@mediatek.com>, 
 Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>
Cc: kernel@collabora.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

This series refactors all users of mtk-pll, just so we can enable
runtime power management. This will then allow us to have clock
controllers that depend on other clocks to be on for their control
registers to be functional.

The final use is to add this sort of relationship to the MT8196 mfgpll
clocks, which all need the CLK_TOP_MFG_EB to be on before their control
registers can even be read.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (4):
      dt-bindings: clock: mediatek: Add clocks for MT8196 mfgpll
      clk: mediatek: Refactor pll registration to pass device
      clk: mediatek: Pass device to clk_hw_register for PLLs
      clk: mediatek: Add rpm clocks to clk-mt8196-mfg

 .../bindings/clock/mediatek,mt8196-sys-clock.yaml  |  28 ++++++
 drivers/clk/mediatek/clk-mt2701.c                  |   2 +-
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c       |   2 +-
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c       |   4 +-
 drivers/clk/mediatek/clk-mt6765.c                  |   2 +-
 drivers/clk/mediatek/clk-mt6779.c                  |   2 +-
 drivers/clk/mediatek/clk-mt6797.c                  |   2 +-
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c       |   2 +-
 drivers/clk/mediatek/clk-mt7629.c                  |   2 +-
 drivers/clk/mediatek/clk-mt7981-apmixed.c          |   2 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c          |   2 +-
 drivers/clk/mediatek/clk-mt7988-apmixed.c          |   2 +-
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c       |   3 +-
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c       |   2 +-
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c       |   2 +-
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c       |   2 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c       |   3 +-
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c       |   3 +-
 drivers/clk/mediatek/clk-mt8196-mcu.c              |   2 +-
 drivers/clk/mediatek/clk-mt8196-mfg.c              | 104 +++++++++++++++++----
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c         |   2 +-
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c       |   2 +-
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c       |   2 +-
 drivers/clk/mediatek/clk-pll.c                     |  16 ++--
 drivers/clk/mediatek/clk-pll.h                     |  12 ++-
 drivers/clk/mediatek/clk-pllfh.c                   |   2 +-
 26 files changed, 157 insertions(+), 52 deletions(-)
---
base-commit: 905612298ef4f5fa9f85fbc6825af224f40af70f
change-id: 20250929-mtk-pll-rpm-bf28192dd016

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


