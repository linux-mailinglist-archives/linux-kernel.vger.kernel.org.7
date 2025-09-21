Return-Path: <linux-kernel+bounces-826406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB42B8E72A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F5C420809
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B02D481F;
	Sun, 21 Sep 2025 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="rNJIqNAa"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697052D0607;
	Sun, 21 Sep 2025 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491149; cv=none; b=XgnH4gZ7VOdU1R2YuLB7Kn9npJtsIxG2SusWO4r67e7eHVnJwwPgvavFjCMlT6ybadmQf6An3wf0Gq5qQeXE0jyY2WrPO0QGlyyve5IrgAXkU3Jcm2r6qurbSqONlQN5U5p/JYTXHB3zO0A7AIerSiEUqZ2tukSKBqTov2WiUK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491149; c=relaxed/simple;
	bh=IuzbyO8RQa1Z7lbkEzV5CpIL2Jb/BToGVCWPOxNgdXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7CitaSjI+K1W/xoQK7o49241dGSA8Ja5Aou2uwMPgNfx1smqLjPV0rVkySFyODRnNUvJngmNNDCuuKkrNK5im93WARqg4dMSuGza9DoPlRSWEwb/tluVuvpnqZLZ+gn891XfMjohp9NIzvjTSVV1G6nOHYGMhJykJD050RNqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=rNJIqNAa; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=p56GR8/f7eBhZdENpdLe5c/4ijriGq1K2w7eDJM2c9o=; b=rNJIqNAaKrYG7KpO79MRmikRtE
	1L0cau7/W5pvuknfTZhi47jp/IJiW3U+RyT3zu5ey+IkBPqoeppT2FFlq1kxWRE0t2HbMwF0tUu2b
	EVCJRztKbISxZ0yNT0/Hj8jZemXGHUpFA7G8wNOybmZrsW5ODg84cJfFY4y0O0GfG4jHQUuCYYkug
	EikWHXpnVzyR7i7f9xMTo7zgrK3cVC5LgLtB5PRnfIsd2yz6V5ePJz0gK/QUgOXxWA38Qb7/X40vG
	tEzGkXeJDYqo6b7mke4hRuDRhZjHOrpsNZLP4oGmvanV+LddHu4yBuyWllqXmpeE4wmxzApr3jqNS
	4BXjzx8w==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v0RCp-009LbK-0U;
	Sun, 21 Sep 2025 23:02:47 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: [PATCH 2/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Date: Sun, 21 Sep 2025 23:01:42 +0200
Message-ID: <20250921210237.943370-3-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250921210237.943370-1-aurelien@aurel32.net>
References: <20250921210237.943370-1-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPI-F3 contains a 24c02 eeprom, that contains among other things the
MAC addresses of the two network interfaces. For this reason, mark it as
read-only.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 3b6e4f52e9aad..574d10fdf9b82 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -115,6 +115,15 @@ &i2c2 {
 	pinctrl-0 = <&i2c2_0_cfg>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		vcc-supply = <&vcc1v8_sys>;
+		pagesize = <16>;
+		read-only;
+		size = <256>;
+	};
 };
 
 &i2c8 {
@@ -143,7 +152,7 @@ buck2 {
 				regulator-always-on;
 			};
 
-			buck3 {
+			vcc1v8_sys: buck3 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-ramp-delay = <5000>;
-- 
2.47.2


