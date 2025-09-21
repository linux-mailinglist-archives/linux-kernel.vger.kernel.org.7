Return-Path: <linux-kernel+bounces-826343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6084B8E41B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704C23BBD14
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7754A23F429;
	Sun, 21 Sep 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PM82mvB3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064F1B041A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482919; cv=none; b=XDQsgK+Ytz6fVqZVADQ/vvn00FladJSicoMLugEjEmyUHfcNAohOOEI/L1uKFBcdB4PmYqWTYK6huncUbFLA75XD8/2R7Eodna8+RTJGA/v1iWVbLi6mJYkQADgl/ZSbWGlCMzyTwd48lBzyr7+wds3BXqjHGWddnlwyldjQ/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482919; c=relaxed/simple;
	bh=+Miu3sd6+O5iHno8nSMZwS7o8cXehTdumMzixg3nceo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5eE/BPvjG5SLtXmqUiCR6ja6MRCjsSOS8k+Wd7Ixgj6/lCHf+7mEOjgAiEg7+7VONSN78F/DVTiWLknIyPp/bQ4I69pY014VyY/FsAKm/uXhyggZe/ltpDJrQLO/SwhULE/zn+xzw995QalgHuxiQMYtNiJkCzRO7G4k3kqmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PM82mvB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758482916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juMfpOs2phKyJbHmzGSoqogpkBynL6NiqIsUFb6RoX8=;
	b=PM82mvB3R4JmhvkFBh0P0ws/L8gSAYRdmiTMkJPP8exzC+SS9jXas4dSkjkEp91sUqkxeQ
	FCBea2YyAFcWnuOWM+ybmrSIabD9q9y8X7Bh0VjuDlUL746tyg5923KYbVXyIWuEBs5gAf
	J+JlFJ1Af/SOBjCixL7Oj2GsIPuCdAg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-EVEXoJbUNVufkR2Cw-NZqw-1; Sun,
 21 Sep 2025 15:28:30 -0400
X-MC-Unique: EVEXoJbUNVufkR2Cw-NZqw-1
X-Mimecast-MFC-AGG-ID: EVEXoJbUNVufkR2Cw-NZqw_1758482909
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E173D1956089;
	Sun, 21 Sep 2025 19:28:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 947871956056;
	Sun, 21 Sep 2025 19:28:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 21 Sep 2025 21:27:05 +0200 (CEST)
Date: Sun, 21 Sep 2025 21:27:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Matt Fleming <mfleming@cloudflare.com>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>,
	kernel-team <kernel-team@cloudflare.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: Debugging lost task in wait_task_inactive() when delivering
 signal (6.12)
Message-ID: <20250921192700.GA565@redhat.com>
References: <CAGis_TWyhciem6bPzR98ysj1+gOVPHRGqSUNiiyvS1RnEidExw@mail.gmail.com>
 <20250919143611.GA22933@redhat.com>
 <CAGis_TUp9_V-kBn9CF55f08NVR+Bx3iyP=O=+PH0QAf73eGY2Q@mail.gmail.com>
 <20250919161353.GB22933@redhat.com>
 <CAGis_TWHJva-gktrsvO9=m5mEFf4zzcN=rNEt+5+moqz=C7AEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGis_TWHJva-gktrsvO9=m5mEFf4zzcN=rNEt+5+moqz=C7AEQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Thanks Matt!

So I guess that this has nothing to do with coredump and wait_task_inactive()
is broken...

I am wondering if this code

		/*
		 * If task is sched_delayed, force dequeue it, to avoid always
		 * hitting the tick timeout in the queued case
		 */
		if (p->se.sched_delayed)
			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);

ia actually correct but I know nothing about the sched_delayed logic.

I will leave this to scheduler experts ;) I can't really help.

Oleg.

On 09/20, Matt Fleming wrote:
>
> On Fri, 19 Sept 2025 at 17:15, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > OK, thanks. Nothing "interesting" at first glance.
>
> Chris (Cc'd) and I managed to get a reproducer and I think I know
> what's happening now.
>
> When a task A gets the SIGKILL from whichever thread is handling the
> coredump (let's say task B) it might hit the delayed dequeue path in
> schedule() and call set_delayed(), e.g.
>
>         dequeue_entity+1263
>         dequeue_entities+216
>         dequeue_task_fair+224
>         __schedule+468
>         schedule+39
>         do_exit+221
>         do_group_exit+48
>         get_signal+2078
>         arch_do_signal_or_restart+46
>         irqentry_exit_to_user_mode+132
>         asm_sysvec_apic_timer_interrupt+26
>
> At this point task A has ->on_rq=1, ->se.sched_delayed=1 and ->se.on_rq=1.
>
> Now when task B calls into wait_task_inactive(), it sees
> ->se.sched_delayed=1 and calls dequeue_task().
>
> At this point task A has ->on_rq=1, ->se.sched_delayed=0 and ->se.on_rq=0
>
> Unfortunately, task B still thinks that task A is scheduled because
> task_on_rq_queued(A) is true, but it's not runnable and will never run
> because it's no longer in the fair rbtree and the only task that will
> enqueue it again is task B once it leaves wait_task_inactive() and
> hits coredump_finish().
>
> > > do_exit+0xdd is here in coredump_task_wait():
> > >
> > >                 for (;;) {
> > >                         set_current_state(TASK_IDLE|TASK_FREEZABLE);
> > >                         if (!self.task) /* see coredump_finish() */
> > >                                 break;
> > >                         schedule();
> > >                 }
> > >
> > > i.e. the task calls schedule() and never comes back.
> >
> > Are you sure it never comes back and doesn't loop?
>
> Yeah, positive:
>
> $ sudo perf stat -e cycles -t 1546531 -- sleep 30
>
>  Performance counter stats for thread id '1546531':
>
>      <not counted>      cycles
>
>       30.001671072 seconds time elapsed
>


