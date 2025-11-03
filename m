Return-Path: <linux-kernel+bounces-882791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C13C2B7D7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47DD18951A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310E4303A15;
	Mon,  3 Nov 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E9op3THK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lUSoXDXa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ChjSBWhb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2JAHTPU1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF62FDC24
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170270; cv=none; b=XbU04wN8Oyy/kiEeX0wyWCLiEb0ZUj+uqmcAbYFeGeND0up1sxD6BN/wc0wDi3m2C/Os8N+f4cWYusDVwPRuNp20OdzoA8VFZP7xSnJ648cNQU23R2oY+xKP/dWRkOliauv0QL9DULsHG/5/RjIcVnBApBXKzBSR9bMdyroupws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170270; c=relaxed/simple;
	bh=hZWTLYMabOkmtGY4GVeuDFCE0M3d4vadiqa22bBzYlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acRAae7IDFHGy9EYu+AVoSWMrv3sYa/FlyI/kDGRs9VZ4tD6xjEUjEAnw/JFDeyxvaeixq5OrJiJl0NnnXWE/hyJzgRAORwztX+uRzxgiE9q52KzuINWEpOw8lfrVBw9vAElb7syEpWm7r+aYEwBiuU/j+FAiEY11cEgS4xyePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E9op3THK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lUSoXDXa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ChjSBWhb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2JAHTPU1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D25EC21208;
	Mon,  3 Nov 2025 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762170267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6TDuHwkQ5vcDidstnrwvp59rRNTZimsSX83f4bK2GAo=;
	b=E9op3THKha8Z6v+s+C2LSBw7kwI7f+xb5pVSt4ZSNCIYft9ZOJbuAOoEqCIOYxKwyNSNiG
	wW2yIXMnD7IGc9MAhjCiM1ruPqRwhelOsfrmmxThUGlKRSy4fYTZBAufExtaFB7pUsFfLr
	TyhTJHmxl9WXBeWbexmLImVGMfrywlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762170267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6TDuHwkQ5vcDidstnrwvp59rRNTZimsSX83f4bK2GAo=;
	b=lUSoXDXaIfRM8Lh2L40Yea6tgZU5VX3vN7Z9izJsDbSMqlsrsZRbA23XAacWiZvJOC112P
	DMNSup8H1c+3BrAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ChjSBWhb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2JAHTPU1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762170265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6TDuHwkQ5vcDidstnrwvp59rRNTZimsSX83f4bK2GAo=;
	b=ChjSBWhbGQVQxjs9mpaVbBFzgqAEZRS+nVT/YHOu9zHTMqcyUUJjLpaC0BnhOzr1xEjxpF
	HppuG2qTenJt7MUyNgmAvy56tI1Dlax739OlmSUc5Fcq9UmSoTY1FmNlCT8FuGsiCUkS1+
	f7iAmSoYF5UiCR041H+fCK9R9lEGgUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762170265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6TDuHwkQ5vcDidstnrwvp59rRNTZimsSX83f4bK2GAo=;
	b=2JAHTPU1UPAQaNRKRWfEBcg2GJv5DTfdXy2xk+yuo5S7N6mKnPcP+QcaeC7WNZWzAiBYbz
	ooi5HJsl2BHUAwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD64D1364F;
	Mon,  3 Nov 2025 11:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 92U0LpmVCGn3MQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 11:44:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28663A2812; Mon,  3 Nov 2025 12:44:25 +0100 (CET)
Date: Mon, 3 Nov 2025 12:44:25 +0100
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Taotao Chen <chentaotao@didiglobal.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	linux-kernel@vger.kernel.org, syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix a drop_nlink warning in minix_rmdir
Message-ID: <aifdv7l2aomyyjdldpmhucnujstfzadjafy2s4kjqq5ecsk2hf@q4nph7xhemrg>
References: <20251102135239.2203389-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102135239.2203389-1-jkoolstra@xs4all.nl>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D25EC21208
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[4e49728ec1cbaf3b91d2];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -2.51

On Sun 02-11-25 14:52:39, Jori Koolstra wrote:
> Syzbot found a drop_nlink warning that is triggered by an easy to
> detect nlink corruption of a directory. This patch adds a sanity check
> to minix_rmdir to prevent the warning and instead return EFSCORRUPTED to
> the caller.
> 
> The changes were tested using the syzbot reproducer as well as local
> testing.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> Reported-by: syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=4e49728ec1cbaf3b91d2

Looks good, just one nit below. With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/fs/minix/namei.c b/fs/minix/namei.c
> index 8938536d8d3c..a8d5a7e22b7b 100644
> --- a/fs/minix/namei.c
> +++ b/fs/minix/namei.c
> @@ -161,15 +161,25 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
>  static int minix_rmdir(struct inode * dir, struct dentry *dentry)
>  {
>  	struct inode * inode = d_inode(dentry);
> -	int err = -ENOTEMPTY;
> -
> -	if (minix_empty_dir(inode)) {
> -		err = minix_unlink(dir, dentry);
> -		if (!err) {
> -			inode_dec_link_count(dir);
> -			inode_dec_link_count(inode);
> -		}
> +	int err = -EFSCORRUPTED;
> +
> +	if (dir->i_nlink <= 2) {
> +		printk(KERN_CRIT "minix-fs error: directory inode has "
> +		       "corrupted nlink");

We usually print inode number (dir->i_ino) with such errors in minix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

