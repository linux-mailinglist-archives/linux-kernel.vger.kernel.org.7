Return-Path: <linux-kernel+bounces-771037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E60DB281F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810AD168030
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFE61DF994;
	Fri, 15 Aug 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="brmKKTT1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qrjGi5dY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="brmKKTT1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qrjGi5dY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882301DD9AC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268573; cv=none; b=A08yGWtOGyKivcFH/IdZMwCFTuLK4frNKI03fNGQcCePvviNLsbh064BHnnPXw8iaURfwzDAmSRHJphxn3dSeS14xeQ/p8VHVWxxJ8ZgYzALRSk9IqjSh58ZHGYJYdCZdWjwXuXiDuq2UIDhWYmF0PC8iULpRrgLM/xTL3d9oGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268573; c=relaxed/simple;
	bh=GDs1RW6Uw9/+RuHLolKAqCfT79h/QlLZOTyn4G4XQIk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r95sjo+S8ur0C2E+MhPWnykCfzYg0oKO6zoMPTEqZFu2c/3aDwEZped/1eHmP/1eKjsvfhuiBResbxGkabdmFQ1NhEtQeTN7AxM6h8k3PD23ZRx/XwcGPg5SN3OSeysgqagEd9bm/wqMLYt3y2sO8iFIw6gQTwtbgSBO3RcKnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=brmKKTT1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qrjGi5dY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=brmKKTT1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qrjGi5dY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BA8E21841;
	Fri, 15 Aug 2025 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755268563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rm3E/c3gJKvhmiQrhrQZRR0BKGxVjzteB6lzr1H43cE=;
	b=brmKKTT1lHbaiXuw3nraATK0CMxiw3HQLrvfT1yu4z2cPDGFV3a96pF/K9/sk7lYZ7vx59
	s56o3+iSDE+l9N17NrDwKtOH6l2TuZwycpmhdmvMx+HNXER4abWCrDtoRHRMcxlCGFH6lo
	zgT8die9Wq3BBDkKu+mB3Ng51thQZrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755268563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rm3E/c3gJKvhmiQrhrQZRR0BKGxVjzteB6lzr1H43cE=;
	b=qrjGi5dYGUd0MIprqSK/y0p1X+qKhYRxYtgleibowLDGMGVq8rUJybAQmgC9tP0bxzzyCw
	GTXwSKnvbKofHkDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=brmKKTT1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qrjGi5dY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755268563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rm3E/c3gJKvhmiQrhrQZRR0BKGxVjzteB6lzr1H43cE=;
	b=brmKKTT1lHbaiXuw3nraATK0CMxiw3HQLrvfT1yu4z2cPDGFV3a96pF/K9/sk7lYZ7vx59
	s56o3+iSDE+l9N17NrDwKtOH6l2TuZwycpmhdmvMx+HNXER4abWCrDtoRHRMcxlCGFH6lo
	zgT8die9Wq3BBDkKu+mB3Ng51thQZrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755268563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rm3E/c3gJKvhmiQrhrQZRR0BKGxVjzteB6lzr1H43cE=;
	b=qrjGi5dYGUd0MIprqSK/y0p1X+qKhYRxYtgleibowLDGMGVq8rUJybAQmgC9tP0bxzzyCw
	GTXwSKnvbKofHkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1868D13876;
	Fri, 15 Aug 2025 14:36:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iFBPA9NFn2igCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 Aug 2025 14:36:03 +0000
Date: Fri, 15 Aug 2025 16:36:02 +0200
Message-ID: <87v7mosld9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>,
	<jesse-ji@ti.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Add name prefix tas2781 for tas2781's dvc_tlv and amp_vol_tlv
In-Reply-To: <20250815130207.1558-1-shenghao-ding@ti.com>
References: <20250815130207.1558-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5BA8E21841
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Fri, 15 Aug 2025 15:02:07 +0200,
Shenghao Ding wrote:
> 
> With some new devices adding into the driver, dvc_tlv and amp_vol_tlv will
> cause confusion for customers on which devices they support.
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Please try to put Fixes tag.


thanks,

Takashi

