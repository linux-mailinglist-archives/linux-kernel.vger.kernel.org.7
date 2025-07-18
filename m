Return-Path: <linux-kernel+bounces-737005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233EDB0A689
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DFB3B564D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F53E72613;
	Fri, 18 Jul 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKMjSLbE"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8B18E20
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849954; cv=none; b=Jod5YM9pOHQwJdGFqpgf/bDnSQW0BhMNAOsNVdpM/0WqLgrOQZ/RaZPqVX9ayXNftS4ZKek8wc0a5lU5Y/jz/nosYB7DUapEMvFEutCbC5gTwGHhtg/33IW6XgoxriVYssYWSzMkuMUCO+CtS6KpLtV0vRfcG2CBkWHqUT7c7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849954; c=relaxed/simple;
	bh=gL/ZhA+zA/j6VFnZvVtt1Wc8XeeJ8bkhGN+gzUbw6Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hlv0EhsD2QJGHPTaJYUYqtUOujXlGEeAiRsqzbB4xjXxVMnyQsC83qANd579Qf0LMmD2qOHjxrFWbUKI7MYKfQ3yXrX5qhpJlLWjRa/3/mlxEfkuw54Vpz2Bu39kcK8n0zidqXfMg2avLCa54xatyMHDYOSyruWKbCGUX92UDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKMjSLbE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso11708a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752849951; x=1753454751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3UMbMju8zZD73u4qu7SuSMkFqAn2KjStFisWvgN4BE=;
        b=UKMjSLbE/Vuy3SotVlfUrfekoNF+Qp5v9gR4jsz30UntcpsimfnseU55hlZcRuWEr7
         HjTKq4A0Urr6Rx0GOnDyIpwgqhsuc8T8LF+adGywmMaHlyPonAOX6DmV5VyuWLrb4ucm
         rfxCWwt+pqe32wyN22HSfBdt6K4eDhG1yglRBc1ohHvy5JqDQYvSfSSR4rweQL4CCuAR
         vwA8Fo79CLR996F5H02k6DkDtAju7Su8LmXxygOtXFr4YrqvYBd2xlU7PTPXK5PfHhCV
         VtVeP9/ESSuK5NNbu8tg5CvymRVUqHKsZD5L9DjlYPMIeIG6h5v+Y0DaeGquPh0LXo7z
         JUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752849951; x=1753454751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3UMbMju8zZD73u4qu7SuSMkFqAn2KjStFisWvgN4BE=;
        b=nURVn8+f29+YL/qg3D9X94hecdJbrrnVExIygb2q6b8v8kORhLwe8d+AxMizua7YIY
         8oS5cW7D7aseTYnewgkQ7fGQDVE5VBJoLL4o7MD4B/ai5DuN3aE7Grlh4bDmYa1QMcFu
         f5I4B8spZEJ0jG3ldzebeRFcEKuf9KD1sSFqSr+JbMzQYBtcPJ4I3h9qVnVKKlmSOjkA
         fJZ2uLbol4wX0Io/Hu4AYgOopXmJ6A4K9rZzS8BCe7dV+cjAShP90MqrKOsl+EYj4bW/
         aauQjJOK892AjZ9Gz3Eey1huaRhd9LyTnYY2utvKAawbiPFkaqg8+Ez3qstg7XefYJ3O
         q9sg==
X-Forwarded-Encrypted: i=1; AJvYcCWKgtozwtEyOJrTa5i8MQDTtxECGh7pPwkP8XMhi8uBq64g6iX2R5UI07Fy0m1pCS/2UAW2Ir2360sXCEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAvy7vLm1f326c/1f8p385OuyA/emk25r77O4yKu41QNOZTRn
	OK0tUtQ1AkDI773ZFLeo8vI73omXiQu3A/83AXhdeKCuXRmAlJR3qsy79UcF1rwuIjMjJfc0Ut0
	AXWUgZ05oziq/gepipRL8TR1Ul051201ST4D3Z/wk
X-Gm-Gg: ASbGncsim0hp0lpEYitB7UQMR3BVHjyXQwOu7Gttv5Fbfi9qoU/SMyk9d0ZVAh9Xkr2
	3iv34sTXgXYAfWDJEOx7MWbDk/a6kx9Ep2RKVbWbqXK8ITvazBJUMojjpgSlxiBeDG1JdmYCNam
	FdR+BQ/Y4wU+Z4ZFD9vo1YglaBtAG9UxX+PtAXero+TeDVUlIPElYqykRWBJlITYJ4/w1fmHS9i
	vj/INTmVzqgEqgzL2xHeXYdqDS3pi69L8U=
X-Google-Smtp-Source: AGHT+IH4mSG0Xi5KZMr26cG1IZhS0kuxNsph/aAXrNG8WSF1/aadNwe3L4lgzIRZV7ld1j5qOsRJa4TLDWKBLTUx0o0=
X-Received: by 2002:a05:6402:268a:b0:611:e30b:5707 with SMTP id
 4fb4d7f45d1cf-612c2344a1amr135093a12.7.1752849951093; Fri, 18 Jul 2025
 07:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr>
In-Reply-To: <20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Jul 2025 16:45:15 +0200
X-Gm-Features: Ac12FXxT5-ysxqmkOwQ3sIp5r2yObHb_RDQcSoDNC41SgQONdfTMwamc6FQ8XPE
Message-ID: <CAG48ez3u09TK=Ju3xdEKzKuM_-sO_y9150NBx3Drs8T1G-V9AQ@mail.gmail.com>
Subject: Re: [PATCH] fs: hidepid: Fixes hidepid non dumpable behavior
To: nicolas.bouchinet@oss.cyber.gouv.fr
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:47=E2=80=AFAM <nicolas.bouchinet@oss.cyber.gouv.=
fr> wrote:
> The hidepid mount option documentation defines the following modes:
>
> - "noaccess": user may not access any `/proc/<pid>/ directories but
>   their own.
> - "invisible": all `/proc/<pid>/` will be fully invisible to other users.
> - "ptraceable": means that procfs should only contain `/proc/<pid>/`
>   directories that the caller can ptrace.
>
> We thus expect that with "noaccess" and "invisible" users would be able t=
o
> see their own processes in `/proc/<pid>/`.

"their own" is very fuzzy and could be interpreted many ways.

> The implementation of hidepid however control accesses using the
> `ptrace_may_access()` function in any cases. Thus, if a process set
> itself as non-dumpable using the `prctl(PR_SET_DUMPABLE,
> SUID_DUMP_DISABLE)` it becomes invisible to the user.

As Aleksa said, a non-dumpable processes is essentially like a setuid
process (even if its UIDs match yours, it may have some remaining
special privileges you don't have), so it's not really "your own".

> This patch fixes the `has_pid_permissions()` function in order to make
> its behavior to match the documentation.

I don't think "it doesn't match the documentation" is good enough
reason to change how the kernel works.

> Note that since `ptrace_may_access()` is not called anymore with
> "noaccess" and "invisible", the `security_ptrace_access_check()` will no
> longer be called either.
>
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  fs/proc/base.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c667702dc69b8ca2531e88e12ed7a18533f294dd..fb128cb5f95fe65016fce96c7=
5aee18c762a30f2 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -746,9 +746,12 @@ static bool has_pid_permissions(struct proc_fs_info =
*fs_info,
>                                  struct task_struct *task,
>                                  enum proc_hidepid hide_pid_min)
>  {
> +       const struct cred *cred =3D current_cred(), *tcred;
> +       kuid_t caller_uid;
> +       kgid_t caller_gid;
>         /*
> -        * If 'hidpid' mount option is set force a ptrace check,
> -        * we indicate that we are using a filesystem syscall
> +        * If 'hidepid=3Dptraceable' mount option is set, force a ptrace =
check.
> +        * We indicate that we are using a filesystem syscall
>          * by passing PTRACE_MODE_READ_FSCREDS
>          */
>         if (fs_info->hide_pid =3D=3D HIDEPID_NOT_PTRACEABLE)
> @@ -758,7 +761,25 @@ static bool has_pid_permissions(struct proc_fs_info =
*fs_info,
>                 return true;
>         if (in_group_p(fs_info->pid_gid))
>                 return true;
> -       return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> +
> +       task_lock(task);
> +       rcu_read_lock();
> +       caller_uid =3D cred->fsuid;
> +       caller_gid =3D cred->fsgid;
> +       tcred =3D __task_cred(task);
> +       if (uid_eq(caller_uid, tcred->euid) &&
> +           uid_eq(caller_uid, tcred->suid) &&
> +           uid_eq(caller_uid, tcred->uid)  &&
> +           gid_eq(caller_gid, tcred->egid) &&
> +           gid_eq(caller_gid, tcred->sgid) &&
> +           gid_eq(caller_gid, tcred->gid)) {
> +               rcu_read_unlock();
> +               task_unlock(task);
> +               return true;
> +       }
> +       rcu_read_unlock();
> +       task_unlock(task);
> +       return false;
>  }

I think this is a bad idea for several reasons:

1. It duplicates existing logic.
2. I think it prevents a process with euid!=3Druid from introspecting
itself through procfs.
3. I think it prevents root from viewing all processes through procfs.
4. It allows processes to view metadata about each other when that was
previously blocked by the combination of hidepid and an LSM such as
Landlock or SELinux.
5. It ignores capabilities held by the introspected process but not
the process doing the introspection (which is currently checked by
cap_ptrace_access_check()).

What's the background here - do you have a specific usecase that
motivated this patch?

