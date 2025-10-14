Return-Path: <linux-kernel+bounces-852864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D06BDA20D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EC0581F06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2430170C;
	Tue, 14 Oct 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wcBR3W7A"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DF2FF164
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452895; cv=none; b=mcW9idiQ0UqFdasmGd2Ubqg4DRyPXGjvlrB9saJol1vtJ/Pvyj6StKugMwXy8l0Sm6sfO6VGxhwDfKWJ09yQbjBz6f9m3cP2AJFiPW+/aOWYeuj+FQMqC22sbIdA/FcgepHfc1dyKp1jiCj4rz0egp623kLiV2in7W4fra9A5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452895; c=relaxed/simple;
	bh=EnFd3hKLw7xglwwAfM0zsnf/4D4i4YLszNYTMx7pwrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wvc5eYLHNfUPGXcMdlg7PT9tDLiDYnoZNKddych+cpg2kN5NKf+ZqMP1GNJroxodJSiZXGMzsmtHgbUnOwZI3IpqZIEfI6xDZQ3ChZ4+VPjut1VbXv6mp6eJuNTKFOdJas9yufqYW5VpmUm4Ctr55AwSfNgaWNrabbxoxXkCGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wcBR3W7A; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9f46ef5-b7fe-4592-b458-ecb91652d2ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760452880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYEZcyD6SgizdudERHV1+QQWcWpelGTwNBq9Zz7nboU=;
	b=wcBR3W7A1MLjmuD0laWyZl/i3lVq1YSI3HECA4D2THldQYOuCm4+vWkIYMAGRIUiODD2sx
	ht7jOzaToTsV1Qh7H/vEAnMHu5gYDS5D67TalwIuwTBLiwnY65frzmmUliYJUpMW04/QOl
	Pl8jMP7IM0kCl+qOHXDAtwWxcylNYCw=
Date: Tue, 14 Oct 2025 07:41:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: remove redundant assignment to variable
 page_offset
To: Colin Ian King <coking@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251014120343.2528608-1-coking@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251014120343.2528608-1-coking@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/14 5:03, Colin Ian King 写道:
> The variable page_offset is being assigned a value at the start of
> a loop and being redundantly zero'd at the end of the loop, there
> is no code that reads the zero'd value. The assignment is redundant
> and can be removed.
> 
> Signed-off-by: Colin Ian King <coking@nvidia.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c  | 1 -
>   drivers/infiniband/sw/rxe/rxe_odp.c | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index bcb97b3ea58a..b1df05238848 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -452,7 +452,6 @@ static int rxe_mr_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int leng
>   
>   		length -= bytes;
>   		iova += bytes;
> -		page_offset = 0;
>   	}
static int rxe_mr_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned 
int length)
{
	unsigned int page_offset;
	...
	while (length > 0) {
		index = rxe_mr_iova_to_index(mr, iova);
		page = xa_load(&mr->page_list, index);
		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
	...
		page_offset = 0;
	}

	return 0;
}>
>   	return 0;
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index f58e3ec6252f..ae71812bea82 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -358,7 +358,6 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>   
>   		length -= bytes;
>   		iova += bytes;
> -		page_offset = 0;
>   	}
int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
			    unsigned int length)
{
	unsigned int page_offset;
...
	while (length > 0) {
		index = rxe_odp_iova_to_index(umem_odp, iova);
		page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
...
		page_offset = 0;
	}

	mutex_unlock(&umem_odp->umem_mutex);

	return 0;
}
 From the above, in the functions rxe_mr_flush_pmem_iova and 
rxe_odp_flush_pmem_iova, within the while loop, the variable page_offset 
is assigned a value. At the end of the loop, page_offset is set to 0. 
However, this assignment at the end of the loop is actually unnecessary.

Thanks,
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   
>   	mutex_unlock(&umem_odp->umem_mutex);



