Return-Path: <linux-kernel+bounces-797911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1833FB41715
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4E51721DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2922DFA24;
	Wed,  3 Sep 2025 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NJ0M6B6Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MhMJwGEg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NJ0M6B6Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MhMJwGEg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C142DE6FC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885548; cv=none; b=hkQRXlVJzlT6vY8wFHNvCVDTVENsSkmSdaZrWBcu7DhfWsC9yV+RkBrTmkyAY1tBdajuvpsueXfmsijdPU1hfLLkwhqZVZfHA1c8J/Jsd0orS3fMC7YR+/qkZkJhsnK2mhHDa+3CS17K9/3L0QmnFYpF+QTr8OO/1gNNexR2dEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885548; c=relaxed/simple;
	bh=qrOB/jc2ipMFC5xCGMcQrYPG3nRsbvjLKzvNHLVcvLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6sy/W3OTrNqfjVrC++fmQQ/7rtDfC3LybGjphKcauuFnhcO0jAxq4ctcxYNB7EiZplMMT4+8r9Y+HtLWKpZGt6GehtkgzStvYqgy2CuETDfQj6R/02AUOAnVj2hUPlcPcqvt+/MhQOL0IqysPxNfLYrw6dnQVx3KRe2e12DuzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NJ0M6B6Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MhMJwGEg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NJ0M6B6Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MhMJwGEg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2E3B1F770;
	Wed,  3 Sep 2025 07:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756885538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkgerhaz5WeBghIbK/W7t7V9qWszlyPc8fhNtRJ1gdg=;
	b=NJ0M6B6QvmyaxvYs4SpXavcchxSq0xwCKFZSIRsexxUh4yY2HHp/blxk/92tZ+ahc7BzJZ
	iquogK0OadI/HqfTfGTwfGZ0px6+e2VB2UxOKSLF1BHjHA4TWonWa0qoh+2gsycHyFjgS+
	GvoNv946wVl4GYNVmOka3UWI3pAGMl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756885538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkgerhaz5WeBghIbK/W7t7V9qWszlyPc8fhNtRJ1gdg=;
	b=MhMJwGEgEme0OxeQNyV6Kq1MxiB2A9YMcF0ZAfFQfgKAAET1NIyznqG8F719cbtHol3hwG
	fms6nT8Qrg4PLXAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756885538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkgerhaz5WeBghIbK/W7t7V9qWszlyPc8fhNtRJ1gdg=;
	b=NJ0M6B6QvmyaxvYs4SpXavcchxSq0xwCKFZSIRsexxUh4yY2HHp/blxk/92tZ+ahc7BzJZ
	iquogK0OadI/HqfTfGTwfGZ0px6+e2VB2UxOKSLF1BHjHA4TWonWa0qoh+2gsycHyFjgS+
	GvoNv946wVl4GYNVmOka3UWI3pAGMl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756885538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkgerhaz5WeBghIbK/W7t7V9qWszlyPc8fhNtRJ1gdg=;
	b=MhMJwGEgEme0OxeQNyV6Kq1MxiB2A9YMcF0ZAfFQfgKAAET1NIyznqG8F719cbtHol3hwG
	fms6nT8Qrg4PLXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFB6B13A31;
	Wed,  3 Sep 2025 07:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rElLLiLyt2jARQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 03 Sep 2025 07:45:38 +0000
Date: Wed, 3 Sep 2025 09:45:38 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] nvme-fc: wait for initial connect attempt to
 finish
Message-ID: <58813044-1e6f-4267-bd10-70cc96348ecf@flourine.local>
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
 <20250829-nvme-fc-sync-v3-4-d69c87e63aee@kernel.org>
 <e34b522c-a492-4d86-9fbd-1a667e26d884@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34b522c-a492-4d86-9fbd-1a667e26d884@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -8.30

On Tue, Sep 02, 2025 at 11:13:41AM +0200, Hannes Reinecke wrote:
> > +	if (!opts->connect_async) {
> > +		enum nvme_ctrl_state state;
> > +
> > +		wait_for_completion(&ctrl->connect_completion);
> > +		state = nvme_ctrl_state(&ctrl->ctrl);
> > +		nvme_fc_ctrl_put(ctrl);
> > +
> > +		if (state != NVME_CTRL_LIVE) {
> > +			/* Cleanup is handled by the connect state machine */
> > +			pr_info("%s:%d ctrl state %d\n", __func__, __LINE__, state);
> > +			return ERR_PTR(-EIO);
> 
> We really should return the correct status (and not just -EIO).
> Guess we'll need to introduce another variable in struct nvme_fc_ctrl
> to hold the connect status...

(forgot to remove the debug prints)

But this is what the current return value is if something goes wrong.
The other transport map all status codes to -EIO or return the negative
error code from the function which fails. I'd rather not change this in
this series.

> >   	dev_info(ctrl->ctrl.device,
> >   		"NVME-FC{%d}: new ctrl: NQN \"%s\", hostnqn: %s\n",
> >   		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl), opts->host->nqn);
> > @@ -3895,6 +3928,7 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
> >   		dev_warn(ctrl->ctrl.device,
> >   			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
> >   			ctrl->cnum);
> > +		complete(&ctrl->connect_completion);
> >   		nvme_fc_ctrl_put(ctrl);
> >   	}
> >   	spin_unlock(&rport->lock);
> > 
> 
> And I wonder: what about the udev rules?
> Do they need to be modified?
> (IE: should we call udev with --connect-async or without?)

Without changing user space, the old behavior will be used. It's an
opt-in feature. I haven't finished the libnvme/nvme-cli changes but I
expect for getting all working the udev rules need to be modified as
well. My plan is to get the kernel bits finished up first before
tackling all the user bits in detail, e.g. also creating blktests for
this (in a way we have the first one which is nvme/041)

I'll post those changes here as it needs wider review for sure.

