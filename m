Return-Path: <linux-kernel+bounces-764657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7A6B225AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32F2173F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A922ECE9A;
	Tue, 12 Aug 2025 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XXtL3xwM"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B61AB6F1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997328; cv=none; b=MGbHlTF8AanF2CWIe+8o9uqsNSqMWgwvU+rCJ5SIXyckLUR0DffvUCUySxxOYf//DdWwEB1m2PyJyO9/jgGw8XgxY02N/wxLO7OZrFiS3mGipObr8H7zbBg82/Ss2nuKlp8mkAqm7If51gniD9082oqKx0ScEUojkWqw47DP1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997328; c=relaxed/simple;
	bh=5ZnVmN9qmI6c4MRo17HexIlgEiTwXkIQzPrwRq36Wt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieLYv0okwbF3r98p50BLFTQeJKqrBC62dd+eEsZbXV3hY3QE+HTMCeAT04U6YCvCyWosOF7ddHZtfUdoRWDHnCtmYjZ/RamteGg3iPzPRP5Bw4IixI1gPolZWWFhzJxwygThFvMYwDyuOjUEPrqvLDlpNYHnrk50uHbb0K385bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XXtL3xwM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=95xIyfEcZBVG1URXhC4JlO9oe2NJPiHrQUAM9YPRm10=; b=XXtL3xwM9bPjlyb4fUxG///MGW
	43+NnZpooet37TsQFJ0C46paVmR4eN7cJN5uvuTBYvgpt4R9pXY/ykKSaD5RP5E8C5Pf7ZV/sz1Fc
	JmolqPsAtV6n3lD5CFkFzjTFT+enkMJBdFfiKgUCxtairuw+Ar9WpVP3+qkXOr0Ot2HSBJin87TVM
	2LUQcKePruVFjX7uM3Oo0Cq5eAJ3p/+xIJlwaiRPhinaGiIU39Rzntr4qgP5Vj8QUoi8mTEk23px+
	bnmLVVzA67LTocDLZ3yv0BBVzelyABzN45Hwmkhih9udDXoz63+aZWlx6+fzqQZGlME+UaXBpc106
	gsdnib8A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmyR-0000000Fn05-1bs0;
	Tue, 12 Aug 2025 11:15:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A732D30049D; Tue, 12 Aug 2025 13:15:22 +0200 (CEST)
Date: Tue, 12 Aug 2025 13:15:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, torvalds@linuxfoundation.org,
	mingo@kernel.org, namhyung@kernel.org, acme@redhat.com,
	kees@kernel.org
Subject: Re: [PATCH v3 14/15] perf: Identify the 0->1 transition for
 event::mmap_count
Message-ID: <20250812111522.GI4067720@noisy.programming.kicks-ass.net>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.956479989@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104019.956479989@infradead.org>


ljs noted that this Changelog was a tad terse, and he had a pending
question here.

On Tue, Aug 12, 2025 at 12:39:12PM +0200, Peter Zijlstra wrote:
> Needed because refcount_inc() doesn't allow the 0->1 transition.

Specifically, this is the case where we've created the RB, this means
there was no RB, and as such there could not have been an mmap.
Additionally we hold mmap_mutex to serialize everything.

This must be the first.

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7033,7 +7033,7 @@ static int perf_mmap_rb(struct vm_area_s
>  	perf_event_update_userpage(event);
>  
>  	perf_mmap_account(vma, user_extra, extra);
> -	atomic_inc(&event->mmap_count);
> +	atomic_set(&event->mmap_count, 1);
>  
>  	return 0;
>  }
> 
> 

