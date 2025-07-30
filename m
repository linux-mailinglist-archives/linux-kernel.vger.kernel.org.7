Return-Path: <linux-kernel+bounces-750948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508DBB1632D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE34F7B3634
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A02DBF49;
	Wed, 30 Jul 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcJvjZk7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004D2C324F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887097; cv=none; b=ZmDVFCbcx5+yT4lO98BFACFF9ZpQ99ZqaIviVjFqKpequv7FDXGRgYvi5dQuTs3U7f8uDDc9aorMdv2EjrQ77ULrM+CLscZSJIHG+ToCfgyymoEH7qIRanMgvrv0tMAYUcxEFxs8re1GyuAWSHMoRbXSaKKXoFUkng4PzoT4jTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887097; c=relaxed/simple;
	bh=AvX6DV9MZeEEGnxMTsiMzU9R6U+GhYhri4HxSIUZVcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ij6fDWpOjyvVeOgG3yzK9MfR7IWAZjnFmmPceLqk6CzV0iKXZ2NYzPi7e8eN5tmDN1NmEAqhKuf5aI2OXwCYsAkRYpYEhdHXN5NSXZmVrVDSDcUoLhRSEhH9sh2OZAY4nUSx2TjgXXmy5lXG16l3yzPIAOvse/FaU0K/KDyBzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcJvjZk7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b73f4ead1so2315120e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753887093; x=1754491893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7NiWxPTKOFYM9uonseM4vMrBQ8wN02nGWedXjPFtiw=;
        b=KcJvjZk7EEVmcCsWGIMUwJ/happltqEiJysuwTu78Gb22uxsbl7UpbVoqEcRQaD5U7
         z3R/DkZtKnWogBJyCuJWH/u4+1MSTcIwXfXLcGr2MApTpYrXgaZxTtvNLf5bs2ZXpCNL
         tTiKXdGQhJyuGQbV8SClXO48cT/S/qBXd7hFgDZseE5/fZhL/GPb2JyIXhPVpNc7Btf1
         3qIqaMuI/rr4ld1P2Q/VF/SQ+QWvY44IG9XkyTXAqGKUMNUCC9IM2E/gJHvET3yJYiVK
         ilWMkUxQCCl9LQBhpmuAjrnutmqQwPwn4o5wOD/xt5+ZBELBBn6G9V2CIi9uWvkFSBMB
         Jtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753887093; x=1754491893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7NiWxPTKOFYM9uonseM4vMrBQ8wN02nGWedXjPFtiw=;
        b=pZ1kHSMIDjo0kF67tQwkAFPYcvNuypRWyBofqloBxt5xU6mhBBPWu5ITwGenf/mKwN
         PETD2rmx44aZOHiVzpfZ6eqzz2iGccEftGAw0R3wCFhV/SXTvasjQwpHhGym8HcA+9Xd
         l2vCPJhQ2uIaZggRYvUdDVfs70v+qjguGDi/BnLp21o9uYdv/YR/9wvj5RtEJpcfuX2m
         HNdFgmQx15VPI1gS8gI4I4IojPWohDE7E7zBb9BNanTnKSml45haLX6eT5cdyct1LWSA
         TOsQkv/dZAB4VdleB6oe5TaEB4IVJvccAV80LnsPdB1sX1+RNc5ZyzX17BAvh3NHl/um
         xHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUcyH+H4axPPbb7/QPJYoNvYfNpdCDCe5khvyo9wLuXX2OIP8/P0OdD6clLSxUW9LWrwWUfo1DP4iqeFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6h4hOfCZehWw188CP5HRRJDWPk6EbS1Mf3hIv4ZAoPgcTCNKF
	/rFQpu97g1k4PC0yk0iAdSpjn29nrVWPKeUn6iFmQJwxW1+6dIdLgXXgVU6AMswQsATJ849oRSj
	XobOH8ny/AKL7sieXzWxmhbP/oXx/Jls=
X-Gm-Gg: ASbGnct7e3U3c2k3rRKEbr5hmLXIXUPx93DKNGTwbT1RWZtCwYI5ffG7tarnwIhgvnI
	lnxtrLTajGDOSb+P8PgWgUFp6DroA1OGzZh+jEkS0Vlk8TXwXVkMap39t4SO/7MrTb+zohD5w89
	T0myLjNJ0312v3BkzLWGXRc52E9AxJqgc/eDOpeCENiOMc3AQzK9jII5c86j/Hdkf0kEePwAjkL
	pMAGjr0ZGr0zRGaU4SX5MR4TLQ9Q/ftbpcohCXYrQ==
X-Google-Smtp-Source: AGHT+IEgEmq4syI9+uAid95y/R35+yJJ48ObJP6+pf2CLRAl6znW8QzofACTPgJiAcWHclppjwRXGeQ3u9SrRiIwgDk=
X-Received: by 2002:a05:6512:39c4:b0:553:adf2:38bb with SMTP id
 2adb3069b0e04-55b7c0986ddmr1271842e87.46.1753887093209; Wed, 30 Jul 2025
 07:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607064444.4310-1-pranav.tyagi03@gmail.com>
 <87cybdp7to.ffs@tglx> <CAH4c4jLjSBxbd3bqkdgcCSWqXURratANgnbq9negrSU283xHpg@mail.gmail.com>
 <87frg3ss9s.ffs@tglx>
In-Reply-To: <87frg3ss9s.ffs@tglx>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 30 Jul 2025 20:21:21 +0530
X-Gm-Features: Ac12FXySoXDJCYsfTOJ1c18ryEETA_OYD0DDbNocu3gc910feNbr76AnTiqvAps
Message-ID: <CAH4c4jKmj2gwmW2LS8CuGyw6phtiN+=_Bef8_pSEzjnbsqPOeg@mail.gmail.com>
Subject: Re: [PATCH] futex: don't leak robust_list pointer on exec race
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	linux-kernel@vger.kernel.org, jann@thejh.net, keescook@chromium.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 6:38=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Jun 11 2025 at 19:33, Pranav Tyagi wrote:
> > On Mon, Jun 9, 2025 at 3:15=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> > Does the revised version below address the concerns more effectively
> > or does it still need a bit more seasoning?
> >
> > "Currently, sys_get_robust_list() and compat_get_robust_list() perform =
a
> > ptrace_may_access() check to verify if the calling task is allowed to
> > query another task=E2=80=99s robust_list pointer. However, this check i=
s racy
> > against a concurrent exec() in the target process.
> >
> > During exec(), a task's credentials and memory mappings can change, and
> > the task may transition from a non-privileged binary to a privileged on=
e
> > (e.g., a setuid binary). If get_robust_list() performs ptrace_may_acces=
s()
> > before this transition, it may wrongly allow access to sensitive
> > information after the target becomes privileged.
> >
> > To address this, a read lock is taken on signal->exec_update_lock prior
> > to invoking ptrace_may_access() and accessing the robust_list. This
> > ensures that the target task's exec state remains stable during the
> > check, allowing for consistent and synchronized validation of
> > credentials."
>
> That's way better, but it still does not explain what the consequences
> of the racy access are.
> >>
> >> You really did not have a better idea than copying all of that logic
> >> into the compat code?
> >
> > As I=E2=80=99m still learning, I wasn=E2=80=99t quite sure how to avoid
> > duplication there. Would factoring out the common logic into a helper f=
unction
> > be the right direction? I=E2=80=99d be grateful for your suggestion.
>
> Exactly.
>
Hi,

I face a small issue while refactoring the common code in a helper.

The main obstacle to a full refactor is that the native and compat
syscalls use different user-visible types (size_t vs compat_size_t,
struct robust_list_head * vs compat_uptr_t). Because put_user() is
type-checked at compile-time, I can=E2=80=99t unify both into one function
without either unsafe casting or weakening type safety (this is as far
as I understand).

The best I can do is refactor the common task lookup/permission
logic into a helper, and leave ABI-specific put_user() calls in thin wrappe=
rs.

I=E2=80=99d be grateful for your suggestion.

Regards
Pranav Tyagi

> Thanks,
>
>         tglx

