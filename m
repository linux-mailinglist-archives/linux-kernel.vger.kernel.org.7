Return-Path: <linux-kernel+bounces-888203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6DC3A2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D6C3A8BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B1F30C62A;
	Thu,  6 Nov 2025 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qYd7f+wt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gafqgFFp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zKXpyvRy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WyaTMup9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E82848A7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423502; cv=none; b=TO5+fptjHSj47HmqIUivHKT6q8lyFlbJi/Qi47wdFQ2DDyAU1gTOz5BrFqKLCLmjgR0uMSJLkKwUqxWHuXRU+u8PIsobT3zmh2meRG4scFD54zHmBAspmjYFXxVB+wtq9Wzo+k13MlbU+3/vf1SHoa6QSWIDAtMt6NLE2vfmvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423502; c=relaxed/simple;
	bh=RGFjMWGmcgUsV3X1SztoiiQ0KkJtUGLHxAdCfukuBdU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGEitgvLRXEySeeo3g2zA1WF464Qk2hxvH4gjGqqYqZ1J6dYYlI5gAGcd/d7Nyn85NCgg/FEOJzgVLjxB9+ie9eyBUloqycLrlUVliVviWys98ywPtwghZF7j7uGY+R5g8gUtKcXKz7a85OcTcA7ekBvlnrjpY2Y/CJo+4Bxuog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qYd7f+wt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gafqgFFp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zKXpyvRy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WyaTMup9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92653211CC;
	Thu,  6 Nov 2025 10:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KuaYp2qrLzFaro3w9aEzA1iCPDWlTi5GGfmshKLJZSs=;
	b=qYd7f+wtgJJJhwaYOLABFzPe2+rgfBfVRC7a6mPgwEzqUc6tI8QgWmAlWiQPlYZo/GenDq
	sc/E5ctPK6nYEAAPx3C98K2MeEHB2g4og+swO7RSXYyKe6VpI3h+w84HuZ3rtNm4mRF1Ja
	QDDyHA5dnAp64Ib4iHhbDiRTChpWLKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KuaYp2qrLzFaro3w9aEzA1iCPDWlTi5GGfmshKLJZSs=;
	b=gafqgFFp4qazKMdDG6dzdr23tOrmbZyzGI3+s+m3nJ3zZ4fyBeiHT4V6eKp/MEM8GIG+4g
	/7DCx6AhUH3PW4DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zKXpyvRy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WyaTMup9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KuaYp2qrLzFaro3w9aEzA1iCPDWlTi5GGfmshKLJZSs=;
	b=zKXpyvRy+rIc/zGmERdQo7JJ/LR+NavTvDGhW67JV/0ZKovXs2jNwNV0hvEQ5ENt0guSbs
	fsPzaSVA9KMN1h4p6apU18KBE9YzkU7chmDG3vOT3KbMdE9tsLho57bjo1472fCaOk56Gi
	eYbRa0/ehwaIcT7IuGJG1sDJHJUrLiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KuaYp2qrLzFaro3w9aEzA1iCPDWlTi5GGfmshKLJZSs=;
	b=WyaTMup9V7oowWOJqAsh3aaPVF9y65W0TED5S08Nbksi/HAs9uWMXO9O4hzKBLVwcse8jk
	EtMBMVBs9BByVGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D0FA13A31;
	Thu,  6 Nov 2025 10:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /GN0EclyDGmMOgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 10:04:57 +0000
Date: Thu, 06 Nov 2025 11:04:56 +0100
Message-ID: <875xbnh3xz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdich9700@163.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH] ALSA: hda/senary: Replace magic numbers with defined constants
In-Reply-To: <20251106063626.115358-1-wangdich9700@163.com>
References: <20251106063626.115358-1-wangdich9700@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 92653211CC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	FREEMAIL_TO(0.00)[163.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org,lists.infradead.org,kylinos.cn];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,kylinos.cn:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Thu, 06 Nov 2025 07:36:26 +0100,
wangdich9700@163.com wrote:
> 
> From: wangdicheng <wangdich9700@163.com>
> 
> Replace hardcoded GPIO node value with a defined constant for better
> code readability and maintainability.
> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>

Please try to align both From and Signed-off-by addresses.


thanks,

Takashi

