Return-Path: <linux-kernel+bounces-829013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BAB960B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD344845DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300DE327A0F;
	Tue, 23 Sep 2025 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myrFIAok"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07D245006
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634763; cv=none; b=UYEknUKqzD35scEl5G4g9PBbcQjhxQq0E9Mj6FgenlAtbau9Zb4BtWGQrD5TZz+myI4X9Dwc4M9PDb1XUH+UCoZn95e0yHImdL9NddV1DlWhf6EEvKWEHTfqCsJRazoULnvPhz+03iFVvdIcdrXIOQMqZ3K7dRcITOVDL0DRVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634763; c=relaxed/simple;
	bh=FPMhIVsi/VYdlMJ7XScrJtwozD+R8sHuMLTk51F0ODM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We2Jonc2qIxQ6s6htdOcwov0AxhIzvEo5QhtdPpwGpZgMFpEtubsvnJwIedOBCCeyd48BfhRlxe4c7f6uKQMD5x2nJ9XyTHy7j9QqZNY7XQDZUrCdyql+ewpfGJz6cb55DPfND+5OjdwqkuK6cXyNzgkWHGdVBdCUIVveThZ1y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myrFIAok; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso8916770a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758634760; x=1759239560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDKW9fdT+wuLAUWIM3nwlPjM3i0h4APj9/PZ9A+ST24=;
        b=myrFIAokSrcZB3Ds+nHLQ8JkkrOrw1sbbY6VMJ5sBjijHlEnZhe8ODzz304oIBoOzi
         2d8bXxgHdZdBu3elteKrwWe8IyK9+czEW+SNdDQaYuYW6NOMykaJn4ueg4lUTc2trmdZ
         tTxofVxu0BZPGjaEeXaZwy+Tw/kDCudKbdevYxoQuABjogN7AIMzSYonCdEORsQP7F7F
         4TFfYZWKO5CIb4Evc++puetVS/1rqOsg9gfF9wOXtVY5kGWOAxnoiU/m/UVhYyW4xtLC
         5RmU/A+kK8NdDysCqssTDMdw7w+hzgRfOuuyHu46USyLPTbQMmBQ7e59CqGl2icxdrQU
         MvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634760; x=1759239560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDKW9fdT+wuLAUWIM3nwlPjM3i0h4APj9/PZ9A+ST24=;
        b=iDNAAfd5ZYKD/Ff3dFxmakcRjYLc0ur2tKbU+OD64uZFqizoQmOGHMmDDNnOLlnziW
         WlxKnUrAwsQ2S2DnxrVEiAJB9FTage4zy4KLyh6Iowrcu4+pR44VumoFY2Kb00IkM47a
         FuUzyKPf+4x0bSjfjfJ/y7pMmlc3uZFfkUtp1hNfM4vWKCdW6MU5CePOpPbcfAylPSN3
         KG3uJ5f6naNKWScE9P+3ambaG7JhduLsfjp+KxIpEXrm40DEtc2qAbRzoRbyeqDL5w91
         6m503n6UFBrqIfWfful2cmOpXTQ1BUZlXRmo3dIJ2Aatc72qTJovuMHR3HxcTkRVWARI
         lk8w==
X-Forwarded-Encrypted: i=1; AJvYcCU7OwDeJf8nUZd2dcET2FSRuMfJtykFxfVqABb/1tDJGuG21WN9JSsxe0+yasl++DNqJm74t+sqefNbzTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+i1gp5JNa/TCxPVl2Fi81HYMPMrFDtEiY8dT8TptFOyPmfVS
	cd9Y62IDMK/KbOKXYsM8AFMZTFyI5XXLzhREOulMJMZFRrR5OS4nwr9XC7vm1S5eOtC9YO4NIW6
	OW/62RVYs/Ce6F91Q0j9SYwoXxIZHr3Q=
X-Gm-Gg: ASbGnculYMFUi2qhvb/ikMx+q2fUmDBNh88UGF3nw1qOb+gBIdgUs1HjpEkKgbn+TOy
	AxlmunBz9dfyTFDcv2+6MsduTrcd4j2OdAOQLPH7iQWX0/zj22mTa0OuCJsgf2TLzQ0TmCELcbs
	IlWvD7hViffP6ysAWOvETmvV+iRpN0Tcw2FVcYd13WeBTUhwllDJaF/G+OBiVMC95fMM1f5nqrj
	I1kWFSbDGd1sfcxkWNVxwBoPnY9iUMBybskZKqAnvAjQbGO
X-Google-Smtp-Source: AGHT+IEJ+fZiL81BB7TIRz1BZFKNqmPS47fKEvPAnswzUbvnAPBSvcoEmjOPyCPQcfv55vwAFRUptDm1JVIL3RTM9Io=
X-Received: by 2002:a05:6402:2695:b0:62f:6e4d:7add with SMTP id
 4fb4d7f45d1cf-634676787a9mr2242697a12.7.1758634759132; Tue, 23 Sep 2025
 06:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-fix-prctl-pdeathsig-race-v1-1-44e2eb426fe9@gmail.com>
 <ef4878fe-3edf-4bd0-bb33-116ced1a4eb8@gmail.com> <20250922154819.c3049158ca006e1561ff5dcb@linux-foundation.org>
 <20250923120344.GA12377@redhat.com>
In-Reply-To: <20250923120344.GA12377@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 23 Sep 2025 15:39:06 +0200
X-Gm-Features: AS18NWB4Lotlt-714q2sw09kryNlgWrhDLuXFwqxle8BmsKvN8RLNE6a3B0Jb4s
Message-ID: <CAGudoHED4nx8QT-yw-zdcUApUyvt2HCOR9c3SQ3tAm9J7Q1jEQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: Prevent prctl(PR_SET_PDEATHSIG) from racing with
 parent process exit
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Demi Marie Obenour <demiobenour@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 2:05=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
> As you correctly pointed out, forget_original_parent/prctl lack the neces=
sary
> barries. So lets add the barriers instead of abusing tasklist? As for sys=
_prctl(),
> I think that ret-to-user-mode + enter-the-kernel-mode should act as a ful=
l
> barrier, so it only needs WRITE_ONCE()...
>

So I looked over this and I think I see why you are not eager to fix
the problem to begin with. ;)

I agree with reluctance to take tasklist lock to handle
PR_SET_PDEATHSIG, but I wonder if in practice this is used rarely
enough that the lock trip would not be a problem? It avoids any
modifications to the exit codepath.

By barriers I presume you meant smp_mb() between
RCU_INIT_POINTER(t->real_parent, reaper) and
READ_ONCE(t->pdeath_signal) in forget_original_parent. That's very
nasty as the full fence is quite expensive. This could be done with
just one fence for the entire call by iterating the list twice, but
that's still preferably avoided.

> Or perhaps user-space can do something else to sync with the exiting pare=
nt
> instead of using getppid() ?
>

I never put any thought concerning this mechanism, I do think it
nicely showcases the prctl at hand is kind of crap. The non-crap
version would pass the PID you think your parent is, so that you do
this race-free. I don't know if makes any sense to add this.

I'm wondering if the fact that tasklist is write-locked in that code
path could be utilized to synchronize this in a matter other than
taking it.

pseudo-code wise, something like this:
WRITE_ONCE(me->pdeath_signal, arg2);
/* publish the above store and load the lock after */
smb_mb();
/* here spin waiting until tasklist_lock is not write-locked */
smb_rmb();

Unless I'm missing something this should provide the guarantee you see
the updated parent, if any.

I don't see a routine to do it though and knowing memory barriers
there might be some bullshit hiding there making this not work, so not
my first choice unless someone with more memory barrier clue can chime
in.


>
> On 09/22, Andrew Morton wrote:
> >
> > From: Demi Marie Obenour <demiobenour@gmail.com>
> > Subject: kernel: prevent prctl(PR_SET_PDEATHSIG) from racing with paren=
t process exit
> > Date: Sat, 13 Sep 2025 18:28:49 -0400
> >
> > If a process calls prctl(PR_SET_PDEATHSIG) at the same time that the
> > parent process exits, the child will write to me->pdeath_sig at the sam=
e
> > time the parent is reading it.  Since there is no synchronization, this=
 is
> > a data race.
> >
> > Worse, it is possible that a subsequent call to getppid() can continue =
to
> > return the previous parent process ID without the parent death signal
> > being delivered.  This happens in the following scenario:
> >
> > parent                                                 child
> >
> > forget_original_parent()                               prctl(PR_SET_PDE=
ATHSIG, SIGKILL)
> >                                                          sys_prctl()
> >                                                            me->pdeath_s=
ig =3D SIGKILL;
> >                                                        getppid();
> >   RCU_INIT_POINTER(t->real_parent, reaper);
> >   if (t->pdeath_signal) /* reads stale me->pdeath_sig */
> >            group_send_sig_info(t->pdeath_signal, ...);
> >
> > And in the following:
> >
> > parent                                                 child
> >
> > forget_original_parent()
> >     RCU_INIT_POINTER(t->real_parent, reaper);
> >     /* also no barrier */
> >      if (t->pdeath_signal) /* reads stale me->pdeath_sig */
> >              group_send_sig_info(t->pdeath_signal, ...);
> >
> >                                                        prctl(PR_SET_PDE=
ATHSIG, SIGKILL)
> >                                                          sys_prctl()
> >                                                            me->pdeath_s=
ig =3D SIGKILL;
> >                                                        getppid(); /* re=
ads old ppid() */
> >
> > As a result, the following pattern is racy:
> >
> >       pid_t parent_pid =3D getpid();
> >       pid_t child_pid =3D fork();
> >       if (child_pid =3D=3D -1) {
> >               /* handle error... */
> >               return;
> >       }
> >       if (child_pid =3D=3D 0) {
> >               if (prctl(PR_SET_PDEATHSIG, SIGKILL) !=3D 0) {
> >                       /* handle error */
> >                       _exit(126);
> >               }
> >               if (getppid() !=3D parent_pid) {
> >                       /* parent died already */
> >                       raise(SIGKILL);
> >               }
> >               /* keep going in child */
> >       }
> >       /* keep going in parent */
> >
> > If the parent is killed at exactly the wrong time, the child process ca=
n
> > (wrongly) stay running.
> >
> > I didn't manage to reproduce this in my testing, but I'm pretty sure th=
e
> > race is real.  KCSAN is probably the best way to spot the race.
> >
> > Fix the bug by holding tasklist_lock for reading whenever pdeath_signal=
 is
> > being written to.  This prevents races on me->pdeath_sig, and the locki=
ng
> > and unlocking of the rwlock provide the needed memory barriers.  If
> > prctl(PR_SET_PDEATHSIG) happens before the parent exits, the signal wil=
l
> > be sent.  If it happens afterwards, a subsequent getppid() will return =
the
> > new value.
> >
> > Link: https://lkml.kernel.org/r/20250913-fix-prctl-pdeathsig-race-v1-1-=
44e2eb426fe9@gmail.com
> > Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >
> >  kernel/sys.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > --- a/kernel/sys.c~kernel-prevent-prctlpr_set_pdeathsig-from-racing-wit=
h-parent-process-exit
> > +++ a/kernel/sys.c
> > @@ -2533,7 +2533,17 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
> >                       error =3D -EINVAL;
> >                       break;
> >               }
> > +             /*
> > +              * Ensure that either:
> > +              *
> > +              * 1. Subsequent getppid() calls reflect the parent proce=
ss having died.
> > +              * 2. forget_original_parent() will send the new me->pdea=
th_signal.
> > +              *
> > +              * Also prevent the read of me->pdeath_signal from being =
a data race.
> > +              */
> > +             read_lock(&tasklist_lock);
> >               me->pdeath_signal =3D arg2;
> > +             read_unlock(&tasklist_lock);
> >               break;
> >       case PR_GET_PDEATHSIG:
> >               error =3D put_user(me->pdeath_signal, (int __user *)arg2)=
;
> > _
> >
>

