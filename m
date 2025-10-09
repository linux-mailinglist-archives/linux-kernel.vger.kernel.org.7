Return-Path: <linux-kernel+bounces-846637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8FEBC89C0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5906A351F85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5D2DFF13;
	Thu,  9 Oct 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9uGDcb5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFF92DECA0;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007261; cv=none; b=BiPm4B+dcVs9gpAPFtatVxo0V8ng8mv15juf3pnJkGjBd1Vd3Nw2NJmFyDwC16FIL8wzVRttBhcupwKMODgh5fLx1Z7fRJi3IY6SpQjA7Oa2LDwUOWzHnjpZVKFDWSr17Zrz8a3LVA9dqqouUm6Wq2DGCrGAgppBZtV0Q8bcY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007261; c=relaxed/simple;
	bh=NuxJQ4PCNhlMAsAch1wEwPEUb1yF+bxyo517P+mfhjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GObCfZtzgBXc7B946F2TlnFBIb54MkSqWv/pBc7hJnD+3mFP45gxVMTMk57mWEqxfOSnOaK/QueVzqYCkg09y39YHBt89a1vs7GgG+PKg3C1pdKJBZayKRQPGLDbppaSVf7+YhVJQnni7WqILK6RYKFDVbHvCEG5uopVzurgAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9uGDcb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A702BC4CEFE;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760007260;
	bh=NuxJQ4PCNhlMAsAch1wEwPEUb1yF+bxyo517P+mfhjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p9uGDcb5fFeyDaWEd7eoSINvn4U5E7CulzIlD6MWBi4RmnGIKWRqdrBNjfdbNhoX0
	 TR97wcG4bTvoeTQMsyESA92ONF8PqMa+HnM1oJGHKMpTclcqp2Gb89jyf8wTFPMdFU
	 zE5qIzzj1WiFktLfP47wo1Blo4SChwsFy1BEuXiZMRf4ISUZ6ptofGd3ILKWA6ywWo
	 mTI8tMmYWCdiB1PJiTDeaChRjdzERe1mwzmN6dufW6hYUIIZbeSBz/eYkUaqJ+isDB
	 EXumWGVl6iVSFnmLoN30GamLj92wgE8GJZWh0MCtx/eblE8I8vwdEgP3kTrOQhhdV8
	 FjXxXRpM+9GOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FE1CCD18A;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 09 Oct 2025 12:54:18 +0200
Subject: [PATCH 2/5] arm64: dts: imx8mm: Add pinctrl config definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-mini_iv-v1-2-f3889c492457@gocontroll.com>
References: <20251009-mini_iv-v1-0-f3889c492457@gocontroll.com>
In-Reply-To: <20251009-mini_iv-v1-0-f3889c492457@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760007259; l=1757;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=MAE7xeBSUg/gATbefV1ey2N4qXKmne123cPaX7vCeFU=;
 b=wQgTu+w0L9+UOad9IVAW/wdFGnCuejvrzxIZKqv17++B+1TagqnNdYzFlaOFMcnVPeiEuxxUQ
 4U4xKPEhItlBQIvezmmmA/IGX6HZE1lusgTAlC/FH2zo7y+3fFae6vP
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Currently to configure each IOMUXC_SW_PAD_CTL_PAD the raw value of this
register is written in the dts, these values are not obvious. Add defines
which describe the fields of this register which can be or-ed together to
produce readable settings.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index b1f11098d248e..31557b7b9ccc1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -6,6 +6,39 @@
 #ifndef __DTS_IMX8MM_PINFUNC_H
 #define __DTS_IMX8MM_PINFUNC_H
 
+/* Drive Strength */
+#define MX8MM_DSE_X1		0x0
+#define MX8MM_DSE_X2		0x4
+#define MX8MM_DSE_X4		0x2
+#define MX8MM_DSE_X6		0x6
+
+/* Slew Rate */
+#define MX8MM_FSEL_FAST		0x10
+#define MX8MM_FSEL_SLOW		0x0
+
+/* Open Drain */
+#define MX8MM_ODE_ENABLE	0x20
+#define MX8MM_ODE_DISABLE	0x0
+
+#define MX8MM_PULL_DOWN		0x0
+#define MX8MM_PULL_UP		0x40
+
+/* Hysteresis */
+#define MX8MM_HYS_CMOS		0x0
+#define MX8MM_HYS_SCHMITT	0x80
+
+#define MX8MM_PULL_ENABLE	0x100
+#define MX8MM_PULL_DISABLE	0x0
+
+/* SION force input mode */
+#define MX8MM_SION		0x40000000
+
+/* long defaults */
+#define MX8MM_USDHC_DATA_DEFAULT (MX8MM_FSEL_FAST | MX8MM_PULL_UP | \
+				  MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
+#define MX8MM_I2C_DEFAULT (MX8MM_DSE_X6 | MX8MM_PULL_UP | MX8MM_HYS_SCHMITT | \
+			   MX8MM_PULL_ENABLE | MX8MM_SION)
+
 /*
  * The pin function ID is a tuple of
  * <mux_reg conf_reg input_reg mux_mode input_val>

-- 
2.51.0



