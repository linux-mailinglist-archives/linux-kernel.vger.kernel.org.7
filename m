Return-Path: <linux-kernel+bounces-797886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C1B416B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531BE1BA289B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3DE2DAFC3;
	Wed,  3 Sep 2025 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1N/UGSpO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nuw7ZXz0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1N/UGSpO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nuw7ZXz0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A52D9497
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884870; cv=none; b=uEB1AxBgFJTmRckgI0NB3LdDsJA4MPCyRkdFcvoSVTZGXrKtCELbJKG3bcizhSrqVSvrZsbOL+8CCB76sPbBqdR0/b5xANeoK1Ze91PIqV7yrB/YoWGXRHcR0GtsTTSPQKQNIgSzHLgEKnoY8mglBLDUMCt+J0EvM612ch6uBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884870; c=relaxed/simple;
	bh=mcZxAQCUjWOAe7K5j4e21X5GqGArNeXKjvZ+cWF4x2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6OJVes3wA1c45oBXIcLk3RQ5rqdbwKnEvcbD9HDfUdHEGaez3hwPx1LyEYg/u6DKt3nOvYxuSS6KlF3Ty4uNEi+DJ4NcZBgKZGw/9M4PT8yyzuwKouOix3s5ihZqMLH7kOrXIfNWzXJ4v6+noHwndYr3G+9+BQJqX5qrqeI0us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1N/UGSpO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nuw7ZXz0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1N/UGSpO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nuw7ZXz0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5BE2211B3;
	Wed,  3 Sep 2025 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756884866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gmnS8Lbbr5tva5ywgmmYTsBeEoqfSHcdoFxLATTI4A=;
	b=1N/UGSpOow3koVOihoBs5joFlouPxI3j9zWWmpKex1XtbObd293BI2y8KgJUrkZwSTNzDR
	HnCPPG9wyhmrVaEPQL2VUeZNfaM2MAUSWT7r48Uvd7qTLhg13BRJPqEBRL5ARTsd8s6bLE
	UPo0tEQPSTgvWMt9KnTkZ3eWIc2AUn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756884866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gmnS8Lbbr5tva5ywgmmYTsBeEoqfSHcdoFxLATTI4A=;
	b=nuw7ZXz0XKmdidOGse8byaHKawQvJ0Mq1GYbCxUKbHojH7hjAVXfGUjznPpTCQF89hg2VA
	cn3nOQ/XAtXFJdBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756884866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gmnS8Lbbr5tva5ywgmmYTsBeEoqfSHcdoFxLATTI4A=;
	b=1N/UGSpOow3koVOihoBs5joFlouPxI3j9zWWmpKex1XtbObd293BI2y8KgJUrkZwSTNzDR
	HnCPPG9wyhmrVaEPQL2VUeZNfaM2MAUSWT7r48Uvd7qTLhg13BRJPqEBRL5ARTsd8s6bLE
	UPo0tEQPSTgvWMt9KnTkZ3eWIc2AUn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756884866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gmnS8Lbbr5tva5ywgmmYTsBeEoqfSHcdoFxLATTI4A=;
	b=nuw7ZXz0XKmdidOGse8byaHKawQvJ0Mq1GYbCxUKbHojH7hjAVXfGUjznPpTCQF89hg2VA
	cn3nOQ/XAtXFJdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B036413888;
	Wed,  3 Sep 2025 07:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KyawKoLvt2ivQQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 03 Sep 2025 07:34:26 +0000
Date: Wed, 3 Sep 2025 09:34:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Daniel Wagner <wagi@kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] nvme-fc: reorganize ctrl ref-counting and cleanup
 code
Message-ID: <3b3bf8fc-592c-4732-8985-629e3baeaa34@flourine.local>
References: <20250829-nvme-fc-sync-v3-2-d69c87e63aee@kernel.org>
 <202508310442.lBWBZ5AC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508310442.lBWBZ5AC-lkp@intel.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

Hi Dan,

On Mon, Sep 01, 2025 at 02:46:07PM +0300, Dan Carpenter wrote:
> Hi Daniel,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-fabrics-introduce-ref-counting-for-nvmf_ctrl_options/20250829-234513
> base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> patch link:    https://lore.kernel.org/r/20250829-nvme-fc-sync-v3-2-d69c87e63aee%40kernel.org
> patch subject: [PATCH v3 2/4] nvme-fc: reorganize ctrl ref-counting and cleanup code
> config: x86_64-randconfig-161-20250830 (https://download.01.org/0day-ci/archive/20250831/202508310442.lBWBZ5AC-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202508310442.lBWBZ5AC-lkp@intel.com/
> 
> New smatch warnings:
> drivers/nvme/host/fc.c:1492 nvme_fc_match_disconn_ls() warn: iterator used outside loop: 'ctrl'
> 
> Old smatch warnings:
> drivers/nvme/host/fc.c:3180 nvme_fc_delete_association() warn: mixing irqsave and irq
> 
> vim +/ctrl +1492 drivers/nvme/host/fc.c
> 
> 14fd1e98afafc0 James Smart 2020-03-31  1465  static struct nvme_fc_ctrl *
> 14fd1e98afafc0 James Smart 2020-03-31  1466  nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
> 14fd1e98afafc0 James Smart 2020-03-31  1467  		      struct nvmefc_ls_rcv_op *lsop)
> 14fd1e98afafc0 James Smart 2020-03-31  1468  {
> 14fd1e98afafc0 James Smart 2020-03-31  1469  	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
> 14fd1e98afafc0 James Smart 2020-03-31  1470  					&lsop->rqstbuf->rq_dis_assoc;
> 14fd1e98afafc0 James Smart 2020-03-31  1471  	struct nvme_fc_ctrl *ctrl, *ret = NULL;
> 14fd1e98afafc0 James Smart 2020-03-31  1472  	struct nvmefc_ls_rcv_op *oldls = NULL;
> 14fd1e98afafc0 James Smart 2020-03-31  1473  	u64 association_id = be64_to_cpu(rqst->associd.association_id);
> 14fd1e98afafc0 James Smart 2020-03-31  1474  	unsigned long flags;
> 14fd1e98afafc0 James Smart 2020-03-31  1475  
> 14fd1e98afafc0 James Smart 2020-03-31  1476  	spin_lock_irqsave(&rport->lock, flags);
> 14fd1e98afafc0 James Smart 2020-03-31  1477  
> 14fd1e98afafc0 James Smart 2020-03-31  1478  	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
> 14fd1e98afafc0 James Smart 2020-03-31  1479  		spin_lock(&ctrl->lock);
> 14fd1e98afafc0 James Smart 2020-03-31  1480  		if (association_id == ctrl->association_id) {
> 14fd1e98afafc0 James Smart 2020-03-31  1481  			oldls = ctrl->rcv_disconn;
> 14fd1e98afafc0 James Smart 2020-03-31  1482  			ctrl->rcv_disconn = lsop;
> 14fd1e98afafc0 James Smart 2020-03-31  1483  			ret = ctrl;
> 
> There should maybe be a break statement here?

Hmm, the commit 14fd1e98afafc0 has a break after the spin_unlock.

+               spin_unlock(&ctrl->lock);
+               if (ret)
+                       /* leave the ctrl get reference */
+                       break;

And since then there aren't any changes applied.

> 14fd1e98afafc0 James Smart 2020-03-31  1484  		}
> 14fd1e98afafc0 James Smart 2020-03-31  1485  		spin_unlock(&ctrl->lock);
> 14fd1e98afafc0 James Smart 2020-03-31  1486  	}
> 14fd1e98afafc0 James Smart 2020-03-31  1487  
> 14fd1e98afafc0 James Smart 2020-03-31  1488  	spin_unlock_irqrestore(&rport->lock, flags);
> 14fd1e98afafc0 James Smart 2020-03-31  1489  
> 14fd1e98afafc0 James Smart 2020-03-31  1490  	/* transmit a response for anything that was pending */
> 14fd1e98afafc0 James Smart 2020-03-31  1491  	if (oldls) {
> 14fd1e98afafc0 James Smart 2020-03-31 @1492  		dev_info(rport->lport->dev,
> 14fd1e98afafc0 James Smart 2020-03-31  1493  			"NVME-FC{%d}: Multiple Disconnect Association "
> 14fd1e98afafc0 James Smart 2020-03-31  1494  			"LS's received\n", ctrl->cnum);
> 
> ctrl->cnum is always an invalid pointer on this line.  Another
> option would be to print ret->cnum instead ctrl->nmum.

Yes, this makes sense. I'll send a patch for this. Thanks!

Thanks,
Daniel

