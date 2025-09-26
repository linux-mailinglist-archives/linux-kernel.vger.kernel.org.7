Return-Path: <linux-kernel+bounces-833460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A115DBA2026
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E8E2A863E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78841DB154;
	Fri, 26 Sep 2025 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWn0sYLO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF62AD3D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758844831; cv=none; b=eaAn37b958DjWe4DBeaclCIBb+gRi2cziwTQwNrfz05Xoh6mnS1MjgiN234sCZMPGRLoBRVZYomwiB7FDCFezHMVjGC6ckdpO9ZgXWcbCqqFr3rcQzUNgylerzD4YZpn8wQWs28e0Kg0yvk33KxRy0M+T2xL7N2mKE8hhitZcvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758844831; c=relaxed/simple;
	bh=pkaKK9TpELu4YEW8f2/5AnnFXKG/gVWQj1hruobD5n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHvnGIQBwUkcqhJVRN35GY5gb3BjXFTOT5iViToJ9xmhq6Tw93q6MC3rw8ibA/zVJaCdTQal9Le1PDRfewfi9uMMURmcYPaJdsp+gupxd4bNXnp45zrYEVf6dtqRw92hODxN45r01cLDX9NQvmwtHkqvbbgEl5C29nqzv9SDqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWn0sYLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA836C4CEF0;
	Fri, 26 Sep 2025 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758844830;
	bh=pkaKK9TpELu4YEW8f2/5AnnFXKG/gVWQj1hruobD5n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWn0sYLOgolzXXpst0LUPuSTKpM93gMlRM/5+FRyHQ7qcbFySBDj+Gx4l33tTD+fl
	 ez1UUAMnf6ET4AAMo6iE3jUk+3XkqANjbvSfXTcU3fh8Ya/ujoFjZH05QeXUGWaQYw
	 zuGv2hOFj8DI7Qm9Tgs38eJIiUlz3U9xczh8iwB9LiDPnIHvRJqHrTL3VFLTcFPNju
	 zLgKkb04NKAHmES0v2l75YLxxV2gQCxT/3q+OwNXQxBwNTTLEiBNfSemkdot0oyh4A
	 xkgL9pChga/gjZ+mCzXk4XsFO5h86IVMemC7cjoJzALYkCCWtxs+t+fmQG0aQnlXCb
	 fWz3G0WpbAD1A==
Date: Thu, 25 Sep 2025 17:00:30 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-kernel@vger.kernel.org,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-ID: <202509251657.F4ED4CF@keescook>
References: <cover.1758806023.git.alx@kernel.org>
 <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>

On Thu, Sep 25, 2025 at 01:48:14PM -0700, Andrew Morton wrote:
> Patchset seems reasonable, I guess.  But I'm not loving "ENDOF".  End
> of what - is that like __etext?  "ARRAY_END" matches "ARRAY_SIZE" quite
> nicely, no?  And it much better describes what the thing does.

And it's really ARRAY_BEYOND. ;) I don't really like having APIs that
require holding pointers that are actively invalid, either.

u8 array[10];
u8 *first = array; // valid address
u8 *last = &array[ARRAY_SIZE(array) - 1]; // valid address

for (u8 *c = first; c <= last; c++)
  putc(*c);
// c would now be invalid but has left scope so it cannot be used

-- 
Kees Cook

