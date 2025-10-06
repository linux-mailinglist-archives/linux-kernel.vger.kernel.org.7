Return-Path: <linux-kernel+bounces-842961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A6BBE136
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C9C3B0102
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0697E27FB1C;
	Mon,  6 Oct 2025 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pPyAgPf4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UAu6VZQ8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cm9V9yF8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BXlcrGVA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C926E70B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754676; cv=none; b=tdCv3LG4WtSMQcCy6me0+t3fbV5AahV8uH2tgsFSQkQ0b+MVg4x6KGQXwejpZ/HxLvpMBwJ+e9vA4rudPNizz2EUZ82KRX+NOXRLAQhLlvliMTuE974HXAUmmf2qbM5dyK5gZa8LqIEKmrTw4nM0S7drUspRxwETYqb4imXYHHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754676; c=relaxed/simple;
	bh=3DtEIj2bQ+j7uXm0UB6jW74rBVc9BQ8geM0U2klIX98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuR6/FKSQP1mxa1WwtrATpGkga2nsFj71/XXBR2A0Z5COIUp0D+OBknu88gTy/tkexHxvfWmWrJO1/jg1aZnBndzd2uroiQAHLL4Y/gNiWNHVgxT0mvXdvhgmaOFBSL6OT98PyH/f7sZlbn7oBygpouk3gZCQLSEpdyXxIOkuqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pPyAgPf4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UAu6VZQ8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cm9V9yF8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BXlcrGVA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD7D7336BD;
	Mon,  6 Oct 2025 12:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759754672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4yQaF2jnmacQc6p7fkFElvW7cTDz3BcCJxg9Y8Lcyc=;
	b=pPyAgPf4kvAJrhmw4OfFXo42H5shi3KNgj5nCT+ijbbhAwIloN79IljqBPn50ow+QKzbXa
	DXn7snqe2V/Edv5VmjmJ6fl78RTV0VsB8Z0h/wBXQhiqAwKkrObavM7Zbw3iEc6MS4ozVg
	Gv2GnWfmEhHox+Y8O/WzaT4NLVoIkyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759754672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4yQaF2jnmacQc6p7fkFElvW7cTDz3BcCJxg9Y8Lcyc=;
	b=UAu6VZQ8K0dWeJXUbn0Ho6SX0wqpasOx5bZypvW49V6Mecdhd28FE0BO/GbTgsOmVxLPLT
	nqRUoRGW528G64AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cm9V9yF8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BXlcrGVA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759754671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4yQaF2jnmacQc6p7fkFElvW7cTDz3BcCJxg9Y8Lcyc=;
	b=cm9V9yF8wMm/bOGNABah3vuX4MCSFYe3fdvEYfRvA1A7ddE9tywOLpY0J1ZRw942O0U/R0
	4/d+Q0LJoMJ/gr5CgF0MLEFHkqrahnz6gshuM4J9AArDC68JAaQuyhb4Gr6jM6gMuqoErn
	rZNcDEN8Xi2Ycz5fF78qzYGXxQDtvPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759754671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4yQaF2jnmacQc6p7fkFElvW7cTDz3BcCJxg9Y8Lcyc=;
	b=BXlcrGVA9g8ENQCpEg36kAdV0iFakq+mTvFRl0d672JtmyAm0zFLsksxtk/q5LXmjmpOUb
	IF1AXTDHb+9a4CAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF64B13995;
	Mon,  6 Oct 2025 12:44:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7SvLMa+542gefAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 Oct 2025 12:44:31 +0000
Date: Mon, 6 Oct 2025 14:44:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Alexandr Sapozhnkiov <alsp705@gmail.com>
Cc: James Smart <james.smart@broadcom.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: target: fix error checking in
 nvmet_fc_schedule_delete_assoc()
Message-ID: <2bc10e91-d937-4584-967d-133487524980@flourine.local>
References: <20251002092202.11-1-alsp705@gmail.com>
 <20251003101354.GA15826@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003101354.GA15826@lst.de>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: DD7D7336BD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

Hi Alexandr,

On Fri, Oct 03, 2025 at 12:13:54PM +0200, Christoph Hellwig wrote:
> Adding Daniel who has been touching this area recently.
> 
> On Thu, Oct 02, 2025 at 12:22:01PM +0300, Alexandr Sapozhnkiov wrote:
> > From: Alexandr Sapozhnikov <alsp705@gmail.com>
> > 
> > The nvmet_fc_tgtport_get() function may return an error.

This description is not correct, because nvmet_fc_tgtport_get wraps
around kref_get_unless_zero. The return value is never an error code.

> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> > ---
> >  drivers/nvme/target/fc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> > index 337ee1cb09ae..68a416a92bfc 100644
> > --- a/drivers/nvme/target/fc.c
> > +++ b/drivers/nvme/target/fc.c
> > @@ -1110,8 +1110,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
> >  static void
> >  nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
> >  {
> > -	nvmet_fc_tgtport_get(assoc->tgtport);
> > -	queue_work(nvmet_wq, &assoc->del_work);
> > +	if (nvmet_fc_tgtport_get(assoc->tgtport))
> > +		queue_work(nvmet_wq, &assoc->del_work);

nvmet_fc_schedule_delete_assoc can only be called when a reference is
held on the assoc->tgtport. The nvmet_fc_tgtport_get is necessary so
that the resource is not going away while the work item is executed.

And this patch doesn't seem against a recent kernel as it misses commit
70289ae5cac4 ("nvmet-fc: put ref when assoc->del_work is already
scheduled") which was added for 6.15.

I am not against this change but I was under the impression we don't add
code to make some tools happy. Maybe it would be enough to add a
comment?

Thanks,
Daniel

