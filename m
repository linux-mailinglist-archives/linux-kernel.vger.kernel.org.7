Return-Path: <linux-kernel+bounces-782185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667EAB31C04
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236F77BA685
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59103126B1;
	Fri, 22 Aug 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hHsKHjpb"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4353093AE;
	Fri, 22 Aug 2025 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873517; cv=none; b=kZnaXxO0R6Ogin6/Agyu2TxaH1ZIPa7vXcP9hbEdzFp2uboJKjb279h2QbVRnszNSr0pW6UQeaIHq2kwwYSEgZnEPHvWlj+bEKVmzj123vUQqYsT4SOpYFUiP1om+sqVJcNGmI//XMU+6L8Dw+3AV5W0NDxMhArkn+O5nle0pT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873517; c=relaxed/simple;
	bh=xstWcPBY6goYqL3FE+fr6Vqn/4Ienn1iKFMuKyMAHl0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=hH05MuE+4zsz+QBwN2tV8vHqCfrsytY8Snt7XPTKUpFT8mbVo/j/wMvv7PNUK0ev0f3XyvKo16+YJWkqniYpW8IhMNKtn7YnDkfvCB/1qAEF0EufLxQlAdWhxSjBuK9vC4u/ry5rY1dT51i9tcYafHoDxjOTp2RqvFBZVjNNuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hHsKHjpb; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MD2rZu032472;
	Fri, 22 Aug 2025 16:38:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=kvDVPw7OS3PnQ1V26p/rxq
	78OrrZUETtAXGrIZiRbxE=; b=hHsKHjpbzRyD7j4iMh4bveco9GYoQNAvI82Yfa
	DNV38i6YBdEkjBPsaOtr55C/CsxDj4WMqNE5KKv31BfyuBXjBPZv1YYyGxdykaqM
	IL16n9XMnuJZuQT67I8kynORQolVMjAezyP6lS1vxvHw0bhmbXRiUtpopQkA73M0
	WKvEvuafXvSvfPY2u7HVe5+IRJFnd+8y6//ooe1tnh2PO3fKoAiZ6wVw1sSxZzvQ
	kgk8qDiFw1oVBFkbFg6hvxeVN0q0eDLo//PuR0NrDbNonUt6J6vSYX8qB/hzDCEB
	WCzeE2VibazqhkuQljJsuVMTRjzMP7UzYqTZhoAdP+NGvSPA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n70dkga5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 16:38:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 508C340048;
	Fri, 22 Aug 2025 16:36:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 317A8726CB6;
	Fri, 22 Aug 2025 16:35:49 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 16:35:48 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: [PATCH v5 00/13] Enable display support for STM32MP25
Date: Fri, 22 Aug 2025 16:34:09 +0200
Message-ID: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOF/qGgC/2XMOw7CMBBF0a0g1xiNx+NPqNgHogj+gIskyI4iE
 MreMVAAoXxPOvfOSsgpFLZd3VkOUypp6OtQ6xVz57Y/BZ583QwBFWhhuM8d71JxvA/XkVMbCbQ
 TjlRk1VxyiOn66u0PdZ9TGYd8e+Un8XzfJYNqUZoEB96qxpINGl1sdnEoZVPGjRs69mxN+PFW4
 NJj9UJi9JZIS2/+vfz2zdLL6oGEko2x4eiP/56+PIqlp+oNaFAA0UYvf/08zw9aXGnKbAEAAA=
 =
X-Change-ID: 20250617-drm-misc-next-4af406c1c45f
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01

This series aims to add and enable sufficient LVDS display support for
STM32MP257F-EV1 board.

LVDS is the default use case to drive a display panel on STM32MP257F-EV,
even though DSI panels will be supported in the near future.

The LTDC needs a pixel rate in sync with the bridge currently in use.
For that both DSI and LVDS bridges need to declare an internal clock and
become clock provider to the mux. The mux then selects the reference
clock for the LTDC pixel rate generation.

For now this mux is handled internally in the LTDC, while waiting for
the STM32 clock framework to merge a 'clk-mux' based on the SYSCFG.
This explains the link done in the patch [7/8] between the LVDS,
providing the reference clock for the LTDC internals.

  +----------+              |\
  |  DSI PHY |------------->| \           +------------+
  |          |ck_dsi_phy    |  |          |            |
  +----------+              |  |--------->|    LTDC    |
  +----------+              |  |pixel_clk |            |
  | LVDS PHY |------------->|  |          +------------+
  |          |clk_pix_lvds  |  |
  +----------+              |  |
                            |  |
   ck_ker_ltdc ------------>| /
                            |/|
                              └- SYSCFG

Clock selection applies as follow:
- 0b00: Selects ck_dsi_phy
- 0b01: Selects clk_pix_lvds
- 0b10: Selects ck_ker_ltdc (for parallel or DSI display).
- 0b11: Reserved

The reset value of the register controlling the mux is 0b01, meaning
that the default clock assigned is the clk_pix_lvds.  This causes two
things:

- In order to get basic display on the LVDS encoder, like intended,
nothing has to be done on this mux within the LTDC driver (which for now
explains the unused syscfg phandle on the LTDC node in the device-tree).

- 'pixel_clk' is dependent from 'clk_pix_lvds' because of the LTDC clock
domains.  They also need to be sync to get a coherent pixel rate though
the display clock tree (which explains the LVDS phandle on the LTDC node
in the device-tree).

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
Changes in v5:
- Documentation:
  - LTDC: Clamp correctly min/maxItems value (again)
- Add Yannick's trailers where relevant except in patch [01/13] which
  has been modified
- Link to v4: https://lore.kernel.org/r/20250821-drm-misc-next-v4-0-7060500f8fd3@foss.st.com

Changes in v4:
- Documentation:
  - LTDC: Add "st,stm32mp255-ltdc" compatible.  After internal
    discussion, we came to the solution that the LTDC on STM32MP255 SoC
    needs its own compatible, since it does have the same amount of
    clocks than on STM32MP251 SoC.
- Devicetree:
  - Add "st,stm32mp255" compatible on corresponding dtsi
- Drivers:
  - LTDC: Handle "st,stm32mp255" compatible
- Remove Rob's r-b from patch [01/13] since it was modified.
- Link to v3: https://lore.kernel.org/r/20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com

Changes in v3:
- Rebased on latest drm-misc-next
- Documentation:
  - LTDC: Clamp correctly min/maxItems value
  - LVDS: Remove second 'items' keyword
- Add Krzysztof's trailer where relevant
- Link to v2: https://lore.kernel.org/r/20250812-drm-misc-next-v2-0-132fd84463d7@foss.st.com

Changes in v2:
- Documentation:
  - Add support for new compatible "st,stm32mp255-lvds"
  - Change LTDC compatible for SoC compliant one
  - Make clearer LTDC clock-names property
- Devicetree:
  - Change compatible according to the documentation
  - Change clock and clock-names order to match documentation (and avoid
    warnings)
- Drivers:
  - Change LTDC compatible
- Add Rob's trailer where relevant
- Link to v1: https://lore.kernel.org/r/20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com

---
Raphael Gallais-Pou (11):
      dt-bindings: display: st: add two new compatibles to LTDC device
      dt-bindings: display: st,stm32-ltdc: add access-controllers property
      dt-bindings: display: st: add new compatible to LVDS device
      dt-bindings: display: st,stm32mp25-lvds: add access-controllers property
      dt-bindings: display: st,stm32mp25-lvds: add power-domains property
      dt-bindings: arm: stm32: add required #clock-cells property
      arm64: dts: st: add ltdc support on stm32mp251
      arm64: dts: st: add ltdc support on stm32mp255
      arm64: dts: st: add lvds support on stm32mp255
      arm64: dts: st: add clock-cells to syscfg node on stm32mp251
      arm64: dts: st: enable display support on stm32mp257f-ev1 board

Yannick Fertre (2):
      drm/stm: ltdc: support new hardware version for STM32MP25 SoC
      drm/stm: ltdc: handle lvds pixel clock

 .../bindings/arm/stm32/st,stm32-syscon.yaml        | 31 ++++++---
 .../devicetree/bindings/display/st,stm32-ltdc.yaml | 55 ++++++++++++++-
 .../bindings/display/st,stm32mp25-lvds.yaml        | 13 +++-
 arch/arm64/boot/dts/st/stm32mp251.dtsi             | 19 ++++++
 arch/arm64/boot/dts/st/stm32mp255.dtsi             | 20 +++++-
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         | 79 ++++++++++++++++++++++
 drivers/gpu/drm/stm/drv.c                          | 12 +++-
 drivers/gpu/drm/stm/ltdc.c                         | 58 +++++++++++++++-
 drivers/gpu/drm/stm/ltdc.h                         |  6 ++
 9 files changed, 275 insertions(+), 18 deletions(-)
---
base-commit: c8cea4371e5eca30cda8660aabb337747dabc51d
change-id: 20250617-drm-misc-next-4af406c1c45f

Best regards,
-- 
Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>


