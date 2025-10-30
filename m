Return-Path: <linux-kernel+bounces-878781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9FEC2175F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A9754F253E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864DF3683A3;
	Thu, 30 Oct 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O/uIE0/h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KhGr4SKE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9vW1t9e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uZ0ldafN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5742773D4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844687; cv=none; b=qAzl00TglIOkiZCU6NJfrShDQO7HGDaAXo4xdERS1XjNhjH8SFUGAM2TtGDvp9PNAZOHNmG0nc01sXrw31r3htx1rhwkihyeo6qY3FkFEHlrD2Ad3r0GLM7zb8p/A1+PY1bmH+0wciNZnuO9YP7/446Tq4ADtzZhiFNxUVz853o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844687; c=relaxed/simple;
	bh=i2Ji/vVZFl0zRh4ocJJ+aCBo4eK4UnDEvwRfZ6jd9rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxMqffjdGGXcLa0Tw+yD4fnckHOb9ikhftESeFw2CIvnSAu2lqcoMtV3/9au+XlpdMGAdct177NhBJ24PyxSh7c+/8rAbTVRDruK1USlA/IZQQ4IIanPSHtcOXLcPRBoX258EOJrRz4uspmo3I9+GmHsw4jKhOooxIJGnzmQtE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O/uIE0/h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KhGr4SKE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9vW1t9e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uZ0ldafN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5D40337BD;
	Thu, 30 Oct 2025 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761844683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVIhy8GzErO/DnHSSM18DclAgY0KzkniuExmfI+jLJ0=;
	b=O/uIE0/hlqtDGskStNdkS7up207UQyiLvruduNKOAw1jgLXq95w2CG1Iti/zujv62PqwCe
	tFdwynRnSsPLkyjmMuBgKOm5VIDEbfuqcMeM5T/Y35SyzEFOE4KLC59Sr1bShdPXEJbZOE
	tDVGNlLeD6Si/rdAvHa7U85XZD82ltI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761844683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVIhy8GzErO/DnHSSM18DclAgY0KzkniuExmfI+jLJ0=;
	b=KhGr4SKEaQev/m8EjzuHMrmJUmr9L+jBIG1m0Oy5+If3o4F6e7Vg2D5FXBBkZwBC3p58ji
	AM/FtnKDnWDsFqAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761844682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVIhy8GzErO/DnHSSM18DclAgY0KzkniuExmfI+jLJ0=;
	b=u9vW1t9eFk+dtepsx82z3CQ+ufVtfQcPNk25ConmJsLSjXOQDAEfdjxJBUdhV4hr4C3hF9
	pnfjeY1uxoXg7xA8tu2omypeCdm243pNaGqPBDRjNV5BWMwrjGm+RhK+Fzmdrja2Q8rl1s
	sTNX24Od9WWt0m9PG7dy7ht5wShorG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761844682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVIhy8GzErO/DnHSSM18DclAgY0KzkniuExmfI+jLJ0=;
	b=uZ0ldafNZ/vU1XGooZgOESjgoA6sfKdENhQidxhMPTufJsitjuN/lxn41YtLA+bJSncMn0
	Zzc4+kCc61xtWjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9368713393;
	Thu, 30 Oct 2025 17:18:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xqD0I8qdA2lOSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 17:18:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9CC1DA0AD6; Thu, 30 Oct 2025 18:18:01 +0100 (CET)
Date: Thu, 30 Oct 2025 18:18:01 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, 
	Khalid Aziz <khalid@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Jan Kara <jack@suse.cz>, Taotao Chen <chentaotao@didiglobal.com>, 
	NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, 
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
Message-ID: <tnofelm75pbsccdkulwpq7lkfz6wjmg4acrrvinkn6zzrkdxqi@dppnd4fge2tu>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
 <1697efab0661c4c80831544f84c9e520f33962e7.camel@kernel.org>
 <1979215152.3123282.1761831106100@kpc.webmail.kpnmail.nl>
 <a2954b90bda141e71da6a4aeb4767d4821abad03.camel@kernel.org>
 <90143686.3161766.1761833369803@kpc.webmail.kpnmail.nl>
 <1ed30710481dd6739e6e9b4bd6f57c7c9d7e7de3.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed30710481dd6739e6e9b4bd6f57c7c9d7e7de3.camel@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[4e49728ec1cbaf3b91d2];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,linuxfoundation.org,i-love.sakura.ne.jp,suse.cz,didiglobal.com,brown.name,vger.kernel.org,syzkaller.appspotmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Thu 30-10-25 11:12:44, Jeff Layton wrote:
> On Thu, 2025-10-30 at 15:09 +0100, Jori Koolstra wrote:
> > > You're quite right though that userland replacements will need to meet
> > > some criteria before we can rip out the in-kernel versions. This might
> > > be a good discussion topic for next year's LSF/MM!
> > 
> > Would an in-tree but out of kernel implementation be an idea? Like how
> > kselftest is integrated in the code, even though most of that also takes
> > place in userland. That would guarantee a level of support, at least for
> > the time being. I could take the code, verify it, and write some tests
> > for in selftest.
> 
> That's not a bad idea. We already have some userland code in the kernel
> tree (the tools/ directory comes to mind). A directory with replacement
> FUSE drivers for in-kernel filesystems could be a reasonable thing to
> add. Anything we keep in-tree will need to be GPL-compatible though.

Yes, I kind of like that idea too. I think we could maybe take the existing
in-kernel minix driver and morph it into a FUSE driver which would deal
with the licensing as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

