Return-Path: <linux-kernel+bounces-752296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCBB173A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7005A8310F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8541DDC15;
	Thu, 31 Jul 2025 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="obvIInBR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uG0wPfh9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t6N4CZeK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mUAfWiPs"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1401D7E54
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974078; cv=none; b=Mf16h2EMMN2y6lju28jdpgiLklpkV/ldRMVohUmTTMzWqfm9i0D/cGWASj1hM5La2+6fb8bZhCiv/k+WppzSDboqUk6zG47H6wIUvkyE9GQI4Za1DPwk8gclP/p56UxjPMtuEvGdqu4fqCO6jGSnNid8pVKPUi/HdruYqH1nlN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974078; c=relaxed/simple;
	bh=tX0sLmZ4usnOl0vNommFRZXu6h5rRawTfuBmrTDBT3A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpSATsbuqd/WgUvCyZFpq2wD0qpyvz955BI0/KiXsHe8s2T3PTTqwdtbbaEQJXQbQmoKi0nZyV3CuoU93CrbzEfHKU980IpR1lcP88WFyJEby7ER7b8u8UKKXh1qOc6hyI/DMBu0c2j9gMdJJ4xfDLd5I3j8/KZUM80wOplUyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=obvIInBR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uG0wPfh9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t6N4CZeK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mUAfWiPs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B5DE21B1F;
	Thu, 31 Jul 2025 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753974071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmhA9IC2ENmhsJp5JcAl0jJa35akCc0R8z+TgcMb6oY=;
	b=obvIInBRkLngks1+lEPKK6tcqFQMbmt/isOteDxTsgUu/yzrjvH+FbLzbtPSaNhRCAP7aI
	am6zqndEXyOyOabw4i4mPI1nOB80o/ddWvEuf176AZ9jaMvWv8VdKLl6Df1fhnavzf0m0Y
	JbR5rN1PEfNIEsW/lT5R2FyPmESqook=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753974071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmhA9IC2ENmhsJp5JcAl0jJa35akCc0R8z+TgcMb6oY=;
	b=uG0wPfh9O/M0FhgV3ogl9Tzn98tbIVzyo2pivgqT58OF5XPMQA5NDEu9aQ1eQIZ7ZIrdH5
	uMyvnsnYuT+FcaBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t6N4CZeK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mUAfWiPs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753974066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmhA9IC2ENmhsJp5JcAl0jJa35akCc0R8z+TgcMb6oY=;
	b=t6N4CZeKLkwRdJcyvy3K+9dBopfyb/51bs3HIRfahWpKwxdlVSBIAWvCQKZBecak+N+w+o
	uLDI5N4ilMMffa+d3nFe7gLUhuxrdJqXhk3grI63WZtkwt+9YOP7+VBaudSYGgltlJ8B25
	aVx6Nd6xNk1DbH05h2sna9Cg+FFsRPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753974066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmhA9IC2ENmhsJp5JcAl0jJa35akCc0R8z+TgcMb6oY=;
	b=mUAfWiPslKRnTd3CoMRNjeDyIz/yLdepkmZqSNRZLvhycbJHdJBvC0RJw//DZh9Gbbbzex
	H6e7ZWLP4ZP0ffBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E758113876;
	Thu, 31 Jul 2025 15:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NJtENzGFi2gnDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 15:01:05 +0000
Date: Thu, 31 Jul 2025 17:01:05 +0200
Message-ID: <87h5ysqua6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: noble228@gmail.com
Cc: tiwai@suse.com,
	perex@perex.cz,
	hulianqin@vivo.com,
	lina+kernel@asahilina.net,
	cyan.vtb@gmail.com,
	dan.carpenter@linaro.org,
	bsevens@google.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"noble.yang" <noble.yang@comtrue-inc.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add DSD support for Comtrue USB Audio device
In-Reply-To: <20250731110614.4070-1-noble228@gmail.com>
References: <20250731110614.4070-1-noble228@gmail.com>
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
X-Rspamd-Queue-Id: 3B5DE21B1F
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,vivo.com,asahilina.net,gmail.com,linaro.org,google.com,vger.kernel.org,comtrue-inc.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[kernel];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[comtrue-inc.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Score: -2.01

On Thu, 31 Jul 2025 13:06:14 +0200,
noble228@gmail.com wrote:
> 
> From: "noble.yang" <noble.yang@comtrue-inc.com>
> 
> The vendor Comtrue Inc. (0x2fc6) produces USB audio chipsets like
> the CT7601 which are capable of Native DSD playback.
> 
> This patch adds QUIRK_FLAG_DSD_RAW for Comtrue (VID 0x2fc6), which enables
> native DSD playback (DSD_U32_LE) on their USB Audio device. This has been
> verified under Ubuntu 25.04 with JRiver.
> 
> 
> Signed-off-by: noble.yang <noble.yang@comtrue-inc.com>

Thanks, applied now.

There were still a bit of white-space issues and I fixed in my side.
At the next time, please try to run scripts/checkpatch.pl before
submission.


Takashi

