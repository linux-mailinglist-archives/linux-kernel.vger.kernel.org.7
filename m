Return-Path: <linux-kernel+bounces-848189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D23EBCCD8D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43271A62360
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5728B3EB;
	Fri, 10 Oct 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYeJmTnu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5112882AC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760098450; cv=none; b=lr37nmc2OomeurV21zJhwruOjBAV2tkxB9nUnTLei49B0FuwsjUooe5JVOSUTFW4Mxiz4bDHvsHXqcXQGV2PhhNOoH/NF2dxOqmd0YKKuKBMnRfPp8MQpQZ2wWEM0J9HQIp67lQzhr2G9SqkBwAr9XvyfTnjautzseAbQDdWjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760098450; c=relaxed/simple;
	bh=rh6LqMn/kBv5tK2CsLcwzQ/R+KHSy8KPC4B8H2brwE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAXelC+uIlz6SEf7C9non3rFoFluOvliHkqp2PG7ivsjkH6/Fzgwk80WrwT6fdvnAIpeDbJtZQ0eXm0SYvSglYmFlOAO6ZZ4fOgAxDpjY52CmnGTCEGy86N3EI0zqDFEnUPA6VAl8xo1xffeUtX7f49OFD/ivbPjOSA60rc7iJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYeJmTnu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760098448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSkOIftXAt2OwtwNgaMsmMKEvqLB/8flG6WLRBIhQdY=;
	b=HYeJmTnumTsj4zFzJ4pS4KlzA3NypxMu1HucbKal4qND+1SS0g3rGkOEmR0uzn/pYjsCNO
	wa62sUA7zuaSSB/Ms0ahlBhYrhAOJ4zN1DM/MHBB988L6jm6cefOW9OT1PfVmaJEpM1+IC
	B6HW5Li/sGUoM8gp05D/EogBB8YA04w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-L-HFnwOvODWqe12ifXHNTQ-1; Fri,
 10 Oct 2025 08:14:04 -0400
X-MC-Unique: L-HFnwOvODWqe12ifXHNTQ-1
X-Mimecast-MFC-AGG-ID: L-HFnwOvODWqe12ifXHNTQ_1760098442
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46BA31800447;
	Fri, 10 Oct 2025 12:14:02 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.193])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 555B719560BB;
	Fri, 10 Oct 2025 12:13:57 +0000 (UTC)
Date: Fri, 10 Oct 2025 08:13:54 -0400
From: Phil Auld <pauld@redhat.com>
To: frederic@kernel.org
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org, tanghui20@huawei.com,
	tglx@linutronix.de, vincent.guittot@linaro.org,
	wangtao554@huawei.com, zhangqiao22@huawei.com,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched: Increase sched_tick_remote timeout
Message-ID: <20251010121354.GA408475@pauld.westford.csb>
References: <aMLs5G3WvlXOAxuY@localhost.localdomain>
 <20250911161300.437944-1-pauld@redhat.com>
 <20250923104739.GA514793@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923104739.GA514793@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Sep 23, 2025 at 06:47:39AM -0400 Phil Auld wrote:
> Hi,
> 
> On Thu, Sep 11, 2025 at 12:13:00PM -0400 Phil Auld wrote:
> > Increase the sched_tick_remote WARN_ON timeout to remove false
> > positives due to temporarily busy HK cpus. The suggestion
> > was 30 seconds to catch really stuck remote tick processing
> > but not trigger it too easily.
> > 
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> 
> Frederic ack'd this. Any other thoughts or opinions on this one
> character patch?

Ping...

> 
> Cheers,
> Phil
> 
> 
> 
> > ---
> >  kernel/sched/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index be00629f0ba4..ef90d358252d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5724,7 +5724,7 @@ static void sched_tick_remote(struct work_struct *work)
> >  				 * reasonable amount of time.
> >  				 */
> >  				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
> > -				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> > +				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
> >  			}
> >  			curr->sched_class->task_tick(rq, curr, 0);
> >  
> > -- 
> > 2.51.0
> > 
> 
> -- 
> 
> 

-- 


