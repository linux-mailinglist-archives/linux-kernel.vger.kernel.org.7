Return-Path: <linux-kernel+bounces-751232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A03B166BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76137B5413
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032432E03F2;
	Wed, 30 Jul 2025 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeVpqHSL"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B511E5710
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753902730; cv=none; b=eURmuHvW/sWTIjEEESGEQgop1oMId+TGgYBnH9aJeR4n/Xpe43RaKiNhFRsCTqxKty/Vmjmp3AHjCUXiDXIoIHT5oEOGbPVHcUhMWOTrL6CRMlpGW8ZjcXRZ8YQZXBD1GclHiNvrrq1h3ooHVZj21hb2eyYGRfT37R0P1buuFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753902730; c=relaxed/simple;
	bh=V1F+bXXlYQeXi5X4k/5ncJkOOvpM5ZuJh2NXOjU0lxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=am8SSvS/TbeurRc+ZVyWyZnutWrM3WaCq+3YmQvdh3BSsWaAS+t/H/0AKHT0dMeujDk+x9o854R3rn8AsAfws6jdpKoIIFw3/1QB1vflSJ7kjKzmleQcAIm+p13UD9E2SUD0IpW8KmzzUyprqZQwPUJWgkF3XxkWx4eKGF9vUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IeVpqHSL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55b7e35a452so92406e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753902727; x=1754507527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1F+bXXlYQeXi5X4k/5ncJkOOvpM5ZuJh2NXOjU0lxQ=;
        b=IeVpqHSLawwOnHGr+Luk5ny+swgJwCI0JVzGY2PKbHGDug7HtYbk4xv7n4cdtqRByQ
         Cq+1652JXTiSWG+bKwNNBRlY0y5MUiunNooB6vmWYoqEt1BEzpqHiejqGznDP5RzbjWH
         e/ZEKfphYHNmLr1tDJ9+7AlCPMQweupmO/LLgQUNAy6C8TZ4nB/LM8TA7jRZYhCBjTLp
         EmWSizA8s2cJxB5gfdXdLe9R7mWkh3aF5egapc4ifFa9UUB/tMaMz8bcSUjhNZbBzos0
         TdTVqQgADb+NMDMr/bko5ISyUVr39ioFH1EANItwcf7M263npF6Xw9vM/0AzXhfM4UiF
         5BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753902727; x=1754507527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1F+bXXlYQeXi5X4k/5ncJkOOvpM5ZuJh2NXOjU0lxQ=;
        b=GkMmsqYagl+tZIQ/8V6bqLVM58+AILwLIrP3cIs/ILuFjt3TQpU3IDrrW0Spnbmwen
         hK0i9Oya/IJWiizvrPxraqB9XAYe/zY95K273rXS8vRSU7rCBiOmZ2acNJCxDg/PfH6q
         yVLkTUU6oT/JNe9KkqcypWwCARXBuF+kOr/AE4/hy7vcC9VSBMhErygw4GKJiWPZxUqP
         /L0KOFj3+6BeEFCJUbno+Yycc2OzIJTwlnmf979L2Ksf0odQp8v+gKZt0pXtLfcys7UK
         +ajn3OjfVnSRsU8uT1q3tpGD+0j5tB7c1B+it1iX+cKPk4zrrlWNK7CZSFW+mEF7TMux
         DenQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYigYHmzXjcirnE9cpHYLSX7cZHg8OwQgHfgGuC/eEVXssoJk+fAWO3mR5n8MJGfGWX382BF0v/VfmXuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh69/exsfo7KbqDM7bbEu5jW95oMg2RAA6oCZPMLI5SmJvpm5b
	EP1u3x9CxSJqDKkhqtkZxDLCW4u2mIgS1yfZvJDjF/895rmk6HQ737IWYMyBtXUTrShe3Y5no0l
	PU5A5IhgtNSgodT3O9i5DitvDNA1kx3HEJytKmXs=
X-Gm-Gg: ASbGncsp7jg5xxjtx/QUiYUj1OCpsX0lEf1mMQkHDBD3KDg56mv0s6sI1/7bSFMkc/O
	kPXyatCztKMtYUCvvZgg9/zH2robOasSchBxD4TE7ZJpzO9R9rakpU38GxyuHYuWupMxglWKq8A
	GEb02oEgUKjcumbBn9y5wGUUmUPwskmRg+Qu34FaBGpqMrtL8SCwhlf5K6DTgNVoiqQLhtaTdrj
	HqGpSqXEOaj4okZhyYPn2PWNH+CIfIkm/H/UdQVSlubekU=
X-Google-Smtp-Source: AGHT+IHq3O02Isy9UO9EBNM2h/tgG1LradItYyY7WiGiYYCjnlChvIFaTIyvSt0KcCsrp/O3eMTcUwrT1XrBc1c3alM=
X-Received: by 2002:a05:6512:39d2:b0:55a:4f05:6e4c with SMTP id
 2adb3069b0e04-55b7c0885ecmr1469195e87.49.1753902726644; Wed, 30 Jul 2025
 12:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68894443.a00a0220.26d0e1.0015.GAE@google.com> <8ab72592-7e16-4d79-9e26-f98a1938cb2a@linux.intel.com>
 <61b68b13-2482-499b-a550-a11580a61e9d@amd.com>
In-Reply-To: <61b68b13-2482-499b-a550-a11580a61e9d@amd.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 30 Jul 2025 12:11:54 -0700
X-Gm-Features: Ac12FXyCBe3eZdHmtT03zQRJBw01rHa-_e76up8xxbhmJkSgGW8khZKY2csyOUw
Message-ID: <CANDhNCo+esbJpwqq0boTaKbEL5WBjwtuynH+jcNW1rzj65jJJw@mail.gmail.com>
Subject: Re: [syzbot] [dri?] WARNING in __ww_mutex_wound
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	syzbot <syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com>, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mripard@kernel.org, simona@ffwll.ch, syzkaller-bugs@googlegroups.com, 
	tzimmermann@suse.de, Valentin Schneider <valentin.schneider@arm.com>, 
	"Connor O'Brien" <connoro@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 2:50=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> On 7/30/2025 1:57 PM, Maarten Lankhorst wrote:
> > Hey,
> >
> > This warning is introduced in linux-next as a4f0b6fef4b0 ("locking/mute=
x: Add p->blocked_on wrappers for correctness checks")
> > Adding relevant people from that commit.
> >
...
> >> ------------[ cut here ]------------
> >> WARNING: ./include/linux/sched.h:2173 at __clear_task_blocked_on inclu=
de/linux/sched.h:2173 [inline], CPU#1: syz.1.8698/395
> >> WARNING: ./include/linux/sched.h:2173 at __ww_mutex_wound+0x21a/0x2b0 =
kernel/locking/ww_mutex.h:346, CPU#1: syz.1.8698/395
> >> Modules linked in:
> >> CPU: 1 UID: 0 PID: 395 Comm: syz.1.8698 Not tainted 6.16.0-rc6-next-20=
250718-syzkaller #0 PREEMPT(full)
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 07/12/2025
> >> RIP: 0010:__clear_task_blocked_on include/linux/sched.h:2173 [inline]
> >> RIP: 0010:__ww_mutex_wound+0x21a/0x2b0 kernel/locking/ww_mutex.h:346
>
> When wounding the lock owner, could it be possible that the lock
> owner is blocked on a different nested lock? Lock owner implies it
> is not blocked on the current lock we are trying to wound right?
>
> I remember John mentioning seeing circular chains in find_proxy_task()
> which required this but looking at this call-chain I'm wondering if
> only the __ww_mutex_check_waiters() (or some other path) requires
> __clear_task_blocked_on() for that case.

So yeah, I have tripped over this a few times (fixing and often later
re-introducing the problem) but usually later in my full proxy-exec
series, and somehow missed that the single-rq hit this.

Obviously with __ww_mutex_die() we are clearing the blocked on
relationship for the lock waiter, but in __ww_mutex_wound() we are
waking the lock *owner*, who might be waiting on a different lock, so
passing the held lock to the clear_task_blocked_on() checks trips
these warnings.

Passing NULL instead of lock is the right call here, I'll just need to
loosen the __clear_task_blocked_on() check for null as well.

I'll spin up a quick patch.

thanks
-john

