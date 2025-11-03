Return-Path: <linux-kernel+bounces-883774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23637C2E63A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAA53AF900
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B282F9DB5;
	Mon,  3 Nov 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="A6n6AJP5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC73218AA0;
	Mon,  3 Nov 2025 23:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211884; cv=none; b=VduwEsCfEKQ3oFfUi6rT8G1XQ5bN3xeUmu2gvstK1hHPhqcqXBdn1cPmnxSIV3CEHkKyNtXioDi/5ObBCKKWpvnchrb+QXrh8RwNbQ6vbgbqsOi1vUv3yolDK6Sp9Ghbu3uOPKotYKjd8/LM9QX6/ff/BA+816K/jPlvQ/lmu9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211884; c=relaxed/simple;
	bh=YId2GSQkFT18/GatKEl55MmCf76X2N7tKb9OoydF1jI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VNGVMWQ1s1lYNHWTqv++la3X90hoLj3LIqKsG/pM+Pxnmfv9Jn4p6rf660zUtNtXQ/hk+mzrld51XR3WHrQWWmt0yhjNPAB2vX2qSr1RCdxJSA1/FgKwQhfJb9LmNMS45InuKLEqeKpQNkGVd4ClHGT9LRIygc2ykJbjrsCzzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=A6n6AJP5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9CC0240AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762211519; bh=4gG90FstYZiFRPxB+Bx0jcUMuohvx/Jq4O8NPO64nVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A6n6AJP58XS1Pb0mJ786Bq+nqX9hF7Uk8ZUpnA+0TgwNr4oVzpIYnuB0fe8Czdt5W
	 reSEJG8Wzv1Bj2JWW2BnDvuEoeIb45l4K3UuFdku6DPt5Bz1rKxHmvcN2nplO4J1h/
	 zG94FPQMtLznfiV0j5wr1tercjq1eScTlm4tPtbDCbV/9VameSCJtLfHLCh5n6no14
	 1sb1d6JTnc18ybGfObodbiYlRwT/3uA6f9joJ4Fh2PcvwT6A2Ro0QqUgZHrsXghNsc
	 PbB8Y/LpYIFAU0FH9JKqE2n+7K4UAdpqvO1hF1bDnkeVM0jmA4SliAjRMzrGVC8GFA
	 rf6By18azZvKA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9CC0240AED;
	Mon,  3 Nov 2025 23:11:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Gabriele Ricciardi <gricciardi-coding@pm.me>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gabriele Ricciardi <gricciardi-coding@pm.me>
Subject: Re: [PATCH] coding-style: fix verb typo
In-Reply-To: <20251101223027.171874-1-gricciardi-coding@pm.me>
References: <20251101223027.171874-1-gricciardi-coding@pm.me>
Date: Mon, 03 Nov 2025 16:11:58 -0700
Message-ID: <87wm46btj5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Ricciardi <gricciardi-coding@pm.me> writes:

> In the Identation section there is a list of instructions in
> second-person. The offending line uses third-person singular.
>
> Signed-off-by: Gabriele Ricciardi <gricciardi-coding@pm.me>
> ---
>  Documentation/process/coding-style.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index d1a8e5465ed9..2969ca378dbb 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -76,7 +76,7 @@ Don't use commas to avoid using braces:
>  	if (condition)
>  		do_this(), do_that();
>  
> -Always uses braces for multiple statements:
> +Always use braces for multiple statements:
>  
>  .. code-block:: c

Applied, thanks.

jon

