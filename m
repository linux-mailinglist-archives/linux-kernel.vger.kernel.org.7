Return-Path: <linux-kernel+bounces-858122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B11DBE90FC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD63019A4CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0836996C;
	Fri, 17 Oct 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahHXrnoS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242A3570C8;
	Fri, 17 Oct 2025 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709090; cv=none; b=TReIXtkV+3xsYQrTeHUmRA6TA7MRrWW2kxfE9SeLMrji+r066DlEid8AyIyeq+r8EgsqjQDNZqcca9fSDRGIoh0G3r7psDhnKxhAmRmOxAwigwrmUKZ2aLMGCUjjFK5gROOljNqyXVxB2yK53I02hAt/At7uga7/BoZKvakAEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709090; c=relaxed/simple;
	bh=gV7eznlDj3fQJt34KPs+aNCRbI0Wc21YzA0aXkfJlHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZueH15P/Fc0uop7vFyW5vSxXFL/BCfSIaiHP6AO7xF26NDKCr19KU9cvDSJ6xA9CY8PGnynT3y9iGaHticE68wX3JELUPrbueLESi78iSl/bhOZb89Je39w2XyHdXx9UC/9MBO1l4fMuocX9RjTQi05JO2c5SCv6hAqvCQiVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahHXrnoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772FEC4CEE7;
	Fri, 17 Oct 2025 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760709089;
	bh=gV7eznlDj3fQJt34KPs+aNCRbI0Wc21YzA0aXkfJlHA=;
	h=From:To:Cc:Subject:Date:From;
	b=ahHXrnoSlHByNTzVCDZi2+lVU4PxrOCF6kJhkn42gdcT+A31a8zGDHDfPrcNSkk6O
	 HqcO7g1pH8EDT13MtkGgkwaV3/8brte2L12cEHTuYo1iD4DQ41ft3f1o0nBA4qbIF3
	 hVsq2h6dZPP1W1NVL9GWLAen7VyVnVffvSDfHy6VYvKkR6bWO+MFD5351mx+8ItlsD
	 o1WTRO4t46qDKP5v6FtizmtlbOWEq08cJ3cRhb6nYxmUZTZTr+BTQMaZkeZdS6tsnC
	 CRm99FQRZvu2cFeQs7KCuZVlONvyG0cMTcYLISkGUVU1mQCvBzXPC0O+CcP1LEi3oI
	 zJiuKVNp09EMA==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v3 0/3] Initial Kontron SMARC-sAM67 support
Date: Fri, 17 Oct 2025 15:50:43 +0200
Message-ID: <20251017135116.548236-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains the remaining (device tree) patches for the
Kontron SMARC-sAM67 module.

v3:
 - dropped all patches which were already applied
 - add 'bootph-all' to the usb ctrl node to support DFU boot
 - as all MFD bits are now merged, combine the patch which added the
   system controller node into the main one again
 - drop duplicate RTC node. This one was a left over before the rtc
   node moved into it's own overlay
 - add a new overlay for the Kontron SMARC 2.2 evaluation carrier
 - add a new SMARC gpio overlay to configure the pinmux correct.
   This is not integrated into the default device tree because it
   will conflict with any device tree which will use the pins for
   different purposes (they are multi function pins)

v2:
 - dropped patches which were already picked up
 - new patch "dt-bindings: mfd: tps6594: allow gpio-line-names"
 - separate driver for the hwmon, add missing hwmon documentation,
   thanks Guenter
 - split the DT as suggested by the SoC maintainers
 - add missing copyright and license to the overlays, thanks Andrew

Michael Walle (3):
  dt-bindings: arm: ti: Add Kontron SMARC-sAM67 module
  arm64: dts: ti: Add support for Kontron SMARC-sAM67
  arm64: dts: ti: sa67: add overlay for the ADS2 carrier

 .../devicetree/bindings/arm/ti/k3.yaml        |    1 +
 arch/arm64/boot/dts/ti/Makefile               |   10 +
 .../dts/ti/k3-am67a-kontron-sa67-ads2.dtso    |  146 +++
 .../dts/ti/k3-am67a-kontron-sa67-base.dts     | 1091 +++++++++++++++++
 .../dts/ti/k3-am67a-kontron-sa67-gbe1.dtso    |   26 +
 .../dts/ti/k3-am67a-kontron-sa67-gpios.dtso   |   61 +
 .../ti/k3-am67a-kontron-sa67-rtc-rv8263.dtso  |   31 +
 7 files changed, 1366 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-ads2.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-gbe1.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-gpios.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-rtc-rv8263.dtso

-- 
2.47.3


