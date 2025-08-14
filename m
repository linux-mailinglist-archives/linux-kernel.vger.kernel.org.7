Return-Path: <linux-kernel+bounces-769278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0869BB26C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBA116FA32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8921FF5D;
	Thu, 14 Aug 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YieH2tLk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fMPQe3MB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YieH2tLk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fMPQe3MB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41D17D346
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188007; cv=none; b=DLKbGPywY9X8qmLiPmktzqUqwityfvNoHCYYQkk4xmVDFIF19LJtqfv53gXzkPXs4MXfLV62vGwoCjapEKBKLmelJ69MrkoeAeYtlnxBTeFtS5XcxY9XdACygts5AbByWwVJOGHXXUvj+ElcDRDCAXv1QWv1Ilf/Lr140j9cmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188007; c=relaxed/simple;
	bh=wn0RUU7wRB89Dsu/XEgQvcYCdZEwMPkATy/Q7fw5yk8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlMSayWIy//KXyhblBZVtSI/OeSTIP54DGkXWYwNWu+KndSjcLV5dVpPFLMmakeCvq++mXghyup4VArelZWcvGvGEOp5tkayVLxP/kANLTNN33cDsuqkWE8lWhC5EGpc9pbRS/+HW4jlbh/SzvnqrzzvXiItVpTHoLu+dkyBicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YieH2tLk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fMPQe3MB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YieH2tLk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fMPQe3MB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 909B71F7FE;
	Thu, 14 Aug 2025 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755188003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HY1Ka0blAbgBSRBSt7UsmlbudX5SHQaBBsmWeXDPrW0=;
	b=YieH2tLkKlvRrVu6dJLG1RLMdnmZmCzItV3ivvcnK5VZSx2EH4lM4pQmyUuyTM2vc3kO8b
	lUP4K3wz4I8uXfopS1pl0I9O4/J+nUh7RsZndBjrr90oSIKfDvINDVnoRqbN/cKNaGv3Q0
	UZIpOI6U7XXz6McC105pWKGmecr5uk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755188003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HY1Ka0blAbgBSRBSt7UsmlbudX5SHQaBBsmWeXDPrW0=;
	b=fMPQe3MBMVFloEbJao3B95VwXbo9DZIPltasgGnrFSNAQHaYTUWbkJ3Aki6bJjNqxaWqp3
	dudKTll5S6gjgqAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YieH2tLk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fMPQe3MB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755188003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HY1Ka0blAbgBSRBSt7UsmlbudX5SHQaBBsmWeXDPrW0=;
	b=YieH2tLkKlvRrVu6dJLG1RLMdnmZmCzItV3ivvcnK5VZSx2EH4lM4pQmyUuyTM2vc3kO8b
	lUP4K3wz4I8uXfopS1pl0I9O4/J+nUh7RsZndBjrr90oSIKfDvINDVnoRqbN/cKNaGv3Q0
	UZIpOI6U7XXz6McC105pWKGmecr5uk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755188003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HY1Ka0blAbgBSRBSt7UsmlbudX5SHQaBBsmWeXDPrW0=;
	b=fMPQe3MBMVFloEbJao3B95VwXbo9DZIPltasgGnrFSNAQHaYTUWbkJ3Aki6bJjNqxaWqp3
	dudKTll5S6gjgqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E661136AE;
	Thu, 14 Aug 2025 16:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /aljFSMLnmgsHAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Aug 2025 16:13:23 +0000
Date: Thu, 14 Aug 2025 18:13:22 +0200
Message-ID: <87ms81ubj1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: tiwai@suse.de,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: Re: [PATCH v5 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
In-Reply-To: <20250814160538.3269-1-ramiserifpersia@gmail.com>
References: <87qzxduchg.wl-tiwai@suse.de>
	<20250814160538.3269-1-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 909B71F7FE
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
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Thu, 14 Aug 2025 18:05:38 +0200,
Šerif Rami wrote:
> 
> Thanks, I’ll fix the brace placement for scoped_guard() in the next revision.
> If there’s anything else you’d like me to adjust before resubmitting, please let me know.

Other than that (and the point you noticed), I didn't see anything
obvious, so likely I'll merge v6 :)


thanks,

Takashi

