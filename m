Return-Path: <linux-kernel+bounces-743806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B567B10382
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254B73B2333
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02227467A;
	Thu, 24 Jul 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVza8sQo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30432627FC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345620; cv=none; b=Sj13DvHZllGIfVQjd1vCDB/tOCz+Cg8xiNLO/sck1gFv/z4F6fQjEG05dt1NO2Zs3ZYGEIFj6r8ZnhunXKyu1tiXCGHr+DLpTMN7Po52b2UeeB0PG5m4zI+pc6TcrYsCmP/69SiuZExERYzK2vO/CKFO4+LyCUbEyIO6AySJ250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345620; c=relaxed/simple;
	bh=AS9oSAtnXCiLGpDS7E6ua5uptnVgrdquz2ExPdxddWM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pf120ny4RsiYCXVRyC3+t5tZtYauZQA4ktGLSm3PkzCN9kzPum7bHo1VzjHhEolk5brCimmOiw+oJJDbRnZDn2RDf/c4FjdJ8+KrH8eupJEbZMnMe3nnTEw8rL3y7wBtPgjIojkgcmZXwPfg5UgXqhvKXmN7AZ2ZPpif+MD2tR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVza8sQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA23AC4CEED;
	Thu, 24 Jul 2025 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753345619;
	bh=AS9oSAtnXCiLGpDS7E6ua5uptnVgrdquz2ExPdxddWM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LVza8sQopt7EYLj/qAZw01FGeasXwMWKCoPtlDFv3UJK2BVXz33YJmUDhSahRP6pb
	 ppiU6XTz47+RiYaGTNFBLuoEf+Teiy7IqJBs8Z1Podm3x9PraxMBC2tsq4oceFTOq7
	 eSlw/yE/mQee96gdo/08dYkiwrk814Yi+aDWQUKgPPhmA88VYp0WugSf2JKU0xwUhm
	 piXwAuyceoVuEL6n91x4b1ql/33+tDPg34yXGRPxYStEkLA0qVJaMc6To4TDl6oofg
	 tZD40SiZljPzfs0To1Kw1ZsT/RsZmd/uiSvpnZp4Rsylo5EbHJAwEJRQRgp4YhpFv+
	 sJQG5foJ2HDEA==
Message-ID: <524de02e-31a1-4b98-8601-edaa51d40d56@kernel.org>
Date: Thu, 24 Jul 2025 16:26:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, bintian.wang@honor.com, feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: directly add newly allocated
 pre-dirty nat entry to dirty set list
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250722143628.430776-1-wangzijie1@honor.com>
 <20250722143628.430776-2-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250722143628.430776-2-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 22:36, wangzijie wrote:
> When we need to alloc nat entry and set it dirty, we can directly add it to
> dirty set list(or initialize its list_head for new_ne) instead of adding it
> to clean list and make a move. Introduce init_dirty flag to do it.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>  fs/f2fs/node.c | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index a23db6238..20bcf8559 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -185,7 +185,7 @@ static void __free_nat_entry(struct nat_entry *e)
>  
>  /* must be locked by nat_tree_lock */
>  static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
> -	struct nat_entry *ne, struct f2fs_nat_entry *raw_ne, bool no_fail)
> +	struct nat_entry *ne, struct f2fs_nat_entry *raw_ne, bool no_fail, bool init_dirty)
>  {
>  	if (no_fail)
>  		f2fs_radix_tree_insert(&nm_i->nat_root, nat_get_nid(ne), ne);
> @@ -195,6 +195,11 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
>  	if (raw_ne)
>  		node_info_from_raw_nat(&ne->ni, raw_ne);
>  
> +	if (init_dirty) {
> +		nm_i->nat_cnt[TOTAL_NAT]++;
> +		return ne;
> +	}
> +
>  	spin_lock(&nm_i->nat_list_lock);
>  	list_add_tail(&ne->list, &nm_i->nat_entries);
>  	spin_unlock(&nm_i->nat_list_lock);
> @@ -256,7 +261,7 @@ static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *nm_i,
>  }
>  
>  static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> -						struct nat_entry *ne)
> +					struct nat_entry *ne, bool init_dirty)
>  {
>  	struct nat_entry_set *head;
>  	bool new_ne = nat_get_blkaddr(ne) == NEW_ADDR;
> @@ -275,6 +280,18 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
>  
>  	set_nat_flag(ne, IS_PREALLOC, new_ne);
>  
> +	if (init_dirty) {
> +		nm_i->nat_cnt[DIRTY_NAT]++;
> +		set_nat_flag(ne, IS_DIRTY, true);
> +		spin_lock(&nm_i->nat_list_lock);
> +		if (new_ne)
> +			INIT_LIST_HEAD(&ne->list);
> +		else
> +			list_add_tail(&ne->list, &head->entry_list);
> +		spin_unlock(&nm_i->nat_list_lock);
> +		return;
> +    }

Nit issue, above blanks should be replaced w/ tab.

Can we clean up like this?

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index de99b42437c6..60fc2c7b8e10 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -280,30 +280,23 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,

 	set_nat_flag(ne, IS_PREALLOC, new_ne);

-	if (init_dirty) {
-		nm_i->nat_cnt[DIRTY_NAT]++;
-		set_nat_flag(ne, IS_DIRTY, true);
-		spin_lock(&nm_i->nat_list_lock);
-		if (new_ne)
-			INIT_LIST_HEAD(&ne->list);
-		else
-			list_add_tail(&ne->list, &head->entry_list);
-		spin_unlock(&nm_i->nat_list_lock);
-		return;
-    }
-
 	if (get_nat_flag(ne, IS_DIRTY))
 		goto refresh_list;

 	nm_i->nat_cnt[DIRTY_NAT]++;
-	nm_i->nat_cnt[RECLAIMABLE_NAT]--;
+	if (!init_dirty)
+		nm_i->nat_cnt[RECLAIMABLE_NAT]--;
 	set_nat_flag(ne, IS_DIRTY, true);
 refresh_list:
 	spin_lock(&nm_i->nat_list_lock);
-	if (new_ne)
-		list_del_init(&ne->list);
-	else
+	if (new_ne) {
+		if (init_dirty)
+			INIT_LIST_HEAD(&ne->list);
+		else
+			list_del_init(&ne->list);
+	} else {
 		list_move_tail(&ne->list, &head->entry_list);
+	}
 	spin_unlock(&nm_i->nat_list_lock);
 }

Thanks,

> +
>  	if (get_nat_flag(ne, IS_DIRTY))
>  		goto refresh_list;
>  
> @@ -441,7 +458,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
>  	f2fs_down_write(&nm_i->nat_tree_lock);
>  	e = __lookup_nat_cache(nm_i, nid, false);
>  	if (!e)
> -		e = __init_nat_entry(nm_i, new, ne, false);
> +		e = __init_nat_entry(nm_i, new, ne, false, false);
>  	else
>  		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
>  				nat_get_blkaddr(e) !=
> @@ -458,11 +475,13 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct nat_entry *e;
>  	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
> +	bool init_dirty = false;
>  
>  	f2fs_down_write(&nm_i->nat_tree_lock);
>  	e = __lookup_nat_cache(nm_i, ni->nid, true);
>  	if (!e) {
> -		e = __init_nat_entry(nm_i, new, NULL, true);
> +		init_dirty = true;
> +		e = __init_nat_entry(nm_i, new, NULL, true, true);
>  		copy_node_info(&e->ni, ni);
>  		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
>  	} else if (new_blkaddr == NEW_ADDR) {
> @@ -498,7 +517,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  	nat_set_blkaddr(e, new_blkaddr);
>  	if (!__is_valid_data_blkaddr(new_blkaddr))
>  		set_nat_flag(e, IS_CHECKPOINTED, false);
> -	__set_nat_cache_dirty(nm_i, e);
> +	__set_nat_cache_dirty(nm_i, e, init_dirty);
>  
>  	/* update fsync_mark if its inode nat entry is still alive */
>  	if (ni->nid != ni->ino)
> @@ -2924,6 +2943,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>  	struct f2fs_journal *journal = curseg->journal;
>  	int i;
> +	bool init_dirty;
>  
>  	down_write(&curseg->journal_rwsem);
>  	for (i = 0; i < nats_in_cursum(journal); i++) {
> @@ -2934,12 +2954,15 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>  		if (f2fs_check_nid_range(sbi, nid))
>  			continue;
>  
> +		init_dirty = false;
> +
>  		raw_ne = nat_in_journal(journal, i);
>  
>  		ne = __lookup_nat_cache(nm_i, nid, true);
>  		if (!ne) {
> +			init_dirty = true;
>  			ne = __alloc_nat_entry(sbi, nid, true);
> -			__init_nat_entry(nm_i, ne, &raw_ne, true);
> +			__init_nat_entry(nm_i, ne, &raw_ne, true, true);
>  		}
>  
>  		/*
> @@ -2954,7 +2977,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>  			spin_unlock(&nm_i->nid_list_lock);
>  		}
>  
> -		__set_nat_cache_dirty(nm_i, ne);
> +		__set_nat_cache_dirty(nm_i, ne, init_dirty);
>  	}
>  	update_nats_in_cursum(journal, -i);
>  	up_write(&curseg->journal_rwsem);


