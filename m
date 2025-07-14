Return-Path: <linux-kernel+bounces-729988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C79B03EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF07188BF38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F035248867;
	Mon, 14 Jul 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vvq/Cvp1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Si+git4y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d94XsAfo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fd3uENEz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A5217F55
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496286; cv=none; b=YwBmcUm3IOBwmy5DgOwC+YDva0ZZ3oAH6Ol/EO7nOfERifkaGgmORyRoPhvmxQBDowPrZbvGoOaEpOsDu1DQ7VOxd7XMOmEQaSMRHJwAFs7U72/p6AJOjlFEZAAvYjGct9Q1mY+sQ7pOY/6HhbvrafISNUkPZVozzdZ0/0TZAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496286; c=relaxed/simple;
	bh=XRSmX4VLJR+0m9mGhIUApkrhXKLLzGJVetsEWb9JH8g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjIOLPYG/kVgF+VNGNKGQJU8wdsa1H7WFMY4ssqFgDo3uug1Jcb8mzaoCmGQiu7963gJGdmAhpEu+Yon/QjjB8sNB36U7HorszqMtQ886yMDi+uTrKrjajc8arOhsEUDNsShQvOpWgKhYSp5hpqPfUEk8z0lxMV5zMdyIF/UhOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vvq/Cvp1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Si+git4y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d94XsAfo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fd3uENEz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FB121F38D;
	Mon, 14 Jul 2025 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752496281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Y5AV10NlnRjD1lOwQsBUOV58WIv1DyM1EzoZg6Z/FQ=;
	b=Vvq/Cvp1j8xmiwtjSAG9BjywwTQuHSDVo0J0uvdQpjiBNyyF9jqJhN4LaFZBXifqtH6Hjq
	Wlj/8ZEx36R3pi5hM7lUuZm4pKaYfNxEz/jyAILwE5DQWpg4/vwZZLfEISaump3NsM0TNM
	x0rMUitR/R0U6V/fUT2Ubqzb4MZLz/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752496281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Y5AV10NlnRjD1lOwQsBUOV58WIv1DyM1EzoZg6Z/FQ=;
	b=Si+git4yQgVtA7UnglxQUsGUvxHizC9aLjnuN24uIS7D7OyX/0xAeWGVkjpt6H4h2yWAw+
	d+uwp2l/pI0sc1CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d94XsAfo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fd3uENEz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752496279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Y5AV10NlnRjD1lOwQsBUOV58WIv1DyM1EzoZg6Z/FQ=;
	b=d94XsAfojxqBigP48ndV44UdhnYFTY3BPWhEzmd8pqoqom/UzdCA3F8xzXwjEf5jopXAYi
	Jw+/LFG8GdU1LDvvIla/FwOxdS3OiWd0FCOSCkQebksMb43Pa0trrPbv3GW+63PBi4i6kO
	vo3e2EECTeYCrId+a5SAYLVGH1zPhIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752496279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Y5AV10NlnRjD1lOwQsBUOV58WIv1DyM1EzoZg6Z/FQ=;
	b=fd3uENEzThuHUmIN72rCujUkxxY6iMZ0006QqwhxttnaWbCG/DivaN2i9o5J/2WkMcz9zc
	/07JtV9ki0JwdABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD0FE13306;
	Mon, 14 Jul 2025 12:31:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id njusMJb4dGgtewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 14 Jul 2025 12:31:18 +0000
Date: Mon, 14 Jul 2025 14:31:18 +0200
Message-ID: <877c0b7y3t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] ALSA: hda/cs35l56: Workaround bad dev-index on Lenovo Yoga Book 9i GenX
In-Reply-To: <20250714110154.204740-1-rf@opensource.cirrus.com>
References: <20250714110154.204740-1-rf@opensource.cirrus.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,cirrus.com:email,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0FB121F38D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Mon, 14 Jul 2025 13:01:54 +0200,
Richard Fitzgerald wrote:
> 
> The Lenovo Yoga Book 9i GenX has the wrong values in the cirrus,dev-index
> _DSD property. Add a fixup for this model to ignore the property and
> hardcode the index from the I2C bus address.
> 
> The error in the cirrus,dev-index property would prevent the second amp
> instance from probing. The component binding would never see all the
> required instances and so there would not be a binding between
> patch_realtek.c and the cs35l56 driver.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reported-by: Brian Howard <blhoward2@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220228
> ---
> This patch is based on 6.16. I have tested that it also applies on the new
> HDA structure using a 3-way merge.

It's a bit bigger than wished for rc7, but the fix itself looks rather
simple, so I took for 6.16-rc7 now.


thanks,

Takashi

