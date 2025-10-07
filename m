Return-Path: <linux-kernel+bounces-843840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8313BC0632
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F10B24F354B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892323C4F4;
	Tue,  7 Oct 2025 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="Iow1UycH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5CD229B0F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819867; cv=none; b=CZeUVEAVAwru8JrJ5cPNDmBzZul6+v0Uh3fzOyKnHm1k7wiDxaJ8yNqvITgoDpc9FR2PgY4PNSnbzMIAgqkxEZO3rLJQZrjbhI1rsxWntOd01/8icttD2Sx3xap2NS+xnt5sncv68lB99IZ5UusCI6a/DcfqUhg9dsPxEfMgLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819867; c=relaxed/simple;
	bh=PzPp5lh4w9MAIVL6Y3lW3zsso39XiIKfrNvEK/RYtJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GH6OlBS3dkcnLGpxqJmLWH/S8nKuDa3shY7M6zuyr5U28SmXvIFKxcxr5q1Xx3nmSjdY7PIaRkzcRCgyGs2To3kq5G2lEguRx6AuiGed5G5Gc/QtBajYhm71tublFNypr2atnR/XQEdL7FRQYzmRlbfEufk7gZxi5luoly5IuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=Iow1UycH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eec33b737so79318175ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1759819865; x=1760424665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1JvAAk4cJnEamYn3QhmqYlNG1sfQI/VEnnjVQb6AzA=;
        b=Iow1UycHOMUL7jid1e8QJpV9hAgyKrlOJG2uLUTuAE1wFcKcxSWeFOJoU/J+9WJap9
         usSaINIKdj630BrR+KKDxO1r6HrtNYDvN+QCdC/nwFJOjZuJDVAp58mcaZREK6cYPXsy
         GzSWHEJzCVCc/pAv9innZT4mIYounYQZFOJ1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759819865; x=1760424665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1JvAAk4cJnEamYn3QhmqYlNG1sfQI/VEnnjVQb6AzA=;
        b=I4rBEBUYxydViBG6BUVoAfmaX3ZJXg+yRlfJOtHAOJgAld3LklRbm6DLf+dJTLs/jd
         9LPpZdR6staJxjfg1txMCUP5pN2GQvWmT3u4JW3TxCNU4pRQjD5VyqK1JL3IyPm79oAk
         V90i/8mmfkgQTGOXkRl9+FaTNSvFWTGcReq2iQDVp+XQuh1kegADDANTzJatiLvn+Xnb
         Nhe1mlX7g9T2pTIO2oAcZMubHF82lXFNLs1Ji+i2VfKP0a9A0BJdJGskfbleTojGSPzG
         w00MMcbCgUDWnHcwV/fXklOCWMeNmxK76pGeDH25JwWEl7bVyv3d4JhbZ3uEMUGzK9c1
         ygGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGruRPG2+MO4e4I2y3IVnyPNt99s9zsvSlRsL6TrXT9hqngEq7W6Avl4EGswizVI2f8VRgY0LO8vZYU6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5t0ZSJlCxSIADojjhU2GlcDQfHtAlu7d0uhtsTxHAXBOg52bR
	UqvGUokJL2+885+IOsGob15c0qVZEiFncidoN5nPS7ZmFimyGkKy2QT014epN4clR6U=
X-Gm-Gg: ASbGncsnObFs04o1ExfQ3hhcQ/GHHOgmfm5Rm1b7v0km8X+8XCyVGsdWg8xfxH1tyC7
	UX/Kx8sQF0ylInSe6ArySC6wBCzw58J+KLnKUCu3uT+hPsdJ0Oa/pBSJEeKMCzCgrJUzNB366LS
	tl6PKXSy0SwM0fY2qSBAIC2Lv89N2WfCnEdoxfaVmi3kdnSkQAUdj99xjejzCaJlNg7RviwvFTV
	pQM5t65NGK2c0VO2XTfw1sAit5deC9ia72/Zd1op2MCnE560u+s9u9PcEzFReAGSnbScfCZHr80
	ZVYDJbZpH3vrIisP1b/RwgmrvEjEodkloFY6oMRY7QpDPZRspjlsZQd/H2I8ir5EOxr1zI6/lAb
	CahffW7/hXavclQzPkFzUWNgVdSwRzBeGL0mPhjaVHtlQOFCy1r3xXNVM39aW9awU1S72OQ==
X-Google-Smtp-Source: AGHT+IH/Mv8ei/4xdbbFNwnpkB2DI8J/Gdq1XPNmETcnbdutsxPo4WAgyfoB4/wa01Wc9l2mpIRYkA==
X-Received: by 2002:a17:903:196b:b0:271:479d:3de3 with SMTP id d9443c01a7336-28e9a5609bfmr187778975ad.12.1759819864927;
        Mon, 06 Oct 2025 23:51:04 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d111905sm153287745ad.24.2025.10.06.23.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 23:51:04 -0700 (PDT)
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
Subject: [PATCH v7 4/4] Add SPAcc Kconfig and Makefile
Date: Tue,  7 Oct 2025 12:20:20 +0530
Message-Id: <20251007065020.495008-5-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251007065020.495008-1-pavitrakumarm@vayavyalabs.com>
References: <20251007065020.495008-1-pavitrakumarm@vayavyalabs.com>
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
Closes: https://lore.kernel.org/oe-kbuild-all/202510040852.qK4TiL4k-lkp@intel.com/
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
index 000000000000..e254a1bf9cbf
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/Kconfig
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_DEV_SPACC
+	tristate "Support for dwc_spacc Security Protocol Accelerator"
+	depends on HAS_DMA
+	select CRYPTO_ENGINE
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


