Return-Path: <linux-kernel+bounces-821668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01597B81E94
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69285881A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F011314D2F;
	Wed, 17 Sep 2025 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rUbvzeb6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8112314D0D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143730; cv=none; b=YlTVdrm68S9lvmEjslp0pQyWEwbuZwQfbHuM8+8o0JGbroBGVGxjOvnarff6Yiwbk/LEWXUTsSc/RjMkn1zU+9UOGs6n/lkM1kVspFNCz4w/8Pf7ieZZMlCcm5ISBowWncDShAQUTCasmhlinSwv8J93dqTWFNghu0YEI0BP89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143730; c=relaxed/simple;
	bh=DcxYPaU/C9Z8kxq2ijoz5I5wq5YK+7WzAtenGXmcCw8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hfkM/UZcbs84YyvzHiQKCnNtiA2Jao6MOiEYzKvRB9RHj1BgtRaveA0nfBiobZoVp96Fus/2zxV9rtkF6zfpmgAQAb0eXefFMtzsvO4V3rmufjZKW8ndCjdh4Nm5sCHKI0KPCNLY8Y04MmdzlvOQdnRCUTx/NsxmwNWkBD52+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rUbvzeb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA83BC4CEE7;
	Wed, 17 Sep 2025 21:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758143729;
	bh=DcxYPaU/C9Z8kxq2ijoz5I5wq5YK+7WzAtenGXmcCw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUbvzeb6lTZ+Whs/55k7lgnRyrOb9pGJ8yrG1X4a738PSNve1uqUlZcQLNspuugE5
	 igqRsR7m7ZGW7YhWZbOsdqHura7PFNCHH12FdrnOJlBb9p1LgYcJsXXfuvBQcK1aBL
	 Zpue6/TV2+E0fX526TLpn03YIXhPqX3qMwZoVtXo=
Date: Wed, 17 Sep 2025 14:15:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Changyuan
 Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush
 Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] kho: add support for preserving vmalloc
 allocations
Message-Id: <20250917141528.cd619a95a19a33d71dcc4b1c@linux-foundation.org>
In-Reply-To: <20250917174033.3810435-4-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
	<20250917174033.3810435-4-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 20:40:32 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> A vmalloc allocation is preserved using binary structure similar to
> global KHO memory tracker. It's a linked list of pages where each page
> is an array of physical address of pages in vmalloc area.
> 
> kho_preserve_vmalloc() hands out the physical address of the head page
> to the caller. This address is used as the argument to
> kho_vmalloc_restore() to restore the mapping in the vmalloc address
> space and populate it with the preserved pages.
> 
> ...
>
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -39,12 +39,22 @@ struct page;
>  
>  struct kho_serialization;
>  
> +struct kho_vmalloc_chunk;
> +struct kho_vmalloc {
> +        DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);

offtopic nit: DECLARE_KHOSER_PTR() *defines* a union named "first".  It
doesn't declare one.  A better name for this would have been DEFINE_...

And the world would be a better place if those three macros had a bit
of documentation ;)

The code looks nice though.

