Return-Path: <linux-kernel+bounces-826450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D35B8E8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2A73BF2BD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D2B257820;
	Sun, 21 Sep 2025 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="tTPmuaSl"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D21400E;
	Sun, 21 Sep 2025 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494197; cv=none; b=Nrq7Z4IWp3PjdznPjLfydykdBuUgyoPq7jcv4tLaKo+dR58OZ7ukRrs9DOOlLzeGDuDTKnHP9CBinKzTSi2H892zC0r5BI2PzDnFNtQq/MEllcwXeY6vVKUi23q8WZOB90tyDKFKDbKXWjD8BuKvReOBXuSpNecW/DBb9z13B6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494197; c=relaxed/simple;
	bh=hURlDRAmCiSH8afdlAsfg6dorJFgqzLMZu3VEaQQIMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fu0zJoxcfo+KyQiTqDzKFjMixUEso/WVUY0gRYI98yJ+RTVPt/fvPUr4r/KFjLwXQeh+JANtbAEKCYQf9INiwNkNUPpc82Bknx6pfw3QpxRasPpo7eXvuEcj6hI0Nig9CXQWQGoz+rQabVPyH+6TXM7KCK7Y5XZILIjbMTXELMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=tTPmuaSl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0851240AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758494195; bh=SChKVAVVGVXzNCoV6xNjZT7EyEp3UafAxLelPEHjfAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tTPmuaSllaTLGzCPFnnqosVXzMvvFChlrCwRrF7FBECowkayKjAnFnNVCNryIcv2e
	 NRxubS5WyXnWgI5NThcYzflAKFTbgM4M+vj/cqvnx9EjP3RYUP8+X7ntdhQ/6oUJK6
	 xY8uSbGXmW+QLcgB7gBGlSHejSJ78tezAGGDHhFO9SXjGVx1JnYYs//EcgAALiFsZ+
	 cak+p6Nsh9UZEgCfreaPI3SvUqFiWfYKWkfk3Q13Y9vA/sblG+uFOpspgqOKnQQVWJ
	 CFRn8g/cmTtb40TWwue6tMu5bOo5zO8JX2oFgzm4NN1p/OVrymYehWTDwKNP4T9o+5
	 tbPY3rW/cz9Yw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::824])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0851240AF9;
	Sun, 21 Sep 2025 22:36:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Kees Cook <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: remove cdomain.py
In-Reply-To: <3b86d236c64af17924e4cfedbbfb8bc60059802f.1758381727.git.mchehab+huawei@kernel.org>
References: <3b86d236c64af17924e4cfedbbfb8bc60059802f.1758381727.git.mchehab+huawei@kernel.org>
Date: Sun, 21 Sep 2025 16:36:34 -0600
Message-ID: <87tt0v8mbx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This is not used anymore, as it was a logic we had to support
> pre Sphinx 3.x, as shown at:
>
>     afde706afde2 ("Make the docs build "work" with Sphinx 3.x")
>
> Remove it.
>
> Fixes: b26717852db7 ("docs: conf.py: drop backward support for old Sphinx versions")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/sphinx/cdomain.py | 247 --------------------------------
>  1 file changed, 247 deletions(-)
>  delete mode 100644 Documentation/sphinx/cdomain.py

Applied, thanks.

jon

