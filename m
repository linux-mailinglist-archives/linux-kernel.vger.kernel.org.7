Return-Path: <linux-kernel+bounces-859169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC64BECF18
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E3804E4304
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28E42D0C7F;
	Sat, 18 Oct 2025 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK/h7Wzl"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C9264F99
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789523; cv=none; b=lXrXQgr/ojgggxRpB8erjMaoNRycHNpO2hDppL8En5A3c74U7hKkZ0lSrTZfS9MwPHK5Ngk9oZ4l4wbhlbXIgenoF9KYr5LG9TDyun8oaRKiG61htokMzCOcR98/c82OHkGdQ3+fe205hBp1vpnAisVOL6c5kMO2+2VzcCXw97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789523; c=relaxed/simple;
	bh=Zm/F6uFyMc4nnEbtPWODklxGuzdzraA3ZsA0+iIdu1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJxuEexYn/PEGyw1Fo9at6kddY0Pxdj3eEC4PMebJ7ipL2bMZAldzDcPtfPTpGUNJteZgzV1D1hdG3Rghx2KX4QlaLf7qI2xGCEyAEFP3Z4GMDqEx6hiOOl30SyaNFWulUGQSB4c+3eD4OJyrbvi00Zi7yTSaoqtAFu7KjkJlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK/h7Wzl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-426ff579fbeso321995f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789520; x=1761394320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mFohtVVslXrTyo8hMYkLuQEeqxiLiM0O92p+2v9UC8=;
        b=kK/h7WzlJjjMGW95mE2R5G4XVJ4OIde2XRrdgxdNuxl1k3E7Oa7izSQkdWe7eJhY62
         w0OgJ3YuRrZz0Bj2OCa05QT1TVSgT29DSZCId4AETCLQ0EROO8X8UyjkEgbTh1X1BOls
         gH3ChmKvHOnjdpuWS0Ch8c9vTqogOOXXZQJWDuWXU8cPWWcIL8Uq72EZDxnffKqsza5j
         2YokSavg+5PBeSpglDQ/Xf6jvsPfxck1LQ/x15cfXiXHfUjqJQ1qGDUai5wWhjA7m3O1
         u+KtNzV9u5FWQJO4svBqaGcI0qi83tiKlaz/MZ6ul5Hpjzn6Z/YcBpI1P4XcSr0yG2Ea
         K1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789520; x=1761394320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mFohtVVslXrTyo8hMYkLuQEeqxiLiM0O92p+2v9UC8=;
        b=HxFx7X7P6P+PUlR7mDwh1iYDyr8d2sbJzdSyqK75B0/dtmewsLYxsjImAvJG9BXNyT
         +5Fj9Kl4SdWMztxT2SfG0WmIytd+DkwivBScsCvD/fgSpUDCGUMiJX9vodIwV4ZMirYL
         og2Cbg9wjrdw+nJ5QtcYH4HoVc3wf08FZ4yBGJG9RY5qsUyWjERdt65q4xmqldH+HglB
         VyIXaFFaadNc3oz4E+LYWNtWa6YdxAI1u19rSsOhqQWXzapKPox8NqLbuyYdvC2fwQKl
         SAbGrnnRjGwZ8AA+KtdYhg07VV2fCFqSyE5ELn0abViqnyWLVAd4je9aDjdyBjZLEicS
         1+VA==
X-Forwarded-Encrypted: i=1; AJvYcCU/T0sTDC7GumAMV5wReQiTAyf8tzA/cxtwAsLVAu2gt0HfkyNhI7DkVqW1DS18qokoVzqco2nlZu5bAAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygIBEWd4skbU6/bEwpue57EvXVx1RssRQwMwUqixjqYrmcSjzD
	QE6NS+LUBeA1t5qvXgZMKJ0tgMF0X1HmqIzTGBmHkXyZYBkh6u1ZhZ27
X-Gm-Gg: ASbGncu2z6u5z+pChg2w5jtL/VV2UAWhMPHBu8kXiCVfDAJN3oBu4V1y5KUo2cz/JLq
	KulVqj27sRi5A6/R8iotQdao+zc7w3T2npb3BuIh6+GaIwFiTxQcyxfmBqciA0R6tgyB0ufOFJd
	AGrN+LfRnMu4LO6retippmxZ7YBj8Viz0sZZk5vpqLa5qRyc3lk6IcWE3s9qsDS3i60f/X6yKxT
	w19heL8hxed17MJZInbOrnmgoD6QQyXvDY1HLYu3s7OIXJU5BPH3/TxFpY3twRVdRE0g31lYP2B
	j02GNaQvUsqaKa0CF8PESb1nJPFxzLK9luQYH13Gwza9c459207a6Xm2+yRQzeQTaJDOh7DS+TS
	/vOgRc8PC26k0mAG7XP9wIpV4d+610TXFgRe7mCWtUtyC+eTOYgNg0S9FoGLVgw+GcnxJNxxWEh
	6cLJ9Xwf6wLbQJOhum4CvCqxyj3vRxQKqM2lgFQWO44wTFY7B/4f0=
X-Google-Smtp-Source: AGHT+IH6Mz87+NrxpXtmwU/KYU3mRF4neYs964czY7WUGPjpjN+OX7ReDKdoBL663BBjzeMtGF0DiQ==
X-Received: by 2002:a05:6000:2383:b0:425:6794:f19b with SMTP id ffacd0b85a97d-42704d14627mr2731734f8f.2.1760789519475;
        Sat, 18 Oct 2025 05:11:59 -0700 (PDT)
Received: from localhost.localdomain (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm4763812f8f.9.2025.10.18.05.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:11:59 -0700 (PDT)
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
Subject: [PATCH v7 01/11] ARM: dts: socfpga: add Enclustra boot-mode dtsi
Date: Sat, 18 Oct 2025 12:11:45 +0000
Message-Id: <20251018121155.7743-2-l.rubusch@gmail.com>
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

Add generic boot-mode support to Enclustra Arria10 and Cyclone5 boards.
Some Enclustra carrier boards need hardware adjustments specific to the
selected boot-mode.

Enclustra's Arria10 SoMs allow for booting from different media. By
muxing certain IO pins, the media can be selected. This muxing can be
done by gpios at runtime e.g. when flashing QSPI from off the
bootloader. But also to have statically certain boot media available,
certain adjustments to the DT are needed:
- SD: QSPI must be disabled
- eMMC: QSPI must be disabled, bus width can be doubled to 8 byte
- QSPI: any mmc is disabled, QSPI then defaults to be enabled

The boot media must be accessible to the bootloader, e.g. to load a
bitstream file, but also to the system to mount the rootfs and to use
the specific performance.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga_enclustra_mercury_bootmode_emmc.dtsi     | 12 ++++++++++++
 .../socfpga_enclustra_mercury_bootmode_qspi.dtsi     |  8 ++++++++
 .../socfpga_enclustra_mercury_bootmode_sdmmc.dtsi    |  8 ++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
new file mode 100644
index 000000000000..d79cb64da0de
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&qspi {
+	status = "disabled";
+};
+
+&mmc {
+	bus-width = <8>;
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
new file mode 100644
index 000000000000..5ba21dd8f5ba
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&mmc {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
new file mode 100644
index 000000000000..2b102e0b6217
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&qspi {
+	status = "disabled";
+};
-- 
2.39.5


