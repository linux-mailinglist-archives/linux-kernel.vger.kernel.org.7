Return-Path: <linux-kernel+bounces-845187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A0BC3D06
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317A34057BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC821FF3B;
	Wed,  8 Oct 2025 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="mQCC8b7q"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA82EBB96;
	Wed,  8 Oct 2025 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911724; cv=none; b=SPh17e/O1TWDZlRjeY02Ja8zIQ1YQAzUfScRrqefKtgj0xM21EmagHaw/MYazNreLvSq905tDlycyuYvcsgfWmFjfaYNWoCxBtJADbyLT/N/1EjpiLOVVnCFIMf8XtrMu2Zkh1puqfCSODs10wt3jbrC/Mb/XGOf+Bb2sKO2boY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911724; c=relaxed/simple;
	bh=K+0GF3zQ+KXrkkbJ4B7e0lEfxPNeqouIO11wYtJ8Z4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtR9Ej64rDGnqpkB7ZOtQSqG3hwHJNcFTWpscdDzk5xzG/uKD2bPYtg8aHsFb/lilvCZTeafm2SMVEmB5jeDPTAgdLRp8ciHKB+R0bxFZPJSI8g3Zl6Up3KxccP5RkKQooicRFy9GzYdHo/ImHLBDtfwQn/vTIprUx7T9hRwun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=mQCC8b7q; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1759911719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H8SPZkt6+sp/5jeMGqBWc/VCT7Uionl7zaKARBI8kLs=;
	b=mQCC8b7qJVTJ2Gh3LAMFqp3KGOlG7jriSk0cpd84DiSOlgRAkKL+A3k30friRJSM/2L7JZ
	5YKRrU4J1Q/GLnkw4b88ld7CyL2IVWbJjKuaeBpaO5UX8+c2DNJ7zB/Dl+TgzKLO0I6gXi
	YNsJggxr4usXcSfziAd+Cxy3GrEGN/a9uj3Un0hCYseiQkoAVkJmTf+bo61XsHXZfiVrjm
	mDjkeZFbKRIJlNkvmlFrct/H/CtWHml4fRGuXKM24/7WjMid3iXSPP5wLtaEuDz81Wr0NW
	FIcFAi35WN4gZ4et/POS89hqSWQuydEmZJRQS0auvEq7p3GMy9zcCxhEwhRMow==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Jonker <jbx6244@gmail.com>,
	Alex Bee <knaerzche@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] arm64: dts: rockchip: Drop 'rockchip,grf' prop from tsadc on rk3328
Date: Wed,  8 Oct 2025 10:21:22 +0200
Message-ID: <20251008082143.242270-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The 'rockchip,grf' property for tsadc in rk3328 wasn't actually used in
the driver and is no longer allowed in the DT since commit
e881662aa06a ("dt-bindings: thermal: rockchip: Tighten grf requirements")

So remove that property which fixes the following DT validation issue

  tsadc@ff250000 (rockchip,rk3328-tsadc): rockchip,grf: False schema does not allow [[58]]

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 283d9cbc4368..03b7c4313750 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -598,7 +598,6 @@ tsadc: tsadc@ff250000 {
 		pinctrl-2 = <&otp_pin>;
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
-		rockchip,grf = <&grf>;
 		rockchip,hw-tshut-temp = <100000>;
 		#thermal-sensor-cells = <1>;
 		status = "disabled";
-- 
2.51.0


