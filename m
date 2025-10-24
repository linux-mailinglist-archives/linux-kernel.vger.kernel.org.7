Return-Path: <linux-kernel+bounces-868919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08DEC06823
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7B73BF6B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D08831D36F;
	Fri, 24 Oct 2025 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q82RxeHx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7388320A1A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312362; cv=none; b=qdw0TFGyqAYsRxaNCOvRbVPZvTxuMEDxs5U9WNwOo6QYGxKmIme7lmV/RNw9MiquM/id4l/m2Tlp08A+UJRnC25GRfmUMKDV8T7AfJhRo6DOmAMS2Z8QRsHj/a8cBQzr/cbjmAhNTvMzJ2zXj9hoREQnOfgRxksnerA+ZwMUe/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312362; c=relaxed/simple;
	bh=lNiRZwtesmiFcKiHJWflQehWlUXukBZMLmjaD5n1mCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIqqgxA0nQBpCj59UA/RyrlNdxD8MYZf+3Ygixh1AHsbgjjqVKTOGLGZUCtvXBxsBkxHaLZTCM/8r4cOBYzhpU9bV6wUvvd1lCjyCT8DQcZM8riLeW6pxnUxxMfCalqnl6gg0JcKK7h2/phdW13ZPdbXF8ctrTFmbN9sh8l7Vwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q82RxeHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D59C4CEF1;
	Fri, 24 Oct 2025 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312361;
	bh=lNiRZwtesmiFcKiHJWflQehWlUXukBZMLmjaD5n1mCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q82RxeHxgjGxZWN16Dqhqw/nHK0LGV9qYpFai9Snpj6Z82SWY8dNfkYrhAr0qYOHe
	 EGJ/5BfIJeKWfP3o5QXsLmkN2QAZuh2jHplSheGpTZu8uYy/S3dO+DwMiUvsELQzbn
	 1zwnYi+oNPbiN31KfMi2KwoBLgk/enZ2YgBbFL7xzw+ybt8QCSFh8ZOmpuT+kp8K6g
	 2iC1Kcc4HgiBeT8jjb+vTf+UebadGw9+EWnxkl5vmPYHHol+LOPhuIvmBMBpiKgDKe
	 Yo34K00ptfSK3SSyGL3oGQgjLhDvWtV3RgwdCH0ZDSh3FJo3YCLRL4scxbCrNa2aT5
	 jLvNh8PSFzyPw==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 6/6] timers/migration: Remove dead code handling idle CPU checking for remote timers
Date: Fri, 24 Oct 2025 15:25:36 +0200
Message-ID: <20251024132536.39841-7-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024132536.39841-1-frederic@kernel.org>
References: <20251024132536.39841-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Idle migrators don't walk the whole tree in order to find out if there
are timers to migrate because they recorded the next deadline to be
verified within a single check in tmigr_requires_handle_remote().

Remove the related dead code and data.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 73d9b0648116..19ddfa96b9df 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -504,11 +504,6 @@ static bool tmigr_check_lonely(struct tmigr_group *group)
  * @now:		timer base monotonic
  * @check:		is set if there is the need to handle remote timers;
  *			required in tmigr_requires_handle_remote() only
- * @tmc_active:		this flag indicates, whether the CPU which triggers
- *			the hierarchy walk is !idle in the timer migration
- *			hierarchy. When the CPU is idle and the whole hierarchy is
- *			idle, only the first event of the top level has to be
- *			considered.
  */
 struct tmigr_walk {
 	u64			nextexp;
@@ -519,7 +514,6 @@ struct tmigr_walk {
 	unsigned long		basej;
 	u64			now;
 	bool			check;
-	bool			tmc_active;
 };
 
 typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, struct tmigr_walk *);
@@ -1119,15 +1113,6 @@ static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
 	 */
 	if (!tmigr_check_migrator(group, childmask))
 		return true;
-
-	/*
-	 * When there is a parent group and the CPU which triggered the
-	 * hierarchy walk is not active, proceed the walk to reach the top level
-	 * group before reading the next_expiry value.
-	 */
-	if (group->parent && !data->tmc_active)
-		return false;
-
 	/*
 	 * The lock is required on 32bit architectures to read the variable
 	 * consistently with a concurrent writer. On 64bit the lock is not
@@ -1172,7 +1157,6 @@ bool tmigr_requires_handle_remote(void)
 	data.now = get_jiffies_update(&jif);
 	data.childmask = tmc->groupmask;
 	data.firstexp = KTIME_MAX;
-	data.tmc_active = !tmc->idle;
 	data.check = false;
 
 	/*
-- 
2.51.0


