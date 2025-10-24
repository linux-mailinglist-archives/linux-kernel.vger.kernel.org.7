Return-Path: <linux-kernel+bounces-868198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0DC04A05
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F09B341E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EDA2BE632;
	Fri, 24 Oct 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgyihKLN"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E7245023
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289722; cv=none; b=L2IJr4kL9oDGLGG5ApEZf/EM3KdGhKsauSVvuZSrqa4nPNOXPht0gsAcHXIBI9SobmLmKYHiWEOuht7vdxMKRyHmtFi5eeGhGphCYshalx0n86aYwLHYBVMDdKq0FC7Fh2F4635fP9zu+B9ZCI/fM5XOx7EWqVyy8rp80Di+ueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289722; c=relaxed/simple;
	bh=DMYZNMyiP51qhvR163WPghAWwrfu3AH48qP2CF7lSBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nry1XEaTV6W9sFnJncuGlFATlIJcn+08NCTB+yBxOEJpUTvtBXnSc5jz/w6d19LYX4TcS9aVRbrNcL0hcraNI58V0ZBcxv2Dxl3Xfs4O2a8vdSAjj5xdgcl/ZzEdPXjwk13mNnhMXiJl6zvqS8M5YobiDO9efTstuQJ3PZIhd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TgyihKLN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so2994845a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761289719; x=1761894519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3j0863NMsH2TxDcTuhZnVL4n97Hbnm5ACId2JottOg=;
        b=TgyihKLNBy1y2Vpec/dfONbA9mJKq6bScZJuOKnKyl4kizbp2qPWxBOheSHr1M/fhm
         Lyjq46AHEcbh5xqbuPYXj258FLCZ1g3hU5xOUJhbYtV8JyGMntMEOQT4gIOhFbhL4Jzw
         BbgTuI1n6cteh2ByrWMqbY5oqcnfshxtYX8oi2b5zjYeLokLlavalWji1iDx0wOYMKxZ
         kTFUQ596WA8SLqb6r8iTcVA2MugXAn1SQpDCMv0/JPfN9aGG0aOB72gQSP/ivAHCj8Mv
         +gfNNvj7TNRZ9szYX1m1a45c9Pg6PmK5lxmvO+WGhVk9+4Jv9y3iehzZogg40xHEV+oA
         5YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761289719; x=1761894519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3j0863NMsH2TxDcTuhZnVL4n97Hbnm5ACId2JottOg=;
        b=FNCHuDZZTiFaItDspbw4dLE6uEaU/5PSy80GPG94Y2rrbYJrlThFWOt8aUeRyvKGEe
         yCwfSf3XZdh2BpG8Z2AAkevp7T/rHkqlwShL5uHjkxc5tAZBFEmd34tKbzrIGAeu60bN
         YMIM6DwJbreq5eF3GSnMN9C4bnEtRfG8m5DLmCtahfFKEoHQL08Jv4pH/Quqrj/ZCTno
         onr2Yh+lyv1nyAR1FfhiG/1u8gKNnpIVsGJ32Oe0/n/IgYVQ67NizfyESDQ5KTKboiKN
         jd2LEztTpaBYWsDUUIteTkEk7NAlW0+OKJ1lL1RAAx65w9Apz7Ug+1vishLcT4WcrYU3
         Zkxw==
X-Forwarded-Encrypted: i=1; AJvYcCVoxWz8d7cVkHG96w2U4e63rO8cXONmyXI3xe3lB/RyDew5bl/4eDd7e6SgNEcpW4aLoV+SF/sKPRP8FvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6fkfo6+yr73MNtlZAu4uhrKgs+6aNyr4TMKAa1Odja+WQe5v
	4sDIL1FDP68vPaNM8VEx/+pfbu0WDNr6ciaBxNt4l6SyuXqtcf91PrLrUL5cJaJ7E23gVigZVmn
	P40tM82/fZ2x13AMK3Send6/iblk+eKlhzbPfqMB6qg==
X-Gm-Gg: ASbGncv1PyxJvAOIC9uO3R8MpLhjrvYCC2hTLEPqQgwCYQnUpw3L2L46iVIR3b2QJ0k
	HwT4p36EFcT19Wbu2zSV35XYm93r9hiJ9jAJt6NT0joxuGJwL9M5CxNn59K+5qHTGwlRyakBtqa
	7tS96JiKYjzAEUBSO35V10dT1zhHhBPyUQLN9U0hSi+QksTZOxDCtvopuEywmuWrECMYlIZB/bK
	kVnh+ooi3G/e/JYuJ1dW7Vo134v6pAe+XVY0eQW/AfAcbFM4lw+AQ02GXRpwUTcPbuA/8YdpSfF
	BYquOt9DCp7HcQ==
X-Google-Smtp-Source: AGHT+IFLe3+jRoOLX67oMONNU8hUa4/ecYf2eWSv9JTCusb49DNV8U7PDzZtofnfsGkk5jm/DBvVd/x5ZvDf51+Y6dY=
X-Received: by 2002:a05:6402:26cd:b0:63b:f1aa:11d1 with SMTP id
 4fb4d7f45d1cf-63e60086099mr1273048a12.1.1761289718654; Fri, 24 Oct 2025
 00:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfTPtDJW4yU2=_4stdS1bggHwAA8K2On_ruV63=_H9=YEgdkw@mail.gmail.com>
 <f3d77b74d72da0c627ff4b4fe9d430969da6b900.1761200831.git.peng_wang@linux.alibaba.com>
In-Reply-To: <f3d77b74d72da0c627ff4b4fe9d430969da6b900.1761200831.git.peng_wang@linux.alibaba.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 24 Oct 2025 09:08:26 +0200
X-Gm-Features: AWmQ_bnoLl6ZwZowLqq0oAjbairDlXIzhwAx0wIrKHjZTCUL6ePTWqrJ0tk9n6U
Message-ID: <CAKfTPtC-L3R6iYA=boxQGKVafC_UhBihYq6n6qTJ6hk4Q76OZg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Clear ->h_load_next when unregistering cgroup
To: Peng Wang <peng_wang@linux.alibaba.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, vdavydov.dev@gmail.com, 
	vschneid@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Oct 2025 at 08:29, Peng Wang <peng_wang@linux.alibaba.com> wrote=
:
>
> An invalid pointer dereference bug was reported on arm64 cpu, and has
> not yet been seen on x86. A partial oops looks like:
>
>  Call trace:
>   update_cfs_rq_h_load+0x80/0xb0
>   wake_affine+0x158/0x168
>   select_task_rq_fair+0x364/0x3a8
>   try_to_wake_up+0x154/0x648
>   wake_up_q+0x68/0xd0
>   futex_wake_op+0x280/0x4c8
>   do_futex+0x198/0x1c0
>   __arm64_sys_futex+0x11c/0x198
>
> Link: https://lore.kernel.org/all/20251013071820.1531295-1-CruzZhao@linux=
.alibaba.com/
>
> We found that the task_group corresponding to the problematic se
> is not in the parent task_group=E2=80=99s children list, indicating that
> h_load_next points to an invalid address. Consider the following
> cgroup and task hierarchy:
>
>          A
>         / \
>        /   \
>       B     E
>      / \    |
>     /   \   t2
>    C     D
>    |     |
>    t0    t1
>
> Here follows a timing sequence that may be responsible for triggering
> the problem:
>
> CPU X                   CPU Y                   CPU Z
> wakeup t0
> set list A->B->C
> traverse A->B->C
> t0 exits
> destroy C
>                         wakeup t2
>                         set list A->E           wakeup t1
>                                                 set list A->B->D
>                         traverse A->B->C
>                         panic
>
> CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker memory
> ordering, Y may observe A->B before it sees B->D, then in this time windo=
w,
> it can traverse A->B->C and reach an invalid se.
>
> We can avoid stale pointer accesses by clearing ->h_load_next when
> unregistering cgroup.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Fixes: 685207963be9 ("sched: Move h_load calculation to task_h_load()")
> Cc: <stable@vger.kernel.org>
> Co-developed-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> Signed-off-by: Peng Wang <peng_wang@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cee1793e8277..a5fce15093d3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13427,6 +13427,14 @@ void unregister_fair_sched_group(struct task_gro=
up *tg)
>                                 list_del_leaf_cfs_rq(cfs_rq);
>                         }
>                         remove_entity_load_avg(se);
> +                       /*
> +                        * Clear parent's h_load_next if it points to the
> +                        * sched_entity being freed to avoid stale pointe=
r.
> +                        */
> +                       struct cfs_rq *parent_cfs_rq =3D cfs_rq_of(se);

Move the declaration at the beg of the if (se) {

> +
> +                       if (READ_ONCE(parent_cfs_rq->h_load_next) =3D=3D =
se)
> +                               WRITE_ONCE(parent_cfs_rq->h_load_next, NU=
LL);
>                 }
>
>                 /*
> --
> 2.27.0
>

