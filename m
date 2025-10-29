Return-Path: <linux-kernel+bounces-876545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E0C1BFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E2A427531
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B43385A9;
	Wed, 29 Oct 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAlRS1mA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9F37A3AF;
	Wed, 29 Oct 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752378; cv=none; b=YHwJX4dn/Xu99TTDzOAfs86Y3e1Ee25TbVwLjYfX3jTxhyP5Q/XRyio0ZGYTiLV6B7FZb98GZOEYgGxtUJxtG+gWGawa0trsA/dq8kMcyT4jhbaDgWwP3Mo7Mf7vzjZkLfB4p2lMERLU45luLfy5OIKk+h+Fck9zEN4mAbFL9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752378; c=relaxed/simple;
	bh=grPwEietiNbq1mSlzDL7WcODrofYGlPESBXp1qQNHsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTo88vE5BGEYbMoPWQEK5UJmHwJD7W7hIu7df5c2pE9i1VWdvGhUhwNRfqxqTkDWVCsjL2um+x4tahSD1SQFGHiiVc45isMbg4HRZKgjiG2eeEIDzFAQ3c6vppVYuc4+7k3a2w6RQ3uluCOLUMiTvr9Rpj4KsZwrkOqw7vW1yYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAlRS1mA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1186C4CEF7;
	Wed, 29 Oct 2025 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761752377;
	bh=grPwEietiNbq1mSlzDL7WcODrofYGlPESBXp1qQNHsQ=;
	h=From:To:Cc:Subject:Date:From;
	b=vAlRS1mAFJLTp2ybW94RNMrdBL9c7LEqcafqarKYgFiPNlZ7pwx3TuoKI8thB7qcr
	 4Bv7O/FqSAg7KTv4URkhPYbf7f5z28e7nawJfc+P55eiNrkVOo5FrUAxfJqpNl7lEN
	 GUrpJtm03ct3XDlLhq+l9uOtujZBhKLpF792XMD+VWVxZDsbTEu0wo2EfmSMWfnYBm
	 GQjiYgdwHeaNQ4WylG8ZP/9xH0Krj5OreqhS72QdXT3WJ8HCDWf0ZqDAqCRK6U5NT5
	 NdbixIdBFcaLj6hnZnNMF1XWdrwilBcZDpjbxHmWEGWOF3IXSYoZnI7BAAuKD/IBDw
	 HpytFTCoAhvgg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/arm: dts: marvell: Rename "nand-rb" pinctrl node names
Date: Wed, 29 Oct 2025 10:39:25 -0500
Message-ID: <20251029153927.1065446-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the "nand-rb" pinctrl child node names to use the defined "-pins"
suffix fixing DT schema warnings.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/marvell/armada-38x.dtsi         | 2 +-
 arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi      | 2 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi      | 2 +-
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-38x.dtsi b/arch/arm/boot/dts/marvell/armada-38x.dtsi
index 1181b13deabc..1d616edda322 100644
--- a/arch/arm/boot/dts/marvell/armada-38x.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-38x.dtsi
@@ -247,7 +247,7 @@ nand_pins: nand-pins {
 					marvell,function = "dev";
 				};
 
-				nand_rb: nand-rb {
+				nand_rb: nand-rb-pins {
 					marvell,pins = "mpp41";
 					marvell,function = "nand";
 				};
diff --git a/arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi
index 7a7e2066c498..a9a71326aafc 100644
--- a/arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi
@@ -322,7 +322,7 @@ nand_pins: nand-pins {
 		marvell,function = "dev";
 	};
 
-	nand_rb: nand-rb {
+	nand_rb: nand-rb-pins {
 		marvell,pins = "mpp19";
 		marvell,function = "nand";
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
index 293403a1a333..df939426d258 100644
--- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
@@ -56,7 +56,7 @@ nand_pins: nand-pins {
 			marvell,function = "dev";
 		};
 
-		nand_rb: nand-rb {
+		nand_rb: nand-rb-pins {
 			marvell,pins = "mpp13";
 			marvell,function = "nf";
 		};
diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
index ee67c70bf02e..fb361d657a77 100644
--- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
@@ -89,7 +89,7 @@ nand_pins: nand-pins {
 			marvell,function = "dev";
 		};
 
-		nand_rb: nand-rb {
+		nand_rb: nand-rb-pins {
 			marvell,pins = "mpp13", "mpp12";
 			marvell,function = "nf";
 		};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
index 50e9e0724828..3cc320f569ad 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -379,7 +379,7 @@ nand_pins: nand-pins {
 				       "mpp27";
 			marvell,function = "dev";
 		};
-		nand_rb: nand-rb {
+		nand_rb: nand-rb-pins {
 			marvell,pins = "mpp13";
 			marvell,function = "nf";
 		};
-- 
2.51.0


