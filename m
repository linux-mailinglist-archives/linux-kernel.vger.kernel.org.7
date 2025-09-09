Return-Path: <linux-kernel+bounces-807449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE7B4A474
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BC6170632
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0AD243964;
	Tue,  9 Sep 2025 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wocPUBNw"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3018A93F;
	Tue,  9 Sep 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405029; cv=none; b=h/jzLYJz/glwEA5huVgXgDUkuakmCsMHWmxC4cHRKq6ZDQSJa7FHe0qcfUcGWlyguoPbWxB9PzRBfM/03hyItIaOOfYqL61FULAbsdzf1XoLFQzgFj+ZPQ+ZvZlYmGYxT76WOMSpbnSLdclk2VJ9UVbaz7+rsvW/VTXDrrsXtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405029; c=relaxed/simple;
	bh=GwBL4OSldz1mc/kSQ26ot5so+nXz0xWQwxecOCuQ4bk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UayOxYr2NUaJP1vwxBNCdRf9EABt2ikwgCXlMu0D7oQLYYL2VpyAn2Jnc1JrLTkjHn4bEut8lvcE7djXW8te7zISwKJerbWYYWTnsMHzqch7pyL/AXCTszvqvEQRTR5NkCNCgMqhN9urrHGU/jHlJCXOjyBODB0dS4buHnHFG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wocPUBNw; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58983iVt242434;
	Tue, 9 Sep 2025 03:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757405024;
	bh=7lh7OfPDXMwcHN8i7gG57s6FPcVnez/AMDdCGNtKoIM=;
	h=From:To:CC:Subject:Date;
	b=wocPUBNwPvY3/sdfu2lM//P68fCngUDDCDPJue0cN6TlPHYMhsCEAKBqZZ03EXoWf
	 FMGX64CcM6oIctosTR2MEs2lwcstM02AZ2zEPNb5a6vGKPfpyCZ9kUGBnwO0EwpAc4
	 Xo5Et0Xshr2m+HjCw3umAQoD0Yu06Xf3RKsX46J0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58983iKi3627732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 03:03:44 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 03:03:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 03:03:43 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.150])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58980nwc2009791;
	Tue, 9 Sep 2025 03:00:50 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <j-keerthy@ti.com>, <vigneshr@ti.com>, <wbg@kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <g-praveen@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 0/2] Capture driver support for OMAP DM timer
Date: Tue, 9 Sep 2025 13:30:40 +0530
Message-ID: <20250909080042.36127-1-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

DM timer hardware supports capture feature.It can be used
to timestamp events (falling/rising edges) detected on input signal.

The timer IO pin can also be configured in PWM mode but this
driver supports simple independent capture functionality.

Dependency: 
https://lore.kernel.org/all/f0d72eac-f842-4060-b197-ced20048b34b@linaro.org/

Gokul Praveen (3):
  dt-bindings: counter: Add new ti,omap-dmtimer-cap compatible
  counter: ti-dmtimer-cap : capture driver support for OMAP DM timer
  Enable required config for OMAP DM timer capture driver on J784S4 SOC.

 .../bindings/counter/ti,omap-dmtimer-cap.yaml |  34 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/counter/Kconfig                       |  13 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-dmtimer-cap.c              | 455 ++++++++++++++++++
 5 files changed, 504 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti,omap-dmtimer-cap.yaml
 create mode 100644 drivers/counter/ti-dmtimer-cap.c

-- 
2.34.1


