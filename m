Return-Path: <linux-kernel+bounces-754158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD9AB18F1A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9F6189E596
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B652397A4;
	Sat,  2 Aug 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RDbAiEEu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RmFVcowo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RDbAiEEu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RmFVcowo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F57230BD5
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754144354; cv=none; b=lJTLtOXFBDtOcX81wkNF/fotLW5HnrkKZ2ae7XgWjlFIOewLJGuB5gquUSTJpvho+wUkzGeWCDSBeEFcw1PTNqvV+iS659yPAzaNhDwwBElMqxMJoMi5ygLO9rR1Hc1vuqO+eRsU+jAxqSNYjT+/qcBcx0eS/aF6rldIFGxDC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754144354; c=relaxed/simple;
	bh=BQjb71q+zfnm04yFC5weB4fBKVIHZCChEcZ1WWpqUeU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL5hKBhmy2iZ3aezi0bmatL5pY9iBH+MF3F1kF9Wdn8mVtaZCHAR8AnmKhjJe5L0HceEU7YB660MKHoXSRcFHoBE/7jKHkZVf1ESJ7ioAlU4nDdRm5VwxC/QGjqIOqWaIePgd8QBXhDhN8UV4evwsMa0nUnLWH/ldY+8mvonXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RDbAiEEu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RmFVcowo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RDbAiEEu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RmFVcowo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E83521B5A;
	Sat,  2 Aug 2025 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754144344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IG0z51HXDcoIRTR9senNIliQSNaEd9Bk3IsJrBf4kVY=;
	b=RDbAiEEuOV1xpVaGZm7E8UkAFfMHlpUDVh451DsrD/32QDUKwGl2RvvJdLveYK/73n98fx
	HTpx43zGEKktOxEvtoetBe1fvDj42JqdugUv9P8oPgTT5kgzzf6Di0mJ3TtdUtCEn1PLuD
	tdGVnuyTZ7JgnCQg6xlpV0C4e3QfHFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754144344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IG0z51HXDcoIRTR9senNIliQSNaEd9Bk3IsJrBf4kVY=;
	b=RmFVcowo+d2MeFBYcF/hjr5gVO9eSqOUFSJ9L5/sVoLRLvtuHqXDk6TeCkojdYFR8t6p40
	tZRi+WotCr3OCmCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RDbAiEEu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RmFVcowo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754144344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IG0z51HXDcoIRTR9senNIliQSNaEd9Bk3IsJrBf4kVY=;
	b=RDbAiEEuOV1xpVaGZm7E8UkAFfMHlpUDVh451DsrD/32QDUKwGl2RvvJdLveYK/73n98fx
	HTpx43zGEKktOxEvtoetBe1fvDj42JqdugUv9P8oPgTT5kgzzf6Di0mJ3TtdUtCEn1PLuD
	tdGVnuyTZ7JgnCQg6xlpV0C4e3QfHFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754144344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IG0z51HXDcoIRTR9senNIliQSNaEd9Bk3IsJrBf4kVY=;
	b=RmFVcowo+d2MeFBYcF/hjr5gVO9eSqOUFSJ9L5/sVoLRLvtuHqXDk6TeCkojdYFR8t6p40
	tZRi+WotCr3OCmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02850133D1;
	Sat,  2 Aug 2025 14:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qz7eOVcejmhABwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 02 Aug 2025 14:19:03 +0000
Date: Sat, 02 Aug 2025 16:19:03 +0200
Message-ID: <87wm7l24dk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Don't use printk_ratelimit for debug prints
In-Reply-To: <20250801154710.739464-1-sean.anderson@linux.dev>
References: <20250801154710.739464-1-sean.anderson@linux.dev>
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
X-Rspamd-Queue-Id: 2E83521B5A
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
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Fri, 01 Aug 2025 17:47:10 +0200,
Sean Anderson wrote:
> 
> printk_ratelimit is deprecated, since it shares state with all other
> printk sites. Additionally, the suppression message is printed at
> warning level even though the actual messages are printed at debug and
> are (usually) invisible! This can result in thousands of messages like
> 
> retire_capture_urb: 4992 callbacks suppressed
> 
> in the console, and can inhibit debugging since it is unclear what the
> source of the suppressed callbacks is.
> 
> Switch to dev_dbg_ratelimited which doesn't print anything unless debug
> is enabled.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Applied now.  Thanks.


Takashi

