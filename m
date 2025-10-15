Return-Path: <linux-kernel+bounces-855210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C33BE084C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5451500DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFA4310625;
	Wed, 15 Oct 2025 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ+dfe6i"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655E30FC1A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557481; cv=none; b=q52Q8+GjfRg8nUPoNBDHXNcK7gSL2Wvrq+u6+PYHG69WiJzpeuVBwAGpyLhW7adnQcMRJqjFM/TT6JimIxFdkR5i0tozk4rmqRi8qqIebd/8paioAHFVUZ4YJ+SIP96QqbZ3U+v5HBdccKVzXsJBDh4KS29kVDiO8hm+eRi1onc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557481; c=relaxed/simple;
	bh=3i5hN70EkS+R2vT407APeWIAYo0I/+m93+hR8moAbAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkjSOyBA+Kt5NJSJAtD9wZfXpTiXPR/m1c6trjR4x5aMGHSogfwgvTMFOqJBp0RJF8MR6GFistbMYGGvF7Omw9m6Awi6YQNnUqlfHL4MWKHzQe1yHrtWxDlm5zh8BMvaLR1lMdcoNXhKItgkLwj3hKo6Jn/vyKsfssukUtAk9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ+dfe6i; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e610dc064so3413315e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557477; x=1761162277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj2U7Ks4Aai4rP5FlRiq75b6DNk0shSZ9f9hco/FDQo=;
        b=PQ+dfe6i6c47AyMoa8WfUf9jRhKT7OYaVZVa8EmBzD09KToG4E3iEy0XnDgnLLnZbq
         ii0IUp3ZxtXpMBOivOG7Dl9xaja8qNV75/0LpLJKbOHkZftTSjXCizN+0cWM2tZkmIrw
         3fmTpGNG8FtFwIwPgNYv1pes3dtTb9g6PGrl3/0vga5pnVF6sQ/7Bz1xcOm3OyD32v2K
         ZawFk6uqAVqy1I9mhL9ey+90Tn5BHV3jPXSzCDO5B13uyQVW6EeXQx5jC1sB0GmlQlB7
         DVtgQwlR1woth6tckcWnqukIJS25XjOKtfABeADezYyKt6mF65Lt+uvnZB0EyQ6+tRHD
         AYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557477; x=1761162277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj2U7Ks4Aai4rP5FlRiq75b6DNk0shSZ9f9hco/FDQo=;
        b=udtvJvTi5L26cnTK1z0tSjd1XQmmk2owiTXoeZ+rAO3fG9W3vxIh0F9QuiiJDUL+Se
         R7C+Dh1I9Xihvt3d14ebZm2Inhnsn9pPoi5zS+/xN0AD1kTY+IToExityM6Sa+Os37h/
         M+EFxAYvJYT0mYcjgtyqKAl82W4Dn3UoKh4ZN0u9QGZKn6W2yvTJuAf1ttpIqMfsKdgn
         5y3E0Mm9lgqaGdzrN+BReUVpvWAH3VWWrCd+HeF2A1Ty1WPDLA/4a0ALg9UZNxi370vz
         vYgiEO+h6mHRBLcgd8chyoGU2NIe3wcHpa6ArkXhKsjwEv8oyjPFkHyd6xOV5SQR2w1h
         LZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfPoZCsMyIBrLkD/bYXNI/Y2aanR8cmFkIgoezfRoa9vd0psjuujPCCKuQaCSgDjMb3TGGBWoA0Mfen+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLC29vsCmSOGkaVzb7O4UsyAIgSb5XFRScaA+atNpuP6CitTIA
	BOrWf9qsSwDKcOkyG5L20/1sN+6lG5gXNJawrP8ZMndfcvpphc23AJWc
X-Gm-Gg: ASbGncsQzR1AX/M4t1FHev2ZdltWsBPMdXkYYb4+P/pt4Kc764drDPcRo8ugbM3EcGN
	rNPClvubSFWKsleSzuYM6mlirWrLHnATfeZ8GWrVPcsxDDbpoxkHxQ/cKtsvlklXuB87Z28ejqn
	AsqH5nENmXT46YVTVCIBUrlAusxOcZISQIvM3CMpKPHCxh+wdhFcSUUHeteq85X/XVN/hZ2CC0C
	XsixRMETMNzDCiGEgvPacCJH/h8FWcBPlFdD7kLL1zAbTN47EuJPLu1uYKnFIjhj5gVKLqWvClP
	A4E1mC3vXNNchKZVHgmntZIg+0E1wuod5YwVoRftIYGV+zqiComDojfbo3fhVsTCmb6hbqbF8Aq
	/C99Rm4wWH8cZAENpxLpsZBaP/x8q2JMifFhQ4qniZm+qEwa03fSFKdvfXerd/Co+eH0D5UBlqY
	qspXCOSpOrJJ8LC81NYe4t2eZa
X-Google-Smtp-Source: AGHT+IG9nNYh1Tga30j2fYYBJBAKSBKjoyirMWGm3c9G6NcAqE/8JulL7YypdlXWl0e9Sv/xentthA==
X-Received: by 2002:a05:600c:548b:b0:46e:3c73:2f9d with SMTP id 5b1f17b1804b1-46fa9b06c1bmr123745385e9.6.1760557477488;
        Wed, 15 Oct 2025 12:44:37 -0700 (PDT)
Received: from d25728c254ff.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm30291626f8f.14.2025.10.15.12.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:44:37 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	martin.petersen@oracle.com,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	bhelgaas@google.com,
	l.rubusch@gmail.com
Cc: arnd@arndb.de,
	matthew.gerlach@altera.com,
	tien.fong.chee@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v6 09/11] ARM: dts: socfpga: removal of generic PE1 dts
Date: Wed, 15 Oct 2025 19:44:14 +0000
Message-Id: <20251015194416.33502-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015194416.33502-1-l.rubusch@gmail.com>
References: <20251015194416.33502-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the older socfpga_arria10_mercury_pe1.dts, since it is duplicate,
the hardware is covered by the combination of Enclustra's .dtsi files.

The older .dts was limited to only the case of having an Enclustra
Mercury+ AA1 on a Mercury+ PE1 base board, booting from sdmmc. This
functionality is provided also by the generic Enclustra dtsi and dts
files, in particular socfpga_arria10_mercury_aa1_pe1_sdmmc.dts. Since
both .dts files cover the same, the older one is to e replaced in
favor of the more modularized approach.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/intel/socfpga/Makefile      |  1 -
 .../socfpga/socfpga_arria10_mercury_pe1.dts   | 55 -------------------
 2 files changed, 56 deletions(-)
 delete mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts

diff --git a/arch/arm/boot/dts/intel/socfpga/Makefile b/arch/arm/boot/dts/intel/socfpga/Makefile
index 7f69a0355ea5..73a912ec6d95 100644
--- a/arch/arm/boot/dts/intel/socfpga/Makefile
+++ b/arch/arm/boot/dts/intel/socfpga/Makefile
@@ -2,7 +2,6 @@
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_chameleonv3.dtb \
-	socfpga_arria10_mercury_pe1.dtb \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
deleted file mode 100644
index cf533f76a9fd..000000000000
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
+++ /dev/null
@@ -1,55 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2023 Steffen Trumtrar <kernel@pengutronix.de>
- */
-/dts-v1/;
-#include "socfpga_arria10_mercury_aa1.dtsi"
-
-/ {
-	model = "Enclustra Mercury+ PE1";
-	compatible = "enclustra,mercury-pe1", "enclustra,mercury-aa1",
-		     "altr,socfpga-arria10", "altr,socfpga";
-
-	aliases {
-		ethernet0 = &gmac0;
-		serial0 = &uart0;
-		serial1 = &uart1;
-	};
-};
-
-&gmac0 {
-	status = "okay";
-};
-
-&gpio0 {
-	status = "okay";
-};
-
-&gpio1 {
-	status = "okay";
-};
-
-&gpio2 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&mmc {
-	status = "okay";
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	dr_mode = "host";
-};
-- 
2.39.5


