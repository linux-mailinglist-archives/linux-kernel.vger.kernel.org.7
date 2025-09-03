Return-Path: <linux-kernel+bounces-798812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB086B42343
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E18F1BA2480
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069730EF6B;
	Wed,  3 Sep 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+5gInAT"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086DA2E92C3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908861; cv=none; b=ExDFpBgQMni3VQM5D7/ig8XZ7TQrm/vIH/kYfWuOGwoE7jvM3wsT3EJLB5h9sqaGZHDNMqdiVqVXE9g1o5dVYm2czlePn3KqOJf9aRaCZdcWNhnp4J0XClHRdlOSaRIxK4CZBJrEefuwP4pu/2PmjCOx0VquWCns9kQaKpOlXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908861; c=relaxed/simple;
	bh=QgpiepA17U/qu04cU/NufFpWBkWLkfEGGfvsson17Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNwpJGX8lAjlggM10Pnev1m8pygcGzg49o7i78XAqdCUTW3kiAiXA8ZAfsdnAWr92u/cAYQDJxwOr+uwbedK4BoBG7EIPvIKkJZ3mqbdKjzzy09Nd3DYqwbWy5osKynRFlFLoK6GMGFHcM4cWcyK/MxnG2mNDhR8/Qd3UdbDOAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+5gInAT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aff0775410eso86280466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756908857; x=1757513657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Sy4dBfHIaBfhYtqP0F27/527JigtHi7rtrySuW1Mpg=;
        b=u+5gInATMekOWdi9wiSKSc/3ESlXxeYwqJs9dSCifxiM9pULf7r7XGNLZQR4cMZGsN
         tsQwZaHbeyPFfTOcYfNMWf7pi0CFoGzNCX1MrvFsYrBhii7jhVRnUrJ7ZlFL1qoGACJN
         PhJ7sEK3NXAacrDOnKxJvgE332HwrhEgilRzMXVr+yWDLm3e28PwzMQIa5++GAFUNpnL
         T/q6g9GcSzQY//KWiCOTKIZZgpZIN93nCtCrPOCGIx8th+HbZAMzBckoaWp2MnECy76W
         eRXHxN4OvepR4Tgf3OYjJqg2qtueBN1Tj/u3H6ekTE6uykazZs2QJl5n4pGae5geA1No
         rGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908857; x=1757513657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Sy4dBfHIaBfhYtqP0F27/527JigtHi7rtrySuW1Mpg=;
        b=v9i2BDxE8KeFT0r5HrW7ywgwGyUljAkLlaLCMZp7crDeESU1Zk/NGOA2U7FfxVlbnV
         tXtx8nCYN1ZFAi1CRjuTJmk7zTlCvoKcbJB1+fI2lnd5veh80S7tn4hP9QvbqfAGSZt4
         1SpXZ9fsudv3m1OHoOOMG/hxoWAaoW14IcMazCJVu0qzQU4WMdfteUR6tIq9IjQ1LJ0g
         EooUc6qMRi5RVsJQ85xiqx2cS966ldC7tKnATC02v14oc+n4SVJlUymtAsU8PZNEgLVW
         Hv9r6HNR72lGB3OgzjL2v64l50fuXmfz9NhMEh2/7jDa299ENoNctRJnP5esMNejMgEg
         RWrw==
X-Forwarded-Encrypted: i=1; AJvYcCXJp8Sszm/vwnOD2fimG2SbkeJPXUu9f8mXT/z+w0aKJqqM51RE0SweB6r8m2uadkDqexK+PFDBNePfRIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC4yAqdJDn5jdt/RPKLQA7zGOO4diVcHOMoIJIZk19HbwqGS8/
	xjSUUuTCxZMUqMWQMb1BSixLZ/XfU5Ox44nZ3Z/P6H9UwDToxmcjWoQQ1hGZGlobiKGF+8B2WlJ
	94U14+oMuN8HN3+5CBvtl9SdgB3/azGD0Xbsgrq/8UA==
X-Gm-Gg: ASbGnctCVLKDkD8ezy1YeJW49oJfdtzeWruaKnNQQ8xqR7zaDihZ0WeO296tdR9xlzM
	5HYG03iIEU+K/8qiLAtITgRv1PL/ceAGCJaCPntbcBgRcxrPpfGcubiYH6rx2dDmyalIZZGQ6Gz
	+ysLwNN8erE1XgQNIP3HvN5C/KTrc93ATFitZsBAn0Phucw2F1GfQ8ZiD+ur0ZLmDE5lysbakfk
	gcT2MXgMTfDwGN0crOQdvFrK1aLNkU9gKWN
X-Google-Smtp-Source: AGHT+IHnoZB35rTBnlm1Z5y4wBU+VqaQbhFz3flsgBehfjRcUpSLK1lDtAUrn9eqGfYuRe3rA3e2YmEuMcm2s3ic40Q=
X-Received: by 2002:a17:907:3f1a:b0:b04:1cb0:baa3 with SMTP id
 a640c23a62f3a-b041cb0bd49mr1267467166b.26.1756908857191; Wed, 03 Sep 2025
 07:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d421a5ba-95cb-42fb-a376-1e04c9d6a1ac@os.amperecomputing.com>
 <xhsmhldnegqq4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <1db2d6df-16ff-4521-ada5-da585b87b06f@os.amperecomputing.com>
 <xhsmhfrdblnp3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <916176fe-ad43-9dd2-ed1c-6f05f838d491@gentwo.org> <xhsmh4itjlnnt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh4itjlnnt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 3 Sep 2025 16:14:04 +0200
X-Gm-Features: Ac12FXwzS2goNSwNbZWrHsd-vrKf-nlV0ORWmO68Buu_r5foNM5s8K1OQckGNt0
Message-ID: <CAKfTPtCtR7Q6PxRRXGxfKnhyPTODBGs5cFRVL6A0nHx_GnpA9w@mail.gmail.com>
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for ILB CPU
To: Valentin Schneider <vschneid@redhat.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Sept 2025 at 14:35, Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 28/08/25 08:44, Christoph Lameter (Ampere) wrote:
> > On Thu, 28 Aug 2025, Valentin Schneider wrote:
> >
> >> > Yes, binding the threads to CPU can work around the performance
> >> > issue caused by load imbalance. Should we document that 'nohz_full' may cause
> >> > the scheduler load balancing not working well and CPU affinity is preferred?
> >> >
> >>
> >> Yeah I guess we could highlight that.
> >
> > We need to make sure that the idle cpus are used when available and
> > needed. Otherwise the scheduler is buggy.
> >
> > Such a load balancing action means that there is a cpu that is running
> > multiple processes. Therefore the timer interrrupt and the scheduler
> > processing is active on at least one cpu. We can therefore do something
> > about the situation.
> >
> > The scheduler needs to move one of the processes onto the idle cpu.
>
> AFAICT we have (at least) two options:
> 1) Trigger NOHZ balancing on a busy housekeeping CPU (what this patch does)
>
>    This is somewhat against idle load balancing rules (only spend CPU time
>    on that if there is no "genuine" work to run), but I guess from a CPU
>    isolation PoV this can be tallied as just another housekeeping activity

In this case, this should only be done for full nohz case and not for
other cases because the ILB overhead is not negligible on a busy cpu
and I don't see anything that enable 1) only for full no hz

>
> 2) Trigger NOHZ balancing on an idle NOHZ_FULL CPU

this patch also does 2) for no smt case

I wonder why this happens only for no smt case ?   If the sibling is
used by another thread with full nohz, it already interferes with this
one

But we might want to do is_core_idle() instead

>
>    That doesn't steal useful CPU time, but that also potentially causes
>    interference, albeit only if racing with the NOHZ_FULL workload spawning
>    (which shouldn't be the steady state).
>
> The more I think about it the more I'm leaning towards 1), but I'd like
> other folks' opinion.
>

