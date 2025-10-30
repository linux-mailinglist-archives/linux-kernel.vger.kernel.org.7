Return-Path: <linux-kernel+bounces-878411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160DC208E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFE8B4F0757
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE222A4E9;
	Thu, 30 Oct 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6Wy8JZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47719E97B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833583; cv=none; b=ThGC+LeEY3w0a/kyHdXGnyDV4NK1LyXujlxesxihqD6JvqcYB/B7gw1JT9+v6fbcdCGOi1hE8Y0r0g223MqBnRFlyj4Pmxgucr4gPYM330BP+3tVkg18u4ljffXsw4tJK3MPWu5LJ+IeDBHWEtNThh8j5+oV/V/kjLQ7SjnPYPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833583; c=relaxed/simple;
	bh=2qJt4HkGJ5MheTVm3JmsFCxA93LEhVSRgx9nW6R2n/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr8emCGgyGqrGxNgfle/zQ5Bpxs+4ySA7H0P8457Ag+YFInx7WTsyh4RfB73PnL40ERKz9S15HnNHh7iZ3IlhkWXEb9TZHVAp+g7zbruIAQtTyBVA/gqXTym1O2Xv49i9Y3mxXwy9Jk77GNRgFBGmXnuJF6Xilh6L4Iu/L80fDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6Wy8JZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7346C4CEF1;
	Thu, 30 Oct 2025 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761833582;
	bh=2qJt4HkGJ5MheTVm3JmsFCxA93LEhVSRgx9nW6R2n/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6Wy8JZlNuduqxvw8H0lIQPOum53x/+obTNhygOS/7clrt4pVx28rAAn2wr4TM2Xd
	 gqQIUTTMoe9BA2XwzCUkJtCNPkEUCCz/Yjk4n3+qWtCFuw0e4UNI5l27fZRk+BveUG
	 YDIxPnBxDqyAyTuxH4/nIRygRJgU6ePZfU3aj0qUYmBq862CE3XvBzytYcKNYjpevQ
	 tsuobJ9+t89zJo3JLc004+GZQnR2oaHbcQGuNnTOwhDNok61i2lp2gDbqZ/IIeSNfW
	 0hTBvLarpuw9kbJe4Zoh5NqPoQurtlEm8L+PRrlxdiekTREBsLym4MUgNvI9chz+ya
	 ABuOeI7FeqhaQ==
Date: Thu, 30 Oct 2025 14:12:58 +0000
From: Will Deacon <will@kernel.org>
To: Josephine Pfeiffer <hi@josie.lol>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: ptdump: use seq_puts() in pt_dump_seq_puts()
 macro
Message-ID: <aQNyaoXKsMdkIDrc@willie-the-truck>
References: <20251018170416.3355249-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018170416.3355249-1-hi@josie.lol>

On Sat, Oct 18, 2025 at 07:04:16PM +0200, Josephine Pfeiffer wrote:
> The pt_dump_seq_puts() macro incorrectly uses seq_printf() instead of
> seq_puts(). This is both a performance issue and conceptually wrong,
> as the macro name suggests plain string output (puts) but the
> implementation uses formatted output (printf).
> 
> All call sites pass constant strings without format specifiers, so
> using seq_printf() adds unnecessary overhead for format string parsing.
> 
> This bug was introduced in commit ae5d1cf358a5 ("arm64: dump: Make the
> page table dumping seq_file optional") in 2016, where seq_puts() was
> replaced with a new pt_dump_seq_puts() macro that mistakenly used
> seq_printf().
> 
> Fixes: ae5d1cf358a5 ("arm64: dump: Make the page table dumping seq_file optional")
> Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
> ---
>  arch/arm64/mm/ptdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index ab9899ca1e5f..a35fcd62bf75 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -35,7 +35,7 @@
>  #define pt_dump_seq_puts(m, fmt)	\
>  ({					\
>  	if (m)				\
> -		seq_printf(m, fmt);	\
> +		seq_puts(m, fmt);	\
>  })

This looks fine to me but I'm slightly confused as this patch is marked
as 1/4 but I can't find the other three anywhere. Is that just an error
or is this part of a bigger series?

Thanks,

Will

