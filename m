Return-Path: <linux-kernel+bounces-815145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE9AB5603E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D4C1C230AD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0D92EBBB2;
	Sat, 13 Sep 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txXKhMAA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C372E8DF1;
	Sat, 13 Sep 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757759101; cv=none; b=jEPotKY4i7NgaxFTfR3Ky00WSRXQxpkHb/fPKXG0vwV7EjmAP33dN4A151sb++Gjflb4kJxJJ3i/QyahmQNQvMPUCZlE42M7ZuW7p9xoUeUmtevwOWylZoeU+vxy2KNbuyaGLovCs/KksIh06nqcxxRjHnuIL5j9MAAuk5086n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757759101; c=relaxed/simple;
	bh=F1Bd2arcxbTkCF48WNm4VUaJPRpk9xfWUd6LNWgngaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lpg5hbscj6XfLFti4PBcqbhpurrUBPzw+wJy+jyBZv9jozWD/4J512/EJVszuI/kAiKTL1mtmgKequCclJs2Vg0Ru6X9BFIMtBRbVYQV2A2OEJ6mKcpKRNRhIqZTYZPtPKRLaG7+iMPciFW8wOvAWNt1jwYfL6aHY4Ja0Ks9kX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txXKhMAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A6FC4AF0B;
	Sat, 13 Sep 2025 10:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757759101;
	bh=F1Bd2arcxbTkCF48WNm4VUaJPRpk9xfWUd6LNWgngaA=;
	h=From:To:Cc:Subject:Date:From;
	b=txXKhMAAMyPNO2QN8sEOlhqm/B0jycwB+TpbbHXDCOAHEF1XJ2hpharCoYFO223kx
	 nNUDHubMapubYHp9/sme7sUiS43RtYSBfFYqIXSpcI+vgfwAfVjJG3/SNDXgN3JnRR
	 Q1v3L6u+Pt+9eVCQxkpgR2CXl0NXn3R2ZUQZqSUHegNeN8XnqrM11BzGgYLEBqK1d7
	 ODfsqR6ojyC3nXmXeTOeW2vg+l4bP97f3BL9eEsrXGQCxymtzQUJ9yvn0qPsm3aCEb
	 AcQjmGdl1QErVvN1vreOykTbur2X6KUMsjXoECz5AIbHDBk3Yhwg6sRYZvuuQwxnmu
	 VT6+12u0MmMCQ==
Received: by wens.tw (Postfix, from userid 1000)
	id A193C5FC8D; Sat, 13 Sep 2025 18:24:58 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: allwinner: a527: cubie-a5e: Drop external 32.768 KHz crystal
Date: Sat, 13 Sep 2025 18:24:48 +0800
Message-Id: <20250913102450.3935943-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The Radxa Cubie A5E has empty pads for a 32.768 KHz crystal, but it is
left unpopulated, as per the schematics and seen on board images. A dead
give away is the RTC's LOSC auto switch register showing the external
OSC to be abnormal.

Drop the external crystal from the device tree. It was not referenced
anyway.

Fixes: c2520cd032ae ("arm64: dts: allwinner: a523: add Radxa A5E support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index 71074b072184..e333bbaf01d3 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -24,13 +24,6 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	ext_osc32k: ext-osc32k-clk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <32768>;
-		clock-output-names = "ext_osc32k";
-	};
-
 	leds {
 		compatible = "gpio-leds";
 
-- 
2.39.5


