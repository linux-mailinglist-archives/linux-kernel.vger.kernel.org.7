Return-Path: <linux-kernel+bounces-806178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C3B492FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE39A1B208BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EE230DD14;
	Mon,  8 Sep 2025 15:22:32 +0000 (UTC)
Received: from leontynka.twibright.com (leontynka.twibright.com [109.81.181.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C91A2387;
	Mon,  8 Sep 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.81.181.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344951; cv=none; b=AI9RKg1uNWLNZ8k04yVwRVWFgM3VNRG3KWM+ClfIVG29nGKnk5xEcHJ0FkNM1GFZcQ+etPWPvLvzYAFyaE6YBTRDvo2p7xjd9PClR2REHRnrnlqwnG7qYq9Y71+3+P6OUZwN87ksWreCwSsZ0bfkNNHqkUOhaGNLT8m2HfqX/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344951; c=relaxed/simple;
	bh=MgsRTG+t4Kj3xSpnI65GEsv/QtEGsMgrOeZ/tmMGNp0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NSHpAviKbdR9XHbwYF/tWxK5WzzGweoi4HWKe7oTS8a0y4DdEf1BJ7L8J8B6HKmFsoiQQk9b9587SIbH0M9VfwdfoK6l2ZHP4pH87gPgHyGOjaMKNTBDuBzjsLl2q/NsBMurZ4jLig7jsriWifHsthYF1LzePczxtf6twUftc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=twibright.com; spf=pass smtp.mailfrom=twibright.com; arc=none smtp.client-ip=109.81.181.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=twibright.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twibright.com
Received: from mikulas (helo=localhost)
	by leontynka.twibright.com with local-esmtp (Exim 4.96)
	(envelope-from <mikulas@twibright.com>)
	id 1uvd0f-00A86K-0E;
	Mon, 08 Sep 2025 16:38:21 +0200
Date: Mon, 8 Sep 2025 16:38:21 +0200 (CEST)
From: Mikulas Patocka <mikulas@twibright.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
    Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] fs: hpfs: Avoid multiple -Wflex-array-member-not-at-end
 warnings
In-Reply-To: <8007649f-324a-4dfb-ae33-9bed8c8d6eec@embeddedor.com>
Message-ID: <d7f2fee4-1832-b47d-f33f-79b9d4b79645@twibright.com>
References: <aJnpXOndcEAF6_NW@kspp> <8007649f-324a-4dfb-ae33-9bed8c8d6eec@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 27 Aug 2025, Gustavo A. R. Silva wrote:

> Hi all,
> 
> Friendly ping: who can take/review this, please?
> 
> Any comments or feedback is greatly appreciated. :)
> 
> Thanks!
> -Gustavo

Hi

I comitted the patch here, thanks.
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=hpfs

Mikulas

> On 11/08/25 15:00, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> > 
> > So, in order to avoid ending up with a flexible-array member in the
> > middle of other structs, we use the `struct_group_tagged()` helper
> > to create a new tagged `struct bplus_header_fixed`. This structure
> > groups together all the members of the flexible `struct bplus_header`
> > except the flexible array.
> > 
> > As a result, the array is effectively separated from the rest of the
> > members without modifying the memory layout of the flexible structure.
> > We then change the type of the middle struct member currently causing
> > trouble from `struct bplus_header` to `struct bplus_header_fixed`.
> > 
> > We also want to ensure that when new members need to be added to the
> > flexible structure, they are always included within the newly created
> > tagged struct. For this, we use `static_assert()`. This ensures that the
> > memory layout for both the flexible structure and the new tagged struct
> > is the same after any changes.
> > 
> > This approach avoids having to implement `struct bplus_header_fixed`
> > as a completely separate structure, thus preventing having to maintain
> > two independent but basically identical structures, closing the door
> > to potential bugs in the future.
> > 
> > We also use `container_of()` (via a wrapper) whenever we need to retrieve
> > a pointer to the flexible structure, through which we can access the
> > flexible-array member, if necessary.
> > 
> > So, with these changes, fix 26 of the following type of warnings:
> > fs/hpfs/hpfs.h:456:23: warning: structure containing a flexible array member
> > is not at the end of another structure [-Wflex-array-member-not-at-end]
> > fs/hpfs/hpfs.h:498:23: warning: structure containing a flexible array member
> > is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > Changes in v2:
> >   - Add GET_BTREE_PTR() wrapper for container_of().
> > 
> >   fs/hpfs/anode.c | 43 ++++++++++++++++++++++---------------------
> >   fs/hpfs/ea.c    |  2 +-
> >   fs/hpfs/file.c  |  4 +++-
> >   fs/hpfs/hpfs.h  | 44 +++++++++++++++++++++++++++++++-------------
> >   fs/hpfs/map.c   |  8 ++++----
> >   5 files changed, 61 insertions(+), 40 deletions(-)
> > 
> > diff --git a/fs/hpfs/anode.c b/fs/hpfs/anode.c
> > index c14c9a035ee0..a4f5321eafae 100644
> > --- a/fs/hpfs/anode.c
> > +++ b/fs/hpfs/anode.c
> > @@ -27,7 +27,7 @@ secno hpfs_bplus_lookup(struct super_block *s, struct
> > inode *inode,
> >   				a = le32_to_cpu(btree->u.internal[i].down);
> >   				brelse(bh);
> >   				if (!(anode = hpfs_map_anode(s, a, &bh)))
> > return -1;
> > -				btree = &anode->btree;
> > +				btree = GET_BTREE_PTR(&anode->btree);
> >   				goto go_down;
> >   			}
> >   		hpfs_error(s, "sector %08x not found in internal anode %08x",
> > sec, a);
> > @@ -69,12 +69,13 @@ secno hpfs_add_sector_to_btree(struct super_block *s,
> > secno node, int fnod, unsi
> >   	int n;
> >   	unsigned fs;
> >   	int c1, c2 = 0;
> > +
> >   	if (fnod) {
> >   		if (!(fnode = hpfs_map_fnode(s, node, &bh))) return -1;
> > -		btree = &fnode->btree;
> > +		btree = GET_BTREE_PTR(&fnode->btree);
> >   	} else {
> >   		if (!(anode = hpfs_map_anode(s, node, &bh))) return -1;
> > -		btree = &anode->btree;
> > +		btree = GET_BTREE_PTR(&anode->btree);
> >   	}
> >   	a = node;
> >   	go_down:
> > @@ -91,7 +92,7 @@ secno hpfs_add_sector_to_btree(struct super_block *s,
> > secno node, int fnod, unsi
> >   		if (hpfs_sb(s)->sb_chk)
> >   			if (hpfs_stop_cycles(s, a, &c1, &c2,
> > "hpfs_add_sector_to_btree #1")) return -1;
> >   		if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
> > -		btree = &anode->btree;
> > +		btree = GET_BTREE_PTR(&anode->btree);
> >   		goto go_down;
> >   	}
> >   	if (n >= 0) {
> > @@ -151,7 +152,7 @@ secno hpfs_add_sector_to_btree(struct super_block *s,
> > secno node, int fnod, unsi
> >   		}
> >   		brelse(bh);
> >   		bh = bh1;
> > -		btree = &anode->btree;
> > +		btree = GET_BTREE_PTR(&anode->btree);
> >   	}
> >   	btree->n_free_nodes--; n = btree->n_used_nodes++;
> >   	le16_add_cpu(&btree->first_free, 12);
> > @@ -168,10 +169,10 @@ secno hpfs_add_sector_to_btree(struct super_block *s,
> > secno node, int fnod, unsi
> >   			if (hpfs_stop_cycles(s, up, &c1, &c2,
> > "hpfs_add_sector_to_btree #2")) return -1;
> >   		if (up != node || !fnod) {
> >   			if (!(anode = hpfs_map_anode(s, up, &bh))) return -1;
> > -			btree = &anode->btree;
> > +			btree = GET_BTREE_PTR(&anode->btree);
> >   		} else {
> >   			if (!(fnode = hpfs_map_fnode(s, up, &bh))) return -1;
> > -			btree = &fnode->btree;
> > +			btree = GET_BTREE_PTR(&fnode->btree);
> >   		}
> >   		if (btree->n_free_nodes) {
> >   			btree->n_free_nodes--; n = btree->n_used_nodes++;
> > @@ -206,8 +207,8 @@ secno hpfs_add_sector_to_btree(struct super_block *s,
> > secno node, int fnod, unsi
> >   			anode->btree.n_used_nodes = 1;
> >   			anode->btree.n_free_nodes = 59;
> >   			anode->btree.first_free = cpu_to_le16(16);
> > -			anode->btree.u.internal[0].down = cpu_to_le32(a);
> > -			anode->btree.u.internal[0].file_secno =
> > cpu_to_le32(-1);
> > +			GET_BTREE_PTR(&anode->btree)->u.internal[0].down =
> > cpu_to_le32(a);
> > +			GET_BTREE_PTR(&anode->btree)->u.internal[0].file_secno
> > = cpu_to_le32(-1);
> >   			mark_buffer_dirty(bh);
> >   			brelse(bh);
> >   			if ((anode = hpfs_map_anode(s, a, &bh))) {
> > @@ -229,20 +230,20 @@ secno hpfs_add_sector_to_btree(struct super_block *s,
> > secno node, int fnod, unsi
> >   			brelse(bh2);
> >   			return -1;
> >   		}
> > -		btree = &anode->btree;
> > +		btree = GET_BTREE_PTR(&anode->btree);
> >   	} else {
> >   		if (!(fnode = hpfs_map_fnode(s, node, &bh))) {
> >   			brelse(bh2);
> >   			return -1;
> >   		}
> > -		btree = &fnode->btree;
> > +		btree = GET_BTREE_PTR(&fnode->btree);
> >   	}
> >   	ranode->up = cpu_to_le32(node);
> >   	memcpy(&ranode->btree, btree, le16_to_cpu(btree->first_free));
> >   	if (fnod)
> >   		ranode->btree.flags |= BP_fnode_parent;
> > -	ranode->btree.n_free_nodes = (bp_internal(&ranode->btree) ? 60 : 40) -
> > ranode->btree.n_used_nodes;
> > -	if (bp_internal(&ranode->btree)) for (n = 0; n <
> > ranode->btree.n_used_nodes; n++) {
> > +	GET_BTREE_PTR(&ranode->btree)->n_free_nodes =
> > (bp_internal(GET_BTREE_PTR(&ranode->btree)) ? 60 : 40) -
> > GET_BTREE_PTR(&ranode->btree)->n_used_nodes;
> > +	if (bp_internal(GET_BTREE_PTR(&ranode->btree))) for (n = 0; n <
> > GET_BTREE_PTR(&ranode->btree)->n_used_nodes; n++) {
> >   		struct anode *unode;
> >   		if ((unode = hpfs_map_anode(s,
> > le32_to_cpu(ranode->u.internal[n].down), &bh1))) {
> >   			unode->up = cpu_to_le32(ra);
> > @@ -291,7 +292,7 @@ void hpfs_remove_btree(struct super_block *s, struct
> > bplus_header *btree)
> >   			if (hpfs_stop_cycles(s, ano, &d1, &d2,
> > "hpfs_remove_btree #1"))
> >   				return;
> >   		if (!(anode = hpfs_map_anode(s, ano, &bh))) return;
> > -		btree1 = &anode->btree;
> > +		btree1 = GET_BTREE_PTR(&anode->btree);
> >   		level++;
> >   		pos = 0;
> >   	}
> > @@ -307,7 +308,7 @@ void hpfs_remove_btree(struct super_block *s, struct
> > bplus_header *btree)
> >   	ano = le32_to_cpu(anode->up);
> >   	if (--level) {
> >   		if (!(anode = hpfs_map_anode(s, ano, &bh))) return;
> > -		btree1 = &anode->btree;
> > +		btree1 = GET_BTREE_PTR(&anode->btree);
> >   	} else btree1 = btree;
> >   	for (i = 0; i < btree1->n_used_nodes; i++) {
> >   		if (le32_to_cpu(btree1->u.internal[i].down) == oano) {
> > @@ -332,7 +333,7 @@ static secno anode_lookup(struct super_block *s,
> > anode_secno a, unsigned sec)
> >   	struct anode *anode;
> >   	struct buffer_head *bh;
> >   	if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
> > -	return hpfs_bplus_lookup(s, NULL, &anode->btree, sec, bh);
> > +	return hpfs_bplus_lookup(s, NULL, GET_BTREE_PTR(&anode->btree), sec,
> > bh);
> >   }
> >     int hpfs_ea_read(struct super_block *s, secno a, int ano, unsigned pos,
> > @@ -388,7 +389,7 @@ void hpfs_ea_remove(struct super_block *s, secno a, int
> > ano, unsigned len)
> >   	struct buffer_head *bh;
> >   	if (ano) {
> >   		if (!(anode = hpfs_map_anode(s, a, &bh))) return;
> > -		hpfs_remove_btree(s, &anode->btree);
> > +		hpfs_remove_btree(s, GET_BTREE_PTR(&anode->btree));
> >   		brelse(bh);
> >   		hpfs_free_sectors(s, a, 1);
> >   	} else hpfs_free_sectors(s, a, (len + 511) >> 9);
> > @@ -407,10 +408,10 @@ void hpfs_truncate_btree(struct super_block *s, secno
> > f, int fno, unsigned secs)
> >   	int c1, c2 = 0;
> >   	if (fno) {
> >   		if (!(fnode = hpfs_map_fnode(s, f, &bh))) return;
> > -		btree = &fnode->btree;
> > +		btree = GET_BTREE_PTR(&fnode->btree);
> >   	} else {
> >   		if (!(anode = hpfs_map_anode(s, f, &bh))) return;
> > -		btree = &anode->btree;
> > +		btree = GET_BTREE_PTR(&anode->btree);
> >   	}
> >   	if (!secs) {
> >   		hpfs_remove_btree(s, btree);
> > @@ -448,7 +449,7 @@ void hpfs_truncate_btree(struct super_block *s, secno f,
> > int fno, unsigned secs)
> >   			if (hpfs_stop_cycles(s, node, &c1, &c2,
> > "hpfs_truncate_btree"))
> >   				return;
> >   		if (!(anode = hpfs_map_anode(s, node, &bh))) return;
> > -		btree = &anode->btree;
> > +		btree = GET_BTREE_PTR(&anode->btree);
> >   	}	
> >   	nodes = btree->n_used_nodes + btree->n_free_nodes;
> >   	for (i = 0; i < btree->n_used_nodes; i++)
> > @@ -485,7 +486,7 @@ void hpfs_remove_fnode(struct super_block *s,
> > fnode_secno fno)
> >   	struct extended_attribute *ea;
> >   	struct extended_attribute *ea_end;
> >   	if (!(fnode = hpfs_map_fnode(s, fno, &bh))) return;
> > -	if (!fnode_is_dir(fnode)) hpfs_remove_btree(s, &fnode->btree);
> > +	if (!fnode_is_dir(fnode)) hpfs_remove_btree(s,
> > GET_BTREE_PTR(&fnode->btree));
> >   	else hpfs_remove_dtree(s,
> > le32_to_cpu(fnode->u.external[0].disk_secno));
> >   	ea_end = fnode_end_ea(fnode);
> >   	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
> > diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
> > index 102ba18e561f..2149d3ca530b 100644
> > --- a/fs/hpfs/ea.c
> > +++ b/fs/hpfs/ea.c
> > @@ -41,7 +41,7 @@ void hpfs_ea_ext_remove(struct super_block *s, secno a,
> > int ano, unsigned len)
> >   		struct buffer_head *bh;
> >   		struct anode *anode;
> >   		if ((anode = hpfs_map_anode(s, a, &bh))) {
> > -			hpfs_remove_btree(s, &anode->btree);
> > +			hpfs_remove_btree(s, GET_BTREE_PTR(&anode->btree));
> >   			brelse(bh);
> >   			hpfs_free_sectors(s, a, 1);
> >   		}
> > diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
> > index 263b5bbe1849..29e876705369 100644
> > --- a/fs/hpfs/file.c
> > +++ b/fs/hpfs/file.c
> > @@ -51,7 +51,9 @@ static secno hpfs_bmap(struct inode *inode, unsigned
> > file_secno, unsigned *n_sec
> >   		return hpfs_inode->i_disk_sec + n;
> >   	}
> >   	if (!(fnode = hpfs_map_fnode(inode->i_sb, inode->i_ino, &bh))) return
> > 0;
> > -	disk_secno = hpfs_bplus_lookup(inode->i_sb, inode, &fnode->btree,
> > file_secno, bh);
> > +	disk_secno = hpfs_bplus_lookup(inode->i_sb, inode,
> > +				       GET_BTREE_PTR(&fnode->btree),
> > +				       file_secno, bh);
> >   	if (disk_secno == -1) return 0;
> >   	if (hpfs_chk_sectors(inode->i_sb, disk_secno, 1, "bmap")) return 0;
> >   	n = file_secno - hpfs_inode->i_file_sec;
> > diff --git a/fs/hpfs/hpfs.h b/fs/hpfs/hpfs.h
> > index 281dec8f636b..353f73c914d9 100644
> > --- a/fs/hpfs/hpfs.h
> > +++ b/fs/hpfs/hpfs.h
> > @@ -394,27 +394,45 @@ enum {
> >   	BP_binary_search = 0x40,
> >   	BP_internal = 0x80
> >   };
> > +
> > +/**
> > + * GET_BTREE_PTR() - Get a pointer to struct bplus_header
> > + *
> > + * Wrapper around container_of() to retrieve a pointer to struct
> > + * bplus_header from a pointer to struct bplus_header_fixed.
> > + *
> > + * @ptr: Pointer to struct bplus_header_fixed.
> > + *
> > + */
> > +#define GET_BTREE_PTR(ptr) \
> > +	container_of(ptr, struct bplus_header, __hdr)
> > +
> >   struct bplus_header
> >   {
> > -  u8 flags;				/* bit 0 - high bit of first free
> > entry offset
> > +	/* New members MUST be added within the struct_group() macro below. */
> > +	struct_group_tagged(bplus_header_fixed, __hdr,
> > +		u8 flags;		/* bit 0 - high bit of first free
> > entry offset
> >   					   bit 5 - we're pointed to by an
> > fnode,
> >   					   the data btree or some ea or the
> >   					   main ea bootage pointer ea_secno
> >   					   bit 6 - suggest binary search
> > (unused)
> >   					   bit 7 - 1 -> (internal) tree of
> > anodes
> >   						   0 -> (leaf) list of extents
> > */
> > -  u8 fill[3];
> > -  u8 n_free_nodes;			/* free nodes in following array */
> > -  u8 n_used_nodes;			/* used nodes in following array */
> > -  __le16 first_free;			/* offset from start of header to
> > +		u8 fill[3];
> > +		u8 n_free_nodes;	/* free nodes in following array */
> > +		u8 n_used_nodes;	/* used nodes in following array */
> > +		__le16 first_free;	/* offset from start of header to
> >   					   first free node in array */
> > -  union {
> > -	/* (internal) 2-word entries giving subtree pointers */
> > -	DECLARE_FLEX_ARRAY(struct bplus_internal_node, internal);
> > -	/* (external) 3-word entries giving sector runs */
> > -	DECLARE_FLEX_ARRAY(struct bplus_leaf_node, external);
> > -  } u;
> > +	);
> > +	union {
> > +		/* (internal) 2-word entries giving subtree pointers */
> > +		DECLARE_FLEX_ARRAY(struct bplus_internal_node, internal);
> > +		/* (external) 3-word entries giving sector runs */
> > +		DECLARE_FLEX_ARRAY(struct bplus_leaf_node, external);
> > +	} u;
> >   };
> > +static_assert(offsetof(struct bplus_header, u.internal) == sizeof(struct
> > bplus_header_fixed),
> > +	      "struct member likely outside of struct_group_tagged()");
> >     static inline bool bp_internal(struct bplus_header *bp)
> >   {
> > @@ -453,7 +471,7 @@ struct fnode
> >     __le16 flags;				/* bit 1 set -> ea_secno is an
> > anode */
> >   					/* bit 8 set -> directory.  first &
> > only extent
> >   					   points to dnode. */
> > -  struct bplus_header btree;		/* b+ tree, 8 extents or 12 subtrees
> > */
> > +  struct bplus_header_fixed btree;	/* b+ tree, 8 extents or 12 subtrees
> > */
> >     union {
> >       struct bplus_leaf_node external[8];
> >       struct bplus_internal_node internal[12];
> > @@ -495,7 +513,7 @@ struct anode
> >     __le32 self;				/* pointer to this anode */
> >     __le32 up;				/* parent anode or fnode */
> >   -  struct bplus_header btree;		/* b+tree, 40 extents or 60
> > subtrees */
> > +  struct bplus_header_fixed btree;	/* b+tree, 40 extents or 60 subtrees
> > */
> >     union {
> >       struct bplus_leaf_node external[40];
> >       struct bplus_internal_node internal[60];
> > diff --git a/fs/hpfs/map.c b/fs/hpfs/map.c
> > index ecd9fccd1663..be73233502f8 100644
> > --- a/fs/hpfs/map.c
> > +++ b/fs/hpfs/map.c
> > @@ -178,14 +178,14 @@ struct fnode *hpfs_map_fnode(struct super_block *s,
> > ino_t ino, struct buffer_hea
> >   			}
> >   			if (!fnode_is_dir(fnode)) {
> >   				if ((unsigned)fnode->btree.n_used_nodes +
> > (unsigned)fnode->btree.n_free_nodes !=
> > -				    (bp_internal(&fnode->btree) ? 12 : 8)) {
> > +				    (bp_internal(GET_BTREE_PTR(&fnode->btree))
> > ? 12 : 8)) {
> >   					hpfs_error(s,
> >   					   "bad number of nodes in fnode
> > %08lx",
> >   					    (unsigned long)ino);
> >   					goto bail;
> >   				}
> >   				if (le16_to_cpu(fnode->btree.first_free) !=
> > -				    8 + fnode->btree.n_used_nodes *
> > (bp_internal(&fnode->btree) ? 8 : 12)) {
> > +				    8 + fnode->btree.n_used_nodes *
> > (bp_internal(GET_BTREE_PTR(&fnode->btree)) ? 8 : 12)) {
> >   					hpfs_error(s,
> >   					    "bad first_free pointer in fnode
> > %08lx",
> >   					    (unsigned long)ino);
> > @@ -233,12 +233,12 @@ struct anode *hpfs_map_anode(struct super_block *s,
> > anode_secno ano, struct buff
> >   				goto bail;
> >   			}
> >   			if ((unsigned)anode->btree.n_used_nodes +
> > (unsigned)anode->btree.n_free_nodes !=
> > -			    (bp_internal(&anode->btree) ? 60 : 40)) {
> > +			    (bp_internal(GET_BTREE_PTR(&anode->btree)) ? 60 :
> > 40)) {
> >   				hpfs_error(s, "bad number of nodes in anode
> > %08x", ano);
> >   				goto bail;
> >   			}
> >   			if (le16_to_cpu(anode->btree.first_free) !=
> > -			    8 + anode->btree.n_used_nodes *
> > (bp_internal(&anode->btree) ? 8 : 12)) {
> > +			    8 + anode->btree.n_used_nodes *
> > (bp_internal(GET_BTREE_PTR(&anode->btree)) ? 8 : 12)) {
> >   				hpfs_error(s, "bad first_free pointer in anode
> > %08x", ano);
> >   				goto bail;
> >   			}
> 
> 

