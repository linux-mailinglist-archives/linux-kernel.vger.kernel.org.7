Return-Path: <linux-kernel+bounces-805222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6AFB48597
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BD01B21A38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC392E92B0;
	Mon,  8 Sep 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EzVtd4mM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u8SpLDU1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EzVtd4mM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u8SpLDU1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A912E9746
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317040; cv=none; b=keClFu983IMb8u8vGq4X9G/n+zWH/URixsHL/XrMl703/xKL8tUNmsoX40rHMhvtrjTcLHyMIfdwZC6rB7RY6qBU4penqSqvWH5y0XPtrFenoG52Y/zE+DUbeJZAYTCfJNeibbgYAgrpioGdQqtPHRHZm35/TQbxf9W6Mua8Cvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317040; c=relaxed/simple;
	bh=YsNIdxbLsy4tn/WFM5GUxWkUoUit6Qn2LXw5/EkhjNo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgNY1jIo/pRpcP92Hks9iQai/sEV4Lx1xGZmef/wShVA6rayGsyZHC1T0HJcooZfkR+/NPz8Ad2Ye6Mt50OnckXyKyP8XyVdIx7hfBSsXIvsfxxFssEMsTx4uq5JObFMToI3iovtewzLQV94DjPn2xaJ+qizKM2L43QNgad5Fy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EzVtd4mM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u8SpLDU1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EzVtd4mM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u8SpLDU1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B2BB2625B;
	Mon,  8 Sep 2025 07:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757317036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao8SRK3csL1Kz6yvjwsT0ce+uyqxVPnZP4xKlldRDkE=;
	b=EzVtd4mMLcyCx5FtzKJmsQQtiQDbowdKuEyrvBA2ns1oOAqfHlCIYLL16l4loCRceSPTrP
	o4nAM4oyduM3O5Z4MKKIQTkcie64CmF44nXrgmORfCYkgW83GboJAmY1/FV19Kz0ZzTAGW
	cL3EWJYUR9tAXVIo+S/WDH2jypDELW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757317036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao8SRK3csL1Kz6yvjwsT0ce+uyqxVPnZP4xKlldRDkE=;
	b=u8SpLDU1xrOzkFI8HgxGN00FxCZZcLWeq/yWK/809YEtEeNzf7XXDinxvbYZD8MqEF5A44
	0zaWIwCczz+jOlCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EzVtd4mM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u8SpLDU1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757317036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao8SRK3csL1Kz6yvjwsT0ce+uyqxVPnZP4xKlldRDkE=;
	b=EzVtd4mMLcyCx5FtzKJmsQQtiQDbowdKuEyrvBA2ns1oOAqfHlCIYLL16l4loCRceSPTrP
	o4nAM4oyduM3O5Z4MKKIQTkcie64CmF44nXrgmORfCYkgW83GboJAmY1/FV19Kz0ZzTAGW
	cL3EWJYUR9tAXVIo+S/WDH2jypDELW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757317036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao8SRK3csL1Kz6yvjwsT0ce+uyqxVPnZP4xKlldRDkE=;
	b=u8SpLDU1xrOzkFI8HgxGN00FxCZZcLWeq/yWK/809YEtEeNzf7XXDinxvbYZD8MqEF5A44
	0zaWIwCczz+jOlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E8F113869;
	Mon,  8 Sep 2025 07:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pLo1CqyHvmgrRQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 08 Sep 2025 07:37:16 +0000
Date: Mon, 08 Sep 2025 09:37:15 +0200
Message-ID: <87wm69l7is.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>
Subject: Re: [PATCH v4] ALSA: hda/tas2781: Fix the order of TAS2781 calibrated-data
In-Reply-To: <20250907222728.988-1-shenghao-ding@ti.com>
References: <20250907222728.988-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 6B2BB2625B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Mon, 08 Sep 2025 00:27:27 +0200,
Shenghao Ding wrote:
> 
> A bug reported by one of my customers that the order of TAS2781
> calibrated-data is incorrect, the correct way is to move R0_Low
> and insert it between R0 and InvR0.
> 
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Applied now.  Thanks.


Takashi

