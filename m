Return-Path: <linux-kernel+bounces-854462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13282BDE731
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74B7134E01E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E724326D43;
	Wed, 15 Oct 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s/r6r2rZ"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD54322541
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530839; cv=none; b=J7p6NMcF+5bN5jNC9MWei+ty98R3Cs9lfExFjEvqgzehIF1d8/ups6WdbT9oS+Ytayg0YBcGG8nlpaC3cVdp4ARKAwCvlUMXmLiOiGn87hrR/x/8cWvlUhQRgEAvuJqmrJ/rVaGd87EaGQ7KtbwAC8N9RQNOMdVK2TYUit8evmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530839; c=relaxed/simple;
	bh=WlGTt3znWOuiY8APyZ6bKKme1iVZn+uffh4oy4xAiE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TwIetpvAHNc5T0QLcfwFFpFndKyyKu0Wh1r4Zs3csjV/Uo6AD1xyrjb5er2TPMSExxQJ3mR+u4nNeacrvWQy3PeE3AGLo0rKT3f+opdf0AsVKoAi+/2Qe5TzLIHp6nZb+PeFMyb8hEtp3GtzNdxkNLnDWyfh7NgJDh0cgch4MZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s/r6r2rZ; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760530827; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=16rkdxmK9NxzqaSu4ODoUDuGnFHD5WQmcoOMO7trPww=;
	b=s/r6r2rZfEKO8p+jW1nkM+GINUr3iKEUzSOxM20fETUb7TNMiIYcBAdTpCY4h+DdUVIgivxb4YYN+z238kxStB71zoimRD4q6a/V0X66gGhtVnU/8/GbFubu3zT253eb8PIqR/Lufg7ZYrzQUMgHV4oH0flc16M8EUG5pM22lAA=
Received: from localhost(mailfrom:peng_wang@linux.alibaba.com fp:SMTPD_---0WqGH8O0_1760530808 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 20:20:27 +0800
From: Peng Wang <peng_wang@linux.alibaba.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	vdavydov.dev@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Clear ->h_load_next after hierarchical load
Date: Wed, 15 Oct 2025 20:19:50 +0800
Message-Id: <bc08fcd528bad11311cd25de37962eb1ce0e7879.1760530739.git.peng_wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An invalid pointer dereference bug was reported on arm64 cpu, and has
not yet been seen on x86. A partial oops looks like:

 Call trace:
  update_cfs_rq_h_load+0x80/0xb0
  wake_affine+0x158/0x168
  select_task_rq_fair+0x364/0x3a8
  try_to_wake_up+0x154/0x648
  wake_up_q+0x68/0xd0
  futex_wake_op+0x280/0x4c8
  do_futex+0x198/0x1c0
  __arm64_sys_futex+0x11c/0x198

Link: https://lore.kernel.org/all/20251013071820.1531295-1-CruzZhao@linux.alibaba.com/

We found that the task_group corresponding to the problematic se
is not in the parent task_group’s children list, indicating that
h_load_next points to an invalid address. Consider the following
cgroup and task hierarchy:

         A
        / \
       /   \
      B     E
     / \    |
    /   \   t2
   C     D
   |     |
   t0    t1

Here follows a timing sequence that may be responsible for triggering
the problem:

CPU X                   CPU Y                   CPU Z
wakeup t0
set list A->B->C
traverse A->B->C
t0 exits
destroy C
                        wakeup t2
                        set list A->E           wakeup t1
                                                set list A->B->D
                        traverse A->B->C
                        panic

CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker memory
ordering, Y may observe A->B before it sees B->D, then in this time window,
it can traverse A->B->C and reach an invalid se.

We can avoid stale pointer accesses by clearing ->h_load_next for
earlier break.

Fixes: 685207963be9 ("sched: Move h_load calculation to task_h_load()")
Cc: <stable@vger.kernel.org>
Co-developed-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Peng Wang <peng_wang@linux.alibaba.com>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc0b7ce8a65d..da7baba35e60 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9847,6 +9847,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 	}
 
 	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
+		WRITE_ONCE(cfs_rq->h_load_next, NULL);
 		load = cfs_rq->h_load;
 		load = div64_ul(load * se->avg.load_avg,
 			cfs_rq_load_avg(cfs_rq) + 1);
-- 
2.27.0


