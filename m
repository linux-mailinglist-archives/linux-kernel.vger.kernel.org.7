Return-Path: <linux-kernel+bounces-836998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA621BAB120
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267161897F68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728132236F7;
	Tue, 30 Sep 2025 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMQ3RZdc"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4A25487B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200318; cv=none; b=TwI6+e+FLd3g0zQjY0fts5ZoOmbyguwNZy8LbQSpCmo1gpcUHLqB4RURBNMhbI6JDN6LcH5B0xxXLVgp4FWgVrNY3d1eM/SQDKKTTp64xV90REi2iEGmfJIWvkO7DRprDz0QJnhI4BVAgo2FUG4OJNp0H7aTXGowuU+j1emXx9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200318; c=relaxed/simple;
	bh=wmwmRtcPH4ST6Dm0G2/AFHsMnlz3q9k9yRWhyo1wI/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wz4SbHKJn1xyDDVHhZbXYSW0z/RmMvG0KAp1mdMlmV/05W4NAxvKwLM7Jym42c2zkfn/CzdtUUHfZbJ+T1g7hKi+WIV4IeSoBPIuvSRQcN6TNNphk5rOHTf0PoV3GDThQ8btri8Q0TxSQwThXyMYPZDk+k2vi//NtjFiFGlfhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMQ3RZdc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so2800946b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200316; x=1759805116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4BKEfc9ax2ksTKKBAwbjubQHvBiDjA54WMJGQTptLg=;
        b=KMQ3RZdckAmme0jUOCXJIopgemB2Ja56Kpmz+pbEeM0xoR/HYAly3J0SYhU6acxg9c
         TE1YANvW5GLqxlokWaBsC94u3Df3Poh7J2S51JRvuFVp5QAN4u0/5Bk78DnZflaGAIF3
         GaAHFrt/JiI3GGcSiAZQKNFeq5N/scmw79xffzCMMwoXlLpaig1EUpBnmgp1Xiw4lE+W
         yRRuhICYSgLsqg2mBt8118beN1+fESg9GutgwL7xJ4G0koaRA8mIIogGpHVqAX7Rf4LP
         cnwMekiQj0fEx2e6tzstCrH0wuSOhn7ui5xrX7TGCEuEe800b1rM4DQqwnuwfGOHLdgI
         wlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200316; x=1759805116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4BKEfc9ax2ksTKKBAwbjubQHvBiDjA54WMJGQTptLg=;
        b=OswxC6gG4JbHvcLKTR9prT3Om/40ok6WWHk2RUGmzijEQi/IjDH1fVaR61DKqSXTv2
         V2fRJSv7fn68nqFqjOC+uhLP8xupcr3LRFdqnKnuAUYVlsgfBx2VgfYOoIIrbcHt7Fhs
         JmNo9vY+0p0FObR3NFefbVJgMvEfJB5OOWDpPxMAQSw6y4TKbDmUS+gdk0CoMOrvLeaS
         4frMy76cJPstN4dGxBlhh28cSvpoJ97O7bdhbvQAkUMBpFRsZQ7qWEUlhtrN9WuIv6Tf
         +PpA/Rtp3EeUfGdSdejsg5OI5sXvqiHhqJrIJbUQqysHk6KGizNaEoJ+AEdBgCK+wBgI
         W3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVGnthYPJP2aZYpkZhF1M/SuqzbouLNXYhbuZ04mSjwDYN1KnnEVHDkRXibRG1eWk50xJ3hvuFExhzKF8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjOGkw2knjxTka4aLuCpqpJgo6ag3D2jg95ZrlDjvW+FSUxXj
	WwuKScszzmswXoJc+ViaTOorsiTpZX8+g5dfmpoSUGyh74ckUVX5nZ2k
X-Gm-Gg: ASbGncs66hTyOeh16TYWwCT2lGyKRtiHdEdDamuB9JnBV+8c0ManAOcP5MPCIqC8sSz
	sj/3erH/tmD8ZJG5K6bnyguWEINaIF+GOjU3zq3oJnj01oTkjsfEzE/c7Dl5akHCIDUHvA8Qbve
	+dtVGLR2gyjiWAdta3ir3b5rSWzMpTVoyyVIn8dCY2uoiPqXAqQqP8nNht5D5D/dp217Zw/ifUj
	GL3cV3N/DmDU4X58tQtUeMLqSA07jNPs/f7mXz2olxysgNCwm8isuduBVoSg0vLSEVwSGJ9vKGL
	zscbpYa/3DwrAEUQVxrZqMc/OJr7pu3p7o1Tjn4ZJ0E08faKH+TOwGq1brtEzjw0UVGUA3nxPHS
	9ixl84qHbNxynwko5rbparaUBhf3BFLfPhSu1PyGDYLWzIuqALNT2C8FF0iZROI2RPkQDT+Y6PP
	+M8Lwhs0aEcrU=
X-Google-Smtp-Source: AGHT+IEQuyQ0WfSSzPcc+c258KMZgmg4lZ9MhFnyLGeSTv6phqmEXsURuXiHXbyU/qbGHk1KY6eV1g==
X-Received: by 2002:a05:6a21:3296:b0:2b5:9c2:c584 with SMTP id adf61e73a8af0-31772a179dcmr3208370637.26.1759200315810;
        Mon, 29 Sep 2025 19:45:15 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c557418csm12399859a12.30.2025.09.29.19.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:15 -0700 (PDT)
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
Subject: [PATCH v6 11/23] sched: add per-task context
Date: Tue, 30 Sep 2025 10:43:32 +0800
Message-ID: <20250930024402.1043776-12-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
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


