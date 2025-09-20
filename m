Return-Path: <linux-kernel+bounces-825776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7903B8CCD8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F9B1B25630
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8CA3064A2;
	Sat, 20 Sep 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpznskuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEAC2FB0BB;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385493; cv=none; b=Fi7WKWLzCD3IjFirRWWlLseGSiHdfvL2VZLeMv7VZkq6lEvjR7FJCArIqYDCTkXltgwiXnKYICRKlfXmQMxkKKHMhHIVfNS+M0RnLfIXu5QAPTAIds3fyBcjCtxMODjl3xwgHyQwFmABaWEyA4bOAA3aAinBoJZq6X1ntcuKCj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385493; c=relaxed/simple;
	bh=nIOQJydUgpMwH1Y2vny+oU81K/MwcYWcirq+RS+j7e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJL9HlpWXotGDui86thdnNf41JtY6bkFy/nYdW7SjLfzE38Xh4MjEmYg0E7mc4KeuoHJufVvME/6NEci15VheNuLGoYrTfOPyHi4L+quL99Z0z2GmCPbzVljSJou7jreScVCIR8f8x13yoe/oPUZCHNfdOu6vcjnMiUm8YHOl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpznskuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EAA1C116D0;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=nIOQJydUgpMwH1Y2vny+oU81K/MwcYWcirq+RS+j7e0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rpznskuK9AgChkGKaCX1AMVIJOFxNkwIDslxKa3phYZ5f2KcZyBaS0XivX612+tms
	 HUaGpJgnPyR/8jNhLiQkAFTACejVBoxgHpt+0KQf2Y/m01e9jJnKXLqDt8L860OeM0
	 sKsDe643oaLzOMzZ2peI7OH5ddEWU5/3EZp903VnoDlRU8a9VyI8s03K3iga3GKaBn
	 DLaDQBPma80TqZdTzM8PYzD/c7gKNaA2dj73B9t9BpxQcLxFo3cvBLEzVzsioCNjZ1
	 HXTvZt+6g7KFWSYmPuJXE42QFR6p/N9Y4f3Gh70eMzj9vW+rXQPONNWFBMCdYAxXpw
	 ynDE6RhruyExg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9594ACAC5A8;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 20 Sep 2025 20:23:35 +0200
Subject: [PATCH 10/10] ARM: dts: mediatek: add basic support for Alcatel
 yarisxl board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-mt6582-v1-10-b887720f577d@protonmail.com>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=2470;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=iyYcAwIUuKoaf3t5Jk0wP9oO6VHUo1cct77WwDYuJAM=;
 b=42iTG8Igz4PcR3ipNH7H+GmAzf51vDO+8qD+UElOPoElp7HJMwL0bq4MpcxPzJCGvRv2LIHbF
 2nbdRJ2sa3LBtNJhUSvcN5kR9O7qmc/NFrxPCjYJ+ya/hTKaMKjRVbh
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

From: Cristian Cozzolino <cristian_ci@protonmail.com>

This smartphone uses a MediaTek MT6582 system-on-chip with 512MB of RAM.
It can currently boot into initramfs with a working UART and
Simple Framebuffer using already initialized panel by the bootloader.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 arch/arm/boot/dts/mediatek/Makefile                |  1 +
 .../boot/dts/mediatek/mt6582-alcatel-yarisxl.dts   | 61 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/Makefile b/arch/arm/boot/dts/mediatek/Makefile
index e48de3efeb3b9ab00108cc28afa8da525d0ec14a..37c4cded0eae8cfcdc61c58fd1d986ae14c3de93 100644
--- a/arch/arm/boot/dts/mediatek/Makefile
+++ b/arch/arm/boot/dts/mediatek/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6572-jty-d101.dtb \
 	mt6572-lenovo-a369i.dtb \
 	mt6580-evbp1.dtb \
+	mt6582-alcatel-yarisxl.dtb \
 	mt6582-prestigio-pmt5008-3g.dtb \
 	mt6589-aquaris5.dtb \
 	mt6589-fairphone-fp1.dtb \
diff --git a/arch/arm/boot/dts/mediatek/mt6582-alcatel-yarisxl.dts b/arch/arm/boot/dts/mediatek/mt6582-alcatel-yarisxl.dts
new file mode 100644
index 0000000000000000000000000000000000000000..f55d8edad1acfe316ea139e76858833dcdae24fe
--- /dev/null
+++ b/arch/arm/boot/dts/mediatek/mt6582-alcatel-yarisxl.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Cristian Cozzolino <cristian_ci@protonmail.com>
+ */
+
+/dts-v1/;
+#include "mt6582.dtsi"
+
+/ {
+	model = "Alcatel One Touch Pop C7 (OT-7041D)";
+	compatible = "alcatel,yarisxl", "mediatek,mt6582";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		stdout-path = "serial0:921600n8";
+
+		framebuffer: framebuffer@9fa00000 {
+			compatible = "simple-framebuffer";
+			memory-region = <&framebuffer_reserved>;
+			width = <480>;
+			height = <854>;
+			stride = <(480 * 4)>;
+			format = "r5g6b5";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		connsys@9f900000 {
+			reg = <0x9f900000 0x100000>;
+			no-map;
+		};
+
+		modem@9e000000 {
+			reg = <0x9e000000 0x1800000>;
+			no-map;
+		};
+
+		framebuffer_reserved: framebuffer@9fa00000 {
+			reg = <0x9fa00000 0x600000>;
+			no-map;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};

-- 
2.49.0



