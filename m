Return-Path: <linux-kernel+bounces-887120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E35B8C37505
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790FE1A2144B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C112D283FEA;
	Wed,  5 Nov 2025 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hWTwhOKu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9461FFE;
	Wed,  5 Nov 2025 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367506; cv=none; b=oYRuxY167/F1JxdiiGmLeGo6QWDw6rQTBF9Z7EfSi2/Xh0NFoBS9KoFr9/17Kk2su18Y3zQ0t+kbntkI6gUl5z0QM9rL7wC1eJTolvaLMKP2llBCP3jssM/xjnAeI9xUa4/+WEM2ABnqE4Cl0Salb0pxwikpz6PsY/WiIqPpj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367506; c=relaxed/simple;
	bh=S2tfhWkRiFbOx2lsv+5tb2bhvhnNjayzhjGgm5XqjB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l3e9StJ6pGXI88aQRZc9PBtCA7E8713uH4hMiIVUmRVuvWem4may3ZB465SUGCPKiblbNw5BL/5iwxZDchXhCNYhh/TDu7pQPqqVNi029bJRHwJduugL/aKKW5WAnl2/bgU6a6oaH7bPXSJsKPHx3zAzFcFipEbwf4xuhngv1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hWTwhOKu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0DDBC40C2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762367504; bh=+qSm1NYuCABVquv8CRh/H8rCYxqKElrGPzu2X3oeikg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hWTwhOKuvOd6WAGFJbeX292IVnn58KvCJNWU/nuaY6ET8h9b0+FYQ3REKvQSkAdoY
	 uRVcUWt+PUwtU1RePELyttWy32kzRfIZVel1it7osErwUORrg9Z4qWBlP/xtlA4efg
	 THDQpVS4QVACZYJweY0cujannEIdR1V/nSI1fg7E0fgnjXLlXpoeRDRTGtgGkiqSDU
	 0mc0i2YbOOD5mXaS2EbP1C6yR8RISfTkCqnBkhgKiuIZT/jlvnk6xSHljaHSj4r73s
	 vPx2KQTMOT0p5NYr45A7zFZ1qH5kP7s+BwXgnbu9bvjtMmEACnmLdG7ptWqJqdb7Hf
	 oD2SXRHYQ7Byw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0DDBC40C2F;
	Wed,  5 Nov 2025 18:31:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Accelerators
 <linux-accelerators@lists.ozlabs.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang
 <wangzhou1@hisilicon.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Randy
 Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation: uacce: Add explicit title
In-Reply-To: <20251103093817.52764-2-bagasdotme@gmail.com>
References: <20251103093817.52764-2-bagasdotme@gmail.com>
Date: Wed, 05 Nov 2025 11:31:43 -0700
Message-ID: <87y0ok5o1c.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Uacce docs' sections are listed in misc-devices toctree instead due to
> lack of explicit docs title. Add it to clean up the toctree.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v1 [1]:
>
>   - s/acess/access/ (Randy)
>
> [1]: https://lore.kernel.org/linux-doc/20251103025950.23159-1-bagasdotme@gmail.com/
>
>  Documentation/misc-devices/uacce.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
> index 1db412e9b1a380..5f78d413e379f4 100644
> --- a/Documentation/misc-devices/uacce.rst
> +++ b/Documentation/misc-devices/uacce.rst
> @@ -1,7 +1,10 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -Introduction of Uacce
> ----------------------
> +Uacce (Unified/User-space-access-intended Accelerator Framework)
> +================================================================
> +
> +Introduction
> +------------
>  
Applied, thanks.

jon

