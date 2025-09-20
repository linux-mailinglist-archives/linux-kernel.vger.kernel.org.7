Return-Path: <linux-kernel+bounces-825721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8BCB8CA83
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D34B7B6DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85912FF666;
	Sat, 20 Sep 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBh26vfu"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5CC2FDC24
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379339; cv=none; b=ea5dml2TcowrBLvlZYy5yfalXrjFWoaRojKIGr5x5jJPnDZQaKw6Ytl+wEKAvaRMZ0UK7vGLhd5dymaAcbuSj5XbnAfzw7IKl+lC3qoF7qznlfaFLB9gYTE571BekNBitJ3CGHoB/AFOiIkj0iWShuZFUZ5gbOD1CmEi5hYG3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379339; c=relaxed/simple;
	bh=Usj+C0PegNI69LjXkoxW4n3D3nNnaTN61TPyqGGREUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elXCLVqEj83IeXvozUV3FOgrdSqFp63lFhei19D3st7k9jBUotGDeTEPsiYStNeaJH4oWb0PpllLPgMVTp6PwJsm9yZPDH5NPG10B6F2PiYFQiu5u6N/LdWV+y9p6p7ipkYXvxzWqIcVc64RFolIfj2HA82+9vl7PUhbN/02uOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBh26vfu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so958665f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758379335; x=1758984135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEtvZFtGHRjuP+b5JrK4y2e0Le4iom+VLjgkoz3MMAI=;
        b=WBh26vfuPt1v7nUePPcsFH84PRSWsZRe01lfn30cpMtrepsl71yLYCLV+se2DVfnD2
         3kBlNEAQdErnoHHlmWYchDCqpeV1WrNmDizsfWReIMYSvZL7NicvIsUtpw96i8jQZ7qE
         o/Y70ZGKrM0vCd/Hlud7M84kweUA3x6dfKG6m5FMD0AfL0rlzsYCTvDBKdDdVNnPyM0f
         fw0h+/iH9LxW3p51Qaot0+K5noDp5q28cuEvXVRDIUTRTMoS8VzAB3kP2KtkbfjN8ZvS
         g31UsestdnSZAKkIgHcIIsi/mufkmwcLqPzkdj9jIGG2ChKnfylNm9TksgHuIlIhelig
         pOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758379335; x=1758984135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEtvZFtGHRjuP+b5JrK4y2e0Le4iom+VLjgkoz3MMAI=;
        b=lTLvGAEH8u4nSFjAMgs2Gh2JRme7GJB6tlIXWL6rSuS9VXSEwYEsDCxA21RsmWI4vA
         ZaKjieNRHXYrIF8yVzyNovq9lUnIj9Qp82tPPkPQRTz4KbZJM/R2uWah1edaYGpKVTPZ
         QVOQeGdADNcc9lEwDekyksDctFzG9JmMj29JkDGtOHg+N5YXEj02cFC7N2aZ9tiKxLS+
         gKzqs8dBjcznDxZFkLEklzznA7JRloOrRORL/qvnkqsvF37H1G9si6A+638IN1JUiA9H
         Oto6Cre9aTM4LkUTYhs6Ej0M21t0Q9mg/9bW7IlvBclcdF1eVaCNh36wgNwWssqc1ry4
         NXpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlB8RxHJ/SFi639+qsRDJHOI/X3BWIJcKJCZUUEhFsjK2K36MLhTmOo5xzfY+ykCGR3T2tPAUGuYgT2p4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrp5WX86+N8ccsNvS8OWO1niqkyGuGy0Lg45QyBk5MlR2O044m
	02zBo4NUm/d6Cs86Y1qgTJAoka6cgw+sxzSp6H6Pca6Z2nu2MH50K9Jd
X-Gm-Gg: ASbGncvO8c2K0ix2JeAoIXvTT/HNa572rVfTy3Ovb7LMBbv6Xyr6ndtZBg7O8IQyoVe
	gO0g4xSHK0rz/CI5k9jylfCYKLm8i4IyHwdPOYUdq9kVCYGAVkc2kO6cd8pFwJ4lmT1aaCnGJAb
	RB2YZOSTHuQNiivkCUNduYCoaeP7M8plmdYhUKBCl+DIhNnKLEas1cYgzmnyrqJ0ze28XOkjoNS
	clmVF3HyHTdmWnaUdS+EVJYO+FCV7mD0PznIjkXHShwZ8rwLha5l9Ehs1J6bMWMd9fit8ZTmwWX
	lcdzWYGEr+WnXfoAc37R76CqMZbLwF6Tla5HVBEOCxjZT1a5y9nnRrnhMihGCJ+cKDBHpVBLjgh
	JTZBia2lnptj5YaujPdtN6w5+rDmUx7zCFMA+TN+AHBVh0PVi969cWLKZzHxS43J6qQ3YAT4=
X-Google-Smtp-Source: AGHT+IE1XfrrZKs7jUn/HCTxExNiug3StteTdhLU8bG47WeeJj4XJHY17xNSaGVA8TgcYBm5il8CoA==
X-Received: by 2002:adf:8bc5:0:b0:3f0:9bf0:a37b with SMTP id ffacd0b85a97d-3f09bf0a4afmr3138635f8f.43.1758379334535;
        Sat, 20 Sep 2025 07:42:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f6695a9dsm132985055e9.24.2025.09.20.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 07:42:14 -0700 (PDT)
Date: Sat, 20 Sep 2025 15:42:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, Khazhismel
 Kumykov <khazhy@google.com>, Willem de Bruijn <willemb@google.com>, Eric
 Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
Message-ID: <20250920154212.70138da8@pumpkin>
In-Reply-To: <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
References: <cover.1752824628.git.namcao@linutronix.de>
	<43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
	<aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
	<87zfat19i7.fsf@yellow.woof>
	<CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep 2025 18:05:45 +0200
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Wed, Sep 17, 2025 at 3:41=E2=80=AFPM Nam Cao <namcao@linutronix.de> wr=
ote:
> > My question is whether the performance of epoll_wait() with zero
> > timeout is really that important that we have to complicate
> > things. If epoll_wait() with zero timeout is called repeatedly in a loop
> > but there is no event, I'm sure there will be measurabled performance
> > drop. But sane user would just use timeout in that case.
> >
> > epoll's data is protected by a lock. Therefore I think the most
> > straightforward solution is just taking the lock before reading the
> > data.
> > =20
>=20
> I have no idea what the original use case is. I see the author of the
> patch is cc'ed, so hopefully they will answer.
>=20
> > Lockless is hard to get right and may cause hard-to-debug problems. So
> > unless this performance drop somehow bothers someone, I would prefer
> > "keep it simple, stupid".
> > =20
>=20
> Well epoll is known to suffer from lock contention, so I would like to
> think the lockless games were motivated by a real-world need, but I'm
> not going peruse the history to find out.
>=20
> I can agree the current state concerning ep_events_available() is
> avoidably error prone and something(tm) should be done. fwiw the
> refcount thing is almost free on amd64, I have no idea how this pans
> out on arm64.

Atomic operations are anything but free....
They are likely to be a similar cost to an uncontested spinlock entry.

	David


