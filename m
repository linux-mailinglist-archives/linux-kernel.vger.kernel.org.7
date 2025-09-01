Return-Path: <linux-kernel+bounces-793929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F4AB3DA59
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B0E3BA831
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D2F25A2B5;
	Mon,  1 Sep 2025 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UCooQjBn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="35/JeQv4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UCooQjBn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="35/JeQv4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92302212556
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709719; cv=none; b=Jjm7fpsAnxhsvip4X42EP0pwXaRy37Q0XqxBo3Dup4FctNpMfiHIBApkufmRFMiMsO1CEUqH4OPbH31TIO6aypjgl60og4BzZxwykmvkMF8dcdrwznd5vOrp7Ku9jofYGhxgo8rsKSuPzS57kqU/pZznSGmg78LYzzt3RIB+34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709719; c=relaxed/simple;
	bh=XljtXRCZzIxYAlR1PIAIjUGBOYO+G+RkoGDswVj7SAs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9MYoLdUGl6wlhIGREklV8Wh9ZDOnviiQHDDZ1yrzyjCLOClDT21ujQzSV+VUMMUL7qYiN+9//YzFrTBwBtZ44Th6E4KOKsaqlG+Sxx7xpr3VtcIdHXh3JoTgp9XhVh3jlA/LEHbmfKssqoXzZFDb02k/cOE0BcTw2GpqfAqMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UCooQjBn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=35/JeQv4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UCooQjBn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=35/JeQv4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9ADBC1F38C;
	Mon,  1 Sep 2025 06:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756709715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g/Mxe5U1Ti0oZ802PkuJxT0wUhmW2w166QeYUk3FxU=;
	b=UCooQjBn3lHpCAWwQCL44G3WoblnYxLnRKDVID4aUDX2dKFa2W8pyHeRkjB1fS67OURDlQ
	H6OXXq0HBazZChWA8VNsan5OPJWuEC26MVyXsNMacznBMZ170nFufxWQpDzoz1tKB/Dss2
	DtaoHwrCAx3jxsAf8tYuZChWO/sdQkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756709715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g/Mxe5U1Ti0oZ802PkuJxT0wUhmW2w166QeYUk3FxU=;
	b=35/JeQv4CXbKPgYiwXgQN8PJKNFZBLVctoxYTehnlHsIxcaU3fwx4bJY35DMvSF/Ti1p7x
	bmtkC3IEPbHKDGDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UCooQjBn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="35/JeQv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756709715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g/Mxe5U1Ti0oZ802PkuJxT0wUhmW2w166QeYUk3FxU=;
	b=UCooQjBn3lHpCAWwQCL44G3WoblnYxLnRKDVID4aUDX2dKFa2W8pyHeRkjB1fS67OURDlQ
	H6OXXq0HBazZChWA8VNsan5OPJWuEC26MVyXsNMacznBMZ170nFufxWQpDzoz1tKB/Dss2
	DtaoHwrCAx3jxsAf8tYuZChWO/sdQkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756709715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g/Mxe5U1Ti0oZ802PkuJxT0wUhmW2w166QeYUk3FxU=;
	b=35/JeQv4CXbKPgYiwXgQN8PJKNFZBLVctoxYTehnlHsIxcaU3fwx4bJY35DMvSF/Ti1p7x
	bmtkC3IEPbHKDGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50A72136ED;
	Mon,  1 Sep 2025 06:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NLMgEVNDtWiUPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 01 Sep 2025 06:55:15 +0000
Date: Mon, 01 Sep 2025 08:55:14 +0200
Message-ID: <877byifyr1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	broonie@kernel.org,
	andriy.shevchenko@linux.intel.com,
	13564923607@139.com,
	13916275206@139.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	baojun.xu@ti.com,
	Baojun.Xu@fpt.com
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Fix the order of TAS2563 calibrated-data
In-Reply-To: <3afb62060097eeafbf9faed33654f7f6612596f4.camel@irl.hu>
References: <20250831124313.438-1-shenghao-ding@ti.com>
	<3afb62060097eeafbf9faed33654f7f6612596f4.camel@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,fpt.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 9ADBC1F38C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Mon, 01 Sep 2025 08:18:06 +0200,
Gergo Koteles wrote:
> 
> Hi Shenghao,
> 
> On Sun, 2025-08-31 at 20:43 +0800, Shenghao Ding wrote:
> > A bug reported by one of my customers that the order of TAS2563
> > calibrated-data is incorrect, the correct way is to move R0_Low_%d
> > and insert it between R0_%d and InvR0_%d.
> > 
> 
> A similar fix is ​​already in Takashi's tree for tas2563.
> https://lore.kernel.org/all/20250829160450.66623-1-soyer@irl.hu/

Right, I already took Gergo's fix on for-linus branch.
Likely included in 6.17-rc5.

> But I think, tas2781 also needs one for the order and one for the
> endianness.
> I left it out because it's easier for you with documentation.

If anything is missing for 6.17, please submit the fix ASAP.


thanks,

Takashi

