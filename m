Return-Path: <linux-kernel+bounces-813403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9C8B544E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209A1585E81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A972D3EF6;
	Fri, 12 Sep 2025 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B26DaC/p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D042D8773
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664859; cv=none; b=RJHcuM4zS5NYNhNN9yB7xhvwQqObR41/Sh/zA87uURWOuLTWdJj0FMa4OzTprNHUsjFxDQrfLbMt+gqBUzl02biwf9GnrvXAdEGZLfBMUh8jW7FgTQRjmJ0y3TLetDRaMmTbPR3c+aC1OXFZdqoeU1u5UcwQYIoLX48kJITc67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664859; c=relaxed/simple;
	bh=azMsw9UcYYDqC9B7k/Y8GO+xdiR80U6koOLcPLTzvp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pk+g1hfIvg2TSuu5y+Z4/wcjyin5B38bSGHR9wlgnEy3eKs6H7XHol6ZSNesbHFRxk0fbuvKK+EiztX8rVUFEvmvTZn3fPx2keM4inuHSDrAx/XibZO/YnBNtDScoTEgCtK2eh3D8XeeKHQYoIMW5el9NX0EZvG81rMUma9yI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B26DaC/p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757664856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLQ9zpwy/op/MmGGkXMW1QcaWAZBupI3LsVE45/b150=;
	b=B26DaC/pbVr3Rag/TnikgRTdRtW7qw9tI/7HNj6wkkbOsH4KpqLlkbTJrSvPtuVCdArWHW
	2oFbYClnrGzC0V4HG6qzR52Toh2traTHhVRbiErIEMSOAFc/hvGeb7tgkjzDi/xJ1RHXjU
	vX2P1UkpWuSYwjHlP5zp4pX7MlzEgRQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-H3d8U1SdOzmkE2o_0enmZg-1; Fri, 12 Sep 2025 04:14:15 -0400
X-MC-Unique: H3d8U1SdOzmkE2o_0enmZg-1
X-Mimecast-MFC-AGG-ID: H3d8U1SdOzmkE2o_0enmZg_1757664854
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so8975555e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757664854; x=1758269654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLQ9zpwy/op/MmGGkXMW1QcaWAZBupI3LsVE45/b150=;
        b=YHmYYGJOMW2gcVjS8ppJMuM7xNF41uB+3vPRmrc+ZoVnWWgalC4foiQJUFW31vrKss
         eXZv3vAPbhfW2Vvvi8vM7TwnmkkM1fIqC+lu4OoE11W/AK5fRTVd8v0p7XuRjton3gh7
         5Gpypgb8MGpbjr5mpFfWEl6IaQIDXdDBkvplfPmiXS+2BnQcEi26/6woswdCFE/Kg9iu
         Yj99NCXRuWt11bnv024fdr3Nk0nDWFdu54U63sK8ySf2GOCa0fe0pogCbsCbdcET/7jE
         pSdSECy3Xx1X3oonlILvELlBifKpRLGHpmj9qREUIcaOYvnSJ23OeaBP/K0ZdFVidzUl
         umGw==
X-Gm-Message-State: AOJu0YxC8fntqc0p+lZDInojM5n9nvE5LCZdZnWTz9NzMrZgM3zqMTRC
	riePjFpRnSFHaa1T4zb+pmLYtYmzY2VUCUGWTViHV5q+M+qYmFfne4YlcOXDkUrlZqnzW9OdEu0
	7+gX4jUca4CRySvZAaQ18tSzi0o9LbUeBYRwhjime1inWtiFsh5axglCpQcTj46heoNMR5zbdxP
	MGKiQ=
X-Gm-Gg: ASbGnct0OWAyPzx7i+1EUWWUTH896amNcUMLX5xrXyKKso3PZwb2vsw8lvhxlXukZ48
	byzLrz8/D6qjvCzRjGEJ0DkDNxgMiWklRn8qUXjmZEfNTvG6/CF/jM/CNu4B7Gwg8/iNLNB4VMx
	X2lpYL9JpNNYfhhpZK/0w04z2DrhRTTb6ZgwEqQHDCuNSMHT/p4eiwC3ucmen5nZodiw+FSm/j2
	ifd/QfhGkmc5zB36OUJ6T0G4rMeLenkNoh8DQF9v5fo9JbawNUTOOc4HbJdals4l58AzQxRfjsX
	+yoHXNKRZpbC8BfGnCXFeyzwc+ulUQvuCrglKX8Plw2i7nnNbv7nEnd8H761K4ancvAaWsg=
X-Received: by 2002:a05:600c:34d4:b0:45b:81ad:336 with SMTP id 5b1f17b1804b1-45f211dad50mr30324715e9.16.1757664853566;
        Fri, 12 Sep 2025 01:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESJFvAeYhdkW4KAMfuQIYjrYum5mTZiCkwxPFGIeV9u9GC9mwwnJ96IkXOGNe4ZRIqcwxMmw==
X-Received: by 2002:a05:600c:34d4:b0:45b:81ad:336 with SMTP id 5b1f17b1804b1-45f211dad50mr30324275e9.16.1757664853119;
        Fri, 12 Sep 2025 01:14:13 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157619fsm56152315e9.7.2025.09.12.01.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:14:12 -0700 (PDT)
Date: Fri, 12 Sep 2025 10:14:09 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com, Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	yurand2000@gmail.com
Subject: Re: [RESEND][PATCH v21 0/6] Donor Migration for Proxy Execution (v21)
Message-ID: <aMPWUYTMMrtUeZqn@jlelli-thinkpadt14gen4.remote.csb>
References: <20250904002201.971268-1-jstultz@google.com>
 <aMLVuZbkMEQzXPqR@jlelli-thinkpadt14gen4.remote.csb>
 <CANDhNCqx1cGRH=H5ze5LWdjTzA40Ajf5pmjrxj==oh_FcTd2oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqx1cGRH=H5ze5LWdjTzA40Ajf5pmjrxj==oh_FcTd2oA@mail.gmail.com>

On 11/09/25 16:21, John Stultz wrote:
> On Thu, Sep 11, 2025 at 6:59 AM Juri Lelli <juri.lelli@redhat.com> wrote:
> > On 04/09/25 00:21, John Stultz wrote:
> > > I’d really appreciate any feedback or review thoughts on the
> > > full series as well.
> >
> > I current have the following on top of your complete series
> >
> > https://github.com/jlelli/linux/commits/experimental/eval-mbwi/
> > https://github.com/jlelli/linux experimental/eval-mbwi
> >
> > of which
> >
> > https://github.com/jlelli/linux/commit/9d4bbb1aca624e76e5b34938d848dc9a418c6146
> >
> > introduces the testing (M-BWI is Multiprocessor Bandwidth Inheritance)
> > infra and the rest some additional tracepoints (based on Gabriele's
> > patch) to get more DEADLINE info out of tests (in conjuction with
> > sched_tp [1]).
> >
> > Nothing bit to report just yet, mainly spent time getting this working.
> 
> Very cool to see! I'll have to pull those and take a look at it!
> 
> And I'm of course very interested to hear if you find anything with
> the proxy set that I need to revise.
> 
> > One thing I noticed thouh (and probably forgot from previous
> > discussions) is that spin_on_owner might be 'confusing' from an
> > RT/DEADLINE perspective as it deviates from what one expects from the
> > ideal theoretical world (as tasks don't immediately block and
> > potentially donate). Not sure what to do about it. Maybe special case it
> > for RT/DEADLINE, but just started playing with it.
> 
> Can you refresh me a bit on why blocking to donate is preferred? If
> the lock owner is running, there's not much that blocking to donate
> would help with. Does this concern not apply to the current mutex
> logic without proxy?  With proxy-exec, I'm trying to preserve the
> existing mutex behavior of spin_on_owner, with the main tweak is just
> the lock handoff to the current donor when we are proxying, otherwise
> the intent is it should be the same.

Yeah, I think we want to preserve that behavior for non-RT mutexes for
throughput, but for RT I fear we might risk priority inversion if tasks
spin (for a bit) before blocking. My understanding is that with PI
enabled futexes (apart from some initial tries to get the lock with
atomic ops) we then call into __rt_mutex_start_proxy_lock() which
enqueues the blocked tasks onto the pi chain (so that PI rules are
respected etc.). Guess maybe we could end-up reintroducing this behavior
when we eventually kill rt-mutexes, so don't worry to much about it yet
I think, just something to keep in mind. :)

> Now, I do recognize that rt_mutexes and mutexes do have different lock
> handoff requirements for RT tasks (needs to strictly go to the highest
> priority waiter, and we can't let a lower priority task steal it),
> which is why I've not yet enabled proxy-exec on rt_mutexes.

Right. I will probably hack something in to test the DEADLINE scenarios,
but again don't worry about it.

Thanks,
Juri


