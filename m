Return-Path: <linux-kernel+bounces-801660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F189B44878
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672401C86910
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114822BF3F3;
	Thu,  4 Sep 2025 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hji1Dl0C"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74CE267733;
	Thu,  4 Sep 2025 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021317; cv=none; b=U6AoljRW2lFo5iRFWQKOBmxNb1NNlCK4MOEygBCovZCdAVuho0tHgrXEmQAsmz8uhz5amqs6nSDjvzBj6Lri82+V+kaTJ7NTvDiu6LnUp+udA7v4y2HtxZ4ywdhP4fUQbgMmciIHqFSHg0wIu/Y5DD+6kJkeZeAKjTM+0McD/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021317; c=relaxed/simple;
	bh=9o66Awt/mPree1eZlyfQvs6/0Bf5OjFdBAbQNVvaLKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WA2g1myjLV6lcisf717JYlx1hsPjALepquZuveQ5v6GtLYnK5aYKBDvtUpCa2KWm79Xpn0QbwBYZEwfs+yRtKBRhPNAt5bpSMvGgJNvXoIZ21sCobGBe4ZoOSb5j/5WZfBdmOjdHtaLCItkGOvujR/3NpyeAwaMq7tAf7BQrdCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Hji1Dl0C; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584LSUHv3603630;
	Thu, 4 Sep 2025 16:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757021310;
	bh=xdEUUeRhDvZUmqzLma+RUB4tbwLO4rgKjOTXQim98rM=;
	h=From:To:CC:Subject:Date;
	b=Hji1Dl0CIUe0DA6IZnqGJ63BgO4TOWYXyyNJoOtLy72CtK//roniuVPUz4IpsY1yf
	 aS+CwKNRH0UJmC2kgHbFtNT0LExWlmGVojULS5lZGBg6evYbxsTRNcYCroUXeIN3aU
	 VSx96isudiXGZIm23NMKqSTK4fx3fVXKdlGAy16M=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584LSU6r449422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 16:28:30 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 16:28:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 16:28:29 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584LSTnN3903903;
	Thu, 4 Sep 2025 16:28:29 -0500
From: Kendall Willis <k-willis@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
        <k-willis@ti.com>
Subject: [PATCH 0/3] arm64: dts: ti: k3-am62: Support Main UART wakeup
Date: Thu, 4 Sep 2025 16:28:24 -0500
Message-ID: <20250904212827.3730314-1-k-willis@ti.com>
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

This series adds wakeup support for the Main UART in the device tree of
the TI AM62 family of devices. It defines the specific pins and pinctrl
states needed to wakeup the system from the Main UART via I/O
daisy-chaining. The wakeup-source property is configured to describe the
low power modes the system can wakeup from using the Main UART.

Dependencies
------------
This series is dependent on the following series [1] to be merged into
the kernel. The series adds the system idle states that are available on
the SoCs. The system idle states are used when configuring the
wakeup-source property.

This series is also dependent on the following patch [2] to be merged
into the kernel. The patch integrates the PIN_WKUP_EN macro which
enables the WKUP_EN bit.

Implementation
--------------
This series is intended to be implemented along with the following
series:

1. "pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl
   wakeup state": Patch which skips setting constraints for wakeup sources
   that use pinctrl state 'wakeup'.

2. "serial: 8250: omap: Add wakeup support": Implements
   wakeup from the UARTs for TI K3 SoCs

3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": (this series)
   implements the functionality to wakeup the system from the Main UART

Testing
-------
Tested on a SK-AM62B-P1 board with all series and dependencies
implemented. Suspend/resume verified with the Main UART wakeup source
by entering a keypress on the console.

[1] https://lore.kernel.org/linux-arm-kernel/20250812-topic-am62-dt-partialio-v6-15-v2-2-25352364a0ac@baylibre.com/
[2] https://lore.kernel.org/all/20250904112538.529857-4-a-kaur@ti.com/

Kendall Willis (3):
  arm64: dts: ti: k3-am62x-sk-common: Enable Main UART wakeup
  arm64: dts: ti: k3-am62a7-sk: Enable Main UART wakeup
  arm64: dts: ti: k3-am62p5-sk: Enable Main UART wakeup

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 24 +++++++++++++++----
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       | 24 +++++++++++++++----
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 +++++++++++++++----
 3 files changed, 60 insertions(+), 12 deletions(-)


base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
-- 
2.34.1


