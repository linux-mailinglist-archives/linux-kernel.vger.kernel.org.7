Return-Path: <linux-kernel+bounces-851873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4519ABD77FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DDF40402A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15C2BE7B1;
	Tue, 14 Oct 2025 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R0E+Cf9A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AhxK+pVr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R0E+Cf9A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AhxK+pVr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3657221FCB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421227; cv=none; b=ow/VkhQ7Kwk8Wx3MGswxwnSCJxoXxjNU0YB40p8EcXRD3l+/GUepFsncwJhqB/ZUjG1RK/JnoriQqzwd6gMiLMcab4l210jlA8Lfo7+wq+vP1crnUnj7xt0CfLxF33Qy5EaXfQ4hwI1o80huM3jdw/8xhEBc/hxbRIDsTZ806Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421227; c=relaxed/simple;
	bh=XHx1MIp0y8MtCK2xU6VtPEz/8ULYtO+sr3Ur3vSAbNE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u67MaAg2wAIjuXBIqhz2z49YImO+2brth0eUDsQnxVTQJTJxi4XQ3e8KnvuWXe/5d5lrwiL+IZ70L/N5rzvInNbghOXsyJv4rSm99LwFxwnOth6247/64QqNg0Rg2GyJ4NlUcggVYlywJ12dCt1a8VknUXtnZwpEWo/kzK943Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R0E+Cf9A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AhxK+pVr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R0E+Cf9A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AhxK+pVr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5407F1F74C;
	Tue, 14 Oct 2025 05:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760421214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvLoKULPX2FQHcB605LWH8Pa4QC+lLB7zqDLvuxGH0I=;
	b=R0E+Cf9ApMMWDYJtCqGjAeiGf4EK3Jo6q0uiqbj8s5enDUYYgJdDwh3gzuAyUpyADtQeZR
	ebHt9w+scbH+stRb+zUrZIFw4Ss/Z0mNY82iM/oLKVchXpkwEMJtHBy+u33k5oHHRWy7gC
	iowwjktmdxH0tQOgpxaQ4SKqDXBd+8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760421214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvLoKULPX2FQHcB605LWH8Pa4QC+lLB7zqDLvuxGH0I=;
	b=AhxK+pVr1UPT9KxqmJBIJ+TxK1PtLbdTKr/5MDRbwrkUVQ3ju/3y7sAtFom/rG/5smNKOb
	HU0QCU7wUapP0WBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R0E+Cf9A;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AhxK+pVr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760421214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvLoKULPX2FQHcB605LWH8Pa4QC+lLB7zqDLvuxGH0I=;
	b=R0E+Cf9ApMMWDYJtCqGjAeiGf4EK3Jo6q0uiqbj8s5enDUYYgJdDwh3gzuAyUpyADtQeZR
	ebHt9w+scbH+stRb+zUrZIFw4Ss/Z0mNY82iM/oLKVchXpkwEMJtHBy+u33k5oHHRWy7gC
	iowwjktmdxH0tQOgpxaQ4SKqDXBd+8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760421214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvLoKULPX2FQHcB605LWH8Pa4QC+lLB7zqDLvuxGH0I=;
	b=AhxK+pVr1UPT9KxqmJBIJ+TxK1PtLbdTKr/5MDRbwrkUVQ3ju/3y7sAtFom/rG/5smNKOb
	HU0QCU7wUapP0WBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07A6713675;
	Tue, 14 Oct 2025 05:53:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hJ+BAF7l7WhIegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 14 Oct 2025 05:53:34 +0000
Date: Tue, 14 Oct 2025 07:53:33 +0200
Message-ID: <877bwy81wi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	broonie@kernel.org,
	cryolitia@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	pierre-louis.bossart@linux.dev,
	quic_wcheng@quicinc.com,
	syzkaller@googlegroups.com,
	tiwai@suse.com
Subject: Re: [PATCH] ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card
In-Reply-To: <2025101453-backboned-shine-17b8@gregkh>
References: <2025101225-lisp-monkhood-af34@gregkh>
	<20251014040149.1031348-1-r772577952@gmail.com>
	<2025101453-backboned-shine-17b8@gregkh>
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
X-Rspamd-Queue-Id: 5407F1F74C
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Tue, 14 Oct 2025 07:26:41 +0200,
Greg KH wrote:
> 
> On Tue, Oct 14, 2025 at 12:01:49PM +0800, Jiaming Zhang wrote:
> > Hi Greg,
> > 
> > Thanks for the guidance. You're right, the root cause of this issue is
> > that a USB audio device is created without a proper interface.
> > 
> > To fix this issue, I added a check for the NULL return value in
> > try_to_register_card() before calling usb_interface_claimed().
> > I have tested patch with the reproducer on the latest version (v6.18-rc1),
> > the issue was not triggered again.
> > 
> > Please let me know if any changes are needed.
> > 
> > Best regards,
> > Jiaming Zhang
> 
> Can you resend this without this text above the changelog comment?
> 
> > ---
> > 
> > In try_to_register_card(), the return value of usb_ifnum_to_if() is
> > passed directly to usb_interface_claimed() without a NULL check, which
> > will lead to a NULL pointer dereference when creating an invalid
> > USB audio device. Fix this by adding a check to ensure the interface
> > pointer is valid before passing it to usb_interface_claimed().
> > 
> > Reported-by: Jiaming Zhang <r772577952@gmail.com>
> > Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> 
> And as you authored this, no need for "Reported-by:" :)

Also try to point to a breaker commit via Fixes tag.
And, pointing to the bug report thread via Closes tag would be nicer,
too.

The code change itself looks good, so only those cosmetic things.


thanks,

Takashi

