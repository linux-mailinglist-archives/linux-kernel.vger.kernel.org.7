Return-Path: <linux-kernel+bounces-863644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46E6BF8B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5853B9187
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2B523EA9B;
	Tue, 21 Oct 2025 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UQbAnwAu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81821E1E04;
	Tue, 21 Oct 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077793; cv=none; b=uNZTOPfHo4NlSSfPvUjoYwYUNpMRNwSuoO8MehJvOgERERkyCeK7ny4acccQou1cODJEhyv6Dm4cQ5gugzmPhvOM793kL4W0DTR1shCwwRfa2ttcvi6X6GCAyreJJxOfxdFU7HJ/5U5vSmlvdN10vr2efFX3FCpG+jZKj6il9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077793; c=relaxed/simple;
	bh=2FwEsDAVTL0eZF75eYcjfklo+HwL71jjw92AWzeQXJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QNBnsqbmwxSSgysX4kHz39B1fJxIlo6JiwdlKhgZ+x0KJsg7xAB74hphS5fADIPaHVBpCP8VOzA+6bD6lgOc2xCZh97JVlxCm2ozM8zEBDnbYwk0BWq3j7VHraauCg4uEvglF4FCOvDQeDH9GlN3iSA0ZdgNySXFg5+p8E6q08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UQbAnwAu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C8EDC40B28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761077785; bh=0BofnvVgBKRkg6q6c8Lc5V1aHmXwTaOpVq7t0+nXVyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UQbAnwAuJNZ8wAcyDEnsV679hVb3jLF3NhC8F/EjKr0QdUJHh4JGxugBRmG3qPTmY
	 XmQm1An4VKyBGqDHQ/HJ0XWIauy+0ybX+phfHMnAm1AzSj8QdHoBdsx8cuW+uCfKwG
	 a1/O/F7VbE8HARW0vE5ByeH5MSXyZzoNFXohEl7oKfSEufmZndvIuGajpqWoYIBhYO
	 80wwBrBhJdFPlqF8a+Tt7b+OobQuTBdkfLd9PchdQhJo0pBBr9ScCvsy+jEaKt4nGU
	 NBvdwglYa8McmdVBmcUAZcE1fBWvaDh35npikHt9eV56hKhc9Uberfa6QVSlOv/8Ed
	 F99USlYGtKxSQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C8EDC40B28;
	Tue, 21 Oct 2025 20:16:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ally Heev <allyheev@gmail.com>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, Hu Haowen
 <2023002089@link.tyut.edu.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, Ally Heev
 <allyheev@gmail.com>
Subject: Re: [PATCH v2] Documentation: fix dev-tools broken links in
 translations
In-Reply-To: <20251020-aheev-fix-docs-dev-tools-broken-links-v2-1-7db64bf0405a@gmail.com>
References: <20251020-aheev-fix-docs-dev-tools-broken-links-v2-1-7db64bf0405a@gmail.com>
Date: Tue, 21 Oct 2025 14:16:23 -0600
Message-ID: <87qzuwt3hk.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ally Heev <allyheev@gmail.com> writes:

> gdb and kgdb debugging documentation were moved to
> Documentation/process/debugging/ as a part of
> Commit d5af79c05e9382d38b8546dc5362381ce07ba3d1 ("Documentation: move
> dev-tools debugging files to process/debugging/"), but translations/
> were not updated. Fix them
>
> ---
> Link: https://lore.kernel.org/all/20241210000041.305477-1-rdunlap@infradead.org/
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
> Changes in v2:
> - fix kgdb doc path in zh_TW/admin-guide/README.rst
> - Please drop v1 of the patch. It is malformed. Link to v1: https://lore.kernel.org/r/20251020-aheev-fix-docs-dev-tools-broken-links-v1-1-5d127efec0b2@gmail.com

Putting your signoff after the "---" line caused the tooling to not
include it in the resulting commit.  I've fixed that up this time, and
added a Fixes: tag as well.

Applied, thanks,

jon

