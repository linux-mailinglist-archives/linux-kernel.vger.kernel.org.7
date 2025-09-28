Return-Path: <linux-kernel+bounces-835239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F32D0BA68EF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E576189B9F3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3829A9FA;
	Sun, 28 Sep 2025 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R+9jxZsg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2WYPk80I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R+9jxZsg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2WYPk80I"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A181A4E70
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759040924; cv=none; b=jlm2CK17QUQlJds7akl3bYtmEE/Z/xmcRt+7WU+i/EUZNdr9FXIIWeWn0baRgRP+WNLbzmDT5LdWPeC/0F+UxjdjfUuX6tC8xnrevEXp8pQ5pxWVCWF1CvbFLvEMex3wapAwNt/sh68bAyquf1mNLrJpih/dfs85ZnHcg4DBRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759040924; c=relaxed/simple;
	bh=hfU9k/wolxf7jfzzDXf7ZpBadhW/KnBM8Y7fK+igjuo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pd0hr6fHK5vDXQ21eomjnkoiba0zRKrSICDyyDCZosM8DOn5yMVR//yPIYpIXPFKn/6GuaM+gYkLj4uO2cCo4ddUx/Svp6wP1r8+FOATSIiS6/WrTsSWakPGlvEOi+SCrZviz0K0KDdQn9KkuASPdkd1GbMoiLr1s4GGu7uQ9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R+9jxZsg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2WYPk80I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R+9jxZsg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2WYPk80I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9F248D225;
	Sun, 28 Sep 2025 06:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759040919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P88UpOD1tIxQy+jxeUn6n/DaQbo2INeizIF9Urj2U58=;
	b=R+9jxZsgr2/Uq4ASlIAbAWRGn5ucG4uWD0EMvSIwzeSdDjt0k6bK3LMhTDmgfNWhDYhOy5
	5uX6NC5g/UHnTH67NmzjzSFamG01jMLSPaftE3CI20JsB9qmCp5oCK+Ak/Ok1dCJSmqMr7
	LOR40V/fBgRNfuabVIWLWkVoTzcIlwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759040919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P88UpOD1tIxQy+jxeUn6n/DaQbo2INeizIF9Urj2U58=;
	b=2WYPk80IkXbrspPGWlIdWkuOeCY01t3/XAgeXnGbbtGeNDQrmY9aEvFrTn/itSmaGnh8WS
	qAc32ejAJo/MipCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759040919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P88UpOD1tIxQy+jxeUn6n/DaQbo2INeizIF9Urj2U58=;
	b=R+9jxZsgr2/Uq4ASlIAbAWRGn5ucG4uWD0EMvSIwzeSdDjt0k6bK3LMhTDmgfNWhDYhOy5
	5uX6NC5g/UHnTH67NmzjzSFamG01jMLSPaftE3CI20JsB9qmCp5oCK+Ak/Ok1dCJSmqMr7
	LOR40V/fBgRNfuabVIWLWkVoTzcIlwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759040919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P88UpOD1tIxQy+jxeUn6n/DaQbo2INeizIF9Urj2U58=;
	b=2WYPk80IkXbrspPGWlIdWkuOeCY01t3/XAgeXnGbbtGeNDQrmY9aEvFrTn/itSmaGnh8WS
	qAc32ejAJo/MipCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93ACE13A3F;
	Sun, 28 Sep 2025 06:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zYlZIpfV2GjRFwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 28 Sep 2025 06:28:39 +0000
Date: Sun, 28 Sep 2025 08:28:39 +0200
Message-ID: <87a52f9jl4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: broonie@kernel.org
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 0/2] ALSA ASoC/HDA: cs35l56: Add support for B2 silicon
In-Reply-To: <87cy7cba2y.wl-tiwai@suse.de>
References: <20250923130326.510570-1-rf@opensource.cirrus.com>
	<87cy7cba2y.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Sat, 27 Sep 2025 09:58:45 +0200,
Takashi Iwai wrote:
> 
> On Tue, 23 Sep 2025 15:03:24 +0200,
> Richard Fitzgerald wrote:
> > 
> > This series adds support for the latest (B2) revision of cs35l56.
> > 
> > Most of the code is in ASoC, but there are some trivial changes
> > needed to the HDA drivers. They are to prevent build breaks so
> > they have been included in the ASoC patch.
> > 
> > Richard Fitzgerald (2):
> >   ASoC: cs35l56: Set fw_regs table after getting REVID
> >   ASoC: cs35l56: Add support for CS35L56 B2 silicon
> 
> Mark, shall I apply those patches to my tree?
> They seem cleanly applicable.

Assuming that they didn't get merged in ASoC tree, I picked up them
now.  Both applied to for-next branch.


thanks,

Takashi

