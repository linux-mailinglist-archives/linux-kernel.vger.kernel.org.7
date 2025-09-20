Return-Path: <linux-kernel+bounces-825723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703FB8CA9E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CB0568095
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A01A2C0B;
	Sat, 20 Sep 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgbfwepd"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105F1E89C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379552; cv=none; b=rB05SykrSrtOWNMcTq0cE2u4bZ3d11pFKbJkUEhZk5OGuN/ddaFextYG8jPXXy06FyL2Nppv8C5IN+Wbc7RJyibm8756rrHglWXC+e58ZWcz+Miqa47d3+nB7IfN9BKy/LfynHbGKfLAyr1TZSWRB6oBmJpWKC8I0aGF0lofnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379552; c=relaxed/simple;
	bh=prBMWFMAjr7chjhq3P8rvyzynNtcsazQYroaTwzNLjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HamZvEkWycI91OPskK4WRCVyXQHa4o7EfIaPvauq2ddCiIDBGGPf4QYwYGSXPITwPPA1bF4O5Ig0Lt3jvpAFU9PGbxztmRHFFbpCnvE/k8KDSEZXBjZdPjrcBIUk+xCPiADPZmE/rFs8s3odJmaY5AZG/eQCHoxQmtte+k5mH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgbfwepd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fce8b75a3so2444392a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758379549; x=1758984349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prBMWFMAjr7chjhq3P8rvyzynNtcsazQYroaTwzNLjk=;
        b=CgbfwepdIvIdG+kIvTHvZ3bhrU15DZeNDymrei7KGLcOTrunR1M1LSsArcR74N5qmN
         GSBJdQxqjxaPXKQiH8iO7CMrm9Yrp0jZAP99ptp7a9aG+3P/j0kcK9RCv5ebLmr6kjvL
         DkKjABbATudAZo8FNzhqOqvzTfezcUzooJ+2eAo/BhpYWw/OHgy/lqBEM6Ec77s0vlmY
         hOF+FU1Bb/ZJdUlyUgv5rijGV5dHoS2RU/UP7bkeve1BhaRyntJ6ttuYsAQp89mNSUSg
         Uyu2Q3s5ltbzR6Rf4EH1XitBCnRb2t3chjsOt8LxshlC6gHSy0RTn5/vgdjZ2+y8miZQ
         8Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758379549; x=1758984349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prBMWFMAjr7chjhq3P8rvyzynNtcsazQYroaTwzNLjk=;
        b=d9Fq4Bh59kUtsnEJHjywTr0PsAGpVKeATyv0C6RxMKpcOoA74aCcnFMvIcCv00lJiP
         jFT5N9CTg98v7VbhgsZ88D3X1NENNud503ZqSfH+2axfJ7i0tL3b8iNOXQ9lPkesJncw
         5dZlTAdQ71b9+v4NWPalD3Ltr8brXMM60lgbKWjMWlZIz1NFzWnQJuvW6yvGeMrX10ap
         KIiPZxHhaC+sagTbpH6k5jhKwskEdNGChQ67DjPX6xO/DJ43fdh0Z34Fii7EQlQAtxfK
         Pdja01wdVTEm/+ZlecoP6OVoCPb4xgO5BjfpZWOJuA+bRLTGXzwABzBP+6CT7wihkqHy
         Dr0g==
X-Forwarded-Encrypted: i=1; AJvYcCUDQ6CMJeHQKMIBkCo++P+UMcIM4y39hP38n4qT0Es6JIOzFT46mMnL0uVt5ZRWzdeNGzjX/p5xUhlrxVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyijEDGDrXbNVF3C1/i4yr2jdz0dShPRpur4F4hUz9AYFTB7u8O
	UTNM/NYh5/4uTopQ3MVWBohtXhy/HAUJBTJsQCsENrSUvFMhUFkbV4GWN79Iqfm/GY8L8OtAu+2
	C7oR5T3RSR0ylYMGCpB9OvQs3KZzPAs0=
X-Gm-Gg: ASbGncsmQyi2jcDUfdE65FYdCmSiSnMckDJFk6OcPK3hTUEFfv4XLnm+7Agqw26yvai
	wa/2xrm7hkFX3+9WvoCwxDyusjYZfv/AsQD+0tkUh67TzW1XOP5eb9jwhM6vKd1710q2nj3UBGr
	BUmvgnZU2kE3M/hIEQtzlbhPmEIEDBxI80gzzTdkQDg+u6s6yx7DUVYPXIdy3+LZEB0fDDrRGgO
	RoeuvKR4Moyv3V+yujB0DedNh+uYbG3sMi03A==
X-Google-Smtp-Source: AGHT+IHprf6sIuf8mcq+DmIUBFqEQvSlyTeJhORDOjRBm1D3ME0hm3yswxncK13S9OfrbZrNkgv0Ra//B/ErT5QPBuA=
X-Received: by 2002:a05:6402:3488:b0:62f:464a:58d8 with SMTP id
 4fb4d7f45d1cf-62fc090a920mr5609831a12.3.1758379548473; Sat, 20 Sep 2025
 07:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <20250920154212.70138da8@pumpkin>
In-Reply-To: <20250920154212.70138da8@pumpkin>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 20 Sep 2025 16:45:36 +0200
X-Gm-Features: AS18NWB9O-d4JEBCOZIFX72GOz0-xwuKTumjYGdgLUXXtHzgyf5FekADp6hUP4M
Message-ID: <CAGudoHG9hTwSoordwbMDci5CmnCKMhD330Z0BKfNJ+xUHYC9uA@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: David Laight <david.laight.linux@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Khazhismel Kumykov <khazhy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 4:42=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 17 Sep 2025 18:05:45 +0200
> Mateusz Guzik <mjguzik@gmail.com> wrote:
> > I can agree the current state concerning ep_events_available() is
> > avoidably error prone and something(tm) should be done. fwiw the
> > refcount thing is almost free on amd64, I have no idea how this pans
> > out on arm64.
>
> Atomic operations are anything but free....
> They are likely to be a similar cost to an uncontested spinlock entry.
>

In this context it was supposed to be s/refcount/seqcount/ and on
amd64 that's loading the same var twice + a branch for the read thing.
Not *free* but not in the same galaxy comped to acquiring a spinlock
(even assuming it is uncontested).

