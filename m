Return-Path: <linux-kernel+bounces-893680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DEDC481B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3352C4A2B62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33043322A21;
	Mon, 10 Nov 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTRPvRp+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99295320A2E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792693; cv=none; b=FE2ZQWRZAW9iFNXUqbImBvSw5qKkrMHjSiHR0xSFnsUaQ1VW1GU1taem10QAjD8DUIDCNNUK8aLkBEmbx9a0e3m5H9ApdBYo+0mJW2t3hzP4fX7LSNa3ukHqMZaM/UqBntWqpvv5oyIR6R7ufvHCVLLiRG2ts2vNBhlqYPyKQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792693; c=relaxed/simple;
	bh=hgEfzLMYGp8CwN/e9f7FjAIj6pt9xNamhCZCRYBRqQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNgxfi00T9+XstsJRPDDQRPpbqsgxfQctnTCh4MbyrfbpGNbEgJNXHmRSNtvcTKa6cqgLYB7zMiNcaD6yrZ01Z+QJ7NU7LVD5W+ScUxz1xFaxt0IKLgCg3eCBZT4QYDDrUZPVmW5f3nGlqIyGyHLi1Qfuts5/+hXvV89eBrhPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTRPvRp+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297ef378069so18864245ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792691; x=1763397491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjEoXPNXhfVJUSFrtIZUZPOp73U+hEWiDpkQ2qC/SvQ=;
        b=WTRPvRp+nyHQ+BzVfs502SSQi3Rbgab5rfHcbvwAuza0fLAUFJ8Z/QoeFAF2sDrrFm
         9F2wZt/veLF0y+UnYcODjEBb9317RYByPySO6C4BKYlzlZxrUviSr4aQmxmTQMtysysZ
         yv5P96wGDrV4nTpCBKHuEVgWW1pnViQYZntJRcqnSz76rZAR9UbdYcIe/wtm/0qrlCIT
         B7WBYgY3KL9KbV88KUSfErHzpesQNOLB3zZ/lQN0uXS6BO/Rl6j55CwQjEDZT4i/od2L
         2cN0m1TyPHY4jSPSS9ABnj12kQXOADGSq6xFBWwvRiz/RT3NVKMtqYqd1+amA1KZz7W5
         1YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792691; x=1763397491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tjEoXPNXhfVJUSFrtIZUZPOp73U+hEWiDpkQ2qC/SvQ=;
        b=Z+RuWWA5H1FCDrDHPTHmckSjLREepYHl835VnML5ANOV5g49Ya139RjLPn56OVLqeG
         yqtwQfpuPewZmqCxktC2ooqMc1/S93rM6wi7lLsUEItSdSkEAiCcj8yCW4CBqWu9MktP
         AKwLi9ikvPtgbtk/p0RzuKTYwJXXLc7vo6fEQIpIUKPXT68H1NSBa8SZPhQt+0o1sY/M
         At5vFU6glF1ztDVQ/kkcF5VUMeEPb/OJyI6vgtF/MVNE+eoNy8j5mIbIPXzmOuNioSFU
         IZFbuYkfPM19RsGL4KIuHamuZlo3Lb62Aw+HqgTkM04ZtlB5oAHtgb4rqUMJ1Kornahs
         mgWA==
X-Forwarded-Encrypted: i=1; AJvYcCU3vi5lShZuOZVeyDQz8MFQOH0uj66cafIAEn29c8qaeVts52In5D3efZ9QtkwBrKPzeZfoHd5x7vsUBFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeyOD96lcIxujLXdZo1IbWi9TBjL5jD0A4JED4SJkRxhpVqV8
	QWffehR292lUCKpA3PPC6L6opp7FO782KdtUGJIXbIcwBF+GbUj8lukl
X-Gm-Gg: ASbGncsWBRYCKyqDZvxmsxj72TmrQz+goe5+zTA9VZs+aGLbE9lt5X9wEMaYnzwgB2D
	blqy4dCoVl7df0HPDKIDagpMIKNZNVawNY1029f4D3kXNvzL8vFkrTyUU8QiHq2qVlL2ME0BJQh
	cWJPVqrgAMApOBXpdecPHDp+j+QXwiXEczOtfeJ9zSaTydgGuBgb9MH9ubhQCrOp7X4N+OXVXoC
	KRc91NeVd6MkNda45X3Fm/aRt6arhn8fthPSzC2gthhCUDGKC3/P2cbC8MgbS1qAxx03Ptnpy4o
	z+gUuIeH0BrDrEDv7cb6/yF4gL1ZUl5ZcE/P/Aars/l358KtCB8LJM1ImHBYJHW/Ic+b/xaTlSX
	Vmgz4Sno5Yc5EYNaUmPph4AdjOzZ2Zd/HFeH2iZTR31kv1EAL4rGX+8LVbEWO2ndR7Rqh7krppw
	a1dCkwuogqQS8=
X-Google-Smtp-Source: AGHT+IGgGEjFRVaat56XCDxopiL8+SM4HXr1TFRgWsca/knmSVG340IyJkWxuGKU2hwaDE2EKORtXQ==
X-Received: by 2002:a17:903:244a:b0:25c:8745:4a58 with SMTP id d9443c01a7336-297e53f933cmr112300665ad.3.1762792690825;
        Mon, 10 Nov 2025 08:38:10 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d0aee149sm8572006a91.1.2025.11.10.08.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:10 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 20/27] mm/ksw: add self-debug helpers
Date: Tue, 11 Nov 2025 00:36:15 +0800
Message-ID: <20251110163634.3686676-21-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide two debug helpers:

- ksw_watch_show(): print the current watch target address and length.
- ksw_watch_fire(): intentionally trigger the watchpoint immediately
  by writing to the watched address, useful for testing HWBP behavior.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch.h |  2 ++
 mm/kstackwatch/watch.c      | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/kstackwatch.h b/include/linux/kstackwatch.h
index ce3882acc5dc..6daded932ba6 100644
--- a/include/linux/kstackwatch.h
+++ b/include/linux/kstackwatch.h
@@ -60,5 +60,7 @@ void ksw_watch_exit(void);
 int ksw_watch_get(struct ksw_watchpoint **out_wp);
 int ksw_watch_on(struct ksw_watchpoint *wp, ulong watch_addr, u16 watch_len);
 int ksw_watch_off(struct ksw_watchpoint *wp);
+void ksw_watch_show(void);
+void ksw_watch_fire(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index c2aa912bf4c4..a298c31848a2 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -273,3 +273,37 @@ void ksw_watch_exit(void)
 {
 	ksw_watch_free();
 }
+
+/* self debug function */
+void ksw_watch_show(void)
+{
+	struct ksw_watchpoint *wp = current->ksw_ctx.wp;
+
+	if (!wp) {
+		pr_info("nothing to show\n");
+		return;
+	}
+
+	pr_info("watch target bp_addr: 0x%llx len:%llu\n", wp->attr.bp_addr,
+		wp->attr.bp_len);
+}
+EXPORT_SYMBOL_GPL(ksw_watch_show);
+
+/* self debug function */
+void ksw_watch_fire(void)
+{
+	struct ksw_watchpoint *wp;
+	char *ptr;
+
+	wp = current->ksw_ctx.wp;
+
+	if (!wp) {
+		pr_info("nothing to fire\n");
+		return;
+	}
+
+	ptr = (char *)wp->attr.bp_addr;
+	pr_warn("watch triggered immediately\n");
+	*ptr = 0x42; // This should trigger immediately for any bp_len
+}
+EXPORT_SYMBOL_GPL(ksw_watch_fire);
-- 
2.43.0


