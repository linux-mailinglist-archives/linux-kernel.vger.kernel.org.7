Return-Path: <linux-kernel+bounces-822418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60050B83D29
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC72717B82C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012CC2F7444;
	Thu, 18 Sep 2025 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b="klIMJ9qL"
Received: from mail1.nippynetworks.com (mail1.nippynetworks.com [91.220.24.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6E2F6562;
	Thu, 18 Sep 2025 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.220.24.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187987; cv=none; b=aXf34zQV9F5a2Twz1/Rp1F6w9fz50AvJjF/oIWkq4Y+uPEe9VaSkTS2IPONosPIRP07/N1XqXwmmDJar/JpPQV9iUGdQ2Uzxr4BrMg2F2MiABxIRD6CehKrChVnpuRDd2Z52SCJKI3odm2p7IlorF0hsSLvDeIs1CzKMAZl1Yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187987; c=relaxed/simple;
	bh=gJK61CxIYORXu0qQVeiNVFEgqWeZ7Q+jakVj0kyAY54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8H3ndDxjcXP4CKoEi1WVWp3+3/RWt49oOEb6n/Na/QUTR6UqeqhSVgNThIc0fpd9ML6CyiTs62LLkzeEFfQ3ofDb0zxuJGl8pIrLrs/DMYbRium5t/S0dbmgh2lWdVz0MDkXhKzBHd1c0oPAMyllqvRVXjG6CixiXPRioGDzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com; spf=pass smtp.mailfrom=wildgooses.com; dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b=klIMJ9qL; arc=none smtp.client-ip=91.220.24.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wildgooses.com
Received: from grunt.nippynetworks.lan (unknown [94.228.36.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lists@wildgooses.com)
	by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4cS9RJ4jR4zkd2x;
	Thu, 18 Sep 2025 10:33:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
	s=dkim; t=1758187980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVU5tGHmqG4x9iEcm9yxe9Fmkvi5HlHhHBrkCZ7w1SQ=;
	b=klIMJ9qLJs52WqW0Fi9hfKFB/aHJfZRnLeN/UBB8NfrpEbu610iFaYqdFpgpqXtnF1QTp6
	YVKHv1maBMPStFALL3IvsMBh1QEosSzwUfxrOy7/YJlkn1ov3CAAO4jI5nDQbCifUt9351
	TN2V/TjbwHAcg0eT+5+PdCMRvFvfTX4=
From: Ed Wildgoose <lists@wildgooses.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ed Wildgoose <lists@wildgooses.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rockchip: dts: Enable UART DMA by adding default dma-names property
Date: Thu, 18 Sep 2025 09:32:46 +0000
Message-ID: <20250918093246.15623-3-lists@wildgooses.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250918093246.15623-1-lists@wildgooses.com>
References: <20250917114932.25994-1-lists@wildgooses.com>
 <20250918093246.15623-1-lists@wildgooses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel appears to need a dma-names set for DMA to actually enable. Set a
default dma-names property for all UARTs defined in the board
definition: rk3566-radxa-zero-3.dtsi

This is tested on a Radxa Zero 3W (which has 5x UARTs) and removes the
warnings and enables DMA on this platform

Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
index e644bfc9c..fc26a4a52 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
@@ -488,21 +488,29 @@ &tsadc {
 	status = "okay";
 };
 
+&uart1 {
+	dma-names = "tx", "rx";
+};
+
 &uart2 {
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
 &uart4{
+	dma-names = "tx", "rx";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4m1_xfer>;
 };
 
 &uart5 {
+	dma-names = "tx", "rx";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart5m1_xfer>;
 };
 
 &uart9 {
+	dma-names = "tx", "rx";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart9m1_xfer>;
 };
-- 
2.49.0


