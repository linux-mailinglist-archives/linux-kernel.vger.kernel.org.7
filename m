Return-Path: <linux-kernel+bounces-884751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DECEC30FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFC53AAB10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF2A2EFDA1;
	Tue,  4 Nov 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F+xV9AjO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PK9XYeO1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F+xV9AjO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PK9XYeO1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAA2D5436
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259537; cv=none; b=ggcWon8lCFjQUGYHgyiENHoLs8bMSofbDvdYqedS9esrGfOMzznYssRyhmGoLPrIN2/Pjsl5/Q70KC9qNilkspGYG49yg74qR7pxDUXL5iopkzJkB4jlEwzwROQnVUq3Ywg+ZD/c6AoUdLN7qslM1UZuqqs13Du5krhWtrsgZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259537; c=relaxed/simple;
	bh=BwSOh9uggEGVO/ZpTb4gd6bEYAFjR+c6nKv3kPky0FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xcb33F5QPCEnIk3scCYWQIbvvMAj3OiURV9PKrVVeoNkPbfQhdhpK0Bd3j3OzEPIbBQRpQjj33KIqgjs9zkziW5FTIxoTspUOhu+UQImP+zuKpoWDcRwZx/yf7LrJlxLC91KlkhtcFnrrAoIdAjU03qHVnfqh/iNnhqao1RX0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F+xV9AjO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PK9XYeO1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F+xV9AjO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PK9XYeO1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CE22211C4;
	Tue,  4 Nov 2025 12:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762259533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh/c05mhQI2YpKSo54WAT+P1CruwJu+ENTqv7BMXPR4=;
	b=F+xV9AjO9XPdZA5jz8LCMXYMbKu7VBwEMEeOTiep5+gr5VDc8Xa+7WHIxANUWQnokeRt2v
	Vny0K4IjVgQf/PmJeSc/gORmKFKoyVUnODIa0dkl5o9mgDhXjVK3Cw+3t+xEdXYim1lTYi
	kcn6SLLUbVLB9buStWftglRh6Ob5X8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762259533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh/c05mhQI2YpKSo54WAT+P1CruwJu+ENTqv7BMXPR4=;
	b=PK9XYeO1rF9QoFyE9q6xtgX1Tm+agLFwoBKzziwBocJF+swkiDJkJU2vcg90tiKFzVSgrZ
	2VE4IXeq9SXuLEAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F+xV9AjO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PK9XYeO1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762259533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh/c05mhQI2YpKSo54WAT+P1CruwJu+ENTqv7BMXPR4=;
	b=F+xV9AjO9XPdZA5jz8LCMXYMbKu7VBwEMEeOTiep5+gr5VDc8Xa+7WHIxANUWQnokeRt2v
	Vny0K4IjVgQf/PmJeSc/gORmKFKoyVUnODIa0dkl5o9mgDhXjVK3Cw+3t+xEdXYim1lTYi
	kcn6SLLUbVLB9buStWftglRh6Ob5X8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762259533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh/c05mhQI2YpKSo54WAT+P1CruwJu+ENTqv7BMXPR4=;
	b=PK9XYeO1rF9QoFyE9q6xtgX1Tm+agLFwoBKzziwBocJF+swkiDJkJU2vcg90tiKFzVSgrZ
	2VE4IXeq9SXuLEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2D7213A31;
	Tue,  4 Nov 2025 12:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I79HOkzyCWnXVQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 04 Nov 2025 12:32:12 +0000
Date: Tue, 4 Nov 2025 13:32:04 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
Message-ID: <bf2b3a79-4e6e-4572-aa96-c318cb496cda@flourine.local>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
 <accf6ad7-047b-48d0-b626-f3ef0facd649@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <accf6ad7-047b-48d0-b626-f3ef0facd649@suse.de>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0CE22211C4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,flourine.local:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On Tue, Nov 04, 2025 at 11:51:09AM +0100, Hannes Reinecke wrote:
> On 10/28/25 16:26, Daniel Wagner wrote:
> > nvme_fc_ctrl_put can acquire the rport lock when freeing the
> > ctrl object:
> > 
> > nvme_fc_ctrl_put
> >    nvme_fc_ctrl_free
> >      spin_lock_irqsave(rport->lock)
> > 
> > Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.
> > 
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > ---
> >   drivers/nvme/host/fc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index 03987f497a5b..2c0ea843ae57 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -1488,7 +1488,9 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
> >   		if (ret)
> >   			/* leave the ctrl get reference */
> >   			break;
> > +		spin_unlock_irqrestore(&rport->lock, flags);
> >   		nvme_fc_ctrl_put(ctrl);
> > +		spin_lock_irqsave(&rport->lock, flags);
> >   	}
> >   	spin_unlock_irqrestore(&rport->lock, flags);
> > 
> In theory, yes.

I hit this in practice ;)

