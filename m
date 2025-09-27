Return-Path: <linux-kernel+bounces-834870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CAEBA5AD1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E520189EEB6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD092D481F;
	Sat, 27 Sep 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E7wyEQI4"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4292D4813
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962468; cv=none; b=MR3U3KnBuQ4FlUhJBgQGELcLNZoKq/4liIvd5jKHr5p+Cjmea7NxfKyB1pvBpDkmNxISpCdg7kNhxhRCrQee2LXVPb4St7TSHR/qSBgCDol+AHAJw3odUSFxTk8QZYE8c2Fvs1WJxgbtIzkCGRRtdIpq/5wzANaV1DWGFUpdM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962468; c=relaxed/simple;
	bh=usd+50FZMY/NEDLIoiEP095ScnxXHEZoCJsJeHwVWcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U16zf8n5ej+giHAIf5rn0tY7gq4zrjLXGx+tB0cRps0/xlFgggnFpwMhEMx4PtCyJ8XtCnJ2c9C6yHjRY5qkMaYPLgJ7k798E26wSG9j6L/R5+oe8KQDVlKv4CWqdE1JafOlJIBdJBEFSRFKsAKXC7iP/ruwSnCCKCEzPQa6MVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E7wyEQI4; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 27 Sep 2025 04:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758962454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fZs9aMRZt5EZgO0jnmqvdxf79UnZuJIg6eVqK0GyvY=;
	b=E7wyEQI4WOaMhR61lfhARmdPBNWx56dXEz4kn1Ca3pdCMCJZe4zTFyNYjWxshieXtlkPbU
	QSHExiq0GKYls/x5A0UEazSVpqXCS8tH+xZmVmJtgB2OJRAfQ3U+b6cgLUqJlU35JftAsB
	QcM9UfD412lBcUgITWxY3HVsfi6+nfo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: Fix deadlocks between fallocate and readahead
Message-ID: <a46zo4zjabiqe4n7q4rmzerndaswafeg5c72lxw5at2vep4y73@ra5fojy7q7ja>
References: <20250927082503.40951-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927082503.40951-1-kartikey406@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 27, 2025 at 01:55:03PM +0530, Deepanshu Kartikey wrote:
> 
> There are ABBA deadlocks between fallocate and readahead operations
> at two locations in __bchfs_fallocate():
> 
> Thread 1 (fallocate):
>   bch2_fallocate_dispatch
>     inode_lock(&inode->v)
>     bch2_pagecache_block_get(inode)  // Acquires two_state_lock
>       __bchfs_fallocate
>         bch2_clamp_data_hole (or bch2_mark_pagecache_reserved)
>           bch2_seek_pagecache_hole
>             __filemap_get_folio
>               folio_lock()  // BLOCKS - Thread 2 holds it
> 
> Thread 2 (readahead via copy_file_range):
>   bch2_readahead
>     folio_lock()  // Holds page lock
>     __bch2_two_state_lock(&pagecache_lock)  // BLOCKS - Thread 1 holds it
> 
> The issue is that drop_locks_do() only releases btree transaction locks,
> but Thread 2 is blocked waiting for the two_state_lock (pagecache_block)
> held by bch2_pagecache_block_get().
> 
> Fix by explicitly releasing and re-acquiring the pagecache_block lock
> around both blocking operations (bch2_clamp_data_hole and
> bch2_mark_pagecache_reserved), following the same pattern used in
> bch2_page_fault(). Force a transaction restart after lock release to
> ensure consistency.
> 
> Reported-by: syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com
> Tested-by: syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=cb91f22d8a581fc19edf
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>

Nice find... we still don't have lockdep support for pagecache add lock,
there was one last bit preventing me from applying the patch last I was
working on that.

If you want to join the IRC channel, this is one a couple of us might
want to chew on. Your commit message is good, I'll probably apply it
after it's not 3 am, but this'll be a good one to talk about.

(irc.oftc.net #bcache, and for this one the secret #bcachefs-dev)

> ---
>  fs/bcachefs/fs-io.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
> index a233f45875e9..66a60e5f03fc 100644
> --- a/fs/bcachefs/fs-io.c
> +++ b/fs/bcachefs/fs-io.c
> @@ -694,13 +694,19 @@ static noinline int __bchfs_fallocate(struct bch_inode_info *inode, int mode,
>  						 &hole_start,
>  						 &hole_end,
>  						 opts.data_replicas, true)) {
> +				/* Release pagecache_block to prevent deadlock with readahead */
> +				bch2_pagecache_block_put(inode);
>  				ret = drop_locks_do(trans,
>  					(bch2_clamp_data_hole(&inode->v,
>  							      &hole_start,
>  							      &hole_end,
>  							      opts.data_replicas, false), 0));
> +				bch2_pagecache_block_get(inode);
>  				if (ret)
>  					goto bkey_err;
> +				/* Force transaction restart to revalidate state */
> +				ret = -BCH_ERR_transaction_restart;
> +				goto bkey_err;
>  			}
>  			bch2_btree_iter_set_pos(trans, &iter, POS(iter.pos.inode, hole_start));
>  
> @@ -730,11 +736,17 @@ static noinline int __bchfs_fallocate(struct bch_inode_info *inode, int mode,
>  
>  		if (bch2_mark_pagecache_reserved(inode, &hole_start,
>  						 iter.pos.offset, true)) {
> +			/* Release pagecache_block to prevent deadlock */
> +			bch2_pagecache_block_put(inode);
> +
>  			ret = drop_locks_do(trans,
>  				bch2_mark_pagecache_reserved(inode, &hole_start,
>  							     iter.pos.offset, false));
> +			bch2_pagecache_block_get(inode);
>  			if (ret)
>  				goto bkey_err;
> +			ret = -BCH_ERR_transaction_restart;
> +			goto bkey_err;
>  		}
>  bkey_err:
>  		bch2_quota_reservation_put(c, inode, &quota_res);
> -- 
> 2.43.0
> 

