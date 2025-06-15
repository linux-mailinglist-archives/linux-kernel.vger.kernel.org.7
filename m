Return-Path: <linux-kernel+bounces-687277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BEFADA23C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 17:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E526188E744
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82F25FA00;
	Sun, 15 Jun 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vQazZhLJ"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AC21930A
	for <linux-kernel@vger.kernel.org>; Sun, 15 Jun 2025 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749999967; cv=none; b=ZAeTau0BLgf93bPNhfAI+UR5eApHffCPpOS9bqpU/FkksI4E4fnvZ9F7VPw6cuihnWbMMaviWQW/XyTDtM/SwMFpACIvk72an4rJzis4ewvqvTrYajQgm8Gr2lYYWGB3JaszLzovb0ib6BuNwSTf9l0yNveiw/DwasfOT3Wsn28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749999967; c=relaxed/simple;
	bh=xNIUWzj16PhCwrAXHyDoUIlgH6ClK+EeYkFEw9nwUiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byzPoYvvqLRRq+/tvlRUL2J1Ves3pQXiUUVCqOQ6lp+9xRHBU9eimLo82d/UMPnDaeFCwuimXJcGh0ZK7MauYnEVUDPZEOm9NlhPjK6x2nzb9Wopf4xJ3wROr91DL38S+dW99lbqN+eMgJEBzjsHbCQ5GamAjuUrTt1qzwcY/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vQazZhLJ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749999961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnVXyo9YAc3mEYtp3xAGNvddXlHt2TT59D1agtzUoxA=;
	b=vQazZhLJpo4STKY9wkJFHJO2MiNtBKI+Y29cEkFtlRsHCC4Pye5+gYR+Qs/yQdNaq0MeM9
	ypsDz2SGYBsN41f/SqcbGbXCpu2RhVIvjo4IdCKGo8F8ryY4M4GpIoiGj3r5D9C/0uQRK/
	hJwaMy8+r/cTiaQWcQRTqFKjfJaswM8=
From: Tao Chen <chen.dylane@linux.dev>
To: song@kernel.org,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 2/2] bpf: Add show_fdinfo for kprobe_multi
Date: Sun, 15 Jun 2025 23:05:14 +0800
Message-ID: <20250615150514.418581-2-chen.dylane@linux.dev>
In-Reply-To: <20250615150514.418581-1-chen.dylane@linux.dev>
References: <20250615150514.418581-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Show kprobe_multi link info with fdinfo, the info as follows:

link_type:	kprobe_multi
link_id:	3
prog_tag:	e8225cbcc9cdffef
prog_id:	29
type:	kprobe_multi
kprobe_cnt:	8
missed:	0
func:	bpf_fentry_test1+0x0/0x20
cookie:	1
func:	bpf_fentry_test2+0x0/0x20
cookie:	7
func:	bpf_fentry_test3+0x0/0x20
cookie:	2
func:	bpf_fentry_test4+0x0/0x20
cookie:	3
func:	bpf_fentry_test5+0x0/0x20
cookie:	4
func:	bpf_fentry_test6+0x0/0x20
cookie:	5
func:	bpf_fentry_test7+0x0/0x20
cookie:	6
func:	bpf_fentry_test8+0x0/0x10
cookie:	8

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9a8ca8a8e2b..d060c61e4e4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2623,10 +2623,43 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	return err;
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_kprobe_multi_link *kmulti_link;
+	char sym[KSYM_NAME_LEN];
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+
+	seq_printf(seq,
+		   "type:\t%s\n"
+		   "kprobe_cnt:\t%u\n"
+		   "missed:\t%lu\n",
+		   kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
+					 "kprobe_multi",
+		   kmulti_link->cnt,
+		   kmulti_link->fp.nmissed);
+
+	for (int i = 0; i < kmulti_link->cnt; i++) {
+		sprint_symbol(sym, kmulti_link->addrs[i]);
+		seq_printf(seq,
+			  "func:\t%s\n"
+			  "cookie:\t%llu\n",
+			  sym,
+			  kmulti_link->cookies[i]
+			  );
+	}
+}
+#endif
+
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
 	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
 	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = bpf_kprobe_multi_show_fdinfo,
+#endif
 };
 
 static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
-- 
2.48.1


