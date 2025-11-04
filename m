Return-Path: <linux-kernel+bounces-884974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA0C319E1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 041CF345770
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B57F2F691B;
	Tue,  4 Nov 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJYJm31M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bBJ9t9+D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJYJm31M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bBJ9t9+D"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE751C5F10
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267808; cv=none; b=ne7pUb41OwfCTUUtBf9gtB+D3PCq/GSHHM3IMAblt0NeCOkAJQlzXUyr1lQvbThdkJCZGNr/1d8zWheJopK2z++N4P5/Fz2E6OQx1kKq+z9cuyqoQDDZqru30jmJ8o+uqU7MZNPSZcSuhCiNfATeSu6FBavbjw/bBqrzSZ2Exms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267808; c=relaxed/simple;
	bh=y18uDK++KO8wjrOFBTEqCodMQYjVJQALIp/BGKQgA6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIO2BI6ph5ffY/F4O6fwaL95FqOh6yAOQIn2iHrSxmvU2B2iL4h8CH/t5nIIBM5FVzA5NasAjrPk+g2gvSUapB4bkknaRX3z++vaQAv8OGBpx/MCNi0pFC1KSyyzFxoC9xwoQrz0DBbaVFgnD6akFfFU1nfhvNJA3lW1xvG41jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJYJm31M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bBJ9t9+D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJYJm31M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bBJ9t9+D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 950FC211AA;
	Tue,  4 Nov 2025 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762267804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sn1YePjU3wGPbLNdiOwEJSPz6A2dbkpu5OMh53R/Bow=;
	b=sJYJm31MIcnXxivMH4h/yO4u/8MzDVL9+KSWC6X+QFBKifnX/4FG4ufV2/jOHSAHQh+7Oh
	OMXCeevdFSLfdTLog5CQb97mw5/NUpG8RBuGwVEWiFo6XaXYIrAvTKKYIPkQLcIvBG2sw4
	E9lk0DLDJRhuexbGVGs72k91GTbkj0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762267804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sn1YePjU3wGPbLNdiOwEJSPz6A2dbkpu5OMh53R/Bow=;
	b=bBJ9t9+DTuiqAkwr2OlDKGs5jgNG6+ReCvTTbvA7j2wfNIGI6d15Vxp0Hb7eqVjN6wN/Ms
	EjbETsnxvhswCyAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sJYJm31M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bBJ9t9+D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762267804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sn1YePjU3wGPbLNdiOwEJSPz6A2dbkpu5OMh53R/Bow=;
	b=sJYJm31MIcnXxivMH4h/yO4u/8MzDVL9+KSWC6X+QFBKifnX/4FG4ufV2/jOHSAHQh+7Oh
	OMXCeevdFSLfdTLog5CQb97mw5/NUpG8RBuGwVEWiFo6XaXYIrAvTKKYIPkQLcIvBG2sw4
	E9lk0DLDJRhuexbGVGs72k91GTbkj0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762267804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sn1YePjU3wGPbLNdiOwEJSPz6A2dbkpu5OMh53R/Bow=;
	b=bBJ9t9+DTuiqAkwr2OlDKGs5jgNG6+ReCvTTbvA7j2wfNIGI6d15Vxp0Hb7eqVjN6wN/Ms
	EjbETsnxvhswCyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A54B139A9;
	Tue,  4 Nov 2025 14:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jq2+IZwSCmkQYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 14:50:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2A785A28EA; Tue,  4 Nov 2025 15:50:00 +0100 (CET)
Date: Tue, 4 Nov 2025 15:50:00 +0100
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Taotao Chen <chentaotao@didiglobal.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix two syzbot corruption bugs in minix filesystem
Message-ID: <bnwyu7itimritk5v7yobztcvf2o4niuo5dap7kx4oh7j3q6kg4@kxneyfqqaj2k>
References: <20251104143005.3283980-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104143005.3283980-1-jkoolstra@xs4all.nl>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 950FC211AA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -4.01

On Tue 04-11-25 15:30:02, Jori Koolstra wrote:
> Syzbot fuzzes /fs by trying to mount and manipulate deliberately
> corrupted filesystems. This should not lead to BUG_ONs and WARN_ONs for
> easy to detect corruptions. This series adds code to be able to report
> such corruptions and fixes two syzbot bugs on this kind.
> 
> Jori Koolstra (3):
>   Add error handling to minix filesystem for inode corruption detection
>   Fix a drop_nlink warning in minix_rmdir
>   Fix a drop_nlink warning in minix_rename

The series looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
>  fs/minix/inode.c | 16 ++++++++++++++++
>  fs/minix/minix.h |  9 +++++++++
>  fs/minix/namei.c | 39 ++++++++++++++++++++++++++++++++-------
>  3 files changed, 57 insertions(+), 7 deletions(-)
> 
> -- 
> 2.51.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

