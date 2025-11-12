Return-Path: <linux-kernel+bounces-897867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB2C53D90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A94F2760
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5334A3B5;
	Wed, 12 Nov 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GJ09pnOY"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7D336ED3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970245; cv=none; b=Exr1vYRpXQ1R3x2KYsPhemz1GzMYC0Z69JobecJsmVEi9bKjYuoXJUYDUx9MpQVc7AKqPAgXuQ6f0LEgXJy1clsK4kkt+sDiiGViYeEX/Xl1yykADlTON1P0WyHp3g4YJxUS2DtoEs35xhVKjZCV9RBPlT4zjmUmnNIqnVjIWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970245; c=relaxed/simple;
	bh=MjEDmAYq4++Uq2lZMtscjOWc1UU/sEDwm5bxzdQwgKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grwBsSJ7P3rPCFXZ3jcxTOTr2/29+ks8Ps2zfWX7yXqqeP6yc1j0sEUslbTsGV7wGQUqYtTVyU9M3HOk+ljS2ctD5nXBJ721bx2R2MskucBSpcAZMhEoHppo6A7XwHKN924xTjgKi36Uq8fmF9jzFiUcqscV1XjQJdnfv+IfgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GJ09pnOY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-594270ec7f9so1134255e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762970242; x=1763575042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ewolTBS7IZhPq/yo/5TbBzsZlBs135aryiIEkWYvqI=;
        b=GJ09pnOYIIUi8zUlB+/LmdkFnoXWCl2PymtZ7bxN961n/YsXyNFy8fvViIuHHGP5n1
         HvWzISfzdTE32b2lXT9ubVFGgp4E9lc66kJKvQzs0byf9v6Sn7qe58YvCNKfH1lKSMG+
         E2OGWKt/dtTE8Ja9q4KJXpZY0neVu09QC6yooF+5o2etjk9zINuhh6XZm5FKwPDBwaXH
         AwGKj2sl4YRK7qCAxCKqMplfFuC/m5swIWIBzs5CDNEYrcOpYFN5/Fe/UR3wBSxkZhc7
         P/f4r69I49E3zIBW8+Ahje+FQCrawYpuy7VMWeGgXQUjiGkfu8KZ9unlCnw424CBhmWv
         t93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970242; x=1763575042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ewolTBS7IZhPq/yo/5TbBzsZlBs135aryiIEkWYvqI=;
        b=reaNCoFegbg2Mz+3X14VHk6hJz1tm+JCcRIUOKWIcvu//LjxnumyF1HHLRUnafIBWb
         +iK4nyacfSjTQBpk3T/NfAE2Dd3MFX3HMVymH3ZWL/i8Eh62iGzGccN1PZDy3T3n/K90
         sY0IoLCfP1j3/COUnB+96fRJ1DFM0LOJTBwUk+rKNQmf8zwiuzXZS4EvMsU5hf6bnyMG
         S03XgD4v1dIXA8nxrZ3WTb3smVlvY4MwKaTCniOrz2OcWx4V4ShlalrpD8MBXXKvTqwH
         jGI7UQ4sOaTWL34fczfupdez8s8O0pS6HzoHQNboI6pGrfqyHTIlF0XqzBfSRLPaLa7Y
         Pt0w==
X-Gm-Message-State: AOJu0YwQ5K7fgBBiOPaBWTizY+MbokVKzmj65glQdKqgwoI62woM0o+H
	pxMcQjU1aukuL7VYOEyyLdgaV1+9pSxvSV/yN27QDymwhpokFGSE5CmxMelbGkmqR2l8ItrhiSr
	ILAqcQn2itMcSh+zgJYaNBwBNjFxJM3Z7HcD0la9nIxagDcz8bkHUiTI=
X-Gm-Gg: ASbGncsik2TZVLT5UtLW7obwynURT8USGaq2101qs9znORGG7OJmesdYdBV01Uv19L6
	pAUQbrrFHmhVYC2tM8kIe7GuvwCdJqHBeJP3aT7A/z2GKWqfYFrc62dMvHKk1hteFeM7Cf5xG6u
	exNtxYkO5qbeTpY8NZhr6KLzWwpATtzgLH1G6flxUC8Gm0XvK1GSJ+CIXT62AWpvNKNIs1wo/QW
	yiFrjQcoT3Qdhp5/8+crv48FX/4tZE727D9b2fw4UMLWybUM8q3yevydz1rM18/4SqDlGRuCbap
	LbysxxY6LdXk+7zzmA==
X-Google-Smtp-Source: AGHT+IEmeeVaV5q744epyzVmrwDVFW7j4/cmgThHS6LnRlZKUqyjMPJJRdHK4mRn9u1u/f1P1HM1MIsX1SPUfQ8SiIU=
X-Received: by 2002:a05:6512:2388:b0:594:2d02:85b3 with SMTP id
 2adb3069b0e04-59576e02c4cmr1410016e87.8.1762970241801; Wed, 12 Nov 2025
 09:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107112354.144707-1-marco.crivellari@suse.com> <aRS9Vk6yh1wEq614@gcabiddu-mobl.ger.corp.intel.com>
In-Reply-To: <aRS9Vk6yh1wEq614@gcabiddu-mobl.ger.corp.intel.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 12 Nov 2025 18:57:10 +0100
X-Gm-Features: AWmQ_bl8otP7iEdFT2es07jTQBY0O2yc5dPncwp_ZOFehTsDj7eU4vYdCQlrMH4
Message-ID: <CAAofZF4UJ1UGAH=r4cWn5HssTinY5e=aXRRMj95Bz40deakmjQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: qat - add WQ_PERCPU to alloc_workqueue users
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 6:02=E2=80=AFPM Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
>
> Hi Marco,
>
> On Fri, Nov 07, 2025 at 12:23:54PM +0100, Marco Crivellari wrote:
> > Currently if a user enqueues a work item using schedule_delayed_work() =
the
> > used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> > WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies t=
o
> > schedule_work() that is using system_wq and queue_work(), that makes us=
e
> > again of WORK_CPU_UNBOUND.
> > This lack of consistency cannot be addressed without refactoring the AP=
I.
> The reference to WORK_CPU_UNBOUND in this paragraph got me a bit
> confused :-). As I understand it, if a workqueue is allocated with defaul=
t
> parameters (i.e., no flags), it is per-CPU, so using queue_work() or
> queue_delayed_work() on such a queue would behave similarly to
> schedule_work() or schedule_delayed_work() in terms of CPU affinity.
>
> Is the `lack of consistency` you are referring in this paragraph about
> developer expectations?  IOW developers might assume they're getting
> unbound behavior?

Hi Giovanni,

Sorry for the confusion. The first paragraph is mostly to give some informa=
tion
about the reason for the change.

It is correct what you are saying, indeed.
I will share the cover letter (for subsystem that needs one):

----
Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.
----

You can find more information and details at (also the reasons about the WQ
API change):

https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

In short anyhow: that paragraph is not directly related to the changes
introduced here.
Here we only added explicitly WQ_PERCPU if WQ_UNBOUND is not present.

Thanks!

--

Marco Crivellari

L3 Support Engineer, Technology & Product

