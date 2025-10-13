Return-Path: <linux-kernel+bounces-850540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBABD3227
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5B034E8ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0B22E92D6;
	Mon, 13 Oct 2025 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiOlibJ5"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C62BCFB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360809; cv=none; b=m8NoOyZTk86jy3NPH6bpxqyx6UQn4o0UZzXUnF9ph3bv0qKvmARUfwNwlnBpJUx+6aH71nL++ml0KvnW1cUmpkNQDh1u2WVaYquci3YOVcWpz1T+yvVKT7Pfd59klAuwMgBhENj5RMxl5h/HAJhZAqSSwoBfAfehp4kiTvwbjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360809; c=relaxed/simple;
	bh=+JrAJiQnQesllvCVS422pN9G7kOwYoBJGo6cNnQcMxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5ExinxWwRyDuhNtN7VkLvi64rVaTjl5Zq39P2xESdfyBSr5lSTD5roFt6eNJJwH1LjHBxi3TX86dvNVehyL//nVltV+qj0wO9utWAp3Vw1IFnjfjw38emIcMFFv05wYkIqkAr61IcEYPHeO9QqLGKcLk9sDz0YeEESEpRjqbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eiOlibJ5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so8641604a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760360806; x=1760965606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TubnhjRQIQK9VyxP1w8Jz/JseEsSrSwGf9ziOFfYLUk=;
        b=eiOlibJ5/e0rtLpSxXO6zkDLWExpzrnyXewAdxv5R2EcIo/73WXlE1Nvgjv5uhqygr
         NNEabwXoVAxcheT+2hlbAt3Czs9xgE6ZfJIPMzfKPzpconC9lfzW6GDQYaSu0gYyTikP
         WjB5PYP0+8+P+l2jN1Fszo+F4Z4ILnRgeD/iEg20k6c14qy0tYM3vyhODn7N2lgOGSlW
         44nxHyJRG3kbAljXVkc0bN19+neNnsH9N957FxJp005qcFj3N6SJV81VcToqQg9kjiit
         M4nePVHHecvWNupOhC97DyQk/wevl3ZVKB6K3yfcAbjey+9aV7lRgOJ8LUhszN9ZIIXC
         2YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760360806; x=1760965606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TubnhjRQIQK9VyxP1w8Jz/JseEsSrSwGf9ziOFfYLUk=;
        b=OOACJb50hvVi6TPZIpUEqIFlLSqPTVbXvomgsYJYwDa2Vja4p0cgoaoUZihpEfCXd/
         zR7HHzCDFQstdO0xUAHCG5EBujGH9dgxm+L6osumfZ2ZeJonFyB65yolB2fCExQVmlio
         FPNbnZPVhbqMTcs4hKn2MKdBOaiKj1aQQOKoqFakeHNovpuVcW5CQOEaJbnid8qtXTHn
         0aMd7SpzPCPmNNLO3A+APmJQ2KQj1NOVvW57iyVNCGO74BdjHihXIPhaxnX3eQ+Hiz5X
         snF8rYVyFxCfC5vWJnfrWCdAVDMWwOpQWtSvoVLEx1KbfcqtOtLnZi9UvYmyiJScjzWO
         nBpw==
X-Forwarded-Encrypted: i=1; AJvYcCV5pWtDlRzbEb9ps/MddgDTgHS5o+gh+iXzMp+J7+F7ZoFcdKgIhftKyshcLWpNdWCdfxGrLdncofDQEMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPjwJ71JjHDAUC828ui3uU1I/pMXV7wpU0lfGMZ7Ka2i0p4ud
	uUV6L5VIE99w4VVIw4SDSTaOhEQ+bA0st/7pCzNyik3a7cScjv6jLG5A5x41jnh5adtjmZJ2zaN
	d4bgaJ1YnuxEK4MCD2VxdI1PGZIk7v3cD70mIQxPyzq8BzI7szk820KG9ughj
X-Gm-Gg: ASbGnctvjn8FhFiQmQm5A2HEZTgeY+9PwTjIzn7Ic/4fHxbxXH36NkpJoIaNExnX1V0
	lU0QyFmB5hFAzzwMIkAEw9dMP4tDPG9rJ2AbOoGh/LFQMlc/OKDbtXE2y95ZddxpfrZeGrV+jnv
	INYnB31WGa0Y0sq+Kki+mReDyDj6Jrds4X4gc9DfTW9aqj4NyEsFpcsbnBlFLWNvjMZCb8LZByE
	xiFaXRACP3vAlyEc603JDml1TpsZbjXpbf2ZDCffMM05ZA76GwoPGJ4g+TPwUM=
X-Google-Smtp-Source: AGHT+IEJdl7nKyjjUWp7J9J4Bp6aSrz+/GMs1soPCOuRkAB+TSp97XKDTmI2RGo+buNVNeL9bBaZ2PquGW3ObBFY6yU=
X-Received: by 2002:a17:907:6d25:b0:b45:8370:ef10 with SMTP id
 a640c23a62f3a-b50aaa9c419mr2027646866b.22.1760360806112; Mon, 13 Oct 2025
 06:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006104652.630431579@infradead.org> <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
 <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
 <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>
 <aObK2MfxPyFcovwr@slm.duckdns.org> <CAKfTPtApJuw=Ad8aX=p3VLvMojyoxVBVRbMG80ADXR-NVL0PTw@mail.gmail.com>
 <20251013110449.GJ4067720@noisy.programming.kicks-ass.net> <20251013110911.GF4068168@noisy.programming.kicks-ass.net>
In-Reply-To: <20251013110911.GF4068168@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 13 Oct 2025 15:06:33 +0200
X-Gm-Features: AS18NWAzGT3q8fm8LwBT4URFj98EAHmqBs8SLH_4hZU7YH6-erXmlA6fCUaV1_I
Message-ID: <CAKfTPtDGsS-+DZEemg6vqbQVV5Xds9TNVnOAOvyeNsw0Kn3Mzw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 13:09, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 13, 2025 at 01:04:49PM +0200, Peter Zijlstra wrote:
>
> > Bah; so yeah, this new behaviour is better for indeed always calling
> > newidle when it is needed, but you're also right that in case of ext
> > this might not be ideal.
> >
> > So I have a pile of newidle hacks here:
> >
> >   https://lkml.kernel.org/r/20251010170937.GG4067720@noisy.programming.kicks-ass.net
> >
> > and while I don't particularly like NI_SPARE (the has_spare_tasks thing
> > is fickle); the idea seems to have some merit for this situation --
> > where we know we'll not be having fair tasks at all.
> >
> > I mean, we can always do something like this to sched_balance_newidle():
> >
> >       if (scx_switched_all())
> >               return 0;
> >
> > Not pretty, but should do the job.
>
> Oh, never mind, none of this is needed.
>
> __pick_next_task()
>
>         if (scx_enabled())
>           goto restart;
>
>         ...
> restart:
>         for_each_active_class(class) {
>                 ...
>         }
>
>
> And then we have next_active_class() skip fair_sched_class entirely when
> scx_switch_all().

Ah yes you're right. fair is not called in case of scx_switched_all()

>
> So in the common ext case, we'll not hit pick_next_task_fair() at all.

