Return-Path: <linux-kernel+bounces-789250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D329B392C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760051B258EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA625A2CF;
	Thu, 28 Aug 2025 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kw5fvGj0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347C1EBA14
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756357585; cv=none; b=D1JSG1BEO/RXWykqMWbN1j5raXKneYbqUQaq7FO0M556R0Ic2mhiCL9U6oQFTRX02F9HWkWQV2t0nD8WPBh36zd8VZJtL69B2EQN/AsnoOx8h3Tg7bdU+U33aG42ziX+m1Ug106jpXY6i2QQh8Sb+DWkjd052dlfHx8fA0VwcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756357585; c=relaxed/simple;
	bh=vZ1o0zz6WMf4oXsp3Iyl/Tng2mtXOhVEQNMwXfa6LNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwq7jRM8DEYxzcw1wsi6LDUqCFe08j1nhgf5RTeYMed/T0eEDgzGQFWXs3+oo6yTJN11PpBuzn688j+m8MzwfYgkpIG/8+nbef+TAF8GDyno+rz8BPIFXGwulglgYvGfkrjsQij7I4Mx/32+CNaUaxQQDaqTcnqFkzD5o4f5XiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kw5fvGj0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24646202152so6796185ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756357583; x=1756962383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bj0F3xKSUaIs0J65GjGl570XOpaBhxurzoqhx6e2Cs0=;
        b=Kw5fvGj0+LTmKpa7R7skr9e7LPUU5eWzZPiKBlv55RoowKbgniMt9qTnBHG7GY4bD4
         1aCOsptoK8o+qlTlJUII6D5ApZqdWAIwVSzySP67wMP6nfcUaVoP/pVKkeP+W2EXJGeA
         8MAh/F6jhJN7BHVo0LhmjjiFn90+xH31gNfig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756357583; x=1756962383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj0F3xKSUaIs0J65GjGl570XOpaBhxurzoqhx6e2Cs0=;
        b=SyB3DZPseBj2rbCNufBMdJzgmcdgx3cBy/XoovBA/dMPMPZLaXghHlECcTE9mr84QT
         kZIsPVGdRzx6/Mj/NfR8IRc8bDbI0WvB7QK+04us+c0m5gP7H3hlEYI2PgiJbYB/6XMn
         NOtLkqw7ylT7ip168oYCd5dvOrBkeiWGEQ+oWy9y3xgS4y1BCBVt1o4TqikYdVrf019M
         /oe8/DbxlNh7Yxgg8j4h4rv1xQcvotKY8msfuIkhBALm8YO3ybB74enssxNSarJa9qIZ
         dW41cMXHzBIvEfIYobIAJJ9oRbb3EiXOzmJ5QadbOf0VfEI3XAAK02SgNY3RNw9XoRAo
         7KXg==
X-Gm-Message-State: AOJu0Yz5y0sgTE9gVUnsk+MtcTx1u37pyqwKTMZQDIEu/xlJ5otLzBGc
	yJ5j7wpoC0LhhF7+6kWbXLSgIX83WdqnOvvU15lfpnurZ7Dd8x081wGBC07gqVGJDg==
X-Gm-Gg: ASbGnctZbgmFmfHWHpYceZOS7Wjira//ADizPLqfpS8f0SP0ej363+rPz+pMxGYJUiG
	Hh4C5Y/FOxdFlIcUTvHJyNT1pKrAo1IYGZG6ni2iQaPqtrq9eMLv9OHekQloOu8NjxhYJtht+d5
	13QB1q2owNu8CvBni5vl/loldn6NoaiwfvsKR/twH61e2TMLrERlmVe0MtPslptoZP6Osoe2kVa
	VrrBrkPakXmf4haSDXqjgMKZ0MH4Xa+pZQNtZca1iQCOhXDIGw7hZlAeI/bsCGzpgK5F920UBW6
	c7iAb4Pe9ionIZOKw0Kz539kal86oCkyOvwgCtNejYAVluAq9mmrO1YV1/ugok80hZcXPiYa2mC
	pkLRcb8kXyHY1Gcqk5/f1V5tpxuYhXuIHCog6
X-Google-Smtp-Source: AGHT+IGFzXqVbx52FiYF4GbIQed6e1Rc69rllf8xeojp/PpiJVnMDg3NfKpiB0qKqfrDT5fxCIrDEQ==
X-Received: by 2002:a17:903:283:b0:246:61c:a67e with SMTP id d9443c01a7336-2462efdd639mr263243935ad.61.1756357583296;
        Wed, 27 Aug 2025 22:06:23 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5da4:f999:f527:70c9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885ed21sm137543975ad.98.2025.08.27.22.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 22:06:22 -0700 (PDT)
Date: Thu, 28 Aug 2025 14:06:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>, 
	Mel Gorman <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	kernel-dev@igalia.com, Helen Koike <koike@igalia.com>, 
	Matthew Wilcox <willy@infradead.org>, NeilBrown <neilb@suse.de>, 
	Thierry Reding <thierry.reding@gmail.com>, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: Re: [PATCH] mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH
 allocations
Message-ID: <xzjclrwdgtzeufjpposi4aqj37qe4cf5mla2mv4ss2fu7llrmp@r6yjikyew6ej>
References: <20250814172245.1259625-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814172245.1259625-1-cascardo@igalia.com>

On (25/08/14 14:22), Thadeu Lima de Souza Cascardo wrote:
> Commit 524c48072e56 ("mm/page_alloc: rename ALLOC_HIGH to
> ALLOC_MIN_RESERVE") is the start of a series that explains how __GFP_HIGH,
> which implies ALLOC_MIN_RESERVE, is going to be used instead of
> __GFP_ATOMIC for high atomic reserves.
> 
> Commit eb2e2b425c69 ("mm/page_alloc: explicitly record high-order atomic
> allocations in alloc_flags") introduced ALLOC_HIGHATOMIC for such
> allocations of order higher than 0. It still used __GFP_ATOMIC, though.
> 
> Then, commit 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
> non-blocking allocations accesses reserves") just turned that check for
> !__GFP_DIRECT_RECLAIM, ignoring that high atomic reserves were expected to
> test for __GFP_HIGH.
> 
> This leads to high atomic reserves being added for high-order GFP_NOWAIT
> allocations and others that clear __GFP_DIRECT_RECLAIM, which is
> unexpected. Later, those reserves lead to 0-order allocations going to the
> slow path and starting reclaim.
> 
> From /proc/pagetypeinfo, without the patch:
> 
> Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type   HighAtomic      1      8     10      9      7      3      0      0      0      0      0
> Node    0, zone   Normal, type   HighAtomic     64     20     12      5      0      0      0      0      0      0      0
> 
> With the patch:
> 
> Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0

[..]

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2ef3c07266b3..bf52e3bef626 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4219,7 +4219,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
>  			alloc_flags |= ALLOC_NON_BLOCK;
>  
> -			if (order > 0)
> +			if (order > 0 && (alloc_flags & ALLOC_MIN_RESERVE))
>  				alloc_flags |= ALLOC_HIGHATOMIC;
>  		}

From my limited understanding, it does look like this was the
intention.  Vlastimil, Mel, got a minute to take a look?

