Return-Path: <linux-kernel+bounces-834261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041CBA4486
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1201BC237B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E101DB12E;
	Fri, 26 Sep 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="iEyUTIH+"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052718EAB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898164; cv=none; b=BP5ZbANwSYhKfM4gSei+VPwHtxhK3E1D69R73o7TxIUK4yAq+1VMEL7D2X02dXYDl+qc/pTxGRhEYUdrf6pTvAcg6Xki5h723AQCKO9WwPYDlFN/9mlhNIP7IzrDJ3Yy3OoEZnnrYbw6U1ey2Vt3cfT3TNqku5wbxXEfPVQcxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898164; c=relaxed/simple;
	bh=5HBl9Ak2WJrbABXf4eB0MJAFE1IV41DGDgW6Iap2Bw4=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=BDzJ9IhEWEj5pkDni8hR3GMFMlpDBi+N0ydV8pC2QmTTgKP2Rv1wCGE2VhR1OZ7+TOjVAgxBLX6IlOCNj0tsC9z6OmPGVI7a5gc53fbYTqbMmb5ivAsTUJiCh1td00v459KZyt1W1uyTqG9ZiCIdP9XP5L8sHmAxVJSRIQDsylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=iEyUTIH+; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:References:In-Reply-To:Cc:To:
	Subject:From:Message-ID:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yBXAgEpvMU/fDVtw7JdYamQYWe/uR67lM4xFtr0H7eY=; b=iEyUTIH+F7T6W2L35x5FLx9Z7a
	AvVh/dyTKuidgr1rkRfvvOQBjoqsNyD7Qnzd3eqcnqNPloxPQQtqhNtrqcrmF8EEgxIPohaeYoaWa
	/3FyVxg4gBrwPEmYW1dvqx9sTyXl3BouKzFFyADqXkj8z0rnm1+JyP4VIaL7A4Zs0lwtc/xnJa/lL
	Oy+Kc88kR2Mbd8CyPOgCJLdqGu9VBY8xW14OucAvB/iKePgp7H6sXHeAEg3GyjtTXL9Xoh5WC0bCC
	zu6FfvJOOy78l2sS5Ks0H446tZVvXZACkP3eOvr3NPRy8Vxnjbxb4os1dBDW8VqSQAFJiMtsNLw0g
	dLou7uYA==;
Received: from host-79-47-48-17.retail.telecomitalia.it ([79.47.48.17] helo=localhost)
	by imap4.hz.codethink.co.uk with utf8esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1v29ko-002rgy-GK; Fri, 26 Sep 2025 15:48:58 +0100
Date: Fri, 26 Sep 2025 16:48:57 +0200
Message-ID: <83bb46158288dfb314fdf07918b074ae@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
Subject: Re: [PATCH] sched/fair: Start a cfs_rq on throttled hierarchy with
 PELT clock throttled
To: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Aaron Lu
	<ziqianlu@bytedance.com>, linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Matteo Martelli <matteo.martelli@codethink.co.uk>
In-Reply-To: <20250926081918.30488-1-kprateek.nayak@amd.com>
References: <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
	<20250926081918.30488-1-kprateek.nayak@amd.com>
Sender: matteo.martelli@codethink.co.uk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Prateek,

On Fri, 26 Sep 2025 08:19:17 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Matteo reported hitting the assert_list_leaf_cfs_rq() warning from
> enqueue_task_fair() post commit fe8d238e646e ("sched/fair: Propagate
> load for throttled cfs_rq") which transitioned to using
> cfs_rq_pelt_clock_throttled() check for leaf cfs_rq insertions in
> propagate_entity_cfs_rq().
> 
> The "cfs_rq->pelt_clock_throttled" flag is used to indicate if the
> hierarchy has its PELT frozen. If a cfs_rq's PELT is marked frozen, all
> its descendants should have their PELT frozen too or weird things can
> happen as a result of children accumulating PELT signals when the
> parents have their PELT clock stopped.
> 
> Another side effect of this is the loss of integrity of the leaf cfs_rq
> list. As debugged by Aaron, consider the following hierarchy:
> 
>     root(#)
>    /    \
>   A(#)   B(*)
>          |
>          C <--- new cgroup
>          |
>          D <--- new cgroup
> 
>   # - Already on leaf cfs_rq list
>   * - Throttled with PELT frozen
> 
> The newly created cgroups don't have their "pelt_clock_throttled" signal
> synced with cgroup B. Next, the following series of events occur:
> 
> 1. online_fair_sched_group() for cgroup D will call
>    propagate_entity_cfs_rq(). (Same can happen if a throttled task is
>    moved to cgroup C and enqueue_task_fair() returns early.)
> 
>    propagate_entity_cfs_rq() adds the cfs_rq of cgroup C to
>    "rq->tmp_alone_branch" since its PELT clock is not marked throttled
>    and cfs_rq of cgroup B is not on the list.
> 
>    cfs_rq of cgroup B is skipped since its PELT is throttled.
> 
>    root cfs_rq already exists on cfs_rq leading to
>    list_add_leaf_cfs_rq() returning early.
> 
>    The cfs_rq of cgroup C is left dangling on the
>    "rq->tmp_alone_branch".
> 
> 2. A new task wakes up on cgroup A. Since the whole hierarchy is already
>    on the leaf cfs_rq list, list_add_leaf_cfs_rq() keeps returning early
>    without any modifications to "rq->tmp_alone_branch".
> 
>    The final assert_list_leaf_cfs_rq() in enqueue_task_fair() sees the
>    dangling reference to cgroup C's cfs_rq in "rq->tmp_alone_branch".
> 
>    !!! Splat !!!
> 
> Syncing the "pelt_clock_throttled" indicator with parent cfs_rq is not
> enough since the new cfs_rq is not yet enqueued on the hierarchy. A
> dequeue on other subtree on the throttled hierarchy can freeze the PELT
> clock for the parent hierarchy without setting the indicators for this
> newly added cfs_rq which was never enqueued.
> 
> Since there are no tasks on the new hierarchy, start a cfs_rq on a
> throttled hierarchy with its PELT clock throttled. The first enqueue, or
> the distribution (whichever happens first) will unfreeze the PELT clock
> and queue the cfs_rq on the leaf cfs_rq list.
> 
> While at it, add an assert_list_leaf_cfs_rq() in
> propagate_entity_cfs_rq() to catch such cases in the future.
> 
> Suggested-by: Aaron Lu <ziqianlu@bytedance.com>
> Reported-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
> Closes: https://lore.kernel.org/lkml/58a587d694f33c2ea487c700b0d046fa@codethink.co.uk/
> Fixes: eb962f251fbb ("sched/fair: Task based throttle time accounting")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Stress test included running sched-messaging in nested hierarchy with
> various quota set alongside a continuous loop of cgroup creation and
> deletion, as well as another loop of continuous movement of a busy loop
> between cgroups.
> 
> No splats have been observed yet with this patch.
> 
> Aaron, Matteo,
> 
> I've not added any "Tested-by" tags since the final diff is slightly
> different from the diff shared previously. ...

I applied this patch on top of commit 45b7f780739a ("sched: Fix some
typos in include/linux/preempt.h") from sched/core branch of tip tree,
and tested it with exactly the same setup I described in my previous
email[1]. With the patch applied, I couldn't reproduce the warning in 5
hours of testing, while before the patch the issue was systematically
reprodicible and the warning was being triggered at least once per
minute.

Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>

> ...

[1]: https://lore.kernel.org/all/e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk/

Thanks to you and Aaron for addressing this!

Best regards,
Matteo Martelli

