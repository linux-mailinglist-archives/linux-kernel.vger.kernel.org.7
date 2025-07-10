Return-Path: <linux-kernel+bounces-724840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EA3AFF77B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8025A1881E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463328312D;
	Thu, 10 Jul 2025 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ubS2RqiA"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61B2F84F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117839; cv=none; b=L2IgI10xGa+xuFi8uurnMTvwb8p2AvLUjh7H9hD1MBAm1NIyhbNGIfKluSyxK2yJkRtJb0ZjDzqkfLMgeJD26VTeQwqWx+BKFzczgJmR2B5gHdG0U6Rllk3WhggN7OeYj42SHuI5IOlbtUDb7260NlmJL6FoCZT5mbY3rY9rvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117839; c=relaxed/simple;
	bh=3SJ11EoLNZfgpfhqvh0bcCy4KQwZ0bipx++KsobFXIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uODHONua5v/BAlNB3TkyqxFT0xhDUiHkO4zRX35gSIw7SGx+yDhcVDCk+BvDD09MT5pG5roZm/DcMot/vdYzKh+w2VWmvfUwH6lPpp8USOEYpaHtsEQLMo1OhR9GGZivy5hIWcqStKjygQR930ReX1UQjDgA71YEkqBjlZMxWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ubS2RqiA; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752117836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRDolkXDl9qd7+NlOBPbIynIXwkkXnjKkdrFLoT5QXo=;
	b=ubS2RqiAISMnlURYy8MU5IcxM17Ff3FmPhWksVhMaNKTAb/HPZ1EMZdOx+9F8wsQnqBzpB
	yWuPXW05mmnXg949v4mnnep8yMvv1V0UiKF3eWKEIFXY7gkKwQVJTJ8vwN11GLuH1uDR7t
	vURlBbgGxaHJkMO+Ywje9330pCvx31s=
From: Tao Chen <chen.dylane@linux.dev>
To: daniel@iogearbox.net,
	razor@blackwall.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
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
	mathieu.desnoyers@efficios.com,
	horms@kernel.org,
	willemb@google.com,
	jakub@cloudflare.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	hawk@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v4 6/7] bpf: Remove attach_type in bpf_tracing_link
Date: Thu, 10 Jul 2025 11:20:37 +0800
Message-ID: <20250710032038.888700-7-chen.dylane@linux.dev>
In-Reply-To: <20250710032038.888700-1-chen.dylane@linux.dev>
References: <20250710032038.888700-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use attach_type in bpf_link, and remove it in bpf_tracing_link.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/bpf.h  | 1 -
 kernel/bpf/syscall.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dd5070039de..976ae571522 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1784,7 +1784,6 @@ struct bpf_shim_tramp_link {
 
 struct bpf_tracing_link {
 	struct bpf_tramp_link link;
-	enum bpf_attach_type attach_type;
 	struct bpf_trampoline *trampoline;
 	struct bpf_prog *tgt_prog;
 };
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14883b3040a..bed523bf92c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3414,7 +3414,7 @@ static void bpf_tracing_link_show_fdinfo(const struct bpf_link *link,
 		   "target_obj_id:\t%u\n"
 		   "target_btf_id:\t%u\n"
 		   "cookie:\t%llu\n",
-		   tr_link->attach_type,
+		   link->attach_type,
 		   target_obj_id,
 		   target_btf_id,
 		   tr_link->link.cookie);
@@ -3426,7 +3426,7 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
 	struct bpf_tracing_link *tr_link =
 		container_of(link, struct bpf_tracing_link, link.link);
 
-	info->tracing.attach_type = tr_link->attach_type;
+	info->tracing.attach_type = link->attach_type;
 	info->tracing.cookie = tr_link->link.cookie;
 	bpf_trampoline_unpack_key(tr_link->trampoline->key,
 				  &info->tracing.target_obj_id,
@@ -3516,7 +3516,6 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
 		      &bpf_tracing_link_lops, prog, attach_type);
 
-	link->attach_type = prog->expected_attach_type;
 	link->link.cookie = bpf_cookie;
 
 	mutex_lock(&prog->aux->dst_mutex);
-- 
2.48.1


