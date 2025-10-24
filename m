Return-Path: <linux-kernel+bounces-869386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6E2C07BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21B919A5242
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22BF347BDC;
	Fri, 24 Oct 2025 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXLNgz6b"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBA1DF75C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330469; cv=none; b=YzA2yI4Ef22Ph47IXIM4IRrRmf19pMK8F3jy9MAAyF0GM8wlkMGqWtEeHqJMqOYA5CCwODU5eGq6f+VPPAfq6fWgr3PZ0TNEMqdbLNlmZHNDEOZzeZXFY4QBg6vmv3GDHccZJY/Iix2Mv5oXa4siXyysrXXlJ8Gu1zrsd9TjfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330469; c=relaxed/simple;
	bh=HZHaVbE4xXiwGjWyg/8FHHHnvbeBk6qoQZBTrjIv3/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr3KhNB5VXShkYqTaI8fO50+zVhPEf11Pn4eWNqEr26fmMb4I0Cm9dypbN+K5clrQZ+Po5qry5sBpQCPmztgYQRvV+dI6yQljztMzrjgO9W/j5efbXMrpZ5TnIp2QCvlx7kgwqfGvclJpOKZg/+otDfwDHvQxXZDqnMIYlLTbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXLNgz6b; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso2697203b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761330465; x=1761935265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+FNd1iv84yj9fXEgDPRihJMKjMARO1OEmBeQEKgFEI=;
        b=NXLNgz6bRT+BWm6qUmGDmIYLs2DsF3BcoGkkvE3dx8pOLonK0HYNvxJ+HNa/hOr6Fa
         zOkhAXvTsFUkzPlq6L1gDwaZAh8QFqLayVHDSpy4l+hnWc2opYZpTeLrCLHL78vHKHSC
         6FeGt+cI4eUUjXMNYgFR2YzwjyXbBf2qGdDXJONPmNJWHY1FKsk8HGoGje7ymFxjiINK
         q/53dBl5HcqSxStc/HqjAywzGF0De485HElD/UpJxsBKKyJ74ulztBy0wL8hoTEajZHB
         jBRAIBlDrhbU4shsB/6Z6wrp0Qsl0T5i5aiZBDPlWe8xJng+nTULCY4fsX8eaaUzkcKh
         aEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330465; x=1761935265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+FNd1iv84yj9fXEgDPRihJMKjMARO1OEmBeQEKgFEI=;
        b=HwXOviSFEvYX8OMIohj4HO849+DykAP0UVI/oDRdkO15FHjQwYxiw4hONI/0zNx+A5
         WPJ9ZKd2w1LgJz4Uo1R7jwA05c/ZoYLTOwhCPAFkxTZSp/DAg3IWN1jtYufsUtnTOiNa
         m8gwsuNIZQIqhO3IDN0ezjsFNMAsj0sSBmJaUJUZGBZaFY2mNUBYb0IK1vyexqYNA15q
         vTGcACx66MvgMyN+ySx59TGGTt6NbO00E0HgGP5VeE+RXRAmwmZ3zYG4SygKXInvqGap
         F26EEAlwOXbbhfBdGPBvq6YIzq/o3tSde+l6o2CSG6qweipDID439lzJsxbn5+8hO8kc
         fSpw==
X-Forwarded-Encrypted: i=1; AJvYcCVmsyO5kGgGcDr8vnFtMEYPjupbSkJ0p7zZzWUUUsdEKLY0sEaFCkGjiwKBjDxf922guOVnfARgAuzq4Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytZu5ttn7hZ0MDdGmXjONefwNGV1z8PWNHGKPBAVKddaig7mmo
	EzJUrQyasOfLHH8KIvpsoQToo79CJZw99MSbGfGUItXrZQrv0xAiwANu
X-Gm-Gg: ASbGncu79O2Dp4GQZxYIMHE4nM9AhDq7kNeNLMKIMw0KU+u+aTKFihgqOQm30HOL4/v
	Pwh3mueMxi7q26yPd+VdRswxtljz1Ha2sui6O2Njsl4q9vfaRm4smvE69QfLijVMTsjpBssikdn
	tkzEDQhyQPqeyc5N39Zr4+8BsO19+YYkQJJgWXuAN4T0PmKXm0Qh/mnV2jqhuZViTwCKk1b/4RZ
	Eh3KF/85d9FbO1fHWWLiNzoVtNYuRRj5PBhHUfqbRsOWGMEs7YnxhW7fHNBa6E2s3ytlG8Di3Un
	MEqRPHXhANl1Ym96RQTGsSFs6m0TfdN0JEsOBRUukAPNraekTqxM4mz4kT8vrozmTyEJZESTNj8
	G/7xGbz9bUFRxJIp3Roc5t8PY9pnbSELHN9WS0HP/wUtQGuKH/Z3q7o5Av1JAn2Gb6izWqMze8S
	WnNAbiPiOFtztvn7ia9q7EyFJYyITtP6M=
X-Google-Smtp-Source: AGHT+IHxEMLf7S4GtVSLpARiG/DBE2cBNDG4VltRWQgt5C51d+t0JTe3Qon0GX6lpPUzY6KiH2TeSQ==
X-Received: by 2002:a05:6a21:2d89:b0:339:352b:1aea with SMTP id adf61e73a8af0-33c5fbaaaf2mr10877285637.3.1761330465233;
        Fri, 24 Oct 2025 11:27:45 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274ac3158sm6616572b3a.32.2025.10.24.11.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:27:44 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: linux@armlinux.org.uk,
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
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	riel@surriel.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	segher@kernel.crashing.org,
	ryan.roberts@arm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	nysal@linux.ibm.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 1/3] Change enter_lazy_tlb to inline on x86
Date: Sat, 25 Oct 2025 02:26:26 +0800
Message-ID: <20251024182628.68921-2-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024182628.68921-1-qq570070308@gmail.com>
References: <20251024182628.68921-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is very short, and is called in the context switching,
so it is called very frequently.

Change it to inline function on x86 to improve performance, just like
its code in other architectures

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
---
 arch/x86/include/asm/mmu_context.h | 22 +++++++++++++++++++++-
 arch/x86/mm/tlb.c                  | 21 ---------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 73bf3b1b44e8..30e68c5ef798 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -129,22 +129,42 @@ static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 }
 
 static inline void mm_reset_untag_mask(struct mm_struct *mm)
 {
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
+static __always_inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
+		return;
+
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
+}
+
 
 #define mm_init_global_asid mm_init_global_asid
 extern void mm_init_global_asid(struct mm_struct *mm);
 
 extern void mm_free_global_asid(struct mm_struct *mm);
 
 /*
  * Init a new mm.  Used on mm copies, like at fork()
  * and on mm's that are brand-new, like at execve().
  */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5d221709353e..cb715e8e75e4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -963,41 +963,20 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, ns.asid);
 	cpu_tlbstate_update_lam(new_lam, mm_untag_mask(next));
 
 	if (next != prev) {
 		cr4_update_pce_mm(next);
 		switch_ldt(prev, next);
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
  * that override the kernel memory protections (e.g., W^X), without exposing the
  * temporary page-table mappings that are required for these write operations to
  * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
  * mapping is torn down.  Temporary mms can also be used for EFI runtime service
  * calls or similar functionality.
  *
  * It is illegal to schedule while using a temporary mm -- the context switch
-- 
2.51.0


