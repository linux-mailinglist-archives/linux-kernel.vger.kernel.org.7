Return-Path: <linux-kernel+bounces-832121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E7B9E65B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C893A5A66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564892E9748;
	Thu, 25 Sep 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="b/aB3D+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BcRz1qeR"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4B219E8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792721; cv=none; b=axvSIj24OCkjbNAA/3KD+z8px+mgwUcHFoA+AHv1Se1foi6eKY8mZdfaQ6NEZWqGWWieNrekHrMRxAN36eXfLEFkA8v3vUiD37UT3j1Xyn67ZYgMisUeLC8riuEKjviLvKge8hrVkTdSKxe2LMcOoOxD3tbSECijtGzMzLehkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792721; c=relaxed/simple;
	bh=3LfaXLi/XrXffT+pYLVi9/m6jIDBCdutzC/VEtXpZ+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F10BX2rqNi0ZvbvPc6wz0vY0K+r+SUIl2hTHx/uXs+fk0Ym91Iq8D92v993aaPTqF+muh3+ZskfeqWOJXAc0AORfzYULzc94JrNPxdCVvCVWVp2UyogsmAtogPeAdIy9VMrYnLFW0liniyxw3SXHGaVytB3o44shKZuod38J1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=b/aB3D+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BcRz1qeR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 301B4EC0178;
	Thu, 25 Sep 2025 05:31:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 25 Sep 2025 05:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758792718; x=
	1758879118; bh=aERbHKCdQ96xhdh41Z7RoEt87xEaCiV0LCS3CvEY7do=; b=b
	/aB3D+B2g5DAsdAHllxoECukzc4Mxr5x5e4f0oLVKgMMPE68+cz5jJK47NPl4OPx
	cXNiqIsxOuD4ToAZUi7n4qAxpXYl2498cmFlJRzo6P4CTkLl5nuhQNTUNlneqwS1
	HmCudPf8ul6qnYovoxm4Hmvjj8psY8eolNXTwriiFutSXMgWxokllWDHsf17kz+r
	MjysJWO3ITjHiR6riM65DlH3lqt80koizhHpRsJUTNz8ODb50e67hpy7WhsuRsEw
	Y2s+/YD4RtOUfS/RcSWhRpR1AAnaTnRRwycdqnXKbCy7eszuZnAmZnIcVHjOW/B0
	7APl/EMdW8IEW0drZx4iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758792718; x=1758879118; bh=aERbHKCdQ96xhdh41Z7RoEt87xEaCiV0LCS
	3CvEY7do=; b=BcRz1qeRU/Ax0KI320C6UCXKHbjbPCkM2yE89cLwJ9ydjr0jQrz
	cG/5FRYt3/UIybLw8FjmzXKGut64bDi+FDFy5AZ07BT7ewoN4DFj+Y4gDGUEArWI
	lzSBnzTTJ8NwBcYzJ3nltXnSL+rKrSLjaJhDheP1dGE1Lh2KRHg5/lWCGUqk9IlV
	Tn/hNoOqCnbIvkD4oK/yID4vUmlDRoEvMN4mVpl0mkhQLAMxxi5IvyqMht+Xa0S4
	y4/zXUEiB1e1nHt+zyZvsatuM5b3YZrVWGSY3PR4mKrGBk4Nbr7+t0uWtmbQL4dj
	tWu+31W7UXyqjcSBfJQ5o7u+j57TY0iRSug==
X-ME-Sender: <xms:DQzVaEd-Wyk8ljKKXYAOa1c4KbkABfsckvhDFhmJVUwrl0SlbnTwCw>
    <xme:DQzVaHg_rmjwHNMrW24yTPudk_w8vYtJrYYlCUw5FxxIhXSDT6hvvyyUiagFGir4y
    UhNu8x0ji4MUi6OXeDhq_2Ger9-citMZluTizbo-hp9XlWoz8T0aEw>
X-ME-Received: <xmr:DQzVaKLaBU28rszoWr6_2Mi0RvmpJwlM66xDgIHqbR_Q34YjdDf7pZpYbU1eKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiiedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeetgeegffdvteeifeekheeigeetgfeltedttdeggeeuffeluedtteef
    vdeitedvffenucffohhmrghinhepphgrshhsrdhmmhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhn
    rghmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopeguvghvrdhjrghinhesrghrmhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhu
    gidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrg
    htrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomh
    dprhgtphhtthhopehvsggrsghkrgesshhushgvrdgtiidprhgtphhtthhopehrphhpthes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehmhhhotghkohesshhushgvrdgtohhm
X-ME-Proxy: <xmx:DQzVaMpK_8EL7mbK3YoASnDh0nVDpZM2-IzxUWCWq18Q07scZaH4mA>
    <xmx:DQzVaHrxQVuch9KFZf40FFYe-apLD-veYlmGbjtY1nhss52sVC2YJA>
    <xmx:DQzVaCE07J1rW1n5MfJ1XcQ3nb0czFw5tCogZQfR8ZejrpDBH4lv5g>
    <xmx:DQzVaJobkvW1bH52sIv3NRddghk7HQZwlQeSxp5dsftVRZ2kVyoNyg>
    <xmx:DgzVaC-dUut48GdOheQTcCgeHRF3l8msugJNgRVX1IxW8DLOKtpIKUJY>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 05:31:56 -0400 (EDT)
Date: Thu, 25 Sep 2025 10:31:54 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: move rmap of mTHP upon CoW reuse
Message-ID: <427kxhljdcrn7thput727j6vpqvxtalistn6yoq6ykdpbe5435@sn7a4rh7zcdo>
References: <20250925085429.41607-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925085429.41607-1-dev.jain@arm.com>

On Thu, Sep 25, 2025 at 02:24:29PM +0530, Dev Jain wrote:
> At wp-fault time, when we find that a folio is exclusively mapped, we move
> folio->mapping to the faulting VMA's anon_vma, so that rmap overhead
> reduces. This is currently done for small folios (base pages) and
> PMD-mapped THPs. Do this for mTHP too.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> mm-selftests pass.
> 
>  mm/memory.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e32eb79ba99..ec04d2cec6b1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4014,6 +4014,11 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
>  	 * an additional folio reference and never ended up here.
>  	 */
>  	exclusive = true;
> +
> +	if (folio_trylock(folio)) {
> +		folio_move_anon_rmap(folio, vma);
> +		folio_unlock(folio);
> +	}

Maybe take the folio lock earlier in wp_can_reuse_anon_folio() to cover
large folio handling too and avoid trylock here.

Something like this (untest):

diff --git a/mm/memory.c b/mm/memory.c
index 812a7d9f6531..d95cf670b6a8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3843,6 +3843,7 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
 	 * an additional folio reference and never ended up here.
 	 */
 	exclusive = true;
+	folio_move_anon_rmap(folio, vma);
 unlock:
 	folio_unlock_large_mapcount(folio);
 	return exclusive;
@@ -3858,8 +3859,15 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
 static bool wp_can_reuse_anon_folio(struct folio *folio,
 				    struct vm_area_struct *vma)
 {
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && folio_test_large(folio))
-		return __wp_can_reuse_large_anon_folio(folio, vma);
+	bool exclusive = false;
+
+	if (!folio_trylock(folio))
+		return false;
+
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && folio_test_large(folio)) {
+		exclusive = __wp_can_reuse_large_anon_folio(folio, vma);
+		goto unlock;
+	}
 
 	/*
 	 * We have to verify under folio lock: these early checks are
@@ -3869,7 +3877,8 @@ static bool wp_can_reuse_anon_folio(struct folio *folio,
 	 * KSM doesn't necessarily raise the folio refcount.
 	 */
 	if (folio_test_ksm(folio) || folio_ref_count(folio) > 3)
-		return false;
+		goto unlock;
+
 	if (!folio_test_lru(folio))
 		/*
 		 * We cannot easily detect+handle references from
@@ -3877,23 +3886,23 @@ static bool wp_can_reuse_anon_folio(struct folio *folio,
 		 */
 		lru_add_drain();
 	if (folio_ref_count(folio) > 1 + folio_test_swapcache(folio))
-		return false;
-	if (!folio_trylock(folio))
-		return false;
+		goto unlock;
+
 	if (folio_test_swapcache(folio))
 		folio_free_swap(folio);
-	if (folio_test_ksm(folio) || folio_ref_count(folio) != 1) {
-		folio_unlock(folio);
-		return false;
-	}
+	if (folio_test_ksm(folio) || folio_ref_count(folio) != 1)
+		goto unlock;
+
 	/*
 	 * Ok, we've got the only folio reference from our mapping
 	 * and the folio is locked, it's dark out, and we're wearing
 	 * sunglasses. Hit it.
 	 */
 	folio_move_anon_rmap(folio, vma);
+	exclusive = true;
+unlock:
 	folio_unlock(folio);
-	return true;
+	return ret;
 }
 
 /*
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

