Return-Path: <linux-kernel+bounces-831741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E19B9D72A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D6B2E2525
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1D92E7F29;
	Thu, 25 Sep 2025 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcDk9GaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BCA2989BC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758777943; cv=none; b=CoDkoUDHCqDFNa7QnCshlYPF58qKZHa8YveNjLggfiRW5ccaIO12uGEnk1AGrvGW0n3h2zBnZVIXM3opfkrM9+wAo0Jb5eK0ujuY2HPoNT98185c16yLJY+n4DbWhdkhSuS+R3v4NMa3ltauGpOIt6IjMRTOqItXlFtx7AVkgeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758777943; c=relaxed/simple;
	bh=OGudxTQC2g9GWDssdOMa7QneRr36x2Z9xVSFQN+8uMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbBszpXoXTIJnD79+POn/zBLiHJCAVYsrMlCdkCSVouHyemo3fqa5YcyhNOkUUCLAXSe3k3BPpb5RZp911tmE/MMrd54nilLYcrY6IqyfQauWNpZGh5HbbbOEZbmCuOt4l5xnQrfb5C9O0UDhtV7Rx/31OUdvHTyXXaRSLzIxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcDk9GaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A352C4CEF0;
	Thu, 25 Sep 2025 05:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758777943;
	bh=OGudxTQC2g9GWDssdOMa7QneRr36x2Z9xVSFQN+8uMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcDk9GaZRzRW1zsoel/WbDttK1TmFSovPAg0aERxDxbLpJzCYC2Xg2VwWqbS1RBL5
	 8Ku/w0fsjx+u7zelLKiCfxyKt+7Tr+GzWth5TYEG3PX7e0+L6ONIlu6KVZ8kgphlOq
	 NxPq+5M03AgyPhiy2kfvpZBHfC0fNmX5YIlzCpZflaLCm1V/lDyIHDOyrbb67YdPb5
	 cY56TOX5b+wATU438Q4RDvuyH9YWGkqucIjosNDvLZLKapbKqw60YyQIS65UKbzTQP
	 7exEYAtWCj4ZAr334FYq8ezivXhfWnzRje0m+OR2vXkDDwkNaht9VZlA1GDsXKA8Za
	 E+tdgYgA9heJw==
Date: Thu, 25 Sep 2025 08:25:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, elver@google.com,
	dvyukov@google.com, kasan-dev@googlegroups.com,
	Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH v2] mm/memblock: Correct totalram_pages accounting with
 KMSAN
Message-ID: <aNTST_OoeUxLQu-6@kernel.org>
References: <20250924100301.1558645-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924100301.1558645-1-glider@google.com>

On Wed, Sep 24, 2025 at 12:03:01PM +0200, Alexander Potapenko wrote:
> When KMSAN is enabled, `kmsan_memblock_free_pages()` can hold back pages
> for metadata instead of returning them to the early allocator. The callers,
> however, would unconditionally increment `totalram_pages`, assuming the
> pages were always freed. This resulted in an incorrect calculation of the
> total available RAM, causing the kernel to believe it had more memory than
> it actually did.
> 
> This patch refactors `memblock_free_pages()` to return the number of pages
> it successfully frees. If KMSAN stashes the pages, the function now
> returns 0; otherwise, it returns the number of pages in the block.
> 
> The callers in `memblock.c` have been updated to use this return value,
> ensuring that `totalram_pages` is incremented only by the number of pages
> actually returned to the allocator. This corrects the total RAM accounting
> when KMSAN is active.
> 
> Cc: Aleksandr Nogikh <nogikh@google.com>
> Fixes: 3c2065098260 ("init: kmsan: call KMSAN initialization routines")
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

