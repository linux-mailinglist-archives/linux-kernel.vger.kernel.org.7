Return-Path: <linux-kernel+bounces-846563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD0BC85BB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C543E7D48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AB328CF42;
	Thu,  9 Oct 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqLjJHWT"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D2258CE1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003174; cv=none; b=jmiyii48KflmzmrLC02zNvGHMnKK1hlxX/CsNCMM0wmh53sKpDkE31x4kYpfiWI6VF5wY1nSe0eX63MTDrkz6Za3l/FzshxfcrtqYOxgeo4x1uV0xCYw2zIeZwSGGommLHQKlWIM2MYDjjWNwrAYgo7ZQWX9Vscp3+STsr+XP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003174; c=relaxed/simple;
	bh=ROUZm5wxzuP9i5ZKHXvBx6k4EahBX1SW+34XynRG1M4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVGp52ED+MwB3OxhWlSOEHtMzVqII+OaiDMZN1kjs/3UGKoR/+qBSMFQk4o8eO0OGsfepYgIR72PeTx9nlaaNWoQ9+E7EtxPH6uj3auiFxPnN2GEw6SCq6DnJvz2SWA7YBWLqexKUEpCldSwJMGdSeBmrDNplbAJUpKTtg24JPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqLjJHWT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36a6a397477so7043271fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760003171; x=1760607971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2ege6p4pcLOxc2jHHJkbOlbvAgh1MwdywY3Y/8BKGY=;
        b=kqLjJHWTTX6rKnQEXCZ3FHtWxijpF5bBMwsbw6QOdr8+daKUBtIL7v87iPg7JcB/AQ
         P8F+yUrIALo05AtULoksDgHngktcbZlrfNo0/kMp2UtK4Lqa2oyTfSyQQlIZuS/Fvov7
         XQXtalnB+rXv7tAQ4EiwfI6ZqGb387gnmv1WQ37IGsSFW6qooaA+I85jTGWUA3WA17Ec
         ieeznPMaDgLlfbCxc5ReGccNpaTSKTdPerzLSM1kjLobTYqwwytkAY8gV377wO+7gJ73
         4ZDPmU1wNsxjdwIzzAbQs1Cn6lKDGv3uwArjJ6mRNc902MzrJSo980co5qhOpXXrzu3b
         jHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760003171; x=1760607971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2ege6p4pcLOxc2jHHJkbOlbvAgh1MwdywY3Y/8BKGY=;
        b=XtZf6Qn4YshCPDhxANAZnE845sCltajoPIOBNy54Dxjq00F/xGPxLSeV6zHsWvDu+e
         PLfqAyjmVu/O+eBhq4aZ84C25ho/RRNUKwDrh0qHjoVbxk/DRrSBr/0U5a5jvF+OX9Rt
         DIXz6p3QpOk2tpQwpiz7VuwACJAFlVLaKZHL/efTEnVWJpaLeVT4R7B4bSmeJnQkxklX
         +BXIHz1AeOBRpjuTTSjUjC1Ls7kJV8D3RAQIu6TiuG2x8vULwBoI5lwR70jqPfQzwp8J
         iOZeWkF4ZAnXoFBybn/+X3a2DXFUo8G77+V7O9I82tm7pz1UCxoR9eOb08N8wKIchwW3
         DnQw==
X-Forwarded-Encrypted: i=1; AJvYcCWBZ8dy3OpRCNXIZjUX652z9mWhpDSg9UlTTXdB4SJz7ETlju5iy/qFzb9mstY5pfvnFL762XDyqOv671I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEScHZRpzDWbvQvn8u/N9sE5TIA5EFMB6z9cmjYXJjLdpCZq/
	hyKMFuc9V4wU764NAp6p1YhtXEiwSHiGoYFG/H9DddIiZaR0Wnw/lTA5C87XPw/z
X-Gm-Gg: ASbGncsztG6QCGdwwZLT+d+A6iKcjX1d/pXB8Z+xVdnIYWH6+IOduHGSLk911Giaswq
	wcLX+83ChFhkpLt57oWQNy62x+0Fs1lvf6yvqx7t4EaiXAXn5QszaKXmFJj+xPzPqhf8DS5abAs
	ruynTmaQ0ixvybBLeltQpLciXAOQXbx+71yLMoR5QsIli0IIh4TC/+aRb3gDOpnB5EXLU9McXdF
	5w4Bdd7ULtduTG97LE1frQKZ0q5N/b0ALAvQhNPRrOMQ9/ssHzQR0NJJ1tg8UAWZFf1yzPDFacN
	+QmWSRKqGZFCdZmIslkRNFuweOyw7vLuRTWIBPexdDBDt6vTx7tCoJ4mip3i10F85mGFYzulagt
	ZxJ4HUx4VlfiBiw==
X-Google-Smtp-Source: AGHT+IHIGQmG8W0O+2Vu70RarOUbKPKl/GJ5/m7NuOCVAVqJsmpKi2KtI5lu/0gEjf9/tM0Q/oJFGA==
X-Received: by 2002:a05:651c:984:b0:372:8cce:2360 with SMTP id 38308e7fff4ca-37609d685d1mr14651341fa.14.1760003170463;
        Thu, 09 Oct 2025 02:46:10 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907aeb6b29sm857369e87.130.2025.10.09.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:46:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 9 Oct 2025 11:46:08 +0200
To: Yadong Qi <yadong.qi@linux.alibaba.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ying.huang@linux.alibaba.com
Subject: Re: [PATCH v3] mm: vmalloc: WARN_ON if mapping size is not PAGE_SIZE
 aligned
Message-ID: <aOeEYHzXUVOpu174@milan>
References: <20251009093707.868-1-yadong.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009093707.868-1-yadong.qi@linux.alibaba.com>

On Thu, Oct 09, 2025 at 05:37:06PM +0800, Yadong Qi wrote:
> In mm/vmalloc.c, the function vmap_pte_range() assumes that the
> mapping size is aligned to PAGE_SIZE. If this assumption is
> violated, the loop will become infinite because the termination
> condition (`addr != end`) will never be met. This can lead to
> overwriting other VA ranges and/or random pages physically follow
> the page table.
> 
> It's the caller's responsibility to ensure that the mapping size
> is aligned to PAGE_SIZE. However, the memory corruption is hard
> to root cause. To identify the programming error in the caller
> easier, check whether the mapping size is PAGE_SIZE aligned with
> WARN_ON().
> 
> Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> ---
> v2 -> v3:
>   * change error code from ENOMEM to EINVAL
>   * modify callers of vmap_pte_range to handle return code
> v1 -> v2:
>   * Use WARN_ON instead of BUG_ON
> ---
>  mm/vmalloc.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5edd536ba9d2..1fa52f203795 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -100,6 +100,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	struct page *page;
>  	unsigned long size = PAGE_SIZE;
>  
> +	if (WARN_ON(!PAGE_ALIGNED(end - addr)))
>
And it might be worth to use WARN_ON_ONCE() otherwise there is a risk
that a kernel buffer would contain only such warnings.

--
Uladzislau Rezki

