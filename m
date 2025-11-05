Return-Path: <linux-kernel+bounces-885767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C7C33DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55D5C4F112A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B2B26E6F9;
	Wed,  5 Nov 2025 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="khju7aYm"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C11DED42;
	Wed,  5 Nov 2025 03:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313904; cv=none; b=CfgqVKUWhR/oFacUQ0X3D4DBCAdSTeIZs4R3QTNJmL9RYYrYo6teNrhz8XHJeDH2ZybDWVjXuIoEJWPp3NnBhL4n7TMkfp5iRk84tMcoe2i4CLpIX5z6ZInQ4EuwUZ7xWrNL9GKKhndeYHkLKbGRFMbDDqutKyk4sJk/0+hGEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313904; c=relaxed/simple;
	bh=V8k0yxmQAnDcmXzZjyaiVPINJrE9h4Ksd4ST09u1EBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9uBMsPhs7QJ3VjOiI5hm7e/ejSYZ6j0U37zTUtYYzYgsv7mrheSFo7AJBgBEdRFvDiJJFF9l/KzEEShmwWFFjUUwHMW7coZNzbuW7M3pU3IkG5lrOJyelyYJ9Tnt5s98V/CuPiwmRWbZFLbVjrvjUAfNNf3JUhtfmlrv7t3YGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=khju7aYm; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762313878;
	bh=ZEQeZC5FbCZl5/PPz+0+QIoro14u9RfciKjSruDqBlU=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=khju7aYm/9XK3ib39LEAgHuNhY5fI5xYdDqIQtOpVU/n2dNBmKPAG/v3inWCYFsgd
	 gGSXl511BKAoPFR7UryuWH2bir+vra0sgAIzqp6dQohixlybOIpEmmoC2H2smA+GdP
	 /s6TC+l+MdTxGBQH0kQwazMV/80QEQe53xdgN6b8=
X-QQ-mid: zesmtpsz2t1762313873td991a8ab
X-QQ-Originating-IP: gdLyqkNyhnd0LHAyoMbqLbDBe5LUTi/ADZcDLkf1dZQ=
Received: from = ( [183.48.244.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 11:37:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2526406523798933425
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Wed, 05 Nov 2025 11:37:43 +0800
Subject: [PATCH 1/2] riscv: dts: spacemit: reorder i2c2 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-k1-add-i2c-node-v1-1-d18dae246137@linux.spacemit.com>
References: <20251105-k1-add-i2c-node-v1-0-d18dae246137@linux.spacemit.com>
In-Reply-To: <20251105-k1-add-i2c-node-v1-0-d18dae246137@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Encrow Thorne <jyc0019@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762313866; l=1874;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=V8k0yxmQAnDcmXzZjyaiVPINJrE9h4Ksd4ST09u1EBk=;
 b=mnCWk4Z1aIXLMbkESpWG4yvukgvwtTCO/09/fzS3TRRZ+6WeMuLb8Kv8wW07LbCPCQh/casEs
 VYWm5wrUopwCXeRFv2SQGN8ht3qmC+e+amy49kfos1DN2LJo37OVsrw
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OE3tIrIEWSq4oHRT14zzcvPwZbkIwE2KG+wCBDyQgWMy2o7kJakNo46G
	gHLT0+79MFMiXnMUurPD052IA2oEnV5IVJcI2vo+4J0fKpa3p650niguVbi1KHXCAfLPRN+
	4flRjZAk5MOzdB1R3coE6Et2mUVnwhY4y3K4P49H4l3iZAZY2OCSJfnWrw1rczaaBxkiPxu
	fEt2h016RqnDUr5xcrtQGQ/j+gJSD74k46xQAipqJ48aDjIM5excWc50CexA+TMmCCQMnv0
	Os24wyYRt2ldex0sV3u/w1Ba4JiDKy5XlwKFQCtIfRSpozrXVfyd11Yz5FR/3qw/110++gu
	fHf2JkGHmfMHoq0U11HAZDbZCu7QMLEp4dzsLIyaijt5OUqQrl+kXw1F7hFex9Ub6b6Tyi7
	gGME6TkqibXX369fDB29rwV6uA6ufJiM1PU0AtJRWIOEH7bgP+39ZmjE4ti6zri2Z6e3qEn
	ppcLC6WoApxsnfnQjojyFJ8ZRsFipgP0X/m0u3V98P4rYIP2LANDFY/BBb3rqgHnjKcXbRc
	kIV6yRtpqB5yW7yanQ0+rF2JlTYyl75m/ul6ozqO4hhHIS0yk7vAzkk160HTkD/l9LntTXM
	5Cf5dSy79VoNdoIgWeqs2xh5WEp4TqEFP5Hnd8hIQksviKOcZBXgK2qCjdXf16paanSPWYI
	VP3wL9aotIWn6OiENL0D+rx06RUSUwwHg2ZULEQSoJYvLdFENACDPEMerOPWTu+qmt966C8
	4DRGYMtAe1pNVFLGKJGWRI8RG0y1NG3Kz2TudaL3BYE5n3VWBfV5R7cxdyJi/snj/ZXlXZf
	xJMo5YPzp4nF2nhYJO5SIteZcGE+tNC+fOy5UFAYRNGNsvGUR9MlPex3hkIuf8JVnb59EfV
	JHX6iAFEfDglnj1qKzX+JApMBVsXVFmavXIyISpPXmZjXEHhboRUnS6B6A5EZNjrtXEVc8O
	WZIwXaesmjXR+C1pIPt08sn0Mwt2TNXqrNbyR9dmTRtF/Q+csc+hOooFHx28nZFDAIzvaau
	0rV6etP3obCMcDA3VdgkCiJ5EHbp5mQMxHFgpmId74l+TIoI57uK/vorvb6/CmzQ7drCW8c
	7Bt18zGMzSa7jmujk9e+gsGTn3VwBomow==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Reorder the i2c2 node to its correct position according to its
register address.This improves the readability and maintainability
of the device tree file by adhering to the established ordering convention.

No functional change is introduced by this reordering.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index af35f9cd643513a1c68a00ccfb3ead688a8b1929..5b46ce2edb059e22d878890b3b6192118dfdb2f4 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -358,6 +358,19 @@ syscon_rcpu2: system-controller@c0888000 {
 			#reset-cells = <1>;
 		};
 
+		i2c2: i2c@d4012000 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4012000 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&syscon_apbc CLK_TWSI2>,
+				 <&syscon_apbc CLK_TWSI2_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			interrupts = <38>;
+			status = "disabled";
+		};
+
 		syscon_apbc: system-controller@d4015000 {
 			compatible = "spacemit,k1-syscon-apbc";
 			reg = <0x0 0xd4015000 0x0 0x1000>;
@@ -459,19 +472,6 @@ pwm7: pwm@d401bc00 {
 			status = "disabled";
 		};
 
-		i2c2: i2c@d4012000 {
-			compatible = "spacemit,k1-i2c";
-			reg = <0x0 0xd4012000 0x0 0x38>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&syscon_apbc CLK_TWSI2>,
-				 <&syscon_apbc CLK_TWSI2_BUS>;
-			clock-names = "func", "bus";
-			clock-frequency = <400000>;
-			interrupts = <38>;
-			status = "disabled";
-		};
-
 		i2c8: i2c@d401d800 {
 			compatible = "spacemit,k1-i2c";
 			reg = <0x0 0xd401d800 0x0 0x38>;

-- 
2.51.1


