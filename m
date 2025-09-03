Return-Path: <linux-kernel+bounces-799483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18AB42C72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15F33B4C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208D42EAD15;
	Wed,  3 Sep 2025 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="s9s4G6f/"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C944A2D;
	Wed,  3 Sep 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936824; cv=none; b=YDUO35c6FYjZVccuTyi88hS4dIRHxtbiGEq+wuNl2SFs2AZSFS37VbbFNYZgdEgg2jlluyaLRcV42A0bgcY7qM4/NjsG4ysD0ytfYy2ryKlsaPBZSe4jecZ9f+yWAbebir5tpZ6UT75/EEPeJdipuW3cOJZq/hXFAm+p6EBV324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936824; c=relaxed/simple;
	bh=uw5aAUCcgxZVi+vY18n2AmpZAB4xTKY8OnGtCb32vk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AV9DNaMsQtakgtmCZYgiu9GJ60TyOcWSTmKGvPutgUfd6R8T1TCmgDWyXHwwpJrfCa6nNQQNSs1GjiBxhQ90/WaxRxfnOLqA1qnyGEFRMoyMw6g7gpjeZlz90BNqTRSm+4heVVV843l14urR8Wfyhymbi2J5Djf6kgPOa+yv25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=s9s4G6f/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 03B9240AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756936822; bh=k9l6zHVofmr8RjjvTGdA7sRE+gjI+QdcV93niTjx5Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s9s4G6f/e4jBLJGdBhuIcJeb1l5qjI5R7DD6tp+a9gHLKvYncS//yLDmXZgJmauvl
	 5AUoBEuUYYbml+lk3FmUoML9o2mTFxjURzJggvdcONfloVMFcYwbADw7WoCieoO2EO
	 pMQlEy1rswjLD3h7cNMF7RVBCUEDKtV36Quai1C8o/XoVK5XtQBGNDsrjOCw/ihOuj
	 MIgPzbTc2JoGDio0sblhofZ9oIYsQIc5cwiuzxx4rW9BrmzZljk4xmAk1sXuOmZAc4
	 kugTyWCptTwNOreCoEdhj6QvUB0SMZ2kKEf1/EFga8eVdg9hCyXdJTxSqGgJDVi0hu
	 aNXB9oX8YidZQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 03B9240AE3;
	Wed,  3 Sep 2025 22:00:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Zenghui Yu <zenghui.yu@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Zenghui Yu <zenghui.yu@linux.dev>
Subject: Re: [PATCH] docs: admin-guide: Fix typo in nfsroot.rst
In-Reply-To: <20250827144738.43361-1-zenghui.yu@linux.dev>
References: <20250827144738.43361-1-zenghui.yu@linux.dev>
Date: Wed, 03 Sep 2025 16:00:21 -0600
Message-ID: <87frd3p56y.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zenghui Yu <zenghui.yu@linux.dev> writes:

> There is an obvious mistake in nfsroot.rst where pxelinux was wrongly
> written as pxeliunx. Fix it.
>
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>  Documentation/admin-guide/nfs/nfsroot.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
> index 135218f33394..06990309c6ff 100644
> --- a/Documentation/admin-guide/nfs/nfsroot.rst
> +++ b/Documentation/admin-guide/nfs/nfsroot.rst
> @@ -342,7 +342,7 @@ They depend on various facilities being available:
>  	When using pxelinux, the kernel image is specified using
>  	"kernel <relative-path-below /tftpboot>". The nfsroot parameters
>  	are passed to the kernel by adding them to the "append" line.
> -	It is common to use serial console in conjunction with pxeliunx,
> +	It is common to use serial console in conjunction with pxelinux,
>  	see Documentation/admin-guide/serial-console.rst for more information.

Applied, thanks.

jon

