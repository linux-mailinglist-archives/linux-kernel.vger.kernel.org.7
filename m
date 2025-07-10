Return-Path: <linux-kernel+bounces-726191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F8B0092E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D045417D933
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18652F0C55;
	Thu, 10 Jul 2025 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="L76XS+hK"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D8285062
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166259; cv=none; b=DM7mYfd0hducyn76aUXeJWStY6fCRpgcAGPgr75T4V2PQOa6OpVYSzo5pnTzvcvTpeFmk/Z31jT+QbZgwtGWcaWovXMTKVdEVSls9XPwgUFaCOoponnqCSwOfNbwH1Gl2lkXBhpwk4fgceeabyg6mLl8QlVq/1brCnKM1XBVgfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166259; c=relaxed/simple;
	bh=d90e+aG/dLPhZ45Wax0yq+hKJxVgTdMsCYq09/QZQ0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jONEqxTFcGL2EnczVgrXeSsaGe4HARydhVvzQx50HOJvJmJYXw6aXA824NIRVL8g/Ini1cgaM60JMWD5Z7rxL9VWfz8PMMHzbJ1a3d4hFfjjPpwNW9GrFROdNHHn6Tueniw+FZ5UU+2jPbk/XBOCNfulzRwjl+nDw4tkw9vq1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=L76XS+hK; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=L76XS+hKOD8ApKRkKj8a913AobIqyRrLPXK1bGS+OfVWOFrcoIZgE69W7luqJZu5heDPAnc01EOKmhaMlZ/BNO/LAX4qJx7ooFdaFKrGuQ1RMhtVZGxaEnIjAgkTWgZx0s0vgKBKDDlS6CdCo6emKCm30bsmFyc6kqomBIWaRTCx58OKPVtsLrH1Dr6iQV1WTz64crkcL04nK5EGA4eMxA5aSra/asG8juTGrrlrKBummXm4YVFxmIujkaL32CvXgh4F5HC+zxvPUwFSw3KAGO+zUmPBySDKUmLKVYMhy73bU6E22HZaso0u217jROgSTWT1ow/djKTxqg+C7P+/Vg==; s=purelymail3; d=purelymail.com; v=1; bh=d90e+aG/dLPhZ45Wax0yq+hKJxVgTdMsCYq09/QZQ0s=; h=Feedback-ID:Received:From:Date:Subject:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1992400030;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 10 Jul 2025 16:50:41 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Thu, 10 Jul 2025 18:50:07 +0200
Subject: [PATCH v2 3/5] arm64: dts: exynos990-x1s-common: Enable USB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-resends-july-exynos990-dt-v2-3-55033f73d1b0@mentallysanemainliners.org>
References: <20250710-resends-july-exynos990-dt-v2-0-55033f73d1b0@mentallysanemainliners.org>
In-Reply-To: <20250710-resends-july-exynos990-dt-v2-0-55033f73d1b0@mentallysanemainliners.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752166235; l=1301;
 i=igor.belwon@mentallysanemainliners.org; s=20241206;
 h=from:subject:message-id; bh=d90e+aG/dLPhZ45Wax0yq+hKJxVgTdMsCYq09/QZQ0s=;
 b=DJQ55NTYx9pLwW/yp6Ykfs9HFU1x2wgbHI33WReelNFvAhuJcejHgP/Lxg4gUwKeQKZrFCNmO
 iK+FJOhdMw4CgCCEj3C/yGuZFPZOknIFosUVBCF3Hkp1j7soO0Zlcv8
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=qKAuSTWKTaGQM0vwBxV0p6hPKMN4vh0CwZ+bozrG5lY=

The x1s family uses a shared USB configuration. Enable both the
USB PHY as well as the DWC3 controller.

Since we do not have any PMIC for USB implemented yet, use dummy
regulators until we do.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 arch/arm64/boot/dts/exynos/exynos990-x1s-common.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos990-x1s-common.dtsi b/arch/arm64/boot/dts/exynos/exynos990-x1s-common.dtsi
index 55fa8e9e05db8af51109d20d74cbd7b9a2af38df..7b97220cccb7442dbc5a9f31ae9b9124bee85c62 100644
--- a/arch/arm64/boot/dts/exynos/exynos990-x1s-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos990-x1s-common.dtsi
@@ -27,6 +27,12 @@ framebuffer0: framebuffer@f1000000 {
 		};
 	};
 
+	/* TODO: Remove this once PMIC is implemented */
+	reg_dummy: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "dummy_reg";
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -96,3 +102,13 @@ key_volup: key-volup-pins {
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
+
+&usbdrd {
+	status = "okay";
+	vdd10-supply = <&reg_dummy>;
+	vdd33-supply = <&reg_dummy>;
+};
+
+&usbdrd_phy {
+	status = "okay";
+};

-- 
2.47.2


