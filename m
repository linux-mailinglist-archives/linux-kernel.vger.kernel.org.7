Return-Path: <linux-kernel+bounces-822329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73623B838BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051131893FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE942ED17A;
	Thu, 18 Sep 2025 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSTf3hRC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9B2E9ED5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184633; cv=none; b=FwxSIYSFae5meE0YeAJfh7AqJ/y8JXSmHkmeMBc+XqaiKGJi7ZzW3qkxy9Hk0x7fPmMJkvFqRT0rmMYH81efRBAvMBjO48iInhGG+DjAHkd+DJfsmRzWBbltCEzBR4xX2Jk0gUq/4fUwABqmgKeYr5W/WIG3yl25B61n8HCjlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184633; c=relaxed/simple;
	bh=JPqg0G/8iXrB5ukxbhO2xXYqyGEaXojcTMpyxqsTkAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LktdBGI/4zzqrn0aF5IyZWVnmXn/LcWhM4mlw+zHa0PO91MsqAYAQPZazEODF8rb654N5hlXS/L6DCABW6LxL6hD1owBRKFpG19MUaHu4yqavy5+EaGORcfFug/9kxN9pIKZO0CokbUW99wy7S23aaJPoBacSqkeAp6wddLir9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSTf3hRC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758184630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ8keyu0lxhKgVhy9Tvgv7PM0wrs2e1n1r7Q9UyQ/j8=;
	b=dSTf3hRCSjgxoUZYDHJAL/KB4cmaYVEY7OkI14s9W+DWB4kYWmtHVfoXPBVEAdlRU5au+7
	vfT87HOZUxX02FZhYuVkSs567mqy/14W0kxy93wIrSgF57KyJ0tYs5Ipm3Vih2ZoyugRif
	brs43zmeQysO0ytv8haYYSyaZma895Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-AeEo69ZRPD2HvojI5GQ-vw-1; Thu, 18 Sep 2025 04:37:08 -0400
X-MC-Unique: AeEo69ZRPD2HvojI5GQ-vw-1
X-Mimecast-MFC-AGG-ID: AeEo69ZRPD2HvojI5GQ-vw_1758184627
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45e05ff0b36so8545805e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758184627; x=1758789427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ8keyu0lxhKgVhy9Tvgv7PM0wrs2e1n1r7Q9UyQ/j8=;
        b=oQKpgykyEjhM7iAdyjd0M3bF+rcooTxXPG6qXcWQR8V/R9nayIjls7NDeWXrpK9P0g
         bjj0irz/Td7QkQKDp12hAOEIBRvcljGIQh7cEpXumnHaxUd2akSTUNcd7zB/lxfrN87v
         Ey0DkZ9tjpF9RTOls0xuWr+sOTFB3N6kNIcK4wMiISTEi1EOG6nhICFYndfzIzVZXzLb
         NyV1KkvwObkNbnyUaNlGnuXc+E5ffuDsvntBdumQjFQbYXaCDVK7LLCgaEO9EAoFRyEn
         OswZK8ZVVtJAg+BQ1uOHoBo3EhD4/qsrQ1ui9iFW8L9amsFYbsQAtPze9IMkY8Oxpx1H
         mqzw==
X-Forwarded-Encrypted: i=1; AJvYcCVTgwvpA/GbCRT7ARvQWIwQ7CGAlLblIEP0cMQMmJJKNLcZKc3BGz6HBhfJY5bcU4AUMuVmNVZkW+LFF20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8x+1FX8cJ9lg+eioohd2kmsn9sgxcdz+w25IGbGAvng+sDEw6
	j/TCKvOs/QlVHkVbXqI6VMGDM/tKauIqZQYLYVvBedAhD2bKrtfccyLa8QN/PAZy8UtL86UKqEq
	HFgjeRL/T9sPpKlqsSHXJo5B0+tQIgRHhE2eBU7HctSDMdpWngbV5svkg9hFX/9lLHA==
X-Gm-Gg: ASbGncsQZJphTGDdtLJ9D8vDOyaMdRLaWM3apZ4SKj14NhVcPytzdX6s9Y3wT2TgFjs
	1eSvxgdyY38dmYy10erX/QNbSDZO9QG0nUyHHibXWTujlrL2Db8H07dyM1IinNyaJqehbe7HTkx
	nQcG8tE70MaP2y3wzokqXIlQfqmMB7hlj46FYgBJeniEF9Bn2mPRE8/EtdJz+BDphIc9B9KxU3X
	9RUON6Wvr5IcztA9bkM6OeZ8h4FQFHSRGHwTYx9mza7dk5alMg9JSmoSXwpP610X2oYaTPQ8b+j
	TcrZ936kVWpEa4NQjE+tMCmpSqVnrUJqUAylU7m+0rTaYcjTv0SUsPclU6oLi8nqxSTnpLg=
X-Received: by 2002:a05:600c:a415:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-4652c9ee679mr16723475e9.9.1758184627273;
        Thu, 18 Sep 2025 01:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENi82ixP7A38dFDkEkeQ10fs2kaQOheM+8giKyQ6J3YI5g7XWDAnUxyoBgL3F3WuAGw8IGGg==
X-Received: by 2002:a05:600c:a415:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-4652c9ee679mr16723195e9.9.1758184626902;
        Thu, 18 Sep 2025 01:37:06 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613dccb5e2sm69905575e9.17.2025.09.18.01.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:37:06 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:37:04 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
Message-ID: <aMvEsIkSv21kksrL@jlelli-thinkpadt14gen4.remote.csb>
References: <20250916052904.937276-1-jstultz@google.com>
 <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>
 <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
 <CANDhNCqK3VBAxxWMsDez8xkX0vcTStWjRMR95pksUM6Q26Ctyw@mail.gmail.com>
 <20250917093441.GU3419281@noisy.programming.kicks-ass.net>
 <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
 <aMq-BKLSIG9JrRb7@jlelli-thinkpadt14gen4.remote.csb>
 <20250917173038.GA973992@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917173038.GA973992@noisy.programming.kicks-ass.net>

On 17/09/25 19:30, Peter Zijlstra wrote:
> On Wed, Sep 17, 2025 at 03:56:20PM +0200, Juri Lelli wrote:
> 
> > > + * By stopping at this point the dl_server retains bandwidth, which, if a new
> > > + * task wakes up imminently (starting the server again), can be used --
> > > + * subject to CBS wakeup rules -- without having to wait for the next period.
> > 
> > In both cases we still defer until either the new period or the current
> > 0-laxity, right?
> > 
> > The stop cleans all the flags, so subsequent start calls
> > enqueue(ENQUEUE_WAKEUP) -> update_dl_entity() which sets dl_throttled
> > and dl_defer_armed in both cases and then we start_dl_timer (defer
> > timer) after it (without enqueueing right away).
> > 
> > Or maybe I am still a bit lost. :)
> 
> The way I read it earlier today:
> 
>   dl_server_start()
>     enqueue_dl_entity(WAKEUP)
>       if (WAKEUP)
> 	task_contending();
> 	update_dl_entity()
> 	  dl_entity_overflows() := true
> 	  update_dl_revised_wakeup();
> 
> In that case, it is possible to continue running with a slight
> adjustment to the runtime (it gets scaled back to account for 'lost'
> time or somesuch IIRC).
> 

Hummm, but this is for !implicit (dl_deadline != dl_period) tasks, is
it? And dl-servers are implicit.


