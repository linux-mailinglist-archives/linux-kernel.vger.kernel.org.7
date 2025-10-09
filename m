Return-Path: <linux-kernel+bounces-846648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783ABC8A56
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E151A60137
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A68D2E6CC2;
	Thu,  9 Oct 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9ISfsas"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040792E62C6
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007458; cv=none; b=QBlbK9GFTXYinF1iuyF11P5nrKEfXCqZ2pDKICc5R+gyluRBy+gorv46wn/NZbrHSUITjq/FzpgoqSFjkTUhy1Z91SxmoNu7MrVfETFjAgmIJYsYagvtT/EfUO57yTaGNuw/ZAtTSOrb7Z7yXwou2aHP/CXm4vu48R7fJKTYNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007458; c=relaxed/simple;
	bh=nvDFxA5+kzzGy254IQd/07joD3bGnycuza2xxZ+JqIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oK5eKoQ/JpARq9oD/n//oaeUWeqzBFQY/JCZUwpaJRDANj2B29DWezHNlcANJo7Au+fquVq4FD0/SuXmozu9KRXbfSWIcOusnDN5R5nFCJaLLBOnSHIwTy+ydyy7c6L8oTdH4cnAhjfpA8umEJADdHYa49fHR/FBoOCyImHQFqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9ISfsas; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33274fcf5c1so958902a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007455; x=1760612255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NW3rnfkFZjd7Zh69vJKiLybxjQ5f/0P49rVAWgM4UU=;
        b=Y9ISfsasCCtIs06k7SAorawKk7CU6wlYPqtH/S/Nsvt88EBa6xCfDMhUz4EYP8QapA
         g2/4KwXps2dU+ncJwK80GttoBkJTvB15Yf4d/0jWMxB5nA8Q8Y619UD7m4AK7p8tonnO
         D9VLgyBa2ChqdkzZ8ijsQii2RWZnZ/icCrfDg5M3KXzZGlu3oRwd+z6mCEBx+rAZwftN
         GUdknLnGg7Z4utFvSdAn0J6yC401cfSqC4Nb2lKdBJ5keCc6AtU9QbuV/6Fv6ChJij4E
         8D1cJ9lc0cs0GUMBE2CXjt3gRBvMk71svaL04UmdccFHa0hh4H9hmGKa7X4DBB80RfUt
         OoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007455; x=1760612255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NW3rnfkFZjd7Zh69vJKiLybxjQ5f/0P49rVAWgM4UU=;
        b=pMTy+XJZNP1Nua6zKlWUk+CsvuDsp6RO5PTZdiP4wYN4K5OdEbra0tc7UaxbEhbQRf
         ZTzqy9hRNzm3h0gXS5z1oaMtyKK6wB8EOWjXn1thqn3ej8tgSS3yZEPDYUNCi7kMqqt1
         Nh7G4UTbu2JT3f4lR3j65vWx/hhGUUyPM5XBSN36W1AldsvH0zDpbHVdtrEqvTywR51G
         p76ctJKpc8kg8ozO1D5n5WrYCJeaenCrz8C/EqZOd3KUqvD8NPiq3KAGg4xWNZM3sIzN
         09psspR93BcU2fd/YVObFn9TM6TfKOzDz0jjXrGo3F2T4fDAQ3JCG8teQc08OFOEZ1+F
         2PSw==
X-Forwarded-Encrypted: i=1; AJvYcCW0+GwVsJkZokIPSAldd2vqJFqRF3a9CnpU/otig0dgdwlOvBSR9ineyzv+bUY8Xhz73Qs+otHkQdSHEz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmYe23BSX2oltCACLZixAx9Z/1MtUYMwRVuF4gY+j9i/LvfKc
	b8KYcT2d/53tpJP92+wN+4c6++8HAhHX0wx9BXaXH+rtl7FpeUY4Hiby
X-Gm-Gg: ASbGncv06uY2u/jCpxSotHgUrgOp4+35HoqFwXsXEvR8Ed4zrCCOH7IBF85G9jnfSVY
	6dJIuZrrSTlGXG4nDIdDXvtQz2IrFBxJHpgwIKMM9HfQoMxa52E4bFvi8XB3NlVKEJMSO1Io2rA
	5Et+/un8VpUBXAoOVEmgb6hF1CuZV4oogYJjv19/TLqAQSDLO/pKUNgtG+E+KsuR2saFW3cyAFH
	wGkrwD48r4SjWO3SblaxQmOuCF47VqPZs1nElH8T+T89rB2B3BYrXdiDBd/UJZx5eMj6DPYh57v
	5tXIbS/DI7c60HY6T/cz86Rr/HqZgckIQ5F0hA1Wfl0cBjW/77CZ+kYl3E1wwZJr/+vbcfTc17w
	+zmf4zseolijrq44DN92YdwhgZajcxbugLrwoVz9TayBRjPF83LOQbTzJLVSw
X-Google-Smtp-Source: AGHT+IFC13odZspSVqGRoywijSg0VBbkFQPkMFOijqia9KTXZKXwmvUEM0W1W0I7XOEEhq8lnQYbLg==
X-Received: by 2002:a17:90b:2249:b0:32b:cafc:e339 with SMTP id 98e67ed59e1d1-33b5139c4f4mr8493028a91.36.1760007455151;
        Thu, 09 Oct 2025 03:57:35 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510fc5e6sm6727834a91.6.2025.10.09.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:57:34 -0700 (PDT)
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
Subject: [PATCH v7 07/23] mm/ksw: add HWBP pre-allocation
Date: Thu,  9 Oct 2025 18:55:43 +0800
Message-ID: <20251009105650.168917-8-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009105650.168917-1-wangjinchao600@gmail.com>
References: <20251009105650.168917-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-allocate per-CPU hardware breakpoints at init with a place holder
address, which will be retargeted dynamically in kprobe handler.
This avoids allocation in atomic context.

At most max_watch breakpoints are allocated (0 means no limit).

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h | 13 +++++
 mm/kstackwatch/watch.c       | 97 ++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 983125d5cf18..4eac1be3b325 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -2,6 +2,9 @@
 #ifndef _KSTACKWATCH_H
 #define _KSTACKWATCH_H
 
+#include <linux/llist.h>
+#include <linux/percpu.h>
+#include <linux/perf_event.h>
 #include <linux/types.h>
 
 #define MAX_CONFIG_STR_LEN 128
@@ -32,4 +35,14 @@ struct ksw_config {
 // singleton, only modified in kernel.c
 const struct ksw_config *ksw_get_config(void);
 
+/* watch management */
+struct ksw_watchpoint {
+	struct perf_event *__percpu *event;
+	struct perf_event_attr attr;
+	struct llist_node node; // for atomic watch_on and off
+	struct list_head list; // for cpu online and offline
+};
+int ksw_watch_init(void);
+void ksw_watch_exit(void);
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index cec594032515..1d8e24fede54 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1 +1,98 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpuhotplug.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/irqflags.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+
+#include "kstackwatch.h"
+
+static LLIST_HEAD(free_wp_list);
+static LIST_HEAD(all_wp_list);
+static DEFINE_MUTEX(all_wp_mutex);
+
+static ulong holder;
+bool panic_on_catch;
+module_param(panic_on_catch, bool, 0644);
+MODULE_PARM_DESC(panic_on_catch, "panic immediately on corruption catch");
+
+static void ksw_watch_handler(struct perf_event *bp,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs)
+{
+	pr_err("========== KStackWatch: Caught stack corruption =======\n");
+	pr_err("config %s\n", ksw_get_config()->user_input);
+	dump_stack();
+	pr_err("=================== KStackWatch End ===================\n");
+
+	if (panic_on_catch)
+		panic("Stack corruption detected");
+}
+
+static int ksw_watch_alloc(void)
+{
+	int max_watch = ksw_get_config()->max_watch;
+	struct ksw_watchpoint *wp;
+	int success = 0;
+	int ret;
+
+	init_llist_head(&free_wp_list);
+
+	//max_watch=0 means at most
+	while (!max_watch || success < max_watch) {
+		wp = kzalloc(sizeof(*wp), GFP_KERNEL);
+		if (!wp)
+			return success > 0 ? success : -EINVAL;
+
+		hw_breakpoint_init(&wp->attr);
+		wp->attr.bp_addr = (ulong)&holder;
+		wp->attr.bp_len = sizeof(ulong);
+		wp->attr.bp_type = HW_BREAKPOINT_W;
+		wp->event = register_wide_hw_breakpoint(&wp->attr,
+							ksw_watch_handler, wp);
+		if (IS_ERR((void *)wp->event)) {
+			ret = PTR_ERR((void *)wp->event);
+			kfree(wp);
+			return success > 0 ? success : ret;
+		}
+		llist_add(&wp->node, &free_wp_list);
+		mutex_lock(&all_wp_mutex);
+		list_add(&wp->list, &all_wp_list);
+		mutex_unlock(&all_wp_mutex);
+		success++;
+	}
+
+	return success;
+}
+
+static void ksw_watch_free(void)
+{
+	struct ksw_watchpoint *wp, *tmp;
+
+	mutex_lock(&all_wp_mutex);
+	list_for_each_entry_safe(wp, tmp, &all_wp_list, list) {
+		list_del(&wp->list);
+		unregister_wide_hw_breakpoint(wp->event);
+		kfree(wp);
+	}
+	mutex_unlock(&all_wp_mutex);
+}
+
+int ksw_watch_init(void)
+{
+	int ret;
+
+	ret = ksw_watch_alloc();
+	if (ret <= 0)
+		return -EBUSY;
+
+
+	return 0;
+}
+
+void ksw_watch_exit(void)
+{
+	ksw_watch_free();
+}
-- 
2.43.0


