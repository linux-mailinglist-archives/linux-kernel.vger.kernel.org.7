Return-Path: <linux-kernel+bounces-899333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826BFC57712
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEAC3B9401
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670E134EF0A;
	Thu, 13 Nov 2025 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sVVkOAWG"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62823136672;
	Thu, 13 Nov 2025 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037195; cv=none; b=m71z/iMYGBzm+geMRYcZHvQ/V7ypconeboNM9vVDro0P2pENYxGwa1RhB0yEouK94u4KUuKssTMcYoeEUmKgvUUx5RDuYvQSnhNLbdAAVTZhHVKN6uKyP1+ClshibApNkfBGogzkrJLcfSeO6n09R3BIPiYY9LCshRYKb6m/8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037195; c=relaxed/simple;
	bh=4VX1vLtLq/V9h8bS77ge52P5t8gUHATteCtEkk2mwiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ikxGEkw0O6ejSSosBH+3mVTaHirZ7NY/E8we+X3LGPSPCcXlorzHQzAgqKITy/GVRCnu0I1y09sUIVdYHdvSdbL5dFOfoXwcAYgFbpsVPFWnF4PQocy6R6hytsrP6q1Vk5T3juTD2wnJdG9kkb9fXQOgTYIWYippI3caIaThJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sVVkOAWG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5ADCU9srC3591308, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763037009; bh=5WVbtlgfd1Y1JsDGCPrgkNb5LWsPfRp9u8sbixllfmM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=sVVkOAWGV/qxKigpmgcTxsQu1OcwzrurKF0UYQ5UTFMv2Wc9c+ZkBtwYpxl5PCy3T
	 kVg/1/8ZbDse984cDdN2awCqlgCRcvc2cuWEZLPemGEqvnTJrRLrLXRilWWIIwYBim
	 EZcnlRMYa+NSYweejY0XanMpEyvVvJh+N+24uBXT0BnlsRjCWC1CbJj5/kNU7ykBri
	 E1uwnEyjLyCQ3ruVrfCFty0eTugC/PMt2oC93nf+71YPlrcXfSWkCh8V8Wn09hvJ4W
	 6YFnHPtxejIUolf7vwrr6h43VdhXWnbpx6NN2cINOctW3oTnW6VCcz9I3AcOzdCorW
	 5I23aIIsTDrPg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5ADCU9srC3591308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 20:30:09 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 20:30:10 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 20:30:09 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <afaerber@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lee@kernel.org>, <james.tai@realtek.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cy.huang@realtek.com>,
        <stanley_chang@realtek.com>, <eleanor.lin@realtek.com>
Subject: [PATCH v2 0/3] arm64: dts: Add support for Kent SoC family
Date: Thu, 13 Nov 2025 20:30:06 +0800
Message-ID: <20251113123009.26568-1-eleanor.lin@realtek.com>
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
3. Add Device Tree files for the Kent SoC, TD1501S Phantom EVB (8GB),
RTD1861B Krypton EVB (8GB), and RTD1920S Smallville EVB (4GB).

The patches have been validated with 'make dtbs_check' and
'dt_binding_check' to ensure compliance with DT schema and successful
compilation.

Cheers,
Yu-Chun

Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v2:

[PATCH v2 1/3]
- Fix YAML syntax: remove duplicate blank lines
- Validated with 'make dt_binding_check'

[PATCH v2 2/3]
- Rename: realtek,iso-system.yaml -> realtek,misc.yaml
- Improve description and example: show child node (UART)

[PATCH v2 3/3]
- Reorder Makefile targets to alphabetical order.
- Rename node: use generic names ('arch_timer' -> 'timer', 'reg-bus' -> 'bus')
- Fix node naming and hex format (remove leading zeros)
- Inline overlay nodes directly into .dtsi
- Reorder properties: ranges after reg
- Remove unnecessary status and custom bootargs

V1: https://lore.kernel.org/lkml/20251105104452.6336-1-eleanor.lin@realtek.com/

Yu-Chun Lin (3):
  dt-bindings: arm: realtek: Add Kent Soc family compatibles
  dt-bindings: mfd: Add Realtek MISC system controller
  arm64: dts: realtek: Add Kent SoC and EVB device trees

 .../devicetree/bindings/arm/realtek.yaml      |  42 +++--
 .../devicetree/bindings/mfd/realtek,misc.yaml |  72 ++++++++
 arch/arm64/boot/dts/realtek/Makefile          |   7 +-
 arch/arm64/boot/dts/realtek/kent.dtsi         | 174 ++++++++++++++++++
 arch/arm64/boot/dts/realtek/rtd1501.dtsi      |  13 ++
 .../boot/dts/realtek/rtd1501s-phantom-8gb.dts |  25 +++
 .../boot/dts/realtek/rtd1501s-phantom.dtsi    | 119 ++++++++++++
 arch/arm64/boot/dts/realtek/rtd1861.dtsi      |  13 ++
 .../boot/dts/realtek/rtd1861b-krypton-8gb.dts |  25 +++
 .../boot/dts/realtek/rtd1861b-krypton.dtsi    |  73 ++++++++
 arch/arm64/boot/dts/realtek/rtd1920.dtsi      |  13 ++
 .../dts/realtek/rtd1920s-smallville-4gb.dts   |  23 +++
 .../boot/dts/realtek/rtd1920s-smallville.dtsi | 129 +++++++++++++
 13 files changed, 712 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/realtek,misc.yaml
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


