Return-Path: <linux-kernel+bounces-830443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8C7B99AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BB84C1EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15703002D1;
	Wed, 24 Sep 2025 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luijkG6O"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211623002C9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714718; cv=none; b=JCReaK5MluEsG0njbOVNhj/I69SPyOxu44J7+PRi3FJGTeRdhHJ0BO0QngNg00ufkpdp0fSx5N7CzFgtLMjuLDMufUARlRlum74+3z3fc7GM9hlrEmb5l2zWMs5I7v8QgDre+WZI3cqVkiNIiv9pqglme7KygmCpdpWA/UTjuBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714718; c=relaxed/simple;
	bh=6SekrJfJo1dIUGCCsK37DffrryW992IXbdw6n87bUwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jkqd2AN21aVXScDz4lJl7+k3mgNmL/i3kPFkmzpt6W8VtjzbGFLmo0W4TBUqrnv8/IkHKrwEusyd4tFqFwvoLPFnvKUxW6oAJt2/WKmUv1SbaqFAHa/aXcMtN9JV3AJU4PyfnNnsYiLWYHtm04wrV74uLHfU44tWHwLXUb0P0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luijkG6O; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24456ce0b96so10970455ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714716; x=1759319516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chAO9GOTMxCV8ZHg6BsIF9VuSBV9TkSRS16Il152ztM=;
        b=luijkG6OkxBdFdQCcaBX7q42Wdus5M63YlT13sDxXcLI/XAaEIs2ARoQ+eZSikmDBb
         Erqc3pRwq83PsjA+Co58bYa4umSKJypAF94IuVb6rzGVplP08VapIWoEOBfWCdxn6THL
         zka6G3Ij8Vd0vMvDeWh2aOealKFDPGzBsLWymNyi71qHp1T0dKZC+/SC86pgWdxKwkqQ
         v28vzEYT1GeSLvRCPlwUhNzpyCOQ6dR1oNHsXyR0ntCNbj/icC3Sz9guQg3EBYzJ6CxJ
         ZoBMRQKS5zXdKdIzqNWm3vfjpyquQfIHOfFBmQB/g/p3DReLav/qwmOTMqQjA00P5YVJ
         i8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714716; x=1759319516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chAO9GOTMxCV8ZHg6BsIF9VuSBV9TkSRS16Il152ztM=;
        b=X0IKeoQ+fRagPJ6wgZUet4al//san0LZiMwOtGZdJITzVShq/WxmWTWnJ9q804qqRW
         4sL3wIodcMAyw+SdfPmFz3qw9GCIER7QkJIjiaZZPNi4P288JyImziYbTdJoPDime7zT
         N8EFz5InLXYC3pZelhCRSneRh+s4ALBOQFRPlm4UDNJLvgLFlvLKSbqjiVycLZ+of9QY
         l2W9JB68uSo4krYIREd1jAyR1H4FOKfhUuQBCuEM5N7vuBjDvd0j2VrJ6m9HUY0sHrgO
         r81cWbxfBxPl8j8+GDDnqrLee5WZK3YhFs5L6ob+JGeSHeuwWPt3/u6CFSMR7fNINJsY
         cwag==
X-Forwarded-Encrypted: i=1; AJvYcCUks9AscSkTUevQ7AL4m4WjM+++9Xc3Z0JmPSX34S0i7jh9TzoYdy864eg58+C+Bnm8UuRozP7ViDidAIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4H1tYt24tiD8dwxYHjkP/3sX0K6B1b100LfqSWJn3Z4ZzM6C
	OIMN2TMQ4tfeDP8OfxsbWOhFCwk/Pj6hPyb8UlTk9aWk6Tp3M07D1wKL
X-Gm-Gg: ASbGncuyyVRav+zqtGZsWsbdxX/9sTiHF87ZBfTeBgc5xvQi3dYeec+B4DnCxazXuw/
	GVIFxTTm2PTWWtu1XoAu5iTVw4OnWzL7m7BUx833UETkhxZQL4GIKLe0Fv28Kufxjn2Lgg+Z5/Y
	D/Ce6BaZz4x4SimAK45e0W7Wnfc459okjPxflJGAO9VkRWuYR5pUvNn8UimVbHKzH4RHSTMLvJ5
	SaGxO8PBtmVrAbQCpHc/5RAEQz6559ylWTflcZNYLf4lOSxCmEa+JUB+dKiEPeZQ0O+MEhQS1IF
	wHdyDGWS4S1q4LAsIAygPsGy2VSkstx4wU55TuNU53i3pGizdoZAziOMVd80VUCnJrhBXPZLtoo
	PFHLt9wwUNcgI25SJCU5vxcdKJg==
X-Google-Smtp-Source: AGHT+IFFFBAirf0qABtQMOGn8HizILgeTQ+bDMYj/NiaLIThYCj5lgAdNhjPQRMYiuEyFN0bl+W06w==
X-Received: by 2002:a17:903:19ef:b0:27d:6cb6:f7c2 with SMTP id d9443c01a7336-27ec11ff7d5mr23462095ad.17.1758714716359;
        Wed, 24 Sep 2025 04:51:56 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980179981sm188216855ad.54.2025.09.24.04.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:51:55 -0700 (PDT)
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
Subject: [PATCH v5 06/23] mm/ksw: add singleton /proc/kstackwatch interface
Date: Wed, 24 Sep 2025 19:50:49 +0800
Message-ID: <20250924115124.194940-7-wangjinchao600@gmail.com>
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

Provide the /proc/kstackwatch file to read or update the configuration.
Only a single process can open this file at a time, enforced using atomic
config_file_busy, to prevent concurrent access.

ksw_get_config() exposes the configuration pointer as const.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c      | 77 +++++++++++++++++++++++++++++++++++-
 mm/kstackwatch/kstackwatch.h |  3 ++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 3b7009033dd4..4a06ddadd9c7 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -3,11 +3,15 @@
 
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 #include "kstackwatch.h"
 
 static struct ksw_config *ksw_config;
+static atomic_t config_file_busy = ATOMIC_INIT(0);
 
 struct param_map {
 	const char *name;       /* long name */
@@ -74,7 +78,7 @@ static int ksw_parse_param(struct ksw_config *config, const char *key,
  * - sp_offset  |so (u16) : offset from stack pointer at func_offset
  * - watch_len  |wl (u16) : watch length (1,2,4,8)
  */
-static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
+static int ksw_parse_config(char *buf, struct ksw_config *config)
 {
 	char *part, *key, *val;
 	int ret;
@@ -109,18 +113,89 @@ static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
 	return 0;
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
+	seq_printf(m, "%s\n", ksw_config->user_input);
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
+	kfree(ksw_config->func_name);
+	kfree(ksw_config->user_input);
 	kfree(ksw_config);
 
 	pr_info("module unloaded\n");
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index a7bad207f863..983125d5cf18 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -29,4 +29,7 @@ struct ksw_config {
 	char *user_input;
 };
 
+// singleton, only modified in kernel.c
+const struct ksw_config *ksw_get_config(void);
+
 #endif /* _KSTACKWATCH_H */
-- 
2.43.0


