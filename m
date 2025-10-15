Return-Path: <linux-kernel+bounces-854055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE0BDD6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5173F354455
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670A306B11;
	Wed, 15 Oct 2025 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXZvIqwY"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06E305061
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517170; cv=none; b=q3eWds7/SXF12N2zxg9Ih35y5KFAZwBqV3E9P4f032edY5QFUmZ5CFjIRnT5SzvqZv3x5FN07U8hr7d7q2jTtml89tCzs6HgdRK/awAOXU0Uu2t9L8jVubzj3tMt1IU+sQ7LoftFFa6FclVoZGtYaeYXglFwVeEeHmcArgPgdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517170; c=relaxed/simple;
	bh=K7p6UhWLDRfKZT2gAOrP7MNUFUmEeyqKtxB0zO9luS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1vhxBzsNexHQEqGMyPnJAXrNOlosvoYcRLlblF6pMlzgS5yOEe/1VVi1ByqRmYkgz9x80Cq58wyk3+MT60EIqDrzP+GUpZthCS1u08RxqeIkei1lgl/PHqK6o1ulM0ZpfTYhpCizs9VnGuyhArT4eY3BvD/68ehPj3jXXHZLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXZvIqwY; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-791c287c10dso5291041b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760517167; x=1761121967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te5eI+fh3hZ8vEBMN4EQiUZ0pMD+A28Xmwyz5U4lckA=;
        b=BXZvIqwYEJH0s5kHf6GOSh4pVqz1Aa0aUeq62GgzPE7A2b6uuNkx6PVVvkTZQlC1JL
         CfocRoUgsAtbQ2ga7J5cSDBFXa2PJeMoRjUpduRDaFJZhLKA4x2hx3kl7eS03yXgX/2X
         rPr0S/UzWmIUGEemHSkdlEqzHl15z+dgn3VDK5Vc2KOCsch2M2CVHP82Gsetw+ex2c2d
         f5/yykAfsbag5Pc9q2/698os0fK8ZOstm9mrc8xjD3elolUHM9JJfI2+L4psRLRfURSE
         KVTCR+7sB/lc89/AsFQhmnBwjRmnTwDMrlGD8geh1qMS78dWRrb9CX2Bns0jIl3eDsGc
         Nq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517167; x=1761121967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te5eI+fh3hZ8vEBMN4EQiUZ0pMD+A28Xmwyz5U4lckA=;
        b=mrUjwl1jhOKZOEw9wrz7kx7qPfLcQ75hrxLAE6JIkD3xDriYfxDeseVfaU6uuMC0Vj
         qnZcfQ+N5ccH2CZTT0QJQuOi//lBjgoHvD1N2bTU56hTmyaBNa8uQW1Ff2gfCQD6rYwt
         tP2o9JQfg+yiTGd3eGLgdwlVEquDhk8owSKOmmkv/Vu5CwBgenn76NmCCIj6KX7A22hK
         Eaq3vBG3OvwaIsHi0gd1lI4NSzPNgHbdgrnyMGialqjYQQC/HWx7dmt91cJuTAhMB6xh
         T5wgKGukTnVOsHZ592mglErCCe2VkMiEPEj8SDFo+fqn0NOM1F4dSl/3oVxM5g1NrwzM
         lkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcOBaUMJ9hxy0oQca7kQf3VrTNTYWak1pygMB35Vl9uAHo/hQT5VH2fgRE5Py6ME9JLJs0NpK4pjQCHMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznB5drjvC/V3qu/ipPJoiZvYrjMYlCGC9dNv4ZSLOHH+F9QwKo
	+Oa/BLAp91msqyPBqT6eH7BbJmFtKVL7fLK57LZoGezQvSlxSK8xqVDV
X-Gm-Gg: ASbGncvM0eXB2StLwGKRZa/nCHKWc9TTWw4Zrr7+99cqrUx1HtOR8yVbHsVc3T/Pqx+
	iFNP+TmiRGXY4DISMV0amyzw1DqrCuPcZdIuiCcmVsQ9lwUHa19c2g/ujrjUWmgQQSsSJgDZ39Q
	tiw5VnWjUqgZR1PP0d5JFbjMC3NqTJ3mFRzUzcYiMmGQDYjZJ5bjDFbjd6Rc1oRFdpoSXF8f1Z+
	+B6DZV41CfCe5lZ9H/LzXpiic4Z86e2ceJtT5REjfFxl0f1buO9dcn6gBkOKizjrXgOYM9b9MJA
	t81e+tFHH4v2FkDFWQ7tkXiPJ/ZNGALlutcoRWiHxZ4ACshA5DFD5EtC6qWzcsb6jPb1C/MPa2m
	m5LMXGak2x63pHn2JwDIzkftOvROxVVzgsJjuJe/dQaAHscDxOIMu
X-Google-Smtp-Source: AGHT+IFtyahH715Ez7HcycJ7972WoW2MVWw6sJis7+N0dA6wa5rXuDxh5CHRyvbCK5UYHcZBqvtpgQ==
X-Received: by 2002:a17:902:fc87:b0:28a:8ae7:4034 with SMTP id d9443c01a7336-2902725eda4mr336705755ad.25.1760517166511;
        Wed, 15 Oct 2025 01:32:46 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35e62sm188932455ad.88.2025.10.15.01.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:32:46 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] tracing: fprobe: optimization for entry only case
Date: Wed, 15 Oct 2025 16:32:37 +0800
Message-ID: <20251015083238.2374294-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015083238.2374294-1-dongml2@chinatelecom.cn>
References: <20251015083238.2374294-1-dongml2@chinatelecom.cn>
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
v4:
- fallback to fgraph if FTRACE_OPS_FL_SAVE_REGS not supported

v3:
- add some comment to the rcu_read_lock() in fprobe_ftrace_entry()

v2:
- add some document for fprobe_fgraph_entry as Masami suggested
- merge the rename of fprobe_entry into current patch
- use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
---
 kernel/trace/fprobe.c | 128 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 119 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 99d83c08b9e2..ecd623eef68b 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -254,8 +254,106 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
-			struct ftrace_regs *fregs)
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+/* ftrace_ops callback, this processes fprobes which have only entry_handler. */
+static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
+	struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe_hlist_node *node;
+	struct rhlist_head *head, *pos;
+	struct fprobe *fp;
+	int bit;
+
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0)
+		return;
+
+	/*
+	 * ftrace_test_recursion_trylock() disables preemption, but
+	 * rhltable_lookup() checks whether rcu_read_lcok is held.
+	 * So we take rcu_read_lock() here.
+	 */
+	rcu_read_lock();
+	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
+
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (unlikely(!fp || fprobe_disabled(fp) || fp->exit_handler))
+			continue;
+
+		if (fprobe_shared_with_kprobes(fp))
+			__fprobe_kprobe_handler(ip, parent_ip, fp, fregs, NULL);
+		else
+			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
+	}
+	rcu_read_unlock();
+	ftrace_test_recursion_unlock(bit);
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
+static bool fprobe_is_ftrace(struct fprobe *fp)
+{
+	return !fp->exit_handler;
+}
+#else
+static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
+{
+	return -ENOENT;
+}
+
+static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
+{
+}
+
+static bool fprobe_is_ftrace(struct fprobe *fp)
+{
+	return false;
+}
+#endif
+
+/* fgraph_ops callback, this processes fprobes which have exit_handler. */
+static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
@@ -292,7 +390,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 				if (node->addr != func)
 					continue;
 				fp = READ_ONCE(node->fp);
-				if (fp && !fprobe_disabled(fp))
+				if (fp && !fprobe_disabled(fp) && !fprobe_is_ftrace(fp))
 					fp->nmissed++;
 			}
 			return 0;
@@ -312,7 +410,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		if (node->addr != func)
 			continue;
 		fp = READ_ONCE(node->fp);
-		if (!fp || fprobe_disabled(fp))
+		if (unlikely(!fp || fprobe_disabled(fp) || fprobe_is_ftrace(fp)))
 			continue;
 
 		data_size = fp->entry_data_size;
@@ -340,7 +438,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-NOKPROBE_SYMBOL(fprobe_entry);
+NOKPROBE_SYMBOL(fprobe_fgraph_entry);
 
 static void fprobe_return(struct ftrace_graph_ret *trace,
 			  struct fgraph_ops *gops,
@@ -379,7 +477,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 NOKPROBE_SYMBOL(fprobe_return);
 
 static struct fgraph_ops fprobe_graph_ops = {
-	.entryfunc	= fprobe_entry,
+	.entryfunc	= fprobe_fgraph_entry,
 	.retfunc	= fprobe_return,
 };
 static int fprobe_graph_active;
@@ -498,9 +596,14 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
 
-	if (alist.index > 0)
+	if (alist.index > 0) {
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+		ftrace_set_filter_ips(&fprobe_ftrace_ops,
+				      alist.addrs, alist.index, 1, 0);
+#endif
+	}
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
@@ -733,7 +836,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	mutex_lock(&fprobe_mutex);
 
 	hlist_array = fp->hlist_array;
-	ret = fprobe_graph_add_ips(addrs, num);
+	if (fprobe_is_ftrace(fp))
+		ret = fprobe_ftrace_add_ips(addrs, num);
+	else
+		ret = fprobe_graph_add_ips(addrs, num);
+
 	if (!ret) {
 		add_fprobe_hash(fp);
 		for (i = 0; i < hlist_array->size; i++) {
@@ -829,7 +936,10 @@ int unregister_fprobe(struct fprobe *fp)
 	}
 	del_fprobe_hash(fp);
 
-	fprobe_graph_remove_ips(addrs, count);
+	if (fprobe_is_ftrace(fp))
+		fprobe_ftrace_remove_ips(addrs, count);
+	else
+		fprobe_graph_remove_ips(addrs, count);
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
-- 
2.51.0


