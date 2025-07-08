Return-Path: <linux-kernel+bounces-721813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BE6AFCE22
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360393B29E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56423226CFC;
	Tue,  8 Jul 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuT9IRQc"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853D226D0A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986045; cv=none; b=JXtuzbSq+1oQiCZIdrZ13Wn8yWjNJ0YXEOb6SC/i8jHQ8wero7EKGwf/SsdBhAo1CkBAPNkxHM1bz/32bWlkaKUl5YuG8ydCqc2tdp3YnKswZF74T7hJMuH1eHlLQ55UK1WOhFMOvTsp1YGVzUtS4qb/y/kqErRJaFmNA+5C9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986045; c=relaxed/simple;
	bh=KbOLzaxfYU2kFB3wUmgV6u+hVS1/ouY0QwUF2nAPo1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owS49AMb5K70jS3wm8SpeuwPpVWp+ZJXB2fEZF9q1Un4BGrLI/kEisL5JLVqa5jdK1IidW7aZUT0n5/mEvQBEWwrpflP1hOeYq4Lfuw+hrvzIik0oGJV8d+EALM6EGCjvsl3RhoZykZysyOcyUZ+6E6PmSZ6mqxEftFRLMiiOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuT9IRQc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-315cd33fa79so3518862a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751986044; x=1752590844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y5SVtgnZVBeR70c6EytxkBI1iAYXKzgR8FCojArq+RY=;
        b=PuT9IRQcNIY8K8HhYBUzjHcN/KtMqMUMK45Bkic4JzhQLAbGIiqqW6upAbQ81yB0Lt
         mhBXrHQMqgPP6bwVkV7T59eNrccHwDzqtwGJ1+xdxh74FQwK+OLayDvjEUQ543Hftk9A
         8G+zZ4x0aF3TUqQxservlKlD235XwxdU4AFue43sE5hKS8VCslunEF9Ed09ccBIzutav
         1AT08ehEHMIKBFCloItmFfTTrwWRNiqsFk7ON4ByDvwFnNAH3FxYGlNhYU6ZAiFpjGsa
         gFbt4KdRcpG8oU3ssTWHvGF+w5Wgh6nDkNmtKiNEZfjXbwyAK7ng+dHE2NTOkRAfY9G5
         Pcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986044; x=1752590844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5SVtgnZVBeR70c6EytxkBI1iAYXKzgR8FCojArq+RY=;
        b=nwkBXkQtwIMUFkXh7QDlYi50cylQHPBDyD3wQe6fJtLClmXW5xR8sm4qXvy+KmH2cc
         wsUFldIZ7SGLcRqkoBOJy8j4FcU0f2owL+3t7EAQ7uQaUF079ZljYlVbQbctSSlOYUtJ
         J8OrcQMunpiJwBD2rfed5t/9kmY3QaU2DuQa9uvCxRMw/7YE9GeVYj+pnKXYNmpxHVmc
         nZCPWh2ijueNCpTm5JDWqEUe79r+ZKpTfKqFsCZw6edx/w6My35rDbVJbHiB9OHktmhw
         OzdDqmZQSkd1wMci0m+N6REJSRmMXkOm2g4INY/oR/YM44s3+P28e3VSjNcCCTq3ADyj
         4f5g==
X-Forwarded-Encrypted: i=1; AJvYcCXKMQErrPcUtqQFkuSwvzD4Xz2SIOmUCJkitopb4MQlE1D1sNCRZIAjtYgV29DBJ1DLSDxjG4ZC/Roosb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysd9hnVyNi7cBvcOFdmthN/5rLTS19gA43DS3W0CCdRf2+6oFw
	Ll4fg09MI6kyhx7+WUkpQW1pgBcTb6f1rPKjWHGU8hpBRoL+dGfmEyPk
X-Gm-Gg: ASbGncv87L+rLmjk6lhIXVUlfwoaJhysyPl7vAtZb3ZKk714sbS6MUDHhxxqqi+LsPt
	X65wh8d7y5skR1AGl8JAVCSmd1v757ZoLwGGODhqsKJ/6EputuLCL0fbrZvE2yBwelGm3gvQ1Lm
	1GKvBzJBYEMma6xjBxyARzV7Jktttu4AIdavka2uOL35y4gCRfZxPAU1YZC18Tp8uQxIgJYXfhQ
	sUiW++z2tpxxEetHCC7T5Ls0uJuAIRQVFSDt+DJBOzcBSGx3Ak7ctBnRvLm5mekhoDlHZwNKlyj
	z4iGRE8wm5KaGSCt1v/PHBGE5Q9EcsC/FGM38O0JyI8+cJithVQ1tZ1DRlbcyg==
X-Google-Smtp-Source: AGHT+IEJ1BfY7zxvAUbxeGiWYv/u3Q/SVkJwGyRqmieMltP5Tku2McKDxI5dKtyzmNvNC1b06duO7A==
X-Received: by 2002:a17:90b:48c8:b0:311:c5d9:2c7c with SMTP id 98e67ed59e1d1-31c21de8312mr3991032a91.23.1751986043555;
        Tue, 08 Jul 2025 07:47:23 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c22fa7db3sm1642877a91.1.2025.07.08.07.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:47:23 -0700 (PDT)
Date: Tue, 8 Jul 2025 10:47:20 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uapi: bitops: use UAPI-safe variant of BITS_PER_LONG
 again (2)
Message-ID: <aG0veDJWGHVIO6Cc@yury>
References: <20250630-uapi-genmask-v1-1-eb0ad956a83e@linutronix.de>
 <aGKkw6b1QPTf9yii@yury>
 <aGRVJHZF36KGVs4c@yury>
 <20250708082027-acf3e21a-8627-4cbe-9ccb-6d872eec2918@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708082027-acf3e21a-8627-4cbe-9ccb-6d872eec2918@linutronix.de>

On Tue, Jul 08, 2025 at 08:26:49AM +0200, Thomas Weiﬂschuh wrote:
> On Tue, Jul 01, 2025 at 05:37:40PM -0400, Yury Norov wrote:
> > On Mon, Jun 30, 2025 at 10:52:54AM -0400, Yury Norov wrote:
> > > On Mon, Jun 30, 2025 at 03:02:18PM +0200, Thomas Weiﬂschuh wrote:
> > > > BITS_PER_LONG does not exist in UAPI headers, so can't be used by the UAPI
> > > > __GENMASK(). Instead __BITS_PER_LONG needs to be used.
> > > > 
> > > > When __GENMASK() was introduced in commit 3c7a8e190bc5 ("uapi: introduce uapi-friendly macros for GENMASK"),
> > > > the code was fine. A broken revert in 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
> > > > introduced the incorrect usage of BITS_PER_LONG.
> > > > That was fixed in commit 11fcf368506d ("uapi: bitops: use UAPI-safe variant of BITS_PER_LONG again").
> > > > But a broken sync of the kernel headers with the tools/ headers in
> > > > commit fc92099902fb ("tools headers: Synchronize linux/bits.h with the kernel sources")
> > > > undid the fix.
> > > > 
> > > > Reapply the fix and while at it also fix the tools header.
> > > > 
> > > > Fixes: fc92099902fb ("tools headers: Synchronize linux/bits.h with the kernel sources")
> > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > 
> > > Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > > 
> > > Arnaldo, do you want to move it yourself or with my branch?
> > 
> > OK, added this in bitmap-for-next together with the MAINTAINERS patch.
> 
> Thanks!
> 
> Any chance to get the fix into v6.16 again?

Yes, just sent a pull request.

> This currently triggers warnings in my code in -next [0], which is intended
> to go into v6.17.
> 
> [0] https://lore.kernel.org/all/20250708160830.36ddf20f@canb.auug.org.au/
> 
> 
> Thomas

