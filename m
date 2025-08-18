Return-Path: <linux-kernel+bounces-774146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37897B2AF1B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272B9565C89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838832C32D;
	Mon, 18 Aug 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kvOsrAjx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA132C302;
	Mon, 18 Aug 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537161; cv=none; b=K5rBRUIACbunhCuUXLeiqNCdnhjJmZU1aM7YA7QOMLTHkykMYnYIgCOkgARlozoiMCi2G4CdoW1ihmMrXiAoxKnsDFHV2CK865ggRByaOvxj15ObA47a87aOVsfZIQDuXZBV5wGyIVgY3bK9FEPfVm7AKG1dmYoDiJCFNfQXju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537161; c=relaxed/simple;
	bh=SAYLvt+TdvOMWkry0P3jnEHv9OeBgLFTEiK5Js0VPL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ldO+NKKOhF7ud61i6BOnoFwWNHc8+lsNBAjVrOAfPe59WbewvjeNhSME8bTtKxgt504+QTOjjirG1rZnTbvwTMD7o8hWIMiK6I7YY08nIIRsL4kJmGXu0qK1VdfNNi+084bYLLv3VApIu022wROa/8mQnjwgLSAcZ7+RkpMowWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kvOsrAjx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755537154;
	bh=SAYLvt+TdvOMWkry0P3jnEHv9OeBgLFTEiK5Js0VPL0=;
	h=From:Date:Subject:To:Cc:From;
	b=kvOsrAjxoBCrN6ZAjhHp+z6Fuy0Lo20VFIjJfaDaDPOCCe7o0JbPjwjYS76J3ubGS
	 qWyd/zPiFeiVp7gohcE4Apj156HY4FeK0naTjIE4aMNyogQNoHW5f1ulEKp8N3x7o3
	 clRVSYPBLI8GmMjwN1qULWlx2p8gWwti1duFk7LY1BqOh0eeskM7g33w8sn8+vPopz
	 Ho2RU+lzNU2m+iwEitCoL5/vmWbtKsKVegkaJo3WlCjCZXUbT5gRYhwtZgs094fqld
	 2986+acmaY0ilq+Mdwvvgp+X3L6+2PNnk9TYqKhwgSJP8S/Qd37H7z1fmDXfNn/YYk
	 KbRBagbd5lMGQ==
Received: from jupiter.universe (dyndsl-091-248-210-167.ewe-ip-backbone.de [91.248.210.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3B4B817E0DE3;
	Mon, 18 Aug 2025 19:12:34 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EF42B480044; Mon, 18 Aug 2025 19:12:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 18 Aug 2025 19:12:23 +0200
Subject: [PATCH] arm64: dts: rockchip: correct network description on Sige5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-sige5-network-phy-clock-v1-1-87a9122d41c2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPZeo2gC/x3MTQqAIBBA4avErBtQSZCuEi3KRhsKDY1+iO6et
 PwW7z2QKTFlaKsHEh2cOYYCWVdg5yF4Qp6KQQmlhZEGM3vSGGg/Y1pwm2+0a7QLSiuF040ZtVJ
 Q6i2R4+s/d/37fiaJqhRpAAAA
X-Change-ID: 20250818-sige5-network-phy-clock-1c10f548b522
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=sre@kernel.org;
 h=from:subject:message-id; bh=SAYLvt+TdvOMWkry0P3jnEHv9OeBgLFTEiK5Js0VPL0=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGijXwGfiXygZXsYaSAVonahjYg5JoVKFCg4Q
 9VsgfeiOl0lzIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJoo18BAAoJENju1/PI
 O/qaZIAQAIivfyWW5RnxUMO+tth3rMGHps2imw6cUeNR4+0t9cuxpBEADAt80yezHZSyh+zsWxa
 InHZXkOFhskpyVidwH20dSEH0nOLqfCppPrkMSBZWUtw9C7b7BEnsldbEhAzCL0FieWbcazhjmq
 JtBVRaLQAvfyQvX4NuWJlkTgOlfSztBRMVEnsbDJVqmAEuUk/GRCyH+WMNV7L9YpoE8JZkLkcy3
 KV6JGwY4R50uakSP0mGjCErSo03xyKFM9CKMD6P3NVfN6H6Gy5gWb1HFb4ZozKJQblkr9n5nxH3
 seEihsfl+BPFnJXEr+pNWEgRZ66GGEllIte9hGnndUWLwKRlC8yw6Q1d8gYFHaQHqQ+If+IEUDo
 vFmy9Fh7M8/afwO7GF5KLF4icJWbGo0iNNJK6jnHofAe54ZHsA+/zMSxyf/HrbCID+ClStZHDdL
 iSgrMNzj299F/KmnOR2JJKdFUIHYdWLBq75vljDWrBwhLS0M0X/cJ0vi9vE0SSmFoYC/z0LDijE
 a+5oAgxw4wkRqJ9Dvpsl7Yl9w8egD+C6+GSxTM9G1iOqsmGda9V5fKh3WG+CStHKHe8jekieNSu
 +0bD8nubWi9aBe13EoFJV1bJc5JpyUHjJftLMwii8LZVNYtd4ZD5MgJaML4bou4fopZC80ayXc4
 SsZ+jPlbGL6q2WEuwKbIgFQ==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Both network PHYs have dedicated crystals for the 25 MHz clock
and do not source it from the RK3576.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts b/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
index 101e2ee9766d7bf5dc09eb29b66f5afd89985b76..3386084f63183efe62beea86bc6fe310cc4ed565 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
@@ -302,8 +302,7 @@ &gmac1 {
 		     &eth1m0_tx_bus2
 		     &eth1m0_rx_bus2
 		     &eth1m0_rgmii_clk
-		     &eth1m0_rgmii_bus
-		     &ethm0_clk1_25m_out>;
+		     &eth1m0_rgmii_bus>;
 	status = "okay";
 };
 
@@ -784,7 +783,6 @@ &mdio0 {
 	rgmii_phy0: phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <0x1>;
-		clocks = <&cru REFCLKO25M_GMAC0_OUT>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&gmac0_rst>;
 		reset-assert-us = <20000>;
@@ -797,7 +795,6 @@ &mdio1 {
 	rgmii_phy1: phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <0x1>;
-		clocks = <&cru REFCLKO25M_GMAC1_OUT>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&gmac1_rst>;
 		reset-assert-us = <20000>;

---
base-commit: e05818ef75bee755fc56811cb54febf4174d7cf2
change-id: 20250818-sige5-network-phy-clock-1c10f548b522

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


