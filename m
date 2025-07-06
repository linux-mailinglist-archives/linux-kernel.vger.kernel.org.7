Return-Path: <linux-kernel+bounces-714669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C29AF6AE9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 08:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F734A0C68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 06:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AEA298CB7;
	Thu,  3 Jul 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uApeWnpd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A02951DD;
	Thu,  3 Jul 2025 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751525957; cv=none; b=R2ZbK5pd/D8ENTpXzEyqO84sZaC0I85bav0o8EOav4NPGJR0Nm39kSkzvL22LZDV6rvLV464gW+9CmUvJ216tPaqBS2zqc9RMm1UpMjwSsZOoUnsWYUwBgemYV1n8qDwCaGHIWbBi59IV2Rnsppy97PpUzH5nWto01iqO92I2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751525957; c=relaxed/simple;
	bh=8sxYXsa6vMa6Xdx/dnmdjle/i2ml7DSXMoYtGGWR74k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdMuGV0Yi4ZrcmwJO9Y3XPNMuN6UW89OohZ8LM3klUk4AJB9wn/hcLBbOZ53aY1N2Zvtquu8X1kpH25JJ3APFZrrXLmaJuBSViC07QxO8rF6233uQ+9mmzOBmv8J7dKt7uAj0NHpvrmmIvc0OZmr31Mrb5kl8Fsf3Psg3u54+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uApeWnpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97CD7C4CEF9;
	Thu,  3 Jul 2025 06:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751525956;
	bh=8sxYXsa6vMa6Xdx/dnmdjle/i2ml7DSXMoYtGGWR74k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uApeWnpd6snOiuU9F0Urpj0hh+GWR56Z9yWmrmb1LDV2FnTdIYWgoNH462bcl8cHr
	 9pziVh0oWiB09WSROyflE3U0RqFkXeizj1IUp0fhn4nwFugkUbxtk/15JTJweGq3LO
	 nrtKwny83SxvsS4++j190AtFFLReM/ptMN4XtyvgXk9apbyar68BiAACnZCeo/iPKv
	 eW5m1OPEqmMv04wMTBR+6thPvSUzzx5nwGC5FL9gZ+pzBZylD2gDFEl5HyomQbt84X
	 NO5ReRnubCZ9xpt0o0cmEj5wkcd0K7aeGA/EsGPsXZxh46BLNNHzn6ewuHQQk4fkQG
	 JP8dbOK7umq5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B883C83F09;
	Thu,  3 Jul 2025 06:59:16 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Thu, 03 Jul 2025 08:59:13 +0200
Subject: [PATCH v3 3/3] arm64: dts: qcom: x1-hp-x14: Add support for
 X1P42100 HP Omnibook X14
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-hp-x14-x1p-v3-3-affe103b4356@oldschoolsolutions.biz>
References: <20250703-hp-x14-x1p-v3-0-affe103b4356@oldschoolsolutions.biz>
In-Reply-To: <20250703-hp-x14-x1p-v3-0-affe103b4356@oldschoolsolutions.biz>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751525956; l=2874;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=+/n8Tbsm5YJtg0RptZgmN0A+zt0dLm93i5/1fSfNp+M=;
 b=IaqtdU9/G1jFOoQOIkWlcDhR2+vnDfJRXKxqNRiYXcdgr99FfbbJ60VfokhyMAOoaUSjPzzkb
 ZAAy+sgGEvRClWMGmcRcA8ytPzL8DwenlQcgSw12sixBMx2qY6HE5Gb
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

These laptops are the same as the already known 14-fe0xxx models, but
with a Purwa SoC, SKU number 14-fe1xxx. [1]

The supported features are the same as for the original Omnibook X14:

- Keyboard (no function keys though)
- Display
- PWM brightness control
- Touchpad
- Touchscreen
- PCIe ports (pcie4, pcie6a)
- USB type-c, type-a
- WCN6855 Wifi-6E
- WCN6855 Bluetooth
- ADSP and CDSP
- X1 GPU
- GPIO Keys (Lid switch)
- Audio definition (works via USB and with internal speakers)

https://www.hp.com/us-en/shop/pdp/hp-omnibook-x-laptop-next-gen-ai-pc-14-fe100-14-a4nd1av-1#techSpecs

Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  2 ++
 .../boot/dts/qcom/x1p42100-hp-omnibook-x14.dts     | 40 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 4bfa926b6a0850c3c459bcba28129c559d50a7cf..63bf3ccc11124a70efb09782b57970b274d80d49 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -333,3 +333,5 @@ x1p42100-asus-zenbook-a14-el2-dtbs	:= x1p42100-asus-zenbook-a14.dtb x1-el2.dtbo
 dtb-$(CONFIG_ARCH_QCOM)	+= x1p42100-asus-zenbook-a14.dtb x1p42100-asus-zenbook-a14-el2.dtb
 x1p42100-crd-el2-dtbs	:= x1p42100-crd.dtb x1-el2.dtbo
 dtb-$(CONFIG_ARCH_QCOM)	+= x1p42100-crd.dtb x1p42100-crd-el2.dtb
+x1p42100-hp-omnibook-x14-el2-dtbs := x1p42100-hp-omnibook-x14.dtb x1-el2.dtbo
+dtb-$(CONFIG_ARCH_QCOM)	+= x1p42100-hp-omnibook-x14.dtb x1p42100-hp-omnibook-x14-el2.dtb
diff --git a/arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts
new file mode 100644
index 0000000000000000000000000000000000000000..12e467aa0ee3dc24d77c28dfdcffafb6ef922c14
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "x1p42100.dtsi"
+#include "x1e80100-pmics.dtsi"
+#include "x1-hp-omnibook-x14.dtsi"
+/delete-node/ &pmc8380_6;
+/delete-node/ &pmc8380_6_thermal;
+
+/ {
+	model = "HP Omnibook X 14-fe1";
+	compatible = "hp,omnibook-x14-fe1", "qcom,x1p42100";
+	chassis-type = "laptop";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/x1p42100/hp/omnibook-x14/qcdxkmsucpurwa.mbn";
+	};
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/x1p42100/hp/omnibook-x14/qcadsp8380.mbn",
+			"qcom/x1p42100/hp/omnibook-x14/adsp_dtbs.elf";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/x1p42100/hp/omnibook-x14/qccdsp8380.mbn",
+			"qcom/x1p42100/hp/omnibook-x14/cdsp_dtbs.elf";
+
+	status = "okay";
+};

-- 
2.48.1



