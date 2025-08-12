Return-Path: <linux-kernel+bounces-764844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A38B227EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6878B176325
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7390281357;
	Tue, 12 Aug 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4PmvtAS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10328000B;
	Tue, 12 Aug 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003641; cv=none; b=f7wRZdOhZzORf+Sj0USgEh5LLgqC1En0v+/JMOjF6Fb5eCFUAG3WZUy1gOOjM+WjiH90M3a95v1q32fhJw14SuBzOI4AIt6cVvJlmaDSwgf2SnVJFtCytXudFqoDyMSyV01CNOzpgDxzmLvcIJD+6CA608k12XWyhnnatyA92Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003641; c=relaxed/simple;
	bh=qEfGEH6TN3t5lb3uqMXrBy+umm7qijcK9imic70APas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfquWkhv9zIQTz1lvk9bvXShUlWtbQUGu2o03lih1DYZZFfJXjD+pR3XgA9IeV98N6Dqs/U0zbsXtxxxj2283jznyFmgPxNBUKt3/z6U3YQ/fVP6q85gisbqWLP0OPRwSVaJ86zozI2VKSyGld+6M+/ZtQyFu92mTY6b73zAqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4PmvtAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD333C4CEF6;
	Tue, 12 Aug 2025 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755003640;
	bh=qEfGEH6TN3t5lb3uqMXrBy+umm7qijcK9imic70APas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U4PmvtASICJxX96G89lxOIizL4ltkh6K7NI0K40PBCWby+fHmCmY8SrModbDYrNV7
	 o6mKq/O56/liJPYlcNi7CyTu/znLGZ4RoM2RjNdFPyGCbhiWufuKHWu6oZrtXRY3Xg
	 ybcdzPXym35aLIJdWQHYrEtDDmvGtQBk+pycVU51MuAsZ5rPuWkZ6PjmIJ496J0Pev
	 nqHKARX94qZnws34SbXegDX60oBnDMpzoHjW0AT2YWftU1v5JxugZQEOG26nivXDYk
	 ZfNEY24jomAgv/sXVnXADM/xTxjGTJEpLQ66c/UyCzYDnV8qllaxJ1Xu5righAbITQ
	 dmQblDlxwozrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D41CA0EC4;
	Tue, 12 Aug 2025 13:00:40 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Tue, 12 Aug 2025 20:59:26 +0800
Subject: [PATCH RESEND v2 3/4] dts: agilex: Add support for SDM mailbox
 interrupt for Intel Agilex SoC FPGA.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-sip_svc_irq-v2-3-53098e11705a@altera.com>
References: <20250812-sip_svc_irq-v2-0-53098e11705a@altera.com>
In-Reply-To: <20250812-sip_svc_irq-v2-0-53098e11705a@altera.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahesh Rao <mahesh.rao@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755003637; l=956;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=kTWn6GvwTe/xGzLhUbTFDEIXbzJ45fZ902gWQA8lOkM=;
 b=e5LrUNd0bULmIlviqmFxaoO/8SP95VX4DsDCBH3fqKIB6Dur2nzJiKnCGldefsvimolevV7YQ
 55Mb+Vi4SqkCQOPlrkPd75kz6MYl1eXd2f+qz4Opm56QdHlZlRO+TL+
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
index c1e66db0f4c524809d4334b86ef741f834a9b896..c3c72e8c1c10fcff818dcc934a36e2ffaa0bd347 100644
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



