Return-Path: <linux-kernel+bounces-835899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B7BA848B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A161B189C98A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD332C11F8;
	Mon, 29 Sep 2025 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="cSLuAtth"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97552C11C4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131867; cv=none; b=A/kbEgZjQ9jpn83eEBW0eFUSmJNKpleIp2EAToQgvPoJAM8kYQkUH6RisqvZnY3Z7ZJo64te6jA/xXqX12hU5Rx1o6wB85wplTGnBq74P/BPEvbMC9iWMWhMAL3QaUod44/1h8Sk5qAfelDltHY/ziVXA727rlzWBStMYf7Fu7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131867; c=relaxed/simple;
	bh=aFzi4qxJ7rQHCA8ko/DkWYKE6oWKyST/QbF/RY7wiNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLyGZejqchoMRlic63Xeyb805b22kBK/EA24xKAtjRgO1kBr2mToGuu3Zm5Jqj04ejBSMbSV5Cwzvus9TL0SyhoyacC/tGR6ZOMn9Uqoow8DtCP5U2PUCWLDSnJ0vFcsk/xT/UxS74TjgnXqytLq8Q/WmSpEnq9r3Iti26YBZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=cSLuAtth; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-273a0aeed57so60285905ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1759131865; x=1759736665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5y/BDQo5bgkRnqVMmNG7pEhS6NIpKO/OpfTCmrBefHs=;
        b=cSLuAtthEvqDOOjTxExFXLoMFd+t2j/INGJ+Ocqv/EfmYNwomVxtmVTvdcZEeE0wSi
         1N7ArRkvla3kGcf7FZ45qnWSOu0ZQmebCWFitSIdAGxETdjxRdnpDw7YMpeu7Xv5SZ9X
         7W0t27IgnCO+aXxCKOkcE8uyohHQmLzDY1hys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759131865; x=1759736665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5y/BDQo5bgkRnqVMmNG7pEhS6NIpKO/OpfTCmrBefHs=;
        b=jIzIeOc7W1lKQyYbd9Rl1T/ZSOkW1jL2eozMkVQfyxgZrpWCSe9lPFMzDOCZdi2Wll
         Gm6YGodYdH04xX9DhDeMy4E5lu3VmiHMTSND3JGbN2O4DyXgcuR5EmkCHBfER5curppb
         MgJt34aPCMOVsF8w8/oWYRXZUg71iXBREusMKWShbkM6NgurGJ4YesfPKB2GvNT1Ug1F
         20YyBTArxKNjNLW98XpSg2/dpF+mi21WTnUmWzVWkAn5O5guQ7/1aCIQvhC5Oc69VEns
         OZV7zbyP4SQoRYE5PadANlyDitYYiQw7wBWVbEbFWeQJ3lSpYDtxcTm47e+XxYevhJyN
         baqg==
X-Forwarded-Encrypted: i=1; AJvYcCVc9XG4UeMdhZJ9jK85U/omOVMkNDOrMU1MzGORc8mfRxz2D0rQWpn/G+acYjskYApYssoJaESEPRnEn/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Hb4NBwmY1wnKDsTh487BVh6SX4AwJf2aGqLvlHd4YJhRIZP9
	ZF/wnRZ7Uojqi5WqJ//HU6FbSjf9j1VizL8w3/IkTiui17EJK/q/vdj+Vjx4YAJbKNo=
X-Gm-Gg: ASbGnctUPKBp6LAR2SHrKQo2ys6gH4fW9PVIYd8BpXcc0sfVMCB24uCIr1BoD2oWYG4
	J9sKivEoKdvZKeWFJaG4IoE8Yk3xrktJ99mtoNkwhuKS40NN2gP5ew4Fu2v4WSvATQpBUO8UVtO
	2fMhQ9LPkfSuW2ogK0fBLgLCtWaMCgCBivvhrofUtOfZWZF3w759WlXYgWk+aNoHomho2y3tH92
	VV37Wxps006LcrWatO0QMYHenNrd5PDv2d3QVGqT/SV7ruwaqq1DTF0i1+NTPcLwWJ4oU0YxKjz
	/33ecwJfMQhk25jwv0iP/nSuqzPt7vse1YpwH8E+nhkeZjvQXMHkLey8kGkEyrVAOUvh4WROIKk
	LJt8zvorXU2ufc0Tg1Fa0VUw+YKTHBrLA475hCTGyfucrSKScS716JLM4
X-Google-Smtp-Source: AGHT+IEDdXtz5qjT/GbVC2bSEbaweaSIC51I+exSyhQsqO8wXjylseRoO6Bbj4eZSqZG/Dc28Q2KUQ==
X-Received: by 2002:a17:902:ce01:b0:267:c1ae:8f04 with SMTP id d9443c01a7336-27ed700e02bmr142895605ad.20.1759131865012;
        Mon, 29 Sep 2025 00:44:25 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bc273sm121341105ad.124.2025.09.29.00.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:44:24 -0700 (PDT)
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
To: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	herbert@gondor.apana.org.au,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ruud.Derwig@synopsys.com,
	manjunath.hadli@vayavyalabs.com,
	adityak@vayavyalabs.com,
	Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v6 4/4] Add SPAcc Kconfig and Makefile
Date: Mon, 29 Sep 2025 13:13:34 +0530
Message-Id: <20250929074334.118413-5-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929074334.118413-1-pavitrakumarm@vayavyalabs.com>
References: <20250929074334.118413-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Makefile and Kconfig for SPAcc driver.

Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509271802.8KQP38Ht-lkp@intel.com/
Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
---
 drivers/crypto/Kconfig            |  1 +
 drivers/crypto/Makefile           |  1 +
 drivers/crypto/dwc-spacc/Kconfig  | 80 +++++++++++++++++++++++++++++++
 drivers/crypto/dwc-spacc/Makefile |  8 ++++
 4 files changed, 90 insertions(+)
 create mode 100644 drivers/crypto/dwc-spacc/Kconfig
 create mode 100644 drivers/crypto/dwc-spacc/Makefile

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 657035cfe940..ada04311c370 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -780,6 +780,7 @@ config CRYPTO_DEV_BCM_SPU
 	  ahash, and aead algorithms with the kernel cryptographic API.
 
 source "drivers/crypto/stm32/Kconfig"
+source "drivers/crypto/dwc-spacc/Kconfig"
 
 config CRYPTO_DEV_SAFEXCEL
 	tristate "Inside Secure's SafeXcel cryptographic engine driver"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 170e10b18f9b..e0d5e1301232 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
 obj-y += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-y += xilinx/
+obj-y += dwc-spacc/
 obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += intel/
diff --git a/drivers/crypto/dwc-spacc/Kconfig b/drivers/crypto/dwc-spacc/Kconfig
new file mode 100644
index 000000000000..736b332c9c94
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/Kconfig
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_DEV_SPACC
+	tristate "Support for dwc_spacc Security Protocol Accelerator"
+	depends on HAS_DMA
+	default n
+
+	help
+	  This enables support for SPAcc Hardware Accelerator.
+
+config CRYPTO_DEV_SPACC_HASH
+	bool "Enable HASH functionality"
+	depends on CRYPTO_DEV_SPACC
+	default y
+	select CRYPTO_HASH
+	select CRYPTO_SHA1
+	select CRYPTO_MD5
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_HMAC
+	select CRYPTO_SM3
+	select CRYPTO_CMAC
+	select CRYPTO_MICHAEL_MIC
+	select CRYPTO_XCBC
+	select CRYPTO_AES
+	select CRYPTO_SM4_GENERIC
+	select CRYPTO_ENGINE
+
+	help
+	  Say y to enable Hash functionality of SPAcc.
+
+config CRYPTO_DEV_SPACC_AUTODETECT
+	bool "Enable Autodetect functionality"
+	depends on CRYPTO_DEV_SPACC
+	default y
+	help
+	  Say y to enable Autodetect functionality of SPAcc.
+
+config CRYPTO_DEV_SPACC_DEBUG_TRACE_IO
+	bool "Enable Trace MMIO reads/writes stats"
+	depends on CRYPTO_DEV_SPACC
+	default n
+	help
+	  Say y to enable Trace MMIO reads/writes stats.
+	  To Debug and trace IO register read/write oprations.
+
+config CRYPTO_DEV_SPACC_DEBUG_TRACE_DDT
+	bool "Enable Trace DDT entries stats"
+	default n
+	depends on CRYPTO_DEV_SPACC
+	help
+	  Say y to enable Enable DDT entry stats.
+	  To Debug and trace DDT opration
+
+config CRYPTO_DEV_SPACC_SECURE_MODE
+	bool "Enable Spacc secure mode stats"
+	default n
+	depends on CRYPTO_DEV_SPACC
+	help
+	  Say y to enable SPAcc secure modes stats.
+
+config CRYPTO_DEV_SPACC_PRIORITY
+	int "VSPACC priority value"
+	depends on CRYPTO_DEV_SPACC
+	range 0 15
+	default 1
+	help
+	  Default arbitration priority weight for this Virtual SPAcc instance.
+	  Hardware resets this to 1. Higher values means higher priority.
+
+config CRYPTO_DEV_SPACC_INTERNAL_COUNTER
+	int "SPAcc internal counter value"
+	depends on CRYPTO_DEV_SPACC
+	range 100000 1048575
+	default 100000
+	help
+	  This value configures a hardware watchdog counter in the SPAcc engine.
+	  The counter starts ticking when a completed cryptographic job is
+	  sitting in the STATUS FIFO. If the job remains unprocessed for the
+	  configured duration, an interrupt is triggered to ensure it is serviced.
diff --git a/drivers/crypto/dwc-spacc/Makefile b/drivers/crypto/dwc-spacc/Makefile
new file mode 100644
index 000000000000..45d0166dfc8f
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_CRYPTO_DEV_SPACC) += snps-spacc.o
+snps-spacc-objs = spacc_hal.o spacc_core.o \
+spacc_manager.o spacc_interrupt.o spacc_device.o
+
+ifeq ($(CONFIG_CRYPTO_DEV_SPACC_HASH),y)
+snps-spacc-objs += spacc_ahash.o
+endif
-- 
2.25.1


