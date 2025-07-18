Return-Path: <linux-kernel+bounces-736857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A6BB0A438
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57D91AA6AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF0EEBB;
	Fri, 18 Jul 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WNqGni77";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CucdTcEN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WNqGni77";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CucdTcEN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8D29B78E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841754; cv=none; b=GQNsSG0+lW+uiwQQXWHKhHWB0zGSKlg3adxoVNUgafBFoDGstZb7/KgsSt/oaXud4ADHgl5d2LShQP1f80Wur990dCo80p/HWGI5rTtlMef/1puyY3pzQUiHrzE1/l+D5AOTgY6a60YDkVL7Efye4PS65KyjcIONK8gG7D6Ip0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841754; c=relaxed/simple;
	bh=6wBOWVx8Q80iVl8o23f+2jKy8/O1afElhr915+zc/wg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mi3xTsOziT9/qvG2rOJ0N0Nvn2UGiIPa4x3akrgK8cj1CEnC+Y9/eAXQNlXNrlk7+QpIGmAIBVdQlLRsFTBuw27Bi/sXtsuGpxE6Do2+wuVLcOKI2UzcA5kJiijy3J8j5XhjBGHgraA0HrUI/cUvs3KgSivpYDcdfrIQxZiRVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WNqGni77; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CucdTcEN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WNqGni77; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CucdTcEN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FA4A21235;
	Fri, 18 Jul 2025 12:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752841751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGQxZIGrA4M25Tdpvso3PY4IErucOZFEm7P3o3ww5k=;
	b=WNqGni77oRM5D13syOK0CxPrg0gV7GIGdH2GVO1uGPLmwYilYFZnUrKDP81R6b7ny38izb
	pKeqnEv/VPg8p7ngGzgag/uBP5pF5YmJ1WoHAXj2FWtI9Z/HggP2lekhpNv7QB7wXYLfz8
	Px8Kmes8mdLSF234mrKkbRLKvVYdECk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752841751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGQxZIGrA4M25Tdpvso3PY4IErucOZFEm7P3o3ww5k=;
	b=CucdTcENtxCZHjv6s9BPzaa7+go0DGkebyifO3vh3zlRN5zCoxHHTqNIHMJ0XWd+zosb/e
	8WCmW7DHfZJ8HpAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752841751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGQxZIGrA4M25Tdpvso3PY4IErucOZFEm7P3o3ww5k=;
	b=WNqGni77oRM5D13syOK0CxPrg0gV7GIGdH2GVO1uGPLmwYilYFZnUrKDP81R6b7ny38izb
	pKeqnEv/VPg8p7ngGzgag/uBP5pF5YmJ1WoHAXj2FWtI9Z/HggP2lekhpNv7QB7wXYLfz8
	Px8Kmes8mdLSF234mrKkbRLKvVYdECk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752841751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGQxZIGrA4M25Tdpvso3PY4IErucOZFEm7P3o3ww5k=;
	b=CucdTcENtxCZHjv6s9BPzaa7+go0DGkebyifO3vh3zlRN5zCoxHHTqNIHMJ0XWd+zosb/e
	8WCmW7DHfZJ8HpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4E1C13A52;
	Fri, 18 Jul 2025 12:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sdKQNhY+emjbEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 18 Jul 2025 12:29:10 +0000
Date: Fri, 18 Jul 2025 14:29:10 +0200
Message-ID: <87ms917kdl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<alsa-devel@alsa-project.org>,
	<shenghao-ding@ti.com>,
	<navada@ti.com>,
	<13916275206@139.com>,
	<v-hampiholi@ti.com>,
	<v-po@ti.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ALSA: hda: Add TAS2770 support
In-Reply-To: <20250718094454.26574-1-baojun.xu@ti.com>
References: <20250718094454.26574-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,alsa-project.org,ti.com,139.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Fri, 18 Jul 2025 11:44:54 +0200,
Baojun Xu wrote:
> 
> Add TAS2770 support in TI's HDA driver.
> And add hda_chip_id for more product support in the future.
> Separated DSP and non-DSP in firmware load function.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Any reason of the submission of the very same patch?
It was requested to resubmit after rebasing to the new location for
HD-audio (sound/hda/*) as found in for-next branch of sound.git tree.


thanks,

Takashi

