Return-Path: <linux-kernel+bounces-734947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E9FB088A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAE2A455EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181C42882DF;
	Thu, 17 Jul 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGpASrfm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C8287269;
	Thu, 17 Jul 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742760; cv=none; b=Haa33QC1hOWxa0+ppp2Vm1HqCk5G+3a83PS+cnM7Tdv9XASM+hXn45x6062LC0dmU1pYnSmTAuHirERA+yzOMb+MfD5q7IvPV/ddnVlOeRwa7JIGj4QnIjiHPz5Gge3tlUxCGSdYG3qCNLrUUQRk6pqofNNyh9ApjC5W3l/vnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742760; c=relaxed/simple;
	bh=M7D/j07sXCiX3umOa4PmP/ROxTjpH2Q+J8kImyrBWYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DVQaX61s7xzFEAjtDl6E5LgEzhLY6X4pCG/MXxsj5K/PQNxTnQtm/965YFAg1KT0kQzjDHbo3yIi+yEFz50yb7NMEqiZH6KrtfWLUzS34j4mSga0XtPecmE/svBpO8ns7HwP+GEux6SyyGLX4Pw2dptSjkdMbfl+IY1ERMWySjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGpASrfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4059C4CEED;
	Thu, 17 Jul 2025 08:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742758;
	bh=M7D/j07sXCiX3umOa4PmP/ROxTjpH2Q+J8kImyrBWYs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=IGpASrfmw1FDQQOEgSJMncOd/GV51zSPjIHldeEP7xjxpylB5G7IgmZteNAjDnunu
	 Cckxgdn8xqJ+AChr43i5R3K+HKWRb3oqnWXum8ir/i4H4uNMHRMnouv6dLMPTGgY+P
	 jQcERLetqSEzWkoSqNNb3ibnknvwo56qllmIkunmKjMBXx/QrJtvObD/YUGn5sMIKO
	 h/sEzduEONXMPxGSECcvBbAPqDOqBgxGJ9aHCpBMewHYFA626Ly6ZaIKRd93CVPln+
	 MByC6YFIIfnQccqy4CRahR0LfSkbHk0tmgkraPngf6P7Tf3cMooK8gFzVo6/uaPHXw
	 LzTXHG0NHDpOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE9C83F1A;
	Thu, 17 Jul 2025 08:59:18 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 17 Jul 2025 16:59:17 +0800
Subject: [PATCH] dts: arm: amlogic: fix pwm node for c3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-fix-pwm-node-v1-1-45021777efa9@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAGS7eGgC/x2MQQqAIBAAvxJ7bkEFlfpKdLBcaw9ZKFQg/j3pO
 AwzBTIlpgxjVyDRzZnP2ED2Hay7ixsh+8aghNLCSouBX7yeA+PpCY2koOziBiM0tORK1Py/m+Z
 aP+a/zN9eAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742757; l=1025;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=o5anEexAdJpsa2RWVePMFRWkvLxzPjZ8flBM5Edgoco=;
 b=WiA8ozMtVIYrzvTWtrwaxBiYQ1SRzjW6Ye/Tg8+39l0g9LF2BvFGboskS2qOMR+lmFFa8W+jL
 Wo+31HvFNR4DFp7Ch5eHYMjU1LfkqNrvMUZSOaxphRUWBHalHX/VvNz
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Fix reg address for c3 pwm node.

Fixes: 431a5281e701 ("arm64: dts: amlogic: Add Amlogic C3 PWM")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Fix c3 pwm node reg.
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index cb9ea3ca6ee0..71b2b3b547f7 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -792,7 +792,7 @@ spicc1: spi@52000 {
 			pwm_mn: pwm@54000 {
 				compatible = "amlogic,c3-pwm",
 					     "amlogic,meson-s4-pwm";
-				reg = <0x0 54000 0x0 0x24>;
+				reg = <0x0 0x54000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_M>,
 					 <&clkc_periphs CLKID_PWM_N>;
 				#pwm-cells = <3>;

---
base-commit: 58abdca0eb653c1a2e755ba9ba406ee475d87636
change-id: 20250717-fix-pwm-node-61ef27ba9605

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



