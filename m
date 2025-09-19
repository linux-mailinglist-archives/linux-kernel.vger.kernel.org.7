Return-Path: <linux-kernel+bounces-824327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB6B88ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0541BC6294
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834892F3C32;
	Fri, 19 Sep 2025 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baC3GNGE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEB2EDD76
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275740; cv=none; b=YfpGrLcH68a9E+iCmUG3ziw1iXaMtSFW1nYLuRstgZfZG8JBYbGbT6JliaCDui7zZInVmuvjKHU7cphD/aE0aJAALK0351QvUMQ39HFjY6R8XpoXQDaNyxTI6SA+K3Ee8kzoMlGibxwnZT4kEJSS5LKmydUt9ztlBD84LPav7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275740; c=relaxed/simple;
	bh=9ZYD2O5yqvIh6f2etaVtF8OL7RJcUChYaE/qwOAMi68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFi4vqfpo31C6A+0zj1HcVWdMuDHpdx75k7AE4+NkNJAWqgS2UUcj1TWqZIKcxdQEVFtcxIhZECne0mQ/gLE1aiXqGzAy3pegmkFi0kAa5AcHu1zZWp6kkYs1FgjGJ6Q3iXBDPU3NLDmFtdwQQsyrxQZvK47VS7ZVIsS/PeOVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baC3GNGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269A6C4CEF7;
	Fri, 19 Sep 2025 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758275740;
	bh=9ZYD2O5yqvIh6f2etaVtF8OL7RJcUChYaE/qwOAMi68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baC3GNGE1xdksGHpX5XvUBE3VcB5lk/WLyPycF2N9is0Dmedj6TUGgmQkywVsJUee
	 EsOLpTl1u0puEOAQYlwBAt1hx7YzdDJAlnsQzzDQSdxjXWr54DkZCzAFMHhIplTZ0H
	 9oo0lxxAUmKqg94HXULOIChSOzrId1jyqtQLVvEIkuECJrGxkyW5wmq8wUwv+AVc3a
	 txho3XIn3AZm2+pbV8DIPkK81qKMMAVaegZfZKHlrp4JB2gxxw3yZYQZilQQq1uTGg
	 2EF3o959iTcAWLmizpWrHDp01cqqjfa4tKZUkVzec8v7KIO6oGs9X3H1JIByceeLbV
	 v4ERtC0A+JMvQ==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3B42FF40066;
	Fri, 19 Sep 2025 05:55:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 19 Sep 2025 05:55:39 -0400
X-ME-Sender: <xms:myjNaKSpRft0M17CjMw02_r2ZwJJHvB44EznM8BsQwZm6BbCa3ReBg>
    <xme:myjNaKJ6s8wWRTwh5nH87PAsHcOx2WQDG4tmO-qvRJ9nUHnAblHHpFGDYYSOMG6BB
    gqmDNYqQ-fpJGAUnUY>
X-ME-Received: <xmr:myjNaDZEyo0_kh-KtL8ADANnSNDsdahLH27NcgUkCvorU5WTKtyvrSLifdOzCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehieekueevudehvedtvdffkefhueefhfevtdduheehkedthfdtheejveelueffgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epsghpsegrlhhivghnkedruggvpdhrtghpthhtoheptghhrghordhgrghosehinhhtvghl
    rdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlh
    drtghomhdprhgtphhtthhopehishgrkhhurdihrghmrghhrghtrgesihhnthgvlhdrtgho
    mhdprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgt
    ohgtoheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:myjNaABKzxu2sSXbXhS5z5-0W_pWtcvSEN2KgR32kwXkj9CxPq1oPw>
    <xmx:myjNaNUT9xp0OH81Os2dAT3Uz-702MbCGapEafwSLMeGjElIPOX2_Q>
    <xmx:myjNaB2ciEcOrg2hLdEK-GddKSEumHG-JxAz7Ka9EmlTCyzUvc_-yA>
    <xmx:myjNaGU-EExkmFeJpecZLrzdELuRW9vx4AfT44Mtcbo2f2iPPD-0Dw>
    <xmx:myjNaPDPpPnbky2_KeTujRdtDDrQ9VZCFlCvfGESI68nDGxa9G_uzUwc>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 05:55:38 -0400 (EDT)
Date: Fri, 19 Sep 2025 10:55:36 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, chao.gao@intel.com, dave.hansen@linux.intel.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de, x86@kernel.org, 
	yan.y.zhao@intel.com, vannapurve@google.com
Subject: Re: [PATCH v3 12/16] x86/virt/tdx: Add helpers to allow for
 pre-allocating pages
Message-ID: <l3wzjxkokrcuu7mguuojr5vnzfwjpjfxgg3d6pw5zmmgsgpdfv@wz6gvpglqkiz>
References: <20250918232224.2202592-1-rick.p.edgecombe@intel.com>
 <20250918232224.2202592-13-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918232224.2202592-13-rick.p.edgecombe@intel.com>

On Thu, Sep 18, 2025 at 04:22:20PM -0700, Rick Edgecombe wrote:
> In the KVM fault path pagei, tables and private pages need to be

Typo.

> installed under a spin lock. This means that the operations around
> installing PAMT pages for them will not be able to allocate pages.
> 

> +static inline struct page *get_tdx_prealloc_page(struct tdx_prealloc *prealloc)
> +{
> +	struct page *page;
> +
> +	page = list_first_entry_or_null(&prealloc->page_list, struct page, lru);
> +	if (page) {
> +		list_del(&page->lru);
> +		prealloc->cnt--;
> +	}
> +

For prealloc->cnt == 0, kvm_mmu_memory_cache_alloc() does allocation
with GFP_ATOMIC after WARN().

Do we want the same here?


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

