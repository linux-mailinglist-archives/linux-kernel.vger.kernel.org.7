Return-Path: <linux-kernel+bounces-880484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9660C25DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF9E426C79
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B41E2DCBEB;
	Fri, 31 Oct 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uiOp2jJo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wDy3Fo+V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oowHSqN5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f2oYuEKT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832516FF37
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925141; cv=none; b=iylmVJh1pPASSmwrfik4VVBd3JBgyBeLobQB0Ir1+AsWOsaaZhKUYjLr89nHhaHNupdkuoBADwZSwqzSPbQEsQrLJ6C8CtSm2d6eDeUcUFQZ/U4C2CUO7qwTXZ/Y/SjK9y9xR6IapBbgodRwLv6CjOrb5vBsxuInXm+WZ+NiFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925141; c=relaxed/simple;
	bh=8qdlMzr753igQ5iXSI1n/mlwUwcJChSk7WZAo1W7ptE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLB9hFB83w4QwFNVqmlDx5PEoDzVAayy2t0gzADKQUHl1Vd438mg5aBi3SlfyMYNLTxN1zpVPPsDvpM92UwO0mX6RkWizJQkaJ9TxUQHlazyv1V02d+cJs+AvK1r27cuQqyJpv4VARrPiJ6Ks1TbL0Vw1iCvmePD+fAZGtbkvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uiOp2jJo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wDy3Fo+V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oowHSqN5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f2oYuEKT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4703225E7;
	Fri, 31 Oct 2025 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761925138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnJ3DAsOKThlKS1zkL/02L41Y07WkRmaiSSTLeQBJl8=;
	b=uiOp2jJoC83t9NWPuKQbj5cNODXShS+2UNsdKmi3lOrGY1zlbBCcpE6MFKRccnWOjOXFXN
	q6aFzhiQoGtBVNx307LRNKAP6aoPmTK70pclChwlq3t+y+FryE58iZXp1+F6TYBgiCKRhb
	wp+B+9RVfDNtMaoiofGwpLrZk78/ugA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761925138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnJ3DAsOKThlKS1zkL/02L41Y07WkRmaiSSTLeQBJl8=;
	b=wDy3Fo+VJK2TK6Ie4QBx36Gadr9WOtW1Q7sB/vk4wyJx1rSW8gKIFMQB7cMq/kOeoJLTEH
	u+BtJC1Z04ytdcCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761925137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnJ3DAsOKThlKS1zkL/02L41Y07WkRmaiSSTLeQBJl8=;
	b=oowHSqN57/3hNPJGYJTxwRuofTdMw3KJwoVPJ1WT64xS5SGUkPsWKy8G9Pk/fwVqhremfj
	ODhTz3yAUP1UfjsCcvDGaIwHA0x6/FHMhJgDeIcozPp3CZJ0k2L/QL8GDU2vUBWwUGqzri
	5JZB3DDWGzMC/rB4z/L2XrwshBez3x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761925137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnJ3DAsOKThlKS1zkL/02L41Y07WkRmaiSSTLeQBJl8=;
	b=f2oYuEKT55vhuE0FZinL9S9xe4YvmqGwNEwcyWA+vJSAHCF7Qey+guv6DD1M0Vw6Vcz/d3
	IgLlT6cUhSsJjADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8FAB13991;
	Fri, 31 Oct 2025 15:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RzL2NBHYBGmATwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 31 Oct 2025 15:38:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A0FCA28B0; Fri, 31 Oct 2025 16:38:57 +0100 (CET)
Date: Fri, 31 Oct 2025 16:38:57 +0100
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, Khalid Aziz <khalid@kernel.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Taotao Chen <chentaotao@didiglobal.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, 
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
Message-ID: <c33ddwyqqyumcvdqfydoelx2xzv4xcntwtmai2nlqob5wno3ir@h4ad4zygk5i7>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
 <aoppzgcsml33slovgn2cz4ntmdxczk3yu5zlajh7d5bnsdav7o@lhszynfelx4b>
 <37767163.3215767.1761866208997@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37767163.3215767.1761866208997@kpc.webmail.kpnmail.nl>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[4e49728ec1cbaf3b91d2];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Fri 31-10-25 00:16:48, Jori Koolstra wrote:
> 
> >  
> > Hi Jori!
> >
> 
> Hi Jan, thank you for your encouraging reply, I appreciate it.
> 
> > 
> > Well, one thing is handling corruption well - that part of your patch was
> > fine and I think it is still useful - another thing are the mount options
> > that allow to configure what happens when we find a corruption - and that
> > is the part I don't think really makes a lot of sense for minix.
> >
> 
> I already had a patch for this specific syzbot bug, and tested with the
> reproducer, but without the new mount options. What I could do is submit
> this and see if the community will accept it. Is that reasonable?

Definitely.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

