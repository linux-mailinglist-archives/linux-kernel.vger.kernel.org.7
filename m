Return-Path: <linux-kernel+bounces-748235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3113AB13E47
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC1D540430
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD07227464A;
	Mon, 28 Jul 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaKFz5tV"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2AD2741DF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716371; cv=none; b=pSi/GyvzgJLY1MlLNdBP1/maQZstYcoMqrejG5+SRYkRteyVDRaQQX8EWppHZ3svZ/fekVwl5cPnG9EmjjumkrtnvuqUPWPTpVcTXZIlCPUP1wElWjvV2Cvw1Cz0Z0eLZ/22LZL+rBJ9yrh5Yvz3UWPENM/6MLU5VucXX5Y2+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716371; c=relaxed/simple;
	bh=MllcQEuHiBTsDJxE3qurrwpUzMzU/Y6EBnsPVAZdFD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DUcLQi2hCaH8vNJAdoJ/goz9ReGoUMJa15AQtn2JAov/1RBleldJWBhyH0/bKodkpgUguMc1tTSOcTBSr72p7BqvMt4xyELb/2qtOL7MC2PPBEs+NjbmE44yJnVVeaOblGesmRSrF3ufP5tr1aiH52FN+f79Y6jn6RReiYLy7GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oaKFz5tV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so22996015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753716367; x=1754321167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxbX5YL9Hd7g/YslttSYNXM3pBZCa2EzwplzrqOsm+s=;
        b=oaKFz5tVBPhBx4n69yFoR2Fzq+Ae6ikXy9+bw/V3SECM2vQVwgcG5O0j6CNamgdned
         M1E4c8xpdi3H5OA3E5hPc8DvlSCq0O6PC/BxHaT5O6B+v08TVNRBow45Kcdmtyi5daTa
         61xlHem5oo0ZiLyNDuQHXVWjM+1PAoDsujEpAxxoZHNzbcU6O+ZyvsMqqHCSd8XtfPJU
         ATgGEgZ2x1Kv6kyMTFKTwprmkeRYHkycZ4qI4PmW8el5hVoV3yBhBBaSy8exqcefQwOZ
         i6EzqaxCgm+ROiOtlX0j+84FUML5vceFMcJyGaQcUFZxi1OSsfZ77biI9KepQ5amBuPz
         GomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753716367; x=1754321167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxbX5YL9Hd7g/YslttSYNXM3pBZCa2EzwplzrqOsm+s=;
        b=XVogG5eT6udxFysopFcv0ikZtRMfuYcMJbvUVQ5BFyWhcRlPhK6BFrDO9fHqoc5D+x
         evicDBayWpp7t1zxQ+b18ELluZCUH84i2c5RQ3wf/1M/nTlUp+TZbcQDHXJoKp+DbGq9
         8/XkyisjCRogMooRRpjjRpU3Z18/PyCBl/mph5bssw3sCIiL2aPlI99aXEaRfv6Z3d08
         U0yIXvb5pNKhvc1B3GP8WAtnHDU+Zy3mHs7TDduNH5ZLAhcEERdE4Qprj9x91hBAUGny
         KUzjUzwn9JLiF8G3ckcvzMqMrpersZ9ts/owG9HznpjqvGrXPt/ZmCVYv5H2ZLX+nMHx
         Tsfw==
X-Forwarded-Encrypted: i=1; AJvYcCUfOgJ7KOCzWkLDpO70D++dKsJQ8bKR48ZlmyYy0BCK+XRSn4IPcmx/1/rJo5F70etgC8pT0EY44bETtxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze418fIBVZo6fqmlV0jjb+cmwJDxoN3ICzzYDQr8IiifE+hQnY
	ELQywwbZXIlHGCCIrOG9pPYmxFYJkPQXBWagfjikVhs29M9ZpVzod8I5iz6j0CJ79v6/GoGvmca
	BUBaNeA==
X-Google-Smtp-Source: AGHT+IG2V0ZWWxxszP1ey1jI3Sk0wfKbI+mMNaZLQ1rs2Nl6fNN8FRwGu+cbt173QwILw+7KVPRP6sUI7BI=
X-Received: from wmtf6.prod.google.com ([2002:a05:600c:8b46:b0:456:365f:428b])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b6d:b0:456:1514:5b04
 with SMTP id 5b1f17b1804b1-4587643aed4mr91132245e9.21.1753716367733; Mon, 28
 Jul 2025 08:26:07 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:25:42 +0200
In-Reply-To: <20250728152548.3969143-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250728152548.3969143-5-glider@google.com>
Subject: [PATCH v3 04/10] mm/kasan: define __asan_before_dynamic_init, __asan_after_dynamic_init
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
v3:
 - add Reviewed-by: Dmitry Vyukov

v2:
 - Address comments by Dmitry Vyukov:
   - rename CONFIG_KCOV_ENABLE_GUARDS to CONFIG_KCOV_UNIQUE
 - Move this patch before the one introducing CONFIG_KCOV_UNIQUE,
   per Marco Elver's request.

Change-Id: I7f8eb690a3d96f7d122205e8f1cba8039f6a68eb
---
 mm/kasan/generic.c | 18 ++++++++++++++++++
 mm/kasan/kasan.h   |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d54e89f8c3e76..b0b7781524348 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -238,6 +238,24 @@ void __asan_unregister_globals(void *ptr, ssize_t size)
 }
 EXPORT_SYMBOL(__asan_unregister_globals);
 
+#if defined(CONFIG_KCOV_UNIQUE)
+/*
+ * __asan_before_dynamic_init() and __asan_after_dynamic_init() are inserted
+ * when the user requests building with coverage guards. In the userspace, these
+ * two functions can be used to detect initialization order fiasco bugs, but in
+ * the kernel they can be no-ops.
+ */
+void __asan_before_dynamic_init(const char *module_name)
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
index 129178be5e649..c817c46b4fcd2 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -582,6 +582,8 @@ void kasan_restore_multi_shot(bool enabled);
 
 void __asan_register_globals(void *globals, ssize_t size);
 void __asan_unregister_globals(void *globals, ssize_t size);
+void __asan_before_dynamic_init(const char *module_name);
+void __asan_after_dynamic_init(void);
 void __asan_handle_no_return(void);
 void __asan_alloca_poison(void *, ssize_t size);
 void __asan_allocas_unpoison(void *stack_top, ssize_t stack_bottom);
-- 
2.50.1.470.g6ba607880d-goog


