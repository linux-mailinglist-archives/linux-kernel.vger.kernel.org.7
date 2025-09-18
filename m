Return-Path: <linux-kernel+bounces-813659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1018B54901
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026D01CC1FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AC42E8DE6;
	Fri, 12 Sep 2025 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibJLqtEi"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517292E8B78
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671950; cv=none; b=c1aCW1cdA3jrjVTvP1pPmsEUnDTjDnWvV1DaTFb7Vf7RKtEk0j4u3N7fvBDEpujNdUuVghHfvVvlAM8DyeJpHmZheYaRcXAv9iSjz1TPhNdtMxyhjxA9ZouIpJHYeelPWZCI7vcysLyLv2Q3noP/XlUMWl+2qxlCgn/EWNuDFVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671950; c=relaxed/simple;
	bh=HtnvcRfhS9CLWmrVuR1TwMxPtWHSQtXzxVQktoPREbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxM4hHe0tgisUkrVJXq2bPZsrBNmFlnxqm+J4MB5bAxQCrdBvCBndy5kIyaRtoDJEa4BE1I/gVsksVBZjFJ9foGvUTQjbeq7YPcwXkBXMKbhywuHx0Kyf7d06NtAia5YZ+lWvydmLFcFd3IiyCU3HaJQbPuQVn2zx9tZsmxvnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibJLqtEi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-329b760080fso1804645a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671946; x=1758276746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Btw7JeEHjCHi0fmk72XeSdeksiIjhqX1c6woWjS/nBg=;
        b=ibJLqtEiEdIp2HmGI1RMpWTh/fGrIXB5E8TsZedpqe6A+E/fjyt41Gf16UNEN9Pzhw
         D1NQez7s8Zp87JDkNhSw1+cb+UQwceM5zJxpbqUo0uwRbE69dgmXNImUYWEnQZnTMex1
         YAWJYBWR/ZKEAuzVUnGEsRJtxa29ScisaJHCefUCQK8VY065T3iNu5UkWLpaQb5dC/7Q
         Y830TmgGUoTcfBY+tQ7A2IAJKFGRlkqX+WaupBdQG/qGHa6nsI79DzCa9POnIESyeJM8
         p88EzBan7TktsTdpAEeB0LEBTxNTE8DD15YYxBudV7n6h+pkx0S/u++6HSNM3PBJLxay
         AEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671946; x=1758276746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Btw7JeEHjCHi0fmk72XeSdeksiIjhqX1c6woWjS/nBg=;
        b=Ws12OkdudN4GCKYNFroQ0zwLBlnGfMl1igbhemH6piSUbxQWUjY8ShrGWoQ1xvV7Gg
         7WkxfzxSmirkYjRmB72xZCV3hm1/LFyvTPXG9ZaqjU064C1hZuZUdLaCHvlD8LB57Rdy
         njX4sr/4wJPYv1DveCPC7baPEnkN3tF22Fv1imzYPPGHuC4MGbw1tV0EOV0vjBZVcY/S
         bwxlVzHJzPzP982phQWULkbSR6KOXtQNMD3MPuFigEXyrJgiqkhOeKVBFpaphkcf4/Un
         cNZSwrEXmH27sj91ENxZy7+qelRXjpDKLw2QFPzN9RXZmsjUTCgL/9ApHpDZnaX7VUdV
         aj/w==
X-Forwarded-Encrypted: i=1; AJvYcCVDK6eGEl76qxkHwd7UIaOcaX1rfDw5z6laKvar3huS37w0wx1oK4yPli7ewBVJBcEJj4IZ+fE2CZogBog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Xq7W6wLBsJFwJdmC+lgzXRpPYusVKQogpBbpnfqAK7PJ6tji
	y7s+Av8s5fgLPJrv68byBKVWSa8gtbR2JFQv+8hwpHHjyYEls7ieQqOR
X-Gm-Gg: ASbGnctx2cGpfQa+iDJmhC5i4BI+zG/vSVC41jS0NhdXsabcsRGPn79qBFbTnYy7BqA
	TdANfNlS6lyPScDEOo4Mx27sUTuHH5qHCakX8hQcBBTSxzj/CL49781Ab4pidGR5Br8qRi7B2/w
	IaA6KyU43dVhdJh3Lqv5+zTpV99004mvj78hW+l3C4WVXxLIO/fQxvHBmV8DkKVVtBz2p/ILHLP
	QZGd8gaLeFXznR8OZjjGNl0vmJWgAUSBmzzMOnzdMx/YTItoXcfaDH/ti9B6qMS9LFfJTIkpFfP
	3NWM/9Q6f4WldeuRwJNZlQEYpGy5ZYnSylT8ozsAGUVVh2hvxWT1PqNA3T2Beo305J2n3WaoDRM
	35Wt0WN7JdT72PcZ3Hf9pNY4iqKWQ4RckRqNM2/c3gcSm7SgU5g==
X-Google-Smtp-Source: AGHT+IE+sH0wcZG9HaKcll5QXaOw6VOwT34jJJKFyIXbetNwLJVfpmHy9Irzue+96yqtkUewE0lXYQ==
X-Received: by 2002:a17:90b:534e:b0:32b:df0e:928f with SMTP id 98e67ed59e1d1-32de4fb9a28mr2940174a91.37.1757671946347;
        Fri, 12 Sep 2025 03:12:26 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a48c19sm4972892b3a.36.2025.09.12.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:25 -0700 (PDT)
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
Subject: [PATCH v4 06/21] mm/ksw: add singleton /proc/kstackwatch interface
Date: Fri, 12 Sep 2025 18:11:16 +0800
Message-ID: <20250912101145.465708-7-wangjinchao600@gmail.com>
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

Provide the /proc/kstackwatch file to read or update the configuration.
Only a single process can open this file at a time, enforced using atomic
config_file_busy, to prevent concurrent access.

ksw_get_config() exposes the configuration pointer as const.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c      | 75 +++++++++++++++++++++++++++++++++++-
 mm/kstackwatch/kstackwatch.h |  3 ++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 1502795e02af..8e1dca45003e 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -3,7 +3,10 @@
 
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 #include "kstackwatch.h"
 
@@ -12,6 +15,7 @@ MODULE_DESCRIPTION("Kernel Stack Watch");
 MODULE_LICENSE("GPL");
 
 static struct ksw_config *ksw_config;
+static atomic_t config_file_busy = ATOMIC_INIT(0);
 
 /*
  * Format of the configuration string:
@@ -23,7 +27,7 @@ static struct ksw_config *ksw_config;
  * - local_var_offset : offset from the stack pointer at function+ip_offset
  * - local_var_len    : length of the local variable(1,2,4,8)
  */
-static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
+static int ksw_parse_config(char *buf, struct ksw_config *config)
 {
 	char *func_part, *local_var_part = NULL;
 	char *token;
@@ -92,18 +96,87 @@ static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
 	return -EINVAL;
 }
 
+static ssize_t kstackwatch_proc_write(struct file *file,
+				      const char __user *buffer, size_t count,
+				      loff_t *pos)
+{
+	char input[MAX_CONFIG_STR_LEN];
+	int ret;
+
+	if (count == 0 || count >= sizeof(input))
+		return -EINVAL;
+
+	if (copy_from_user(input, buffer, count))
+		return -EFAULT;
+
+	input[count] = '\0';
+	strim(input);
+
+	if (!strlen(input)) {
+		pr_info("config cleared\n");
+		return count;
+	}
+
+	ret = ksw_parse_config(input, ksw_config);
+	if (ret) {
+		pr_err("Failed to parse config %d\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static int kstackwatch_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s\n", ksw_config->config_str);
+	return 0;
+}
+
+static int kstackwatch_proc_open(struct inode *inode, struct file *file)
+{
+	if (atomic_cmpxchg(&config_file_busy, 0, 1))
+		return -EBUSY;
+
+	return single_open(file, kstackwatch_proc_show, NULL);
+}
+
+static int kstackwatch_proc_release(struct inode *inode, struct file *file)
+{
+	atomic_set(&config_file_busy, 0);
+	return single_release(inode, file);
+}
+
+static const struct proc_ops kstackwatch_proc_ops = {
+	.proc_open = kstackwatch_proc_open,
+	.proc_read = seq_read,
+	.proc_write = kstackwatch_proc_write,
+	.proc_lseek = seq_lseek,
+	.proc_release = kstackwatch_proc_release,
+};
+
+const struct ksw_config *ksw_get_config(void)
+{
+	return ksw_config;
+}
 static int __init kstackwatch_init(void)
 {
 	ksw_config = kzalloc(sizeof(*ksw_config), GFP_KERNEL);
 	if (!ksw_config)
 		return -ENOMEM;
 
+	if (!proc_create("kstackwatch", 0600, NULL, &kstackwatch_proc_ops)) {
+		pr_err("create proc kstackwatch fail");
+		kfree(ksw_config);
+		return -ENOMEM;
+	}
+
 	pr_info("module loaded\n");
 	return 0;
 }
 
 static void __exit kstackwatch_exit(void)
 {
+	remove_proc_entry("kstackwatch", NULL);
 	kfree(ksw_config);
 
 	pr_info("module unloaded\n");
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 7c595c5c24d1..277b192f80fa 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -35,4 +35,7 @@ struct ksw_config {
 	char config_str[MAX_CONFIG_STR_LEN];
 };
 
+// singleton, only modified in kernel.c
+const struct ksw_config *ksw_get_config(void);
+
 #endif /* _KSTACKWATCH_H */
-- 
2.43.0


