Return-Path: <linux-kernel+bounces-864988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A04BFC035
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F835833BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C3D34C9B2;
	Wed, 22 Oct 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0p0B+ix"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979334BA31
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137558; cv=none; b=DEir7BTb5ApEZdTV9FWgETNr0wfDQgWujaRA0/0ZnXnyu1S58sTCVpwwliSJp/N64aYCsT9O+qa/UfJnqO5ESc+ZKNgp1cwdD6UJFV8D/TJyR6ptcpqb/dPrsd9EivGQn+3iuQlEkDQLujKhv/fYtEJUWGey0SGTP8H7JeLBjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137558; c=relaxed/simple;
	bh=5L8a1So7bGE6+K4RnPOZ1pGeXmli87/mVNEosZSlX1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6i2ZH8Wgh4TqoIjlyphHlbvwUEYwpw6fDuvLAWS+CBduOcLy/g3nLzV1J679P23ZVEN9LY5grxRfNYiEvkToaPxoU1DJLyQ7OSh4HL8w/KGy7phaJSU45IrsczZehvF/tfndMeIj3aHuD80qMlYyw+vnAxMszxWX4eTOv17iAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V0p0B+ix; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63e12a55270so2160635a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761137551; x=1761742351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLuEn96e4jmGGoEFinZx4ImtI/4jmgH04aMEPyhO0KU=;
        b=V0p0B+ixvq/sKPIsE+q0ILqDTeGglJnTGlpSFfmVRaMfmDwlaj4vntYPhv7fEfh/EW
         fxSmJKQVmCuSCq9zPfH+MUL13wQQ6BGUCAEErk7X9kby8GX+xn6h8rk7gHN4jRxQL4Hj
         k9zNlIFH2zb5pvKo91yVyVXRpWw7USwqAQaojHxEPBk2Ndo6SvjpnGw4Nnt+miBiarvj
         6uWWk4FmJ2bb2V0qbMlV86bLWMt5xPf1v9zd3ksfQ5G/kW2FBIA5Agb9vpzx183flfXo
         oz0BqVd9FOJMUYvJgXGM7rfvsWYy+2v/qiAUlP9FYCHLK/1dJcR9Yg63nyTfgTyi/Uty
         GzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137551; x=1761742351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLuEn96e4jmGGoEFinZx4ImtI/4jmgH04aMEPyhO0KU=;
        b=mAjNmT5NRMdMMmdF+wBCBBI6mfRcm5gXLs0xtTF584QRcaLX6e6DJrQmeFuSgKwori
         4LAuid65ljyf2gKIopA09bjejQibDL67gkPmDvCezvTKeWQpZreS6klxnhtY2bCOKoqw
         kl6k8BZfPHwIiaVUc3l20vBJ3MKrf+kSIn/kTvS8h4CgmSMPrdFiqueEYb6YWx9ss1Ep
         ptc5ZG68EuU3BD/+54P19anFbx6nFJ+2wmhvuG8BRf9v0pjUssP7PR8pP95Sp7D335fZ
         m0II2G6zZp6JJuHThRw5HajgMzKV/t5dwEsamrCy5yN88p/YWoTNiy/2FLFHcMYWm9Rv
         z/zA==
X-Forwarded-Encrypted: i=1; AJvYcCUo0OBbIzet40OgN4lt5NkadoPuZnZFyjIRdedGX2p66TqLVQ6hbKGb4ebDKKWHLOItAJgOCXTjTeD15nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWGqdJLoVs6/OtYPxQzHaJO956WRHsePq/+1Z6iz2cUwO4GcF
	av7ZumhlQXZWScOxWRZm0BWNCbYkUev5l8FP57ggNa2/LbhPTA+RfYdtcJizMIZIWNsCxAkoVb7
	0liJs8jleLI+iUL4aZvkYxHwS0bNguZzvW+ofE87A3Q==
X-Gm-Gg: ASbGncvBtQ87NzG0ywOWrhnYKuOMHE+xAdKatmZxQ9RDWZ8oaD1aZb7XvfuUHgkaS3q
	EpZdDT3888hHOsBO6KWugAbhNX63QESMa3wD+MgqxIb2GzNNAVi5NOuMnnlYVDaOGJ19TLeb2A7
	AZ7cFURFVONBZx2NnxShTelB0OCoygvMnIdsEnHno9avJ9gAW9CHGRc9pv0vuLriI36c3xBKdUU
	8MhcAmCMaHRXAcNl62L1+AG5iXH5vCZEnTd6v8yFlZMpC0CNAbBqZHU46fZGSxXXc0f+hP+r3PT
	oCd/YkVRrtK01qCUAiDPYvE=
X-Google-Smtp-Source: AGHT+IH8sKTpg9uLGPArsnIf8EO4LRTyPPpVdIZqfeJCaX3o70ytdG98jtANNe+f2rLyF3JSoJ6t2QJa+2/Gqed5mYc=
X-Received: by 2002:a05:6402:13ca:b0:637:f07d:e80f with SMTP id
 4fb4d7f45d1cf-63c1f58c0d3mr20650940a12.0.1761137550578; Wed, 22 Oct 2025
 05:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bc08fcd528bad11311cd25de37962eb1ce0e7879.1760530739.git.peng_wang@linux.alibaba.com>
 <20251015124422.GD3419281@noisy.programming.kicks-ass.net>
 <CAKfTPtD-RJoMEHSQToF_578KZ=WszR+xStxNghiWpv4asnHBoA@mail.gmail.com> <20251022090038.GA88368@j38d01266.eu95sqa>
In-Reply-To: <20251022090038.GA88368@j38d01266.eu95sqa>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 22 Oct 2025 14:52:18 +0200
X-Gm-Features: AS18NWB0Z3XIRWCrXEeYGvcmS1YvFSSwhT02xJo0GzRw5tRB9sL6FK_QtN7OifM
Message-ID: <CAKfTPtDJW4yU2=_4stdS1bggHwAA8K2On_ruV63=_H9=YEgdkw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Clear ->h_load_next after hierarchical load
To: Peng Wang <peng_wang@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, vdavydov.dev@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 at 11:00, Peng Wang <peng_wang@linux.alibaba.com> wrote=
:
>
> On Wed, Oct 15, 2025 at 03:14:37PM +0200, Vincent Guittot wrote:
> > On Wed, 15 Oct 2025 at 14:44, Peter Zijlstra <peterz@infradead.org> wro=
te:
> > >
> > > On Wed, Oct 15, 2025 at 08:19:50PM +0800, Peng Wang wrote:
> > >
> > > > We found that the task_group corresponding to the problematic se
> > > > is not in the parent task_group=E2=80=99s children list, indicating=
 that
> > > > h_load_next points to an invalid address. Consider the following
> > > > cgroup and task hierarchy:
> > > >
> > > >          A
> > > >         / \
> > > >        /   \
> > > >       B     E
> > > >      / \    |
> > > >     /   \   t2
> > > >    C     D
> > > >    |     |
> > > >    t0    t1
> > > >
> > > > Here follows a timing sequence that may be responsible for triggeri=
ng
> > > > the problem:
> > > >
> > > > CPU X                   CPU Y                   CPU Z
> > > > wakeup t0
> > > > set list A->B->C
> > > > traverse A->B->C
> > > > t0 exits
> > > > destroy C
> > > >                         wakeup t2
> > > >                         set list A->E           wakeup t1
> > > >                                                 set list A->B->D
> > > >                         traverse A->B->C
> > > >                         panic
> > > >
> > > > CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker m=
emory
> > > > ordering, Y may observe A->B before it sees B->D, then in this time=
 window,
> > > > it can traverse A->B->C and reach an invalid se.
> > >
> > > Hmm, I rather think we should ensure update_cfs_rq_h_load() is
> > > serialized against unregister_fair_sched_group().
> >
> > The bug has been reported for v5.10 which probably don't have fixed
> > done "recently"
> > commit b027789e5e50 ("sched/fair: Prevent dead task groups from
> > regaining cfs_rq's")
>
> Hi, Vincent and Peter,
>
> We have already integrated this commit, but the bug persists.
>
> Do you think we should explicitly clear the h_load_next list?
>
> Even though update_cfs_rq_h_load runs under an RCU lock, ARM's
> weak memory ordering could still allow readers to observe stale
> values in the list.

I'm worried about the increase of contention on the cache with this write.

Could we check cfs_rq->h_load_next  and clear it if needed in
unregister_fair_sched_group() instead ?

>
> >
> > >
> > > And I'm thinking that really shouldn't be hard; note how
> > > sched_unregister_group() already has an RCU grace period. So all we n=
eed
> > > to ensure is that task_h_load() is called in a context that stops RCU
> > > grace periods (rcu_read_lock(), preempt_disable(), local_irq_disable(=
),
> > > local_bh_disable()).
> > >
> > > A very quick scan makes me think at the very least the usage in
> > >
> > >   task_numa_migrate()
> > >     task_numa_find_cpu()
> > >       task_h_load()
> > >
> > > fails here; probably more.

