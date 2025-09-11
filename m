Return-Path: <linux-kernel+bounces-812491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D03B538D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21120B6471C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45D34F46A;
	Thu, 11 Sep 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA+Q2C1S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC025785E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607194; cv=none; b=H45y3Fouf0SbT2XZ93MCFcgYXOMbVzDA6INLF3wDbI1MKShEE0RYLi2Wu4a+gT3ErQvgorlIz0sg4EF1BXBRtdR5OOWjdAeuEFuYWakuzmtlxwhTCSmtIKU1u13OLwv2EtUPpO9J2beDFsYlpHrWTWPNmqUKx2bdLbJfVJla8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607194; c=relaxed/simple;
	bh=b2lVOXte18FZ0u7uwFHj+XjzGH++DCvhXLRMl44tWWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=uhU05eQuvGtAuyOJm2+uL9ALQnM5uRlJug5ycFPZkQAuYI3tXA66Dc0/u4a6198n74SB/fD7JpPwVw5mxikY8mIRw2aJzW+wRRYiXZDKD26qw3A9zdIBXpGyu6SFp6vidm9yPBPYGPkXaiHX2aPgf4x0qgPOhS/a2SFlTCz25f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RA+Q2C1S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757607191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6C5e6bBCCflvWYdgV0yI5JmXLKmaym9FC/faKpthf+M=;
	b=RA+Q2C1S5VeS0Z95LRG5k2ljdLst6FQpQFMhnjXa6LetGABnBkIbD0mvW7622gzoVlgnEF
	3e1jTwHK0W4WL4eyWp9bkvyp2xnSrfotCjk0CIiOvlOfLdTd99RAPBTuQzoryh4apsutgT
	NjqllJTjklQNNNhRGZZXWY+2B2mB8L4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-ErOjLuP4P7GZleFedegVaA-1; Thu,
 11 Sep 2025 12:13:08 -0400
X-MC-Unique: ErOjLuP4P7GZleFedegVaA-1
X-Mimecast-MFC-AGG-ID: ErOjLuP4P7GZleFedegVaA_1757607186
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 303481800452;
	Thu, 11 Sep 2025 16:13:06 +0000 (UTC)
Received: from pauld.com (unknown [10.22.88.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91D9C180035E;
	Thu, 11 Sep 2025 16:13:01 +0000 (UTC)
From: Phil Auld <pauld@redhat.com>
To: frederic@kernel.org
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	pauld@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tanghui20@huawei.com,
	tglx@linutronix.de,
	vincent.guittot@linaro.org,
	wangtao554@huawei.com,
	zhangqiao22@huawei.com,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] sched: Increase sched_tick_remote timeout
Date: Thu, 11 Sep 2025 12:13:00 -0400
Message-ID: <20250911161300.437944-1-pauld@redhat.com>
In-Reply-To: <aMLs5G3WvlXOAxuY@localhost.localdomain>
References: <aMLs5G3WvlXOAxuY@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Increase the sched_tick_remote WARN_ON timeout to remove false
positives due to temporarily busy HK cpus. The suggestion
was 30 seconds to catch really stuck remote tick processing
but not trigger it too easily.

Signed-off-by: Phil Auld <pauld@redhat.com>
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..ef90d358252d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5724,7 +5724,7 @@ static void sched_tick_remote(struct work_struct *work)
 				 * reasonable amount of time.
 				 */
 				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
-				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
 			}
 			curr->sched_class->task_tick(rq, curr, 0);
 
-- 
2.51.0


