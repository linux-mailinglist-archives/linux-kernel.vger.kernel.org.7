Return-Path: <linux-kernel+bounces-753240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593EB1806D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890F81C25D06
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7E72367A3;
	Fri,  1 Aug 2025 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqtX865n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF102B9A5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045494; cv=none; b=Cmmz0wwLaj+ZySA7ViF+2MHu8Q0Pv47dfAa7ATLQxBg1YijsYIZJro4JLuxy7DSf7JG4oc0vxcEWdBBoX/UYpwSdZdftXod81AD6p/yKfOk3g8PU448YXSVa9Y97Hx05soQwBVcofmf+LSZAodcVNvboWUu71E4XPU/M85GuUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045494; c=relaxed/simple;
	bh=WPSglG3XGbB2wDw/Z59J8t68VBc0K9D4p90j2/nD11M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch33qcbF3slttARpsjsBpSWsxgY8TfA+YYflFny+kOiPvXWIKgCojMKGD1gNxgHug1DG5TNl4iZIlnseAZsYrRNkfnwGN7s4sGCg/HNieKjbKUBLDhkr0cgbc4lVkEGB16JsXCxA5BbryDliOxqjgD84XirlAePEdgn1PeOYRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqtX865n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754045491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=trEnncG2/S++UtO33faV1YMVFurJwgznDgyvzs7SHtU=;
	b=RqtX865niiKj176IZQsvIPmHfE0v+VU93unYaO19CM38TLw43ZVAOYy+tt6j57/QBRr6j1
	geVRxtEcZgy6FInrqebN2GIIoy0dy6OHghtecX8B3MxgNReR8VFubfrVvrdgbpK1WZ1uNk
	hESyQVWg03i6AoffZGxv7woA7V36+JQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-Bm6LSpqFNjSr6u5HpgC8KQ-1; Fri,
 01 Aug 2025 06:51:28 -0400
X-MC-Unique: Bm6LSpqFNjSr6u5HpgC8KQ-1
X-Mimecast-MFC-AGG-ID: Bm6LSpqFNjSr6u5HpgC8KQ_1754045486
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ADE9195609E;
	Fri,  1 Aug 2025 10:51:26 +0000 (UTC)
Received: from localhost (unknown [10.22.66.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 398EC3000199;
	Fri,  1 Aug 2025 10:51:23 +0000 (UTC)
Date: Fri, 1 Aug 2025 07:51:22 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Subject: Re: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <aIycKn9typGtfPuD@uudg.org>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801102428.GB27835@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Aug 01, 2025 at 12:24:29PM +0200, Oleg Nesterov wrote:
> On 07/29, Oleg Nesterov wrote:
> >
> > On 07/29, Luis Claudio R. Goncalves wrote:
> > >
> > > On Tue, Jul 29, 2025 at 01:47:03PM +0200, Oleg Nesterov wrote:
> > > > On 07/29, Luis Claudio R. Goncalves wrote:
> > > > >
> > > > > +	/* In !RT, it is always safe to call __put_task_struct(). */
> > > > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > > > +		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> > > > > +
> > > > > +		lock_map_acquire_try(&put_task_map);
> > > > > +		__put_task_struct(t);
> > > > > +		lock_map_release(&put_task_map);
> > > > > +		return;
> > > > > +	}
> > > >
> > > > FWIW:
> > > >
> > > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > >
> > > >
> > > > At the same time... I don't understand this DEFINE_WAIT_OVERRIDE_MAP().
> > > > IIUC, we need to shut up lockdep when put_task_struct() is called under
> > > > raw_spinlock_t and __put_task_struct() paths take spinlock_t, right?
> > > > Perhaps this deserves a comment...
> > >
> > > I reverted that code to the previous state, commit 893cdaaa3977 ("sched:
> > > avoid false lockdep splat in put_task_struct()") and simplified the "if"
> > > statement.
> >
> > Yes, yes, I see and I have already acked your patch.
> 
> So I think you should just resend it.

Thank you! I was a bit unsure on how to proceed :)
 
> s/LD_WAIT_SLEEP/LD_WAIT_CONFIG/ needs another discussion even if I am right,
> sorry for the confusion.

For what is worth, I tested the change with LD_WAIT_CONFIG and it worked as
expected.

Luis

> Oleg.
> 
---end quoted text---


