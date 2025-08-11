Return-Path: <linux-kernel+bounces-762388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23CCB205E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70173ADADD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59432367C9;
	Mon, 11 Aug 2025 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKyp5XTt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815312343C2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908922; cv=none; b=HEpIR4k1FXpWUlsjMxz0Hs7iMX/SVI5hY9HkrvVjsiA1TjfpJjH4NpJHk4rX4QPUFBhdRG2AuNXENTVdMCSMi9k0Sjjixg4Sz6Qyhw3WtBnXFrqd2wIj7034NuYi6tLeT2NouxudRS69iy9dYMEDJauK8F6lcRMGpy5LyYND0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908922; c=relaxed/simple;
	bh=oUUPBFt8iPQEt8wtHKfQYq4KaOfu60yp7zYZFd7eCH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwCt/VL4kXRxWUS/boqU0spnl9sNX8BtNjkbRXfHrACj8eaqdphND2xvyUbafk4nX3dHafJbwn4WaPUqdir9EubdOhvE00s4I8kvsaRz5lTR+HItdO6KA597Go5ikA2Ifz6n86uu5R/cmDIbirtwKHiK5RvFdoI4bvbnAsdsKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKyp5XTt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754908919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Mf+fEKLcRqF2Lbn8B1ER4v3t7yfNx1UEpVwuNnQTTs=;
	b=FKyp5XTt1kqlg0x2coQOxiWBWzwRAPyf0I2jlpkGU6pf81KWGkCF/+gTHmGwDVBK2BkkfE
	ZkGFL8mw6VJ+dYORHGyAPB6yPTEDxLqVmaoA3rdwOcLFzKE7UmRAr6o2wO301gL+4/7CQV
	K14iFtGpWEqMYlxmV3Mye/HiReqRpGA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-pC-M_UN9OVqUAWD6nHCYlA-1; Mon,
 11 Aug 2025 06:41:58 -0400
X-MC-Unique: pC-M_UN9OVqUAWD6nHCYlA-1
X-Mimecast-MFC-AGG-ID: pC-M_UN9OVqUAWD6nHCYlA_1754908916
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB11E180047F;
	Mon, 11 Aug 2025 10:41:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BB56E180044F;
	Mon, 11 Aug 2025 10:41:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 11 Aug 2025 12:40:43 +0200 (CEST)
Date: Mon, 11 Aug 2025 12:40:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20250811104033.GA5250@redhat.com>
References: <aJOwe_ZS5rHXMrsO@uudg.org>
 <20250811100624.LuYV-ZuF@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811100624.LuYV-ZuF@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/11, Sebastian Andrzej Siewior wrote:
>
> I don't want to drag this but this comment is obvious for anyone who is
> fluent in C. It is just a statement with no explanation.
> An important note would be that the atomic context restriction only
> apply to PREEMPT_RT and therefore we have this context override for
> lockdep below. The other question would be why don't we do this
> unconditionally regardless of PREEMPT_RT. The only reason I could find
> is that releasing the task here from the "exit path" makes the vmap
> stack "earlier" available for reuse.

Sorry, could you clarify your "other" question?

What exactly do you think we could do regardless of PREEMPT_RT?

Oleg.

> 
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> > +
> > +		lock_map_acquire_try(&put_task_map);
> > +		__put_task_struct(t);
> > +		lock_map_release(&put_task_map);
> > +		return;
> > +	}
> > +
> >  	/*
> >  	 * Under PREEMPT_RT, we can't call __put_task_struct
> >  	 * in atomic context because it will indirectly
> > @@ -137,10 +150,6 @@ static inline void put_task_struct(struct task_struct *t)
> >  	 * current process has a mutex enqueued (blocked on
> >  	 * a PI chain).
> >  	 *
> > -	 * In !RT, it is always safe to call __put_task_struct().
> > -	 * Though, in order to simplify the code, resort to the
> > -	 * deferred call too.
> > -	 *
> >  	 * call_rcu() will schedule __put_task_struct_rcu_cb()
> >  	 * to be called in process context.
> >  	 *
> > 
> 
> Sebastian
> 


