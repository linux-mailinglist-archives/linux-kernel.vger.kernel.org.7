Return-Path: <linux-kernel+bounces-741866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0F3B0EA02
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2811C87CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8721D5B3;
	Wed, 23 Jul 2025 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHux7sbx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FF2F4A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247921; cv=none; b=Ofrvnp39Wk1pOCxn0ktn0iePEGP/XYlDE7PWekvSnMxoQgEVXVCvu9VTvpoITts9+ARt5DLZ7uxiraJsrrl5py2FvMh6x0FjRiiwIjPAWMl2eyVEL75d+9xbHLmYrZksu3TwX/uhiOeG9FVmtzOz3mbstE/kCuwv0WkQ8ZPqrJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247921; c=relaxed/simple;
	bh=kF4IPwhM4HYaC5OYAGkDsFkIDR4awcOTgIWQid4x2yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF3tRuY3/Mx7mjOhpOzligqe8ymcsP1a/Cyn3yXU4oEGEcRR3HN+1faVWsDOPXzEbsE0dgjreDLXiN/l8SmX2i6hYJ9j0vrF41J/tq+HCBO2Wa5pMrG61L1XC9D70/Q+tO/hldeARjp/xg0mGNmMxD70lG8eZhGoaycrapE7h+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHux7sbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236D7C4CEE7;
	Wed, 23 Jul 2025 05:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753247921;
	bh=kF4IPwhM4HYaC5OYAGkDsFkIDR4awcOTgIWQid4x2yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHux7sbx11I7KG2xIMA7yFSf3JCpZ2HV6BNUYZXPxObtWAS2elBxr8Bg5BICdgMSr
	 ILbzPBLstH4OI/luBuwso9nu26oL8SmVUKOG7trO+/MhrP6TaEnl4MOa5X4RGpIP0t
	 zM82H15ER3b/5eNiWPfxN46UGqLV7RVXfKjgaExQ1vXTvyn7TY2cIRSfZjOE3r45wF
	 w3FuXqVMuDxHc4Ph/Phvpo4XgROKtRwbGTgjh9N3iBI837GC1EfpUHxNv7ZxbDo2bp
	 n7vMMJHon9yrSvCbrmjIlJSpofKaOw0w6ZXO+1aXAIWqd3QlYkCaU8xlHLMuPsWuf/
	 jgP4uQ8H/kfkg==
Date: Wed, 23 Jul 2025 08:18:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] MAINTAINERS: rename MM to MM MISC, add missing files
Message-ID: <aIBwqmITl1VyZp7S@kernel.org>
References: <20250722192704.164758-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722192704.164758-1-lorenzo.stoakes@oracle.com>

On Tue, Jul 22, 2025 at 08:27:04PM +0100, Lorenzo Stoakes wrote:
> To fit in with other sections within MAINTAINERS for memory management
> files, rename the MEMORY MANAGEMENT section to MEMORY MANAGEMENT - MISC to
> contain files that are not described by other sections.
> 
> We also add missing files to MEMORY MANAGEMENT - MISC and MEMORY MANAGEMENT
> - CORE sections.
> 
> Move over appropriate files to the core section, and in both sections add
> remaining missing files. At this point, with the other recent MAINTAINERS
> changes, this should now mean that every memory management-related file has
> a section and assigned maintainers/reviewers.
> 
> For the time being, we maintain catch-all mm/ and tools/mm/ entries for MM
> - MISC, though in future we may wish to remove these to make it obvious
> when files don't have assigned entries.
> 
> Finally, we copy across the maintainers/reviewers from MEMORY MANAGEMENT -
> CORE to MEMORY MANAGEMENT - MISC, as it seems the two are sufficiently
> related for this to be sensible.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

