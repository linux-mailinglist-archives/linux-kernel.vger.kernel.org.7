Return-Path: <linux-kernel+bounces-802971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB7B45904
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C715C21D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4B535206F;
	Fri,  5 Sep 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DwF1H9CE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9No8GHHd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DwF1H9CE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9No8GHHd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC023148DF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079003; cv=none; b=toYtnYS0Gy2uMz5Up58U1zbF1u4RJeqJmvVWvX/oFqYe4S+gx/p63Dw1UiLB9FRzu1vZsxg7pPhRlOSFBxQ2jNcIB1HZT31Hh70rLzux3rQphxKTPnL64puJ2Yg1p7p7S+SbhBeZ2CG78PivRDC9A3RAW/OZmNlg984Xx3lWEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079003; c=relaxed/simple;
	bh=nbx9yeMXqVbxjaZrn9k4qgf1Ge15vs6guc1928gX5Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5pw4u30zRBl9lNQZBoXHqDkOJey6ct4AxPeRgLyTX+6VIbAWZs0qEmtAtfDw612AhNVYF3gJDH8hpGQSwd61L3gzJO3KplCd+ZhVX6JYMXmZ3yAvDLTzmkxAfdV8CiAWCa9lCcYvdMvT9w+/Du5tr54YjR07ptn1kzt6PZV6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DwF1H9CE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9No8GHHd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DwF1H9CE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9No8GHHd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A2AE4E7D2;
	Fri,  5 Sep 2025 13:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757078999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E9/tsIa4V6eWlJ4d89CEM4IMZi++FhWTrKiHIIwUSqs=;
	b=DwF1H9CEUxRxaeppSbB7XuTDaCE2VosktZuJGvNzuMjTVoUqTQGF6T5cwVAVyRi/4Aww/a
	L0nqfiS9EzJon9CxhAMBuGmlGXr3sFL9FNR9F6+cGk6ij3vEbwroead6lPRHgEOKuXzEwz
	t0+6yPWYl2RVVtuur6/hevEO/1Xj6jY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757078999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E9/tsIa4V6eWlJ4d89CEM4IMZi++FhWTrKiHIIwUSqs=;
	b=9No8GHHdw/OECAGVVGzG2sZKb+sv7GVF+K+dWNptckjRX6D0BAzs1I00Au1CwyVzTHzjI+
	JoPje6cZVjQdqhAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757078999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E9/tsIa4V6eWlJ4d89CEM4IMZi++FhWTrKiHIIwUSqs=;
	b=DwF1H9CEUxRxaeppSbB7XuTDaCE2VosktZuJGvNzuMjTVoUqTQGF6T5cwVAVyRi/4Aww/a
	L0nqfiS9EzJon9CxhAMBuGmlGXr3sFL9FNR9F6+cGk6ij3vEbwroead6lPRHgEOKuXzEwz
	t0+6yPWYl2RVVtuur6/hevEO/1Xj6jY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757078999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E9/tsIa4V6eWlJ4d89CEM4IMZi++FhWTrKiHIIwUSqs=;
	b=9No8GHHdw/OECAGVVGzG2sZKb+sv7GVF+K+dWNptckjRX6D0BAzs1I00Au1CwyVzTHzjI+
	JoPje6cZVjQdqhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3B7E13306;
	Fri,  5 Sep 2025 13:29:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fDKPN9blumhRdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 05 Sep 2025 13:29:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D21B0A0A48; Fri,  5 Sep 2025 15:29:57 +0200 (CEST)
Date: Fri, 5 Sep 2025 15:29:57 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: ocfs2-devel@lists.linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	joseph.qi@linux.alibaba.com, jlbec@evilplan.org, mark@fasheh.com, brauner@kernel.org, 
	willy@infradead.org, david@fromorbit.com
Subject: Re: [PATCH] ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage
Message-ID: <3rqcl7pgqmel4l54fwbbyslexehzrqbugj7zfmq77iykmg74ih@js6ki7oacu67>
References: <766vdz3ecpm7hv4sp5r3uu4ezggm532ng7fdklb2nrupz6minz@qcws3ufabnjp>
 <20250904154245.644875-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904154245.644875-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Thu 04-09-25 17:42:45, Mateusz Guzik wrote:
> This postpones the writeout to ocfs2_evict_inode(), which I'm told is
> fine (tm).
> 
> The intent is to retire the I_WILL_FREE flag.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good to me! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> ACHTUNG: only compile-time tested. Need an ocfs2 person to ack it.
> 
> btw grep shows comments referencing ocfs2_drop_inode() which are already
> stale on the stock kernel, I opted to not touch them.
> 
> This ties into an effort to remove the I_WILL_FREE flag, unblocking
> other work. If accepted would be probably best taken through vfs
> branches with said work, see https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.18.inode.refcount.preliminaries
> 
>  fs/ocfs2/inode.c       | 23 ++---------------------
>  fs/ocfs2/inode.h       |  1 -
>  fs/ocfs2/ocfs2_trace.h |  2 --
>  fs/ocfs2/super.c       |  2 +-
>  4 files changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 6c4f78f473fb..5f4a2cbc505d 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1290,6 +1290,8 @@ static void ocfs2_clear_inode(struct inode *inode)
>  
>  void ocfs2_evict_inode(struct inode *inode)
>  {
> +	write_inode_now(inode, 1);
> +
>  	if (!inode->i_nlink ||
>  	    (OCFS2_I(inode)->ip_flags & OCFS2_INODE_MAYBE_ORPHANED)) {
>  		ocfs2_delete_inode(inode);
> @@ -1299,27 +1301,6 @@ void ocfs2_evict_inode(struct inode *inode)
>  	ocfs2_clear_inode(inode);
>  }
>  
> -/* Called under inode_lock, with no more references on the
> - * struct inode, so it's safe here to check the flags field
> - * and to manipulate i_nlink without any other locks. */
> -int ocfs2_drop_inode(struct inode *inode)
> -{
> -	struct ocfs2_inode_info *oi = OCFS2_I(inode);
> -
> -	trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
> -				inode->i_nlink, oi->ip_flags);
> -
> -	assert_spin_locked(&inode->i_lock);
> -	inode->i_state |= I_WILL_FREE;
> -	spin_unlock(&inode->i_lock);
> -	write_inode_now(inode, 1);
> -	spin_lock(&inode->i_lock);
> -	WARN_ON(inode->i_state & I_NEW);
> -	inode->i_state &= ~I_WILL_FREE;
> -
> -	return 1;
> -}
> -
>  /*
>   * This is called from our getattr.
>   */
> diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
> index accf03d4765e..07bd838e7843 100644
> --- a/fs/ocfs2/inode.h
> +++ b/fs/ocfs2/inode.h
> @@ -116,7 +116,6 @@ static inline struct ocfs2_caching_info *INODE_CACHE(struct inode *inode)
>  }
>  
>  void ocfs2_evict_inode(struct inode *inode);
> -int ocfs2_drop_inode(struct inode *inode);
>  
>  /* Flags for ocfs2_iget() */
>  #define OCFS2_FI_FLAG_SYSFILE		0x1
> diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
> index 54ed1495de9a..4b32fb5658ad 100644
> --- a/fs/ocfs2/ocfs2_trace.h
> +++ b/fs/ocfs2/ocfs2_trace.h
> @@ -1569,8 +1569,6 @@ DEFINE_OCFS2_ULL_ULL_UINT_EVENT(ocfs2_delete_inode);
>  
>  DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_clear_inode);
>  
> -DEFINE_OCFS2_ULL_UINT_UINT_EVENT(ocfs2_drop_inode);
> -
>  TRACE_EVENT(ocfs2_inode_revalidate,
>  	TP_PROTO(void *inode, unsigned long long ino,
>  		 unsigned int flags),
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 53daa4482406..e4b0d25f4869 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -129,7 +129,7 @@ static const struct super_operations ocfs2_sops = {
>  	.statfs		= ocfs2_statfs,
>  	.alloc_inode	= ocfs2_alloc_inode,
>  	.free_inode	= ocfs2_free_inode,
> -	.drop_inode	= ocfs2_drop_inode,
> +	.drop_inode	= generic_delete_inode,
>  	.evict_inode	= ocfs2_evict_inode,
>  	.sync_fs	= ocfs2_sync_fs,
>  	.put_super	= ocfs2_put_super,
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

