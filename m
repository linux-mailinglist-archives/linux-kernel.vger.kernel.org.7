Return-Path: <linux-kernel+bounces-822433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63987B83DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A45E2A3D74
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFCB2D8DCF;
	Thu, 18 Sep 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifjcVF78"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBCF27F011
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188554; cv=none; b=MJV0zQmTCgbqZw38T2Wg2ztTP7WHgCoyIzwpuawfLg+WMGvSQ8Z1yPn+WV8+wFVxuq9lR8xpoUtRBK5ly13QzZduhcGB0k3qsK2sNx3E+qUjj8wcvmS4Z+v2GPH/lA/16gFWjXGkUSX6pwgi3p3j7iikK33j1UaDfo4gRQBY9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188554; c=relaxed/simple;
	bh=gP+5j6wHXxtL6RN7dy66N6cw8vI9CIBp+HXUDFzv6kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCISddviwI7umuatCFG5JVdJ5Hrex7gdwiSYvYiBUqEBGzWXqHp8TcdGv3MGFMmK37XAcmUfNoG7QXsIkBLGjPKVFobM325mlK70wYgfzuHHHr6mqb1YF95BYlue6Boa3BSK5cwVzhOsgvcwdH24Zg9S/t3mmhUKtemv+7q62lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifjcVF78; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758188551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yspTBogxnCSCvbnTEKQGF3c7hjWHFA2dvRCLT6i1ZZk=;
	b=ifjcVF788SVfZYm4ro36Xzgt5rXNJihpcjKH6S8NI/4kDPNnR45NMUNJncTRop+YGjWxDe
	G06tWluovcvRw6wicNQERQ1eSEsrBCuKvpF2Ktv1ELFbvRZESMd4GG8pOROTTwIuFLbAzq
	RnH0U2nZc9u1QgoAH0BwNbRNHMMe2ME=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-NiV5Gd-yO2WoNVAyDyxeRQ-1; Thu, 18 Sep 2025 05:42:29 -0400
X-MC-Unique: NiV5Gd-yO2WoNVAyDyxeRQ-1
X-Mimecast-MFC-AGG-ID: NiV5Gd-yO2WoNVAyDyxeRQ_1758188548
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso239191f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188548; x=1758793348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yspTBogxnCSCvbnTEKQGF3c7hjWHFA2dvRCLT6i1ZZk=;
        b=rx28NH7b40pRc+77+F0G0Td+ktBtldpYrHv0zmj9Ts0+mVLnPS8H385b9va5uy0AIL
         QV44JnZgenzfnpkXWMhkSt0VAMxP6X+tnH6h6czw7ThTHapM5eUrQo782qorg7Kl93Du
         YGkXyaBtLgaH+fKseRPHdgb+bBokLjAuwRZZkM3FbshtoBY9gsfPCJ4lOPmVdjhBKWu8
         1nhCjyszfRuqQ5wAigHKjtXrhWh8fVdVcsThR1MdffHCIfNPQLZjGW+w6AJylGFBXt0o
         /xWOh784MazGu94wqV/BmWlj3c3tCGs8zDkcuGdtbdZvdBx5/gUvzEqDWywrJe9HDdcl
         8dtw==
X-Forwarded-Encrypted: i=1; AJvYcCUO43fP3wgD5emtmDiBI58mQmoBdDjvmJu8118EjVe7HAKg1sbgMqWDDjrT9FK9jl7W7M0NqIc0WzYtAqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySfk4iU+fRuTLYosk5BtihXFk1TmNgqT8FncuEjysX+MSLRo8M
	9UmyQFROg7QuDn6V4oaPFyo8bnp/TX4JVTIMOkePRFMYPHIBAGZeZ/SKw24AjIgAlRjES42MOJJ
	kJV9wdfNmUe7nGPhOcNET2BoaLqpIps2fHqi5GE+u/xJQXvC3cWgGs4Nk7Mo+lyjj9A==
X-Gm-Gg: ASbGncvUWhLcdhhB6ad75rEjEeMARgFgNS5i8lZj3cstOvPA/Lyz+GOuny4KK9XlF9J
	abSNbNj6ShStrAAOKHIZXFbij2AR0n9o1/qc0Ppc5PSERFt0336PDdi+HhuCGwJ8LMFXVBM/tuy
	Oe4Zj5cxW9vZT6PWcvBUrOKBQnSuqXbpPi6R4j5+p3qdF+MQjlcnnAUejabKe/g4qZlCgrWbubE
	c4cr/DAuV3fRP5wPFFsoHauVktJ247t0WehfISGKvVdFPKYziMnWrbrzh00DP/t53c9vGXX2ObZ
	5uejwJDMZnki1DPY2gMrlHFvjERpTMZ7o1YjPp5XdV3ZWOdNIj5ikySwDzecTslPZXO/GCw=
X-Received: by 2002:a05:6000:310b:b0:3e7:484a:741b with SMTP id ffacd0b85a97d-3ecdfa17051mr3811159f8f.41.1758188548396;
        Thu, 18 Sep 2025 02:42:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIWWPeHQ6swHc+UzF2dTloc2cOTXDCu8p8ZBevv1/mRlb4QZpI+8326nuhRpauPIkI7+MT1g==
X-Received: by 2002:a05:6000:310b:b0:3e7:484a:741b with SMTP id ffacd0b85a97d-3ecdfa17051mr3811142f8f.41.1758188547972;
        Thu, 18 Sep 2025 02:42:27 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d81sm3093649f8f.5.2025.09.18.02.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:42:27 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:42:25 +0200
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
Message-ID: <aMvUAQ81WEBZdTQ7@jlelli-thinkpadt14gen4.remote.csb>
References: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>
 <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
 <CANDhNCqK3VBAxxWMsDez8xkX0vcTStWjRMR95pksUM6Q26Ctyw@mail.gmail.com>
 <20250917093441.GU3419281@noisy.programming.kicks-ass.net>
 <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
 <aMq-BKLSIG9JrRb7@jlelli-thinkpadt14gen4.remote.csb>
 <20250917173038.GA973992@noisy.programming.kicks-ass.net>
 <aMvEsIkSv21kksrL@jlelli-thinkpadt14gen4.remote.csb>
 <20250918090445.GF3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918090445.GF3289052@noisy.programming.kicks-ass.net>

On 18/09/25 11:04, Peter Zijlstra wrote:
> On Thu, Sep 18, 2025 at 10:37:04AM +0200, Juri Lelli wrote:
> > On 17/09/25 19:30, Peter Zijlstra wrote:
> > > On Wed, Sep 17, 2025 at 03:56:20PM +0200, Juri Lelli wrote:
> > > 
> > > > > + * By stopping at this point the dl_server retains bandwidth, which, if a new
> > > > > + * task wakes up imminently (starting the server again), can be used --
> > > > > + * subject to CBS wakeup rules -- without having to wait for the next period.
> > > > 
> > > > In both cases we still defer until either the new period or the current
> > > > 0-laxity, right?
> > > > 
> > > > The stop cleans all the flags, so subsequent start calls
> > > > enqueue(ENQUEUE_WAKEUP) -> update_dl_entity() which sets dl_throttled
> > > > and dl_defer_armed in both cases and then we start_dl_timer (defer
> > > > timer) after it (without enqueueing right away).
> > > > 
> > > > Or maybe I am still a bit lost. :)
> > > 
> > > The way I read it earlier today:
> > > 
> > >   dl_server_start()
> > >     enqueue_dl_entity(WAKEUP)
> > >       if (WAKEUP)
> > > 	task_contending();
> > > 	update_dl_entity()
> > > 	  dl_entity_overflows() := true
> > > 	  update_dl_revised_wakeup();
> > > 
> > > In that case, it is possible to continue running with a slight
> > > adjustment to the runtime (it gets scaled back to account for 'lost'
> > > time or somesuch IIRC).
> > > 
> > 
> > Hummm, but this is for !implicit (dl_deadline != dl_period) tasks, is
> > it? And dl-servers are implicit.
> 
> Bah. You're right.
> 
> So how about this:
> 
>   dl_server_timer()
>     if (dl_se->dl_defer_armed)
>       dl_se->dl_defer_running = 1;
> 
>     enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH)
> 
>  __pick_task_dl()
>    p = dl_se->server_pick_task(dl_se);
>    if (!p)
>      dl_server_stop()
>        dl_se->dl_defer_armed = 0;
>        dl_se->dl_throttled = 0;
>        dl_se->dl_server_active = 0;
>        /* notably it leaves dl_defer_running == 1 */
> 
>  dl_server_start()
>    dl_se->dl_server_active = 1;
>    enqueue_dl_entity(WAKEUP)
>      if (WAKEUP)
>        task_contending();
>        update_dl_entity()
>          if (dl_server() && dl_se->dl_defer)
> 	   if (!dl_se->dl_defer_running) /* !true := false */
> 	     /* do not set dl_defer_armed / dl_throttled */
> 
> Note: update_curr_dl_se() will eventually clear dl_defer_running when it
> gets throttled.

Ah right! I indeed missed the dl_defer_running condition check.

> And so it continues with the previous reservation. And I suppose the
> question is, should it do update_dl_revised_wakeup() in this case?

No, it can use its current reservation, so no need to possibly shrink
it. Also the revised rule is for constrained tasks anyway.

I think we are good! Thanks a lot for fixing this and for bearing with
me. :)

Feel free to add my Reviewed/Tested/Acked-by as you see fit.

Juri


