Return-Path: <linux-kernel+bounces-616763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAF0A995B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 18:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D634650DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B47728A1D0;
	Wed, 23 Apr 2025 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ih/V0JGS"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C22853F3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426872; cv=none; b=rmK2nOqAJtoSyTSOOcl7z3+PfYF3fworu569299d2a9tcpUjeje69ka1hp6LGqxSG6EsJW30HoI88DzNCNCD1+YTSmmwEixVBkXs7BVJOefSTixEyWm53h/tT3SsBMVjOa/9UFsj9L3AtXRzb4U88G3dUWCe2BZHibJeDKQ5MJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426872; c=relaxed/simple;
	bh=sHyVnwcpepa8zIa3lAgxTEJ2l1IsLWodmvB6cfGIv4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwYkDfiTRmSGnqlLx3anH19I5eReKxvQ6iqZyqnW1nNcdtsRX2iBp66astbykGVmG2dUDd4O89wBcnC1700B0F9xZ8IzEny/dyuS6pIV8kgb/G9ml0GNoqS/W31VFvSEc657BV5oHiAQRWUR0/HcXiiYyjz75SD9rWRBaCBigQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ih/V0JGS; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Apr 2025 12:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745426867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPkM1jKEjmetc5EYd4TkOghy+zQtF2/1fXegDo8r0xM=;
	b=ih/V0JGSYweiuXmwlO2xVLkKpu3nmHnPhZ69fPrhLGRxNcn7kK9HsAfC9dCMB7wvekV7zU
	qwm5WtPuK6NyCukjn07H925M474YHtX9tq+JYKkS1S6dHRFw9ljzw6pdN05M74951IhL+Q
	eWaJV64n0AMV9LSKloYJiBCeGqAcQSE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: syzbot+843981bb836d699c07d1@syzkaller.appspotmail.com, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: Sub volumes handling in bch2_fsck_update_backpointers
Message-ID: <22hlu76p6uzlu6zexcjxgpijenfba3en4bx74nx6etr2mpgw4g@liyxgcpx7hbl>
References: <6806d857.050a0220.f25bb.07a8.GAE@google.com>
 <20250423154531.376838-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423154531.376838-1-contact@arnaud-lcm.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 23, 2025 at 05:45:31PM +0200, Arnaud Lecomte wrote:
> Hey everyone, in fsck.c, we have:
> /*
>  * Prefer to delete the first one, since that will be the one at the wrong
>  * offset:
>  * return value: 0 -> delete k1, 1 -> delete k2
>  */
> int bch2_fsck_update_backpointers(struct btree_trans *trans,
> 				  struct snapshots_seen *s,
> 				  const struct bch_hash_desc desc,
> 				  struct bch_hash_info *hash_info,
> 				  struct bkey_i *new)
> {
> 	if (new->k.type != KEY_TYPE_dirent)
> 		return 0;
> 
> 	struct bkey_i_dirent *d = bkey_i_to_dirent(new);
> 	struct inode_walker target = inode_walker_init();
> 	int ret = 0;
> 
> 	if (d->v.d_type == DT_SUBVOL) {
> 		BUG();
> 	} else {
> 		ret = get_visible_inodes(trans, &target, s, le64_to_cpu(d->v.d_inum));
> 		if (ret)
> 			goto err;
> 
> 		darray_for_each(target.inodes, i) {
> 			i->inode.bi_dir_offset = d->k.p.offset;
> 			ret = __bch2_fsck_write_inode(trans, &i->inode);
> 			if (ret)
> 				goto err;
> 		}
> 	}
> err:
> 	inode_walker_exit(&target);
> 	return ret;
> }
> 
> What is the current state for handling subvolumes ? In someone already working on or it is something we don't want to implement
> for some reasons ?

This does need to be handled, I haven't started on it yet.

I did just fix another subvolume root backpointers bug, which makes this
one easier - now, only the newest snapshot version of a subvolume root
inode needs to have a backpointer.

