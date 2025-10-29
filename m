Return-Path: <linux-kernel+bounces-876686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 506F0C1C336
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 291C45841B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBCE2EA17E;
	Wed, 29 Oct 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WReRaWhr"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554822D8779;
	Wed, 29 Oct 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754731; cv=none; b=Rhwm2U8cfvlA1Qwa3M40HVXhCPU985ILoJJX8VZYXTbYf8k3bAAV7HAHAS74g3PCfhmwMg/znYKyyRKuq7KcJmHX1EGVwWeY4es38aG0/Z7IuWFf/bzr6fD86vzkyMLxR3T+bHKUVWv/wQYldx2tz4k3+LMtGLM/26zi2uW77Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754731; c=relaxed/simple;
	bh=ItsQFA6gHB0B+bH4phqSUxOq4pDY0347EnzmcFg1V68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0c9DtjnCHNjv3UTYh1jKIC+tFgYzobxvkhIjAF/hr16gkk/VI93sVDYLZPpKQWkeMLP7AqKNW2TMhMvxZjh2cOgqNMi5DhdXxtT/262t/DzAZ9ZaTdlTYw+GRkhXElLlF0P9z4Wws+UQfQj4a3TN+yIfcsvCeWIa/8i3ElivEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WReRaWhr; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8076E406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761754729; bh=fipKxuWbGOwA/hJdR+OnXvH3NJNssstojmnRmDx0+gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WReRaWhr0I/tIRElpLUw8GYU+7drG+ZGue7M5nGQqjJEr83utz/O9qv6fcoA5cPkM
	 OyKgpzZA3HqK7TW3NDpOXU7AfoKYSDg+RoyAl/l0CX04z0VtCHF8MqyaFJzZqsHOTO
	 OqDWaRzMnmRADf7EqWlrfRytX3cq+79HE1P8oV7fnpkNkYwLm9bU/H6I1PZ0lef/6U
	 IN9ZmqONAjFTEqk2BD4yccB6M5jmpqf7OaSMVfM21veuadhwR/OUeZpANYZGEwIYWJ
	 Tuma5YRc564Hsz0XRrJR5u340unoRUr+gnJNV77x8GIEMhmvnqmcOgLdbQbfpNbXiU
	 JYX0S5k2C4YPA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8076E406FB;
	Wed, 29 Oct 2025 16:18:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 bhanuseshukumar@gmail.com
Subject: Re: [PATCH] docs: Makefile: Sort Documentation targets
 case-insensitively in make help
In-Reply-To: <20251015012922.19467-1-bhanuseshukumar@gmail.com>
References: <20251015012922.19467-1-bhanuseshukumar@gmail.com>
Date: Wed, 29 Oct 2025 10:18:48 -0600
Message-ID: <874irhr89j.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com> writes:

> Avoid case-sensitive sorting when listing Documentation targets in make help.
> Previously, targets like PCI and RCU appeared ahead of others due to uppercase
> names.
>
> Normalize casing during _SPHINXDIRS generation to ensure consistent and
> intuitive ordering.
>
> Fixes: 965fc39f7393 ("Documentation: sort _SPHINXDIRS for 'make help'")
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---
>  Notes
>  - Patch is tested with make help command.
>  - Verified case-insensitive sorting.
>
>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3609cb86137b..00c81e7947a9 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -23,7 +23,7 @@ SPHINXOPTS    =
>  SPHINXDIRS    = .
>  DOCS_THEME    =
>  DOCS_CSS      =
> -_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
> +_SPHINXDIRS   = $(shell printf "%s\n" $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)) | sort -f)
>  SPHINX_CONF   = conf.py
>  PAPER         =
>  BUILDDIR      = $(obj)/output

I'm unconvinced that the extra complexity is really needed ... but I
went to apply it anyway.  Unfortunately, this patch doesn't apply to
docs-next.

Thanks,

jon

