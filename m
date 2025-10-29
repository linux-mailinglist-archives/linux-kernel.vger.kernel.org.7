Return-Path: <linux-kernel+bounces-875001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75BCC17FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A3E1A252C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8AB2EC094;
	Wed, 29 Oct 2025 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M300f0Mi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B72EAB71
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703284; cv=none; b=C2HJwc8pNR+nNBvN0/H46rlw3umZBUXxoEzYTrwe7h/Hhvke32qk5aMLVEydpZ7vvQ6vZZDvBwX7kzCVMMPsljKaoOhOiELxWYe/NbHRO82v5FkwLCzO4R70YgvT66M5loJZWyOun2JdjJd/5ONHN9JiGL3cjyllMHrnliaIMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703284; c=relaxed/simple;
	bh=SXQxPsN26Co6NKBGJZdxYDwuDG6nvbInjqG4fC87DO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkX7bjyZcx9zZeevMqOJ2G354bKduEs1nRwlycsHuW02mVXwK97ENQHRuQxPDmZcQNPUpccelaYy3WKkzaxECJYpzqgA7U9HeUfPFdomKnGbk1jC7PDWdaE2yNGmUYn3IsVjabHGVuIS9qn/wbEgidprQDKLISu8Sv8qQ7+++RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M300f0Mi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761703281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYTH6r4pMzG++s76D15s6Jao2UHZD14Avc7KSLviCz4=;
	b=M300f0MiNNDaoysVDb0vl+cSLCUnaLrK+a1zZhn7VqvgUNbmRVzAHTkQcetB9IeHCfac8z
	AqPevGANYtCrCkMMJrRltcwEEJgVJCAh80MSOmZIlQXFTuhqJ0KL9+lsAMQddsOylc4sY5
	FmiUg7/JaUPZyqQMVfZN/C17bImTdyk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-BuRRDu5BMS6XHxBgXgGynA-1; Tue,
 28 Oct 2025 22:01:18 -0400
X-MC-Unique: BuRRDu5BMS6XHxBgXgGynA-1
X-Mimecast-MFC-AGG-ID: BuRRDu5BMS6XHxBgXgGynA_1761703276
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E4A519541B7;
	Wed, 29 Oct 2025 02:01:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.80])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E3FD180035A;
	Wed, 29 Oct 2025 02:01:12 +0000 (UTC)
Date: Wed, 29 Oct 2025 10:01:09 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHv2 2/2] kernel/kexec: Stop all userspace deadline tasks
Message-ID: <aQF1ZZfjLBXuRl-s@fedora>
References: <20251028030914.9520-1-piliu@redhat.com>
 <20251028030914.9520-3-piliu@redhat.com>
 <20251028163911.98990cbf1516d1c6d221f92b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028163911.98990cbf1516d1c6d221f92b@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Oct 28, 2025 at 04:39:11PM -0700, Andrew Morton wrote:
> On Tue, 28 Oct 2025 11:09:14 +0800 Pingfan Liu <piliu@redhat.com> wrote:
> 
> > Now that the deadline bandwidth check has been skipped, there is nothing
> > to prevent CPUs from being unplugged. But as deadline tasks are crowded
> > onto the remaining CPUs, they may starve normal tasks, especially the
> > hotplug kthreads. As a result, the kexec process will hang indefinitely.
> > 
> > Send SIGSTOP to all userspace deadline tasks at the beginning of kexec
> > to allow other tasks to run as CPUs are unplugged.
> 
> This all looks a bit hacky.
> 
> What's special about kexec?  If many CPUs are being unplugged via other
> means, won't the kernel still hit the very problems which are being
> addressed here for kexec?  If so, we should seek a general fix for these

No, they are in different situations. For normal CPU hot-removal, the
deadline bandwidth validation will prevent the CPU hot-removal if the
bandwidth requirements are not met. But in the kexec case, there is no
way to roll back, so it must try its best to proceed. That is why the
previous patch is introduced.

> issues rather than a kexec-specific one?
> 
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1132,6 +1132,18 @@ bool kexec_load_permitted(int kexec_image_type)
> >  	return true;
> >  }
> >  
> > +static void stop_user_deadline_tasks(void)
> > +{
> > +	struct task_struct *task;
> > +
> > +	rcu_read_lock();
> > +	for_each_process(task) {
> > +		if (task->policy == SCHED_DEADLINE && task->mm)
> > +			send_sig(SIGSTOP, task, 1);
> > +	}
> > +	rcu_read_unlock();
> > +}
> 
> If we can safely stop all SCHED_DEADLINE user tasks then presumably we
> can safely stop all user tasks.  Why not do that?
> 

I think it can be done that way.  Normal user tasks cannot block the CPU
hotplug kthread. Once the other CPUs are offlined, kexec can jump to the
new kernel immediately. However, DL tasks may starve the hotplug kthread
and kexec task, which is why I take this cautious approach.


Thanks,

Pingfan


