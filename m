Return-Path: <linux-kernel+bounces-868946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63661C068F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 530074F86FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1F5199E94;
	Fri, 24 Oct 2025 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AcrnhscE"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A31494D9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313559; cv=none; b=p9KWGEkD6Pwv2h8yZg6YVw+Bqzg58l4egIc7haYLT41Z5j6f+XC4xocwy2y5ALlXm6aY+7JxzY6rhFPYsujkqtfXt1uZD+TGi6afWeC6IhCuOOKZyZ4FfJG82vz+2NttIsD4A3h6PYeHXXXnhiZUC04HdVAYsvAdO3YGPmwvCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313559; c=relaxed/simple;
	bh=RmQnKBV1obuzYCAqSs/q2r0kPrj4WpnuWojvv6eiba0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDhfMqVwhAD8SqKZQey4uxXtga77cvAYUieaEgWvDBxe9m5FG2wl36G0ZlEZnkkCKooHG/LuxtRQTepq5AJ9Bs3ImuoDA/yKTeNin6YCTSGTNC4CH4EbSLONlSPfAzzrovVx3nqA7XH7eSb3pR5he6p6MvVANZL09RMxrbvEYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AcrnhscE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NpkZbdmoOd1H6RDfh/V7uaNkAdx3zJ05aEWxUS3F6oI=; b=AcrnhscEKlMk/75NeeA5Yn9WkV
	FY6i/BR8DIPZtHHhOFn/D8VFioFk/Vzo5odFFEfEDUu6vFU+yq8R9jO+NTH+nkngP0D1omWumhpXY
	IvNKw8v+OeMX9THzBQDnrvxkhklj3r5CYBhAWCvd2D7A7SCkIwAJ0WzUiLsxHGqyqld5GnNQQ4nos
	uzMF9V0XY2131cs0r49K/kDsV9kwh2pAmkyBHInFW0g8hBghlQNAcS6NCvC+vgsMkC6bmxuf33D2F
	eVWfJNiFe5WCr5PPrJgc+cbjN+Fp14Ezg8CTj14R0g8gG4f2rR8jP6rilwejzM6ZXdtbulq/fwPv8
	RL6KZ6QA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCHFR-00000002J2C-1phi;
	Fri, 24 Oct 2025 12:50:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2B6D300323; Fri, 24 Oct 2025 15:45:50 +0200 (CEST)
Date: Fri, 24 Oct 2025 15:45:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Remus <jremus@linux.ibm.com>, jpoimboe@kernel.org,
	rostedt@kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
Message-ID: <20251024134550.GU4067720@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.613695709@infradead.org>
 <bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>
 <cc6f34bb-7d05-4260-bc02-299fef2bcb01@linux.ibm.com>
 <20251020103940.GP3419281@noisy.programming.kicks-ass.net>
 <20251020104807.GS1386988@noisy.programming.kicks-ass.net>
 <20251022112344.113da927@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022112344.113da927@gandalf.local.home>

On Wed, Oct 22, 2025 at 11:23:44AM -0400, Steven Rostedt wrote:
> On Mon, 20 Oct 2025 12:48:07 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Oct 20, 2025 at 12:39:40PM +0200, Peter Zijlstra wrote:
> > 
> > > Yes, this should do nicely. I've made the changes, I'll do a test build
> > > and then push out to the robots.  
> > 
> > Ok, this now lives here:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git unwind/cleanup
> > 
> > Suppose this all comes back clean from the robots, where shall I merge
> > it? tip/perf/core, tip/x86/core ?
> 
> I've been basing all my perf work off of tip/perf/core, so perhaps use that branch?

Right, I'll move the pile over to queue/perf/core and once blessed by
the robots shove it into -tip.

