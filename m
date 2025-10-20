Return-Path: <linux-kernel+bounces-860524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F157BF0523
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26DC3B25AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3942ED15D;
	Mon, 20 Oct 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADQHf6ul"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A931643B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953963; cv=none; b=ZO/VCWtr55uOnnQ/gdLWxtt0MQRabeL5nzAOmHPksLh7CkGFPrL9PRoYpOExKWTy0w4x2qge3N2O/74R3qm159b/PhiUKgrvFiSwVX9knnhJoxw6r8gkPDKNChXS81xI/GtOPBXZStRARO6pLF7LHx3lPrHUwv4E/xkM6ZGtWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953963; c=relaxed/simple;
	bh=8BNj1nyI6XA8AHTXc9nev4ngtSQqfFQNmbIzYwVO9Tg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=achFTUOhsx+OgFuZ7TnwGzGLkDt3yfnGyDAhKdkuKyw2SOoqUfB6pVEspV6k3fE3LRcaZEXwZTglSJ7dTMpIAofUCPLUISD1lD0WhqGYeJikqHRf7mFXdlVF4eM995vgV6T545+L380xJfm9rUNful0c5VHj65MS2kXxwivWSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADQHf6ul; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-579d7104c37so5207229e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760953960; x=1761558760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGpju+Gd9/THNpuuTg8cSbZecPHS5eNNv2MOF/fBRs8=;
        b=ADQHf6ulzc+V05wFpMEfUPM9ncpZFymykuAKY3vcx0UAMGyj2PrcdKk9hopWoMoqNA
         oepvD8ZfZUcVbxp5UECD6JObC3rNNjsPi4m1hSLLCJuujRSy4KBHUHa2LCaZW2k7wkR4
         7Kve1SoApEWUM0nyaoAfpXgzzo5m1+uRIAziSh5QotoMlkSYRsuVXFVps5QbL+WT1g1m
         h04+9wymOmmg0m1g1J6WuLMxmXcNk9coKqa6bW3cURR3fs5h3cRirPm0K52mWOMBClWP
         BDZnqoPHoT4eh0L615ba0h+kYIw4j038mg7PBU0jXFCKBAjd9BLNc9gB92eHJRlDKwdq
         LZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953960; x=1761558760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGpju+Gd9/THNpuuTg8cSbZecPHS5eNNv2MOF/fBRs8=;
        b=QQDBlSSp6Q5evX/Xwsv42aUt0fMjP/1AaD8nrFyrb1JR2pT+fSF9JJ1t3BoeNgjlNS
         +Uj/kaOZnuqUHc/O960wWzJJrQIP4wMdCeYTSSxmZROd0lS+1dHDGIOI5B9CERA0YkxI
         828/NP+uCbkT+PKxvpjGxFjf4COQRRlok692m8OUw75FRTgJn9wuF57EaIkQGcJwr6NY
         BUHzi66oxvIcBjooqraw6592cGqjbBBsitr6AjlXEZkFYqdRofAZaWq1Rbe2LcsB1OSk
         pI3UXuSXRPmgqjOpYqvgHTNURd07BVXx0gjYGBUFG7WeipUaT2NgDehlXyJMTYp/I9r6
         vHPg==
X-Gm-Message-State: AOJu0YzJ6Jxz9iwgFmYgUsUr+RusnUMCZQEuO6vIW7NoAGnuBf+SjZfy
	nL9zek3ju+3mCcPnWhxnyI1peFv6L+hpk2EU783Tg29Nc/azeGzvXRZq
X-Gm-Gg: ASbGnct2PCSjk5Bzao/IGM0TmEcbaoey02fO/babpDmZY5GZL4baYzkaFIgPyAuGx/1
	eyXQoFP7DMaTpSUfsQET2lgoRRJWYa4FWr8Diy4ikLEFf8Mv/yE3+JfTCgL4ARA0dr+AmIg3iEe
	JAYPdy6zaBGXDMa5cN1xPvSFJasaXTcrTVaqqM5hwkRNT0AbZAauxaODM6n39mTPP1uWZbYZ2l/
	5gUBpjbqRwS6wHjfyjbhe3vtC4zNb1HjQgXDBOvdbXo7Ck4sb0Qk7tvyi8AlSD86RtXdFqV9dGw
	8R3rCwZ7yMY99vUuUBmgxbVG4uaRrAnO0f8X+7Dbp56uqWhkpl6MvPJy/R7rqucfP3tZWpRq9z+
	0iMgPg5NrLVoZZq17KGW0nk5h07kalxTLP7lAsTtJg3bXtC44n3gabg==
X-Google-Smtp-Source: AGHT+IExS7iD+QnDCXSMCbonZCGW2Axznoc42QyUybY5f3lmldOmND0AMnsbCjH+0+hoQeg8aUWzhg==
X-Received: by 2002:a05:6512:3e03:b0:58b:75:8fae with SMTP id 2adb3069b0e04-591d85575dcmr3843407e87.26.1760953958936;
        Mon, 20 Oct 2025 02:52:38 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def16900sm2374908e87.56.2025.10.20.02.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:52:38 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 20 Oct 2025 11:52:36 +0200
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Baoquan He <bhe@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH mm-unstable] vmalloc: Separate gfp_mask adjunctive
 parentheses in __vmalloc_node_noprof() kernel-doc comment
Message-ID: <aPYGZBYTBoAEYjAK@milan>
References: <20251020044933.15222-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020044933.15222-1-bagasdotme@gmail.com>

On Mon, Oct 20, 2025 at 11:49:33AM +0700, Bagas Sanjaya wrote:
> Sphinx reports htmldocs warning on __vmalloc_node() comment:
> 
> Documentation/core-api/mm-api:52: ./mm/vmalloc.c:4036: WARNING: Inline strong start-string without end-string. [docutils]
> 
> Fix it by separating adjunctive parentheses from preceding gfp_mask
> formatting markup.
> 
> Fixes: 32904ba6f5ef ("vmalloc: update __vmalloc_node_noprof() documentation")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20251020134902.3a11107e@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e207ca64a688ee..091a07f6d92524 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4034,7 +4034,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>   * Allocate enough pages to cover @size from the page level allocator with
>   * @gfp_mask flags.  Map them into contiguous kernel virtual space.
>   *
> - * Semantics of @gfp_mask(including reclaim/retry modifiers such as
> + * Semantics of @gfp_mask (including reclaim/retry modifiers such as
>   * __GFP_NOFAIL) are the same as in __vmalloc_node_range_noprof().
>   *
>   * Return: pointer to the allocated memory or %NULL on error
> -- 
> An old man doll... just what I always wanted! - Clara
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you!

--
Uladzislau Rezki

