Return-Path: <linux-kernel+bounces-830311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E843B99600
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96997163FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E482DCBFB;
	Wed, 24 Sep 2025 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="dm4/F7fc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWM+b5/M"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E22DC77C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708658; cv=none; b=LlqboZrL293b96Sr3DvKTgd2XLP9g0DGVreoceeqfOym1KpP1IZzaa3rsASSLiLOfr2mF9uDftKI5p9P/yJ7zC2BCJtQvcRWShUdxngDheSMNlIRVa73za7ACZ9ceu1yL7b0q50EnJTS0OdHtl+fhzSU8baqzIOhvdvLb78RoV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708658; c=relaxed/simple;
	bh=jcxu3NeJ9gwPAeirt2I3GIx5wwoRzh2kzoPA+w5dkDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUO3XJHqMh4aIUfGoUyf18nLLLA9hwnB1LQjULgGcG7RZXZis6neINuoD+7MNw178+F4XziNuRdOHtjrBDqgIiQC5jqbJjeiEm2SOS+WluMXFUSZGdkXCHvnxcSaz4YNbxtahclkAMXRnI5bSLi/6k/tV0t4xs7V/a+ux+erueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=dm4/F7fc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWM+b5/M; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id EA6A4EC00DC;
	Wed, 24 Sep 2025 06:10:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 24 Sep 2025 06:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758708651; x=
	1758795051; bh=RGmbEfPLISQO1ROGSU6HyBBqnTTSfiwWmowUcjVsqq8=; b=d
	m4/F7fczegdaq+vfCrcSLI6RlWak04aro4o4pJ3hHd7g8cWhkuFqIB5PJ7J3WuZG
	d98CpWhzWhJv/a1OPwljvPNpxKRDftvD+0mp4IELvxnD0TRw/mFD75yLPxHUwscP
	Ep5i5J3eNUBAdhPPJrVbItgllVeGWF4nCCGTjnT/gA/EPmC4/ELd8MjtHYupzI6p
	klPtlif59E6CuJ3Jhlz7yn34vB0y/oWmHpCoYxY1qALZdmzPk3rAiQsE4UW6rLJk
	UyHpvbkWPxUusAwDMxq/uMkqBU8KwAjOvu3JUlwMosLHuPm2bPrYy/evWmxpJq00
	IKMwHmUiiaUWzb3n8sZDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758708651; x=1758795051; bh=RGmbEfPLISQO1ROGSU6HyBBqnTTSfiwWmow
	UcjVsqq8=; b=JWM+b5/M7h6Ub6hNdu3gxmqIC1jTjwy77kKd8HlRY+jh9V02Xi6
	HtsGCAppxRudZx0XcT0MvGK9oTriaej7yT+Aq8zPigeYTzmr4lfQ/a6gNa27j+9d
	Lr4+waJvH0y1QVW9TJkOnpblfU7e27FE528Psafy6PhVq6QAYzS67jGilC2HNxLR
	2iLDONJGkamek+aJm+aB63wds5ZMCMGcNi5zHO+k3wfLmgrBYtfIv5Tc08wvMBf+
	r5G8Kdl1vsdXcP4uzgD3DRDT+NFd+W5mcsq3lHokalOmDwWhd01P2+8IeyXi0AHX
	IncKYmVprmphpqYBgrvY7XYBiAfvHdOsbLg==
X-ME-Sender: <xms:q8PTaP05_tH9GEeC4Ax089W-Of2D0GX4sXrfQd_7LLIFLarx9ojLNA>
    <xme:q8PTaI6QzHu1f_ZOgDLyaGZM-koNOz8hinxNLKTDR1wKx4Z_WRxrfZ8cf-RSONCph
    mPPaztdMjpotwTXndl47r3XZAJHVeB3oSMkOMvo2lg06fMv18Egc28>
X-ME-Received: <xmr:q8PTaOLsCLn0Rq2WKnR6esW9mrFe0vTgH82W9dR7mPth1xgqkcwcaUXXjZfMPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeegfeehleevvdetffeluefftdffledvgfetheegieevtefgfefhieej
    heevkeeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopeefgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrdguvghvpdhrtghpthhtoheprghk
    phhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvih
    gusehrvgguhhgrthdrtghomhdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghs
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrg
    gtlhgvrdgtohhmpdhrtghpthhtohepsggrohhhuhgrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsrgholhhinhdrfigrnhhgsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpd
    hrtghpthhtohepuggvvhdrjhgrihhnsegrrhhmrdgtohhmpdhrtghpthhtohephhhughhh
    ugesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:q8PTaEag3zPU9hQMoBWhbUQZ89gEjo6Go8GwG7QjAThN_A1ICvso3g>
    <xmx:q8PTaL2iTViXiU4WYpxe1CnvT4Z2ANjqZY-cnk5FqAJPqnysncGCpw>
    <xmx:q8PTaGNjXlDh0nPGzxmbcu8MyJukPRXFS-4jdmc90tBdUNWCoi1Xqw>
    <xmx:q8PTaFJfFDzdPe5bf7FlyljS49nOT-ZiC1_1OZ8GDZl9AXb2FLPWmg>
    <xmx:q8PTaC2_7J6WWMxSNIY78I4T6f58eWFlPPmxuGXg4kHJb2tPhxqQvql8>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 06:10:50 -0400 (EDT)
Date: Wed, 24 Sep 2025 11:10:49 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com, ioworker0@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com, 
	ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <bhkr4y5h2d254ba7eopsb44tqwdvb2h2ddfhwjjho7twomaqk7@4nqik57oxw3e>
References: <20250924100207.28332-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924100207.28332-1-lance.yang@linux.dev>

On Wed, Sep 24, 2025 at 06:02:07PM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> The existing check in hpage_collapse_scan_pmd() is specific to uffd-wp
> markers. Other special markers (e.g., GUARD, POISONED) would not be caught
> early, leading to failures deeper in the swap-in logic.
> 
> hpage_collapse_scan_pmd()
>  `- collapse_huge_page()
>      `- __collapse_huge_page_swapin() -> fails!
> 
> As David suggested[1], this patch skips any such non-swap entries early.
> If a special marker is found, the scan is aborted immediately with the
> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
> work.
> 
> [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>  mm/khugepaged.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 7ab2d1a42df3..e9778e7734b5 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1285,16 +1285,19 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  	     _pte++, addr += PAGE_SIZE) {
>  		pte_t pteval = ptep_get(_pte);
>  		if (is_swap_pte(pteval)) {
> +			swp_entry_t swp = pte_to_swp_entry(pteval);
>  			++unmapped;
>  			if (!cc->is_khugepaged ||
>  			    unmapped <= khugepaged_max_ptes_swap) {
>  				/*
> -				 * Always be strict with uffd-wp
> -				 * enabled swap entries.  Please see
> -				 * comment below for pte_uffd_wp().
> +				 * Always be strict with PTE markers, which are
> +				 * special non-swap entries (e.g., for UFFD_WP,
> +				 * POISONED, GUARD). We cannot collapse over
> +				 * them, so just abort the scan here.
>  				 */
> -				if (pte_swp_uffd_wp_any(pteval)) {
> -					result = SCAN_PTE_UFFD_WP;
> +				if (is_pte_marker_entry(swp) &&
> +				    pte_marker_get(swp)) {

Hm. Can we have a marker that have zero pte_marker_get()?

> +					result = SCAN_PTE_NON_PRESENT;
>  					goto out_unmap;
>  				}
>  				continue;
> -- 
> 2.49.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

