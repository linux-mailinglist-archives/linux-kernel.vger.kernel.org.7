Return-Path: <linux-kernel+bounces-713482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EA6AF5A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 16:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163AF1C239D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B115285046;
	Wed,  2 Jul 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3RIt4U5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t0uKXR0s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DmP3jEwi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zpR8FQhT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9E270ED2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464861; cv=none; b=hOrpVpGzxoZBfdclq4YuBEP8oGKo2PZJuyqJNe2fTuOhcBZVj9pPBfIns9G6cdzq91Rk1A7IScTwcRA+FEPXC6iFKs1B+gbqjCWlRz7usQ++v2Cfq7mEvD8qA3ncq41xfHUZYjXXeL6GXS5zRULELk+tcCFz5oUCyvIDVWR6j6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464861; c=relaxed/simple;
	bh=q7cWX1q5XOzIdmgSMYhMNuKO/w6LPYIMvhl38UMpbiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn1Xd9sGi2z5ho1KkEUPK2oL1UnTJ5+REckg/An+ThxZRtHA3z4TvxSI1IuQBU5IfVhsBGxfFftDhOGRTekgvt82ND3wVFfnGX0qcuQ6aVGSHLZMrGVs0l7EiAVmdCnWjCWZqIbPV9geoxssg0saVd4V1I4yu5Xauu0/LqCPAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3RIt4U5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t0uKXR0s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DmP3jEwi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zpR8FQhT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A389321175;
	Wed,  2 Jul 2025 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751464857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogH5YUW3xFK4kTYSL5tuO47wTBbYiwnGy6sd7kuVWOQ=;
	b=Y3RIt4U5uTMhRULdEOh5VlMjU6Waer02EL8tU7If8NuSxK6hlraTkGO5syJGDwSQvPmi93
	zlq6bGyhrQLVc8OZpXRXvhhGdC2mAyEq4uD06BlMn3HNitxFhQf1hf8zMogcdQD1klcBh/
	tQgz4JHYZw04FyRt2A4o9xScw4OsgGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751464857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogH5YUW3xFK4kTYSL5tuO47wTBbYiwnGy6sd7kuVWOQ=;
	b=t0uKXR0se5y8ck4qHsvCXrf+KbLHtrncIGkGq4PF7stdiaZbL3fRf0CtJhcRau9+78iarF
	GfBHuKVVwqJeaxCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DmP3jEwi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zpR8FQhT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751464856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogH5YUW3xFK4kTYSL5tuO47wTBbYiwnGy6sd7kuVWOQ=;
	b=DmP3jEwiMLCOIgJqKNnCCinvlmwM4o4rPAMoWGTsMm8UD1p6Yyir1/JiWHUR+kb8Ryv2/r
	CYv9kuFb0cYpM+NlnE7NTROOUAno8khmCZA4QdDFAtMYStR0ybDG73HvpffdzBP+x6qvGO
	SMHUXNUb1uplap+NhsAKyRhtBiJjEUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751464856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogH5YUW3xFK4kTYSL5tuO47wTBbYiwnGy6sd7kuVWOQ=;
	b=zpR8FQhTaAlIwT1znlpyQzPn6LSqc+sFnm0UsfzlpVNWa7pcSppCJyUxf2ZdJx01lnRWHO
	/D9WKTm2tmRam6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D8D413A24;
	Wed,  2 Jul 2025 14:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gOCDIpg7ZWiHPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Jul 2025 14:00:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A2514A0A55; Wed,  2 Jul 2025 16:00:51 +0200 (CEST)
Date: Wed, 2 Jul 2025 16:00:51 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 01/10] ext4: process folios writeback in bytes
Message-ID: <oggzqu4j23ihzsi7qfwiluy5w3nwubgbyhqu2a3hdtta7cyhno@smlzq7xmrflq>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701130635.4079595-2-yi.zhang@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A389321175
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 01-07-25 21:06:26, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since ext4 supports large folios, processing writebacks in pages is no
> longer appropriate, it can be modified to process writebacks in bytes.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Just one small issue. With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -2786,18 +2788,18 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  		writeback_index = mapping->writeback_index;
>  		if (writeback_index)
>  			cycled = 0;
> -		mpd->first_page = writeback_index;
> -		mpd->last_page = -1;
> +		mpd->start_pos = writeback_index << PAGE_SHIFT;
> +		mpd->end_pos = -1;

Careful here. Previously last_page was unsigned long so -1 was fine but now
loff_t is signed. So we should rather store LLONG_MAX here.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

