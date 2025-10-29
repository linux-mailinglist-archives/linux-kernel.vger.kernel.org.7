Return-Path: <linux-kernel+bounces-875885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BFEC1A084
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91C244FC06C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CB334697;
	Wed, 29 Oct 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DwkRXW+K"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E5337699
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737273; cv=none; b=WL65kwplLZwOLMkaYsWb9JLgJ0ZsEk4uggKd4xhrARqpEwe/rpJcM0XhXCc9VG3FqLgKRz1/F2OH+54MJY8FZlbjqovKpHQAinMX6q2QsnRacYTGqqa8PlplupsVpF/gFISaiSXlZcil9DF5eBHc22yTkG690kC1SCBUJWUThSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737273; c=relaxed/simple;
	bh=iaxzzzfbF/Bf+RL8UjVT7dkfdCOWfh0hkHaopBJWsmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDv9LZNrLF8/EVaDNtcPpvKBQvriuRSsniWiWtzVSXYKIFlsflsDgWkmhT8ScJm+Kh2KfZTPhCwK7/Fb8D8Z00TcLcpBEyzBgSuC64CTvfNFC2HcI8LyNZlHd0N6Wr9gXaRndxyQUkLJxl2dNBdKi3M1cd5BC+oLaftjVb24es4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DwkRXW+K; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so6648319a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737264; x=1762342064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp1nIH/UcUWGrGQTMqAlrnMpZhTNysKVdYoaQCQ6E6E=;
        b=DwkRXW+KXXZnBdHfiMPjEO8csTLpAABqA7WK7jojK0uWNv9w2EotRFpNOcJGT6NJR4
         1n55ZLpRlQkwf9VqSfHVdypQkX9kbM44qyFLB+hpPipTFEdLq42bHeRE3rr5LYoyEnRB
         lwrFbIFAmjbk7U4/J4HxThEX2bfH52HE+lpgpgE0rqg8xt2d6iK4lmPFANZfIdvgFvNx
         /HJJ7etolbG+86sJaBcuoHnoP/HSY/bWFcwJyOEOLTEWweBWJX+53CnxNtp8Kz4xBksf
         B8qOh8k2FrPIzrTWK2/qVMqQsKgaHTcGufZS7eQf7vn8LWi2a55Q44VeHfR1bsW+VDGW
         OK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737264; x=1762342064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kp1nIH/UcUWGrGQTMqAlrnMpZhTNysKVdYoaQCQ6E6E=;
        b=HJWTP0niijNySlojgg0Lo1wDuTpuNUqIw1fA1zmyetEoLD9ziXXqW7Ttgzth1x06GN
         /h4UfasZnkymsPSQGpoeKweM5ztYNGCVvAH8vHRQLC5XoxKWX/qatg4Esu81rOyfRmDu
         GzIbdW2shARxWO8LRjk3VfErlrX+Wkgi30umY7Xpkio52Hu85aAP1196lU7WTVR8qMjt
         gWMyXz5tUkTtRdfIWZco+zH5tYHsRZBkk1PH82cBhyh0OHQ/LqdwXcbrs66yuClxowcv
         dQ+/OvWXV9FqXxKbAJO5+9w2pkcwhZgaUvsT4qUDdt5mlGvqMAA/u+M4aBveJJdVbs4q
         5/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCU+u2/DJeE968gbyj60Ub8svhiuMVzkhzp4Hhguoi3HxMIa0c5ZHBGgq8F79i8YTXpc1Kwoici8bM4SM7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzchpt9tRp6XuOIVyYqRzLqeLSA7AmoQaU89geLNJa8LghzHdj9
	ioDI6VVG5s4/E7FESQzoTe6Gh0olZDPu2ZkJK9uy+byua1Cx/0eNXhz51ByeUqtoRgc=
X-Gm-Gg: ASbGncvUZdlPHIIvtkf1m2ON0N3KffdhB+xnFi6Q8qPEzmJwDGZ8K4jlqEqI3TcimHB
	B8hlR6g/vmXK3YKI7s7qErIvXo9RoIaiitIrWczTGGCQr+KxFPuCHk5QsD7AxhtXrke+ZLuYAxG
	tFNBOQ7j9Pro5g1YardO5Va4cZvy3qaD5JYwX9MW+E4y+1zFP57TEFr6oVGjcD6nzYjV3owN/01
	thkbVT2z9NdTettY2HUOFmuMlBweScBnb8cQL16BIMM63rzVfLwfjAjrQdGGqufMwaaXG556jc/
	pfMD5JVD1y3uEkQnsUjNrIWBAzQhh2NP18vO1E0MPXEo+AlzBRE4fx+7NLEmdP0Do/GiMDTq711
	qtdU4p8SyhjqqgimyN2ExYKlTj5wO9AuJXndGt/EYXOTrYn7yl1hSuGrGS90GYsg9GKtKBlRhpz
	+6jcYWBWl1saVRMx0QWAior7vNM5Sd
X-Google-Smtp-Source: AGHT+IFARlQT4wxU5rIAA9JBJXOgqU4ng9/zvGb3HdF6wqemjXQ0P2gKhLivhx1oGEPscd3xyn6Eow==
X-Received: by 2002:a17:90b:5188:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-3403a2fece5mr2816754a91.33.1761737264495;
        Wed, 29 Oct 2025 04:27:44 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:44 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 08/10] riscv: Introduce HEST SSE notification handlers
Date: Wed, 29 Oct 2025 16:56:46 +0530
Message-ID: <20251029112649.3811657-9-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add config option to enable SSE in APEI. When it is enabled, functions
to register/unregister a ghes entry with SSE are avilable along with
low and high priority event handers. If a SSE notification type is
determined, a ghes common handler to handle an error event is registered.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/Kconfig |   5 ++
 drivers/acpi/apei/ghes.c  | 101 +++++++++++++++++++++++++++++++++-----
 2 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..ada95a50805f 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -46,6 +46,11 @@ config ACPI_APEI_SEA
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
 
+config ACPI_APEI_SSE
+	bool
+	depends on RISCV && RISCV_SBI_SSE && ACPI_APEI_GHES
+	default y
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f2cbd7414faf..3c47249245d1 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -17,6 +17,8 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/err.h>
+#include <linux/riscv_sbi_sse.h>
 #include <linux/arm_sdei.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -97,6 +99,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+#ifndef CONFIG_RISCV_SBI_SSE
+#define FIX_APEI_GHES_SSE_LOW_PRIORITY	__end_of_fixed_addresses
+#define FIX_APEI_GHES_SSE_HIGH_PRIORITY	__end_of_fixed_addresses
+#endif
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1530,6 +1537,63 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
 	return sdei_unregister_ghes(ghes);
 }
 
+#if defined(CONFIG_ACPI_APEI_SSE)
+/* SSE Handlers */
+static int __ghes_sse_callback(struct ghes *ghes,
+			       enum fixed_addresses fixmap_idx)
+{
+	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
+		irq_work_queue(&ghes_proc_irq_work);
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+/* Low priority */
+static int ghes_sse_lo_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_lo);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_lo);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_LOW_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_lo);
+
+	return err;
+}
+
+/* High priority */
+static int ghes_sse_hi_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_hi);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_hi);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_HIGH_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_hi);
+
+	return err;
+}
+
+static int apei_sse_register_ghes(struct ghes *ghes)
+{
+	return sse_register_ghes(ghes, ghes_sse_lo_callback,
+				 ghes_sse_hi_callback);
+}
+
+static int apei_sse_unregister_ghes(struct ghes *ghes)
+{
+	return sse_unregister_ghes(ghes);
+}
+#else /* CONFIG_ACPI_APEI_SSE */
+static int apei_sse_register_ghes(struct ghes *ghes) { return -ENOTSUPP; }
+static int apei_sse_unregister_ghes(struct ghes *ghes) { return -ENOTSUPP; }
+#endif
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
@@ -1576,6 +1640,15 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		pr_warn(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
 			generic->header.source_id);
 		goto err;
+	case ACPI_HEST_NOTIFY_SSE:
+		if (!IS_ENABLED(CONFIG_ACPI_APEI_SSE)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d "
+				"notified via SSE is not supported\n",
+				generic->header.source_id);
+			rc = -ENOTSUPP;
+			goto err;
+		}
+		break;
 	default:
 		pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
 			generic->notify.type, generic->header.source_id);
@@ -1639,6 +1712,18 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		if (rc)
 			goto err;
 		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		rc = apei_sse_register_ghes(ghes);
+		if (rc) {
+			pr_err(GHES_PFX "Failed to register for SSE notification"
+			       " on vector %d\n",
+			       generic->notify.vector);
+			goto err;
+		}
+		pr_err(GHES_PFX "Registered SSE notification on vector %d\n",
+		       generic->notify.vector);
+		break;
 	default:
 		BUG();
 	}
@@ -1668,7 +1753,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static void ghes_remove(struct platform_device *ghes_dev)
 {
-	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1702,16 +1786,11 @@ static void ghes_remove(struct platform_device *ghes_dev)
 		ghes_nmi_remove(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
-		rc = apei_sdei_unregister_ghes(ghes);
-		if (rc) {
-			/*
-			 * Returning early results in a resource leak, but we're
-			 * only here if stopping the hardware failed.
-			 */
-			dev_err(&ghes_dev->dev, "Failed to unregister ghes (%pe)\n",
-				ERR_PTR(rc));
-			return;
-		}
+		apei_sdei_unregister_ghes(ghes);
+		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		apei_sse_unregister_ghes(ghes);
 		break;
 	default:
 		BUG();
-- 
2.43.0


