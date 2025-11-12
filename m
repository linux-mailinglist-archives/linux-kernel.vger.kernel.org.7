Return-Path: <linux-kernel+bounces-897133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8ABC521D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5353BF9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6E6313268;
	Wed, 12 Nov 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfFkJwF8"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FEF310624
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947968; cv=none; b=VFgEceONKJFzSCpqFCXjsaIg/cws1/TzGq4xBq4W4RDPiiRwdQlQSpnbTJsptoXcsRPhiJM5jhHTX0t7dC56jnRNi+NnRBR4nX6q7KzU7xxzkpg6fkuYxm5NVR+W58FIJtvRQEymf9vg9UAd9C2/y0Vdn04TI2b82Vgs2V+lKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947968; c=relaxed/simple;
	bh=vZUWSCQIpZTxI4lRbngolIKzMpkUCMfsbaQVmPwJkik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cy9t/aeJV7bAKu6wiNzhXWQZ0mLlZhR2EndoJPX+kpcjF0N/7y2tAB66DbVYrym/D+3oCY/Ysc+zUdWALGTJgYCkNx8Z1A1rW3UK+J3yQbOGthMp9wHBDWA2BwEpgoUEGPIfx7OwgHnI9LIzszjtv4fP7Y41mWuh+dPuy5VKG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tfFkJwF8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787e35ab178so7602597b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762947965; x=1763552765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2qMZBPGj+h/uNpt9ZMgHu14uO1vCueIFHkFnzkVCS0=;
        b=tfFkJwF8pXIv5X9YHMmjgwSoMB7pmYPH+ZLYIqOhmhzYZvNBTFgKQU9xXH/HNYx869
         dQ6Lp0hMzw0dJtjfUTvjmVC9svaoFqeqH3xF/usEV4+YwIycXP1owT71Z+xQntUZey5x
         F4Ozk3/8Xx5mNLA2ZKcNhFU1o8bGiLJRQU092TyVI/22lqJSHfEZL55ouSHUxF2iOmS9
         Cn5QGWFAGujElfv9uln/cImXUvCJ4+ziB4KsGXwmH6RgMSSKtE41gJAnCIZWNrJRNaAZ
         bVm1QUwOxBNQtOyKnsi+81tIk0A2RzXTzdXaIwD0C7AV9GJwKMWuMpRL4su94LazFLdB
         +SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762947965; x=1763552765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2qMZBPGj+h/uNpt9ZMgHu14uO1vCueIFHkFnzkVCS0=;
        b=kGgNKfrvkkwf8dmHPn1ghTJ5NNpccg/xU6L30bLfu8SX/ecxHprdGj0GbXqJVK+A0z
         e2YZ2qcYbPskMpTajCLoqijU8n5qWp7IpAyDdZ+ac6LUvCX+fjVxMFAs4p/5uEDwMHEh
         SRZ4LIAC21jc1i1H/N7UmeP7zWTHgPRBS69tIdu6N6xfzQSFLyG9zJUxZv8om+dr0/G7
         tp3EDPJrQXbxKRYnN3H8UNsy4oVAp34dEwLo2eZXkKpB3gqSfrb5TEBjqh2ds+01iVhd
         w4t0789eC399dTfo/hI8Im7jw24Xq64+OHCvmclvOJ7B6zVJEcqwp1ax0cR+rCp1h/bW
         c/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXtcRKAs5FYmaWomlbWfhCGQub8DzNuJSGHGVlCdo6M1SC02dNBe9ctGMcwu70+vb21m459gbl0cRck8eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwCloCsDyXDcOz8C1b2631wsZNirKBn8An2/tWnSXIti8aEbi
	my61+GpJicvknI6jeTts9RxA10e6rrfDlCK8rpu7mEr1upzOqtZ6rgnRan+APb9zva08RZAIKGi
	02p0KK72xMaHTgN76bQmRgbujZNVWyTAgrfASDzmCkg==
X-Gm-Gg: ASbGncuHOSUJROE1ZlQJ6QP3ag87CEgKYCl+KYBVSZsxWFQpmMbXRyp/VFI7YoKDAFY
	jj88EmjOFaSJpbfgnkSxHHQmKWFJI2PkqUgoK+WtjDL5vnp2sLJntV6nkQ5Pxbae8S4GpRmqV7T
	CEG5OSE2sfEdk8Cee9N+mdXhGU0M2cQyNFW38bft+ib/qNwLvNIst/v3mn5cpOtMI2uzFF8n9CU
	/6V4NnIJnHn+nJwOMuaND7pQX6X2+HpBYiL2YIT1jTcDQFJ51v9cvemv8B5GQ==
X-Google-Smtp-Source: AGHT+IGkn+N5zQyXYEQGDK4CC2hGaCbuvbo4Sq23RcQDAxvsmQHt5AlzKM1puzMz/T2iHx6hMSx1jVKyy02rK8jCvkI=
X-Received: by 2002:a05:690c:905:b0:787:d456:2e80 with SMTP id
 00721157ae682-788136e00d8mr21345127b3.50.1762947965608; Wed, 12 Nov 2025
 03:46:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141654.226947-1-marco.crivellari@suse.com>
 <CAPDyKFq46qON9W5akWh7CV5fiGSLHV=K9F_Uj6u_g1g08DPV=g@mail.gmail.com> <7e99c811-2081-46b8-a089-19d6e1778cc7@intel.com>
In-Reply-To: <7e99c811-2081-46b8-a089-19d6e1778cc7@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Nov 2025 12:45:28 +0100
X-Gm-Features: AWmQ_bmN2O0wWXlbNMIvk6Sh1olsnCNZ3MtgPCuyWboPHhZCXxqncRDHta7XpjU
Message-ID: <CAPDyKFp3wBv4Kk5TXjQ49CxUjV1sd3uxreX0mOKpD5Gk=OiJrQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 at 07:49, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> On 11/11/2025 19:12, Ulf Hansson wrote:
> > + Adrian
> >
> > On Fri, 7 Nov 2025 at 15:17, Marco Crivellari <marco.crivellari@suse.co=
m> wrote:
> >>
> >> Currently if a user enqueues a work item using schedule_delayed_work()=
 the
> >> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> >> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies =
to
> >> schedule_work() that is using system_wq and queue_work(), that makes u=
se
> >> again of WORK_CPU_UNBOUND.
> >> This lack of consistency cannot be addressed without refactoring the A=
PI.
> >>
> >> alloc_workqueue() treats all queues as per-CPU by default, while unbou=
nd
> >> workqueues must opt-in via WQ_UNBOUND.
> >>
> >> This default is suboptimal: most workloads benefit from unbound queues=
,
> >> allowing the scheduler to place worker threads where they=E2=80=99re n=
eeded and
> >> reducing noise when CPUs are isolated.
> >>
> >> This continues the effort to refactor workqueue APIs, which began with
> >> the introduction of new workqueues and a new alloc_workqueue flag in:
> >>
> >> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_w=
q")
> >> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> >>
> >> This change adds a new WQ_PERCPU flag to explicitly request
> >> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified=
.
> >>
> >> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND=
),
> >> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify W=
Q_UNBOUND
> >> must now use WQ_PERCPU.
> >>
> >> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> >> become the implicit default.
> >>
> >> Suggested-by: Tejun Heo <tj@kernel.org>
> >> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> >> ---
> >>  drivers/mmc/core/block.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> >> index c0ffe0817fd4..6a651ddccf28 100644
> >> --- a/drivers/mmc/core/block.c
> >> +++ b/drivers/mmc/core/block.c
> >> @@ -3275,7 +3275,8 @@ static int mmc_blk_probe(struct mmc_card *card)
> >>         mmc_fixup_device(card, mmc_blk_fixups);
> >>
> >>         card->complete_wq =3D alloc_workqueue("mmc_complete",
> >> -                                       WQ_MEM_RECLAIM | WQ_HIGHPRI, 0=
);
> >> +                                       WQ_MEM_RECLAIM | WQ_HIGHPRI | =
WQ_PERCPU,
> >> +                                       0);
> >
> > I guess we prefer to keep the existing behaviour to avoid breaking
> > anything, before continuing with the refactoring. Although I think it
> > should be fine to use WQ_UNBOUND here.
> >
> > Looping in Adrian to get his opinion around this.
>
> Typically the work is being queued from the CPU that received the
> interrupt.  I'd assume, running the work on that CPU, as we do now,
> has some merit.
>

Thanks, I get your point!

So, to me it seems like if we want to explore other options, it would
require us to do more analysis to avoid introducing performance
regressions.

BTW, do we know how other block device drivers are dealing with this?

Kind regards
Uffe

