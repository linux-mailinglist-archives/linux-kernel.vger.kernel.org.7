Return-Path: <linux-kernel+bounces-760238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A95B1E85C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD811C2005F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D2527A127;
	Fri,  8 Aug 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="o4I47y88"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E562279787
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656088; cv=none; b=iArlGT919+zkCIMoGQ6c7V7KGMMskWKtcF/TvWxGFQsx3t7rGUCuGATZjzYadYVy0uQUFTxr5+J5gehf5pQR74IM0HLpIkv6+RyHg0DcjCpGu85P0fKp/yTeQ8QPWvMNWrXJy+26YV2LaZAXCXWBdmh3ei0yz5GtChhKkfjAP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656088; c=relaxed/simple;
	bh=hAFR1xBhX87nwBQzR1MC0ZMDIhtmlbpADrjiVttXDLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIFmEaHFjNGqixEWZvYT2WC1dfaAJt+xD6KMchhdIHwnhfF5JPzLpfrXDNTVZY26FHnm/zE3mzmlqkmCz5yTGblof4lDPDizouKfijbu+xGscYm1bdveatD4dl9lty6U07t+O371kD0IgxS48YDvan5EK25O68Pozf8HqWOwYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=o4I47y88; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2406fe901fcso21885455ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1754656086; x=1755260886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQwQrGub2aStw6hjlQ5y/xMW7z8UYCEI10h/q/mNXAg=;
        b=o4I47y88qrRN7i3AMYTOnGvrwBwoL+4+WE1x4hoxImK2D+jt7GJ7T0mV7qG7dxSIga
         lSDAnnmakywsYh4fnDpWcx/Jxyoz+sjZNtXRpIEY/A+8nuL0sfY0Cow1PhH1RchYKcr+
         IxLUqfzChslBoekrpHZipBds1/kc3wM11u+mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656086; x=1755260886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQwQrGub2aStw6hjlQ5y/xMW7z8UYCEI10h/q/mNXAg=;
        b=QIfBy0ta5TYqFt6jJEb1bFsnYrBp8JWgMplZwwdf3SlqooEdHh1iOav55v+DnAB4KW
         UY69pXFvjdmyfjDRLQ6HQ66FWthbCwvtmmBYaGim2qlfSTI1CMuiS5liIPLMT7LRh2qi
         jn7OoVPtJT16fUGAQl94WpaVy8FlT/Rk5k9TUXsrDsr8seijNPWSraHJqC8Mqygos7iE
         xzU4bay2lTwFMJop4EXKNBNBMAbeuvjnvCKQqdaSCBfDpDhXLCo0TPUSYn1Hr0nmC+gZ
         bDc2qy4uK6IgAop5aZxmX9nzv2vQB52FaMQmQrbe3Rj/ceGmHn2FbDkcCMu9QH/bB4eR
         0yzg==
X-Forwarded-Encrypted: i=1; AJvYcCUH04hrZIhbuWN5rO8FSANtEDK28PUTgJMQ7BWSJsCWyMwyqQS7//M3dK1YxjbQ0ETz22dGgOxnh9Qd778=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkPznOyurpI5ZhudbHA7c8nbWnOEHGDrilkwrzf29GDtE814L
	b/fzKxwUyCiH/ePOgVSqQ2ICQjOfUHUmhV8fatHoCpXLy6VfW4ijkJADNt1T8XWWw8E=
X-Gm-Gg: ASbGncuMRT7TKxE6XzMp1pONfOeDy/Po+/+BUFqyP2ESZr9HIXnsvdBQemMpOpp0sla
	aF/kJ/dB590vCRcLX0djfdQNLH4qLxtGNWyWQbfXmzeJVlrUarLxJYyJzOeVKkxLUEdSxokpQdg
	m+fEP+00/Rk/Z0omgue5Lc70ycN/L45qDWsxiTddNeVZAQiciaIWCysb3uYhwOtX/6MY8MY92i3
	RAImJmYTtg3tQuNIN7KoR63UZrPD+AmO+1zTkAmZtWqWOsC2wHSp6LjcfMwIX03vrqaaDHqG4S8
	zfMnaWF0QfHLTqhERy/VY2iaKK0En+6hF3364Qg2iwpWRkx0y3FN6Ay6TQkDEYG3kKXkVnzTjWR
	lYSY7jNRDxJFl4PDOwdH17Gtuy8qvbW/Oat4sTpvsh2KI4g==
X-Google-Smtp-Source: AGHT+IHCreUZY3AWxk/HAxu/lZhyalRoym3qObzmCb3bMSU2wLsZVkRUHvXdeL6eTVrsglYPN+g80A==
X-Received: by 2002:a17:903:120a:b0:240:41a4:96c0 with SMTP id d9443c01a7336-242c2208e85mr41906945ad.29.1754656085914;
        Fri, 08 Aug 2025 05:28:05 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a8cdsm208296665ad.121.2025.08.08.05.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:28:05 -0700 (PDT)
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
Subject: [PATCH v4 6/6] Add SPAcc Kconfig and Makefile
Date: Fri,  8 Aug 2025 17:56:31 +0530
Message-Id: <20250808122631.697421-7-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250808122631.697421-1-pavitrakumarm@vayavyalabs.com>
References: <20250808122631.697421-1-pavitrakumarm@vayavyalabs.com>
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
 drivers/crypto/Kconfig            |   1 +
 drivers/crypto/Makefile           |   1 +
 drivers/crypto/dwc-spacc/Kconfig  | 114 ++++++++++++++++++++++++++++++
 drivers/crypto/dwc-spacc/Makefile |  16 +++++
 4 files changed, 132 insertions(+)
 create mode 100644 drivers/crypto/dwc-spacc/Kconfig
 create mode 100644 drivers/crypto/dwc-spacc/Makefile

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 04b4c43b6bae..14688eda719d 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -768,6 +768,7 @@ config CRYPTO_DEV_BCM_SPU
 	  ahash, and aead algorithms with the kernel cryptographic API.
 
 source "drivers/crypto/stm32/Kconfig"
+source "drivers/crypto/dwc-spacc/Kconfig"
 
 config CRYPTO_DEV_SAFEXCEL
 	tristate "Inside Secure's SafeXcel cryptographic engine driver"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 22eadcc8f4a2..c933b309e359 100644
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
index 000000000000..4eb2eef56053
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/Kconfig
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_DEV_SPACC
+	tristate "Support for dw_spacc Security Protocol Accelerator"
+	depends on HAS_DMA
+	default n
+
+	help
+	  This enables support for SPAcc Hardware Accelerator.
+
+config CRYPTO_DEV_SPACC_CIPHER
+	bool "Enable CIPHER functionality"
+	depends on CRYPTO_DEV_SPACC
+	default y
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_DES
+	select CRYPTO_AES
+	select CRYPTO_CBC
+	select CRYPTO_ECB
+	select CRYPTO_CTR
+	select CRYPTO_XTS
+	select CRYPTO_CTS
+	select CRYPTO_OFB
+	select CRYPTO_CFB
+	select CRYPTO_SM4_GENERIC
+	select CRYPTO_CHACHA20
+
+	help
+	  Say y to enable Cipher functionality of SPAcc.
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
+config CRYPTO_DEV_SPACC_AEAD
+	bool "Enable AEAD functionality"
+	depends on CRYPTO_DEV_SPACC
+	default y
+	select CRYPTO_AEAD
+	select CRYPTO_AUTHENC
+	select CRYPTO_AES
+	select CRYPTO_SM4_GENERIC
+	select CRYPTO_CHACHAPOLY1305
+	select CRYPTO_GCM
+	select CRYPTO_CCM
+
+	help
+	  Say y to enable AEAD functionality of SPAcc.
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
index 000000000000..bf46c8e13a31
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_CRYPTO_DEV_SPACC) += snps-spacc.o
+snps-spacc-objs = spacc_hal.o spacc_core.o \
+spacc_manager.o spacc_interrupt.o spacc_device.o
+
+ifeq ($(CONFIG_CRYPTO_DEV_SPACC_HASH),y)
+snps-spacc-objs += spacc_ahash.o
+endif
+
+ifeq ($(CONFIG_CRYPTO_DEV_SPACC_CIPHER),y)
+snps-spacc-objs += spacc_skcipher.o
+endif
+
+ifeq ($(CONFIG_CRYPTO_DEV_SPACC_AEAD),y)
+snps-spacc-objs += spacc_aead.o
+endif
-- 
2.25.1


