Return-Path: <linux-kernel+bounces-859177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB799BECF51
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C74586BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A42FD7A0;
	Sat, 18 Oct 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1JkyaYD"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341052FB99F
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789533; cv=none; b=mH7OTYmW9MnChKQ+hDr+MN0nIfmpNLfv7EpiYxM834GANryMdGy6lWGZ/n9sQwfPtTtuMEbR7mSChyEO/aDwinSN0Y6il86C+HA4usdpWQsGtQPeoUni6X1qU+tosxI1Zg8sQLvL/azpGL1P1FFtd+U5nH9quy21VmyNzFWxmSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789533; c=relaxed/simple;
	bh=3i5hN70EkS+R2vT407APeWIAYo0I/+m93+hR8moAbAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j79cUOlNeuiEH1jwdWH3P1Swho9iIAtfeNi8ygipyoQGYCB3+1IEbUqU5UqqYNBmB+V5qx0VU/e437c1N0esJW84QNNAiuXq/11DlCJVvL/IQ2mtJzc+u5AbQn/NIPGcgxgIqZuO5vCXjIkINFSZSzyeb+ThSM/yjjYfPcO/sCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1JkyaYD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4271234b49cso140087f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789530; x=1761394330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj2U7Ks4Aai4rP5FlRiq75b6DNk0shSZ9f9hco/FDQo=;
        b=X1JkyaYDVQu6ShFZGoHAiHQF2ZYFHMyZ45VDNxgmq28xPHHUcIKNDsTVwmkxtjuTwU
         He/7BPEJV25YUifJMaHY3DqGZmSLbiIQwEodx2qlBIt380FBIA4czrIzcdJad+WkAkM6
         UhbxVXd6BC2/7kdOZ7pbjRvykPFqYzWmkuy4hywMjWVUwfQRbISB11wg0cwDk4GFgsz/
         Ld70ARbakhoA72ph7dYhf5z8jsaTWJE0Cs2HaUkx8Eg+eBVkPozbSQq1c2KsYe0DnOxO
         +GIN2NeC7JRC6VUj3qBuaD1cNUwqQf7EZEsSQcxsAocTbIttG2xBU0WyC/DoR5kn0wwz
         tZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789530; x=1761394330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj2U7Ks4Aai4rP5FlRiq75b6DNk0shSZ9f9hco/FDQo=;
        b=S7KVkOR4BemDLm48V6swpgmMbmZwzv6HCCYXvbHSGoWcvp7PCN1k+Qw8I0s9idM5zM
         h+AL594zLu2HBPJo7ZwgNww/ByYZGy2th3CAun1yMzHG/s2XV4sMozV/U/yi548b5MFW
         3V04vX/0fQgmGxBEQilR2Wp0Zqth3IaWsLJlQO+MG4SemhEI7kzXqVre76fjaDL4eHWJ
         Ye2zgExKKyStHak2op9o7rN7SeBAhT0GT13D+FwmriiPN9oRDIMMKZU96QXBRnrAUveC
         2g+zfsYYfiVI67WCJvHfcFdvOaT64xd7aam1fZfl3NAG0Pnp9edwxBwYZItwPzcb+n2Y
         HlBg==
X-Forwarded-Encrypted: i=1; AJvYcCXmqdti3TA2k3PIzi7Cik+G4Zp7oVSL+2p0G1cfNZw8xHIgF1k8569eGkT69FTC9mhx098HPB2Lj4qWidY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGV4pEwz8tKXc6lOgedVjk46Y5USI97QB1c9aUvCQ5yxSkGyMg
	QEIdSjFTUE7VffDn/zk5OnC7Ym8HSHNd90bNf2AMonVTgvz804UutmMJ
X-Gm-Gg: ASbGnctdEiUR4WvAD6HrY1748xth7o2/uFL+4nB2et3hy2x+yGjyqbgHdIKL5KR42yN
	W6arT1bkgFdE+58t5ecPHTQO7LEyj+bYQ2SimnLWZVhS/X3PJohIM3sKFo+rZI/KN1h7If6nnzU
	LbvJeICHRYGuNNeU6PmbDI4SS3ozPA9R9J4+NChvYTRX1x6ad3bv2ps3clXbClMImUnuHrwZkS3
	6t5OH7P2HWTjwEf4qULQDdg6PrRpyd3rx1OJO6D4VnUG9SsBJnVR51wXA3J0SVLzwqHjb8Ld2pb
	KZCcgqNI4AJGp/shC77BUGeuRw11n/i1J/6EJHvRgJgDKvUnLHZdSeJSmj2ouHH+gobdEDzS+/C
	2AMqt37zP4AgvCfPpNxLTdmuyx1Y/pcsyzUfN9AVoi0ZyzpHEJrqX+FLcvkkKtUB+AkuPbYF76a
	+XtS1lz9NxCY5GC6IIV3UIT12PGgAS7+apjyboEuBBst2uTWAmeLA=
X-Google-Smtp-Source: AGHT+IEBdyKtF2N2KL9lmNfwqEGlADXNFa9DsShem0CkpLr8AuBNYJQxf6N3vylc+U/0FgLDa4AAyg==
X-Received: by 2002:a05:600c:3149:b0:471:161b:4244 with SMTP id 5b1f17b1804b1-4711792a696mr28075605e9.5.1760789530237;
        Sat, 18 Oct 2025 05:12:10 -0700 (PDT)
Received: from localhost.localdomain (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm4763812f8f.9.2025.10.18.05.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:12:09 -0700 (PDT)
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
Subject: [PATCH v7 09/11] ARM: dts: socfpga: removal of generic PE1 dts
Date: Sat, 18 Oct 2025 12:11:53 +0000
Message-Id: <20251018121155.7743-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251018121155.7743-1-l.rubusch@gmail.com>
References: <20251018121155.7743-1-l.rubusch@gmail.com>
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


