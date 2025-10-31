Return-Path: <linux-kernel+bounces-879507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DFAC23456
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745E01A62A09
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047242D191C;
	Fri, 31 Oct 2025 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="hk6cyJM4"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF82C15AC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761886127; cv=none; b=dfgRuiiyzVHaIBRTZG+bETd32+BQ4eOjeYITQEsH6KBSKnLSYopL31nHbJdMZkyjbwLFOg1KylYe3iK9dXsKX7qwmybMHugbrJsEpSjIWTm6X3rd4dzgdMZlOdCuqUaoiruO5ZDTZqgc+wOTlw+XRLUJUlwz0SFHYUEvkkKn0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761886127; c=relaxed/simple;
	bh=fnfgAHpm/oOK5jjhw0HXag3cq3lb1Krfoz2NFFT7Hac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W5TFsdWzgEEwdDvaSHQrOL0fT6nxcFNg72ZAX+n23Q79+n6+5Lv7luEXE/AVC3tX/WjJNJKCh8rMEbRZDgytkJjZHMjlrp9LqDKfRLyPVCEMytNtG5j/dyE2LV8gL9cqXAtNG+6o5dqBioHLcWYkF9e9hE5XhXHPQj7wObbbUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=hk6cyJM4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290ab379d48so18144555ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1761886125; x=1762490925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wxq8aZYN3BEmAZfNqUF8Scnyl6sv0hnpCWP+cCenBpc=;
        b=hk6cyJM4hA/HZArBAToiJ4Fviid/XNj0oIDrWua3b1nO52yCXip4I9XoODnJ/Iysg5
         OHG0iQCkxXu1yrYQU87GOhoKS05YU3NzWiEQQHKwVI9JE37rpx/SyHsX5Jx98uER2SZJ
         KW4lAZAMb7p+Q7+4gwBWYiG2Pa99c4ee/29S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761886125; x=1762490925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wxq8aZYN3BEmAZfNqUF8Scnyl6sv0hnpCWP+cCenBpc=;
        b=lLuFXm3G+cqHUR0BG+gknIwK0D2WdcP17B8yOxi8CUMLPfKFW4AY1Gp6ODHm7Z62A5
         EvUbLq1zmRa387zu7ofJafQisbuS1gMPamXvBoFT+2D/R5M2TUy/CJz+0x4tVp5jJdRA
         PmiCvbVGpbUNwlyPwPS+vdX56YN6eoNvcmFPNQPVvB+kGfYMMAKwsV96TcSP33SnVtWT
         rXdGk5puRSpvUBjHVTqN/iN0H1MgrnkmU9WXzcdn7OAFRR2ohNKXMiJOQr71v7gCWssN
         F8egG4GeGruBsH1QWrlmvZVjWeslEfJxb7ytYm3AbCANOJ9cDCouhcaWleM5XUNb3vpI
         /+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUbPfTSvSScJPZq+WB9Q9BIaNr9YlHlRrdMruJO689L+CfwgFaDIK6bIHMbePKRyh6HDdWAhkLha39Nlmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQg2n17rxMVON/Mvj5jn3vMYf5GreH42LCMInSntYROmbFJiCR
	SgNaENJmjrpQQLiF4rRDEGVcdiMcyjSyi0HPvg400QciJyx7b8eVAvjnKbWLDvtgdQjcsGCrL5U
	J35H3
X-Gm-Gg: ASbGncsTppq5naCMPaYlX4I1XpxSzoMAanc3GpZAWTrTk8KMTp89/nRvqNznlmEq7S2
	B5Xi1vQUukWj23GwFPKWdEo57fTcuXfUtEunQDyLp2WAKyKCl/jtyU7tF1fA8Z/hI53M8/KbzDP
	yd+5FR+AzdDXv5aRLPz2RKnRBLK938/qZjCvdOpfe7fur8lwDGid7Jqn175VVIcCrE88Q70K5vC
	/3pIM+S0auf9xb8aJT1TUug7v7ADkipQAaRce11+UHpktYo5enJUIAN1pqeu+d+woHuPcOkFo1b
	3NlSAx5cGRgzvY3E6B0a/UOfZ7yagp7Lcfu1oCFhxAYCUepES4rj66FfHp+nI6fPOkoLn1vIWXr
	3syzSAAIKiydEkHMha14hSPbte3XgLSfgzB0Ou08dl2ifVQuYiQBptobgPwc3D1Oc43VpWBOUvj
	2gcB7ywsdlzJC/spDvEfDHh0cjp7CGhX4JB+Vizm/Zj83m/1VqifCtAgA=
X-Google-Smtp-Source: AGHT+IF5HX/zwMINsUWyvYSK1AffYKFH7nYt9+81LbvhC56oHrPOR6rPmURMsi6raSMj2RpOBtlqKQ==
X-Received: by 2002:a17:902:eccc:b0:295:2276:66f8 with SMTP id d9443c01a7336-29522766ea7mr22629205ad.54.1761886124983;
        Thu, 30 Oct 2025 21:48:44 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm7238875ad.105.2025.10.30.21.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 21:48:44 -0700 (PDT)
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
	Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Subject: [PATCH v8 4/4] crypto: spacc - Add SPAcc Kconfig and Makefile
Date: Fri, 31 Oct 2025 10:18:03 +0530
Message-Id: <20251031044803.400524-5-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251031044803.400524-1-pavitrakumarm@vayavyalabs.com>
References: <20251031044803.400524-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Makefile and Kconfig for SPAcc driver.

Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
---
 drivers/crypto/Kconfig            |  1 +
 drivers/crypto/Makefile           |  1 +
 drivers/crypto/dwc-spacc/Kconfig  | 88 +++++++++++++++++++++++++++++++
 drivers/crypto/dwc-spacc/Makefile |  8 +++
 4 files changed, 98 insertions(+)
 create mode 100644 drivers/crypto/dwc-spacc/Kconfig
 create mode 100644 drivers/crypto/dwc-spacc/Makefile

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 8d3b5d2890f8..b644f80ed40d 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -781,6 +781,7 @@ config CRYPTO_DEV_BCM_SPU
 	  ahash, and aead algorithms with the kernel cryptographic API.
 
 source "drivers/crypto/stm32/Kconfig"
+source "drivers/crypto/dwc-spacc/Kconfig"
 
 config CRYPTO_DEV_SAFEXCEL
 	tristate "Inside Secure's SafeXcel cryptographic engine driver"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 322ae8854e3e..89f54b3faeb5 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
 obj-y += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-y += xilinx/
+obj-y += dwc-spacc/
 obj-y += hisilicon/
 obj-y += loongson/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
diff --git a/drivers/crypto/dwc-spacc/Kconfig b/drivers/crypto/dwc-spacc/Kconfig
new file mode 100644
index 000000000000..f9752e6f664b
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/Kconfig
@@ -0,0 +1,88 @@
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
+
+config CRYPTO_DEV_SPACC_CONFIG_DEBUG
+	bool "Enable SPAcc debug logs"
+	default n
+	depends on CRYPTO_DEV_SPACC
+	help
+          Say y to enable additional debug prints and diagnostics in the
+	  SPAcc driver. Disable this for production builds.
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


