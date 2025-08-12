Return-Path: <linux-kernel+bounces-765034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7684B22A26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC207AAA22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906DF2F5323;
	Tue, 12 Aug 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhAEHJby"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42792ECEB5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008309; cv=none; b=W9xbGARsAKJbvl8noUS6mYeiQUm7bCbwwi0Pu7xe/gVfJlo6MaNC+MfnbS1mXoWNUMxzY8Vev7P1TomzjDY+PpQmRfZlLRfDt2lYjb+gAfEk82g8TdurrxA6x0OcXhi9ItZ5lAX2lP8XmopopwkdQ2UPKsIgH0imSc84Y1ZJMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008309; c=relaxed/simple;
	bh=XtmAMAj37rcZzfJ83uJ2neJDfrdqUS1UkEsK6Q3tjts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmTPCQed9SgFo/Xwts8CE1FG6/T2LkW+wk9C6axg46DOBZ2U6HzPQFXQ5JYYM3fAX32CiJBC+hsXSbTob7MPcQATZOIXTvLLdj6WRRCSjUoYwmndmgXukhN8fH1LD8Uqr5JuqlHcDHDuHkmtABXwT6zBFPpdO8u4836PGC5c9bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhAEHJby; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755008306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lbF44vTiU1ANQcwmUNyKm+m1/4WbStG7daM487U6vs=;
	b=YhAEHJbyF6Agwc0M+eNsF2czElav91INAaa2gmTv8Kassso84lumNHyhukQ63YvPZKDkZl
	+2737WA2ms8h6IdRWPmL1K7azZMMkB3kQKjUJuIS77VvV+2cjsoftmbI6Ad0yjBwu70FFm
	vQ5qo5rwjd9xxmNZ3axVjZrcPBpDeUU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-5gZNSgOwONKrv_GK2lGd9g-1; Tue, 12 Aug 2025 10:18:25 -0400
X-MC-Unique: 5gZNSgOwONKrv_GK2lGd9g-1
X-Mimecast-MFC-AGG-ID: 5gZNSgOwONKrv_GK2lGd9g_1755008304
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e69d69691fso557495885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755008304; x=1755613104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lbF44vTiU1ANQcwmUNyKm+m1/4WbStG7daM487U6vs=;
        b=mTDy0ikNjmC5uM2EwQizBt6XMcpscGTSyJQeYufOm52Htqml6HSPKnoPIpz2uc2GU6
         AIro/P1SDBZqJHAiyNbLraPo/FR7k0NCUpXbJPSAsZgxcFMRcBGJJXuIsNFE5rUmBMM0
         i5RPuH8FO0ZQI0RjXgNoXaZfj4++q0LQG0joVVNpxE6MH1wuGxgxVh83BNERqUNYbHT5
         Ji7htFohC1hyyr9tI+uXySyMdcDZ54TU5CK2bWhAhuGwpFns20PxdsMdYc+Bh0S6EMsn
         8sChta357ko6/PqXlMW5CW8j4W5mIj8KJL7BRGszK6ON84/aBUgpXKW/5TfRnf3u6XnH
         5U5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB3KviSk6JVnKebjWBW8Cr6QNXL3tEsHGgn5m9IgmJxDr5YnlV9bi5GrCO93Hz9NW3sEFBhtBdw2OLmyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCcxYjdJJfhBw9KBo+EirCVlWLuH/Zod4xzX66vxlJ6fqJsZD0
	guFP0EtI1P+N3Hx5CD5R1bvvx3Gdcuk+YMjMXT3c/uvDrwTpFVnC9k4qVQpX5sqZj7bVYtocKSH
	Y2Neanq1j/Bh+l1yl85stoaxJHtVUQtFmaIW+3qAo6cSoZXTuBqjxAqoMoihPKbCtaA==
X-Gm-Gg: ASbGncuPGR2h7PUWSWzCgPsykqIP6gfK5OhwNdHLXWhIhj6q6VksIHH/4JrOhkDWXb9
	0oc/h1JRaOq7Mw0JCUyEgHJsWQ5pD56Z8nvThKaofpFV+9MME2dgLpV3I6x7vE5B1SUzf7/JGmz
	+XRS3pnDpyUeCg77z/P3E1d36w/0zz90Phr7KCGjJgKNqwxjxSWk7Ylv/Jc4f2pl9Fzy3bXjc+H
	S9tmXSI7FhUNGMRJE4+ZntbQHw4X6DbuI5G6UCrCHUGCzE9lIKgQQoZOyNbc3Ma7bCgJsXddNTK
	HN8teBQ/suekVzsCFoOtCjQAD3/UjOO2eS8N+kNQDZtUDx3sxEog5ybw65N1UZj3W4zJhQ==
X-Received: by 2002:a05:620a:4155:b0:7e8:158d:316c with SMTP id af79cd13be357-7e82c74fcefmr1696768985a.34.1755008304564;
        Tue, 12 Aug 2025 07:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5/TCo0SmwQpZxOWc1S/HBIKPeZH0UU0FWhXDi2MwJ0DdL8fT6Pr30cNDJAH8I6EQ9SFaj7Q==
X-Received: by 2002:a05:620a:4155:b0:7e8:158d:316c with SMTP id af79cd13be357-7e82c74fcefmr1696763585a.34.1755008303927;
        Tue, 12 Aug 2025 07:18:23 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.46.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e80235288fsm1318373185a.22.2025.08.12.07.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:18:22 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:18:18 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	vschneid@redhat.com, yuri.andriaccio@santannapisa.it
Subject: Re: [PATCH v2] sched/deadline: Remove fair-servers from real-time
 task's bandwidth accounting
Message-ID: <aJtNKvNzkoAlIW9k@jlelli-thinkpadt14gen4.remote.csb>
References: <aIxunUAqdecVuUMs@jlelli-thinkpadt14gen4.remote.csb>
 <20250801160352.4816-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801160352.4816-1-yurand2000@gmail.com>

Hey,

On 01/08/25 18:03, Yuri Andriaccio wrote:
> Hi,
> 
> thanks for reviewing the patch.
> 
> > > @@ -1688,17 +1690,14 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> > >  
> > >    cpus = dl_bw_cpus(cpu);
> > >    cap = dl_bw_capacity(cpu);
> > > +  max_bw = div64_ul(cap_scale(BW_UNIT - dl_b->bw, cap), (unsigned long)cpus);
> > 
> > fc975cfb3639 ("sched/deadline: Fix dl_server runtime calculation
> > formula") essentially removed cap/freq scaling for dl-servers. Should we
> > rather not scale max_bw here as well?
> 
> Now that I think about it, you are correct. Since the fair-servers' rate is
> fixed (i.e. by default 50ms every second), the bandwidth must be scaled for both
> the CPU and the server, or equally, neither needs scaling for the check in
> question.
> 
> ...
> 
> > > @@ -3149,10 +3138,13 @@ int sched_dl_global_validate(void)
> > >        goto next;
> > >  
> > >      dl_b = dl_bw_of(cpu);
> > > -    cpus = dl_bw_cpus(cpu);
> > > +    cap = dl_bw_capacity(cpu);
> > > +    fair_bw = dl_bw_fair(cpu);
> > >  
> > >      raw_spin_lock_irqsave(&dl_b->lock, flags);
> > > -    if (new_bw * cpus < dl_b->total_bw)
> > > +    if (cap_scale(new_bw, cap) < dl_b->total_bw)
> > > +      ret = -EBUSY;
> > 
> > It's kind of a minor one, but can't we return early at this point already?
> 
> Yes, I suppose so. I'll update the patch to return as soon as the error
> condition is met.
> 
> Additionally, I'll also update some of the checks in the above function to
> reflect the aforementioned fixed rate behaviour for fair-servers.

Don't think you had a chance to send a new version yet, no worries!

But, I just noticed that this seems to regress cpu hotplug. With this
applied, offlining of cpus fails with device or resource busy on my test
system. Can you please double check?

Thanks!
Juri


