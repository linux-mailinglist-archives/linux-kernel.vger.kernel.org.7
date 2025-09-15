Return-Path: <linux-kernel+bounces-817343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A60B580F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE7177D78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937D23B605;
	Mon, 15 Sep 2025 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RiNhsm8j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ULRprKS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DBD23ABA0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950316; cv=none; b=j57YixvRGSHoZ2RyU6Yxfqc1KQeCA4nLDCMEccGP17e4Eor2EmmAqj56xSK1fOzcPL2OexdNerR04rKG0XC1L/hnDpalnroyvu0eUrQ3F9C19KSpEyYLkJUrH/A33LX2tIntiMBM+K2WHJPAercPL8Tj6RtpBGGH0hTqawvS4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950316; c=relaxed/simple;
	bh=iFihoKHZq4DfQWQgGJvrxJfcyMRoyDvnvVIvIAiilFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMg2K2xs/ka43ixu3cZQtEwOzIKbUspis9XQ3l/IN6qjNhp60YBtbqLztOECoeWLC4jwFHx/bDZWIZroSiWUqOxArZqU2NDuPrJDX07E2Mh+PVX3mcPbFO9NzO7k9kSTzf8ZlWY0Ocob0GWG+rwFmVVnN5Dkb6S6iAFHdtrzlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RiNhsm8j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ULRprKS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 17:31:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757950312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16BPyb79WnSLgcLqvDIXMPPG6yOIETfT08w7CMnijGM=;
	b=RiNhsm8jJ8rTarD0TPzxSlAxgSDixb0CZN/qNT1ZY+1b/PxmeRiPMalH+zxejmCafjWkNq
	LWAZWZRWDqJyFhXtXbvvEYgWrBkuo+gj2NLI224Cnnnql5wwyAF5nH0Y1QPfKibqXn7wVH
	yZUcjMzbIZ97/xF789KG3UodW8CUaPUrAFfaNNsIW5ShRwCpeuZ3vfHHct+HAr6YX87xXp
	iWXG4c6h7Uzmz9mQnE5r23+xJiETe8GmSG60IBt5OPFPvEDS5BxiIAHBymKJjm2+pcWtiH
	p9bifu3hsplNiaHAxed7fFNCbub3JHwWHgYL0XVkB8Ktn2KUKo2Ua9V9Eu19JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757950312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16BPyb79WnSLgcLqvDIXMPPG6yOIETfT08w7CMnijGM=;
	b=1ULRprKSedyefkPqzebhK+AoHbxwXKUOdMaIh4bSlrgObXlqoigoeVG20IbOyBpaCREjxq
	s8AsX8YmxFFenxDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RESEND PATCH] sched: restore the behavior of put_task_struct()
 for non-rt
Message-ID: <20250915153151.fPHJU6-d@linutronix.de>
References: <aMf1RzZHjdoPNOv_@uudg.org>
 <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
 <20250915122444.Gg_Tsymz@linutronix.de>
 <aMgngWdtqUKuqLcw@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMgngWdtqUKuqLcw@uudg.org>

On 2025-09-15 11:49:37 [-0300], Luis Claudio R. Goncalves wrote:
> On Mon, Sep 15, 2025 at 02:24:44PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-09-15 13:38:12 [+0200], Peter Zijlstra wrote:
> > > Right, but I thought we did want to make this behaviour consistent.
> > 
> > That is correct, that is what I asked for (either consistent or a
> > compelling reason why not).
> 
> I received a ping from colleagues investigating a problem possible caused
> by excessive pressure on RCU and this change could make the problem worse.
> But last I heard from them, sounds like the problem they are investigating
> lies elsewhere.

Either way, if this change introduces a problem then it affects RT as
today. So we should deal with this. If it is not a problem and it just
put pressure on an existing problem then it shouldn't be an issue.

> Luis

Sebastian

