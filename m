Return-Path: <linux-kernel+bounces-724619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0EBAFF4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACE53A86E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210352248A0;
	Wed,  9 Jul 2025 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpghOC1S"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135CA92E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101358; cv=none; b=LGZFKQcTvicGGWKpttIOpTZ45vlibfKjIicVC2zZbQMNM9XSecuOCIEqcgox8A5HwWAALRqbIWVFT123gU+rQFW2l32b2Bl9F117QS2H+njGqJPNmlE1ueZ4qMURHOJkI92REZkpNfN947tZGPu3+n2zIuk4l6BKum6yWX7JTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101358; c=relaxed/simple;
	bh=CC0bgrIdwksXWNPIPQdnL8jTNyJeVQOtatiTQcgZTPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5KXkFBZLF5MCFk/Wvvu/eWnlkN+sibnm1H0dHzjvBgJq4sR6ZdhPxXwvYyXNljJGqNvrdKA3TGrGDO6qI5pXDSEeLOu/8sNmNmosCx24Z4I1yho9BHgdpuvFgc4zuMLC2Gsa3zdK9cWcvhRbebwfVKpe2D3agyAFUbsVEbxJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpghOC1S; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a58197794eso36641cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 15:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752101356; x=1752706156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I6WjSQwUs71DxN/QS/li8qkFp059A9PRc4gKLJpYF90=;
        b=IpghOC1Sj9TaqB9M/SRzgh99hkxn/rCaWa5/Dj/ffeo5o4sYkSOB5iOvfJGX6L302r
         s1fp3SXXIgcsY4DfQqP0tdKYBGK2exlWZJJCQLgHYlSGPeIIMDkstqNEglasmk7gRfp7
         mfn3DDe4pMKbPJTGoMAIhDUesXPNXw1DAQscoGu+mrnyjDabk2PWiVErQD78TiAywsif
         hPV1bMDJZy9byidiw9/yBKtMWxTjajO/dAMHeF+JOpX5ezOYKaW3ldPTDNyEh12/dtyG
         LyrQswf4wLX03zAIe5tyk5yXOT1fAfTfXn13Yd57g6BVmYY0xJf659jCDUlMWZURj/it
         YQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101356; x=1752706156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6WjSQwUs71DxN/QS/li8qkFp059A9PRc4gKLJpYF90=;
        b=O7O8l2Is0anhDReOrYETe41RMy5Xx1g0e1OEYw6BRdgcKmmkED9m+tRwZSRWnwNzc6
         C50OUiAoM1rGygxyeXIj4KKVbIyJJanud5ZbEQnFyab2fuDYv/SPzCNwZBVMIcTG3EUk
         pqwGki6webLRjiSmVIg1nEgd0D8KOoit96jA8mp6gZWS23B7ChaoO1ewqUMSdLD4uOUD
         thYzWzgDz+61Vlmi0bTWgALiSmc4754rcYS1AGt5x+zm2AhYYHDGmKjqvo4bAmH3i9l0
         pnGTb3foY3v0rNl0rkNaxGUsqW3PGY51dat4tim7FItht/oaXeC1+51p8Wr5tEy2vaYV
         m6Og==
X-Forwarded-Encrypted: i=1; AJvYcCXwPWIX5yVLSb3wLn7U0Q6cE2XTXLTZ5uJ+45GBdsxWjYkwOyoojGJOXpjC8KDZsPHGRjmZsguSXFHjWzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ix5Tfai5Wf04MHAT9ZGmA1XcsQ0nJlDWaporYAT4cThUAMZe
	2kiKAboZiL6tJty6d84CA9l1iiDf0nelSZmsXKAnmSIbhpApDGyxNEimIPmWc/E4HMUo2Mx5Xa3
	JJMvmBdT0jbomF2sg4laXgokdqrvwYWjV3/9rkTXq
X-Gm-Gg: ASbGncu6EArcM30q1ThgfBQX6Ot8HKMuGdY1cWWSiqU3trAfMQWRJokRn275rkis4bQ
	0+sSAUq4/rpkbzbNy5pObV56s+d4OhLx8Xq5nAhPGhMLP68A29ubXWLWAVXJjtEsiDhOABBBhaO
	ibNJrtW98GCC/NQbevI5zOI94pjq1E4PkohS77mWJ1M0F4dqrT8Z2Djm7GdX1JHQNEHXX2HhI=
X-Google-Smtp-Source: AGHT+IEoLIbt2irsqaGFGtwHQ7Zx3lleok1hVEoxG8Q0E/4zF2n2wGHgWR3nGN/o+VcFI1aZOZtarTXQzy3HLGYP+Sc=
X-Received: by 2002:a05:622a:15c3:b0:4a9:e17a:6288 with SMTP id
 d75a77b69052e-4a9ec83be88mr661451cf.13.1752101355509; Wed, 09 Jul 2025
 15:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619000925.415528-1-pmalani@google.com> <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com> <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
 <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com> <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
 <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>
 <aGuGLu2u7iKxR3ul@arm.com> <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
In-Reply-To: <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 9 Jul 2025 15:49:03 -0700
X-Gm-Features: Ac12FXxtleLMdf-VJ5bhxQFtWFvonHrcLTRu8uMMp_CtpDUSsgekTEVB0oyKmNM
Message-ID: <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Beata Michalska <beata.michalska@arm.com>
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 10:25, Prashant Malani <pmalani@google.com> wrote:
>
> Hi Beata,
>
> Thanks for taking a look.
>
> On Mon, 7 Jul 2025 at 01:33, Beata Michalska <beata.michalska@arm.com> wrote:
> >
> > Hi Prashant,
> >
> > On Wed, Jul 02, 2025 at 11:38:11AM -0700, Prashant Malani wrote:
> > > Hi All,
> > >
> > > Ionela, Beata, could you kindly review ?
> > >
> > > On Fri, 27 Jun 2025 at 10:07, Prashant Malani <pmalani@google.com> wrote:
> > > >
> > >
> > > I think it is pertinent to note: the actual act of reading the CPPC counters
> > > will (at least for ACPI_ADR_SPACE_FIXED_HARDWARE counters)
> > > wake the CPU up, so even if a CPU *was* idle, the reading of the counters
> > > calls cpc_read_ffh() [1] which does an IPI on the target CPU [2] thus waking
> > > it up from WFI.
> > >
> > > And that brings us back to the original assertion made in this patch:
> > > the counter values are quite unreliable when the CPU is in this
> > > idle (or rather I should correct that to, waking from WFI) state.
> > >
> > I'd say that's very platform specific, and as such playing with the delay makes
> > little sense. I'd need to do more deliberate testing, but I haven't noticed
> > (yet) any discrepancies in AMU counters on waking up.
> > Aside, you have mentioned that you've observed the frequency reported to be
> > above max one (4GHz vs 3.5HZ if I recall correctly) - shouldn't that be clamped
> > by the driver if the values are outside of supported range ?
> >
> > Verifying whether the CPU is idle before poking it just to get a counters
> > reading to derive current frequency from those does feel rather like an
> > appealing idea.
>
> That's good to hear. What can we do to refine this series further?
>
> > Narrowing the scope for ACPI_ADR_SPACE_FIXED_HARDWARE cases
> > could be solved by providing a query for the address space. Though I am not an
> > expert here so would be good to get some input from someone who is
> > (on both).
>
> Who would be the expert here (are they on this mailing list)?
>
> Could you point me to an example for the query for the address space? Then
> I can respin this series to use that query and narrow the scope.

Actually, if the idea of this optimization (the idle_cpu check) sounds
good to you,
I don't see why we should limit it to ACPI_ADR_SPACE_FIXED_HARDWARE.
IOW, the patch can remain in its current form.

Best regards,

-- 
-Prashant

