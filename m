Return-Path: <linux-kernel+bounces-788606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C64B3872A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7CA3A76F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A5A1FBC94;
	Wed, 27 Aug 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NI9czFoM"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854514BFA2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310261; cv=none; b=uVvR6zLNE72WPKzhNnNmbqsZf5kWhrHEvmwABr2AlUDlOhiNsNF9I+jPGEq+DASujv+7RpY4T9wDQJqwh6vb0PVVs1rGq5g8oW+ug7cxRR2ESlq0EXZnk/dIBOiTVmhGQrKbaiEXFateOD4RH75k3oTD3LcinzXCcen+D3kLuiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310261; c=relaxed/simple;
	bh=AKiJ/haQLb4o7Ulmihc6LN7JlF3zpr9bZtze8tCmbqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+M9ujbSdKLGB6Wxmjy/hfCrRa/gHgyrlVHYKtoFjOPb9E/0t9q9oFp8rDbsmHSNmztZUGfRIvA4E9Jr04Bb97PlLMvC9tbuktLu6RYpzkA7yaySY+GPWn9Dzpq4QW7/CV45PVE8aNytqb7hVySHOWStbzfdxMJcxsLsvPbWEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NI9czFoM; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b29b714f8cso302331cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756310258; x=1756915058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5esvUn+re4RANzfva1WglABLZIhxZJhL8x4RwcUhAk=;
        b=NI9czFoM4GiGNLwlPOcaWCI88GUHJC0NQbH8YLxXvLuGEMM0D2Qr4P8dqVGQP2izmj
         iqPYUe+5aNADlcGcDFLrLiFdpJ+joRLTKNMB//tfB8HRgCeNcGRTws1kto7mHEjZJ1n8
         NHl8YKgxYilLA+RNQLWUfx8Ww1906tc8bFXL2b0jtRmEz91qs7VA7kfRh2YdttdqBbco
         y+fiSYsDSQ5JMGyRkWbURgdA4wzarZMzHtrpT1aa4Gw+pz9O2kKBpKgz97guCvR5mGUE
         YFGTS4M0fcgkLB41o9fgmNrHOeAA8YsDkyA3Sr0JErbB1n3rXHj6JsM/eSBjuYOzz4h5
         SVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310258; x=1756915058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5esvUn+re4RANzfva1WglABLZIhxZJhL8x4RwcUhAk=;
        b=Yn4dq/94si/JLuKoMmJocRBynU3R1LecHvV8eP2cLwF7IpE2iSHV0wr5waX0SToWBZ
         KczudZuXFGTFLSe6s7/X3xSmINgrTPkUXrI4uKbQ5uois9nMN0foRIEHJ3dqYMVLQv+F
         ZGeMkrSSulgi6g7OH4RU9dmRGskwh55cAHEnCu6/ZQh2EIebaj9Geuv1Nqk+C5ls5rtc
         aZ27hm/JGbwtc5Oc0rLrh+egTJbLlHVp4lr2efAlS5HDMGGuWYmvuizM+g9hh/HT7TL0
         MJJlgwx9KmN6sWtEIBYTqGLsMEiIM3HrEGnytP1AGiF7Jr2I1DyPr7i0ktI+9mJKF1DO
         3Yqw==
X-Forwarded-Encrypted: i=1; AJvYcCVGwqXodPNnNBPGiEkeRi90Uk+hLtPgqQ7ax2v+xKGY/x5d4jj4hQnO0IkmT2V2W5pfunaqzfMTqZrA/QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpb999pFLVPRKSj4UBRVWTfcDjDNoT0IBMX/ush/nXjx2QPlw0
	Vhi2CmSG+uQdXC0SgMiU0mFJ1v908Ru4WLwSWmkErUSgpMHfeKW8hY1zh579CzmWdXtqlfOhP/c
	8bBaPVMaTsMOlehcVjGVqtwbEle7bo/Wm2KxZ6pOd6pZpVYnSlKYjWpgUDPk=
X-Gm-Gg: ASbGncvULABK7c0NONzomUVKSVqT8ceh3LWQegky+Lmnsl+3h9IqDDe/f19vYXrOYXb
	2mKoWTv3TxGj3zVTZR/Ovrqp1uQLZJh0xl4owI6Yv7ubfQPTwsy9+C/WqZIgqCoZNl8NIeF17wV
	P5FoaZ+2mgj5s1NDzi75fKdaqV4kAGuZM16/7BwIX3dvSC28tXfD11pIiLkD29z2RaEqcyoAizT
	lfaDxuJAqdTF0l4yMAMh+t6jYt5izpzVamqeFBHHDSR
X-Google-Smtp-Source: AGHT+IEMM3qdJfcRZGgaVM50iZSWrSIvlAfbaTbSrRzkoXb2GqeZ23lKxfkBPqe9jLfWC9tSuK4fC2NFk3GrySpPHhE=
X-Received: by 2002:ac8:7d8f:0:b0:4b2:d5d4:1a88 with SMTP id
 d75a77b69052e-4b2e1b297d3mr13906411cf.0.1756310257426; Wed, 27 Aug 2025
 08:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6cqsibtttohay7ucs4ncmq6nf7xndtyvc4635i2e5ygjsppua6@7iwkgpp245jf> <20250827095535.13979-1-zhongjinji@honor.com>
In-Reply-To: <20250827095535.13979-1-zhongjinji@honor.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 27 Aug 2025 08:57:25 -0700
X-Gm-Features: Ac12FXw90C-JkTkOf0_IJTu2epqEfx2_oZboslk2mHWHSlPaCzuu_rCR1aqdhhM
Message-ID: <CAJuCfpFf7SKEi36+EAGwVbBT8A8LubrbUg6=F3QYDSa62PpioA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite order
To: zhongjinji <zhongjinji@honor.com>
Cc: liam.howlett@oracle.com, akpm@linux-foundation.org, feng.han@honor.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, liulu.liu@honor.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, rientjes@google.com, 
	shakeel.butt@linux.dev, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 2:55=E2=80=AFAM zhongjinji <zhongjinji@honor.com> w=
rote:
>
> > + Cc Suren since he has worked on the exit_mmap() path a lot.
>
> Thank you for your assistance. I realize now that I should have
> Cc Suren earlier.

Thanks for adding me!

>
> > * Shakeel Butt <shakeel.butt@linux.dev> [250826 18:26]:
> > > On Tue, Aug 26, 2025 at 11:21:13AM -0400, Liam R. Howlett wrote:
> > > > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250826 09:50]:
> > > > > On Tue, Aug 26, 2025 at 09:37:22AM -0400, Liam R. Howlett wrote:
> > > > > > I really don't think this is worth doing.  We're avoiding a rac=
e between
> > > > > > oom and a task unmap - the MMF bits should be used to avoid thi=
s race -
> > > > > > or at least mitigate it.
> > > > >
> > > > > Yes for sure, as explored at length in previous discussions this =
feels like
> > > > > we're papering over cracks here.
> > > > >
> > > > > _However_, I'm sort of ok with a minimalistic fix that solves the=
 proximate
> > > > > issue even if it is that, as long as it doesn't cause issues in d=
oing so.
> > > > >
> > > > > So this is my take on the below and why I'm open to it!
> > > > >
> > > > > >
> > > > > > They are probably both under the read lock, but considering how=
 rare it
> > > > > > would be, would a racy flag check be enough - it is hardly crit=
ical to
> > > > > > get right.  Either would reduce the probability.
> > > > >
> > > > > Zongjinji - I'm stil not sure that you've really indicated _why_ =
you're
> > > > > seeing such a tight and unusual race. Presumably some truly massi=
ve number
> > > > > of tasks being OOM'd and unmapping but... yeah that seems odd any=
way.
> > > > >
> > > > > But again, if we can safely fix this in a way that doesn't hurt s=
tuff too
> > > > > much I'm ok with it (of course, these are famous last words in th=
e kernel
> > > > > often...!)
> > > > >
> > > > > Liam - are you open to a solution on the basis above, or do you f=
eel we
> > > > > ought simply to fix the underlying issue here?
> > > >
> > > > At least this is a benign race.
> > >
> > > Is this really a race or rather a contention? IIUC exit_mmap and the =
oom
> > > reaper are trying to unmap the address space of the oom-killed proces=
s
> > > and can compete on page table locks. If both are running concurrently=
 on
> > > two cpus then the contention can continue for whole address space and
> > > can slow down the actual memory freeing. Making oom reaper traverse i=
n
> > > opposite direction can drastically reduce the contention and faster
> > > memory freeing.
> >
> > It is two readers of the vma tree racing to lock the page tables for
> > each vma, so I guess you can see it as contention as well.. but since
> > the pte is a split lock, I see it as racing through vmas to see who hit=
s
> > which lock first.  The smart money is on the oom killer as it skips som=
e
> > vmas :)
> >
> > If it were just contention, then the loop direction wouldn't matter..
> > but I do see your point.
> >
> > > > I'd think using MMF_ to reduce the race
> > > > would achieve the same goal with less risk - which is why I bring i=
t up.
> > > >
> > >
> > > With MMF_ flag, are you suggesting oom reaper to skip the unmapping o=
f
> > > the oom-killed process?
> >
> > Yes, specifically move the MMF_OOM_SKIP flag to earlier in the exit
> > path to reduce the possibility of the race/contention.
> >
> > >
> > > > Really, both methods should be low risk, so I'm fine with either wa=
y.
> > > >
> > > > But I am interested in hearing how this race is happening enough to
> > > > necessitate a fix.  Reversing the iterator is a one-spot fix - if t=
his
> > > > happens elsewhere then we're out of options.  Using the MMF_ flags =
is
> > > > more of a scalable fix, if it achieves the same results.
> > >
> > > On the question of if this is a rare situaion and worth the patch. I
> > > would say this scenario is not that rare particularly on low memory
> > > devices and on highly utilized overcommitted systems. Memory pressure
> > > and oom-kills are norm on such systems. The point of oom reaper is to
> > > bring the system out of the oom situation quickly and having two cpus
> > > unmapping the oom-killed process can potentially bring the system out=
 of
> > > oom situation faster.
> >
> > The exit_mmap() path used to run the oom reaper if it was an oom victim=
,
> > until recently [1].  The part that makes me nervous is the exit_mmap()
> > call to mmu_notifier_release(mm), while the oom reaper uses an
> > mmu_notifier.  I am not sure if there is an issue in ordering on any of
> > the platforms of such things.  Or the associated cost of the calls.
> >
> > I mean, it's already pretty crazy that we have this in the exit:
> > mmap_read_lock()
> >    tlb_gather_mmu_fullmm()
> >      unmap vmas..
> > mmap_read_unlock()
> > mmap_write_lock()
> >    tlb_finish_mmu()..
> >
> > So not only do we now have two tasks iterating over the vmas, but we
> > also have mmu notifiers and tlb calls happening across the ranges..  At
> > least doing all the work on a single cpu means that the hardware view i=
s
> > consistent.  But I don't see this being worse than a forward race?

This part seems to have changed quite a bit since I last looked into
it closely and it's worth re-checking, however that seems orthogonal
to what this patch is trying to do.

> >
> > As it is written here, we'll have one CPU working in one direction whil=
e
> > the other works in the other, until both hit the end of the VMAs.  Only
> > when both tasks stop iterating the vmas can the exit continue since it
> > requires the write lock.
> >
> > So the tlb_finish_mmu() in exit_mmap() will always be called after
> > tlb_finish_mmu() on each individual vma has run in the
> > __oom_reap_task_mm() context (when the race happens).

Correct.

> >
> > There is also a window here, between the exit_mmap() dropping the read
> > lock, setting MMF_OOM_SKIP, and taking the lock - where the oom killer
> > will iterate through a list of vmas with zero memory to free and delay
> > the task exiting.  That is, wasting cpu and stopping the memory
> > associated with the mm_struct (vmas and such) from being freed.

Might be an opportunity to optimize but again, this is happening with
or without this patch, no?

> >
> > I'm also not sure on the cpu cache effects of what we are doing and how
> > much that would play into the speedup.  My guess is that it's
> > insignificant compared to the time we spend under the pte, but we have
> > no numbers to go on.
> >
> > So I'd like to know how likely the simultaneous runs are and if there i=
s
> > a measurable gain?
>
> Since process killing events are very frequent on Android, the likelihood=
 of
> exit_mmap and reaper work (not only OOM, but also some proactive reaping
> actions such as process_mrelease) occurring at the same time is much high=
er.
> When lmkd kills a process, it actively reaps the process using
> process_mrelease, similar to the way the OOM reaper works. Surenb may be
> able to clarify this point, as he is the author of lmkd.

Yes, on Android process_mrelease() is used after lmkd kills a process
to expedite memory release in case the victim process is blocked for
some reason. This makes the race between __oom_reap_task_mm() and
exit_mmap() much more frequent. That is probably the disconnect in
thinking that this race is rare. I don't see any harm in
__oom_reap_task_mm() walking the tree backwards to minimize the
contention with exit_mmap(). Liam, is there a performance difference
between mas_for_each_rev() and mas_for_each() ?

>
> I referenced this data in link[1], and I should have included it in the c=
over
> letter. The attached test data was collected on Android. Before testing, =
in
> order to simulate the OOM kill process, I intercepted the kill signal and=
 added
> the killed process to the OOM reaper queue.
>
> The reproduction steps are as follows:
> 1. Start a process.
> 2. Kill the process.
> 3. Capture a perfetto trace.
>
> Below are the load benefit data, measured by process running time:
>
> Note: #RxComputationT, vdp:vidtask:m, and tp-background are threads of th=
e
> same process, and they are the last threads to exit.
>
> Thread             TID         State        Wall duration (ms)          t=
otal running
> # with oom reaper but traverse reverse
> #RxComputationT    13708       Running      60.690572
> oom_reaper         81          Running      46.492032                   1=
07.182604
>
> # with oom reaper
> vdp:vidtask:m      14040       Running      81.848297
> oom_reaper         81          Running      69.32                       1=
51.168297
>
> # without oom reaper
> tp-background      12424       Running      106.021874                  1=
06.021874
>
> Compared to reaping when a process is killed, it provides approximately
> 30% load benefit.
> Compared to not performing reap when a process is killed, it can release
> memory earlier, with 40% faster memory release.

That looks like a nice performance improvement for reaping the memory
with low churn and risk.

>
> [1] https://lore.kernel.org/all/20250815163207.7078-1-zhongjinji@honor.co=
m/
>
> > I agree, that at face value, two cpus should be able to split the work.=
.
> > but I don't know about the notifier or the holding up the mm_struct
> > associated memory.  And it could slow things down by holding up an
> > exiting task.
> >
> > >
> > > I think the patch (with your suggestions) is simple enough and I don'=
t
> > > see any risk in including it.
> > >
> >
> > Actually, the more I look at this, the worse I feel about it..  Am I
> > overreacting?
> >
> > Thanks,
> > Liam
> >
> > [1] https://elixir.bootlin.com/linux/v6.0.19/source/mm/mmap.c#L3085

