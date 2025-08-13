Return-Path: <linux-kernel+bounces-766274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA079B2448F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2991B60ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F80C2EF656;
	Wed, 13 Aug 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rvw6PHrP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B9keNU7P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rvw6PHrP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B9keNU7P"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED02D12EF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074604; cv=none; b=myUHPLu3hJmD0wcSZHAemaclEClsWSIjUfMFFWEfKvttuRqZaMgbeKcHqPOKmy/Vd5kuekmxbRUOwwS6Bti51QIqyjmfwd3aj9GOYRyup4uXlWLHJ3nKw59pQ6k2UxNo9iLFx5zpV7V/7BNoXTutcyAKEUvuUq7zopcOYZaDgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074604; c=relaxed/simple;
	bh=Y2E2mn9mO1evzeXdp+tUIQyLhvGbKGtSDcnozSPBWwg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLC07+Rc5pFyzLM5/VSHtIj6e522fzy+Zeqt/EzC5fNbi3d3zIpTB+lrfsKuEsrfv0Nid7pJd76t9ASrZESUve4iiHeXECeHurJTBrX0Ejz/NGcg7jgqch+s8QAK44bxrVLEjEC47fiOAq8lyLmhM7wgpIlThYHntauHpBosFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rvw6PHrP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B9keNU7P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rvw6PHrP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B9keNU7P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D04E81F455;
	Wed, 13 Aug 2025 08:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755074601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgAF2JcilgOIJ+nIikpdqF5jAmEIpEe8oKeqRxVmOs8=;
	b=rvw6PHrPSHXQ4zq9T5rdXA18MOmfhdi3v0k9pYlcjDPuoMJxJizBC2nUm5isiy73pyX83C
	gTOyKrZ6aSM86eU0xV95KayAL3DK/bFsylH5Tn3Lwk1jMNThw9cYI6+TSAibrV05vexMR5
	KHHvyOvSfWPMiuIxMns4DP7LXCqGQ5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755074601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgAF2JcilgOIJ+nIikpdqF5jAmEIpEe8oKeqRxVmOs8=;
	b=B9keNU7PMuDtnAzFYca1D4LPHyr7nJbozerp7CJDSeV6e2JjECgpkVzxU2S6AziRSjcBwH
	YdVAijGoS8i1MtDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755074601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgAF2JcilgOIJ+nIikpdqF5jAmEIpEe8oKeqRxVmOs8=;
	b=rvw6PHrPSHXQ4zq9T5rdXA18MOmfhdi3v0k9pYlcjDPuoMJxJizBC2nUm5isiy73pyX83C
	gTOyKrZ6aSM86eU0xV95KayAL3DK/bFsylH5Tn3Lwk1jMNThw9cYI6+TSAibrV05vexMR5
	KHHvyOvSfWPMiuIxMns4DP7LXCqGQ5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755074601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgAF2JcilgOIJ+nIikpdqF5jAmEIpEe8oKeqRxVmOs8=;
	b=B9keNU7PMuDtnAzFYca1D4LPHyr7nJbozerp7CJDSeV6e2JjECgpkVzxU2S6AziRSjcBwH
	YdVAijGoS8i1MtDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A68BC13479;
	Wed, 13 Aug 2025 08:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EBF0JylQnGgIDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Aug 2025 08:43:21 +0000
Date: Wed, 13 Aug 2025 10:43:21 +0200
Message-ID: <87ikiry5li.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
In-Reply-To: <20250812132209.83728-1-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
	<20250812132209.83728-1-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Tue, 12 Aug 2025 15:22:02 +0200,
©erif Rami wrote:
> 
> Hi there,
> 
> I'm sorry if if this is inproper way to submit new version of the patches.
> The v2 submission got mixed up with unusable patches.
> Hopefully this isn't an issue for the verification of the changes and further
> review.

The patches look mostly OK, but there are a few remaining issues.
Looking forward to seeing v4.

Also, at the submission of v4, please don't hang on the previous
thread, but rather open a new thread.  It'll make easier to follow the
new series.


Thanks!

Takashi

