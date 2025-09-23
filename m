Return-Path: <linux-kernel+bounces-828695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41D2B9537F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538EB3B0A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C011400E;
	Tue, 23 Sep 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWhz9Kj7"
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869ED31D393
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619211; cv=none; b=Ngmt+LM3RSWhGP/3/q1zjTlSA39j3KsnnaqXU8l9X5cpPNMVwUwS/FV7lsSdKLi5DC4unh65jxEmq+wIQNrPw5NwoMcUANy1kHe4TyZ3TVGDwvdaYK1OpAV/hpEVEMZjxvgrfvX5Q4PgOiixjzipTEZK+bzmsM7Q+18U+NUEaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619211; c=relaxed/simple;
	bh=5pnjXc/9ZbmjjTrBgjp8P0EtDaAx5Q8QwP0wZtxZOA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G772245APeU5FjbU1adjyR7+WRjq4+4uKdbK7I9CocEE7BW0Gjl7jsZOKEK/0S9VKr59kCde/Ddf+FM76KJq5J9JUcXBoEG4lW1LCgtk9KqiGxMzcqPcmNZPUNCNANeVatB7wxrMAQRUugA/KT4fSfooB9J8hB6SYHEu11mqECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWhz9Kj7; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso4609223a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619209; x=1759224009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaNfaBqm37JCuf2+6crFN8tXW1LJyt91pScqJZvXw60=;
        b=NWhz9Kj7/t9cH5P8i8XyscVK9005WZTn6fLtpu9EVBmLAdHM+8Qh2a9qFAqcfzTKMv
         QNTO0VEdjLJBxBG5AQFIZ9Elp7Zd5rDSOw8N4pmtyaTKPEf5lxmsNW1nwYF560/nb7+o
         mUuzhpfpf6Gmdt+RLIK+IydQf/zutgIRagn0Mm+2Tl+q4Bu/6kP+qXxnA+sZ91oTnwlE
         Xr+dVMX8UeLoK4PpHrX4rB77mTvjhp3MW9xC8JFqyd7l2ebSW82A7x/eXZcJhVApC4Tc
         /AbyBVmi316kV52ZEF0GYsFnMl/3NdHYVQr+QR81T5mulzsuQNjFM2iYe+KS4HVo9iHk
         YHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619209; x=1759224009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaNfaBqm37JCuf2+6crFN8tXW1LJyt91pScqJZvXw60=;
        b=wI0SRfC8FayqXY9vdV1JHkyq+UCQvaLdk5Xuh8hLrLb4yWZy8av51XUkPnZgc+a+uc
         VZcVtTMTGYEnQY23UKj9Qm8rrOscQlHjSLnerKhywphTPn5Zx/o5MG9VXk7Hf9hAvvw6
         4ohz8m2jWAN1JnEtwuzAwc+hauo71ZDnOSpdMnfUnt7iEuddRwZaTTKjc9vRtd3bTk09
         e0OUlrIAi5swAb9LQBig7y0JXMkDMSYoq94t5uuWj4ElbqjWd53y1R/9Edph6FU+F2GK
         ZmZmCcOQbp/A8D+ERE+ncg5a4hAoVMZ671ncUq3s32K5wEd4X5iksFf9v4Ggi8tyI7rB
         gcuA==
X-Forwarded-Encrypted: i=1; AJvYcCVzIfbTeJGLssYElIMX7PQNVRRHEtjO7E7dG/Sy/gVHW0zu+hmsvcmpLDtP1P9YgidgqPontoQGqXN1Xlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw318lhiaxzqpE8FFVVl0PIWdQv3SKQI9OKuaihTAatXj4KFo3w
	+W+6DMHhpN4M9Jljziv8ezv+k6hngMx47/961WVWyaoLCS+NT3BzyL1L
X-Gm-Gg: ASbGncte11G0+3YgoZJslkm9TsqRNlOwLROYttztSMRGZ8Fgq47bgEnxIN+/01JHY9R
	Qpi4uDYyTdPYDt6HZbiyl/mi9Fnz0RYRD15Eu0Y7eR9FE0gGGrH7JM9KCNfHN4atHL3DJP+hrW7
	puG17wbiloxcoBhL1bMESaxmmvWgFQ6qpJhWYAUL04HGeEsQp2Qf8QyCKsMOxotLEArgh9qoV0/
	6ANDp55pdYtLAo+CmWNWlskQvHW/RRWx+7TQPdCy4zbSqk0HRnpSgN7f8mXqCQj0w+95hLL0TUN
	7keIn7t6aiYXFXCgHSXculHnE4NQ8qco44F/UUvQrzAj8BfX7OuNDHFMf234Mwf4NVWeijLVQQJ
	egcwWWsLlvGagd2D9/sE=
X-Google-Smtp-Source: AGHT+IG3ynY4UK+SsdUVSWoFpGYbb21gaKH0sSIJYddvHUwrQq+l84afRbdI1AvvJzx7siPBXaqARg==
X-Received: by 2002:a17:90b:2243:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-332a94f538bmr2369393a91.3.1758619208557;
        Tue, 23 Sep 2025 02:20:08 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm14114941b3a.82.2025.09.23.02.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:20:08 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Date: Tue, 23 Sep 2025 17:20:01 +0800
Message-ID: <20250923092001.1087678-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, fgraph is used for the fprobe, even if we need trace the entry
only. However, the performance of ftrace is better than fgraph, and we
can use ftrace_ops for this case.

Then performance of kprobe-multi increases from 54M to 69M. Before this
commit:

  $ ./benchs/run_bench_trigger.sh kprobe-multi
  kprobe-multi   :   54.663 ± 0.493M/s

After this commit:

  $ ./benchs/run_bench_trigger.sh kprobe-multi
  kprobe-multi   :   69.447 ± 0.143M/s

Mitigation is disable during the bench testing above.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/fprobe.c | 88 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 1785fba367c9..de4ae075548d 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -292,7 +292,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 				if (node->addr != func)
 					continue;
 				fp = READ_ONCE(node->fp);
-				if (fp && !fprobe_disabled(fp))
+				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
 					fp->nmissed++;
 			}
 			return 0;
@@ -312,11 +312,11 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 		if (node->addr != func)
 			continue;
 		fp = READ_ONCE(node->fp);
-		if (!fp || fprobe_disabled(fp))
+		if (unlikely(!fp || fprobe_disabled(fp) || !fp->exit_handler))
 			continue;
 
 		data_size = fp->entry_data_size;
-		if (data_size && fp->exit_handler)
+		if (data_size)
 			data = fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
 		else
 			data = NULL;
@@ -327,7 +327,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
 
 		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
-		if (!ret && fp->exit_handler) {
+		if (!ret) {
 			int size_words = SIZE_IN_LONG(data_size);
 
 			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
@@ -384,6 +384,70 @@ static struct fgraph_ops fprobe_graph_ops = {
 };
 static int fprobe_graph_active;
 
+/* ftrace_ops backend (entry-only) */
+static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
+	struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe_hlist_node *node;
+	struct rhlist_head *head, *pos;
+	struct fprobe *fp;
+
+	guard(rcu)();
+	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
+
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (unlikely(!fp || fprobe_disabled(fp) || fp->exit_handler))
+			continue;
+		/* entry-only path: no exit_handler nor per-call data */
+		if (fprobe_shared_with_kprobes(fp))
+			__fprobe_kprobe_handler(ip, parent_ip, fp, fregs, NULL);
+		else
+			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
+	}
+}
+NOKPROBE_SYMBOL(fprobe_ftrace_entry);
+
+static struct ftrace_ops fprobe_ftrace_ops = {
+	.func	= fprobe_ftrace_entry,
+	.flags	= FTRACE_OPS_FL_SAVE_REGS,
+};
+static int fprobe_ftrace_active;
+
+static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
+{
+	int ret;
+
+	lockdep_assert_held(&fprobe_mutex);
+
+	ret = ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 0, 0);
+	if (ret)
+		return ret;
+
+	if (!fprobe_ftrace_active) {
+		ret = register_ftrace_function(&fprobe_ftrace_ops);
+		if (ret) {
+			ftrace_free_filter(&fprobe_ftrace_ops);
+			return ret;
+		}
+	}
+	fprobe_ftrace_active++;
+	return 0;
+}
+
+static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
+{
+	lockdep_assert_held(&fprobe_mutex);
+
+	fprobe_ftrace_active--;
+	if (!fprobe_ftrace_active)
+		unregister_ftrace_function(&fprobe_ftrace_ops);
+	if (num)
+		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
+}
+
 /* Add @addrs to the ftrace filter and register fgraph if needed. */
 static int fprobe_graph_add_ips(unsigned long *addrs, int num)
 {
@@ -500,9 +564,12 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
 
-	if (alist.index < alist.size && alist.index > 0)
+	if (alist.index < alist.size && alist.index > 0) {
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
+		ftrace_set_filter_ips(&fprobe_ftrace_ops,
+				      alist.addrs, alist.index, 1, 0);
+	}
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
@@ -735,7 +802,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	mutex_lock(&fprobe_mutex);
 
 	hlist_array = fp->hlist_array;
-	ret = fprobe_graph_add_ips(addrs, num);
+	if (fp->exit_handler)
+		ret = fprobe_graph_add_ips(addrs, num);
+	else
+		ret = fprobe_ftrace_add_ips(addrs, num);
+
 	if (!ret) {
 		add_fprobe_hash(fp);
 		for (i = 0; i < hlist_array->size; i++) {
@@ -831,7 +902,10 @@ int unregister_fprobe(struct fprobe *fp)
 	}
 	del_fprobe_hash(fp);
 
-	fprobe_graph_remove_ips(addrs, count);
+	if (fp->exit_handler)
+		fprobe_graph_remove_ips(addrs, count);
+	else
+		fprobe_ftrace_remove_ips(addrs, count);
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
-- 
2.51.0


