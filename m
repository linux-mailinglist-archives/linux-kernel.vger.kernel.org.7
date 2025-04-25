Return-Path: <linux-kernel+bounces-621156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AF5A9D4D3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 00:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F7F7B192B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0625CC5C;
	Fri, 25 Apr 2025 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2RsMfFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4665227EBF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618337; cv=none; b=CmSgu0ErG2qCo7vLxvb5C1dck4A3FQMFeNp3zMJXi3yHLx/f3ObwNjJ7BABJoQYcLisS2lQXZGrM5GXuHRBlC9beioI1RtD5hPBdoOMe4bTHFInelLe04ErzsuAePKQw6dSIx17MGSItAWSV8nkreKDJyFaX7ZwIrI+CMKsEc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618337; c=relaxed/simple;
	bh=2m1lx6718HUGj1A+Y3jL6STQpLZ234l1yOz8ZA+kREo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8kMAbVNJXDFiBvPMPTZnwOv4G7Q0yxGm65lrUOcMxk8TRep2Q38hOcmRV+KsWaKIpLpnLQzoyx7o4SSQq4lzlQar1NDpcPaPYQX057EevUZ4sNSioduciKBZoaH5tAY3suWW4Efn9DJwz6WD2YeAdVZzDV0/XqKERrkri+wK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2RsMfFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99010C4CEEC;
	Fri, 25 Apr 2025 21:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745618337;
	bh=2m1lx6718HUGj1A+Y3jL6STQpLZ234l1yOz8ZA+kREo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2RsMfFE9c1nT3dog/5yns+fWYv4zKdsC0xA8ms6dDtg98ek+2ov7E9HiGNBxkiX3
	 5xW0B5FtMSg8mdv1wT6NQRUSbX9bnbepGeaJ9Yeaquw9RdHzVevkyvaqrV+hPruLVc
	 TUYB9oc6EAc5Gu5eOA15hmF46jbk5IvT0+OzgLkNq7Z08pc+uqvguBT8KR72lPznvl
	 UBDmrVM89poi/KTY8NTS6e6jSmCxW+4SqHpXIYzv1J7JNNa7Yr9mnqEZzdAFR3/QLy
	 RjiVwz28ovjJhmTkBpOEEgvYJIk6eo+uUelH3RfrQihJ0QfWD7/p2JP6OtNM4ROFCQ
	 IE3FH/+aebRDQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/12] sched_ext: Clean up SCX_EXIT_NONE handling in scx_disable_workfn()
Date: Fri, 25 Apr 2025 11:58:27 -1000
Message-ID: <20250425215840.2334972-13-tj@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425215840.2334972-1-tj@kernel.org>
References: <20250425215840.2334972-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the global states and disable machinery moved into scx_sched,
scx_disable_workfn() can only be scheduled and run for the specific
scheduler instance. This makes it impossible for scx_disable_workfn() to see
SCX_EXIT_NONE. Turn that condition into WARN_ON_ONCE().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 06973ec6177a..a35095047c5f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4752,13 +4752,9 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	kind = atomic_read(&sch->exit_kind);
 	while (true) {
-		/*
-		 * NONE indicates that a new scx_ops has been registered since
-		 * disable was scheduled - don't kill the new ops. DONE
-		 * indicates that the ops has already been disabled.
-		 */
-		if (kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE)
+		if (kind == SCX_EXIT_DONE)	/* already disabled? */
 			return;
+		WARN_ON_ONCE(kind == SCX_EXIT_NONE);
 		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
 			break;
 	}
-- 
2.49.0


