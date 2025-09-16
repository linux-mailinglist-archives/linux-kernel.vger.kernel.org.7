Return-Path: <linux-kernel+bounces-819434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547A4B5A094
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55293AFA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D722C11E9;
	Tue, 16 Sep 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dY3xQnWF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C72BD58A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047714; cv=none; b=bRo5YK/9YATXzwUCJSi5n0/gIkXwFCt0rY6OSeggl4PqNta9TN4F4vlz0m8RN6eSm2CQSc+Q269czB/uT9Bom/+IGCpT+/x5QCFMw2U6eyOx26Gwl/6hdHrIXv+X8JVKOmY+P4Aa74Z5sARDK17Z3Shr00Q9ofOxhiidn88PKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047714; c=relaxed/simple;
	bh=p2L+BoGjF7funf1kKzdI2zSzLPq5TYcZXKpLPTIH8Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlVPLf/9Syc8vVlDVHG0iUznYPX2lrF5+EJBYPu450IbX36otNlLnYXAnZ/HKo4ifEPEDSox5x9KoEMSkF0kgblJg9juc7k/hteWT2eIIc/UT0uRXGXsvxum+PRjqnATLbzlrSFORafFmU4uRoeXNgvtQ3pp6otnAMsfB/XSivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dY3xQnWF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5rkvZwt85N53PHekOoIC3Lo9zWtABx+bQZ+hiuLk1wg=; b=dY3xQnWF/2ii/HdaPXcRLU7fY9
	4YvgPSlZfO/cmb3NwOBlJdMgH8Z8P60HTEQkJx+H4S4kjmK3lILP0EWwxsyhOwvHitoVtezXJ79aR
	5GPTc6uoHkmz7KLQXTlHjmoY0fJfeodm4erslkE5qXiwZT1McT8GkWCnWrbLG8KC8ZinbNAb0H4c+
	3W8U9Keoml7w3+WdQboVCJDniMDRysLs1d+LPkWbRUrxPchXxLPnspgw4YcufZOYnQftROFngWJZY
	FufktfRb8RJXj/aGPHYNjt8LtDQ7TiuR4ag0SAart9spW3lJxQJjxQYyperjyqlMUumbz7HNH2s5n
	+Wvj1BPg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyaW7-00000007FhL-3D0e;
	Tue, 16 Sep 2025 18:35:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9ED8A300328; Tue, 16 Sep 2025 20:35:02 +0200 (CEST)
Date: Tue, 16 Sep 2025 20:35:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Andr?? Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 0/3] selftest/futex: Collected mpol fixes
Message-ID: <20250916183502.GA2800598@noisy.programming.kicks-ass.net>
References: <20250915212630.965328-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915212630.965328-1-bigeasy@linutronix.de>

On Mon, Sep 15, 2025 at 11:26:27PM +0200, Sebastian Andrzej Siewior wrote:
> I collected Andr??'s two mpol related fixes and reworded slightly the
> description of #1.
> Patch #3 was also on the list for a while and now does no longer apply
> so I rebased it on top.
> 
> Andr?? Almeida (2):
>   selftest/futex: Make the error check more precise for futex_numa_mpol
>   selftest/futex: Reintroduce "Memory out of range" numa_mpol's subtest
> 
> Sebastian Andrzej Siewior (1):
>   selftest/futex: Compile also with libnuma < 2.0.16
> 
>  .../selftests/futex/functional/Makefile       |  5 +-
>  .../futex/functional/futex_numa_mpol.c        | 61 +++++++++++--------
>  2 files changed, 40 insertions(+), 26 deletions(-)

Queued these for tip/locking/futex, if they were intended for another
branch, please holler.

Thanks!

