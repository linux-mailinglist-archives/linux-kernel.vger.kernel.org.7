Return-Path: <linux-kernel+bounces-807902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D4BB4AAE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21C0173808
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7B31AF16;
	Tue,  9 Sep 2025 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="IRjGDNLB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJWV1kGW"
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE72E9EA3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414889; cv=none; b=aZL+uBhztGn14zdaGuZVhWTOg8/k6IT8SjNmdbUekyAIIonGGrROMMcjMid+wD0ecqfLIF4Rd1lgNTnhaS3828BZKCuSXmkO0YCeNeosQ7TZQOIOZ/luUXsYUMpAgFI/zDCZ6dC4v/zfHLj5M8aPt092Om9QYrgVNMCE/1ASlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414889; c=relaxed/simple;
	bh=bOMpoPZhjFxX2lwAd62HfCJQ4dCvseJo+E97BwoJHyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tX80hG83ykZZW2T3ppbqRl+KmIjMdxHJiLJpQd3egwjaAtjHI7Bc+H8J8lAXIPdenORCfRZ/STX53QtSxAFErXxz6YYzQW6F4WUGE0LhsYtmoLtkIxOiIpj3Gf6NtjAKnf3+IPoviDkLwrLykQg5C/wqAZvRz8vHfuCoov9SwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=IRjGDNLB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJWV1kGW; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id ACC591300944;
	Tue,  9 Sep 2025 06:48:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 09 Sep 2025 06:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757414884; x=
	1757422084; bh=rNoH5fa/opO+WTmOJxSo7bt81WHvwxJBdsDyJBfGjpI=; b=I
	RjGDNLB/RvSdGLCqb3j+4cvPg9x83RzGw4YfoxuMzxhnbrV5imieTZMRic/GszNq
	Gu1964qdV57thuLyTgetKVQ6HJxfgbEv3UMuC8h1Vs5Nt90xP40FkdLIKQt+TRSp
	OYv2f72B7OeOpQYN+QG4Wd/KEL5IM3wD9lkLeXFTuRyr6J0Fok88qUdapRzRceiT
	YNzXr9PBg1acj5d0jXVsxbYQHtEKmc7Yxw0ZbKZOj3aTebd22IAoYD0UXdgPCLqN
	OQFcTJubPTv7lbquF065Wsmup36e4D+UU/96S4PbUuQ72h2MkHT2UtHrAIGuDZ4d
	6i8Sv+W1IjotUYlCk/yEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757414884; x=1757422084; bh=rNoH5fa/opO+WTmOJxSo7bt81WHvwxJBdsD
	yJBfGjpI=; b=LJWV1kGWhYibguXeTgcDjb+fFkP+m0K8wKlA9or7VmvDoMIFxoU
	aCi3tx2mmkmTX1mshqZhRyc/y0EzH548Pbv17VCsDn4IFXRfieq+0hq/+v39Ha1z
	oCzYQYQjv9GVs9zhQsRQYC22h8EdxHwHxeJfbj/zRJGMEY7iE5FPTKzF5A8jDL0S
	8RNjlNxSOopw+S74tESDKvmiXz/oDtBEGaavl+C2TLcbhOVq0+P+4B7+ILMLWkwS
	G7cIwVinr89cH9O2yiviIAKP6Din/4IxBzCHg2vs0FMg7MmBmGpQVeJq/sYruYuf
	arWXSeIvpeMGwcBul3FDWtvlMW7y+FPwmzw==
X-ME-Sender: <xms:4wXAaIcOxZi6MXDqaZPIMlJR5zG4ACk08EQzc-U3BBu5BW46SgISZg>
    <xme:4wXAaK7gX7yfoqo-9U4Azoba1S2mciOcfJKCZT-72w3ZI84zOzS6KTbZSMEYs2OiU
    Yc63AndtE-CqI5bBB0>
X-ME-Received: <xmr:4wXAaODP57_RB-SuXqQxv_XDLB54bYX1E6XbwE0Ue-2JhJe7zYqklBZn42zgXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeegfeehleevvdetffeluefftdffledvgfetheegieevtefgfefhieej
    heevkeeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopeehgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrlhgvgigrnhguvg
    hrrdhkrhgrsghlvghrsehkuhhkrgdrtghomhdprhgtphhtthhopegrnhgvvghshhdrkhhu
    mhgrrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgigvghlrhgrshhmuhhsshgvnh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghhrhhishhlsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepug
    grvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhhmrgihlhgvsehgohhoghhl
    vgdrtghomh
X-ME-Proxy: <xmx:4wXAaOdLSe-xaKiD5TO0AqzQ9XC39lKIU-xgGJla6Y30gOXlvP5hAg>
    <xmx:4wXAaLTmnw6yxOwdmb84zM7NERF65vJI1kb3Cp1Mc5Jc0oZtvBhU1Q>
    <xmx:4wXAaNkWZ5wi5tbkrHF-riz_nNfw22LQY6lAtojPGT-2SVrn_1Hj2A>
    <xmx:4wXAaPbwvxo-jaFdVewfjDSZGvsVouF90dv5sf2ZfI9XDq4NP6Vupw>
    <xmx:5AXAaDy7XY-XTU-fy23f5joErztRzUXdTLdiBZeqv2mg0pnGDXgjwb6E>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 06:48:02 -0400 (EDT)
Date: Tue, 9 Sep 2025 11:48:00 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Krabler <Alexander.Krabler@kuka.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Chris Li <chrisl@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Frederick Mayle <fmayle@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>, 
	Keir Fraser <keirf@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>, 
	Li Zhe <lizhe.67@bytedance.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>, Shivank Garg <shivankg@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>, 
	yangge <yangge1116@126.com>, Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/6] mm/gup: check ref_count instead of lru before
 migration
Message-ID: <qsaofruq3r6ffvcutn4rx23rhgc6dg42t6yvnmwpimqk3loz56@d3j24wa3hho7>
References: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
 <bd1f314a-fca1-8f19-cac0-b936c9614557@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1f314a-fca1-8f19-cac0-b936c9614557@google.com>

On Mon, Sep 08, 2025 at 03:15:03PM -0700, Hugh Dickins wrote:
> Will Deacon reports:-
> 
> When taking a longterm GUP pin via pin_user_pages(),
> __gup_longterm_locked() tries to migrate target folios that should not
> be longterm pinned, for example because they reside in a CMA region or
> movable zone. This is done by first pinning all of the target folios
> anyway, collecting all of the longterm-unpinnable target folios into a
> list, dropping the pins that were just taken and finally handing the
> list off to migrate_pages() for the actual migration.
> 
> It is critically important that no unexpected references are held on the
> folios being migrated, otherwise the migration will fail and
> pin_user_pages() will return -ENOMEM to its caller. Unfortunately, it is
> relatively easy to observe migration failures when running pKVM (which
> uses pin_user_pages() on crosvm's virtual address space to resolve
> stage-2 page faults from the guest) on a 6.15-based Pixel 6 device and
> this results in the VM terminating prematurely.
> 
> In the failure case, 'crosvm' has called mlock(MLOCK_ONFAULT) on its
> mapping of guest memory prior to the pinning. Subsequently, when
> pin_user_pages() walks the page-table, the relevant 'pte' is not
> present and so the faulting logic allocates a new folio, mlocks it
> with mlock_folio() and maps it in the page-table.
> 
> Since commit 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page()
> batch by pagevec"), mlock/munlock operations on a folio (formerly page),
> are deferred. For example, mlock_folio() takes an additional reference
> on the target folio before placing it into a per-cpu 'folio_batch' for
> later processing by mlock_folio_batch(), which drops the refcount once
> the operation is complete. Processing of the batches is coupled with
> the LRU batch logic and can be forcefully drained with
> lru_add_drain_all() but as long as a folio remains unprocessed on the
> batch, its refcount will be elevated.
> 
> This deferred batching therefore interacts poorly with the pKVM pinning
> scenario as we can find ourselves in a situation where the migration
> code fails to migrate a folio due to the elevated refcount from the
> pending mlock operation.
> 
> Hugh Dickins adds:-
> 
> !folio_test_lru() has never been a very reliable way to tell if an
> lru_add_drain_all() is worth calling, to remove LRU cache references
> to make the folio migratable: the LRU flag may be set even while the
> folio is held with an extra reference in a per-CPU LRU cache.
> 
> 5.18 commit 2fbb0c10d1e8 may have made it more unreliable.  Then 6.11
> commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding
> to LRU batch") tried to make it reliable, by moving LRU flag clearing;
> but missed the mlock/munlock batches, so still unreliable as reported.
> 
> And it turns out to be difficult to extend 33dfe9204f29's LRU flag
> clearing to the mlock/munlock batches: if they do benefit from batching,
> mlock/munlock cannot be so effective when easily suppressed while !LRU.
> 
> Instead, switch to an expected ref_count check, which was more reliable
> all along: some more false positives (unhelpful drains) than before, and
> never a guarantee that the folio will prove migratable, but better.
> 
> Note on PG_private_2: ceph and nfs are still using the deprecated
> PG_private_2 flag, with the aid of netfs and filemap support functions.
> Although it is consistently matched by an increment of folio ref_count,
> folio_expected_ref_count() intentionally does not recognize it, and ceph
> folio migration currently depends on that for PG_private_2 folios to be
> rejected.  New references to the deprecated flag are discouraged, so do
> not add it into the collect_longterm_unpinnable_folios() calculation:
> but longterm pinning of transiently PG_private_2 ceph and nfs folios
> (an uncommon case) may invoke a redundant lru_add_drain_all().  And
> this makes easy the backport to earlier releases: up to and including
> 6.12, btrfs also used PG_private_2, but without a ref_count increment.
> 
> Note for stable backports: requires 6.16 commit 86ebd50224c0 ("mm:
> add folio_expected_ref_count() for reference count calculation").
> 
> Reported-by: Will Deacon <will@kernel.org>
> Closes: https://lore.kernel.org/linux-mm/20250815101858.24352-1-will@kernel.org/
> Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

