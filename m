Return-Path: <linux-kernel+bounces-794335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E77B3E021
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC0E3AF819
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFB30AACC;
	Mon,  1 Sep 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IpfU/kUv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ARqhzOas";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IpfU/kUv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ARqhzOas"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC119C546
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722473; cv=none; b=SK/oWt/8PGqI3NNdHQAAF1AWyqeIChC6mrJ20FtVe6CSqTL+ZLZU9nCKfnuXQz1IrdQ8gYUntuZQwzbjofni/Np8QRyjEfeV9fLxlFQqfVIwu7GepQdah6/7zCx3OXq52RKFXM0L6XDrP+Viqfk5AgEpo9snebcM+zzZwjhPCkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722473; c=relaxed/simple;
	bh=OnGJAX0dxjoae2UcQ17LGzqcgGFWEw8RupZn86M8kU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot94U5Ga/qDfHe2UzXvwiEmY9yiiWHb5qyq6TEyxFZO1DXTxGqNESNCn09M/av6FtWdSWs1NVxOCTdBJgPgDTPCa7YVLki9rBQFsRsspwM7ZI2qy8/HvuKAyMBa3ZDpZs/jBdYBkIvBAQExBTCvY3SNHYuQ8bImmOFuL+38xUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IpfU/kUv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ARqhzOas; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IpfU/kUv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ARqhzOas; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A871721168;
	Mon,  1 Sep 2025 10:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756722469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOzfdji6Hay6gcG/mjTMJVGEun3YyTmzaRsVI4zhcss=;
	b=IpfU/kUvhSPRlgrPK7wwStdsey2nyseRdIkhwHa16Tmv3fom00OXPdVxCnewLNvbPY95Y9
	EvNuHubIm5xwP934ENNJ+2IlHvyatUfPDQENlnqcxhQHxExx0/nNQ/LIRO3yoIqpM2cRzv
	BouG253QFy+8D8Gff4vnke0pUU8Nxbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756722469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOzfdji6Hay6gcG/mjTMJVGEun3YyTmzaRsVI4zhcss=;
	b=ARqhzOasjwvPhDImt6/uQF5wr1ndTxc9HYDE0NWWwa7Kl05b6+th9BeUu/wECxyWToAudW
	nbFweD/dcFQDZSAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="IpfU/kUv";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ARqhzOas
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756722469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOzfdji6Hay6gcG/mjTMJVGEun3YyTmzaRsVI4zhcss=;
	b=IpfU/kUvhSPRlgrPK7wwStdsey2nyseRdIkhwHa16Tmv3fom00OXPdVxCnewLNvbPY95Y9
	EvNuHubIm5xwP934ENNJ+2IlHvyatUfPDQENlnqcxhQHxExx0/nNQ/LIRO3yoIqpM2cRzv
	BouG253QFy+8D8Gff4vnke0pUU8Nxbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756722469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOzfdji6Hay6gcG/mjTMJVGEun3YyTmzaRsVI4zhcss=;
	b=ARqhzOasjwvPhDImt6/uQF5wr1ndTxc9HYDE0NWWwa7Kl05b6+th9BeUu/wECxyWToAudW
	nbFweD/dcFQDZSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B977136ED;
	Mon,  1 Sep 2025 10:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id baiDOiR1tWjcAQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 01 Sep 2025 10:27:48 +0000
Date: Mon, 1 Sep 2025 11:27:47 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] tools/include: Implement a couple of atomic_t ops
Message-ID: <tnbyxwmcwia3teewhqlpdjk7igsljfqcqbze2rbalzidccfndy@e3ybvfap4pbd>
References: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
 <20250828-b4-vma-no-atomic-h-v2-1-02d146a58ed2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-b4-vma-no-atomic-h-v2-1-02d146a58ed2@google.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A871721168
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu, Aug 28, 2025 at 12:27:58PM +0000, Brendan Jackman wrote:
> The VMA tests need an operation equivalent to
> atomic_inc_unless_negative() to implement a fake mapping_map_writable().
> Adding it will enable them to switch to the shared atomic headers and
> simplify that fake implementation.
> 
> In order to add that, also add atomic_try_cmpxchg() which can be used to
> implement it. This is copied from Documentation/atomic_t.txt. Then,
> implement atomic_inc_unless_negative() itself based on the
> raw_atomic_dec_unless_positive() in
> include/linux/atomic/atomic-arch-fallback.h.
> 
> There's no present need for a highly-optimised version of this (nor any
> reason to think this implementation is sub-optimal on x86) so just
> implement this with generic C, no x86-specifics.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

LGTM, thanks!

-- 
Pedro

