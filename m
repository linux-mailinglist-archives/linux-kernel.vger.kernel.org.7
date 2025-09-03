Return-Path: <linux-kernel+bounces-798328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D1B41C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563C3561282
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB602F39DA;
	Wed,  3 Sep 2025 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ReawGCfP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lGL7uF8M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ReawGCfP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lGL7uF8M"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677852F39D3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896749; cv=none; b=BhMn+1/I4/lqSCJEz5YnGFznPMg8jm8N3dohjj8aIGYoOz2zY3+98uhxc9fbHv6XBOODeNgDXokQCt4Nu4vDIxec99CBYzlRgX6f5hrxec5gosy2EaT+pQ/nYgpZSEDezr7+Ep/sOn10KsQjISuPooGTPDtCJqfwvt5/3KIyrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896749; c=relaxed/simple;
	bh=nO9g3PNXhwTLKuaA2Jm4zlIfcuIINjcXTwiFdT85LUY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVNndXRfTmxytP4mE+xpfhBkBVCBwN2isuDnjYA284XTDonUrDEDepQaGEnZSm1V9F9rUgbQlDUUQjKL30ofaaEKKFVbfLDfFK1JRSxMUM7uRPJ+sCQiMbyOcUQ5DNqq1v7v5HLIkpicSwCMUHLGgdKQ2FZuIvG7bI6K+bmzT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ReawGCfP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lGL7uF8M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ReawGCfP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lGL7uF8M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82F0F1F456;
	Wed,  3 Sep 2025 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756896745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnMOUYeZoFXkfeNuRCqWig5KNvw7Qlwif546rjx2fGc=;
	b=ReawGCfPiV9LEelH6cW6IkvDBRd8ncVPj3hLP2aO1u2rxIE5yRcHLh5c5kbL08+7bCZEQC
	8uK1etXrJI7El9u63QgMUg++UwG/r2zbQMR+D3ZIoc4q8yFLWXTmlTrrFGLJec5oVdODfT
	giY3j3gLj+y3aTcGP2o1Bda7N1EJgo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756896745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnMOUYeZoFXkfeNuRCqWig5KNvw7Qlwif546rjx2fGc=;
	b=lGL7uF8MNkBZ+XZo4oyF5Q8wc0LR4m3KBs6sVEUD72IeaRJKwahPsddmonJJSjH8CanV86
	TzfsbGrprk48tyDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756896745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnMOUYeZoFXkfeNuRCqWig5KNvw7Qlwif546rjx2fGc=;
	b=ReawGCfPiV9LEelH6cW6IkvDBRd8ncVPj3hLP2aO1u2rxIE5yRcHLh5c5kbL08+7bCZEQC
	8uK1etXrJI7El9u63QgMUg++UwG/r2zbQMR+D3ZIoc4q8yFLWXTmlTrrFGLJec5oVdODfT
	giY3j3gLj+y3aTcGP2o1Bda7N1EJgo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756896745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnMOUYeZoFXkfeNuRCqWig5KNvw7Qlwif546rjx2fGc=;
	b=lGL7uF8MNkBZ+XZo4oyF5Q8wc0LR4m3KBs6sVEUD72IeaRJKwahPsddmonJJSjH8CanV86
	TzfsbGrprk48tyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44A5A13888;
	Wed,  3 Sep 2025 10:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BEyMD+kduGgSDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 03 Sep 2025 10:52:25 +0000
Date: Wed, 03 Sep 2025 12:52:24 +0200
Message-ID: <87qzwnvmdz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Cryolitia PukNgae <cryolitia@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: docs: Remove 3rd person singular s in *to indicate*
In-Reply-To: <20250903100842.267194-1-pmenzel@molgen.mpg.de>
References: <20250903100842.267194-1-pmenzel@molgen.mpg.de>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Wed, 03 Sep 2025 12:08:41 +0200,
Paul Menzel wrote:
> 
> Fixes: 78811dd56def ("ALSA: docs: Add documents for recently changes in snd-usb-audio")
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied now.  Thanks.


Takashi

