Return-Path: <linux-kernel+bounces-758019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC89B1C9D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A84B188FC1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680A52882CB;
	Wed,  6 Aug 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="N3A6fT7P"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9419AD5C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497950; cv=none; b=uQb6EUNpkPssBkLz0jFzN41dc7jpcQvQ/U1VW189y2SveqcfGo4zNn6+0UOcFTbPm4zlUNZ+vBqiM3gubsFDR1zOIn9gu79FbiYiEB0ZGfLn4PfDLK0sEFFTlaX6pZZJfaDyliHzQ0Nmyn1uhXhupwT+mvrFzBx0jSMzsg0HDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497950; c=relaxed/simple;
	bh=8koxwrrrpXRQv68oFmk2nURbB1epOaqVtBKzW9mOwbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2pzfJBv6ZhCj7NTFCjOdrofxgQCTFsKyrz4NebTwoAUtvEVVY5pQcdxDQ6hsJ8DD+P1ArM7IAk4RF8bG1w5o6wHvKVdPC2DMmipKcqDID0FoGxY5n6SbHXC73ZZ17FdC4BtA9WuI0aUGjb85l1dYHAPCb5M3rru+2YCe6GLFRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=N3A6fT7P; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0770954faso1285361cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1754497947; x=1755102747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DczkdOzRVH8sA2mnIf+wryGp+DfW+r4oiu5gHq5d+os=;
        b=N3A6fT7P1jN9vYQPxniMneX3p/pY/qqymWujslq7w9F8zT8TglOmOum8uHWkP2TQUb
         m/UCvvEXHz8YXzBKWpe1z/fRhyxwbg/247WHP+Ui9juZeRwUGaIweYc/YKktTNzQDhF5
         sVdHto0MNVSXpGx1anDigcQgbi0xAs8iQafgGKyGL1gPa/lprSiNPANcVOsSM+EXOzOy
         /9WCL9+QgjI7Vc98DHXXXauVw6uI8wKhlggoOhtU6GMVusujYwEkAzvLXegj8EiHwLbc
         6sJsuKS413TnZTXe+YhZ/OUo3YFTousHYNPiQAP0oIBsRvh2INMHq6s4Xv4rquMfOqdn
         2d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497947; x=1755102747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DczkdOzRVH8sA2mnIf+wryGp+DfW+r4oiu5gHq5d+os=;
        b=gF14T3FSqVYcp8EM/HcdycS+8pCtWRfxChhpCcLodxx+l9Isa2Jq3t5TtyajkZgWHR
         rnIsL7KcvHo8wlgtUczNyIuUHbzgSlQ9+dfJCln0XL68NC4qQTP+uLtfGoWnp6Era5/3
         jqUgoXgVByblTs3TUGQxhF2ZP1fXlkMcpJ5OgVnea88xD9+jW5/ZQ329ztrHZyUFV4Hp
         niR8x263v7M4DsPUZK1sj2ZfaaRaBNKaEv9Rv7BeNCIvq06xEspteaaBOR9HpV+/HjMb
         HCG/PgRTX52jnyn+VNE/hoXDHFf/vwkgtL4Fs+NLFmXhTe7LbQM9a26vDswro6tUul7a
         treA==
X-Forwarded-Encrypted: i=1; AJvYcCVr13kG6Yf27q8RiR58aQphTpq39vnvFKADOy4TQVhoSHsRSxa6gq0ML02KJWXyyCodoSf7WvbPU9/rk8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWP2D30ixh77VH62t1Ndus6x9bYsucUnNRFDuXwLI68zpkISn+
	NLH1TWpIJkNMzqD7bWcJaFh3LpVVYiOCBQt9R0opBwIZXAQwEWceQXoPovVV9ZdR66A=
X-Gm-Gg: ASbGncs2xQ0keDds1ebd2PsY5ji3x1hTVG3rCMzUhgONw9j1xb989WJhPeCrY0N6PBx
	wY+ckpOBwo0ZuT8K2i/dJ8k8+Lo+fzc7q+Ydm6DoOFSENdfx1bp4b7Knymn+D529ZURB6bvQan3
	6wrT2yv4WcNcrA0JVTl861DXFEfUtqFT1/cyJ6mWLt/PpS/dfj6q3+bYiwdGbaRV4QrelUvXxuN
	/Yp4aLZ9ilDdCa7fJ24bC7NAIfSLdmVfNAJzLzn004f3ryGujQsaKE6bziD+Um5eCCIjHpPle/p
	mP2F/G3uZwnZbjAbZ6ujaW+e9SBiJwnhXw0oRWM4CTjJEu/0v8lX+TC3GYHBxel7WAUu17Sm0PD
	anBEbybb9Jr5XBTOyBNYL93WNzsjIW9ws
X-Google-Smtp-Source: AGHT+IHC3hrESSBrcMoIOYxPNKtmK7006X0ZFbjOG06E52Szyt/nP4BqvqO0+YzYU4f3W7ZcXwwE4A==
X-Received: by 2002:a05:622a:1cca:b0:4af:1fb2:339c with SMTP id d75a77b69052e-4b091534932mr66831011cf.29.1754497945572;
        Wed, 06 Aug 2025 09:32:25 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b09a2e6095sm5411891cf.33.2025.08.06.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:32:24 -0700 (PDT)
Date: Wed, 6 Aug 2025 12:32:21 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed
 page as-is
Message-ID: <20250806163221.GA1795303@cmpxchg.org>
References: <20250805002954.1496-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805002954.1496-1-sj@kernel.org>

Hi SJ,

Overall this looks good to me. On top of the feedback provided by
others, I have a few comments below.

On Mon, Aug 04, 2025 at 05:29:54PM -0700, SeongJae Park wrote:
> @@ -142,6 +142,15 @@ User can enable it as follows::
>  This can be enabled at the boot time if ``CONFIG_ZSWAP_SHRINKER_DEFAULT_ON`` is
>  selected.
>  
> +If a page cannot be compressed into a size smaller than PAGE_SIZE, it can be
> +beneficial to save the content as is without compression, to keep the LRU
> +order.  Users can enable this behavior, as follows::
> +
> +  echo Y > /sys/module/zswap/parameters/save_incompressible_pages
> +
> +This is disabled by default, and doesn't change behavior of zswap writeback
> +disabled case.
> +
>  A debugfs interface is provided for various statistic about pool size, number
>  of pages stored, same-value filled pages and various counters for the reasons
>  pages are rejected.
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7e02c760955f..6e196c9a4dba 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -129,6 +129,11 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
>  		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
>  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
>  
> +/* Enable/disable incompressible pages storing */
> +static bool zswap_save_incompressible_pages;
> +module_param_named(save_incompressible_pages, zswap_save_incompressible_pages,
> +		bool, 0644);

Please remove the knob and just make it the default behavior.

With writeback enabled, the current behavior is quite weird:
compressible pages to into zswap, then get written to swap in LRU
order. Incompressible pages get sent to swap directly. This is an
obvious age inversion, and the performance problems this has caused
was a motivating factor for the ability to disable writeback.

I don't think there is much point in keeping that as an officially
supported mode.

> @@ -937,6 +942,29 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
>  	mutex_unlock(&acomp_ctx->mutex);
>  }
>  
> +/*
> + * Determine whether to save given page as-is.
> + *
> + * If a page cannot be compressed into a size smaller than PAGE_SIZE, it can be
> + * beneficial to saving the content as is without compression, to keep the LRU
> + * order.  This can increase memory overhead from metadata, but in common zswap
> + * use cases where there are sufficient amount of compressible pages, the
> + * overhead should be not critical, and can be mitigated by the writeback.
> + * Also, the decompression overhead is optimized.
> + *
> + * When the writeback is disabled, however, the additional overhead could be
> + * problematic.  For the case, just return the failure.  swap_writeout() will
> + * put the page back to the active LRU list in the case.
> + */
> +static bool zswap_save_as_is(int comp_ret, unsigned int dlen,
> +		struct page *page)
> +{
> +	return zswap_save_incompressible_pages &&
> +			(comp_ret || dlen == PAGE_SIZE) &&
> +			mem_cgroup_zswap_writeback_enabled(
> +					folio_memcg(page_folio(page)));
> +}
> +
>  static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  			   struct zswap_pool *pool)
>  {

> @@ -1001,6 +1034,17 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  	return comp_ret == 0 && alloc_ret == 0;
>  }
>  
> +/*
> + * If save_incompressible_pages is set and writeback is enabled, incompressible
> + * pages are saved as is without compression.  For more details, refer to the
> + * comments of zswap_save_as_is().
> + */
> +static bool zswap_saved_as_is(struct zswap_entry *entry, struct folio *folio)
> +{
> +	return entry->length == PAGE_SIZE && zswap_save_incompressible_pages &&
> +		mem_cgroup_zswap_writeback_enabled(folio_memcg(folio));
> +}

I don't think there will be much left of these helpers once you
incorporate Nhat's feedback, but please open-code these in either
case. They're single user, hide what's going on, and the similar names
doesn't do them any favors.

