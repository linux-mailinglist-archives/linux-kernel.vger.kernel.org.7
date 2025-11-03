Return-Path: <linux-kernel+bounces-883730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA831C2E349
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 068F44E34EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F42BF3DB;
	Mon,  3 Nov 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjBIOXIt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D242D5C67
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206999; cv=none; b=pkYpvtIFeAHv2VFtkAId0edP5sSeQMM9G7po8jI/dcijwKQx3nLoaMtnsFdckP+F28aUbupiSEKQZa62iaFSDYJrYbV1UyYiTKn5QYDuzgBwewlGGZIuWTVwDqKLrX0SncE0j+pOgZP/O3akAPKjbYcmiHEPek3GSzcHaJmBraQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206999; c=relaxed/simple;
	bh=2aV1jpVS/b2ogJmQ4qWsmxQWZLinZ6L/mG/Y6bMN9ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II0MjbruD+nYMi2h1/BIDUdpEU3uIREB1JhkssX0r2TqvEJFTdIHBGLVvUOwhei+e2AkD//lp0WtBQm+Nw61ISPA+dK+67WuxsB1cFsY/7dUNSLdnavp7E+4FvYjl5sYC+duzCzrOkxqLf7xgfrw/BqsYjsFJinv6d69t6NSYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjBIOXIt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762206996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAHpVp72cuhlEDbcCUsElajB9pDHVuUFNgtsOAXDQ0I=;
	b=fjBIOXIth/xWIM21r+QGaG0iPJdi1cMXWcK3yLpEfM9Sg6lE7hXVNPzIu0ECKwwDUGMvsn
	PYsm+MvAu6C0sGgtreQXvaE0qUo+kpl2vxWzzozIkpvy28EonsUbq08ph3W51a63lsZpj/
	rBn2OiT6ZC3jyG8U9/AA/n1en3lgEhs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-v8uCwOdxMfiZ8dV4kakhxw-1; Mon,
 03 Nov 2025 16:56:33 -0500
X-MC-Unique: v8uCwOdxMfiZ8dV4kakhxw-1
X-Mimecast-MFC-AGG-ID: v8uCwOdxMfiZ8dV4kakhxw_1762206992
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C9C11956071;
	Mon,  3 Nov 2025 21:56:31 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.90.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C5BB19560A2;
	Mon,  3 Nov 2025 21:56:26 +0000 (UTC)
Date: Mon, 3 Nov 2025 16:56:23 -0500
From: Phil Auld <pauld@redhat.com>
To: peterz@infradead.org
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	frederic@kernel.org, rostedt@goodmis.org, tanghui20@huawei.com,
	tglx@linutronix.de, vincent.guittot@linaro.org,
	wangtao554@huawei.com, zhangqiao22@huawei.com,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched: Increase sched_tick_remote timeout
Message-ID: <20251103215623.GA73531@pauld.westford.csb>
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


Hi Peter,

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

Can we have this timeout increase, please? 


Thanks,
Phil

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


