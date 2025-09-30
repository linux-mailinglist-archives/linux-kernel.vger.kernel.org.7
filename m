Return-Path: <linux-kernel+bounces-837688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DF7BACF3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CEA17BD37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D26E2F8BF1;
	Tue, 30 Sep 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kK0lApBs"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768524167A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237067; cv=none; b=B9Ndyerrq/QbNaymUnCkpZRXZHlZWCZBvsvwvTInxaAtYX0gEBOWOz/F8WAieROxksvOwqhi2yUORQlI/ron9ZragXSS4+Qmidx6iHHzJP4tRducwvgyWEJ0Kj/ZbQON6nhFvNR7F87vLT6NshnIzKdvssJP2Rx2I+2B7SxwI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237067; c=relaxed/simple;
	bh=kWzPIJSCPvZuJ5cTivFa/QO51QpD2ze2aD7rllOzFEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ixe5cD093vQdANZS83J7G9+XSrXewfOeK1EIuJLpN1YmWRmQFt7P/seorkMCeScOl4skZPX+9JbMifSaVqcBJZa7gJogrPOseoS5R0qLc1Dhjt6mJHxFUFFVgHr1iWjvMixhAmSvZdbJF2E2xK8Tp0E4L9KqRqCaRRPpjVfUU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kK0lApBs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 568414E40E50;
	Tue, 30 Sep 2025 12:57:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 100E1606E4;
	Tue, 30 Sep 2025 12:57:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EABD4102F17DB;
	Tue, 30 Sep 2025 14:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759237061; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nVa13gnqEbh0OZfVTb62Mape7gGdjtHA5pEICJOEZkQ=;
	b=kK0lApBsvgRTKrjnu2IL+FRxEyR7mnsh3RP0I7hz5/8rfbhRiS/M1SmGvCx98qkRn50S40
	DUuy6VU71VExjQDcGAojP8+opuH+Ak3vE7hk+5v7Ua5MzDtTQ9Y+P1E82gPRCP2QFiJWiv
	D23lVXQomE6b7XxqCYXDQT1snVJVZ6UpdrOS8YDH0D5kCPM6RMt21PyqGlpbt38Qm78oN2
	vKLpRgvc2AEBNZxk7Y7ls2cI3pLo0ue9PBGwgs1z3xAdPxKvAohA+FyomgAYUoi/YQrrts
	8qK0EOOPxIrYpGj3rjSXo9pFMyKBm4ndIRpT49dhsMT8Bn7Q0rgikBt90Dt3pg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,  Richard
 Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 resend] mtdchar: fix integer overflow in read/write
 ioctls
In-Reply-To: <aNvN4kfJ2ROB353Q@stanley.mountain> (Dan Carpenter's message of
	"Tue, 30 Sep 2025 15:32:34 +0300")
References: <aNvN4kfJ2ROB353Q@stanley.mountain>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 30 Sep 2025 14:57:19 +0200
Message-ID: <87qzvogksw.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Dan,

On 30/09/2025 at 15:32:34 +03, Dan Carpenter <dan.carpenter@linaro.org> wro=
te:

> The "req.start" and "req.len" variables are u64 values that come from the
> user at the start of the function.  We mask away the high 32 bits of
> "req.len" so that's capped at U32_MAX but the "req.start" variable can go
> up to U64_MAX which means that the addition can still integer overflow.
>
> Use check_add_overflow() to fix this bug.
>
> Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
> Fixes: 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE i=
octl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: fix the tags.
> RESEND: I sent this last year but it wasn't applied.
> https://lore.kernel.org/all/Z1ax3K3-zSJExPNV@stanley.mountain/

I don't know why, perhaps it got filtered as SPAM, I don't know, but I'm
sorry about that.

I've just "closed" next, so I'll queue this in a fixes PR on top of
v5.18-rc1.

Thanks,
Miqu=C3=A8l

