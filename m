Return-Path: <linux-kernel+bounces-882329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F1AC2A331
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD497188AEF0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9B296BC4;
	Mon,  3 Nov 2025 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csO3V6h3"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF51220F5C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151683; cv=none; b=mPa8/yLW5E9s1epbF6SpQUagsbN/2ZgRGjabcnmovnBfIVYV/ZVqC1YEilQSBA314ZxOZN5I5BLdbFRAUBJ8Rt1jkMpEfmLxICkfG97kSEf8Wu2rHnSBCOefnk0DKffaUhtiBr0af4VxGv9JJndvjsn7YwuzdcBvweedV0eAEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151683; c=relaxed/simple;
	bh=l3X8/HCu2jjhNwfqprnRXqlwt8o4gif9BBGKVwAZJ08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPFxgEtdjv+Q/5i7ppSPRAZ3N76ZU03nCwzyzGRbdYrqXdRg5QvBRahI6hE5T7tW0xmqLHEtv7XtKI1s4VPATR9OQbnVKL2wlGuyIaZ6f/7LEnt52jKIpcojeavmfRBKiDvwWjADW723rsLFAhAlby5XxOmdKcyJ8Yzdkl0mqqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csO3V6h3; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34003f73a05so4578391a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762151682; x=1762756482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0cklwjYFWwcH/zJRyQ1Tmvs7zr5qVecrRqFbTLGTgg=;
        b=csO3V6h3o3x15USzxQ5voMe3noUZam+etJBf4n4K3FD9VM7PZVpmgizgDpd++bHvc+
         I3Y5ulJV0hHyiFnYDmJXYXEIGZTAsVcOqTbOGMKJDUKtwrpd1FD+8PjCK1tMDxaOzbxD
         l92/SZllYLZb5kJuBsOhG1d4TVaw7UQYnxg3HBHZqSadeT4FmWzUrE5pt719+0AHCWAx
         yIJLk8jT8iz3zfsQm3nep7Hf6nuFwiB6CaZUpG2cAOvaBtp+tJENb4vDqQnRDpk/kQDK
         T11t2gndNwgcN7lFe506tcWowAPP7qovAuJIF4AGtw1W4Dxr8cpF152W/PKIGbeJhGia
         I/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151682; x=1762756482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0cklwjYFWwcH/zJRyQ1Tmvs7zr5qVecrRqFbTLGTgg=;
        b=rzsyjNbb9JfN1x8Cp9OTATta2+7QYGQ/z+10CyySI84fetsBrAyvCJs1JP6uiW/8Bz
         B0QcCCbU3WmWGUDgumGm+jAMUR9094qJRz+abdxGujLvhJC/GMyAwI4swT1ZHPoXB1U5
         PJjxVbQtSA9S/QQa7ktgkQYr3rdmTadAWpoGptOOqEPYJjTudVMZHSav9VPpVCg7Yt6V
         IWg60rNukAFdr/2pxF/NVLE/7njbpC/nnYGpxqn9hdPeiol8g7LvNp3DFlOwZCHDkfIA
         Q5bTZsWwqjagIHEw4X1Jhm/aGrpViaeBrxPjcqmxQG0MOxGbsb4sXiqgBKbh2PbQflwD
         md6g==
X-Forwarded-Encrypted: i=1; AJvYcCUjZIw4bZAUlUOsjn8BUbH7/y5Y8U2xVoxF98GwELiHYRMisJ/osXqatW+fvvD+7I79go6vpEZVF/xRrwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAg+RKXlOurDdwFdPiQcW6zcDirxwd1CkC9CK6U7032Wq/Zlp+
	k93cwJ+UZ/mSLQaDD6BsgCxdDSxHxQ2q7LuWKWUArCOW9eE4tn/6LeR2
X-Gm-Gg: ASbGncvZxoz6/oF30eV5pLbbnHxFFfxkwHIRKBLfWyB99uM2Fmtc8MtSdNw66oBc51b
	K6CU0w2e2EFRBjknhE0KKc2D24L7es1qkdx8GHVueqvVsfqMjIBbvKdbmbLS9VdROYU9QTgNU8X
	Vpsb72AEgUmzE84nrg8G/7AOifpjB6el412f21ogHu0E2kmJRZRvSgVPzD4sSSqMZAP6Vk7CVhU
	UUaT7RzpKNK601ItTRBLmBsChRRobZWmwLOcHyd0ISDmyTuDY/5uRpUnRnEXtb+Se3g2Qtqu834
	3pgn2DfxZYwppI5XLU2hIr4RxVkBkbNg+gz8CtZK5GuVeTgmLgSAVMeVwB7bHlBkQea1XvELfs8
	JmoMz3BY/yNkobKqCi5iCyNZ3kEId2z39BZ6Y0PI4uQVIh5AKciNNnxT3007t5Eat+KaeaWGCt3
	qq
X-Google-Smtp-Source: AGHT+IGdj6Fh9qiNLzROwa+IJ6zR12Ju+TaxMNk+532E7LVd24e4IdXGR46tFBhnzHEeLr0aBGl4vA==
X-Received: by 2002:a17:90b:6cd:b0:340:e8ce:7569 with SMTP id 98e67ed59e1d1-340e8ce7685mr5427076a91.12.1762151681569;
        Sun, 02 Nov 2025 22:34:41 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ab5ee9fde6sm1777415b3a.45.2025.11.02.22.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:34:41 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	jolsa@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Mon,  3 Nov 2025 14:34:34 +0800
Message-ID: <20251103063434.47388-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we will use ftrace for the fprobe if fp->exit_handler not exists
and CONFIG_DYNAMIC_FTRACE_WITH_REGS is enabled.

However, CONFIG_DYNAMIC_FTRACE_WITH_REGS is not supported by some arch,
such as arm. What we need in the fprobe is the function arguments, so we
can use ftrace for fprobe if CONFIG_DYNAMIC_FTRACE_WITH_ARGS is enabled.

Therefore, use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_REGS or
CONFIG_DYNAMIC_FTRACE_WITH_ARGS enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- fix the build warning when CONFIG_MODULES not enabled

v2:
- remove the definition of FPROBE_USE_FTRACE
---
 kernel/trace/fprobe.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ecd623eef68b..0b1ee8e585f2 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -44,6 +44,7 @@
 static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
 static struct rhltable fprobe_ip_table;
 static DEFINE_MUTEX(fprobe_mutex);
+static struct fgraph_ops fprobe_graph_ops;
 
 static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
 {
@@ -254,7 +255,7 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
 /* ftrace_ops callback, this processes fprobes which have only entry_handler. */
 static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *ops, struct ftrace_regs *fregs)
@@ -295,7 +296,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
 
 static struct ftrace_ops fprobe_ftrace_ops = {
 	.func	= fprobe_ftrace_entry,
-	.flags	= FTRACE_OPS_FL_SAVE_REGS,
+	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
 };
 static int fprobe_ftrace_active;
 
@@ -335,6 +336,15 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 {
 	return !fp->exit_handler;
 }
+
+#ifdef CONFIG_MODULES
+static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
+			   int reset)
+{
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, remove, reset);
+}
+#endif
 #else
 static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
 {
@@ -349,7 +359,15 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 {
 	return false;
 }
+
+#ifdef CONFIG_MODULES
+static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
+			   int reset)
+{
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+}
 #endif
+#endif /* !CONFIG_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 /* fgraph_ops callback, this processes fprobes which have exit_handler. */
 static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
@@ -596,14 +614,8 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
 
-	if (alist.index > 0) {
-		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
-				      alist.addrs, alist.index, 1, 0);
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-		ftrace_set_filter_ips(&fprobe_ftrace_ops,
-				      alist.addrs, alist.index, 1, 0);
-#endif
-	}
+	if (alist.index > 0)
+		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
-- 
2.51.2


