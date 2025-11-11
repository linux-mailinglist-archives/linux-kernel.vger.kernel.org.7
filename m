Return-Path: <linux-kernel+bounces-895682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B0FC4EA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC76A1891518
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82356305E24;
	Tue, 11 Nov 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YqnJDfgW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288A2ED168
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872944; cv=none; b=DzSxkOoVhrm0tE58hduN3IMaMUEL0ld9uj0q2dLnKupYgaVt8V0seyU2f3oZdXuE3b3LVqnRfuI2bTjP3HSYvStFfDZypcdQeZvPMjUyZto4GTnuQbIYZRanm2gWZ5lOWVIyUzhm44ZyzHiJ8Osau6JYLjCYPTnzwFRVe1YxNbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872944; c=relaxed/simple;
	bh=s14Zs00+SFC87wqi/dEo7NUxcA2MGJgYNhfDtWAw2tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCzrcJhynsYjoFwIS/aZoPMF8O9p8Q49Pm2eiaQGtyoEUN27UT0+i2NQl5qRTtg95i0NfMqW+ZtKt7ColAnDClsgSkrQg3ynd8rkZpPc3VBRFqvIcgTd3LZ28PUtQzeO5HA1nvBgZZ+7hTI8ITdjdkMQ1J6XCRhWVKT0QSUFXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YqnJDfgW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 499A440E01CD;
	Tue, 11 Nov 2025 14:55:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tMmmeYl0meH3; Tue, 11 Nov 2025 14:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762872935; bh=gvaesmOa4FL0oqNE6Jjuc2W41XHSmQDSTtdVBn3gwyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqnJDfgWmmm4+pdX93nY6U8tsFaahs3v4rYfl4buKyG10uFC3lKtz423FJ262vWsX
	 FqM4lih1cyrfG4QCdQZUBQh3QhJh7fgkRzZuk7v6DZ2Wptp55l723CQVIuSoIUO4qn
	 3xaTgphDcDnjuZYMEOWWbBRDFaNG2qql1svczVUoT1NpQz9jYNAeLboaFjYarhJ+2q
	 QWh9J8Oty2/1JubETP0icZR23/940OCcxcq8VW8pQnPwd5XuCOT3Hx61QXGKqOtl34
	 u1p/Mkx4iT4lOvFv+6LtSTriU2g3gAkZvLNqyFb0JSlai5411gS6dZPt2IIdupgf+q
	 HWTvATKDrqumxcqngSOHbDwtY92/14YPjv0MO8s/NGkb2Lf7Fl0Kc+AegtNQSS+ile
	 nWZdb6suadmWtiP6FmWMG0UNdHjDmKqNq9ho1rnLykzc8C8mqafD2jFsi7xE6Xie2C
	 nruE/H1DW32bUV8+rPfgsw4K3N0IacmMjgSTJxKlNM1qKb6rwRHQxJojfyG4JsunHY
	 658U+xq6/+ej2G96X84LTfqX6Mz2ISi8i04sPCKPLHK/mHfW1WMoTPaKPYvnaXH5BW
	 Ux1PPw3wModikDTW7nJ6WjJJ40GIrpxxcArxB7unlhItBWX4zIhzzDqFnU5a3rjajn
	 kLOHxA6twlsm47fwL2detOKQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D251B40E00DA;
	Tue, 11 Nov 2025 14:55:07 +0000 (UTC)
Date: Tue, 11 Nov 2025 15:55:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, peterz@infradead.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de,
	akpm@linux-foundation.org, david@redhat.com, derkling@google.com,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, reijiw@google.com, rientjes@google.com,
	rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
	yosry.ahmed@linux.dev
Subject: Re: [PATCH 04/21] x86/mm/asi: set up asi_nonsensitive_pgd
Message-ID: <20251111145501.GXaRNORRWGIYQ7yFmH@fat_crate.local>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-4-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924-b4-asi-page-alloc-v1-4-2d861768041f@google.com>

On Wed, Sep 24, 2025 at 02:59:39PM +0000, Brendan Jackman wrote:
> @@ -797,6 +800,24 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
>  
>  	paddr_last = phys_pgd_init(init_mm.pgd, paddr_start, paddr_end, page_size_mask,
>  				   prot, init, &pgd_changed);
> +
> +	/*
> +	 * Set up ASI's unrestricted physmap. This needs to mapped at minimum 2M
> +	 * size so that regions can be mapped and unmapped at pageblock
> +	 * granularity without requiring allocations.
> +	 */
> +	if (asi_nonsensitive_pgd) {
> +		/*
> +		 * Since most memory is expected to end up sensitive, start with
> +		 * everything unmapped in this pagetable.
> +		 */
> +		pgprot_t prot_np = __pgprot(pgprot_val(prot) & ~_PAGE_PRESENT);
> +
> +		VM_BUG_ON((PAGE_SHIFT + pageblock_order) < page_level_shift(PG_LEVEL_2M));
> +		phys_pgd_init(asi_nonsensitive_pgd, paddr_start, paddr_end, 1 << PG_LEVEL_2M,
> +			      prot_np, init, NULL);
> +	}

This looks weird: so you have some other function - asi_init() - which *must*
run before this one so that the pgd is allocated. But then you check it here
and in order to do such a "distributed" init, you export it too.

Instead, I'd simply add a function call here - asi_init_physmap() or whatever
- which is defined in asi.c and gets *only* called from here. And that
function returns the pgd or NULL. And then you use phys_pgd_init() on it.

Also, looking at kernel_map_pages_in_pgd() - and you mentioned set_memory.c
already - and if I squint my eyes hard enough, it does look like a bunch of
redundancy between there and init_64.c. But that's nasty code so unifying that
would be a hard task.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

