Return-Path: <linux-kernel+bounces-745188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8D4B11652
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069DB17D160
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC62264A9;
	Fri, 25 Jul 2025 02:17:50 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15F1EE032
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753409869; cv=none; b=H2wEjWcgaA/y9lYw2knSf3XQ/2R5IwIl+Tgp263aorwmVFuWyRKQuk5YhUBcDTXBqqgdB/3Db7TNNSMM3MF+flAn6TBZfAr+YNK2wnqT6i4TJuM+brWrLnjpvMiG75HTEoezMBF+tRtbFCbOin8iBCEhVs2OcgCXKLNp38IHGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753409869; c=relaxed/simple;
	bh=AxhAm3YGoErvD4+o4eGWIvBUboB6VYSXtZ5RN6TXrJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiwFLRW7G0mN1FgAUK0KWtI+QQ4F058s3SwdCKD1Os7IwUxf79/MQMtYwn26YeBkfHEb3dX4JH0pcEBbtskCKh+mO2eCMIb+rQAmFFAzQXZW7n/iK53x2Rc5+fGi3HT3LOb9XsUWglz/l2bJ6xRrMor3M/syw1sqmZxjNwfbmvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4bpBKJ63cjzYnRvj;
	Fri, 25 Jul 2025 10:15:00 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Jul
 2025 10:17:39 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Jul
 2025 10:17:38 +0800
From: wangzijie <wangzijie1@honor.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
CC: <chao@kernel.org>, <feng.han@honor.com>, <jaegeuk@kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: directly add newly allocated pre-dirty nat entry to dirty set list
Date: Fri, 25 Jul 2025 10:17:38 +0800
Message-ID: <20250725021738.1011413-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <524de02e-31a1-4b98-8601-edaa51d40d56@kernel.org>
References: <524de02e-31a1-4b98-8601-edaa51d40d56@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a011.hihonor.com
 (10.68.31.243)

> On 7/22/25 22:36, wangzijie wrote:
> > When we need to alloc nat entry and set it dirty, we can directly add it to
> > dirty set list(or initialize its list_head for new_ne) instead of adding it
> > to clean list and make a move. Introduce init_dirty flag to do it.
> > 
> > Signed-off-by: wangzijie <wangzijie1@honor.com>
> > ---
> >  fs/f2fs/node.c | 37 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index a23db6238..20bcf8559 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -185,7 +185,7 @@ static void __free_nat_entry(struct nat_entry *e)
> >  
> >  /* must be locked by nat_tree_lock */
> >  static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
> > -	struct nat_entry *ne, struct f2fs_nat_entry *raw_ne, bool no_fail)
> > +	struct nat_entry *ne, struct f2fs_nat_entry *raw_ne, bool no_fail, bool init_dirty)
> >  {
> >  	if (no_fail)
> >  		f2fs_radix_tree_insert(&nm_i->nat_root, nat_get_nid(ne), ne);
> > @@ -195,6 +195,11 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
> >  	if (raw_ne)
> >  		node_info_from_raw_nat(&ne->ni, raw_ne);
> >  
> > +	if (init_dirty) {
> > +		nm_i->nat_cnt[TOTAL_NAT]++;
> > +		return ne;
> > +	}
> > +
> >  	spin_lock(&nm_i->nat_list_lock);
> >  	list_add_tail(&ne->list, &nm_i->nat_entries);
> >  	spin_unlock(&nm_i->nat_list_lock);
> > @@ -256,7 +261,7 @@ static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *nm_i,
> >  }
> >  
> >  static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> > -						struct nat_entry *ne)
> > +					struct nat_entry *ne, bool init_dirty)
> >  {
> >  	struct nat_entry_set *head;
> >  	bool new_ne = nat_get_blkaddr(ne) == NEW_ADDR;
> > @@ -275,6 +280,18 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> >  
> >  	set_nat_flag(ne, IS_PREALLOC, new_ne);
> >  
> > +	if (init_dirty) {
> > +		nm_i->nat_cnt[DIRTY_NAT]++;
> > +		set_nat_flag(ne, IS_DIRTY, true);
> > +		spin_lock(&nm_i->nat_list_lock);
> > +		if (new_ne)
> > +			INIT_LIST_HEAD(&ne->list);
> > +		else
> > +			list_add_tail(&ne->list, &head->entry_list);
> > +		spin_unlock(&nm_i->nat_list_lock);
> > +		return;
> > +    }
> 
> Nit issue, above blanks should be replaced w/ tab.

Ah...my bad :-(

> Can we clean up like this?
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index de99b42437c6..60fc2c7b8e10 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -280,30 +280,23 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> 
>  	set_nat_flag(ne, IS_PREALLOC, new_ne);
> 
> -	if (init_dirty) {
> -		nm_i->nat_cnt[DIRTY_NAT]++;
> -		set_nat_flag(ne, IS_DIRTY, true);
> -		spin_lock(&nm_i->nat_list_lock);
> -		if (new_ne)
> -			INIT_LIST_HEAD(&ne->list);
> -		else
> -			list_add_tail(&ne->list, &head->entry_list);
> -		spin_unlock(&nm_i->nat_list_lock);
> -		return;
> -    }
> -
>  	if (get_nat_flag(ne, IS_DIRTY))
>  		goto refresh_list;
> 
>  	nm_i->nat_cnt[DIRTY_NAT]++;
> -	nm_i->nat_cnt[RECLAIMABLE_NAT]--;
> +	if (!init_dirty)
> +		nm_i->nat_cnt[RECLAIMABLE_NAT]--;
>  	set_nat_flag(ne, IS_DIRTY, true);
>  refresh_list:
>  	spin_lock(&nm_i->nat_list_lock);
> -	if (new_ne)
> -		list_del_init(&ne->list);
> -	else
> +	if (new_ne) {
> +		if (init_dirty)
> +			INIT_LIST_HEAD(&ne->list);
> +		else
> +			list_del_init(&ne->list);
> +	} else {
>  		list_move_tail(&ne->list, &head->entry_list);
> +	}
>  	spin_unlock(&nm_i->nat_list_lock);
>  }
> 
> Thanks,

We need to init list_head before using list_move_tail.
I think we can do more clean up like this, keep refresh_list part code.

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 20bcf8559..ebb624fa1 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -196,6 +196,7 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
 		node_info_from_raw_nat(&ne->ni, raw_ne);
 
 	if (init_dirty) {
+		INIT_LIST_HEAD(&ne->list);
 		nm_i->nat_cnt[TOTAL_NAT]++;
 		return ne;
 	}
@@ -280,23 +281,12 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 
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

> > +
> >  	if (get_nat_flag(ne, IS_DIRTY))
> >  		goto refresh_list;
> >  
> > @@ -441,7 +458,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
> >  	f2fs_down_write(&nm_i->nat_tree_lock);
> >  	e = __lookup_nat_cache(nm_i, nid, false);
> >  	if (!e)
> > -		e = __init_nat_entry(nm_i, new, ne, false);
> > +		e = __init_nat_entry(nm_i, new, ne, false, false);
> >  	else
> >  		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
> >  				nat_get_blkaddr(e) !=
> > @@ -458,11 +475,13 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
> >  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> >  	struct nat_entry *e;
> >  	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
> > +	bool init_dirty = false;
> >  
> >  	f2fs_down_write(&nm_i->nat_tree_lock);
> >  	e = __lookup_nat_cache(nm_i, ni->nid, true);
> >  	if (!e) {
> > -		e = __init_nat_entry(nm_i, new, NULL, true);
> > +		init_dirty = true;
> > +		e = __init_nat_entry(nm_i, new, NULL, true, true);
> >  		copy_node_info(&e->ni, ni);
> >  		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
> >  	} else if (new_blkaddr == NEW_ADDR) {
> > @@ -498,7 +517,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
> >  	nat_set_blkaddr(e, new_blkaddr);
> >  	if (!__is_valid_data_blkaddr(new_blkaddr))
> >  		set_nat_flag(e, IS_CHECKPOINTED, false);
> > -	__set_nat_cache_dirty(nm_i, e);
> > +	__set_nat_cache_dirty(nm_i, e, init_dirty);
> >  
> >  	/* update fsync_mark if its inode nat entry is still alive */
> >  	if (ni->nid != ni->ino)
> > @@ -2924,6 +2943,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
> >  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
> >  	struct f2fs_journal *journal = curseg->journal;
> >  	int i;
> > +	bool init_dirty;
> >  
> >  	down_write(&curseg->journal_rwsem);
> >  	for (i = 0; i < nats_in_cursum(journal); i++) {
> > @@ -2934,12 +2954,15 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
> >  		if (f2fs_check_nid_range(sbi, nid))
> >  			continue;
> >  
> > +		init_dirty = false;
> > +
> >  		raw_ne = nat_in_journal(journal, i);
> >  
> >  		ne = __lookup_nat_cache(nm_i, nid, true);
> >  		if (!ne) {
> > +			init_dirty = true;
> >  			ne = __alloc_nat_entry(sbi, nid, true);
> > -			__init_nat_entry(nm_i, ne, &raw_ne, true);
> > +			__init_nat_entry(nm_i, ne, &raw_ne, true, true);
> >  		}
> >  
> >  		/*
> > @@ -2954,7 +2977,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
> >  			spin_unlock(&nm_i->nid_list_lock);
> >  		}
> >  
> > -		__set_nat_cache_dirty(nm_i, ne);
> > +		__set_nat_cache_dirty(nm_i, ne, init_dirty);
> >  	}
> >  	update_nats_in_cursum(journal, -i);
> >  	up_write(&curseg->journal_rwsem);


