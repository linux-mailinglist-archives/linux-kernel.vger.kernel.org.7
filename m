Return-Path: <linux-kernel+bounces-861084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1369ABF1BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D03E4F615B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4733203AA;
	Mon, 20 Oct 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS42h5gQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA552F8BD9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969378; cv=none; b=MlSmsRY/j4GsjQY5DCpgR/KKX3ipX81uGjqBqRZJ05UYFnppP9AW5r3UUwyVWz2phYrYGUFFhYbSwlzhirewOrwUGpQyU8yNl2UE/2ir5hwthER65BCcmAjwVen6pZGCqETdmucxO9q3rw+5Vjz9ErbQOqdx54XP4on/erH2sn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969378; c=relaxed/simple;
	bh=j/Pp8+a9LWec1g+KxozHCqh0X+tJ57lSb9FaEKyKHjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itFg+iF7AVbvs0y6pQ+KcZNtBEGsbpMTC/FuI4JSZMFmKJpciPuVeZcES0dkTVRy6K4571NfLkmvlU66umIn4AfiT8dUqC/9gX86/MvzDXeVvy5WgDwCAK0jdckIM/UtQ+sWw5ukW/d439xeEO9qjATi3cdxrnFziukmjzIiKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VS42h5gQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XQFS0nziRWGUnVx3NjlDIpRK/8NuLJrpA5nzcrIPL+Y=;
	b=VS42h5gQGqm5SUwGE2la7PzJMTTBcHWFv/iO3MriHuPa92JoTEVhnsMGcScMFhZesRR5dn
	IBH1qGFI+Bg2dali/A/5vwRLSv+pMmPCdoH9kVw9MftGdqkdfEta946zeE4KAVHHnckMXs
	wNoR3bppQt8ZsAkZiRhrDufB1pkNbkI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-AfIx3HS7N6WXxmWkl-fo7g-1; Mon, 20 Oct 2025 10:09:34 -0400
X-MC-Unique: AfIx3HS7N6WXxmWkl-fo7g-1
X-Mimecast-MFC-AGG-ID: AfIx3HS7N6WXxmWkl-fo7g_1760969374
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4710d174c31so48138505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969373; x=1761574173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQFS0nziRWGUnVx3NjlDIpRK/8NuLJrpA5nzcrIPL+Y=;
        b=LHM8ervXrUr9Sxr1StD5vh4UWBUD0Ez6NjeJPSe8Jv+jWOpa2Q8a+LQ9zeVHis8CFu
         wrqKxB6wutu5RtBkB3dB03ThXx2yvyJG8f8IfNuRkZl+2T779gqP5mV4/NPY6XtgDP5O
         OgI8AR4NcNcbrg9c4AlzqJsz2gtzbt34jbbzhmHfcIsRod1PNi+uF6bw1EnW6EiS3Sfg
         nWvcNvUwEzm3Y//+1O3n9DgrUQ6+H13f1BniBvMnyOdddVMz97ofQK61DTFzyWZzcb17
         rkDfhz15H/lubPLN31JsJYTqdnp6XvnZVSZBNf81MNZlpIMAPTtsExLbo/hZLJToYTsr
         eJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCWUwFdGVKpkmWoUetIv9u3P+GjCTDdsMkuuB33Txh7+JsbqG5oJ6VVnREKP0d7lIyY4oYyYJXGnYKTHYQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2fyxjSfJMh6yT8JYnmEdhfVqUtrH9q1aW3hX27xBsPwJ/AOc
	1EMBpzTpEp/J9wNRun9dJiOgsQJUrJDnBn4QhILfkd+g96ok/sW3kAHZJmaROJbd9YmBheDCZCY
	/pwRvg2DfejkEfY/GFvCaF3tBKE5TdC2b5JnkqpZjGURvvGMFMrcXUoWsB7WZ7gp9JsctkI2dvQ
	==
X-Gm-Gg: ASbGncsNJ8wRGQKLqDJXimBVG7lQStI2cPxRTY4m+2cQeNA+ijdymOlvF/Ql8Pn1x5W
	qzCUJH4VGpY2QJaZ5kfxEGdob4HR3YQy4wCsve1U02GTgT/vak+DB9vaOBJYIa8SQhT0RYHso0V
	CP0OFAbmGUgFFDxdo463yMV7vwdtiSYhjlKqrjqbz6OE2XExNKrNHABy22uTtFBrdfNR3Gvphl/
	mJScILx0poqgqSVYzvZquMp60lPmr+UgXO0LAlrRI4gLqbw9+I/newA5+Ia4jLv86DIzfA7dEXb
	NNz217OSCuDkdXMdseGa3Nz2LXMqIi9Sw8LAXF0Les1xTkubmBtGf1iA3M+kr2U9ZRopNbHP0lI
	KExBGjPj53gWzvVX88gfXzma/ZKA1NQ==
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-471178a7ea5mr86748875e9.16.1760969373332;
        Mon, 20 Oct 2025 07:09:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0mn7LBjNER9gtoWif8Bgg5J8Y0egN0uHFHsLZtoAR0dq+X1zkA1a8NQOlBpYb8JH2pb5i0w==
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-471178a7ea5mr86748665e9.16.1760969372894;
        Mon, 20 Oct 2025 07:09:32 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm149048465e9.9.2025.10.20.07.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:09:31 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:09:29 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPZCmZF_K-vJOYKp@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
 <aPYj-iOdvgUYQFpn@jlelli-thinkpadt14gen4.remote.csb>
 <aPY-QOXV5USEHVIq@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPY-QOXV5USEHVIq@gpd4>

On 20/10/25 15:50, Andrea Righi wrote:
> Hi Juri,
> 
> On Mon, Oct 20, 2025 at 01:58:50PM +0200, Juri Lelli wrote:
> > Hi!
> > 
> > On 17/10/25 11:25, Andrea Righi wrote:

...

> > > @@ -1487,6 +1499,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
> > >  	sub_nr_running(rq, 1);
> > >  
> > >  	dispatch_dequeue(rq, p);
> > > +
> > > +	/* Stop the server if this was the last task */
> > > +	if (rq->scx.nr_running == 0)
> > > +		dl_server_stop(&rq->ext_server);
> > > +
> > 
> > Do we want to use the delayed stop behavior for scx-server as we have
> > for fair-server? Wonder if it's a matter of removing this explicit stop
> > and wait for a full period to elapse as we do for fair. It should reduce
> > timer reprogramming overhead for scx as well.
> 
> So, IIUC we could just remove this explicit dl_server_stop() and the server
> would naturally stop at the end of its current deadline period, if there
> are still no runnable tasks, right?

Right, that is what I'd expect. But this part tricked me several times
already, so I am not 100% certain (Peter please keep me honest :).

> In that case it's worth a try.


