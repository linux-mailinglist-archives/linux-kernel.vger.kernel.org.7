Return-Path: <linux-kernel+bounces-870414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4361C0AADF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465043B0CFE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD81527B4;
	Sun, 26 Oct 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRoZfofp"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205923EA89
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490191; cv=none; b=rJy/z3rXrFD8SegGFkvlo9L18h3H+L2dC8ceQ2U7DtEFTeBTtV2pEZDjA8YMKP9SwzKCOUmo216xUIjAAXyC1/LalTdEPZp3slgaqjpmD7+tzMk1hVv/Fxde+2FSjYf+GTwpQOQY7viZO9g8ydXWXH7Sww5vrHEorvnMNVFecYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490191; c=relaxed/simple;
	bh=c9DLuzYW3uFu/TN3tGOR1lW2HuktEMicGD4wu6XfhCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/sauJMP0cBg1duAxlQ/VH8/s+j/9s8ijXX8ZQgTAJfVvCS19n9tZXnQd/DE/xxuuOY+UIEf7CxeWNs06yqlUeT+0bYzDb2fTPnShdmGRs8bJp0bxpd1zZ/OesHJXZu5rVCMOfrQ4pjG6GrwBwR0U7mdSnXNIX+y6/ohzI+fsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRoZfofp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c0eb94ac3so6758646a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761490188; x=1762094988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKWIFjJYbNJGdbaAmi8HRMA8u6IUi9pVvv1xAjavbhU=;
        b=lRoZfofp7+scMf9OhTgZZ67svsUyrZIlGqwQc9FDuFSWfl5f+n+0L8tv4+Tqg+y1WS
         tze3z1durN2vJGwee7+bTNa3ZzI6bCaWo2s3YkJVZrP7AvXia50AiMRqemqyfPyyhf1x
         VhWChqDOxeCpymJVJdg52tmmPjIjxNcetOL/MD3WzYiItQYO9HrAXRIi6hPu4BJiCPTR
         /+h35CRX/R43/3s8/gKKUKDoPAfKJ+nYsGFJ0DtCvxGD7vuHCD6vBvtzZpN72MA4UecX
         mQup1BUBIxx8NtuDXlHbW6+LZoMO2L1e8yZTuHk/wI3GnY+D7szS58hM9L112IgtV2U5
         wM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761490188; x=1762094988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKWIFjJYbNJGdbaAmi8HRMA8u6IUi9pVvv1xAjavbhU=;
        b=EylXknsIvCCUDklVc67deQDqYNHvYaJppBGu8Xp0SXPJOgnNM2LKn+q8/W2kmRIxCn
         GM2icLHw2SBDUbBFRiWu6QN/EiMKFeMeQLksNbdB6gIAWFsBMaq/RUvNtmjrLxJc/Erj
         BHKZbi9xuSvTQyoo7oI1hOemUfu2BJEHwN4QcZF568ZrPvGUXoASwbYuL3sl/kITwekg
         Xk++yCgYxTozCSiU4+nmLbWxjBfbTtSuXNiVuuUKXkjC4erJrqPdd9un4auKpMtBG0Lf
         uyBmdH6Y+3NHzrB4RV63cGD7+RMRAxYstZ0l1knaLgGhYLoZbsmbll1bVS7XGy0jgKds
         rq/A==
X-Forwarded-Encrypted: i=1; AJvYcCW0MjvbQDrq0bRmYWaEDj4pehOGRwc2F8zupzMIAFpv6HHOhLXmLkCwNSZMI8YfTFlXQgkaNTDxkV0G4vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvfuFLTkAXlIRoFBNK3HbzF6L8yrR4zu1R272a0D1t638Y19Vu
	++DSmwDkxqke4kFhg0DkW6wwapMLq/EwfUXdQZBzpO2iD76mCgDVeKdng/XFu+I3TNK9XDBF476
	mlO7Mk49k6cF4rK1c/oSJjEYo81l2p48=
X-Gm-Gg: ASbGnctrZSd5wxYjtE9lMIF7HZXvPEmP/+03ZjPrKzbRWznt/oszzQt3dyLBA9+D1op
	k6cmhm6Cf72UmkxnZwfewdSyu6Ug3DLWcefndVeJ4wsymmMPW7nwfKXV7m9KO4j7e3uZv94uibz
	gSI+1sVcutEFu1oS/d2Y42P2I39STJl9VMc1wBiJmVp2NZtfT0sBhOuRYX7QazkHUrCm7nTVZ3p
	dFXFNczCX791NwOb/BCp+NX6tBUpTgLqLvz7lBH4tahvHVnGbDhYl6HHtz522+M8lidy2I+mDF5
	8vCSawM/qjJ9obl8e68Z1D9L5A==
X-Google-Smtp-Source: AGHT+IHUui5ZTwUoQp40qnajh4RRrcIT5Xxe1j8xunonkRhV/SWl801upFkr5Q6ywN3+5agWQZ5AQDSyHg6z4NZXmlM=
X-Received: by 2002:aa7:c396:0:b0:63c:1e24:d92f with SMTP id
 4fb4d7f45d1cf-63c1f6d4b46mr29223795a12.26.1761490188045; Sun, 26 Oct 2025
 07:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026143140.GA22463@redhat.com> <20251026143501.GA22472@redhat.com>
In-Reply-To: <20251026143501.GA22472@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 26 Oct 2025 15:49:34 +0100
X-Gm-Features: AWmQ_bnOnI2Z_8G4TUAcwA03racqUwx4HM-in_O0cn45b4HhhJYQgo9haaXWPAM
Message-ID: <CAGudoHGWrf5sD+6nKjhxZdFOwDP=pArH1cEjpveYbrZ_4WNXEQ@mail.gmail.com>
Subject: Re: [RFC 2/1] kill task_ucounts()->rcu_read_lock(), add __task_ucounts()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <legion@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Howells <dhowells@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 3:36=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 10/26, Oleg Nesterov wrote:
> >
> > NOTE: task_ucounts() returns the pointer to another rcu-protected data,
> > struct ucounts. So it should either be used when task->real_cred and th=
us
> > task->real_cred->ucounts is stable (release_task, copy_process, copy_cr=
eds),
> > or it should be called under rcu_read_lock(). In both cases it is point=
less
> > to take rcu_read_lock() to read the cred->ucounts pointer.
>
> So I think task_ucounts() can just do
>
>         /* The caller must ensure that ->real_cred is stable or take rcu_=
read_lock() */
>         #define task_ucounts(task)      \
>                 rcu_dereference_check((task)->real_cred, 1)->ucounts
>
> but this removes the lockdep checks altogether.
>
> But, otoh, task_cred_xxx(t, ucounts) (or, say, task_cred_xxx(task, user_n=
s)) can
> hide the problem. Lockdep won't complain if, for example, we remove rcu_r=
ead_lock()
> in task_sig() around get_rlimit_value(task_ucounts(p)). So perhaps someth=
ing like
> below makes any sense?
>
>
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 89ae50ad2ace..7078159486f0 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -347,7 +347,14 @@ DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_=
NULL(_T)) put_cred(_T))
>
>  #define task_uid(task)         (task_cred_xxx((task), uid))
>  #define task_euid(task)                (task_cred_xxx((task), euid))
> -#define task_ucounts(task)     (task_cred_xxx((task), ucounts))
> +
> +// ->real_cred must be stable
> +#define __task_ucounts(task)   \
> +       rcu_dereference_protected((task)->real_cred, 1)->ucounts
> +

While this indeed should be fine, this invites potential for misuse
which perhaps can be warned about. It's not a big deal and can be
ignored, but should you be willing to further massage this:

As is, this is legally callable for tasks which are still under
construction or are already dead. Maybe there is a WARN_ON to that
effect which can be trivially slapped in for the non-rcu case?

As a nit in a nit, lack of a debug-only general kernel WARN_ON/BUG_ON
variants is discouraging frequent use and perhaps this could be used
as an impetus to add something of the sort, or a justification for not
bothering to add the new check. ;) I'm definitely not going to try to
add something like that and I can't good conscience suggest anyone
tries that either.

tl;dr the patch LGTM, but consider the first nit. thanks. ;)

> +// needs rcu_read_lock()
> +#define task_ucounts(task)     \
> +       rcu_dereference((task)->real_cred)->ucounts
>
>  #define current_cred_xxx(xxx)                  \
>  ({                                             \
> diff --git a/kernel/cred.c b/kernel/cred.c
> index dbf6b687dc5c..edddecec82e5 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -305,7 +305,7 @@ int copy_creds(struct task_struct *p, u64 clone_flags=
)
>                 p->real_cred =3D get_cred_many(p->cred, 2);
>                 kdebug("share_creds(%p{%ld})",
>                        p->cred, atomic_long_read(&p->cred->usage));
> -               inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, =
1);
> +               inc_rlimit_ucounts(__task_ucounts(p), UCOUNT_RLIMIT_NPROC=
, 1);
>                 return 0;
>         }
>
> @@ -342,7 +342,7 @@ int copy_creds(struct task_struct *p, u64 clone_flags=
)
>  #endif
>
>         p->cred =3D p->real_cred =3D get_cred(new);
> -       inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
> +       inc_rlimit_ucounts(__task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>         return 0;
>
>  error_put:
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f041f0c05ebb..80b0f1114bd3 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -252,7 +252,7 @@ void release_task(struct task_struct *p)
>
>         /* don't need to get the RCU readlock here - the process is dead =
and
>          * can't be modifying its own credentials. */
> -       dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
> +       dec_rlimit_ucounts(__task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>
>         pidfs_exit(p);
>         cgroup_release(p);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3da0f08615a9..f2a6a3cd14ef 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2048,7 +2048,7 @@ __latent_entropy struct task_struct *copy_process(
>                 goto bad_fork_free;
>
>         retval =3D -EAGAIN;
> -       if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rli=
mit(RLIMIT_NPROC))) {
> +       if (is_rlimit_overlimit(__task_ucounts(p), UCOUNT_RLIMIT_NPROC, r=
limit(RLIMIT_NPROC))) {
>                 if (p->real_cred->user !=3D INIT_USER &&
>                     !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)=
)
>                         goto bad_fork_cleanup_count;
> @@ -2486,7 +2486,7 @@ __latent_entropy struct task_struct *copy_process(
>  bad_fork_cleanup_delayacct:
>         delayacct_tsk_free(p);
>  bad_fork_cleanup_count:
> -       dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
> +       dec_rlimit_ucounts(__task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>         exit_creds(p);
>  bad_fork_free:
>         WRITE_ONCE(p->__state, TASK_DEAD);
>

