Return-Path: <linux-kernel+bounces-820330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C7B7FA84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629C11C01EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47F43093BD;
	Wed, 17 Sep 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpbyHRlj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A929AB13
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101149; cv=none; b=R2loLhYu/JMkXRGMyF5TBeXRDclzyW0KR9G5B44njp6SHTeTPvlpgGdVg54QPkAbQJCuWSMS5nhVFiiJlr5FB4Alm82yvb9v9aQf5oRWe3Ic1QEmwt2ulLeLeU7mJ+leU7CGkamwQZRT+CM06tdaJQxFnOrUm3vFEY/PJzx2png=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101149; c=relaxed/simple;
	bh=mi+c+o3FWmHPaLJiT7Mnmm6sTZe4R8F+gNG7LUzeQcM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtxSG4eondVkk9Aoa6rzdwzY+XEgopDsiHMu9nbPr4vwAjnrhIqG8SUrKizXTAn+J4Rfm78GVbzd1i5X0pgRZ3UrO8mmegUSuSwgVLfU3k6KltH927wklv73f0TZXs6z+B0VfJ+l+5sUNc7rorXCR5mAtTvgC74dXb5qcw9JBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpbyHRlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A34C4CEF0;
	Wed, 17 Sep 2025 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758101147;
	bh=mi+c+o3FWmHPaLJiT7Mnmm6sTZe4R8F+gNG7LUzeQcM=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=UpbyHRlj6I92I8jYO8q8IHg9KFI/uWkocCl/yZZihL+Pu5p5cNv9/3GUZM17ZnTEL
	 55OySOMRo/VxAf3J394PdGoWX6PnbU604tDshBIp4JnADYGd/Pkg31p/3oS9TTje5M
	 7XfdTlfu+IC1/Km3+dylN2uadA4ih0TYYSHUze4cbDLE16OZqf4/SRXFT7EkFTZb4J
	 gH3rkjwmWpvOwW12ngJ60mDM2ggbYPEiueaZ6Bn9U9mvtgUlJrFrGEpHajgaa9UoZP
	 ZMlPKuJYultxRbn5+7KKJOHkKr9t6sXPHiG2v0BXspJrgKTFHMr7j3ktzLyJEJoz06
	 rPPyl6Or7FIGA==
Date: Wed, 17 Sep 2025 12:25:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aMp-kW3OLqtZs8sh@kernel.org>
References: <982f4f94-f0bf-45dd-9003-081b76e57027@lucifer.local>
 <cda7c46b-c474-48f4-b703-e2f988470f3b@amazon.com>
 <aGVu1Isy-R9RszxW@kernel.org>
 <aGWMsfbayEco0j4R@x1.local>
 <aGbCbW7hUf3a2do2@kernel.org>
 <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>

Hi Liam,

On Mon, Sep 08, 2025 at 12:53:37PM -0400, Liam R. Howlett wrote:
> 
> Reading through the patches, I'm not entirely sure what you are
> proposing.
> 
> What I was hoping to see by a generalization of the memory types is a
> much simpler shared code base until the code hit memory type specific
> areas where a function pointer could be used to keep things from getting
> complicated (or, I guess a switch statement..).
> 
> What we don't want is non-mm code specifying values for the function
> pointer and doing what they want, or a function pointer that returns a
> core mm resource (in the old example this was a vma, here it is a
> folio).
> 
> From this patch set:
> +        * Return: zero if succeeded, negative for errors.
> +        */
> +       int (*uffd_get_folio)(struct inode *inode, pgoff_t pgoff,
> +                             struct folio **folio);
> 
> This is one of the contention points in the current scenario as the
> folio would be returned.

I don't see a problem with it. It's not any different from
vma_ops->fault(): a callback for a filesystem to get a folio that will be
mapped afterwards by the mm code.

-- 
Sincerely yours,
Mike.

