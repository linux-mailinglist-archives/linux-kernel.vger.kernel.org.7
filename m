Return-Path: <linux-kernel+bounces-830450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF853B99AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DDF4C60D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB91307AD7;
	Wed, 24 Sep 2025 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpQkdID/"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374A305067
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714745; cv=none; b=tn8wpD+lZMpH1CjXzaInMoX1si0aAioGuZqHQ1lRqM7FjYYsanjhunQXViyYWcyVPe+74WZRR8no1JdUsUA4VyKYE3A3Y8GS6cvlIi34/zWXzZbB5Pk+RwKTeAL5UKwoVF3SI9NbJ1Df9wmHoTkwtYtm/JtyYpPGZG3uPLmiGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714745; c=relaxed/simple;
	bh=fgMlahiCQseGsOMwUDeQip37398eJhQex5YpJdEa4RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LP8uliIY6hglwF+QYLt2vbfvIdIlo4RxEG1pve6ZxB+xC3OqCJR9hOAgk+3ijISvmrLsLeLlJOnoU7SBE1w/XiX6+zC8pZ7vld6//9L0NvyXoTNL9DxMjnBNPgIqga4dn7dEGR6ODQbgNZyxGYi4dbLJZZrdQlK5WPYab9y8QVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpQkdID/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so26556925ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714739; x=1759319539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zjvk/jwcgtCF9TRiT6Fv94jzQiYOsdOhmjAblUevyNs=;
        b=hpQkdID/UsPSSm4az1H/+3L6wEGeYzGYCgN3GwzYa9HNIiAOqBa/CEdCWallO7C71F
         fBcI4KqsiOclw9d/mL0hXcJJYBvQpnQQ6RnoZF/zyDNdeDQqGiDCFeoVXARbEsypMK9G
         MsSZmGuaTI1EuFV2FAUYaQ8FDy+Eth4FUFfPFp3OeMaRqDL9k8D2cL+LVlnUp3bdjxgS
         2SH2a3mHiiMBtvxsMjyL0xD25CNP5KqMYGmj8rSYLKE5piA4OfY1PyOLQJJ3SkDEookD
         7kqEpL5qoJ4NvRODY/PHoWxfRfB0kjP1YBSZm+Ir2cc4jsMwS1NUZoRXL9hs4mJNfuox
         AD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714739; x=1759319539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjvk/jwcgtCF9TRiT6Fv94jzQiYOsdOhmjAblUevyNs=;
        b=e36YRmEkb1hVkWFZi3B2fvGNQZGucg+iyy20xyOYcv5lQ1TIfU7xKJyG0GK4ZG2wMa
         PLvooQmQlC2vOdtoJYjvBn8HuBJJwE0VEAy0KgVrKxxSErqFH956UNq1opkhxsRNmLYl
         f+Pwq12SgxvPF0+ShjvNorCVX8u2VJnzy47tA9+iICtv69109eef1eWuElH9Y4lFPT+w
         PB8KIkZzpLKZ2wxMiZ3xG9dNzxWCYavdL2jExnN2KRT3vXJas7ICYXwkT4GzhOA9ceXp
         8F6AKZr7kpcaIDsEhaF4vmV5esKq8ae+ZR14a976Zuy4wlt+DjoBh6kKCfMUsd2GMDh8
         8djw==
X-Forwarded-Encrypted: i=1; AJvYcCXw6/WsvAnrDr0ivqk4ixNo6yqn9kdx4BGYBPuB22m+rW4hIXRKmLfqFxh2BA5FL+/9av/3c7wp/GWFMQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBnXXPT2oWwbPKYeqC+QesPhHsQTnrjrddsCLDwCi4+35vwWI
	/0PgD2N63smWMCSlu8NKdDopoOf4c+ibWsWD7gVeAvx3Zxc7YOL0cKc1
X-Gm-Gg: ASbGncsPZjlCpijPCIfWo3FCgJQpmZJrvcsbGceWRdckDhcTTQCXOPI8Ks8B3bTY4JL
	IwxazUIaO6grWtozttbZAmUzeZ1CyJ4r6ao5lKrRVQESGPlRgKFgjIdKkFyvhASeiYgUJ24ZzJ0
	T5CFSwfeA+ZT/n6AfTAck/g2EhjlpFY/EfcZ4CppR8z9H2C3M98Nppz+pCIttNPYMrhauj6ed8R
	De0s3cmP6WcS5ewuvcdZljh20qibrgN93/deIzYb4OgnN9FnNEIwtgi4MxnelnzPV4tlseoNUQh
	5/9PRFFqctGiTAATeCWvl0RBAqeLVb11nTQba9fJ9wbTEJKLZSLIi76GzXPJKZwPrcMh9cKA7jW
	SIsCBmrDO4gknj7CKieDCW6+DaA==
X-Google-Smtp-Source: AGHT+IEDDMc95VZgHrJ2bAg4UbEi7E3pBoXcjCjpFvkax+6hzWgfw34rDBIIXWBy56pkk1ir13aqcg==
X-Received: by 2002:a17:902:e78e:b0:270:ea84:324a with SMTP id d9443c01a7336-27cc5624e4emr73742285ad.38.1758714738650;
        Wed, 24 Sep 2025 04:52:18 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2752328629fsm101241105ad.106.2025.09.24.04.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:52:18 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH v5 12/23] mm/ksw: add entry kprobe and exit fprobe management
Date: Wed, 24 Sep 2025 19:50:55 +0800
Message-ID: <20250924115124.194940-13-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924115124.194940-1-wangjinchao600@gmail.com>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide ksw_stack_init() and ksw_stack_exit() to manage entry and exit
probes for the target function from ksw_get_config().

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |   4 ++
 mm/kstackwatch/stack.c       | 101 +++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 850fc2b18a9c..4045890e5652 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -35,6 +35,10 @@ struct ksw_config {
 // singleton, only modified in kernel.c
 const struct ksw_config *ksw_get_config(void);
 
+/* stack management */
+int ksw_stack_init(void);
+void ksw_stack_exit(void);
+
 /* watch management */
 struct ksw_watchpoint {
 	struct perf_event *__percpu *event;
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index cec594032515..9f59f41d954c 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1 +1,102 @@
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
+	struct ksw_ctx *ctx = &current->ksw_ctx;
+	ulong watch_addr;
+	u16 watch_len;
+	int ret;
+
+	ret = ksw_watch_get(&ctx->wp);
+	if (ret)
+		return;
+
+	ret = ksw_stack_prepare_watch(regs, ksw_get_config(), &watch_addr,
+				      &watch_len);
+	if (ret) {
+		ksw_watch_off(ctx->wp);
+		ctx->wp = NULL;
+		pr_err("failed to prepare watch target: %d\n", ret);
+		return;
+	}
+
+	ret = ksw_watch_on(ctx->wp, watch_addr, watch_len);
+	if (ret) {
+		pr_err("failed to watch on depth:%d addr:0x%lx len:%u %d\n",
+		       ksw_get_config()->depth, watch_addr, watch_len, ret);
+		return;
+	}
+
+}
+
+static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
+				   unsigned long ret_ip,
+				   struct ftrace_regs *regs, void *data)
+{
+	struct ksw_ctx *ctx = &current->ksw_ctx;
+
+
+	if (ctx->wp) {
+		ksw_watch_off(ctx->wp);
+		ctx->wp = NULL;
+		ctx->sp = 0;
+	}
+}
+
+int ksw_stack_init(void)
+{
+	int ret;
+	char *symbuf = NULL;
+
+	memset(&entry_probe, 0, sizeof(entry_probe));
+	entry_probe.symbol_name = ksw_get_config()->func_name;
+	entry_probe.offset = ksw_get_config()->func_offset;
+	entry_probe.post_handler = ksw_stack_entry_handler;
+	ret = register_kprobe(&entry_probe);
+	if (ret) {
+		pr_err("failed to register kprobe ret %d\n", ret);
+		return ret;
+	}
+
+	memset(&exit_probe, 0, sizeof(exit_probe));
+	exit_probe.exit_handler = ksw_stack_exit_handler;
+	symbuf = (char *)ksw_get_config()->func_name;
+
+	ret = register_fprobe_syms(&exit_probe, (const char **)&symbuf, 1);
+	if (ret < 0) {
+		pr_err("failed to register fprobe ret %d\n", ret);
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


