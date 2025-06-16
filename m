Return-Path: <linux-kernel+bounces-688053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BBAADAD13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775121631B7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC0A27E04D;
	Mon, 16 Jun 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gdj4Q8/+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gwrMVlcb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gdj4Q8/+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gwrMVlcb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4A25D8E3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750068650; cv=none; b=CWbGY5ocmSQZmOaCzpKq08yNIOe1gkChyulDt88KQUccWMvV26mwA2iwKzpfXybwo1HLvihdEO8qeVwo87P+oe4px6DClFblFLeLcfp3zciRQ1SGqMXa3Qhdagrb/t23vejDwFU4Kzn7ZbLdChIK6O3+dALselz5bWerYswZ7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750068650; c=relaxed/simple;
	bh=KmA1gvb1BgHKLpHjtVYUJFUCFxz6uXQdO77HkGO8SSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJVaAP8iq15JE/oA1+zlLdEOIVEpCJLj9+bp+2pMPyAbc+SQQFrYpv81FjE1h3ZgzRV91S0QtYhnARxQAGhV1QgHb6hiZtcrkLf9yys8NBYS35JmHZii1kvjeqaDEVNJovks4P15NADb0XS67PpryrThLLWazgMosSyLJHrzu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gdj4Q8/+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gwrMVlcb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gdj4Q8/+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gwrMVlcb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BA65211A6;
	Mon, 16 Jun 2025 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750068645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8BaSuCJ5jt9OiYDg+RbrGk/O5naIRwZH4Tg1A9NatQ=;
	b=gdj4Q8/+WDUWK4SCZLZuetgUvLPXxaS69ucvU1y+VuKQOLFauERa96TBPKH/nQuYq7p1GG
	9bn4tlTkGG00QLxhnGDp7oZnfZ5bWNBK2M9vbiNNuqdEDtl29+p5oA449+WloOwDsiMu08
	062JMgOpRl6bGzRzRCHy50KUnXNG/GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750068645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8BaSuCJ5jt9OiYDg+RbrGk/O5naIRwZH4Tg1A9NatQ=;
	b=gwrMVlcbwEjj1utCw2cq2ulbdA+1SaODC8IAseZYH6NkvNDcwfB0ASzLUp2oah5nNpRHvs
	AqajQKvpr2Jn4mDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750068645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8BaSuCJ5jt9OiYDg+RbrGk/O5naIRwZH4Tg1A9NatQ=;
	b=gdj4Q8/+WDUWK4SCZLZuetgUvLPXxaS69ucvU1y+VuKQOLFauERa96TBPKH/nQuYq7p1GG
	9bn4tlTkGG00QLxhnGDp7oZnfZ5bWNBK2M9vbiNNuqdEDtl29+p5oA449+WloOwDsiMu08
	062JMgOpRl6bGzRzRCHy50KUnXNG/GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750068645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8BaSuCJ5jt9OiYDg+RbrGk/O5naIRwZH4Tg1A9NatQ=;
	b=gwrMVlcbwEjj1utCw2cq2ulbdA+1SaODC8IAseZYH6NkvNDcwfB0ASzLUp2oah5nNpRHvs
	AqajQKvpr2Jn4mDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 508CB13A6B;
	Mon, 16 Jun 2025 10:10:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JHKgE6XtT2gqWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Jun 2025 10:10:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 04A12A0951; Mon, 16 Jun 2025 12:10:40 +0200 (CEST)
Date: Mon, 16 Jun 2025 12:10:40 +0200
From: Jan Kara <jack@suse.cz>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/1] docs/vfs: update references to i_mutex to i_rwsem
Message-ID: <fduatokkcmrhtndxbmkcarycto5su7gb7jfkcb53gvzflj5o5a@itnis2jwtdt6>
References: <666eabb6-6607-47f4-985a-0d25c764b172@cs.wisc.edu>
 <fd087bc3-879f-4444-b4ad-601a3632d138@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd087bc3-879f-4444-b4ad-601a3632d138@cs.wisc.edu>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sun 15-06-25 21:16:53, Junxuan Liao wrote:
> VFS has switched to i_rwsem for ten years now (9902af79c01a: parallel
> lookups actual switch to rwsem), but the VFS documentation and comments
> still has references to i_mutex.
> 
> Signed-off-by: Junxuan Liao <ljx@cs.wisc.edu>

Thanks. This cleanup is long overdue :).

> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index fd32a9a17bfb..a09c4aab9b5b 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -759,7 +759,7 @@ dirty_folio to write data into the address_space, and
>  writepages to writeback data to storage.
>  
>  Adding and removing pages to/from an address_space is protected by the
> -inode's i_mutex.
> +inode's i_rwsem.

It is not your fault but this sentence is not actually true. i_rwsem is
held exlusively when removing pages from an address space. However i_rwsem
is often not held at all when adding pages to an address space.
mapping->invalidate_lock is used for that.

> diff --git a/fs/attr.c b/fs/attr.c
> index 9caf63d20d03..3a3881d3147f 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -230,7 +230,7 @@ EXPORT_SYMBOL(setattr_prepare);
>   * @inode:	the inode to be truncated
>   * @offset:	the new size to assign to the inode
>   *
> - * inode_newsize_ok must be called with i_mutex held.
> + * inode_newsize_ok must be called with i_rwsem held.

I guess we can add "exclusively" here.

Otherwise the changes look good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

