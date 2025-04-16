Return-Path: <linux-kernel+bounces-602629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EADA87D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 12:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672CE16138E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E280726E147;
	Mon, 14 Apr 2025 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLhY4Um1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C1267AF5;
	Mon, 14 Apr 2025 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625576; cv=none; b=SjprwREhfj/Oeue2DVrWtdc9wZujbIYGfshSciSan9CkbYPSeJc+0XsKYqBCX8CnNr2FblV0guDyCZ1v8q8sblLtZgv4Ny4yUGK8rL6KAwMygJqJemAusq733myqRoSNVKYYOR8HtTpavmoRLN/0o0eanHS9AHY4FJEdXYedfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625576; c=relaxed/simple;
	bh=HLUNHReE0cNLO6CqkVo6sXtk4KZJ2890NAAWXXyNoFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+EhcTrCwK6X61KPAk4lBcT1DyoXnu3VOZMnJkyy+vDeo8NU65kcsblwAB4RXoX+nBOfjE0dW9FwJWSm9W4F8A8/Qgb6GXSO8Vswrg8zPh5sYrYF0a5HBekAdyIuvd3w1RyzHLNaWaCg3eNAGrC5ZkWG60QMHgsm/k6Viz/sGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLhY4Um1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16DB3C4CEF1;
	Mon, 14 Apr 2025 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625576;
	bh=HLUNHReE0cNLO6CqkVo6sXtk4KZJ2890NAAWXXyNoFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CLhY4Um1h3j2aFquJGFPvC38oqN+YOCoEPZdww7e9guZVqXFB2xazsCAGRitei6df
	 SjgpylDfKlNfGRKTtzNHuie0We5swhdJHhbbdOVHZv/O5vZUIysOTrVGbo0C6aon6p
	 F3hpkLtX4GG+ZWwR5xBIEPLmtiso+uAvGZ0FDklb+HKFvK46HxOZIvoy0njsOBaDuh
	 VBEYOLU5N1nvb8StFWh5X8c3NZUPoGUFd3IxhMGwVv+LFVLo6U9P/jfDvq1Bd4pbDc
	 ZhtkYqqgTN3OL1FppvbtLMxyN3RNVFK9aUR/OAhPKluijAO7jhS1LISN3oxGbz1L6u
	 OlevZIWu+F0JA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFB0C369B2;
	Mon, 14 Apr 2025 10:12:56 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Mon, 14 Apr 2025 18:12:34 +0800
Subject: [PATCH v2 7/7] arm64: dts: amlogic: S4: Add clk-measure controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-clk-measure-v2-7-65077690053a@amlogic.com>
References: <20250414-clk-measure-v2-0-65077690053a@amlogic.com>
In-Reply-To: <20250414-clk-measure-v2-0-65077690053a@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744625573; l=767;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=itRtutR2PIVs/kAFr6Titwp0GUUTkodKKnworvlokhM=;
 b=JEJNCUO49wWdoCvxqJSItcfefAv5rWsX4x/UkgYRkHFA0qg8SFWeO9i1EIxsud5Y+obbjddCI
 3/5z2wWBSNGC9HWTbopBDAUc3pYnQy0DWo/8Z9Z1FJklsqn/o1kSqlT
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the clk-measure controller node for S4 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index 957577d986c0..9d99ed2994df 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -629,6 +629,11 @@ internal_ephy: ethernet-phy@8 {
 				};
 			};
 
+			clk_msr: clock-measure@48000 {
+				compatible = "amlogic,s4-clk-measure";
+				reg = <0x0 0x48000 0x0 0x1c>;
+			};
+
 			spicc0: spi@50000 {
 				compatible = "amlogic,meson-g12a-spicc";
 				reg = <0x0 0x50000 0x0 0x44>;

-- 
2.42.0



