Return-Path: <linux-kernel+bounces-884261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34557C2FC25
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25013AFF56
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDA22874E4;
	Tue,  4 Nov 2025 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ue4ljkTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8sz/j7+z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xhm6qQvz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NMxm0U5E"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E041FBEAC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243439; cv=none; b=YFHr5ALqCAVOY74e22nMgiGrvTBRZJQKb32S13mnZhSs5DSEi4fWRbFMJly/Ryae5sIT70u8cHU2XYDo8d1inq+b5nk/Wd2bwaB+Vn364pubT/S9NM/1jQymCizCaM+Ws6MzftXK6GWvj0zzEReFeS3HTStZ9Vmia8a63a4gUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243439; c=relaxed/simple;
	bh=hLX27sKgGhzUmxeyparxiXdOnK1bEq8fSBYMFLKhxbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY5pWyjAwRe5rpFPpraZ4LfmU1z3BAN1pI+ROnm4iq191g9c4lS3hrRikGefbPCZ4/T28PM4euG54oNBLP2nznzZxF3Kf596WKfeUA+9eif+/dUzlF6ihDKPM/c7OV277ptDG715d0Ixh2NyTVUefzly5OlcBP5OgEMG7jZhqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ue4ljkTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8sz/j7+z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xhm6qQvz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NMxm0U5E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2DA02119C;
	Tue,  4 Nov 2025 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762243431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6pUNmhMunvfmG1HpgrU7P4TOJFhO2G0Dqu7Z2UhO+s=;
	b=Ue4ljkTfbn0rKW711WqSnC+BGzZGPl1qFRb5sTs6PmYVcy/GY6CJ04uAsM+2ZW46WrC+Oi
	W2t8VrklLZXlsHs38siFSJXNPe+Xq7TiXmY0EA82r9mC21SJ2bTYETA0xL8v5gh9E0FQ8W
	EVLPhksJSFfDFgQtG7quRvEBgN+Luco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762243431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6pUNmhMunvfmG1HpgrU7P4TOJFhO2G0Dqu7Z2UhO+s=;
	b=8sz/j7+z8FRV9UwYQ1mVGSeQBCQMwMOU4hTxrxw0EteyiuPOLWI5h+42TxALAHTFaPbm1U
	CvGEbbDFk2luTqBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762243426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6pUNmhMunvfmG1HpgrU7P4TOJFhO2G0Dqu7Z2UhO+s=;
	b=xhm6qQvzHGk2pfolYuowb9XSX+C4xqbLUDHi4z7cNcQNPujbWfEecVfYF8+Y5+IqxC1vyZ
	xumKa5tuy/YeZ97Ba7jHFpX31KM3VbzPWaYCW/g51B7ZcRj5u8iU1qV2C2WGNv/ySVPwIO
	cawLBcxd7SjXjgzouZIHnsm/CIHae+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762243426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6pUNmhMunvfmG1HpgrU7P4TOJFhO2G0Dqu7Z2UhO+s=;
	b=NMxm0U5EGHQXRHQkjWjcwsN1LGhbB7HCki7EJPCLjr2rN/5Ma0m4Z7BpUdxdpepuYchC9M
	JmgLBMtdENHEodAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98DCE136D1;
	Tue,  4 Nov 2025 08:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rUNMJWKzCWl8RAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 08:03:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47092A2812; Tue,  4 Nov 2025 09:03:46 +0100 (CET)
Date: Tue, 4 Nov 2025 09:03:46 +0100
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Taotao Chen <chentaotao@didiglobal.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	linux-kernel@vger.kernel.org, syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix a drop_nlink warning in minix_rename
Message-ID: <kk6kvnjtabdriq6pbxuenltbecjibsvzqg6a3bwdklqad3dxiz@mr7lgm7s45qu>
References: <20251102182532.2442670-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102182532.2442670-1-jkoolstra@xs4all.nl>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[a65e824272c5f741247d];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Sun 02-11-25 19:25:32, Jori Koolstra wrote:
> Syzbot found a drop_nlink warning that is triggered by an easy to
> detect nlink corruption. This patch adds sanity checks to minix_unlink
> and minix_rename to prevent the warning and instead return EFSCORRUPTED
> to the caller.
> 
> The changes were tested using the syzbot reproducer as well as local
> testing.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> Reported-by: syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=a65e824272c5f741247d

Two comments below.

> ---
>  fs/minix/namei.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/minix/namei.c b/fs/minix/namei.c
> index a8d5a7e22b7b..4bc1d9c31284 100644
> --- a/fs/minix/namei.c
> +++ b/fs/minix/namei.c
> @@ -145,6 +145,12 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
>  	struct minix_dir_entry * de;
>  	int err;
>  
> +	if (inode->i_nlink < 1) {

I guess it makes sense to check here for i_nlink == 0 for consistency.

> +		printk(KERN_CRIT "minix-fs error: inode (ino: %ld) "
> +		       "has corrupted nlink", inode->i_ino);
> +		return -EFSCORRUPTED;
> +	}
> +
>  	de = minix_find_entry(dentry, &folio);
>  	if (!de)
>  		return -ENOENT;
> @@ -218,6 +224,13 @@ static int minix_rename(struct mnt_idmap *idmap,
>  		if (dir_de && !minix_empty_dir(new_inode))
>  			goto out_dir;
>  
> +		err = -EFSCORRUPTED;
> +		if (new_inode->i_nlink == 0 || (dir_de && new_inode->i_nlink != 2)) {
> +			printk(KERN_CRIT "minix-fs error: inode (ino: %ld) "
> +			       "has corrupted nlink", new_inode->i_ino);
> +			goto out_dir;
> +		}
> +
>  		err = -ENOENT;
>  		new_de = minix_find_entry(new_dentry, &new_folio);
>  		if (!new_de)

You should also check that 'old_dir' link count is correct. I.e.
		if (dir_de && old_dir->i_nlink <= 2) {
			error out.
		}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

