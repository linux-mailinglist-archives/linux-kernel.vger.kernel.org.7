Return-Path: <linux-kernel+bounces-825047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2951B8ACD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD2C58088F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05E322A15;
	Fri, 19 Sep 2025 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1k1f7Rn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F30321F54
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304043; cv=none; b=i/0Wmy8zf7yhFtlzdTyo25yEVMtaESNoVMoNa6qx6vrh7CB/t1IbXuVdi3gj3q9sG3SRD7mMiDPtNzu4A5rKGChuafLdqEDKh/OSh5upGx8VO542lLsVvOjWypZUFSgeNr7RXPOr2ihnHlYSNaD8AkyRChJcpZ7XH8OIq9dcLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304043; c=relaxed/simple;
	bh=n+KgshepexF/kdJqeLiSuQBGX049soAzwhgy949zX78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg1eU7ZiANBzu8QS/hTZAmj0pCFmviWPpevjepFzNwSJdVBqmMedNb+XSggDpNpux0VmzZqjwndv+GVziki+wHpHbmDjRsZ59Ipo4F3/UU/1zStK5L7JQGXgR5rDnhZ4/g27HvCS+oC7/6Yu/Y17cHLC9Cd+SIkUtwA1zK0F7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1k1f7Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E694BC4CEF0;
	Fri, 19 Sep 2025 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758304041;
	bh=n+KgshepexF/kdJqeLiSuQBGX049soAzwhgy949zX78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1k1f7RnsOxiR1co63JYTCi3v21F+im+d3E9sU3AuLJzAMg3Ghno6HOnYn/zpI6yP
	 3bLHZbw0OTRB/KmB2PcJgEvHYhMl6Kzki0/WFLak5Gkl7bsQb5jEJWK3vicOSdhLK2
	 +PpJlsJKRDxpvqzOM/GiOsOj5uoUL22S6CTwYntXzXUvhwEV0U9gBicwycLYNjNW+5
	 XidjAOApWpH/C4HU1W0tolvl8fDl6O5r3Lv3Zfu8jjv/S9bQR97nG6HxQf6YqML2Ov
	 gd6tZ/sDtQlXFpn0ZcE3q7xw5h5Mzy6Et/QsvGa8kXvkgpg4oNiEN3M1paV+kSM0sZ
	 PQopDmAme6nLQ==
Date: Fri, 19 Sep 2025 10:47:19 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] objtool: speedup subsequent calls to
 dead_end_function()
Message-ID: <pkmbl4rn35vugayytvy7hhyfahkyckv6bpsm2tpip24cauhxfs@3skfkcyq2is6>
References: <20250919135557.280852-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919135557.280852-1-dmantipov@yandex.ru>

On Fri, Sep 19, 2025 at 04:55:57PM +0300, Dmitry Antipov wrote:
> Running over KASAN-enabled vmlinux.o, some functions comes from the
> sanitizer runtime may be processed by 'dead_end_function()' a lot of
> times, so it's reasonable to record the result in 'struct symbol' of
> the relevant function. Briefly testing over huge 'make allyesconfig'
> vmlinux.o, this may speedup objtool by nearly 10%.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  tools/objtool/check.c               | 5 ++++-
>  tools/objtool/include/objtool/elf.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index d14f20ef1db1..d4c0ef419b95 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -322,7 +322,10 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  
>  static bool dead_end_function(struct objtool_file *file, struct symbol *func)
>  {
> -	return __dead_end_function(file, func, 0);
> +	if (func->functype == UNKNOWN)
> +		func->functype = (__dead_end_function(file, func, 0)
> +				  ? NORETURN : REGULAR);
> +	return func->functype == NORETURN;
>  }

Thanks for the patch.

Since this basically gets called at least once for every function
anyway, how about we just identify them during init, all at once, in
decode_sections()?  Then we only need a single "noreturn" bit.

-- 
Josh

