Return-Path: <linux-kernel+bounces-764843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D74B227C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE5C68221A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E8281358;
	Tue, 12 Aug 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCARbBi5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E3280024;
	Tue, 12 Aug 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003641; cv=none; b=s+kMXnhUPc9NIRS7tCQ0C/847AH2+jpK9lpUJRrF5kaEdiX+/dpZ5nLtVBYd+bjFH6ei0mzm0+6WK7fpKrEzyTM2hVmXm1R2RMJoIhCB0v7MtvvSv1JI3bAmBoSdNX86NN8OtHCBP+GzETu+isXIANbDUIeHHjCM55e6/9dWFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003641; c=relaxed/simple;
	bh=zYGMtM8fuI4HHjVC9uIuljEjH+ZKKu6iq7sDJh5FxKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RF9Xn9ys7rEICWWzF/JgyjgN02Bgqn+7Hr0oIbdmAUQF9VXjkKi0gp3r8uIB3G5uiEzczt6rtOeQ+fgxVNDx9JkREy9+sqn26Nc6G5Kqw6xArDG7WKirplorTUy2EtH0NCxpzmuqVy39fC7G61XIgIPORjFcLnqf5qpgqx+9R7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCARbBi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C54B9C4CEF8;
	Tue, 12 Aug 2025 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755003640;
	bh=zYGMtM8fuI4HHjVC9uIuljEjH+ZKKu6iq7sDJh5FxKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OCARbBi5fDhVrI5gh48ZwbcyJPTmd7ZYq6ACUYR6eRo50RRcsnYWn0OKCVUFMYgQe
	 lI3i/LBennckxP2h5Q6s+dZvpT1uArqFGGlqFSqjsgiOdcd0leiTbk1PTjoAcpCfIn
	 WkzWOv54Hherjw58iVOmlsMd0N6DiQTydA/D6ao579TFkmrXPAB+cIRaJV4xEuYh8o
	 as74LtbmgH8FcjW807rLFa7OyMC+WAaf3l4zXE3vZ96avRvvYq3z5rQJJVrbej8VdZ
	 zpYYV9AXOi+iGt7E/61dUmQozlL78V0Dc6AAvht4CQQ1exkeUxF7pLRX4a0MHQbaxx
	 Omxjmvngh9Dmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AE4CA0EDB;
	Tue, 12 Aug 2025 13:00:40 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Tue, 12 Aug 2025 20:59:25 +0800
Subject: [PATCH RESEND v2 2/4] dts: stratix10: Add support for SDM mailbox
 interrupt for Intel Stratix10 SoC FPGA.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-sip_svc_irq-v2-2-53098e11705a@altera.com>
References: <20250812-sip_svc_irq-v2-0-53098e11705a@altera.com>
In-Reply-To: <20250812-sip_svc_irq-v2-0-53098e11705a@altera.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahesh Rao <mahesh.rao@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755003637; l=1326;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=3ob8k9A6zIADp0lruGxd1g5augXf3tZBlKtdVmhWZZI=;
 b=QDmzUwun/xgQqFFN4+DuH+uiOuoF/QBmwrB90Uyrqg31EOzLm47xWbWs1AquzPkOhYYYBlrb+
 Do7ujBn5v7oC7qYfktIzQV2w4CYgPU7Xt5Huxw3qs5BbgYHOb1c9pXE
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
index effd242f6bf709a53659b4de2a2da728052d086f..9e8b3b07dde3ff57382044f528c34bd52f8df123 100644
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



