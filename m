Return-Path: <linux-kernel+bounces-743570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4098B10058
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CD9175067
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81F1FE444;
	Thu, 24 Jul 2025 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FupX6TPY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858861E868
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336840; cv=none; b=CBxScNwYfsO8Goqp2lP/rYR0Xm1v1V2cvXPHdTfFKNog2vYOzay0zagOrRaFaT4MW6omeeVlqrnD8AA3RTEJv6Na6/lbFa+7qfKfPdD9xQUN4DRg+fKsHFQkxv8AG2/gUPZ4XLy3ef+WzzgBYFfw7hb9YYJmNx8Y8HoNvA1S+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336840; c=relaxed/simple;
	bh=ZJDG4pk/q5OXiUjzggS/Usi6EspHl53ixtWjfVmGpx4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mycVWSOoqLGHcMMLP4KjfnBk7M9DwKg8vvzxGfGweMXoBAMMdVXf+IIPU/izywhak98DPClBi3c6JaauvepPksLjTAc3yDWhQfymcRq3iM0yrCSY4FgWt0/oFe+NIJuxKJkll8vbbxIvonrWsg5SXbBv7nduURzDo5F+4Tzj3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FupX6TPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F19C4CEED;
	Thu, 24 Jul 2025 06:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753336838;
	bh=ZJDG4pk/q5OXiUjzggS/Usi6EspHl53ixtWjfVmGpx4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FupX6TPYJ1DbiNMZX9ShqDgMuP1fmN6GPp8gN6MkEfGh5r+jeapc4h+2HTxwCiSog
	 a50IST3UkVKM+xnyMHVqYwkdKL0hXuYj9XZRX9U9AhbelgMZRmNuuG5fdCzhMWruRN
	 /qLYaPu78pCcPIZR9vweGGTX9QJICL9bQV6TitTqYSYxhfibeBPPC5BWBsmtqggkqa
	 +4M5NCpqoWXNszHGbvThkR3M4YfD8NPMRNrscYp1ks6agj8BHBoxg7cRB52BLzwan6
	 0nu4PJRkJFWPDIb304+szMMNSQBpk/x2V9hXEB+61Qzb10S85ZjqamAr6LZpdaAihV
	 OQe6mUzwE5Ecw==
Message-ID: <b17f5401-0462-42c7-8fef-0875814d1064@kernel.org>
Date: Thu, 24 Jul 2025 14:00:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, bintian.wang@honor.com, feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: avoid redundant clean nat entry
 move in lru list
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250722143628.430776-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250722143628.430776-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 22:36, wangzijie wrote:
> __lookup_nat_cache follows LRU manner to move clean nat entry, when nat
> entries are going to be dirty, no need to move them to tail of lru list.
> Introduce a parameter 'for_dirty' to avoid it.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
> v2:
> - followed by Jaegeuk's suggestion to add a parameter in __lookup_nat_cache
> ---
>  fs/f2fs/node.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 76aba1961..a23db6238 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -204,14 +204,14 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
>  	return ne;
>  }
>  
> -static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n)
> +static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n, bool for_dirty)
>  {
>  	struct nat_entry *ne;
>  
>  	ne = radix_tree_lookup(&nm_i->nat_root, n);
>  
> -	/* for recent accessed nat entry, move it to tail of lru list */
> -	if (ne && !get_nat_flag(ne, IS_DIRTY)) {
> +	/* for recent accessed(not used to set dirty) nat entry, move it to tail of lru list */

What do you think of this?

	/*
	 * for recent accessed nat entry which will not be dirtied soon
	 * later, move it to tail of lru list.
	 */

Thanks,

> +	if (ne && !get_nat_flag(ne, IS_DIRTY) && !for_dirty) {
>  		spin_lock(&nm_i->nat_list_lock);
>  		if (!list_empty(&ne->list))
>  			list_move_tail(&ne->list, &nm_i->nat_entries);
> @@ -383,7 +383,7 @@ int f2fs_need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
>  	bool need = false;
>  
>  	f2fs_down_read(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, nid);
> +	e = __lookup_nat_cache(nm_i, nid, false);
>  	if (e) {
>  		if (!get_nat_flag(e, IS_CHECKPOINTED) &&
>  				!get_nat_flag(e, HAS_FSYNCED_INODE))
> @@ -400,7 +400,7 @@ bool f2fs_is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
>  	bool is_cp = true;
>  
>  	f2fs_down_read(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, nid);
> +	e = __lookup_nat_cache(nm_i, nid, false);
>  	if (e && !get_nat_flag(e, IS_CHECKPOINTED))
>  		is_cp = false;
>  	f2fs_up_read(&nm_i->nat_tree_lock);
> @@ -414,7 +414,7 @@ bool f2fs_need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
>  	bool need_update = true;
>  
>  	f2fs_down_read(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, ino);
> +	e = __lookup_nat_cache(nm_i, ino, false);
>  	if (e && get_nat_flag(e, HAS_LAST_FSYNC) &&
>  			(get_nat_flag(e, IS_CHECKPOINTED) ||
>  			 get_nat_flag(e, HAS_FSYNCED_INODE)))
> @@ -439,7 +439,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
>  		return;
>  
>  	f2fs_down_write(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, nid);
> +	e = __lookup_nat_cache(nm_i, nid, false);
>  	if (!e)
>  		e = __init_nat_entry(nm_i, new, ne, false);
>  	else
> @@ -460,7 +460,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
>  
>  	f2fs_down_write(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, ni->nid);
> +	e = __lookup_nat_cache(nm_i, ni->nid, true);
>  	if (!e) {
>  		e = __init_nat_entry(nm_i, new, NULL, true);
>  		copy_node_info(&e->ni, ni);
> @@ -502,7 +502,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  
>  	/* update fsync_mark if its inode nat entry is still alive */
>  	if (ni->nid != ni->ino)
> -		e = __lookup_nat_cache(nm_i, ni->ino);
> +		e = __lookup_nat_cache(nm_i, ni->ino, false);
>  	if (e) {
>  		if (fsync_done && ni->nid == ni->ino)
>  			set_nat_flag(e, HAS_FSYNCED_INODE, true);
> @@ -562,7 +562,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
>  retry:
>  	/* Check nat cache */
>  	f2fs_down_read(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, nid);
> +	e = __lookup_nat_cache(nm_i, nid, false);
>  	if (e) {
>  		ni->ino = nat_get_ino(e);
>  		ni->blk_addr = nat_get_blkaddr(e);
> @@ -2371,7 +2371,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
>  		 *   - __remove_nid_from_list(PREALLOC_NID)
>  		 *                         - __insert_nid_to_list(FREE_NID)
>  		 */
> -		ne = __lookup_nat_cache(nm_i, nid);
> +		ne = __lookup_nat_cache(nm_i, nid, false);
>  		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
>  				nat_get_blkaddr(ne) != NULL_ADDR))
>  			goto err_out;
> @@ -2936,7 +2936,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>  
>  		raw_ne = nat_in_journal(journal, i);
>  
> -		ne = __lookup_nat_cache(nm_i, nid);
> +		ne = __lookup_nat_cache(nm_i, nid, true);
>  		if (!ne) {
>  			ne = __alloc_nat_entry(sbi, nid, true);
>  			__init_nat_entry(nm_i, ne, &raw_ne, true);


