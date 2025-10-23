Return-Path: <linux-kernel+bounces-866910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A046C01034
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AB0D504EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57EB30F800;
	Thu, 23 Oct 2025 12:10:11 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1A30E82D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221410; cv=none; b=owG9d6r0AdjirxuaO8Vn4NrfJPkdspky9oXGjUUxNUrp1sE7zUqUSDEw8lNxaIBAu1WWuDeNg433gBMMXD/cVZnAs61JpFpNJYZpCZm07Zaf3BUOw6UAvC7kM+Q5hZ2tqB425MXugk8vm6Jyi88GCuxzGI5xQr09K2AkdqLJDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221410; c=relaxed/simple;
	bh=LKggEBidnDaoYAZy2tX0K+iAOnLSLC3Hm2DoyOcDOqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slyyqxMnbOhsvg2NVPoqnyjjS06nQrMWtEnvzmY/59VE8e8Ek+viY4QwQ26m4QsBKxeBQHvYrscLWoglaJKGTBq/9aD/RZKyITZg4nlx0FwxxywHl5RWo46Ne6QECyP5aojma/y9PvLDJEk70pGY235fqnHDBIXhFRsFSyrbCQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 59NC9gGd039376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 20:09:42 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Thu, 23 Oct 2025
 20:09:41 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <pjw@kernel.org>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v9 2/4] riscv: dts: andes: Add PCIe node into the QiLai SoC
Date: Thu, 23 Oct 2025 20:09:31 +0800
Message-ID: <20251023120933.2427946-3-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023120933.2427946-1-randolph@andestech.com>
References: <20251023120933.2427946-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 59NC9gGd039376

Add the Andes QiLai PCIe node, which includes 3 Root Complexes.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 arch/riscv/boot/dts/andes/qilai.dtsi | 106 +++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/riscv/boot/dts/andes/qilai.dtsi b/arch/riscv/boot/dts/andes/qilai.dtsi
index de3de32f8c39..afa7b75a7e7a 100644
--- a/arch/riscv/boot/dts/andes/qilai.dtsi
+++ b/arch/riscv/boot/dts/andes/qilai.dtsi
@@ -182,5 +182,111 @@ uart0: serial@30300000 {
 			reg-io-width = <4>;
 			no-loopback-test;
 		};
+
+		bus@80000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+			ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x20000000>,
+				 <0x00 0x04000000 0x00 0x04000000 0x00 0x00001000>,
+				 <0x00 0x00000000 0x20 0x00000000 0x20 0x00000000>;
+
+			pcie@80000000 {
+				compatible = "andestech,qilai-pcie";
+				device_type = "pci";
+				reg = <0x00 0x80000000 0x00 0x20000000>, /* DBI registers */
+				      <0x00 0x04000000 0x00 0x00001000>, /* APB registers */
+				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
+				reg-names = "dbi", "apb", "config";
+
+				linux,pci-domain = <0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x00 0xf0000000>,
+					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x1f 0x00000000>;
+
+				#interrupt-cells = <1>;
+				interrupts = <0xf 0x4>;
+				interrupt-names = "msi";
+				interrupt-parent = <&plic>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 1 &plic 0xf 0x4>,
+						<0 0 0 2 &plic 0xf 0x4>,
+						<0 0 0 3 &plic 0xf 0x4>,
+						<0 0 0 4 &plic 0xf 0x4>;
+			};
+		};
+
+		bus@a0000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+			ranges = <0x00 0xa0000000 0x00 0xa0000000 0x00 0x20000000>,
+				 <0x00 0x04001000 0x00 0x04001000 0x00 0x00001000>,
+				 <0x00 0x00000000 0x10 0x00000000 0x08 0x00000000>;
+
+			pcie@a0000000 {
+				compatible = "andestech,qilai-pcie";
+				device_type = "pci";
+				reg = <0x00 0xa0000000 0x00 0x20000000>, /* DBI registers */
+				      <0x00 0x04001000 0x00 0x00001000>, /* APB registers */
+				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
+				reg-names = "dbi", "apb", "config";
+
+				linux,pci-domain = <1>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x0 0xf0000000>,
+					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x7 0x00000000>;
+
+				#interrupt-cells = <1>;
+				interrupts = <0xe 0x4>;
+				interrupt-names = "msi";
+				interrupt-parent = <&plic>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 1 &plic 0xe 0x4>,
+						<0 0 0 2 &plic 0xe 0x4>,
+						<0 0 0 3 &plic 0xe 0x4>,
+						<0 0 0 4 &plic 0xe 0x4>;
+			};
+		};
+
+		bus@c0000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+			ranges = <0x00 0xc0000000 0x00 0xc0000000 0x00 0x20000000>,
+				 <0x00 0x04002000 0x00 0x04002000 0x00 0x00001000>,
+				 <0x00 0x00000000 0x18 0x00000000 0x08 0x00000000>;
+
+			pcie@c0000000 {
+				compatible = "andestech,qilai-pcie";
+				device_type = "pci";
+				reg = <0x00 0xc0000000 0x00 0x20000000>, /* DBI registers */
+				      <0x00 0x04002000 0x00 0x00001000>, /* APB registers */
+				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
+				reg-names = "dbi", "apb", "config";
+
+				linux,pci-domain = <2>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x0 0xf0000000>,
+					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x7 0x00000000>;
+
+				#interrupt-cells = <1>;
+				interrupts = <0xd 0x4>;
+				interrupt-names = "msi";
+				interrupt-parent = <&plic>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 1 &plic 0xd 0x4>,
+						<0 0 0 2 &plic 0xd 0x4>,
+						<0 0 0 3 &plic 0xd 0x4>,
+						<0 0 0 4 &plic 0xd 0x4>;
+			};
+		};
+
 	};
 };
-- 
2.34.1


