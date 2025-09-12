Return-Path: <linux-kernel+bounces-813665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D2AB54910
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CE4AA5A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3F2EB87C;
	Fri, 12 Sep 2025 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4SxenS3"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B442EB84E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671974; cv=none; b=GBDr0gs0VUI4j+FQRaw3XF/o38cduR4QXQ/Xz/A5H+cVm5mwZwh4gkzXIbeMG3qHUzlZAo89Qr32qmQf5yeeKhWruFCOcmh4kQcIRELgjw0WHxq1B4qse/44IOClQAsdbAtpNHfPS3Zc5v2x9LUQtITrV1SZ23bephaTvBexUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671974; c=relaxed/simple;
	bh=a5HXFEXCxWNRHDDVyZZfIidS3SNN062TjXO3sF8vxcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7BCmBpWxV4sALlJgRAfp8va0D6E+6m+MhStdyn0GfZZ0b8tG7p+r7UryQgAmY4VQ0j62cx7g1F7eKGpSHflAFN8vmdoNeIU6OPavBCAkYcTW9tpvTezll/dN78H5vY0Mqll9Gf5mjo7bcn4lVFP84stayR1yJZ1xh4SoyRUGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4SxenS3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24458272c00so18778295ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671971; x=1758276771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEzQtMPq9PK+5+yYtP/oNug9OWMsSiZGEa798p9Mz9w=;
        b=X4SxenS3BxcAA9QiBmVt+MB6I+ZcELSePKO4cOmBRvVjrbpwt9Uj288zM4KHAmiu5C
         +5X/D3B1XHmLtRG5npsNGNIePp0Va+eE1jYuI6wwf66FeB44vMr8d0VzaKXgK/hJx2YC
         HWU1uOpyx0uN8VlsT99qnsM7eKsR5dFmlOcuzWmxhgTrPRw0HLqSvcNxjpwK00kz/ETk
         Zb7E+5h3IQLeY4XtJ7NXB/yZxZ7iSZzefLLcwcH2bn7hSHYWspt4wbRH71zf/zKIdwtd
         OxrOgXe0ovMgI2hz9sloJYajJ9dzBPoYj7+oepOOwo7W1lv+Rn3TSaQBWGkZqibQEN23
         NKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671971; x=1758276771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEzQtMPq9PK+5+yYtP/oNug9OWMsSiZGEa798p9Mz9w=;
        b=LnFpEnpvp4h5yW8Lms9QdaOeEarE2a26MInxBftzMsjvTPBr8sVO2NZKXkR+pVP1lI
         8+6CPcmTGD09Oie3QJAf/4fOfx9zwya7t0Y54wLNWIKH2nHozO8jHMUmpxMPrRETEtUi
         saBsjwispZgJE+PDpEAsfq09x5ld5P7Onu/aqUbH9IkSEUYB48+GqSZBXrT+FxxQxNkw
         LBzXK1vWuJk4mVQBChoMOYLD5NQzE+6HX+fnGnIMwrokeLuUadszKHeXMbhV0Bfc5ObY
         DIGROXsygyTipscv+WFDQOdjpWlMzENqcmFSt1O+HfRvr716Y82rEvOduQ734tY55HHZ
         Csjw==
X-Forwarded-Encrypted: i=1; AJvYcCXRCLyo3zJQJOEF8U8qd0nH4H8OmlBqegBrkWjbiwAAV+/tjZifZv0C0xrvHtsUidgZ3IKz9vUe+z0WYvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQQnnr6yJ2UtC9sJ8oXT8wbYW++cpC+uxNa4j2IxzkfGh3t4F
	5B/nvrwSRUFVjJsFcgfA8WDLgRk1b1g/1A+lGcVfAA3OqqADybFFy/8X
X-Gm-Gg: ASbGncvA7VVv512OZetIzQM1wzFzVberPx3mjaitSj2IrQ6qCEhGPLSGAMA+MQPJDGZ
	o+Cc2YSVNEF3VApMi4lZY3KPUYL/K9R+3sCE0TL3RuEOG7A/L31mPQ3Ua0cVTbBCiGY5ylcLGsh
	XABZSW86W5T2HIJ82qEjVi0ucrDa7Ek1Vh46XdH3mK9R9t/1DiZtLgE9rgkgvf3tg96tPPIziXi
	TlwJGv8+o99c4Pf3FsU1aMc/v2phTbvj6Kvgp9CDNca+j9WIfrGIAZOBA2x6gMOu7AGZEsdR0qY
	KxTwqNWkHujLJuCYy/7XtkYqf1u6FnHAx5qFqrktVZ4dj1kImSQu84c4oOSPhWxyFC0OQ+ZwhNW
	2Qb+UuBWQU4IkCBwPkOK6elxoukWyN3Nz1zvKQCOocWnSEE/HQLaX5qEit5hj
X-Google-Smtp-Source: AGHT+IFjzeds5aG6Wb+p60MOU157xCW/uyAMBkC8kYhjKV3VQWNhWnO7RA/JWobHVFlYljAoloxrVg==
X-Received: by 2002:a17:902:d490:b0:25c:18d:893 with SMTP id d9443c01a7336-25d24bb33f9mr25149495ad.22.1757671970918;
        Fri, 12 Sep 2025 03:12:50 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37293f0asm45159835ad.43.2025.09.12.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:50 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
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
Subject: [PATCH v4 11/21] mm/ksw: add probe management helpers
Date: Fri, 12 Sep 2025 18:11:21 +0800
Message-ID: <20250912101145.465708-12-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide ksw_stack_init() and ksw_stack_exit() to manage entry and
exit probes for the target function from ksw_get_config().

The entry/exit probe handlers use atomic ksw_stack_pid to ensure a
singleton watch and current->kstackwatch_ctx.depth to track
recursion depth. A watch is set up only when depth reaches the
configured value.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |   4 ++
 mm/kstackwatch/stack.c       | 113 +++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 0786fa961011..5ea2db76cdfb 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -38,6 +38,10 @@ struct ksw_config {
 // singleton, only modified in kernel.c
 const struct ksw_config *ksw_get_config(void);
 
+/* stack management */
+int ksw_stack_init(void);
+void ksw_stack_exit(void);
+
 /* watch management */
 int ksw_watch_init(void);
 void ksw_watch_exit(void);
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index cec594032515..ac52a9f81486 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1 +1,114 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/fprobe.h>
+#include <linux/kprobes.h>
+#include <linux/kstackwatch_types.h>
+#include <linux/printk.h>
+
+#include "kstackwatch.h"
+
+static struct kprobe entry_probe;
+static struct fprobe exit_probe;
+#define INVALID_PID -1
+static atomic_t ksw_stack_pid = ATOMIC_INIT(INVALID_PID);
+
+static int ksw_stack_prepare_watch(struct pt_regs *regs,
+				   const struct ksw_config *config,
+				   ulong *watch_addr, u16 *watch_len)
+{
+	/* implement logic will be added in following patches */
+	*watch_addr = 0;
+	*watch_len = 0;
+	return 0;
+}
+
+static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
+				    unsigned long flags)
+{
+	struct kstackwatch_ctx *ctx = &current->kstackwatch_ctx;
+	ulong watch_addr;
+	u16 watch_len;
+	int ret;
+
+	if (ctx->depth++ != ksw_get_config()->depth)
+		return;
+
+	if (atomic_cmpxchg(&ksw_stack_pid, INVALID_PID, current->pid) !=
+	    INVALID_PID)
+		return;
+
+	ret = ksw_stack_prepare_watch(regs, ksw_get_config(), &watch_addr,
+				      &watch_len);
+	if (ret) {
+		atomic_set(&ksw_stack_pid, INVALID_PID);
+		pr_err("failed to prepare watch target: %d\n", ret);
+		return;
+	}
+
+	ret = ksw_watch_on(watch_addr, watch_len);
+	if (ret) {
+		atomic_set(&ksw_stack_pid, INVALID_PID);
+		pr_err("failed to watch on depth:%d addr:0x%lx len:%u %d\n",
+		       ksw_get_config()->depth, watch_addr, watch_len, ret);
+		return;
+	}
+
+	ctx->watch_addr = watch_addr;
+	ctx->watch_len = watch_len;
+	ctx->watch_on = true;
+}
+
+static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
+				   unsigned long ret_ip,
+				   struct ftrace_regs *regs, void *data)
+{
+	struct kstackwatch_ctx *ctx = &current->kstackwatch_ctx;
+
+	if (--ctx->depth != ksw_get_config()->depth)
+		return;
+
+	if (atomic_read(&ksw_stack_pid) != current->pid)
+		return;
+	WARN_ON_ONCE(!ctx->watch_on);
+	WARN_ON_ONCE(ksw_watch_off(ctx->watch_addr, ctx->watch_len));
+	ctx->watch_on = false;
+
+	atomic_set(&ksw_stack_pid, INVALID_PID);
+}
+
+int ksw_stack_init(void)
+{
+	int ret;
+	char *symbuf = NULL;
+
+	memset(&entry_probe, 0, sizeof(entry_probe));
+	entry_probe.symbol_name = ksw_get_config()->function;
+	entry_probe.offset = ksw_get_config()->ip_offset;
+	entry_probe.post_handler = ksw_stack_entry_handler;
+	ret = register_kprobe(&entry_probe);
+	if (ret) {
+		pr_err("Failed to register kprobe ret %d\n", ret);
+		return ret;
+	}
+
+	memset(&exit_probe, 0, sizeof(exit_probe));
+	exit_probe.exit_handler = ksw_stack_exit_handler;
+	symbuf = (char *)ksw_get_config()->function;
+
+	ret = register_fprobe_syms(&exit_probe, (const char **)&symbuf, 1);
+	if (ret < 0) {
+		pr_err("register_fprobe_syms fail %d\n", ret);
+		unregister_kprobe(&entry_probe);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ksw_stack_exit(void)
+{
+	unregister_fprobe(&exit_probe);
+	unregister_kprobe(&entry_probe);
+}
-- 
2.43.0


