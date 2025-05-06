Return-Path: <linux-kernel+bounces-635313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B0AABC6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 10:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5ED3AB1EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95E1A23A9;
	Tue,  6 May 2025 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z2sKxBHG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CC1E493C
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 07:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746514894; cv=none; b=gGdOa5f4eSR7YYa/3GmipUMJuoUpKtoi6JqqFOvZ1t+55FhKG2WUDPDmC7ANpAzJ9JtIOt0Ijm3heQcgpz9lQZenzlv+bdlvII2M1cTeiJPbHabh8qzS/GqkLYr6hzjzuwrn2bdYs7y+WxiDCvjXo9alnXhPpuD4JhOgt71SW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746514894; c=relaxed/simple;
	bh=w9uxW/9oeSFU7jsO6s9mzRWQ4gOuUHQwYzTuGEWVL9o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ixkkGD7i8eY7WoJqsP1uYNcyLwDUFYhXeVL+SeN6QlTPh053enNSW7dJqFbOtNkBTf10OPca8YeQEKKGSs3dNTRwjD0FBVewoXWvD7924uy45BihRJJ5tjmyKD+oQwHZfmLiUCA+Lfn1sLyUKAPUVuAJrJQiBngkSau8rgYcLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z2sKxBHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF136C4CEE4;
	Tue,  6 May 2025 07:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746514894;
	bh=w9uxW/9oeSFU7jsO6s9mzRWQ4gOuUHQwYzTuGEWVL9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2sKxBHGWSNf5nAr2gfqkZHaiqJbxdeG6vfjhfSsQ4BRL8KQ+qGKAPA5cV60+gjBF
	 3ih0N/yDF+NkQaMsBnlSt+2KOpIk8Lp8dRozkE+Q+xumyhpCsSffxzhzI1SXLlCw47
	 8+n+JFNfheL+OU2U7IWsvnAI9tMKShYL+aS6miZE=
Date: Tue, 6 May 2025 00:01:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Juan Yescas <jyescas@google.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tjmercier@google.com,
 isaacmanjarres@google.com, surenb@google.com, kaleshsingh@google.com,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v3] mm: Add CONFIG_PAGE_BLOCK_ORDER to select page block
 order
Message-Id: <20250506000133.ba44539dd517e4f54515751b@linux-foundation.org>
In-Reply-To: <20250506002319.513795-1-jyescas@google.com>
References: <20250506002319.513795-1-jyescas@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 May 2025 17:22:58 -0700 Juan Yescas <jyescas@google.com> wrote:

> Problem: On large page size configurations (16KiB, 64KiB), the CMA
> alignment requirement (CMA_MIN_ALIGNMENT_BYTES) increases considerably,
> and this causes the CMA reservations to be larger than necessary.
> This means that system will have less available MIGRATE_UNMOVABLE and
> MIGRATE_RECLAIMABLE page blocks since MIGRATE_CMA can't fallback to them.
> 
> The CMA_MIN_ALIGNMENT_BYTES increases because it depends on
> MAX_PAGE_ORDER which depends on ARCH_FORCE_MAX_ORDER. The value of
> ARCH_FORCE_MAX_ORDER increases on 16k and 64k kernels.
> 
> ...
>
> +config PAGE_BLOCK_ORDER
> +	int "Page Block Order"
> +	range 1 10 if !ARCH_FORCE_MAX_ORDER
> +	default 10 if !ARCH_FORCE_MAX_ORDER
> +	range 1 ARCH_FORCE_MAX_ORDER if ARCH_FORCE_MAX_ORDER
> +	default ARCH_FORCE_MAX_ORDER if ARCH_FORCE_MAX_ORDER

Do we really need to do this arithmetic within Kconfig?  Would it be
cleaner to do this at runtime, presumably when calculating
pageblock_order?

