Return-Path: <linux-kernel+bounces-785704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3121FB34FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA52B486C31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A87629E116;
	Mon, 25 Aug 2025 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ynh0//NV"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732FE4A33
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166132; cv=none; b=rVYDXPTZk1FdRdj4GGqzgiLe/jJ4D+DeOEwx5BSIMwut8eMGOgnX1bQN859xr8AUnNdz5qEcVYWORD6mzH0JXVZpW+01voHt3baXNbtolWpbZF16FVPijcR/rb2J7pz+bojeWQL1fRhc4OaUz5t/fvArUjTeWBIN+Bz8PGCofgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166132; c=relaxed/simple;
	bh=NPLAgrHMPEbRcCit8cg5LUfxIE1xtiGXtD62dIg7V30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pj6xf7Rzurbz6vR5ifkEdsq4nsX4doJG4vuTFoesfWpEPk1/1kQlH2ownOc/6UIjl3k7ODQYoYhG5F7YQs1nTKNZVODMYsuildmIqUT6BcZnxy3F33eKoT51MwpZq/jD6kw4XpgCZL+s7aJdRgn1PvqB9NxR25EVTUThjOSZwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ynh0//NV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e4c3af5fso5100500a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756166131; x=1756770931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cen4jQG+cKViO7/eGyf45X+bTPWbr93jK3pMNW+3FMM=;
        b=Ynh0//NVPO7ARLrBqL95G0rxGWF3yDO/43b+U2ZBjGMLucrQa5ajl8STenbuP9Y2vx
         vNSqYRcPwivcLr2L18vnWFk4TXXKph77Ps/ILNe/Y1Awm+xRkAkBrbuG7AjFSXzpUc3o
         JCI0fKA7GUTeYviEIaEGPPs6laE4G/bhKg1os6YyFc11M7lLuEfHeOXtH9t0N7QymgDz
         sXZtYJUuWNFZxQt5fMLXwWG9yq/Qt2izlMTgwGwppaKDJvBwYB9eKjX6tNk8D1p6YvV5
         IhJ2dbuooWNiKmpD9cOSu17cXm5vS65hdUhseAfPqMxafl0eM0xiGN9F0ibgGcq6uaAS
         UkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756166131; x=1756770931;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cen4jQG+cKViO7/eGyf45X+bTPWbr93jK3pMNW+3FMM=;
        b=RuwEX5PYZkQEl7VvSSZtDoLp6JcFie9QqtJxuyKsWWZrZq/XMEEvrjB1I5RHcAy+qE
         4Kaj7fVogO0YmmayHT18sPlonRRS4ZqSw7hkdbAPoXvKviCmKHJzNpdeGfIqrbeB2mKB
         XvzPmTKTzYrvHSxSum8B0PAktIg3pasKYYF2OKQA/N6YNvtVXJU/htLwEgTqanjCuk8G
         yA5fJ+nHYoyYfhZIJS66RrjwuLyEhiNzy9FGSvRH/fwGqHiiJ0aqbvjjHfdzzpMTF7MW
         3LfPn/T0O56Q90TapnoupWWkQHPtq+LM6Uq3nrVoLHIrdpRzER53MOWjQm5bwPM2Dudu
         yAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO22XC5xVEB0GuyZzyb5yhLImH/9wm6PGRl8f8CMFPqY/NRXjsudqBDxNRmjZbDUAVVAouR3E7gD+8nI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQFMkGtq16625lb03F6QnbFvzvn+u36KVHooyCM3fQWuNUVaMP
	/wwgJ7nxH+YDA0sUN/8LygS/eT1okOpYaUrsDdS1IKir9PkEqcciwH/5ZPXMhe0RerLqjEdJPyh
	ZJbTvIA==
X-Google-Smtp-Source: AGHT+IEoGfLX9h1c37EIZeAhhgssdExyoStlprcH70MckStQoVHKCpQSpMAwANLqo/yLR9b9nIacG9kitSQ=
X-Received: from pjtq6.prod.google.com ([2002:a17:90a:c106:b0:31e:c1fb:dbb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4c:b0:324:ece9:6afa
 with SMTP id 98e67ed59e1d1-32515e2bd02mr16610057a91.4.1756166130690; Mon, 25
 Aug 2025 16:55:30 -0700 (PDT)
Date: Mon, 25 Aug 2025 16:55:29 -0700
In-Reply-To: <20250825160406.ZVcVPStz@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
 <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>
 <aKd3cNJqj6_g_ATE@google.com> <20250822141654.Sjoffo8F@linutronix.de>
 <aKkLEtoDXKxAAWju@google.com> <20250825160406.ZVcVPStz@linutronix.de>
Message-ID: <aKz38QetUrDfKP8P@google.com>
Subject: Re: [GIT PULL] locking/urgent for v6.17-rc1
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025, Sebastian Andrzej Siewior wrote:
> On 2025-08-22 17:28:02 [-0700], Sean Christopherson wrote:
> kvm-nx-lpage-recovery shares the mm but it grabs a reference.
> It might be a coincidence but the task, on which the wakeup chokes,
> seems to be gone according to my traces. And with
>=20
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -75,7 +84,10 @@ static int vhost_task_fn(void *data)
>   */
>  void vhost_task_wake(struct vhost_task *vtsk)
>  {
> -	wake_up_process(vtsk->task);
> +	mutex_lock(&vtsk->exit_mutex);
> +	if (!test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags))
> +		wake_up_process(vtsk->task);
> +	mutex_unlock(&vtsk->exit_mutex);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_wake);
> =20
> it doesn't crash anymore. Could it attempts to wake a task that is gone?

Oh fudge, that indeed is what's happening.

Each VM that KVM creates has a kvm-nx-lpage-recovery task, and KVM wakes al=
l such
tasks across all VMs in response to any change to the hugepage recovery set=
tings,
i.e. when privileged userspace changes any of the associate module params.

KVM holds a global lock when walking the list of VMs and so guarantees the =
VM
hasn't fully exited, but nothing prevents the recovery task from getting a =
signal
and exiting long before the VM is destroyed.  hardware_disable_test is (del=
iberately?)
not very tidy, and exits without explicitly closing the VM and vCPU fds, an=
d so
its recovery task gets terminated via signal instead of by KVM explicitly c=
alling
vhost_task_stop() when the VM is being destroyed.

The basic gist of the above diff works, but unfortunately simply taking
vtsk->exit_mutex in vhost_task_wake() doesn't appear to be an option becaus=
e the
vhost code appears to have gone through a lot of effort to avoid waking an =
exited
task.

I think we can also add some sanity checks and hints to help future users o=
f the
vhost task code from running into the same problem.

I'll post a proper series.

Thanks a ton, I owe you a drink of your choice :-)

> > Strace on hardware_disable_test spewed a whole pile of these
> >=20
> >   wait4(32861, 0x7ffc66475dec, WNOHANG, NULL) =3D 0
> >   futex(0x7fb735c43000, FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, 0, {tv_=
sec=3D1, tv_nsec=3D0}, FUTEX_BITSET_MATCH_ANY) =3D -1 ETIMEDOUT (Connection=
 timed out)
>=20
> That is a shared FUTEX and is probably part pthread_join().
>=20
> > immediately before the crash.  I assume it corresponds to this:
> >=20
> > 		/* Child is still running, keep waiting. */
> > 		if (pid !=3D waitpid(pid, &status, WNOHANG))
> > 			continue;
> >=20
> > I also got a new splat on the "WARN_ON_ONCE(ret < 0);" at the end of __=
futex_ref_atomic_end().
> > This happened during boot; AFAICT our userspace was setting up cgroups.=
  In this
> > case, the system hung and I had to reboot.
>=20
> This is odd
>=20
> >   ------------[ cut here ]------------
> >   WARNING: CPU: 45 PID: 0 at kernel/futex/core.c:1604 futex_ref_rcu+0xb=
f/0xf0
> =E2=80=A6
> > Heh, and two more when booting a different system.  Guess it's my lucky=
 day.
> > This time whatever went sideways didn't appear to be fatal as the syste=
m booted
> > and I could ssh in.  One is the same WARN as above, and the second WARN=
 on the
> > system hit the
> >=20
> >   WARN_ON_ONCE(atomic_long_read(&mm->futex_atomic) !=3D 0);
> >=20
> > in futex_hash_allocate().
>=20
> This means the counter don't add up after the switch. Not sure how. This
> seems to be a random task but it might be part of the previous splat.

Yeah, IIRC, those only showed up when I kexec'd into a new kernel instead o=
f doing
a normal reboot, so it may have been some weird leftovers and/or PEBKAC?  I=
'll
file a new bug report if I see either of those warnings again.

