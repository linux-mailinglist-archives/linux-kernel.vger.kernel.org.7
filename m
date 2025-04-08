Return-Path: <linux-kernel+bounces-593852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3BEA8055A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 14:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB684251AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD85E269CE6;
	Tue,  8 Apr 2025 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZpAYgcak";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="prrnFnBM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZpAYgcak";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="prrnFnBM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3108269AE4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114072; cv=none; b=kZrg6j+9m1Sp7kwQLmUZyTqVPDU+1bLvo04GT84n9TIcql7L5s1oiIVBooBSlpw6ZmgQp1O7kqoOSXofhtkd88JxYUKuGirWZBcKOv64FgkkDDe85BvONNCAnrtHClkly3SVhuY0FKpQK9QqS5Zc1fjWra1/9I6WLneyajdH3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114072; c=relaxed/simple;
	bh=UvUkLlMxuXlCVavDuuLvtfi9LoKgLxoLDqPAAI+Q180=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNdZPpX3hoSlYPlCuW8DtTyStyXy+undqsX4GEawSXj3GPs2T1qMf8FtFxeaomGOMPx0UIpXWq+QzcyvWPbF1D7TV2/QY1TJ/J2Bwcp2GOG5M3tNr2qdM4JrlrtZ2p+TuZZ3ADShgIN9iegnwyQNhIWSwpYZtrLdP6Wat0wMzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZpAYgcak; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=prrnFnBM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZpAYgcak; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=prrnFnBM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF3EF21180;
	Tue,  8 Apr 2025 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744114068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNx8nRN5Z1aOgb10aduLsC1MU3LMq+2ylBkd8wKaqVE=;
	b=ZpAYgcakn510lpDwwU5TzMkOeM+OJOI7pt07sadagUDeTdWf14msHVXJcbembqed/+h/ix
	H1ncIESX8spPNmDLG9ZUpEgmG88ervGgaeKHywTWAIOgsee/Q1apOUl+IG2UY6GbPx+QaL
	uG4w4Jwq+ODI2qfxuQzrFTjyJEp4T0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744114068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNx8nRN5Z1aOgb10aduLsC1MU3LMq+2ylBkd8wKaqVE=;
	b=prrnFnBMgEXODm31PcgxqaHK7weN+cmZEh9R9V1O+ECeg4iGPHsooFIPVL7tRPRG6m7Ln3
	/u4fXYzdV1PXNqDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744114068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNx8nRN5Z1aOgb10aduLsC1MU3LMq+2ylBkd8wKaqVE=;
	b=ZpAYgcakn510lpDwwU5TzMkOeM+OJOI7pt07sadagUDeTdWf14msHVXJcbembqed/+h/ix
	H1ncIESX8spPNmDLG9ZUpEgmG88ervGgaeKHywTWAIOgsee/Q1apOUl+IG2UY6GbPx+QaL
	uG4w4Jwq+ODI2qfxuQzrFTjyJEp4T0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744114068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNx8nRN5Z1aOgb10aduLsC1MU3LMq+2ylBkd8wKaqVE=;
	b=prrnFnBMgEXODm31PcgxqaHK7weN+cmZEh9R9V1O+ECeg4iGPHsooFIPVL7tRPRG6m7Ln3
	/u4fXYzdV1PXNqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5B3A13A1E;
	Tue,  8 Apr 2025 12:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EX89MJQR9WcIGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Apr 2025 12:07:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7E36AA0968; Tue,  8 Apr 2025 14:07:48 +0200 (CEST)
Date: Tue, 8 Apr 2025 14:07:48 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: unconditionally use atime_needs_update() in
 pick_link()
Message-ID: <ygscd5g4qhpkekidplxvwprtxf34gc3aylohxsk5qr2meehk33@n54hljzo53y7>
References: <20250408073641.1799151-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408073641.1799151-1-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 08-04-25 09:36:41, Mateusz Guzik wrote:
> Vast majority of the time the func returns false.
> 
> This avoids a branch to determine whether we are in RCU mode.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 360a86ca1f02..ae2643ff14dc 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1905,13 +1905,13 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
>  			unlikely(link->mnt->mnt_flags & MNT_NOSYMFOLLOW))
>  		return ERR_PTR(-ELOOP);
>  
> -	if (!(nd->flags & LOOKUP_RCU)) {
> +	if (unlikely(atime_needs_update(&last->link, inode))) {
> +		if (nd->flags & LOOKUP_RCU) {
> +			if (!try_to_unlazy(nd))
> +				return ERR_PTR(-ECHILD);
> +		}
>  		touch_atime(&last->link);
>  		cond_resched();
> -	} else if (atime_needs_update(&last->link, inode)) {
> -		if (!try_to_unlazy(nd))
> -			return ERR_PTR(-ECHILD);
> -		touch_atime(&last->link);
>  	}
>  
>  	error = security_inode_follow_link(link->dentry, inode,
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

