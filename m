Return-Path: <linux-kernel+bounces-752657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60510B178F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE37A7AEDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32F626E6FF;
	Thu, 31 Jul 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8+yQ7J9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8526C3A7;
	Thu, 31 Jul 2025 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999961; cv=none; b=T0h2vP4yd/McqOLTrBu2dt72nsoOdy4GP3cB3gmoj6wlsrNuaIlb1lxrL4B0tG8gbw8HQHT5ITUrH+mrBWbqeRq9JtFlZdMTeGpEH7s4SlJXP6vFjwDS7zZlTyNWi6k8gehoyf8T29K1benApOA5tvNv55p/Ivjyeatb8nIZvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999961; c=relaxed/simple;
	bh=cfyyeN6Mb/ojJhksgCO4DWogxFkAIMP5MsCuIL3s2YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9P5tr8l+/pjFv3mb5xW67+0p8ewPnSGSEGNpuPAY+wbSt0bBwys8t/sgGyI8EJbu1pyfpekxPFr4tXsFlf7HfuCFD/LtoCv7tvj56Bd4OS/UO48dk+m6ld5jEfyfkKIaxyWGm1RtwyBcjCgL6/bQoYCdlvaYdFGje4L7E59aJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8+yQ7J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA040C4CEEF;
	Thu, 31 Jul 2025 22:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999960;
	bh=cfyyeN6Mb/ojJhksgCO4DWogxFkAIMP5MsCuIL3s2YA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r8+yQ7J97MSgjECdZIEpPz29v94q0XLnMmAmK2wKV/FeSbIh3sAdiodOLVBHToGsa
	 JyE7pZIcE2Ub9FFFAZTd6zo7jKpRSLN+0dJVSoeeR9IA8uiclLH99KXbDgwCOa+L9c
	 zR8d2LIhi089je4vkNYTVcG39wWMQSQT0atXVG09MCB8IBLeX2+dlc2dU4kCiyMeAM
	 MDZiTuwsPs9csc/aiQTANOSooPHM1VbPYrvNKdJadQ5Ds+UWUMEnCU1gogLjfl4QsL
	 KuC59InQMObYKalpvPNkwqKwDqLffkwDooCVXzA9uIxkmhMW6vDZfugLL+Lwos32Hu
	 QvYjfh2eNYuaA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:18 -0500
Subject: [PATCH 1/6] ARM: dts: aspeed: Drop "no-gpio-delays"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-dt-fsi-cleanups-v1-1-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

The "no-gpios-delays" property only applies to the "fsi-master-gpio"
binding and not the "aspeed,ast2[45]00-cf-fsi-master" binding. It
doesn't really make sense either as the timing is controlled by the
offloaded firmware.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts | 1 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts      | 1 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
index 78a5656ef75d..f42254ba6aeb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
@@ -57,7 +57,6 @@ fsi: gpio-fsi {
 		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
-		no-gpio-delays;
 
 		memory-region = <&coldfire_memory>;
 		aspeed,sram = <&sram>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
index b1d0ff85d397..e5b8d07e7622 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
@@ -80,7 +80,6 @@ fsi: gpio-fsi {
 		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
-		no-gpio-delays;
 
 		memory-region = <&coldfire_memory>;
 		aspeed,sram = <&sram>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
index 24df24ad9c80..2180fa9b6f24 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
@@ -71,7 +71,6 @@ fsi: gpio-fsi {
 		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
-		no-gpio-delays;
 
 		memory-region = <&coldfire_memory>;
 		aspeed,sram = <&sram>;

-- 
2.47.2


