Return-Path: <linux-kernel+bounces-829240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A3AB9697E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C605E483E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2121FF4C;
	Tue, 23 Sep 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="gb1AVmro";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FVWinC/x"
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A2263F2D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641478; cv=none; b=NQkUbST5MNi3uD6zb++zgqICa0uoInIZjeHmYGuJEU6tgsK3Cfh1DxjtHwqFQnIiOnOba8ORYOGBAjddZUNek58hhrMaiwXBY6GPgxgNllx/RCX2qHDxJLTTOItwgo/Oi2UcfQ0TpIOeEzMAM3VoHw/aAHmog9mPn62xUwdcb9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641478; c=relaxed/simple;
	bh=RqZsUeSF6XJ76PRC2aFBMe65b0HCxV0DfGkgOG8chHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Noy1rGlTc7LqMCcm4fGXMs3qHOeqzpVim6wTiym3ZQtHuu9C41bySDb/GstR5enjh8dlu9EePErunskot5/2oygACVABhWAtlQDioBPKHcHFKqIc4t/QCHsxr9igX14IGexwHhrT9e7lR4Zdz7DZBjyzb4LWAVOx/Q+D0sZ9tZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=gb1AVmro; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FVWinC/x; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0C47140006F;
	Tue, 23 Sep 2025 11:31:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 23 Sep 2025 11:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758641475; x=
	1758727875; bh=XjdVUNHhjUNJuLMxy6/eU24vJDAL9EcE5N2rfPXMzKk=; b=g
	b1AVmroCn+2rfsbRriNmCmDOVFlTOPdTDnsjLcHC5uQ9OFnV1GgR0HQFK3zZBXwz
	7AGtu2vkEsua6S8kB1iQp7mQRAO02Kazp+imCfj6hfO5QOcl7T8BSdFwwX2jCBr2
	dDhR6+tZ4vSkzaBfQHza/kR43K521Z1FZRIk8tb5CtZjng9oMwsTJVuy0Dqlgkka
	2If1JTbRdFN83/mF4m/2idqFcBxlTqf0xdfx8Fq3t9PEV+ipQwFMAoeSA8zGmVio
	dFq8MpLXn6xc2OPDoB8El3o82kvuI6sjDJ0ods2oS0WmjuQsw38UXOWRM0MQp7Xn
	vKu/i6mb4/nQUDmirCdgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758641475; x=1758727875; bh=XjdVUNHhjUNJuLMxy6/eU24vJDAL9EcE5N2
	rfPXMzKk=; b=FVWinC/xm6uIyyO93qjO5gJEEhslP9QG/uw5LTrmSX4FNWPEfGR
	5T90Q6kyF4ZcvlS9i04pmQ0vLfnvFDhK+ie70bnd+JwcgtN73Xw4rAXpU9Jfr2Fj
	dOJQFnXtS7uRUjixHBsbd1JU+eNF57mMaBT4YiDCTw3P6EY/kVfAr0r58SPz7Cc+
	gjcPuiO0g85nXPs4+9q6o/byTsJUsUSbj4Kq2IhyYHVrX9r01Gn/7ttJGHom733/
	62URewWXKVhbsHgJchFRCtYbvNyEGzsstIYbtFR9RbRzDYQL2HUOwmMGzGDTXJpS
	3nXCX61mMTuW51kbo41/fld3WVnQq8ZKy3w==
X-ME-Sender: <xms:Q73SaMr6xipkrf2d7TJG5aBm39HMFAkXy_oYpuB2dKpcmWlHFAJcTQ>
    <xme:Q73SaB58-H7HiksjTfjdaG6ewtAoXcytRAjpa_uSyASTLxOO9_7J4hVHjP3L3FUYW
    5Z8Ywta222gJ8hH9Rek01yo71XGXbPrjpF7PGp2WlhUbD9yJ6bY3g>
X-ME-Received: <xmr:Q73SaEDBVtnJ1tZvxrN73cV7Gbq9TB0NES8XQLDds1jB1BZ-M7-r2QZmi-3nhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiuddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtth
    hopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    lhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplh
    hirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopehvsggrsghk
    rgesshhushgvrdgtiidprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:Q73SaLafYZ_Rd5imKIkhXzZtlS446ECKgBXFbC1LXClJQbVaoADQ6Q>
    <xmx:Q73SaALNItVAy2bpeWr1rZTkPblVnqnAjalRNswmsgq1Rmh_d7pfwA>
    <xmx:Q73SaMBk3JkSWDZ31fK9J9h6XyQP4nrJeRtOCxhRKpCXSB1hAcCriQ>
    <xmx:Q73SaMNMb-8iwwrMA_NQ-keguP4w-N3uMLlIUI1xXgpTB3XkfW8cEA>
    <xmx:Q73SaKn1zdYmVp0Eu68ibPCIeku12Sj7KNBIHik8pRllD3MQ6LEmcius>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 11:31:15 -0400 (EDT)
Date: Tue, 23 Sep 2025 16:31:12 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1] mm: convert folio_page() back to a macro
Message-ID: <oaitxb74dpz6gdxoxrqcru3gz2w55r2afpow6vb226xu2elnrk@zqcn2yh4a4eg>
References: <20250923140058.2020023-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923140058.2020023-1-david@redhat.com>

On Tue, Sep 23, 2025 at 04:00:58PM +0200, David Hildenbrand wrote:
> In commit 73b3294b1152 ("mm: simplify folio_page() and folio_page_idx()")
> we converted folio_page() into a static inline function. However
> briefly afterwards in commit a847b17009ec ("mm: constify highmem related
> functions for improved const-correctness") we had to add some nasty
> const-away casting to make the compiler happy when checking const
> correctness.
> 
> So let's just convert it back to a simple macro so the compiler can
> check const correctness properly. There is the alternative of
> using a _Generic() similar to page_folio(), but there is not a lot of
> benefit compared to just using a simple macro.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

