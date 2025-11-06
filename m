Return-Path: <linux-kernel+bounces-887622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C298BC38BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDD81A238E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2942225390;
	Thu,  6 Nov 2025 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lowElG/X"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CF222578
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393488; cv=none; b=rhwYqbXoVOs6Vlb2/9/jGsi9SvPsxSm3joF/MkLyGcXQ39TCG6+rOYkSs1BwD6v2bDHVJ7IWFBVOPmtR+Iqh75htH4ZbLe3J4SqWprL7wNho4PsPAq1QozoN6PqHAHxk2k02m4vvxyX9DajZcNhj3wu2YsyNs+A2D80vw37pp5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393488; c=relaxed/simple;
	bh=uXggKOOg8qY5wpScmPa1g6Myeb/kXJkE+8C71CpzpD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8sI2vglVfb3OENKWrBBbBO48u1dzAEsqnpkJsyf8udCWCmxTXXZAZ1/IGKMepMkh6XjYNv92dF/Nee8X/k+zx0UJfPuCeefbvS90agRslG5AIgOCqJgj/n0txjI0nPUDdLWijWAsm/xVZagZWP/5ok4s6mWvqNu/lZz+CmiDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lowElG/X; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b4f323cf89bso92647666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762393485; x=1762998285; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEEJ+LqV/J689MN97nUNzHTLqbjLFvnlgtqVatgdXXs=;
        b=lowElG/XMm4J7fCNhqLN5fd4fShzCa4IvCWlO8HJfAJrXngl3Z+kLu7m6hpgMfr0A0
         k7wIYTXWJmCg8S6lT551R8oxMUH8Q0JhcLTnLVm0+X8XJJX6d9USG+2zfmlmaLsyqUJl
         oAyZuB6gYS7ixOBZmAcvbG04w3FqJC/BtJBZvpQZg0no9Yb8yddfdgj/6HQ2AU5Gvn09
         gcO+tAT2T/JGacorBo4YYJs40tuy1td88BzdYTZ+Qc+Uu+v99xUTD2ar6j+O0rHGhdIo
         rJR7RVViNwEp3h3LD831sEUvVZPTjlqMBzjnCwOPEQ1tNxl8aUhDgP+5jKudrcyZQqia
         oEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762393485; x=1762998285;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rEEJ+LqV/J689MN97nUNzHTLqbjLFvnlgtqVatgdXXs=;
        b=siaCqPfho9fD+X5AHFZ9QtNnltmpIgrm8CgTLlWSgYDUtSAq0mfiYx3p0zacuuxhPJ
         cO4sGOykm27nutdX/0WTiVtpVsnYSLvGzu2phmrFY5IsDQM7BEsEk/gQdaYqGWZXdhM8
         CvyhvIrgM58RNZkdSTm5Fm93JAH1oSgxqAIxK7MJnV26dsyWJXqBTSihDUqoBGA2PqMe
         QLwU1EPHMVDYodw+rsmzrm946ZHz1XcIipErc2lwAapdm5v0dtxCMWN84ZS5rKHS7jyP
         5Ys31pFXtg1jhnn1p9t949m+IMmFs3RTZqvAkaH+i1XmThFDKTmdy2a4u4l8KsgpSean
         2lkg==
X-Forwarded-Encrypted: i=1; AJvYcCVNpxChvm6fbICJmYfpw9WrIkOoLff2Lb5hxNbzqvQn56UM0ixR/7jfxsg8oSz9K3jLU5l4O9CXx9C5o7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFn3Xn/9dNqNViax3axG/PWPmm9N7U4FzeogzVwWy9715fyzi
	hGkeOwdtQKYfKzMkEVF8PkmP/Crr7k+zmW+t7PGWzje2yx0sovGomTsb
X-Gm-Gg: ASbGnct7N7zZQ+/M6i1MDuGaqm7D7pCJeM2GZO6YJbGBhS8KnP0IQIXVb1aLUv6Iqdp
	nxsF2N4+wB3Z1Tr9ivPajvKfp4RdXAtSdbduA+JYNtyae6gScmXPYG3zKpEW78o0Hz97pveJH5F
	GnsSgEKdUogF9gKQ6NGJAOf66NZXAqeOpBHspV9iHXr00KUOxNuMeFUxhZ+JYv8rGO93NCLBSio
	1Loaxu3otokiyzZISisVZGGAVcTZY+1800hi6tuW6j3dheX0wPOcC07XGPZO5QF9pl/lsswb3Ha
	qmuFFgAN5SWJOOl7aRyaz4TAYaePvd72SYSs2lMTy7vZhSQX+46PWEvdb91tg6smS4qd85DQntL
	yAGoI0qJKD0l3wKFdnZWIL+M3FEnY5h8/3sUJvl5XjCd4Qgi7qCFzwuJiFpnY/cdqZvpLzH6TDm
	3D0mOwuysstA==
X-Google-Smtp-Source: AGHT+IHJEYTNNMqTgGZ5Z19ASHC1/aHl2q87qeR2t0TYHvehAhnbl1q6Hr7yQiLOC3CnEXe8R0EkYA==
X-Received: by 2002:a17:907:7241:b0:b6d:5914:30c with SMTP id a640c23a62f3a-b7265588257mr472200766b.34.1762393484633;
        Wed, 05 Nov 2025 17:44:44 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c93b6sm94181466b.69.2025.11.05.17.44.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Nov 2025 17:44:44 -0800 (PST)
Date: Thu, 6 Nov 2025 01:44:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix folio split check for anon folios in
 swapcache.
Message-ID: <20251106014443.wkurq6p7ofhsffkn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251105162910.752266-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105162910.752266-1-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Nov 05, 2025 at 11:29:10AM -0500, Zi Yan wrote:
>Both uniform and non uniform split check missed the check to prevent
>splitting anon folios in swapcache to non-zero order. Fix the check.
>
>Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-uniform) folio_split()")
>Reported-by: "David Hildenbrand (Red Hat)" <david@kernel.org>
>Closes: https://lore.kernel.org/all/dc0ecc2c-4089-484f-917f-920fdca4c898@kernel.org/
>Cc: stable@vger.kernel.org
>Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

