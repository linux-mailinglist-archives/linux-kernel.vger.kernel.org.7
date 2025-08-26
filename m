Return-Path: <linux-kernel+bounces-786285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DAEB357C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B052043DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578662FF159;
	Tue, 26 Aug 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BHsJarB3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jJBZxIE1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BHsJarB3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jJBZxIE1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0152FDC24
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198808; cv=none; b=hc1EjfeihJ3H3aZ+7XxeJ39wEQKvzRh9TvnhIL9sVTiQ5SRaY1lh3OBJvyYCE540ngd36kOUx+c/9grQ1kkxkM0SmE4FNMsWrgtXTu24HUtHhimvHYBp/fiIwpWFEhTbz3U9oS80doWz6G42Xl2TuDwNrGRoXIJByPsCMidb7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198808; c=relaxed/simple;
	bh=XacsbIyM0up0kctDlsVsMxEXCcAlpKqLAzpWFrjVEYE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KP2O6SCWs+9pKAdg5DV32zgFVNg+DBxd36qqJF8zlq+JDsOIFH+QP3sViFLunL5hvLieR8N0FoR/Rx8VlqQRNpTv5g/IqHb+LucFLReZQhiUKcbohedb4Pv8ticNAsqcFYdNHBZQDXvW6x6oRvlqqJHKzgiEusv76zPlJ13/j7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BHsJarB3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jJBZxIE1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BHsJarB3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jJBZxIE1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 317891F787;
	Tue, 26 Aug 2025 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756198804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnPwNa6LP7B365mq43W1LIQAp7oHTiqDnDbqA5du2rA=;
	b=BHsJarB3sqfImXkoJiTX/x3T2Keim2NsL8h+LlKaz3wO1qKNubOV0UlXZGd2BVY5FDT6sB
	mgYU/gz0BqR4pb2sLiEMII+p3m/QdUQCfFaWcMhPN8pGgsYvwH7OSSb+IYIE/jd5lpC+xf
	6t8jvUOC49iMqppbtra5ZxU1XJ0jgXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756198804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnPwNa6LP7B365mq43W1LIQAp7oHTiqDnDbqA5du2rA=;
	b=jJBZxIE1MynWco60bPWQkYkfuyM3YdLGARS+Sn+mnS4uUm9kASv4EQNn40RfNnt4MnFXxi
	WC+6qX7ocmhgcoBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BHsJarB3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jJBZxIE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756198804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnPwNa6LP7B365mq43W1LIQAp7oHTiqDnDbqA5du2rA=;
	b=BHsJarB3sqfImXkoJiTX/x3T2Keim2NsL8h+LlKaz3wO1qKNubOV0UlXZGd2BVY5FDT6sB
	mgYU/gz0BqR4pb2sLiEMII+p3m/QdUQCfFaWcMhPN8pGgsYvwH7OSSb+IYIE/jd5lpC+xf
	6t8jvUOC49iMqppbtra5ZxU1XJ0jgXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756198804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnPwNa6LP7B365mq43W1LIQAp7oHTiqDnDbqA5du2rA=;
	b=jJBZxIE1MynWco60bPWQkYkfuyM3YdLGARS+Sn+mnS4uUm9kASv4EQNn40RfNnt4MnFXxi
	WC+6qX7ocmhgcoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AEA213A31;
	Tue, 26 Aug 2025 09:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /1t2AZR3rWgsWAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Aug 2025 09:00:04 +0000
Date: Tue, 26 Aug 2025 11:00:03 +0200
Message-ID: <87o6s231bg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: us144mkii: Fixes for handshake, MIDI out and cleanup
In-Reply-To: <20250825072557.7670-1-ramiserifpersia@gmail.com>
References: <20250825072557.7670-1-ramiserifpersia@gmail.com>
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
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 317891F787
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Mon, 25 Aug 2025 09:25:57 +0200,
©erif Rami wrote:
> 
> Add a handshake value of 0x32, which is required when the device
> was previously used by another OS with the official drivers.
> 
> Correct the last byte of the MIDI output protocol to 0xe0.
> 
> Also, remove the unused DRIVER_VERSION macro.
> 
> Signed-off-by: ©erif Rami <ramiserifpersia@gmail.com>

Applied now.  Thanks.


Takashi

