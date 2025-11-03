Return-Path: <linux-kernel+bounces-883695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F1C2E220
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEC11897D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E02C325B;
	Mon,  3 Nov 2025 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VjXiriO7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0362727E0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204756; cv=none; b=dKrX3ReRAxW8uQFP2R6C6lfiSTaiY7SSPdRv5uOL8bo2gW1vu3Vk65ekRNsQ54nk6G5AhmOCx85dfHHz/tmN2FptIY6zO4uStvkJ6al3+Rubv+cMqqK4fVvqT37Y55B5Ff52g3WhAHJguiiWtM6ZhCwCLKG/BlcuUpS8Yi5ccck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204756; c=relaxed/simple;
	bh=ijxUOa5YVD0PYF+50SflYtYxl6/b5Wia358mYbTcmeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFm39DUtbVzSz+Eh4jj+Y2CoNcKkExg6B0pk6UJwS9z7TlsmMoot8NxyTDF7bg3XLSFkXfcXRnoJYndFaKhnIALLG3C8DBB/HTPlZZfOnC644yJD4cqkPC+SUcvUo9cxJt5nUHmrLUQ+8w9GieOEJFmZC4ah+pMUjVOeoGjeVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VjXiriO7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Aaby5z03Dk35/PQOrsPiH5dUTSzW+1JeNBFvKTsgV0Q=; b=VjXiriO7cbMPjDX9PZZVas0cRo
	bCRmRIQkUHex1ehtUdosaR5dJGFT1mlYLjpENonR8kUgBKXeT6sKIUIfkFBMdcK6FlxHUeIG/u4yv
	H8yq8MM1LBl/kdEmLC3kTHsjRHI7wNCU0DceBUKib3TXfmImOxdEWa3Op76PuDptjYkq4CY5iNtg7
	o+9//Vy81zvBw8VKc2CNy15/QVdv3JwoPUj03dRYh4KjBQPME11H19B+Bj4yAzxVxWsF2mmKh13pP
	N1RrzNnBTFEfIlwHKt1DmBayfcn3X/QzAun4I4tvSYxcR+fZaQNZxQ80WU2s3IFEBsrsHAkNr7flw
	wQXy8T8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG1xF-000000011Un-3wEi;
	Mon, 03 Nov 2025 21:19:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E863300230; Mon, 03 Nov 2025 22:19:10 +0100 (CET)
Date: Mon, 3 Nov 2025 22:19:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: xur@google.com
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	Sriraman Tallam <tmsriram@google.com>,
	Han Shen <shenhan@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Subject: Re: [PATCH 2/2] objtool: dead_end function change for split functions
Message-ID: <20251103211910.GK3245006@noisy.programming.kicks-ass.net>
References: <20251103185154.1933872-1-xur@google.com>
 <20251103185154.1933872-2-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103185154.1933872-2-xur@google.com>

On Mon, Nov 03, 2025 at 06:51:54PM +0000, xur@google.com wrote:
> From: Rong Xu <xur@google.com>
> 
> Function Splitting can potentially move all return instructions
> into the cold (infrequently executed) section of the function.
> If this happens, the original function might be incorrectly
> flagged as a dead-end function.
> 
> The consequence is an incomplete ORC table, which leads to an unwind
> error, and subsequently, a livepatch failure.
> 
> This patch adds the support of the dead_end_function check for
> split function.
> 
> Signed-off-by: Rong Xu <xur@google.com>
> Reviewed-by: Sriraman Tallam <tmsriram@google.com>
> Reviewed-by: Han Shen <shenhan@google.com>
> Reviewed-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> ---
>  tools/objtool/check.c | 88 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 69 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index c2ee3c3a84a62..b752cf508d09a 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -237,6 +237,73 @@ static bool is_rust_noreturn(const struct symbol *func)
>  		str_ends_with(func->name, "_fail"));
>  }
>  
> +static bool __dead_end_function(struct objtool_file *, struct symbol *, int);
> +
> +/*
> + * Check if the target of a sibling_call instruction is a dead_end function.
> + * Note insn must be a sibling call.
> + */
> +static inline bool __dead_end_sibling_call(struct objtool_file *file,
> +		struct instruction *insn, int recursion) {

Please: cino=(0:0
also for functions { on a new line.

> +	struct instruction *dest = insn->jump_dest;
> +
> +	if (!dest)
> +		/* sibling call to another file */
> +		return false;

I know this is just code movement, but this wants {} per coding style.

> +
> +	/* local sibling call */
> +	if (recursion == 5) {
> +		/*
> +		 * Infinite recursion: two functions have
> +		 * sibling calls to each other.  This is a very
> +		 * rare case.  It means they aren't dead ends.
> +		 */
> +		return false;
> +	}
> +
> +	return __dead_end_function(file, insn_func(dest), recursion+1);
> +}
> +
> +/*
> + * Handling split functions. Mimic the workflow in __dead_end_function.
> + */
> +static bool __dead_end_split_func(struct objtool_file *file,
> +			struct symbol *func, int recursion)

cino=(0:0

> +{
> +	char section_name[256];
> +	struct section *sec;
> +	struct instruction *insn;
> +
> +	/*
> +	 * Use a fixed-size buffer (max 256) to avoid malloc. If the section
> +	 * length exceeds this limit, we return a conservative value. This is
> +	 * a safe fallback and does not compromise functional correctness.
> +	 */
> +	if (snprintf(section_name, sizeof(section_name), ".text.split.%s",
> +		     func->name) >= sizeof(section_name)) {

That is a terribly confusing line-break to read. Might've been better to
split after the greate-or-equal sign.

> +		fprintf(stderr, "Error: Function name '%s' too long.\n", func->name);
> +		return false;
> +	}
> +
> +	sec = find_section_by_name(file->elf, section_name);
> +	if (!sec)
> +		return false;
> +
> +	sec_for_each_insn(file, sec, insn) {
> +		if (insn->type == INSN_RETURN)
> +			return false;
> +	}
> +
> +	sec_for_each_insn(file, sec, insn) {
> +		if (is_sibling_call(insn)) {
> +			if (!__dead_end_sibling_call(file, insn, recursion))
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * This checks to see if the given function is a "noreturn" function.
>   *
> @@ -298,33 +365,16 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  	 */
>  	func_for_each_insn(file, func, insn) {
>  		if (is_sibling_call(insn)) {
> -			struct instruction *dest = insn->jump_dest;
> -
> -			if (!dest)
> -				/* sibling call to another file */
> -				return false;
> -
> -			/* local sibling call */
> -			if (recursion == 5) {
> -				/*
> -				 * Infinite recursion: two functions have
> -				 * sibling calls to each other.  This is a very
> -				 * rare case.  It means they aren't dead ends.
> -				 */
> -				return false;
> -			}
> -
>  			/*
>  			 * A function can have multiple sibling calls. All of
>  			 * them need to be dead ends for the function to be a
>  			 * dead end too.
>  			 */
> -			if (!__dead_end_function(file, insn_func(dest), recursion+1))
> +			if (!__dead_end_sibling_call(file, insn, recursion))
>  				return false;
>  		}
>  	}
> -
> -	return true;
> +	return __dead_end_split_func(file, func, recursion);
>  }

Aside from some coding style nits, this seems like it will do.


