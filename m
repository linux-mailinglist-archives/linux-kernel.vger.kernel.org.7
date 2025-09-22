Return-Path: <linux-kernel+bounces-826509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4298FB8EB28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10E67AC769
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B9319AD8B;
	Mon, 22 Sep 2025 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWvKHG87"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5C191F9C;
	Mon, 22 Sep 2025 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504770; cv=none; b=HA5pdZ0Zuyw+1XMsoA6GGtX3aRWg3H1VobnM2FLMZUEEYIc+Zm0iMZP1VhYcdcp9tTI+Ci2YJSqIm0MDQbhYSYPFcajHTvD6jwkkmk5rXjY9n+8CFINrkh1q0Gc7950hlzVAM900orhItUV+TTWj+MQRveJhbdReA7hU3n1s26g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504770; c=relaxed/simple;
	bh=DX8xACRQB3Q0f9Mpj9jSY6cREEKLJMBXATnCxkYx2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQ5DJ5nUNzkS+7A+FkQtR7H057L211O7wAHUANXdJM3AJJr3qb33Ya/qp9FhxQBxYVgWEa+93saeFoRmI2y1YjaLREHsf6Eje4+3bBU7uL95P1taNWtBSHBXILACSlDt7+VoDWW654hulIgEwf6zsPGAZk5Q3ZTwWH95NtC49QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWvKHG87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AACC4CEF7;
	Mon, 22 Sep 2025 01:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758504770;
	bh=DX8xACRQB3Q0f9Mpj9jSY6cREEKLJMBXATnCxkYx2EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWvKHG87u8GK8UimkUg/DYfzjCL9ouIalKCWzguD1HGtWhn37X7Z3WojnYJa55Ev8
	 dOK0AISF9s8moN84E1OzE1qC8CGiZ6zzIc1H+V3vSP/Y8A8W99ykJVtoZepAVMFJrI
	 p8/iRysofYCr6nyE+fEExnB3eR30hDDx/S6uGTAFtvD7svOWjfzA2x/YBeggJWgNUB
	 46BR61KUqySjOjy1XWUEBG7jAMaHceoggtU14dCwz99ocWjHTObgKCQOpmp+I2ajSE
	 /Zk0BfBNBjpuy/9mCM4FFeb+X3k7vdWpzSjmYUfgaMSP1gzpTjH6MInb+rg7SbQdYR
	 ENoxLQkrDG1TA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/7] sched_ext: Fix stray scx_root usage in task_can_run_on_remote_rq()
Date: Sun, 21 Sep 2025 15:32:42 -1000
Message-ID: <20250922013246.275031-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922013246.275031-1-tj@kernel.org>
References: <20250922013246.275031-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task_can_run_on_remote_rq() takes @sch but it is using scx_root when
incrementing SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE, which is inconsistent and
gets in the way of implementing multiple scheduler support. Use @sch
instead. As currently scx_root is the only possible scheduler instance, this
doesn't cause any behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index df433f6fab4b..5801ac676d59 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1622,8 +1622,7 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	if (!scx_rq_online(rq)) {
 		if (enforce)
-			__scx_add_event(scx_root,
-					SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE, 1);
+			__scx_add_event(sch, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE, 1);
 		return false;
 	}
 
-- 
2.51.0


