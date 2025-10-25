Return-Path: <linux-kernel+bounces-869910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B37C08FAD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386F51B24590
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064542F7AB1;
	Sat, 25 Oct 2025 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Pe7e09Yo"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BC28727E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761392932; cv=none; b=jIIh0b9r62Qc3uEtIWULwkTt4KIc7fvLWMrh4VdJUo4xNHgEJGM9g1YXiEB4Hn0/TX7+Fj34nlgTbAF1kI7wdacfkA/DKYKivppQV4DFVvbu4EeHE6aVyNOQK2tbEoeKtf+LsHL19dUfF1xuFw05CxSAZZUMzjRis5aooaATqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761392932; c=relaxed/simple;
	bh=i8XofQqqpFBYtNUfPREDBqPdpKj+cAWkqMaj6cdVJlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2b7uWNd48PKEGjRlmFzfMe3B0CbYXzIHCN3lC/5INV18GzSElIQp37ECm/bQYRfZucilMBy0fxKrXQzNoTQgXoBwWrMNEBFSGLrkZChmqiMQYlWCnKR/aCaNZE1pT0EwEgt80Qt8OsTPDypYcFvIMFmNM3xdwRSx9a+9xwwzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Pe7e09Yo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 608C040E01FA;
	Sat, 25 Oct 2025 11:48:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GCanCPmvqytz; Sat, 25 Oct 2025 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761392916; bh=fXUt4RhE9O4TW7ib83ixqHYYEv1RZkDc63T93cQXQfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pe7e09YozzO9P2wUfc0UwGYzIHiFg7UD0eesrJRAkWy6tQmVHB82ZeA2JevnW/oA9
	 eKEYWZsN/7/ukeId6nuvC1UDNYOdjOif94deQWNPXgQ9hX+6jCcKQla5kDm5c12Vra
	 5jOCzacmW6RYgKj2V9SqUS+Qwx6kTyBWRNFLkaSjnU75iezliaENyQ/gcGgZmEGYHO
	 cj9Zfj1lQWVMV93Fg74UlpWdm+xB2b3+eFyZMa0vSFOI+JoHN8KkqKDSV7kPytqj/3
	 RgZWMn1UQGie4bla5B5FtPCgueQ+kQOer3yFrameuF7DbRlFYQHIf5c5Nu86+GZE7h
	 ExAf/lQ9Y2o0AkMUpJ3K2LPbJauKJxa5n9znivnzsprmQUXhwi2DXqgR0nHRoL9qAJ
	 DWBKYGDAp8k0+TGv2CERgx5fW0yQ/UVH/SwTAmxW/JZPW5qWF2h+OfewG9LmvG6dwM
	 3WwNen8OfShTzXTdePZe55RyUs/Exv93shD+W+Q7cMUeImGh01Vb+Nnx87Bm8R6y87
	 ExvW66cuIJVg35Y3kzYNJYh+RzapU5YW+k2nD44ZPTOZc+Uh5OnU0Qg6OngflOFaSR
	 l6AUEjU8H7mogaKjNlW1BIJybYXRIQ931ZwboW3kdOXW1VZPNiou/reTtByhl2dU1A
	 kMf7DXJaWizUzuQ1H01n0UW8=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CF52C40E01AB;
	Sat, 25 Oct 2025 11:48:08 +0000 (UTC)
Date: Sat, 25 Oct 2025 13:48:01 +0200
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
Subject: Re: [PATCH 03/21] x86/mm: factor out phys_pgd_init()
Message-ID: <20251025114801.GWaPy48dhlZ_EVoqKi@fat_crate.local>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-3-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924-b4-asi-page-alloc-v1-3-2d861768041f@google.com>

On Wed, Sep 24, 2025 at 02:59:38PM +0000, Brendan Jackman wrote:
> +static unsigned long __meminit
> +__kernel_physical_mapping_init(unsigned long paddr_start,
> +			       unsigned long paddr_end,
> +			       unsigned long page_size_mask,
> +			       pgprot_t prot, bool init)
> +{
> +	bool pgd_changed;

I have to say, that pgd_changed is yuck but I don't have a better idea and
this has happened a long time ago anyway.

How about you have the caller pass in false:

	bool pgd_changed = false;

and then callee sets it to true when it does so?

> +	unsigned long paddr_last;

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

> +
> +	paddr_last = phys_pgd_init(init_mm.pgd, paddr_start, paddr_end, page_size_mask,
> +				   prot, init, &pgd_changed);
> +	if (pgd_changed)
> +		sync_global_pgds((unsigned long)__va(paddr_start),
> +				 (unsigned long)__va(paddr_end) - 1);
> +
> +	return paddr_last;
> +}
>  
>  /*
>   * Create page table mapping for the physical memory for specific physical
> 
> -- 
> 2.50.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

