Return-Path: <linux-kernel+bounces-596098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C4BA826FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 16:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE387A588B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 14:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8BC264A9D;
	Wed,  9 Apr 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kmM8nGSt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF425F788
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207395; cv=none; b=chMcxt2/gI5dmt/TCdffmzQKLenuzSxbQGhkV8QW2TkWcEvJ8FDMbD1CarB+1tXQTzLxkJFQtbrfvPM8wmhrjJv1yt05qnQY5jIdt0aWHYRqpiVSvbMfhOjWs6l75QM7L/qSPFKiX/Dh8kbQS9aFwm99L7dRCS0+mWrhrdl0SD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207395; c=relaxed/simple;
	bh=Xzn04fYIgH4XAznn2NkXUEsV3TK9MfILaqPt7yhLHv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwJSlmAWd44e97RdhrszqE/kZoNgepugE31RxZ434OGigpkE4+52YRQM+wDfP1xyEVZWJVnPy+ZcBG20EIulIlSGoc8+3WfVK2O6rV0ht2fuDBEHlcUSm+605lnVtX0y5m/pl+dhSlJmfips2NH0CBSG899cQlXLbv85sGnTGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kmM8nGSt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WgC7apt66Yz1l8rnuSd1IOWppntzQHHRtIGlSbwyHq8=; b=kmM8nGStJ9MkFXEn48fe7anjfv
	o5bzu7sk4x3zNVkoEdfaP5wwaJzuSe7pVDGYcvESN1iiRNeoE7DgMaVjklAewf/NUK3Vv1P03aY0Q
	4pZWyFgWqfdvOqMlDGPzPc0Nvl9wEl0Ng7Cc8xdWfjItC3THCk2nbmD/D8yiQ5E4bG9QbayqFkX2g
	nxKTJgwHfGUqgyC2SwjD5UxVAFKXMXZl0IKOtnYj/YaKHGftWvbmNROhvgRFchHCBahKosXchi38E
	3SIdCzYJyBloHD7FHwG6BBfN/j30hmm5FFVDRebXjgaDRriFRoYQ2BzVkwWG9CNgYU4MZTwzrUbxX
	CkE/WBcg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2W19-00000008dDM-4B8r;
	Wed, 09 Apr 2025 14:03:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4A764300288; Wed,  9 Apr 2025 16:03:03 +0200 (CEST)
Date: Wed, 9 Apr 2025 16:03:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-mm@kvack.org,
	Ingo Molnar <mingo@redhat.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v12 2/3] sched: Move task_mm_cid_work to mm work_struct
Message-ID: <20250409140303.GA9833@noisy.programming.kicks-ass.net>
References: <20250311062849.72083-1-gmonaco@redhat.com>
 <20250311062849.72083-3-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311062849.72083-3-gmonaco@redhat.com>

On Tue, Mar 11, 2025 at 07:28:45AM +0100, Gabriele Monaco wrote:
> +static inline void rseq_preempt_from_tick(struct task_struct *t)
> +{
> +	u64 rtime = t->se.sum_exec_runtime - t->se.prev_sum_exec_runtime;
> +
> +	if (rtime > RSEQ_UNPREEMPTED_THRESHOLD)
> +		rseq_preempt(t);
> +}

This confused me.

The goal seems to be to tickle __rseq_handle_notify_resume() so it'll
end up queueing that work thing. But why do we want to set PREEMPT_BIT
here?

