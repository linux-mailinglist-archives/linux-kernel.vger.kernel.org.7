Return-Path: <linux-kernel+bounces-681284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AA5AD50AF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23263A3E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C32609C6;
	Wed, 11 Jun 2025 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/6FMBTw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D419924D;
	Wed, 11 Jun 2025 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635859; cv=none; b=HJy56u2hA08O/tYGWx6R4/WhLeuyvOL2KRolR0CmZ5osj9zwqyeNZiuXd4JIP6XZRdLX1kVyitoIyFKPAXLE3Ku4KUSAybCXv0gKL9w760QDAjPCfAjMRiXJQLwfAJgpwnkqU0k9nbnGRl0EueSOy6LxKBVC9w7jXgZhOj3pVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635859; c=relaxed/simple;
	bh=e6TS5O+g2JwrZ8I2ZOF2aYAJsjX+AZS4VpHURqwjnLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2dT9NDu7sX75kEYXEUTl9o3r6oOjySndrx4LgkNVksbaas/U0jZN99aA/sXMpa0H6Z6FCAQJO+KBH1wqxu8laUsNstc+pz0tIeN5Uo3kVROiFG/q7gwVHrJq+kVoVvCXSOzUYpIkV+y092Vq6aAmC9h1lrgKvc8ytwUbJcYIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/6FMBTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0735C4CEEE;
	Wed, 11 Jun 2025 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749635858;
	bh=e6TS5O+g2JwrZ8I2ZOF2aYAJsjX+AZS4VpHURqwjnLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/6FMBTwIaQN2SRyM9vkcaCmosGcBtQJ+c5KUx2YCVnXFjDAKwf0hWKHhrni5xlbj
	 dmklTuh3gfNT6cdQk/B4ISt7Gbtt+cfFSaFqiAGDp8HyX7WCSNCVQ+9ugGxnP8eCJU
	 RB84oU9HHmsM/BCT0riqULfcimJiV4k55VpfsMyzIQtBTBIOQ6r0rATDg9sItv3kME
	 lDhSusRlWoJCNI0V5+jLYHEcUpRwdl1seRedsQuzgP2OjF5L/g3RUkb1koXcnxHbbn
	 J0HWHLacUxMOiUEiwjenshSVoafxRufNA8zPFF5Zme7COtU9+zqoGv9W/ABUjyGtGV
	 21Y3/bjAhoqwg==
Date: Wed, 11 Jun 2025 11:57:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v5 3/5] mm/readahead: Make space in struct file_ra_state
Message-ID: <20250611-mitleid-ablief-1e7f1f03394d@brauner>
References: <20250609092729.274960-1-ryan.roberts@arm.com>
 <20250609092729.274960-4-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250609092729.274960-4-ryan.roberts@arm.com>

On Mon, Jun 09, 2025 at 10:27:25AM +0100, Ryan Roberts wrote:
> We need to be able to store the preferred folio order associated with a
> readahead request in the struct file_ra_state so that we can more
> accurately increase the order across subsequent readahead requests. But
> struct file_ra_state is per-struct file, so we don't really want to
> increase it's size.
> 
> mmap_miss is currently 32 bits but it is only counted up to 10 *
> MMAP_LOTSAMISS, which is currently defined as 1000. So 16 bits should be
> plenty. Redefine it to unsigned short, making room for order as unsigned
> short in follow up commit.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/fs.h |  2 +-
>  mm/filemap.c       | 11 ++++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 05abdabe9db7..87e7d5790e43 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1052,7 +1052,7 @@ struct file_ra_state {
>  	unsigned int size;
>  	unsigned int async_size;
>  	unsigned int ra_pages;
> -	unsigned int mmap_miss;
> +	unsigned short mmap_miss;

Thanks for not making struct file grow!

