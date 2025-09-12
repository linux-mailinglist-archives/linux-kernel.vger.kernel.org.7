Return-Path: <linux-kernel+bounces-813654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B5B548E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C93A1CC0381
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772292E2DE4;
	Fri, 12 Sep 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG60eddr"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1662E1C7B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671925; cv=none; b=QsM4G90zKtNid6MprpK4FDYIygX8P/53wXOqm0OIQF5buRAXUv5pMDAirrQrT+akgfPUGibe4MwMgzvNuK5nm9kN18dWb27QRFDvAQvIDQuNBl8dE48g697I0KbeU6/mv/Z762LdfbxIv57SoDkK3jdyuOERFOFfDuTSjVhc2HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671925; c=relaxed/simple;
	bh=mvbQhJ9iNpy/VCsIq7tEZOr138Lj3Ag2m3NYvU9haY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oK8eKOjn202kfVxbuRYsavwpWNTtS6wzA0L4FaJknPcMCJhwvSkO+4gJo9mLfaWZLnMHbb9Nv6EvPz9WEn9dlqZJmN7Y3ZGX6834pAgNmH7qJbH3o/e+CrmUZHpxZibLhc35oQWdtQzeR4EjvLBKW08C8j1/om/C2msUsEp3o4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG60eddr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32ddfe3c8ccso1561227a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671923; x=1758276723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiJ4BKoAQXxhATSlWNuzoAaMk7tQVn4VoD83Z8R1fnY=;
        b=lG60eddrwFZX4Le6zYQCDPJTpdh7Gh7lO2bopIv5m2KRP3timIP3n1h2gcj89YAPKf
         ixc2NfwsaMbRjV2PapOlFolM1OfSybsxAtUf83VgWJNVFSQF847kvuV4eo+S0caTRgIp
         El9PVSDPdYZoYyvqdYUUORmJSlcldyARPgv4/eq+IWIA3cHE9mqTdDx5z6l33bslwLQV
         ca/35VSxu0s973ZwV2NfyLjrfafWfXOF2rHysW8233BI/xSlODl9g+YdZNMAbSM2idxY
         nMj3Dp3zp/myFsk6suQQuf74dTsC/pV6r8vPsl6Vfq+TZiQto1/gWwlsVzqSmm1S33ct
         Cw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671923; x=1758276723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiJ4BKoAQXxhATSlWNuzoAaMk7tQVn4VoD83Z8R1fnY=;
        b=CudqtR0A3FjJkfGoz5okGKgxf3sFzRvhER7AInReuZu78jQgrBByf5ctRlV+7SCjwh
         2EJS0sVqgTgFvba7VZtnmY0eiGlBor3Bm74B7HXRt/X66ke5hyCnZwL3n0CZehIy3HT4
         cMYMB6US5+ftyptE5HafpXQ9CFamZOxw/Etvdr37Jpgyuj3PEk4Rte6N2QHHEE4yqnjx
         3xPZBurU1TaJyJ6m+jG5f1hK9/Cnu9MOhfDJ1X+FtPScdRiDR3cPmWQv5gVUrtxz/Zwe
         tRpetEvcegN+b+iYhIOFnVFwXCqD7ZVPIhW0byvxj8T30vpIoxo9EJoP9LP1QXIbmirG
         7MjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZjAmYdxA1VkRboa19Or5dCaUTu4VluNyEEEGQZagK7npkO7T1nBXhKvpKg2wNnabAQbG4FTFVQPKXd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPIAxCNuPk9I/FXh3mMkLXfB4eGlBsOJ+l8gL8jFTseZPkjcY
	L7oHyh+ZBTgNjLc+ZnFbPQu7NsVInIFp8jrm4NQrlJQZwuvq2ZxEW+RV
X-Gm-Gg: ASbGnct+TDMPWqzPLdZPOOD6NPTUM7qHSfEftnhMf8UZusBDKS2FevHw6533V1OPgL2
	xHwMRxAqyxy/nSsgpAn6q0Bxh8PCPkHqGD9mlICP6C8DgPKVcKrQpspCT+UvleTWcw7Y6m7ietZ
	ySDRiQ5e6UYqidHlxhbakFwdBCL6KCp+2jyuEHqkEi5jnekBZH+SV44pXHIpLFj+6jMvQ6XxDpb
	PL2ua+dCWcVC7bNwdBonjQQU7PYVswjIFlHvDHJy74kfx++xDY5pPrZyf3hIptxvUO2IsvFqyms
	NK3I/10lZv5GGTmAkmk2jvdNsJKImpuO/6jWjSDKNqZ3sW1+irixwpS2CBk+NtCbpEtw6jLqSJS
	iKrZqk7QFGb55uO5ryMamA9gcFUMntb3JBUQHHe8smJq7JKtBF1HUhfGDIyH7
X-Google-Smtp-Source: AGHT+IFVVaIhwhf/XCrQlu3eHp9PRsMkwMoA7wjEYyYhHpp+oe5/jMTyKiMg3Xyx5H7ewbGZG5mSrw==
X-Received: by 2002:a17:90a:da83:b0:32b:96fa:5f46 with SMTP id 98e67ed59e1d1-32de4e7488amr2457300a91.5.1757671922786;
        Fri, 12 Sep 2025 03:12:02 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32df607d504sm76776a91.11.2025.09.12.03.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:02 -0700 (PDT)
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
Subject: [PATCH v4 01/21] x86/hw_breakpoint: Unify breakpoint install/uninstall
Date: Fri, 12 Sep 2025 18:11:11 +0800
Message-ID: <20250912101145.465708-2-wangjinchao600@gmail.com>
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

Consolidate breakpoint management to reduce code duplication.
The diffstat was misleading, so the stripped code size is compared instead.
After refactoring, it is reduced from 11976 bytes to 11448 bytes on my
x86_64 system built with clang.

This also makes it easier to introduce arch_reinstall_hw_breakpoint().

In addition, including linux/types.h to fix a missing build dependency.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h |   6 ++
 arch/x86/kernel/hw_breakpoint.c      | 141 +++++++++++++++------------
 2 files changed, 84 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..aa6adac6c3a2 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -5,6 +5,7 @@
 #include <uapi/asm/hw_breakpoint.h>
 
 #define	__ARCH_HW_BREAKPOINT_H
+#include <linux/types.h>
 
 /*
  * The name should probably be something dealt in
@@ -18,6 +19,11 @@ struct arch_hw_breakpoint {
 	u8		type;
 };
 
+enum bp_slot_action {
+	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_UNINSTALL,
+};
+
 #include <linux/kdebug.h>
 #include <linux/percpu.h>
 #include <linux/list.h>
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index b01644c949b2..3658ace4bd8d 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -48,7 +48,6 @@ static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
  */
 static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
 
-
 static inline unsigned long
 __encode_dr7(int drnum, unsigned int len, unsigned int type)
 {
@@ -85,96 +84,112 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
 }
 
 /*
- * Install a perf counter breakpoint.
- *
- * We seek a free debug address register and use it for this
- * breakpoint. Eventually we enable it in the debug control register.
- *
- * Atomic: we hold the counter->ctx->lock and we only handle variables
- * and registers local to this cpu.
+ * We seek a slot and change it or keep it based on the action.
+ * Returns slot number on success, negative error on failure.
+ * Must be called with IRQs disabled.
  */
-int arch_install_hw_breakpoint(struct perf_event *bp)
+static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
-	int i;
-
-	lockdep_assert_irqs_disabled();
+	struct perf_event *old_bp;
+	struct perf_event *new_bp;
+	int slot;
+
+	switch (action) {
+	case BP_SLOT_ACTION_INSTALL:
+		old_bp = NULL;
+		new_bp = bp;
+		break;
+	case BP_SLOT_ACTION_UNINSTALL:
+		old_bp = bp;
+		new_bp = NULL;
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	for (i = 0; i < HBP_NUM; i++) {
-		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+	for (slot = 0; slot < HBP_NUM; slot++) {
+		struct perf_event **curr = this_cpu_ptr(&bp_per_reg[slot]);
 
-		if (!*slot) {
-			*slot = bp;
-			break;
+		if (*curr == old_bp) {
+			*curr = new_bp;
+			return slot;
 		}
 	}
 
-	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
-		return -EBUSY;
+	if (old_bp) {
+		WARN_ONCE(1, "Can't find matching breakpoint slot");
+		return -EINVAL;
+	}
+
+	WARN_ONCE(1, "No free breakpoint slots");
+	return -EBUSY;
+}
+
+static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
+{
+	unsigned long dr7;
 
-	set_debugreg(info->address, i);
-	__this_cpu_write(cpu_debugreg[i], info->address);
+	set_debugreg(info->address, slot);
+	__this_cpu_write(cpu_debugreg[slot], info->address);
 
-	dr7 = this_cpu_ptr(&cpu_dr7);
-	*dr7 |= encode_dr7(i, info->len, info->type);
+	dr7 = this_cpu_read(cpu_dr7);
+	if (enable)
+		dr7 |= encode_dr7(slot, info->len, info->type);
+	else
+		dr7 &= ~__encode_dr7(slot, info->len, info->type);
 
 	/*
-	 * Ensure we first write cpu_dr7 before we set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 * Enabling:
+	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
+	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
 	 */
+	if (enable)
+		this_cpu_write(cpu_dr7, dr7);
+
 	barrier();
 
-	set_debugreg(*dr7, 7);
+	set_debugreg(dr7, 7);
+
 	if (info->mask)
-		amd_set_dr_addr_mask(info->mask, i);
+		amd_set_dr_addr_mask(enable ? info->mask : 0, slot);
 
-	return 0;
+	/*
+	 * Disabling:
+	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
+	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	if (!enable)
+		this_cpu_write(cpu_dr7, dr7);
 }
 
 /*
- * Uninstall the breakpoint contained in the given counter.
- *
- * First we search the debug address register it uses and then we disable
- * it.
- *
- * Atomic: we hold the counter->ctx->lock and we only handle variables
- * and registers local to this cpu.
+ * find suitable breakpoint slot and set it up based on the action
  */
-void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+static int arch_manage_bp(struct perf_event *bp, enum bp_slot_action action)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long dr7;
-	int i;
+	struct arch_hw_breakpoint *info;
+	int slot;
 
 	lockdep_assert_irqs_disabled();
 
-	for (i = 0; i < HBP_NUM; i++) {
-		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
-
-		if (*slot == bp) {
-			*slot = NULL;
-			break;
-		}
-	}
-
-	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
-		return;
+	slot = manage_bp_slot(bp, action);
+	if (slot < 0)
+		return slot;
 
-	dr7 = this_cpu_read(cpu_dr7);
-	dr7 &= ~__encode_dr7(i, info->len, info->type);
+	info = counter_arch_bp(bp);
+	setup_hwbp(info, slot, action != BP_SLOT_ACTION_UNINSTALL);
 
-	set_debugreg(dr7, 7);
-	if (info->mask)
-		amd_set_dr_addr_mask(0, i);
+	return 0;
+}
 
-	/*
-	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
-	 */
-	barrier();
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
+}
 
-	this_cpu_write(cpu_dr7, dr7);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
 }
 
 static int arch_bp_generic_len(int x86_len)
-- 
2.43.0


