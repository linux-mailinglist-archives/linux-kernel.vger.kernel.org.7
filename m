Return-Path: <linux-kernel+bounces-857489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E0BBE6F04
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62C7C4EA772
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C6A1E5215;
	Fri, 17 Oct 2025 07:31:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CE833469A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686276; cv=none; b=ToUj5CNP3bSuR5B3Gd9b4SiCrl5U8xyucJ7L0kOejrYVoChNPXQLiv8rdLH+nqEQoN+PjAm8HmysjjDbpqKGNWqBD9KCJaO/eYchFLEFrX5Xi1dPDjA3UMJnOki0gGkVkEcroUwvqbbsgLr+r346wp6ItQ6LF8LJ59IK0473E9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686276; c=relaxed/simple;
	bh=hb9jvg70Y87x5xN+5xbZCzyYwzz8VOT1HGznc77kHAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1k+m51aLCH0ylRl13VAl7H0V8YoqdKscKO+cuEyTkT7BbOZBWmHqOdVnfs8itddFq9ezepcybRRzG/MqYiExRThbFNBrlefXz4dIft8vP/TGCp26BmihJ2tI367LfTGJw9bAVoNGIlCbbTS6sgrKPJ/zmhC63yOaW4SGSLB+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E53F11595;
	Fri, 17 Oct 2025 00:31:05 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBFF73F66E;
	Fri, 17 Oct 2025 00:31:12 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] sched: Remove unused variable in mm_cid_get()
Date: Fri, 17 Oct 2025 08:30:50 +0100
Message-ID: <20251017073050.2411988-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpumask variable in mm_cid_get() has never been used, remove it.

This fixes a -Wunused-but-set-variable warning when building with
W=1.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f5d07067f60..361f9101cef9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3740,11 +3740,9 @@ static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
 			     struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	struct cpumask *cpumask;
 	int cid;
 
 	lockdep_assert_rq_held(rq);
-	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
 		mm_cid_snapshot_time(rq, mm);

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.47.0


