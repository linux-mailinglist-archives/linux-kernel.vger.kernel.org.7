Return-Path: <linux-kernel+bounces-730253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D579B041E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4842E4A6D51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9F22561D1;
	Mon, 14 Jul 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UkQen5oe"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCDF257AC8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503830; cv=none; b=faiTtvLH3fTpCU5ssjS/Hb5bWbcjsBnaL4wBDNLfebM1aIfkPl4+FgfnqXRoQ5p98vboLDdCvsFuVO+OIcdPXqLmkKbch5ZiCqIdh1hI2W1alL5iaPgiuxbiY3YE46sJdWuwzY2SzfR//oNzxJlZRCyc1Rl5GzMPWDoOyTtRbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503830; c=relaxed/simple;
	bh=jfkbhYru0bFIk2VctfQAth663ehySmtvE2nRp1sPZ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv0V84W23rci0Mtf4HiIAUQtmBR8o6JaePTZCJ6wp1cdoBqE39KiJErLqbAepD2u6Ltsu+tLmDM+hSQwU5/wrDVUppSomndZ1KDjAcMEMWMDjzQqp2ecVCxSHQF596icYmGjvOCqRarMfqreRRgh0oj14Sv/C4n6MgrmskWncdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UkQen5oe; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fabe9446a0so36217356d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752503828; x=1753108628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyTDdbiheRnKMGdgHLnRikk86cXTsPCJomYNsFHd9a0=;
        b=UkQen5oerwUz9GRDqQGIx2SBdnosXT6OKxAHWSabNiZAHcfpWLOZ9o5zoBNVOZEZzl
         XaJne/HuiGsSwFXNd4ZHh8OBzdKq2YwFrx3TFqKmX7dnZyCCQ1c6Djp1b7v3rsYs4sU/
         DIbKcXVUgoBJwRtaLyARSV6qSQty+ND8ytIyMly57A2m/CPqci7ztsaEaO7dCTuIdN4g
         qneMVrVCa0AMjnZYQpRdf/qGCcs0xcKuIu8PFy02nmtizdVSHQMJ6ZcOoXMB1WODLUcG
         gvG5e1AuI9S6l5Wk4B7FmjALBDZcof+5TsWWo/zUDwauIfkCaodZgUzo1vnbjeN7MHNK
         WG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503828; x=1753108628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyTDdbiheRnKMGdgHLnRikk86cXTsPCJomYNsFHd9a0=;
        b=VkhFW3YUyV9dtr3typclYmVARJs0GPgVCpyuKsRTLqeD7ZsU8dJvJZrcwWRC7nOjbi
         ni96o4rbXZdZu6Aplq+YXanYKDLb7tpyV6ccWShC/8zWC3hQgHb0Z0KdA0Tekny9fuet
         eaZ0GUGg9IZxj81b6dxtE1rSIgAXAZThy0zZV+QldxpHnyA5XCs3cH9dbdWwBE8YpG1e
         lVQrkDW7clLgW+2At0Lu5PWyg0j69jKHstgyD6Tj4FNTuqCwIoHlKep7J76dhyFrcmZx
         ey/SVrqaJWxu3Ebj8M+OClA1RLOodFURiQycQqtb9iRWLWr7Wak5bEbBHeMdRKg7p1b7
         eWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfw9zbpHviMWy0DAgU87jJe5hG08WvMdwlP4QzNQsoT6oLYQP/ay43BoBKrgU5eSdEPCb3Ct5ipEwHRo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nzntTvfWC4vLYWllr2KvRC8hCj8NKb1jbVp6x21oY+iIR2SN
	gMurwInxFhEOGIorjSkXMT2JCMiZmi3Ls2odYjdVO09MaZDQK13cQOWbuOVczTVwIq4=
X-Gm-Gg: ASbGnctMm+UNtHgpVcu7Ww1R+xC8HLA7AbLqj2YBfrrhDtjeqZaceC35H3vL26EX5+N
	QgiAcLRQQq8WcoLdSnVZYIF1D2hyrNnfCxIJXNVkdYlwO9vofYuuM89N/zCHTek6P9NpRompNjJ
	N1FYmpjvOs14PHa+aHFW0hu3+5/P/1YDew6KzwyetoaQopCDNwoTrMYvSZcQWA5G+/FE6SC5ajm
	8HMIcDh+NSZ891wCN5SXsscn84/+SS+SUv0iMqoV1zRkW47lJD8i/3oI3r5GUgJ/DWuKDHU4GJa
	1Q46aQDsgRFU4pRzp67aux6qCZs6vTx0Dl+ACDTWTw+e3TsD8SvM+BOUC5qvp5u3YMZ3h+DVnMO
	gdngrBkiGCHVcKif5Dw879xfsURHEmIkORGwINUprNEuXYaS+ex4dgCdkAU9AvFUeZIRgFEzCPg
	==
X-Google-Smtp-Source: AGHT+IGzSh4U8zlkbAbt1sARjalYvKWSIgZ8I6Ou+Sz022y53ECOehZLFJYmOuZw9cPfaOr9xiWGcA==
X-Received: by 2002:a05:6214:258f:b0:6fa:d956:243b with SMTP id 6a1803df08f44-704a39bb51dmr231977926d6.37.1752503827724;
        Mon, 14 Jul 2025 07:37:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497dae711sm47567726d6.100.2025.07.14.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:37:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ubKIj-00000008fud-3bh6;
	Mon, 14 Jul 2025 11:37:05 -0300
Date: Mon, 14 Jul 2025 11:37:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] locking/lockdep: Move pmd_to_hmm_pfn_flags() to
 the respective #ifdeffery
Message-ID: <20250714143705.GG1870174@ziepe.ca>
References: <20250710082257.663850-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710082257.663850-1-andriy.shevchenko@linux.intel.com>

On Thu, Jul 10, 2025 at 11:22:57AM +0300, Andy Shevchenko wrote:
> When pmd_to_hmm_pfn_flags() is unused, it prevents kernel builds with clang,
> `make W=1` and CONFIG_TRANSPARENT_HUGEPAGE=n:
> 
>   mm/hmm.c:186:29: warning: unused function 'pmd_to_hmm_pfn_flags' [-Wunused-function]
> 
> Fix this by moving the function to the respective existing ifdeffery
> for its the only user.
> 
> See also:
> 
>   6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions for W=1 build")
> 
> Fixes: 9d3973d60f0a ("mm/hmm: cleanup the hmm_vma_handle_pmd stub")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  mm/hmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

