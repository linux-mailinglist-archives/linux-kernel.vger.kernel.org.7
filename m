Return-Path: <linux-kernel+bounces-885970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE10C34685
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D61294EF65A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3E72C3272;
	Wed,  5 Nov 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="SCL+Yjs9"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF56E35965;
	Wed,  5 Nov 2025 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330400; cv=none; b=iiNaMuH3LJh0E7gt1MfTKzH8MLrj+TeeOnWfiA6hg/Kwk9lv7RJoLBE4Y9ORB2KBOJs+yA24AomO3eNMLb8Cn+ndOsJ/c6ZCPobJ1N0ANGCOolJnJhmTBsfulv0MI2jfbzl7UiNWRhNjfa84EGv7TG5++gw5czFnGlQ5bZXRrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330400; c=relaxed/simple;
	bh=FmZDyhuNr0oLBexd7kHUt1YPDH4ec6MPQJ8xgRgTdNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b5X4bp+Obx+akXLvkWtr9Pw3B/ukNYhGHGetzoPiHz9xbb1LckAZbLczo5sCW5Iv9Nu5fWY6a4S4pKKi5jvhMn0kvPwCqmjh7yohqafLV8MnVShCMNTvUhG6Xf8Tu7zZnnYCxpoevmCWaY5p6H6EhzGKMSFGc0/3FWn0ZlIBFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=SCL+Yjs9; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762330379;
	bh=4/aVTDcYEiImDJjO+fflC/Dv77O9woX/qRdgBjUVup8=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=SCL+Yjs9vEHJW85LQ+YwfIrE8B1r8qCQw9e5Meskg7BD8vHhEFqGZonil53o+MmjV
	 MplTMVgFTob4RBxgKGw8gkX460KSSKIo1EtVfHFppNpmH9t+z3/1N8+n4hIt+a0273
	 WdLTyf/bvPxjrPyV2/MPD81UBaxxDcdHjg3z573I=
X-QQ-mid: esmtpgz12t1762330373t493e4989
X-QQ-Originating-IP: nQiqbRGq6vpRkTervbpAafKGXLnpABZ2stIypPufKs0=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 16:12:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12398856002057575520
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Wed, 05 Nov 2025 16:12:46 +0800
Subject: [PATCH] riscv: dts: spacemit: add i2s0 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251105-k1-add-i2s-node-v1-1-9360b57a0c52@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAP4GC2kC/x3MSwqAMAwA0atI1gaagvi5irioTapBqNKCCMW7W
 1y+xUyBLEklw9QUSHJr1jNWUNuA313cBJWrwRrbEZkOD0LHjGozxpMFV+fDOlrqeWCo1ZUk6PM
 f5+V9P5BYKAdhAAAA
X-Change-ID: 20251105-k1-add-i2s-node-bacfb9217d8d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Encrow Thorne <jyc0019@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762330371; l=1679;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=FmZDyhuNr0oLBexd7kHUt1YPDH4ec6MPQJ8xgRgTdNM=;
 b=xret/F+EES85epJ03W+8Fv6VutPMgumLqweBUH3WSLcFpfFZAQ8zzX9lJLgE4ZIImLMJOnr9g
 qrKY9G+25LOAjEtzSWx8iGC+RIU/1MHvNkPEsTQeVAJCbEAIziSEFZ+
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MeYHCqcqpzbj8V14rbM/Kcyi0CqubDZuaIKVs0G0TI/RBbwcnosL3aHR
	n0t+WPWYBBYtr0frkuaTkgZtuyFyabNkobBcQo/uwvl9PMC90DpJiuid9z8CLeawOtImZz7
	NgGH0bMdzLxA9btdIx8fjKWuQcY9dQJDb6qWTuAbiTILTbzBwcYTvEoxoXMfIbYPVxIcpcx
	YPFdhWEk6mnvnsSX2zuTM5KNhib+YlHp/GlVgZfvffggE6YFiR3g6JsmcHkwS0PuZbfDHE3
	CCre2KLcq49szPFlGFcndVrAkPB4pXCa7TW4VY+/InTCr7c6zn0jsC3xfAk5x6jObAy7IKE
	bdOYHVa56PsMr2AF/obXmB5ZwIL0xB9OFy1/3X3uPhHq25YTrPpcSmF2VmmdxQAzl4kFArZ
	8RqazylPdcn4Q+P3P/783bvj7caSEFAOtnY6Uwr+0IOIAXNrsg8wtySTB8DBNDWp26Gg8ya
	Un31Hu86oEYBv/ptwNNSw6gAidH+cThP2gJWGLTXleiWn2bpvG+RjfVo2hpuwL9O5AvbEip
	4Lb7V7VQLFl4neooBCTsF7u90+i/jwTLWZwO+PCP035wPHy9AzJ8/43oUD9QvBty/gkPyIp
	KBviofoIYbyYKMewUaN4KXUagY6zAgM/YH0pFWrbi+ttBgF420Udv76mdnimylxhUXoWCEc
	/OJOfC/oWaC4nkl6EjtkUCBLR4Lh87rCKU999eHfVc3gbWfzindQyq7YhjOZNDFUuEggPv/
	UAAAnxD1zz1KzUrCwCLPlrGK9ZPJWXUrSt9NI8889k1VEWgcNhplNkm35NWhTcywwy7MW2t
	3YKuYQOyypDp+t52hSr2L27a5oR6moCmGMo3w7s0BbgHf4ZQ7kVpodoCfvKlytOCo/LpZqj
	fKI2o3tdf+yNYOIkiIbB/TovWcOAYt1FX7aHdShR3h3YlX9nKK775uZLNvpaZn/n9c+KCCN
	LwBEoYWzRctM071bxTx3VTD0BTI7xpMBpGu9oSICzPRkhOyyHztoOpTMTYPvTYeM7MFPsEr
	XVSvX7xDq7vQzYnBQl2oOv1qOORJU+lgKfTxrDiP8Aybt/gIIqCRmkUXX/D9lU2RHeFC8dX
	J7rlWzz0zdxtjfZdAEc3RaAROeCeWfDAwxR0HhrmZQZH1FZfh4hiEs=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Since the I2S driver has been merged, it’s time to add the I2S node
in the device-tree now.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index af35f9cd643513a1c68a00ccfb3ead688a8b1929..25deac318fa349ef1d444846371cc393cf58545a 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -823,6 +823,28 @@ uart9: serial@d4017800 {
 				status = "disabled";
 			};
 
+			i2s0: i2s0@d4026000 {
+				compatible = "spacemit,k1-i2s";
+				reg = <0x0 0xd4026000 0x0 0x30>;
+				#sound-dai-cells = <0>;
+				clocks = <&syscon_mpmu CLK_I2S_153P6_BASE>,
+					 <&syscon_mpmu CLK_I2S_SYSCLK_SRC>,
+					 <&syscon_mpmu CLK_I2S_SYSCLK>,
+					 <&syscon_mpmu CLK_I2S_BCLK>,
+					 <&syscon_apbc CLK_SSPA0_BUS>,
+					 <&syscon_apbc CLK_SSPA0>;
+				clock-names = "153p6_base", "sysclk_src",
+					      "sysclk", "bclk",
+					      "sspa_bus", "sspa";
+				assigned-clocks = <&syscon_mpmu CLK_I2S_153P6_BASE>,
+						  <&syscon_mpmu CLK_I2S_SYSCLK_SRC>;
+				assigned-clock-rates = <307200000>, <307200000>;
+				resets = <&syscon_apbc RESET_SSPA0>;
+				dmas = <&pdma 22>, <&pdma 21>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			/* sec_uart1: 0xf0612000, not available from Linux */
 		};
 

---
base-commit: 17490bd0527f59d841168457b245581f314b5fa0
change-id: 20251105-k1-add-i2s-node-bacfb9217d8d

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


