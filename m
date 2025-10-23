Return-Path: <linux-kernel+bounces-867324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F52BC0243A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E021F4FBA45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642522580F0;
	Thu, 23 Oct 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkcLB/sK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617724D8CE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234916; cv=none; b=VPVgCM3JwK3ucxvYIanj0SrDdWN0/BfiWuSJcaeQV+gebTBKZWPur88+DC5PbZb8vF+cpzqT7RrOMcpEUVFFGSN5z9v97Zc69D0SVc0/WrW9nOgK1VTgQaVFhZwabgubkmC+nmh2ZKLrnLFRBzE5XsVh9hKZNS9iQ9j/xE5InKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234916; c=relaxed/simple;
	bh=9vRQsWTU1bGawr6sv7Czwt/5D0tPFpG9DS3UtxnsHts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUe85rTj6wPu2o3K6gZ7z6m2lGqJuctUEw5WSviQCqKmzcXkVoKCCsUk9vF4VAk5cB/JPY7ptv/LfljNnZ/tRk0G1VREeLjWxTxe0HNsEDDfagSKy6thXM67tM5iymG5bkjhRqfSrvu5UkYSLKdBW8rTe2m/0vVeLz7BQVxGaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkcLB/sK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761234914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7iSUgXoM0qVt7GRMqOCJs+1jLI6D2kNdaUPNd5OMOA=;
	b=XkcLB/sKm9NX5ieFiIbP+YUPq0UDbv4nw9/MR1XloEwEPpdVR743HcNVyRgqSwfBCb8MAF
	Zd4K3+w5HH/K8eJD1gVeXn9qsGq8m3KGmu0z5ajv99luwxENzTPBpVQI3vLowcaLqg6Y0/
	AUUDl7a7l5do73HDWci2LHnZB80GgkY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-K2K8AlH-Mc6kF6nGQ8tj0g-1; Thu,
 23 Oct 2025 11:55:11 -0400
X-MC-Unique: K2K8AlH-Mc6kF6nGQ8tj0g-1
X-Mimecast-MFC-AGG-ID: K2K8AlH-Mc6kF6nGQ8tj0g_1761234909
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3036E18001E4;
	Thu, 23 Oct 2025 15:55:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 06C39180057C;
	Thu, 23 Oct 2025 15:54:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 Oct 2025 17:53:49 +0200 (CEST)
Date: Thu, 23 Oct 2025 17:53:40 +0200
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
Message-ID: <20251023155339.GE26461@redhat.com>
References: <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20251020145310.GA9608@redhat.com>
 <20251023135316.1ZRx0UU5@linutronix.de>
 <20251023152942.GC26461@redhat.com>
 <20251023153750.C6EU9NL6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023153750.C6EU9NL6@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Sebastian,

sorry. I guess this is my fault, but I can't understand your reply...
Could you spell please?

Just in case, I will read your reply tomorrow.

Oleg.

On 10/23, Sebastian Andrzej Siewior wrote:
>
> On 2025-10-23 17:29:43 [+0200], Oleg Nesterov wrote:
> > Hmm. I'll recheck, quite possibly I missed something.
> >
> > But. From include/linux/spinlock_types.h
> >
> > 	/* PREEMPT_RT kernels map spinlock to rt_mutex */
> > 	#include <linux/rtmutex.h>
> >
> > 	typedef struct spinlock {
> > 		struct rt_mutex_base	lock;
> > 	#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > 		struct lockdep_map	dep_map;
> > 	#endif
> > 	} spinlock_t;
> >
> > > rt_mutex is defined as LD_WAIT_SLEEP but this one is not the one we use
> > > for spinlock_t.
>
> I may need to update the comment then if this is the source of your of
> confusion. The rtmutex.h header is required for the rtmutex bits which
> does contain struct rt_mutex_base which is used below you see.
> struct rt_mutex iself is not used here and has a different semantic
> (this one does use SLEEP).
>
> > Oleg.
>
> Sebastian
>


