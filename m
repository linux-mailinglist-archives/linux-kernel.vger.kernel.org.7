Return-Path: <linux-kernel+bounces-725156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C71AFFB70
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0587B0603
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F728B4FA;
	Thu, 10 Jul 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UlSBw/v2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LXJxHKgt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UlSBw/v2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LXJxHKgt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE74C28983E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134178; cv=none; b=NCLyhUsBluUagxpbgesLIaA7lusC5JlAt1QyJcHyvMmKXMH9Dc94UUwTJvj+vkIWFPxuhoVJ8w78VXxFQcWT7P1D8CagqYmHKeUgPSY5X5RVEnH88fZdjx9vO975bKzniRGwih/sDipIAq2c5Hcwx9PDz/nEaRdmZgx7lOqqlsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134178; c=relaxed/simple;
	bh=rCy+vLYLMIZ853U4WOUwEK0MVf3ZWJvvDLZ+5qPWbek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2+0x79rS6j8mroWKDb7OVYOwv2bpGAj9CyBPyF/yZ032GF7GurxEfCxPQXR5ANbIiXzs9dd4HCocjar13lwOsMFZushiblWwour/RIOHza+z6jY+d1OzVdkDdVAt19HkfSznhF3TZufJfEqTKKtHSzoK0ayla8hwPrvcaVsCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UlSBw/v2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LXJxHKgt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UlSBw/v2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LXJxHKgt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80B0E21164;
	Thu, 10 Jul 2025 07:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752134174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soczQF42Fe2kavIG+s9yiq1xrLUBCGtgKG1Ot1oYmXE=;
	b=UlSBw/v252otnM56csjWgaV9Rj85CdJI2WZ68i2ToakkKNMuuj4BUHyrDqOYBP0Yg9fC2s
	MPrul+tbasxa/GBbze26CzjqyBGa61uZ7iJD5Stui6rX9EdhWwRIiMVJC+n/k4+IB8eJyX
	UQeczDm0tSPL/wqjAAudiOT+TDLGTH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752134174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soczQF42Fe2kavIG+s9yiq1xrLUBCGtgKG1Ot1oYmXE=;
	b=LXJxHKgt5tzjq1cZEtxb1MWkDYWJupv6wNizye+Kh14CyRRRahsD+gMDBsoFlcdCi64YwO
	d+HAQju7Wv4ULlAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="UlSBw/v2";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LXJxHKgt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752134174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soczQF42Fe2kavIG+s9yiq1xrLUBCGtgKG1Ot1oYmXE=;
	b=UlSBw/v252otnM56csjWgaV9Rj85CdJI2WZ68i2ToakkKNMuuj4BUHyrDqOYBP0Yg9fC2s
	MPrul+tbasxa/GBbze26CzjqyBGa61uZ7iJD5Stui6rX9EdhWwRIiMVJC+n/k4+IB8eJyX
	UQeczDm0tSPL/wqjAAudiOT+TDLGTH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752134174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soczQF42Fe2kavIG+s9yiq1xrLUBCGtgKG1Ot1oYmXE=;
	b=LXJxHKgt5tzjq1cZEtxb1MWkDYWJupv6wNizye+Kh14CyRRRahsD+gMDBsoFlcdCi64YwO
	d+HAQju7Wv4ULlAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAF18136CB;
	Thu, 10 Jul 2025 07:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fi4lNh1yb2gmLAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 10 Jul 2025 07:56:13 +0000
Date: Thu, 10 Jul 2025 08:56:11 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Xuanye Liu <liuqiye2025@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: simplify min_brk handling in brk()
Message-ID: <jnhrylra2u4wf2tyo6zuu5v6ngz6xvhgtpwvxti7erako7oufc@cr4szidnh4yp>
References: <20250710025859.926355-1-liuqiye2025@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710025859.926355-1-liuqiye2025@163.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 80B0E21164
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

On Thu, Jul 10, 2025 at 10:58:58AM +0800, Xuanye Liu wrote:
> Set min_brk to mm->start_brk by default, and override it with
> mm->end_data only when CONFIG_COMPAT_BRK is enabled and
> brk_randomized is false.
> 
> This makes the logic clearer with no functional change.
> 
> Signed-off-by: Xuanye Liu <liuqiye2025@163.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Small little simplification, looks good, thanks!

-- 
Pedro

