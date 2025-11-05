Return-Path: <linux-kernel+bounces-886299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E96C3532E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00BD1898897
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2ED309F06;
	Wed,  5 Nov 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="oeoo5pLy"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747013009FC;
	Wed,  5 Nov 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339657; cv=none; b=Bb6ajk9twpOG1e92A2AevWRCKtCvB+JWeJ6l6VkI2CVbBLiAakof/V0Sk7Ymrys6O+B2NgCho0fWLmlWw9z5urFgPXx+vaC4zZ1cXLRLZIGM8AXqDQNMbAbOTTR9DcMi9xsR9rlqNz2GkLWGOrpNVDfNn4yjlInff/uYl5/sh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339657; c=relaxed/simple;
	bh=qKWyyW5kB5XfI7vrhh0GHwmmVlzRPghkdvaUyXa6bxk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6ERSlZZgn0Pdb2+AaNm2s/fMgZlL2fEzaQSkMwGyxmSynqe02gW6YtW6wrsaGebGdk4svTYrxGpLAF7Y8aK+0dsmuTszEy3R7iTAl2x9G79Vx2I6NsLJ7W5Rst4aUGQ+Cpz/Ql12Z7XLhuEUy7uYRCu2FSDXgIgocCLXTIzi4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=oeoo5pLy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A5AirLlB984686, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762339493; bh=sSn/B8MLi6vUnr2qxjw+AgTuuZRK9O5yBQVrq5+ToBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=oeoo5pLygaTa9wWUlip+08ccQCWZdylr8A6y7OCtm+uCgWaoiG4edYaS6tzmSuCL6
	 4VSo1Btd8ku1hCizITcXmniBjpw2K//ttEkwqgDrNokMffuVHWYdGmOebaTycNhT6e
	 957Mrr2iOrQ2HLyJrPN/xXmi9Ophzy0eZ20ByI97vFbkIjgu4j2rvDl/80VvVmxISB
	 YuDKr4cahetvhrw3N54cLWowYq53zWNaB7jLiH1ZydZL9mkbo9SMpCnuLptNJWhCwY
	 WtLXWmHQR1e/XhKleXnwY7rAzIxwe58GkxHbktWNt31bftvPNDV1GhNtbde5XR0Pnn
	 k8OUwRsO/CKRA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A5AirLlB984686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 18:44:53 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 18:44:53 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 18:44:52 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server id 15.2.1544.27 via Frontend
 Transport; Wed, 5 Nov 2025 18:44:52 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <afaerber@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lee@kernel.org>, <james.tai@realtek.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cy.huang@realtek.com>,
        <stanley_chang@realtek.com>, <eleanor.lin@realtek.com>
Subject: [PATCH 0/3] arm64: dts: Add support for Kent SoC family
Date: Wed, 5 Nov 2025 18:44:49 +0800
Message-ID: <20251105104452.6336-1-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hello,

This patch series adds initial Device Tree support for Realtek's Kent SoC
family, including the RTD1501S, RTD1861B, and RTD1920S variants with their
respective evaluation boards.

The series includes:

1. Adds compatible strings for the Kent family.
2. Add new DT bindings for the Realtek ISO system controller.
3. Add Device Tree files for the Kent SoC, TD1501S Phantom EVB (8GB), RTD1861B
 Krypton EVB (8GB), and RTD1920S Smallville EVB (4GB).

The patches have been validated with 'make dtbs_check' and
'dt_binding_check' to ensure compliance with DT schema and successful
compilation.

Comments and feedback are welcome!

regards,
Yu-Chun Lin

Yu-Chun Lin (3):
  dt-bindings: arm: realtek: Add Kent Soc family compatibles
  dt-bindings: mfd: Add Realtek ISO system controller
  arm64: dts: realtek: Add Kent SoC and EVB device trees

 .../devicetree/bindings/arm/realtek.yaml      |  43 +++--
 .../bindings/mfd/realtek,iso-system.yaml      |  65 +++++++
 arch/arm64/boot/dts/realtek/Makefile          |   5 +
 arch/arm64/boot/dts/realtek/kent.dtsi         | 179 ++++++++++++++++++
 arch/arm64/boot/dts/realtek/rtd1501.dtsi      |  13 ++
 .../boot/dts/realtek/rtd1501s-phantom-8gb.dts |  26 +++
 .../boot/dts/realtek/rtd1501s-phantom.dtsi    | 135 +++++++++++++
 arch/arm64/boot/dts/realtek/rtd1861.dtsi      |  13 ++
 .../boot/dts/realtek/rtd1861b-krypton-8gb.dts |  26 +++
 .../boot/dts/realtek/rtd1861b-krypton.dtsi    |  79 ++++++++
 arch/arm64/boot/dts/realtek/rtd1920.dtsi      |  13 ++
 .../dts/realtek/rtd1920s-smallville-4gb.dts   |  24 +++
 .../boot/dts/realtek/rtd1920s-smallville.dtsi | 145 ++++++++++++++
 13 files changed, 754 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/realtek,iso-system.yaml
 create mode 100644 arch/arm64/boot/dts/realtek/kent.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1501.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1501s-phantom-8gb.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1501s-phantom.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1861.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1861b-krypton-8gb.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1861b-krypton.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1920.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1920s-smallville-4gb.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1920s-smallville.dtsi

-- 
2.34.1


