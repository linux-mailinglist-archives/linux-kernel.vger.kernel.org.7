Return-Path: <linux-kernel+bounces-856175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 698EABE34EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6B65505950
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515643277B8;
	Thu, 16 Oct 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xl5bIlgZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B331D74C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617065; cv=none; b=XTcuFnH9Hh8ez4f7EGmLG5VI0GrMegq24yKfmXpxp/wtkCjp8sPQvHFN0RsQWbaOETqFtJ4YuXNowj0TwmWA2F6S55ypIknG9N73Zn7RmBjBEkyr5HU1uqSw/xsZoNkgF5oLTsKa4fvqs8BxLyxLPcGodNKOosnMyd1TwCzFuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617065; c=relaxed/simple;
	bh=Yl0sQvJz5DMfOoGiEXSbISyCn22w/szpE0Z56+FjDlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVDM2bUoddbZhsHTC4E8y86C1ceP1UMANnndyBYTktEs8NNZl2sT5gbwS5Svh+LB7RZw1InAiX0FhSDfSkF4KmBfn3ro9Ga3Sbk2cd0S7QCBMnqFN/HqFrFouxekm9US6bWOxjvlXYg3DE0fGohP8i81wiL8Z7s4liH9/Nq81i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xl5bIlgZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760617062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4PkDew8TyGeRFZ5XZ6GhWj/vjcjwXknGPgocxkdWZA=;
	b=Xl5bIlgZRIPI/G9cz7v284wQUvYlytrSFjXJWQltKtTbMJJQk0hKSwdvE/94K7OatHfjbK
	+06Bi4XtAoqUsemwofa/sbrlRd0dIjDFCePuBOPMBfCWNav6QKYTfpufzC0xRm4x+PgdBh
	HJXi918AkXde8JJGE2MfWSo0G9bl6os=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-07TaJW9wMDuQYiX80mEBEw-1; Thu, 16 Oct 2025 08:17:41 -0400
X-MC-Unique: 07TaJW9wMDuQYiX80mEBEw-1
X-Mimecast-MFC-AGG-ID: 07TaJW9wMDuQYiX80mEBEw_1760617060
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2698b5fbe5bso10032185ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760617060; x=1761221860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4PkDew8TyGeRFZ5XZ6GhWj/vjcjwXknGPgocxkdWZA=;
        b=rJXovU4mjBvTpoEFI5OMAzlJmP1JAmiWIZ8iLHMvQiIvzn1BTpHCU95x47d3Hi+dhc
         iMcjMa4EUf172exV3jB4ZJo3PMU5vHGbPjyCHSaaeCedIt/HnylWqBISTtWE+ncKKNM1
         r4WdzpcKM2s4iMA6oTQZHgOh0K33ZvJ7oo1t/2yt0WL0TTe0iV5PBbPBAIUvlHxYENAH
         zNPycPy4EsKKo3ZuUgmRJ7WpAqw48SF2SegK/rRGg/pRlJkAYvzeuyLiDDZH1hN5BDGK
         peH5OooK/S6Au3RwALZ2EOo0lgyRh7gWq7vfdQ8Avw8QFMKd2/A8GV1vTDXjN2Z4JoFG
         eNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4SEHOyuBKH1VpZxCrmVBXq5Hnq0hRwo1Ry8nXI2+sH3CjwmN44/QxiOiWojtRwJJqV4WC4oz0cljWcJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkPADHcjD7cpq17TyW/G9Ed6a9Y2ZrNBvDQ0D8OsNBKV6RDOm
	5OrOwdhgWn1DdULLDTlHQnS5uu6rB2dlqlxVGG36bAV5OlIRlFyGM/ag3DArlkjVhRnXMTnG8k8
	YddbNAaJaBZgBKWtkIbvu/4mN1fpc+LAmRyQgDOd3arOLTQ/pRykkhlzXIHy9HX3jFMPELkusnD
	ZgZ5C669sdFuJtzv5eddb1LfTNUn5Fv2UwrOI97GfU
X-Gm-Gg: ASbGnct9g4JqN7svbe9ECDOWwYI1pngISd2bQlyGiJmeYa9eLvirtwrdkEQzagIc8Xi
	36eEahUTanSFEwhdhdZxuDUgvvvBseRLQYrcDfVfqrl6tXhx8AOV9pyjz4sch1JZFHgI7CwCrx0
	YxjRHtrKAfTjjPy5H83kZ63ouI4Ek4ZeqsCgVofUL8p/qgKurYw/zpSj/p
X-Received: by 2002:a17:903:286:b0:24c:c8e7:60b5 with SMTP id d9443c01a7336-2902723ebf6mr460578765ad.16.1760617059816;
        Thu, 16 Oct 2025 05:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZBGnRwDi7PhTt3l2lBUnsFdI17z2twFC3jrdyReWpXpUTcl86pxyAUzjqn1dN3Vrwankk1IksCwhUtGPv1uU=
X-Received: by 2002:a17:903:286:b0:24c:c8e7:60b5 with SMTP id
 d9443c01a7336-2902723ebf6mr460578415ad.16.1760617059425; Thu, 16 Oct 2025
 05:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929133602.32462-1-piliu@redhat.com> <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
 <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb> <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
 <45e40d5e-f0b9-4c77-af1e-6ac915518acc@arm.com> <aOOyF3EvIG5HKEel@jlelli-thinkpadt14gen4.remote.csb>
 <3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com> <CAF+s44Tv1n0b1GSghSPP3xDPK4qzbzc629XMB9btzXuKgfKvcA@mail.gmail.com>
 <aO9q9EJbUw0QqbXv@jlelli-thinkpadt14gen4.remote.csb> <454c61fc-0771-4800-b075-02591bab79b1@arm.com>
In-Reply-To: <454c61fc-0771-4800-b075-02591bab79b1@arm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 16 Oct 2025 20:17:28 +0800
X-Gm-Features: AS18NWArIRtIlTqqam3U1CrSXpe_9OqFQEK8s-bgTtG06rKMu9TQ1wNP9Wno6us
Message-ID: <CAF+s44TT3f0Tp_bXttx-Uwf-QdDUi47Lb7PDqJ9iUg-AUSwPxQ@mail.gmail.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 7:38=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
>
> On 10/15/25 11:35, Juri Lelli wrote:
> > On 14/10/25 21:09, Pingfan Liu wrote:
> >> Hi Pierre,
> >>
> >> Thanks for sharing your perspective.
> >>
> >> On Sat, Oct 11, 2025 at 12:26=E2=80=AFAM Pierre Gondois <pierre.gondoi=
s@arm.com> wrote:
> >>>
> >>> On 10/6/25 14:12, Juri Lelli wrote:
> >>>> On 06/10/25 12:13, Pierre Gondois wrote:
> >>>>> On 9/30/25 11:04, Peter Zijlstra wrote:
> >>>>>> On Tue, Sep 30, 2025 at 08:20:06AM +0100, Juri Lelli wrote:
> >>>>>>
> >>>>>>> I actually wonder if we shouldn't make cppc_fie a "special" DEADL=
INE
> >>>>>>> tasks (like schedutil [1]). IIUC that is how it is thought to beh=
ave
> >>>>>>> already [2], but, since it's missing the SCHED_FLAG_SUGOV flag(/h=
ack),
> >>>>>>> it is not "transparent" from a bandwidth tracking point of view.
> >>>>>>>
> >>>>>>> 1 -https://elixir.bootlin.com/linux/v6.17/source/kernel/sched/cpu=
freq_schedutil.c#L661
> >>>>>>> 2 -https://elixir.bootlin.com/linux/v6.17/source/drivers/cpufreq/=
cppc_cpufreq.c#L198
> >>>>>> Right, I remember that hack. Bit sad its spreading, but this CPPC =
thing
> >>>>>> is very much like the schedutil one, so might as well do that I su=
ppose.
> >>>>> IIUC, the sugov thread was switched to deadline to allow frequency =
updates
> >>>>> when deadline tasks start to run. I.e. there should be no point upd=
ating the
> >>>>> freq. after the deadline task finished running, cf [1] and [2]
> >>>>>
> >>>>> The CPPC FIE worker should not require to run that quickly as it se=
ems to be
> >>>>> more like a freq. maintenance work (the call comes from the sched t=
ick)
> >>>>>
> >>>>> sched_tick()
> >>>>> \-arch_scale_freq_tick() / topology_scale_freq_tick()
> >>>>>     \-set_freq_scale() / cppc_scale_freq_tick()
> >>>>>       \-irq_work_queue()
> >>>> OK, but how much bandwidth is enough for it (on different platforms)=
?
> >>>> Also, I am not sure the worker follows cpusets/root domain changes.
> >>>>
> >>>>
> >>> To share some additional information, I could to reproduce the issue =
by
> >>> creating as many deadline tasks with a huge bandwidth that the platfo=
rm
> >>> allows it:
> >>> chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &
> >>>
> >>> Then kexec to another kernel. The available bandwidth of the root dom=
ain
> >>> gradually decreases with the number of CPUs unplugged.
> >>> At some point, there is not enough bandwidth and an overflow is detec=
ted.
> >>> (Same call stack as in the original message).
> > I seem to agree with Pingfan below, kexec (kernel crash?) is a case
> > where all guarantees are out of the window anyway, so really no point i=
n
> > keeping track of bandwidth and failing hotplug. Guess we should be
> > adding an ad-hoc check/bail for this case.
>
> Yes right
>
> >>> So I'm not sure this is really related to the cppc_fie thread.
> >>> I think it's more related to checking the available bandwidth in a co=
ntext
> >>> which is not appropriate. The deadline bandwidth might lack when the
> >>> platform
> >>> is reset, but this should not be that important.
> >>>
> >> I think there are two independent issues.
> >>
> >> In your experiment, as CPUs are hot-removed one by one, at some point
> >> the hot-removal will fail due to insufficient DL bandwidth. There
> >> should be a warning message to inform users about what's happening,
> >> and users can then remove some DL tasks to continue the CPU
> >> hot-removal.
> >>
> >> Meanwhile, in the kexec case, this checking can be skipped since the
> >> system cannot roll back to a working state anyway
>
> Yes right, I meant that:
> -
> when using kexec, the kernel crashes
> -
> when manually unplugging CPUs with:
> `echo 0 > /sys/devices/system/cpu/cpuX/online`
> The kernel returns `write error: Device or resource busy` at some point
> to prevent
> from reducing the DL bandwidth too much.
>
> ------
>
> I  could not reproduce the issue you reported initially. I am using
> a radxa orion o6
> which has a cppc_fie worker.
>

I speculate that you miss something like
"isolcpus=3Dmanaged_irq,domain,1-71,73-143" in the kernel command line.
That is critical to reproduce the bug. In that case, cpus
[1,71],[73,143] are in def_root_domain, while cpu0 and 72 are in the
other new root_domain. The bug is triggered if cppc_fie worker is
scheduled on cpu72.

> AFAIU it should not be possible to add/remove bandwidth to the
> def_root_domain.
> During kexec, the following is happening to all CPUs:
> \-dl_bw_manage(dl_bw_req_deactivate, cpu)
>    \- // Check if there is enough bandwidth
> \-dl_clear_root_domain_cpu(cpu)
>    \- // Recompute the available bandwidth based on the remaining CPUs
>
> So I'm not sure to understand why accounting some bandwidth to the
> def_root_domain
> is problematic in practice as the def_root_domain seems to have some DL
> bandwidth.
>
> IIUC the problem seems to be that for some reason there is not enough
> bandwidth in the
> def_root_domain aswell, which triggers the bandwidth overflow detection.
>

The problem is caused by accounting the blocked-state DL task's
bandwidth to a wrong root_domain. Let me refer to the previous
example.  cpus [1,71],[73,143] belong to def_root_domain, cpu0,72
belong to root_domainA. In the kernel, the root_domain is traced in
cpu_rq(cpu)->rd. But for an offline rq, rq->rd points to
def_root_domain. Hence the reserved bandwidth of cppc_fie is wrongly
accounted into the  def_root_domain instead of root_domainA. So
finally, cpu143 refuses to be offlined since def_root_domain
demonstrates there should be reserved DL bandwidth.


Thanks,

Pingfan
> >>
> >> Thanks,
> >>
> >> Pingfan
> >>> ---
> >>>
> >>> Question:
> >>> Since the cppc_fie worker doesn't have the SCHED_FLAG_SUGOV flag,
> >>> is this comment actually correct ?
> >>> /*
> >>>    * Fake (unused) bandwidth; workaround to "fix"
> >>>    * priority inheritance.
> >>>    */
> >>>
> >>> ---
> >>>
> >>> On a non-deadline related topic, the CPPC drivers creates a cppc_fie
> >>> worker in
> >>> case the CPPC counters to estimate the current frequency are in PCC
> >>> channels.
> >>> Accessing these channels requires to go through sleeping sections,
> >>> that's why a worker is used.
> >>>
> >>> However, CPPC counters might be accessed through FFH, which doesn't g=
o
> >>> through
> >>> sleeping sections. In such case, the cppc_fie worker is never used an=
d never
> >>> removed, so it would be nice to remote it.
> >>>
> >
>


