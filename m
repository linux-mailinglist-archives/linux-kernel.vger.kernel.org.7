Return-Path: <linux-kernel+bounces-761011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05959B1F2FC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211C11733A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A7B277007;
	Sat,  9 Aug 2025 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="c2+OKLoI"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113D224225
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754726188; cv=none; b=kgmAeLpN82DqeTSo1R3fN+WeTpj7A9Jtf0/sA7kLEzflGn7XDNaJPdmENgjxq7vrTKNxdSbi9dAPRDbNRhO/QT9XEOmDNmg9oC5/8kVDFkRJZYFfgrVCz7TZYfgoBw6sJLKCtIF4Jv99xyQS4EgKfZQTNAukaKFs7r7p8CRbjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754726188; c=relaxed/simple;
	bh=iH2N9wqbHzEMj8RmmQatvqHszvO9Gt7XtO95bu8L8vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhl+XCjW6oU00TvttQ2E4E1MvK+Bm0rCh6GRU5DAMjruhmckveebxW3PjkpHpLU/4exfllbHNmPBv+oKupNL0AU4ngma0IbgTBb2vi2Yltq2rnrpQLfc4zEyA5bVoOzjFaAuYJ++Eqx/b0milpzortw0wp/Nyjgn/uZcJQlAMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=c2+OKLoI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754725831;
	bh=iH2N9wqbHzEMj8RmmQatvqHszvO9Gt7XtO95bu8L8vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2+OKLoIHhDpovJtVTPR7h0usvsbmNEWfhosuIYK8ufwoD/ahhv5djIlEFwVshyn3
	 zH8m479T/tUwH6nZYlkK1Gm4fvg5tukqZMYq7p5l5V3fMr2XbWvS0it7KysGtA0YtR
	 WJdXxK7D6AwhHBugvPZP8DraxURJcH2ILICi7CUc=
Date: Sat, 9 Aug 2025 09:50:31 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Daniel Palmer <daniel@0x0f.com>
Cc: geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Add target for lz4 compressed vmlinux
Message-ID: <5dd0a031-dd7b-4078-b1a8-6b760248390b@t-8ch.de>
References: <20250809015529.373693-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809015529.373693-1-daniel@0x0f.com>

On 2025-08-09 10:55:29+0900, Daniel Palmer wrote:
> Traditionally gzip (/bzip?) has been the compressed image format
> but its a pain to decompress because its very hard to load and
> decompress it in chunks which you need to do if you don't
> have enough memory to load the whole kernel image and decompress
> it somewhere else.
> 
> With lz4 you can set a block size, read it from the header,
> and then you only need memory for a single block and the
> decompressed kernel.
> 
> I use lz4 compressed images on 68000 with 8MB of ram
> and MVME147 with 16MB. I want to use lz4 in my fork of EMILE
> to boot m68k macs because streaming decompress of gzip is painful.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  arch/m68k/Makefile | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index 0abcf994ce55..a56e853037c0 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -124,6 +124,17 @@ else
>  	$(KBZIP2) -1c vmlinux >vmlinux.bz2
>  endif
>  
> +vmlinux.lz4: vmlinux
> +
> +ifndef CONFIG_KGDB
> +	cp vmlinux vmlinux.tmp
> +	$(STRIP) vmlinux.tmp
> +	$(LZ4) -z9f vmlinux.tmp vmlinux.lz4
> +	rm vmlinux.tmp
> +else
> +	$(LZ4) -z9f vmlinux vmlinux.lz4
> +endif

Splitting the vmlinux.tmp creation into a dedicated target would make
all the compressor targets simpler. It will need a bit more disk space,
but there are a bunch of vmlinux copies already in any case.

> +
>  CLEAN_FILES += vmlinux.gz vmlinux.bz2

CLEAN_FILES also needs to be updated.

>  archheaders:
> -- 
> 2.50.0
> 

