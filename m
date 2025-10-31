Return-Path: <linux-kernel+bounces-880165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD2EC2505C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15C2465ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42552D47F5;
	Fri, 31 Oct 2025 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L4dEnD3J"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E834217C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913955; cv=none; b=XCKN9nbDKM1+JIdH2Qx8pGqHBnwFk2w9n+9cdYQBQdf9G3Gf93CmFoZgM3i1bX7ZXinppR3YvlnD8siiaM/TlCGk74Umiw2MUPCbmlh4d5g0M//yuE5Fh0V8uXAz6jTaCCl7NZbUFUrYAKZFQieQ9WPv6y6zkoCOdNYVffTe55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913955; c=relaxed/simple;
	bh=Yx51E/hEVPuThO1aORg/TBO9UACHPb0DASTCNYm5fdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfsJeMhjxXEMZQ3PGzkfh3x7o0rShOpFICa7UG5WnikFT7Kx/xr2H8Bgt+etXAwYcME1t2YPc9sbEvIDDU1DFhefR/zORWt3EITWdFmd358RZ85zMSnFdskbUn4pcRkC1Xz/n2WkR5UfSB8/oiSxywTidZW9QhmYjhqW6VP3Kf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L4dEnD3J; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C070940E016E;
	Fri, 31 Oct 2025 12:32:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EQmMh1wuh5d9; Fri, 31 Oct 2025 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761913945; bh=Q1wKm23IWPLU7SS0cQRSfxSNlgwvrah53XvFGrbtS7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4dEnD3JvwMbKBNj9bNtjxXpVRjb1AIRNRlOuEIR4M/vuYJGeDHZGmPcDIxAjIWDa
	 0D3e9x1db0wVoAfzYTdVJFX7IaZlMTyU39CPBrEoIR0W9UZwrDgfPe/LpcMR11gX/a
	 PwrCd27OGhyIf6/v9m6zXFL1mLnRR8bt/TUmyIXIGaS/2kXaDh2VuJBQ63ECMHTVjZ
	 fonJRB2YfgGRRxUlX9/r17t3Ty0ZELKwKpebISeaaz3E2cft9/mekyHm2ezsTpriEo
	 Nt56ebqnBkXY9y7B83+RsYXfkVdSNFN+xcYNXtItb2Mlh+c/hkn82J0HxEHGx7pbi4
	 agcxoRHPV3/X+FNqz/x6CXoOo5D6JYYiavHJ1wqO1RTYCp0xXx5cRnj5GxPAUWVDgJ
	 w/pNFh1bUohzH2VH+ELquMQjJgFoSxKrsm37rzqdA271MUHJz7iIsIuYFgKVuBAoiB
	 dBviAZMwGFnUvDNMTF9rK7FSozgjIePhIMNhr8NdqZXqQtarWv6FUL2JaR3+cfZZG4
	 Sk94uwpb+QTMMQQaFvo+eZtrgfYyiZYCxdXju3Wj9kCBpNAy7SInXoOfpbkr9uOymc
	 jDllQt9c2frgcX+ncfNjqPBQ1RXFBOGixmPKZRo7DA8ZoC9P0wLW+iNAgPBqMA+xPg
	 lepazrFIKXTknHmfWP10ZAAM=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9E31140E021A;
	Fri, 31 Oct 2025 12:32:16 +0000 (UTC)
Date: Fri, 31 Oct 2025 13:32:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: neqbal <nooraineqbal@gmail.com>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com
Subject: Re: [PATCH] x86/mm: Fix off-by-one error in set_memory
Message-ID: <20251031123215.GCaQSsT-TMmfz_Ot8b@fat_crate.local>
References: <20250927223652.17018-1-nooraineqbal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250927223652.17018-1-nooraineqbal@gmail.com>

On Sun, Sep 28, 2025 at 04:06:52AM +0530, neqbal wrote:
> Correct end page calculation by subtracting 1 to prevent
> out-of-bounds access.
> 
> Reported-by: syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com
> Signed-off-by: neqbal <nooraineqbal@gmail.com>
> ---
>  arch/x86/mm/pat/set_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index d2d54b8c4dbb..daefc96403f1 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -446,7 +446,7 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
>  	}
>  
>  	start = fix_addr(__cpa_addr(cpa, 0));
> -	end =   fix_addr(__cpa_addr(cpa, cpa->numpages));
> +	end =   fix_addr(__cpa_addr(cpa, cpa->numpages - 1));
>  	if (cpa->force_flush_all)
>  		end = TLB_FLUSH_ALL;
>  
> -- 


I guess this got fixed differently:

f25785f9b088 ("x86/mm: Fix overflow in __cpa_addr()")

Thx. 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

