Return-Path: <linux-kernel+bounces-875673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5F7C1992B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BFB84E3ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017A12E1F01;
	Wed, 29 Oct 2025 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uh5/iJo2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vRNjCpqM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uh5/iJo2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vRNjCpqM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2692DF126
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732327; cv=none; b=mF/pfgc4fi6d/gqF6Tisnb0fW2MUVCazMkeyk23MFik80EZ8H7iZqQuYh8Ua0AT9+PkDmIxomjuU6wU5ofyId+/lRSVyCaxVN7jrc6qgsU9nDW3z1hX1wRTZ5+vsU06/knERuu0yPQkRgGSLV1H5r0asDXN7IVbpNIvgkTAQuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732327; c=relaxed/simple;
	bh=4vrBRkjSKnf4X7RBuCdH8KoqtNUsJUDv1K4335KazZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkderVbUh1XuyZ3fvT4BNBncJP6F0oSnbyYzBOgwdwsbVA1Nb65qZRzRbzoF0LwimRH+w8Sst2H/+Eff+VyepRYP5G5UUW+O08ED8tAAfwaqpwDs2Iibu3yApaYgN7I4RTamjJxxO/X80naubPgcJDLgjGgFFDW9iT45M36rBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uh5/iJo2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vRNjCpqM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uh5/iJo2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vRNjCpqM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E0DD205AE;
	Wed, 29 Oct 2025 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761732323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTDloIiGE0Hgd8TVixy6KeJL+V1MuMdXZmfs28yFEA4=;
	b=uh5/iJo23Keblw9wEJ1C3Dcsi9FZTS3Pkvq7lMbAl4KDrEyI16NkvK05vzCj8rCd5XW9Lr
	Fg55OE8sfaleDQb6/4MLksC1RaKolJ6EoUu0qFL86deYdmWgiCWHn8hqxLCYjguYPIKqpB
	jpgs1EGC8pc2wIsmdwdHL6p0vD246ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761732323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTDloIiGE0Hgd8TVixy6KeJL+V1MuMdXZmfs28yFEA4=;
	b=vRNjCpqMO+aCCdy4CjLT09Wm0bxQkRMZzKU7Y4abBQtCCBBE632eaKejW/tdtLmJqky2qZ
	gD4Fasz2qQGdbwDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="uh5/iJo2";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vRNjCpqM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761732323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTDloIiGE0Hgd8TVixy6KeJL+V1MuMdXZmfs28yFEA4=;
	b=uh5/iJo23Keblw9wEJ1C3Dcsi9FZTS3Pkvq7lMbAl4KDrEyI16NkvK05vzCj8rCd5XW9Lr
	Fg55OE8sfaleDQb6/4MLksC1RaKolJ6EoUu0qFL86deYdmWgiCWHn8hqxLCYjguYPIKqpB
	jpgs1EGC8pc2wIsmdwdHL6p0vD246ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761732323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTDloIiGE0Hgd8TVixy6KeJL+V1MuMdXZmfs28yFEA4=;
	b=vRNjCpqMO+aCCdy4CjLT09Wm0bxQkRMZzKU7Y4abBQtCCBBE632eaKejW/tdtLmJqky2qZ
	gD4Fasz2qQGdbwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D51F1396A;
	Wed, 29 Oct 2025 10:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z2CEIePmAWlUJgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 29 Oct 2025 10:05:23 +0000
Date: Wed, 29 Oct 2025 11:05:19 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Justin Tee <justintee8345@gmail.com>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	LKML <linux-kernel@vger.kernel.org>, Justin Tee <justin.tee@broadcom.com>
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
Message-ID: <dc6288f0-989c-4314-9217-8f1a12eb206c@flourine.local>
References: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9E0DD205AE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

Hi Justin,

On Tue, Oct 28, 2025 at 05:33:17PM -0700, Justin Tee wrote:
> > nvme_fc_ctrl_put can acquire the rport lock when freeing the
> > ctrl object:
> >
> > nvme_fc_ctrl_put
> >   nvme_fc_ctrl_free
> >     spin_lock_irqsave(rport->lock)
> >
> > Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.
> 
> While I agree that we can’t hold the rport lock when calling
> nvme_fc_ctrl_put, nvme_fc_ctrl_free also does a nvme_fc_rport_put,
> which could also trigger nvme_fc_free_rport, making rport invalid.
> Should we also add kref get on the rport before entering the
> list_for_each_entry loop?
> 
> Also, because nvme_fc_ctrl_free removes itself from the
> rport->ctrl_list, should we also start using list_for_each_entry_safe?
> 
> So, something like this?

Yes, this makes sense. Just wondering why I didn't see any KASAN
reports. 

Should I add your change to my patch (obviously mentioning it), or do
you want to send a patch yourself?

In the meantime, I am giving this patch a spin in my test setup.

Thanks,
Daniel

