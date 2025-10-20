Return-Path: <linux-kernel+bounces-861086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC133BF1C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CAE04F64FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E65320A04;
	Mon, 20 Oct 2025 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxKnVNEW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA913BC0C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969549; cv=none; b=bfqZS8yGaYvzUHVxu8ZmtEkjo8ku/1fjceMKiMPDKfRtl3UQH5Y8Dn465bEsLMW0S4ni8W16dvH51/EuzombHbbPQm/F2V9KFFiWjHLHXSn4cRGFuZ1AMY0r0nQn/a4zZEmUbLUK+CbeSTJM36UL4SP4LXuPX9q2N2Zktww4+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969549; c=relaxed/simple;
	bh=XTmyJMnTaGQvMndSexCb1z6HpLrVTTo7/egeZXdgM08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS3CRbHIW/6MS8Yc8quqPV6C4zNIqv/vjFthDaIDbdc+Vzs1A+MLjqMdv9DkKyPfn4cZWNfP6YNkC6oRThOEYT878zzufsp1m1TZ+4e89g2nZv9qRAoNbMBGl2cUaYkOQlKHNDYJkSIxmgWb32t4qMc2lFJc+sK6VDFgPWAq6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxKnVNEW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7m1GlhRfmho7liEla+/1yigGXVY8Z7LQaPA9s5+XnW4=;
	b=UxKnVNEW0jgk81rZD1qIIqUBZ9AIdXQyPxxI/yRafGe1mr4fahvTbNnc9109vboIj+CEOl
	uT9N/IkZiGf+fNdeRe/vtNA91OYUlQHQtjdpKthK5FWOK3eW72AhXo6o1Zolwd5qGGIZ5V
	pfQ4I67dwUnlL3AdK4NC5y6l/lwvXfs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-tkFqoXNVP8uKfpZY6546AA-1; Mon, 20 Oct 2025 10:12:22 -0400
X-MC-Unique: tkFqoXNVP8uKfpZY6546AA-1
X-Mimecast-MFC-AGG-ID: tkFqoXNVP8uKfpZY6546AA_1760969541
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4710d174c31so48160265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969539; x=1761574339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m1GlhRfmho7liEla+/1yigGXVY8Z7LQaPA9s5+XnW4=;
        b=KvROIqUhNAtNbC+AR5vpd24dheKAY0Vh1w4bP0TaG1Kn9G4o2AbrdcRLSsz25+w+w1
         zzrX7wGRIf264n6eIOqU0t4DiBma/Zs7USDXGFHQV8AC67M/lsC+zgcjZzBn0vVCQGi2
         CmWUSZbbTHyIC8+NiEq2GtybJ5OzG6biujZuD0oLx7NlTU24aefGJIEnzi6CmObTHVKF
         sI/ox14ORtH/Q0SySImyVr2UXurQVFsoaSViItlGdCiwOEj8OFm66SVytYn/ZW3da8Bp
         L36kO06YajMSN+sJKsQlThG3PFuXaKmQbHu2Sg4Aamg9s3SIKm8LnaMRUliixqTK7sQs
         t4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWdfFI2SIv7hOuKEKMDk0dEuVnbccLjoXhkL99BDfkk4CdivlskzcLkZ/CdAH5HABe1toyDwLAys+wkuqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6zA77KldtdPSKIzg05mBkuZpaZVjf3TZ2rAb1f0VADa5Zv8qr
	63criIHBnS527FAju9wH6HtRH+SjY9qqKNMC8uz6LiZni+tf+gP+OTgUnBn5UimSIj2LyjigMOU
	DjyWWlLM546c+Lc4eFuL4Sq0KzXLTOt9jHWm5B9Nm2UmYd7zX1hmf8WZp81r/i2Taqw==
X-Gm-Gg: ASbGncuWEvVD+BJjJ39LJ1I6f9PTtyi1DCfwvSdmZhJaMUrnmD+JPJwhmklsMfrJvQi
	2nDpYpEKFLf1tSW+7VNR9ygvHXARPgwU9mppZh0Pedhh+NIbm10SLK4wA6bpT780rkUwArYcuRV
	dNJNpzJ3q0Ga320a17YqKWBu2p5E1XUZrEfHYFKtpeQzw4XqMe3cRQfwNGhFExyxsJilbcNBx9g
	DQxnz1fA/iAVgJ1mSSzigGMKLRWMlPRMOK6IPxWm74FNxZnQO5DPaASJBoMwJFCXn1RIO+8LimD
	C0AOruPjoXHkYkTOkzk8WjyLyQm9GBpFNc+ZFDN0pYlm0d8tO9VSGhdvQEq/idGxd07ZO8KokkJ
	w18zrJuvi2IlgQJzOjsDJuTgbBTmd0g==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr120147015e9.32.1760969538605;
        Mon, 20 Oct 2025 07:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUFlFwDhK5O8LnMIOdT/gwVFGKlVMOVfS2OH7HmR0uwDj9gtAHpXIdIfbbitn2vkRwOsYp+A==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr120146715e9.32.1760969538203;
        Mon, 20 Oct 2025 07:12:18 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b988dsm15921167f8f.35.2025.10.20.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:12:17 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:12:14 +0200
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aPZDPsJaZ9g4jz0g@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-5-arighi@nvidia.com>
 <aPYFv6YcxqWez8aK@jlelli-thinkpadt14gen4.remote.csb>
 <aPY7O7NNs2KyKpb-@gpd4>
 <aPZBPQpRHm977Fno@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPZBPQpRHm977Fno@gpd4>

On 20/10/25 16:03, Andrea Righi wrote:
> On Mon, Oct 20, 2025 at 03:38:12PM +0200, Andrea Righi wrote:
> > On Mon, Oct 20, 2025 at 11:49:51AM +0200, Juri Lelli wrote:
> > > Hi!
> > > 
> > > On 17/10/25 11:25, Andrea Righi wrote:
> > > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > > 
> > > > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > > root domain containing cpu_active() CPUs. So in this case, don't mess
> > > > with accounting and we can retry later. Without this patch, we see
> > > > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > > > 
> > > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > > ---
> > > >  kernel/sched/deadline.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > > index 4aefb34a1d38b..f2f5b1aea8e2b 100644
> > > > --- a/kernel/sched/deadline.c
> > > > +++ b/kernel/sched/deadline.c
> > > > @@ -1665,7 +1665,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> > > >  	cpus = dl_bw_cpus(cpu);
> > > >  	cap = dl_bw_capacity(cpu);
> > > >  
> > > > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > > > +	/*
> > > > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > > > +	 * with accounting and we can retry later.
> > > 
> > > Later when? It seems a little vague. :)
> > 
> > Yeah, this comment is actually incorrect, we're not "retrying later"
> > anymore (we used to do that in a previous version), now the params are
> > applied via:
> > 
> >   ext.c:handle_hotplug() -> dl_server_on() -> dl_server_apply_params()
> > 
> > Or via scx_enable() when an scx scheduler is loaded. So, I'm wondering if
> > this condition is still needed. Will do some tests.
> 
> Looks like I can't reproduce the error with the hotplug kselftest anymore
> (and it was happening pretty quickly).
> 
> Then I guess we can drop this patch or maybe add a WARN_ON_ONCE(!cpus) just
> to safe?

WARN_ON_ONCE() works for me.

Thanks!


