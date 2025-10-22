Return-Path: <linux-kernel+bounces-864300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5447EBFA73A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01A2334482D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E572F6174;
	Wed, 22 Oct 2025 07:05:58 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7F2F6182;
	Wed, 22 Oct 2025 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116758; cv=none; b=C8fBbIe1NpyJu+8qJ5mpHSFkVxuvM/uKTngiNHCUMWzZWuWemByo/uK0OIhVDsU396t1eRndneI9C6zPAPebahahjchauuGYbIZv71Wnj64rrxRBNkpslii4uc+lXrW/us5Jts1D07Rfli/B3vc07/AdHOQNP0hLFknnOgSmuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116758; c=relaxed/simple;
	bh=43IdN5grqab5NtUu5trKBJYwk2qqeBRy9PQwFFafD8k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uc6pg+a+44IHiXVV6AjuJ/NGQCeYDOuORO9o5ksJo5HvdR3YZTGUo1wMJlmus+OSSo8po0J/erVRkm5Q6yZKunP7zAMVCEVGmPY97ao2afaiJXmH5cPEHTQFaFq9cku14twvx0dBVUIlB2v/H2GEkvVSHwieDopkNR7Tja4KWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 22 Oct
 2025 15:05:44 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 22 Oct 2025 15:05:44 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, <bmc-sw@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, <jk@codeconstruct.com.au>, Lee Jones
	<lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 5/6] arm64: dts: aspeed: Add AST2700 Evaluation Board
Date: Wed, 22 Oct 2025 15:05:42 +0800
Message-ID: <20251022070543.1169173-6-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

ASPEED AST2700 EVB is prototype development board based
on AST2700 SOC.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm64/boot/dts/Makefile               |  1 +
 arch/arm64/boot/dts/aspeed/Makefile        |  4 ++++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts | 22 ++++++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index b0844404eda1..5b8fbf5b1061 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -9,6 +9,7 @@ subdir-y += amlogic
 subdir-y += apm
 subdir-y += apple
 subdir-y += arm
+subdir-y += aspeed
 subdir-y += axiado
 subdir-y += bitmain
 subdir-y += blaize
diff --git a/arch/arm64/boot/dts/aspeed/Makefile b/arch/arm64/boot/dts/aspeed/Makefile
new file mode 100644
index 000000000000..ffe7e15017cc
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_ARCH_ASPEED) += \
+	ast2700-evb.dtb
diff --git a/arch/arm64/boot/dts/aspeed/ast2700-evb.dts b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
new file mode 100644
index 000000000000..654b36ec24de
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+#include "aspeed-g7.dtsi"
+
+/ {
+	model = "AST2700 EVB";
+	compatible = "aspeed,ast2700-evb", "aspeed,ast2700";
+
+	chosen {
+		stdout-path = "serial12:115200n8";
+	};
+
+	memory@400000000 {
+		device_type = "memory";
+		reg = <0x4 0x00000000 0x0 0x40000000>;
+	};
+};
+
+&uart12 {
+	status = "okay";
+};
-- 
2.34.1


