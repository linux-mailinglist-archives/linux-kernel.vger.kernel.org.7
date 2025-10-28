Return-Path: <linux-kernel+bounces-874835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21DDC17322
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E021B26095
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F573570A3;
	Tue, 28 Oct 2025 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8oXu/T6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38F3563CE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690657; cv=none; b=ozVHhxJ0F3BwdGGogkPojwF/yNNjT7BK7xYEfZ1kZ3MXXqFRrrDwYucc3KQTqRIBKcWPGKS3U4pUCslu6LP8bkvoBhM5rW7MZyXT+xJvlv057mkbdWPO4V36XwSK73OnRQvUEQ3KxwyB1+Mn0UNcnmxzHsAjaUPFGxms5kEqnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690657; c=relaxed/simple;
	bh=sx9Mpldj6UmZjYtPI1GsMsto99Ag0oVxN4vN/BoY9V0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOc6M3W+XZiMCKYL5AEoibMVIrudt9W3Tbi+l93McQMcBHMO/Wmh4ZYDq4776xyFfJOmfrLsmTqiZZxybYCMBl8g/25dZ8pkoQ2BbE/bx5JOKBucKc/EtdmYgPfC+XlOej76swi+A4bQ7fzJGgqeGIIXJLpNjUQIFl9UCmBiGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8oXu/T6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso51755355e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761690653; x=1762295453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7MYXT8RdCoSxz7Hgl9+a32CaifYT+zfGLvjG0fFD9Q=;
        b=L8oXu/T6u7zqeivM9gSd3PzbKHH9yassNHcZjNQXt0iPKbqcWlX2cKkBCxf2X+lmTc
         H8pkfao+lXt7DfZ26OryPI/aJHcV2/lGSNBKI/r/iN93D/u0IZmqZrvNz3GFEeaLXXVn
         W8bZhE8nMdOlgtddvk/1rYo74vM1mOxicJ2mHYH4tpUdyYgdVlxNb8rRk5u35BEF75ju
         5nSlwBlTje+nXw8et4e3YpO0FuLFkxvCb7/lc5ezVVVmif9RbtsSg0enjqyrsqmE+4aU
         JUDQeY8Qj25gyHNZiMdKbDkUsI7naoNx+7OFTtS6Br4MOm0yd/O8rSnsFKtpntTwQrTx
         3i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761690653; x=1762295453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7MYXT8RdCoSxz7Hgl9+a32CaifYT+zfGLvjG0fFD9Q=;
        b=KAPXPR+0iTeLG6vfLpk46u4XkQ8pl7WGQszkHRebZ8HftHOQ/kDk/OF0sTYdmmhQzb
         ZZUsgcOp4hZFNeCcZ6XFgvZ6tNs7/Aubg8mXh5GTncjqF7wHCoR2i0mJsDspb+KQit9U
         62nrhIuaaQzWVGcXq+ZQciGgYBnWnZTsDCRw4myaqOgoiKnWXixtq41nReQ6qDpCKsjt
         esXSpT+7lkvQnS9s+iKNNj0t0lVqU3w/esT76ejq76dbNs9EEu8vBbcIOjlQUOwBm+8m
         3WPdB+zhgmD39wYUb+J6xDyM4zo/knasq9QzsJq6DNSVt5LJ7ekDKc0qLS3sa7JB2JmZ
         H6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoXqFlWvoqU5g+oDGQxVLtRmfRhM/W9IsX0KtTr09mui9iWaT0Lc/U79S2UJhhDSaq7h7QSPTY9XW19Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIu9AocncFf1I5D+AK+LkA8cFUi3XzcUQbQP97ZgDGpeALySG
	smoOy6bPEAj8JW0QbIu3gW4GIvHz9vhGsY8aWAB8JiEeDP5HeBL0+1/8
X-Gm-Gg: ASbGncsqxKfdfLilzJZ/8iMC5gJTMA80+67tkoOJ7dUaZlL4s9/F9mhclZG9kakof60
	ySTc9mAqCfiAhOyQieibJGo5gA9dFNAvcbrOlJN/bjqLpxJsaRXq/zMM1lOfinlND/7pnmr1IY2
	AeyySvVC9swDveXtuwfPPWHm+k0vy3gKEapILJ8Y/0OJ4TUSKoBdKG4qfYG4FOV2MIdC3wAIC88
	oeT7L1pzM+l6I4KUAoVa3AEM9DUKvei4HYMut85iRhdGacuT1015kLXeSiHVr1F15JYAOYbQCpV
	VR/dtBSYkeGIgShezKCf7X5WHRShqcF74wXD3e2R5geRL4fE63jFjUsrIIqnkKa4qFXihURIXAM
	IAOndZZCjqAagbbFXae3wkG7SnqrgBvJYlNdT3JJC1nVo+UJAB9Poxym+NQf1MKMya5l1igzp02
	Sm8y8AVxNJSDZywOgJ3natHPwimn8vB2KLeWTgRWxcYNH6mMWswhVg
X-Google-Smtp-Source: AGHT+IGr3MaQmjLDcnechwHoyti0ltwYCF5fdXDSzbiJBdxMc2AUsas+y5bOu1/39BNyQHtZcenqXg==
X-Received: by 2002:a05:600c:474f:b0:477:df3:1453 with SMTP id 5b1f17b1804b1-4771e1ed170mr10187095e9.28.1761690652951;
        Tue, 28 Oct 2025 15:30:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3b7cb9sm16032815e9.15.2025.10.28.15.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 15:30:52 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:30:50 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dave.hansen@intel.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
 axboe@kernel.dk, bp@alien8.de, brauner@kernel.org, catalin.marinas@arm.com,
 christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
 edumazet@google.com, hpa@zytor.com, kuni1840@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mingo@redhat.com, mpe@ellerman.id.au,
 npiggin@gmail.com, palmer@dabbelt.com, pjw@kernel.org, tglx@linutronix.de,
 torvalds@linux-foundation.org, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 2/2] epoll: Use __user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
Message-ID: <20251028223050.3e3ce110@pumpkin>
In-Reply-To: <CAAVpQUARk-XeMdTeGy_s65sdwuLY2RzocGyJ=2_WkhsrFN-bUw@mail.gmail.com>
References: <ea7552f1-842c-4bb8-b19e-0410bf18c305@intel.com>
	<20251028053330.2391078-1-kuniyu@google.com>
	<20251028095407.2bb53f85@pumpkin>
	<CAAVpQUARk-XeMdTeGy_s65sdwuLY2RzocGyJ=2_WkhsrFN-bUw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 09:42:25 -0700
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> On Tue, Oct 28, 2025 at 2:54=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 28 Oct 2025 05:32:13 +0000
> > Kuniyuki Iwashima <kuniyu@google.com> wrote:
> >
> > .... =20
> > > I rebased on 19ab0a22efbd and tested 4 versions on
> > > AMD EPYC 7B12 machine: =20
> >
> > That is zen5 which I believe has much faster clac/stac than anything el=
se.
> > (It might also have a faster lfence - not sure.) =20
>=20
> This is the Zen 2 platform, so probably the stac/clac cost will be
> more expensive than you expect on Zen 5.

I must has looked the cpu type incorrectly.
AMD haven't made it easy working out the cpu architecture.
I need to get an older zen cpu for my set of test systems
(and some newer Intel ones).

> > Getting a 3% change for that diff also seems unlikely.
> > Even if you halved the execution time of that code the system would have
> > to be spending 6% of the time in that loop.
> > Even your original post only shows 1% in ep_try_send_events().

I realised after that you might be showing a 3% change in that 1%.
>=20
> We saw a similar improvement on the same platform by
> 1fb0e471611d ("net: remove one stac/clac pair from
> move_addr_to_user()").

Certainly removing one could easily be measurable.

	David



