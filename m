Return-Path: <linux-kernel+bounces-805209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B4B4855B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB82A17C4CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6D02E7BC2;
	Mon,  8 Sep 2025 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V5Afb/Iz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w+Tn5Agp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V5Afb/Iz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w+Tn5Agp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA72E7199
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316855; cv=none; b=ahEZC3Rep6NTxMI/94UIYGZo2DV4eM6XuvgxyKd9tu/rIL2zEeWlXzCKqZ/QSWJqRYbn8RgngkDVArpuPKc6FQB2wPqI2j4fWkdD83IFrXfa94OTZbkPe6z0V/8oeI+t9130mMmgi4EtSOGwpysT4L/mjRPe9qJeSDnuf+t6VDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316855; c=relaxed/simple;
	bh=npAA28GqieMUhCcybIaf+CrGM1GKchRiFCGSfzZZdXo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tueOWzYOU020Unt3KsPah5u64nMDLR3tDedQfg5jeoRQq3AnGgZaZLFBimM8XQPg17VVi9ffxlm2Qaj4+plQEfnZKs8cPtq/bMPdpVwmAAS+xMXMsClHyn7vT61PX0tWnqLelWwnbpfdDyt8xVE6SKehsSV15s2oFqSWt4hjM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V5Afb/Iz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w+Tn5Agp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V5Afb/Iz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w+Tn5Agp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CC866C115;
	Mon,  8 Sep 2025 07:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757316850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXmCmYpRcmR454J1XuMwAB8IJ2C3TnOhXXVXUPOrdX4=;
	b=V5Afb/IzTiegSQEBSas9z3E1boJkkAa/v+ka/GSXXaWipPXUFa49f5+noHIWS69+4vCvRB
	GNmlXrTsMQezZNPscwdj23yPfkuVOeuGf4FJLVlMO77KAXttz4LFrHg4sA09JGaYN9g5sm
	Y0I4wdKL7lT5FvzPoiynGrzzsDQCYLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757316850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXmCmYpRcmR454J1XuMwAB8IJ2C3TnOhXXVXUPOrdX4=;
	b=w+Tn5AgpBG8EU923Gn/SXAsHyfXeaYXJTx79Y4WLOljzSv0vUDocBU0F30vJsoKx48lgbh
	cjZypZpNMMOseFCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757316850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXmCmYpRcmR454J1XuMwAB8IJ2C3TnOhXXVXUPOrdX4=;
	b=V5Afb/IzTiegSQEBSas9z3E1boJkkAa/v+ka/GSXXaWipPXUFa49f5+noHIWS69+4vCvRB
	GNmlXrTsMQezZNPscwdj23yPfkuVOeuGf4FJLVlMO77KAXttz4LFrHg4sA09JGaYN9g5sm
	Y0I4wdKL7lT5FvzPoiynGrzzsDQCYLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757316850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXmCmYpRcmR454J1XuMwAB8IJ2C3TnOhXXVXUPOrdX4=;
	b=w+Tn5AgpBG8EU923Gn/SXAsHyfXeaYXJTx79Y4WLOljzSv0vUDocBU0F30vJsoKx48lgbh
	cjZypZpNMMOseFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D577713869;
	Mon,  8 Sep 2025 07:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5/C2MvGGvmgzRAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 08 Sep 2025 07:34:09 +0000
Date: Mon, 08 Sep 2025 09:34:09 +0200
Message-ID: <87y0qpl7ny.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Joris Verhaegen <verhaegen@google.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Srinivas Kandagatla <srini@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	kernel-team@android.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-arm-msm@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/3] ALSA: compress_offload: Add 64-bit safe timestamp API
In-Reply-To: <20250905091301.2711705-1-verhaegen@google.com>
References: <20250905091301.2711705-1-verhaegen@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,perex.cz,suse.com,gmail.com,intel.com,linux.intel.com,linux.dev,nxp.com,linux.alibaba.com,socionext.com,android.com,vger.kernel.org,opensource.cirrus.com,alsa-project.org,lists.infradead.org];
	R_RATELIMIT(0.00)[to_ip_from(RLtwg9tyn6faipwn1aqsxq4m86)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Fri, 05 Sep 2025 11:12:53 +0200,
Joris Verhaegen wrote:
> 
> The current compress offload timestamping API relies on struct
> snd_compr_tstamp, whose cumulative counters like copied_total are
> defined as __u32. On long-running high-resolution audio streams, these
> 32-bit counters can overflow, causing incorrect availability
> calculations.
> 
> This patch series transitions to a 64-bit safe API to solve the problem
> while maintaining perfect backward compatibility with the existing UAPI.
> The pointer operation is reworked to use a new timestamp struct with
> 64-bit fields for the cumulative counters, named snd_compr_tstamp64.
> ASoC drivers are updated to use the 64-bit structures. Corresponding
> ioctls are added to expose them to user-space.
> 
> The series is structured as follows:
> 
> Patch 1: Updates the pointer op, refactors the core logic and ASoC
> drivers to use it, and defines the new UAPI structs.
> 
> Patch 2: Exposes the SNDRV_COMPRESS_TSTAMP64 ioctl.
> 
> Patch 3: Exposes the corresponding SNDRV_COMPRESS_AVAIL64 ioctl.
> 
> This series has been tested on a Pixel 9 device. All compress offload
> use cases, including long-running playback, were verified to work
> correctly with the new 64-bit API.
> 
> Thanks,
> Joris (George) Verhaegen
> 
> Signed-off-by: Joris Verhaegen <verhaegen@google.com>
> 
> ---
> Changes in v2:
>   - Corrected author and Signed-off-by to be consistent (Mark Brown).
> Changes in v3:
>   - Rework pointer op to return 64-bit timestamp, rather than adding a
>     parallel pointer64 op (Charles Keepax, Takashi Iwai, Vinod Koul)
>   - Bump the protocol version for ABI change (Takashi Iwai)
>   -Fix linker error on Intel Atom (lkp@intel.com)
>   -Rebase on latest for-next sound tree (Takashi Iwai)
>   -Avoid changing return error code for ioctl (internal)
>   -ASoC: Replace u64 % u32 by do_div(u64, u32) (internal)
>   -ASoC: sprd: change current_data_offset to u64 (internal)
> Changes in v4:
>   -Fix compiler error on Intel AVS (lkp@intel.com)
> Changes in v5:
>   -Revert formatting change in compress_offload.c (Vinod Koul)
> 
> Joris Verhaegen (3):
>   ALSA: compress_offload: Add 64-bit safe timestamp infrastructure
>   ALSA: compress_offload: Add SNDRV_COMPRESS_TSTAMP64 ioctl
>   ALSA: compress_offload: Add SNDRV_COMPRESS_AVAIL64 ioctl

Applied all patches now to for-next branch for 6.18.


thanks,

Takashi

