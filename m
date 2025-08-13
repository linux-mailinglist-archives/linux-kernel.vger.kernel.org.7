Return-Path: <linux-kernel+bounces-766780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AE3B24B08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C47188E917
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E5E2A8C1;
	Wed, 13 Aug 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZX7OAEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625CC72612;
	Wed, 13 Aug 2025 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092732; cv=none; b=jYnI5fduAAW++GgAgtrvms1A+8HJ+g1+1JAmg/kEqrFgcSUVIPW7pmGEB7d9JgIwrH5LdFN3CRUXZwH1hYuoDQnEmKZuPez79rqbm9u67hwLGORDy0i7kPw0LV+A4BNPmdfUOgBzJCwYG+brde2JqSBevtQ+qHOO/Bfdf9xR+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092732; c=relaxed/simple;
	bh=D0xx7031UZevoMdpdp6ryj7WTHkAul4ivyREJrKlUK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CrtNoVW54oYQrvC+uMm+8b39FxOIQYB2ZyP7VWymwFoCfhFdgbKz76YGT0q4w089tzctwNC7SoadVKRL/faD0vU5YLdcVjz52twC2h6HX4qOHtiBCNBvizCzjZmhUINjW1sWaSwpKiWvmvtPo8WITBNmmSRKbaOU3kdERTdRf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZX7OAEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E37C4CEEB;
	Wed, 13 Aug 2025 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755092731;
	bh=D0xx7031UZevoMdpdp6ryj7WTHkAul4ivyREJrKlUK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lZX7OAEO4iV5S1+YXwOnpNeXysrLeSryC2YE5VkGmWFuQ1wIf+WHQIRsPfY64kEvv
	 QzcQMAowqKlFIJSrHE1eEuBK6vW1P1AekwkoCcjrd4HOlzlC6jenE3ECVGpLYdDivk
	 qyjpj02i46dkWEnCNEDjQSNs/9x6Jd21DB4k9HTMhz5nsiU0DfPOYMHteLZ1wJLASP
	 qpUPUOOVkMdmZ1Z9ow7qaMytrTTWQK6SBmBQ51D/RRDYYx10iAwqrguOIiiU8j9v8N
	 4iS480IBHW3v/cY6/gPBGGopu5lpSm9aIIhXlxXD27EoChcg/w8dp4NObDJYFg5pZk
	 akcmTCNvjNGFA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Shuah Khan <shuah@kernel.org>,
  Thomas Weischuh <linux@weissschuh.net>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 1/3] kho: allow scratch areas with zero size
In-Reply-To: <20250811082510.4154080-2-rppt@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
	<20250811082510.4154080-2-rppt@kernel.org>
Date: Wed, 13 Aug 2025 15:45:29 +0200
Message-ID: <mafs0349vwd1i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 11 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Parsing of kho_scratch parameter treats zero size as an invalid value,
> although it should be fine for user to request zero sized scratch area
> for some types if scratch memory, when for example there is no need to
> create scratch area in the low memory.

Can the system boot with 0 per-node memory? If not, then perhaps we
should only allow lowmem scratch to be zero?

>
> Treat zero as a valid value for a scratch area size but reject
> kho_scratch parameter that defines no scratch memory at all.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/kexec_handover.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index e49743ae52c5..c6ac5a5e51cb 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -385,6 +385,7 @@ static int __init kho_parse_scratch_size(char *p)
>  {
>  	size_t len;
>  	unsigned long sizes[3];
> +	size_t total_size = 0;
>  	int i;
>  
>  	if (!p)
> @@ -421,11 +422,15 @@ static int __init kho_parse_scratch_size(char *p)
>  		}
>  
>  		sizes[i] = memparse(p, &endp);
> -		if (!sizes[i] || endp == p)
> +		if (endp == p)
>  			return -EINVAL;
>  		p = endp;
> +		total_size += sizes[i];
>  	}
>  
> +	if (!total_size)
> +		return -EINVAL;
> +

Looks good. BTW, unrelated to this patch, but should we also check that
p == '\0' here to make sure the whole argument was consumed?


>  	scratch_size_lowmem = sizes[0];
>  	scratch_size_global = sizes[1];
>  	scratch_size_pernode = sizes[2];

-- 
Regards,
Pratyush Yadav

