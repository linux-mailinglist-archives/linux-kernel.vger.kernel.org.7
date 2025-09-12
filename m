Return-Path: <linux-kernel+bounces-813660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43388B54905
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8EE586280
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A72E8DFC;
	Fri, 12 Sep 2025 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVqx/HMc"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1132E2EEF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671953; cv=none; b=X4xoYKNfbrbCDu73/8ybXO0ZQ6WeSCiLPDR1enYFmLQQEHVn50S0QHfVAQzvZ7n81zZddu2Q7j5LACUxBeZxicgs2aUDaqTgYTS6orIcq8/nlWYPSgBK6ob7xa30e1glRqjE4fFyzkbXkaFSvRxZftFjyVhDcn80otl0x9b6n1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671953; c=relaxed/simple;
	bh=0LDaB0nCUJks9qfGHQUupDX5ghXvVPG655pHEUpPv0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONk+xPDp03W6uruXMbXYRKOGTjCsWZZtgfOcWQNtPaymn9pTmUq0bbKNLgp+YR8R53SvOYdp4tkvuI/LoJPdlN4/dFY4fBBGf7cFkbHCy2Qg6OtRPutwXzhFRi50QTY/FKMmyykHp4gnSkfiUWKoxHoVqs608SSIUsNf0gm0G8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVqx/HMc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4e84a61055so1163814a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671951; x=1758276751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0CmyIyII1+MjAJi7HJRtv0YVAXaAwAF3MNYXoEmi5A=;
        b=YVqx/HMcx4WSO9i1YtOiiV7Z3RYtwePGk3ADWg3kZQ9pySyLlQhj3snXhTpJEx957w
         srGpnBdxagEBUTvLsPLQJewwbBYn7iWjj4/v0ayowKE2WoalDMmvhyuZdDam2JEsawor
         hk0EutrTk4+v9xlH/63Ub6gGLU2bqMw0qaJwKNuTXWRaoNhkVlCuTnRYVVuN8pqlhIlM
         K3/QMkQpDQ5J8XrQRM7fULzrOm34WCUgmaI6OS9LLYuNSu/8bFMlIW7TGsZyqaiSEjFE
         oVC29mNNaEa+kxkVYn9FuSevElViV1F3l/dHiCnoF+ibYOYYgPWCZ0fWA46ALLAg+isW
         tmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671951; x=1758276751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0CmyIyII1+MjAJi7HJRtv0YVAXaAwAF3MNYXoEmi5A=;
        b=GhqpzmfddHOFqT7bm+Ke2NFERjYpIKFzFWbHB81YoyPktRPzhZQTicRFzL7TzvsB+Y
         w+fEhcTT4RCvOsdgMgXVznkKzzELKakzwlWvguHOPwM9mLmKx2o1eGlU2BT2LJpaPwUM
         wHwrJlG7sBxh35Kr1glrmF8dQCr0qpLMXE721mEeuXSIKIrCzGusZt9zo3UvuE1eO/IL
         3GzSv+fBTDp8ib5kKdIC7sKIUEA4/V5Xccq+hpf08okDe+ZD0cL02pY/oI5OwWRIz0aX
         lNrAX0uan+QeKGqhtxvZMmAozh/mV2tow8sSqNdr5aGLnA5v/eWjs/Gw6ToTxX25Zr/3
         fAdA==
X-Forwarded-Encrypted: i=1; AJvYcCXwHEU1M9qMO33JnkL5O175aySl9HvjZioYcqFtYu4J3UupMpoxuk2lL1/aOkdP530ppSvMup9AQRQ2PnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9theSlt2NkmT4g7Hay5ij8yogD6At9UZ+aOBmVF5tS4Gb9jv
	HqHfYmrigvOF0Iary0zGa3IrzzIH5PrBvxmk/x6xSE4KMDLwrUnuLnTB
X-Gm-Gg: ASbGnctr7Ziq1yELMSUJonah+4nzYkTfNDQUL+33whlBE43JVw5d0eViLQUEFJCy2VS
	3InF9enXkERF0aTwHDqX7HJqttN0xR/6tUNTs9qxfmiGB3b3QcL+ujIa12yB7pePP/6fhVotVEs
	zToNTA10pwPPIjk4AEwAqHHC7lGzMiYi6chRb75cyQPzALN1YVrbg8IEWjV9Sgau8uQcV9pdVLn
	rWP+OkcMeH+J6RjiIP6tOeTO5s4kvPTUSHIjAV2PAZG7HmgYfi8/sirX22lej5vTWj4YtlF5NgT
	WLMcr4n3B5TNIbnNldacMEv++QMInrhMvL2MwRbivhqMJ7TxnFDKSMk2CDyOsiHg4KwINmDsmYc
	6VcGNJrkRisWbjc65AFuvXqHUp//yMdwuAZnt3mg=
X-Google-Smtp-Source: AGHT+IF00yk89VG+lmEZt4lMLX0bbsabe7ZkX4XQg7tfyuz6vAWZHryAYuUydwk9sktzZqpEFk926w==
X-Received: by 2002:a17:903:3c2c:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25d26663dcamr29087525ad.29.1757671951122;
        Fri, 12 Sep 2025 03:12:31 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b4f1127sm44400285ad.147.2025.09.12.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:30 -0700 (PDT)
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
Subject: [PATCH v4 07/21] mm/ksw: add HWBP pre-allocation
Date: Fri, 12 Sep 2025 18:11:17 +0800
Message-ID: <20250912101145.465708-8-wangjinchao600@gmail.com>
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

Pre-allocate per-CPU hardware breakpoints at init with a place holder
address, which will be retargeted dynamically in kprobe handler.
This avoids allocation in atomic context.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  4 +++
 mm/kstackwatch/watch.c       | 55 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 277b192f80fa..3ea191370970 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -38,4 +38,8 @@ struct ksw_config {
 // singleton, only modified in kernel.c
 const struct ksw_config *ksw_get_config(void);
 
+/* watch management */
+int ksw_watch_init(void);
+void ksw_watch_exit(void);
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index cec594032515..d3399ac840b2 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1 +1,56 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/printk.h>
+
+#include "kstackwatch.h"
+
+static struct perf_event *__percpu *watch_events;
+
+static unsigned long watch_holder;
+
+static struct perf_event_attr watch_attr;
+
+bool panic_on_catch;
+module_param(panic_on_catch, bool, 0644);
+MODULE_PARM_DESC(panic_on_catch, "panic immediately on corruption catch");
+static void ksw_watch_handler(struct perf_event *bp,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs)
+{
+	pr_err("========== KStackWatch: Caught stack corruption =======\n");
+	pr_err("config %s\n", ksw_get_config()->config_str);
+	dump_stack();
+	pr_err("=================== KStackWatch End ===================\n");
+
+	if (panic_on_catch)
+		panic("Stack corruption detected");
+}
+
+int ksw_watch_init(void)
+{
+	int ret;
+
+	hw_breakpoint_init(&watch_attr);
+	watch_attr.bp_addr = (unsigned long)&watch_holder;
+	watch_attr.bp_len = sizeof(watch_holder);
+	watch_attr.bp_type = HW_BREAKPOINT_W;
+	watch_events = register_wide_hw_breakpoint(&watch_attr,
+						   ksw_watch_handler,
+						   NULL);
+	if (IS_ERR(watch_events)) {
+		ret = PTR_ERR(watch_events);
+		pr_err("failed to register wide hw breakpoint: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ksw_watch_exit(void)
+{
+	unregister_wide_hw_breakpoint(watch_events);
+	watch_events = NULL;
+}
-- 
2.43.0


