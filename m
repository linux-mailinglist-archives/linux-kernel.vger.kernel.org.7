Return-Path: <linux-kernel+bounces-825368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5970B8BB07
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F281C0589C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA651DF252;
	Sat, 20 Sep 2025 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw4hW/JJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0EA1D61B7
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327737; cv=none; b=eCZZ/eedwqQpN8bZHDmfRKHkfVrLHjAm9xCCjyfZSh3NabeXTnLmwSfOucAw2KovLzS2KLpxw9F25TRwoBew8GhnSfDLoCXFTBFoRGfTbJaFa5VyIcZyfTuaRvzNK5Bp6B5ENNzKxisVH9uAQQEmFBeTivc0U3nBrlmDlQZf49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327737; c=relaxed/simple;
	bh=4DvAhjw4ydnznZHTJDEhOcF/tHwQ2EFCjGBPnhBV/rU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IlFJteJzCZXnrCLJX85a2Vl5lZwXLJk7kxuUw1mYflinYoOy0nPM/PzgmFJK27FEioSbeBMzcsgsbRjQ4tYhKvWxF7i281DDrCkwtuJYtcjSrk9YGdYmmOKplGsHIYGZfc2msr6Ci0aj9aBFzUcctsEbWpBCrCE73lSsjYC9Ebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw4hW/JJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1BEC4CEF0;
	Sat, 20 Sep 2025 00:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327735;
	bh=4DvAhjw4ydnznZHTJDEhOcF/tHwQ2EFCjGBPnhBV/rU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=Sw4hW/JJuUClLwFhQQ3T/zrzvXM1zpWH2fTSVyaP+Cl/MXKlSr5ZVDldfhiIFhHYu
	 tMX4o0WxIKgruu6wW+ahI/zwBPPAa3rdDijd0aESFnaaNzUJ+fKCJfYYx+XbqDyDMj
	 pmp9K0pLC9xXkzB8bL/hgeHTUFWuLNAlKUT36sA69BoevRBVjr91T8FFtXwit7bZG5
	 qqbS6pAJAwEJIk5sV1S/NN9ujYNvQqXwpIdJQSZcoDy0Mhjmt0oh0mZxJl19eFzimt
	 pQUp6aXz1AMxyVgqxadxcqp9EsngIRftXg70Myr5Yq4EcZWnBzngX5dNgb/VGZNCMR
	 HbhAZILxCM8Sw==
Message-ID: <72f0108c-ce6c-4f89-b04d-2398d7c808a5@kernel.org>
Date: Sat, 20 Sep 2025 01:22:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH] bpf: fix netfilter link comparison to handle unsigned
 flags
To: Haofeng Li <920484857@qq.com>, Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 Haofeng Li <13266079573@163.com>, lihaofeng <lihaofeng@kylinos.cn>
References: <tencent_9196B487ED0904A6B2F921A50EECF4D6CB0A@qq.com>
Content-Language: en-GB
In-Reply-To: <tencent_9196B487ED0904A6B2F921A50EECF4D6CB0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-19 17:04 UTC+0800 ~ Haofeng Li <920484857@qq.com>
> From: lihaofeng <lihaofeng@kylinos.cn>
> 
> The original implementation of netfilter_link_compar() used subtraction
> to compare the netfilter.flags field, which is  an unsigned type.
> This could result in incorrect comparison results when the unsigned
> value wrapped around due to underflow.
> 
> Changed the comparison logic for flags to use explicit conditional
> checks (similar to how priority is handled) instead of subtraction,
> ensuring correct negative/zero/positive return values regardless of
> the underlying data type.
> 
> This fixes potential sorting issues when using this comparison function
> with algorithms like qsort() or bsearch().
> 
> Signed-off-by: lihaofeng <lihaofeng@kylinos.cn>
> ---
>  tools/bpf/bpftool/net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index cfc6f944f7c3..9f840821beda 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -816,7 +816,11 @@ static int netfilter_link_compar(const void *a, const void *b)
>  	if (nfa->netfilter.priority > nfb->netfilter.priority)
>  		return 1;
>  
> -	return nfa->netfilter.flags - nfb->netfilter.flags;
> +	if (nfa->netfilter.flags < nfb->netfilter.flags)
> +		return -1;
> +	if (nfa->netfilter.flags > nfb->netfilter.flags)
> +		return 1;
> +	return 0;
>  }
>  

Thanks! Did you actually observe an overflow producing an error when
sorting, here? Or did you run into some compiler warning? If I'm not
mistaken you'd need the difference between flags for nfa and nfb to be
bigger than 1 << 31 for the sign to reverse. As far as I can tell, the
netfilter.flags can be 0 or 1, so this is unlikely to happen. I note
that fields netfilter.pf and netfilter.hooknum are processed in a
similar way earlier in the function, with the types allowing overflows
but possible values preventing the comparison to reverse in practice.

This being said, I don't mind making the code cleaner for these
comparisons, but we should probably treat all three attributes the same,
and update the rest of the function as well?

Quentin

