Return-Path: <linux-kernel+bounces-868914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B4C067BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289231C02777
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909AC31D378;
	Fri, 24 Oct 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5OQwXqU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86B231D36A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312355; cv=none; b=cQIyP+UBsLNzD8HbDl7ED0HVHvLRpUpOb7l7YxI6yfqroDdhm1hunwvGJiy+H+C9Qk2xUJZchAikMg2QlWfCRLgZP5BJ8eUYUiePzhFv0ypAWkitzK6kDlILI4B4Tu7WoAmceZYswyfZHrjXfoflg8Gm+DBD2osUWtknPlX1YoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312355; c=relaxed/simple;
	bh=dEvEcEaAEAJ00M+doNnzB97L5BEkFu161uwoejGWcZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6EpKirUOKlYJE5RzqIrCf3ELDegV0K1dOCf5AIwd/dt/SBZi6O/Vj6xQSxR2qd3KU45DPEz7vvy+t1fRrgzfl1pX1xdD3YbMEiNo6mis0S0YjGEPJGifgOSXjjafSOEUFW26ZQB9rZXZAY0+MXUNIzN1cRHpscJIqtXs0eGyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5OQwXqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368B0C113D0;
	Fri, 24 Oct 2025 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312354;
	bh=dEvEcEaAEAJ00M+doNnzB97L5BEkFu161uwoejGWcZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5OQwXqUFf0OI0pvGQDfhppEcdukL6zHGrKAptj2NXzAwW7tDly8Uh6QqVcSaEeVb
	 TSGanVRuG4FFMfKGDwf1MfweRad943ipclXuJ8hJm0NJea84GFQKDUHl+zsBtdm7o4
	 YHPs6W7FTG4dwOqUjsENtadjvnrV50d6yXsKXPWyVrOmWuoxyqau2Ttog2p9fHs1nf
	 l+LfEUH8xcsgFPOxcBLh19DHMBDZZiHr5oKNd5v/WYsaA1hN7BCpQnG5Mxt1F8CXJH
	 UtSDWT1UsZXsLJrcqMscQAMNe7hRSp/ICeaKbV8Z5BrreH0zgDCCX6GpLnFRxG84AM
	 hPEQmkf3wuvrQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 1/6] timers/migration: Convert "while" loops to use "for"
Date: Fri, 24 Oct 2025 15:25:31 +0200
Message-ID: <20251024132536.39841-2-frederic@kernel.org>
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

Both the "do while" and "while" loops in tmigr_setup_groups() eventually
mimic the behaviour of "for" loops.

Simplify accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c0c54dc5314c..1e371f1fdc86 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1642,22 +1642,23 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 {
 	struct tmigr_group *group, *child, **stack;
-	int top = 0, err = 0, i = 0;
+	int i, top = 0, err = 0;
 	struct list_head *lvllist;
 
 	stack = kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
 	if (!stack)
 		return -ENOMEM;
 
-	do {
+	for (i = 0; i < tmigr_hierarchy_levels; i++) {
 		group = tmigr_get_group(cpu, node, i);
 		if (IS_ERR(group)) {
 			err = PTR_ERR(group);
+			i--;
 			break;
 		}
 
 		top = i;
-		stack[i++] = group;
+		stack[i] = group;
 
 		/*
 		 * When booting only less CPUs of a system than CPUs are
@@ -1667,16 +1668,18 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		 * be different from tmigr_hierarchy_levels, contains only a
 		 * single group.
 		 */
-		if (group->parent || list_is_singular(&tmigr_level_list[i - 1]))
+		if (group->parent || list_is_singular(&tmigr_level_list[i]))
 			break;
+	}
 
-	} while (i < tmigr_hierarchy_levels);
+	/* Assert single root without parent */
+	if (WARN_ON_ONCE(i >= tmigr_hierarchy_levels))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top])))
+		return -EINVAL;
 
-	/* Assert single root */
-	WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top]));
-
-	while (i > 0) {
-		group = stack[--i];
+	for (; i >= 0; i--) {
+		group = stack[i];
 
 		if (err < 0) {
 			list_del(&group->list);
-- 
2.51.0


