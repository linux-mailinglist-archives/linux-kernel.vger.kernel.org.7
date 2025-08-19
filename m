Return-Path: <linux-kernel+bounces-775933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C588B2C691
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D50A0726C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E691B2063E7;
	Tue, 19 Aug 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vx4CKx6E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38E202C30
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612135; cv=none; b=i+kjqcIAOVAWNT2NBQI0s9ueS9Yxe6maXZOnTXc4561G5UaiJGEj0pU+/t3tN+0YM0xS9j8x0sCQPJGzk/QdwbUPVfX99u4zJ3yIUdVK8v+JGuZFzgDfA8PAU4WcJed3e3Xs+CLqC4i/pS4phqxqVwjflSYwMIH7Bt6NYyPFYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612135; c=relaxed/simple;
	bh=sdLSZHE+YDb6j4NUPbiZkZNvbBcm8s32KKgkk41wlKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDxITNQIhG/RX8Z3eD9fKU8GRmQxvI0RFkLm239VY1IZEqETiigSYMiSbAjg6Ak/4web3tDU2fagXyMDE/D84qALhA8C8cfhWUkCWHXWC8K2tL7JA8PsY0NmCQyhZNewI6c1/LJXLsuGnKxR71MnpHzCsCIIyb14x0KZXa3kOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vx4CKx6E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755612132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jL4DCYjUTrqfa8AuGeCkz9uDEXcPC2wDOnFYU02zZ4o=;
	b=Vx4CKx6EKN/ebyADnvDqiHQQeKyMTva809Q1zdJIZsuaVmI7pt1QcfWUI9vmGF7EmQjFJF
	5CvgMQ/S5Pa4uLNkeKp6zBmBPBXI4wVao/paB0dyMNJNtEqQ/j3qF6YmDQNtx/FbCEDrYU
	uUhIIzxfnsu70I5c6ojHMHfwJX2kTho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-4f4aAt0bNVucuQrRZTuzqw-1; Tue, 19 Aug 2025 10:02:09 -0400
X-MC-Unique: 4f4aAt0bNVucuQrRZTuzqw-1
X-Mimecast-MFC-AGG-ID: 4f4aAt0bNVucuQrRZTuzqw_1755612129
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9d41cec2cso4339864f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612128; x=1756216928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jL4DCYjUTrqfa8AuGeCkz9uDEXcPC2wDOnFYU02zZ4o=;
        b=Pa1eEoogwtryoxDrXcW3rNTdDqBGGBbQjwNTB6gWaFtBIgrZYUXJQdpgqd9CuRVxsM
         WgMsfuMe02ZOtvCv1R1wa3W4m3QycUCoalkWjvRwAkC2U9MUIsxKgdEWFEphtBzjKW2C
         J+nDSHr7iEJWDHJQVtV8z5XEiK+VbZ6kQBJLZ+dQYI+WTs88eWS9tIe9+G1EL/KKIE29
         1yUrW5A36gx/if/s9sAlGOATQtQD/bG/st++NcVWleWdYRwF21ufbv1ItNsidLKlyPeX
         nvCWRmyLS+3FaWSvzJQMYc/MuTSO5deP6s6wyNIqPF+HvY7EeRfGQmjGK8GqqCxNVfeM
         Pepg==
X-Forwarded-Encrypted: i=1; AJvYcCUvQ1twx4yqV2G1coh98kx5/7A+UAUHPpwTjGyzkUCNy26Jj5FOVtd+2ZCwQGtPA0Rv3ZkNgSB/E8a6SS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqtTA5q6NGwBDcyS0hvFhfR58Kwuavg5ZPjL1BiMaqiaMSTOUw
	zHKgY+2oMqatGk1nkjhzpa6fpdsX5CZAMrDgj2clKGylBaIRvgz2SnE+TleeyjNf//CEcCKjSj4
	z5YSY67CpIm1AqzDkNQUe7YlYR/TMlt/pI9lCVazm1rNbgMn07ZQnVaYCIf1mIDE0YQ==
X-Gm-Gg: ASbGncuFMNFUzzz5t9/5rwk/Q3tl7QXmkpegVTeBBp3qDUuoRy6Oimlj550nq/eLiNg
	ub0BGknmvXBQcAIYQ3JpUYueYx4rdabDmX1ahnqsFG6xHxl5kcGpRc9NKCLdYl8gY3PMFcTp3e8
	suhjAGjxuKdmbXam6ac8aCCYchQnsaduT36fbjA9nRqyi5pQUDjnIFBWkIe3toTUuj+GXT+rFub
	XgDuED/+K1yl5BvNyK9H2vNJ+0M/GQQLLEibxEbudjhAFmvUQrG+GV5n+3wJ/wjUA3byYA9N5Mx
	gqTpLrhjdkULZokzvCR6zNlOEdK5jCUISWFoWjqGj1TtIJG5zYpLBBHzPdg3TkKRWMiW
X-Received: by 2002:a05:6000:2310:b0:3b7:9aff:db60 with SMTP id ffacd0b85a97d-3c0dffac9f5mr2475153f8f.10.1755612128230;
        Tue, 19 Aug 2025 07:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5N1I1AcneaySadyW04OkCHGfpwFLPFglPcwgnA3c0/PhMkULX/Yz4XNz/AjzbHNPRbbcP6w==
X-Received: by 2002:a05:6000:2310:b0:3b7:9aff:db60 with SMTP id ffacd0b85a97d-3c0dffac9f5mr2475113f8f.10.1755612127649;
        Tue, 19 Aug 2025 07:02:07 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077789c2asm4140604f8f.57.2025.08.19.07.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:02:06 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:02:04 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, linux-trace-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
Message-ID: <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-15-gmonaco@redhat.com>
 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
 <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
 <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>

On 19/08/25 12:34, Gabriele Monaco wrote:
> 
> 
> On Tue, 2025-08-19 at 12:12 +0200, Peter Zijlstra wrote:
> > On Tue, Aug 19, 2025 at 11:56:57AM +0200, Juri Lelli wrote:
> > > Hi!
> > > 
> > > On 14/08/25 17:08, Gabriele Monaco wrote:

...

> > > > @@ -1482,6 +1486,7 @@ static void update_curr_dl_se(struct rq
> > > > *rq, struct sched_dl_entity *dl_se, s64
> > > >  
> > > >  throttle:
> > > >  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > > > +		trace_sched_dl_throttle_tp(dl_se);
> > > >  		dl_se->dl_throttled = 1;
> > > 
> > > I believe we also need to trace the dl_check_constrained_dl()
> > > throttle, please take a look.
> 
> Probably yes, strangely I couldn't see failures without it, but it may
> be down to my test setup. I'm going to have a look.

Not sure if you tested with constrained (deadline != period) tasks.

> > > Also - we discussed this point a little already offline - but I
> > > still wonder if we have to do anything special for dl-server defer.
> > > Those entities are started as throttled until 0-lag, so maybe we
> > > should still trace them explicitly as so?
> 
> The naming might need a bit of a consistency check here, but for the
> monitor, the server is running, armed or preempted. Before the 0-lag,
> it will never be running, so it will stay as armed (fair tasks running)
> or preempted (rt tasks running).
> 
> armed and preempted have the _throttled version just to indicate an
> explicit throttle event occurred.
> 
> We might want to start it in the armed_throttled if we are really
> guaranteed not to see a throttle event, but I think that would
> complicate the model considerably.
> 
> We could instead validate the 0-lag concept in a separate, server-
> specific model.
> 
> Does this initial model feel particularly wrong for the server case?

No it doesn't atm. :-) Thanks for the additional information.

> > > In addition, since it's related, maybe we should do something about
> > > sched_switch event, that is currently not aware of deadlines,
> > > runtimes, etc.
> 
> I'm not sure I follow you here, what relation with switch and
> runtime/deadline should we enforce?
> 
> We don't really force the switch to occur timely after throttling, is
> that what you mean?
> Or a switch must occur again timely after replenishing?

Hummm, yeah I was wondering if we need something along these lines, but
we can also maybe leave it for the future.

> > As per the whole _tp() thing, you can attach to the actual
> > sched_switch tracepoint with a module and read whatever you want.
> 
> Yeah I believe Juri referred to model constraints on the already
> existing events rather than new tracepoints here.

Separately from this series, maybe we should put such a module/bpf thing
somewhere shared, so it's easier to use it when needed.


