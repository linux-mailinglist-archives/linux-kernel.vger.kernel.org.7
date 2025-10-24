Return-Path: <linux-kernel+bounces-868387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C36C05179
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC32420FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0FF3064A6;
	Fri, 24 Oct 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MQtolijM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED6306B00;
	Fri, 24 Oct 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294794; cv=none; b=gwISDru9JYTdGzmZjHMnjBACnJAAsKIny11ndpi17IAbgRZVSJ3K9rXCB0ZbjNfQdObHMkYpV4Z32nsq+h1MHpWVceTCJYfZN7VW4uHPQupeEb28JH8AkXEDuX0Md/esB3hzVuZT5gbOenuOs6XxIdUMnl4ZHWgRiSyU2WCIACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294794; c=relaxed/simple;
	bh=vOWEWKdi3bjK7LjRlKsISvl3DrortAGk12XkW77HR2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKQOuK+4bxAR+c5DYieTOmJZ0/Ws83BkDIwu9VizBpJ/VZn3UdW6eq54euq6RonJmCJw9eljM29xX74Ia5I/R82A4gZiY7Z+6H0tmTIhKZX53/6foTSYkGacK+U5+I5PDqYgHS/WYywnfXZHBnc1cg6lLUQ1bahXjeWkNUV66hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MQtolijM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761294790;
	bh=vOWEWKdi3bjK7LjRlKsISvl3DrortAGk12XkW77HR2I=;
	h=From:To:Cc:Subject:Date:From;
	b=MQtolijM30FxuWvoBD+kf27lrR8xCebGpeYNnqaFJo4qyFxQYikFsp4DUCGVCR7UX
	 YTBmSS74ztjJSgIiYpCR86uiVd5UZSGS1bZcrCeCUYa435yvipynsOIOrI+pdJmD+2
	 +8gFfEcqNFGkJaoySPOGrwYaNONUXZ1ucMA9uP6/LTbP6Kof1JJHShaPWLZ49rXOOy
	 aiueRpvKrPs0u84C0zy+Pmz0juqAXKFhi1OnOURxSHuhzMYUL9E4LNVG92I7bSEsjt
	 bw703QbAh+uscn1yy+U2ZZyZeRyq3o32sQAsVis98wt4FmSnYDD+mNoeBFizG/Q7jE
	 eyNcOqmhpKQFg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7DE4917E00A6;
	Fri, 24 Oct 2025 10:33:09 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: mturquette@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	laura.nao@collabora.com,
	nfraprado@collabora.com,
	wenst@chromium.org,
	y.oudjana@protonmail.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 0/7] clk: mediatek: Add support for SPMI Clock Controllers
Date: Fri, 24 Oct 2025 10:32:54 +0200
Message-ID: <20251024083301.25845-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some new PMICs, Clock IC and combos are complex SPMI 2.0 devices that
contain multiple IPs, including clock controllers.

This series expands the MediaTek clock helpers to allow registering
clock controllers over SPMI, and adds a clock driver for the MT6685
SCK_TOP clock controller.

For now, only gate clocks are supported to reduce the complexity of
this change.

NOTE: This series depends on series [1] "SPMI: Implement sub-devices
and migrate drivers"

[1]: https://lore.kernel.org/all/20251021083219.17382-1-angelogioacchino.delregno@collabora.com

AngeloGioacchino Del Regno (7):
  clk: mediatek: Split out registration from mtk_clk_register_gates()
  clk: mediatek: clk-gate: Simplify and optimize registration iter
  clk: mediatek: clk-mtk: Split and rename __mtk_clk_simple_probe()
  clk: mediatek: Add and wire up mtk_spmi_clk_register_gates()
  clk: mediatek: Add support to register SPMI Clock Controllers
  dt-bindings: clock: Describe MT6685 PM/Clock IC Clock Controller
  clk: mediatek: Add support for MT6685 PM/Clock IC Clock Controller

 .../bindings/clock/mediatek,mt6685-clock.yaml | 37 ++++++++++
 drivers/clk/mediatek/Kconfig                  | 15 ++++
 drivers/clk/mediatek/Makefile                 |  7 +-
 drivers/clk/mediatek/clk-gate.c               | 70 ++++++++++++-------
 drivers/clk/mediatek/clk-gate.h               |  6 ++
 drivers/clk/mediatek/clk-mt6685.c             | 70 +++++++++++++++++++
 drivers/clk/mediatek/clk-mtk-spmi.c           | 62 ++++++++++++++++
 drivers/clk/mediatek/clk-mtk-spmi.h           | 31 ++++++++
 drivers/clk/mediatek/clk-mtk.c                | 66 ++++++++++++-----
 drivers/clk/mediatek/clk-mtk.h                |  5 ++
 .../dt-bindings/clock/mediatek,mt6685-clock.h | 17 +++++
 11 files changed, 339 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt6685.c
 create mode 100644 drivers/clk/mediatek/clk-mtk-spmi.c
 create mode 100644 drivers/clk/mediatek/clk-mtk-spmi.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6685-clock.h

-- 
2.51.1


