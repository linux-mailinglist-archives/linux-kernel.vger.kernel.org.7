Return-Path: <linux-kernel+bounces-713523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25BAF5AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 16:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D422F520539
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EBB2F49F9;
	Wed,  2 Jul 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlc+Vcn+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JaXX/d4A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlc+Vcn+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JaXX/d4A"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A62F5312
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465915; cv=none; b=DsF06d+rbi4dgmSbAZkViicDTwy4GEN08zU6JeBRn1lbNLmhejW/iD0cd9DqMKX8FrGUroQww//fi/bRrpxwaaB4t0Wa9Q9RqaQfdXU2h/UnPtS8I7QAwVPqAJD5M1Q7wcKqNp45idQvbJzrfbvEFdDUZpkQ4933x5sFBnvXpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465915; c=relaxed/simple;
	bh=U90ze6YGaRKTN4akGjcsk4ddEqacBFwSE3cpSjF7fA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8lUuhOTDaKuXQLk7LaqCCdVLff1BETEZDyd/DfeTLFbOkk7SH0ptVFsj2X5ylyHzJa0xqn0xxemZwcNGploZ5ApseE9+bdrmvk1ZbuIx+9h2k2TBmOR97FW8DsL3pEagkIvkOBuhSjuQ9LSbyBF7TFNdxHjW9CEf8OMuGG9zxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlc+Vcn+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JaXX/d4A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlc+Vcn+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JaXX/d4A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCAAF1F45F;
	Wed,  2 Jul 2025 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751465911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgoFF8DUukUkYq9J7iecIj+75rXFjaQrqgbtYXVONDo=;
	b=zlc+Vcn+tkOze8qW30S9ajdbtJ59gSGR068egcz9alKiDxE4HukUPpmU4xGqTM1mfN/Igt
	pLyH+cgyRxFYPe3e073x3mKtRVItqHPWKtARMsBZH976sMPNz4AyR7yPT0KIBowwvd+OfU
	TvFlOiMVEoOUnmlUE0N/iyfb6Yqpn9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751465911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgoFF8DUukUkYq9J7iecIj+75rXFjaQrqgbtYXVONDo=;
	b=JaXX/d4AnSQI2rg3YqrdEUOJ5YguJd7MQ/Fq5RjH3ghYa09SfyISXk+d3F8Pg3lBOi7crc
	oBEFFi+Rbxzv7OBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zlc+Vcn+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="JaXX/d4A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751465911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgoFF8DUukUkYq9J7iecIj+75rXFjaQrqgbtYXVONDo=;
	b=zlc+Vcn+tkOze8qW30S9ajdbtJ59gSGR068egcz9alKiDxE4HukUPpmU4xGqTM1mfN/Igt
	pLyH+cgyRxFYPe3e073x3mKtRVItqHPWKtARMsBZH976sMPNz4AyR7yPT0KIBowwvd+OfU
	TvFlOiMVEoOUnmlUE0N/iyfb6Yqpn9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751465911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgoFF8DUukUkYq9J7iecIj+75rXFjaQrqgbtYXVONDo=;
	b=JaXX/d4AnSQI2rg3YqrdEUOJ5YguJd7MQ/Fq5RjH3ghYa09SfyISXk+d3F8Pg3lBOi7crc
	oBEFFi+Rbxzv7OBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AFAA13A24;
	Wed,  2 Jul 2025 14:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WZEBHrY/ZWiCQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Jul 2025 14:18:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 83B07A0A55; Wed,  2 Jul 2025 16:18:21 +0200 (CEST)
Date: Wed, 2 Jul 2025 16:18:21 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 05/10] ext4: restart handle if credits are
 insufficient during allocating blocks
Message-ID: <i7lzmvk5prgnw2zri46adshfjhfq63r7le5w5sv67wmkiimbhc@a24oub5o6xtg>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701130635.4079595-6-yi.zhang@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BCAAF1F45F
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 01-07-25 21:06:30, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After large folios are supported on ext4, writing back a sufficiently
> large and discontinuous folio may consume a significant number of
> journal credits, placing considerable strain on the journal. For
> example, in a 20GB filesystem with 1K block size and 1MB journal size,
> writing back a 2MB folio could require thousands of credits in the
> worst-case scenario (when each block is discontinuous and distributed
> across different block groups), potentially exceeding the journal size.
> This issue can also occur in ext4_write_begin() and ext4_page_mkwrite()
> when delalloc is not enabled.
> 
> Fix this by ensuring that there are sufficient journal credits before
> allocating an extent in mpage_map_one_extent() and
> ext4_block_write_begin(). If there are not enough credits, return
> -EAGAIN, exit the current mapping loop, restart a new handle and a new
> transaction, and allocating blocks on this folio again in the next
> iteration.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Very nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One small comment below:

> +/*
> + * Make sure that the current journal transaction has enough credits to map
> + * one extent. Return -EAGAIN if it cannot extend the current running
> + * transaction.
> + */
> +static inline int ext4_journal_ensure_extent_credits(handle_t *handle,
> +						     struct inode *inode)
> +{
> +	int credits;
> +	int ret;
> +
> +	if (!handle)

Shouldn't this rather be ext4_handle_valid(handle) to catch nojournal mode
properly?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

