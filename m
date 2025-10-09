Return-Path: <linux-kernel+bounces-846659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B04EBBC8AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD1918846E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C22EA146;
	Thu,  9 Oct 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H607T/AS"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DDE2EA735
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007498; cv=none; b=WsPgKG+/EV1ftjsh2TWBm2FKLAxZYtUA4QiIhzBubk/yTX4Onj8ux5KCQPgLZMFxQFgpROG4QoRqlpChhe/gTl1rmsOV9t9VnLY776lrrJF1D7buPHT/yv1hFYeITC8Qw+CjdERKZSVuzbHpDf2sQ0VrzoFZBTM/roymM7HTPwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007498; c=relaxed/simple;
	bh=fq2Ne6eA5Hj+u/oZogdwy0lpJa+hkt/8IQwPQXp6BxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/A6ufYvowtFYnLvkMbBs98CxEkSDHvz9H6nApVaV5tuOEBJQiB8/yEDVRIKmZacfyrlQposot7ne99j4Ykc+DkEH/pd09ychcvbOhg6V6pekvqbSGVhJzY04qqk/z+wbmWZ7eS9i/W+7dePDifYF4PR/pGdAmNSAsJJOxAMJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H607T/AS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so759814a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007495; x=1760612295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zjn9o91E8eMF6fANpWy8yJadTo2vfyIghwnTsVomDQ=;
        b=H607T/ASE7Rnz5qYGOMgNyEpgE0IoFctC1NLPgLpgD3P+Pauoij2McYLUavZ/jIn0z
         +DGvavMPvaigtGVCquwQmFa8nqBeY6zrtimuHUHu4Bc+msN8M6sTOEXYtUpTyot4ubhx
         7+/uHXZAML79IuQvlMt7RW+h7rygUJjnrEuQHhepCi8rG0AQ158RP2fQ0evWdk1Xh//8
         TS9P/RZ16TkPNLqN+dbOTDDbA//PcPCI0/PgPo2/n6CvguCgfimcdlMtQEkdeioh/r1m
         du4ZogEBQPBn1rr7KtwRMTJdILBdq2kysOfEIvCtkU/HK8oHzyrp5F9wlpDCyaiMfuyd
         1UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007495; x=1760612295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Zjn9o91E8eMF6fANpWy8yJadTo2vfyIghwnTsVomDQ=;
        b=sPU0JOgafjfXH7Ac5jwbpLACJdbSan6Gxi5Emv6Up/eVigZN7gwVjJVemT+Fa+V43z
         wgJxP8LavlaHnaqvtVPoGM/I8VXla4PG4IQJCiG8s1GVQLWy5NBZbH/Pqg24ZXpHeInG
         0At7xiySoGvlYlTeplo4alyTwti4Bj5PhtljBm+xXtZrR7BsKIqOUlTOVvlwuXOggzQ5
         ZdB8tJWwkhZc/hzP3cFBc6rQY7+G3lePcdrp8s0XYPnNaHUXaGPgULejg674utWglaoc
         pkHou58afM5b2sgm2Xi0Sd6sIgr9yjnMe+eq9sDDANxkh/C21OIF6/dgM2Hy0gSImnAB
         QwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp49siJCtYup/tTAlxezCoudEpmz42/tvJIKPscRvCVNFGyBvh6oLkafkVOy2mJGS99qGCilj0mCcc6H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7w8THvUZYVyPIV61RwHs0/lhq8cQ74Vd9tn+H8I/WxGflnLw
	AYZmumV8bBep5U6HZR78HLyQ3ybJ5hQv5FXEvywx/NSz8/ST+0V8posh
X-Gm-Gg: ASbGncuqloElQQ7CcCUxjOGlAkOSQhfQlqpKR1el1UceBqfwLapYJLxXGI8hUsBXsIL
	sCYp5CIH8g+wk9cc6MUyhCwFo+ag2gOrHlt+X8V4aYCMnwQLo+3lmrAYHNDFosYmD/YaZni1Udf
	zukxqclFGfDQdOc6eX2xrcxKkeL4pCeJvWYmEzgIcp2AiwSwtbmfnEnVRzv/NPXvUC/k1cwDsm+
	rELAadGrz+YgOkkD+ELgNeBl7QkF7QIwit5FM1x88vMPontA6HD3D01ChPgGqitwP/PmGr3JDsW
	IM7f/d+5wTUeKWyyEmlN6H/b3nTB0doRXESwU9UEa94SORYktmzjfCu80OEX3GX0fJBquMma2Up
	KI41LjPeoBsO/W8zRrmNZyml2o6MBKJaiNDmPoX6j6A4MFD6PAB6wgCK+BBDeGPzQuqmnmX8=
X-Google-Smtp-Source: AGHT+IEmLuap8ugWBv16A9DJeROmcKQpeqK89dicn1ex7O52mvV1jyxIgbB9ToaVJaHbTj90CsCHAA==
X-Received: by 2002:a17:90b:35d1:b0:327:c583:add with SMTP id 98e67ed59e1d1-339eda5cf24mr16255407a91.6.1760007495079;
        Thu, 09 Oct 2025 03:58:15 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b513ad555sm6898776a91.22.2025.10.09.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:58:14 -0700 (PDT)
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
Subject: [PATCH v7 17/23] mm/ksw: add test module
Date: Thu,  9 Oct 2025 18:55:53 +0800
Message-ID: <20251009105650.168917-18-wangjinchao600@gmail.com>
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

Add a standalone test module for KStackWatch to validate functionality
in controlled scenarios.

The module exposes a simple interface via debugfs
(/sys/kernel/debug/kstackwatch/test), allowing specific test cases to
be triggered with commands such as:

  echo test0 > /sys/kernel/debug/kstackwatch/test

To ensure predictable behavior during testing, the module is built with
optimizations disabled.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug             |  10 +++
 mm/kstackwatch/Makefile      |   6 ++
 mm/kstackwatch/kernel.c      |   5 ++
 mm/kstackwatch/kstackwatch.h |   2 +
 mm/kstackwatch/test.c        | 121 +++++++++++++++++++++++++++++++++++
 5 files changed, 144 insertions(+)
 create mode 100644 mm/kstackwatch/test.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 24f4c4254f01..224bd561dcbb 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -317,3 +317,13 @@ config KSTACK_WATCH
 	  A lightweight real-time debugging tool to detect stack corruption.
 
 	  If unsure, say N.
+
+config KSTACK_WATCH_TEST
+	tristate "KStackWatch Test Module"
+	depends on KSTACK_WATCH
+	help
+	  This module provides controlled stack corruption scenarios to verify
+	  the functionality of KStackWatch. It is useful for development and
+	  validation of KStackWatch mechanism.
+
+	  If unsure, say N.
diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
index 84a46cb9a766..d007b8dcd1c6 100644
--- a/mm/kstackwatch/Makefile
+++ b/mm/kstackwatch/Makefile
@@ -1,2 +1,8 @@
 obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
 kstackwatch-y := kernel.o stack.o watch.o
+
+obj-$(CONFIG_KSTACK_WATCH_TEST)	+= kstackwatch_test.o
+kstackwatch_test-y := test.o
+CFLAGS_test.o := -fno-inline \
+		-fno-optimize-sibling-calls \
+		-fno-pic -fno-pie -O0 -Og
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 57628bace365..12b2f5ceb5d4 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -233,6 +233,11 @@ const struct ksw_config *ksw_get_config(void)
 	return ksw_config;
 }
 
+struct dentry *ksw_get_dbgdir(void)
+{
+	return dbgfs_dir;
+}
+
 static int __init kstackwatch_init(void)
 {
 	int ret = 0;
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 528001534047..b7361d5d071d 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -34,6 +34,8 @@ struct ksw_config {
 
 // singleton, only modified in kernel.c
 const struct ksw_config *ksw_get_config(void);
+struct dentry *ksw_get_dbgdir(void);
+
 
 /* stack management */
 int ksw_stack_init(void);
diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
new file mode 100644
index 000000000000..80fec9cf3243
--- /dev/null
+++ b/mm/kstackwatch/test.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/prandom.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include "kstackwatch.h"
+
+static struct dentry *test_file;
+
+#define BUFFER_SIZE 32
+
+static void test_watch_fire(void)
+{
+	u64 buffer[BUFFER_SIZE] = { 0 };
+
+	pr_info("entry of %s\n", __func__);
+	ksw_watch_show();
+	ksw_watch_fire();
+	pr_info("buf[0]:%lld\n", buffer[0]);
+
+	barrier_data(buffer);
+	pr_info("exit of %s\n", __func__);
+}
+
+static ssize_t test_dbgfs_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *pos)
+{
+	char cmd[256];
+	int test_num;
+
+	if (count >= sizeof(cmd))
+		return -EINVAL;
+
+	if (copy_from_user(cmd, buffer, count))
+		return -EFAULT;
+
+	cmd[count] = '\0';
+	strim(cmd);
+
+	pr_info("received command: %s\n", cmd);
+
+	if (sscanf(cmd, "test%d", &test_num) == 1) {
+		switch (test_num) {
+		case 0:
+			test_watch_fire();
+			break;
+		default:
+			pr_err("Unknown test number %d\n", test_num);
+			return -EINVAL;
+		}
+	} else {
+		pr_err("invalid command format. Use 'testN'.\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t test_dbgfs_read(struct file *file, char __user *buffer,
+			       size_t count, loff_t *ppos)
+{
+	static const char usage[] =
+		"KStackWatch Simplified Test Module\n"
+		"============ usage ===============\n"
+		"Usage:\n"
+		"echo test{i} > /sys/kernel/debug/kstackwatch/test\n"
+		" test0 - test watch fire\n";
+
+	return simple_read_from_buffer(buffer, count, ppos, usage,
+				       strlen(usage));
+}
+
+static const struct file_operations test_dbgfs_fops = {
+	.owner = THIS_MODULE,
+	.read = test_dbgfs_read,
+	.write = test_dbgfs_write,
+	.llseek = noop_llseek,
+};
+
+static int __init kstackwatch_test_init(void)
+{
+	struct dentry *ksw_dir = ksw_get_dbgdir();
+
+	if (!ksw_dir) {
+		pr_err("kstackwatch must be loaded first\n");
+		return -ENODEV;
+	}
+
+	test_file = debugfs_create_file("test", 0600, ksw_dir, NULL,
+					&test_dbgfs_fops);
+	if (!test_file) {
+		pr_err("Failed to create debugfs test file\n");
+		return -ENOMEM;
+	}
+
+	pr_info("module loaded\n");
+	return 0;
+}
+
+static void __exit kstackwatch_test_exit(void)
+{
+	debugfs_remove(test_file);
+	pr_info("module unloaded\n");
+}
+
+module_init(kstackwatch_test_init);
+module_exit(kstackwatch_test_exit);
+
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("KStackWatch Test Module");
+MODULE_LICENSE("GPL");
-- 
2.43.0


