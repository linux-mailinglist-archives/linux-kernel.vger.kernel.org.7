Return-Path: <linux-kernel+bounces-822523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFA3B8411D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60AA3A342E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522C302175;
	Thu, 18 Sep 2025 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EP4ueUHN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A12F90CE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190932; cv=none; b=inQArjPleM0LocYJ4Q+IZp8h8+DlsdJkWOO8e6I7dQuC18z3W4xUkhMnEJ3+2uKoReCV1iK04hhVy1v00ov5u2UBkHnQFve4zseBZAdBTaiOYTQrvtCYbaTSBVNPEh0g5ieTpdUrvMi5tlfbuZg22KKUEosgYdkriBTpzM+rc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190932; c=relaxed/simple;
	bh=kDKD1DqAkYu+mVcTWSvMzfvsQwzK9VBXEe95QXgpNXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9EZtUugeVPoVW97RGsrQmIpb4f3iH5TIcLw9nFvnfSRDCmJ6Y1PwOE717Noq6Ob093W2lmqokfZHX0oG0nUpOv6PcbLb9/v6MOuzRI+0uRQrO7idEm4XKtI7QKPriuL+T2Vt49vIPF3sESCTzLojgQ6gFwEPRPsIU4vLb+GhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EP4ueUHN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JGSKMad2e49ENOnKr0+ijqZM75TslQ66m4Ye2rlmscI=; b=EP4ueUHNveUWsZ12n3lWGHx1a8
	8qMB7VtnQ9/Li1B3HNtB92q8tfgyWRmeYnipDn6WxQp+1ph2MguJAlq9ssFbO0k3elv7vHtGlj9Lx
	yFRhIhHnRJ+5C2qqLdNhQg1j/IqU0PQJk6j7iUbTZkGGSKWzUaUbuVYjX971qSbsdoTCTgMUriEhi
	/mrxFDicJDZX5zz/eG5d8t83r7jdFYJhOvQ/xMWsrDQc0EqxmnCLD5wq1yY7XgWtQK75Enz74TgeZ
	gvdkZNqWSiuf2+mqdr9dvA2pl7cRSnlaQZXUgVJq1l6KOoAMC7aPaKz+CpsaNK58He6RiFKbybc4g
	nZiR2mmw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBm4-00000007ad2-3GA1;
	Thu, 18 Sep 2025 10:22:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8431E300566; Thu, 18 Sep 2025 12:21:59 +0200 (CEST)
Date: Thu, 18 Sep 2025 12:21:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Fernand Sieber <sieberf@amazon.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com, dwmw@amazon.co.uk,
	graf@amazon.com, jschoenh@amazon.de, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	tanghui20@huawei.com, vincent.guittot@linaro.org,
	vineethr@linux.ibm.com, wangtao554@huawei.com,
	zhangqiao22@huawei.com
Subject: Re: [PATCH v2] sched/fair: Forfeit vruntime on yield
Message-ID: <20250918102159.GH1386988@noisy.programming.kicks-ass.net>
References: <20250916140228.452231-1-sieberf@amazon.com>
 <20250916160036.584174-1-sieberf@amazon.com>
 <20250918064300.GV3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918064300.GV3419281@noisy.programming.kicks-ass.net>

On Thu, Sep 18, 2025 at 08:43:00AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 16, 2025 at 06:00:35PM +0200, Fernand Sieber wrote:
> > After further testing I think we should stick with the original approach or
> > iterate on the vruntime forfeiting.
> > 
> > The vruntime forfeiting doesn't work well with core scheduling. The core
> > scheduler picks the best task across the SMT mask, and then the siblings run a
> > matching task no matter what. This means the core scheduler can keep picking
> > the yielding task on the sibling even after it becomes ineligible (because it's
> > preferrable than force idle). In this scenario the vruntime of the yielding
> > task runs away rapidly, which causes problematic imbalances later on.
> > 
> > Perhaps an alternative is to forfeit the vruntime (set it to the deadline), but
> > only once. I.e don't do it if the task is already ineligible? If the task is
> > ineligible then we simply increment the deadline as in my original patch?
> > 
> > Peter, let me know your thoughts on this.
> 
> Sorry, I missed this email earlier. I'll go ponder it a bit -- my brain
> is esp. slow today due to a cold :/

Right; so you're saying something like the below, right?

Yeah, I suppose we can do that; please write a coherent comment on it
though, so we can remember why, later on.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5c94caa93085..e75abf3c256d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9012,8 +9012,13 @@ static void yield_task_fair(struct rq *rq)
 	 */
 	rq_clock_skip_update(rq);
 
-	se->vruntime = se->deadline;
-	se->deadline += calc_delta_fair(se->slice, se);
+	/*
+	 * comment...
+	 */
+	if (entity_eligible(cfs_rq, se)) {
+		se->vruntime = se->deadline;
+		se->deadline += calc_delta_fair(se->slice, se);
+	}
 }
 
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)

