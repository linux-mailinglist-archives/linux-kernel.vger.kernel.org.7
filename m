Return-Path: <linux-kernel+bounces-875019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AFCC18079
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A58F1A602DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22F1F790F;
	Wed, 29 Oct 2025 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faZ2750Z"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F62189906
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704124; cv=none; b=hFbFrTnDqqIgYtm7Z4hAyFnGznKT1c4n9FOWfx+3Era5iI6sTlHmwedvszW246JP0kUipGXLbD9PEbI2eWD47EULteMi7tIIRLZj0MEDdLNmzQUEGLbjQEbIJmFsBVOfqLq4d66VgOKxfTYVd5JtUSnl9wiGWODuiNzLgMSxmxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704124; c=relaxed/simple;
	bh=CEvAhyPYCG+T++r8yJdAAsbzjdXegc+nM5rNng/jC1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ftpnn06ZwMfJ7FPl1+WPKYIKI6X5k0SSxuisyZqOHm0IAfKDUxHJ+NUNDJ39Z+7V45yMWlrwOFhawCwJZgK9Ppg97SPj7dSZj7g22fxoksl8U6AiUT8tkp5Rm1/tlkmHh/ZOTYd49zemR/96Ts0X8XgOpaoTk0fuXnt2uidwriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faZ2750Z; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7a4176547bfso3608958b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704121; x=1762308921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ktlh/43BHkPq4CFdjDK0hsgcK6sJG2dQbSUlBR4d9/E=;
        b=faZ2750Zrl+eNv3NGWVEaGwepo6Zkz4kH2odDlkpwNMF9pJDYkx3DC666E4WWeCqY7
         CMzxrs00jWOJyeoYLi5SlTpjAw+ji2QH0SiG2YkfjGM5IbA/fdC68WORkSRRbQINHPRd
         JRzOek2lFeRKJgWRwBtGEGQ2mrrQOjrv25NDjWEVn8VzKGEjIzM6QDKV/IrJc0YkAOAS
         jC5TALIDom5EX54a/hrkHf0s1dUvL7YyrFcFMmL+rH45AxnSB47LwgSJg2pi/uW2RsIC
         Zf8Ue7ZWRrz3v5FVHUBBe3KMLI3FUAy++EDIHou9a8zcXqS5Da6IsMD1vfgLmAbl0ZIE
         pL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704121; x=1762308921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ktlh/43BHkPq4CFdjDK0hsgcK6sJG2dQbSUlBR4d9/E=;
        b=frpPg2gYz6q9eukpkdkuxYFIgTUIvVGeK2zJirxcPeYuS6DdJVD2DIPxnTSmdTChVD
         4cy8lvZQ5fZRlIzBBkFubJGPrSSNHbkLa4kMHmrOpvZBZS5u16d0xiCN3I3Dv8FIP4L9
         8vKuZe7BBcA4NhqZPqRgO4FVopg4Ao5MP7Yy9N6M8GUmwEFncR+ahUZcce5mopBJKz63
         BmGct2uj7jf1JhXwA9miyfHnhx/7TNY9RU7ZqneMa08IJjhqB0Kr18+I0c4zxaqpF3FK
         2GAIoCUcpXCKU7Dxc6Ex/4T5VoOh5KTWODQKb141DMjukg5pFlrXGi0b1H9FeOC4xaNM
         0bVg==
X-Forwarded-Encrypted: i=1; AJvYcCWaw2HwgI4Rjq3NGec2XhsJS4kJPuUerULiIcoLe5fOx37N20Scgmjhd0dryBmp5ClYSiLBC0pSuGPUoqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFiyv5+elz03msKlWnBch2bfAUQMAgahp6U1NEO7HHmWZbieLm
	ck90wDMvyzSbR9tB/SzGoTBXMRJO2fLMwy0VU4j1nqeIdACT9V2udRDb
X-Gm-Gg: ASbGncvP7NmaxRJ3kT3o/MY7AevmaDWqIfHnn39aQmhYoScR3c6LVE9rBkCEyCL97Tc
	sV8M3pI0v7Jc16S7sggOPSTsF41MOCdFVyktj0trekN/Rh+7vZoJ7Nl5f7Jwt8odRBh2o51sgpA
	TkA1n/f/vIwX+9O7a9FBGP4sAx7cAMCEl5bQn3me0ak7rVEqUqlaA9eKgHXN5UziJOb5YFbFvYd
	oeKzn2esS3NN2kMV7d+v389CSb6VQo4iJSvHFtG8aFRjTJMQnbKYimZVjypBHk32QXc35qTwtUo
	568ZT7d2wOO5S1YFE3VpuivPNJxtIQOkV6/B91q4Mm1Rhzd5UUwCc1ZHPlOABljUNxmyYWqiAlz
	+XoXrxLaRgZjAtTVVV2q7zeqIZteOwxyv1ZqVifEYyjqMq76dh7qtEw3SDpjMJIm+9Muz47LfYY
	vl
X-Google-Smtp-Source: AGHT+IH/g79Ujfibd+JTMvUkBpYFAQJiqZkOLBJGhObxS6FSqfhAX6RVRxRENNGWr6hg43128FBG8Q==
X-Received: by 2002:a05:6a20:7d8b:b0:344:a607:5548 with SMTP id adf61e73a8af0-346558e31a1mr1592301637.58.1761704120749;
        Tue, 28 Oct 2025 19:15:20 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712d024aaasm12124442a12.26.2025.10.28.19.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:15:20 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	jolsa@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Wed, 29 Oct 2025 10:15:14 +0800
Message-ID: <20251029021514.25076-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1
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
 kernel/trace/fprobe.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ecd623eef68b..9fad0569f521 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -254,7 +254,11 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+#define FPROBE_USE_FTRACE
+#endif
+
+#ifdef FPROBE_USE_FTRACE
 /* ftrace_ops callback, this processes fprobes which have only entry_handler. */
 static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *ops, struct ftrace_regs *fregs)
@@ -295,7 +299,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
 
 static struct ftrace_ops fprobe_ftrace_ops = {
 	.func	= fprobe_ftrace_entry,
-	.flags	= FTRACE_OPS_FL_SAVE_REGS,
+	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
 };
 static int fprobe_ftrace_active;
 
@@ -349,7 +353,7 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 {
 	return false;
 }
-#endif
+#endif /* !FPROBE_USE_FTRACE */
 
 /* fgraph_ops callback, this processes fprobes which have exit_handler. */
 static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
@@ -599,7 +603,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	if (alist.index > 0) {
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef FPROBE_USE_FTRACE
 		ftrace_set_filter_ips(&fprobe_ftrace_ops,
 				      alist.addrs, alist.index, 1, 0);
 #endif
-- 
2.51.1


