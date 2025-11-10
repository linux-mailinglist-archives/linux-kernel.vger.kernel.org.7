Return-Path: <linux-kernel+bounces-893669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A97C4806D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97F4188C32E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2413161A3;
	Mon, 10 Nov 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1SLqfyD"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737F314B73
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792653; cv=none; b=f0yYogIJlyMunS7ckV9HgVnwyxJPgCZo9UDUHKzimlJpiJ1dqwSNiT1xKt7wkBfIn1USw7MT/bDBvpRHUjFMAgF1nDf2u6IBJwF23DyDt30Jkmf+X/1ZuBz/rkMXYnFQJ/76sSU5PecXT7wqxJc5kdkAmJbDVxCychh8tZN5Gbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792653; c=relaxed/simple;
	bh=/b/zOktEwqAjI5HJj6uEpLQ11BHnYeMx0oURGuRUTjs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqw9AD93iKlFSlKuqZvz2OMZZ1LkrnUltSo6SEGjih9X7PS92T7T5Rf2mOEhMhBUJ3T/Sx63zODPwnzSLkDaUQwW74tox4FyAxreore4JGljHa0C803lUyw7vLyANOwFyri8gxLHT4u//KL6bdfUdUTa9jpxpHTSOp/+jLjcNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1SLqfyD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297dd95ffe4so22999665ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792650; x=1763397450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmTHCnPEb0OVb2q4c4fHcn++Nk34I0DPY6dUiFoe4Xs=;
        b=Y1SLqfyDfR8ppi0EnhB5ihICf/DW8etj06fLjMr71E7TRvRl2e2hEpaly2M5h5KEYb
         +30JYjqd6vMFwoX6PLbUgi4uiVEBLehaoK++cGI0AF+7ptsbbCN5DIL2wRTIyfY31xj8
         zRSi1+Zw5Rg/Jc9DW6cXZOe0qOjpVijNAKDgElrCirdv4w28YiVkB+H/8x2eh6nHc1Br
         +1MIm7SvPnJTrTFjwzp/FUERRF6HopdhqqRcrMDxJa9X0WGxd1HdcyBXo8s6YgrWMVMB
         a6e0K2286aeD036eGmVxme/1fILqXivvLNDXy/BoZxfaiPntVpPoeVD3MQotC1wXu9E/
         t5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792650; x=1763397450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmTHCnPEb0OVb2q4c4fHcn++Nk34I0DPY6dUiFoe4Xs=;
        b=mUTxroZDA7F4fg4+2fXBUKCfG2NIiSZpICYoZ+RgeTXorST222H/jB6iIUUOxSJCyD
         BPVg1bc9w4bror9u/5ahMtAqHC3yCV74wMAqf4izuiZhSrh4IcTVctkACdQ06bCLdATr
         EdHmrDuqlT9aD77EnIUmaFnvSlGhVJv2a1v5s/AEnG+wvA4GI3gbaazJy/YE5t2+cXBF
         gF2Z0x2BNywUxY0uF83bWTH9iZbea42T91vYP/+KqgYar16GAkERYTb+AhwEQD8ijBY3
         5vtJIz/S2dXdVZVrBsM3atnyrKw/EspBDgNu4+o8xsPoiiK3K+mXfV+h8JmZDCqxfPgM
         3S9g==
X-Forwarded-Encrypted: i=1; AJvYcCVwz2cr1bVmztuzr0SAOgHwo3WdFvvWoLLKkIiy9zUIuM87RRsHRIwY3/gN10IZOImFI1mHgXHG/JIsd78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMBQNiWdzx9bx7T3MTYuBWDcV+mUQ4GvDjIOs/ZwuXT/3lfA3j
	Tsj8Yd347fpYbXl1qPC9Sq7dcm5FuNQmlKYrPPeQSxVrK0YeOF9e8TYi
X-Gm-Gg: ASbGnctoj1z0augSS1RnTVqDmTN8XglU1TKc+a0AxpGbwS5gP2sRja2U0hX7Y5tTaWM
	gcNwZMW/D528Fv6D6SbzNnHgA04AwQyf9nFyvvbPo1DKJWzYFyX8odpyryr2JDge0jG9md6oe0N
	4uUBojkAs1bGS4/OYmutmdn9bftO9FzWoRO5Ml9Mz5rNTEiCw1qOBTqXkk5fwu5LGpZXMJ6bAgE
	Anl3Eqrd0iUR1M0OihLJiewGlaoWFRJq+52VRqb8F/Qw8eT27NXpJ2RlFMxDkg1gzba4X/71vlB
	p4uhd1fiYtwifAvM1caLu8uRwpwKpC17KDtplmad+UYB0Mb+KCH6twHh+TbtmNK9zZETTO1ZOXA
	T2466zTmw8DhRAvW1/tSsxSxhAd5809zpsoi1Sepfn0OQcQgqAY+/6yI+Me46M6VO0zlmQwHaUH
	d2MDCL39YTgQYuEHFIl4/3EQ==
X-Google-Smtp-Source: AGHT+IFq15Zr3Z90Q0MMFQV+lAVCnrHviaSI2/PKIFU3mj11pJDvw+OMCcvtXWZk8em43woe/8IelQ==
X-Received: by 2002:a17:903:944:b0:296:3f23:b910 with SMTP id d9443c01a7336-297e5619f92mr100007215ad.9.1762792650184;
        Mon, 10 Nov 2025 08:37:30 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b801sm154506025ad.7.2025.11.10.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:29 -0800 (PST)
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
Subject: [PATCH v8 11/27] sched/ksw: add per-task context
Date: Tue, 11 Nov 2025 00:36:06 +0800
Message-ID: <20251110163634.3686676-12-wangjinchao600@gmail.com>
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

Introduce struct ksw_ctx to enable lockless per-task state
tracking. This is required because KStackWatch operates in NMI context
(via kprobe handler) where traditional locking is unsafe.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch_types.h | 14 ++++++++++++++
 include/linux/sched.h             |  5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 include/linux/kstackwatch_types.h

diff --git a/include/linux/kstackwatch_types.h b/include/linux/kstackwatch_types.h
new file mode 100644
index 000000000000..8c4e9b0f0c6a
--- /dev/null
+++ b/include/linux/kstackwatch_types.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTACKWATCH_TYPES_H
+#define _LINUX_KSTACKWATCH_TYPES_H
+#include <linux/types.h>
+
+struct ksw_watchpoint;
+struct ksw_ctx {
+	struct ksw_watchpoint *wp;
+	ulong sp;
+	u16 depth;
+	u16 generation;
+};
+
+#endif /* _LINUX_KSTACKWATCH_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b469878de25c..db49325428b3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -22,6 +22,7 @@
 #include <linux/sem_types.h>
 #include <linux/shm.h>
 #include <linux/kmsan_types.h>
+#include <linux/kstackwatch_types.h>
 #include <linux/mutex_types.h>
 #include <linux/plist_types.h>
 #include <linux/hrtimer_types.h>
@@ -1487,6 +1488,10 @@ struct task_struct {
 	struct kmsan_ctx		kmsan_ctx;
 #endif
 
+#if IS_ENABLED(CONFIG_KSTACKWATCH)
+	struct ksw_ctx		ksw_ctx;
+#endif
+
 #if IS_ENABLED(CONFIG_KUNIT)
 	struct kunit			*kunit_test;
 #endif
-- 
2.43.0


