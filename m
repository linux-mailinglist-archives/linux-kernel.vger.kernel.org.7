Return-Path: <linux-kernel+bounces-807905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6EEB4AAED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5E03A9BB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF5131C591;
	Tue,  9 Sep 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="SquqfoQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UVwDxbsc"
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0222DC34B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415183; cv=none; b=aEWuKQG5Vt/q4QUudURuvx38CBWF0ZlMr28R49EsLyJaMy/shd1vF2iOJ9fknaNpmksi9wIJUB0tHvSZ81WoT7OeF2qQPEl49K8HwYIe2oMVB/ulRt5ZBoqrgI3G2wSnIqdwfBGHOUNe6Y12M+QuM+hL2QkFO4KUlUQuZE+V5w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415183; c=relaxed/simple;
	bh=tCX8Kza6JK+zUR/+nPCloMYhy6VDvfvUKukl8mDZ4+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDhALPTJVbTDI7eLxgsG99cIqryRXvCE1UWde/quZnViUi5Ufkgq5NPpgabxCNaFNZ7Lf5k+eYbmqDXuSq/vj3N209VJRi7xqRAxoGKYGv9p3LtlcAVRO2LArpukS5RAnLSQb8P1z+JZ42JhqhCbYZuf2gyhOlpORqmeWZtSgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=SquqfoQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UVwDxbsc; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 2BA2613001CC;
	Tue,  9 Sep 2025 06:52:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 09 Sep 2025 06:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757415179; x=
	1757422379; bh=wg98qBWvsK/xMOq6MrYIGvPlEvdIreb1eSQHFEhM07w=; b=S
	quqfoQ1A/Es8HY2Ox1iXgAtilXn4DOoih7hVgISC+p4nALircwFqtKiY0Rcexau2
	R14o5XifOuHy6hYd1Wx9/VoFQQA6WW4jSVfiDMh8jjTw6wr6Zh8P0eMMKhbdmKCV
	WqZv2jgdxelhVDeBKrcD4eywuHF1V9rNGX3doyR7DvdAk4eOqFmBMxFwfi7migIa
	y84yL78mq78rgcKO+4Fi5QEDenR1AwLbNzpJR0BrRA2znS1q2mBqFV7hm8vOHH+z
	ZpMhdRp31e0cWFky0aRd5bFN6fDur5wo3FIqjTOWxayPzZktzZRM98lu8sVHOqpf
	FoZ1w7TbeqIYVj/iLSPqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757415179; x=1757422379; bh=wg98qBWvsK/xMOq6MrYIGvPlEvdIreb1eSQ
	HFEhM07w=; b=UVwDxbsc93fwdu4x5rmjBVIqRLw5Ctm77zBemWK02DkfNqm7B6V
	BrfO1hPFwqMpcXVAJ3tT6CFG9Dt9btINdEbOTA6BrI53DScA8SzlIIbbWlljWwIM
	ij/W5nHp7pmaI+dVbX9QmkW9kccau2VdS3c5GOd09lcmn82qGHk0pXTVfEFzn75q
	avg9iskhtj093Kg4vcd3dvioTHfwD4sXPSHkf0XOtqHwA2uuT1jY3kgDjq1VOOsQ
	xWX2AqUrF9S87kJKAzID/SgKs8HfM04g1vAYEV8NKf5FQM9Y8/cbcREQx5TLJ+8q
	PPqZU4+IW/2Fb7p3jp7yxW4/c1kh3GdPB5g==
X-ME-Sender: <xms:CgfAaD8_IwsZ2C_Z6z0Sz4lQ1nZ7q2_smTL65rLTHFgdRZx9Y-_dqQ>
    <xme:CgfAaJ1Zubv1MJxm07JTlc26_txvRB2kMzipfNwVJkbQm5Gg8jji3Eq6_qdFvwste
    4oBbkTWoizEtprGEz8>
X-ME-Received: <xmr:CgfAaGC_fEnoZJFVkgYfHwq441M3PpAuDBkXzeCCINvcvyBJckNh2bkbDofSlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepheeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopegr
    khhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghlvg
    igrghnuggvrhdrkhhrrggslhgvrheskhhukhgrrdgtohhmpdhrtghpthhtoheprghnvggv
    shhhrdhkuhhmrghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrgigvlhhrrghsmh
    hushhsvghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhslheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopehfmhgrhihlvgesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:CgfAaDnH0hHt5UvkdrVLCCjub-He_pyUuOZrNWoFNOEIktC8ZyCMMQ>
    <xmx:CgfAaHotZP_nb5NJTEHc_40cABL3TMXOkFjsOByFxWpTfCUswDcUiQ>
    <xmx:CgfAaIM5Qx0qdcQ6sCMm-FvaXRbCQjY-sReL8MJkhgOk38wKq-6glA>
    <xmx:CgfAaBZbmOt0gWMZAthCchWYJaWki9MMaOhB5UCfYpP9j8tUCXovXQ>
    <xmx:CwfAaDrUB9oOsBVIlUW8HmOtjp1gbFp2KBd1hEKTJ3djVE-9ZRqF91Qk>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 06:52:57 -0400 (EDT)
Date: Tue, 9 Sep 2025 11:52:55 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Krabler <Alexander.Krabler@kuka.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Chris Li <chrisl@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Frederick Mayle <fmayle@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>, 
	Keir Fraser <keirf@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>, 
	Li Zhe <lizhe.67@bytedance.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>, Shivank Garg <shivankg@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>, 
	yangge <yangge1116@126.com>, Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/6] mm/gup: local lru_add_drain() to avoid
 lru_add_drain_all()
Message-ID: <bq6mehuumf5gmf5tnm5jo3iiglqtn4yo3owkxhdddnkejd46jv@4hax34dkkzds>
References: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
 <66f2751f-283e-816d-9530-765db7edc465@google.com>
 <ebaeb8d9-0b22-4304-9dba-40d37d82e369@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebaeb8d9-0b22-4304-9dba-40d37d82e369@redhat.com>

On Tue, Sep 09, 2025 at 09:56:30AM +0200, David Hildenbrand wrote:
> On 09.09.25 00:16, Hugh Dickins wrote:
> > In many cases, if collect_longterm_unpinnable_folios() does need to
> > drain the LRU cache to release a reference, the cache in question is
> > on this same CPU, and much more efficiently drained by a preliminary
> > local lru_add_drain(), than the later cross-CPU lru_add_drain_all().
> > 
> > Marked for stable, to counter the increase in lru_add_drain_all()s
> > from "mm/gup: check ref_count instead of lru before migration".
> > Note for clean backports: can take 6.16 commit a03db236aebf ("gup:
> > optimize longterm pin_user_pages() for large folio") first.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >   mm/gup.c | 15 +++++++++++----
> >   1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 82aec6443c0a..b47066a54f52 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2287,8 +2287,8 @@ static unsigned long collect_longterm_unpinnable_folios(
> >   		struct pages_or_folios *pofs)
> >   {
> >   	unsigned long collected = 0;
> > -	bool drain_allow = true;
> >   	struct folio *folio;
> > +	int drained = 0;
> >   	long i = 0;
> >   	for (folio = pofs_get_folio(pofs, i); folio;
> > @@ -2307,10 +2307,17 @@ static unsigned long collect_longterm_unpinnable_folios(
> >   			continue;
> >   		}
> > -		if (drain_allow && folio_ref_count(folio) !=
> > -				   folio_expected_ref_count(folio) + 1) {
> > +		if (drained == 0 &&
> > +				folio_ref_count(folio) !=
> > +				folio_expected_ref_count(folio) + 1) {
> 
> I would just have indented this as follows:
> 
> 		if (drained == 0 &&
> 		    folio_ref_count(folio) != folio_expected_ref_count(folio) + 1) {

Do we want folio_check_expected_ref_count(folio, offset)?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

