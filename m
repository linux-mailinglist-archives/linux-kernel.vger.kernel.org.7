Return-Path: <linux-kernel+bounces-893664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0CC481C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7871427BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBF3311959;
	Mon, 10 Nov 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSIZCYhG"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20CA2F693A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792631; cv=none; b=geNNOaUC8dwzeIKkrekJg0j/WWUfMX0jUXZUY/AxQUlqkgfL0O7BlXeTY95j8Y4ldTLy8TyjQrTPpMGBhgW/RJBZYH6EwFXw4/A/KX+/ieqSvBFY6HS+A7yrRPNeIFWbwR2CGSXKvju/tSF4yuKTF9aGXV7HAdZN+9qxhIdRqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792631; c=relaxed/simple;
	bh=Ima2e4/C5WqdeZyYCnDIwbDgz9ZYOLESM4kickHutQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW8p0pyz/tATG7iDSOi+jTmZHkGTRLJ3Ilwxd/mpAmP6rjmdDs428E+bJ1GS24nHhHdiEFNxFB2PW6x/2rr3PmLZ6jbJjo90T4khorvqanHwVlprL/Drtk/weCRKwKIY7Iu4LMGVRNa2S91f2SJQm35Kbv3gi7Abn50lNiCyMHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSIZCYhG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3436a97f092so2884607a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792629; x=1763397429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDpE0CvbPiS95CD/e7bDhFl1FHfdcNhWeVLe6GjR39g=;
        b=PSIZCYhGt4Dd7vdyEl0mOkvONblClWeuS4QZ5ZGZ0MedDHaXvNpz8ADNwK6qenO/nl
         Pb/UnAJOqDscQSNuGq5DvTveWqzQNJRjZR74EfcpeSq51CYCe8HZQf1eSXkClT3lN4v5
         jDA4Uf1eMXEwoFGNz7xw5vivscquUJFUyP3J6VHHZKqUBpHtJy+DPu7PXVAYSUuoVyJP
         aB4usMrzfDrouMV5Cvutjl1EAzaR4YDI8xNeDhDMscnv5m1YQVAjiAs0jvblEGrrVfpv
         i1/D/oTtCvkXRE+Waa0EpWEcbdCvHLnzoFCbgrWsj1I31g3LKULWa5rQBUPlBE/yXd+A
         DXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792629; x=1763397429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RDpE0CvbPiS95CD/e7bDhFl1FHfdcNhWeVLe6GjR39g=;
        b=bo0vs3iGzZII8qpJ1g3xcWgKZ1jPPwLcM4Q7Tljxa4rNj8N4D1mhMuWqhfRVLItoGd
         3qxrN1RM/6RIUagqdDuDX8UKoEGslttUukB6PGM+/fpfn9VYHWtGPx3kEemp7vorNPfE
         VD5Krvziqc9ldNe3Mc4IFauCb1+M17QYxD2Vc5Cy0KioXs8uo/KkFAz1s4djbZ6bBqK7
         SmR3ELhrm8OEbzlwZF5eqEjhZPW1XAj1+wUUZo2/z2sEjY5Lk2GRbpbcuZifDF333A9s
         70eD4hWoocDvTcZMy0HJgKNmto8XhDVnp6Q6eOwfiYCvX/OHsjfq+zmMFbnIDGVWc4FG
         MV3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBzRdIuvHGKjWHAuhKLV+oeFGifySF4ndfJt8R9YQ7bziL2xuJrkZw43DwADnKl/c0qrDUCVKbhMId+IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwjQfIbcMVMud7GVhjO03ULlbvwTojnTXM7aal+14xQZgmygb
	gssINWI1MLot7Wi8KzOLlLZcmh0TH5tMKu9r3rZ3RfmjgsMqdWdTkS5L
X-Gm-Gg: ASbGnctaqDaHeWk/+VpVpxu0hvOjePrDousiM/NCVROeo/cAyc93jQqJwOuGzyc3qMS
	x4Pe7ujlKFZ+hLt2fggIY6k5yuICJmgZz/79BquFdkYm6gdlMdrCyAfYkuRHdJY043Y6k8uLKsu
	7vp52gi+ImUiHuIsbRHd6F2FISQwTsBSF0dPRHi2jSrKa7ER91NnZgUCRkEHp/aPiiDMr2ke1Rg
	yzot0yliQ6icJm1U8zbECmi/2SBOfv5CB+ylwd6IIZIOdQsoCEQ1q5YDSXOiFLxaWTquiQTX3Wn
	K3wOJBpxC6URdVVHC8cONHAuBGXLl1bHdv95lpwFdGLxmTc+9CJeABQRVEHGo240cdDOK8mKnY4
	DkkAAJaMNl8TdLAZ3u/XSg4SHEKzOh2BEB0KHqKhLOidWhSjrLDNkw6uJ5f1TxgP+e/GOZdLBGE
	dM1aZK5YbW0V7HTTSYpDunTA==
X-Google-Smtp-Source: AGHT+IHLWcFC7W3aH7MtEyBpRAAfyoGWF1TXnIybIjXPJD9gYvIPg0ozGaDjCXeoqvDbHEVRJoG18g==
X-Received: by 2002:a17:902:d481:b0:295:9b73:b15c with SMTP id d9443c01a7336-297e56f9c21mr125602655ad.42.1762792628683;
        Mon, 10 Nov 2025 08:37:08 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5ce87sm150073335ad.29.2025.11.10.08.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:08 -0800 (PST)
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
Subject: [PATCH v8 06/27] mm/ksw: add singleton debugfs interface
Date: Tue, 11 Nov 2025 00:36:01 +0800
Message-ID: <20251110163634.3686676-7-wangjinchao600@gmail.com>
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

Provide the debugfs config file to read or update the configuration.
Only a single process can open this file at a time, enforced using atomic
config_file_busy, to prevent concurrent access.

ksw_get_config() exposes the configuration pointer as const.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch.h |   3 ++
 mm/kstackwatch/kernel.c     | 103 ++++++++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/include/linux/kstackwatch.h b/include/linux/kstackwatch.h
index dd00c4c8922e..ada5ac64190c 100644
--- a/include/linux/kstackwatch.h
+++ b/include/linux/kstackwatch.h
@@ -35,4 +35,7 @@ struct ksw_config {
 	char *user_input;
 };
 
+// singleton, only modified in kernel.c
+const struct ksw_config *ksw_get_config(void);
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 50104e78cf3d..87fef139f494 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/debugfs.h>
 #include <linux/kstackwatch.h>
 #include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
+static atomic_t dbgfs_config_busy = ATOMIC_INIT(0);
 static struct ksw_config *ksw_config;
+static struct dentry *dbgfs_config;
+static struct dentry *dbgfs_dir;
 
 struct param_map {
 	const char *name;       /* long name */
@@ -76,7 +81,7 @@ static int ksw_parse_param(struct ksw_config *config, const char *key,
  * - sp_offset  |so (u16) : offset from stack pointer at func_offset
  * - watch_len  |wl (u16) : watch length (1,2,4,8)
  */
-static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
+static int ksw_parse_config(char *buf, struct ksw_config *config)
 {
 	char *part, *key, *val;
 	int ret;
@@ -111,18 +116,110 @@ static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
 	return 0;
 }
 
+static ssize_t ksw_dbgfs_read(struct file *file, char __user *buf, size_t count,
+			      loff_t *ppos)
+{
+	return simple_read_from_buffer(buf, count, ppos, ksw_config->user_input,
+		ksw_config->user_input ? strlen(ksw_config->user_input) : 0);
+}
+
+static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
+			       size_t count, loff_t *ppos)
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
+static int ksw_dbgfs_open(struct inode *inode, struct file *file)
+{
+	if (atomic_cmpxchg(&dbgfs_config_busy, 0, 1))
+		return -EBUSY;
+	return 0;
+}
+
+static int ksw_dbgfs_release(struct inode *inode, struct file *file)
+{
+	atomic_set(&dbgfs_config_busy, 0);
+	return 0;
+}
+
+static const struct file_operations kstackwatch_fops = {
+	.owner = THIS_MODULE,
+	.open = ksw_dbgfs_open,
+	.read = ksw_dbgfs_read,
+	.write = ksw_dbgfs_write,
+	.release = ksw_dbgfs_release,
+	.llseek = default_llseek,
+};
+
+const struct ksw_config *ksw_get_config(void)
+{
+	return ksw_config;
+}
+
 static int __init kstackwatch_init(void)
 {
+	int ret = 0;
+
 	ksw_config = kzalloc(sizeof(*ksw_config), GFP_KERNEL);
-	if (!ksw_config)
-		return -ENOMEM;
+	if (!ksw_config) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	dbgfs_dir = debugfs_create_dir("kstackwatch", NULL);
+	if (!dbgfs_dir) {
+		ret = -ENOMEM;
+		goto err_dir;
+	}
+
+	dbgfs_config = debugfs_create_file("config", 0600, dbgfs_dir, NULL,
+				       &kstackwatch_fops);
+	if (!dbgfs_config) {
+		ret = -ENOMEM;
+		goto err_file;
+	}
 
 	pr_info("module loaded\n");
 	return 0;
+
+err_file:
+	debugfs_remove_recursive(dbgfs_dir);
+	dbgfs_dir = NULL;
+err_dir:
+	kfree(ksw_config);
+	ksw_config = NULL;
+err_alloc:
+	return ret;
 }
 
 static void __exit kstackwatch_exit(void)
 {
+	debugfs_remove_recursive(dbgfs_dir);
+	kfree(ksw_config->func_name);
+	kfree(ksw_config->user_input);
 	kfree(ksw_config);
 
 	pr_info("module unloaded\n");
-- 
2.43.0


