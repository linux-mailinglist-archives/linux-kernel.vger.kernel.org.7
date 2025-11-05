Return-Path: <linux-kernel+bounces-886064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8163DC34A09
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90F53A7631
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A862EAD0D;
	Wed,  5 Nov 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CCKm0f5P"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FE2E9EBE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332940; cv=none; b=QWcQH1BnlTNX4JZvGgR9ydF5Mum8GrhCvpYHiH8iAITnWGoXfqoSlYEp0pPQauOo7rA/tCygb0O3XoG1nsdqT4eggykymWz30ENpnAH/29Z4UMh4ejV0Puow7AOhShG0tIer7Rw1YL8ZeXU33Jdlk9x0Qr5hjM7OOt26M21KHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332940; c=relaxed/simple;
	bh=3XzqJkACJTnBrY3n8Y/2hXaChUELFZ6bE8Jx9Sk9b98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ank8xkjfLndr4xur2i0DgtVdddDRKt8+GQ2zBVHvUsPItDmsrhUccOmij7NP/QkAlNh2/a0TY95OnDvsdTUpDfC+S195TKDRqtdvUT2mOGBVEUJ4k2UcWQp4DiPXwtjLXpDUI8sv9WFPccL5/YtxeyOkrMEXePS7W7o7QG7gbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CCKm0f5P; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-594249d3732so603393e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762332937; x=1762937737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XzqJkACJTnBrY3n8Y/2hXaChUELFZ6bE8Jx9Sk9b98=;
        b=CCKm0f5PO/c3drCeyipVkSV+5wNTI7NMlfrfL3rqiwrPqlJEGZFph6CgBLwqoMNxJG
         9koE4hscmDfr6qV3yAn+mapKKK5AFE7jNqHhXcKMhyEALNMVYb5QatqlpUGHp99Fa5qV
         siEa997O3OkA1U2Uk+vvzd6xYVlwq5oga/qmh0Q7zgvvv/QqMCUr1ESTtL9xfiMX3n0j
         UiJbVG5/1zWsi4XKqh1oJ/XFSMSMmEWFBBFLIvE/nEHmteKSDzdTP7VrtAsXSmZ2xclu
         v8o7/O46kOzx7ywBS0gHPiCYP8q+po6wGb9cZ4Pi4+HPD5B9jyV3PuL+Xq3LrOahZH6i
         eKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332937; x=1762937737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XzqJkACJTnBrY3n8Y/2hXaChUELFZ6bE8Jx9Sk9b98=;
        b=XGvXqBKvxffU15KEXi4058vx0RvvbZPKgMgPKxN6dlNiFiPItYm/Npy4iCWR4sD//V
         RxRHaTm/bWDtqLd1RfY4bUCHm4OMunSQtZWu6Mfu+jFWScBnh/oT52Qr/fnYwpLA2MFy
         /gRuqvuATwVO1p4nm0QfZPAgEXtsyrkCLrlAgmLT7ztibzACKEj1g/sutHaAJMns8vnV
         7r4qnBlUFzUFKDm6DCBCKXI+TnGWPl5ElzJ7Y4Ux+pYP+UU3AEGphfwxINWRWZbsGftm
         FLc4qSYZdY8JWIcLRjd6z+f/h7v1gb1ctHrlh9AblshotWyzV1qPISU9xw4E1BCXlY9d
         lryA==
X-Gm-Message-State: AOJu0YxOo1SH1HJM8JpbGo8TlK7csP48ad69hLsOepW27Gc/WdeSHfgu
	phv35OicrRnM/ec14D5cnliEx9E+LJHcIJAGga805ZdRj3mbcjL+G6uXZz2+ecR8LT2PFX5DslL
	75LBMzyx6Yjn8/s6fFiudD8RWi33puCWaNaMctG7CAQ==
X-Gm-Gg: ASbGncsDl/nTXmeRFnGNDBC8xXJl7IeQnTWZel1kmDllx20XlJB9eThA4U2hqR+GhL8
	NtZAdk3slUzpgR045X9ypw3Tdx456RKeWwAu9tyuLZk1+atXgAgeDAtNQ0XIZxLyAcqRd3n72kU
	41DyjE3CxnnHRxWoFdwjCy/6sfKcgCYqntKTavYwBvp7FUCtmT6q+LwqKPiYTRkYYgCTdxIXtrP
	kmSZai2HWobM+lCnyaEK2wZObJPfmzdUEDno9ipQKyRxhYLC52zzRFQiPFhK3XUPWZZbEwF+iOQ
	/qZuK03U/zo+hDtKeg==
X-Google-Smtp-Source: AGHT+IFMlfRHsAR4DMeaSo5FVlFF6m6I5phVCcm5VA1bPtlqEJheDm6cFYf0KfTy8jlSmnG/sEoU/sGLR5rlsl9ves0=
X-Received: by 2002:a05:6512:63d7:10b0:594:2f25:d491 with SMTP id
 2adb3069b0e04-5943cc407b6mr700023e87.16.1762332936582; Wed, 05 Nov 2025
 00:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104165209.309545-1-marco.crivellari@suse.com> <7808bc5fcac1236640f481733d1c8aaaf8accb02.camel@mailbox.org>
In-Reply-To: <7808bc5fcac1236640f481733d1c8aaaf8accb02.camel@mailbox.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 5 Nov 2025 09:55:25 +0100
X-Gm-Features: AWmQ_bmsSlL8L1MkdAbNYg0dra-VH-QzHmvod4fA1eM_prAILZHwQjVAE8_kjN8
Message-ID: <CAAofZF5=WZ_C7FP62mr+FzDJD4-XV8+JXMULpLB9HxYmjVPBPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sched: replace use of system_wq with system_percpu_wq
To: phasta@kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Konig <ckoenig.leichtzumerken@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:39=E2=80=AFAM Philipp Stanner <phasta@mailbox.org>=
 wrote:
>
> nit: s/replace/Replace
>
> On Tue, 2025-11-04 at 17:52 +0100, Marco Crivellari wrote:
> > Currently if a user enqueue a work item using schedule_delayed_work() t=
he
>
> s/enqueue/enqueues
>
> Also: maybe start the sentence with something like "In the general
> workqueue implementation, if a user [=E2=80=A6]". Otherwise it at first r=
eads
> as if we're talking about a drm/sched user here.
>
> In general, the commit message should focus more on drm/sched. See
> below, too.
>
> > used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> > WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies t=
o
> > schedule_work() that is using system_wq and queue_work(), that makes us=
e
> > again of WORK_CPU_UNBOUND.
> >
> > This lack of consistentcy cannot be addressed without refactoring the A=
PI.
> >
> > This patch continues the effort to refactor worqueue APIs, which has be=
gun
> > with the change introducing new workqueues and a new alloc_workqueue fl=
ag:
> >
> > commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq=
")
> > commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> From my POV it would be enough if you provide these commits in this
> commit message and maybe a Link: to the overall discussion in the
> workqueue subsystem / implementation.
>
> You can give the details above if you want, but I think drm/sched
> doesn't care too much about them. The drm/sched users who really care
> about the timeout_wq's exact behavior use one they allocate themselves
> anyways.
>
> >
> > system_wq should be the per-cpu workqueue, yet in this name nothing mak=
es
> > that clear, so replace system_wq with system_percpu_wq.
> >
> > The old wq (system_wq) will be kept for a few release cycles.
>
> Please state in your commit message what you're actually doing to
> drm/sched. Like:
>
> "Use the successor of system_wq, system_percpu_wq, for the scheduler's
> default timeout_wq. system_wq will be removed in a few release cycles."
>[...]
> Actual change looks fine by me.
>
>
> Thanks for your patch,
> P.

Many thanks for all your feedback Philipp.

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

