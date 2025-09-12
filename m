Return-Path: <linux-kernel+bounces-813664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A646DB5490D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EB7AA5ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0352EA726;
	Fri, 12 Sep 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZajTr3oD"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BB2EACEE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671968; cv=none; b=SESBatHPpkgwvDc2yslbjk3soR2upu7ADd/bHcXpi5+pbOGeD0Qk25vxMuoIHfXRYGPJYyItcbP8bc0nsBw+K76SNj3x2cbzJ/2XNnsmgdzhIKQDbNXgwMbZJVvpZNDLTS6Stnth3opjL6n/kw2OsMTs0XER4tPrM5o+mqgEokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671968; c=relaxed/simple;
	bh=9KjIUwPMgHNHYVh/vgsz+Iu+cp7WW766R2rHVAOmv3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K27xHAeUyJYuHvLEhQWctP200mqeO8BycsBZzUk8tYUNegZHeoam+fQj2/8J3bNHRGlP8dxXG9okPOOF/R/ei2BrWbEPcjLLVE6sQhoXHmm4K84iRTTTv6ywruTNb56TEufrYm6bpGdqgtRgxgSP8VLLQZjysDf3MQZMCpFa7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZajTr3oD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b54a588ad96so1009992a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671966; x=1758276766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqhfZKpOZ5vr6/4baQpnpDghHsngjObwVAr7pMjTC1U=;
        b=ZajTr3oDOxUYhsKnBwW/jtStARL+36ayWUwx4F2P6hiWtwXOvDpVMVNxrvHhiTrZuB
         v2qVtPdtCZ81HZO9ZLyqIovuW4I74RgRaD3dSWSRVtkz0N6MNT/pISfjP34RfngIUyod
         N5fh2DrReYCXh1qzjTJVtmVWqXWn3fm9LPAhhMrQ1gkLbfCC9e9kNLHQVmEVSvzLt5ho
         NX7j7c8j6GqXH8pipGjTvf4ebtxAysbB+dXfeSj/xorvfu9+dAxowrpsYNDO9IU9ONXN
         gyZZ0XbR5GWQEBZW5hJQBY9oeQsXNicVR+XYMs8hjbC99xMBzQy7/CtOiWbakBD/rons
         u4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671966; x=1758276766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqhfZKpOZ5vr6/4baQpnpDghHsngjObwVAr7pMjTC1U=;
        b=jpuEfLiElVr38XjMfdDLggSpVy8vqI35y64LmjjQE//D/mPFdnKhInAwJ7RhvPLEy2
         neTxmabbfXK9uC4FRQI20jJLdOPYB6VCImgn7w+KNq0s3wmzvbsbHFK80d4M65KRSd3o
         blXQBMSDQFkJkcIfMuCQWMo73ISDvJlltIBLieMRoOMYYl/ObxF49yiVSHXByrTiKt6G
         a5nFNq2+S4PZuyEs89XZY8qycqWIr6z+S7Cg812CRRam0tLKl+476bDOVSRP8T+qoo8M
         aR3c84In7xP5XgU2xe4DV6vgz6kMydmhjA4zz332RatVtFxQ2ERD65MiFn2EM578jFFk
         EOlA==
X-Forwarded-Encrypted: i=1; AJvYcCVd1W7S2dkpqI12xl2VHeDQx/vDdbvNrXRcUKadM/85gVvmFjt7nDpITUkJ0Z5gLZ12GbpXWPWYxLeBS7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzasqijxWcta/o6MtyEZ+r58xiuraY2BK0VFXoCICsiNo/etCY9
	DxKelWcLRevfMUV81Q3wdLCkdy3EvLMy7fI2meDpxbZoEbpuGOSNO8jh
X-Gm-Gg: ASbGnctdZjhbQ/kzbi3H7AlNHDx0gow/MAdJPIcMIBaqvDElY0UsYX/A4kmI1st7ROo
	+IwwvpsbU9kK52Ro+KouzmHNdeHJdvN5U7460uM6gnIY3Y7Kku6hbLb9RIp9r1qhPJ/bbw+HJJo
	VeaoP0byVMn66yElJrABew4oJHS6L0s5/hZwxLryh6W8DDdA23Ms+G/7ihubZ9uChIerbJ8vp+5
	pecj8qGzN3IBeBPK9roLPi8nK23cWTqnVjCxjpEIwTWHXqZWDRPYMr3EkZEDg6gUYbtcJuXOJmY
	5/o7sJRtB+GBRBF05ZJ/nS6i1Uz1Bs4E6nafRn8HNwZhjevLeN6QhJjCeLudnnR4iImKM4DLkQL
	9bO2TN0dotMIdD33rtLmeQP3qmZKMdOnYpXOGEds=
X-Google-Smtp-Source: AGHT+IHYvhVuQu3JkB4HjuaPSs4+WBMwwDAkSMFdp4aHblSEvg/m0jfxMexK7gmtMSLEueohiSNhCQ==
X-Received: by 2002:a17:902:e5c5:b0:253:65e4:205f with SMTP id d9443c01a7336-25bab92cc8fmr79198095ad.3.1757671965944;
        Fri, 12 Sep 2025 03:12:45 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm4273352a12.50.2025.09.12.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:45 -0700 (PDT)
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
Subject: [PATCH v4 10/21] sched: add per-task KStackWatch context
Date: Fri, 12 Sep 2025 18:11:20 +0800
Message-ID: <20250912101145.465708-11-wangjinchao600@gmail.com>
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

Introduce struct kstackwatch_ctx to enable lockless per-task state
tracking.  This is required because KStackWatch operates in NMI context
(via kprobe handler) where traditional locking is unsafe.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch_types.h | 13 +++++++++++++
 include/linux/sched.h             |  5 +++++
 2 files changed, 18 insertions(+)
 create mode 100644 include/linux/kstackwatch_types.h

diff --git a/include/linux/kstackwatch_types.h b/include/linux/kstackwatch_types.h
new file mode 100644
index 000000000000..93855fcc7981
--- /dev/null
+++ b/include/linux/kstackwatch_types.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTACK_WATCH_TYPES_H
+#define _LINUX_KSTACK_WATCH_TYPES_H
+#include <linux/types.h>
+
+struct kstackwatch_ctx {
+	ulong watch_addr;
+	u16 watch_len;
+	u16 depth;
+	bool watch_on;
+};
+
+#endif /* _LINUX_KSTACK_WATCH_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b833350..1b324b458309 100644
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
+	struct kstackwatch_ctx		kstackwatch_ctx;
+#endif
+
 #if IS_ENABLED(CONFIG_KUNIT)
 	struct kunit			*kunit_test;
 #endif
-- 
2.43.0


