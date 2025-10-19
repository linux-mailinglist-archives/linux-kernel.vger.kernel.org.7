Return-Path: <linux-kernel+bounces-859853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56010BEEC4C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 22:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBB51898ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE2221D96;
	Sun, 19 Oct 2025 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TrsUfLnW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pXBHoDel"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A4220698
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760905979; cv=none; b=ls549l1q8lPKoUQDAIG4RBTfLR+axK55ChT7+vbSLUM5QInkAGdziIj0yqwsr8ZOHO4kSIcfLiX9Iaz1noLVIpbL6uBCZbX3nLAzcm+V9EXH+Sm2TbntgYqyW2Wgq+rv1FZdVuf78EOEO2ExF+lER8sdRV0xrcXEm3q8Tt10pHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760905979; c=relaxed/simple;
	bh=M46DAMpFg9erMnI3iAG1NlfTiFTXJJ1gkg8xpNq/6T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X/BqjWZXIgKL8ol67ooVbc1vwVIyKZjOUnRnrsnQY13yyEYGHik2zCu5krTYHrbpl2uPjxgckuNb8Rcu3u6wvPGu45ItSxWy6gj/g7OxookS1qBf3S/kYzwLuR8r93rxaSHrftj5hTTYnB7UqMYq0TNKNoiTR38Osi5ZDnUqgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TrsUfLnW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pXBHoDel; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760905969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9/6cp3d1pt/fAhE33yIlBlIeD2BPu+PjAbaWRkKVcE=;
	b=TrsUfLnWhft5KsNJGBnLRQlOkT5qGxsrkKWBp2ONDeYh8I11Rx6UfuFPFt1QFgW+1BKDTJ
	pTttFVLHH8RrFOWfur8MQH/zkbGw9rvuxBmals6p1EmKjbTH/hK5cy/CYOLNsN2bSG6HrC
	zIv03ndsBT9lYYhrD7RS7l5pzf3/Ma2hqx7XlTgXD86wpyddAwQhQh/DhhMMN10qUg05rM
	LG3Yl+bGwUsFGsccXioeXQhZYLxjK/BVWw73rrH64mxZGz2L5L1zpj6dCiQVjq0wpUB0rf
	QEmYW9ej/TEQE9J/TVVo94I+jDj7CxNyJzoWhnuQAvXvy++cOzXMy9ZfXUd1Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760905969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9/6cp3d1pt/fAhE33yIlBlIeD2BPu+PjAbaWRkKVcE=;
	b=pXBHoDelLaJ8Ue34ff9cuEsOjZU1NmGhggnd0ir9fXeUeJASeRMlSYOU/vR/Q0UcbqFF0k
	xhODFPI01ctqMNDQ==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 06/19] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
In-Reply-To: <20251017181911.GR1386988@noisy.programming.kicks-ass.net>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.694547089@linutronix.de>
 <20251017111223.GD4067720@noisy.programming.kicks-ass.net>
 <87y0p9zo9y.ffs@tglx>
 <20251017175853.GH3419281@noisy.programming.kicks-ass.net>
 <20251017181911.GR1386988@noisy.programming.kicks-ass.net>
Date: Sun, 19 Oct 2025 22:32:47 +0200
Message-ID: <87jz0qzl74.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 17 2025 at 20:19, Peter Zijlstra wrote:
> On Fri, Oct 17, 2025 at 07:58:53PM +0200, Peter Zijlstra wrote:
>> Same is true when you offline a CPU come to think of it.
>> 
>> Same is true if the cpumask is sparse.
>> 
>> Anyway, just saying, checking against nr_cpu_ids might not be the best
>> shortcut here.
>
> Put another way, nr_cpus_allowed == nr_cpu_ids only work when none of
> the masks involved have holes. The moment anything {possible, present,
> online} has holes in, it goes sideways.

You're right. I was too narrowly focussed on the normal x86 case, where
nr_cpu_ids == num_possible_cpus ....

Let me think about that.

