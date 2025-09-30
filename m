Return-Path: <linux-kernel+bounces-836996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7359BAB114
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796911C60F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E254E1B4F2C;
	Tue, 30 Sep 2025 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmTgSTCi"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEF2459D1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200308; cv=none; b=P23Xj8hT/CNvFeVcRVV/rZqJBrQSZ6qHsSoW4ZB1HdqxPOfuYJkSWnEoDYwXS0WecQC0jvXEr+1CCNrXGu7mSDD/j8OzEwyWqX8MiZr66qt6VdTfovONfFKAr9WyeHLflyue/LkR+Kop61fFUzN7tDPZwOjDGM62elIqHEeZmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200308; c=relaxed/simple;
	bh=0RaB9b3mDxARpzNAU+b9+OM/53UguV9OX02ut00avNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LokIvYuZaeyCGlBSzK97pTts2Ovy/7g1lIVleiSwMyi/QIbIRkLaWaw1NhljerXStRQ40Xu5VzuOfK+9mfS8hzHjW++BW4RSa/tg5grlNGVjXz35WlSkcO7XU2tKrTOTVQfRFCUaeGLEHD6S+gboZtaLQmsVlxfkFFdm0XRpR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmTgSTCi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-78100be28easo3958584b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200305; x=1759805105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p2Xfne7CGpLjN/MkaU3Ee28S3aCNgQ2oxnJpFebIbs=;
        b=MmTgSTCivQdUN6WGxhnHkpN5oRIKQd+LSfqs/sOS1wy2A8Aebb4kOPRHOFYP3Pye7z
         okcZ63/Z8oiXVqnARwwKT96xgQmpBZbY+wkkiB4SSSIYm1ClzYVE+/8XgMwVfFzunb+o
         XvcryWYV3OnknQgXuLeGqq/shiIkNcaQ0pXvEwa6uHBUtTc6CO7nO5P9ET3F1STh5Kjc
         Wv0H71Sbx8+0eaXFVfwdROUoeWJOWYekKay/Rifb38+oU2cqbXnZQc33Yqnqs21fy6rv
         6JMUsBzxNF1hZRisA1VjjCVCTayeXC8zgP0SvJCR7PSv0VSdcEkaQkq7wsxKea2CKhui
         HyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200305; x=1759805105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p2Xfne7CGpLjN/MkaU3Ee28S3aCNgQ2oxnJpFebIbs=;
        b=c7TwPUwi0YaFvqIPp7ypbsETrQf7DXuQXBCmSWADarxdVP+mKwcXUTFS0kdNvSfmBQ
         l7drhiSsskFQKaMtiaOm3TowxUFujdGS9gDwDJFo1kINjP1YUeddgY/SYF3PantFXvPm
         IMma6b2tI2nSeRC6sfMB6Fb1db4jHtfm7NmTki7YqF573KZml/bZPoOZwLdoG6KuUdTn
         l3uhKfM+2btRTxsztECeytDM1C+ioi3q19YlK/7Ro8D7A9UOJ4DqElNlTNjAYQ9LpJ9N
         y8TpZN9Gnmu+zegEmE1Hyb+9XgGnYIiuZ70Byg/PA9kiS7iVtfJUrFOagBi6juyoynV0
         GGZA==
X-Forwarded-Encrypted: i=1; AJvYcCW4yrx+XwuZHOGT5hZi/zgID9LMkGPiX5gipn/KG8ZyhRvgJN94gDywTIgyqJYvDZ+deXHgpGJluDUHyf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjRNe8QEJ60hCBPNkMt10Mw8sALAr4+eHV8cv+UpeHYDSxU2SU
	WXoVXNBuL6PC1AjZ23VASSVERMxCPJ/jMGkGMxaQ5pNfygJPMtXmDe0j
X-Gm-Gg: ASbGncu6uDFNfDxOzB1/oI4z68Q+FBEsPD3Vzw01Fm/LcHdi7dKCLHINEhgQ+MPhMfI
	MFc7YepbiCovR3L6JONR8JS8Pjy0T1p32mefIvdnBWb/fhshgdNMOXejVZbk+QFEduaWnOLThbP
	9tKhgjK+GiT1BuH8VtdNQqM0+Xdy6rXW8qxN7ePQS4kdiCBRlDuOPex5tj62vufb/37W5vv4fAb
	kneVW+JZpoLEiZlfEZmgihtsxg+2r2xU2ys+ykp8JzmaYYTXKdsQ9/SeztfjvwgcvmCQaxizKI3
	mwVdYuM9gpnl7PnsWldeoA2dRLd+bvM6Qz0IqTZUAGxuDAzSNYyrfZHtYkrOKjwB7CO8QQe76/J
	LfRfC8hlAHUn7KJTOwvRrg/2TEfdqNXOiQHfNLgZ2oiSjKflKYLVQBASKJRtrvNdiwQ==
X-Google-Smtp-Source: AGHT+IGPdLJDAcFgGXBMapnRTLkbwOuAH98GZaW3SdGH9OxArUIFVK7BxMIb+p319lKI1/5kl2O6lQ==
X-Received: by 2002:a05:6a00:1404:b0:782:d4b6:f5e5 with SMTP id d2e1a72fcca58-782d4b6f88amr8934209b3a.13.1759200305238;
        Mon, 29 Sep 2025 19:45:05 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7822f628080sm6431314b3a.89.2025.09.29.19.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:04 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v6 09/23] mm/ksw: ignore false positives from exit trampolines
Date: Tue, 30 Sep 2025 10:43:30 +0800
Message-ID: <20250930024402.1043776-10-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because trampolines run after the watched function returns but before the
exit_handler is called, and in the original stack frame, so the trampoline
code may overwrite the watched stack address.

These false positives should be ignored. is_ftrace_trampoline() does
not cover all trampolines, so add a local check to handle the remaining
cases.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/watch.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 887cc13292dc..722ffd9fda7c 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/cpuhotplug.h>
+#include <linux/ftrace.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/irqflags.h>
 #include <linux/mutex.h>
@@ -18,10 +19,46 @@ bool panic_on_catch;
 module_param(panic_on_catch, bool, 0644);
 MODULE_PARM_DESC(panic_on_catch, "panic immediately on corruption catch");
 
+#define TRAMPOLINE_NAME "return_to_handler"
+#define TRAMPOLINE_DEPTH 16
+
+/* Resolved once, then reused */
+static unsigned long tramp_start, tramp_end;
+
+static void ksw_watch_resolve_trampoline(void)
+{
+	unsigned long sz, off;
+
+	if (likely(tramp_start && tramp_end))
+		return;
+
+	tramp_start = kallsyms_lookup_name(TRAMPOLINE_NAME);
+	if (tramp_start && kallsyms_lookup_size_offset(tramp_start, &sz, &off))
+		tramp_end = tramp_start + sz;
+}
+
+static bool ksw_watch_in_trampoline(unsigned long ip)
+{
+	if (tramp_start && tramp_end && ip >= tramp_start && ip < tramp_end)
+		return true;
+	return false;
+}
 static void ksw_watch_handler(struct perf_event *bp,
 			      struct perf_sample_data *data,
 			      struct pt_regs *regs)
 {
+	unsigned long entries[TRAMPOLINE_DEPTH];
+	int i, nr = 0;
+
+	nr = stack_trace_save_regs(regs, entries, TRAMPOLINE_DEPTH, 0);
+	for (i = 0; i < nr; i++) {
+		//ignore trampoline
+		if (is_ftrace_trampoline(entries[i]))
+			return;
+		if (ksw_watch_in_trampoline(entries[i]))
+			return;
+	}
+
 	pr_err("========== KStackWatch: Caught stack corruption =======\n");
 	pr_err("config %s\n", ksw_get_config()->user_input);
 	dump_stack();
@@ -168,6 +205,7 @@ int ksw_watch_init(void)
 {
 	int ret;
 
+	ksw_watch_resolve_trampoline();
 	ret = ksw_watch_alloc();
 	if (ret <= 0)
 		return -EBUSY;
-- 
2.43.0


