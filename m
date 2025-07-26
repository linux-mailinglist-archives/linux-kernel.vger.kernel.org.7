Return-Path: <linux-kernel+bounces-746887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0ECB12C81
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 23:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A01189E660
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 21:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C448A1FBE80;
	Sat, 26 Jul 2025 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzNPhLLo"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4C206F23
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753563694; cv=none; b=izpwB54w2ZJPcABhAIUGZ2Dnsqe6bqcu4UjMIknmyVMmq9zKIwojaETqOfdXRnLm9TXXHP0CVhr0Ek/9FnQQah2o4Caa35ufSJvd95HLhJdVA6aVFH+AD3J/7IN77pcpKpxIvFE3kQpNKO2yznekS7HZsf6GofP/8fTGtfkLqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753563694; c=relaxed/simple;
	bh=GOOK+NKSqEawB65E8IgBt4psR5xQS3I+Ix0GnU5cvbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXNaWlzvM9FHC3Hq57cqDY1PLzrgY4xxhlNs1CFbar65TSQ9rtMxnPm+Ok+irjQAQLIPGnYtUdtOcUCFUEqiUlL4t7XEhZU7Au48iBPPlUIoXq4BltW8xjlPpdowB/KjifqtsY7/RWe7n6DH+8q5Fczdm8iju4MLbBoed/6v82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzNPhLLo; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e283b2d065so153305ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753563692; x=1754168492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x4fJxfKzaOWGYLSu6UptUSjwhrzaz0p9fgAriJd8/o=;
        b=dzNPhLLoPrnwwuVwkdGMUHlGGzqygzbnBOncbw2UTpcBu4goNE2AriuImgCpl5oaEL
         smS9azGCX3obUllUHLltFbN/2dhvPIPjomOpxDpmxZaLsmZqzfoEu1hy7IYMiwkS4B/U
         /UGdndgd0bpawluqE54nOnStV6ovBG0cEXSVhe0VvyHzzju3I+MvoYBSFPIQPUKM6808
         e+Vgui9ImsVcOOtIDX337+WA1fl6u7mVvgj7M7gUgl4aN/3/Hzadi31fwMGNWddTMtNJ
         gZ+GpuyBW8GdcJOsDRn9QiqlDul/SfQEOFeNOqF91QjkPhqfK3gXmEeU9ZQOZs3+zHeq
         svmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753563692; x=1754168492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x4fJxfKzaOWGYLSu6UptUSjwhrzaz0p9fgAriJd8/o=;
        b=KyEeuRTzM1nq6ahVCdnDpxMzJuWdKZAgHgJrfvz3dXlI0MnkV0gnOsibqxOODJSvWH
         H7vyRSbeyq2Xlt0DejEZjWomr+b1Q4EegtLpm0f0BbAz8ZMT62ofNDnlksTv9rAAYpby
         v3q1UfRhWzmYbrmWemrcruONS93eqDszJwW2McMiQPuM7O+zB62NPEgsOKd8L1xoyrCC
         OHwEt5wrTT+zVGbt57ydG7x4C4eCl3g+ngPwcr3AvBd01SLe3P0K2RKwDWrUfm1sXbjD
         d+I5PxJJWxJ51+VmRx5F8yLUF/Hr+rMZimn2MUD0Iz/2Mk1YONI7N9Dcq9kbE5HlMjpS
         L+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUoIyw5QuY1r0M7f+4/NVP3pYeTKNdfmFwuhUl4xxR6eB31WqKVLcC+XCgwO+GbsSCKzftin5OvDhuYm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycwuZNCNtPW9gAHx9sWAYR5ytSrO+NGEq8KVBY5PF9eUM8U9HB
	2+9l02rTnUMGJ2OwsPBnh/Xv3kgBoR4RWmU/9mfnakktQ0NcWWR49PtELheIgI2hKVKEH4OnHZP
	2DuT8zwG7IKlt9PB3uzAtk+ycd/CwRgQ2M+Hk4NCN
X-Gm-Gg: ASbGnctgXLAfjPaCld54QXH3v3J51E9+PkE2mtupslNHH1hg0P/6VUu4b5QM3Cle1L0
	pz8dM1lHAG7LGJnIl4LLfYpYAt2+zg+RdzG5t1emA5+tJAdAkTLzpE5wlBVGYHBLMrJ0nSO5ul7
	aGBnVmuqtWCDNC3TY5alLwOfazGzH8JVZSgxmiDN1tqxBFJuiBticEtt7WL2cOfePYftrjOJZ6X
	2L1lT6s
X-Google-Smtp-Source: AGHT+IEmA1DUIGHQb1RhToZt+PXTE893jXnkv9Gcbost3232KkW59jU5rvsNSTpPTWHOWmtITWmZ8sfC05S61MmnGZo=
X-Received: by 2002:a05:6e02:3786:b0:3e3:b0ed:2170 with SMTP id
 e9e14a558f8ab-3e3cbf79f02mr2916975ab.6.1753563691516; Sat, 26 Jul 2025
 14:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV> <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
In-Reply-To: <20250726175310.GB222315@ZenIV>
From: Andrei Vagin <avagin@google.com>
Date: Sat, 26 Jul 2025 14:01:20 -0700
X-Gm-Features: Ac12FXyA3quU2h7NGWT-ipBC-zbAngmnxqJ3Jg4xKgmnSzqf6a1vVrUdwUoL6Fs
Message-ID: <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrei Vagin <avagin@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	criu@lists.linux.dev, Linux API <linux-api@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 10:53=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Sat, Jul 26, 2025 at 10:12:34AM -0700, Andrei Vagin wrote:
> > On Thu, Jul 24, 2025 at 4:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > On Thu, Jul 24, 2025 at 01:02:48PM -0700, Andrei Vagin wrote:
> > > > Hi Al and Christian,
> > > >
> > > > The commit 12f147ddd6de ("do_change_type(): refuse to operate on
> > > > unmounted/not ours mounts") introduced an ABI backward compatibilit=
y
> > > > break. CRIU depends on the previous behavior, and users are now
> > > > reporting criu restore failures following the kernel update. This c=
hange
> > > > has been propagated to stable kernels. Is this check strictly requi=
red?
> > >
> > > Yes.
> > >
> > > > Would it be possible to check only if the current process has
> > > > CAP_SYS_ADMIN within the mount user namespace?
> > >
> > > Not enough, both in terms of permissions *and* in terms of "thou
> > > shalt not bugger the kernel data structures - nobody's priveleged
> > > enough for that".
> >
> > Al,
> >
> > I am still thinking in terms of "Thou shalt not break userspace"...
> >
> > Seriously though, this original behavior has been in the kernel for 20
> > years, and it hasn't triggered any corruptions in all that time.
>
> For a very mild example of fun to be had there:
>         mount("none", "/mnt", "tmpfs", 0, "");
>         chdir("/mnt");
>         umount2(".", MNT_DETACH);
>         mount(NULL, ".", NULL, MS_SHARED, NULL);
> Repeat in a loop, watch mount group id leak.  That's a trivial example
> of violating the assertion ("a mount that had been through umount_tree()
> is out of propagation graph and related data structures for good").

I wasn't referring to detached mounts. CRIU modifies mounts from
non-current namespaces.

>
> As for the "CAP_SYS_ADMIN within the mount user namespace" - which
> userns do you have in mind?
>

The user namespace of the target mount:
ns_capable(mnt->mnt_ns->user_ns, CAP_SYS_ADMIN)

