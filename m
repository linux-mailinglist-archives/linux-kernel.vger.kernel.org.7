Return-Path: <linux-kernel+bounces-833753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7D4BA2F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED27188624F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AE6286D46;
	Fri, 26 Sep 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="afG1mFvG"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11E291C1E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875735; cv=none; b=tIMhznj+1Jgu7+8V0qCxDaRPfy9Xv6us2eh/2lGqd/uImyhHwgq9t4UtumDcZ3ZvVZjd75n9j56tnXf+kZEKFSLLbsWbLkEo8l7t+/XdNO1ci8De/em3GNJjxZB2UtZKgCv9Ng94K+1AFmNe4UC4HHL+waIiIn0HtBiVZcCVFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875735; c=relaxed/simple;
	bh=Ed56HJ9zlcZmsRvDKPtUHTDa7tOaqwU8ZB28/nacD5M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Vt7v75onfcPLiuddyRmIsL6FyB/8c6mfLGDD/VVh+JFUZ7f/s1pdZnHxBrOOeNpdkgAIFqLWwGAB22y98YFjogAbXjln6bjOf95Wr5TJ5OjUDM0vajNmFGYDJsJHziAph9qxudyM+vEys8w7MjVtZrsrwyFl4Q5GsOu7iVv2xD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=afG1mFvG; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758875730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=RBR1vHVyS7n1Bb+cHaUm5Gqd5AP1AMXPgLw7+rsyya8=;
	b=afG1mFvGrHoOhHZxM7/BCtEb6I7arzi+RAw9L9BsMB/Uv5O37AQNAB3vrwELOuugRotTXL
	SVc2htN87FoHLXOO+PsVtWGcljihIpj3LINsGTQx+zfc5gqNw1ZFX+r8RXQ0u/nUEqVEu9
	1ru+regWNfT/e+1y3WyCr5mnKCGXyzE=
From: Zqiang <qiang.zhang@linux.dev>
To: edumazet@google.com,
	jlayton@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] ref_tracker: Handling kmalloc() allocation failure in __ref_tracker_dir_pr_ostream()
Date: Fri, 26 Sep 2025 16:35:25 +0800
Message-Id: <20250926083525.13500-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kmalloc() maybe fail to allocate, causing sbuf to be null. this
commit therefore free stats memory and exit function when the sbuf
is null.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 lib/ref_tracker.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index a9e6ffcff04b..a822de2b691e 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -160,6 +160,8 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 	}
 
 	sbuf = kmalloc(STACK_BUF_SIZE, GFP_NOWAIT | __GFP_NOWARN);
+	if (!sbuf)
+		goto end;
 
 	for (i = 0, skipped = stats->total; i < stats->count; ++i) {
 		stack = stats->stacks[i].stack_handle;
@@ -176,7 +178,7 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 			   s->prefix, dir->class, dir, skipped, stats->total);
 
 	kfree(sbuf);
-
+end:
 	kfree(stats);
 }
 
-- 
2.17.1


