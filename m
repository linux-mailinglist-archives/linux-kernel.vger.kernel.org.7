Return-Path: <linux-kernel+bounces-888315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B8FC3A7D7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 107F04FCF37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CB92F12DF;
	Thu,  6 Nov 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mjlctmqr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqVNTFD9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852AE2DF706
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427353; cv=none; b=J1R520xPzydUQWiXOZdTcpMhNVAw3nNZKpHr+Y2ZU/mq9apOpK+8BYq5qPgn+YeqZDDlC4SjI/sJOlUQJZLyNtg57x4ozPkUaneTTBp6a9awYCSOXk7tnCOKZBvJ7tDOubAr2xOjvj7+ZghxZI9pkzeaO64VaMYsBWXzswzvCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427353; c=relaxed/simple;
	bh=iTdjDsyl6HK/9oH27p0Yo36MYPhMMeDaKT3L8Rf385g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afe1ajqo2/5hU3o10kJRJUxJ5cdzjsU9qbPwXdcJ79VJxksJTmwzJSeTYl27uC5BOcmb47wWyiL9aGpz3enubCzStjImjClCnP77C7z4JRIhHBCb+0sGwMUNZ+gxftj7Rhw4+mW5jplG+pQBdfxFxRrtoQQaECY43Ew1yDLyveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mjlctmqr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqVNTFD9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Nov 2025 12:09:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762427349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XueThWvF3n5evZs+5r6yujTpYysUKTKrco+Wi+5HTV4=;
	b=mjlctmqrnu+YS/VRjlFTeAfTRJbZsNNF5PvWyKf2ZDfdGrTCXr7BwGue36+AEMCly/AdmH
	o+l9vyqK2VotU6ljfYBBYR0YPMEJzis5IOSuuMSdpAJ2VNqpd2Ipr+9+r0PNhzK/yiz/n4
	BEaN4rRLmXvA35EqObiquDL7jJg5hUqX3ZBcz6vIG6BSHQm5Vl5GGePUfDSTgsN07ucolc
	jToeqX82Dc6SCzZm9wKkR5GedsXj9VwtexBwL1jXFk3DdFHa+VMz+EzVAHfmfS9Qg7cxYK
	fb86OejcMSbZo/pmVnmIveAOHkIYvBWb1rDAuw/LanicG4D7Wg11dZR2e0vAlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762427349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XueThWvF3n5evZs+5r6yujTpYysUKTKrco+Wi+5HTV4=;
	b=xqVNTFD9zkkS3SQ0mfUpQVtDx0uqFwlVkEz/xQu/KGDtELiYsFtrTzpgd5zTIRmG7pMY9f
	HZE+bMQ7agBKghDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 0/6] futex: Use RCU-based per-CPU reference counting
Message-ID: <20251106110907.noLpnulw@linutronix.de>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
 <e0f58203-22ef-44c0-9f7b-b15c6007249b@linux.ibm.com>
 <20250715163134.pM1J2XO9@linutronix.de>
 <88edcfdf-2253-4563-a895-6e8bb1625800@linux.ibm.com>
 <20250716142946.GD905792@noisy.programming.kicks-ass.net>
 <ae8c6fd5-cc9c-44f3-a489-0346873f4be5@linux.ibm.com>
 <20251106092929.GR4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106092929.GR4067720@noisy.programming.kicks-ass.net>

On 2025-11-06 10:29:29 [+0100], Peter Zijlstra wrote:
> Subject: futex: Optimize per-cpu reference counting
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed, 16 Jul 2025 16:29:46 +0200
> 
> Shrikanth noted that the per-cpu reference counter was still some 10%
> slower than the old immutable option (which removes the reference
> counting entirely).
> 
> Further optimize the per-cpu reference counter by:
> 
>  - switching from RCU to preempt;
>  - using __this_cpu_*() since we now have preempt disabled;
>  - switching from smp_load_acquire() to READ_ONCE().
> 
> This is all safe because disabling preemption inhibits the RCU grace
> period exactly like rcu_read_lock().
> 
> Having preemption disabled allows using __this_cpu_*() provided the
> only access to the variable is in task context -- which is the case
> here.

Right. Read and Write from softirq happens after the user transitioned
to atomics.

> Furthermore, since we know changing fph->state to FR_ATOMIC demands a
> full RCU grace period we can rely on the implied smp_mb() from that to
> replace the acquire barrier().

That is the only part I struggle with but having a smp_mb() after a
grace period sounds reasonable.

> This is very similar to the percpu_down_read_internal() fast-path.
>
> The reason this is significant for PowerPC is that it uses the generic
> this_cpu_*() implementation which relies on local_irq_disable() (the
> x86 implementation relies on it being a single memop instruction to be
> IRQ-safe). Switching to preempt_disable() and __this_cpu*() avoids
> this IRQ state swizzling. Also, PowerPC needs LWSYNC for the ACQUIRE
> barrier, not having to use explicit barriers safes a bunch.
> 
> Combined this reduces the performance gap by half, down to some 5%.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

