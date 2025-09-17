Return-Path: <linux-kernel+bounces-820277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DABB7D85A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BB417F9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E830C627;
	Wed, 17 Sep 2025 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sEGcmwfA"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D73093B8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099032; cv=none; b=f3UrDKmnPxiJZvuMfokXF5FS+gCiZK603EYY1G2L1jE7bpMntWpknaS/DGdc9kek73MyH5E5/FN6GX4+P+3ycutlgqPV1WfTN8Bp+EXWi39XnEBb+hHvOZX0VvEGnkEdCKl4kTR0A9sEasAE33e4E1QPmNxWIZfsttAnxuSEVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099032; c=relaxed/simple;
	bh=z1nm0FAZYHzy4E6g37WZRmFclBdm64JpzQ+XuSub9bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=go+u6yptjI/tS1OF+YaCzp8JEM9o0K9lsUmROeof6QJGoaC4E7El91c+Had9zpgfemNgxrQALP0fya1d8W4hEMXFPOhvjFZkZkwYUtFEUjZgbqTZIoQaNl64bcyZGQ9Iz8GKzibjJF7826vbuD4M7m01rtUQh2WbzYL6pYKgODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sEGcmwfA; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250917085022epoutp0234308e24ff1bb0f116e90ef1bc703499~mBb7y-qcU1711917119epoutp02S
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:50:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250917085022epoutp0234308e24ff1bb0f116e90ef1bc703499~mBb7y-qcU1711917119epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758099022;
	bh=I363QpdwZwlQ876BU+P+93B+lnskOUgFb5tXAEx5RNw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=sEGcmwfA6jVfUJOfPtZxEVLoszekoks9GAE8GmYi3SK6Hh87aypt4EEtC0/poJ+UX
	 RjLqpbSK4iQ2DJVSU62eYwvJti3rvHn7qOQLA8DGixIMahLSVI9QU6xiYk8SvyKeXv
	 +OPULuymE4H2VngVk9z001PIWnKXLTpmE11KG9yw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250917085021epcas5p3d9f0d62fc1b2f731987f9f536db532e2~mBb7ApQ6k1728417284epcas5p3m;
	Wed, 17 Sep 2025 08:50:21 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cRXXX23DGz2SSKZ; Wed, 17 Sep
	2025 08:50:20 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250917085019epcas5p273ef86028a90e78ada55cde48a28a949~mBb5Yf87f0421204212epcas5p2C;
	Wed, 17 Sep 2025 08:50:19 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250917085014epsmtip207bf6dd995b78fd7dac7ff0a0048bffd~mBb0pofzE2764627646epsmtip2M;
	Wed, 17 Sep 2025 08:50:14 +0000 (GMT)
From: Ravi Patel <ravi.patel@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jesper.nilsson@axis.com, lars.persson@axis.com, mturquette@baylibre.com,
	sboyd@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com,
	cw00.choi@samsung.com
Cc: ravi.patel@samsung.com, ksk4725@coasia.com, smn1196@coasia.com,
	linux-arm-kernel@axis.com, krzk@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	pjsin865@coasia.com, gwk1013@coasia.com, bread@coasia.com,
	jspark@coasia.com, limjh0823@coasia.com, lightwise@coasia.com,
	hgkim05@coasia.com, mingyoungbo@coasia.com, shradha.t@samsung.com,
	swathi.ks@samsung.com, kenkim@coasia.com
Subject: [PATCH 0/7] Add support for the Axis ARTPEC-9 SoC
Date: Wed, 17 Sep 2025 14:19:57 +0530
Message-ID: <20250917085005.89819-1-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917085019epcas5p273ef86028a90e78ada55cde48a28a949
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917085019epcas5p273ef86028a90e78ada55cde48a28a949
References: <CGME20250917085019epcas5p273ef86028a90e78ada55cde48a28a949@epcas5p2.samsung.com>

Add basic support for the Axis ARTPEC-9 SoC which contains
6-core Cortex-A55 CPU and other several IPs. This SoC is an
Axis-designed chipset used in surveillance camera products.

This ARTPEC-9 SoC has a variety of Samsung-specific IP blocks and
Axis-specific IP blocks and SoC is manufactured by Samsung Foundry.

This patch series includes below changes:
- CMU (Clock Management Unit) driver and its bindings (patch #1 to #3)
- PMU bindings (patch #4)
- Basic Device Tree for ARTPEC-9 SoC and boards (patch #5 to #7)

The patch series has been tested on the ARTPEC-9 EVB with
Linux Samsung SoC tree (for-next branch) and intended
to be merged via the `arm-soc` tree.

NOTE: This patch series is dependent on following floating patches:
1. https://lore.kernel.org/all/20250917070004.87872-1-ravi.patel@samsung.com/T/#t
2. https://lore.kernel.org/all/20250917071342.5637-1-ravi.patel@samsung.com/T/#u
3. https://lore.kernel.org/all/20250917071311.1404-1-ravi.patel@samsung.com/T/#u

GyoungBo Min (3):
  dt-bindings: clock: Add ARTPEC-9 clock controller
  clk: samsung: Add clock PLL support for ARTPEC-9 SoC
  clk: samsung: artpec-9: Add initial clock support for ARTPEC-9 SoC

Ravi Patel (2):
  dt-bindings: arm: axis: Add ARTPEC-9 alfred board
  arm64: dts: axis: Add ARTPEC-9 Alfred board support

SungMin Park (2):
  dt-bindings: samsung: exynos-pmu: Add compatible for ARTPEC-9 SoC
  arm64: dts: exynos: axis: Add initial ARTPEC-9 SoC support

 .../devicetree/bindings/arm/axis.yaml         |    6 +
 .../bindings/clock/axis,artpec9-clock.yaml    |  232 ++++
 .../bindings/soc/samsung/exynos-pmu.yaml      |    1 +
 arch/arm64/boot/dts/exynos/axis/Makefile      |    3 +-
 .../boot/dts/exynos/axis/artpec9-alfred.dts   |   36 +
 .../boot/dts/exynos/axis/artpec9-pinctrl.dtsi |  115 ++
 arch/arm64/boot/dts/exynos/axis/artpec9.dtsi  |  277 ++++
 drivers/clk/samsung/Makefile                  |    1 +
 drivers/clk/samsung/clk-artpec9.c             | 1224 +++++++++++++++++
 drivers/clk/samsung/clk-pll.c                 |  184 ++-
 drivers/clk/samsung/clk-pll.h                 |   17 +
 include/dt-bindings/clock/axis,artpec9-clk.h  |  195 +++
 12 files changed, 2282 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/axis,artpec9-clock.yaml
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec9-alfred.dts
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec9-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec9.dtsi
 create mode 100644 drivers/clk/samsung/clk-artpec9.c
 create mode 100644 include/dt-bindings/clock/axis,artpec9-clk.h

--
2.17.1


