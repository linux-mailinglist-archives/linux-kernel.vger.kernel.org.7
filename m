Return-Path: <linux-kernel+bounces-847668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB869BCB62A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40A314F0E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED96B22D9ED;
	Fri, 10 Oct 2025 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="pOtv92mW"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4F288AD;
	Fri, 10 Oct 2025 01:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061430; cv=none; b=SqA4KoLiDfnVIPBYCwK4wqR68P+9d+9r7npw9eNgizk5ZA+uVi6cY7BBXRxxAQ6EPhQubfJ2XbJuHIgx27NfNf0QZptKpgQvOQmW6sQs1o2HUn1rd3yG0wdACRIq9PUl7+xXNHfwvHidJ5TQ5T6aUgIlcdKXIKtt+oCsgUR0AI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061430; c=relaxed/simple;
	bh=8fVMPi0D436bKk5I12JlAgG0mrDgpoHjEOC1EVXL3+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tv9fbH6WbF7ATYh2B2ZmhnNFPZ3NvGhuc4ZPu7lQk+ekNzKuAG+g9BBRwC2orHqSFUIrIyooh1qq0fOBu1vqsKqXP14it1c8HRkum1exZxDb/QxQ1Dre1ySzBe+wzTnRHs81gdDVvgZ3WS8bXjKGMqEk8aqHnj4VtlmjBfWfH3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=pOtv92mW; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760061423;
	bh=LW8SLJdqAoSDw7GW9cUUMcMal45y7bSOQHFDO9blFuI=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=pOtv92mWatHLstj5DLd+FUC1pQbvtL+hvTXm0gKhGomEbXbu7VP1wOmzf6u8X9jMJ
	 GOm8orQEKS49Y9OW8HgpmQ0b/xa8Z6bFuFkx4T/p+W4lpSJgGYvWh8MEUz2vk+lAIb
	 FgVQSt+m/rFTiGM3GlKWF6MltfFbaRAo1Qs97yMM=
X-QQ-mid: esmtpsz21t1760061419te84f3ea8
X-QQ-Originating-IP: ZWQ1xL+DZDYV8pAS//7JgtDaaEfZoNg0a5O0pI42V2k=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Oct 2025 09:56:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10941913832204491341
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 10 Oct 2025 09:56:34 +0800
Subject: [PATCH v2 5/5] riscv: dts: spacemit: add Ethernet support for
 MusePi Pro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-k1-musepi-pro-dts-v2-5-6e1b491f6f3e@linux.spacemit.com>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
In-Reply-To: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760061399; l=1192;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=8fVMPi0D436bKk5I12JlAgG0mrDgpoHjEOC1EVXL3+k=;
 b=9hQyo3rM7L6zXB5hetSkNx3wZrbLr3AeYBFyQtOSXpyVPaDQYrpKIHQ51TIISBfPsYlbPWxKa
 n5MuwHxuWS0BFH+9k+uCP3vgUNvyWCpw2RZTlGE8n7BP943ZTCfvDUc
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NfGQECF1EzMaM/UwMlkF4ANqw/W9WWtrndFtbBUx03drgEcVcq24RVrX
	nJ7t7LjM14/eZhLznuvZ2u1rOQfjRg4zvVEpiSYGsH+0/u2nLgX5MmqZldj4eBmnOQcuAEz
	ZqDWUWP2EZapMwvMUeD7WTJ/OsN0PrK9ceFzk+Qd++bRhQfIj1Qa0MkP20Lff6NF4YLV4Zu
	Ku+QKrXmlnnC3d2mJN2qt9ZzYQmMOtRGhhYDWRlKxuoig/AKCz1GVYCtSxQY1DVHRooDn5q
	WK0rwO4b4qxQ3zSZilZwVf2j+/BCFlmXQVt5th/XgNOZJ5v0hxfVgVIJV0cdh4Q71C6DCDD
	5JgkVpgrz9JZFBBkYjh3z9jei1NAj2AADFIe973Ct/mpUd26UphgV2JrSykmr7g6hRY9BlM
	mYu5KQRze8nktOA3sGFGlOWEA6osNeOzKlTPIBi3P3sGLYd87uSkBL/AjNtjptrD67NKTei
	O4esNWoGNj4mrRZyHbaVGU5HGsxZjiiBVVLdGR+0XNfrXDBKqU9NpTLBu29381jAajj2+DL
	8NdeqAxjV38YPXLKzalFr33LlAnzNiH44JKFV6uJdi6RHuyUcpRymLmQ4EWYhsdbK6CRjzv
	K4a4CL7pWDOcuhGovVssBVtFybNQTmy1uyIb4f0kCPYIDrRJ8eJy/+tZYFFS1p6D3rqZ/u5
	SvvbDOes50fhnBWfmJx7tdYhXqUjCgLL2eny2PDN5lmvrr2LfowLeYQZKV1UoQkyJumG/uf
	gkj1V/MqINb402AS9j1EhoFP+ARDzkXha7GL0EERm7QAMtT1iGHDM6oDk3IgjLN2bVucNuC
	0zruUvzndfI/okyZi0yTy6krmtB/ufi/xVb9myzzz3LgvjcysW69pdSu37o2Ogo8AgviJmy
	PQH7Vgm/JNCdoOP2ZkIPMmYZQTT46/6zCJ3hsB8qxOLb5YdjykfRIociETSEZQEWLLY8J9P
	ej8MStqT0hVJL1RL7yxjgzytfWll9K4pQ2S2eZuzDAAhh4/T/fBoXWuf3Jlkvk7dfDtYI6C
	RDaXzEjEPyVUbcL6vhcqWj907rfp3SkcH4ZGNuPhbazjyjAeCDdfvPQmlT43GK+IEZIPqFw
	10MUZzuKtrJKdUMze7JCnD0zTPk8Hxvqyh/riZIG8uGxkMp1YofLADU+t0qBoWUpFXXs07b
	IZE3meweMsF3SQs=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

MusePi Pro features a single RGMII Ethernet port with
PHY reset controlled by GPIO.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
index 89a35914710bfd15c6ad27cd8d0de7ccf62e2309..e9a53dc7a417117c82f3e467677290bdaeffc845 100644
--- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -47,6 +47,29 @@ &pdma {
 	status = "okay";
 };
 
+&eth0 {
+	phy-handle = <&rgmii0>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&gmac0_cfg>;
+	pinctrl-names = "default";
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+	status = "okay";
+
+	mdio-bus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		reset-gpios = <&gpio K1_GPIO(110) GPIO_ACTIVE_LOW>;
+		reset-delay-us = <10000>;
+		reset-post-delay-us = <100000>;
+
+		rgmii0: phy@1 {
+			reg = <0x1>;
+		};
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	pinctrl-names = "default";

-- 
2.51.0



