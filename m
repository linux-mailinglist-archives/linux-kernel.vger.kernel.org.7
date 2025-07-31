Return-Path: <linux-kernel+bounces-752033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD1B170A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6F81AA831D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4472C324E;
	Thu, 31 Jul 2025 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvsyRSJ6"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A192C3242
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962717; cv=none; b=KwIJKPdK0qezG7vVhcPufHI25VX8cFKDpxew2EXZ03p7gQkFrKdvXoR7tKTaZLgsg95zR2pO3OkVCsiAgeDbpk860v9DoC76m0WYl5yrK9r6YJ49cjPWk1iMeL2t+lBdDirGAq16QMUAI2S4r2voP4RrV5dIKdGZSshMcnWMHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962717; c=relaxed/simple;
	bh=jag1r1U9xtFWGzbHHaOAoGJUilJf+3MCA7L1ZTkpTb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nI7PKGP6/nR2PK6DZ+japFvKAQ6HIPWSwz2gwiNlqVlUX3F0XMWC1TisgcUXIeYl1CcRXE6pBw4U0V21MuOldXLm+7weG+NJaRHcHWwv4/aTL20KJzp+q/iQAWjn6XAA/EIAfIGWHHy3GejEXmKI3NOmubdQuGsoK12NeOPGqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HvsyRSJ6; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b780da0ab6so435191f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753962714; x=1754567514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx/82C9/LmdN6I5VG5zleKCD5AaUcYE9gaKc5zZKlEM=;
        b=HvsyRSJ613s8bUdj2QgOqxlxGSOnOP66NnH1oXSapnhKjCGPJRu/We+UNiTw1+9G2h
         G4fgI5g/ubMjQfZDE7JNRON66DzZ5R0Obqq3MoKcwqab6XbdbmRleRLQw8VkT+YkPBqx
         ApGTTQh46rf/OdEsLr4lF4r6Uz3gSYoMglzte/5XxEM1OGjIm23Ml0VtV0sS0/SM847e
         WPUwHhRaBpjV/LGSwRuavIynS1zdIKpNKnEioj5WkWOXkj5hovdKq0Ouk5t8ixomQd2P
         9SsAxt+/FeUJjMIancGliXzfxjhH2xmgzYPbWlnQaICTdoS0dHfe9W2uZ8ozgi97GzLX
         cexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962714; x=1754567514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx/82C9/LmdN6I5VG5zleKCD5AaUcYE9gaKc5zZKlEM=;
        b=wZX00F/6/7DtfzsEk6z51HbqmEQk5WH23gLy75RK/bm2AETrxlWHmI6SjQME/Qvcgj
         Wheu7EeZzwmQvckGQ38sy6GN87cg2E2xanKmqdGNKqssifqgWdFGM0RqVNTWX/j8IV7P
         HtTbyM0xStf7eB7ONKb7YPtANb+qXR0jN1ndkou+Qq9R6Hxxaw/jzkQEeMTW2T+dSrWR
         ZubTN7Ke3B0p5sRCM3uzsGZ98R2wfxPG0Zkb4BKexRZruG4ZKfw58CnOTPn0TG+KLCiW
         DDbbicEXI+kX2ro2DWC7EQan4F+DR7TtJD0iTs14+SUCdjdYl9VB8aHrK8+gJ1fXQ5o5
         fYRw==
X-Forwarded-Encrypted: i=1; AJvYcCW2XSoyl8wVVeroxVVSMsF4RmOIwo8JxVGF3ZD3BBJ0YwDHKg1QoASCwvvKYV/oYXIu7CPPrh2nsSDe0m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhCBEOOlCt/aAemU6wgzeYXP3e/pp5R0tXtnyRUYzhLDrtUnG
	loC9wanG+m/qM5KXV9vw7F05XYXFul5MpoS9+JHwinuPK9nEKh7K/JKvEWX4mJXaGH/3aEiXRSb
	V9vWoew==
X-Google-Smtp-Source: AGHT+IGToFaqhJLe0IGbNpc4OT696IWRhQioLybjZJauCKgYvo/uamB7Vtqa+4ymvZ9o8FsYzUyGdVvEMkA=
X-Received: from wrta8.prod.google.com ([2002:a5d:5088:0:b0:3b7:89f0:5c26])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:401f:b0:3b7:8832:fde6
 with SMTP id ffacd0b85a97d-3b794fb6807mr4958295f8f.13.1753962714695; Thu, 31
 Jul 2025 04:51:54 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:51:33 +0200
In-Reply-To: <20250731115139.3035888-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731115139.3035888-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731115139.3035888-5-glider@google.com>
Subject: [PATCH v4 04/10] mm/kasan: define __asan_before_dynamic_init, __asan_after_dynamic_init
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Calls to __asan_before_dynamic_init() and __asan_after_dynamic_init()
are inserted by Clang when building with coverage guards.
These functions can be used to detect initialization order fiasco bugs
in the userspace, but it is fine for them to be no-ops in the kernel.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

---
v4:
 - Fix a compilation error reported by the kernel test robot <lkp@intel.com>

v3:
 - add Reviewed-by: Dmitry Vyukov

v2:
 - Address comments by Dmitry Vyukov:
   - rename CONFIG_KCOV_ENABLE_GUARDS to CONFIG_KCOV_UNIQUE
 - Move this patch before the one introducing CONFIG_KCOV_UNIQUE,
   per Marco Elver's request.

Change-Id: I7f8eb690a3d96f7d122205e8f1cba8039f6a68eb

fixup asan_before

Change-Id: If653ba4f160414cafe65eee530b6b67e5b5b547c
---
 mm/kasan/generic.c | 24 ++++++++++++++++++++++++
 mm/kasan/kasan.h   |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d54e89f8c3e76..b43ac17b7c926 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -238,6 +238,30 @@ void __asan_unregister_globals(void *ptr, ssize_t size)
 }
 EXPORT_SYMBOL(__asan_unregister_globals);
 
+#if defined(CONFIG_KCOV_UNIQUE)
+/*
+ * __asan_before_dynamic_init() and __asan_after_dynamic_init() are inserted
+ * when the user requests building with coverage guards. In the userspace, these
+ * two functions can be used to detect initialization order fiasco bugs, but in
+ * the kernel they can be no-ops.
+ *
+ * There is an inconsistency between how Clang and GCC emit calls to this
+ * function, with Clang expecting the parameter to be i64, whereas GCC wants it
+ * to be const void *.
+ * We pick the latter option, because Clang does not care, and GCC prints a
+ * warning with -Wbuiltin-declaration-mismatch.
+ */
+void __asan_before_dynamic_init(const void *module_name)
+{
+}
+EXPORT_SYMBOL(__asan_before_dynamic_init);
+
+void __asan_after_dynamic_init(void)
+{
+}
+EXPORT_SYMBOL(__asan_after_dynamic_init);
+#endif
+
 #define DEFINE_ASAN_LOAD_STORE(size)					\
 	void __asan_load##size(void *addr)				\
 	{								\
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 129178be5e649..d23fcac9e0c12 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -582,6 +582,8 @@ void kasan_restore_multi_shot(bool enabled);
 
 void __asan_register_globals(void *globals, ssize_t size);
 void __asan_unregister_globals(void *globals, ssize_t size);
+void __asan_before_dynamic_init(const void *module_name);
+void __asan_after_dynamic_init(void);
 void __asan_handle_no_return(void);
 void __asan_alloca_poison(void *, ssize_t size);
 void __asan_allocas_unpoison(void *stack_top, ssize_t stack_bottom);
-- 
2.50.1.552.g942d659e1b-goog


