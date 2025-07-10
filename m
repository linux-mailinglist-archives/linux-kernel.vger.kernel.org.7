Return-Path: <linux-kernel+bounces-726190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E644FB0092C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F267F1C25452
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F22F004D;
	Thu, 10 Jul 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="FGAvR0Vn"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC01279DB6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166258; cv=none; b=XnagDHzhDmtNidLaD9rlY0IFLCiJxuSncZAPXEx0hShezoTui277Rlz9NTKBy6T/6CPLfBrYTgrccZd0iQtqfW3f2NzypdqeOeSN1mPZPTlfzCLgWJdRXUDm35W93kxdLiAjxcB5QsKpoRq58Whii6kIVoa1bpmLHsqErbhSYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166258; c=relaxed/simple;
	bh=clxVsQKkrnR9wv8DKul25lTsvvLat2HJc7+oSMFkZlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gW5uXe0zwSaqyFhDAtJyco1KPx5VgzfGdSHxPwU6u5ub6reY0NdC6H9EZrwVOxw0WdGmEDmPLK3OsStftfqqpYrxSshXL3jU8Nj44GsMUh39n569VO9Pplqf/IRROzp9pR1KVI74IuPfqaFWsmVcjY4z9RN22fdH5M6FpPruUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=FGAvR0Vn; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=FGAvR0Vnmqx0SatLPRyP1DkZi8vetTQl0iHi7cvaP3dqxKoqaODOxKGZ3TXJCr0FqFQ3kSLJEE1ZR+4qTdzKyBPyBfx7FdnuBYrnmFH44iKaziy1Z/Ln9FYXP+nDEBIwwVhjEwS7PsZldvZu+ftDtvBG8MIJKB9fjwISGf54jrKbwCi9DwK5bspL9MhNdalGIz1y6XbBiOSnYNUcLGsajaXHl/65Ntwqs1YO9ZRr/OVzaMDSQgMu1wU06l9c2RLj9htcstW5XLLodMVc8rxVBqrUEM8/z91eHeh6DByTndbJsVYRJBbla7PYpM7Zq1ECUBbE0xvTUdVraLEc04PoOg==; s=purelymail3; d=purelymail.com; v=1; bh=clxVsQKkrnR9wv8DKul25lTsvvLat2HJc7+oSMFkZlk=; h=Feedback-ID:Received:From:Date:Subject:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1992400030;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 10 Jul 2025 16:50:42 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Thu, 10 Jul 2025 18:50:08 +0200
Subject: [PATCH v2 4/5] arm64: dts: exynos990-c1s: Enable USB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-resends-july-exynos990-dt-v2-4-55033f73d1b0@mentallysanemainliners.org>
References: <20250710-resends-july-exynos990-dt-v2-0-55033f73d1b0@mentallysanemainliners.org>
In-Reply-To: <20250710-resends-july-exynos990-dt-v2-0-55033f73d1b0@mentallysanemainliners.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752166235; l=1236;
 i=igor.belwon@mentallysanemainliners.org; s=20241206;
 h=from:subject:message-id; bh=clxVsQKkrnR9wv8DKul25lTsvvLat2HJc7+oSMFkZlk=;
 b=1wJaa5+YsmwD3pHwjOLrqecSCac9cHVyVOiwr8MaubnbBiW/Q1ZK5LLvwSNZH2LMpiXp6HKnV
 XI2nZIreuHoABl5Fdy5UWiQW76M5E7tpBax81YEn+Wd8kT+KCD6jG3Q
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=qKAuSTWKTaGQM0vwBxV0p6hPKMN4vh0CwZ+bozrG5lY=

Enable both the USB PHY as well as the DWC3 controller nodes.

Since we do not have any PMIC for USB implemented yet, use dummy
regulators until we do.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 arch/arm64/boot/dts/exynos/exynos990-c1s.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos990-c1s.dts b/arch/arm64/boot/dts/exynos/exynos990-c1s.dts
index 36a6f1377e92b40716c606cceb752f642ae603e3..9f0ad4f9673a87b4d75f3c7d208c8c37bb51fe2d 100644
--- a/arch/arm64/boot/dts/exynos/exynos990-c1s.dts
+++ b/arch/arm64/boot/dts/exynos/exynos990-c1s.dts
@@ -44,6 +44,12 @@ memory@80000000 {
 		      <0x8 0x80000000 0x1 0x7ec00000>;
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
@@ -113,3 +119,13 @@ key_volup: key-volup-pins {
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


