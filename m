Return-Path: <linux-kernel+bounces-757373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02189B1C15F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3B185CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804F321B199;
	Wed,  6 Aug 2025 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RyzWxmlS"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AB21A428
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754465624; cv=none; b=HrQ2T0djxSlsSRd8QCrGYIA6a7kODwt97OiC1v6FR7WZavpO1oPhAcGtD7Yyat37Q1MAaZ7HWGZmOaTWaaBKfxZG9slbfMCYj9gLC7CNLod2jFH65kLGxTy2aYheYplNgOR50+12h76ak8HpJALr1XVwnoeyKcrPy4KyYDJznuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754465624; c=relaxed/simple;
	bh=s8rlzYmz4iwePlgb3helKr8vtnaDaeilcyW3MpNEcCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqPb3QWCEclZRIh+NPjw6Rm/avdm8OSFZkielyLvtJ/2Pk9/CrUW+sH6kVbB5qtikgLRzoTFJ1wt3TwwTjTImBv+E7FNcQ7Xz8B/p6t6i5c/kf+pCVN604Vvw3x8UauPw+pIJuHthsiYuU6lQW3dvqhHuxUjWcVuUegwtU2TvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RyzWxmlS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74264d1832eso6149929b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 00:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754465621; x=1755070421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6QkmT+leuKWjylaXUxOSu0eJ5GXAXHONEWqn2hIXhY=;
        b=RyzWxmlSRF1Pmufued5/gbXkF5q4vqCjSy697nnnHTEtcxS3jBmvZMfqaxl8l23V12
         NMRr6oeIr1YZzWckg8ySJOJ8VKveZIRsbzOke0frVG0vCsyB/xpLHIJOTBDkc3xv8qKc
         /dKJVhpxfPyC9aGqhlXWsbfHkz1WBJKsqSAEJTljS6NjpevIGJw9WgL6X3lgrpOJcmFr
         fX2IMZ6ajawE4u37hBhv1TV8VLLO9zNZy5u7Kpl5q++W7Ap7NIKl9nc/ofbfuwILJapR
         TjWNIHT05r5vfiY44Yqcfu+yM5874so93hhRc/q/TxiI5qRSr4OqkHlHfF4QDHmqIN55
         pZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754465621; x=1755070421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6QkmT+leuKWjylaXUxOSu0eJ5GXAXHONEWqn2hIXhY=;
        b=Nk5Gg5qrHx/vhBV59Pi6jkfbpTysyb+Ef2r2mhs06QOh7LIUaNzRb5Ckn3Z0XEi3zN
         /YumD0Is1mrwzonk1jfTlzbS+QVdWAatVK+H6zWIkXJ0mDjJuOSy90+vsIhPj6vDQcsr
         u8aopBwOnzsi/dXHiKgTCietdghWwQk9Z+AxeNKGPCW/XP9e5gwpzCPkrycYUxppwg51
         ZNNHneewkZkjEfheKzlazLEH0hcgaqxmZAvgLHzADnUUf2vBRItpTdkjRwg2MeWVqfXo
         4NdF7iEcwRQeKP6MSS8jxKZ+jDYtY7SrY/C/DH1L+x0jxA+kG/tWKJMBLYC1QGDialrC
         JskQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1GTHoc5QPxwafALbbm3bNsF4do51yiiYsMnaFy1k27SiBf1nw/0r8scl96tkd9n8xkos684kiKX8kHa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjjWBQlhuvXcQtoENR54xFC+g5DTXoK+ApjT1RRhNO2UTf2SuM
	lBp6/UzKlsnz6dm6h+y0p2f3RHkv6lk6Hm2SE87T5Ca1dBvx9Nwstu4P1eOi2PSL6w==
X-Gm-Gg: ASbGnctPoeD+p0rZRM8ODMzLoXU7u2M9YpDbsQbe31gZByBO2JTtEVw0eqRWwJzUMOR
	llYsNCGtrj3XArw4JRAMnGsUX7jZFlIagd2EJG2iqh83PSyThGIcSnYbq/gvNrBEdOKnilVYEex
	IuspoWaKODyJTjnkkIXV4joRDXnRW53JdHR9s9Pb/lwiTWC9FEfX8AZnwHJE6nca5m4pu0dWSb6
	OiodkoxlRFuLFo21hxdIW3corxBO/egMsqDmaErWN4uPk4kJHTQXBbWJ8ly6LoyhAlc0IsrIj9L
	lMicbmw0j4k4bmcJ3IjafXihMcAYVc6ClJnjZBe2k19dudP3k20S/mQSP7Cp6hd3dzUVKz/UOpD
	9ftdDFXA93MVWW2TzCEfiumK1b6zxIqEkAVnRyfqriYI=
X-Google-Smtp-Source: AGHT+IG448uyN0NVsDWe4oIm+CVEKb9fP1UL0cwxq9mjP7jR2d2c7ST2cbJQK+cDvXU/Y903bJXWLg==
X-Received: by 2002:a05:6a00:80e:b0:76b:ef0e:4912 with SMTP id d2e1a72fcca58-76c2b038195mr2333305b3a.20.1754465621377;
        Wed, 06 Aug 2025 00:33:41 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce56sm14784943b3a.82.2025.08.06.00.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:33:40 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:33:27 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: xupengbo <xupengbo@oppo.com>
Cc: vincent.guittot@linaro.org, bsegall@google.com, cgroups@vger.kernel.org,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org, vschneid@redhat.com
Subject: Re: [PATCH v2] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
Message-ID: <20250806071848.GA629@bytedance>
References: <CAKfTPtDexWX5N0jaMRqVQEnURSaPhVa6XQr_TexpU2SGU-e=9A@mail.gmail.com>
 <20250806063158.25050-1-xupengbo@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806063158.25050-1-xupengbo@oppo.com>

On Wed, Aug 06, 2025 at 02:31:58PM +0800, xupengbo wrote:
> > >On Tue, 5 Aug 2025 at 16:42, xupengbo <xupengbo@oppo.com> wrote:
> > >
> > > When a task is migrated out, there is a probability that the tg->load_avg
> > > value will become abnormal. The reason is as follows.
> > >
> > > 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> > > is a possibility that the reduced load_avg is not updated to tg->load_avg
> > > when a task migrates out.
> > > 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> > > calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> > > function cfs_rq_is_decayed() does not check whether
> > > cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> > > __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> > > updated to tg->load_avg.
> > >
> > > I added a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> > > which blocks the case (2.) mentioned above. I follow the condition in
> > > update_tg_load_avg() instead of directly checking if
> > > cfs_rq->tg_load_avg_contrib is null. I think it's necessary to keep the
> > > condition consistent in both places, otherwise unexpected problems may
> > > occur.
> > >
> > > Thanks for your comments,
> > > Xu Pengbo
> > >
> > > Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> > > Signed-off-by: xupengbo <xupengbo@oppo.com>
> > > ---
> > > Changes:
> > > v1 -> v2:
> > > - Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in
> > > cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
> > > - Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/T/#u
> > >
> > >  kernel/sched/fair.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index b173a059315c..a35083a2d006 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4062,6 +4062,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> > >         if (child_cfs_rq_on_list(cfs_rq))
> > >                 return false;
> > >
> > > +       long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > > +
> > > +       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)
> > 
> >I don't understand why you use the above condition instead of if
> >(!cfs_rq->tg_load_avg_contrib). Can you elaborate ?
> > 
> >strictly speaking we want to keep the cfs_rq in the list if
> >(cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg) and
> >cfs_rq->avg.load_avg == 0 when we test this condition
> 
> 
> I use this condition primarily based on the function update_tg_load_avg().
> I want to absolutely avoid a situation where cfs_rq_is_decay() returns 
> false but update_tg_load_avg() cannot update its value due to the delta 
> check, which may cause the cfs_rq to remain on the list permanently. 
> Honestly, I am not sure if this will happen, so I took this conservative 
> approach.

Hmm...it doesn't seem we need worry about this situation.

Because when cfs_rq->load_avg is 0, abs(delta) will be
cfs_rq->tg_load_avg_contrib and the following condition:

	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)
becomes:
	if (cfs_rq->tg_load_avg_contrib > cfs_rq->tg_load_avg_contrib / 64)

which should always be true, right?

Thanks,
Aaron

> 
> In fact, in the second if-condition of cfs_rq_is_decay(), the comment in 
> the load_avg_is_decayed() function states:"_avg must be null when _sum is 
> null because _avg = _sum / divider". Therefore, when we check this newly 
> added condition, cfs_rq->avg.load_avg should already be 0, right?
> 
> After reading your comments, I carefully considered the differences 
> between these two approaches. Here, my condition is similar
> to cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg but weaker. In 
> fact, when cfs_rq->avg.load_avg is already 0, 
> abs(delta) > cfs_rq->tg_load_avg_contrib / 64 is equivalent to 
> cfs_rq->tg_load_avg_contrib > cfs_rq->tg_load_avg_contrib / 64,
> Further reasoning leads to the condition cfs_rq->tg_load_avg_contrib > 0.
> However if cfs_rq->avg.load_avg is not necessarily 0 at this point, then
> the condition you propose is obviously more accurate, simpler than the
> delta check, and requires fewer calculations.
> 
> I think our perspectives differ. From the perspective of 
> update_tg_load_avg(), the semantics of this condition are as follows: if
> there is no 1ms update limit, and update_tg_load_avg() can continue 
> updating after checking the delta, then in cfs_rq_is_decayed() we should
> return false to keep the cfs_rq in the list for subsequent updates. As 
> mentioned in the first paragraph, this avoids that tricky situation. From
> the perspective of cfs_rq_is_decayed(), the semantics of the condition you
> proposed are that if cfs_rq->avg.load_avg is already 0, then it cannot be
> removed from the list before all load_avg are updated to tg. That makes 
> sense to me, but I still feel like there's a little bit of a risk. Am I 
> being paranoid?
> 
> How do you view these two lines of thinking?
> 
> It's a pleasure to discuss this with you, 
> xupengbo.
> 
> > > +               return false;
> > > +
> > >         return true;
> > >  }
> > >
> > > --
> > > 2.43.0
> > >

