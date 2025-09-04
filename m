Return-Path: <linux-kernel+bounces-800112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E872B4338A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E664B1BC80D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F053A29A9C8;
	Thu,  4 Sep 2025 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7EiTYVG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76082989BF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970254; cv=none; b=UU1G8Tp6vVmw1kNZ6ko89iDGtSqMn4RDwPge7Bqead6CJj7/aEgiVUN9xZv/pFXm8aDLs5Q/JssIr8E9BqHivQFPhc+ZVCDNTZkICm9OkixcUBFpli+Pr/zvcrLdZM6V8Jw+9GiLjQu9XnAasalBbiyYxMG7En05RGSBHB/iWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970254; c=relaxed/simple;
	bh=oIckBVKRKgmc03f98rn0emLj9a37R8lZrEevCLloEgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASmQN6b/aE0YDdgr1QQKnWkSJuQQ5Y/bXCU0wRMEo0fNCPH6Q2Wce25wwjRsOWnIXb5Ehwg4AxsayGfUN/xNl1kS3DMHDrLA6S89w/X7lq16X13RwRxcnAH+ceC0Cje/3HART7jPTsIj/FZ/7YilIUTofvbSoQ5EzIr3+kq5MeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7EiTYVG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756970251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8hHca6nrr4DSD1i4RnW4HNPHcBb/x8yT/5uh6e1tr0=;
	b=A7EiTYVG3vpi6Xi06OaZQnIqbAy5rV1zZn/8dG7/rXp2CUm9Ts7OXN3WSe0PX73iS65QsP
	wrJzZZUMEqnUfB/ugJmki5fL8TgRDK2enjmrJjXq85nyIIEblgf7ohZV/KOQXNm3USPHGt
	efYJc/llD3lwBnaJj2sY4/Ka/OJaJp0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625---03T395O5WrgQhoIP9VmA-1; Thu, 04 Sep 2025 03:17:29 -0400
X-MC-Unique: --03T395O5WrgQhoIP9VmA-1
X-Mimecast-MFC-AGG-ID: --03T395O5WrgQhoIP9VmA_1756970248
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45cb5dbda9cso4000265e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970248; x=1757575048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8hHca6nrr4DSD1i4RnW4HNPHcBb/x8yT/5uh6e1tr0=;
        b=MMhCLXBBAcyo7+Bnu0Z3y5K0kyiFcPjesTtm6iZiNrmjRBZmsUO9d41vRFiyUezAqf
         cNtUhlrfh4LHFbYv7skRWxuaiXe0sNuzbtgCHuHatmLwAj+Ler7PIoCL4nB/SMSI+CPd
         2zHi+iRwLwPTiNg+dF7g9vxfOb2AlRv/g9P/IdAE54HdlZfImlCXcGpeKZvNqC1bZRAc
         4Id0nKe3s2uzs3VkCRQPERQjdTSFLr63OLLnCMP9Hsz7CDkW3/Am3VvX755qx5xHs39N
         UlqZOFilaL1prNmZsdGXJdLxeii48ULuDKAY6pmL0Pbf6lMhA9JDz1q7jiQC+zMmkl+/
         PmRw==
X-Forwarded-Encrypted: i=1; AJvYcCVAsu2EmbSNlGeRDy5a2iKKmbBuxswP+8mzPQDVhlB6NwMLeexPeZMWqHamIYx8NzLumvRRj8A/Jecjojg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7aNwnsBz7NSYVwKffS8+Dz1t6URWqLTRwqIx31k2DIQab73vZ
	pgTPj9iDkpU2YoPzlpjA/2yC291K7DQdeABOWYuc4QQAgo8o5EyTccqjLf+xdcKKpFhqgG6OiYM
	o2nl8TXWbCA5PUv/dC2BPS8heetLUMjVwg8iIhZ3JKhwuC5POKknywOzsRDcqOXToaQ==
X-Gm-Gg: ASbGncsVD/vBG57s5AuMTvruU3XiHGVs6CoqZH7Cw7c4PoEp2GCalu0HSDSWj/EquIP
	ypC6OiH9Z3AP+IYoopbVQpsMcwpD3wNspCjF/5REjltfkAQTtpgct1BrZ3aQJypJV/c7URp/8WE
	kdFE+Qi+rJOIWSd7Ajgrh/ymt/DotBKeH38Cd8pHr+WFRonvTpXhuWJw4jxp0eyigMPF5qxdiXG
	mNi6vbtSPTgEivWQRd2XSrmxAsmUICS3PMKEavytMAVC5NGHHuklYNtBrGmW2jhEWlSlJH2ExMa
	RfuFODdvPBcQcOj4DWSHtU80g5PYvxiOnF2Oa6TjcUxFSoEwW0fvhFmJ2Xw5IhbdlScM84g=
X-Received: by 2002:a05:600c:4694:b0:459:443e:b177 with SMTP id 5b1f17b1804b1-45b8557a72cmr141026965e9.25.1756970248423;
        Thu, 04 Sep 2025 00:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxlNaYXu+Ti5TyjToAfM/VPhoLNPClSOiPQxxxvQ/mXgMA1LuzTwi9Jqs2HyOXrR/sPrrxEg==
X-Received: by 2002:a05:600c:4694:b0:459:443e:b177 with SMTP id 5b1f17b1804b1-45b8557a72cmr141026695e9.25.1756970247956;
        Thu, 04 Sep 2025 00:17:27 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2304e16sm7685035e9.7.2025.09.04.00.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:17:27 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:17:24 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
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
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>
Subject: Re: [PATCH 05/16] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aLk9BNnFYZ3bhVAE@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-6-arighi@nvidia.com>
 <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
 <20250903200520.GN4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903200520.GN4067720@noisy.programming.kicks-ass.net>

On 03/09/25 22:05, Peter Zijlstra wrote:
> On Wed, Sep 03, 2025 at 04:53:59PM +0200, Juri Lelli wrote:
> > Hi,
> > 
> > On 03/09/25 11:33, Andrea Righi wrote:
> > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > 
> > > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > root domain containing cpu_active() CPUs. So in this case, don't mess
> > > with accounting and we can retry later. Without this patch, we see
> > > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > > 
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > ---
> > >  kernel/sched/deadline.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index 3c478a1b2890d..753e50b1e86fc 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -1689,7 +1689,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> > >  	cpus = dl_bw_cpus(cpu);
> > >  	cap = dl_bw_capacity(cpu);
> > >  
> > > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > > +	/*
> > > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > > +	 * with accounting and we can retry later.
> > > +	 */
> > > +	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
> > >  		return -EBUSY;
> > >  
> > >  	if (init) {
> > 
> > Yuri is proposing to ignore dl-servers bandwidth contribution from
> > admission control (as they essentially operate on the remaining
> > bandwidth portion not available to RT/DEADLINE tasks):
> > 
> > https://lore.kernel.org/lkml/20250903114448.664452-1-yurand2000@gmail.com/
> > 
> > His patch should make this patch not required. Would you be able and
> > willing to test this assumption?
> > 
> > I don't believe Peter already expressed his opinion on what Yuri is
> > proposing, so this might be moot. 
> 
> Urgh, yeah, I don't like that at all. That reasoning makes no sense what
> so ever. That 5% is not lost time, that 5% is being very optimistic and
> 'models' otherwise unaccountable time like IRQ and random overheads.

But, wait. For dealing with IRQs and random overheads we usually say
'inflate your reservations', e.g. add a 3-5% to your runtime so that it
is sound against reality. And that gets included already in the 95%
default max cap and schedulability tests.

I believe what Yuri is saying is that dl-servers are different, because
they are only a safety net and don't provide any guarantees. With RT
throttling we used to run non-RT on the remaining 5% (from 95%) and with
Yuri's change we are going to go back at doing the same, but with
dl-server(s). If we don't do that we are somewhat going to pay overheads
twice, first we must inflate real reservations or your tasks gets
prematurely throttled, second we remove 5% of overall bandwidth if
dl-servers are accounted for with the rest of real reservation.

What do you think? :)


