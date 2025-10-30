Return-Path: <linux-kernel+bounces-878789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46504C217C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A5E4223B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438342B9B7;
	Thu, 30 Oct 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wtq4GDw/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jHzQ0tl5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKLrCO0J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZvGqY0MB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB237A3C0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844948; cv=none; b=GOoUczmmZfkIw+pdl+W1py75UxQKbBgjm4agOJ3Dpi1eLs6r6q2MiSyKYVB1ASpk6koKCMxA2iFa5qgNObf3ZDBT3JLYaHg34Zb43OrTX3riJWlSTm3CKZRi1l6lycuh6Y+bvKdmtmpZP7xtRYRt4nJXbO5RJ+qHPlo7jD3Gn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844948; c=relaxed/simple;
	bh=JF1GykXtPrJAeeoyvBLlcyqxz6nWKR7n1J1ThhTf0bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkxngF9JR2tGcgK9iFeK3BaGmC2qQY78m1KSkFmwbU7EG/gIw6wJot2tSDMfei4narIlZvQzRxPRWTOz+tBvstnoWM+IPC6tTR4rMYCCM477bw7iLo8gtH+9fjibBGqRprlIQzx9TCLfH7Tzcpl3FcMItcA93qBH+9AXS9sQAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wtq4GDw/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jHzQ0tl5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKLrCO0J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZvGqY0MB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBFB922790;
	Thu, 30 Oct 2025 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761844945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXUnKERguiwAXXPoKNZmYQoSSRPkNP6QiI3cERp6DR8=;
	b=Wtq4GDw/tzqPPr9wcSMa01P6YRnKLsJoZ5UOKChSBybqY3lOydFvvRj5jEfREchl3ojVaH
	VALFmCn8CDXAV2X6TttgO8VIs9jiJHwUX7V4wfq+QK2v7an/gsZdaLEgWXzPgAhxwOTftH
	57T6tpiZt2Xcanxx6TlmU7k17Uf1VsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761844945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXUnKERguiwAXXPoKNZmYQoSSRPkNP6QiI3cERp6DR8=;
	b=jHzQ0tl5RGse6hmxsqOg3KjuCas38FTbFjWYCeG8MmPf5P0FI/SHCgU8ukdpdYu+7+m2yx
	y00+zqBh8ApBMTAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CKLrCO0J;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZvGqY0MB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761844944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXUnKERguiwAXXPoKNZmYQoSSRPkNP6QiI3cERp6DR8=;
	b=CKLrCO0JHUeQLdHnbOiyAEcFGpHMXeVLGTjJhEFz6b9wFJGPAtX9jU/A+WKOJwIkSo0UZv
	7kLr2D+NFeAyXirKuompj/AY5HtV5Qs3h/l2/MlEHCHbW/2ZY9WFfvT+61E5Kt9xsI8ymw
	zCqKl30qZKz/nLQLlPOd/E5q779STO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761844944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXUnKERguiwAXXPoKNZmYQoSSRPkNP6QiI3cERp6DR8=;
	b=ZvGqY0MBGmvixJMy4aQwczMm+R5Nhwu+mZVYFByJ3iDwl6oJxG/NSlGy+tO7KrF60gTeJl
	aVPsCI+rP3jfbpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFCDA13393;
	Thu, 30 Oct 2025 17:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k+y7MtCeA2mTTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 17:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45FFBA0AD6; Thu, 30 Oct 2025 18:22:20 +0100 (CET)
Date: Thu, 30 Oct 2025 18:22:20 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, 
	Khalid Aziz <khalid@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Taotao Chen <chentaotao@didiglobal.com>, NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, 
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
Message-ID: <ci6wvlqqh6jkdmnz5obfjx3moy67cik3354apiihifh4gtgx2t@zh4fk7zevbpx>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
 <1697efab0661c4c80831544f84c9e520f33962e7.camel@kernel.org>
 <1979215152.3123282.1761831106100@kpc.webmail.kpnmail.nl>
 <a2954b90bda141e71da6a4aeb4767d4821abad03.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2954b90bda141e71da6a4aeb4767d4821abad03.camel@kernel.org>
X-Rspamd-Queue-Id: DBFB922790
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[4e49728ec1cbaf3b91d2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,suse.cz,kernel.org,linuxfoundation.org,i-love.sakura.ne.jp,didiglobal.com,brown.name,vger.kernel.org,syzkaller.appspotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Thu 30-10-25 09:43:26, Jeff Layton wrote:
> On Thu, 2025-10-30 at 14:31 +0100, Jori Koolstra wrote:
> > One question I would have about this is that if we move minix, for
> > instance, out of the kernel code, how can we be sure that it is
> > maintained. What if some Github repo suddenly disappears? Like I said,
> > I would be fine with helping maintain minix, otherwise what should be
> > the course of action from here? What demands do we place on a userland
> > replacement for minix before I submit a patch to deprecate and remove
> > the code?
> > 
> 
> These are great questions that I don't think we have an answer for just
> yet.
> 
> In practice, FUSE interfaces are quite stable, and the minixfs format
> also doesn't change a lot. Much like minixfs in the kernel, I wouldn't
> expect that it would require a lot of maintenance itself over the long
> haul (but everything requires _some_). It might need some to keep up
> with broader OS changes, but that's not usually too burdensome.
> 
> You're quite right though that userland replacements will need to meet
> some criteria before we can rip out the in-kernel versions. This might
> be a good discussion topic for next year's LSF/MM!

Usually the requirement is feature parity - meaning if the kernel can read
/ write filesystem with some set of features, then the other drivers should
support that as well. Also passing the same set of fstests is a good
indication the replacement is sound. Darrick did quite some work with
making fstests work better for FUSE filesystems recently if I remember
correctly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

