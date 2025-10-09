Return-Path: <linux-kernel+bounces-846656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1AFBC8A80
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88A9C352B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2B2EA15E;
	Thu,  9 Oct 2025 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdKRLbWe"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE52E9EC0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007485; cv=none; b=YPCgvuNZ9dX5M+/kRSkyEYwU7eoTN21dwavQWv9aCT9901r2kILOAK6QU+Ff7UAXCbDHQkXeE1NZWNqDjh5FJfhZkj0GhOFLPF+IIDzVY00oNY7UqZORUHCrOzXZFFDqIoaQBu5OwQ0WFL/YfgM6mPPU2VFrrZHrAhtrx2CwjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007485; c=relaxed/simple;
	bh=ye1IFedT6QyfAsl7NnFp/ScKqi80nwnk9udpC+1GQaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISnSWqdS0OpPUC9YjN6wAbhV7QLC5g4bwET4bmzS/ybfwFbhEAz+3s2XFmrckAauzI+fKNEmOxEJRR4tbI3WuPDihGJbW20M1OoqOtCZotyMO01CVPyJ1Z7NSP4HGUsx4MUCpwcDjshKZxfKEqGEMmgdu1wkF70a2wDLeaVTUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdKRLbWe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781010ff051so593450b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007483; x=1760612283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RtyZdLa/V9peD4vyIt7vF3g+yVd+tHG9wNYuCcZNH8=;
        b=LdKRLbWeg/b5DVlAqapHePmhvK9AG0yeiBom5D9bMCoIXu8P8c+Umy4sT7Kah1pDbI
         e1Rcp9JcDySTjznRdaxIei5/6B5nvO6zCKs+nDWrNiSPrNGqrdeTWCZv7Cu19ecN0mhe
         hZH3WFQTCOJJD1nTm7vvBdsNvVjxR2ln2aeSjGkELI7oeB379UefLEDPhsuQc0Hzx3Ta
         26DCv+2k5pRPudddjUObqT4W6QcbK+ux/K3Z6CBv3WK9eyIOKaqTTkLC8xmMkbWLQeNN
         kcIxQfdmxd3mDrgLy84H4OnGKkhX6Ct46oqGyW3u5jrdmjedHtSOaMjBjM9dmINe8BSe
         jNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007483; x=1760612283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RtyZdLa/V9peD4vyIt7vF3g+yVd+tHG9wNYuCcZNH8=;
        b=YlhkzaAKdrFj8zYiv4TGI98zzjVg0XV/qGquDr8l2sRqigquMMp6kRlNoq4ZbdljwS
         w54c/r7Nc/+NMQaWC5TkbKHxPAjY3ekNq8IqKM2qD0frAAvdOgjiSQEzJwIB/1V/XT1h
         iatS5XEDvq+Aqon+9voE+9hVuIIvY4aCwwIVScvSfGeXCE8BFsH8X57/f3EtxiLG+doO
         0n5CNWOUp2qeyZHQDNbRA2a8k3lN6rDkLOI832NmUgIBCO04m16Nf9k5+IswcV53VvgT
         XCXJ5h+YOMhvj7TCgvyQBlW4bUXibf8w9K1oI2/8iDyrPIHoLQ+MQbc5rxT6jMAl+QOF
         fHFw==
X-Forwarded-Encrypted: i=1; AJvYcCWIJUwMQhrn0j61GCXmSCZoZGegfSQ5f0sP3ALvHWwBCGvJKwFjZFjS2eYohmI7te8OyJrVf3HC7yOVj1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUFgjsbWqg7vbxGRdGDEmxgUUX5I8BQdCr0rKrCb+GcIAA980y
	ydZ0vfN2sJ1nHnOwPNfPBgND41j5W5euRFatzQTquyq93VlhaW0TIbA0
X-Gm-Gg: ASbGncudTvV4b9nM5UxepnQXJBIpq2wpmKbd+Vl8wUgeUDd1lw3Zu1BPjq+nzGtLjGw
	tCe7pV+UGY5ZiHAo49M7JZscWPFsMzo5h/JThfQxtUceyNF3Yu2btXDvPCchwZ4h/Z87EiZeOf1
	pBwrQ5vFKCXfPyilU52NEXXnjmfIOcR9kQDADPmogSU5m3CycwH0B4bgWO8qATKXYz7QV4GWZC1
	nUfPwgjwxH/ukbUEpSceH1vtNPUzNrtrOg2Jkaoaz5HkkH6IqbWYsvYe4xnFWB6diRzyNA0Dkp2
	O4mjbBNt8H7hdCEBrxK0mqt23OvL3sC1foiGB3ENlPMSoqgXZK+FvEKdx649NUWvpnlmnAPUyhU
	xGkyykbnvkc/RdBJB6jWuYsMKHabrMkIhGUoEWGnBg2kBQCUyihd15QkKulCLlUt9fsXp7g0=
X-Google-Smtp-Source: AGHT+IGV1mxHWu3pQaxCo2GAVbKHGeNdLDqI1po/b05L3G5Ejn51+25jeUHtC8qpbOYN5GwS7DtIXA==
X-Received: by 2002:a05:6a20:12cd:b0:2f8:4558:ad9e with SMTP id adf61e73a8af0-32da839ee26mr9375118637.33.1760007482826;
        Thu, 09 Oct 2025 03:58:02 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f3b041sm20711876a12.24.2025.10.09.03.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:58:02 -0700 (PDT)
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
Subject: [PATCH v7 14/23] mm/ksw: resolve stack watch addr and len
Date: Thu,  9 Oct 2025 18:55:50 +0800
Message-ID: <20251009105650.168917-15-wangjinchao600@gmail.com>
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

Add helpers to find the stack canary or a local variable addr and len
for the probed function based on ksw_get_config(). For canary search,
limits search to a fixed number of steps to avoid scanning the entire
stack. Validates that the computed address and length are within the
kernel stack.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 77 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index e596ef97222d..3c4cb6d5b58a 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -9,6 +9,7 @@
 
 #include "kstackwatch.h"
 
+#define MAX_CANARY_SEARCH_STEPS 128
 static struct kprobe entry_probe;
 static struct fprobe exit_probe;
 
@@ -59,13 +60,83 @@ static bool ksw_stack_check_ctx(bool entry)
 		return false;
 }
 
+static unsigned long ksw_find_stack_canary_addr(struct pt_regs *regs)
+{
+	unsigned long *stack_ptr, *stack_end, *stack_base;
+	unsigned long expected_canary;
+	unsigned int i;
+
+	stack_ptr = (unsigned long *)kernel_stack_pointer(regs);
+
+	stack_base = (unsigned long *)(current->stack);
+
+	// TODO: limit it to the current frame
+	stack_end = (unsigned long *)((char *)current->stack + THREAD_SIZE);
+
+	expected_canary = current->stack_canary;
+
+	if (stack_ptr < stack_base || stack_ptr >= stack_end) {
+		pr_err("Stack pointer 0x%lx out of bounds [0x%lx, 0x%lx)\n",
+		       (unsigned long)stack_ptr, (unsigned long)stack_base,
+		       (unsigned long)stack_end);
+		return 0;
+	}
+
+	for (i = 0; i < MAX_CANARY_SEARCH_STEPS; i++) {
+		if (&stack_ptr[i] >= stack_end)
+			break;
+
+		if (stack_ptr[i] == expected_canary) {
+			pr_debug("canary found i:%d 0x%lx\n", i,
+				 (unsigned long)&stack_ptr[i]);
+			return (unsigned long)&stack_ptr[i];
+		}
+	}
+
+	pr_debug("canary not found in first %d steps\n",
+		 MAX_CANARY_SEARCH_STEPS);
+	return 0;
+}
+
+static int ksw_stack_validate_addr(unsigned long addr, size_t size)
+{
+	unsigned long stack_start, stack_end;
+
+	if (!addr || !size)
+		return -EINVAL;
+
+	stack_start = (unsigned long)current->stack;
+	stack_end = stack_start + THREAD_SIZE;
+
+	if (addr < stack_start || (addr + size) > stack_end)
+		return -ERANGE;
+
+	return 0;
+}
+
 static int ksw_stack_prepare_watch(struct pt_regs *regs,
 				   const struct ksw_config *config,
 				   ulong *watch_addr, u16 *watch_len)
 {
-	/* implement logic will be added in following patches */
-	*watch_addr = 0;
-	*watch_len = 0;
+	ulong addr;
+	u16 len;
+
+	// default is to watch the canary
+	if (!ksw_get_config()->watch_len) {
+		addr = ksw_find_stack_canary_addr(regs);
+		len = sizeof(ulong);
+	} else {
+		addr = kernel_stack_pointer(regs) + ksw_get_config()->sp_offset;
+		len = ksw_get_config()->watch_len;
+	}
+
+	if (ksw_stack_validate_addr(addr, len)) {
+		pr_err("invalid stack addr:0x%lx len :%u\n", addr, len);
+		return -EINVAL;
+	}
+
+	*watch_addr = addr;
+	*watch_len = len;
 	return 0;
 }
 
-- 
2.43.0


