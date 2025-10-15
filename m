Return-Path: <linux-kernel+bounces-855212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5184BE0877
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA7C585A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665F303A04;
	Wed, 15 Oct 2025 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5LS+z62"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6430FC28
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557485; cv=none; b=Ro6mkNnGImBLd2IWMiorJRyriZa3/y8uuJCpZbe6I4+UAT5kW9Ol0i8+g++xJ9OAFhciDkNEUuc2ZdbSLtIBbThcBgQt7/R+F6fELwco7yWxIOlD5zbkqUf95IekJWuJQngaBEzlS///apCTaIyEFhxSXS74BskP0/2O2Pi4XI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557485; c=relaxed/simple;
	bh=g3c67g0JuAQ/MF5TeeywHnKyQWy5NcHxIAatThiSlk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DgGGbfU4YCtsMIam0q1D6CDZfchnFjKy6lHSNDTa3oEMjTGuv4Yi2VaJvr1DTzoGeTvsv0TySGr4aQOd/WaPN4kdtpm24BcXHN5KSYRzzvgaWtMR/CmgEhyjFE8X81jUZc2ntjU8vHCnDMj0/8Td3HpZtcpSisrDVqWajWhjb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5LS+z62; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47103531eeeso1313035e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557480; x=1761162280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0t4ELZpwdFTZdxiqhNSp7y3ezBf0UkavYUxtLN6k7g=;
        b=l5LS+z62+Veq1SO/IPrwvRqV++NbLG3c4WL7h9wLxm9t0hsD3egK54MKYq1l2SWmYL
         N/dpT4cFEdCo1YxGQY162V1CeiSmmLxyHfhYF0GP0x+p7ze53BP3EU6Wj/8nKmBcqwOa
         PCYNidGfwIhNUe+nsHFrpc9BRN/qIEq0sKqxlYqMv2UvsjF5QoNGy+toRyR619SMaYd/
         tYZH62JlKnFi/tnwBO0h69wT0LXHYs2HCc3iRaGCZ2yAILM6A9bZeWbqzew3PunHvNN7
         uDQC1BMxL0Kg6u/dibeMZsg+7vb7W0T1Zk7p6kTvWtPn34UIrrDi7vuoR+m93DS8OXNW
         gGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557480; x=1761162280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0t4ELZpwdFTZdxiqhNSp7y3ezBf0UkavYUxtLN6k7g=;
        b=julzrpPwzEqVlhqQ/JlXm4634WOGUV2bHCMZYVHcr8Keka200N1UZVWl5RfvHmvfu5
         niEvSbKZNi2QNjkk/EVMJ9hcqmgRzAiwLa6TYl1JVtwxaqUXT0sct3IA7Xex2f0je5n0
         fqqmEyZ68IjGhJ20VvnGNRmU1nXC8YCnAxHIxW38IJW69euOF4W5u406VynskQGFiO+g
         +bRZRT7Lm8MoLeLqWHfyqt+NC7L632Q1pyE99h+lR6tSibBqLRVZ9eejpLh0f0jdKiYl
         KBeycrJ+UL/zzwBDDNKSIFuqYYlmg94CLikxamzA4Zd7y+7mKZ5sJVHDvNThfb7RMc7I
         ri0A==
X-Forwarded-Encrypted: i=1; AJvYcCWBCd9l58sk39X+z/nNxSO+LNIg4EtirPUOS4cgBiSrHMVTDG77yrs1WjvXK1AxHAlqxmHxmj0YqJ1guBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTSpFHTra0ycSmVe9h9S3YR4YDy+S/ue1m3+C6tn8FpcompTf
	OHDBzl04u1cl5iU7xMN3tVk3MJYL/f1NCwUEkhKc/6S3DOAZjE2eHgva
X-Gm-Gg: ASbGncuIoPG3pFl4pFg+JoA96klyvsGDJd8/pCUWemb4j23mcIPCTz5q/6b73GE/qn9
	ddOLzmTFyGWlX6jnUf7/0eJUs3eZJB0V4CgE4X6TDkTEhkP5SQ0ZRzXOe4qPpeZ++498H5678bq
	I/QFMou+SmMI0KHJzL6WprYEv68ysvTQeqtvzgnz/iQaI/B3sgfs03ZYnmeCsvLvf0dXV/OTOvh
	iptz5KqdXp1QizGBXa6G0/nXOLUTWi575B2KTzFw+TEFwsMu+fHNYl2lgd5vKim/IvYvwGsUb+C
	Fo77Z0GH4ocjT8rA7JeexFMDtxEplObXmMcgmqBcuwSQft/YSB52j+ojFWI3SyqXKyUFz/P/R0m
	2hrDT8oldL8CdEkHBLvcIE5MR/rRnu1OT46sgezS0D/yEXc89EhQgLD4C6Z6hJhRniNiQtBM1gA
	Ioe1EPK9f/DMR+iqVvJUj6lO8x6d58ddFHqDJcAakMj9G/+V53SVfl3LPbtiI=
X-Google-Smtp-Source: AGHT+IFXOS6l7hNbQ6Qgd7a7LAjAdBl92r89g4mI/45u1/vUukXrYjISEjg9uQL0y7uwCZNCNptdCA==
X-Received: by 2002:a05:600c:1f16:b0:46e:372e:bfe9 with SMTP id 5b1f17b1804b1-46fa9b1b317mr112364735e9.8.1760557479889;
        Wed, 15 Oct 2025 12:44:39 -0700 (PDT)
Received: from d25728c254ff.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm30291626f8f.14.2025.10.15.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:44:39 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/11] ARM: dts: socfpga: add Enclustra SoM dts files
Date: Wed, 15 Oct 2025 19:44:16 +0000
Message-Id: <20251015194416.33502-12-l.rubusch@gmail.com>
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

Add the approach to set up a combination of Enclustra's SoM on a carrier
board and corresponding boot-mode as single device-tree target.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/Makefile      | 24 +++++++++++++++++++
 .../socfpga_arria10_mercury_aa1_pe1_emmc.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_pe1_qspi.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_pe1_sdmmc.dts | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_pe3_emmc.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_pe3_qspi.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_pe3_sdmmc.dts | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_st1_emmc.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_st1_qspi.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_st1_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe1_emmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe1_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe3_emmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe3_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_st1_emmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_st1_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa2_pe1_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa2_pe3_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa2_st1_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts | 16 +++++++++++++
 25 files changed, 408 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts

diff --git a/arch/arm/boot/dts/intel/socfpga/Makefile b/arch/arm/boot/dts/intel/socfpga/Makefile
index 73a912ec6d95..8df0976da01c 100644
--- a/arch/arm/boot/dts/intel/socfpga/Makefile
+++ b/arch/arm/boot/dts/intel/socfpga/Makefile
@@ -2,6 +2,30 @@
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_chameleonv3.dtb \
+	socfpga_arria10_mercury_aa1_pe1_emmc.dtb \
+	socfpga_arria10_mercury_aa1_pe1_qspi.dtb \
+	socfpga_arria10_mercury_aa1_pe1_sdmmc.dtb \
+	socfpga_arria10_mercury_aa1_pe3_emmc.dtb \
+	socfpga_arria10_mercury_aa1_pe3_qspi.dtb \
+	socfpga_arria10_mercury_aa1_pe3_sdmmc.dtb \
+	socfpga_arria10_mercury_aa1_st1_emmc.dtb \
+	socfpga_arria10_mercury_aa1_st1_qspi.dtb \
+	socfpga_arria10_mercury_aa1_st1_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa1_pe1_emmc.dtb \
+	socfpga_cyclone5_mercury_sa1_pe1_qspi.dtb \
+	socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa1_pe3_emmc.dtb \
+	socfpga_cyclone5_mercury_sa1_pe3_qspi.dtb \
+	socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa1_st1_emmc.dtb \
+	socfpga_cyclone5_mercury_sa1_st1_qspi.dtb \
+	socfpga_cyclone5_mercury_sa1_st1_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa2_pe1_qspi.dtb \
+	socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa2_pe3_qspi.dtb \
+	socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa2_st1_qspi.dtb \
+	socfpga_cyclone5_mercury_sa2_st1_sdmmc.dtb \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts
new file mode 100644
index 000000000000..b6cca0b5fd09
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa1-pe1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts
new file mode 100644
index 000000000000..6ad023477cd2
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-aa1-pe1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
new file mode 100644
index 000000000000..653c9a86516b
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-aa1-pe1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts
new file mode 100644
index 000000000000..ae9c7c6a2370
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-aa1-pe3", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts
new file mode 100644
index 000000000000..c3a0c30a07a5
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-aa1-pe3", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts
new file mode 100644
index 000000000000..dc1e1ad20381
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-aa1-pe3", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts
new file mode 100644
index 000000000000..61d5e4c85d9b
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-aa1-st1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts
new file mode 100644
index 000000000000..a3b99c9b16fd
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-aa1-st1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts
new file mode 100644
index 000000000000..5deb289e2b55
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-aa1-st1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts
new file mode 100644
index 000000000000..85d6146da0da
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa1-pe1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts
new file mode 100644
index 000000000000..770ab680a18c
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa1-pe1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts
new file mode 100644
index 000000000000..990ca0fec61e
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa1-pe1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts
new file mode 100644
index 000000000000..6c8fd5b0d6eb
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-sa1-pe3", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts
new file mode 100644
index 000000000000..3292426078a1
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-sa1-pe3", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts
new file mode 100644
index 000000000000..1eb10b5244dd
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-sa1-pe3", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts
new file mode 100644
index 000000000000..8c97b5b3adea
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-sa1-st1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts
new file mode 100644
index 000000000000..e6d14b22e41d
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-sa1-st1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts
new file mode 100644
index 000000000000..beaeca94d4df
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-sa1-st1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts
new file mode 100644
index 000000000000..6f79d9ed1d36
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa2-pe1", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts
new file mode 100644
index 000000000000..b94bd8bafc26
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa2-pe1", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts
new file mode 100644
index 000000000000..51fc4a22937a
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-sa2-pe3", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts
new file mode 100644
index 000000000000..e4209209f4fa
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-sa2-pe3", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts
new file mode 100644
index 000000000000..ab4549a0d455
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-sa2-st1", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts
new file mode 100644
index 000000000000..ebe62879c3fb
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-sa2-st1", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
-- 
2.39.5


