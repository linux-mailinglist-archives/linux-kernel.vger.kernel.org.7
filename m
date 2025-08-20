Return-Path: <linux-kernel+bounces-777098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC3EB2D528
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612FA7222E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6C82D8780;
	Wed, 20 Aug 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Ra8vI+iF"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9EC2D838A;
	Wed, 20 Aug 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675852; cv=none; b=KT297im4v2jdtDZGfzpIx3GHmcalmBjaQ/oJze68bjlmI7ACHneh437b68pCyoGMKnoeeQgxuxUm6CB/NfUX1i4IrsMK6dcVFMfUCfzIND4/BYfNvRE+4WsPD9q9WFLo2hPbTg9xA6NAJ9iyIfMpjMigSpMEhidwnAmWBugKWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675852; c=relaxed/simple;
	bh=tGfL13W8ti4YSK/nAW99ULHcrHSz0Etv9XyPU1NgCnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeVZigr8CY3SRU6j08ooZR7l9XftWf5b6AleY/2JpZoRGN7+rEjl+FfPy3qg/6PpNztmwShpkY+JKUOwLu6LPQKLO+o4hbKTdurzD/uCu70zb6Q+vo7IZVMWT9bQUviU87NFJ5+3ejXzFmkRbD1vc5Ym0Pg08vmg1ApEVAAL4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Ra8vI+iF; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D475925D1A;
	Wed, 20 Aug 2025 09:44:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eg5zdjj6xz1G; Wed, 20 Aug 2025 09:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755675849; bh=tGfL13W8ti4YSK/nAW99ULHcrHSz0Etv9XyPU1NgCnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ra8vI+iF6/xFxBmwuQMo1Tp25pzmLZs19io6wRgsYmtwhHkMoQI50B/4MA3p8jjxl
	 Jk5bJsI6WU1J1Wxx6Z34I9uPrqvvnF0RXPMrIq5prPv1WHl2dKUph/Ua5q3Dd+1ys/
	 3VjVEMUd3NSnkYal7EA62k34RHAi8M7BIcaSXeR+XWjrDEjLtqNgLrAOcnvvL1d/uj
	 /bEhFxCY41MnhNQbL/Chs0rQO60nNtJA8Qr9bTCFLyFTQL4LicDpiP/glGFQ8K1Hk6
	 UcR16pT2xtMeG3qV1PwWtJ8rRTnGMCqJKdmasT9jlKgUFsxY0I8OQjGsjh8YubUTWC
	 o7VO49zI0d8Jg==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 3/3] riscv: dts: thead: Scope the reset controller to VO for TH1520
Date: Wed, 20 Aug 2025 07:42:45 +0000
Message-ID: <20250820074245.16613-4-ziyao@disroot.org>
In-Reply-To: <20250820074245.16613-1-ziyao@disroot.org>
References: <20250820074245.16613-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only reset-controller described in TH1520's SoC devicetree takes
control of reset signals in VO subsystem, while using a generic
"thead,th1520-reset" compatible that may imply control over the whole
SoC.

To avoid such confusion, let's replace the compatible with the new
introduced "thead,th1520-reset-vo" that explicitly describes the
controller's scope. The controller's label is updated as well.

Fixes: 1b136de08b5f ("riscv: dts: thead: Introduce reset controller node")
Reported-by: Icenowy Zheng <uwu@icenowy.me>
Co-developed-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 03f1d7319049..025402f6aa21 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -235,7 +235,7 @@ aon: aon {
 		compatible = "thead,th1520-aon";
 		mboxes = <&mbox_910t 1>;
 		mbox-names = "aon";
-		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
+		resets = <&rst_vo TH1520_RESET_ID_GPU_CLKGEN>;
 		reset-names = "gpu-clkgen";
 		#power-domain-cells = <1>;
 	};
@@ -502,8 +502,8 @@ clk: clock-controller@ffef010000 {
 			#clock-cells = <1>;
 		};
 
-		rst: reset-controller@ffef528000 {
-			compatible = "thead,th1520-reset";
+		rst_vo: reset-controller@ffef528000 {
+			compatible = "thead,th1520-reset-vo";
 			reg = <0xff 0xef528000 0x0 0x4f>;
 			#reset-cells = <1>;
 		};
-- 
2.50.1


