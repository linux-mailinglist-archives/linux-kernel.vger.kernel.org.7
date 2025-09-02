Return-Path: <linux-kernel+bounces-796254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280EAB3FDE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73D84E2860
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8525E2F618F;
	Tue,  2 Sep 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lgi/a6np";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xZCaxC+s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lgi/a6np";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xZCaxC+s"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC9634EC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813073; cv=none; b=uTr6wMMxSBzSYG3w1FUFlNHjXwyF4rsV+VO0HQyfo5zdgfpiCcU+IeLnTO/IpWX9oAJXFODkD14MtWQ0rgVO3HNjKCQXWse4aUauK4x+him7qJ8ELMRsBsWPjRXneRtdrcrpH6mdL4wPIwWGiSzp24WjXoSbwrT8wvHJQMa8O9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813073; c=relaxed/simple;
	bh=E7qwp6rvkDJSiXpS0gmHYk6+WqhhqDVZrNcg4XXegZo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8Vu42KSQx0LukS9U7/1raaHD1tJWLTpeN/e245uUI3GhbRF5JSDoN+T6BsfAIEEB8/oJ8elTQc1e3mVSHQZdufkqWEL5d9UCtpvuIgx3kDpZimSL5SnzO/HrfztPcaZr4Qda/X8uhnAEhq8FtpwafcoOO7yZmFqu/lOuyOobXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lgi/a6np; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xZCaxC+s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lgi/a6np; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xZCaxC+s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 575871F455;
	Tue,  2 Sep 2025 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756813069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHQcXQifMWa4v30eNpXBIvzgbF43iQ+MtPgX3RQFVU4=;
	b=lgi/a6npxFPGRz4eGDXehQUf12Dat2WR4O6D+nslgw924AUqsZshQOVmUU8Q9JCpnck+57
	dH8y8TBIU37pSp/2c3GH8LVlsBL7el4ZKSANPieRPAMC+dPlbNTKPp+jXBHuLW+Ie7vgUy
	iERhXB4ojR7gBarQRExGZU6lMEwkDrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756813069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHQcXQifMWa4v30eNpXBIvzgbF43iQ+MtPgX3RQFVU4=;
	b=xZCaxC+sMeRvepIKQN/+YaX3eW4k8wKhaFmYrFCtHY91cG1BrDqmQTF5YqmCuRpO5xI4oZ
	lRKXJnldbc7zIqBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756813069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHQcXQifMWa4v30eNpXBIvzgbF43iQ+MtPgX3RQFVU4=;
	b=lgi/a6npxFPGRz4eGDXehQUf12Dat2WR4O6D+nslgw924AUqsZshQOVmUU8Q9JCpnck+57
	dH8y8TBIU37pSp/2c3GH8LVlsBL7el4ZKSANPieRPAMC+dPlbNTKPp+jXBHuLW+Ie7vgUy
	iERhXB4ojR7gBarQRExGZU6lMEwkDrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756813069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHQcXQifMWa4v30eNpXBIvzgbF43iQ+MtPgX3RQFVU4=;
	b=xZCaxC+sMeRvepIKQN/+YaX3eW4k8wKhaFmYrFCtHY91cG1BrDqmQTF5YqmCuRpO5xI4oZ
	lRKXJnldbc7zIqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3635813882;
	Tue,  2 Sep 2025 11:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jWdsDA3XtmgMNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 02 Sep 2025 11:37:49 +0000
Date: Tue, 02 Sep 2025 13:37:48 +0200
Message-ID: <878qix9jar.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Fix the order of TAS2781 calibrated-data
In-Reply-To: <20250902113155.1761-1-shenghao-ding@ti.com>
References: <20250902113155.1761-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Tue, 02 Sep 2025 13:31:55 +0200,
Shenghao Ding wrote:
> 
> A bug reported by one of my customers that the order of TAS2781
> calibrated-data is incorrect, the correct way is to move R0_Low_%d
> and insert it between R0_%d and InvR0_%d.
> 
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> v1:
>  - Add varialbe csz to store cali_data->cali_dat_sz_per_dev, which is long
>    enough to need two lines.
>  - Add more comments on calibrated-data order

Is this still needed for the latest for-linus branch of sound.git
tree?  There have been a couple of fixes for TAS2781 already.


thanks,

Takashi

