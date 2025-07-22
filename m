Return-Path: <linux-kernel+bounces-741288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24395B0E272
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5946D581021
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064F27F163;
	Tue, 22 Jul 2025 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFA8FgKU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACAA20C037;
	Tue, 22 Jul 2025 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204622; cv=none; b=FugjJxUtV2rWw0p9jR7h9pDK69W3JSKzamxUV0LylkwvS9mKQAmc9jV3OdN4HJR0yA6JQC6g+4OCtQc8WxoGjx5dcHuHifuEzz6u/bLy9/GzAo+evkktZ9p7fo0DTUXwBl6ywoUEM9ljfHj/EBguYBU2jtvk/W/gQiPBsK/1ABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204622; c=relaxed/simple;
	bh=w1K4bvODgaupuZ6rTZXJyHZe+HGhv/jTyPnbCIz8yz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TORl1fZUrFJLVOXY+/l9/WoG/3gc+MGGEdA7dSFges+MmZxEmk1v8eGFzR51bBbf8lZdb86mhzRoOuY6zEgjno09BZJU45geaKyJ3BPge7pFQ6G37vZqzx5+R8e44LITV1NAYYzH7EzImoRqtzQc62fC4J7hnyWU5rM80axl19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFA8FgKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01743C4CEEB;
	Tue, 22 Jul 2025 17:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753204622;
	bh=w1K4bvODgaupuZ6rTZXJyHZe+HGhv/jTyPnbCIz8yz0=;
	h=From:To:Cc:Subject:Date:From;
	b=CFA8FgKUfxPDnZ3oYkOZ86kNnByY29sDQi+lr7AXgJlmDghA5oCtLETsYqBplCXGm
	 2WmCp4OG7tGny1nCj94jOPRaEeJHXqNZRJaCZ+Kv0v2olRyLTCQGd6+9jrNjkk3XAO
	 dGHLQuDsbQbNoNsbvwobiov9EVpkqHJRmylodK4BiIFECMrg32GIbtx8DXhLULx2YW
	 JTBW7kEWqZ6Ue9VsZmgzh4mMlDT74ZbPErX8rAw6cUSWyhL9B4dIr+wWRIQUVcFatE
	 bL3MjD15bGo15RDXnRubQMG1WfsxDxJB+0rd7CS3s1ogVMkUjZVyRPJSHU+6A0dPKb
	 LliRIGvFiU4+Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Ben Ho <Ben.Ho@mediatek.com>,
	Fabien Parent <fparent@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mediatek: mt8183: Fix out of range pull values
Date: Tue, 22 Jul 2025 12:11:52 -0500
Message-ID: <20250722171152.58923-2-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A value of 10 is not valid for "mediatek,pull-down-adv" and
"mediatek,pull-up-adv" properties which have defined values of 0-3. It
appears the "10" was written as a binary value. The driver only looks at
the lowest 2 bits, so the value "10" decimal works out the same as if
"2" was used.

Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
Fixes: 19b6403f1e2a ("arm64: dts: mt8183: add mt8183 pumpkin board")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
This is just a few of the warnings related to mt8183-pinctrl... Mediatek 
is #1 for DT warnings on arm64. And by #1, I mean worst. :( It would be 
nice to see some progress on fixing them. Otherwise, seeing new Mediatek 
bindings rather than fixing the existing stuff makes me grumpy.

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi  | 14 +++++++-------
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 400c61d11035..fff93e26eb76 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -580,7 +580,7 @@ pins-cmd-dat {
 		pins-clk {
 			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
 			drive-strength = <MTK_DRIVE_14mA>;
-			mediatek,pull-down-adv = <10>;
+			mediatek,pull-down-adv = <2>;
 		};
 
 		pins-rst {
@@ -609,13 +609,13 @@ pins-cmd-dat {
 		pins-clk {
 			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
 			drive-strength = <MTK_DRIVE_14mA>;
-			mediatek,pull-down-adv = <10>;
+			mediatek,pull-down-adv = <2>;
 		};
 
 		pins-ds {
 			pinmux = <PINMUX_GPIO131__FUNC_MSDC0_DSL>;
 			drive-strength = <MTK_DRIVE_14mA>;
-			mediatek,pull-down-adv = <10>;
+			mediatek,pull-down-adv = <2>;
 		};
 
 		pins-rst {
@@ -633,13 +633,13 @@ pins-cmd-dat {
 				 <PINMUX_GPIO33__FUNC_MSDC1_DAT2>,
 				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
 			input-enable;
-			mediatek,pull-up-adv = <10>;
+			mediatek,pull-up-adv = <2>;
 		};
 
 		pins-clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
 			input-enable;
-			mediatek,pull-down-adv = <10>;
+			mediatek,pull-down-adv = <2>;
 		};
 	};
 
@@ -652,13 +652,13 @@ pins-cmd-dat {
 				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
 			drive-strength = <6>;
 			input-enable;
-			mediatek,pull-up-adv = <10>;
+			mediatek,pull-up-adv = <2>;
 		};
 
 		pins-clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
 			drive-strength = <8>;
-			mediatek,pull-down-adv = <10>;
+			mediatek,pull-down-adv = <2>;
 			input-enable;
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index dbdee604edab..7c3010889ae7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -324,7 +324,7 @@ pins_cmd_dat {
 		pins_clk {
 			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
 			drive-strength = <MTK_DRIVE_14mA>;
-			mediatek,pull-down-adv = <10>;
+			mediatek,pull-down-adv = <2>;
 		};
 
 		pins_rst {
@@ -353,13 +353,13 @@ pins_cmd_dat {
 		pins_clk {
 			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
 			drive-strength = <MTK_DRIVE_14mA>;
-			mediatek,pull-down-adv = <10>;
+			mediatek,pull-down-adv = <2>;
 		};
 
 		pins_ds {
 			pinmux = <PINMUX_GPIO131__FUNC_MSDC0_DSL>;
 			drive-strength = <MTK_DRIVE_14mA>;
-			mediatek,pull-down-adv = <10>;
+			mediatek,pull-down-adv = <2>;
 		};
 
 		pins_rst {
@@ -377,13 +377,13 @@ pins_cmd_dat {
 				 <PINMUX_GPIO33__FUNC_MSDC1_DAT2>,
 				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
 			input-enable;
-			mediatek,pull-up-adv = <10>;
+			mediatek,pull-up-adv = <2>;
 		};
 
 		pins_clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
 			input-enable;
-			mediatek,pull-down-adv = <10>;
+			mediatek,pull-down-adv = <2>;
 		};
 
 		pins_pmu {
@@ -401,13 +401,13 @@ pins_cmd_dat {
 				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
 			drive-strength = <6>;
 			input-enable;
-			mediatek,pull-up-adv = <10>;
+			mediatek,pull-up-adv = <2>;
 		};
 
 		pins_clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
 			drive-strength = <8>;
-			mediatek,pull-down-adv = <10>;
+			mediatek,pull-down-adv = <2>;
 			input-enable;
 		};
 	};
-- 
2.47.2


