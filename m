Return-Path: <linux-kernel+bounces-874689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B0C16DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E699B188AD13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7EF2BE7C6;
	Tue, 28 Oct 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg54qwLd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19E27464F;
	Tue, 28 Oct 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685459; cv=none; b=MzJlkfBx8D3yj1qCcWNpcFgYZ7XhqC4H5MJ0K7fsL/Yd0kANHdPlgHcDip21Okk79Yqd3gJWwdTJHlgphHO/UvlkuyrTcJw3ePQ3PZSYJeezKTMHWt+jnhSSWuD+V8Tn8CW1G89O1nu/GWad+nupyXWZG3weIPPrFt7KDi+rsEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685459; c=relaxed/simple;
	bh=yPTiSmkFy0L2ygt5n7CY9W5kU9yg9YW2BtOaGQKJYU4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=rQ7n0Wo+GQLHDc404RWjW2N7tqVCoffn378bjpvUDKWhjhBGDLKBovb+FXlvuHYW2pvpCymBKxA1dxkv6JGL24A52uNu4QKqLVL0bdsRU7EFZH69KHnWdXQaB49O7mz+1Vce/H7VAcjoKGgGn1kw7ChMDDOnKyxu1/Dyx/n2jXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg54qwLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CECAC4CEE7;
	Tue, 28 Oct 2025 21:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761685459;
	bh=yPTiSmkFy0L2ygt5n7CY9W5kU9yg9YW2BtOaGQKJYU4=;
	h=Date:From:To:Cc:Subject:From;
	b=Jg54qwLdNAJ9dJQDTesLdPqUu7nTvxLTLXaM+rrsY84I0RQ1J0wW5J6/oEpRqySwK
	 vRVnucYSAeaONpn/Sg9HWalOFfxVYy4jslI7S7FEwIonSac+9+GN1o4CMMito4XLcg
	 QQjW2yeVV2Xxwl8WU2i9j9ZdGzzq2XbDgR00l3fe34GIa/xDMelYwOq2bhzAF5A5rd
	 KnQ+z//eUykDXMyrJdmRP2RKKdakIEOBBh2q9tnffBqRHkrDDLnIGMNcUF43nj0SXy
	 4xdZX/951bQyJR+l2koUS7deviTtKd/KwDoH705HGj6PMq+VaexBIzl+QBs6OuVPSV
	 tRDIQYG5WY4lg==
Date: Tue, 28 Oct 2025 11:04:18 -1000
Message-ID: <31c2ba69c73dc25b022533ca00300256@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: [PATCH sched_ext/for-6.19] sched_ext: Use SCX_TASK_READY test instead of tryget_task_struct() during class switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

ddf7233fcab6 ("sched/ext: Fix invalid task state transitions on class
switch") added tryget_task_struct() test during scx_enable()'s class
switching loop. The reason for the addition was to avoid enabling tasks which
skipped prep in the previous loop due to being dead.

While tryget_task_struct() does work for this purpose as tasks that fail
tryget always will fail it, it's a bit roundabout. A more direct way is
testing whether the task is in READY state. Switch to testing SCX_TASK_READY
directly.

Cc: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4662,7 +4662,7 @@ static int scx_enable(struct sched_ext_o
 			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;

-		if (!tryget_task_struct(p))
+		if (scx_get_task_state(p) != SCX_TASK_READY)
 			continue;

 		if (old_class != new_class && p->se.sched_delayed)
@@ -4677,7 +4677,6 @@ static int scx_enable(struct sched_ext_o
 		sched_enq_and_set_task(&ctx);

 		check_class_changed(task_rq(p), p, old_class, p->prio);
-		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);

