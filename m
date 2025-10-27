Return-Path: <linux-kernel+bounces-871385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C959C0D1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CEC402A26
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE6E2FBDEA;
	Mon, 27 Oct 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I7YEEMNd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E412FB098;
	Mon, 27 Oct 2025 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563630; cv=none; b=FQrJbQI2H93hmfaWiO3/NC2V0RShpfEXCcFmbxdDnkc+3L6N8vJDk51m5hORP/b4d+mMWqqPC5Ndv11/UiDaONg9cG/CNZ2wb+2m7yjZ/KLp+2lqQJsaRMiR7+Rf0Bsi/TSXvhyOaan+v8vFjioF+U9tNC4ryAVax84Gn+JZGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563630; c=relaxed/simple;
	bh=1FmWkgn1cw8Kk0c9UURvXKaVtFGzcFCFQwq2r0o0m5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPjucboEvHuiHAiPcKZyydawV/hvOEfhEIZgeCNAGLJD0kQ+3uZ0e0l7sFRl/zKPgYVnc0fppg2WdBPMucHg+I3gbWv098h8gcU89UCsG/2yhl+/aQeNem8d8D5STtxleMn9TCJ8AgvDXva7tsSvF8z7qMtlOVCFcoWRe5EjRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I7YEEMNd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761563626;
	bh=1FmWkgn1cw8Kk0c9UURvXKaVtFGzcFCFQwq2r0o0m5U=;
	h=From:To:Cc:Subject:Date:From;
	b=I7YEEMNdqMjwOqcWs+rHHHUxdtCWl6yZ2KXOFJKPsupG2tZWPdkztXTti5bKn5lFK
	 dfLfCYmUcLqcquwHGXxpsWECbQOli/Bo2nrycX9xO4rdYkequF1nbgN4UuMeg6RzUu
	 9MIyl5xwKnOZwEF9PDIiTfpceLRnsGHhOgVj+VIZIuZUeLcX2UdX28R/ufo9mxxT9w
	 tvMs81/2tbWHHHxwrNVuwMDtLkf60ZwuwwgCHZYoRuR2UvBMAHK0PJt3DQ/Ci0iyRz
	 vCnQYnmn47Ha0iG7ZGJZpJTmLFe9dQw22NlpuXmTmx3oa7RhiwCbUjZjilqQqpmBzc
	 GxYo2Gb5tonVA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 71FDF17E1276;
	Mon, 27 Oct 2025 12:13:45 +0100 (CET)
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
Subject: [PATCH v2 0/7] clk: mediatek: Add support for SPMI Clock Controllers
Date: Mon, 27 Oct 2025 12:13:36 +0100
Message-ID: <20251027111343.21723-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Fixed description in mediatek,mt6685-clock.yaml

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

 .../bindings/clock/mediatek,mt6685-clock.yaml | 36 ++++++++++
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
 11 files changed, 338 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt6685.c
 create mode 100644 drivers/clk/mediatek/clk-mtk-spmi.c
 create mode 100644 drivers/clk/mediatek/clk-mtk-spmi.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6685-clock.h

-- 
2.51.1


