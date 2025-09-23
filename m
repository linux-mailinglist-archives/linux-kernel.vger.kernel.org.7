Return-Path: <linux-kernel+bounces-829721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C066B97B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F23C2E8513
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F130BB9E;
	Tue, 23 Sep 2025 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGcyIsqY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64587A48
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666331; cv=none; b=tSYFfXLlghwlqT52Cmk7IbQ66s/7hioCFrd1jT6nZVmQ2rytGGxOynb9KZUuxirKHQ0DM9ON8gg52M+iBoyJ+89n/DtKxYOuQJA/5ic8ekBA7Y585VyXEJy3t/LDRA3axxb9kwandiBtlJd7uX6gykmzWXydDKYc2jMffSPh4jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666331; c=relaxed/simple;
	bh=G3A1DDpwmpxbuzxfrNatNcTJfyAeheA//QY9aV5ywfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp1FLq8g3x/ukiDpVA4LvS9T11FvcAfUmw85miOERyci8+N4/gDf3WAGIiaPhOo63wntvH6a4rHl8HqdNOlMoQBs19LSYJebR9/BbMX+9H3ch8vpxrF013GuCO6EPVFFiVTmpW2OB8cJBd+5EPxmvQeUORkw3MuD78QGI+NZJhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGcyIsqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56887C4CEF5;
	Tue, 23 Sep 2025 22:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758666331;
	bh=G3A1DDpwmpxbuzxfrNatNcTJfyAeheA//QY9aV5ywfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGcyIsqYYs7uqyIs+ws91Rj5NgjjMK5Y5l0tSNfuE1ToPsu8uecvEsnrQwfHPrJiC
	 t22/mFn9FO5eSeGqaavd0ApJJ10FXk3Mx7ycu/vDWHRBAvVxevpJaWMf7uNsiZnmmC
	 BTWW1k3iAJz/ev7+M4Hc7oAxwXen6YxqIykdvBn1fn9+RIR9crrq6kNdQumPYeyakV
	 fsFdZ3hK89X62WzysiwvB6ilDNqvTrEAUEi2g7gZ3b+HYayll+SifbyThk1z1u3+Om
	 PgclpPg3nuau+MzpQOG9FRxRHYpV2sR+HGYi6VQ4GeJCmgjxTZ3ZnLJlrqcVFvyokM
	 5C7JsEr1czstA==
Date: Tue, 23 Sep 2025 15:25:28 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH v2 11/17] objtool: Add option to trace function
 validation
Message-ID: <7oixcq3uauympfawfkbilfgb65jwgsm3ud4luibx4rawl7kwcg@plf6oq62fmpm>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250619145659.1377970-12-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619145659.1377970-12-alexandre.chartre@oracle.com>

On Thu, Jun 19, 2025 at 04:56:53PM +0200, Alexandre Chartre wrote:
> @@ -3796,6 +3843,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  			if (file->ignore_unreachables)
>  				return 0;
>  
> +			TRACE_INSN(insn, "falls through to next function");
> +
>  			WARN("%s() falls through to next function %s()",
>  			     func->name, insn_func(insn)->name);

Why duplicate the warning?

>  			func->warned = 1;
> @@ -3805,10 +3854,15 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  
>  		ret = validate_insn(file, func, insn, &state, prev_insn, next_insn,
>  				    &dead_end);
> -		if (dead_end)
> -			break;
>  
> -		if (!next_insn) {
> +		if (!insn->trace) {
> +			if (ret)
> +				TRACE_INSN(insn, "warning (%d)", ret);
> +			else
> +				TRACE_INSN(insn, NULL);
> +		}

What does "TRACE_INSN(insn, NULL)" do?

> @@ -4237,9 +4304,19 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
>  	if (opts.uaccess)
>  		state->uaccess = sym->uaccess_safe;
>  
> +	if (opts.trace && !fnmatch(opts.trace, sym->name, 0)) {
> +		trace_enable();
> +		TRACE("%s: validation begin\n", sym->name);
> +	}
> +
>  	ret = validate_branch(file, insn_func(insn), insn, *state);
>  	if (ret)
>  		BT_INSN(insn, "<=== (sym)");
> +
> +	TRACE("%s: validation %s\n\n", sym->name, ret ? "failed" : "end");
> +	trace_disable();
> +
> +
>  	return ret;

extra newline

-- 
Josh

