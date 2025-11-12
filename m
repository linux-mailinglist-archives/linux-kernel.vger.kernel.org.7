Return-Path: <linux-kernel+bounces-897092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3738AC51E86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF70E34DC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C113009D2;
	Wed, 12 Nov 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZJuW1x7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5101135958
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946485; cv=none; b=lTAyXYcEJ61LDraZHWs9o8tQd1Ywp3q+qHAJGferPh+6L3yKKRcdh5jRLTJnb1USv4FhE83/PpM/fgWZYInL28Sq58buryaUnUroQsX19EaFiHfPmpXM4+tWa2dv8Wxu6K65CkOEQyHoXfUpQpjd5mnWcGpH9nRKh0EwM8IkMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946485; c=relaxed/simple;
	bh=ksHEYPgtJ6gbLYSV95PNLfDyLjBndgKAHp4389BbMVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5zxgL6z/25R9mBlopG/ZErOgTz3j11M22/o2sLuR0xGn+uSI1u2g5K+TQMPSQwhi61b7u0EdpRM4SnvTaYLebftbjwtCZ8DP54IKu04cXXztNVeAesJ4QAJ7aeCvo67Br6r3xum4DFvmzAPZfo3/bBFp9QaFofSZVIpqK3N33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FZJuW1x7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AWIttM0C/qgqMEiWla3PEpVXZNss1KlydC/vWS297Og=; b=FZJuW1x7HAyhh7UJeoBlquD1/Y
	T/Wp1VMhscOVqf6+qLxYXSGVPTEMcE4zlqOQSWA0VbKfZidqb9j+Jf/2+E4X63T6DDQRTmr7s/PCN
	JmGIYIYUIFU6EqFONhSiSXF5fe9P4lbhzmpLQSUJBiBTBj1iHl6HdD6mprFgW+yryCtlySc49blZX
	CVnEPfCTHE0kz2AFnipeBf6f0UmKli2GYqRsZbYuIN6JTYY6VTZJ3ammT4Zu9gMtH3KwNMiqJnS2R
	JdHq/IdW2hIcDwIWnzXrEx1EJV+ngvwZM0cmFM92/EmWwTiTCZlmOkrEioJBhGgxjb1jV7TklUhxz
	KKEwvAjQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ82t-0000000FGkP-2EDs;
	Wed, 12 Nov 2025 10:25:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A83D8300265; Wed, 12 Nov 2025 12:21:13 +0100 (CET)
Date: Wed, 12 Nov 2025 12:21:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
	Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
Message-ID: <20251112112113.GO278048@noisy.programming.kicks-ass.net>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <aRQ_D1vyNfGVo-xK@linux.ibm.com>
 <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
 <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
 <55e02921-6477-4ed0-9ef6-16c3f34594a8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e02921-6477-4ed0-9ef6-16c3f34594a8@linux.ibm.com>

On Wed, Nov 12, 2025 at 04:39:43PM +0530, Shrikanth Hegde wrote:
> 
> 

> > So perhaps this is the better option -- or did I overlook something with
> > should_we_balance? It doesn't look like that will make a different
> > decision on the retry.
> > 
> 
> I think in newidle balance, these checks are there in swb to bail of load balance.
> redo logic catches it right?

Urgh, my brain still thinks we're not serializing on newidle. Perhaps I
should make this 2 patches, one moving the serializing and one adding it
to newidle.

> env->dst_rq lock is taken only in attach_tasks, meanwhile, if the wakeup happened,
> pending would be set. is irq enabled or remote CPU can set ttwu_pending on this rq?
> 
>         if (env->idle == CPU_NEWLY_IDLE) {
>                 if (env->dst_rq->nr_running > 0 || env->dst_rq->ttwu_pending)
>                         return 0;
>                 return 1;
>         }

Right, that could get tickled.

