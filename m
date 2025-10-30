Return-Path: <linux-kernel+bounces-878737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1A7C215DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2ACD4EC73B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810032B99E;
	Thu, 30 Oct 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dBqLKVYx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MVVFTNIb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rz5q53+t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c7qefiys"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81EC32ABC6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843676; cv=none; b=rzWSARUr+shPN1UmvJzFnp5aShdEyZ34v+IwpAaGR5DlX0CFUrjz9VFyapR9/WPn7Ou21tMPaxkq2sc8s+OXi5d0uN5e4taWJtvodN4SCePYeGu+bDjaNSa0HPAj7/qZd5/8Ob4a6y4Qd2R/n9QWG1wcRskCoKWbRHehk9oMtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843676; c=relaxed/simple;
	bh=PSye66wWOjMXhKU+7k5mhGd78LfzAw3FDCCAYS6py+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHAwynqLMUJP4iGb3Hh6a4jfm1qEd5YbaqOjXgLeDNfXMwrGAu0pvnrzcFpnSfa9/RkMZmyZ3m3uyHK4ZEJIRgkuoVaGEKPwiL8k9r3LWB5Vi4t++CCdN9EQN94Hu5upFTzFalP+7u7sa8ZPOI8q3TLfCwi9+9N0Sxoig8fWJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dBqLKVYx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MVVFTNIb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rz5q53+t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c7qefiys; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51E093377F;
	Thu, 30 Oct 2025 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761843668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5KYMrsAUlY7tK1JPq23V+c+Q4pgMVZhaN9ptPIEGho=;
	b=dBqLKVYxrnLo875NuD3gHXKq1OlrhO2Y9ARnsSs6X9z1xoyat8tvsTDKsQwp0ZZmPJlVPK
	jWac5ODZoGQgKS/CnFJ2dDFqxt2mZWmQQOhnaUMxCHZxeGSCeZS1CFSbK5fOJEpY5QsnQt
	P5+a687BFSPGmAx1mgnTTuKeaR/74XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761843668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5KYMrsAUlY7tK1JPq23V+c+Q4pgMVZhaN9ptPIEGho=;
	b=MVVFTNIbSOh6ZXQWFhmcIruRCqdg4+1LJ7D8R3kVSMpYwKqbOylPrAkKXVNYMsKSwgLtjs
	WJ+ATJE3D6CUZEDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Rz5q53+t;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=c7qefiys
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761843667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5KYMrsAUlY7tK1JPq23V+c+Q4pgMVZhaN9ptPIEGho=;
	b=Rz5q53+tG2UpOujCwji9h8vOsS1TZTaF7aDiEqIcKUPjGsctT+/h5GIU5dz6vBq4OMTtWW
	L9iK8e3WctOvOBRxoUCFAwmqerJDYFnQakSYfuupv12tQ2OtxBXuq6WJ+YI01YL2UPSWai
	LU5UK30zHooUK5LxVQX/DBWRiezxlM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761843667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5KYMrsAUlY7tK1JPq23V+c+Q4pgMVZhaN9ptPIEGho=;
	b=c7qefiysdJPAJwbECsjLBQai2ZCuK2dbDi0y2U57z6N0Chdah/yqbURwDjI4SVmDQUihjM
	OPkS4llmpE7RbSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3359713393;
	Thu, 30 Oct 2025 17:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JjCHDNOZA2mWOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 17:01:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E59D6A0AD6; Thu, 30 Oct 2025 18:01:05 +0100 (CET)
Date: Thu, 30 Oct 2025 18:01:05 +0100
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, Khalid Aziz <khalid@kernel.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Taotao Chen <chentaotao@didiglobal.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, 
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
Message-ID: <aoppzgcsml33slovgn2cz4ntmdxczk3yu5zlajh7d5bnsdav7o@lhszynfelx4b>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 51E093377F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[4e49728ec1cbaf3b91d2];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.51

Hi Jori!

On Thu 30-10-25 13:22:53, Jori Koolstra wrote:
> > The patch looks ok to me but since minix filesystem driver is in the kernel
> > mostly to allow mounting ancient unix filesystems I don't quite understand
> > the motivation for adding the new mount options. Why not just fixup
> > minix_rmdir() to better handle corrupted filesystems?
> > 
> > 								Honza
> 
> I am doing the Linux kernel mentorship program, and was looking to contribute
> to fs. Since I saw a lot bugs on syzbot related to minix (and jfs too) not
> handling corruptions well (yielding warnings in drop_nlink e.g.) I figured
> it was a low stakes project, not completely trivial, yet within my scope, to
> attempt to implement what ext4 does for these kind of problems (and jfs
> implements the same opts too).

Well, one thing is handling corruption well - that part of your patch was
fine and I think it is still useful - another thing are the mount options
that allow to configure what happens when we find a corruption - and that
is the part I don't think really makes a lot of sense for minix.

> I would have asked about the exact status of minix, but was told not to
> bother maintainers without a patch. I would be open with trying to improve
> minix further, but of course if there are better options to get it out of
> the kernel altogether that may be better. Sad for me, since that means still
> zero patches, but that is not your problem :)

Your fix for minix_rmdir() is needed. If minix is going out of the kernel
is uncertain and even if that happens it will certainly need some
deprecation period so functional fixes are still wanted in that period.

> Anyway, I hope this clarifies why I submitted this patch.

Fully, thanks for the clarification and your work on Linux :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

