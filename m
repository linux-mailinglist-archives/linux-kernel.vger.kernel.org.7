Return-Path: <linux-kernel+bounces-735057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA1B08A46
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E50C1A67599
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C08298CB0;
	Thu, 17 Jul 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JHa0jhA+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zZ6vedIZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JHa0jhA+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zZ6vedIZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A0289808
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746870; cv=none; b=L86hYjiOoX15R56cfvgqzJSMozGXO7MPUxRbTskLiU50/vkou6tyJLnnyz7/3UoUsJwOnanhyjAsw5Nyj2NMnj+vVB1ld3JVlXySwTfVE9UcSUbbK50ce6ef6Hvmdm/fBPtXR3BNPlRmxXkcau+wl8s9SM0QV0FqliVAEbjUO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746870; c=relaxed/simple;
	bh=PYw0HZpBcIPMweebRezzW3je0YTx/m+a/d6ydU8kHFc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVkTQcu+2WErITMHwSNmyuxqOLRuujBu2werQuOe1RBuVcMPHILivujo9WmsxdzzXN32OxsQpbOx0Bt0rme/fg14gSNfmpcl9MRU+Eab+iAta+Xok2TyaszIsXhJBF/KOhh7utL4WOcK66YuWtCFLlisjJv8y8tuu7dvC2Sy26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JHa0jhA+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zZ6vedIZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JHa0jhA+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zZ6vedIZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F525216F2;
	Thu, 17 Jul 2025 10:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752746866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SDLO0wpm53maWeUC3PwUrjWWwCvxlueHHYDIlsxuH7g=;
	b=JHa0jhA+6dt4oMmQMTEfWO7fr9LlF9tpz0DcdYdswraYtlFRTWWJo4+kezKlflyhXBGT13
	QtUg3a55yo6Bnw+XEF0LAr7LiiGiVOLpRaxXJ0qxLkOmTpD1taIthHtWN6JnVBfOSwTUtf
	cffWlLzjd3S7Z4EeegFky12vyFAZK20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752746866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SDLO0wpm53maWeUC3PwUrjWWwCvxlueHHYDIlsxuH7g=;
	b=zZ6vedIZM8zyC33I3R2gWO7uBUmCsEAwk0INQD9pHCkf/MYP4EbbVAfK8dgAK0eir1fC2c
	j+PKTa0xwCdwGuCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JHa0jhA+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zZ6vedIZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752746866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SDLO0wpm53maWeUC3PwUrjWWwCvxlueHHYDIlsxuH7g=;
	b=JHa0jhA+6dt4oMmQMTEfWO7fr9LlF9tpz0DcdYdswraYtlFRTWWJo4+kezKlflyhXBGT13
	QtUg3a55yo6Bnw+XEF0LAr7LiiGiVOLpRaxXJ0qxLkOmTpD1taIthHtWN6JnVBfOSwTUtf
	cffWlLzjd3S7Z4EeegFky12vyFAZK20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752746866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SDLO0wpm53maWeUC3PwUrjWWwCvxlueHHYDIlsxuH7g=;
	b=zZ6vedIZM8zyC33I3R2gWO7uBUmCsEAwk0INQD9pHCkf/MYP4EbbVAfK8dgAK0eir1fC2c
	j+PKTa0xwCdwGuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 793E113A6C;
	Thu, 17 Jul 2025 10:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6wdwHHLLeGhFYwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 17 Jul 2025 10:07:46 +0000
Date: Thu, 17 Jul 2025 12:07:46 +0200
Message-ID: <87ecuf9ll9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sharan Kumar Muthu Saravanan <sharweshraajan@gmail.com>,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP OMEN 16 Laptop xd000xx
In-Reply-To: <87jz479m96.wl-tiwai@suse.de>
References: <CAGo=CcK+aHAYVv=tS4frM07D8MCar1CHBy3r3eg1An16YCqk6g@mail.gmail.com>
	<87jz479m96.wl-tiwai@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 9F525216F2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 17 Jul 2025 11:53:25 +0200,
Takashi Iwai wrote:
> 
> On Thu, 17 Jul 2025 05:02:19 +0200,
> Sharan Kumar Muthu Saravanan wrote:
> > 
> > this patch is to fix my previous Commit e518230 i have fixed mute led
> > but for by This patch corrects the coefficient mask value introduced
> > in commit e518230, which was intended to enable the mute LED
> > functionality. During testing, multiple values were evaluated, and an
> > incorrect value was mistakenly included in the final commit. This
> > update fixes that error by applying the correct mask value for proper
> > mute LED behavior.
> > 
> > Tested on 6.15.5-arch1-1
> > 
> > Signed-off-by: M SHARAN KUMAR <sharweshraajan@gmail.com>
> 
> The patch is still not applicable cleanly.
> Please try to fix the mailer setup and resubmit.  At best, test to
> send a patch to yourself, and try to apply the patch by yourself,
> before resubmitting.
> 
> Also, don't forget to add the proper Fixes tag pointing to the
> commit.  It must be with 12 chars SHA1 ID followed by the commit
> summary.  See Documentation/process/submitting-patches.rst for
> details.

Last but not least: please use the proper subject line.
The subject of this patch is *exactly* same as the commit you're
trying to fix.  This patch isn't about enabling the mute LED; it's
correcting the bug introduced by the previous patch.


Takashi

