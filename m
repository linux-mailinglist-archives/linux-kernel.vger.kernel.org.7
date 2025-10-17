Return-Path: <linux-kernel+bounces-857381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7251FBE6A47
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 400184F38D8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D530C37E;
	Fri, 17 Oct 2025 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="M9nlVNFG"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AB81720
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682260; cv=none; b=EedBvRCbMZwrf9yxYQ0gkcL0SOgu2ZgyOpQZ5t9G2KnQAVJwuPw1zNPJ33yTg2pVROz1Yn5CDl1od/70c6mRm83r0px5UndsQrbZjvrhfQA4MrtlyFKqpXQBRFhgIrxZy2s5q8o/J3EQLlFyZydg+sE5BOP529F36wHXiWuPEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682260; c=relaxed/simple;
	bh=dCNbnzZaGTURzQcRM5MdxD+kKtITjSXEMqUN6a+7kTw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=U+6r9izXrKgnpJNPsTLiAzpmt3gMY9PyLrlZ1eu6TEyeYzbU/8gG2JdvRlgi6W8Ye16dHoAnzvEiDfL+ZsljcgAfMANOWUCt5yrpXUFpOWsXSyjcUg9FHtvGnRaQmeh9zl+LNNHOD902RT5tnmYr4vZYk/Ct5WgfHCtqIo+8ucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=M9nlVNFG; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=9pnnaQM5xSMrFsb
	0p+f4Y36hC8nYEX7zRftyen+UAt8=; b=M9nlVNFGZ3n9YlOp/CtMMUmgH7RwSfN
	Ky9LcFiJlM3szc2MPCTMmWEXC3N4idviHF9FWMs01+iim0x8Th2sjE8Oq569fEzN
	oXbuoic+NBqk9Dl5A6tY8z5VNVYTMYmoqUBXpVM7PoFzrY3DzZTszdyaVl1tXUkH
	fmyXHCKpEh2A=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3dwhv4PFoULOHAA--.1374S2;
	Fri, 17 Oct 2025 14:21:46 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] sched: Fix assignment in if condition in wait_task_inactive
Date: Fri, 17 Oct 2025 14:21:33 +0800
Message-Id: <20251017062133.48118-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:QCkvCgD3dwhv4PFoULOHAA--.1374S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1rZw18XFy7AF43Zr13urg_yoWDXrg_Aw
	1UXF109w4Fyr9rZFWfXr4xWw1rt3yFyFy8uFs7ZFy8Xry0yrZ8XwsYvFyakw1fXasYvFy2
	g3ZxWayDKwnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKfHjUUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiihXpxWjxnXGMeAABsz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix checkpatch.pl ERROR: "do not use assignment in if condition"

The code in wait_task_inactive() had an assignment inside an if condition,
which violates the kernel coding style. This patch separates the assignment
from the conditional check for better readability and maintainability.

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 198d2dd45..2dae4cd53 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2305,7 +2305,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if ((match = __task_state_match(p, match_state))) {
+		match = __task_state_match(p, match_state);
+		if (match) {
 			/*
 			 * When matching on p->saved_state, consider this task
 			 * still queued so it will wait.
-- 
2.17.1


