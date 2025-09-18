Return-Path: <linux-kernel+bounces-822458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935DB83EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9651C01C90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514B12E3B07;
	Thu, 18 Sep 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vvGNU6UR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23047280A5A;
	Thu, 18 Sep 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189318; cv=none; b=MEvxk0/FJuoXRUk22iBtfZgQUja8nD7XnTFSFf53P/tzcf40MRLaC7EbKvtRsXCw7muGRG6J8qGCRkzfaE3yCK1OO7AcMYnJT6pjW9Mb+0304UqZXv2vAaZ2rnLr+byPfRxr3GtBcGD8sHN22edVP5XvpruxWjyabSZHFR1Qnf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189318; c=relaxed/simple;
	bh=VdrOjdmxeHHCeR4/FygVKubJGgZX78g1iZug45KwOkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E39SpTWQ0bbBCR05HQmCm961j1HXaJ52dnEuBVvJyMGVIxavla+H8qX9/eV7mAdL3ExBpVwbzDU+19ASJRVvZyvFDxFhzcbZF/3ZJ73mpxmh0lyktNvaPnYZ1hjWwlaO+Qq/rsLTEcT/1Ehh56YlFSVsvmZjmNSFRJun3Hgol1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vvGNU6UR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758189317; x=1789725317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VdrOjdmxeHHCeR4/FygVKubJGgZX78g1iZug45KwOkc=;
  b=vvGNU6URYF1pKBm6KWgm6C8IGl32ux6SocmBrioLL/+HgUHVbUmr6vQT
   1SXR9MJaz6Gmt+KJrMaCGMVaRxuTQHgwfRlSZvd4yP5pOqaVcIA21oPGE
   x1yOCH5oIO7YXWV+wU6eT9tVX/PPW0wXIlF1BXFxNCDt7U8n9txaRTMYx
   EdJTanzyTUQg7tFypOSIzU8lxlHpwlGnHxoSureNIi1h7yq/KKvrAWWas
   AUPGmKcRFdJ/PsMNAef5LgtgaIiPvJ/HRQEet9svLhK6sNogd7e8wrt//
   a2MU+aqfvHqtu1IKea/k/cdJNiIZrHKoI91FB1Tx8Jw407KJ2R2wgKrmA
   A==;
X-CSE-ConnectionGUID: jSMfuw15TJGzquobHcasUg==
X-CSE-MsgGUID: 8joSnPNMRgSgNM3+xoGuZg==
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="46088878"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 02:55:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 02:54:35 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 02:54:31 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <balamanikandan.gunasundar@microchip.com>,
	<nicolas.ferre@microchip.com>
CC: Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 0/4] Add microchip sama7d65 SoC I3C support
Date: Thu, 18 Sep 2025 15:24:25 +0530
Message-ID: <20250918095429.232710-1-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for microchip sama7d65 SoC I3C master only IP which is based on 
mipi-i3c-hci from synopsys implementing version 1.0 specification. The platform 
specific changes are integrated in the existing mipi-i3c-hci driver by introducing 
a quirk and SoC specific config option.

I3C in master mode supports up to 12.5MHz, SDR mode data transfer in
mixed bus mode (I2C and I3C target devices on same i3c bus).

Testing done:
With this patch we are able to fully configure the lsm6dso I3C slave
device. Unlike I2C, I hope there is no linux utility to check the
various transactions supported in the host controller. These features
will be tested later probably with I3C analyser KIT.

Durai Manickam KR (4):
  clk: at91: sama7d65: add peripheral clock for I3C
  i3c: mipi-i3c-hci: add microchip sama7d65 SoC
  ARM: configs: at91: sama7: add sama7d65 i3c-hci
  ARM: dts: microchip: add I3C controller

 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 12 ++++++
 arch/arm/configs/sama7_defconfig              |  2 +
 drivers/clk/at91/sama7d65.c                   |  5 ++-
 drivers/i3c/master/mipi-i3c-hci/Makefile      |  3 +-
 drivers/i3c/master/mipi-i3c-hci/core.c        | 28 ++++++++++++
 drivers/i3c/master/mipi-i3c-hci/hci.h         | 12 ++++++
 .../i3c/master/mipi-i3c-hci/hci_quirks_mchp.c | 43 +++++++++++++++++++
 7 files changed, 102 insertions(+), 3 deletions(-)
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c

-- 
2.34.1


