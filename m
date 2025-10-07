Return-Path: <linux-kernel+bounces-844834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33586BC2E17
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEE81891A08
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E9C2494D8;
	Tue,  7 Oct 2025 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="swC7I8sH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72E3A1D2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876465; cv=none; b=vCoD7mMCuH4rHQp6oZYrV8tFtz5plErTID9HGv0XaRMJDpvdmDeOpBY2FGdGE2lkhUUEkfDG6XAcutgXvMk03YJELoJ1QmJTOhPbQpnS6VkSVMm7oXXlLC2w7GzMSwyGS3pzbaPUZw5t1uJqS6IDP95XZG7ANdcjWzM7GuFMlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876465; c=relaxed/simple;
	bh=jhp6SV6anK/PGrNJeEzIoxrnja1H0V2Sd5G7xaZKuWI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rKWVx/Gtr+4z5EsvSCVAsZ+D/jqdnt42xgwjQizi3nXu4aKSI0UBM8fA/K6deD8ffHSROfqXoBMZZ80fSR0GJ19RvQdVybQyIyM58T7L8hfPF3jeP8rFWbnPt3ZrwuR+Gft+rssc1E+ZK6HxXLLOzzRI5sP9RmpWPF7MPR1lhbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=swC7I8sH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D0EC4CEF1;
	Tue,  7 Oct 2025 22:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759876464;
	bh=jhp6SV6anK/PGrNJeEzIoxrnja1H0V2Sd5G7xaZKuWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=swC7I8sHM52a/RUTuobaO6U2Z4PX35vJoB46A8XLLwChLLWdb+tjlShuHSqhLQq/B
	 3lJAyXE2QD23pkR+FfzBmPgbomh2ciDvXhc3eqHLuJ76BcmmIRLytZA6MWtU5Q0LVp
	 fg8Jt7Ecc9lQGppPfBliHnBE7PK8ug2SG3MSgpKU=
Date: Tue, 7 Oct 2025 15:34:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Dev Jain
 <dev.jain@arm.com>, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: readahead: make thp readahead conditional to
 mmap_miss logic
Message-Id: <20251007153424.1b46a4018e17d5dafd7fb126@linux-foundation.org>
In-Reply-To: <20251006175106.377411-1-roman.gushchin@linux.dev>
References: <20251006175106.377411-1-roman.gushchin@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Oct 2025 10:51:06 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> Commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> introduced a special handling for VM_HUGEPAGE mappings: even if the
> readahead is disabled, 1 or 2 HPAGE_PMD_ORDER pages are
> allocated.

Three years ago.

> This change causes a significant regression

So no backport suggested?  I guess reasonable given how long 4687fdbb805a has
been in tree.

>
> ...
>

> for containers with a
> tight memory.max limit, if VM_HUGEPAGE is widely used. Prior to this
> commit, mmap_miss logic would eventually lead to the readahead
> disablement, effectively reducing the memory pressure in the
> cgroup. With this change the kernel is trying to allocate 1-2 huge
> pages for each fault, no matter if these pages are used or not
> before being evicted, increasing the memory pressure multi-fold.
>
> ...
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dev Jain <dev.jain@arm.com>

But I'll slap the Fixes: in there, it might help someone.

