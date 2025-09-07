Return-Path: <linux-kernel+bounces-804615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12558B47A7C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D191B2307F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CF11EDA0F;
	Sun,  7 Sep 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1qFdRt1"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42A225A3D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757240814; cv=none; b=PSewjqIFvx3CJ8meU5FhHM2gAwl1XOGAmC1HdkR3pU/w1yjUX9twty3fUwqj7bEY5achIRvu2vCV5J96spVb+1j8o7q81cLBlKmPlHollfWt9iI9ck9cVPMGYnWovyUMKx6/mxNIMa1DNAFwqvYP67/+XH7+9PSbxTbbsll/awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757240814; c=relaxed/simple;
	bh=U4o+1kgm58FgueMgya/dzhJDiCXmmZt3TUbA69suYo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyV7kCJDPirXrH+9MLvsgtblG5x8He4VGBbcfF4kGCeb6b6cLPDflhFohjapc8N2t4Idgrmaz5Cq5/MRVlAdMktjQeeUpIwOdVAqkNjG25VLHVPBetMdXQSSD/DwBLhuWYDaX9PXVAEiUVH026zkDSy6LzEF/kp+t8meePDO8IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1qFdRt1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-337e5daf5f5so38821591fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757240809; x=1757845609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Djck81ZHPeC/TYbTh7nXfmIIlc9M+rZyku/8UYrEA8I=;
        b=L1qFdRt1LV/7z0Swq00sKqY+GJ4zZ4ZJAMnsZ8LrgeHaY5YLPDFQDkHJ+MUJRVUyMU
         PljbfiG2OT6TB6RxKIs7EnE4omvdJknrmBH5X2upor2pBblg/9Bneg4nFKh6fa3fSVSv
         hEpI90fYoT1Ier1LRwNSTgCPrAJcbB8P36zzgXgw/8SU9wWSAuRL7z3RXnC5souo28LB
         HlhBE/HvG6rLiDBfHEnmRSrciOXrDyLQ1fs/nShPVJA4YwqLNOeJkPkCa3W/0aThFuSM
         NdpUZoiDg4DPZGClR4UWYERP1snmAOv9I0rjB/0IzL1leiSST0OEUFHUEKPyXnSSAYo8
         MchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757240809; x=1757845609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djck81ZHPeC/TYbTh7nXfmIIlc9M+rZyku/8UYrEA8I=;
        b=SJS4L+voH2LsyJDBkdnnM5j6mnVZQcw7LDAudf3y4zbwySgq5PNxNOFvq+1zElM26R
         cZf7hdVkX0j12/PTZ07wqeQ/SWaUYjui/EoJEjzcDcCXqMfWL3gg/u1ZyowZIq0xcIVO
         CrwmuhrlCXqm4HPxWx8+aH5k8Z6jI6w4b8/FeJekUYGUwy8J7Td1CcAzOoMHfhqzA2vt
         RUZ5+bVoQtxHsZ1a916r2UX/019fEDa2LwrLUJyKvCKdytGmGcCo4TE9FM3Ibe21Vpzq
         a+PDMy5e04Z5jSRJYyf1Srz+muYsNSXgs+OqDMoJ6au2idDyGlu1M456N/wPy9FJSmDk
         zypA==
X-Forwarded-Encrypted: i=1; AJvYcCUif87zeFL9GF7MUpWU9TPU5Dc8XDk2HRQw+UIVNZyD4C/s3QOZJferq2iQLRtGAOM8rc5x+e7MSRvIs50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpjJeXS2Zl9FqJLjhuIoYIj70Uk60Os5CHOdDmNXyeZpn5zZ3
	swbWbV7JNFS0xCcsJZsSx6MsYOzHmG3LofIUA2edJPPaRW1pJ+SQvRLGAoAfdtzUmUu/tZD/32g
	cqmLAaPm73NgSZVePIhm4kLVmR+qVbTs=
X-Gm-Gg: ASbGncsB9yS1C3pbkVDLAgGH53o2lqVaMmGLjhlp675SOFml8eve6jvX5l9pPRl50vO
	1O4zTSL2LLMMsy41/ky8eJK5kQpe675xir+GLOo8lZq4wtjCR5gk9/XoVlEQEoNEbRQTYzKliUE
	8rG+zzDS/oqivCFo768T3XRFYdI0KSteIHyfvaW6M37ccnbhS7PI/KvNMcjCFbVx1kOQ1jkQEF1
	yszIO9ehRzE+otT0JsdLUzpBR1nuVpfTgOQjB8fW2lzK5P060XU
X-Google-Smtp-Source: AGHT+IH3QyH3JPirF7YY1Fxych8WDM1JG2MgxwmZHIV+4KErAgiezY+cwo0iGAM3UUR43pVZSDORyW3Mgj89pa8EykQ=
X-Received: by 2002:a05:6512:6d5:b0:55f:3ae4:fe57 with SMTP id
 2adb3069b0e04-562758dd55cmr1154512e87.20.1757240808574; Sun, 07 Sep 2025
 03:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813074201.6253-1-pranav.tyagi03@gmail.com> <e3e00ba8-1516-4632-b987-4c0d1bb303d5@igalia.com>
In-Reply-To: <e3e00ba8-1516-4632-b987-4c0d1bb303d5@igalia.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Sun, 7 Sep 2025 15:56:36 +0530
X-Gm-Features: AS18NWCEses5eql09XCpd3YvNS0TicXHLm0lxUZLKYpo8ifY23bSlvzcMwL3kG4
Message-ID: <CAH4c4jLGrThaZdhpu0jYFqj-Bp8Q39Oz0sWWJsVCHMjG4rg9qQ@mail.gmail.com>
Subject: Re: [PATCH v4] futex: don't leak robust_list pointer on exec race
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: jann@thejh.net, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com, 
	tglx@linutronix.de, skhan@linuxfoundation.org, dave@stgolabs.net, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:22=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> Hi Pranav,
>
> Thanks for your patch! Some feedback bellow.
>
> Em 13/08/2025 04:42, Pranav Tyagi escreveu:
> > sys_get_robust_list() and compat_get_robust_list() use
> > ptrace_may_access() to check if the calling task is allowed to access
> > another task's robust_list pointer. This check is racy against a
> > concurrent exec() in the target process.
> >
> > During exec(), a task may transition from a non-privileged binary to a
> > privileged one (e.g., setuid binary) and its credentials/memory mapping=
s
> > may change. If get_robust_list() performs ptrace_may_access() before
> > this transition, it may erroneously allow access to sensitive informati=
on
> > after the target becomes privileged.
> >
> > A racy access allows an attacker to exploit a window
> > during which ptrace_may_access() passes before a target process
> > transitions to a privileged state via exec().
> >
> > For example, consider a non-privileged task T that is about to execute =
a
> > setuid-root binary. An attacker task A calls get_robust_list(T) while T
> > is still unprivileged. Since ptrace_may_access() checks permissions
> > based on current credentials, it succeeds. However, if T begins exec
> > immediately afterwards, it becomes privileged and may change its memory
> > mappings. Because get_robust_list() proceeds to access T->robust_list
> > without synchronizing with exec() it may read user-space pointers from =
a
> > now-privileged process.
> >
> > This violates the intended post-exec access restrictions and could
> > expose sensitive memory addresses or be used as a primitive in a larger
> > exploit chain. Consequently, the race can lead to unauthorized
> > disclosure of information across privilege boundaries and poses a
> > potential security risk.
> >
> > Take a read lock on signal->exec_update_lock prior to invoking
> > ptrace_may_access() and accessing the robust_list/compat_robust_list.
> > This ensures that the target task's exec state remains stable during th=
e
> > check, allowing for consistent and synchronized validation of
> > credentials.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > Suggested-by: Jann Horn <jann@thejh.net>
> > Link: https://lore.kernel.org/linux-fsdevel/1477863998-3298-5-git-send-=
email-jann@thejh.net/
> > Link: https://github.com/KSPP/linux/issues/119
> > ---
> > changed in v4:
> > - added task_robust_list() function
> > changed in v3:
> > - replaced RCU with scoped_guard(rcu)
> > - corrected error return type cast
> > - added IS_ENABLED(CONFIG_COMPAT) for ensuring compatability
> > - removed stray newlines and unnecessary line breaks
> > changed in v2:
> > - improved changelog
> > - helper function for common part of compat and native syscalls
> >
> >   kernel/futex/syscalls.c | 108 +++++++++++++++++++++------------------=
-
> >   1 file changed, 58 insertions(+), 50 deletions(-)
> >
> > diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
> > index 4b6da9116aa6..0da33abc2f17 100644
> > --- a/kernel/futex/syscalls.c
> > +++ b/kernel/futex/syscalls.c
> > @@ -39,6 +39,58 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_=
head __user *, head,
> >       return 0;
> >   }
> >
> > +static inline void __user *task_robust_list(struct task_struct *p, boo=
l compat)
>
> Function names inside of kernel/futex/ have the futex_ prefix
>
> > +{
> > +#ifdef CONFIG_COMPAT
> > +     if (compat)
> > +             return p->compat_robust_list;
> > +#endif
> > +     return p->robust_list;
> > +}
> > +
> > +static void __user *get_robust_list_common(int pid, bool compat)
>
> Same here
>
> > +{
> > +     struct task_struct *p;
> > +     void __user *head;
> > +     unsigned long ret;
>
> down_read_killable() returns a int, but you are storing the return value
> in an unsigned long.
>
> > +
> > +     p =3D current;
>
> Could this be initialized in the declaration?
>
> > +
> > +     scoped_guard(rcu) {
> > +             if (pid) {
> > +                     p =3D find_task_by_vpid(pid);
> > +                     if (!p)
> > +                             return (void __user *)ERR_PTR(-ESRCH);
> > +             }
> > +             get_task_struct(p);
> > +     }
> > +
> > +     /*
> > +      * Hold exec_update_lock to serialize with concurrent exec()
> > +      * so ptrace_may_access() is checked against stable credentials
> > +      */
> > +     ret =3D down_read_killable(&p->signal->exec_update_lock);
> > +     if (ret)
> > +             goto err_put;
> > +
> > +     ret =3D -EPERM;
> > +     if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> > +             goto err_unlock;
> > +
> > +     head =3D task_robust_list(p, compat);
> > +
> > +     up_read(&p->signal->exec_update_lock);
> > +     put_task_struct(p);
> > +
> > +     return head;
> > +
> > +err_unlock:
> > +     up_read(&p->signal->exec_update_lock);
> > +err_put:
> > +     put_task_struct(p);
> > +     return (void __user *)ERR_PTR(ret);
> > +}
> > +
> >   /**
> >    * sys_get_robust_list() - Get the robust-futex list head of a task
> >    * @pid:    pid of the process [zero for current task]
> > @@ -49,36 +101,14 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
> >               struct robust_list_head __user * __user *, head_ptr,
> >               size_t __user *, len_ptr)
> >   {
> > -     struct robust_list_head __user *head;
> > -     unsigned long ret;
> > -     struct task_struct *p;
> > -
> > -     rcu_read_lock();
> > -
> > -     ret =3D -ESRCH;
> > -     if (!pid)
> > -             p =3D current;
> > -     else {
> > -             p =3D find_task_by_vpid(pid);
> > -             if (!p)
> > -                     goto err_unlock;
> > -     }
> > +     struct robust_list_head __user *head =3D get_robust_list_common(p=
id, false);
> >
> > -     ret =3D -EPERM;
> > -     if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> > -             goto err_unlock;
> > -
> > -     head =3D p->robust_list;
> > -     rcu_read_unlock();
> > +     if (IS_ERR(head))
> > +             return PTR_ERR(head);
> >
> >       if (put_user(sizeof(*head), len_ptr))
> >               return -EFAULT;
> >       return put_user(head, head_ptr);
> > -
> > -err_unlock:
> > -     rcu_read_unlock();
> > -
> > -     return ret;
> >   }
> >
> >   long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
> > @@ -455,36 +485,14 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
> >                       compat_uptr_t __user *, head_ptr,
> >                       compat_size_t __user *, len_ptr)
> >   {
> > -     struct compat_robust_list_head __user *head;
> > -     unsigned long ret;
> > -     struct task_struct *p;
> > -
> > -     rcu_read_lock();
> > -
> > -     ret =3D -ESRCH;
> > -     if (!pid)
> > -             p =3D current;
> > -     else {
> > -             p =3D find_task_by_vpid(pid);
> > -             if (!p)
> > -                     goto err_unlock;
> > -     }
> > -
> > -     ret =3D -EPERM;
> > -     if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> > -             goto err_unlock;
> > +     struct compat_robust_list_head __user *head =3D get_robust_list_c=
ommon(pid, true);
> >
> > -     head =3D p->compat_robust_list;
> > -     rcu_read_unlock();
> > +     if (IS_ERR(head))
> > +             return PTR_ERR(head);
> >
> >       if (put_user(sizeof(*head), len_ptr))
> >               return -EFAULT;
> >       return put_user(ptr_to_compat(head), head_ptr);
> > -
> > -err_unlock:
> > -     rcu_read_unlock();
> > -
> > -     return ret;
> >   }
> >   #endif /* CONFIG_COMPAT */
> >
>

Hi Andr=C3=A9,

Thanks for the feedback. I will make all the changes as per your observatio=
ns
and send a v5.

Regards
Pranav Tyagi

