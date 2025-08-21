Return-Path: <linux-kernel+bounces-780403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12FBB3015D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BC01CC6043
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7416A341652;
	Thu, 21 Aug 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LB001szm"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19420482FF;
	Thu, 21 Aug 2025 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798372; cv=none; b=obvkv4SSTqtT9ZH5ET3zGPFTI1wFwcn1q43AZ0/tcYDD1f1sOenv0jIBYBDseDzhcj2BGE4GMQhHJod57CurfhzBfhqjCUKnqMKrZ58FEOZJMK3hbXPOYkEynxI3sYii/m9x1eKx86frTuxM1tuc5rnzGNes67zcoZOKHnaQpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798372; c=relaxed/simple;
	bh=qhT+LlyRONqaan1vamerAK8oTaKUm0AOI6yLv41vfyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HngKA2Ki2pp84hAwzE14ybEUmnXfXGFYW1vZkdAAHnSqQgnvsqixJmBYemtA32YtgnFO8N8F0o5VenSj1OtVvdze1Xajs4jZ73NtLPGsDb2Hnd/DHAbOGqJ00MB5Dq9vG44FZjJr0USOrWyfHdomYMooKaYPGipP5LuasYXCZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LB001szm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 77AE040AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755798360; bh=CI5IIwqpEBf3bKeAEA5qs+18psBFosyojgKFAxoWgJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LB001szmpjh9qLBkz99Q1toXRxO85gkuwJnKfxx/7+7SV8zR2KGPLek/RkF5Q/pGF
	 VujInIUeyphpuFodghvfusPki/zQUV50QkIlHOPxlSoNeaOTFZUseIubj4SCbJdY4P
	 PUjUK6cGyzN6IZEYRqbFATcS17YJdt7blfJOzLpOQz7hM0zzd3AsI7B74Ct/k88scg
	 eRj+8/2Rfuh+1YL0KYwptdJ5FIBU/PuSvRcEDZXtxablvYoeNhjpuTLM1YPy4ZO1d6
	 B7tvNrORvgc4bgyUuUPQdUzbq8qsG5tC1XOJNDS6ysbwgBkZQOvr2f/oEZn0ENAT1b
	 LV6vjJ67teYig==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 77AE040AB4;
	Thu, 21 Aug 2025 17:46:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Albin Babu Varghese <albinbabuvarghese20@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Albin Babu
 Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [PATCH v2] Documentation: conf.py: remove repeated word in comment
In-Reply-To: <20250820194714.130513-2-albinbabuvarghese20@gmail.com>
References: <20250820194714.130513-2-albinbabuvarghese20@gmail.com>
Date: Thu, 21 Aug 2025 11:45:59 -0600
Message-ID: <87ms7s7elk.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Albin Babu Varghese <albinbabuvarghese20@gmail.com> writes:

> Remove a repeated "are" from a comment in conf.py
>
> [v2] Resent with full recipient list. No changes from v1.
>
> Thanks, Albin

For future reference, information about resends and such should go below
the "---" line so that the maintainer does not have to edit them out
when applying the patch.  I have taken care of that this time around.

> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> ---
>  Documentation/conf.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 700516238d3f..55299665753a 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -224,7 +224,7 @@ author = "The kernel development community"
>  # |version| and |release|, also used in various other places throughout the
>  # built documents.
>  #
> -# In a normal build, version and release are are set to KERNELVERSION and
> +# In a normal build, version and release are set to KERNELVERSION and
>  # KERNELRELEASE, respectively, from the Makefile via Sphinx command line

Applied, thanks.

jon

