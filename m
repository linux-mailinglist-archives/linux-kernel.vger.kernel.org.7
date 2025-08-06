Return-Path: <linux-kernel+bounces-757607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A49CB1C421
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070D83BE1FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9C928A40E;
	Wed,  6 Aug 2025 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N2US6QeO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GirxieAD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N2US6QeO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GirxieAD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745D23FC4C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475685; cv=none; b=WacXVJ2Az1kXiwraMuZvoIW/kqyNDCC2iycxMItEB6zBBcqo0HMqSZTDb8mrGUY2yxpoyp+Ox0imcZF8gtdAhqGUBdfWDRFiauAq6z2l6XwP7uMzsCIkELK2hOHT7vJD/Gzfry2IT0ZU8h5/zFuxI53FZu2GORehXt/Qq0UQ1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475685; c=relaxed/simple;
	bh=2k3tFWhPgWmX5vmTPvh2RAqMQA/HOYPPQn06ovSTjmw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHXaqjrUOKR8C2JRYJ805WwgJOxaJlSx0er9Czc4Gvf0W3uA+bPStc9E0cFiW5r4BzixjHMzaWNGM2SVv4ZstwCPcZuRR+gmOMNNmR9lbTV9UketaMDl0iZ2HaLXM4rzVCMGUxDOZRXrbDMgBWUJ5Ep55r7p8dhYYRpuskS3vyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N2US6QeO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GirxieAD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N2US6QeO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GirxieAD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 874121F394;
	Wed,  6 Aug 2025 10:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754475681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOV0rA2Iv5+dUBBYGYW0OY3eKblC/GDoc2anJGe8tLw=;
	b=N2US6QeO11mUYBHcKpaZYAP2kOL7r0KRWEbJLOtBYmzEj4g+Q2usUS/hEhYHSgpgkRN7cb
	hPwoMlMozU+n45BLgHhJ/qrCkprJy6AwZP8WGCACCf5WeL4SvyppNQzWtw0EtuU2jZP9EL
	WgZeZiAsbzO/1RLMw97x5OqK5MKBkW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754475681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOV0rA2Iv5+dUBBYGYW0OY3eKblC/GDoc2anJGe8tLw=;
	b=GirxieAD9VuQYJH3xRJB7ZvzYKw7RGb8T2Y8hS1FIv5s5heOKB2U5INtRhuDDFny+QWIAl
	2ZLi7k1fxCO6IIBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754475681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOV0rA2Iv5+dUBBYGYW0OY3eKblC/GDoc2anJGe8tLw=;
	b=N2US6QeO11mUYBHcKpaZYAP2kOL7r0KRWEbJLOtBYmzEj4g+Q2usUS/hEhYHSgpgkRN7cb
	hPwoMlMozU+n45BLgHhJ/qrCkprJy6AwZP8WGCACCf5WeL4SvyppNQzWtw0EtuU2jZP9EL
	WgZeZiAsbzO/1RLMw97x5OqK5MKBkW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754475681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOV0rA2Iv5+dUBBYGYW0OY3eKblC/GDoc2anJGe8tLw=;
	b=GirxieAD9VuQYJH3xRJB7ZvzYKw7RGb8T2Y8hS1FIv5s5heOKB2U5INtRhuDDFny+QWIAl
	2ZLi7k1fxCO6IIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10F2213AFB;
	Wed,  6 Aug 2025 10:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U3y/AKEsk2jIMAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 06 Aug 2025 10:21:21 +0000
Date: Wed, 6 Aug 2025 11:21:19 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] testing/radix-tree/maple: Hack around kfree_rcu not
 existing
Message-ID: <diytmqqhv2wd5guvbzuauenr4ucpttlqrcmffecqkdchjyi5bl@x57r6ypqysuw>
References: <20250718172138.103116-1-pfalcato@suse.de>
 <20250718172138.103116-2-pfalcato@suse.de>
 <32irwh2uqdg56jrx7mkbcfltu5t4im6l4j44mtq7ylnebtfpt4@te3sbbfuws5q>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32irwh2uqdg56jrx7mkbcfltu5t4im6l4j44mtq7ylnebtfpt4@te3sbbfuws5q>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue, Aug 05, 2025 at 09:26:47PM -0400, Liam R. Howlett wrote:
> * Pedro Falcato <pfalcato@suse.de> [250718 13:21]:
> > liburcu doesn't have kfree_rcu (or anything similar). Despite that, we
> > can hack around it in a trivial fashion, by adding a wrapper.
> > 
> > This wrapper only works for maple_nodes, and not anything else (due to
> > us not being able to know rcu_head offsets in any way), and thus we take
> > advantage of the type checking to avoid future silent breakage.
> > 
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> Thanks, but shouldn't this be patch 1 so that the testing continues to
> work?

Yeah, that makes sense, I'll re-order these two on a possible v2.

-- 
Pedro

