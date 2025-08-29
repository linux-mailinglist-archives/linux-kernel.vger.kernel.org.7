Return-Path: <linux-kernel+bounces-792083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D2B3BFF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40967BD251
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F03345741;
	Fri, 29 Aug 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeY+u4yR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEB3469EC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482586; cv=none; b=FHsSyxABA8y8xC4Lg+hd0LfxqoDbTLwvj120iCA+6rYMscY4BfRTsRO9VhOiqH3rGN/zC6lzpS1OMSC2R03sOzGFza7GLQePnGxsRTtnyTJeU0HKq3hYmMMZdrUkJRADHYNgFIrrsqSdXQ9nK2DNvcUgYjwyTtik4tuuuI8vv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482586; c=relaxed/simple;
	bh=VRca4O5xWSvVtV07vu7T/vayv/vKzk4YtiAHpk59aYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxPJE1p3jc+K380OFYpnhLaFF2cBPAmEcbcGQemA3JsMbT5NxJUQ8/TAx6srDZVwYPveUEPDdvt15rt8h5vyHGtHiccVuNqRIwZ9M4LTRjv9etQ8Pq4sYvy2sQv8RJazndootcnts/5T1GhW4JhuYzYnK+29Y50ryWT4u7vnONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeY+u4yR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2141AC4CEF6;
	Fri, 29 Aug 2025 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482586;
	bh=VRca4O5xWSvVtV07vu7T/vayv/vKzk4YtiAHpk59aYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeY+u4yRCSDgJjtSz5hmOoH3x+19w/I5H1KLqf5o9IzSy4VLTHJHmCL04nCDqjl/A
	 Mi3x3LwMHRRn+lb+eRFvvD0VNC/J8aFrykShAPe2Qyw3DFCrMaXcUjLoMtmE5Zqk5v
	 KEY/GMXoPLxWzLoKGwA1a1EU0rS1reEksM2jpm33gu1U3bjqhY20oFcA7TosiH/GOV
	 rUtyYwdKFmyOcDXFLxXk7mOf6qqGFqPUlbXsYWhEPy978x01HZUHGDVX1ckPDmrT8j
	 M9m3hbV2fQHdHo0C6h2vE7P64y7inEVxIublpIAIQq2kbRtatTh4jaUoflsYZPVrL4
	 ToZ6s8NuGB8Mg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 31/33] kthread: Document kthread_affine_preferred()
Date: Fri, 29 Aug 2025 17:48:12 +0200
Message-ID: <20250829154814.47015-32-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation of this new API has been overlooked during its
introduction. Fill the gap.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f3397cf7542a..b989aeaa441a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -857,6 +857,18 @@ int kthreadd(void *unused)
 	return 0;
 }
 
+/**
+ * kthread_affine_preferred - Define a kthread's preferred affinity
+ * @p: thread created by kthread_create().
+ * @cpumask: preferred mask of CPUs (might not be online, must be possible) for @k
+ *           to run on.
+ *
+ * Similar to kthread_bind_mask() except that the affinity is not a requirement
+ * but rather a preference that can be constrained by CPU isolation or CPU hotplug.
+ * Must be called before the first wakeup of the kthread.
+ *
+ * Returns 0 if the affinity has been applied.
+ */
 int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
 {
 	struct kthread *kthread = to_kthread(p);
-- 
2.51.0


