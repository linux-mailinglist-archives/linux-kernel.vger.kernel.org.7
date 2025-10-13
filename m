Return-Path: <linux-kernel+bounces-850105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E8BD1E34
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8C3189430A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A22E2DC4;
	Mon, 13 Oct 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vfs++J5i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DtLGvF40";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J8VFdhHl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WVhrkLKQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A162EB5A3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342190; cv=none; b=MC7tkCN78RVM8wPi52AIQVwXuh3miDfSkQVZTyqTuzsYXbNr6ga2IBqcbiBEVSG6+rN6w+0SX4LIf+hzSQXPwXPH+fkN4PS/t8c92NO3ty3qkCMALeKX47BlaKHnccsEPAOSj409tw0klK/HXrVNb9klDUF16tJ/cu6ElufdAY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342190; c=relaxed/simple;
	bh=4B3mPVJ1xeqBywimjFQMvxYDd9netkH9wS/TCYiPKLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN8cB4twgf5COKPs8O69r+ml0qEtUjESaB3wleBD/SMQfY/T0oxxsTCQLWWI8najoxD/Ytr/cp0o7J4o7+0AtJB5YyAcY3s7kjk6JEe24LFltYTrpQDuzBWv6wh0UbzAo+XrdKlpUOLLS/x+wM+GTM8GxMv4dwKgPzMYMS0rVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vfs++J5i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DtLGvF40; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J8VFdhHl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WVhrkLKQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 253F5211B4;
	Mon, 13 Oct 2025 07:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PX880TA/77/yrgYUzZYJ9ptGRpChgW/jGJJ8qYIOliA=;
	b=Vfs++J5iE5Vf+i6+pSlQesYltQxk/PixZNz6SgTCTa6+uwJmSOr8xRXP06iuJeVvH1u64X
	hbiZUq57LJD5nW4KQ+qj6B4dhOiSQ515tIgtGVZV5DPre/+I305cLWI4j4EVA+dcsRWDUi
	rbFzuIzjEOiD+hAXy5prs25PKwOGmLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PX880TA/77/yrgYUzZYJ9ptGRpChgW/jGJJ8qYIOliA=;
	b=DtLGvF40H7FBAeyeAUkcfpsddi0LOHAHJcrB+yIuvZD3Aaai6mqyb9wToy/4RALiNPodQl
	PtyOZLOltnjIvDAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J8VFdhHl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WVhrkLKQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PX880TA/77/yrgYUzZYJ9ptGRpChgW/jGJJ8qYIOliA=;
	b=J8VFdhHlx7doAxqdrJY11dDWSvtAhIpVKO4HtdzdF0Qh26Nkyn2w2s0toKxzCuNhE2kk2b
	xaIjD08b8qD3eFoueKEfsXKZwVvGj7Oq/WMPaiX9tZ59PweMiwH5aWuW+1wcEWTErJ6Ant
	R7TYLxDqwzZ2iGLTbau4kG5w5/tdrO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PX880TA/77/yrgYUzZYJ9ptGRpChgW/jGJJ8qYIOliA=;
	b=WVhrkLKQQe2+Ur0EQdAWDpWIZ1glyXkwJlzIdAcyQAD/tJKKLaRSrSkMRkaWqTWUeS8Zu/
	hwrDc7ahVXAGzyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80A9C13874;
	Mon, 13 Oct 2025 07:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qyJ2HKiw7GhGDQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 13 Oct 2025 07:56:24 +0000
Date: Mon, 13 Oct 2025 09:56:14 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Usama Arif <usamaarif642@gmail.com>
Cc: muchun.song@linux.dev, david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, shakeel.butt@linux.dev,
	linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com,
	kas@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] mm/hugetlb: create hstate_is_gigantic_no_runtime
 helper
Message-ID: <aOywnmyYj7R-CFVd@localhost.localdomain>
References: <20251009172433.4158118-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009172433.4158118-1-usamaarif642@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 253F5211B4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.de:dkim,suse.de:email,linux-foundation.org:email]
X-Spam-Score: -4.51

On Thu, Oct 09, 2025 at 06:24:30PM +0100, Usama Arif wrote:
> This is a common condition used to skip operations that cannot
> be performed on gigantic pages when runtime support is disabled.
> This helper is introduced as the condition will exist even more
> when allowing "overcommit" of gigantic hugepages.
> No functional change intended with this patch.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

