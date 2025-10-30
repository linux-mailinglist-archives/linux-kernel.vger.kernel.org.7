Return-Path: <linux-kernel+bounces-878755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8BBC2169B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 490E04E4C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E9F3678AF;
	Thu, 30 Oct 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X7WPgHHU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="28BpU0yh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X7WPgHHU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="28BpU0yh"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17659365D39
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844335; cv=none; b=bM0cHtUwgGQ4Q3MNu3t8iih2MpcZvUtoni1zg88k3BT5FXtDNA6goeENjFbs1Smi/jQ6H1vlfw6SflTfiFBjBXh/xrJgd8HAyo6+yVrSuxds8SE5QaI9J6OMUXKUiH2/CVajIJTIsq7iNDzKOaWBZ/Nq8icNUrYDQYJtrijOGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844335; c=relaxed/simple;
	bh=aoDtgqAWWRj/Q3h43cUnmcGM3TqMuuZIB6/agtBIPEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSWi0YtJ+ASl6KdRIblHa2pwdDupG6zHD0lEaQj7d7Dqd2yQN00dJVK5uO92lZpoiLcaM492HNdTyKDgOGwy27S1vP0UsJk7Pd+ztFTZl2fBkZVWuyPv63Rg6wdU/iqBaw0cbgrKGbo4jpn9RbNEEXLZRVoTtbC4nqngffw2MMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X7WPgHHU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=28BpU0yh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X7WPgHHU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=28BpU0yh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C9E13377F;
	Thu, 30 Oct 2025 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761844332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7APiWB86J5LdAWvCynjBAwtYTioxBi9PybozZ0j8HaI=;
	b=X7WPgHHU64PihJRF7Etx21qZzGeWeieMXduEkQxhUo6ySPPGgymGv9PYXs9ITNjdDh7qjL
	wN/SngyZdAnQitcX+tcOqKIx9f6NfKDp7xZQxQCS7G8bYd0m1fxnQIwRIygt7f2CXAqdCq
	E0dzMEq7ceB4kj/xQU5inLsZAC6StzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761844332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7APiWB86J5LdAWvCynjBAwtYTioxBi9PybozZ0j8HaI=;
	b=28BpU0yhpCFkle+SVxM1432AnhNAFqK/OLI3mqH+pNYW77B5g1EQITD4BgStRdhQYAtpik
	9V288LNCjAIw9RAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761844332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7APiWB86J5LdAWvCynjBAwtYTioxBi9PybozZ0j8HaI=;
	b=X7WPgHHU64PihJRF7Etx21qZzGeWeieMXduEkQxhUo6ySPPGgymGv9PYXs9ITNjdDh7qjL
	wN/SngyZdAnQitcX+tcOqKIx9f6NfKDp7xZQxQCS7G8bYd0m1fxnQIwRIygt7f2CXAqdCq
	E0dzMEq7ceB4kj/xQU5inLsZAC6StzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761844332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7APiWB86J5LdAWvCynjBAwtYTioxBi9PybozZ0j8HaI=;
	b=28BpU0yhpCFkle+SVxM1432AnhNAFqK/OLI3mqH+pNYW77B5g1EQITD4BgStRdhQYAtpik
	9V288LNCjAIw9RAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 349A013393;
	Thu, 30 Oct 2025 17:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZpblDGycA2mTQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 17:12:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7DA81A0AD6; Thu, 30 Oct 2025 18:12:11 +0100 (CET)
Date: Thu, 30 Oct 2025 18:12:11 +0100
From: Jan Kara <jack@suse.cz>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, Khalid Aziz <khalid@kernel.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Jan Kara <jack@suse.cz>, Taotao Chen <chentaotao@didiglobal.com>, 
	NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, 
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
Message-ID: <4ebc2e6ptdbfqrd4vwgswmqzuzm5joztd2jfg2cvq7wdxhtnjb@f52arbgipszs>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
 <1697efab0661c4c80831544f84c9e520f33962e7.camel@kernel.org>
 <1979215152.3123282.1761831106100@kpc.webmail.kpnmail.nl>
 <a2954b90bda141e71da6a4aeb4767d4821abad03.camel@kernel.org>
 <90143686.3161766.1761833369803@kpc.webmail.kpnmail.nl>
 <1ed30710481dd6739e6e9b4bd6f57c7c9d7e7de3.camel@kernel.org>
 <dceefe7e-4cd3-464d-b5b4-f80c02b4331d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dceefe7e-4cd3-464d-b5b4-f80c02b4331d@linuxfoundation.org>
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
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[4e49728ec1cbaf3b91d2];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,i-love.sakura.ne.jp,suse.cz,didiglobal.com,brown.name,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Thu 30-10-25 09:44:40, Shuah Khan wrote:
> On 10/30/25 09:12, Jeff Layton wrote:
> > On Thu, 2025-10-30 at 15:09 +0100, Jori Koolstra wrote:
> > > And there is still the issue of what we do for the syzbot bugs until a
> > > more permanent solution is achieved.
> > > 
> > 
> > Yeah, that's a different issue.  Most likely we'll need to fix those in
> > the near term. Replacing minix.ko with a FUSE fs will take time
> > (years), even once we have a new driver in hand.
> Does this mean Jori can work on fixing these while replacing minix.ko
> with fuse progresses?

Yes, we generally accept fixes to syzbot bugs even for old filesystems.
It's just that for these old filesystems there's limited enthusiasm to
accept large-scale changes just to fix some odd syzbot issue. But luckily
most of the syzbot bugs are usually fixed just by proper input validation
which isn't usually very intrusive.

> > We'll need to mark the old driver deprecated and then wait a few
> > releases before we can rip it out.
> Jori could work on patches for deprecating perhaps?

He could but deprecation is pretty easy - just print a notice about
deprecation to the kernel log on mount, update MAINTAINERS file etc. But
more interesting is making sure the userspace driver has feature parity
with the kernel driver before we start the kernel driver deprecation.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

