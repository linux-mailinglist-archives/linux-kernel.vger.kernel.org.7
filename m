Return-Path: <linux-kernel+bounces-770472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB59DB27B47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A00D5E0784
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA72D0C76;
	Fri, 15 Aug 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSvE7d5T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55C238D57;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247061; cv=none; b=vBvQNNTnKIicNl8Is2YHHjfk7pd49tSM9ZozWi1sUPaivdLZUCHD2oj1jjAjFFB4+6uB4LnWGmcFk2X+bW6ztUt3fYRAdVjB/+c1CkrV+Yk6LvAGWwsTutZqk2hTB1ipDUDvWPQaQiohhetNqhmUgx9k1/0fO2by676lUqs0wgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247061; c=relaxed/simple;
	bh=HXEA9l6YKygvEuv8M/1chWcv0RBJVJ1iSq+R8A6ihQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=njEoeDqPTFz8FkUBYh2A+DPasZFT22uL9Ktz9VaMN2MsL/fjgP7+/mvkSzV2pyWTaIG3uYLn7g/wFdygu/YKZa/Qn79GEeVxRTaeWpo4elWBQ70B7PjgT2XdrKapKN1tgnBP4bxtiO4DxQRACnHLs1Re07PRfH3OS7RXpcUTUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSvE7d5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8531BC116B1;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=HXEA9l6YKygvEuv8M/1chWcv0RBJVJ1iSq+R8A6ihQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bSvE7d5TakjlIb8jEIxsvTW1b0Kf3uGEyNv+PL1hKILLgwp82aP3iFdmO/0+pirhL
	 vpNItUZH9tT98ak0RnGqPUNHYlPDet+gZ/GYrDIukTxZdEOvxweQLxN+jC/GmSVeIO
	 n/UIc0c8RfSNIHlJvpur+dkhSdsyWHFmt9OKrNg1fOQIIxMhMioEUXsa2rcvDU/638
	 iZU3wCrbLMgEZoskQ1TJF4NUsNA64jXiLLmGpaYjIhbxB5ogjQu76xwEoDbHM+h0NV
	 gmYGZtGtCQql520sH9+6l6yLH5geR3q/2q0wbP/BjsCfaQ3H1ZnFls/or5ZK9DN3EF
	 /2C7+EXEV8EdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE9ECA0ED1;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:33 +0800
Subject: [PATCH 07/13] ARM: dts: amlogic: Unify the compatible property for
 clk-measure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-7-59f04ba67457@amlogic.com>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247057; l=1245;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=ogLhza13Z3+sRdNuog3wi18IBAswOBl0lnCwSfN1OrY=;
 b=I/pWu4T97rWRApNMfafG00zPnjp6BitC2JwcExuQmhW9xDCyeJcyQ2yhM37tCrDcoUd2rnXUb
 fGhA362SrvHB/Xc4jqb9tkx1TFny57iIjqx6o3+bwhiHTlcLanyy9i6
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The clk-measure IPs across Amlogic SoCs have minimal differences, so
they can be managed with a unified compatible property.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm/boot/dts/amlogic/meson8.dtsi  | 2 +-
 arch/arm/boot/dts/amlogic/meson8b.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
index 2f9ecd2eb4cf..db47e1de0b20 100644
--- a/arch/arm/boot/dts/amlogic/meson8.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8.dtsi
@@ -460,7 +460,7 @@ pwm_ef: pwm@86c0 {
 	};
 
 	clock-measure@8758 {
-		compatible = "amlogic,meson8-clk-measure";
+		compatible = "amlogic,clk-measure";
 		reg = <0x8758 0x1c>;
 		clkmsr-indices = <0>,
 				 <1>,
diff --git a/arch/arm/boot/dts/amlogic/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
index 74fd000569a2..3b1d2d2ad7a2 100644
--- a/arch/arm/boot/dts/amlogic/meson8b.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8b.dtsi
@@ -414,7 +414,7 @@ pwm_ef: pwm@86c0 {
 	};
 
 	clock-measure@8758 {
-		compatible = "amlogic,meson8b-clk-measure";
+		compatible = "amlogic,clk-measure";
 		reg = <0x8758 0x1c>;
 		clkmsr-indices = <0>,
 				 <1>,

-- 
2.42.0



