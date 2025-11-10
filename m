Return-Path: <linux-kernel+bounces-894164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC6C49643
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74FA3A6322
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80C62FE59A;
	Mon, 10 Nov 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="tK2h2sDt"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C62FB963
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809714; cv=none; b=SlqBnudn8uYAIa6QEpYxeVY6Q3FHa8TgE+AfCbEpyFC3g8VHpmnpw1FJLb/lD/j0EdpwHwr41RM7mDElGInByK6BvhJKoezMwxtFT+dLY51BkrL3AAT3asPzgeMCLdRTYGEmKCnNLqlV8ewkvWS+2xE03DoUbIWdrSHTQp5lxIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809714; c=relaxed/simple;
	bh=lT0bETKBrtamVm1uBBj/h7Vn58enr7FjC9rwg4SQvGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmXbNM8ldbzjRmqY9P870hADvVvroCyxvaeli4HqQApQ1Qwz8B/b/kRAXdcaPSFhSKGanA4ZvS6miOkEYUyYdLgj7/8LvDrdJvqnwwmBlzAOXtXxB3E7ZtoO2BgOXAfPbyDVch2n3z++W95max89eUufaOihaV3xCfLX2Yr3TZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=tK2h2sDt; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640e065991dso2323653d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762809710; x=1763414510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sesGHprX+1WlbXXlnwmIK+NqQik2TI8q+6Ij8J/CIOg=;
        b=tK2h2sDtS9BmV5Fcm9upOhwLfaK3W1p2ZLXG8f2P3yvsFktxsYrdAwLk3hzCgbPD+o
         Ms9gT4AcXWDzzVkyxc5n9VskcMcTV/JKU9BkuwJHhRUGJMXhr22+slor1akF4f//ywqU
         OAZhTXnWyxZouWDFOyZRzByBH9AwOt/H1fTRlkcr2VPI3vUkI+syNoQ1nvziFvMzLMpd
         e0X+5TTbm/TMt3YSPVQXNxKFOAEM1RtFOt/23TLwvnsMCN4U8Pb4EfGMvmpzdpupiFMG
         BRzLRzdQvCUf0TGziJBNRTqF+Xx8THlMNAXNhgiDiQoKwEIwbblAyBbHPWzAMyUxl16W
         Ng/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762809710; x=1763414510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sesGHprX+1WlbXXlnwmIK+NqQik2TI8q+6Ij8J/CIOg=;
        b=EMihhFp+CYWzkYRBUTlu4bz+RglFh6yL5iYOhfXHiJVPuuW5G7Bh7lKYYFOIlsWZW6
         EM9i8gLoLx423ZfG47qt4EJAwG78HgAP4RodE+IMUeqPtdevYvYok6DHFOnuRjzKsXyg
         okdl+13pZJWk8s5+JjP6U5zXZ3fDGJprdmmG7MuGxuz+QpDdy97nHBV62PDkzEiL6BYa
         CVXvDj0M8HauHy1uOm2OKL/mEDeG3aH1Qbw54UVD0U/NP/3iclCnDp1tHbxFDoQrM/ZX
         QRZ8fMY4eP9qDh+9wO75pPv0HLdTyvEUVRwS9V++qlRkyljCIdLTIA66C7oWmtDomKcN
         5GRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8piCFYsHEbo57WXBVSara0FmOcmTccAuyZKF/ZaX9T1uyaJ4P95GRVCRGbzErox1ZbvT7C3pMu8Xv8Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7a0I5w8F4LGA8njl3BargsRCObLxoPRt8u3LrGt9tgFRyo5U
	iLM3QspWizFp3cjEL2EDbZDSOrvKzdOZWcx50hXXQEIfBuIA6yj0vzaCF0MLvgxWJJk6EkpL75k
	WW7nrqTuE1YBLE+aZarCWuAcA8MgPwhj3jNqnOHBe2w==
X-Gm-Gg: ASbGncsQFoyB9SDmag0p2bKSiEfS0hkfBz5AI+M7ZQg7j8D5DFapLAeq1Pa9VAdvYHx
	K11maZ9nAZT97Rrc1g7gXNIaPL/CFgxVnXs8WHftgbgwwlbL8YDSV+9F/QJcvdHh2KpWdVQTOUV
	gdyz2zriOhyrlzdsE8eTcdny8EGEFrCjSwn5Q+QdkLaW6Is62qxi8CS3rLi13P09e3Txt7DiR2R
	VndKR0flX0sI0V7WWF4kBNKwOBhnvdGlXxwLAU1Ndqj+Q1JYXs+j6tOgMUL+s0=
X-Google-Smtp-Source: AGHT+IFMWauJYg/+Hxf6FOiIbgd7lsrxFeiDNEwY8YbAc/vKRrFFeNS0GHTj94ZvI8kEc8OUG+156cOYC9eXjYym2+k=
X-Received: by 2002:a05:690c:4d09:b0:787:cad1:bdbd with SMTP id
 00721157ae682-787d5473907mr104028257b3.65.1762809710480; Mon, 10 Nov 2025
 13:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-2-tj@kernel.org>
In-Reply-To: <20251110205636.405592-2-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 16:21:38 -0500
X-Gm-Features: AWmQ_blAi8FOoVppDnM5enbLhfoiA5Nt_BRDMI3YlXMQjTOkmLWDkjIHUFecRoA
Message-ID: <CABFh=a5Y8b9Ke2e=Cjdirjzz95bNEJf1SjEOtT3OVG8ZPPBk3w@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] sched_ext: Don't set ddsp_dsq_id during
 select_cpu in bypass mode
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:56=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> In the default CPU selection path used during bypass mode, select_task_rq=
_scx()
> sets p->scx.ddsp_dsq_id to SCX_DSQ_LOCAL to emulate direct dispatch. Howe=
ver,
> do_enqueue_task() ignores ddsp_dsq_id in bypass mode and queues to the gl=
obal
> DSQ instead, rendering the setting unnecessary.
>
> Don't set ddsp_dsq_id from bypass. Just return the selected CPU, which ha=
s the
> effect of waking up the picked idle CPU. Later patches will implement per=
-CPU
> bypass DSQs to resolve this issue in a more proper way.
>
> v2: Removed incorrect bug fix claim about dangling ddsp_dsq_id triggering
>     WARN_ON_ONCE(). dispatch_enqueue() always clears ddsp_dsq_id even in =
bypass
>     mode (Andrea).
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Andrea Righi <andrea.righi@linux.dev>
> ---

Reviewed-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

>  kernel/sched/ext.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 652a364e9e4c..cf8d86a2585c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2521,12 +2521,8 @@ static int select_task_rq_scx(struct task_struct *=
p, int prev_cpu, int wake_flag
>                 s32 cpu;
>
>                 cpu =3D scx_select_cpu_dfl(p, prev_cpu, wake_flags, NULL,=
 0);
> -               if (cpu >=3D 0) {
> -                       refill_task_slice_dfl(sch, p);
> -                       p->scx.ddsp_dsq_id =3D SCX_DSQ_LOCAL;
> -               } else {
> +               if (cpu < 0)
>                         cpu =3D prev_cpu;
> -               }
>                 p->scx.selected_cpu =3D cpu;
>
>                 if (rq_bypass)
> --
> 2.51.2
>
>

