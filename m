Return-Path: <linux-kernel+bounces-842943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C48BFBBE05C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37EC04E7E33
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949C27F011;
	Mon,  6 Oct 2025 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="usqtrK+T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CcQacKOT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="usqtrK+T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CcQacKOT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CD2905
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753674; cv=none; b=QXFiVK4c2fNOh2WnxJmumCAuZrcm1drGFMrVBqmGmRXND7Lixsy4DANThQOjX8UPmAnkJvEot98Yugxl2sI2PVJc+7HCfnsWWYfttkLUlvtW5ibD/exvc4DubAd0lEkKs+nB4x5kmFr5jCVv7TLyamP2KMvJh8ew9QmjYtiILU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753674; c=relaxed/simple;
	bh=1ksx+EJJX7Q130scag6qAwAJ8EGx02vpS083PwEAniM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFU7MLZxzeaHc/mfur0qSt9jDITtb7Llhb2xPSMpYrgbDejrb8QVPWS1kBeiSVeAFHiPaXby4KR0Wy+Az2GGiC6+YugkFi/se5rkcgN9XecOGRPZOHM+U8FntsSlDkwFPjX49QnBm5QUsnhWVEeoLLvutujEZIPeMjo2RngYW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=usqtrK+T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CcQacKOT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=usqtrK+T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CcQacKOT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22D401F45B;
	Mon,  6 Oct 2025 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759753670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/N8w/X5/6A+i1bNWZkBrJvAuFqWFqiVFijqUr8HYU8=;
	b=usqtrK+TmjksJl2a/CxQ+wYENLyYyi5sf8CZiHKfYp7iWO/99o240xW3a6M3gEna9bsKcU
	KTyKOlqz/2ZHMF3xC+h3xY70NRL9K6RLuJTDH/44pGYgXws9j9XAEBQk0oAmvmAcNN4bzB
	is8AYuWk9YLWBCALmIuozIZqCMZj6EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759753670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/N8w/X5/6A+i1bNWZkBrJvAuFqWFqiVFijqUr8HYU8=;
	b=CcQacKOTPAw4+hTxz7jwmT4blyIjGwNgb3fH0Urxj3J20aSj35LkuIg78UqdBkA+9AygDE
	FGjxyd0730dUzIAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759753670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/N8w/X5/6A+i1bNWZkBrJvAuFqWFqiVFijqUr8HYU8=;
	b=usqtrK+TmjksJl2a/CxQ+wYENLyYyi5sf8CZiHKfYp7iWO/99o240xW3a6M3gEna9bsKcU
	KTyKOlqz/2ZHMF3xC+h3xY70NRL9K6RLuJTDH/44pGYgXws9j9XAEBQk0oAmvmAcNN4bzB
	is8AYuWk9YLWBCALmIuozIZqCMZj6EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759753670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/N8w/X5/6A+i1bNWZkBrJvAuFqWFqiVFijqUr8HYU8=;
	b=CcQacKOTPAw4+hTxz7jwmT4blyIjGwNgb3fH0Urxj3J20aSj35LkuIg78UqdBkA+9AygDE
	FGjxyd0730dUzIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6925E13995;
	Mon,  6 Oct 2025 12:27:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zA10FsW142g+dgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 06 Oct 2025 12:27:49 +0000
Date: Mon, 6 Oct 2025 14:27:47 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: muchun.song@linux.dev, david@redhat.com, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	broonie@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hugetlbfs: skip PMD unsharing when shareable lock
 unavailable
Message-ID: <aOO1w3OMc7c563w3@localhost.localdomain>
References: <20251006075436.8417-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006075436.8417-1-kartikey406@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On Mon, Oct 06, 2025 at 01:24:36PM +0530, Deepanshu Kartikey wrote:
> Apologies for confusion. Please disregard this patch . As, it is creating a lot of confusion.
> I will create patch v4 with proper commit message and previous link

Hold on, let us try to avoid more traffic than necessary :-)?
I plan to have a look at this later today.


-- 
Oscar Salvador
SUSE Labs

