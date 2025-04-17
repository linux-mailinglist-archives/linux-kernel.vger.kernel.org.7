Return-Path: <linux-kernel+bounces-608904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A6FA91A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 13:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587D85A6184
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7CB237709;
	Thu, 17 Apr 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gvpg8SEw"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39423644A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888297; cv=none; b=hsP2kOfH2JsMOOYyJQhOuX6s5OuZ/+ORrErhC1bsuzp/sf5TNjARO6MzoytOt30OPJCMfN8PFzO7Dhihdo0d77Q6V+FwQUfCi3oCEFlvvyOyjDw9690oCVATOnQZLDpSqbIWxDSlewHwsW+mv7lBZMZq6HlYTa66Q8v/CTIn8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888297; c=relaxed/simple;
	bh=iPlBiPeQvYwklJSnGwieziVFHlC8ZbDVfSa4gQiyems=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8caBTE9RorD8euHQUUR3ulkxECczinFxpuLS5lLjfHQzx7tWh71TYT4KmfT+JSoGAgwQ9LRyOFtXlSI1x7NWEK+y6sb3cCPDj1RFl6QiRpTUeFzrLRg1JPhLAUouqk/1gFRvz0ytdXhJTzMwFqJEX6Rx2ulA8b2b056TPXTkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gvpg8SEw; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744888284; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ih4D2hjc1RuSPbkNyhYdhil7SRFVem/SvdPeGCUUw2w=;
	b=gvpg8SEwawWkJpE28CaNwp5mgUbxYySJi8WlY443CZZGHP0dJfC2rEDHwIoKeOnsRdI/TU6xJLiBA108osA4PysWN5hspQiBO/brCVXMV+qj6saA9dtyEjqr9jred2sTPOKrRvilfNQMuIJF+bFm/gh6drtM8SctEdIN3XxvL8I=
Received: from 30.221.145.47(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WXEiprf_1744888283 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Apr 2025 19:11:24 +0800
Message-ID: <518cd8d7-394c-4b19-a0b9-f73219c621de@linux.alibaba.com>
Date: Thu, 17 Apr 2025 19:11:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ocfs2: fix the issue with discontiguous allocation
 in the global_bitmap
To: Heming Zhao <heming.zhao@suse.com>, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 gautham.ananthakrishna@oracle.com
References: <20250414060125.19938-1-heming.zhao@suse.com>
 <20250414060125.19938-2-heming.zhao@suse.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20250414060125.19938-2-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/4/14 14:01, Heming Zhao wrote:
> The commit 4eb7b93e0310 ("ocfs2: improve write IO performance when
> fragmentation is high") introduced another regression.
> 
> The following ocfs2-test case can trigger this issue:
>> discontig_runner.sh => activate_discontig_bg.sh => resv_unwritten:
>> ${RESV_UNWRITTEN_BIN} -f ${WORK_PLACE}/large_testfile -s 0 -l \
>> $((${FILE_MAJOR_SIZE_M}*1024*1024))
> 
> In my env, test disk size (by "fdisk -l <dev>"):
>> 53687091200 bytes, 104857600 sectors.
> 
> Above command is:
>> /usr/local/ocfs2-test/bin/resv_unwritten -f \
>> /mnt/ocfs2/ocfs2-activate-discontig-bg-dir/large_testfile -s 0 -l \
>> 53187969024
> 
> Error log:
>> [*] Reserve 50724M space for a LARGE file, reserve 200M space for future test.
>> ioctl error 28: "No space left on device"
>> resv allocation failed Unknown error -1
>> reserve unwritten region from 0 to 53187969024.
> 
> Call flow:
> __ocfs2_change_file_space //by ioctl OCFS2_IOC_RESVSP64
>  ocfs2_allocate_unwritten_extents //start:0 len:53187969024
>   while()
>    + ocfs2_get_clusters //cpos:0, alloc_size:1623168 (cluster number)
>    + ocfs2_extend_allocation
>      + ocfs2_lock_allocators
>      |  + choose OCFS2_AC_USE_MAIN & ocfs2_cluster_group_search
>      |
>      + ocfs2_add_inode_data
>         ocfs2_add_clusters_in_btree
>          __ocfs2_claim_clusters
>           ocfs2_claim_suballoc_bits
>           + During the allocation of the final part of the large file
> 	    (after ~47GB), no chain had the required contiguous
>             bits_wanted. Consequently, the allocation failed.
> 
> How to fix:
> When OCFS2 is encountering fragmented allocation, the file system should
> stop attempting bits_wanted contiguous allocation and instead provide the
> largest available contiguous free bits from the cluster groups.
> 
> Reported-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> Fixes: 4eb7b93e0310 ("ocfs2: improve write IO performance when fragmentation is high")

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/suballoc.c | 38 ++++++++++++++++++++++++++++++++------
>  fs/ocfs2/suballoc.h |  1 +
>  2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
> index f7b483f0de2a..6ac4dcd54588 100644
> --- a/fs/ocfs2/suballoc.c
> +++ b/fs/ocfs2/suballoc.c
> @@ -698,10 +698,12 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
>  
>  	bg_bh = ocfs2_block_group_alloc_contig(osb, handle, alloc_inode,
>  					       ac, cl);
> -	if (PTR_ERR(bg_bh) == -ENOSPC)
> +	if (PTR_ERR(bg_bh) == -ENOSPC) {
> +		ac->ac_which = OCFS2_AC_USE_MAIN_DISCONTIG;
>  		bg_bh = ocfs2_block_group_alloc_discontig(handle,
>  							  alloc_inode,
>  							  ac, cl);
> +	}
>  	if (IS_ERR(bg_bh)) {
>  		status = PTR_ERR(bg_bh);
>  		bg_bh = NULL;
> @@ -1794,6 +1796,7 @@ static int ocfs2_search_chain(struct ocfs2_alloc_context *ac,
>  {
>  	int status;
>  	u16 chain;
> +	u32 contig_bits;
>  	u64 next_group;
>  	struct inode *alloc_inode = ac->ac_inode;
>  	struct buffer_head *group_bh = NULL;
> @@ -1819,10 +1822,21 @@ static int ocfs2_search_chain(struct ocfs2_alloc_context *ac,
>  	status = -ENOSPC;
>  	/* for now, the chain search is a bit simplistic. We just use
>  	 * the 1st group with any empty bits. */
> -	while ((status = ac->ac_group_search(alloc_inode, group_bh,
> -					     bits_wanted, min_bits,
> -					     ac->ac_max_block,
> -					     res)) == -ENOSPC) {
> +	while (1) {
> +		if (ac->ac_which == OCFS2_AC_USE_MAIN_DISCONTIG) {
> +			contig_bits = le16_to_cpu(bg->bg_contig_free_bits);
> +			if (!contig_bits)
> +				contig_bits = ocfs2_find_max_contig_free_bits(bg->bg_bitmap,
> +						le16_to_cpu(bg->bg_bits), 0);
> +			if (bits_wanted > contig_bits && contig_bits >= min_bits)
> +				bits_wanted = contig_bits;
> +		}
> +
> +		status = ac->ac_group_search(alloc_inode, group_bh,
> +				bits_wanted, min_bits,
> +				ac->ac_max_block, res);
> +		if (status != -ENOSPC)
> +			break;
>  		if (!bg->bg_next_group)
>  			break;
>  
> @@ -1982,6 +1996,7 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
>  	victim = ocfs2_find_victim_chain(cl);
>  	ac->ac_chain = victim;
>  
> +search:
>  	status = ocfs2_search_chain(ac, handle, bits_wanted, min_bits,
>  				    res, &bits_left);
>  	if (!status) {
> @@ -2022,6 +2037,16 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
>  		}
>  	}
>  
> +	/* Chains can't supply the bits_wanted contiguous space.
> +	 * We should switch to using every single bit when allocating
> +	 * from the global bitmap. */
> +	if (i == le16_to_cpu(cl->cl_next_free_rec) &&
> +	    status == -ENOSPC && ac->ac_which == OCFS2_AC_USE_MAIN) {
> +		ac->ac_which = OCFS2_AC_USE_MAIN_DISCONTIG;
> +		ac->ac_chain = victim;
> +		goto search;
> +	}
> +
>  set_hint:
>  	if (status != -ENOSPC) {
>  		/* If the next search of this group is not likely to
> @@ -2365,7 +2390,8 @@ int __ocfs2_claim_clusters(handle_t *handle,
>  	BUG_ON(ac->ac_bits_given >= ac->ac_bits_wanted);
>  
>  	BUG_ON(ac->ac_which != OCFS2_AC_USE_LOCAL
> -	       && ac->ac_which != OCFS2_AC_USE_MAIN);
> +	       && ac->ac_which != OCFS2_AC_USE_MAIN
> +	       && ac->ac_which != OCFS2_AC_USE_MAIN_DISCONTIG);
>  
>  	if (ac->ac_which == OCFS2_AC_USE_LOCAL) {
>  		WARN_ON(min_clusters > 1);
> diff --git a/fs/ocfs2/suballoc.h b/fs/ocfs2/suballoc.h
> index b481b834857d..bcf2ed4a8631 100644
> --- a/fs/ocfs2/suballoc.h
> +++ b/fs/ocfs2/suballoc.h
> @@ -29,6 +29,7 @@ struct ocfs2_alloc_context {
>  #define OCFS2_AC_USE_MAIN  2
>  #define OCFS2_AC_USE_INODE 3
>  #define OCFS2_AC_USE_META  4
> +#define OCFS2_AC_USE_MAIN_DISCONTIG  5
>  	u32    ac_which;
>  
>  	/* these are used by the chain search */


