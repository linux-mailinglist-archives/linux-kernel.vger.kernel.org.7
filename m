Return-Path: <linux-kernel+bounces-829644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E4B9786E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567FC3B06DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83487303A2A;
	Tue, 23 Sep 2025 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="AUDEH+rE"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE572FD1B1;
	Tue, 23 Sep 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660655; cv=none; b=LyTR07HxWPEItgwvOQ/dkPdc1zta3pwCeEKuRsx7D3LYqX+hQQWpJ52IBn3UX+d2RFJS+scpreLNSUPhYszxbFuTHpyDNeNE3zLMW+PtCCss0KiyGZrL1TXeJmOgLNjzB4gEggG1wQ+2Fkml8G+Y64ve+2+aQNRAp6fzi1UaDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660655; c=relaxed/simple;
	bh=ELWqddDgWzTH1hccxxJBSxJBULKOtPbGk3X13hi6Ze0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzyjKoZQKbPCmQTPsIpde/Nk3JZ3DN2UAiPf6/vBPSQx8MqkKTXhLdZHbkAKWTXk9VW7PHKF/6qF0Z2gmnJrbOuBbvtKBw8y6L11PRd0DWR5uVFS9tn1NrWUR4cMtRpywXkHaiCyP4Sgp+4PM92cTCY9WaDZf/Wbl5qXuuhmOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=AUDEH+rE; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=+6iIiad176OW4AQzEBo582ZIz3g89l1k5od4FKYfGpg=; b=AUDEH+rERQLyo78W2oJhgBgCHD
	g1waUWNm1jUEb2uw8J7K70U43NhDguWhD9TkCQyYjLFztlDzkR3oKbYyBAq4UaLazWEztNpz0sj1B
	nHlj4wfVLRSmMrPhDoumqk66C+ahK3Db2j0DtJDUnHwDjQ8KyhNJjW1nblu7jFH1fj8l1CW5bk5t/
	UKjtk2QQSedxjRCIQss0gTQkBhg/p2dhVKE4gqQYAyTxPZdihXKnIFYbA8MbLM+HzMGnsOEaK2GTh
	sezmvwfnuthdtqhElh9e7o2BaewsaI4087Oh+lKZTRYno3Xo0xQU6/15Pm87vQTVR+QTM/TTawy4d
	p5z4amVw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v19yJ-00CFUy-2u;
	Tue, 23 Sep 2025 22:50:47 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: [PATCH v2 2/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Date: Tue, 23 Sep 2025 21:45:42 +0200
Message-ID: <20250923205028.2355244-3-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250923205028.2355244-1-aurelien@aurel32.net>
References: <20250923205028.2355244-1-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPI-F3 board includes a 24c02 eeprom, that stores the MAC addresses
of the two network interfaces and the board's serial number. These
values are also exposed via an onie,tlv-layout nvmem layout.

The eeprom is marked as read-only since its contents are not supposed to
be modified.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---

v2:
 - Rename the 24c02 supply name label to buck3_1v8
 - Add a onie,tlv-layout nvmem layout describing the content of the 24c02 eeprom

 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 7df7f2c547750..994bc23cc1023 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -115,6 +115,29 @@ &i2c2 {
 	pinctrl-0 = <&i2c2_4_cfg>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		vcc-supply = <&buck3_1v8>; /* EEPROM_VCC1V8 */
+		pagesize = <16>;
+		read-only;
+		size = <256>;
+
+		nvmem-layout {
+			compatible = "onie,tlv-layout";
+
+			mac-address {
+				#nvmem-cell-cells = <1>;
+			};
+
+			num-macs {
+			};
+
+			serial-number {
+			};
+		};
+	};
 };
 
 &i2c8 {
@@ -143,7 +166,7 @@ buck2 {
 				regulator-always-on;
 			};
 
-			buck3 {
+			buck3_1v8: buck3 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-ramp-delay = <5000>;
-- 
2.47.2


