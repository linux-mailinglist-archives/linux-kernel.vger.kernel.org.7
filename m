Return-Path: <linux-kernel+bounces-779676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E39AB2F71B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5654F5E8279
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FAD2DE6E5;
	Thu, 21 Aug 2025 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlspyJgZ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A21A76BB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776889; cv=none; b=DogtL7ZGqnlqXKN9Opl0NIcwQFgz3jNowIYD3dsXg+LQqMOwzjWHdNEpatTR9euIJ/2gsNyQ20mrL36NV001HhNw5sGhGSfooYpPYQtYX2wDXCyGNqsYz79by7k80VZTab8hwZUGBJ0TunOFHbad6s9slktthqRZ1TyFkSX/7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776889; c=relaxed/simple;
	bh=xKbvWwKbcZWaJQHIgEza0/GnYU9xwg6q/b9NTBU8WVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfA79FZYVzzp8LqYfQcMm1VUT7yJxt6yhyqfJETmuTWxYcHPvW6xxQQ7/+bX+gnud0aptFCItEGicKqdnzGqAU5JyKk+dGlVkG39T1RkN5PhBbG1SplXe9pmVITlnFqg3F4iAAkk8z4jBqjA8ZNgGkKBY2KnluL83Sr53YcTTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlspyJgZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3354b208913so3779201fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755776886; x=1756381686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVn6yHViqofsnebAXzQeno5didziZHpYLqIREvbjhLA=;
        b=VlspyJgZX2evf7/xJ10JYrjsfcFIFSU9MIpkchGgVwFHPVsybQpTnflv+Pw8JZBlHz
         YL9KP7DPLhpf3ISOak8arYZR8ASJCMsfFJNEMgTnRnQN78ewWOHfZng9ZRh8pmR2OGUA
         CQ7sic30iU7LOpvBIAZ3PPD9h7EG+3rihrfNih3KsAPY9KnCOgN4J5Vg0+Penz88b2CS
         NrK3tyAmv3CBoqkE6ikmxgnUa/1K1gugwj6buPgeJbd0rSZWI83mRywzOclgMQcXtPKX
         5p9dLeiBEQGFqr02+QhMMdXc4wal8qrjrDjlfC1PFwUL2VjonOqcD8dn6j7NkHGX2zCQ
         0x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755776886; x=1756381686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVn6yHViqofsnebAXzQeno5didziZHpYLqIREvbjhLA=;
        b=tDZ3ve7LesGDcMIOiCQJpRHmuvHhPeyl38H7yDBATiZzsYAwh+x9GJA/UrPr5b6LD+
         Nz3PwdxxE97WcIiKQCl8q2OixIkDIqSyP3R7qBkIx5jxsqefLjRqIfzWT7uVsX2nYmvp
         rt2ZIuaKB+8jUq4wcVcVCnOF0BmFfsNPIsrVRcmN1sSdRTnmG4bUzkMyv70PWlQit+Y2
         EDyO/LOHSY3aPyiwgDW8WjbSPp7waC+nroEdUE2C1YvqmoRytaFJ1BJsjU00/CiuRJx+
         tX3NOhJFoUTmaPrBsdXBpamPVlWivhky3XO8Oxf3XlLpRbAhI0CucCVYYSqilVpO/jgI
         W9mA==
X-Forwarded-Encrypted: i=1; AJvYcCVhps7apR3YZUTifINKiwj6nPHB4WvGa2UOd6b9AIKwhGTYPr776LynfZK6tX7a6VWCG2LlXnT6eMt82TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIW5phfk2SDArOMuGvnKqk6AEGFjvUb/NKS3Sxh8iiPghkvVlK
	FAbB7MQdwzS83JxjQ//+YN21zcvjns0ZKLPEewnLhRJlFoJam6zgas+tTxHAp5m8EOJ3mAl05kl
	v3Q8jUFghHRqwmP2EVm7YmfT1i0ZIFFWmMA==
X-Gm-Gg: ASbGncv2mSdossuKx2MCgjxDFT+Z/eh5utYgKcIOkTLCN+5ujwKE6ENlNKSUvjJEtNY
	NW80NJs3G/Hn9jWkmeIAzc+RPWvu4pTNstZxhPm5v5QxNpNEo35rWeS8izeujz4qnhj43ZWS8sW
	uYkEMK8BOsFMeunBqfb3vyMsme8UN/WF3+u+BnHZkjOLAM/JeV5o+2uyz4Ta0Z5PEjfP51HhEfI
	F9GuHaLYzv/2mkpQWrR+aiAgd7/A5sTnsjFzE31ALrKbib1y4CZ
X-Google-Smtp-Source: AGHT+IF85vZ2002hxM55gh6BA+f5b4GlTLelhMuP8NmcH/nZOCmmKzZQce3hznqKYlk6R+jnyqhE6Dfj0hy84/C1NCA=
X-Received: by 2002:a2e:beaa:0:b0:32c:abf4:d486 with SMTP id
 38308e7fff4ca-33549e7d464mr6908951fa.14.1755776885248; Thu, 21 Aug 2025
 04:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813074201.6253-1-pranav.tyagi03@gmail.com>
In-Reply-To: <20250813074201.6253-1-pranav.tyagi03@gmail.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Thu, 21 Aug 2025 17:17:53 +0530
X-Gm-Features: Ac12FXxjbjvJOBMZ4ibG5yQxSfbMm5Bq3eDS1TXF9aRKeJ4RBZQemk4sO_lF5yk
Message-ID: <CAH4c4jLuhe-S+2BtKyn0+uQzzAwvVXoCSkQKZ-tqv5Ww9xU5sw@mail.gmail.com>
Subject: Re: [PATCH v4] futex: don't leak robust_list pointer on exec race
To: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, 
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com, 
	linux-kernel@vger.kernel.org
Cc: jann@thejh.net, keescook@chromium.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:12=E2=80=AFPM Pranav Tyagi <pranav.tyagi03@gmail.=
com> wrote:
>
> sys_get_robust_list() and compat_get_robust_list() use
> ptrace_may_access() to check if the calling task is allowed to access
> another task's robust_list pointer. This check is racy against a
> concurrent exec() in the target process.
>
> During exec(), a task may transition from a non-privileged binary to a
> privileged one (e.g., setuid binary) and its credentials/memory mappings
> may change. If get_robust_list() performs ptrace_may_access() before
> this transition, it may erroneously allow access to sensitive information
> after the target becomes privileged.
>
> A racy access allows an attacker to exploit a window
> during which ptrace_may_access() passes before a target process
> transitions to a privileged state via exec().
>
> For example, consider a non-privileged task T that is about to execute a
> setuid-root binary. An attacker task A calls get_robust_list(T) while T
> is still unprivileged. Since ptrace_may_access() checks permissions
> based on current credentials, it succeeds. However, if T begins exec
> immediately afterwards, it becomes privileged and may change its memory
> mappings. Because get_robust_list() proceeds to access T->robust_list
> without synchronizing with exec() it may read user-space pointers from a
> now-privileged process.
>
> This violates the intended post-exec access restrictions and could
> expose sensitive memory addresses or be used as a primitive in a larger
> exploit chain. Consequently, the race can lead to unauthorized
> disclosure of information across privilege boundaries and poses a
> potential security risk.
>
> Take a read lock on signal->exec_update_lock prior to invoking
> ptrace_may_access() and accessing the robust_list/compat_robust_list.
> This ensures that the target task's exec state remains stable during the
> check, allowing for consistent and synchronized validation of
> credentials.
>
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> Suggested-by: Jann Horn <jann@thejh.net>
> Link: https://lore.kernel.org/linux-fsdevel/1477863998-3298-5-git-send-em=
ail-jann@thejh.net/
> Link: https://github.com/KSPP/linux/issues/119
> ---
> changed in v4:
> - added task_robust_list() function
> changed in v3:
> - replaced RCU with scoped_guard(rcu)
> - corrected error return type cast
> - added IS_ENABLED(CONFIG_COMPAT) for ensuring compatability
> - removed stray newlines and unnecessary line breaks
> changed in v2:
> - improved changelog
> - helper function for common part of compat and native syscalls
>
>  kernel/futex/syscalls.c | 108 +++++++++++++++++++++-------------------
>  1 file changed, 58 insertions(+), 50 deletions(-)
>
> diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
> index 4b6da9116aa6..0da33abc2f17 100644
> --- a/kernel/futex/syscalls.c
> +++ b/kernel/futex/syscalls.c
> @@ -39,6 +39,58 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_he=
ad __user *, head,
>         return 0;
>  }
>
> +static inline void __user *task_robust_list(struct task_struct *p, bool =
compat)
> +{
> +#ifdef CONFIG_COMPAT
> +       if (compat)
> +               return p->compat_robust_list;
> +#endif
> +       return p->robust_list;
> +}
> +
> +static void __user *get_robust_list_common(int pid, bool compat)
> +{
> +       struct task_struct *p;
> +       void __user *head;
> +       unsigned long ret;
> +
> +       p =3D current;
> +
> +       scoped_guard(rcu) {
> +               if (pid) {
> +                       p =3D find_task_by_vpid(pid);
> +                       if (!p)
> +                               return (void __user *)ERR_PTR(-ESRCH);
> +               }
> +               get_task_struct(p);
> +       }
> +
> +       /*
> +        * Hold exec_update_lock to serialize with concurrent exec()
> +        * so ptrace_may_access() is checked against stable credentials
> +        */
> +       ret =3D down_read_killable(&p->signal->exec_update_lock);
> +       if (ret)
> +               goto err_put;
> +
> +       ret =3D -EPERM;
> +       if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> +               goto err_unlock;
> +
> +       head =3D task_robust_list(p, compat);
> +
> +       up_read(&p->signal->exec_update_lock);
> +       put_task_struct(p);
> +
> +       return head;
> +
> +err_unlock:
> +       up_read(&p->signal->exec_update_lock);
> +err_put:
> +       put_task_struct(p);
> +       return (void __user *)ERR_PTR(ret);
> +}
> +
>  /**
>   * sys_get_robust_list() - Get the robust-futex list head of a task
>   * @pid:       pid of the process [zero for current task]
> @@ -49,36 +101,14 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
>                 struct robust_list_head __user * __user *, head_ptr,
>                 size_t __user *, len_ptr)
>  {
> -       struct robust_list_head __user *head;
> -       unsigned long ret;
> -       struct task_struct *p;
> -
> -       rcu_read_lock();
> -
> -       ret =3D -ESRCH;
> -       if (!pid)
> -               p =3D current;
> -       else {
> -               p =3D find_task_by_vpid(pid);
> -               if (!p)
> -                       goto err_unlock;
> -       }
> +       struct robust_list_head __user *head =3D get_robust_list_common(p=
id, false);
>
> -       ret =3D -EPERM;
> -       if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> -               goto err_unlock;
> -
> -       head =3D p->robust_list;
> -       rcu_read_unlock();
> +       if (IS_ERR(head))
> +               return PTR_ERR(head);
>
>         if (put_user(sizeof(*head), len_ptr))
>                 return -EFAULT;
>         return put_user(head, head_ptr);
> -
> -err_unlock:
> -       rcu_read_unlock();
> -
> -       return ret;
>  }
>
>  long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
> @@ -455,36 +485,14 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
>                         compat_uptr_t __user *, head_ptr,
>                         compat_size_t __user *, len_ptr)
>  {
> -       struct compat_robust_list_head __user *head;
> -       unsigned long ret;
> -       struct task_struct *p;
> -
> -       rcu_read_lock();
> -
> -       ret =3D -ESRCH;
> -       if (!pid)
> -               p =3D current;
> -       else {
> -               p =3D find_task_by_vpid(pid);
> -               if (!p)
> -                       goto err_unlock;
> -       }
> -
> -       ret =3D -EPERM;
> -       if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> -               goto err_unlock;
> +       struct compat_robust_list_head __user *head =3D get_robust_list_c=
ommon(pid, true);
>
> -       head =3D p->compat_robust_list;
> -       rcu_read_unlock();
> +       if (IS_ERR(head))
> +               return PTR_ERR(head);
>
>         if (put_user(sizeof(*head), len_ptr))
>                 return -EFAULT;
>         return put_user(ptr_to_compat(head), head_ptr);
> -
> -err_unlock:
> -       rcu_read_unlock();
> -
> -       return ret;
>  }
>  #endif /* CONFIG_COMPAT */
>
> --
> 2.49.0
>

Hi,

This is a gentle follow-up on this patch. Please let me know if any further
changes are required.

Regards
Pranav Tyagi

