Return-Path: <linux-kernel+bounces-893670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF58C4807D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 127E934A525
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01709319864;
	Mon, 10 Nov 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pzy7lD+N"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6E3164C3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792658; cv=none; b=T0Rpc9E+Mul2VxMmATv4pCqG7VvFXDBQQP4JF77bjiytgnVR0swP/d+HUu1TCfqpGU4bRxM8NJ07f8yy59sBLmfRGpKVfswgNYWZSdU3CDwpHpeFLShoUFk19NUIk2N1cXGenu6oWY+5GnBXdlxJP0lnMgyTDZhDRzNoI8Dugik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792658; c=relaxed/simple;
	bh=gl+G5Qso+k3I+qIwzV1n+u7DG36AFw0uDF3MMxGh5rI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkQ8e28REp0P43I8atfPyVmfnJrWpegC/oWCDFeL8JuD8k/vHipaaB3lafxIHa8U1Kn6hjBPgmNU31u3qvO0wxvD+RONWCMDjpKa27ZBYheJcMMLp5u0X+JGQk05ZtE+fxq6EhR+pqqE2ouZV/TSWNrkUw91BDlVep4NWizNTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pzy7lD+N; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo2583825b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792655; x=1763397455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+iVGEpI5Tg4S20J7P4CCPxNAttk2LGvwxP9Ue3oAtA=;
        b=Pzy7lD+NquyHSGa1JX0CzL2mRM2AEQB34Tqfh9dMTEn2PagUByYT09lY0RVBdjmJZr
         /h4IpIzUSDe9HpDDD+wF7lY8ec/fhrerEyNWJZ2P3uo5e3VtOcB0cMXQ44Xi2lu0/thr
         iDillqqNE3vTv6lyo/uwRwePuCbkzadF7CUB1R/1R/QARlQMDJ+wn4ypzTI3NL+pMsm1
         qLyZLDIGhmNOzkK0AY1Q7IsP0gOf8e2eg6VhQUsJsJk8UODn+YqHK/RSmv3Gwvf3prUK
         nGi0lbLCiSr7sr2NAL5bUvlGocJS934tDASJ/tRgQ+AzWTh7zyvvCQw46G2SL+q8UuJG
         OMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792655; x=1763397455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+iVGEpI5Tg4S20J7P4CCPxNAttk2LGvwxP9Ue3oAtA=;
        b=P1BUcTK5qOwe83weYTMyUsoA0tdCxzKIxHW6IKlHzAN1NbBSI2c9W6FCi2kiGZ6/nS
         uHOMMnnuK9AYlZahDy88f1kbhxYhz+WTu9YcoMw/Mp9+nqXjU2E3+ERgzDYtl5MG9kcu
         jcUzBQCLxixeyIXseDTybGHYBOYOHLdUWOXGZ73S0Mr1FhLBQrbv4hVGdcDsSamn8oUz
         /0fdOLkJaqwRNiGfWNk+6VH53h8I9HDwe+ODYtsijb8bmynQsRtOifmPhHIpWaZ82lPf
         8rv+WLZT8n2Y32soDGJmqEK/Tp5c0jBjoZ99Zv/i88ZUPzqxN5DCRVwq7avJczi8j4jY
         k2mA==
X-Forwarded-Encrypted: i=1; AJvYcCX7P5uYl6huzstTs1QD/DtognD1q31egjKyukFArgXu2sofupElQFV/XOz5UzmDuQt2suXRVIaGOZZN3Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XdhZ1X8PXwzbJlATb3A6AnoX9K5ynyojGiQx4ATeWcGnw9QB
	JxfVdKbasALETvFyWMC83pnBjAwy/gcpCCbNYVu6t24VzpEuTqHd8j/2
X-Gm-Gg: ASbGncuZCSK8VFCS/60q/hy02FJNPqo+Mb5khE1hxM0a3EEPJ4qfZYFOBufs0px2pmY
	acdysKhaFBShEDoluQZArlxXk60zitOuVzNsjL7fX1GJwovbJ+LQMFq09BP0cxGVAHiQ3rlEmmP
	adOoWJK57msvXF0881k003w5kQSPi9I5aIfSvLF1pTP59Yd3ZaF1rFUcpzMB9qqjsWM2C4MLpBt
	evuHAWNMmuC4e4Bm2qEfnT4FfJNQe79D2GULPo1W94Q0oUddxywl73EV9gDLxsmkh5LcSXVX2Us
	/SAXHiEN3aviTb9p/xiZIAOHjyPIQwlRRZ3wZ6537jM98vYVt3Jja174S32uZzBjkmIj1I/+jLA
	cyscR6nuXLusU71PTcbmqe4FGwoHxAnKy5GDwObOyuRDbYlX2oO+ri1DGjari9B0RAu7WNa3lea
	yJEWTaS7SDlGc=
X-Google-Smtp-Source: AGHT+IGtiWcQfJK4Ygp04b6O0toULhQ9ivsVDr7hyiasnMUnwDIgBXPDlxiRxSR9lhapVrMC+QPG1w==
X-Received: by 2002:a05:6a20:72a0:b0:342:378e:44af with SMTP id adf61e73a8af0-353a39633e5mr12501946637.41.1762792654931;
        Mon, 10 Nov 2025 08:37:34 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccc59de7sm12250750b3a.65.2025.11.10.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:34 -0800 (PST)
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
Subject: [PATCH v8 12/27] mm/ksw: add entry kprobe and exit fprobe management
Date: Tue, 11 Nov 2025 00:36:07 +0800
Message-ID: <20251110163634.3686676-13-wangjinchao600@gmail.com>
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

Provide ksw_stack_init() and ksw_stack_exit() to manage entry and exit
probes for the target function from ksw_get_config().

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch.h |   4 ++
 mm/kstackwatch/stack.c      | 100 ++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/include/linux/kstackwatch.h b/include/linux/kstackwatch.h
index d7ea89c8c6af..afedd9823de9 100644
--- a/include/linux/kstackwatch.h
+++ b/include/linux/kstackwatch.h
@@ -41,6 +41,10 @@ struct ksw_config {
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
index cec594032515..3aa02f8370af 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1 +1,101 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/fprobe.h>
+#include <linux/kprobes.h>
+#include <linux/kstackwatch.h>
+#include <linux/kstackwatch_types.h>
+#include <linux/printk.h>
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


