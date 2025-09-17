Return-Path: <linux-kernel+bounces-821302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E50B80EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1031C814E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D0A2FC874;
	Wed, 17 Sep 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzJjqcZx"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA02F7ADB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125337; cv=none; b=GU9GbRf3ezcG/84eqsFcXNVPMJlogE5Z7gi56WP2HG8fXsd5vJ7rCmJfJtILJp9FnSUn/vIYhedXjnSNMBSeGLdZn0Szzg+iygD3uQmv+UQWqDajieOgT1vCPl2umzAR50NtmRJRoGiRzTJp8zB1ztF72JwqGiBUxKqy5EnWP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125337; c=relaxed/simple;
	bh=Kr3gqWKbVlIGwo9cD0/OQm+KVwsdtYQ0965Lj/PoWnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XU/ND14HU/0NHtK1FJ10cBBciVYRJo24IpUxT0DnK7R+nE9hKZ2J2Vl91muEc5IWOGBx4NGM40YLI8grbCP42D07Zd52JAurY6/SaU8Z/RjAbntrFptKjaBqXLXYullK5kGpNlXwPLwxrtirOFIzJ1XeSAgEnBWhmPvUGA5ScsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzJjqcZx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so9935353a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758125334; x=1758730134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr3gqWKbVlIGwo9cD0/OQm+KVwsdtYQ0965Lj/PoWnU=;
        b=VzJjqcZxYA3erzmSv1+Gm41JHdb95987L7OsKUf4tYF1aZ103ndDt9D2n9L5UX/iyR
         Oq+lWdgL7xoAzYV1HZHdv3y3WYgpPtHQnyQgcMW91V7NbXG3zabz0leuOrkPuMeta8WS
         uNs5Yyx16VjZ0llaa0UOxNekJGpvl7Ax1VNuJ5SGuLyyWQ74/XXoqW7d9YfGukfsM1NO
         5IBZh2au7giOwNwKvk0s0/GIbnYR4gA3hkaM26+h8jhSSQ98mZBPZl/fjjlJBNRHHqeo
         LkCTyEaGVppvMgv/fCRep0OPMWncQPxNVsv3cxn6iAEyDwP0qlywPjkGwVKJaTzjFW98
         4rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125334; x=1758730134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr3gqWKbVlIGwo9cD0/OQm+KVwsdtYQ0965Lj/PoWnU=;
        b=vSF9bUx9lCv0Wn/+hnWdqjYcmzyaLJvcdl+l4RbSu2fk2hhHgkayD3IgM//4ivAo+u
         K64UmAzXOunZHigLJdYsjkHfSlXKmrsRxCr1nclCTfL+6Z5An0GAPan6LOL90Jn1EQYU
         x3O7IodnHB7K5+0N9TRkfqSO93Y988I/P6DqHjzPucg4a7xA+KB7G1iRpEwDjNw8oKZf
         LtnfCzcKUjoY9lE63ZzbL+Y43tdCOYNF8n/RmsXdAY+xUcHp8GQFtF491i+5jFCA8Tg8
         +HseiAjdhOB/M4cUE4akbMlkBLHw1m6foqTsfPZROWsPRmcxjiSxwypQ9fhSAEj010GR
         yz+w==
X-Forwarded-Encrypted: i=1; AJvYcCXYAl6MFnrbckKtlpjNvBzNQL+YcpbPqD2OiMThrtpd1D9fWQ+xgsWFSlQzjORu+uAytTNFgpfcOkla5Og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9fTLYa1qnqNYzJieOVBwHxl76C+CqyKkJz+SdDqNoUlLV+vRI
	wKhAZZJkH8GZl19Bpi63GM64vVvqz4oxbjm1rCCqPMv+7Pp6mecfdbgTtDiuIpGk+TMvGSNqlMO
	ZMYRwhmERAjIOQRTbgZ/VNKjs2/Hgt1s=
X-Gm-Gg: ASbGncvM/gRu7yCZIhD9fjcLzTdonOAZt9vOGpmJ/ObopKL6Aa7et6KX6EGjZu65HcT
	Cn4p1tnO3U4LAApx3fuhPI2+8ogM3iBmf3XScz3hs/MZOpYELr80rYTX+ZB1yPBJxOVos8/hvXY
	guN+GzqPtnKAZUNMhdk+M+uoMsFfYEYPrXoSQdkXjg0F8jUPy894/mG3h4nEkDL4EJCghACiDQT
	WP4kwfOi4sgkTLVRIvoJauPm1V8onuYTembogY=
X-Google-Smtp-Source: AGHT+IFfkw3ZhHCyvQ/zqYdJnCid9nGZ71xvQ4q8PPdeMSagiSD+1jRHqhMt2JVe+mHbWhpBVrm4H+NXXW402BjcU/Q=
X-Received: by 2002:a05:6402:50c8:b0:62f:492d:57df with SMTP id
 4fb4d7f45d1cf-62f83e2ee50mr2738250a12.13.1758125333841; Wed, 17 Sep 2025
 09:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
In-Reply-To: <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 18:08:40 +0200
X-Gm-Features: AS18NWC1EPmJdyZY3bQd_3V_8f7tgIP7U6oPJlspQMEqezDw5kgn80teldh6eoI
Message-ID: <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Nam Cao <namcao@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Khazhismel Kumykov <khazhy@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:05=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Sep 17, 2025 at 3:41=E2=80=AFPM Nam Cao <namcao@linutronix.de> wr=
ote:
> > My question is whether the performance of epoll_wait() with zero
> > timeout is really that important that we have to complicate
> > things. If epoll_wait() with zero timeout is called repeatedly in a loo=
p
> > but there is no event, I'm sure there will be measurabled performance
> > drop. But sane user would just use timeout in that case.
> >
> > epoll's data is protected by a lock. Therefore I think the most
> > straightforward solution is just taking the lock before reading the
> > data.
> >
>
> I have no idea what the original use case is. I see the author of the
> patch is cc'ed, so hopefully they will answer.
>
> > Lockless is hard to get right and may cause hard-to-debug problems. So
> > unless this performance drop somehow bothers someone, I would prefer
> > "keep it simple, stupid".
> >
>
> Well epoll is known to suffer from lock contention, so I would like to
> think the lockless games were motivated by a real-world need, but I'm
> not going peruse the history to find out.
>
> I can agree the current state concerning ep_events_available() is
> avoidably error prone and something(tm) should be done. fwiw the
> refcount thing is almost free on amd64, I have no idea how this pans
> out on arm64.

erm, seqcount

