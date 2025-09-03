Return-Path: <linux-kernel+bounces-798269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6645AB41B7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38BA716D1D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F32853E0;
	Wed,  3 Sep 2025 10:15:32 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003D2EC554;
	Wed,  3 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894532; cv=none; b=ddqzeMJuKYr7dvwh+6FPkJqBAipa8izkrD9PEQSgtYdG0jvh5YIy0Tc/R8BJYqok3HpdoZzJ6JsHGDgY8TTz5poXoZN2Htq9LT7p20wG6GmheUcKeGPN9xupz8tdBl0daFaEv9vvFumw9gcKWP/AFlKXtsdgBWh6Xb0j9IlHNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894532; c=relaxed/simple;
	bh=YbsbZ5iVBfwCaU9Y03wZ09bGfbPqggyKRE4e3K58+B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAfKrZnSPujvtOygAyOeIJJ3daVbtk93NiuiMpQPulLW5lpTeUksVYh11CEJOjhiNlX8UOMe+g+q0cFlbYZRIJQ/39QZ0tuKAFJPjAqXJczAtOifKXzs+z+eDzfqKOYwfG1jTxpidGPLQNIhMNg67fqx8Qsxsd/g9PoCgMw2jGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id EADEFB22029D;
	Wed,  3 Sep 2025 12:15:25 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	E Shattow <e@freeshell.de>,
	Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v1 2/2] riscv: dts: starfive: jh7110-common: drop mmc post-power-on-delay-ms
Date: Wed,  3 Sep 2025 03:13:36 -0700
Message-ID: <20250903101346.861076-3-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250903101346.861076-1-e@freeshell.de>
References: <20250903101346.861076-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop post-power-on-delay-ms from mmc0 mmc1 interfaces. There is no
known reason for these properties to continue, testing appears to be fine
without them [1].

1: https://lore.kernel.org/lkml/NT0PR01MB1312E0D9EE9F158A57B77700E63D2@NT0PR01MB1312.CHNPR01.prod.partner.outlook.cn/

Signed-off-by: E Shattow <e@freeshell.de>
Tested-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 4fa77ffd54e3..5dc15e48b74b 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -285,7 +285,6 @@ &mmc0 {
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	cap-mmc-hw-reset;
-	post-power-on-delay-ms = <200>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&vcc_3v3>;
@@ -302,7 +301,6 @@ &mmc1 {
 	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	cap-sd-highspeed;
-	post-power-on-delay-ms = <200>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	status = "okay";
-- 
2.50.0


