Return-Path: <linux-kernel+bounces-773855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B5CB2AB80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6D81B6683C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1186248F70;
	Mon, 18 Aug 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3fUnSK9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB402472BA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527505; cv=none; b=tEsXCbzJnruTKGMZQOlK/ti3nf/kSrsvqh56FGObU9NKhabIwjYZB6BB39ACBnHReJ/XrPaRmw+Vau2rMFLE9vjuLPRoYvmZZNoJFDmJ4Qi2YQXexq6wT3E7vAzXAn6nT307QFO5qY0LHuEsHqY5GA3qk6wCXK4gmjoIzUiT4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527505; c=relaxed/simple;
	bh=x+H/JV7qF5hNtmqo/4v7maJapNrhalBia7LwWz/dRn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuqSAOHLZv90pPGeSnACDuXUWffBXEuYSEpM4ZJObuotJksqSeM5qtVutlO/2UEiiH3gLO86bOU3/F3V+bKjT4uulubQKmk0VPZhOGSn+CtNw+t99WQUdzV9PEtVFw5CUydYAwMo+xqMNwVdkOxQlcESYAgXkEkCmhEAd8yop9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3fUnSK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AACC4CEEB;
	Mon, 18 Aug 2025 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755527504;
	bh=x+H/JV7qF5hNtmqo/4v7maJapNrhalBia7LwWz/dRn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3fUnSK9poKsz+jssXIllY32dR75qoEJStnziXmYSQxYN+AV/WAoZkIfqBiKjP4uw
	 /mNDHnGs/4nY+ZnoOcXonOvrZhx683jbtLojkRjZl9E34t54U9ecpKNumScoVskURW
	 0a0Furkwne2676IxB+o+zkDiLFNFFXg3rQGdXTpJ+Rda46qLC4JFhirhllfpQxY4P8
	 mHHYqxFuRvRdTdW+oz+sOkPQgMOO3udanWJFwaeASmgK8z7Mf/W/hCUqgc15JRvxcg
	 vI393AhPP/1TerTvhJHU8u+RVij08+9BV1RpeUc2ADpmoCkkEhtPZg7SHciu4mhIMd
	 2yBTYTe357y9A==
Date: Mon, 18 Aug 2025 15:31:39 +0100
From: Will Deacon <will@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Frederick Mayle <fmayle@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
Message-ID: <aKM5S4oQYmRIbT3j@willie-the-truck>
References: <20250815101858.24352-1-will@kernel.org>
 <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
 <aKMrOHYbTtDhOP6O@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKMrOHYbTtDhOP6O@willie-the-truck>

On Mon, Aug 18, 2025 at 02:31:42PM +0100, Will Deacon wrote:
> On Fri, Aug 15, 2025 at 09:14:48PM -0700, Hugh Dickins wrote:
> > I think replace the folio_test_mlocked(folio) part of it by
> > (folio_test_mlocked(folio) && !folio_test_unevictable(folio)).
> > That should reduce the extra calls to a much more reasonable
> > number, while still solving your issue.
> 
> Alas, I fear that the folio may be unevictable by this point (which
> seems to coincide with the readahead fault adding it to the LRU above)
> but I can try it out.

I gave this a spin but I still see failures with this change.

Will

