Return-Path: <linux-kernel+bounces-654856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE4ABCDB6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 05:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621537ADD84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 03:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4002580F3;
	Tue, 20 May 2025 03:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ll2qeVuw"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28ED515
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747710971; cv=none; b=oyZ969wUcH/8Tcra1/yV1jQL5g7W5OOn5Ps9Kt/5b38RxBoopT3rAAwJqF7x4ILT9Kw0hz8ReQuq+kes6IiJRxLLAVz9+sifHp0syHSh4ChnzRJKuviFSapVC4+puatqghToZ2+8Rd7bGYclrHLuh2+BHyE8xZH741bZCmfoAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747710971; c=relaxed/simple;
	bh=wr/SokuYkrOkEZ/CQiuuek5E2zh5L7FO0f9nUPx6fM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZY7EB6qM0ISfJSjx+5VAzyJRLfzus/SM5ZCTjOgpvbE75PoQDRx3PuJuSFf4InlfARSD760j7pkEgCuiqqLRE019QKaVTFo9RV97shW5itRMG/njfWgZPMLLdH2CqotCrcThVpv+13nwF9fWB8xuWN3RYeopIek4w5cF8e/LppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ll2qeVuw; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ab20e420-dd11-4b39-97b9-bf8041ab62fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747710967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQfMDoQ260BGjCMrcScg0wHQ7wmLuw8S4sagjFqk5vA=;
	b=ll2qeVuwHYlqF06nbJapV7M04PIb5JWw4ezsb3LpeLlHEgtvPM+woEGuhfJ+qNRUi6arka
	5OrguEJWF2vBokVj0MAr24gB/mhPhZo/ZnGi1wrPXet3sYHISKXoMZ30IpS/Z4khtvFrEJ
	Ru/x3IjYboKkfu6GrysovtojXIv9V7s=
Date: Tue, 20 May 2025 11:15:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] mm: ksm: refer to special VMAs via VM_SPECIAL in
 ksm_compatible()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
 Xu Xin <xu.xin16@zte.com.cn>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <ec973573540c6871683ee763d291b74bd851990f.1747431920.git.lorenzo.stoakes@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ec973573540c6871683ee763d291b74bd851990f.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/5/19 16:51, Lorenzo Stoakes wrote:
> There's no need to spell out all the special cases, also doing it this way
> makes it absolutely clear that we preclude unmergeable VMAs in general, and
> puts the other excluded flags in stark and clear contrast.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Nice.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>   mm/ksm.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 08d486f188ff..d0c763abd499 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -679,9 +679,8 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
>   
>   static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
>   {
> -	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
> -			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
> -			VM_MIXEDMAP | VM_DROPPABLE))
> +	if (vm_flags & (VM_SHARED  | VM_MAYSHARE | VM_SPECIAL |
> +			VM_HUGETLB | VM_DROPPABLE))
>   		return false;		/* just ignore the advice */
>   
>   	if (file_is_dax(file))

