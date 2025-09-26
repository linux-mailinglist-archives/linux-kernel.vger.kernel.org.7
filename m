Return-Path: <linux-kernel+bounces-834529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F05BA4E07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C423280BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F07130DEA4;
	Fri, 26 Sep 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFqQZElB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED131494A8;
	Fri, 26 Sep 2025 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910788; cv=none; b=j2gxcJsKu0JV8/yq5u2w7BDE5qKEhlUUQPMyrGQ8U4P0RlSMprP62uNF7XQDEKcf13a3dGW9TT57Fuzlww9BdbD6g0yXXYETxN46VhGKD76JsRmAXND3Em3+zFpvOrOoDvFyq5/MsSjMA0xIZ6L1aEh23X++AznZviaO+8S72iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910788; c=relaxed/simple;
	bh=0CgND4WO16EtwUc3Nse3AAY8I+x8THVa8IhQIsivJLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uaHO0CKkqSM96YNODruum8ngTTR3NKPDC8kh14V5AQ/S5Wt5QpWJmn/J0I6tYxBIuMrsDN2mZAcFAXXOdS1KumpMPXTdtNU6ALoZlgqepFtq2Zet9tfljBjWeUFpp1crkl0ekBDgpapMZzV70QSjIijESDSKszhK3HBKBMRwbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFqQZElB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61B71C4CEF4;
	Fri, 26 Sep 2025 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758910788;
	bh=0CgND4WO16EtwUc3Nse3AAY8I+x8THVa8IhQIsivJLs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EFqQZElBdFonxbZXptHxBGcF7HN72o2kHiE88vBtKb9UJLOLs7JAhSIjcjTBoYI+X
	 7+psEOnYSFC6rlh9JSWxyYAmyOUnp4O4NgEkT3/RWBDZVQ6yvKE+IHBrPCYoA/UfT9
	 vf6DCunRU1iF14XAzo5Ctg5IqSTcmI5B7yrC/kxDXWx3KiqquRl0UAwZfAIFw1qM81
	 tt7KVbLYQdz8i1zZloLF+NE9e2VQQiOmLOl6z5YOr5QsZReG7pigdz0yhr6BsbLDtX
	 EpjIs+bghQqJNPfjiL0Z5U1RTQj7bHMqx62lR8MOXEcLtoHQWLy3cSgBPagEat/w/J
	 +LI1Tv+bDexKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450B9CAC5B9;
	Fri, 26 Sep 2025 18:19:48 +0000 (UTC)
From: Frank Li via B4 Relay <devnull+Frank.Li.nxp.com@kernel.org>
Subject: [PATCH v4 0/4] usb: dwc3: add layerscape platform driver use
 flatten dwc3 core
Date: Fri, 26 Sep 2025 14:19:39 -0400
Message-Id: <20250926-ls_dma_coherence-v4-0-21e9c6bdb5cb@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADzZ1mgC/33OQQqDMBAF0KtI1k2JiR1rV71HKWImYw3UKEkRi
 3j3Rje1IF3+gff/TCyQtxTYJZmYp8EG27kYskPCsKncg7g1MTMp5EmAkPwZStNWJXYNeXJIHBV
 KDXVeGC1ZZL2n2o5r5e0ec2PDq/PvdWFIl+ufsiHlgiPk2TkzUGnIrm7sj9i1bKka5JcXUu1wu
 XBSaQ6qAG30L1dbDjtcRR7/0ikKJNCb9XmeP6x5Tm0sAQAA
X-Change-ID: 20250602-ls_dma_coherence-c3c2b6f79db2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758910787; l=3727;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0CgND4WO16EtwUc3Nse3AAY8I+x8THVa8IhQIsivJLs=;
 b=f4VguHT7W5iuk/7l2407RYWfAHOiiw0M3T09v5A7GJ5UaA1ZSGrZAWbO1/F5s3AyWLcNfz3mO
 8HMzO79XgAlCYvA/HomfsHs5YAzTSKipm2h0N88JNE1Bx7i121o/vlJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-Endpoint-Received: by B4 Relay for Frank.Li@nxp.com/20240130 with
 auth_id=121
X-Original-From: Frank Li <Frank.Li@nxp.com>
Reply-To: Frank.Li@nxp.com

Add layerscape platform driver use flatten dwc3 core to enable dma-coherence.
It needs set gsburstcfg0 to 0x2222.

There are some several try before:
[1] https://lore.kernel.org/imx/20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com/
[2] https://lore.kernel.org/imx/20240123170206.3702413-1-Frank.Li@nxp.com/

[2]: add new property, which was reject because there are no varience in
the soc. Fortunately the below commit resolve this problem by use software
managed property.

d504bfa6cfd1a usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller

[1] was reject because there are not actually dwc wrap at layerscape
platform. Fortunately Bjorn Andersson's below patch to make it possible
by use correct dts dwc3 node layer out.

613a2e655d4dc usb: dwc3: core: Expose core driver as library

This resolve problem [1] and [2] by use flatten dwc3 core library.

1. add soc specific compatible string at dt-binding.
2. create platform driver for layerscape chips and pass down gsbuscfg0 if
dma-coherence enabled.
3. update layerscape dts files.

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: bjorn.andersson@oss.qualcomm.com
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Use flatten properties, instead of use dt pass down information to core.
- Link to v3: https://lore.kernel.org/r/20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com

Changes in v3:
- skipped, accident sendout
- Link to v2: https://lore.kernel.org/r/20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com

Changes in v2:
- base on drivers/usb/dwc3/dwc3-generic-plat.c

commit e0b6dc00c701e600e655417aab1e100b73de821a
Author: Ze Huang <huang.ze@linux.dev>
Date:   Sat Sep 13 00:53:48 2025 +0800

    usb: dwc3: add generic driver to support flattened

    To support flattened dwc3 dt model and drop the glue layer, introduce the
    `dwc3-generic` driver. This enables direct binding of the DWC3 core driver
    and offers an alternative to the existing glue driver `dwc3-of-simple`.

- Link to v1: https://lore.kernel.org/r/20250602-ls_dma_coherence-v1-0-c67484d6ab64@nxp.com

---
Frank Li (4):
      dt-bindings: usb: add missed compatible string for arm64 layerscape
      usb: dwc3: Add software-managed properties for flattened model
      usb: dwc3: dwc3-generic-plat: Add layerscape dwc3 support
      arm64: dts: layerscape: add dma-coherent for usb node

 .../devicetree/bindings/usb/fsl,ls1028a.yaml       | 33 ++++++++++++----------
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  8 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  9 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  9 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  8 ++++--
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  8 ++++--
 drivers/usb/dwc3/core.c                            | 12 ++++++--
 drivers/usb/dwc3/dwc3-generic-plat.c               | 14 +++++++++
 drivers/usb/dwc3/dwc3-qcom.c                       |  1 +
 drivers/usb/dwc3/glue.h                            | 14 +++++++++
 11 files changed, 89 insertions(+), 30 deletions(-)
---
base-commit: c45d2c21b3889c520bf141d576eaecb25666895c
change-id: 20250602-ls_dma_coherence-c3c2b6f79db2

Best regards,
--
Frank Li <Frank.Li@nxp.com>



