Return-Path: <linux-kernel+bounces-794059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B1B3DC45
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD91189CD46
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0256D2ED868;
	Mon,  1 Sep 2025 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxj37rLh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974625CC4D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714989; cv=none; b=t3W8as+J7MuE9uPXPnT/OOweNx8wF00OMs4HFI8DL5otoEQcyjH8bg1k9fSVjIv6iou3YiHiyt9zQ/Kz0P0Fx+RCYpttikMOK7dKqdqpzOF8GBC0jaoBKt2+2JUSKqGiH/gHY8zs/WCe0BI8JiWbiKuNScX0zn8MnLgcWveHZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714989; c=relaxed/simple;
	bh=slg/knugYfdID3fSA+rgt5Womt4WwMw1yB4SjgeL3Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj+S9iMEg4n/bCh8ICVNXmmYvrE0RjwiJGuADcvEB2MQGsax7CC+zDOWnQgHqoNmsGI8Y4h2CCdhg9zH25icj2AKG3Kz1/yEOIP5Q48r9BhbrTuvCxQjVTp+RU6i97teLDdttzKfN5G86Xewth1aQTWaVA4Zz3QMqwsRgExzT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxj37rLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B64C4AF0B;
	Mon,  1 Sep 2025 08:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756714988;
	bh=slg/knugYfdID3fSA+rgt5Womt4WwMw1yB4SjgeL3Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dxj37rLhvkC1zDOhXYNisORhyQGv8KEshR5FUM4G8we2Wq934pICLmZoAbgNW3MKN
	 K69badD1GR0FpB/Yv2PeQI8Sa40PR0+2IDBpeGZgYZCd7PD1Z/grD5LyMz1DJYdFvr
	 ZaNY1tE5lX7DKsSBDuwRo4Q3e6KM6ah9wWHvN1EMxW4gbVB9sLLKAfoA2w7Td48czK
	 JuELGCIhSHd9bRuHV7KhedQnAY4A4i7DLf9GLg9r05JiWIMlmUUm9bHPQca/WNDprd
	 5eO2hhZBlN7kUlkwAT4bTg2tYb/V2PzUe9+XIpiNK2qlrHQ+L/F4SSqTywjetKjb6i
	 DchCOkDcO/xbw==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0BBB1F40066;
	Mon,  1 Sep 2025 04:23:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 01 Sep 2025 04:23:07 -0400
X-ME-Sender: <xms:6le1aC3C6O3w4wscLelV5FRNUN98JnVzyF37UdzHb1_8y4q3p_1S9w>
    <xme:6le1aKMxr_vSuVTnjMx71F0_3ihB_l65DvrSU-DFG6wgCdQNkSIUfqUzQ_OpcXEg6
    a526rkN5xCN_7f9Muk>
X-ME-Received: <xmr:6le1aCKeJfzS4YNCiGPsWQoy5qOT-mkms3JrBcXST3Q88FD_fVk_BycmE1Ah>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleduieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhephfeikeetleeludeghfffkeffgfejtdevvefggfejfeefgedvkeettedugeeggfek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhdrjhgrihhnsegrrhhmrd
    gtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhhughhhugesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
    epsggrohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphht
    thhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomhdprhgtphhtth
    hopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:6le1aLbBHGmQXTl4i9SIr_G0bFii48MMgLzngIF7t7YHNigJdJmlfQ>
    <xmx:6le1aLlRMzxMlwoaxF_4ibpRe989Bcsi5wdx2uT9hoDRaHSsCCb6wg>
    <xmx:6le1aObrjGa7fnU0xlUiafoph_NQdHTKlxwPGazN3BrT0DcbddI1aw>
    <xmx:6le1aLCYRK6PVuUQRD5KCJ7P2kdaGWeuSOGiKi_V5LrYTu8CkN8HKA>
    <xmx:61e1aMaKCGPQt0qMRld9Jff5YzArem6dX8bzFb6XOIfel4ak_BTGGGHK>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Sep 2025 04:23:06 -0400 (EDT)
Date: Mon, 1 Sep 2025 09:23:03 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	hughd@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Enable khugepaged to operate on non-writable VMAs
Message-ID: <7towtl2pjubgdil4csn5rg3usbai5xvzz73wqkwj5b5awh2iim@wfvahykzjrlo>
References: <20250901074817.73012-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901074817.73012-1-dev.jain@arm.com>

On Mon, Sep 01, 2025 at 01:18:17PM +0530, Dev Jain wrote:
> Currently khugepaged does not collapse a region which does not have a
> single writable page. This is wasteful since, apart from any non-writable
> memory mapped by the application, there are a lot of non-writable VMAs
> which will benefit from collapsing - the VMAs of the executable, those
> of the glibc, vvar and vdso, which won't be unmapped during the lifetime
> of the process, as opposed to other VMAs which maybe unmapped. Therefore,
> remove this restriction and allow khugepaged to collapse a VMA with
> arbitrary protections.
> 
> Along with this, currently MADV_COLLAPSE does not perform a collapse on a
> non-writable VMA, and this restriction is nowhere to be found on the
> manpage - the restriction itself sounds wrong to me since the user knows
> the protection of the memory it has mapped, so collapsing read-only
> memory via madvise() should be a choice of the user which shouldn't
> be overriden by the kernel.
> 
> I dug into the history of this and couldn't find any concrete reason of
> the current behaviour - [1] is the v1 of the original khugepaged patch
> which required all ptes to be writable. [2] is the v1 of the patch which
> changed this behaviour to require at least one pte to be writable. The
> closest thing I could find was: in response to [2], Kirill says in [3] -
> "As a side effect it will effectively allow collapse in PROT_READ vmas,
> right? I'm not convinced it's a good idea." (Although Kirill realizes in
> [4] that this was not the intention of the patch).

Hm. I don't see a justification for only collapsing writable pages.

> I can see performance improvements on mmtests run on an arm64 machine
> comparing with 6.17-rc2. (I) denotes statistically significant improvement,
> (R) denotes statistically significant regression (Please ignore the
> numbers in the middle column):

Could you give a summary instead of raw data? It is too much for commit
message. Raw data can be put under "---" for reference.

BTW, why did you pick hackbench as a benchmark? Seems random.

> +------------------------------------+----------------------------------------------------------+-----------------------+--------------------------+
> | mmtests/hackbench                  | process-pipes-1 (seconds)                                |                 0.145 |                   -0.06% |
> |                                    | process-pipes-4 (seconds)                                |                0.4335 |                   -0.27% |
> |                                    | process-pipes-7 (seconds)                                |                 0.823 |              (I) -12.13% |
> |                                    | process-pipes-12 (seconds)                               |    1.3538333333333334 |               (I) -5.32% |
> |                                    | process-pipes-21 (seconds)                               |    1.8971666666666664 |               (I) -2.87% |
> |                                    | process-pipes-30 (seconds)                               |    2.5023333333333335 |               (I) -3.39% |
> |                                    | process-pipes-48 (seconds)                               |                3.4305 |               (I) -5.65% |
> |                                    | process-pipes-79 (seconds)                               |     4.245833333333334 |               (I) -6.74% |
> |                                    | process-pipes-110 (seconds)                              |     5.114833333333333 |               (I) -6.26% |
> |                                    | process-pipes-141 (seconds)                              |                6.1885 |               (I) -4.99% |
> |                                    | process-pipes-172 (seconds)                              |     7.231833333333334 |               (I) -4.45% |
> |                                    | process-pipes-203 (seconds)                              |     8.393166666666668 |               (I) -3.65% |
> |                                    | process-pipes-234 (seconds)                              |     9.487499999999999 |               (I) -3.45% |
> |                                    | process-pipes-256 (seconds)                              |    10.316166666666666 |               (I) -3.47% |
> |                                    | process-sockets-1 (seconds)                              |                 0.289 |                    2.13% |
> |                                    | process-sockets-4 (seconds)                              |    0.7596666666666666 |                    1.02% |
> |                                    | process-sockets-7 (seconds)                              |    1.1663333333333334 |                   -0.26% |
> |                                    | process-sockets-12 (seconds)                             |    1.8641666666666665 |                   -1.24% |
> |                                    | process-sockets-21 (seconds)                             |    3.0773333333333333 |                    0.01% |
> |                                    | process-sockets-30 (seconds)                             |                4.2405 |                   -0.15% |
> |                                    | process-sockets-48 (seconds)                             |     6.459666666666666 |                    0.15% |
> |                                    | process-sockets-79 (seconds)                             |    10.156833333333333 |                    1.45% |
> |                                    | process-sockets-110 (seconds)                            |    14.317833333333333 |                   -1.64% |
> |                                    | process-sockets-141 (seconds)                            |               20.8735 |               (I) -4.27% |
> |                                    | process-sockets-172 (seconds)                            |    26.205333333333332 |                    0.30% |
> |                                    | process-sockets-203 (seconds)                            |    31.298000000000002 |                   -1.71% |
> |                                    | process-sockets-234 (seconds)                            |    36.104000000000006 |                   -1.94% |
> |                                    | process-sockets-256 (seconds)                            |     39.44016666666667 |                   -0.71% |
> |                                    | thread-pipes-1 (seconds)                                 |   0.17550000000000002 |                    0.66% |
> |                                    | thread-pipes-4 (seconds)                                 |   0.44716666666666666 |                    1.66% |
> |                                    | thread-pipes-7 (seconds)                                 |                0.7345 |                   -0.17% |
> |                                    | thread-pipes-12 (seconds)                                |     1.405833333333333 |               (I) -4.12% |
> |                                    | thread-pipes-21 (seconds)                                |    2.0113333333333334 |               (I) -2.13% |
> |                                    | thread-pipes-30 (seconds)                                |    2.6648333333333336 |               (I) -3.78% |
> |                                    | thread-pipes-48 (seconds)                                |    3.6341666666666668 |               (I) -5.77% |
> |                                    | thread-pipes-79 (seconds)                                |                4.4085 |               (I) -5.31% |
> |                                    | thread-pipes-110 (seconds)                               |     5.374666666666666 |               (I) -6.12% |
> |                                    | thread-pipes-141 (seconds)                               |     6.385666666666666 |               (I) -4.00% |
> |                                    | thread-pipes-172 (seconds)                               |     7.403000000000001 |               (I) -3.01% |
> |                                    | thread-pipes-203 (seconds)                               |     8.570333333333332 |               (I) -2.62% |
> |                                    | thread-pipes-234 (seconds)                               |     9.719166666666666 |               (I) -2.00% |
> |                                    | thread-pipes-256 (seconds)                               |    10.552833333333334 |               (I) -2.30% |
> |                                    | thread-sockets-1 (seconds)                               |                0.3065 |                (R) 2.39% |
> +------------------------------------+----------------------------------------------------------+-----------------------+--------------------------+
> 
> +------------------------------------+----------------------------------------------------------+-----------------------+--------------------------+
> | mmtests/sysbench-mutex             | sysbenchmutex-1 (usec)                                   |    194.38333333333333 |                   -0.02% |
> |                                    | sysbenchmutex-4 (usec)                                   |               200.875 |                   -0.02% |
> |                                    | sysbenchmutex-7 (usec)                                   |    201.23000000000002 |                    0.00% |
> |                                    | sysbenchmutex-12 (usec)                                  |    201.77666666666664 |                    0.12% |
> |                                    | sysbenchmutex-21 (usec)                                  |                203.03 |                   -0.40% |
> |                                    | sysbenchmutex-30 (usec)                                  |               203.285 |                    0.08% |
> |                                    | sysbenchmutex-48 (usec)                                  |    231.30000000000004 |                    2.59% |
> |                                    | sysbenchmutex-79 (usec)                                  |               362.075 |                   -0.80% |
> |                                    | sysbenchmutex-110 (usec)                                 |     516.8233333333334 |                   -3.87% |
> |                                    | sysbenchmutex-128 (usec)                                 |     593.3533333333334 |               (I) -4.46% |
> +------------------------------------+----------------------------------------------------------+-----------------------+--------------------------+
> 
> No regressions were observed with mm-selftests.
> 
> [1] https://lore.kernel.org/all/679861e2e81b32a0ae08.1264054854@v2.random/
> [2] https://lore.kernel.org/all/1421999256-3881-1-git-send-email-ebru.akagunduz@gmail.com/
> [3] https://lore.kernel.org/all/20150123113701.GB5975@node.dhcp.inet.fi/
> [4] https://lore.kernel.org/all/20150123155802.GA7011@node.dhcp.inet.fi/
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> Based on mm-new.
> 
> Not very sure of the tracing parts which this patch changes. I have kept
> the writable portion for the tracing to maintain backward compat, just
> dropped it as a collapse condition.
> 
>  include/trace/events/huge_memory.h |  2 +-
>  mm/khugepaged.c                    | 11 +++--------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 2305df6cb485..f2472c1c132a 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -19,7 +19,7 @@
>  	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
>  	EM( SCAN_PTE_UFFD_WP,		"pte_uffd_wp")			\
>  	EM( SCAN_PTE_MAPPED_HUGEPAGE,	"pte_mapped_hugepage")		\
> -	EM( SCAN_PAGE_RO,		"no_writable_page")		\
> +	EM( SCAN_PAGE_RO,		"no_writable_page") /* deprecated */	\

Why not remove SCAN_PAGE_RO?

>  	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
>  	EM( SCAN_PAGE_NULL,		"page_null")			\
>  	EM( SCAN_SCAN_ABORT,		"scan_aborted")			\
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4ec324a4c1fe..5ef8482597a9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -39,7 +39,7 @@ enum scan_result {
>  	SCAN_PTE_NON_PRESENT,
>  	SCAN_PTE_UFFD_WP,
>  	SCAN_PTE_MAPPED_HUGEPAGE,
> -	SCAN_PAGE_RO,
> +	SCAN_PAGE_RO,	/* deprecated */
>  	SCAN_LACK_REFERENCED_PAGE,
>  	SCAN_PAGE_NULL,
>  	SCAN_SCAN_ABORT,
> @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  			writable = true;
>  	}
>  
> -	if (unlikely(!writable)) {
> -		result = SCAN_PAGE_RO;
> -	} else if (unlikely(cc->is_khugepaged && !referenced)) {
> +	if (unlikely(cc->is_khugepaged && !referenced)) {
>  		result = SCAN_LACK_REFERENCED_PAGE;
>  	} else {
>  		result = SCAN_SUCCEED;
> @@ -1421,9 +1419,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  		     mmu_notifier_test_young(vma->vm_mm, _address)))
>  			referenced++;
>  	}
> -	if (!writable) {
> -		result = SCAN_PAGE_RO;
> -	} else if (cc->is_khugepaged &&
> +	if (cc->is_khugepaged &&

The only practical use of the writable is gone. The only other usage is
tracing which can be dropped to as it is not actionable anymore.

Could you drop writable? Maybe as a separate commit.

>  		   (!referenced ||
>  		    (unmapped && referenced < HPAGE_PMD_NR / 2))) {
>  		result = SCAN_LACK_REFERENCED_PAGE;
> @@ -2830,7 +2826,6 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  		case SCAN_PMD_NULL:
>  		case SCAN_PTE_NON_PRESENT:
>  		case SCAN_PTE_UFFD_WP:
> -		case SCAN_PAGE_RO:
>  		case SCAN_LACK_REFERENCED_PAGE:
>  		case SCAN_PAGE_NULL:
>  		case SCAN_PAGE_COUNT:
> -- 
> 2.30.2
> 

-- 

Kiryl Shutsemau / Kirill A. Shutemov

