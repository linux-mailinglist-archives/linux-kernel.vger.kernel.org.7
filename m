Return-Path: <linux-kernel+bounces-852894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C20BDA2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 388603442D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C17C2FFDD3;
	Tue, 14 Oct 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nty0cZcW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A0D2FF152;
	Tue, 14 Oct 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453875; cv=none; b=qCYc7IM/pGRyooh/VudTVz+00nPQoXHQsOn8JY9zibmfb39xvfNofGyDCtMn8uAgsdFngBU+8S1xMMOBRysPZiIB2Y0Tq8FX6rkDGcJLZ8wNX0CR0hKGHi3WDhXLS9s8BdipaBXXnR6lxlDP5GvFhTV6dOZH2BkopJzMZ5TxvxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453875; c=relaxed/simple;
	bh=LeVdUQ8lX2lg2KlQK3iSPpVCXspigp3O0Kc6mMCPKk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gjiIbXG4MKI6tGaNJevM/E3/Lszu3yvNUr+jHxdh5mlKqdeUE1qv195t86AdFvouW894Xp7D9RsG5mRPO9oCJf3F3B8HxpZAZSpuC4cS3Sz7DCm0I9pMkTgUWdsgY6KI18+zojTwRZ5iUIQcFBVqHKqmz9Z62D7XseoMDGf5wVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nty0cZcW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2812540B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760453873; bh=Bw6pa+0VpuTwWoQO80EmiM4FTaQ5Ki33aDGmh8gXitU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nty0cZcW4NB5uRUogo5SzI27s+YrJN8OyiXPXhz9DkrTy3Mwb6AS+n5ik3fzCPubH
	 xw9a6uoT5mAMuLiIUrAF2ztcZjUPdxIOH41xwWzhbzZOXV+wjww5i+DqeuOlF7Q7BO
	 G5mJogkpX3jmxhnc1r4badY9WLAGI0StaKv70OIdHr0MjIUKeRF3K+pVCC3jgY6HEZ
	 22Na4mffL6hqVKbHk81wYFriDKNMJCJ+Jneb/3f8rl75chyYVN3cWQ7AvBnyVo1ov+
	 vCuG9oI+4k5Zbg7Q0PxmeW3qPkolLjnf1UMIDVbcsfj7a5s1VuiZvyewmflLmJpe/2
	 cMPvwmRLyoBkg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2812540B1E;
	Tue, 14 Oct 2025 14:57:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akiyoshi Kurita <weibu@redadmin.org>, linux-doc@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shannon Nelson <sln@onemain.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, Akiyoshi Kurita
 <weibu@redadmin.org>
Subject: Re: [PATCH] Documentation: admin-guide: Correct spelling of
 "userspace"
In-Reply-To: <20250926190019.41788-1-weibu@redadmin.org>
References: <20250926190019.41788-1-weibu@redadmin.org>
Date: Tue, 14 Oct 2025 08:57:52 -0600
Message-ID: <87seflbken.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akiyoshi Kurita <weibu@redadmin.org> writes:

> The term "userspace" should be a single word. Fix the typo
> "userpace" accordingly.
>
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index a0cc017e4424..ed1f8f1e86c5 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -186,6 +186,6 @@ More detailed explanation for tainting
>  
>   18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
>  
> - 19) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
> + 19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>       to use the devices debugging features. Device debugging features could
>       cause the device to malfunction in undefined ways.

Applied, thanks.

jon

