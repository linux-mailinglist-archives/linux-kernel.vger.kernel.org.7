Return-Path: <linux-kernel+bounces-741105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C3B0E019
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334ED3BE269
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE9A2EBDC3;
	Tue, 22 Jul 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+Dmi5yW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899F28B7C7;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196949; cv=none; b=GpZGYs6kxOFBJ4gn8Kr7MEgv2wuMMl5vbML45EAvDvwtXFiZxFvkIQfViERi68qKrXpnrHl4s4g9Flu7WWOywWwWS6tnScb6ZKkCD7+yfHSNX34pjXKKAG7NNlPhGQpsYbeEdZmHcBXasxnEtjLGjxWztHQjZFfQvFo0k7SH2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196949; c=relaxed/simple;
	bh=aHN18HPkwCf0LxSHB2eIoBDEjdVHt7XQYvM14GyS9uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nd2L5OJinWfcK5Smbqtpjz1+hkf3x2wR0lMKM1TUJ9dEjq6KToT57ageiJuc9ktXgviW6M1ZlKjHfPV66DTkV5axHe5IFcu8Fu5y3YkcYq+wM5VfSSSgvLdharmBH6vw6/d7ViNiZd0jhGkCfppojr82XS47dtTqQtKBK3rbHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+Dmi5yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA212C4CEF8;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196948;
	bh=aHN18HPkwCf0LxSHB2eIoBDEjdVHt7XQYvM14GyS9uk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k+Dmi5yWjjBHSfJSItPo97SKQO+cq4Lanxud1mQZkCT3KRDN5aL3A3s+F4f54vXWL
	 nMG3Oaup2wCmCM3Ts5hp12qHKnni+1qGDAI1Y1dYkl8VNrQdlH0MgLqpi/rQZevjqe
	 YA1Oxfz9SjU9hjm+cZm4WD7cAlTi31QxvxXCG/uKGjdshdGDmTRatBWGOdNbWdea1k
	 him9UoqPS0xOTBf9rIQPwxumeQIw1PV6GVK3y1dk0sjsBb/crHTZ7lP8rgb/7YKZN7
	 Ajo/TC9QYuERwANTH6foTDkvXzC+bhVHzbeF52yyUQLbJc9ClPOe1L1X+M5M5j5/+B
	 jx0DGvPsZAMNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8A0C87FC5;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Tue, 22 Jul 2025 23:07:52 +0800
Subject: [PATCH 2/4] dts: stratix10: Add support for SDM mailbox interrupt
 for Intel Stratix10 SoC FPGA.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-sip_svc_irq-v1-2-c5b9e02c1ce6@altera.com>
References: <20250722-sip_svc_irq-v1-0-c5b9e02c1ce6@altera.com>
In-Reply-To: <20250722-sip_svc_irq-v1-0-c5b9e02c1ce6@altera.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahesh Rao <mahesh.rao@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753196946; l=1326;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=EyWFuPMqdroUgCXWZr6rl+Afig+2qBq3MLf9ty0RfNw=;
 b=hPx+iNGCXFxdYOfVUDxINu9LBG9KDVYy8r+6gnqauneL9xWveBSxoby7xpa16PvXLQedrMGJU
 IazOx9B17ItDm1Hb2CVlX7YpjU/noFyTdjsje6zN2wZq5e6X1NL5GfQ
X-Developer-Key: i=mahesh.rao@altera.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=
X-Endpoint-Received: by B4 Relay for mahesh.rao@altera.com/20250107 with
 auth_id=337
X-Original-From: Mahesh Rao <mahesh.rao@altera.com>
Reply-To: mahesh.rao@altera.com

From: Mahesh Rao <mahesh.rao@altera.com>

Add support for Secure Device Manager (SDM) mailbox
doorbell interrupt on Stratix10 SoC FPGA for
supporting asynchronous transactions.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 0def0b0daaf73101362eb13e0db5901c6ade06e1..9699b3fe79c89c0af0d00e8f1a5548707d01539d 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright Altera Corporation (C) 2015. All rights reserved.
+ * Copyright (C) 2025, Altera Corporation
  */
 
 /dts-v1/;
 #include <dt-bindings/reset/altr,rst-mgr-s10.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/stratix10-clock.h>
 
 / {
@@ -74,6 +76,8 @@ svc {
 			compatible = "intel,stratix10-svc";
 			method = "smc";
 			memory-region = <&service_reserved>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&intc>;
 
 			fpga_mgr: fpga-mgr {
 				compatible = "intel,stratix10-soc-fpga-mgr";

-- 
2.35.3



