Return-Path: <linux-kernel+bounces-825779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E588B8CCDE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE887C70C5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D659306492;
	Sat, 20 Sep 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU719B0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D622FE076;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385493; cv=none; b=o1XJdDtgyZTCklYM0nPi7FeO9Eht8WgJvo29+IYLEGjYGdYcW9i2BidD52uzqziAF3zwpw6iC7ODdBmtzT2M14YCZ3rGkUF6J5IO4Vraeg/juylQyPnNxxwsid2iyzUZJEnR7Ray0ktgcrR/3edDgdVIsNca4z7wM401fN0NDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385493; c=relaxed/simple;
	bh=8AVmMZ4i5vlJy4yy6ArsXwdN8LZl6h2LuSGyZF1y3pQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoM+CAf6l667ZBOr54oUccBNyOsvLGWBn42XVL43o1u8yd/C9hXE9sZI+/l2Luo/wBHcKDEve71HtSCPmrGd37yItSpNJR5IhsZHshOrR2/jOSOqFwljs3lzlEebnR3wdcPMN5LYaQZANXGTspT1tj8xI0n4YamX9H7bRd9bi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU719B0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73CC6C19422;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=8AVmMZ4i5vlJy4yy6ArsXwdN8LZl6h2LuSGyZF1y3pQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hU719B0YQ4LUE0/+mPl3T6HjAIxuI8g5AadgBId1wj+jXt9njbl/pTqdrjBpnoJ37
	 HUWKaZMGrORG3k1Da4mYpLVz+25MDZvqyQ4zDjfgEQxKOISriLOmF6cj73I02LRk0W
	 qd0wwPIJzPDbzmHl9vdeLPV6+V7v/Ci1T/wBM1gzTJ9/5caS2v18NX/LdtoSVEUQH8
	 MI7pNy1ldUbJg6k/F+X1HdMnBkGYftAnX8298BA66DG8AEUz5nB7yjUjbu7NqZmpKK
	 m6aZlyicPKWZCbgVQa0Oi8+IC4BrG5jXaunDCPv9C0ygXE6TIfP0a+T2Qg2xFZSwRN
	 9fF7Fm8nqMqyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB4BCAC5A0;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 20 Sep 2025 20:23:32 +0200
Subject: [PATCH 07/10] ARM: dts: mediatek: mt6582: add clock-names property
 to uart nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-mt6582-v1-7-b887720f577d@protonmail.com>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=1434;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=IJ2WpBgydGyDmriFnyhyzls81B4aPjYb5NY6k/JiK2Y=;
 b=VAp6w9Z5osx1mLNbqsginU96nD8BYUh3ydYdVzHCMjEzRr/CrmZ2ZHQ8JbulRfNn5Th37kQyh
 n5+6W4naoVNCBrFrIuWqNaARBOwLiUqEpeQMwx9EANcZGw5ZhO4CPwF
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

From: Cristian Cozzolino <cristian_ci@protonmail.com>

Other SoC DTSI files define this property for their uart nodes.
Do the same here too, to be consistent.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6582.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/mt6582.dtsi b/arch/arm/boot/dts/mediatek/mt6582.dtsi
index 54d675ecb390c52c7ca0f406155bfc59e32137ec..82564c740c2182448f8f88bbc2b22c4fef1fdeef 100644
--- a/arch/arm/boot/dts/mediatek/mt6582.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6582.dtsi
@@ -97,6 +97,7 @@ uart0: serial@11002000 {
 			reg = <0x11002000 0x400>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
+			clock-names = "baud";
 			status = "disabled";
 		};
 
@@ -105,6 +106,7 @@ uart1: serial@11003000 {
 			reg = <0x11003000 0x400>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
+			clock-names = "baud";
 			status = "disabled";
 		};
 
@@ -113,6 +115,7 @@ uart2: serial@11004000 {
 			reg = <0x11004000 0x400>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
+			clock-names = "baud";
 			status = "disabled";
 		};
 
@@ -121,6 +124,7 @@ uart3: serial@11005000 {
 			reg = <0x11005000 0x400>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
+			clock-names = "baud";
 			status = "disabled";
 		};
 	};

-- 
2.49.0



