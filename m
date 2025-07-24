Return-Path: <linux-kernel+bounces-743636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1676B1012F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD06158578C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C96214A7B;
	Thu, 24 Jul 2025 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="P834fNjy"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536611E9B3A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340270; cv=none; b=PLt/8gOCLAYQb1IU2KU+HpXTqeHHQqtMF4YKajeKwlqtHCeeVYoHLeCeqtLggQMAArFPYTZqP7rM+pPTiPzxOdYrpdcLX8OIuRrZdWN5z7ZSaaduK2DY1GDNol4s3chbWv3QeC8iRZGYx5sRDe+fYSkqlkaXGSdXfjOoO2mp/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340270; c=relaxed/simple;
	bh=lOrqEij4bO3aKy6WkuBzkyt1KT8dBtUPO6TG52+Pnk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnBwQaa0YWlwHi4r/0vqa3FuzvnaMOxaxqBU4aoyG0pU8vFrg6V0qOasjbpoQiZpxx1kt/we7YTlk+DJwG4xRGWfdBXs/PT/Ufqy8bfRYga2BzrCQO0hHvI5daEYfgGgCwckLy1vHm93S/PJ8GyRKzgoqEaYzcg3b3xfgwCX5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=P834fNjy; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=u6S7XS/xkA5P8VT7oxrBjYtiiKRZUn36jJAQ/vC02Sw=;
	b=P834fNjyqzB7lZJ64cWYX4yTxTvR5+6AifvETmSCGYtQarq1PzGzTUeHwD6XzKuu8qnG45je8
	iUanFydyEQGpoN+lGAUxl89OXnrdl7P1iPYB9PFIrJYJ3yY+zeJb1azKcdLWUPCebyL+nzXc6/E
	y1so9cmJ+wrBKVHlOi/d2WE=
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4bnhbF1HlszYlQ3p;
	Thu, 24 Jul 2025 14:55:21 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Jul
 2025 14:57:37 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Jul
 2025 14:57:36 +0800
From: wangzijie <wangzijie1@honor.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
CC: <chao@kernel.org>, <feng.han@honor.com>, <jaegeuk@kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: avoid redundant clean nat entry move in lru list
Date: Thu, 24 Jul 2025 14:57:36 +0800
Message-ID: <20250724065736.634693-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b17f5401-0462-42c7-8fef-0875814d1064@kernel.org>
References: <b17f5401-0462-42c7-8fef-0875814d1064@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
 (10.68.31.243)

> On 7/22/25 22:36, wangzijie wrote:
> > __lookup_nat_cache follows LRU manner to move clean nat entry, when nat
> > entries are going to be dirty, no need to move them to tail of lru list.
> > Introduce a parameter 'for_dirty' to avoid it.
> > 
> > Signed-off-by: wangzijie <wangzijie1@honor.com>
> > ---
> > v2:
> > - followed by Jaegeuk's suggestion to add a parameter in __lookup_nat_cache
> > ---
> >  fs/f2fs/node.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 76aba1961..a23db6238 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -204,14 +204,14 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
> >  	return ne;
> >  }
> >  
> > -static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n)
> > +static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n, bool for_dirty)
> >  {
> >  	struct nat_entry *ne;
> >  
> >  	ne = radix_tree_lookup(&nm_i->nat_root, n);
> >  
> > -	/* for recent accessed nat entry, move it to tail of lru list */
> > -	if (ne && !get_nat_flag(ne, IS_DIRTY)) {
> > +	/* for recent accessed(not used to set dirty) nat entry, move it to tail of lru list */
> 
> What do you think of this?
> 
> 	/*
> 	 * for recent accessed nat entry which will not be dirtied soon
> 	 * later, move it to tail of lru list.
> 	 */
> 
> Thanks,

Hi, Chao
Thank you for your suggestion. Let me update comment in next version.

> > +	if (ne && !get_nat_flag(ne, IS_DIRTY) && !for_dirty) {
> >  		spin_lock(&nm_i->nat_list_lock);
> >  		if (!list_empty(&ne->list))
> >  			list_move_tail(&ne->list, &nm_i->nat_entries);
> > @@ -383,7 +383,7 @@ int f2fs_need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
> >  	bool need = false;
> >  
> >  	f2fs_down_read(&nm_i->nat_tree_lock);
> > -	e = __lookup_nat_cache(nm_i, nid);
> > +	e = __lookup_nat_cache(nm_i, nid, false);
> >  	if (e) {
> >  		if (!get_nat_flag(e, IS_CHECKPOINTED) &&
> >  				!get_nat_flag(e, HAS_FSYNCED_INODE))
> > @@ -400,7 +400,7 @@ bool f2fs_is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
> >  	bool is_cp = true;
> >  
> >  	f2fs_down_read(&nm_i->nat_tree_lock);
> > -	e = __lookup_nat_cache(nm_i, nid);
> > +	e = __lookup_nat_cache(nm_i, nid, false);
> >  	if (e && !get_nat_flag(e, IS_CHECKPOINTED))
> >  		is_cp = false;
> >  	f2fs_up_read(&nm_i->nat_tree_lock);
> > @@ -414,7 +414,7 @@ bool f2fs_need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
> >  	bool need_update = true;
> >  
> >  	f2fs_down_read(&nm_i->nat_tree_lock);
> > -	e = __lookup_nat_cache(nm_i, ino);
> > +	e = __lookup_nat_cache(nm_i, ino, false);
> >  	if (e && get_nat_flag(e, HAS_LAST_FSYNC) &&
> >  			(get_nat_flag(e, IS_CHECKPOINTED) ||
> >  			 get_nat_flag(e, HAS_FSYNCED_INODE)))
> > @@ -439,7 +439,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
> >  		return;
> >  
> >  	f2fs_down_write(&nm_i->nat_tree_lock);
> > -	e = __lookup_nat_cache(nm_i, nid);
> > +	e = __lookup_nat_cache(nm_i, nid, false);
> >  	if (!e)
> >  		e = __init_nat_entry(nm_i, new, ne, false);
> >  	else
> > @@ -460,7 +460,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
> >  	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
> >  
> >  	f2fs_down_write(&nm_i->nat_tree_lock);
> > -	e = __lookup_nat_cache(nm_i, ni->nid);
> > +	e = __lookup_nat_cache(nm_i, ni->nid, true);
> >  	if (!e) {
> >  		e = __init_nat_entry(nm_i, new, NULL, true);
> >  		copy_node_info(&e->ni, ni);
> > @@ -502,7 +502,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
> >  
> >  	/* update fsync_mark if its inode nat entry is still alive */
> >  	if (ni->nid != ni->ino)
> > -		e = __lookup_nat_cache(nm_i, ni->ino);
> > +		e = __lookup_nat_cache(nm_i, ni->ino, false);
> >  	if (e) {
> >  		if (fsync_done && ni->nid == ni->ino)
> >  			set_nat_flag(e, HAS_FSYNCED_INODE, true);
> > @@ -562,7 +562,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
> >  retry:
> >  	/* Check nat cache */
> >  	f2fs_down_read(&nm_i->nat_tree_lock);
> > -	e = __lookup_nat_cache(nm_i, nid);
> > +	e = __lookup_nat_cache(nm_i, nid, false);
> >  	if (e) {
> >  		ni->ino = nat_get_ino(e);
> >  		ni->blk_addr = nat_get_blkaddr(e);
> > @@ -2371,7 +2371,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
> >  		 *   - __remove_nid_from_list(PREALLOC_NID)
> >  		 *                         - __insert_nid_to_list(FREE_NID)
> >  		 */
> > -		ne = __lookup_nat_cache(nm_i, nid);
> > +		ne = __lookup_nat_cache(nm_i, nid, false);
> >  		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
> >  				nat_get_blkaddr(ne) != NULL_ADDR))
> >  			goto err_out;
> > @@ -2936,7 +2936,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
> >  
> >  		raw_ne = nat_in_journal(journal, i);
> >  
> > -		ne = __lookup_nat_cache(nm_i, nid);
> > +		ne = __lookup_nat_cache(nm_i, nid, true);
> >  		if (!ne) {
> >  			ne = __alloc_nat_entry(sbi, nid, true);
> >  			__init_nat_entry(nm_i, ne, &raw_ne, true);

