Return-Path: <linux-kernel+bounces-749602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A14AEB15070
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F127918A1FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A3296153;
	Tue, 29 Jul 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ai7G92Bu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X9z8Bcm6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ai7G92Bu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X9z8Bcm6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72329552F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804153; cv=none; b=JneMNitscrigMO/oPVerfoAb6da1gIWn1kxUiAPokfafN9NUNyuCAkoedzNRuhYQ3gmSmGidvzKMgPwiq+PiysvJ4jkoLFX48Qi+lWq2yTnb4WjZdBuqCJNGcKv5KYnQBQZeMezmdAigaoeg5WOZKe0v8nrdnz34lBzuIHIuQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804153; c=relaxed/simple;
	bh=IVNy6v9HGzm94qke8swRbmLaY42nxP91LpFEJqAQ4l0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2rzvhWpkUDrwps7HB7q0YYYvg6/H1UW5OwYvrNahouJs+WfLwMx/+PQqC4n9Y4zGiBwltpWKpZLoI6sT9KiKia1Ky9Bzav9lcFOF7EQi2C3uueqxOJS9UQt8gGVKdsqSWn2M8WJuKFXpMwIDuk2Q5bGVkwdx9VF2/qNwZs+lUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ai7G92Bu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X9z8Bcm6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ai7G92Bu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X9z8Bcm6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64DF11F397;
	Tue, 29 Jul 2025 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753804148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpUU701DImrDdhgMT8J+8eS3XOnIAyB/YwvE+FSAL4M=;
	b=Ai7G92BuqFGZXtbhwbN0/wqybH13lSuUBzlkavMBR8p6xsTzs+EMVYyX+2wLSdB9aOguoe
	+uQ1ONwfJ2VVLIjaihWnmch3vfWuKjKSgblxbS12FBOxwQu9RPD2Fcv/2QqYJ4Tu6Al8hQ
	bIp77nrgNthZ3vEnh9qnVHkv71ydB4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753804148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpUU701DImrDdhgMT8J+8eS3XOnIAyB/YwvE+FSAL4M=;
	b=X9z8Bcm6sYXYHh1OFKCmWnsi2eeutNHmilCSnz6pg36gXXONGiKNFnKV8+hCDI3RRR3YeE
	dLhHhedtkxWYChBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753804148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpUU701DImrDdhgMT8J+8eS3XOnIAyB/YwvE+FSAL4M=;
	b=Ai7G92BuqFGZXtbhwbN0/wqybH13lSuUBzlkavMBR8p6xsTzs+EMVYyX+2wLSdB9aOguoe
	+uQ1ONwfJ2VVLIjaihWnmch3vfWuKjKSgblxbS12FBOxwQu9RPD2Fcv/2QqYJ4Tu6Al8hQ
	bIp77nrgNthZ3vEnh9qnVHkv71ydB4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753804148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpUU701DImrDdhgMT8J+8eS3XOnIAyB/YwvE+FSAL4M=;
	b=X9z8Bcm6sYXYHh1OFKCmWnsi2eeutNHmilCSnz6pg36gXXONGiKNFnKV8+hCDI3RRR3YeE
	dLhHhedtkxWYChBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 273EF13A73;
	Tue, 29 Jul 2025 15:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OXfrB3TtiGjMUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Jul 2025 15:49:08 +0000
Date: Tue, 29 Jul 2025 17:49:07 +0200
Message-ID: <877bzrt2to.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<alsa-devel@alsa-project.org>,
	<shenghao-ding@ti.com>,
	<13916275206@139.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda: Fix the wrong register was used for DVC of TAS2770
In-Reply-To: <20250729145849.55057-1-baojun.xu@ti.com>
References: <20250729145849.55057-1-baojun.xu@ti.com>
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
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,alsa-project.org,ti.com,139.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Tue, 29 Jul 2025 16:58:49 +0200,
Baojun Xu wrote:
> 
> The wrong register was used for digital volume control of TAS2770,
> The definition was changed, and usage was also updated.
> 
> Fixes: ab29b3460c5c ("ALSA: hda: Add TAS2770 support")
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Applied now.  Thanks.


Takashi

