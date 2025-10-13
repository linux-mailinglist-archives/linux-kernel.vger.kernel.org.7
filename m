Return-Path: <linux-kernel+bounces-850121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778A0BD1EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47171898CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B402EC0B1;
	Mon, 13 Oct 2025 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RHG+2uN6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3MYv7UFI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eeDubVNZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v/0r/G/a"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E721FF46
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342930; cv=none; b=YQhTbk2TtnQYS/34cEg8hNKJ2IXsuwilUUjiHCivZlD1lIW/EPXL2FONVVYt6662Hhatch95V5BIZWd+t6Ym5Hx1kzPu2393nZUdcU7GFsxfETQbo/bqmFqxym2N0YElDKhzCziOtbL/ovJ2seOWtjpROG65DaU7uVesdQ7OQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342930; c=relaxed/simple;
	bh=RRwy1lLs7sH8ybxF+sw2XgT4MbF/6U8gs+1ykbZHfR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWVs7nGUyDYlDZfkna0HblrqGBhzi4a6sWspD5KRYy6mCE0Km4JYojKGUHyoiiNaG2GJzM9d0tHnOE42unrtzSWTr1ridf1bT5Ii6rc/jkkqbYI45Hgeqee6Noqv9WIL7jv81mpAzX3oQJUzntSgw5DuCbw8YlSgtWEjFe1ZxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RHG+2uN6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3MYv7UFI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eeDubVNZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v/0r/G/a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B74BE211FE;
	Mon, 13 Oct 2025 08:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dlNkhyop+IEN4Hkc4oUyCWqeDkbc6AZN0KzU4dkgeLA=;
	b=RHG+2uN67HN79LYFdavTGm2bpJbicwUnlTXQcZIRlv+fV286C0B/LMkXEEvZWIQTHJPrUp
	ZXNxGPJ4/8xc1VVSGdTSmzD4mFmuEq3OGJZH9wnxgHBc/nTeIGR2KOta1dqFJgHyoVlpXq
	l33xUWXj8LRf1W74XZYMUmpZHto/JLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dlNkhyop+IEN4Hkc4oUyCWqeDkbc6AZN0KzU4dkgeLA=;
	b=3MYv7UFIEqRa46ApyLaQAFs/MDjNNyuNycxrJPOc7jq7hJBnfSYjc6L0j2PPjKtntWJuz4
	my2GcNY6qGQuhjBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dlNkhyop+IEN4Hkc4oUyCWqeDkbc6AZN0KzU4dkgeLA=;
	b=eeDubVNZbtpRzOsTkWcy/VN3T6wI9a+XwvWaWP5DYIWtFv83CF+LRJ7QHXCqQcZ18K1esA
	Y4T3npR2pN1t+uAbNnHNwk2UERiI47OcpaWvCHgnrMekijd/J07PpGOsxLzsT9MGnLs8dR
	XFqZ1KgfI2EwDLX7P/T985Uj3DMvX1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dlNkhyop+IEN4Hkc4oUyCWqeDkbc6AZN0KzU4dkgeLA=;
	b=v/0r/G/aCjZ94Q0X4QvB8jehsvLLQG5rR+r9EwpZjyMsKp1Gxi4LSw7a0AVwOyJ1dtRED3
	32BGYy3Fyx+WL5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 579BF13874;
	Mon, 13 Oct 2025 08:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N+qyEouz7Gg9GwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 13 Oct 2025 08:08:43 +0000
Date: Mon, 13 Oct 2025 10:08:41 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, david@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hugetlb: add __read_mostly to
 sysctl_hugetlb_shm_group
Message-ID: <aOyzibjnM89KxnXi@localhost.localdomain>
References: <20251008212614.86495-1-gourry@gourry.net>
 <20251008212614.86495-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008212614.86495-2-gourry@gourry.net>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:email,localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Wed, Oct 08, 2025 at 05:26:14PM -0400, Gregory Price wrote:
> sysctl bits are mostly-read values.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

