Return-Path: <linux-kernel+bounces-785356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E4B3497E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2D12A5FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF998308F36;
	Mon, 25 Aug 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7+dSJWm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4816308F11
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144719; cv=none; b=M9oMwL2MBil1fiYYtLWLZAA0z93Da5LuoR9H17oK4xGuZvwMwDzOh23Or+sZdrVkL5MhcTmFutWYO25TLRYiMk9/b3frFLClOpGB8hjzs9r+51x++vHNG5sYdVMkeuL2t8J2EgjCYw/A0oA+Dn+G3V3foEDI5Vw55rYab7T+igw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144719; c=relaxed/simple;
	bh=4GQMW7y4hB6OnpRIcEB2iZaqJ0oZoARp3ba61McckPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogSiSFD20kcZVS2qJCCHP6YjLm+jHq8tYzBxKd97IPaLX8ycNdJ+AY9JDC1UzZuUzy4uTt3xvX/GZy0XYrzSTTAM2rSFbBKI6wGxFHonGP9PU78yn8NmvnLjtOCyHd8zjQ024gqqV2AuEZczIv1aWTBz0oD9PTVmWd4YLbUdmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7+dSJWm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so6425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756144715; x=1756749515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5yo9Tha3EYZ7QDWhjTh1gNp5eXSF1E//nUjICwrq4k=;
        b=u7+dSJWmVmjCDzkOc/+o9pNju1PVWZxyMDFdMqcF1qQUWCrO3gOBEufIdc6TDhYb8a
         pqdW7m6yd2jcjO3p0y5g9rSPMktXUwJr1oEkSJcsjJoowgiF2SbxGpV5l21gyNJsvHJq
         LTGulZYKbV9dmabNwXL4XxgOfhfXn7uefmZgJWI26f2DRr2Rb1Vb42MEiyVcMUZNjtzL
         fWwIRd4gVCoRNLH5ZgMwLwkxon09bJ9kE0XCOyZ8KcxN/+LIZxxJfyzcJIywx7B7q3R4
         zUklveOK6ovTkTEUIyVD4E2SVa81Mcp3/aLfyq+xhwwwb5FQUR8h7G8Ht7oB3PcPsEqV
         LsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144715; x=1756749515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5yo9Tha3EYZ7QDWhjTh1gNp5eXSF1E//nUjICwrq4k=;
        b=t/sz+oW5cmbK3j+Se+hkkcVvJ7kOSIFlm+bfwR4agJekv2McULXEWezXm/pUczKI2D
         YN3WxtZJR0X/KSW0KwMx926zbRVbFnTeGouaBeqRrpIWQB3oawerQkgxBDIcvtFR4wYS
         5W//sx4Xc1SkQiAFPC+2PNJw2KlofoQJqCMsN989FZ5Temh/kwNOJgSjUHVW508VBdTk
         jlC7lw1OyitZNhgSrnY3uTmRi8vdaUqbVjRYvGYdv2tunqamYfXkamEQSG1jpExSu0Yf
         b5BvcuzniSZ2gTaWe+/uBqXCQlt87SS2dfuU74C2Z+fqe3XnFNtYqyUZQaAF6DWrsLoH
         WRaA==
X-Forwarded-Encrypted: i=1; AJvYcCU3XUmxUa0vWRdcaLBxbWo7jK80YbOllcdwH9kWUPjSFbD0kQUdZsiD2wFxVtf24Gngm8Bq1ABOfWmWIrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQIrzkuHgm1x/Vk61PShkJ/WjZJWo/nwq8iXeA58BlaymxMoTc
	ZbZZl+Qo3SmC4tS/IGie/mKmhtrkSrcSgKte2M9dLCNirBG3W3lST3L8OtsXiSuXyQRsLsz6jRx
	tn61AP2igK3N428TDpiu7EIQFG72OFrHWTessEaFQ
X-Gm-Gg: ASbGncs8t5Mn6rzLGfpJUPbjGyHRxqnnU42bzVeJzK6v55XA/2Yg0pR+a/fh97bGsbt
	Et0rjiQvNX5isuNXW2RpIflsyUCwSorJ3eoH5dQnAcMg/WVMHGyCpQPKpA/8OtSh3YsS1zTrz1q
	SwW8AFBPOWtYMt7Upl+hc/hQUljYOWBCykv9/hG3vIHjSecSqAKVJL+2a8Fo2zS9IYIs7GwHjL6
	+ZizRE9xjN60iSRSxoyuYLlslpIHLR2+pZT3dQMCZ6E
X-Google-Smtp-Source: AGHT+IGoEbuuaQmf6ejPreW/3EnO6Pdxa5HefL1xaCUoTpRbYEOTACur/ikE7cpdM/TuCFok1aNUpgjgLfri4GxZboA=
X-Received: by 2002:a05:600c:3b9f:b0:439:8f59:2c56 with SMTP id
 5b1f17b1804b1-45b65e97671mr61125e9.2.1756144714893; Mon, 25 Aug 2025 10:58:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
 <20250824.Ujoh8unahy5a@digikod.net> <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
 <20250825.mahNeel0dohz@digikod.net>
In-Reply-To: <20250825.mahNeel0dohz@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 25 Aug 2025 10:57:57 -0700
X-Gm-Features: Ac12FXxz9pJE0h6HrBGgWJl3z0z4f3e-FfLHbDFV9MrECVyOF6U4dJWEVdkn5yM
Message-ID: <CALmYWFv90uzq0J76+xtUFjZxDzR2rYvrFbrr5Jva5zdy_dvoHA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>, Jann Horn <jannh@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Micka=C3=ABl

On Mon, Aug 25, 2025 at 2:31=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Sun, Aug 24, 2025 at 11:04:03AM -0700, Andy Lutomirski wrote:
> > On Sun, Aug 24, 2025 at 4:03=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
> > > > On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > > Add a new O_DENY_WRITE flag usable at open time and on opened fil=
e (e.g.
> > > > > passed file descriptors).  This changes the state of the opened f=
ile by
> > > > > making it read-only until it is closed.  The main use case is for=
 script
> > > > > interpreters to get the guarantee that script' content cannot be =
altered
> > > > > while being read and interpreted.  This is useful for generic dis=
tros
> > > > > that may not have a write-xor-execute policy.  See commit a5874fd=
e3c08
> > > > > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> > > > >
> > > > > Both execve(2) and the IOCTL to enable fsverity can already set t=
his
> > > > > property on files with deny_write_access().  This new O_DENY_WRIT=
E make
> > > >
> > > > The kernel actually tried to get rid of this behavior on execve() i=
n
> > > > commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that ha=
d
> > > > to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
> > > > because it broke userspace assumptions.
> > >
> > > Oh, good to know.
> > >
> > > >
> > > > > it widely available.  This is similar to what other OSs may provi=
de
> > > > > e.g., opening a file with only FILE_SHARE_READ on Windows.
> > > >
> > > > We used to have the analogous mmap() flag MAP_DENYWRITE, and that w=
as
> > > > removed for security reasons; as
> > > > https://man7.org/linux/man-pages/man2/mmap.2.html says:
> > > >
> > > > |        MAP_DENYWRITE
> > > > |               This flag is ignored.  (Long ago=E2=80=94Linux 2.0 =
and earlier=E2=80=94it
> > > > |               signaled that attempts to write to the underlying f=
ile
> > > > |               should fail with ETXTBSY.  But this was a source of=
 denial-
> > > > |               of-service attacks.)"
> > > >
> > > > It seems to me that the same issue applies to your patch - it would
> > > > allow unprivileged processes to essentially lock files such that ot=
her
> > > > processes can't write to them anymore. This might allow unprivilege=
d
> > > > users to prevent root from updating config files or stuff like that=
 if
> > > > they're updated in-place.
> > >
> > > Yes, I agree, but since it is the case for executed files I though it
> > > was worth starting a discussion on this topic.  This new flag could b=
e
> > > restricted to executable files, but we should avoid system-wide locks
> > > like this.  I'm not sure how Windows handle these issues though.
> > >
> > > Anyway, we should rely on the access control policy to control write =
and
> > > execute access in a consistent way (e.g. write-xor-execute).  Thanks =
for
> > > the references and the background!
> >
> > I'm confused.  I understand that there are many contexts in which one
> > would want to prevent execution of unapproved content, which might
> > include preventing a given process from modifying some code and then
> > executing it.
> >
> > I don't understand what these deny-write features have to do with it.
> > These features merely prevent someone from modifying code *that is
> > currently in use*, which is not at all the same thing as preventing
> > modifying code that might get executed -- one can often modify
> > contents *before* executing those contents.
>
> The order of checks would be:
> 1. open script with O_DENY_WRITE
> 2. check executability with AT_EXECVE_CHECK
> 3. read the content and interpret it
>
I'm not sure about the O_DENY_WRITE approach, but the problem is worth solv=
ing.

AT_EXECVE_CHECK is not just for scripting languages. It could also
work with bytecodes like Java, for example. If we let the Java runtime
call AT_EXECVE_CHECK before loading the bytecode, the LSM could
develop a policy based on that.

> The deny-write feature was to guarantee that there is no race condition
> between step 2 and 3.  All these checks are supposed to be done by a
> trusted interpreter (which is allowed to be executed).  The
> AT_EXECVE_CHECK call enables the caller to know if the kernel (and
> associated security policies) allowed the *current* content of the file
> to be executed.  Whatever happen before or after that (wrt.
> O_DENY_WRITE) should be covered by the security policy.
>
Agree, the race problem needs to be solved in order for AT_EXECVE_CHECK.

Enforcing non-write for the path that stores scripts or bytecodes can
be challenging due to historical or backward compatibility reasons.
Since AT_EXECVE_CHECK provides a mechanism to check the file right
before it is used, we can assume it will detect any "problem" that
happened before that, (e.g. the file was overwritten). However, that
also imposes two additional requirements:
1> the file doesn't change while AT_EXECVE_CHECK does the check.
2>The file content kept by the process remains unchanged after passing
the AT_EXECVE_CHECK.

I imagine, the complete solution for AT_EXECVE_CHECK would include
those two grantees.

Thanks
-Jeff

