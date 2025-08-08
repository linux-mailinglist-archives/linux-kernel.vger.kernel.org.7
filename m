Return-Path: <linux-kernel+bounces-760298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69AAB1E920
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3981C22CDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4427C84F;
	Fri,  8 Aug 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hifD7ca4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCNPG+o3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFE277030
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659578; cv=none; b=GdizCip4yPdhpRY6C+qeiMWe5ufit9uovjLoKkvewecybwkNHSt0HvlrEdftlzCSwb9dcSiWlcSCEHdECzONqFRrNK+J80nk0E6hBHiexnUTkWfvlhH0rSaegi27Dg4R0/qbmSzDvGPfNi/c3/zFzhvLSQfsV+PKxoLI6XnWTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659578; c=relaxed/simple;
	bh=39al1NexIqrKmdTPGUa1EW4PW+6u95dBNZkq4xkcJg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oRF3cb34DJTKTflR/dIbUKgfMVg2JxIPsDmhtIk1ats4Ej2UI7+prbgqi2I9EznuP3zhk3dWWFIs++Q51ZQrifRg2mkx2nr5fKQtjL33b+1sv37VrZ8OrfpgDrQwc33FuFmVUj57nIPKjoIJZdqXiTSykZj3xBvEEdptF7JXwXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hifD7ca4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DCNPG+o3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754659572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzvMB3pLI43HpfkzDbtM+Z14vCKTlS7+hrho/lyyzjc=;
	b=hifD7ca4IWoPvyhuCg3p3w1WPo6Y+G0SkjxucDt29BYub4uePK8d+jN2LTaaDQcqVJViTK
	W7f/cIdtc1Zo2wxQZDFcGpNRgtJRqLwoNDFhxiwkQsD4IygCwKtIQVroHR7vuO7EMONILr
	Uobn+BYVyX0bzvEYXBYA2+VrHuJF+PZ1XBQe6lhZOmqNqgttdDeKJOPFQMRpCXVFKkH/yr
	z0mfXOC7dRmO5gS26eYCjhIYxYBQcyKoHJ3nu2D66eYyXatvkAafF+MTjIjoNdOjoYa9P7
	0htTtCLvfONPdSifAZD3gQmEDj9p/mhxdrj45rWzW4jEcjeI+3jKvEykf+l9lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754659572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzvMB3pLI43HpfkzDbtM+Z14vCKTlS7+hrho/lyyzjc=;
	b=DCNPG+o3vPveavKQQR0HMEKKEpYEIPwuvRGpxdTdIAxVjmKflDlSqZ5S1pG+2xbx1isYNy
	hHi8esFgPI7/LdDQ==
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, bigeasy@linutronix.de,
 kprateek.nayak@amd.com, vineethr@linux.ibm.com,
 prakash.sangappa@oracle.com
Subject: Re: [PATCH V7 09/11] sched: Add nodelay scheduling
In-Reply-To: <20250724161625.2360309-10-prakash.sangappa@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-10-prakash.sangappa@oracle.com>
Date: Fri, 08 Aug 2025 15:26:10 +0200
Message-ID: <871ppmc5cd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 16:16, Prakash Sangappa wrote:
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c

You forgot dl.c :)

> @@ -1027,7 +1027,7 @@ static void update_curr_rt(struct rq *rq)
>  			rt_rq->rt_time += delta_exec;
>  			exceeded = sched_rt_runtime_exceeded(rt_rq);
>  			if (exceeded)
> -				resched_curr(rq);
> +				resched_curr_nodelay(rq, rq->curr);

How is this possibly correct?

If the current task has nodelay set, then this means it asks not to be
affected by a slice extension of a lower priority task.

But that aside, I agree with Sebastian, that this is overly complex and
yet another TIF RESCHED flag is just horrible. We should avoid it in the
first place unless there is a real use case.

RT uses the LAZY flag for non-RT tasks, which means if the regular
RESCHED is set on RT, then we just go and preempt and decline the
extension.

If there is a real use case somewhere down the road, we can revisit the
problem later. Keep it simple for now.

Thanks,

        tglx


