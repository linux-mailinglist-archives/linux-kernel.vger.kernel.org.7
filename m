Return-Path: <linux-kernel+bounces-584342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E847A78624
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 03:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA5A7A426D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AAED299;
	Wed,  2 Apr 2025 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I+qSEBhp"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735141FC3
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743557560; cv=none; b=dzb/MArKOLAUKdDH25WH7J1cGbB6HRvgc3hYFqQijyQB1Hxm5sVSg2jY4TI7mHHfX6Byt9kY+i8hYzt+Q54z/E/aW1tFRx8dTrDaHhLCE2RJUDV03m8eiGlEOwGtlpap2eZqa/i4kCHbjDR1q1M4s8zrbTwhaSqQ92vHg8OigZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743557560; c=relaxed/simple;
	bh=6xv0UdMT2jKPGvrRdUd4aSHXjDtyS7d4b8Su/zPeQvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnek3OlbCnKcsQzzcrUjdSRo5eBlRHxQoNtAntifMcCzuOZNr64/y5Xy3IR2/Vy9aipACLyVyX4Oc4W/zAzHTjJ6W3IPMU6UR6iqZbEthL9QsNI2uVEzu4lTev1ZwiR2DZHsnzj3y/ZhqzSfc9uQXQRX2/b0nFX7hcf2y/LSxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I+qSEBhp; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743557549; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lFpBtKjDSqajrJ+0h5TnlZ61sTYpISGxLvmt6Y5CHE4=;
	b=I+qSEBhpHQNc4hRiADiC2q89pNxQw8hXWaTJm6drBfS2glrsZkBqCyiPrmGYJiqu22RlNg79penyX7b75gGRIM9Sbe1Tl1SFeriJNV0IOh5L0UbHCbu9Wj9ns7LGKoFG+67UMN+A2Q0o4nZF7eUfj7R2ZMQM+tWIoj09GFBvrwo=
Received: from 30.221.144.168(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WUCJeHV_1743557548 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Apr 2025 09:32:28 +0800
Message-ID: <ca2d7fd7-c856-4187-a15a-699334fb280d@linux.alibaba.com>
Date: Wed, 2 Apr 2025 09:32:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: fixing global bitmap allocating failure for
 discontig type
To: Heming Zhao <heming.zhao@suse.com>,
 Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250401142623.31223-1-heming.zhao@suse.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20250401142623.31223-1-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/4/1 22:26, Heming Zhao wrote:
> The commit 4eb7b93e0310 ("ocfs2: improve write IO performance when
> fragmentation is high") introduced a regression. In the discontiguous
> extent allocation case, ocfs2_cluster_group_search() is comparing with
> the wrong target length, which causes allocation failure.
> 
> Call stack:
> ocfs2_mkdir()
>  ocfs2_reserve_new_inode()
>   ocfs2_reserve_suballoc_bits()
>    ocfs2_block_group_alloc()
>     ocfs2_block_group_alloc_discontig()
>      __ocfs2_claim_clusters()
>       ocfs2_claim_suballoc_bits()
>        ocfs2_search_chain()
>         ocfs2_cluster_group_search()
> 
> Reported-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
> Fixes: 4eb7b93e0310 ("ocfs2: improve write IO performance when fragmentation is high")
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>

Looks fine.
Gautham, could you please verify this version? Thanks.

Joseph

> ---
> v1 -> v2: OCFS2_AC_USE_MAIN_DISCONTIG type requires separate handling,
>           with all other types proceeding as before.
> ---
>  fs/ocfs2/suballoc.c | 10 ++++++++--
>  fs/ocfs2/suballoc.h |  1 +
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
> index f7b483f0de2a..fde75f2af37a 100644
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
> @@ -2365,7 +2367,8 @@ int __ocfs2_claim_clusters(handle_t *handle,
>  	BUG_ON(ac->ac_bits_given >= ac->ac_bits_wanted);
>  
>  	BUG_ON(ac->ac_which != OCFS2_AC_USE_LOCAL
> -	       && ac->ac_which != OCFS2_AC_USE_MAIN);
> +	       && ac->ac_which != OCFS2_AC_USE_MAIN
> +	       && ac->ac_which != OCFS2_AC_USE_MAIN_DISCONTIG);
>  
>  	if (ac->ac_which == OCFS2_AC_USE_LOCAL) {
>  		WARN_ON(min_clusters > 1);
> @@ -2429,6 +2432,9 @@ int ocfs2_claim_clusters(handle_t *handle,
>  {
>  	unsigned int bits_wanted = ac->ac_bits_wanted - ac->ac_bits_given;
>  
> +	if (ac->ac_which == OCFS2_AC_USE_MAIN_DISCONTIG)
> +		bits_wanted = min_clusters;
> +
>  	return __ocfs2_claim_clusters(handle, ac, min_clusters,
>  				      bits_wanted, cluster_start, num_clusters);
>  }
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


