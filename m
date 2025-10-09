Return-Path: <linux-kernel+bounces-846415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4ADBC7F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 948164FE4E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD4A2BEC31;
	Thu,  9 Oct 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lT3BcE/3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uhJSxLdk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lT3BcE/3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uhJSxLdk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332771B4F1F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997271; cv=none; b=gKoWelYN0a734zE4C+RU3edHv/3IOP2V5JE7pL0E6U/bdnSVA5p/bDe0VVXX7kQ7CZbeixdHZ4/fLT9Bv71coG8dy2k1uAE0o5fefONBOT0K4ryfofZRtPN11Ei5JxoNhHpeJqZttDDcn1MahKqkV/C4e/4tfbScx7QT7N3HgrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997271; c=relaxed/simple;
	bh=4W3fMl5l3jcHrj0ggcJQMaLz1dS2cx4Ut1OZNPYE8IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5MWWtndd2oz3eRKJh+84MuKKT62lvb3Ym1EjiET0mzdU+TGXGMIUgzfPg9JDN2tNwHjxvKmlXWbr3B6oX6yL38ClbTU1CQVBAgxcksRFUkBSNiM6yN71S2WnNzWzH0s4nlCgf+0TFJyDJB4XQMLi5oKxhNJZxe0TO5ZIZHyWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lT3BcE/3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uhJSxLdk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lT3BcE/3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uhJSxLdk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 59C20224C6;
	Thu,  9 Oct 2025 08:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759997267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=840BVvk4h/vQ3iIDPplNBop5pm8dJACDtuDls2QAuzo=;
	b=lT3BcE/3xLnQc9f2v2Q3k1PaokeHfbIitmRaSGJFjpMBc+Gi3AhKPqgCIh+KbCM/k5CDgD
	0g+hXMyScNWMF5W2sKtxiI++tsS+wb4Bmj9LPmoBF4ZsGG9RWUZimUEuo1zkK8iJm1rRbU
	Vtvs2hNofBorIJpm1pODkmLFify2KVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759997267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=840BVvk4h/vQ3iIDPplNBop5pm8dJACDtuDls2QAuzo=;
	b=uhJSxLdkywP8EgjhSzopzlfXz6YCM8o/5fj57d7Jj60gAoL5kZVIg22rAKAZkeP+Vu2mxV
	Xubi1K3Ydm1QnmAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759997267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=840BVvk4h/vQ3iIDPplNBop5pm8dJACDtuDls2QAuzo=;
	b=lT3BcE/3xLnQc9f2v2Q3k1PaokeHfbIitmRaSGJFjpMBc+Gi3AhKPqgCIh+KbCM/k5CDgD
	0g+hXMyScNWMF5W2sKtxiI++tsS+wb4Bmj9LPmoBF4ZsGG9RWUZimUEuo1zkK8iJm1rRbU
	Vtvs2hNofBorIJpm1pODkmLFify2KVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759997267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=840BVvk4h/vQ3iIDPplNBop5pm8dJACDtuDls2QAuzo=;
	b=uhJSxLdkywP8EgjhSzopzlfXz6YCM8o/5fj57d7Jj60gAoL5kZVIg22rAKAZkeP+Vu2mxV
	Xubi1K3Ydm1QnmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B723013AAC;
	Thu,  9 Oct 2025 08:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AavsKVJt52gYEAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 09 Oct 2025 08:07:46 +0000
Date: Thu, 9 Oct 2025 10:07:45 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH v2 2/5] mm/page_owner: add struct stack_print_ctx.flags
Message-ID: <aOdtUZbMhV77q3Hk@localhost.localdomain>
References: <20251001175611.575861-1-mfo@igalia.com>
 <20251001175611.575861-3-mfo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001175611.575861-3-mfo@igalia.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo,igalia.com:email,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid,igalia.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On Wed, Oct 01, 2025 at 02:56:08PM -0300, Mauricio Faria de Oliveira wrote:
> Add the flags field to stack_print_ctx, and define two flags for current
> behavior (printing stack traces and their number of base pages).
> 
> The plumbing of flags is debugfs_create_file(data) -> inode.i_private ->
> page_owner_stack_open() -> stack_print_ctx.flags -> stack_print().
> 
> No behavior change intended.
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

