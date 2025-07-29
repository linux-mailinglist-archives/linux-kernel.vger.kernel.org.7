Return-Path: <linux-kernel+bounces-749908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD108B1549B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78473AF9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6EA2561C5;
	Tue, 29 Jul 2025 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LOQuYbzM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ZNr0A9N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6B1A23B1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823866; cv=none; b=Dunwg+kHUTYZyG020k3WEkWhS6Oxvsmt9Vfs22Ni6bgHx2QOVInBYYsgXVaCac3Dk1Dx+1xLarbYp/GyqqBA/iXTDFG/tGphmRnQlqJKfYYdWWrACAU3s21h6izq7TvgDpLFWKm3LS2fzZD7lLQmh+jFNkbPyvbcrCMYEFvnOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823866; c=relaxed/simple;
	bh=im4zcgUfpSPq2ELFn2mVEfTTsSNRnAzpBvs7yc2Zxm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2mvAv19orhtFEBMeNaHIeVCUk5ajFiZkaNVNaQHsiNdD3LUWRRT4TLmnJ3KphAMtbGQHLtENTXmRdb8ryuzBJyrviH3S8s79ZthQHPK8xN6LZbhwe5Sv91RA/qBN/ZadWggHJ9J0d2ugucIo/WCbv0EXhrPMnXT+88NiOYZnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LOQuYbzM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7ZNr0A9N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753823862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5hkoU4bTkfvIy0vP97V2ilntrsjj5Vy72aNaQmKN9o=;
	b=LOQuYbzMQ0EAS03JkYFeR/B5Q+AaK13a/D03cUHvhFibt9ljm/49B6zavZRGU0pZrQUx7m
	5kq3L1X69OOUjndXzKTzH1rJsB3MxRZhyyu5Z8H4s1bFOXe4HKTP6q9Mqw8aTyg8EGnDFV
	5aIrN2kIDZ5m6bi8eBVTuzbYWzqme60/3AuI+DCDQQwAAwQBXas6BY2RcoeFPagX5/3TOr
	4qE6ScCl0GU71x+TD5Wd2hWyPP98zZZ3CnymzTufWvsWEady9JZYXEShVjapNIAMGicnTa
	EWD3utoB8TWxDWoSjM0GsJ88c9DWubKweOAaqOCXL0JKMZRifoyukSIEWmDc+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753823862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5hkoU4bTkfvIy0vP97V2ilntrsjj5Vy72aNaQmKN9o=;
	b=7ZNr0A9N5GbWlFkCpGP4zKMKbFLxZG6XOwuwL9/gdGLLpriFoS395oN8m6dkIxMxZDmAzR
	kEwTJSQTxVIffyBQ==
To: syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com, x86@kernel.org, Kees Cook
 <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [syzbot] upstream build error (23)
In-Reply-To: <87cy9ikcwh.ffs@tglx>
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>
 <87cy9ikcwh.ffs@tglx>
Date: Tue, 29 Jul 2025 23:17:41 +0200
Message-ID: <874iuuk87e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 21:36, Thomas Gleixner wrote:
> On Tue, Jul 29 2025 at 06:43, syzbot wrote:
> and to keep the call for efi_init() as a symbol for the linker to
> resolve, which obviously fails.
>
> If I change the efi_enabled() stub to __always_inline, it's optimized
> out.

Kees has addressed similar problems in:

8245d47cfaba ("x86: Handle KCOV __init vs inline mismatches")
65c430906eff ("arm64: Handle KCOV __init vs inline mismatches")
c64d6be1a6f8 ("s390: Handle KCOV __init vs inline mismatches")
2424fe1cac4f ("arm: Handle KCOV __init vs inline mismatches")
d01daf9d95c9 ("mips: Handle KCOV __init vs inline mismatch")

> Disabling CONFIG_KCOV_INSTRUMENT_ALL makes it go away. So GCC confuses
> the optimizer when CONFIG_KCOV_INSTRUMENT_ALL is on.

Seems to be GCC 12 specific. GCC13 does not have that problem.

> The kernel is full of such inline (not __always_inline) stub
> conditionals which evaluate to a constant....

And chasing all those stubs and convert them to __always_inline seems to
be a whack-a-mole game.

Can we just stop pretending that GCC12 is KCOV capable?

Thanks,

        tglx



