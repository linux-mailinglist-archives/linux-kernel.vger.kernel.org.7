Return-Path: <linux-kernel+bounces-739439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B08B0C64F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604264E5ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CA62DCF4A;
	Mon, 21 Jul 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kbfVdA1E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X4cmvt6v";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jXcW+2BT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W1BOE2qm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6C2DC335
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108176; cv=none; b=ma+781xl4KqDRjJs7Y96iTXMndWLJ1zv5pJEISNHGarWKPv21jTGFFhxOIOqu//wai3s5Xx/BK298ofizXOvUp+oSuqvcr2gcCYg2xxUloqjgQZ4gcFLOOY959kPWGx54FWM5zITIta79EfoqKmO956H6auXxBkptgP0BGHVO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108176; c=relaxed/simple;
	bh=96wTtwS03kjWcL3m82S7BzO+HEmJOwtKs1WpfLhFJXU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBsEbjnlwldulBnrZdsEFcLM1htZ6zC668YCAugtrtYyvT4e1gmrDW6PPS4ZLzXW5ThXZWjVEsmPIH1djEeGBDal2VxTWAYFtwKCbxnbvSO4Ulk3X1iuZqACcZTxdu1ZX/JsjNJRozN96fdKqq5Trmbh6AKKqnfqGq1paC09oZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kbfVdA1E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X4cmvt6v; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jXcW+2BT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W1BOE2qm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 259DB1F84E;
	Mon, 21 Jul 2025 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753108173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3gINDOHKCiVuqdD1u2tyiwCTQh41DKbiZSP35pDZUI=;
	b=kbfVdA1EQkKm5xo+eGrx/N+cLRqRL1DQC7NzIzwVh70RLiZhxDpkBbCfPxIocvW/y6AbNS
	e2uwvrZjmD8Ce2CDBaFKUDlsbr1Y26C9zAV+wHeYVtEJZxcKo8PLSuTCaRqeAYkjoOhPPP
	YwMlnYUKHLPIpn/u8KNQNH5wQZu0ay0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753108173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3gINDOHKCiVuqdD1u2tyiwCTQh41DKbiZSP35pDZUI=;
	b=X4cmvt6v8kZEKcppWfQcMNOGDSbMVKQLHGeCWClpLGgEfCNtPQswD2d74U5oP8u/OHodh9
	cKYsyh1bL5QAiUDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jXcW+2BT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W1BOE2qm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753108172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3gINDOHKCiVuqdD1u2tyiwCTQh41DKbiZSP35pDZUI=;
	b=jXcW+2BTKwGYhapEDRTfsAX3F4ydkGswPZnIlkKdACaYwxN2OqqmQmuX3JcbTp5JiDyBoS
	uYcU907x60qee8zIYrPDOU1+Pq7m4PyQzhfPlZ9H8RYwgGQ3WAKwu1EqZRAAwpx9m5BGt6
	IOwjKEi+/lsPBpBZDn3YRe4jvPQSo/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753108172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3gINDOHKCiVuqdD1u2tyiwCTQh41DKbiZSP35pDZUI=;
	b=W1BOE2qmmDaGpwCnKZt4+AIEbRmwF7eSSNSRcvUQKzL1t2vintlrakSLOA3FnVksQO6IFX
	IGSyZ0U6oOO5d0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF60213A88;
	Mon, 21 Jul 2025 14:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XIZQOctOfmgcZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 21 Jul 2025 14:29:31 +0000
Date: Mon, 21 Jul 2025 16:29:31 +0200
Message-ID: <877c014nxw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v1] ALSA: hda/realtek: Add support for ASUS Commercial laptops using CS35L41 HDA
In-Reply-To: <20250721135406.366912-1-sbinding@opensource.cirrus.com>
References: <20250721135406.366912-1-sbinding@opensource.cirrus.com>
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
X-Rspamd-Queue-Id: 259DB1F84E
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,cirrus.com:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Mon, 21 Jul 2025 15:54:05 +0200,
Stefan Binding wrote:
> 
> Add support for ASUS PM3406CKA and PM3606CKA.
> 
> Laptops use 2 CS35L41 Amps with HDA, using Internal boost, with I2C
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Applied now.  Thanks.


Takashi

