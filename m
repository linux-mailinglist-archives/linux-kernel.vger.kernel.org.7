Return-Path: <linux-kernel+bounces-825401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F2BB8BBE1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755FE5A0BC5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F491274B31;
	Sat, 20 Sep 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNx6aZOR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC562701BB;
	Sat, 20 Sep 2025 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329993; cv=none; b=im5cL2SOFV9U3tJV8YkaHmSkQG1EWX5SS1mEmAZaQOl1RNuqfstqyNGuI5JfzhFMb/SQAJtMyyo++R5QRegu06t3evh8TVBWR9L/DEFJC4KH9XdqiKP4raakncUP3iZs1588UOod6J+m/U8AOD8p3vch2/ylgKxBfF5Zs/JnHSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329993; c=relaxed/simple;
	bh=GtkAshaK54WAcSfNOFJ8SQsdT9SQP7Sgd0hlLccLHfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iik1KOC/UXvuvrc4ZTIwA9CPmCz9btO6gW3HHGbTblko6tZroW3PkplbG1EJK4dCcgYLBkkeHQop8S5XnlZvefC/DxoF5YlU+f5aeGeOxYUye+2/0rgfyNX0QGRcKru2OF11kDjf+PkdcsokOl1nNqpnSaWqxtPMCtgEs8aIDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNx6aZOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E2EC4CEF5;
	Sat, 20 Sep 2025 00:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329992;
	bh=GtkAshaK54WAcSfNOFJ8SQsdT9SQP7Sgd0hlLccLHfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNx6aZORRXa4wHvGpR2XIqPG2iRmhCWWGlHDcA9DN1pJXQEfLLATq/N7hux/k2Fd7
	 PlmX338RRgNv/H/0efJgyN2t4mDdmovw6rLGvauUApdXUYBE4vPQ/T1jsC/jLrt35R
	 hrLuasVMKzBrscSEfHmvJZ4GZ9qs0PCW5JPnHFcHPX/ukb1shYsan0M47D1nGI4KSv
	 ahBelUdimQGLrK6fSRcbOqIlgbhffXZZr6vX2BHWFlJIwLTuLk3jDo/sCWNWJD1Pr5
	 /JWc+t6Xqk0JOSSTDujszpZlOcXcgWWKzOe9zjGfjOrfXoAaN8m0GVAG/l5YnU72Hg
	 mynPMpYbx9yuQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 18/46] sched/core: Swap the order between sched_post_fork() and cgroup_post_fork()
Date: Fri, 19 Sep 2025 14:58:41 -1000
Message-ID: <20250920005931.2753828-19-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The planned sched_ext cgroup sub-scheduler support needs the newly forked
task to be associated with its cgroup in its post_fork() hook. There is no
existing ordering requirement between the two now. Swap them and note the
new ordering requirement.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/fork.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499d..6e5a1397d2e6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2415,8 +2415,12 @@ __latent_entropy struct task_struct *copy_process(
 		fd_install(pidfd, pidfile);
 
 	proc_fork_connector(p);
-	sched_post_fork(p);
+	/*
+	 * sched_ext needs @p to be associated with its cgroup in its post_fork
+	 * hook. cgroup_post_fork() should come before sched_post_fork().
+	 */
 	cgroup_post_fork(p, args);
+	sched_post_fork(p);
 	perf_event_fork(p);
 
 	trace_task_newtask(p, clone_flags);
-- 
2.51.0


