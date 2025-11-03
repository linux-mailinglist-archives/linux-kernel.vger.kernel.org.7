Return-Path: <linux-kernel+bounces-882511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E98BC2AA0D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3DAA4ECC89
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3740C2E2665;
	Mon,  3 Nov 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9Q2rxdB"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A82DFA32
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159653; cv=none; b=Qr79wwp2k7T0D1Cd/m3aNPppg5ruc6Y50Xk3TwZjrGqMvCYvdgJ7jYWW5T40rh8Y9aj5vk3CAflqhBt0XbQJBFU2t5BEV2qdzPn/4qqWarMSWNRNra2ryEwQ97O1GLEqHK0jXDyOmQn7kpamx1SahtUYUbHFoteqI81dhWxCNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159653; c=relaxed/simple;
	bh=1X2By9QoThsdGSa5CA88Md4gR1pD3mMBEB9rDlXDtgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lB/jzmpxjM2d7rHigObu0a8r5JYbS+We9wcSxNfE8er2DnvRbZzUvBdCLFSz6iXuVUegYk3FJ+Gu80CVFgHD555nqpLSfxWtS6DIGq+9CO3FrDZGjFxvSgvoHYFj3++Drk4BHQPsM/hYqNvOIzlykKNF73aSPRUeWhmDOSh4dMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u9Q2rxdB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29470bc80ceso45290955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762159651; x=1762764451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1X2By9QoThsdGSa5CA88Md4gR1pD3mMBEB9rDlXDtgg=;
        b=u9Q2rxdB7TKka87ADzE6bQN/eld2Ir7a9vkvcukwJ3iNnUYWijm1xtUJ1lGAfBpL5T
         1o7NwzxdD6BMk1BP/8CWf23Z7I1MoVkQsnQt6dGZYXflHhP+x2wemodYoJMBmxXMPvs4
         EXJffHvQxmdQhLapMzqwFJRg/ZzpyZDmaT9hpkCFWxeAY9ho2OCfgy78HL6m+y7X2es0
         ZEoubj4Jd8+6XJ1JfIv0spJgc0dicxrGhjAAHkPNCssS9tkHQxDxoo+Fwip/lka+KgFT
         bNY9iIyhoo+nTa2RO3etYTDTeEg1WleI2djp2fmzQYEqwK4MG3Wu3QuTPQ8ZdHtQ1eZY
         gJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159651; x=1762764451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1X2By9QoThsdGSa5CA88Md4gR1pD3mMBEB9rDlXDtgg=;
        b=NK3wh7dun+Z0R+6pXNeXTThfwfPma13WF4EpLpAB1JqdoWh3jCTDChu7wQw3zqFRd9
         RU5bbol2Dfl9FDOJgenLXI9n/Ao2GtMq6Coh+jCuVcrUfR0XVucJDk8MfCjvGNeTBkcV
         o+4iNalFzdM5DGj6pC5FQ8/IoknKmjHMVO8oI/ktF8hYOJr8zJ9NcPhKt+IXV5NX83p7
         3dS/5RX6hc5963Wfs2CvYBuDWMC7/G6RSiiI+I4kSgHJ9wGG3pF4CV5kUgMypNu6IpX2
         Z1mePxlOek937GL+tET4lYe27DX/8euGla3UwqHCk0KdJTke5J/Mwg7guVMP1Muinkz+
         DoXQ==
X-Gm-Message-State: AOJu0YzjtRp+lK5M5YCU1vz1yzFHdXGxjynx6Nx9e+xOmxaDJ1+wQWS7
	GKdgAS/vDJi4aJvjcNL1t8Oqs5gOmSba+SRXfIdjCn1kp51Tr4jKvtVqrtdb1gDEcLKZaxqg8RI
	puhJ+2r6VmvxtFoNuTfrNkIgMsVGZQgiwxCQ5EAxOLg==
X-Gm-Gg: ASbGncsKf5MtWi4fGSW8P6COdwD61eSbKMLBhd7dDdf4mvWgaaLCz9hmklEiWDqrRIv
	wGw0dCpoHmraox9OCNT8+EPt1OPyedM2sAA9TomEaFmxtF/OdNU5Zf/dCMa1IvL6qyhSwrUQIQ1
	2tNHO29FEzcFI6iayRya0hiBcFOap8ARsEmNPuhAdOo9uDfu5YTq9XC+P9EUsdVMVC2dIli4Mk7
	dCqClCA9PnAG1CZsPSCXREqfGXRE9gKcsvyjErTXcRIjUZXUdVrNwInf7LLPA==
X-Google-Smtp-Source: AGHT+IEiPTsQwQmjnN2J2GJDQ9Za9zoUC977FiwEF1W5fvbJaKj2P0HWSCM/QFTK/S/yIJvxhgV0PffM5gtHzmdjQQw=
X-Received: by 2002:a17:903:228b:b0:295:4d97:84f9 with SMTP id
 d9443c01a7336-2954d978dfbmr90787815ad.26.1762159651160; Mon, 03 Nov 2025
 00:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029060757.2007601-1-srikar@linux.ibm.com>
 <20251029060757.2007601-2-srikar@linux.ibm.com> <CAKfTPtDW9rApEm+4qSrEpRDMA+68BnVOgegKUZUa5S-gKnR--A@mail.gmail.com>
 <aQHQ7UyaK849BKV8@linux.ibm.com>
In-Reply-To: <aQHQ7UyaK849BKV8@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 3 Nov 2025 09:46:26 +0100
X-Gm-Features: AWmQ_bmrR_yvsXkBlqoY42TLV69O97bhzwYzWqV56CRBaYZDsYsoTTM21b2VC28
Message-ID: <CAKfTPtDtfy7=rb6rPVMAk1+Bq4w=+opiWuo_Y+3dy3me--6KsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/smp: Disable steal from updating CPU capacity
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Ben Segall <bsegall@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Sikar,

On Wed, 29 Oct 2025 at 09:32, Srikar Dronamraju <srikar@linux.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2025-10-29 08:43:34]:
>
> > Hi Srikar,
> >
> > On Wed, 29 Oct 2025 at 07:09, Srikar Dronamraju <srikar@linux.ibm.com> wrote:
> > >
> > > In a shared LPAR with SMT enabled, it has been observed that when a CPU
> > > experiences steal time, it can trigger task migrations between sibling
> > > CPUs. The idle CPU pulls a runnable task from its sibling that is
> > > impacted by steal, making the previously busy CPU go idle. This reversal
> >
> > IIUC, the migration is triggered by the reduced capacity case when
> > there is 1 task on the CPU
>
> Thanks Vincent for taking a look at the change.
>
> Yes, Lets assume we have 3 threads running on 6 vCPUs backed by 2 Physical
> cores. So only 3 vCPUs (0,1,2) would be busy and other 3 (3,4,5) will be
> idle. The vCPUs that are busy will start seeing steal time of around 33%
> because they cant run completely on the Physical CPU. Without the change,
> they will start seeing their capacity decrease. While the idle vCPUs(3,4,5)
> ones will have their capacity intact. So when the scheduler switches the 3
> tasks to the idle vCPUs, the newer busy vCPUs (3,4,5) will start seeing steal
> and hence see their CPU capacity drops while the newer idle vCPUs (0,1,2)
> will see their capacity increase since their steal time reduces. Hence the
> tasks will be migrated again.

Thanks for the details
This is probably even more visible when vcpu are not pinned to separate cpu


>
> >
> > > can repeat continuously, resulting in ping-pong behavior between SMT
> > > siblings.
> >
> > Does it mean that the vCPU generates its own steal time or is it
> > because other vcpus are already running on the other CPU and they
> > starts to steal time on the sibling vCPU
>
> There are other vCPUs running and sharing the same Physical CPU, and hence
> these vCPUs are seeing steal time.
>
> >
> > >
> > > To avoid migrations solely triggered by steal time, disable steal from
> > > updating CPU capacity when running in shared processor mode.
> >
> > You are disabling the steal time accounting only for your arch. Does
> > it mean that only powerpc are impacted by this effect ?
>
> On PowerVM, the hypervisor schedules at a core granularity. So in the above
> scenario, if we assume SMT to be 2, then we have 3 vCores and 1 Physical
> core. So even if 2 threads are running, they would be scheduled on 2 vCores
> and hence we would start seeing 50% steal. So this steal accounting is more
> predominant on Shared LPARs running on PowerVM.
>
> However we can use this same mechanism on other architectures too since the
> framework is arch independent.
>
> Does this clarify?

yes, thanks
I see 2 problems in your use case, the idle cpu doesn't have steal
time even if the host cpu on which it will run, is already busy with
other things
and with not pinned vcpu, we can't estimate what will be the steal
time on the target host
And I don't see a simple way other than disabling steal time

>
> --
> Thanks and Regards
> Srikar Dronamraju

