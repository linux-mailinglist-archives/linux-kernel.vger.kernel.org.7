Return-Path: <linux-kernel+bounces-751331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B87B167C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514205829B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A2221F02;
	Wed, 30 Jul 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="U39lTtPt"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09D221294;
	Wed, 30 Jul 2025 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908689; cv=none; b=OVRQJrB5/4ygZ/CClKTAe9m6Uyd7mLzEROTfJzNQ2pPIGfG8PALF5OnKZdSggv2bPH4trEn50w16EQc4WOGIXgzR4UKm8fcgCHB24MQ87jsS6wVWzz+VdffaLDg49+bQ6mwGFpCCxdGcllADyMfZsXotHtgI1bv8g7YKJb1awjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908689; c=relaxed/simple;
	bh=+Bgteg8oaAVo/cV3WkvBBwkTzRwzmbZj0bECgoudcpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gIkWhv4/Wy2NXDFMuY5GKw06HsnztFR2ZJnrrktNUvghWsRyRbPE8WBuEnCHEtokTtRHRofGUcNyRCxmK+L8oaT2lmJ4Z22n8DzkSeJoGH9kkPQ8cR66bOC2SCW02C0cJEDb62SEvC3HEmhInVwYclJFsILF888J7bAALrleKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=U39lTtPt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1A49D406F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753908681; bh=02MqzAQL13wGSkiV79PTgEwMNUoLXFSOZapwySxtdHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U39lTtPtf4k9A2d2EgfZUKo2Ists2QHrOkoBrC7tz7IDvbDfTiLnYdeaQE6c2wiRA
	 JGpMR+9yUCXoFuz5Ki76yYTxkKZOoPiQbWyrvfMEhGlRHOyqIP4Z/Bil7Pm2fHwjdN
	 POfd4IK2EchMQYKKsIg9aZWKClpCV+vDcavVNtQPhOOjmGCY2J4VBzAgTkvHgFqVmy
	 qZNS2GYGNab3u/1N4JM79Unz8qGnaNFPe5IeKeZkhr/OAnVbJD8NGZfhlACNwvGf/b
	 KmBB3Z3LIBvQFFpz2qjBawRdx62UvZVYaJI+Iw73nfoplxq1OMK7KsyGG8btXlMVX4
	 sOelNx303hhuA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1A49D406F8;
	Wed, 30 Jul 2025 20:51:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kriish Sharma <kriish.sharma2006@gmail.com>, skhan@linuxfoundation.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu,
 npiggin@gmail.com, linux-kernel-mentees@lists.linux.dev, Kriish Sharma
 <kriish.sharma2006@gmail.com>
Subject: Re: [PATCH] docs/powerpc: add htm.rst to toctree to fix warning
In-Reply-To: <20250730202752.8508-1-kriish.sharma2006@gmail.com>
References: <20250730202752.8508-1-kriish.sharma2006@gmail.com>
Date: Wed, 30 Jul 2025 14:51:20 -0600
Message-ID: <87qzxxtnav.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kriish Sharma <kriish.sharma2006@gmail.com> writes:

> The htm.rst file was not included in any toctree, leading to a Sphinx
> warning when building documentation.
>
> Include it in Documentation/arch/powerpc/index.rst to fix the warning.
>
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  Documentation/arch/powerpc/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
> index 0560cbae5fa1..ae0280383315 100644
> --- a/Documentation/arch/powerpc/index.rst
> +++ b/Documentation/arch/powerpc/index.rst
> @@ -36,7 +36,7 @@ powerpc
>      vas-api
>      vcpudispatch_stats
>      vmemmap_dedup
> -
> +    htm
>      features

Thanks...but we already have two conflicting versions of this fix headed
upstream, so a third is probably not needed :)

jo

