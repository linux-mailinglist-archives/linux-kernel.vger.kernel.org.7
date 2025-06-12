Return-Path: <linux-kernel+bounces-683457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1144AD6DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 12:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DF6162E97
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201F235076;
	Thu, 12 Jun 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fv86OAgQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LHTBtuiv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fnjs6vAO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IfF4q5QI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3F231825
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724166; cv=none; b=Ju6Sv/QmlfqFPFZZ1od4fAPZnaWJp0qP+5kkY97UjpLip+EqXiO8CC1tdO17kG0cSvsD3mxuDy2JSIy84brZfx8Utzne/ZxlmcVMj1SHCfeXopFwIdeKnPRZNdrOO9d2I1z0PMeDT7HVAYKjgB3NsCBmS+uAbLt3e3n+j6rq2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724166; c=relaxed/simple;
	bh=htBlrFUT9M19CvqUTcyDHjmI1SzQw0rNWL3FGGhAfBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEN2bUkrK24IFgjNem80IBdvPXOOPjDdrGeRExj9+LuFXjtQsmAWplII4nyKspJGNofzemdRNlrF1arFpU3t59jFal7JcG7XXY2mhI2zEfw/z1w+kCagofgP44UnP/kTkPkBaKfOecNd4gEaQ/dkEnjc/DosROVLVTltiA1dlxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fv86OAgQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LHTBtuiv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fnjs6vAO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IfF4q5QI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FB1D21999;
	Thu, 12 Jun 2025 10:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749724162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwQkMcA9moFJpyocsAYiCQbPPUl6f95kCi3PAYs2Cmg=;
	b=Fv86OAgQarEjCErWjgqhTfcHtaJe+vvx8WdMwcy+3kh+gzfPsJ8b13ccT9ggO5g7zScIa3
	Aq4qVSs/aSsIToaKtvRt3WQjntjhmhWwlZQSuhjfHUGzQYjZKiHAPR71/MFPk76WOXD59S
	QFHpdLwBV0DbgUdFqXrvyaZ6jV3yGRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749724162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwQkMcA9moFJpyocsAYiCQbPPUl6f95kCi3PAYs2Cmg=;
	b=LHTBtuivW8VdWRAcVxMWc20izkg31bpBySAJYDcK56eKx8/IgKLaOdLfQV6GaEnasMj7NA
	t5yveAHoAXI6bHDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749724161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwQkMcA9moFJpyocsAYiCQbPPUl6f95kCi3PAYs2Cmg=;
	b=Fnjs6vAO/a7bWsvgEPbJG4R9tY6aH+dCChdVPIBMcghWASCn1mioKadiIuVl7AM/59r9oh
	XOJ6JRYSmdexwjckLFAPwH3SOVsdvuUViga98CRRQKEXyC+KDhFffHjYBZFFO2dTCZ5jHP
	J0uRpkb7vSXtpInmUAfNTvI+LiZWAbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749724161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwQkMcA9moFJpyocsAYiCQbPPUl6f95kCi3PAYs2Cmg=;
	b=IfF4q5QI5bdwbtjKvKof1HEKuZoYCTNxcKq3HfOKcy63m4TsBkuJ9YhCIP17//8SG5yneR
	CDOBpS2jlcLVgMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44666132D8;
	Thu, 12 Jun 2025 10:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7qDPEAGsSmgGUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Jun 2025 10:29:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F1193A099E; Thu, 12 Jun 2025 12:29:16 +0200 (CEST)
Date: Thu, 12 Jun 2025 12:29:16 +0200
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Cc: linux-kernel@vger.kernel.org, jack@suse.com, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: Handle fiemap on empty files to prevent EINVAL
Message-ID: <ve7pt2nbw6qmdoy2i6dzvtlougxjcl6eye73kjysomhxx4vans@24vgczp5ospk>
References: <20250612142855.2678267-1-wegao@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612142855.2678267-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 12-06-25 10:28:55, Wei Gao wrote:
> Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
> i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
> would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
> then result in an -EINVAL error, even for valid queries on empty files.
> The new validation logic directly references ext4_fiemap_check_ranges.
> 
> Link: https://github.com/linux-test-project/ltp/issues/1246
> Signed-off-by: Wei Gao <wegao@suse.com>

Thanks for the fix. Some comments below:

> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 30f8201c155f..e5cc61088f21 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -895,10 +895,30 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		u64 start, u64 len)
>  {
>  	int ret;
> +	u64 maxbytes;
>  
>  	inode_lock(inode);
> -	len = min_t(u64, len, i_size_read(inode));

So I agree this 'len' reduction to i_size looks bogus and can be removed.
But why are you adding those maxbytes checks when they are done inside
iomap_fiemap() shorly later?

								Honza


> +	maxbytes = inode->i_sb->s_maxbytes;
> +
> +	if (len == 0) {
> +		ret = -EINVAL;
> +		goto unlock_inode;
> +	}
> +
> +	if (start > maxbytes) {
> +		ret = -EFBIG;
> +		goto unlock_inode;
> +	}
> +
> +	/*
> +	 * Shrink request scope to what the fs can actually handle.
> +	 */
> +	if (len > maxbytes || (maxbytes - len) < start)
> +		len = maxbytes - start;
> +
>  	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
> +
> +unlock_inode:
>  	inode_unlock(inode);
>  
>  	return ret;
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

