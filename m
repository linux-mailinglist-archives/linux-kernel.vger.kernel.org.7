Return-Path: <linux-kernel+bounces-880075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE39C24CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500684222A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AA1346790;
	Fri, 31 Oct 2025 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bKMpKse9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pMPA5Dlg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T9FCT3e7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Om+i6Ho"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA91336EDE
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910597; cv=none; b=i+/40TsKMHhKPESSEzAx+cFr8MzvfRtWaomHh4Uzp8B3UJ+NMb8fMuPSbTRlqqJUj5+shfg+93lx5/avw2PJOOgJ3dh88FNgY85hXCvRNVSnDqY0LZGXT3/L8Mw0ypL3RXtmrM8XibVcIrCcUhiHAnHHkIh1dWtOoJ9Q0JUOUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910597; c=relaxed/simple;
	bh=6bc3P7DrsiF+cW+oH2mucW+V/iWFZK7LGVXCCfAzVmo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOK2UDxLYNL8BJi5F6rpXjUBWzj/zPoUhVrJnbWhPd/4EDFNrffLHUd4kK29oV0tBrmW6lNMDzeSnNX6O8pMWfMrop+6fnkWm74Y0sS9MuL46bynyU5o1qg9rpFnV9JgwCVF4Ur5lcRADcqksIq8Ejw5i9AO3Z/CzNJEX5Bo34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bKMpKse9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pMPA5Dlg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T9FCT3e7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Om+i6Ho; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B84FD21F4C;
	Fri, 31 Oct 2025 11:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761910594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=szMEw9D3/QE6hoGf/A51E4/DXuZVNHTUsNxlNfYmzRk=;
	b=bKMpKse9mSp30qw2z6IuoRcgXheoitD7teFGtp04PUeiIOj4SKYfjLHcAZFJOWuoJLSMCE
	4W7Q5lkAKdz62dF1qKhGa94F/d+r6P1LAREgFnW08h8c4YjgQd/cUlNd6AQaEZmrDQAhwt
	aHWemRJggqjqwCjfPJCHG8r7dugcOHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761910594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=szMEw9D3/QE6hoGf/A51E4/DXuZVNHTUsNxlNfYmzRk=;
	b=pMPA5DlgdmFs5jfzfT0l/vO7DN4xOjHuqiMeTnJWySc92KVoigKukuvJNsmDhZfCNh4gcu
	53xON9GPOsAxeHBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T9FCT3e7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2Om+i6Ho
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761910593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=szMEw9D3/QE6hoGf/A51E4/DXuZVNHTUsNxlNfYmzRk=;
	b=T9FCT3e7vj/n2kAEHY6Mb7TwsyTrD5m08VYbm6JXlw+DwA3izoBAh1v7vheBDetwYHxAln
	1B4Mv8bx409vYp2O2vmmR/QhXsPkxALE4oRUN2kQXH+hyoWqlbh9GJReMi0AIZcEaJSMsZ
	5Mlfzh2zITPPEg1k5D6XqoK9WIBTOX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761910593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=szMEw9D3/QE6hoGf/A51E4/DXuZVNHTUsNxlNfYmzRk=;
	b=2Om+i6HoQ8sdEu0gplZM7qkxQxwn67/tMgV5/Y7VGvyIU2oe+LUjHiPZw1ryhIUO5FYZDT
	GPM13AkZAuhy3HAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6377C13991;
	Fri, 31 Oct 2025 11:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id udMsFkGfBGnuWAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 31 Oct 2025 11:36:33 +0000
Date: Fri, 31 Oct 2025 12:36:32 +0100
Message-ID: <87ldkrjoan.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org,	Jun Zhan
 <zhanjun@uniontech.com>,	=?GB2312?B?xPSzzw==?= <niecheng1@uniontech.com>,
	Guan Wentao <guanwentao@uniontech.com>,	Feng Yuan <fengyuan@uniontech.com>,
	kernel <kernel@uniontech.com>,	Cryolitia PukNgae <cryolitia@uniontech.com>
Subject: Re: [RFC] sound: add uevent notifications for jack events
In-Reply-To: <c6a869fc-8b4a-4311-b14e-28a131d6a706@linux.dev>
References: <c6a869fc-8b4a-4311-b14e-28a131d6a706@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: B84FD21F4C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Wed, 29 Oct 2025 09:11:56 +0100,
Cryolitia PukNgae wrote:
> 
> I propose adding uevent notifications for all audio jack events in the
> sound subsystem, including headphone and microphone jacks.
> 
> The kernel already sends uevents for certain jack types like HDMI,
> demonstrating this pattern is well-established. However, other common
> audio jacks like headphones and microphones only generate input events,
> not uevents.
> 
> This inconsistency affects userspace tools that rely on uevents for
> device management. Adding uevents for all jack types would provide a
> uniform interface for monitoring audio connection state changes.
> 
> My proposal is straightforward: extend the existing uevent mechanism to
> cover all audio jack plug/unplug events in the sound subsystem. This
> change would maintain backward compatibility with existing input event
> consumers while providing consistent device notification for all jack
> types.
> 
> The change aligns with the semantic purpose of uvents - to notify about
> hardware state changes. Physical connection events naturally fit this
> category.
> 
> If there are objections or historical context I should consider, I would
> appreciate hearing them.
> 
> Thanks.
> 
> Best regards,
> Cryolitia PukNgae

Honestly speaking, I have a mixed feeling for this approach.
I understand that uevents can be used for handling commonly for all
jack events, but OTOH, it means that we may spam a lot there.

FWIW, as generic jack event handling, there is the notification via
ALSA control API for each sound card, not only the input devices,
too.  If any, we may add yet another notifications on top of that with
uevents; but this must not be enabled blindly.


thanks,

Takashi

