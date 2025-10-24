Return-Path: <linux-kernel+bounces-868939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E2C068C3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFB93ADCFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C484F31AF0A;
	Fri, 24 Oct 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YOjznXwF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5225C711
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313233; cv=none; b=fi9cnK57G+t7GqH875/2nNRC//sQQfM6eYd+WHGl7bFMwULGkQfJxHlo4dhF4D4rrAaqPzlKkhtNn67qT+f7FmODp+3OUagoT3EhA/UdKgt/PA1GIbLo6/myBGwJNp5kZTmjd97vAMFmIhaEt8V/4hbht+qSLT4waNM2E7J29xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313233; c=relaxed/simple;
	bh=iRGB7KwxF+heWMfqHG+AJZi2NLuLRS3ljgXoZCP1T7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+g/6hWmQTY02PhJIWqdmkQ1LcYb9WzTrcBYmGGCHF1mz2aKFQvhvluS2IK+3FnMg5fllQ1g5dFsVo9GsJxOHRZTKRGodD2VxS10y7DLBcNCJzNRFgIKh3S+74x9QCMC2VGL1/GP3joqCwUV84rOIruAg7ZssarEWElhgM1zTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YOjznXwF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eqIlbFIS1NrExPF+0T4MGwSwd18ATnESRaBZ3QjiXDA=; b=YOjznXwFR1FWIfwQXVIcQR6/xc
	nGUFkoP8jUkymiGrc3rvJqH13WH40TDTz0+L7GSw/DFAR944I+zpLoxV6eI1GXdT7lu3H88CH6Luk
	I+71rIVwOYvARtm/DarVu4j5nYSHKMUn0qqfMtYvXKFGwORZj9JavN9PYhzVDd9dIqvuGNvoNZ8Dj
	vl+T+7wSImpU1pLx2DiuKtH7Lk0KseI+2ltaEejCpBv9S4YpFsG6eWvIW7lEgAsf9jfn+OHXETrqM
	0w74y5HKTeFrgeF+cVd8X9qfpWOwM1EdehXWb9o4SmuD86BvL7IuyJ90ka8W4V6IwzHZShlOrnqxp
	/CN9KGJQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCHAC-00000002Irx-1TNu;
	Fri, 24 Oct 2025 12:45:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D126E300323; Fri, 24 Oct 2025 15:40:24 +0200 (CEST)
Date: Fri, 24 Oct 2025 15:40:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: jpoimboe@kernel.org, rostedt@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
Message-ID: <20251024134024.GT4067720@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.613695709@infradead.org>
 <bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>
 <cc6f34bb-7d05-4260-bc02-299fef2bcb01@linux.ibm.com>
 <20251020103940.GP3419281@noisy.programming.kicks-ass.net>
 <5bdb1c91-8862-44b1-9f12-c5afa9e1806c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdb1c91-8862-44b1-9f12-c5afa9e1806c@linux.ibm.com>

On Wed, Oct 22, 2025 at 04:55:01PM +0200, Jens Remus wrote:
> Hello Peter!
> 
> On 10/20/2025 12:39 PM, Peter Zijlstra wrote:
> > On Mon, Oct 20, 2025 at 11:16:45AM +0200, Jens Remus wrote:
> >> On 10/17/2025 5:47 PM, Jens Remus wrote:
> 
> >>> In SFrame the CFA, FP, and RA offsets are unscaled.  Would it be ok, if
> >>> unwind user sframe would factor state->ws from those offset values?  What
> >>> if they were not aligned?  unwind user sframe would then have to fail.
> >>
> >> Sorry that I did not immediately think about the most obvious solution
> >> tho above issues:  to not factor out the word size from the frame CFA,
> >> FP, and RA offsets.  What do you think about making the following
> >> changes to this and giyour subsequent patch?  That would work nicely
> >> with unwind user sframe.
> > 
> > 
> > Yes, this should do nicely. I've made the changes, I'll do a test build
> > and then push out to the robots.
> 
> Thanks!  Looking at your following updated patch I found that your
> change from "pointer to const struct unwind_user_frame" to
> "const struct unwind_user_frame" (done for obvious reasons) will require
> unwind user sframe to undo this when refactoring unwind_user_next_fp()
> into unwind_user_next_common().  Would that be the usual procedure or
> could you leave it as "pointer to const struct unwind_user_frame" for
> now?

Ah, I see, that is here:

  https://lkml.kernel.org/r/20251022144326.4082059-9-jremus@linux.ibm.com

Yeah, just change it there. It is a bit weird to have this indirection
at this point.


