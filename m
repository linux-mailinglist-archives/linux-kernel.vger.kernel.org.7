Return-Path: <linux-kernel+bounces-749497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07996B14F19
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56CDA7AFA71
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1D01D63F2;
	Tue, 29 Jul 2025 14:12:41 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2DA1D7999;
	Tue, 29 Jul 2025 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798361; cv=none; b=uRkf9DxmxlNwwlnThZrDypNsPXDsy7s6Qfoe1Pkqe77nkGM5E/8aPNNoQt6ukr5DoQ+8gR4p/pX/o6yw++uR7jkdoAsNUVebfaogg09FBaOUDUihhW186//Q1NS4YO/olqTV2FcH6/kClKxKk3r1lpOH44f18r+CvzT6Wm0TbzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798361; c=relaxed/simple;
	bh=eO8ZrookEskYLtv48KoN1fSfR5jGOWzxlsis5CUrNnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJq7WFU0pSl/nAHfByMItx0XRRDIGFBzqWd0S7eSO/2d4moGh/hi6SlVQ2ETNDF0l9C3wsBbXWXIHKpbAOYUrrGsX54m256JI7TWwq/b9Cb0u7HR5zzsev2JRrBeSYvGnoGmfV7QHooesrwuURuspf5NfrOtRnyzBotMZJcLisk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 286E9B4E0042;
	Tue, 29 Jul 2025 16:12:24 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	E Shattow <e@freeshell.de>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2] riscv: dts: starfive: jh7110-common: drop no-sdio property from mmc1
Date: Tue, 29 Jul 2025 07:11:35 -0700
Message-ID: <20250729141142.13907-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relax no-sdio restriction on mmc1 for jh7110 boards. Property was
introduced for StarFive VisionFive2 dts to configure mmc1 for SD Card
but this is not necessary, the restriction is only needed to block use of
commands that would cause a device to malfunction.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 4baeb981d4df..b156f8703016 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -290,7 +290,6 @@ &mmc1 {
 	assigned-clock-rates = <50000000>;
 	bus-width = <4>;
 	bootph-pre-ram;
-	no-sdio;
 	no-mmc;
 	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
 	disable-wp;

base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
-- 
2.50.0


