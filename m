Return-Path: <linux-kernel+bounces-819195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B5B59CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460461B273FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409F233D9C;
	Tue, 16 Sep 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNqqBSS/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF236CE0E;
	Tue, 16 Sep 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038429; cv=none; b=c8pgzb7RJOk64WKI4r6nLqZVBsGdrIFSyw+YoVO+R/WEantguMZ4M8HGBOFAAR1X/bPFFXxvnkuQDv756QSr++gWPEmij5CostL+SAs5FN111tML1sU9ZN8WcQ0wxgM9Ug3YCsJH5HQa+hC2193o69GQFgP5VyRlREal3O362Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038429; c=relaxed/simple;
	bh=wOFq06mfz1y8OWoYQVwC0XqhGTky3MJIO8nLINm7vwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjw8MeQKIGUc/3Wrz8qFiEV5QXtw/rxmmHCxWJ182xCJ2cbCywp2aENbPvwsZD0U/oxxbslGPk3g65CHZ9GZEXt7afv1HjHr5Ics7aCvz1V2sax3Zvt+WaUgI/1mFjjAPc7X8Wn7gU9iI8XcxQC7oZbn/MGOxcKLK0V1zFK6R38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNqqBSS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9275FC4CEEB;
	Tue, 16 Sep 2025 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758038428;
	bh=wOFq06mfz1y8OWoYQVwC0XqhGTky3MJIO8nLINm7vwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNqqBSS/mFqKYPzGN63WqbXQ6BNDKedzQpAW8JAzd6fXdOu10stUnhO/4aCc16htk
	 NR7L2UzG3+OSvNskl3dNxiIW3tYCbi2Ui0PNg7l8QjAdbtj2GLhuOYbIi6PkA3L7U0
	 LtVGZ2HmWtStw9hgtz0LG1CUmsHbE2VzVOZ2oqixlAvM+DvIsig00nVOeDNYj9zD2p
	 1mhCes9EYSlSDoJrxLdcryjesEAqXrd1oCqyXpf/XCUhdCwq9J0UFHXOQFguHlJHnk
	 WbenJwNASG2PVXl6V9ruRqFpOHCLzg7YVA8gpE7EXz0fU0gLpbeMsTpFfwE8IvEk/N
	 qZBtOMgxAgi1w==
Date: Tue, 16 Sep 2025 17:00:22 +0100
From: Will Deacon <will@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: pengyu <pengyu@kylinos.cn>, mingo@redhat.com, boqun.feng@gmail.com,
	longman@redhat.com, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, t.haas@tu-bs.de,
	parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	paulmck@kernel.org, jonas.oberhauser@huaweicloud.com,
	r.maseli@tu-bs.de, lkmm@lists.linux.dev, stern@rowland.harvard.edu
Subject: Re: [PATCH] locking/qspinlock: use xchg with _mb in slowpath for
 arm64
Message-ID: <aMmJlv8JrzyHRCxR@willie-the-truck>
References: <20250916033903.3374794-1-pengyu@kylinos.cn>
 <20250916141032.GJ3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916141032.GJ3245006@noisy.programming.kicks-ass.net>

On Tue, Sep 16, 2025 at 04:10:32PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 16, 2025 at 11:39:03AM +0800, pengyu wrote:
> > From: Yu Peng <pengyu@kylinos.cn>
> > 
> > A hardlock detected on arm64: rq->lock was released, but a CPU
> > blocked at mcs_node->locked and timed out.
> > 
> > We found xchg_tail and atomic_try_cmpxchg_relaxed used _relaxed
> > versions without memory barriers. Suspected insufficient coherence
> > guarantees on some arm64 microarchitectures, potentially leading to
> > the following issues occurred:
> > 
> > CPU0:                                           CPU1:
> > // Set tail to CPU0
> > old = xchg_tail(lock, tail);
> > 
> > //CPU0 read tail is itself
> > if ((val & _Q_TAIL_MASK) == tail)
> >                                                 // CPU1 exchanges the tail
> >                                                 old = xchg_tail(lock, tail)
> > //assuming CPU0 not see tail change
> > atomic_try_cmpxchg_relaxed(
> > 	  &lock->val, &val, _Q_LOCKED_VAL)
> > //released without notifying CPU1
> > goto release;
> >                                                 //hardlock detected
> >                                                 arch_mcs_spin_lock_contended(
> >                                                       &node->locked)
> > 
> > Therefore, xchg_tail and atomic_try_cmpxchg using _mb to replace _relaxed.
> 
> Yeah, no. We do not apply patches based on suspicion. And we most
> certainly do not sprinkle #ifdef ARM64 in generic code.

Absolutely.

> There is this thread:
> 
>   https://lkml.kernel.org/r/cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de
> 
> Which is also concerned with xchg_tail(). Reading back, I'm not sure
> we've ever heard back from ARM on whether that extra ;si was correct or
> not, Will?

It's still under discussion with the Arm architects but it was _very_
close to concluding last time we met and I wouldn't worry about it for
the purposes of this report.

> Anyway, as Waiman already asked, please state your exact ARM64
> microarch.
> 
> Barring the ;si, the above thread suggests that they can prove the code
> correct with the below change, does that resolve your problem?
> 
> Other than that, I'm going to have to leave this to Will and co.

I'll take a look but it's light on details.

Will

