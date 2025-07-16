Return-Path: <linux-kernel+bounces-733641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 483E3B07742
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4C91899196
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB0155C88;
	Wed, 16 Jul 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITqEzOdq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884B2F2E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673619; cv=none; b=dW+StCB+ZVMNmLNNrQnBoVc4CWAI3MGLNdHzwF7kYVnHMJaFs6ytiaQpkNbMn/3Q4XFeLo329YqEjs9W0Mvc6Cf405acapGDis6S0Jw4pbqRqiH88rqqdiEFA3Zbe6EUnnFqPXTqCXM1a2Jksj9k97GXRUjDcUNddG80KSIUw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673619; c=relaxed/simple;
	bh=oWqfY4IYFYnZ6rkfKGKz2+ZwKtIQvii/tCymvVf7m4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8YqPtK3EKlW5lQ9N+MkhoRzJ1/X29tp8qO8ldi1LhqICGnRgCoTxJSOsJBsUuija5lbwEG6KXJDKRiZs90Hcy35bnCslZ0dlnl2yhi0bhuVgy0YmRRaHslFWr2JnuvOKQmlIBqm9HF6GEkXfr6T8IW6jS6kjGzbh0a1MwULLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITqEzOdq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMSdNvGF0+Gq7PI8vtKmcbLGIURl0DxCtzS+LlFdMfo=;
	b=ITqEzOdqMC212jJvmC3ecjTvSobfO/ydgqWleM7tOS+jE7J6dJJhC961KNXPkD3QW4nao9
	kBjQ3WApqRllPUJitCXQvvgfnxjnAMLs9t/wpLlKo6y1021Br1bfqmSlC/q+6ziWupQUiS
	Pr7MM5OGZty9mDfaI+3TnKH80X76u0c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-WC3Bwjj9P0K5A8YwX8acZw-1; Wed,
 16 Jul 2025 09:46:53 -0400
X-MC-Unique: WC3Bwjj9P0K5A8YwX8acZw-1
X-Mimecast-MFC-AGG-ID: WC3Bwjj9P0K5A8YwX8acZw_1752673612
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C6D219560B0;
	Wed, 16 Jul 2025 13:46:51 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.44.32.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB9E61955F16;
	Wed, 16 Jul 2025 13:46:44 +0000 (UTC)
Date: Wed, 16 Jul 2025 09:46:40 -0400
From: Phil Auld <pauld@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, clm@meta.com
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
Message-ID: <20250716134640.GA20846@pauld.westford.csb>
References: <20250702114924.091581796@infradead.org>
 <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
 <20250707091136.GB1099709@noisy.programming.kicks-ass.net>
 <49a9e43b-7ca5-4c90-a8b2-c43a84c34aeb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49a9e43b-7ca5-4c90-a8b2-c43a84c34aeb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


Hi Peter,

On Mon, Jul 07, 2025 at 03:08:08PM +0530 Shrikanth Hegde wrote:
> 
> 
> On 7/7/25 14:41, Peter Zijlstra wrote:
> > On Mon, Jul 07, 2025 at 02:35:38PM +0530, Shrikanth Hegde wrote:
> > > 
> > > 
> > > On 7/2/25 17:19, Peter Zijlstra wrote:
> > > > Hi!
> > > > 
> > > > Previous version:
> > > > 
> > > >     https://lkml.kernel.org/r/20250520094538.086709102@infradead.org
> > > > 
> > > > 
> > > > Changes:
> > > >    - keep dl_server_stop(), just remove the 'normal' usage of it (juril)
> > > >    - have the sched_delayed wake list IPIs do select_task_rq() (vingu)
> > > >    - fixed lockdep splat (dietmar)
> > > >    - added a few preperatory patches
> > > > 
> > > > 
> > > > Patches apply on top of tip/master (which includes the disabling of private futex)
> > > > and clm's newidle balance patch (which I'm awaiting vingu's ack on).
> > > > 
> > > > Performance is similar to the last version; as tested on my SPR on v6.15 base:
> > > > 
> > > 
> > > 
> > > Hi Peter,
> > > Gave this a spin on a machine with 5 cores (SMT8) PowerPC system.
> > > 
> > > I see significant regression in schbench. let me know if i have to test different
> > > number of threads based on the system size.
> > > Will go through the series and will try a bisect meanwhile.
> > 
> > Urgh, those are terrible numbers :/
> > 
> > What do the caches look like on that setup? Obviously all the 8 SMT
> > (is this the supercore that glues two SMT4 things together for backwards
> > compat?) share some cache, but is there some shared cache between the
> > cores?
> 
> It is a supercore(we call it as bigcore) which glues two SMT4 cores. LLC is
> per SMT4 core. So from scheduler perspective system is 10 cores (SMT4)
> 

We've confirmed the issue with schbench on EPYC hardware. It's not limited
to PPC systems, although this system may also have interesting caching. 
We don't see issues with our other tests.

---------------

Here are the latency reports from schbench on a single-socket AMD EPYC
9655P server with 96 cores and 192 CPUs.

Results for this test:
./schbench/schbench -L -m 4 -t 192 -i 30 -r 30

6.15.0-rc6  baseline
threads  wakeup_99_usec  request_99_usec
1        5               3180
16       5               3996
64       3452            14256
128      7112            32960
192      11536           46016

6.15.0-rc6.pz_fixes2 (with 12 part series))
threads  wakeup_99_usec  request_99_usec
1        5               3172
16       5               3844
64       3348            17376
128      21024           100480
192      44224           176384

For 128 and 192 threads, Wakeup and Request latencies increased by a factor of
3x.

We're testing now with NO_TTWU_QUEUE_DELAYED and I'll try to report on
that when we have results. 

Cheers,
Phil
-- 


