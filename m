Return-Path: <linux-kernel+bounces-823486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB71B86A02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96931C87255
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967512D3745;
	Thu, 18 Sep 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sFBWGxT2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="scysqsaM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sFBWGxT2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="scysqsaM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90E2C0265
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222659; cv=none; b=BxaWauzMdhNVciAFH3T+tLHnxnKNSC9coFEhAQV5z0r7o+MKBusENoB+UYyciEgxZMUlLn/BOwc+hWSUDwc266XzYRU/yJgBMJDdKtzO5K44dFLpm2HfA0bVj7aTHIQSFpBS1c0ZXer921IcDjarp/lb1b+zc5sBVEqBy0p85pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222659; c=relaxed/simple;
	bh=Oy+RAxugv4mDdmI6mvSsUYa6jnaGclKcBqMdD9aMa4o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPfHXfr8bvoZ9WhbTkwzYWmJnvN6O0kR8SZ+rUeqoZQORw0LDaEwxVVAEroF8ZEkp4UZI/8k54aYVyOlh8jp6QYDg1cwVES6K+XdywEKMUNX3UYzGNyw2QWOUW8cosMn65YlBmsafd9axPZGqO9zotn6Heib3Pdpqere8SJnyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sFBWGxT2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=scysqsaM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sFBWGxT2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=scysqsaM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C0DF21C3B;
	Thu, 18 Sep 2025 19:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758222656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcZKwJP1qyd07WLo1MS3G/y8S1FE445FKUuAGsTw9no=;
	b=sFBWGxT21DAi+pej12XnEwLBJC7RE933vzo65a0yUXdNq4UELWtSojp7PgBDM+vqCRDfBx
	LDz/7UUi0hBA5bwztjnbKowPgtazXTd9D9GYQ19U+aGovrWGYEyMZ2DLgGjeLMCcphpNjP
	EiaSjbxAiI6fJH3hUseoptlHpwTrcCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758222656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcZKwJP1qyd07WLo1MS3G/y8S1FE445FKUuAGsTw9no=;
	b=scysqsaMXSN8v09CO7U6cuQu3hzlqtrHt/CXd/RMyxRQEaiPMNMJC00xhIsKgs8KVsMcdA
	XRLWxfEAHh8/C1Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sFBWGxT2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=scysqsaM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758222656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcZKwJP1qyd07WLo1MS3G/y8S1FE445FKUuAGsTw9no=;
	b=sFBWGxT21DAi+pej12XnEwLBJC7RE933vzo65a0yUXdNq4UELWtSojp7PgBDM+vqCRDfBx
	LDz/7UUi0hBA5bwztjnbKowPgtazXTd9D9GYQ19U+aGovrWGYEyMZ2DLgGjeLMCcphpNjP
	EiaSjbxAiI6fJH3hUseoptlHpwTrcCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758222656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcZKwJP1qyd07WLo1MS3G/y8S1FE445FKUuAGsTw9no=;
	b=scysqsaMXSN8v09CO7U6cuQu3hzlqtrHt/CXd/RMyxRQEaiPMNMJC00xhIsKgs8KVsMcdA
	XRLWxfEAHh8/C1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C201D13A39;
	Thu, 18 Sep 2025 19:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e9MULj9ZzGglIQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Sep 2025 19:10:55 +0000
Date: Thu, 18 Sep 2025 21:10:55 +0200
Message-ID: <87o6r7a85c.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: praful.adiga@gmail.com
Cc: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	chris.chiu@canonical.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ALSA: hda/realtek: Fix mute led for HP Laptop 15-dw4xx
In-Reply-To: <20250918164018.69040-1-praful.adiga@gmail.com>
References: <20250918164018.69040-1-praful.adiga@gmail.com>
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
X-Rspamd-Queue-Id: 0C0DF21C3B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Spam-Score: -2.01

On Thu, 18 Sep 2025 18:40:18 +0200,
praful.adiga@gmail.com wrote:
> 
> From: Praful Adiga <praful.adiga@gmail.com>
> 
> This laptop uses the ALC236 codec with COEF 0x7 and idx 1 to
> control the mute LED. Enable the existing quirk for this device.
> 
> Signed-off-by: Praful Adiga <praful.adiga@gmail.com>

Applied now.  Thanks.


Takashi

