Return-Path: <linux-kernel+bounces-883686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2298C2E138
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112603A891B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A862BEFF3;
	Mon,  3 Nov 2025 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="phvmLlp1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EF2116F4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203719; cv=none; b=i6ZCeKK839EG4XqOP8QBAFqMMLCYgqp4GusWVQ9Vp96vUo4eEcxrrx4LQf1sVxq83XBB47AODK8IakE72ec2VAi4RyMLfe8jRhEItiBiDMgVhS//kNw4+S5jWgSGwEix9heMDs3s1zqw2be/9hrDCnY26TbXmd3OIElHshvQZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203719; c=relaxed/simple;
	bh=FhvL4guKH1HEh5pPnbYJOFNcoqm7tHoqc3iMtHu7ZGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVzLWxKwvixTyXEOIaY/fB+3q5qQjFLlbkwkQYMnNu0iJRNGykYdaxclOZnZ+2k8B9c9F7eV/0jSergcI3U3tOYYU/S1P2EeX9WA5o6WzHz2QLLKRoMbiDoo0eIT1v3i5+Rb+P/3bjahigvlSYEUhheX5381aINvUgbX59oUiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=phvmLlp1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G59xETWvtPohls4d4e90R0pJZx/F1Keg5iWPNwE1E7s=; b=phvmLlp1g2t6qtVspUnX17jVi/
	k5zLMuKyR3qzKtf4x+Dzxls9XDBlHmcbqu985SURuNkp3V3ww62oFaJLV8m++2JzV6L54B39iKMGu
	rPV6hD02I62e4TCjWnDclQWpQGdM9dDt9Ue4WoieJL+XAhioGD5AidrSGrJLYYBG5T+MTYjiwNuC/
	1kGzVsUqMkYCUM4zn6vckuwQbEzmmml7JE52ha9+6JyVdBJwJIk4nxBzK2wGPhe2EUTrEc9kKBjkN
	Xbabpe25vlkxagh8NbnQ3vacLwJM7QIellwFyI+GTT9GIf6T/CaphUtNtlxPJlJdrj1CILAeeTxhh
	m+Lhd7ag==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0oq-0000000GHhr-3oTF;
	Mon, 03 Nov 2025 20:06:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A68A2300220; Mon, 03 Nov 2025 22:01:53 +0100 (CET)
Date: Mon, 3 Nov 2025 22:01:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: xur@google.com
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	Sriraman Tallam <tmsriram@google.com>,
	Han Shen <shenhan@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Subject: Re: [PATCH 1/2] objtool: fix the check for dead_end function with
 multiple sibliing calls
Message-ID: <20251103210153.GJ3245006@noisy.programming.kicks-ass.net>
References: <20251103185154.1933872-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103185154.1933872-1-xur@google.com>

On Mon, Nov 03, 2025 at 06:51:53PM +0000, xur@google.com wrote:
> From: Rong Xu <xur@google.com>
> 
> If a function has multiple sibling calls, the dead_end check should
> only return true if all sibling call targets are also dead_end
> functions.

Cute, however did you find this?

> Signed-off-by: Rong Xu <xur@google.com>
> Reviewed-by: Sriraman Tallam <tmsriram@google.com>
> Reviewed-by: Han Shen <shenhan@google.com>
> Reviewed-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> ---
>  tools/objtool/check.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 9004fbc067693..c2ee3c3a84a62 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -314,7 +314,13 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  				return false;
>  			}
>  
> -			return __dead_end_function(file, insn_func(dest), recursion+1);
> +			/*
> +			 * A function can have multiple sibling calls. All of
> +			 * them need to be dead ends for the function to be a
> +			 * dead end too.
> +			 */
> +			if (!__dead_end_function(file, insn_func(dest), recursion+1))
> +				return false;
>  		}
>  	}
>  
> 
> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> -- 
> 2.51.2.997.g839fc31de9-goog
> 

