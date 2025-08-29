Return-Path: <linux-kernel+bounces-792542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B79B3C560
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C196B588046
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6642F8BF1;
	Fri, 29 Aug 2025 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="TPI85Qq6"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC51C5F39;
	Fri, 29 Aug 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507779; cv=none; b=MBBfrOaMOZcUWRBLUDfhG+81ZfavhsrVVeyeP2rPOwnzWwA5TtstWdryqZfrJf8b0h1A/T4NaFIB+SuEjlz8tPEAJOSrIPSPYR+3Noyo+3U5iNGDcvgji3+mZaUsaTe4fDQXUTF++ybIKm7IzQeQeT2lsHgVal6xyp/CSLClWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507779; c=relaxed/simple;
	bh=GX9xsTtGU/uXie2m0TNplBPxk/b3kPC56uYI52oCyHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vfd9Oa/tV0KcqkMmJU8Jn0eC9k35/RfZVOEesyfuZGCAAH/Owf2NxNpw+peA6Q4H+MZ3ul3u1w+w6JTGvFOGAz7EX6BSfxpG/1r8zMJ5+E7G7kP7VE/ZjsHu1iPI33C6H2eXNEYp6ZCuFRHFQp8peMqYapfHAxO66vcangz5y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=TPI85Qq6; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4BA4B40AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756507777; bh=Vf9FHeSvOjXjhp6WX9uhmsNSpUGjfQaGUBsXH5N63hI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TPI85Qq6d113kHUaMBvDTOicjYL8yLbG3WUfv+SULh7/u5SORJU8XGITTjkA/5z2P
	 GLjT+VY2L1XLPBrFeRPagP/iDKYJw8DmAeAcCL3uk/DZAUJR4+Sh/lyvGqgJpUSqUB
	 XCFlESmxPSrBQPEibJahysCFDOBy2Wn+ynDVAdkmK67JvhXL3D9CnGXOQjKl5x4A3E
	 IIHI6Mhrk/PzFTvfR2PQWS69wsop3vpWxtFkWBd/imKn4BH/gPLebRpodSofpCJm+6
	 gETy84aLbVhlm6D/VyKU/nYPlwtYn8YDnwmgXZQgcuQ1Vkq9vnx0VaG2GUls8QvyPf
	 YlH0caGXps91A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4BA4B40AF9;
	Fri, 29 Aug 2025 22:49:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: conf.py: drop xindy rule
In-Reply-To: <83068bc31839e7095f1f408e49658362d467797e.1756123459.git.mchehab+huawei@kernel.org>
References: <83068bc31839e7095f1f408e49658362d467797e.1756123459.git.mchehab+huawei@kernel.org>
Date: Fri, 29 Aug 2025 16:49:36 -0600
Message-ID: <875xe53fr3.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> The rule as-is is wrong, as it was inverted. Besides that, after
> retest building all repos with suggested LaTeX packages given
> by sphinx-pre-install, I was unable to reproduce the issues
> I saw with xindy in the past.
>
> So, let's just drop. If anyone reports issues with xindy, we
> may need to readd, but at the right way, e.g. {options}{pkgname}.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/conf.py | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 8fcecdb927b1..574896cca198 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -458,8 +458,6 @@ latex_elements = {
>      "papersize": "a4paper",
>      "passoptionstopackages": dedent(r"""
>          \PassOptionsToPackage{svgnames}{xcolor}
> -        % Avoid encoding troubles when creating indexes
> -        \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
>      """),
>      # The font size ('10pt', '11pt' or '12pt').
>      "pointsize": "11pt",

Applied, thanks.

jon

