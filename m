Return-Path: <linux-kernel+bounces-834858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934F6BA5A85
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44688321882
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351ED2D3212;
	Sat, 27 Sep 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KiKRq3xs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TP/ZU12s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KiKRq3xs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TP/ZU12s"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7C2D29C3
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758959930; cv=none; b=hWtgh/ldo64nGxSqHzFHl12Q8p1sEHEUoPRuMJvX9w02gfBZvffSDX3xJT3vLLO8q3RYITJ4Zv3Aw7Uhwsp2DH7K+zv1SKcYxAztWy38T34cZayFGyBR5GysP8H5AOdTK2oAy8WXvsXgPaNKSdda4FA1hME+pUVIeHGVbOGlcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758959930; c=relaxed/simple;
	bh=HR0qO8gHX6aAXc6yTShu71RRVpPWZ4d836yvKlxVm/4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=holc2SGC6WOWyQdjLugbsb/UYf9CBf9qQR3nnCHR1I2G2l7yG5swSV69syuzMP7yAWLAF1XY5Hx5Zgcy036Jw1cmxYrVlygynvbsl0SLeW0ijgFqo486fdawLhkJ8W0qNofqiIAmMrKCgehuXl8nDHPmTfr6JnYngjAPiAg3jGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KiKRq3xs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TP/ZU12s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KiKRq3xs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TP/ZU12s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E68A5C5B7;
	Sat, 27 Sep 2025 07:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758959926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kqTvBLPLCqPJt6nkYq3LM/TFb7EkSNWGwO4ZH5bH0Y=;
	b=KiKRq3xsrcOqn3qivhxr2O3+LGXIAwIpHPdMuWaCBiN+7fqJu42G0GzEQFgJX+Ffb2r1Yn
	qBT5szwqblPtEUhyMx8LaZm6ySOX7Yy75O4qFvV507V53KUpyyaFGOvOQMMg1zBPz8haoH
	gHHVjox5lI4KZopof00l5htnNMtP9w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758959926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kqTvBLPLCqPJt6nkYq3LM/TFb7EkSNWGwO4ZH5bH0Y=;
	b=TP/ZU12sL95/TvwxmNc138SooLHL6N3Y4MHhFVU0gm+zR4BWeeGhVLj7W9fCQKxa0CFwJI
	PKPCjDnmqy7GLICA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758959926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kqTvBLPLCqPJt6nkYq3LM/TFb7EkSNWGwO4ZH5bH0Y=;
	b=KiKRq3xsrcOqn3qivhxr2O3+LGXIAwIpHPdMuWaCBiN+7fqJu42G0GzEQFgJX+Ffb2r1Yn
	qBT5szwqblPtEUhyMx8LaZm6ySOX7Yy75O4qFvV507V53KUpyyaFGOvOQMMg1zBPz8haoH
	gHHVjox5lI4KZopof00l5htnNMtP9w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758959926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kqTvBLPLCqPJt6nkYq3LM/TFb7EkSNWGwO4ZH5bH0Y=;
	b=TP/ZU12sL95/TvwxmNc138SooLHL6N3Y4MHhFVU0gm+zR4BWeeGhVLj7W9fCQKxa0CFwJI
	PKPCjDnmqy7GLICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 694CD13782;
	Sat, 27 Sep 2025 07:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X7CmFzaZ12hZMgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 07:58:46 +0000
Date: Sat, 27 Sep 2025 09:58:45 +0200
Message-ID: <87cy7cba2y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 0/2] ALSA ASoC/HDA: cs35l56: Add support for B2 silicon
In-Reply-To: <20250923130326.510570-1-rf@opensource.cirrus.com>
References: <20250923130326.510570-1-rf@opensource.cirrus.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Tue, 23 Sep 2025 15:03:24 +0200,
Richard Fitzgerald wrote:
> 
> This series adds support for the latest (B2) revision of cs35l56.
> 
> Most of the code is in ASoC, but there are some trivial changes
> needed to the HDA drivers. They are to prevent build breaks so
> they have been included in the ASoC patch.
> 
> Richard Fitzgerald (2):
>   ASoC: cs35l56: Set fw_regs table after getting REVID
>   ASoC: cs35l56: Add support for CS35L56 B2 silicon

Mark, shall I apply those patches to my tree?
They seem cleanly applicable.


thanks,

Takashi

