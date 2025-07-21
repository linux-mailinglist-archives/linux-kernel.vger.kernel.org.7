Return-Path: <linux-kernel+bounces-739033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F932B0C0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEF34E1259
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FBC28D8D9;
	Mon, 21 Jul 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="1XbQZC15"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA428C851;
	Mon, 21 Jul 2025 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092518; cv=none; b=pvUOLoD2ACgOGGYV56aVjYJ+C83vztoS9uo1RlYgsTKY3e7Q0wkoZyFQeuwP4fzkWy0XWSHXnJfKP/T1q8M6/InHcVksnJI87VnoIFuRU101KiS8fBdRUuml8N1dznc3DBaYAx2zJb65FqickQVhIQ7w+SFgU2QQQJ2zX+szpGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092518; c=relaxed/simple;
	bh=rMzb3d5qtjFKfc/bGqjqPlJqlTMcEsjCcMdBwBiNQqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6bbkpRe1Q3OYD7tBHgbufWxLA4E3Or/rsxzYXmehbyhBUVHH21p3WPFTZGrF35Xd1aDwkcuL/NTCoWmA27rQYsvIb8enF6CKqDq6PHbBkcjtSlTKN6YXaCPvOcpuHp7tAyJJ7DwfVjmc5GlZRvlT5nfmdC922jkM2lSvgWTHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=1XbQZC15; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6E40C75F8;
	Mon, 21 Jul 2025 12:08:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092506; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=4wQsUSF34x7aot1sElNjzy3g37v/3VUcwunuzv0HHdc=;
	b=1XbQZC15gvy/KqcMus1Nt1rlueqbgzD8Ds2iHTBPWAh5j6pYh+24xqpNd2YTlERkhvr+nX
	MhIKVOulkPRHychu6uiXA+WoyAhb3agZUGtqeqHeldPEKodK5DaTXICN2Gdu6JHZxxaGu0
	4rj/Gp60AlcRp4SIghFi0/DZ94TkLXHMo/nwJhHR4x70lQ5hdII1RDVC2KxgqK670E70UL
	s4XhuWZxBFE0mnzc9RJL97Rwz+IF/sfVzdA5okmxpIS2XMWCsPkvZ5NET2T6RTnK8hBWM1
	H2lL64E9x8DuSzyuabAlHy1xK0yrWpm25inlnt3kjkwGWtY0ypR7znD4Swi87g==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andrej Picej <andrej.picej@norik.com>,
	Annette Kobou <annette.kobou@kontron.de>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Oualid Derouiche <oualid.derouiche@kontron.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Teresa Remmet <t.remmet@phytec.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 00/12] Misc fixups and changes for Kontron i.MX8M and i.MX93 DTs
Date: Mon, 21 Jul 2025 12:05:34 +0200
Message-ID: <20250721100701.115548-1-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This is a collection of changes for several Kontron ARM64
board devicetrees. Some are related to hardware changes,
some are bugfixes and some are improvements.

Changes for v2:
* fix touchscreen node name
* add touchscreen labels
* fix commit message for RTC interrupt patch

Annette Kobou (3):
  arm64: dts: imx8mm-kontron: Add overlay for LTE extension board
  arm64: dts: imx8mp-kontron: Fix CAN_ADDR0 and CAN_ADDR1 GPIOs
  arm64: dts: imx93-kontron: Fix GPIO for panel regulator

Eberhard Stoll (1):
  arm64: dts: imx8mm-kontron: Use GPIO for RS485 transceiver control

Frieder Schrempf (7):
  arm64: dts: imx8mm-kontron: Remove unused regulator
  arm64: dts: imx8mm-kontron: Sort reg nodes alphabetically
  arm64: dts: imx8mm-kontron: Name USB regulators according to OSM
    scheme
  arm64: dts: imx8mp-kontron: Fix GPIO labels for latest BL board
  arm64: dts: imx8mp-kontron: Fix USB hub reset
  arm64: dts: imx93-kontron: Add RTC interrupt signal
  arm64: dts: imx93-kontron: Fix USB port assignment

Oualid Derouiche (1):
  arm64: dts: imx8mm-kontron: Add Sitronix touch controller in DL
    devicetree

 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx8mm-kontron-bl-lte.dtso  | 186 ++++++++++++++++++
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts |   8 -
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  |  12 +-
 .../boot/dts/freescale/imx8mm-kontron-dl.dtso |  13 +-
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   |  50 ++---
 .../dts/freescale/imx8mp-kontron-bl-osm-s.dts |  59 +++---
 .../dts/freescale/imx93-kontron-bl-osm-s.dts  |  32 +--
 .../dts/freescale/imx93-kontron-osm-s.dtsi    |   9 +
 9 files changed, 301 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-lte.dtso

-- 
2.50.1


