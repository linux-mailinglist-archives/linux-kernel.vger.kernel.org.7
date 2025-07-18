Return-Path: <linux-kernel+bounces-737042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CAB0A6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10378A8113F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F52DCF7D;
	Fri, 18 Jul 2025 15:13:39 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D514D283;
	Fri, 18 Jul 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851619; cv=none; b=bqnoHzPAb/ACetm5dFEjIQfNPKvdiqsyEFcyzMZwWh1r1Fix18KHOUdt9bjKdOAfvkSHcnsXioXveJ1X22bOgpM26zBH3eg0vrPPh6XltiSSBgKRP0btMWY0Y9acJbGrfZ080UThVOlITF6fWTD+hj+6t4dVlw0c7IFPG00sHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851619; c=relaxed/simple;
	bh=Qc90R/wKlwZzydgUbeWgdwRR5Gjg0u1fsWOFnERsnQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hQHxAwFqqbazXXwruqSza40eh1o++Avgtzz9I1Ue+Sgv93nNxwvDnlRWqtnx0zSrbphwY7Y1Dc9biq02UrTntG3JtvxbqpeySVWsAPKdES1ZrEy0+uh/Zf28HO1c7rIgnqrNyKVly7MnFA7r4ySkC2ff5zF21/Te33QPj0B46io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id BF3A133BEA5;
	Fri, 18 Jul 2025 15:13:33 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Fri, 18 Jul 2025 23:13:23 +0800
Subject: [PATCH] riscv: dts: spacemit: uart: set dummy clock to silent dt
 warning
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-02-k1-uart-clock-v1-1-698e884aa717@gentoo.org>
X-B4-Tracking: v=1; b=H4sIAJJkemgC/x3MTQqAIBBA4avErBsYhejnKtEibazBqNCKQLp70
 vJbvJcgchCO0BUJAt8SZd8yVFmAXcZtZpQpGzTpimrVIGn0Cq8xnGjX3Xokw6Zlp8gxQc6OwE6
 ef9kP7/sBAWU3SmIAAAA=
X-Change-ID: 20250718-02-k1-uart-clock-0beb9ef10fe0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=Qc90R/wKlwZzydgUbeWgdwRR5Gjg0u1fsWOFnERsnQ4=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoemSaDXUiJarkoPAv74cbl3GPf+0St8IFpnfeS
 +CWcnTv4zSJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaHpkml8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277ZmtD/9VwLCxQcQ0hB0Tcz
 Hiv7P4pGgYimXWcwy99P2oCnsLxUZVSyviVHcWMACml/PEvWLipk0/B5tBHIL5oj34ugP1rYR+f
 GdF8k5YVYUYsYlIlyG+XsPfmqMDnb/EWqK5ZKibRm5ar6zHWY0rDkuv3B44sS5mtR7If+VFX+gc
 elqsMCB3eR8BWLnY+6fN2olUi0X6n2l6AOB6IKNVA+7RS8qbPk15bUB5njopP+OtrphXMe0+GIm
 RVquSD4+CaWl5/WEtlxP5XwUbC/x1OrGxKm4ruV5/SpB+WCgNyGHJCm/9PB9MzdyjgTmR/pcS/U
 xazeRCa1FXY06JWQqK1MATtLzzQzOBtVaGZk5qT2otjr/AnJPLl7rtbjT3FHUlKLxO0syT76wWF
 M1OuN1qFsWdexeFZ5k6mgzJ9lafmZhtbW5k5GM1gZe0bkcsGjjSUmXYWuxjFSzWqKoGinnSqQpU
 eWQrx/3GfLv3WtCTCsru9iafxpxx1ugWVhHzOxsWmHlHZjpREgN511ven8nGT7cwGW/Hkgwqbsn
 3oYI+WMvj4SF6d2+QOWa8QmaH6gTvMebQp3Mfcnbc5Vrr88+rqdPC0669PHt/tlAJ26eb3FL20j
 s/5ccko2FWSpp5xINaF0xTUal4UNi8N9lum6EUhcl4lAGb/GT6bF4q8VlnsDrZtIo2oA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

sec_uart1 is reserved in DT, and no clock is implemented in the CCF
framework, thus 'make dtbs_check' will eject this warning message:
  serial@f0612000: 'clock-names' is a required property

So, adding a dummy clock to the device tree to fulfill the clock
requirement, then silent this dt check warning.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index c0f8c5fca975d73b6ea6886da13fcf55289cb16c..e9b98f2a3b1cc38f569d7de336630df846cbfbe7 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -309,6 +309,13 @@ cluster1_l2_cache: l2-cache1 {
 	};
 
 	clocks {
+		clk_dummy: clock-dummy {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "clk_dummy";
+		};
+
 		vctcxo_1m: clock-1m {
 			compatible = "fixed-clock";
 			clock-frequency = <1000000>;
@@ -556,8 +563,9 @@ clint: timer@e4000000 {
 		sec_uart1: serial@f0612000 {
 			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xf0612000 0x0 0x100>;
+			clocks = <&clk_dummy>, <&clk_dummy>;
+			clock-names = "core", "bus";
 			interrupts = <43>;
-			clock-frequency = <14857000>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "reserved"; /* for TEE usage */

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250718-02-k1-uart-clock-0beb9ef10fe0

Best regards,
-- 
Yixun Lan


