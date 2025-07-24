Return-Path: <linux-kernel+bounces-743725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43E1B1027C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE85E5860FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E420827056D;
	Thu, 24 Jul 2025 07:56:56 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEFD225D6;
	Thu, 24 Jul 2025 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343816; cv=none; b=BZGc8L0V3ooAse/572DeUMYAgmEfBGUvubi1UA9pLO7Dcop1rLo4rTX/MDg6ondCJXcWXsclG26GiaN1s7bWwU6xUhMqUYq6dgYpZ4uSjq8/X1759JR+A52BgTCuAQW0K9g0wTTuMew8gIEQjJXqC7QSPozkk4pvdg8mReXc0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343816; c=relaxed/simple;
	bh=ghBB/PHxWvRV+AUck2mi8CWGeB3M55wT/OdGADJT6W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrSR82RzoDO60lglU8+Xl/Aj7j6LE2co3LbXSJXH2BsTGHlU6F1N7LJqeXrwNr49eIPtzvnBAVU1VM7txJMFABtgp6223RO6DCSVEVrSW/sSOT4NZ2lEOLpEnJt41zcmp4RrtfZgJoT5rWEEKgxDqh2GxDSE99YU7vZMYv5t9ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id A8DFDB4D05E5;
	Thu, 24 Jul 2025 09:56:48 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: E Shattow <e@freeshell.de>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: starfive: jh7110-common: drop no-sdio property from mmc1
Date: Thu, 24 Jul 2025 00:55:53 -0700
Message-ID: <20250724075600.239522-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop no-sdio property avoids a delete-property on variant board dts
having an SDIO wireless module connected to mmc1.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 2eaf01775ef5..a315113840e5 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -299,7 +299,6 @@ &mmc1 {
 	assigned-clock-rates = <50000000>;
 	bus-width = <4>;
 	bootph-pre-ram;
-	no-sdio;
 	no-mmc;
 	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
 	disable-wp;

base-commit: 28fa0dcb571ab8f3be4d919f0e20e01d4e44bcb1
-- 
2.50.0


