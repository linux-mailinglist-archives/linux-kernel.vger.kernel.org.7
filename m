Return-Path: <linux-kernel+bounces-838929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68EBB0719
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A49C3AAC7F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90942EC0B3;
	Wed,  1 Oct 2025 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dp/Hr0xv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0214D29B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324536; cv=none; b=idrxFoZHicKtJk58aHzLnBNZGcDBCgcabMqTYeDQhcfosXJrlfXSUs69GuG8Mg/KahMBVLhSj2pVjAZPVyL2Rn5ctCXWL/7ILJJqi9TkmcQkHZiL8f4d4INp2uEC39CoYTKNvMAcrFcnhhQmSbavzgn7vGmJ5EkshJkEj1vMhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324536; c=relaxed/simple;
	bh=D7BH5/KU8Dj+e20WYIKpB80d/xMCeLchglQOfyOAEO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWTrIoOpCr+W2mZraqS/9k0m/IRFXFYV36ZihxOydKlVkfT0Y1ghTPowTlIIJzTxjh8kgqwO+q+xcKRwCHa7Vmsg+UaKH0hD5udGdhd+n/CDk/QcN8hX4TtRez2oi2BHGcsRUvbbSArsNWyIyv4AYZBit+7eftalu2xAJfp50YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dp/Hr0xv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759324533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7BH5/KU8Dj+e20WYIKpB80d/xMCeLchglQOfyOAEO8=;
	b=Dp/Hr0xvpUSGdFywBqpi69ftbAma7h+L/TmAjfFpDFJIN/5hsHqPulggIWeOJRLXGfIo1+
	OYqijsKHXiiJVlBDETliZmQs1iTLHjlht6+Ksc9ckOrv49wz8mfeKnWSZh2hi1W7dweyO9
	ZXgsICi2lZUXJy/93mlrlaxHEgxWMmE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-jGNODtdzMtGQFvStLGEgGA-1; Wed, 01 Oct 2025 09:15:32 -0400
X-MC-Unique: jGNODtdzMtGQFvStLGEgGA-1
X-Mimecast-MFC-AGG-ID: jGNODtdzMtGQFvStLGEgGA_1759324531
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c72281674so4476461a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759324531; x=1759929331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7BH5/KU8Dj+e20WYIKpB80d/xMCeLchglQOfyOAEO8=;
        b=Ch5Z4YR6ASZIXYyky7pPqLad5lNd1sPN6Aqk9bdbybJ+hXbl8af8e+iVZ3ttGxrfuX
         gaRYvZ/r1FD9IWgg9lavddO8HNbfjTyl1EvYursOMACZdV54fncgV66RC++ToNNsqqKt
         IceUxCkO0rtwRD9w/iHN3QCzQuufsZeaMWmUHme4xPJzkO2gygm5goT9+mVE/COgMrlN
         XBvVO4HlpLykzeb/HPXJ3DcI7Wf2hNIHHhz2aAce9xjrrsArtxONuxA1Apfo2b4MmA4k
         T8iV0eKhcfgixbj4+JnSprRP8Qd9Ysp0HllS0wdJL5PaWEpeTkY8BnWqeEwC8wwGHitX
         Jdeg==
X-Gm-Message-State: AOJu0YzHkGdEttzXItuRnxqmBFSLha71/nmudoVc1i7k19ib3vWJHXGX
	WU34rAbW36AI8zSdNckLUe5I3Xm0FECOXh2u/fqs28Ky5MyvtkWMo8EUR8wCxc+ZuhVf8sQFZU7
	5KypWqsgwjE7UMaWypeX4StXFcJcWwAVOtvsBzSOI1khiFkWttJv4/ElwlV2UqNFItrHTMI6PyW
	Z6O2eI46Ulgm0P6lIibeXrUO0zXkPZ0M8jQSh9h0jJ
X-Gm-Gg: ASbGncsBDZ0I0hXaWUaJe7ef0onLJH307eNTfYVJUOmGXys+1it4sPToh6ploGXY5u/
	Q2TT93huIzhy2I9BybTFbUlb4qyIV6c8K4g2eOBpRPEcQviGyMxFb0R1tVhUAqtAyYfaialAPcE
	Kf2NgEeMS70DmBdHPmMA8hCHRcSl4=
X-Received: by 2002:a17:903:3bac:b0:27e:ec72:f67 with SMTP id d9443c01a7336-28e7f26f37fmr44999335ad.6.1759324530888;
        Wed, 01 Oct 2025 06:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF0LAgqyPVXd7qJPUMExh3PNE701DTZgj8B277BuZk4f2EOeL7fYyVMFIzVDHIkWd0qxbex7Qawfx1GwLhPzk=
X-Received: by 2002:a17:903:3bac:b0:27e:ec72:f67 with SMTP id
 d9443c01a7336-28e7f26f37fmr44998975ad.6.1759324530344; Wed, 01 Oct 2025
 06:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929133602.32462-1-piliu@redhat.com> <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com> <20250930090334.GI4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250930090334.GI4067720@noisy.programming.kicks-ass.net>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 1 Oct 2025 21:15:18 +0800
X-Gm-Features: AS18NWBTnm-jFEzgV4Wc1hvvMQRZWuJJ4_IWN1R4i-0Jx0eVB3jtL7HW4MNJ_Bw
Message-ID: <CAF+s44RVjwL7G8Lw+bcKdu+MbXtgpue6t_+5XuoQE7ys2oRs1w@mail.gmail.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 f

On Tue, Sep 30, 2025 at 5:03=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Sep 30, 2025 at 09:47:33AM +0800, Pingfan Liu wrote:
>
> > > > This patch uses the rd from the run queue of still-active CPU to ge=
t the
> > > > correct root domain.
> > >
> >
> > Sorry that I haven't explained it clearly. I mean the still-active CPU
> > in task->cpus_ptr,
> >
> > > That doesn't seem right in general. What if there are multiple root
> > > domains; how does it know which to use?
> > >
> >
> > In the case of task->cpus_ptr, there should be only one root domain, ri=
ght?
>
> IIRC there was a corner case somewhere; something like clearing the old
> cpuset load_balance flag on the root domain would not iterate all tasks
> or so.
>
According to the current implementation, root_domain is the toppest
cpuset, except top_cpuset, with load_balance flag. So at the top
level, it should be several disjoint CPU sets. If a top level cpuset's
load_balance flag is cleared, the rebuilt root domain which covers
this cpuset's CPU should be the one corresponding to top_cpuset. If
this is true, I think there is always one root domain.

> The result would be tasks with all-set cpumasks (the default value)
> spread over multiple root domains. Every task would be caught in
> whatever root domain it was at the time of toggle.
>

If the above is true, the tasks will have top_cpuset's
root_domain->span in cpus_ptr. And this corner case will be avoided.

Does that make sense?

Thanks,

Pingfan


