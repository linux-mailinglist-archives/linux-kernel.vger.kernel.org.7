Return-Path: <linux-kernel+bounces-854377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CBEBDE3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 696504E2A30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A7A31D377;
	Wed, 15 Oct 2025 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SneuFKL5"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD031CD15;
	Wed, 15 Oct 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526835; cv=none; b=aTsyCNFG20CfJ+FpQy6mCkL2nU0YrrvYWFxChlKp92RmtQUsFkjFdMfZwr7y+jyG5fvBkz+H5wBx4CRwVKa8EdNoZPU3VoNO7YnCvoTkG2r/KKqQrGngr2qU4HS6avdz2lY7yo9D55EBK7x0ZXUi0VTGIp6lGiRb7AWoX+81xEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526835; c=relaxed/simple;
	bh=iF3BAX09rmWvaxcm4bVWBJYltuvv6rRtOM0FI+IVUU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h+i0vyNenWhD6lhxxjihqJOQAZ81+C44jaV1lK70YDLftL3ZZ6xOTYIuPbsVyDn0AebqxxH2LbpfEq8i07uBTpUzE6qcVvkTCpbg2oEL/b6HkjOK2GabVK2IpQYsbBjKrE5+08Tq4hRGjJeONLC8PpbgYGW7VddE3z1qeLk5F3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SneuFKL5; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FBDgRZ1387653;
	Wed, 15 Oct 2025 06:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760526822;
	bh=FsntGwJK+u1bx93YId7/aEwLX3vg7UlA2rb4wGYzrE8=;
	h=From:To:CC:Subject:Date;
	b=SneuFKL5Pp1hWTysHZ9tvaNyHWNuvaOciG8JGyH1/QHLvfTOCMOlrswVK7rfNgBvc
	 71azxMvn103AaGqDw3HAZyimVW5Cnu3ge3EuKyRXrs/JOMJypXZbCRLQGOnJ6ySOl7
	 kpFN0Lbs0v5GxcCjwldah21fljaLzthmh3d/8jOs=
Received: from DLEE209.ent.ti.com (dlee209.ent.ti.com [157.170.170.98])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FBDf2s1179812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Oct 2025 06:13:42 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 06:13:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 06:13:41 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FBDbHi1809909;
	Wed, 15 Oct 2025 06:13:38 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d.haller@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 0/5] TI-K3-DTS: Cleanup CPSW DT Nodes
Date: Wed, 15 Oct 2025 16:43:32 +0530
Message-ID: <20251015111344.3639415-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

This series cleans up the CPSW Device-tree nodes by updating the SoC and
board files to keep CPSW disabled in the SoC files and enable it only in
the board files.

The following is a summary of the SoCs, CPSW instance and the Boards that
this series affects:

-----    -------    ----------------  -------------------------------------------------------------
S.No.      SoC        CPSW Instance                         Board(s) / SOM(s)
-----    -------    ----------------  -------------------------------------------------------------
  1.       AM62          CPSW3G           AM625-Beagleplay, AM62-LP-SK, AM62-Phycore-SOM, AM625-SK
  2.       AM65        MCU CPSW2G         AM654-Base-Board, IOT-2050 Based Boards
  3.       J7200       MCU CPSW2G         J7200-Common-Processor-Board
  4.       J721E       MCU CPSW2G         J721E-Common-Processor-Board, J721E-Beagleboneai64, J721E-SK
  5.       J721S2      MCU CPSW2G         AM68-SK-Base-Board, J721S2-Common-Processor-Board, AM68-Phyboard

Series is based on linux-next tagged next-20251014.

v3 of this series is at:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20251014125349.3408784-1-s-vadapalli@ti.com/
Changes since v3:
- Rebased series on next-20251014.
- Based on feedback from Dominik Haller <d.haller@phytec.de> at:
  https://lore.kernel.org/r/df6acbfe5d30956ed66e2768fa595c36d2ebe98a.camel@phytec.de/
  the first and fifth patch have been updated to enable cpsw in:
  k3-am62-phycore-som.dtsi and k3-am68-phyboard-izar.dts respectively.
- The fourth patch of this series has been updated to enable cpsw in:
  k3-j721e-beagleboneai64.dts and k3-j721e-sk.dts

Test Logs:
1. AM654-Base-Board:
https://gist.github.com/Siddharth-Vadapalli-at-TI/168cada897c0e13d5c197b241e336544
2. AM68-SK-Base-Board:
https://gist.github.com/Siddharth-Vadapalli-at-TI/b97d65dd9fd1a8a852fc4b55842d5e3c
4. J721E-Common-Processor-Board:
https://gist.github.com/Siddharth-Vadapalli-at-TI/0b264562259b8eed349daa36827f7c2c
5. J721S2-Common-Processor-Board:
https://gist.github.com/Siddharth-Vadapalli-at-TI/690ca66e8400b966723f4d316ac1db7e

Regards,
Siddharth.

Siddharth Vadapalli (5):
  arm64: dts: ti: k3-am62: disable "cpsw3g" in SoC file and enable in
    board file
  arm64: dts: ti: k3-am65: disable "mcu_cpsw" in SoC file and enable in
    board file
  arm64: dts: ti: k3-j7200: disable "mcu_cpsw" in SoC file and enable in
    board file
  arm64: dts: ti: k3-j721e: disable "mcu_cpsw" in SoC file and enable it
    in board file
  arm64: dts: ti: k3-j721s2: disable "mcu_cpsw" in SoC file and enable
    in board files

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts               | 4 ++++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi               | 2 ++
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi        | 1 +
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts         | 1 +
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi         | 1 +
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi     | 4 ----
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                | 2 ++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts         | 1 +
 arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts       | 1 +
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts       | 1 +
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts  | 1 +
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi        | 2 ++
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts     | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts  | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi        | 2 ++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                 | 1 +
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 1 +
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi       | 2 ++
 18 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.51.0


