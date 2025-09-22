Return-Path: <linux-kernel+bounces-826507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4715B8EB22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E783B39DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F361C7D098;
	Mon, 22 Sep 2025 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8e5Ejvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484FCDF59;
	Mon, 22 Sep 2025 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504768; cv=none; b=MR/9q7v5Cm/MaqmqxeRMqtRL11ykF0WSfHJ43SX16YTJ9ogOwxtRhw+OSMKVnydNR12ihBtaiW2utQToiH1XSVqI4iutg2BnGKQDG/QuHjIAzo6RjAH9F/ypQlrLny+rAUlG2fCFCdPDSGHTKSxfYWCtj/+Ek5haZQS3PbIyZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504768; c=relaxed/simple;
	bh=uxjzFijAGUqRJoJXtzBFbfoa3JxlkIJaaNsClV+5oUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljn04MMZlcIXAkNshDSQNjrqYjVZZ/OurEbq9P9viQW3Mb5qaSVgLtSDKbFga6YZ6FG4Y9Qelj0+tfIkfeYmgNsC7O+cvwDk/iQz19lPuVkkOzXtkBiFxTbMHfnwnk6tezVBZFKYTDPn0iYIlp8QYKC8o1pTY9qqSHkumpv0hqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8e5Ejvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A846DC4CEE7;
	Mon, 22 Sep 2025 01:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758504767;
	bh=uxjzFijAGUqRJoJXtzBFbfoa3JxlkIJaaNsClV+5oUM=;
	h=From:To:Cc:Subject:Date:From;
	b=c8e5EjvtNHOttZJGdG4m7ixWYvMqWXPjJydQyusD3JW7JWxb5GV9biTaL3RC+zlAB
	 RJaITzxuVmuUfDMe24GDKUTVxV7jPsH9JcsYhdf9fxooov/Nn/nNwYWMqPbZl1j2gA
	 T/JwrpJ/p5dkvH82i6qb6zNdH55EAasr5K9d4jJoSadbnLjDHQzZUP85KPhJJDnRAf
	 FuLNSad809mtmnOcinUkF5hje3hAxsVgXgZNpN9lwixFaisdw28VSz6tA0JXKJDU8L
	 1rL/0xoGcai4KpX9vuPQ240xvbRlxv2iMvfE9tvfPEXOfnnK253gpInpLRaVe/vg9y
	 eiPTCGDge5aEw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of rhashtable_lookup_fast()
Date: Sun, 21 Sep 2025 15:32:40 -1000
Message-ID: <20250922013246.275031-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The find_user_dsq() function is called from contexts that are already
under RCU read lock protection. Switch from rhashtable_lookup_fast() to
rhashtable_lookup() to avoid redundant RCU locking.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f5873f8ed669..df433f6fab4b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -207,7 +207,7 @@ static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
 
 static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
 {
-	return rhashtable_lookup_fast(&sch->dsq_hash, &dsq_id, dsq_hash_params);
+	return rhashtable_lookup(&sch->dsq_hash, &dsq_id, dsq_hash_params);
 }
 
 /*
-- 
2.51.0


