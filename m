Return-Path: <linux-kernel+bounces-809404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE831B50D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17EAA7A31E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A9247299;
	Wed, 10 Sep 2025 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf68HO8L"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B62459FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482331; cv=none; b=VDChS+IjW4++r3/oNAKXwY8/KK63Efip+Fmvk86r4IhlbjlPC5PLyJDvNa+VPJav5YpPChvhBzlzoKSabWwPadNTGeCkCBNkLUYuu7U+emqAkynRX8IPaHr/OqkZ7b7loBsq42K9H3rCLyt9zazM7MxNJQs5dXyltREBEQTlg7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482331; c=relaxed/simple;
	bh=SkhVEDZinWN4f6gLf6AD49QXQAAX3QdS/Y8kBRD00QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyL3S3MC+U1ny44Q/6OxvHAq42eHMWYcWNWQkk8pnntEwmQF55oaGqut5euqpBB2t+Kn9GrWoNmvuEsfX2/jLOPVXhwXYQyIym7jw5ziUF7N/DGixFUegL932m4ix0NbXuKz/OiiV3vjI7UC7FOCjoT0hoxfLZuMKEIl9YjyqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf68HO8L; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7724cacc32bso5017198b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 22:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482329; x=1758087129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTX/18/Ng4CVcL/DRFC+Yv752wszrnD9hcMkiFmERzI=;
        b=Sf68HO8LASx5vUSfB/6FtMuME7Go9T/biFyP2UkY9f5mwn7aleqXkE61r+OfsvfpFx
         As0ZsRAA/NLGZVuCs1zUzRgLMY2OmXf2n3/bVuC/ovYsF4yTELoH2teeL2jZZcElx+7b
         5I0lOpooofpGwrmI1ufEo0lxgff5S0nVzcTS1ypOdnrtBgB0GtggfMBd52H9zvU4uPGW
         F73VfZzfdNZTIJkdMZqIpeqUXn5OVxHYF9f9eRJJ+z7GIHX3bg8rH1iaEygpbgHqXg8F
         TyIn3w9jrcw78JNH+K6ZG+Q2lLlhOJsnUP7SHbTfleNJqewlYVNf4IRuKhRAwxbkzf7K
         +hGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482329; x=1758087129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTX/18/Ng4CVcL/DRFC+Yv752wszrnD9hcMkiFmERzI=;
        b=F+v4BRPcwDAi575PsXVNtrzu0ks0PnHkHmH9fHiFBKTluo2x70b3wUPz5IRKJTCeUZ
         Dr0RCsKKIxOewbzOMotKvExtQEhsCYKukL7WNMs/Nd1/LDIbvEKFh3+wXJmz7/T1sh3A
         O9s5hgg9Cj1gzhH+PcymFiJyhbfJBSSHszqgtX+tRZWkRmfbyikaBPQ6VexPt5b+nQKw
         XvRKJXSqxGxtWrgjncVCGWkWUfOocl2GNbTTQfQN48aEC1ynSa4rJOoR8LNpElecHyH7
         nxlChVQLdMZ8FT3h9kmjODhMZTG4w5pcci3k5fYjnwAsqvMIiPCgIzZU1ePWZuAlg2dx
         Al5g==
X-Gm-Message-State: AOJu0Yy327nsII/yQM8tDT6VLIp65Pk8FI+gk+GD25TpjKEqSuYnkxWj
	EqIt997w6ntgpbq/FWlQoIfJGbuMv2rKZyyiud2KAorb5HPLeEnn/wMh
X-Gm-Gg: ASbGncsEBjHZFjoTBq3/8vjFNSMRnqq/weq3kvekFINErrKQ5DOlZ43NW7ahrubhMQG
	LPCiBqO2f4mx+5Vh7CNoSthqGQcD7dJr6ZSKXOaOb13kk5cbnY/APxvIcjQtIXatGeoScGpTCfH
	CIDqHZ/by19KSJaFHK8ZlOR4lcYghHQEAmmw/lcLRfafD68k8QduLCJ0eSFz6mK/ilF0Maf2lXP
	+29bVPd7H/PF64IOvWRMcjUzvNpnLecVFso/Crpgq8LR8iAlnnKnHUbytpilgAuOw/5QIWiPp50
	U+vJsFD3y8Khr9cgPPREhAuWDM8r+8oF448edeMKrTfeOXZtHBoe5xTJX2G7olJnt9NwVFt6Zpx
	U276B9k4qMzJ+gjImOhyoQ6+RvtF7ElaRtaZNgsDdJUeNmkn52Zp7z2GnGqFf4gLMhFRSGeI=
X-Google-Smtp-Source: AGHT+IF9kJrtBDYiB4hfn4HCCgf0UorUfbL019zuPVBNsodMy1NJmmuOm2Dva3GcVIGrDCyocRIbhw==
X-Received: by 2002:a05:6a00:13a0:b0:770:579a:bb84 with SMTP id d2e1a72fcca58-7742dca7eb8mr15301351b3a.5.1757482329364;
        Tue, 09 Sep 2025 22:32:09 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:32:08 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 09/19] mm/ksw: add probe management helpers
Date: Wed, 10 Sep 2025 13:31:07 +0800
Message-ID: <20250910053147.1152253-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052335.1151048-1-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide ksw_stack_init() and ksw_stack_exit() to manage entry and
exit probes for the target function from ksw_get_config().
Use atomic PID tracking to ensure singleton watch.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  4 ++
 mm/kstackwatch/stack.c       | 99 ++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 2fa377843f17..79ca40e69268 100644
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
index cec594032515..72409156458f 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1 +1,100 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/fprobe.h>
+#include <linux/kprobes.h>
+#include <linux/printk.h>
+#include <linux/spinlock.h>
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
+				   u64 *watch_addr, u64 *watch_len)
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
+	u64 watch_addr;
+	u64 watch_len;
+	int ret;
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
+		pr_err("failed to watch on addr:0x%llx len:%llu %d\n",
+		       watch_addr, watch_len, ret);
+		return;
+	}
+}
+
+static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
+				   unsigned long ret_ip,
+				   struct ftrace_regs *regs, void *data)
+{
+	if (atomic_read(&ksw_stack_pid) != current->pid)
+		return;
+
+	ksw_watch_off();
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


