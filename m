Return-Path: <linux-kernel+bounces-767510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8089EB25575
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2BA1888E65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A22F0687;
	Wed, 13 Aug 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2EiHoy+e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ye8gXaPH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DF309DC2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120622; cv=none; b=aUXcRuMfhlm6fukhK6T1+wSpYus60S5Pm3Z2yrEb1GnJUVjmNdiuug39GPVIuWhISPb6N+9jnIScuzrYxiyojHc90uMkAE+AeAgLWxyRUibpZGOD96eqhGG3l72MQbfkaSZau2LQw8it9JgNX72/bO7kWunY59Yxv1LGpcxNHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120622; c=relaxed/simple;
	bh=Ctf9eUSxBiMCuggxSGcFxFo/Py5ILZKPD9Hvr3/Hveg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OohVYyKlHc0boGZH4oLeFYFP39HChdHxloSjO6a0pk/O2x1yzYM6+V+W3GJsm1kVY47KBSoQs2oXUBEhdnt3diGy4jCGnErpP4MO/cxFflvhoF7fjoSHiNxW55/7JxxRuSoec75asOZN/oF6mdiMV95hHDIf+Hew+ROHFkuVw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2EiHoy+e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ye8gXaPH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755120619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpGLITjvn1bXL/+EJIR6RdgTJ6vOihJDdipYVnZHlhA=;
	b=2EiHoy+emMjXnysrYyBBvbXYD1nuSHf6rBXgc3qHmdb4QbHy0hc7YKY0F1JUSDA/yuDi0q
	HcWVX6jNYxrqVVvrrLRZJ73f5kuUg8RsyQasXsM9VyEq1ezYZ8B4JbRdNvmgJIVYjr9cRF
	1gSmN2zOQzBhSh6kyCdKszH/lg0xkqElYqSCo7GlkOi7LXhHlzehxA69+52p7zjGkWvyUP
	4xN+6RCj8d8/l6xkwKlEDPDEwhTpckzy0ZCzUd/b2u66jrgjyT4APMLinRxC2GcY4KCnbr
	0cQpi1Vv0XFcXSpjus5dcz9eGW1PQyUYD3ZpAqwKYIgwr+Mbw8JiMwJBROuOJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755120619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpGLITjvn1bXL/+EJIR6RdgTJ6vOihJDdipYVnZHlhA=;
	b=Ye8gXaPHMBzHS/ptRtLYKiY1dcJJlV+SNbw+poID1la3MAMl15sdsWc6jlv+WnRs1ETMmM
	T2uZXNJJFuPZPeAw==
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>, Peter Zijlstra <peterz@infradead.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Wei Liu
 <wei.liu@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [patch 07/11] entry: Cleanup header
In-Reply-To: <CAE7dp2pxxKWdNJkwZZDw2GmR6vH8YVMGcTm55u1pxVygaeNydw@mail.gmail.com>
References: <20250813155941.014821755@linutronix.de>
 <20250813162824.228728594@linutronix.de>
 <CAE7dp2pxxKWdNJkwZZDw2GmR6vH8YVMGcTm55u1pxVygaeNydw@mail.gmail.com>
Date: Wed, 13 Aug 2025 23:30:18 +0200
Message-ID: <87ecte7vv9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13 2025 at 21:09, Giorgi Tchankvetadze wrote:

Please do not top-post and reply inline so there is context:

       https://people.kernel.org/tglx/notes-about-netiquette

> Typo in kernel-doc:
> In irq-entry-common.h the doc line reads Pointer to currents pt_regs =E2=
=80=94
> should be Pointer to current's pt_regs (or Pointer to current->pt_regs
> depending on local style).

Good point.

>  Stray blank/trailing whitespace:
> In entry-common.h there is an extra blank line inserted after the
> ARCH_SYSCALL_WORK_ENTER) macro continuation =E2=80=94 remove the stray bl=
ank
> to avoid style/noise.

No.

>> @@ -37,6 +37,7 @@
>>                                  SYSCALL_WORK_SYSCALL_AUDIT |           \
>>                                  SYSCALL_WORK_SYSCALL_USER_DISPATCH |   \
>>                                  ARCH_SYSCALL_WORK_ENTER)

There is no continuation of the SYSCALL_WORK_ENTER macro.

>> +

And this is an empty new line to visually seperate SYSCALL_WORK_ENTER
from SYSCALL_WORK_EXIT.

>>  #define SYSCALL_WORK_EXIT      (SYSCALL_WORK_SYSCALL_TRACEPOINT |      \

No?

Thanks,

        tglx

