Return-Path: <linux-kernel+bounces-772502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA17DB29372
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25294E16A1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED32E266D;
	Sun, 17 Aug 2025 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bsc/ynqH"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49398770FE
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755440953; cv=none; b=JUC0GA7B0+EMMZGgL6Or8qVTR4mTRvFNPtpudrIkiev44CK8lvfpUHtGSnBGEc+PF6ubEvt5Bbc5FvE41wcRtUWYZGoWMaFDlgYtLszbHJTNGZ5U0Z03mL8sOAGspC/wXXx6tdHBLAFIS7MJlldRPSkXn43o01UpW2xjyj+4iIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755440953; c=relaxed/simple;
	bh=28n8CxDuDki+Z2+FJdVcetGs5D37Nu2X6SQ0exxsq6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/qVPPAJDpQ3SMT2DRbfNRnUDBSKgoYDA7Vylu1osKZ2jPANKlJ2N+XyN4BeTbIYqOBUf/4pubzMpjvvZXxYnhX+iP7FeqjMW4JdR/tQnTzw7wI5HVesUJEk/Wt8IhcATAUUFz7NjXsm2mgQIkEiAzQHSzy4EflPRUHQlmUVGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bsc/ynqH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b916fda762so2058224f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755440951; x=1756045751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6yEu2AlLzkFYZiSQt2WaNR52waq6ZeZHTHYBBDv5k4=;
        b=Bsc/ynqHm6skxjBG7mqeISdYmye7r9qAafJzdJDsdswJIF5lOGNGSJwxUXB2WAO1vi
         3ZXZ0FbnCwzhmOPfkv0HBx/MYDNuUpABsnqfGB9vXjWytf0mgFcygNHVMmi7ot3AfYQL
         zOK00hqBPsErQZ2foCMitCRQqYAq1V7w1vDVraeyXKGBnSkSlgE/ZhqRfZaaG/oqMkZ2
         07GUdvSH3sOMuUI6SoMVJmAaMYLb0M2WQ4tBIz5ezHxVuo7SdxrJ/jP1Txq0PGgF9TD7
         KSjcTo0bzHqHtHkkpopOW2CkeIvaYFdKIvk7iXMGUBODUFIBoNnFVZtYejGMaxZUxmQy
         GNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755440951; x=1756045751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6yEu2AlLzkFYZiSQt2WaNR52waq6ZeZHTHYBBDv5k4=;
        b=YzsOkvAUFaGn2tu+KNh9G6l8LlP0YvlLDxy/fZyX+y4cdMfhfJ/4xBuyny/hMdd6pk
         fIS9VxiduEnVuEgaMDqrw3TiCn19jDHl/Ja1VwAI3TwFPTywf1O/ycQsh9edEK16H/ha
         1AVlG0zQ6avaBnr5cNrl1IFRcFvjxRujUjXDz7BbCyZv5XwVmKrmMQZYEQOqJKGSYatm
         JoOFgppLvgqAh/K7njcYguBPWkDKwk283JXYXvaZuBZ5abSpvAxTGHDFgpegf2Ka1nxN
         dENBu1A6ztXIlqTUEoz9QXJ7hPjlwVvDJ5IhzRJo2d64c6ZQ7BD/N6U+Unv5UTVV67P9
         FroQ==
X-Forwarded-Encrypted: i=1; AJvYcCWttuPpppq1c0HmDmG01FZ3eR0SiRUBlZaDediUmXCeWsklJceiYiBesFzjgXccOxGJSr/T2HyiNU4oMHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd7tB2CIzQHopYsEADCyke2pnhr6pKtFkL4WrAzxOLXbzSItf8
	0bOYz98zISJ/6J5+SsaJQO+FahdHa6k7bG6q3zEMsrpNd4FacHbdjVoT
X-Gm-Gg: ASbGncuOwG/ViLUO6hpQd/693pjjjR9ctNwY6vE1akulrZUaoOjITrSrKFSOBgPpEXV
	bNDkUvWmgUSGpS3M0DkdOZy7fz2mSX+D1Uudk8Bxba+K7n+kVKRMXM87hp+YdoVBU8MqxEuJmUU
	kXKcUpApX4T0TGQiUGAanzykRLLHAJqQc3sJRjTe373C9Qr85sLotsCQlxdT9iVsVdIyl/sxHTW
	U+gSFxccFz600ndnaGpVhki67DboBbKqpoHZGmiQxhqdY/l8/zkzb2JbxP+AJWLwDyYN5HMtVgV
	7dMoI4Fff1yedGr/kC6qPjmHlE4mL6BMugN7kmyPboPEkqW5Q7lJC6qDhyvr9fhnkDiz9G+BVQ3
	EhY2TGxY6bv666QiTKHQWRMssq35hMDfqgvp/rJTp3pQdehdx3bCUmJOkTlzI
X-Google-Smtp-Source: AGHT+IETKpBYTg/qI7JrrvClWxZ1BBfG1mxEtTNoRR0a+tiu3C2/+FWEGyA6Cb4IoghUZrX3OhMxhw==
X-Received: by 2002:a5d:64cb:0:b0:3b7:8aa2:9fcb with SMTP id ffacd0b85a97d-3ba508ebe8fmr9326231f8f.14.1755440950520;
        Sun, 17 Aug 2025 07:29:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758561sm9579067f8f.11.2025.08.17.07.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 07:29:10 -0700 (PDT)
Date: Sun, 17 Aug 2025 15:29:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, mingo@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, joshdon@google.com,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] sched: add ability to throttle sched_yield()
 calls to reduce contention
Message-ID: <20250817152909.45567727@pumpkin>
In-Reply-To: <20250814145308.GB4067720@noisy.programming.kicks-ass.net>
References: <20250808200250.2016584-1-jpiecuch@google.com>
	<20250811083609.GB1613200@noisy.programming.kicks-ass.net>
	<CABCx4RDTq6x5=dqiROM6GYU21heaCYwOkerUxvf9ENaEM3+BtQ@mail.gmail.com>
	<20250814145308.GB4067720@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025 16:53:08 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Aug 11, 2025 at 03:35:35PM +0200, Kuba Piecuch wrote:
> > On Mon, Aug 11, 2025 at 10:36=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote: =20
...
> > The code calling sched_yield() was in the wait loop for a spinlock. It
> > would repeatedly yield until the compare-and-swap instruction succeeded
> > in acquiring the lock. This code runs in the SIGPROF handler. =20
>=20
> Well, then don't do that... userspace spinlocks are terrible, and
> bashing yield like that isn't helpful either.

All it takes is the kernel to take a hardware interrupt while your
'spin lock' is held and any other thread trying to acquire the
lock will sit at 100% cpu until all the interrupt work finishes.
A typical ethernet interrupt will schedule more work from a softint
context, with non-threaded napi you have to wait for that to finish.
That can all take milliseconds.

The same is true for a futex based lock - but at least the waiting
threads sleep.

Pretty much the only solution it to replace the userspace locks with
atomic operations (and hope the atomics make progress).

I'm pretty sure it only makes sense to have spin locks that disable
interrupts.

	David

