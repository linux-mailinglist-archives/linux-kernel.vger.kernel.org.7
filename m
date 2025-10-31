Return-Path: <linux-kernel+bounces-880747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74DC266D7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9500B188AE87
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC803002BD;
	Fri, 31 Oct 2025 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVm4+fJH"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8F2D6E7E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932557; cv=none; b=AE2kgUaVOy/hcLrgW/GF3syVZWIhXMksFboglHh80WvZTu6B9O88n0EtTLUVq4armD9x/VwqmVXTI3+6RSQrxBUa8DW710txZay6NRPz9zA/IPChxXJ4SnNpEd9dqj+KO48slIcJFkWxWgeHGpxVZvr02+Y1l/F7zBeDwM1C9rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932557; c=relaxed/simple;
	bh=d1R4iL+4wvoOBAD0zobayWZrPssfeYHyl9iEv1Doqgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqvttPlf0Tljcifv5fb70SmX8jA7hPJuE1m6JnUIBWeGAVoxl0FP+auBa0jTu1D9U93a6cl8txoVFOyug2yY478cPBiG4LxmYLGXs/KqcW/wikeb3kidEV8Sf4AcpB/H2EvPEoWPEZH0OIG/8nkbt5MZhpc8uH+7RQTA6MUQXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVm4+fJH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-475c9881821so23159465e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932554; x=1762537354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/LvF/A8PwnfUK+jfwgeT95AEzwYHe3M659qwoSt/Tk=;
        b=GVm4+fJH4xGqJgS0JGLjbndRVra8Fy6W2+MDizEaXlsZHzEfiI1CiUlhlVhHBLra47
         l5nHMuaeC8KvDybVLr5Xtr+ld3yNx2UWu06XxVI1JvT198VXHTyuuNxaKPWjlB8dkQmg
         gY+ywyAKChkvO5ZmkZmVD1jd5nalHtqiG7ZpWu29WMr0wSeESadgcxUV08N/GAQQpQmY
         DZScKLqPvHjTBl2EJUiPLkH5kZo1xh1EtN4EsrjqbVeWQZePzKs4WCumnNm/ZLd+SbCJ
         881tqlxPk9DfwQka+j02oyPZ+n/WUVtmZ0Bsrgodwpx+AJBt+Xz6xmkQ6Cc23JkKVsgP
         WLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932554; x=1762537354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/LvF/A8PwnfUK+jfwgeT95AEzwYHe3M659qwoSt/Tk=;
        b=ZXHhLRWOTg+d5bh6nVssl6r8CT7bSpYH1mOOpXZVnPim78HsnV5jkDqF6m5mm1iTpu
         bFyekVLCY/7GLho0Co2F1ABOwXGdwn9bv1I6RgWZg40Z+pP/aMBDiIvPinNOKCw0RnXl
         GmzwO0zYQFKgoQt0VeZ5mHtOgNTgfZ6eWVmAdnWJRqo1xp3Ycd+fzLWX7LZGIDln8ZNH
         RTaBcyxtyjx5RUW4K1h33km/pfZz1b0NbYxvmYIwzCOcMqF736iui5LEfTyyQyTb84L4
         UT9jgk2S52suTKM2RB5h0+GaD2MBi8vTL/DqDALeeLrEWZq7ZAGAqdLIzFHTHdvGOY1j
         w4ag==
X-Forwarded-Encrypted: i=1; AJvYcCU40jJao/ezt4azJ0ArSbv0hM30cr28Aw1szRdEgvmfWCX9lIMHZcbSJ1fOy12VBzUrN6bJrhArXlVKBrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTBjnI/v0hX6+tcR3MSupNMEnrProvF40D2nvtR4vkOTBB6/N
	txTGso6PAOyXI1mAqAcEhynWdGX13PvtvGzQTQLmqgv65HBjTiwbJm4g
X-Gm-Gg: ASbGncuuWgJUglXo+aKqRw/bUs/rPiw1UjO/D0+IfEL/hC9mUF4cJhrksNsjYiWq7Fm
	G7cuGtCMEwLI53P0gnsap2h5wDxyqjGnZePWeiyi8Ck53fi4lbqZBb7TEyvqikruZd6TAWPjFdM
	KhPbukA/YpVIJrGojEZLRwGrCPHa1MdomppEnrz6G2cmb6SXn/Pzo5cxzL2a//NM4hpVLlUYU+R
	UxF1vWXQR3vEZl/l4DaLRhINEAFef3fFGqLQ9B/FYH2GR4q6cdQLWmhCI5fUhqYKyNrsg2NGWQS
	qC+L2F+d0N6I9xWLVYf4aargKud/7dw6DQXZNZsLvJZHbB/euXMnU6SfAcZb8F0sf6Wk9H7FDSE
	9vfedmO3XAdse7CDc0PtwGmaay6Zvf3H5kexRnVwsSqq9cryGZrSh92Q3Si51uT+AB5UUkNaeNR
	3G976HIOt8hbz2Z+grFEPR9nTDf1LfF2fXNJQZ+EH52CdMDe3iobpE8Oupsz4=
X-Google-Smtp-Source: AGHT+IEgGIpbEqFITIYD0jLuHMu6DCril9HILvlfeFDEOAO0cMDvZU9V83iSt7M2m7bKdOQ6MWIqbA==
X-Received: by 2002:a7b:ca54:0:b0:475:dc32:5600 with SMTP id 5b1f17b1804b1-477262e8fd6mr61275235e9.19.1761932553429;
        Fri, 31 Oct 2025 10:42:33 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53eafbsm6728865e9.12.2025.10.31.10.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:42:32 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using wrong USER_PTR_MAX in modules
Date: Fri, 31 Oct 2025 18:42:18 +0100
Message-ID: <20251031174220.43458-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031174220.43458-1-mjguzik@gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[real commit message will land here later]
---
 arch/x86/include/asm/uaccess_64.h | 17 +++++++++--------
 arch/x86/kernel/cpu/common.c      |  8 +++++---
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c8a5ae35c871..f60c0ed147c3 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -12,13 +12,14 @@
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
 #include <asm/percpu.h>
-#include <asm/runtime-const.h>
 
-/*
- * Virtual variable: there's no actual backing store for this,
- * it can purely be used as 'runtime_const_ptr(USER_PTR_MAX)'
- */
-extern unsigned long USER_PTR_MAX;
+extern unsigned long user_ptr_max;
+#ifdef MODULE
+#define __user_ptr_max_accessor	user_ptr_max
+#else
+#include <asm/runtime-const.h>
+#define __user_ptr_max_accessor	runtime_const_ptr(user_ptr_max)
+#endif
 
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -54,7 +55,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
 #endif
 
 #define valid_user_address(x) \
-	likely((__force unsigned long)(x) <= runtime_const_ptr(USER_PTR_MAX))
+	likely((__force unsigned long)(x) <= __user_ptr_max_accessor)
 
 /*
  * Masking the user address is an alternative to a conditional
@@ -67,7 +68,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
 	asm("cmp %1,%0\n\t"
 	    "cmova %1,%0"
 		:"=r" (ret)
-		:"r" (runtime_const_ptr(USER_PTR_MAX)),
+		:"r" (__user_ptr_max_accessor),
 		 "0" (ptr));
 	return ret;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3ff9682d8bc4..f338f5e9adfc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -78,6 +78,9 @@
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+unsigned long user_ptr_max __ro_after_init;
+EXPORT_SYMBOL(user_ptr_max);
+
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
@@ -2575,14 +2578,13 @@ void __init arch_cpu_finalize_init(void)
 	alternative_instructions();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
-		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
-
+		user_ptr_max = TASK_SIZE_MAX;
 		/*
 		 * Enable this when LAM is gated on LASS support
 		if (cpu_feature_enabled(X86_FEATURE_LAM))
 			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
 		 */
-		runtime_const_init(ptr, USER_PTR_MAX);
+		runtime_const_init(ptr, user_ptr_max);
 
 		/*
 		 * Make sure the first 2MB area is not mapped by huge pages
-- 
2.34.1


