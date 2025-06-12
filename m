Return-Path: <linux-kernel+bounces-683600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F2AD6F98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 13:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE00189D5DB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AEE22F76C;
	Thu, 12 Jun 2025 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pBs3pgyV"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202A22B8BD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729390; cv=none; b=gOigmwXgLKFdSr8vFg6QwPlhbemheeadPAqPImQ/USLmunSq1WgtU0axaokKpXnmtWU4oPwBumXjieHs1OROh7IHstFG4RpSCfStdxaebN7nslfgrofWTJ2hMqqtpY271z3P5bf5OR7Pb+Bl0SE3m5X21bmpiWXAOVhJY9Ak/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729390; c=relaxed/simple;
	bh=lfBOzGo2w8TegsMN/okVNt545ojtH3LSDwiGDmOvrfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ba/aXinoH6s2BIZ4pyD2Li9CSF8hLM+c2krBp9WgWIEmDwMLVLIULthmAiY908SgIiSUAdIuMw8rQ1Uvua272A+JgvDgQLLr84OT0wC2ds3hNjfGZ8B1tgjdOiVIWTGC/AUGLElkdFeublimOAsX/QisGkoe8MmnDyg1qO0vEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pBs3pgyV; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749729377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yeGanY3faZzIQt7AidE+BWD380NKCiKNmhDjjFNsWXI=;
	b=pBs3pgyV7Xmupm+7PGjCdm5eKZKavVrCWgEbrcURfG1FCbli8HyRJuh/IWwSZrPtBwn1nW
	qmMpLnSy3NW9/ogNQOph0nBlIKOVgmvxKR7oEwQfS6nE2TVFT4PKiZgD/R1bUHPPaOmOuY
	ENKGIqj8gb5S4PgxfnapLncfGmgeiXc=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 1/2] bpf: Add show_fdinfo for uprobe_multi
Date: Thu, 12 Jun 2025 19:55:55 +0800
Message-ID: <20250612115556.295103-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Show uprobe_multi link info with fdinfo, the info as follows:

link_type:	uprobe_multi
link_id:	9
prog_tag:	e729f789e34a8eca
prog_id:	39
type:	uprobe_multi
func_cnt:	3
pid:	0
path:	/home/dylane/bpf/tools/testing/selftests/bpf/test_progs
offset:	0xa69ed7
ref_ctr_offset:	0x0
cookie:	3
offset:	0xa69ee2
ref_ctr_offset:	0x0
cookie:	1
offset:	0xa69eed
ref_ctr_offset:	0x0
cookie:	2

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 24b94870b50..c4ad82b8fd8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3157,10 +3157,58 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	return err;
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_uprobe_multi_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_uprobe_multi_link *umulti_link;
+	char *p, *buf;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
+
+	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	p = d_path(&umulti_link->path, buf, PATH_MAX);
+	if (IS_ERR(p)) {
+		kfree(buf);
+		return;
+	}
+
+	seq_printf(seq,
+		   "type:\t%s\n"
+		   "func_cnt:\t%u\n"
+		   "pid:\t%u\n"
+		   "path:\t%s\n",
+		   umulti_link->flags == BPF_F_UPROBE_MULTI_RETURN ?
+					 "uretprobe_multi" : "uprobe_multi",
+		   umulti_link->cnt,
+		   umulti_link->task ? task_pid_nr_ns(umulti_link->task,
+			   task_active_pid_ns(current)) : 0,
+		   p);
+
+	for (int i = 0; i < umulti_link->cnt; i++) {
+		seq_printf(seq,
+			   "offset:\t%#llx\n"
+			   "ref_ctr_offset:\t%#lx\n"
+			   "cookie:\t%llu\n",
+			   umulti_link->uprobes[i].offset,
+			   umulti_link->uprobes[i].ref_ctr_offset,
+			   umulti_link->uprobes[i].cookie);
+	}
+
+	kfree(buf);
+}
+#endif
+
 static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 	.release = bpf_uprobe_multi_link_release,
 	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
 	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = bpf_uprobe_multi_show_fdinfo,
+#endif
 };
 
 static int uprobe_prog_run(struct bpf_uprobe *uprobe,
-- 
2.48.1


