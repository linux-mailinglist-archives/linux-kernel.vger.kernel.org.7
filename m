Return-Path: <linux-kernel+bounces-745971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D95B1210E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1AE16CBDB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7372EE967;
	Fri, 25 Jul 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJdsG5RH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tpi5EjqH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJdsG5RH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tpi5EjqH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F91E86E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458097; cv=none; b=RXS8vNo75MAjtnROSFz1v8SbxQtCgSJgPdEaZRUEY6H5UovBG+w1UkKcpkabnktdBu/FFaczVhjS2cgsEasuTgE8Om+l+KB6Y5mSKXQ50Y9YuIUVLPoRcEiZlL/AjLKSAGDURkCNXpScNLY3z648CDW3QbEzPDuD+LpWhirCbY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458097; c=relaxed/simple;
	bh=Keag8gQEoU2brqEx3SnGpDjuuQ1pc4jvZo1vq/NMwsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJqyN2dZ968bxnJkSijSuEWG73aA4PfnKR66hEd0kqvsTbMM2GNOxMygwRGZWWzRDD8Byw+k76VT0SBUfybj0CBU3qIfci94TMx2x4QlUnRDjLupRKTY+T+6oXW2NNdAXWazpPGw5/fsJX9PYPV9aVY6GuN6uiH6BJ8XkaZsDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJdsG5RH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tpi5EjqH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJdsG5RH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tpi5EjqH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C17D219F9;
	Fri, 25 Jul 2025 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753458093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJgFII9dEGhLxxa1Vwkmy8l/d+gZsGa6EAV6Aa6vzp4=;
	b=PJdsG5RH1cbwBs1/sdZ5qbX3KgAvOI4NPywgbjAtaLhP72G1EaDGoUVcR7KpmV9Be+gpfb
	jRsw2wKWXE3E7SEbqrvJN/Sm1puBiXBB5JKXJWEVhD3Kwe4NG4AQDJPep1g1zlFxa/uNzf
	OKGANfzBuF+UUjRhEV3DgUwQDUxGeKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753458093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJgFII9dEGhLxxa1Vwkmy8l/d+gZsGa6EAV6Aa6vzp4=;
	b=tpi5EjqHtq9CmyQbU3rEM1fgufRZBHCkd8/IvOFNJBToT8Lq9PkDCWDk3FxiMdx5uWf15L
	FIZGXJHRMNAh7+Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753458093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJgFII9dEGhLxxa1Vwkmy8l/d+gZsGa6EAV6Aa6vzp4=;
	b=PJdsG5RH1cbwBs1/sdZ5qbX3KgAvOI4NPywgbjAtaLhP72G1EaDGoUVcR7KpmV9Be+gpfb
	jRsw2wKWXE3E7SEbqrvJN/Sm1puBiXBB5JKXJWEVhD3Kwe4NG4AQDJPep1g1zlFxa/uNzf
	OKGANfzBuF+UUjRhEV3DgUwQDUxGeKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753458093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJgFII9dEGhLxxa1Vwkmy8l/d+gZsGa6EAV6Aa6vzp4=;
	b=tpi5EjqHtq9CmyQbU3rEM1fgufRZBHCkd8/IvOFNJBToT8Lq9PkDCWDk3FxiMdx5uWf15L
	FIZGXJHRMNAh7+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 879CE1373A;
	Fri, 25 Jul 2025 15:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nnfSIK2lg2i5aQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 25 Jul 2025 15:41:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D48ACA29BD; Fri, 25 Jul 2025 17:41:28 +0200 (CEST)
Date: Fri, 25 Jul 2025 17:41:28 +0200
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, hch@lst.de, jack@suse.cz, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH 2/3] blk-wbt: Eliminate ambiguity in the comments of
 struct rq_wb
Message-ID: <r5qjezoetjiuw6vyjvya6o7boikidjp36hzywpgqu4nfwy4jw4@dlbauxv4mmq6>
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
 <20250724083001.362882-3-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724083001.362882-3-yizhou.tang@shopee.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.dk,lst.de,suse.cz,vger.kernel.org,gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 24-07-25 16:30:00, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> In the current implementation, the last_issue and last_comp members of
> struct rq_wb are used only by read requests and not by non-throttled write
> requests. Therefore, eliminate the ambiguity here.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-wbt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 30886d44f6cd..eb8037bae0bd 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -85,8 +85,8 @@ struct rq_wb {
>  	u64 sync_issue;
>  	void *sync_cookie;
>  
> -	unsigned long last_issue;		/* last non-throttled issue */
> -	unsigned long last_comp;		/* last non-throttled comp */
> +	unsigned long last_issue;	/* issue time of last read rq */
> +	unsigned long last_comp;	/* completion time of last read rq */
>  	unsigned long min_lat_nsec;
>  	struct rq_qos rqos;
>  	struct rq_wait rq_wait[WBT_NUM_RWQ];
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

