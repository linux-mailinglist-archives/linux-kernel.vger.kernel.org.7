Return-Path: <linux-kernel+bounces-794739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8796B3E69B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9334170AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C8D33472C;
	Mon,  1 Sep 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ou2hLhOb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JETED1lb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2Q7kVmh3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vo7dlgbU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC041D61B7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735507; cv=none; b=QeFlILuVxa45L5pUTH1jsOFEPwkOSpE5Y0QwgQfvLTRRApnaNCjhmFIqGqy5fbfyU1CLnesjBjBiRjS2GgAKSu1BbNAdHQ25V4BiOaQRAigbMPsSPRaUIg0blr2g0J+NQ8qcZFq3DiyiHapsNgkZHuWl4UZPUPHCEXdPnDfJ/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735507; c=relaxed/simple;
	bh=v4t/6Y/62xfPZAOq/A5yHWHpFLus6ObcQYLc9+RrAE4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g395TRMZcttYCL3QdlIY2K5Dm5fL1tCrVOXUEXl2a4VFjZNhGi8Ir9vdMZSjU8MJWLtwCISPbn3ZVOQzrjS3jeqhSNZGhMmeKFdQ+wDEwuHe/N4/bzAzsBXz08UrLhncE7cUc4D6C3FHYgPLeocOy0z66I/KG8bSYuO6gB4yW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ou2hLhOb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JETED1lb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2Q7kVmh3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vo7dlgbU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C57D2118A;
	Mon,  1 Sep 2025 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756735504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xnx/oXinx0yk6OsECgCvuW6zhFsQoZiDXuQ/Zzkt8HM=;
	b=Ou2hLhObeGQWjvUq3bSEI1pXe9yCMEvwEDt06ENTSLclw6sHRYZ9LoDXnapCB6nlm5+r5p
	xThG+f5tihBAh30hPMxNqUE5t6re23kJGCskzxvvJOvzNX/TGPnBtYndGE5Yhct9oGeq3c
	zmHxizhhub3R7LHyJZKoBKQyW0iqW9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756735504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xnx/oXinx0yk6OsECgCvuW6zhFsQoZiDXuQ/Zzkt8HM=;
	b=JETED1lb8LvaN0DiSY+o+RASe75EJm71SwbDHRl39y+OIPOe5DK23H0gY206nwe4XYIS/v
	c8iILdxjsi7m6hBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2Q7kVmh3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vo7dlgbU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756735503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xnx/oXinx0yk6OsECgCvuW6zhFsQoZiDXuQ/Zzkt8HM=;
	b=2Q7kVmh3SATKolIYKgKR+aRL1/gnQ6vcU1OLuBmVkASYvmh58YuRbHlI7PJHmPLBVtTJNe
	B/CFc9SoHH+StHEYXZZ1476TTwdG7o5X+35LDOpihssPynOcSfr/VrPyWRgOPLJ9MBjTA8
	M7gE4JtR92Yce5hFI1I+dK94Km5LK6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756735503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xnx/oXinx0yk6OsECgCvuW6zhFsQoZiDXuQ/Zzkt8HM=;
	b=vo7dlgbUixN0upfQJxGqRAZwbSHvos167BostHmsZkGeK/PhJxXDg6iD19wGvGfCvnmQTf
	xeybb3A0/9NX5CCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 168A0136ED;
	Mon,  1 Sep 2025 14:05:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /FRBBA+otWixSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 01 Sep 2025 14:05:03 +0000
Date: Mon, 01 Sep 2025 16:05:02 +0200
Message-ID: <87tt1m5kvl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: SDCA: Add quirk for incorrect function types for 3 systems
In-Reply-To: <20250901075755.2070983-1-mstrozek@opensource.cirrus.com>
References: <20250901075755.2070983-1-mstrozek@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5C57D2118A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,opensource.cirrus.com,linux.intel.com,linux.dev,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.51

On Mon, 01 Sep 2025 09:57:46 +0200,
Maciej Strozek wrote:
> 
> Certain systems have CS42L43 DisCo that claims to conform to version 0.6.28
> but uses the function types from the 1.0 spec. Add a quirk as a workaround.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>

It's a fix for the report below, right?
  https://github.com/thesofproject/linux/issues/5515
Then please put it to Link tag.  Also at best give Fixes tag if you
can give some hint for the stable backports.


thanks,

Takashi

