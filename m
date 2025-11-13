Return-Path: <linux-kernel+bounces-899191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37646C570EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32247354902
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F92332EDE;
	Thu, 13 Nov 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="espvAuQi"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9C3385AA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031205; cv=none; b=OWad+atYFrSwl6nnjP+cB5ydO3/eP6rIYWNw02cYl+z8u/PMFwtpxN1tfGMhqI+Q26bbwmNOQWsIjdUbufCA8/0+ZeGhGLjD4LhVwYtcQY/GJEgAA5kUzGcugNUsGlUJP1OZrPxxWvLy2zS5g2R2186D+NrdVAz14D3kLLTCAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031205; c=relaxed/simple;
	bh=1E2mId5k7LQtvQtsMUhfWzpkQGYCGnS/GTmR184+ESA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNZjq1IdPh08IuK4VrIo/l2Z9CSJd7Zh02LT28J9Lv+7+PzEi9WRA2aAr5MQLRpRU4crOA2mtLLLoCs1ZAV3+Ex0//ArntmBTAucsJ/TFKOIB06819tLspIgZdobXZSQiK4aPPXpEWCSBIxsPo2S4HFIzDohPEr4S20jT0P1anA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=espvAuQi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343806688c5so584254a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031201; x=1763636001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXzDe/lb8LBcXrcioYpdWFUmDINGA7jRuKL/XW2h0KY=;
        b=espvAuQikWN6NSnmwCOum6JjqIfIBu5G9N+yhIlFVJVRUJbJedPBR66aNff5UgCCaM
         D9l/v464MIErTzsjWaPivsY1lLLEew29Tiipuh65h54Ztlz93nLpLmT0lRrQChGj1TTx
         se5ARy7ojP0jc6p8GLMZ+V5G+1xB3xtlS+5wo9K+uc4zhqBRgwcoWzLyL1F/pCVCf7q0
         3yNtFJDGPPqH0HM6bK31553jyf7WNPNBEaT9Xmd8BKywsL8Mx3zcAuLnXmE5eGBibhwU
         QyeKyHG9bvtyVGcha2eCS/ujzXDA0zzL0CrfBwp1qiUHyeF9dK/Nq8VXFQ+Z/8PVhPZN
         sQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031201; x=1763636001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iXzDe/lb8LBcXrcioYpdWFUmDINGA7jRuKL/XW2h0KY=;
        b=tCfUAnaxKbZGFGQUxSBWRLrkXcwq+cBU+973qKcR/LbvW/4j4lMvYfx9SUesXtOWTu
         UNswhXYfHZ+myj0No6MOtdZT5LZNpT6FGPPAXLH/0mRrJPTHKWctQwtJjk4jM6jIV+5j
         HdKlaiDurN/dFs/+i9wuUatfLL7AfGGjL8GXp3aZLSVja1+rl1nqpocNv0phYs623H9G
         pyLpUcfk47zdv/TqnCu7c1cFN3mlrS3IgkapsZAuRGkwAbSJD+lBMjFoFNfmvQxIp3oJ
         GuIRlL4wOm3gMtAzqQzGDhOxr/KgDGkrg7Gw09bCyak3ZapZmhTxjqACqhaNV8kXOQz8
         GW2A==
X-Forwarded-Encrypted: i=1; AJvYcCXBQqvaBlAUoZln1IzMT5HA6KrzTTsDx8cqhGYHB/gPwq7VMJXLjMZ+K2KxkS2gNILOiD0Nqnx/t898ts8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUssxi51xltjg/nHvcqakmYg2KyeRHGrPp7/edEGcS8QcXyE6
	3/vVqbzwiWi2UndKmjARDeLCl639rFxbCM8kbDKNWdVgvuS5SM8U1WDe
X-Gm-Gg: ASbGncu44LuFCCUcTyzIvVRObsfSeI6MXB7NhfSvsE8mqPTglMkv/o5EB2l6Y5aI4D+
	SVOQPPEUg8cpnsxZbOIooumqM1UlTis9kiW9b3RrEQ3Sb9aeKHHaAn8VrRITGkoSEHqAK8SjYsA
	yzpziE1q3rizefJ1ppYEUc8aInLDv7o1a5FM474WuCpWnNWnpT752PKw0YQ7i7CzSN9NDGlmJmT
	dGj8bHiJwycHzmpmABidrImTW8Z/+C8uKXEByMd82Fq7OPC5R6cvEiNiMSLqgf9w6FJqPKkXRht
	wtEEXCoIzwpsUYBD3Gq7TQAOW5/sND/0dwE7fp5cZKLJgGdLtOyEKAzlKRaQzZkYyP7ARKNb0zE
	bo4WpSvkM+FyXKHo8/CGv69pPrsfvldgo9G3/3iVScQ1BTRtmhfNCfV00FXV6Icz15j/AOwzr9X
	+AwxK5RIbKTYTTHzi+FIbBtPe5x84Ww92w9Xk=
X-Google-Smtp-Source: AGHT+IGjc7/BLrmluqoR0wCBX6JW+io2uPlNPbBrwMmM01hCccHJSoZKJTWfi0yRonMDUz3bgaA4Iw==
X-Received: by 2002:a17:90b:4a4d:b0:33e:30e8:81cb with SMTP id 98e67ed59e1d1-343dde14c3bmr7915421a91.13.1763031201314;
        Thu, 13 Nov 2025 02:53:21 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4c939dsm2139616a91.6.2025.11.13.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:53:20 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	riel@surriel.com,
	segher@kernel.crashing.org,
	david@redhat.com,
	peterz@infradead.org,
	hpa@zytor.com,
	osalvador@suse.de,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	arnd@arndb.de,
	sforshee@kernel.org,
	mhiramat@kernel.org,
	andrii@kernel.org,
	oleg@redhat.com,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/3] Make enter_lazy_tlb inline on x86
Date: Thu, 13 Nov 2025 18:52:25 +0800
Message-ID: <20251113105227.57650-2-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113105227.57650-1-qq570070308@gmail.com>
References: <20251113105227.57650-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is very short, and is called in the context switching,
which is the hot code path.

Change it to inline function on x86 to optimize performance, just like
its code on other architectures.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511091959.kfmo9kPB-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511092219.73aMMES4-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511100042.ZklpqjOY-lkp@intel.com/
---
 arch/x86/include/asm/mmu_context.h | 23 ++++++++++++++++++++++-
 arch/x86/mm/tlb.c                  | 21 ---------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 73bf3b1b44e8..ecd134dcfb34 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -136,8 +136,29 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 }
 #endif
 
+/*
+ * Please ignore the name of this function.  It should be called
+ * switch_to_kernel_thread().
+ *
+ * enter_lazy_tlb() is a hint from the scheduler that we are entering a
+ * kernel thread or other context without an mm.  Acceptable implementations
+ * include doing nothing whatsoever, switching to init_mm, or various clever
+ * lazy tricks to try to minimize TLB flushes.
+ *
+ * The scheduler reserves the right to call enter_lazy_tlb() several times
+ * in a row.  It will notify us that we're going back to a real mm by
+ * calling switch_mm_irqs_off().
+ */
 #define enter_lazy_tlb enter_lazy_tlb
-extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
+#ifndef MODULE
+static __always_inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
+		return;
+
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
+}
+#endif
 
 #define mm_init_global_asid mm_init_global_asid
 extern void mm_init_global_asid(struct mm_struct *mm);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5d221709353e..cb715e8e75e4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -970,27 +970,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	}
 }
 
-/*
- * Please ignore the name of this function.  It should be called
- * switch_to_kernel_thread().
- *
- * enter_lazy_tlb() is a hint from the scheduler that we are entering a
- * kernel thread or other context without an mm.  Acceptable implementations
- * include doing nothing whatsoever, switching to init_mm, or various clever
- * lazy tricks to try to minimize TLB flushes.
- *
- * The scheduler reserves the right to call enter_lazy_tlb() several times
- * in a row.  It will notify us that we're going back to a real mm by
- * calling switch_mm_irqs_off().
- */
-void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
-		return;
-
-	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
-}
-
 /*
  * Using a temporary mm allows to set temporary mappings that are not accessible
  * by other CPUs. Such mappings are needed to perform sensitive memory writes
-- 
2.51.0


