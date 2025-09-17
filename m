Return-Path: <linux-kernel+bounces-820569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27803B7D5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA005487B68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221F369988;
	Wed, 17 Sep 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAEu3P8+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B2BA45;
	Wed, 17 Sep 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109039; cv=none; b=XIDSOsUW6NdmfY8KSKorkWgHtSH1nDhRMhGq1E3+tR7vE6D4sKWhwiq610vvk6UI9nZwXKq2J/4PKFxItECcIK6MVo9d5hKG5sM+0DTixqovHDXJOIhKUGeRLUzBVJtMSgdqCnXA8khoT1DLglEX2X2Z1UE0X2ePWzrW+f8OKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109039; c=relaxed/simple;
	bh=MhGnNnjxCsusBSIoICY8/qvPgGMLOIsv9J/v7VpkAro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfJF9TBMPWoIMSW8H4cUFaVko8FHXOSvRjLB+N6l25LA98ztoxAvCTAHj075zAS9BCryRx2h7bePIS9E71lnYf1zNND1MH5MiDX7pLoIT77M2Zjeu2xGDK6M1bkx/ecxT+YCa30afwvTYtbEPQu7EOov/1i1KaX+qODDCK94b1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAEu3P8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F74C4CEF0;
	Wed, 17 Sep 2025 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758109038;
	bh=MhGnNnjxCsusBSIoICY8/qvPgGMLOIsv9J/v7VpkAro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAEu3P8+KUng/mEvczw6TyBP1sOPwgx9woe0T7sYojCuWnxoZ+2MW4NsAbCPuuK6w
	 6H0Izyizp1Ko/ek+tUIGbelcjRhvFsmj5gehPJrSYG1BYN/r1bYuZMpc+KNLZ+v8qb
	 eb/IVK+0hfzgErnUAW2kbK7zlBzVQQVALl6wmqwrqU01+hHFZ7WyXgfmQCUxC5NJ6G
	 afo7s5UhBFT+KR3TWHwHk+/3JwwYgKNyMyNoQe+CUOZjdw+Zw5F92XzQ9nQDxiW/Ua
	 DXpVR1ncJ28w27KLPzn+rdmAgM68qEvY+q1pOwkvz+9Fop+9sW7Amwk4PKJGtElr0+
	 ffnFZ949G7/ww==
Date: Wed, 17 Sep 2025 12:37:12 +0100
From: Will Deacon <will@kernel.org>
To: pengyu <pengyu@kylinos.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	boqun.feng@gmail.com, longman@redhat.com,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	t.haas@tu-bs.de, parri.andrea@gmail.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, paulmck@kernel.org,
	jonas.oberhauser@huaweicloud.com, r.maseli@tu-bs.de,
	lkmm@lists.linux.dev, stern@rowland.harvard.edu
Subject: Re: [PATCH] locking/qspinlock: use xchg with _mb in slowpath for
 arm64
Message-ID: <aMqdaCkflusKi2hA@willie-the-truck>
References: <20250916033903.3374794-1-pengyu@kylinos.cn>
 <20250916141032.GJ3245006@noisy.programming.kicks-ass.net>
 <aMmJlv8JrzyHRCxR@willie-the-truck>
 <31861b75-02ee-495e-b839-15d7510bf7c6@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31861b75-02ee-495e-b839-15d7510bf7c6@kylinos.cn>

On Wed, Sep 17, 2025 at 06:51:18PM +0800, pengyu wrote:
> Yes, this issue occurred on a kunpeng920 96-core machine and only
> affected a small number of systems that had been running for over a
> year.
> 
> Vmcore Analysis:
> • Panic triggered by CPU 83 detecting a hard lockup at
>     queued_spin_lock_slowpath+0x1d8/0x320.
> 
> • Corresponding code:
>     arch_mcs_spin_lock_contended(&node->locked);
> 
> • The qspinlock involved was the rq lock, which showed a cleared state:
>     crash> rq.lock,cpu ffffad96ff2907c0
>       lock = {
>         raw_lock = {
>           {
>             val = {
>               counter = 0
>             },
>             {
>               locked = 0 '\000',
>               pending = 0 '\000'
>             },
>             {
>               locked_pending = 0,
>               tail = 0
>             }
>           }
>         }
>       },
>       cpu = 50,
> 
> • CPU 83’s MCS node remained in a locked=0 state, with no previous
> node found in the qnodes list.
>     crash> p qnodes:83
>     per_cpu(qnodes, 83) = $292 =
>      {{
>         mcs = {
>           next = 0x0,
>           locked = 0,
>           count = 1
>         }
>       },
>     crash> p qnodes | grep 83
>       [83]: ffffadd6bf7914c0
>     crash> p qnodes:all | grep ffffadd6bf7914c0
>     crash>
> 
> • Since rq->lock was cleared, no CPU could notify CPU 83.
> 
> This issue has occurred multiple times, but the root cause remains
> unclear. We suspect that CPU 83 may have failed to enqueue itself,
> potentially due to a failure in the xchg_tail atomic operation.

Hmm. For the lock word to be clear with a CPU spinning on its MCS node
then something has gone quite badly wrong. I think that would mean that:

  1. The spinning CPU has updated tail to point to its node (xchg_tail())
  2. The lock-owning CPU then erroneously cleared the tail field
     (atomic_try_cmpxchg_relaxed())

But for the cmpxchg() to succeed in (2) then the xchg() in (1) must be
ordered after it and the lock word wouldn't end up as zero. This is
because RmW atomics must be totally ordered for a given memory location
and that applies regardless of their memory ordering properties.

Of course, there could be _a_ bug here but, given the information you've
been able to provide, it's not obviously as "simple" as a missing memory
barrier. Have you confirmed that adding memory barriers makes the problem
go away?

If you're able to check the thread_info (via sp_el0) of CPU83 in your
example, it might be interesting to see whether or not the 'cpu' field
has been corrupted. For example, if it ends up being read as -1 then we
may compute a tail of 0 when enqueuing our MCS node into the lock word.

> It has been noted that the _relaxed version is used in xchx_tail, and we
> are uncertain whether this could lead to visibility issues—for example,
> if CPU 83 modifies lock->tail, but other CPUs fail to observe the
> change.
> 
> We are also checking if this is related：
>     https://lkml.kernel.org/r/cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de

Hopefully I (or somebody from Arm) can provide an update soon on this
topic but I wouldn't necessarily expect it to help you with this new
case.

Will

