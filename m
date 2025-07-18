Return-Path: <linux-kernel+bounces-737191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55279B0A8E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC652A877D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261962E716F;
	Fri, 18 Jul 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+W/nr57"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C732E5B1A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857377; cv=none; b=CxeL/2qwa3I/pNDsU6MxMcG5awL60Ow7vGQcjNussQjMqpYOMBsIfZ6diILXhmP8DDtmZGsAsaNfE9BoAA6jJ49sWM0hGSpa+37l3Hy39/n0hpLjdb56H1Z5feiRCORF/PJ9mPgiadK3LdxN7wzJuBWOiLDkICQhLw++kXGaipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857377; c=relaxed/simple;
	bh=YYkFrLXQNcF/LRzXFAq83sA1w2G3tvd/U+OLCef/WXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWU8Ooh2Rn1SuLsvH/0ulBXxM3VBglOtkyqf5eUgXLQDsxV8lWFamJj24kqVN0/iYQEA99nq75OOlJ/qTVQ64yn/ni+93+JSXxQeyHhj6qKQqXbLTMeD2filxGapbF6YCWhDYk/yS113Qqv8dqlXIefB9ymaEm0eUr2I+ITO+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+W/nr57; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso334a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752857373; x=1753462173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdFQmiTCtyQu/zHhNrg0B+XyPur8yXji78Rwk2BnkTc=;
        b=u+W/nr57xhl4EAMpI6TI3EPf3o5EmZ8fgwdYJE04bYn5u+AzZp461xOy0L6yjK5Gce
         qLULE633lfJ6+hvmykx8450F2seG/XokGLBaqG/k3OpvLzLXA1dHbE011rKTwTqmChQm
         k/RPcUd85W2HOAn47qokuXm+YP/Iv6kkWBIDBkXo8yT9ebeKnU3essR1cNOThMLAOKbp
         7JgSQGLhERjQfjE9kFoBlSNbsMrdI1kCxeWtt/m167xZrO4RN/XALFyDfwPgr9liRQJo
         boDU6avQ5GtuEXLNQ0KpZUi54fup4QZq7SgZPM8Hmwrr9pY3BMdhW9Ssi1LXp1kXMoof
         WydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857373; x=1753462173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdFQmiTCtyQu/zHhNrg0B+XyPur8yXji78Rwk2BnkTc=;
        b=fv5fGCGb2iGxrWpTloCtisaeSe6pzrjLLHzD3AppruP0zHjdjTnQULxnUoVM0VOfcb
         WEPdKZfEMSuAu2uPGujytZ4gQEFgVLkkMvYN40Kd/0vWXqIVwtSYI/abhgcOQumci6Zf
         tOUkLfcMHZz5Wd27cDR/w/KdulJb3JqiIjAw4mn0ZRQukn6ZdacnJZOuBsC6LY/8FAP3
         1aFwQyB4a0geIltFMdciJ9Agba7yLN9vNomSXfZR7eQ04StWYDEmkCKMHPufBSiqVTfL
         pdRsc/+m3X6IAckPadFLyo1XlJrYa+wbt6Z1GBO3t7lGNel+6x0W5QSa1UVROulGepO1
         NCxg==
X-Forwarded-Encrypted: i=1; AJvYcCWCPXrxJTTC/UUPQfPg9SR0SFLfpx7MNstTGhIZWlV/ALNrZgJjP2toKKwp6BMVvlrFfT5MW+zFCbPQ/vE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2sEO/oOcROGzFV3hMl9yoxwgJLz9omtZ2jjnkV7QbbeUbTcp4
	b5LB/k5W2vnLXja0dMgDnpvrnWrOihO3J8Dz0q/ERxQKRlZ9smFcqf54dBzSgBGVREHUP65FAaf
	TuJq++Km0oPjO/gjlJXTly4uTRHYqQqF/tobKELJ/
X-Gm-Gg: ASbGncsKxwz7+FrWfo1L6LMOCRLQ6AAbfjbSgAfGrZONDgkcJTnTVEi74zOnvcPyjC+
	Nx+v+nFfyrezIkn+jXnwf/2Mh3Pd6zs9E9ywjtHMK7OpGoyj0d0BTrAOJYN4K1KWJJ3pm9OcuQ6
	jwU0AlKwtHdjRnphbz7jNaEhf8sshpXblxo8PbXtkuu+kFJPAO4sGMHUWZNK/h1Ex8kO7pbmugS
	PazcTGB19L1IOSC8OHAmDN/5pfk4dWh/Rg=
X-Google-Smtp-Source: AGHT+IEKipZ75dFcHQSQPERCSjZrzcx9z2eXpEQd6YxCy6qM2F3cG0oanco6kN4MAL7MZ/V/SEtL/XNR5ChXhILWj8A=
X-Received: by 2002:a50:d6c6:0:b0:612:bec2:cf22 with SMTP id
 4fb4d7f45d1cf-612c2317b32mr104875a12.4.1752857372727; Fri, 18 Jul 2025
 09:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr>
 <CAG48ez3u09TK=Ju3xdEKzKuM_-sO_y9150NBx3Drs8T1G-V9AQ@mail.gmail.com> <s7no7daeq6nmkwrf5w63srpmxzzqk5uor2kxdvrvrskoahh7un@h6kubn7qxli2>
In-Reply-To: <s7no7daeq6nmkwrf5w63srpmxzzqk5uor2kxdvrvrskoahh7un@h6kubn7qxli2>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Jul 2025 18:48:54 +0200
X-Gm-Features: Ac12FXwHhnJM27H3F2j0R9jH8PM46wRLA_SIP9MxHGaFT7dpoUWY-oXaYWfBUR4
Message-ID: <CAG48ez1ERkkwd+cJPmLmVj4JKpj5Uq=LaUEpb6_TgC4PRXosUw@mail.gmail.com>
Subject: Re: [PATCH] fs: hidepid: Fixes hidepid non dumpable behavior
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:47=E2=80=AFPM Nicolas Bouchinet
<nicolas.bouchinet@oss.cyber.gouv.fr> wrote:
> Hi Jann, thanks for your review !
>
> On Fri, Jul 18, 2025 at 04:45:15PM +0200, Jann Horn wrote:
> > On Fri, Jul 18, 2025 at 10:47=E2=80=AFAM <nicolas.bouchinet@oss.cyber.g=
ouv.fr> wrote:
> > > The hidepid mount option documentation defines the following modes:
> > >
> > > - "noaccess": user may not access any `/proc/<pid>/ directories but
> > >   their own.
> > > - "invisible": all `/proc/<pid>/` will be fully invisible to other us=
ers.
> > > - "ptraceable": means that procfs should only contain `/proc/<pid>/`
> > >   directories that the caller can ptrace.
> > >
> > > We thus expect that with "noaccess" and "invisible" users would be ab=
le to
> > > see their own processes in `/proc/<pid>/`.
> >
> > "their own" is very fuzzy and could be interpreted many ways.
> >
> > > The implementation of hidepid however control accesses using the
> > > `ptrace_may_access()` function in any cases. Thus, if a process set
> > > itself as non-dumpable using the `prctl(PR_SET_DUMPABLE,
> > > SUID_DUMP_DISABLE)` it becomes invisible to the user.
> >
> > As Aleksa said, a non-dumpable processes is essentially like a setuid
> > process (even if its UIDs match yours, it may have some remaining
> > special privileges you don't have), so it's not really "your own".
> >
>
> Also replying to  :
>
> > What's the background here - do you have a specific usecase that
> > motivated this patch?
>
> The case I encountered is using the zathura-sandbox pdf viewer which
> sandboxes itself with Landlock and set itself as non-dumpable.

It kind of sounds like an issue with your PDF viewer if that just sets
the non-dumpable flag for no reason...

> If my PDF viewer freezes and I want to kill it as an unprivileged user,
> I'm not able to get its PID from `/proc` since its fully invisible to my
> user.
>
> > > This patch fixes the `has_pid_permissions()` function in order to mak=
e
> > > its behavior to match the documentation.
> >
> > I don't think "it doesn't match the documentation" is good enough
> > reason to change how the kernel works.
> >
> > > Note that since `ptrace_may_access()` is not called anymore with
> > > "noaccess" and "invisible", the `security_ptrace_access_check()` will=
 no
> > > longer be called either.
> > >
> > > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > ---
> > >  fs/proc/base.c | 27 ++++++++++++++++++++++++---
> > >  1 file changed, 24 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index c667702dc69b8ca2531e88e12ed7a18533f294dd..fb128cb5f95fe65016fce=
96c75aee18c762a30f2 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -746,9 +746,12 @@ static bool has_pid_permissions(struct proc_fs_i=
nfo *fs_info,
> > >                                  struct task_struct *task,
> > >                                  enum proc_hidepid hide_pid_min)
> > >  {
> > > +       const struct cred *cred =3D current_cred(), *tcred;
> > > +       kuid_t caller_uid;
> > > +       kgid_t caller_gid;
> > >         /*
> > > -        * If 'hidpid' mount option is set force a ptrace check,
> > > -        * we indicate that we are using a filesystem syscall
> > > +        * If 'hidepid=3Dptraceable' mount option is set, force a ptr=
ace check.
> > > +        * We indicate that we are using a filesystem syscall
> > >          * by passing PTRACE_MODE_READ_FSCREDS
> > >          */
> > >         if (fs_info->hide_pid =3D=3D HIDEPID_NOT_PTRACEABLE)
> > > @@ -758,7 +761,25 @@ static bool has_pid_permissions(struct proc_fs_i=
nfo *fs_info,
> > >                 return true;
> > >         if (in_group_p(fs_info->pid_gid))
> > >                 return true;
> > > -       return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> > > +
> > > +       task_lock(task);
> > > +       rcu_read_lock();
> > > +       caller_uid =3D cred->fsuid;
> > > +       caller_gid =3D cred->fsgid;
> > > +       tcred =3D __task_cred(task);
> > > +       if (uid_eq(caller_uid, tcred->euid) &&
> > > +           uid_eq(caller_uid, tcred->suid) &&
> > > +           uid_eq(caller_uid, tcred->uid)  &&
> > > +           gid_eq(caller_gid, tcred->egid) &&
> > > +           gid_eq(caller_gid, tcred->sgid) &&
> > > +           gid_eq(caller_gid, tcred->gid)) {
> > > +               rcu_read_unlock();
> > > +               task_unlock(task);
> > > +               return true;
> > > +       }
> > > +       rcu_read_unlock();
> > > +       task_unlock(task);
> > > +       return false;
> > >  }
> >
> > I think this is a bad idea for several reasons:
> >
> > 1. It duplicates existing logic.
> I open to work on that.
>
> > 2. I think it prevents a process with euid!=3Druid from introspecting
> > itself through procfs.
> Great question, I'll test that and write some hidepid tests to check that=
.
>
> > 3. I think it prevents root from viewing all processes through procfs.
> Yes only if combined with yama=3D"no attach", and IMHO, that would make s=
ense.

Why only if combined with yama? Doesn't your code always "return
false" on a UID/GID mismatch?

> > 4. It allows processes to view metadata about each other when that was
> > previously blocked by the combination of hidepid and an LSM such as
> > Landlock or SELinux.
> Arf, you're absolutely right about this, my bad.
>
> > 5. It ignores capabilities held by the introspected process but not
> > the process doing the introspection (which is currently checked by
> > cap_ptrace_access_check()).
> As suggested by Aleksa, I can add some capabilities checks here.
>
> >
> > What's the background here - do you have a specific usecase that
> > motivated this patch?
>
> The second motivation is that the "ptraceable" mode didn't worked with
> the yama LSM, which doesn't care about `PTRACE_MODE_READ_FSCREDS` trace
> mode. Thus, using hidepid "ptraceable" mode with yama "restricted",
> "admin-only" or "no attach" modes doesn't do much.
>
> As you have seen, I also have submited a fix to yama in order to make it
> take into account `PTRACE_MODE_READ_FSCREDS` traces.

I don't think that's really a fix - that's more of a new feature
you're proposing. Yama currently explicitly only restricts ATTACH-mode
ptrace access (which can read all process memory or modify the state
of a process), and it doesn't restrict less invasive introspection
that uses READ-mode ptrace checks.

> I have to admit I'm not really found of the fact that those two patch
> are so tightly linked.
>
> Thanks again for your review,
>
> Nicolas

