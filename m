Return-Path: <linux-kernel+bounces-757470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EEEB1C282
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B392189FDC4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A033A289340;
	Wed,  6 Aug 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kuKMWxgl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vwj/fp/7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1B288CAE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470504; cv=none; b=OU8N2kC8YZuS+oFUvTFYk+gITVVIyqwuI3wIBPxs/0pO2meCN98n0EqsBkQ9wYzArLD9V+i/2iZvgqJfr4YhhCjjFMcnMj/lc/XqR38/GBBT5THKqz9yxc4PTXpUMoQhpa2Te+Qv7CINak0KNw+HybjZFQEOp0a6naJMXoQzfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470504; c=relaxed/simple;
	bh=gVwPR3snMG5z9Mmx0I5Mldi9kbEf5Rnud0QzDzODnLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f/KoHjQcEzS6HgI0ctX+3uAH3xct+Lu0mAymu62mfh3R+Y3phyRMqvjXAXt8y8ZklS1RPDBpHw/8EFnBjeSCscVxq+TcXC1Gg4puwGI8BuE+q+T5QcH7WbW//sbldYI+9nsRqkXEikqVpXOj8Q/Suil+br3I9RRx5F0JPp2gj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kuKMWxgl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vwj/fp/7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754470500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2x/EJ2urZ6IAqF2Ig0DqZ3Dwxv6ZyE8NU8q2OJUYXuc=;
	b=kuKMWxglA0AS0jiiHS86UK/G6JTdOoVNTBJgFdgY/iNh3Xxf8qPEAAvxi0Ofzql7VuZXnK
	mDrs/i5dx0k6MAGgqyL4Jocu3KX+k/IXomayTh0w0paXgrXCi+Ph6zEm/113t0O1E+5mXJ
	nd7lcwipNPUyXe8uqNrrJOmV/FeVDWWd0X7BkETs55qf5jBerKYKmPcyqRMvI6eKklOaQD
	spY8Ld0+dL8U3N+EWwXITHgAx0F0FVc+VWO3hxS57bOdY3oh8L6tJDrGXTq3axq2kz7gQy
	WiJDe/XZCr/nAl+LgkReOwJlLZZaXZcAKXdgEI7J4vEneiwZNUVhUpqz114tVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754470500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2x/EJ2urZ6IAqF2Ig0DqZ3Dwxv6ZyE8NU8q2OJUYXuc=;
	b=vwj/fp/7gXXwh/41SxCFPtaXtDf7hRz08od3HmRmC7/+b7SAO4Kx2TxGWXCWPNBnhbj7PP
	R5VjX5WCDDIH8lCA==
To: Wake Liu <wakel@google.com>, Andy Lutomirski <luto@kernel.org>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, wakel@google.com
Subject: Re: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
In-Reply-To: <20250805162153.952693-1-wakel@google.com>
References: <20250805162153.952693-1-wakel@google.com>
Date: Wed, 06 Aug 2025 10:55:00 +0200
Message-ID: <87ikj0esnv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 06 2025 at 00:21, Wake Liu wrote:
> The constant NSEC_PER_SEC (1,000,000,000) is defined as a long literal.
> On 32-bit systems like arm32, where long is 32 bits, this value can
> overflow when used in 64-bit calculations.

How so? Where is the overflow exactly?

The only usage of NSEC_PER_SEC in the VDSO is:

# git grep NSEC_PER_SEC lib/vdso/
lib/vdso/gettimeofday.c:        ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);

and __iter_div_u64_rem() is an inline:

static __always_inline u32
__iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)

So how exactly is this causing an overflow?

Also by your description this would be a problem throughout the kernel.

Thanks,

        tglx



