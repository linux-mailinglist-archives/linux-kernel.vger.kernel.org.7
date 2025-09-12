Return-Path: <linux-kernel+bounces-813672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE6EB54927
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965CA1CC3366
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA1E2E2DD0;
	Fri, 12 Sep 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRey67IO"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524C72F0686
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672006; cv=none; b=Hzzof8liLZTo2VGdGzDDaRc96lRlMlfrY0ubvNueKW4KGGqveHn+owaGrVwCxjLBsOCXV11Igw0YBR2J6CxMfPd/hV47LDCpPHA9SeIAAtg07T/WbVpz8sH3gYHwpRxEuK9qL1bfeqefQ4AZsebdCAEEDtCYFKcZN10Fay5SHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672006; c=relaxed/simple;
	bh=xBysK8gV2dBvim56r1xsBo0HiYvpD2t6feorIo85ANY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFXAr0TlJF3QaWGfJvE7/64gw59fcDecYKIMl71ug7gM1e/soN16Nhnpg2KMQr3Gnmuz7f2N3tra2f0wBk9BGPT+WACl4WBvbx/DwWCQeKV8XEsqXGQhVKJ223RbudBtgfeZZKdAv6OuW+43D1uHL7TBfeChyQBmOvfLRKPa1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRey67IO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so1502214a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672003; x=1758276803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbQZ2RA/ceP/Xd/vXrNH7xFxG1mfw2BEk3J2LPmN1HA=;
        b=dRey67IOHZ/2rMxXC5cSne2seOyJbyfXHa/e77+0PEVEfo1XnT7TskSsVG3VSUULQT
         zLMjmUsl/gBqlrPWc4C8YXxJD8MD9t/7disQwBMZFEwieOj6ZGVinY6CqpvpqJLYfKiK
         Z4ZA6sgVntr/qLxtUuBq2FmtuK6cH7oxHSF3GIBzYy8CDk+1ZxFnAHJ2d+0V1i3AgJjo
         I+drPd7KjNyOS7wcJCxkmBdiEpC/ERH0DnXNr7Di4JhLjsqNq2sVj5cg63QHUmnaM3Dp
         j/oBZxWdcckvaS4k7Ln2C9uEqqH3jXTsD8o+LZVQDuT3pl/Qda3k1KbqPF22cs+Q0ij2
         5ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672003; x=1758276803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbQZ2RA/ceP/Xd/vXrNH7xFxG1mfw2BEk3J2LPmN1HA=;
        b=HnzXP/00gNuvA/zcvu4tlwAzj/zpvg1BuDx1APub+2gQacu9CdA7yOk6HNZxZ89x8s
         4TwuJ672vDM+sLHBlMxHLSY3SmK0dLv59q7hNITOlqwg5xvPAmUt6WK6hZ0zA9N4/FFd
         rOG4C71/sGxQNOBHuyVF1k36LSeBSKy/RlMU3bm2kR/XW4cKcRQ/Ju1mElcI7Xi2OVNn
         c0oxdrbdNOz4DnMCsjO8wEHUe6uyF3jUGFEq583T290M6S4/vohXcjFl3Yc02VnTfAUE
         R2pk8qD/7mvwKgWz68Dcyib4Mg67i4zuhnU00hzFrn45o1mCxbGyFcUEtx2lSkw3OeeO
         fMvA==
X-Forwarded-Encrypted: i=1; AJvYcCWnFORyMlb6iAftMO1ic3MsQBJo5CGpMPjP5EHjMscd/sDtbnKHVjCVDsRI6OsYdjLZLi3ugV7WqTzw/nA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Bxn3crqTzFMlMJsAQ71kfFWgb4Xz8NEtbhuFva5iDohdmoAm
	T0ypu9oZhKqnb6XvjaN1wOg7DaNNFYNUXM/57wcoVXss+2Vf4SW2+T7v
X-Gm-Gg: ASbGncuy0zWEwk2lqpwJzpJF+MmSkVm1EdnvZ+B+Xt2NzmiZal3ZV6VwF9cklXfi75Z
	2K/F5RLjQhSTw88S1ZjUbAUkAvYohZMZjf0DnxnLrVMnJbCeQtlb8Ts/SPAUJs6eibljbwyhF+C
	+kuJ4FXr72/bWRLt5NecDRXQc/RanHlkg9EvReH3QieuL6GW+vENwkDyytqI/wqbFXNwQBM0dwC
	iA+cuCpq1aV8+gtZ8GEbkwHFE1iOUDd1TJaApfdfj6L2/68i1uFFwRKYSVwQtbXLbH9zsRNYhk4
	IqWGAdFNkyoLRB31Tftjj7r+dGvzt3EbS9Y9p89vIG9cMvMrnCo+cDGTwjzOFTKle8cokdnXa8b
	heUsPZ3TAyirP5OEbznyae/Qj1S5qR3K5hNM=
X-Google-Smtp-Source: AGHT+IF25l3C1E8p5GHeNvlIVkbp0kOIYt1wPzTaRq0s8H1fBwmcnKLuf8G6T/dCuiyhKBgfSsTJeA==
X-Received: by 2002:a17:90b:2b46:b0:32d:7093:7f6b with SMTP id 98e67ed59e1d1-32de4f96188mr2888054a91.30.1757672003490;
        Fri, 12 Sep 2025 03:13:23 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b3ea0sm5091462a91.18.2025.09.12.03.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:22 -0700 (PDT)
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
Subject: [PATCH v4 17/21] mm/ksw: add silent corruption test case
Date: Fri, 12 Sep 2025 18:11:27 +0800
Message-ID: <20250912101145.465708-18-wangjinchao600@gmail.com>
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

Introduce a new test scenario to simulate silent stack corruption:

- silent_corruption_buggy():
  exposes a local variable address globally without resetting it.
- silent_corruption_unwitting():
  reads the exposed pointer and modifies the memory, simulating a routine
  that unknowingly writes to another stack frame.
- silent_corruption_victim():
  demonstrates the effect of silent corruption on unrelated local variables.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 96 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index ab1a3f92b5e8..2b196f72ffd7 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -20,6 +20,9 @@ static struct proc_dir_entry *test_proc;
 #define BUFFER_SIZE 4
 #define MAX_DEPTH 6
 
+/* global variables for Silent corruption test */
+static u64 *g_corrupt_ptr;
+
 /*
  * Test Case 0: Write to the canary position directly (Canary Test)
  * use a u64 buffer array to ensure the canary will be placed
@@ -61,6 +64,92 @@ static void canary_test_overflow(void)
 	pr_info("canary overflow test completed\n");
 }
 
+static void do_something(int min_ms, int max_ms)
+{
+	u32 rand;
+
+	get_random_bytes(&rand, sizeof(rand));
+	rand = min_ms + rand % (max_ms - min_ms + 1);
+	msleep(rand);
+}
+
+static void silent_corruption_buggy(int i)
+{
+	u64 local_var;
+
+	pr_info("starting %s\n", __func__);
+
+	pr_info("%s %d local_var addr: 0x%lx\n", __func__, i,
+		(unsigned long)&local_var);
+	WRITE_ONCE(g_corrupt_ptr, &local_var);
+
+	do_something(50, 150);
+	//buggy: return without resetting g_corrupt_ptr
+}
+
+static void silent_corruption_victim(int i)
+{
+	u64 local_var;
+
+	local_var = 0xdeadbeef;
+	pr_info("starting %s %dth\n", __func__, i);
+	pr_info("%s local_var addr: 0x%lx\n", __func__,
+		(unsigned long)&local_var);
+
+	do_something(50, 150);
+
+	if (local_var != 0)
+		pr_info("%s %d happy with 0x%llx\n", __func__, i, local_var);
+	else
+		pr_info("%s %d unhappy with 0x%llx\n", __func__, i, local_var);
+}
+
+static int silent_corruption_unwitting(void *data)
+{
+	u64 *local_ptr;
+
+	pr_info("starting %s\n", __func__);
+
+	do {
+		local_ptr = READ_ONCE(g_corrupt_ptr);
+		do_something(500, 1000);
+	} while (!local_ptr);
+
+	local_ptr[0] = 0;
+
+	return 0;
+}
+
+/*
+ * Test Case 2: Silent Corruption
+ * buggy() does not protect its local var correctly
+ * unwitting() simply does its intended work
+ * victim() is unaware know what happened
+ */
+static void silent_corruption_test(void)
+{
+	struct task_struct *unwitting;
+
+	pr_info("starting %s\n", __func__);
+	WRITE_ONCE(g_corrupt_ptr, NULL);
+
+	unwitting = kthread_run(silent_corruption_unwitting, NULL, "unwitting");
+	if (IS_ERR(unwitting)) {
+		pr_err("failed to create thread2\n");
+		return;
+	}
+
+	silent_corruption_buggy(0);
+
+	/*
+	 * An iteration-based bug: The unwitting thread corrupts the victim's
+	 * stack. In a twist of fate, the victim's subsequent repetitions ensure
+	 * the corruption is contained, protecting the caller's stack.
+	 */
+	for (int i = 0; i < 20; i++)
+		silent_corruption_victim(i);
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -88,6 +177,10 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("triggering canary overflow test\n");
 			canary_test_overflow();
 			break;
+		case 2:
+			pr_info("triggering silent corruption test\n");
+			silent_corruption_test();
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -108,7 +201,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"==================================\n"
 		"Usage:\n"
 		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
-		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n";
+		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n"
+		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0


