Return-Path: <linux-kernel+bounces-815766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CE2B56AF0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E8F3BB2F0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D034252912;
	Sun, 14 Sep 2025 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCAVzuIe"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1169CE571
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757872106; cv=none; b=SttP9VOd0LhVAZPVv8Tw+NBmUhYUZFMjDr6QKnyAG5lotYt4vGCn07wX+2MseP5pFAUCJR7jsdRfcA5c/9hu9FGpLooZZFGsd74LkZ8pHFCvAY0i4ffoteMNOP3Emr9CAv7Lonm7pk7QkqNiLj7sYa5HafyU56Oh1rezArHU+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757872106; c=relaxed/simple;
	bh=xj6iq7t+zsCPPMhegtmbuLTt84mIu4kDWkXMwMa6m+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tteJa4/8YZWhOpKRcYsYBo0nbIe6VZQw4boxUQ6uUVjkhkEaegrcSjIkqEfVJnYCTQZg5WtO/002sDOpavFGNDMPEh13+m5in+vThMcajk5dwFuDRw5A5gOvsz48+vUqyu/+WmyIA6P/nx/he2WeIIiWnH8e/z36jhgHuKWt68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCAVzuIe; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62f1987d44fso1367342a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757872103; x=1758476903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs8wtDeP7ECBADMn52gHRkwUNhHc9dpXCWHU4uspSYE=;
        b=MCAVzuIeUOuu4Ls6ujlEHnZVM2mbeJxPF/nQzjCopLRNSD0lQ4ILqo2ktpHAb7g3ZC
         6m3o0GhV+4R0lui0CJlXUvVy+OyviZwYWZvbp5zphbl5eKMHm3Go+qavk4F0hwXOpY0B
         J5wUe7QIHIQNbOLaTL9guVFcBd+coUVlDtDnSgIafNepx7Rc1ofQPyRttuWjGoLtrrb9
         0KhoRp9jAiCKHjt/8SrSdk5Ul9CPmWPBXt1se3BlnIFMFnk9DH6LO9dm35nro4ziXHG6
         2eBeq+3YUY9M8X2RWzwrze3FDwHQAafGsY63AGarQv4K4gq2OAQ1xx98gCPOHrW2W1/D
         INrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757872103; x=1758476903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hs8wtDeP7ECBADMn52gHRkwUNhHc9dpXCWHU4uspSYE=;
        b=hLwodKEjMnH0QtN/8SHJV5kWvvPhg3R8+8/thmx6ovjt66Wnyskp3FR34whXfLP0Db
         yhRuE+rb4DZRI/eU3/AMrByFJPPhOnZGunBatnu5oZIHt8NAeQTodSVJuL5C0VtlN/r5
         yUOpmvqW5m3xC/AIrYnV43MyJPjYMo+K3KyoqFEB9270FEIKgNbod+/ZPNqDL+MD/fom
         UeD3GKsrtnEog4AqXwAZ51FO7nMLv0VV2jZV/dh/l40UtD6u38OLuYL2gIYhgspU2Lq6
         J3+LdqpgvnTloHeMas4FLHQxuoV+8hwZwgCaYTLQ+oJfzp6zshxpQON3ldQKCFmhOvfQ
         8MIw==
X-Forwarded-Encrypted: i=1; AJvYcCW2eFAX6MPlGUgWuZLIYAUpPnbtvMsd3rb0Uq2B8xOEoB2Z8tQOUnD+26li9hekAtUrJt76hJ00AbkPjsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WOLpPbQ/sEnLGhiBLCOLjBrZvVfDaoj7olwFl3jd6Wl+lZIe
	8rA4r1S6TBGCRW9bYVh+cbN9QXwaFl6LWgIuZqAKRMlVApNVH1O77dgnxE33IDmh6urY9VT/g9s
	TNHbS8qBinwVtSQrBoK3fndhRU0sKpZY=
X-Gm-Gg: ASbGncv3MnuLl6ivJmZuT1dnxYfnz7p7rLM7wtT+dsT/tnyhf/ud8poG2aMiRhOmQor
	RApaQYrXarz6GGXbv0BLLo4BrfqN6ncZutvoCTRYO3i7sZChn7Dzjsm/I3uFjH27jfF+NbSkbFi
	L0euF4e9tI8hrhqUaSlLNTKozsEhK+SjGHGYQkkvfG1nsI847BKNGWXAZKYhvI6xwT3ssmt2man
	tWW4rVXyvw9V5uFb3soIxHZl1WWWE97YPPdw5ovCJAdSuUJYg==
X-Google-Smtp-Source: AGHT+IHyLT2Uplflz+aBk2pqMhG/q9qimkqhE6i5p3eZpkqJEXtAkL6BuUqLW6KeH026ypwkTZ7eX4ilQJiUTp2gnxU=
X-Received: by 2002:a05:6402:5201:b0:627:7d41:9f70 with SMTP id
 4fb4d7f45d1cf-62ed8669282mr9451171a12.36.1757872103203; Sun, 14 Sep 2025
 10:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914110908.GA18769@redhat.com> <20250914110937.GA18778@redhat.com>
In-Reply-To: <20250914110937.GA18778@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 14 Sep 2025 19:48:10 +0200
X-Gm-Features: AS18NWAZgUrhIUOymkm6CvNo9omgRNJrxhbd5q9T3mG2xlhDG6AAwo1rBrzSNCM
Message-ID: <CAGudoHGwEYg7mpkD+deUhNT4TmYUmSgKr_xEVoNVUaQXsUhzGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fix the racy usage of task_lock(tsk->group_leader) in
 sys_prlimit64() paths
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 1:11=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> The usage of task_lock(tsk->group_leader) in sys_prlimit64()->do_prlimit(=
)
> path is very broken.
>
> sys_prlimit64() does get_task_struct(tsk) but this only protects task_str=
uct
> itself. If tsk !=3D current and tsk is not a leader, this process can exi=
t/exec
> and task_lock(tsk->group_leader) may use the already freed task_struct.
>
> Another problem is that sys_prlimit64() can race with mt-exec which chang=
es
> ->group_leader. In this case do_prlimit() may take the wrong lock, or (wo=
rse)
> ->group_leader may change between task_lock() and task_unlock().
>
> Change sys_prlimit64() to take tasklist_lock when necessary. This is not
> nice, but I don't see a better fix for -stable.
>
> Cc: stable@vger.kernel.org
> Fixes: c022a0acad53 ("rlimits: implement prlimit64 syscall")

I think this is more accurate:
Fixes: 18c91bb2d872 ("prlimit: do not grab the tasklist_lock")

Unfortunately this syscall is used by glibc to get/set limits, the
good news is that almost all real-world calls (AFAICS) with the
calling task as the target. As in, performance-wise, this should not
be a regression and I agree it is more than adequate for stable.

As for something more longterm, what would you think about
synchronizing changes with a lock within ->signal? Preferably for
reading (the most common use case) this would use sequence counters.
Bonus points for avoiding any task ref/lock manipulation if task =3D=3D
current (again the most common case in real-world usage).

signal_struct already has holes, so things can be rearranged so that
the struct would not grow above what it is now.

I had a patch somewhere to that extent I could not be bothered to
finish, if this sounds like you a plan I may get around to it.


> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/sys.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 1e28b40053ce..36d66ff41611 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1734,6 +1734,7 @@ SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int=
, resource,
>         struct rlimit old, new;
>         struct task_struct *tsk;
>         unsigned int checkflags =3D 0;
> +       bool need_tasklist;
>         int ret;
>
>         if (old_rlim)
> @@ -1760,8 +1761,25 @@ SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned in=
t, resource,
>         get_task_struct(tsk);
>         rcu_read_unlock();
>
> -       ret =3D do_prlimit(tsk, resource, new_rlim ? &new : NULL,
> -                       old_rlim ? &old : NULL);
> +       need_tasklist =3D !same_thread_group(tsk, current);
> +       if (need_tasklist) {
> +               /*
> +                * Ensure we can't race with group exit or de_thread(),
> +                * so tsk->group_leader can't be freed or changed until
> +                * read_unlock(tasklist_lock) below.
> +                */
> +               read_lock(&tasklist_lock);
> +               if (!pid_alive(tsk))
> +                       ret =3D -ESRCH;
> +       }
> +
> +       if (!ret) {
> +               ret =3D do_prlimit(tsk, resource, new_rlim ? &new : NULL,
> +                               old_rlim ? &old : NULL);
> +       }
> +
> +       if (need_tasklist)
> +               read_unlock(&tasklist_lock);
>
>         if (!ret && old_rlim) {
>                 rlim_to_rlim64(&old, &old64);
> --
> 2.25.1.362.g51ebf55
>
>

