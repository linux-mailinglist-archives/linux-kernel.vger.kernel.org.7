Return-Path: <linux-kernel+bounces-754757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C509B19BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35898176608
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44225228CBC;
	Mon,  4 Aug 2025 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTUNfBfT"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152322A1C7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290892; cv=none; b=nUb3kSkDxedxg6o0/080NJsoM44YtdhdAfSgvVJPncZcXxz025v2ZE+bAtiuJYP5wn15K4fmdCnIkcioeA015ixzPYlWQE7Pw0l6u4wjVthABQO2fyeqjDNvbDPj81smB8qjZEBHU7jWe4NLjz208DyZVZC8FXLS7pNmE6KICVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290892; c=relaxed/simple;
	bh=pYYfbgtGKtJmMe3qV97+fPjpGWjo1ETtd5dCoPaov5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6mMLLl3Vli9AnRmq3/w84x1rdc2BF/7KRpqqWsZ8K9LTI0d1B1Oi9sPBBX3/MbkaMafRIKXPskwWXLEoAY93+nQLdb+HFTbRb7nKfwRIH+RA5QQrgzRUeSQKY9kQzgsI3JUr68y4q4E0HVzUk//XvdLWAbg+25QXWebOdtBiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTUNfBfT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-332559ace6eso17956451fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754290889; x=1754895689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOeLQP+AJ+SiRI8RVG4vwpZ6jRWlqeSJrVM4bgwJ2FY=;
        b=gTUNfBfTnJxNEp1rasvuOeWdh7nBNsLxcVOC0Kn9t7AFnjrzuiXRqtIcKcpkYwUCQ4
         54hJa8keHOSSorB4ugaYWid/RmEE5dKiLoNPjdckLpLuKIy50dxWBCMTsk7tWSfVTYDA
         P/40kfB03QzcxX9LGGUc0qztwE3I3yMqtT6uAWbzb8DpwLCQ7eIVbUk1TG0TNAzWxl6J
         h2GMYCHkbNVFA48/nPJaTomc9Vj8fakmKtgODiL23g6GnNavIFWttd6jAJX0x1BlrqZ2
         tpB/VdpyaI0oIMWcZcFBVMNrcMHbTJPQMc2HeFAWEZ7CEWuX7z9AI9KfMhbiUqkWDn3A
         Y8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754290889; x=1754895689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOeLQP+AJ+SiRI8RVG4vwpZ6jRWlqeSJrVM4bgwJ2FY=;
        b=NdMmFEMunO6JbQzG3zJVpzJ5b3H+by7qaNYSq7+21TmROZx0AvQDAqmB3ZHcomFptI
         VRjLB/3XwFl4ekbNB3e1mBzCoTRZBYsFLH+TWLKr8sg6VlGkAo7arTlFYW085IcAKcpv
         pF0cj7EIEQNd7fBmS12SBWow+84iPrLxNdecVRxmC28khXm2XvDSO33PlSeyTWiqtQ2Y
         aY4PvyqmS9qhKVvUXeIoEp4cbAf23cnhg2Otat9rWKWijU/K+1JQd0zgN0i9gbDrVVS+
         OJeM7khMWqVAb6eLCbSjMmarPzfdI7o0kPPRwy8SyS76aGSw0Sn3LSs4C08aS1N9o6tV
         v6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXREMPShu88Rt0ldlL+urTVaGHMEXmFdyiVFNZSUk9ktvfuBXMO0EqgT7E3q9yECW4ot4TlTf8oTkWtupQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GuLfi94PvQLuQqwk8sX0zMJh1CJR+wbgPKeqM9TcwSITanbO
	14IFQ/FuQVs0II3okZgxLove4RUKX053875bWzwBkifeiuUVA2LeYGXcWSijAPCtawpLNW6BJvX
	KP3C4N1SxSZoLaP/4mQcgDOyV6gpJkNs=
X-Gm-Gg: ASbGncsj7KRu5wVa8UsCZaNPEwURxkFgm0fkSqRBItX0LepIB7jLBvbZMk5qovGoI21
	sSEEjdkkkDvKcconqHDxJYW4M8of8D0H8I3acLESJW0N+D7kjdJxoH+L3xoQDJKIJFQ0sKZM1OF
	wiyRyBr0AmYu56yUj6flB+XxOS/bmQSxTftcr/yY6VJQMwIpyK9PGpH1cnOTGCwtCTWYohyUzhK
	8B3M35oxy2UutfJexXL3x4mwk37YB8SV64uoSqFteaJvKszsv4i
X-Google-Smtp-Source: AGHT+IExYrDYlOhD8PYRKprLU9YY3QN8ioiYkkgYmkU4MRe6GPcKn/K68YK+q8Ter9ncHammKU/9pdBLWTG2jk7Defg=
X-Received: by 2002:a2e:a375:0:b0:32b:4773:7aaf with SMTP id
 38308e7fff4ca-33256810b45mr14702521fa.35.1754290888567; Mon, 04 Aug 2025
 00:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607064444.4310-1-pranav.tyagi03@gmail.com>
 <87cybdp7to.ffs@tglx> <CAH4c4jLjSBxbd3bqkdgcCSWqXURratANgnbq9negrSU283xHpg@mail.gmail.com>
 <87frg3ss9s.ffs@tglx> <CAH4c4jKmj2gwmW2LS8CuGyw6phtiN+=_Bef8_pSEzjnbsqPOeg@mail.gmail.com>
 <87pldhioov.ffs@tglx>
In-Reply-To: <87pldhioov.ffs@tglx>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Mon, 4 Aug 2025 12:31:17 +0530
X-Gm-Features: Ac12FXx2e9gO-8pYyZoWXyN8mb9SRh0jyrBetN4eiD7KtRPHp3RGszi8f_aBmoE
Message-ID: <CAH4c4jJhB=P_bSwiqDb3d+AdT5QNv_qSgtKLZLNMDLJwVK-6hQ@mail.gmail.com>
Subject: Re: [PATCH] futex: don't leak robust_list pointer on exec race
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	linux-kernel@vger.kernel.org, jann@thejh.net, keescook@chromium.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 10:46=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Wed, Jul 30 2025 at 20:21, Pranav Tyagi wrote:
> > On Fri, Jun 13, 2025 at 6:38=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> > I face a small issue while refactoring the common code in a helper.
> >
> > The main obstacle to a full refactor is that the native and compat
> > syscalls use different user-visible types (size_t vs compat_size_t,
> > struct robust_list_head * vs compat_uptr_t). Because put_user() is
> > type-checked at compile-time, I can=E2=80=99t unify both into one funct=
ion
> > without either unsafe casting or weakening type safety (this is as far
> > as I understand).
> >
> > The best I can do is refactor the common task lookup/permission
> > logic into a helper, and leave ABI-specific put_user() calls in thin wr=
appers.
>
> These are two different SYSCALL() implementations, so they
> can deal with the difference sizes of put_user() there.
>
> Thanks,
>
>         tglx

Thanks for the suggestion, that clears things up.

Regards
Pranav Tyagi

