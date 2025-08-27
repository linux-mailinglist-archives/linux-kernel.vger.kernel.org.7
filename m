Return-Path: <linux-kernel+bounces-788333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8A6B3830A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9941BA3892
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A329134F47D;
	Wed, 27 Aug 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UsQ+LUKR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="673aaeOv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UsQ+LUKR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="673aaeOv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F05214228
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299412; cv=none; b=YfVSUZwSL+441LQ/n426oRtHELl9nIFW3nXKCh/C+tGsopLl28rNtuizKvvpU+b7xZRrD/KSY3c5xgQnF0wpL3o3mgmwHIUs7nvswmGuradDQphUljwo/9bKna+W0Kz6M7Vvy+E09cLBLj0pRXqhADTCyXC4F3dlsqLwHgm5qEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299412; c=relaxed/simple;
	bh=AJqTS2TQaf11/ATxHid9c7Rht5MvfqKcy3tb2Dd7WiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFESz04OHv4f66BzDqk6ZA793hrcOwkUSD10flxO1CfZK0CPCyQWgL+HdBvD8/nKIaOsb7vPvPdyngUUBpJ62hcYlPaKsUZObfujJ79LUdoYlqGhRCiuE6qF+1w3/3zT5NjFEs/c7xiXnzhAlg7rbMWUF6ZhqSqgTinODXeVY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UsQ+LUKR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=673aaeOv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UsQ+LUKR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=673aaeOv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 648FB201DA;
	Wed, 27 Aug 2025 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756299406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aq7wpdiF4pl/TGxZNEC5pqur7Xst8wsCEhYLoncfMXw=;
	b=UsQ+LUKRKwyy8Ys3/+6fym05z9/crxCzboVbu0XIo3r5sywbl9OViz552Fp6zjKhgzroSC
	JHTlJEnBiqi0uzdcyIGpUwlTKsD0ZRzR7rNwkBhHEOl3HBN3/DXnIeydNJJbykt/H+vC6e
	lq3APQxK7Cmb4l6OLPDoZ9tUzhD8GOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756299406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aq7wpdiF4pl/TGxZNEC5pqur7Xst8wsCEhYLoncfMXw=;
	b=673aaeOv/+DLVfJCzQAvWk1+3jdWxqGW7VJUe3XwsPT+qbQ1p8UwvtR2LEa3SxVtQxSVYA
	PjjxpTu7HqZWu/AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UsQ+LUKR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=673aaeOv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756299406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aq7wpdiF4pl/TGxZNEC5pqur7Xst8wsCEhYLoncfMXw=;
	b=UsQ+LUKRKwyy8Ys3/+6fym05z9/crxCzboVbu0XIo3r5sywbl9OViz552Fp6zjKhgzroSC
	JHTlJEnBiqi0uzdcyIGpUwlTKsD0ZRzR7rNwkBhHEOl3HBN3/DXnIeydNJJbykt/H+vC6e
	lq3APQxK7Cmb4l6OLPDoZ9tUzhD8GOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756299406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aq7wpdiF4pl/TGxZNEC5pqur7Xst8wsCEhYLoncfMXw=;
	b=673aaeOv/+DLVfJCzQAvWk1+3jdWxqGW7VJUe3XwsPT+qbQ1p8UwvtR2LEa3SxVtQxSVYA
	PjjxpTu7HqZWu/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C352313867;
	Wed, 27 Aug 2025 12:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xmqFLI0Ar2jZWwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 27 Aug 2025 12:56:45 +0000
Date: Wed, 27 Aug 2025 13:56:49 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] tools: testing: Use existing atomic.h for
 vma/radix-tree tests
Message-ID: <xz2m4q24kgig36wu3enk6qlsxo5xywsaffgivyubadsps5topi@6yupqs7b7cze>
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
 <20250827-b4-vma-no-atomic-h-v1-2-5d3a94ae670f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-b4-vma-no-atomic-h-v1-2-5d3a94ae670f@google.com>
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 648FB201DA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed, Aug 27, 2025 at 11:04:42AM +0000, Brendan Jackman wrote:
> The shared userspace logic used for unit-testing radix-tree and VMA code
> currently has its own replacements for atomics helpers. This is not
> needed as the necessary APIs already have userspace implementations in
> the tools tree. Switching over to that allows deleting a bit of code.
> 
> Note that the implementation is different; while the version being
> deleted here is implemented using liburcu, the existing version in tools
> uses either x86 asm or compiler builtins. It's assumed that both are
> equally likely to be correct.
> 
> The tools tree's version of atomic_t is a struct type while the version
> being deleted was just a typedef of an integer. This means it's no
> longer valid to call __sync_bool_compare_and_swap() directly on it. One
> option would be to just peek into the struct and call it on the field,
> but it seems a little cleaner to just use the corresponding atomic.h
> API. On non-x86 archs this is implemented using
> __sync_val_compare_and_swap(). It's not clear why the old version uses
> the bool variant instead of the generic "val" one, for now it's assumed
> that this was a mistake.
>

I don't think it's a mistake. Namely we're checking if the cmpxchg occured.
So in the new version you'll have trouble incrementing i_mmap_writeable from
0 to 1, where in practice you should (AIUI) see 0 -> 1 (old val = 0, retry) -> 2,
which is obviously not correct here.

At the very least you'll need some:

do {
} while(atomic_cmpxchg(&mapping->i_mmap_writeable, c, c+1) != c);

to keep the same semantics.

-- 
Pedro

