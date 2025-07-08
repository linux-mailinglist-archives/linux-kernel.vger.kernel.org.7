Return-Path: <linux-kernel+bounces-722245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C98AFD6D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCD63A6604
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34872E6D0D;
	Tue,  8 Jul 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SYzKH4Aj"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2F2E6133
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001580; cv=none; b=r+Y9wdzxg/oXW7aUL/S3h9PfUQQNlzqfk9WHdLr0AFyqWBnL9860rpHWS+/KKBllmCANB+T8ApS5pdQQScTPLEGbx6TwUHIRu4cDo6Q2PQ0cYp5yvlDGqC4X85rYFhe7w8yp7VujJi4SB/E4vN0Izs4bC4yYl1FqdtoRJ4G0v0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001580; c=relaxed/simple;
	bh=/oO1VIqV+g791567elBb8/PEB2Jkw3ZD1KrBA8jdSi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbybMNkWTeiyy+mlkj9vkYlY1p8J7RXYf64AFxmFWMjM5SApPxXFNqaFnMgI43Rv0c7xu7pkvHsFkrTmXF5MZizCQg3tY1Dqj+mgmLePCEC3a8+hg8kvI+TQQ+ia52UlvfSyCI+bKUxFcIyoPBI0ORToB0KPv59YPglDNWZNc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SYzKH4Aj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rK0DYVjMLwpRkov2sjTi2xYgBCQul0YUIiQ98AlA+wM=; b=SYzKH4Aj77pIAreKmPLGuRb8A9
	EEHd4kSVfomxh6+nm8XzgdTcgNQ3xd+kvmaJW7fpzOoW3+Y3yXoe6ekP9HX72hROEd7SaVrVOTvb4
	lmkmeiigqlwtI3P6zZ4xlP92zCAMnznmqlV8OxW839o42SLf1+BGo/OmkcLw9u3bV0d6Uh7/z5hsq
	j+hwfWmjh0rvLPdoAej2VdSQo3dgbW0Uiws52gXozBpks9w3dQGda2eJDEez+08nQ/3CogNwQihU8
	G+FJInWTV6ljkpIUuIQxZCzPsllkrHzjU69+foPyfbJEah6r1A2mWKJD+Uz4DyqpGdA4FSxJoiauo
	ppMED3Jg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZDdm-00000008mSH-0mX3;
	Tue, 08 Jul 2025 19:06:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BA01D30029B; Tue, 08 Jul 2025 21:06:05 +0200 (CEST)
Date: Tue, 8 Jul 2025 21:06:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
	Andr?? Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
Message-ID: <20250708190605.GF477119@noisy.programming.kicks-ass.net>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250707143623.70325-3-bigeasy@linutronix.de>
 <2f0fc991-0e70-4bb3-bdcc-f87293cb6471@redhat.com>
 <20250708134708.Rgh8nHcx@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708134708.Rgh8nHcx@linutronix.de>

On Tue, Jul 08, 2025 at 03:47:08PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-07-08 09:43:44 [-0400], Waiman Long wrote:
> > This looks somewhat like what the percpu refcount does (see
> > lib/percpu-refcount.c). Could this be used instead of reinventing the wheel
> > again?
> 
> From the comment:
> 
>   * futex-ref
>   *
>   * Heavily inspired by percpu-rwsem/percpu-refcount; not reusing any of that
>   * code because it just doesn't fit right.
>   *
>   * Dual counter, per-cpu / atomic approach like percpu-refcount, except it
>   * re-initializes the state automatically, such that the fph swizzle is also a
>   * transition back to per-cpu.
> 
> but I leave it up to Peter if he considers merging that.

Basically what the comment says. Trying to reuse things ended up in a
mess. It really isn't much code, most of it is comments.

