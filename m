Return-Path: <linux-kernel+bounces-793610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F48FB3D609
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 01:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAC97A36D9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 23:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCB7248867;
	Sun, 31 Aug 2025 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KhiP7pYP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B314AA9
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756683451; cv=none; b=lL+I8aga+cnIFWq48qdCk1CrakwuA/ffvwpOhO09j/jAkRGVX8rH8LXPXlhKN31tVkZ6ylXy8RifB21Ft007UYeG3EMHYxOEyWcackvFaJ9JnDJkPPPA4U/fdSBjHo+m61Mw7ae+7MYrafgpps2nSMimQxIloeN1EZhOIDElktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756683451; c=relaxed/simple;
	bh=QoyPh+HafMw6z1btoD3KW7sbENt4hG10xXtcbHhIRbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oR8Vn03WiD1Cx48mSgSTUfNvNH9SmninKtZ14nHcIzX12x3Uaxdqf3NEPLRa++7hHWajLcoMSa3Q+3MwVPmxsrjWACsvCjgupxgQ+IGDufimpUuLvxZLug0kUcqZ2+nG3Vmalv1Dmi2ZAH8jWTxeXOd+kHVFcgNS2Nz0D7wutpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KhiP7pYP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5/X6IMPWa31K/zfx8lt7hgWlCVhbr2OzJf3fLghYiYA=; b=KhiP7pYPLLNma/iEZ0/e2s/a+D
	CYvRTBGFdpIballmC6yGqJ45tRlQU5XV7nPT0Jxt3J6XyDX7QkhlwDDgcHOZ+ASfjOpjy4wicG8li
	p8Hx3mozisdRvwWVZIRaEln/oA0dC9LLsOLnW6AqqbFTTdAAcRdjsG2SIfQnJFw7Woj92s2GYXFI8
	fmoXWNWwydZl5iJgBxDNHQiX+hL+kKfc9lK917e9vtCdMScd05eaRrU23kDIEPsOCpPRqS8fxcBWB
	HWBQgs4FsAT2MfTquTpvhyXreYXTERavKkyalH0axsHnlTDNtqC1L5b62O9qCo8OcIUipKR6SKwo6
	VGvMVuyg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usrbs-0000000GxvR-1wBS;
	Sun, 31 Aug 2025 23:37:20 +0000
Date: Mon, 1 Sep 2025 00:37:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Shivank Garg <shivankg@amd.com>,
	Christoph Hellwig <hch@infradead.org>,
	Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexander Krabler <Alexander.Krabler@kuka.com>,
	Ge Yang <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>,
	Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/7] mm: fix folio_expected_ref_count() when PG_private_2
Message-ID: <aLTcsPd4SUAAy5Xb@casper.infradead.org>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
 <f91ee36e-a8cb-e3a4-c23b-524ff3848da7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f91ee36e-a8cb-e3a4-c23b-524ff3848da7@google.com>

On Sun, Aug 31, 2025 at 02:01:16AM -0700, Hugh Dickins wrote:
> 6.16's folio_expected_ref_count() is forgetting the PG_private_2 flag,
> which (like PG_private, but not in addition to PG_private) counts for
> 1 more reference: it needs to be using folio_has_private() in place of
> folio_test_private().

No, it doesn't.  I know it used to, but no filesystem was actually doing
that.  So I changed mm to match how filesystems actually worked.
I'm not sure if there's still documentation lying around that gets
this wrong or if you're remembering how things used to be documented,
but it's never how any filesystem has ever worked.

We're achingly close to getting rid of PG_private_2.  I think it's just
ceph and nfs that still use it.


