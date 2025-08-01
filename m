Return-Path: <linux-kernel+bounces-753781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D19B187D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A653A1C20F61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF5B28DB5B;
	Fri,  1 Aug 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLZV5Olb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485991F03C5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076941; cv=none; b=BIW0/5wxBXzrFhADG9yEtIus7Z4yoK+X6rR10Pa9mmf9cFUw1nJqns9veKFCx6TZyJZ8hNJQ8VA3EcO1LfnVO6T4H1pQGcf4t987lrNmjJfQzKC6locNlHO0YLRx6XRyx1DJwv68YZQ4KkaXl5rQRp5IDN9MB98A2vnhV5tizN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076941; c=relaxed/simple;
	bh=N4zcWxz0G70Gk7ZR1SotpUujN9s9JmpktFgtGaCKwN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRUTCJI8uD+GepN01cUDwVMgG9BCYlIIEbFgwhYBpiKZOgpoGBEwq8zpEjLL4m2XNHXF2/wWwZ2nbiUIz1G3eROJiql3AtHyzr0J+AwYVlcu7CtUJLltElb/KKjxW7cR1BjC0SPBEQnG/F2yM0GtZyOUMyp1B4PNvk8U+9haihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLZV5Olb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8589C4CEE7;
	Fri,  1 Aug 2025 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754076940;
	bh=N4zcWxz0G70Gk7ZR1SotpUujN9s9JmpktFgtGaCKwN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLZV5OlbajLgE60JrNadzVZxjWK7VS0m42e2TNn6c+TEg9vu7pw3tsZmpKAcV6c4Q
	 zhsBn6Bc6EtM4AwoZaQ7bL/ygInRzT725Tz77TO8jgrjhcZY/LCuy5qv0WAVhTBBOq
	 ZYC+MgrCc6R6pnOuWcvhiAxJ2l46PW4ZPg9FSz8F8nIE/hCUaux8Oh1YWBtzzJfL5K
	 IojollchCFzQw8OPB8CwLdfCMxZr9je0nRrnVswN5dbJI+qQc96ydQcOcPlf3rcrg6
	 f5cQOcWgz0C9X7iVDLuBGqwMz6AdnK3LWefoZjvraJ/olE6oTX+8B3Hp1UxRxSO0qC
	 SRiZxRyc+6njw==
From: SeongJae Park <sj@kernel.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	willy@infradead.org,
	vbabka@suse.cz,
	jannh@google.com,
	pfalcato@suse.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH] mm/nommu: convert kobjsize() to folios
Date: Fri,  1 Aug 2025 12:35:37 -0700
Message-Id: <20250801193537.1149-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731202629.3729139-1-sidhartha.kumar@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 31 Jul 2025 20:26:29 +0000 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> Simple folio conversion to remove a user of PageSlab() and
> PageCompound().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

I have a trivial comment below, but since it is just a trivial one that I don't
really care,

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/nommu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 07504d666d6a..a00f8fc316c1 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -64,7 +64,7 @@ const struct vm_operations_struct generic_file_vm_ops = {
>   */
>  unsigned int kobjsize(const void *objp)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  
>  	/*
>  	 * If the object we have should not have ksize performed on it,
> @@ -73,22 +73,22 @@ unsigned int kobjsize(const void *objp)
>  	if (!objp || !virt_addr_valid(objp))
>  		return 0;
>  
> -	page = virt_to_head_page(objp);
> +	folio = virt_to_folio(objp);
>  
>  	/*
>  	 * If the allocator sets PageSlab, we know the pointer came from
>  	 * kmalloc().
>  	 */
> -	if (PageSlab(page))
> +	if (folio_test_slab(folio))
>  		return ksize(objp);
>  
>  	/*
> -	 * If it's not a compound page, see if we have a matching VMA
> +	 * If it's not a compound folio, see if we have a matching VMA

Nit.  I think "a large folio" rather than "a compound folio" is more consistent
and easier to read/understand.  No strong opinion, though.

>  	 * region. This test is intentionally done in reverse order,
>  	 * so if there's no VMA, we still fall through and hand back
> -	 * PAGE_SIZE for 0-order pages.
> +	 * PAGE_SIZE for 0-order folios.
>  	 */
> -	if (!PageCompound(page)) {
> +	if (!folio_test_large(folio)) {
>  		struct vm_area_struct *vma;
>  
>  		vma = find_vma(current->mm, (unsigned long)objp);
> @@ -100,7 +100,7 @@ unsigned int kobjsize(const void *objp)
>  	 * The ksize() function is only guaranteed to work for pointers
>  	 * returned by kmalloc(). So handle arbitrary pointers here.
>  	 */
> -	return page_size(page);
> +	return folio_size(folio);
>  }
>  
>  void vfree(const void *addr)
> -- 
> 2.43.0


Thanks,
SJ

