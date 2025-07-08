Return-Path: <linux-kernel+bounces-720966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA41CAFC2AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904861897978
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36C822129B;
	Tue,  8 Jul 2025 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3tUKK4Kr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hX7b3+5b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43642206BC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956013; cv=none; b=kTKY5+V0rSp4taMA9lZoZQJ8FzzMwG/unCCV66myZfiqk2xjsbJb61i6yCEv3YcPZu/Afnqtt/CbsHFtRBa47DVmE58VDuGoZNC3AACqNKKY8Av9eC0Jun42gKLll3NEavyTUnxbxJ7K222vr2SFE0SkVfpSZz+QYw9GEu57M4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956013; c=relaxed/simple;
	bh=yeYiajsrvBZAmEBc35J9Mdx73N8RHuD0K0mwaaZMLM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfL3Nw1M6Bz6PXozFhrl2j5VK2msJYU7N9jHvWxS9WMIkaoaH6VsjUAFWRKOWvFbIqWhi4Qkf2X5spuZIrnhfHhWF2wc3FD+d1ScwxRgBnYwJPgSzdv/6+X9hgh+TnTeCMjffDbzmD90E7zDhBEDPZXKlnqfyjUeSXlisEzmTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3tUKK4Kr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hX7b3+5b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 08:26:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751956010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+0zItmWiOyNxBldmRMVwedkjxiLinvf/NtrbP1zg+E=;
	b=3tUKK4KrWq6TIkjcRSPgNem1HxFr9XXO1ZmnXm8uLVfp5rJcgZssiGpg/zYcHe2BBd7iC3
	0/3Q3ltiuoXR2960Q8BD7NV2VBIodtPG+rq8z1Ppoj/tvChkzgJXytEpGi83OBPN6U9yPS
	xnx2KbbPLtwdRowxifq8jbMGwvj1CPfJPPW7chuZiO3qvzwIp2mH1nDR8hmey5T9qp9iYI
	Hx5o0TK1eF+yesGb+hI/v+PGtraCrQ3Rz+5zY4IlZRLmdTR2cZBTshm5qClRuLbddwCQFs
	qAhx1l9V5drtJchIFHRCbHaFyGa0i+xNQHJvYdbL+bKviEy3SntVf2U57SW/Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751956010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+0zItmWiOyNxBldmRMVwedkjxiLinvf/NtrbP1zg+E=;
	b=hX7b3+5bJQAy8wlml8diuWxaHQsvVsIxqvOwKnrNDjUx4bq3bX5/tLkshMUeaN6wWDBhz2
	FT/MNmjNUw4QGjDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Yury Norov <yury.norov@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uapi: bitops: use UAPI-safe variant of BITS_PER_LONG
 again (2)
Message-ID: <20250708082027-acf3e21a-8627-4cbe-9ccb-6d872eec2918@linutronix.de>
References: <20250630-uapi-genmask-v1-1-eb0ad956a83e@linutronix.de>
 <aGKkw6b1QPTf9yii@yury>
 <aGRVJHZF36KGVs4c@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGRVJHZF36KGVs4c@yury>

On Tue, Jul 01, 2025 at 05:37:40PM -0400, Yury Norov wrote:
> On Mon, Jun 30, 2025 at 10:52:54AM -0400, Yury Norov wrote:
> > On Mon, Jun 30, 2025 at 03:02:18PM +0200, Thomas Weiﬂschuh wrote:
> > > BITS_PER_LONG does not exist in UAPI headers, so can't be used by the UAPI
> > > __GENMASK(). Instead __BITS_PER_LONG needs to be used.
> > > 
> > > When __GENMASK() was introduced in commit 3c7a8e190bc5 ("uapi: introduce uapi-friendly macros for GENMASK"),
> > > the code was fine. A broken revert in 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
> > > introduced the incorrect usage of BITS_PER_LONG.
> > > That was fixed in commit 11fcf368506d ("uapi: bitops: use UAPI-safe variant of BITS_PER_LONG again").
> > > But a broken sync of the kernel headers with the tools/ headers in
> > > commit fc92099902fb ("tools headers: Synchronize linux/bits.h with the kernel sources")
> > > undid the fix.
> > > 
> > > Reapply the fix and while at it also fix the tools header.
> > > 
> > > Fixes: fc92099902fb ("tools headers: Synchronize linux/bits.h with the kernel sources")
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > 
> > Arnaldo, do you want to move it yourself or with my branch?
> 
> OK, added this in bitmap-for-next together with the MAINTAINERS patch.

Thanks!

Any chance to get the fix into v6.16 again?
This currently triggers warnings in my code in -next [0], which is intended
to go into v6.17.

[0] https://lore.kernel.org/all/20250708160830.36ddf20f@canb.auug.org.au/


Thomas

