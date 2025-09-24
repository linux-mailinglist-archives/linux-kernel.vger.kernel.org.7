Return-Path: <linux-kernel+bounces-830448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729AAB99AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0FCF7AF954
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819263064AE;
	Wed, 24 Sep 2025 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXCQ7oji"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC2305967
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714741; cv=none; b=Bz5SbuoX0RjWmg/Qgf+pNH4Cw/Hn7Kyn4uvV/iuKqArgOUVTvjHn2nvLuwdpPkKItImHIUY9AEawQwrSaToI5AfMAqKR6QhAyeNlSl0PmsxAH99fgX4YZsDsKmDTav8MsLsOoIerVygZ5N624YLLXrrrKm4AOkfltl2A0fXK6iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714741; c=relaxed/simple;
	bh=wmwmRtcPH4ST6Dm0G2/AFHsMnlz3q9k9yRWhyo1wI/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSL+pvBbP6XRwzvtgIwv9pmwJFNCO4R8WHje33lfXsUIjl2c8EsekW94HaYjWylnxsR9+9bxAvXCYr8g/hH9kBjRirkCe+hy9jlQE040JJ+yniDt08EXLheMJoWhtuUqNDQ3PooKhH6qyo5pW8O+j3yIHXofBs+Xo8Qv+N+MwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXCQ7oji; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b54a74f9150so4969871a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714735; x=1759319535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4BKEfc9ax2ksTKKBAwbjubQHvBiDjA54WMJGQTptLg=;
        b=AXCQ7ojisXReGNvopgPMp8A0RZsJPR7y39gkdB+j20C1Kr39caCOI3U/8aJK0DzUBu
         FSvj5BAqshUcX8sqk5Z+XaCM83/KoVGvmTbVAGZqkbjAgnKvqcFr9Th+rz6QlMKMwNLz
         9ZpVxdrcYdND8pT5D2Ehx5k3nyDS+TMb6BaRPIwh41BsYcQlX4SgmzQ1MspkpBVSe/vE
         z3VsfdNHc+lT4vlYipGxa60SbjmCyRxdSk43cJCCD0t8Xh4qCpV2+SJUHBG7E4gWVKyn
         L3L6eXwieXXVo0BxL818lzuVABikbGk8NrAOi/97+qIeG2ld6Mrd2SRESAay+RCoQRjU
         imKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714735; x=1759319535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4BKEfc9ax2ksTKKBAwbjubQHvBiDjA54WMJGQTptLg=;
        b=EDw7I1VlUlTCZqRi0p8NSL3cIQ54n0hymg5nNgj8LoJ+WpGYFTn2KtKaykFayCV90M
         KbMgeqN0OiXqKm2sO/6VCqUR6yvE5QArev1EeLv0SJTwWTPJUsDz9T6T/5ZySv7gX4r3
         YYs+KboIdIjesdeyaiNWtAlyTjC5hQ4bcPbSG04Uh3chIHuPVUOHzxsK99I4liBpnJxJ
         5Gr69ncuKgCKmyXp0Wdep6mDrIWc6cZFp1T3dgbMK2I1e81FFJGQp8dD8QZVyxX76/rj
         XbRp1DG2B8JYh+YNOhXxQXyMLqS9d/4/cMjdCOIWeCD0//kXZEAij5L15COO9gRv+rjT
         dScA==
X-Forwarded-Encrypted: i=1; AJvYcCXVeWi6SucOV+1I6duN9+BqBBwZ/xt/flbQPtVh1W8dDxiGs/r8JH/793JfGeH2hJcDljPhii6Ghm8zoRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRzxT0JLih1u8u7de455jkW0ZXNJqiHLBvngO+M5frcp+LUqj
	udu+i7iPRkNalKHF+qm5ezDLKJ3P567BK3HDm9EcNJWeaWRoQncqh+WU
X-Gm-Gg: ASbGnctiaKwOnFdw0QKAqtJZBGns185tMhpp53Qcp+PNtWFowaaOeJE3+9Ee5AlQEah
	2+ZGUgnFi83lah5zH+fU/JkiL4r7zBPwIjGMwACVIQgpuYRBzkanz7Ao+VXVQR/aXsTFYZD6rlA
	chnirpC6bY0WYOW3jAliFEOgefTq2HioL9EYZ+CFe7s+xOJsDMSsI37sYICUp9d75bHzZYYpKN2
	LEzgOV7BLB3hPLHuFAHkzMc68LVeOBC3/eqPUmg8qmQaPe4QQKEyjg/fS9jLLO4Tm//pGAhoJ5h
	5Izv3mHwDZsLllDqgb/9cVpY4falmoN84AklF/bUNw+ujx3weXsZepiIZO0/TzVKwlDPzPzyoWa
	/v4H2By87L5UFagWZ7wqQ5Cob3Q==
X-Google-Smtp-Source: AGHT+IEIPde70G75F7g+aLuFunwEIX4ciWCOE5JEZlKnHsvKJ7fdAzkwZXDsNRxc7SsbnaPx5zSyIw==
X-Received: by 2002:a17:903:8ce:b0:266:2e6b:f592 with SMTP id d9443c01a7336-27cc325ea9emr75331615ad.25.1758714734961;
        Wed, 24 Sep 2025 04:52:14 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27cc8b251f7sm49110575ad.8.2025.09.24.04.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:52:14 -0700 (PDT)
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
Subject: [PATCH v5 11/23] sched: add per-task context
Date: Wed, 24 Sep 2025 19:50:54 +0800
Message-ID: <20250924115124.194940-12-wangjinchao600@gmail.com>
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
index 000000000000..2b515c06a918
--- /dev/null
+++ b/include/linux/kstackwatch_types.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTACK_WATCH_TYPES_H
+#define _LINUX_KSTACK_WATCH_TYPES_H
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
+#endif /* _LINUX_KSTACK_WATCH_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b833350..6935ee51f855 100644
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
@@ -1481,6 +1482,10 @@ struct task_struct {
 	struct kmsan_ctx		kmsan_ctx;
 #endif
 
+#if IS_ENABLED(CONFIG_KSTACK_WATCH)
+	struct ksw_ctx		ksw_ctx;
+#endif
+
 #if IS_ENABLED(CONFIG_KUNIT)
 	struct kunit			*kunit_test;
 #endif
-- 
2.43.0


