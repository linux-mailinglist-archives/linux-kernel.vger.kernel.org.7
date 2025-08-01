Return-Path: <linux-kernel+bounces-753215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B85CB1801E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806BB173BCA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8E2367A8;
	Fri,  1 Aug 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RppKjpFi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ED61C3306
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043956; cv=none; b=Cfbg4j550PP2PHayIUuSH5ZJDTCajkGiAhZ/OEUTL8oC3L1Z7+j1ykDlgP40AZKTqs3/Mqzpg0ISLqdz4zl5pIrkZ1J1v3dg5Ko542e5IcrVHCHCcMNkOkNXqoIuneFZ5p9w7h5l0yWHh41fRbfbhCWBkjgfhZuZcbagor0e0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043956; c=relaxed/simple;
	bh=hapeyy6ZUbsbldLETwPLW02PG29HLqTfMFCCw/DwPiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or5d77Ua55koeo970M7aIk9a+hUg3wtzaCqoZdo9fBtikvflkr2ARrqSqvOoSe4T/gBAbGhR2eDXfJkm4rYVk1mTLHSRQkzteDf8LWAglmfv9mq5vz4FFpAH4AMFo2D2CcGldcWvNGJNg97QStINn/Ugc64j+W3uUVYZaYBGfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RppKjpFi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754043953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fBy/ubE+PTLysJPtmvIHw7wyj6tGguI9dSijz7MCsA=;
	b=RppKjpFifgqLL9RgLoGuKSBRru6P6so7mays0/3v3QcZ2j5VCr+YvqwjGUqRmhR1Up44ls
	OAw+gG6HNfLZ0mvBI1o0be0CBTDhO3oeELyThnTO4fdFQpc9YFrVlIAPMzJCp6lanDKh/B
	5fqW+FYVS3hnOZD/JCd0X5H0AYBV8HM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-DAHlOX1YN0GXCAgaD-eg1w-1; Fri,
 01 Aug 2025 06:25:50 -0400
X-MC-Unique: DAHlOX1YN0GXCAgaD-eg1w-1
X-Mimecast-MFC-AGG-ID: DAHlOX1YN0GXCAgaD-eg1w_1754043948
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFC591956094;
	Fri,  1 Aug 2025 10:25:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.194])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A19F718003FC;
	Fri,  1 Aug 2025 10:25:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  1 Aug 2025 12:24:37 +0200 (CEST)
Date: Fri, 1 Aug 2025 12:24:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
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
Message-ID: <20250801102428.GB27835@redhat.com>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729130936.GB18541@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/29, Oleg Nesterov wrote:
>
> On 07/29, Luis Claudio R. Goncalves wrote:
> >
> > On Tue, Jul 29, 2025 at 01:47:03PM +0200, Oleg Nesterov wrote:
> > > On 07/29, Luis Claudio R. Goncalves wrote:
> > > >
> > > > +	/* In !RT, it is always safe to call __put_task_struct(). */
> > > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > > +		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> > > > +
> > > > +		lock_map_acquire_try(&put_task_map);
> > > > +		__put_task_struct(t);
> > > > +		lock_map_release(&put_task_map);
> > > > +		return;
> > > > +	}
> > >
> > > FWIW:
> > >
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > >
> > >
> > > At the same time... I don't understand this DEFINE_WAIT_OVERRIDE_MAP().
> > > IIUC, we need to shut up lockdep when put_task_struct() is called under
> > > raw_spinlock_t and __put_task_struct() paths take spinlock_t, right?
> > > Perhaps this deserves a comment...
> >
> > I reverted that code to the previous state, commit 893cdaaa3977 ("sched:
> > avoid false lockdep splat in put_task_struct()") and simplified the "if"
> > statement.
>
> Yes, yes, I see and I have already acked your patch.

So I think you should just resend it.

s/LD_WAIT_SLEEP/LD_WAIT_CONFIG/ needs another discussion even if I am right,
sorry for the confusion.

Oleg.


