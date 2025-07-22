Return-Path: <linux-kernel+bounces-741104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B31B0E026
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4203B1C200E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184F2EBDC7;
	Tue, 22 Jul 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuuG8Wuu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288CA273816;
	Tue, 22 Jul 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196949; cv=none; b=QWjgGFL8fQdJkECTkzPZRgIEHG83mAuZIZq/I9fKIgaUm9j5V30qcMvKEmuRBUz4fyNIMOTkasvFqiu6VkMSuOVm/VXnHXEBNC/65v9PWNPwVCkXILL6JD445pE6lunxAmXg4IE29bZkU1Jgmbew9pa5uoGVpiyWgQcpImQHaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196949; c=relaxed/simple;
	bh=UmKRauBkPwRBEcxzeLfsR2YxRVyU+QCdpvaIF5yeb1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6Y8bOSgNIHouzANqRIwvqUHM2pc1LqAOiXmh5hu1K+ggtQ/hyESU7SpVmU0YTVtINEUL6oiE3eypmmZ5BpV0XddNBFUgw5vb6220r5Btv08wMMVlHU0OZAiO/kzMYEu+L671UxDLYZNl4bGf5GUBF+XzH4xbwDf7mMsStpM/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuuG8Wuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D945CC4AF0B;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196948;
	bh=UmKRauBkPwRBEcxzeLfsR2YxRVyU+QCdpvaIF5yeb1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JuuG8WuuJlC+TR2KBcY4iI2PVJkrrIXhiAL9k3md+qxPYMoETS6QmTQAnA8cLGAsw
	 vcZ84NgBdzx6JNYmrcw+rJ2jXaM8fDNwxuUyW6pGjD8QDMfdISZ1DPvHNRbTbBNSQJ
	 9H/EAvLxpEBGe5KMb45jzQ4xV5EO4Iq+h3i0DAlg7xLYZL2hTrD/Z41PRustdXQxL0
	 Sj2nrx6ujQgtXN7FXUu7utgf7o1G+QQZvUPW6oPByUNP0/6EFAtWrBaCfXM+LD+awa
	 9Y892bj8OgtOT1GNXRgb84Q4mSsUPTNcaM/+1nOKjiqK907y9X+rT8dJgNS2f40pS8
	 WredeMKvaQAfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98F9C83F1A;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Tue, 22 Jul 2025 23:07:53 +0800
Subject: [PATCH 3/4] dts: agilex: Add support for SDM mailbox interrupt for
 Intel Agilex SoC FPGA.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-sip_svc_irq-v1-3-c5b9e02c1ce6@altera.com>
References: <20250722-sip_svc_irq-v1-0-c5b9e02c1ce6@altera.com>
In-Reply-To: <20250722-sip_svc_irq-v1-0-c5b9e02c1ce6@altera.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahesh Rao <mahesh.rao@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753196946; l=956;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=qLJL9E6mhNOyiVfHw+nPeNLWSX7L0xd4wCMDiWauGyc=;
 b=/SOzXqFsdQWRhSBWMsOdPguNNREu4BpMpU0pOPlTo/z4UC7X6csZ8iqTWM3n7hlD9s/Z7OJ9U
 jbIwpDeNskRB25CJIa4GWmTD93kqEWlXkMleN2foxsrzTR8hVcdXL8o
X-Developer-Key: i=mahesh.rao@altera.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=
X-Endpoint-Received: by B4 Relay for mahesh.rao@altera.com/20250107 with
 auth_id=337
X-Original-From: Mahesh Rao <mahesh.rao@altera.com>
Reply-To: mahesh.rao@altera.com

From: Mahesh Rao <mahesh.rao@altera.com>

Add support for Secure Device Manager (SDM) mailbox
doorbell interrupt on Agilex SoC FPGA for supporting
asynchronous transactions.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index a77a504effeab6b487ea0ef4c733f3ed80cad5be..436de1bb18d7a561c169595ad50d54d8120fdd35 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -65,6 +65,8 @@ svc {
 			compatible = "intel,agilex-svc";
 			method = "smc";
 			memory-region = <&service_reserved>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&intc>;
 
 			fpga_mgr: fpga-mgr {
 				compatible = "intel,agilex-soc-fpga-mgr";

-- 
2.35.3



