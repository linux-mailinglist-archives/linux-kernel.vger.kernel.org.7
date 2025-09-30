Return-Path: <linux-kernel+bounces-837849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF40BAD9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC8E189F013
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF3E2FD1DD;
	Tue, 30 Sep 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkX2FHjv"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789432FFDE6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245206; cv=none; b=I3B0s3RMyYhD/rmflLq5cgd3TIQ5yIj70aFlgfZpyfS0psyzmWNS2yWm3+72s9mQfSC+9CPXOYsDdXoqEWVAeDHR8EBHKtnOfa/+/+u4MNm8jB0vPbrMI/FfPNBzr+85XRMMJfzvCNTReUEJIv6lR18g6xKP2321jT11prWMsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245206; c=relaxed/simple;
	bh=BSewBfFWhJBl490BIH5OZ5knEj952tmRcHjCLHNd3ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNAhVPoOJVS/iQiq+TFX/L88ENFaOFgkDSq3ZKNeHMdZgODHsZpCsIIM+4nHdcAyfKUhQv4s3hfW4Xt2XUpa0w4KL/oaW9tQtyfDQdpVOP5g4h+lLRFGPM3gVeTSPhf8SPE8SeqRX3jaW9HpXiFhnKWzMhyl4jr9V0a4wGM5kHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkX2FHjv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-36a6a397477so58845561fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759245203; x=1759850003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSewBfFWhJBl490BIH5OZ5knEj952tmRcHjCLHNd3ws=;
        b=DkX2FHjvnJZkH/LdoCtIYQFCZSWwI/2Va5/I0UK6YIIN7+XvhylrqT1x8k2EV92ueP
         1e/tdcz7vI4lS1MbU3jyD8OkPiHdSWe0JKPyB1DAHrNDcvow5YAmunMVudz3BbykNIWM
         FsZmXJSn3jeRTnC8VvBynrASUfzTAnrs1Ix6cyZWRIzyucT4w32YFJ7qSFMz++DLT2Kn
         KjxvEployqbI4g0t3cQH+MO7L8rFBfP0GlbzwQG3S75dQRu6/k19DfwZyYec+i2x2/OE
         MV3ENHNW4UF0EgsLmQi10prjWjYQq8FXscP0aZF4SG7Xu90IKbsUagZCcJYMromKStGu
         33ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245203; x=1759850003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSewBfFWhJBl490BIH5OZ5knEj952tmRcHjCLHNd3ws=;
        b=Qm9iTUihHpFBmjFUzvkdmKDM1U+jSWu5n2eW8EMDgkdIb9CaV52xSnMDu5IiD6vaq8
         NcgHX5kU+IdnNDk8tJrF7p6/h2gHpWF0vQfSkcLuK443tNo6QJ+0off7U2a7KYvU383u
         tKN/CnFaIvU8Mf/bc37Jx2GJRLWqNRyGG/3DXfxd3XSSmV2vEPAM1MmxO/CaYvGKxdnU
         4xMJ+kmdYCHm40iM34tmwXkKgMolZ4kK3hjqFkq3LPj1/UYT9M0QrUKatsStDQIzH3Ys
         8CC3czHclY051s6vH8JBW6/6/8K3pmh9yEYhmu/ftgBRYxEMoaGVZntmYTJQy8O9si8U
         rwXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUpTTw+nSqGwnBf7DOiG7xZBuDd+UQHWlJ9RjFAY6O4dJhk7ChDmyK8UEOQ1R8NOBxR4iMfukozWXXAUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAocj0fRXehu1Xwob60vC+L0JAAfoFtAOp9XPTvt6QRl+bpLqb
	oY2koenL6R4LbkRm0HO45jlTVWtXrodkx36TET3aQP71t3v9tU0B9XFlMutGIIv4glgq50CuhlJ
	/6Ez+Madfkms2Qc0d+euYDS6ozq2qXdrf9vs8
X-Gm-Gg: ASbGncsrMEzjoTrFocO3FTkTNFLu7ELYdty0VJtkCz7/CthgyxNkHB6HqO5eZhYppNZ
	QSt6rYHfS8KKBHZzSEyLzRbC+JqB/mv4Ok43qOF0F8GAgAI5Q4zyuHmaE3h+7fuu0NLPM3lWCzZ
	eBkEvJB/pbUQVVXu8WjVBYArOx4SKjLD8Q9pYnhGS2kqS/CfV9iuTYS5UMpdYk7gum0kRPCJBe5
	WVGwjh03kPMjYB+bh0/GuHqJSnnzTeD/3gCUMOTgfqMEHx6KfkVox/fJXbXJ/CNf69UCiM2hDmj
	r3YJl8IR9W9wUf1C1BHuOg==
X-Google-Smtp-Source: AGHT+IF4toYIrIqD3kiLsHfmm4JRYPSghmYhxXGwVPbDmOVVXAkp72RxcbXIqWOsLeoh54cMOZe90BiMurhEoL3Goy4=
X-Received: by 2002:a05:651c:2542:10b0:372:90ab:8bfa with SMTP id
 38308e7fff4ca-37290ab904bmr26694711fa.37.1759245202296; Tue, 30 Sep 2025
 08:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
 <54234daf-ace1-4369-baea-eab94fcea74b@redhat.com> <CABbzaOUQC_nshtuZaNJk48JiuYOY0pPxK9i3fW=SsTsFM1Sk9w@mail.gmail.com>
 <377697dd-15bc-4a2d-be19-1d136adb351c@redhat.com>
In-Reply-To: <377697dd-15bc-4a2d-be19-1d136adb351c@redhat.com>
From: Cortex Auth <deepak.takumi.120@gmail.com>
Date: Tue, 30 Sep 2025 20:43:11 +0530
X-Gm-Features: AS18NWCPx3KYKK3cvUH6TSzAvXHruvjzP3zvXDvzd6ohqBVPIRDoOlk-IyqoDss
Message-ID: <CAC_ur0rRtuVS7GTxUuEU=yOfrsTRZH0dcGwgoQCy9wB_b6pE2A@mail.gmail.com>
Subject: Re: [PATCH net v2] atm: Fix the cleanup on alloc_mpc failure in atm_mpoa_mpoad_attach
To: Paolo Abeni <pabeni@redhat.com>
Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, pwn9uin@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, 
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com, 
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:01=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/30/25 3:33 PM, Deepak Sharma wrote:
> > On Tue, Sep 30, 2025 at 2:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> AFAICS the mpc_timer can rearm itself, so this the above is not enough
> >> and you should use timer_shutdown_sync() instead.
> >
> > Hi,
> >
> > As I understand it, `timer_shutdown_sync` will prevent any further
> > re-arming of the timer. I think this is not what we want here; since ev=
en if
> > we somehow fail to allocate our first MPOA client object on our first
> > ioctl call,
> > and hence end up wanting to disarm the timer, maybe on next call we can
> > allocate it successfully, and we would want that caches are processed
> > (which are processed for every time out). So we still want it to be
> > possible that
> > we can re-arm it.
>
> Ah, I missed the goal here is just being able to rearm the timer (i.e.
> there is no related UaF).
>
> Given the above, I think you could instead simply replace add_timer()
> with mod_timer().
>
> /P
>

I think yeah we could do that.

I have just been going with what code seems to have wanted to do;
Arm the timer if `mpcs` was NULL (no MPOA client existed)
And if there's any error, delete it as (was done in case of error by
the `_notifier` call, where we have no MPOA client yet).

I just extended it to the `alloc_mpoa` failure too, because
in that case too `mpcs` remains NULL

`mod_timer` would still work, because the timer callback will not do much
if it finds the `mpcs` to be NULL

If it sounds good, I can go ahead with it

Thanks,

Deepak

