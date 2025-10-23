Return-Path: <linux-kernel+bounces-867288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F21C021F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7E624F2070
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0FB32ED29;
	Thu, 23 Oct 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGzphJdr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8F306B06
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233481; cv=none; b=fwd+gI7eWX1bakRFqhfqNJPxaK3pyfZX0xIge15ekYh/Kw8gHXIi8hZn8b5KceD190AVCY6PXqQpmVIwIxtCD5kw9PMFidFjtzGea6L5yYaHRze1FkqbHM95STNp5+rZX98er5L4o0NacCnrCxsMcPw+oQ4tlvrdlrhUiuWy2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233481; c=relaxed/simple;
	bh=R/cQYVsqxroQX2KF38Lpi1wY6/SZ34iDsH0OQluS+M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoWwB9ehCyaf8vKufPIGHwtdMcCEBWcw5Bf7iNPhofMxqUxlZO8+Osfe0UOPY9nHDLSQFw8Gyua2BncTa2SwlOQHp/4sv/3zmv+zmibNFNoNOI4tssuEaKz9vPVzyd1qXn6etxrBrcHp57h7fdlAcNjRUK/pKmQasPR8TZzxZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGzphJdr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYNyTZdPSO1+EdVNImtZojSgxA1u0MZm8NZmU9klkxQ=;
	b=iGzphJdrsEF94D5wyRD8NxTJpPYko8WJ+1YBIebE7KzxEkObder4aYP9uxSQjJdvVmeS/N
	HeX/nJFO4pry2kpWvtLN0qnB4AGEiRwPvpBhDPIaJiDSQOXKUCp7slJoJ7CFYt0GLs+f2G
	nMcv8HatNe1kcMyZ4x0DCHcNv90bUDs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-N2Kx_z8jNi69VvS1EyQDdA-1; Thu,
 23 Oct 2025 11:31:14 -0400
X-MC-Unique: N2Kx_z8jNi69VvS1EyQDdA-1
X-Mimecast-MFC-AGG-ID: N2Kx_z8jNi69VvS1EyQDdA_1761233471
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACB72195608A;
	Thu, 23 Oct 2025 15:31:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CD89130002DB;
	Thu, 23 Oct 2025 15:31:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 Oct 2025 17:29:52 +0200 (CEST)
Date: Thu, 23 Oct 2025 17:29:43 +0200
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
Subject: Re: usage of DEFINE_WAIT_OVERRIDE_MAP(LD_WAIT_SLEEP)
Message-ID: <20251023152942.GC26461@redhat.com>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20251020145310.GA9608@redhat.com>
 <20251023135316.1ZRx0UU5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023135316.1ZRx0UU5@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/23, Sebastian Andrzej Siewior wrote:
>
> On 2025-10-20 16:53:10 [+0200], Oleg Nesterov wrote:
> >
> > If CONFIG_PREEMPT_RT=y and preemptible() is true, LD_WAIT_CONFIG won't work.
> > lockdep will complain if fill_pool() takes a spinlock_t, spinlock is
> > LD_WAIT_SLEEP on RT.
>
> Where is this? This is then wrong then because _SLEEP is for MUTEX and
> those things that sleep-sleep and pretend to sleep.
>
> spinlock_t should be LD_WAIT_CONFIG. This is used in
> include/linux/spinlock_types.h via SPIN_DEP_MAP_INIT which is only
> defined once as LD_WAIT_CONFIG.

Hmm. I'll recheck, quite possibly I missed something.

But. From include/linux/spinlock_types.h

	/* PREEMPT_RT kernels map spinlock to rt_mutex */
	#include <linux/rtmutex.h>

	typedef struct spinlock {
		struct rt_mutex_base	lock;
	#ifdef CONFIG_DEBUG_LOCK_ALLOC
		struct lockdep_map	dep_map;
	#endif
	} spinlock_t;

> rt_mutex is defined as LD_WAIT_SLEEP but this one is not the one we use
> for spinlock_t.

see above...

> What you want to have working in the end is the following scenario:
>
> |static DEFINE_SPINLOCK(lock_spinlock);
> |static DEFINE_RAW_SPINLOCK(lock_raw_spinlock);
> |static DEFINE_RAW_SPINLOCK(lock_raw_spinlock2);
> |
> |static void lockdep_test(void)
> |{
> |        static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_CONFIG);
> |
> |        raw_spin_lock(&lock_raw_spinlock);
> |        lock_map_acquire_try(&put_task_map);
> |
> |        spin_lock(&lock_spinlock);

Yes, but this won't work on RT? Again, I didn't check (yet), possibly I am
wrong...

> This will work. On RT as well but is wrong and will not happen due to
> the preemptible() check. On !RT it will so you want lockdep to be quiet.

See above and please correct me.

Oleg.


