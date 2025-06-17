Return-Path: <linux-kernel+bounces-689943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC8ADC8B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 12:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4302B16D955
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D962D12E3;
	Tue, 17 Jun 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afpqtohj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9302192EA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157597; cv=none; b=euGikEMfTp4+PO6JgYxgqBCSpZRrflTCIXGMhK+mVpjE3bysDY2AO4E2eHSxeXhdF02noIN7kPA5AeJ4THwNv+Obuv9oIS60b064N/TxbPmSzWkhJUiZd6zrOtB4qZwsrjT1hj+ZcDy2P/L4Pqce+CjHzBnyTLwfzbUVdXOVboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157597; c=relaxed/simple;
	bh=UgCGhu7fYeMI4mIfoFDow90naCmWaWja5M31mu4hz14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoSUseeOPei1PKaPRlnP2gKd8YBUPSyBsMoSuJhOxOxkCw2+yN6DecOpy1RvGL/IQzMG3tFmJgdFrSlmH8EviD0AbrRDVEQkiugyNYZobIPASHi4iYQmnOq22miNs1QRJ3iEmDWF+/kMiNicdAJ5tkKk8BY0RQnK34RxTEdtkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afpqtohj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750157594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0ncJVs04Al38TEGKEfhY3VBsmgJ1MjE0cgapDAotLM=;
	b=afpqtohjLqRluzD7ApFR5xi0H0sgk2mPQdFcU1qHnyHlwXMknyC+fnULHz4CelrIM8b/cp
	mZhJ+UInFXI4gvkg7BeDGzvhOfIYy63/90Tj19iQw7yMR8O54YrF2yjjlgmSQwZ5oDn1ky
	abRwDdooCn7qDbqoCJJNqUj2Fw32b3c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-Nf1SH4g6PqWzvE_XXZcHWA-1; Tue,
 17 Jun 2025 06:53:09 -0400
X-MC-Unique: Nf1SH4g6PqWzvE_XXZcHWA-1
X-Mimecast-MFC-AGG-ID: Nf1SH4g6PqWzvE_XXZcHWA_1750157587
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43ED21955F45;
	Tue, 17 Jun 2025 10:53:06 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CD2D18002B5;
	Tue, 17 Jun 2025 10:52:56 +0000 (UTC)
Date: Tue, 17 Jun 2025 07:52:55 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, David Vernet <dvernet@meta.com>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>, DietmarEggemann@uudg.org, 
	dietmar.eggemann@arm.com, Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH v4] sched: do not call __put_task_struct() on rt
 if pi_blocked_on is set
Message-ID: <kq6edcqhqwzy25y4uurbjkty6r3vzmz74wizmmy4vxu6rvofvk@opm4sjchvegc>
References: <aEw-KjUjjP2gYH6z@uudg.org>
 <20250617092609.GR1613376@noisy.programming.kicks-ass.net>
 <20250617093627.ykSeZMqk@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617093627.ykSeZMqk@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Jun 17, 2025 at 11:36:27AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-17 11:26:09 [+0200], Peter Zijlstra wrote:
> > On Fri, Jun 13, 2025 at 12:05:14PM -0300, Luis Claudio R. Goncalves wrote:
> > > With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> > > from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> > > with a mutex enqueued. That could lead to this sequence:
> > > 
> > >         rt_mutex_adjust_prio_chain()
> > >           put_task_struct()
> > >             __put_task_struct()
> > >               sched_ext_free()
> > >                 spin_lock_irqsave()
> > >                   rtlock_lock() --->  TRIGGERS
> > >                                       lockdep_assert(!current->pi_blocked_on);
> > > 
> > > Fix that by unconditionally resorting to the deferred call to
> > > __put_task_struct() if PREEMPT_RT is enabled.
> > > 
> > 
> > Should this have a Fixes: tag and go into /urgent?
> 
> I would say so. I'm not sure what caused it. I think Luis said at some
> point that it is caused by a sched_ext case or I mixed it up with
> something. Luis?
> 
> The other question I have, do we need to distinguish between PREEMPT_RT
> and not or can we do this unconditionally?
> 

That's something I had been wondering myself. However, since this code
runs in multiple places, I was concerned it might trigger some obscure
corner-case issue. In any case, if we decide to remove the
PREEMPT_RT conditional, I’d prefer to handle that in a follow-up patch.

> Sebastian
> 


