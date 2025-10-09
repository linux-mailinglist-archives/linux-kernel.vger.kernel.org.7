Return-Path: <linux-kernel+bounces-846408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18279BC7EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB311188C36D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0902D3A77;
	Thu,  9 Oct 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y9ZWb5GX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rifxSvZ+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZxIoF4LO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yK4OMB9e"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4F1B4F1F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996906; cv=none; b=tczlOeaqgbQY03ZVDBmrv/rT/2RhU6TyojnhS3SyB8WZgYZy2sdrKu0zZm42NWIkNkJlNuoe1spq4w4e76MEa1uJej9YbjIJ9xzzY0J3k4UWM+QNXTdATpePL3Wm2qg+8tqvIBiLwgHXsencD2Ym4AwpHjYL1yl5SjRAa/Rk3qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996906; c=relaxed/simple;
	bh=P+5CsK2whxAKBCIDznN22E5b3CLb+sSY5GApurMeCJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOmfB0XVhSVLMFMxvylB2ctZpmITmA0uDBo9R+sRu04PrMp1a/0UoGBjpn1eg5Y8qpM8BvOQB3DbRYs0AhMYl+r9C3ZKzzq11GCFRj0Ehh9M2Iiq6u3yfUDAh66NQUC+n/B7rl/jlEAzRu+KG5GOiukkOWYnD+HLDigGEJb+Pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y9ZWb5GX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rifxSvZ+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZxIoF4LO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yK4OMB9e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C5152245E;
	Thu,  9 Oct 2025 08:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759996892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxltF4dkzdwh6jot7QMtNml0hcUKaWzZhVwWOrFpfOk=;
	b=Y9ZWb5GXyC7HLDHnuy3lGQZgvXzHlmQtuYSXnrJ0ZWYmdzaUj4CfZAGjoAJfGQUX3JLrW5
	ane2RhKtAzQITCXc+bpOuCoX5XddEIiyd1dnDVjz8bfX501p0ZGP6P7fnk/2nvKFXS49oz
	NABSJyWvOWkmrd9BHOh6w61lrltHsx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759996892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxltF4dkzdwh6jot7QMtNml0hcUKaWzZhVwWOrFpfOk=;
	b=rifxSvZ+fbU/gYJ/h1EEg83AXCdY5jTDt9lXvzpyMXfkVy+zqhY4uLzs3VR3C6fPkuT47p
	OZ3EKQcQIyIUf0DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759996887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxltF4dkzdwh6jot7QMtNml0hcUKaWzZhVwWOrFpfOk=;
	b=ZxIoF4LOjZ3VshzQhSmJwnmcNKEUApnXVcbWo+6zhdja2EAR5eCza6N1vGYvd4j1mxdaP9
	GQHBsbxIQHQa5acXI/yc6VOQrLtsWNZuqfxqKCKT5ohxEgukwJ1+AimW/lZFVzmZScG9if
	ZgP1uvKS1cI8W66Lz/x6jYDC9MN+o8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759996887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxltF4dkzdwh6jot7QMtNml0hcUKaWzZhVwWOrFpfOk=;
	b=yK4OMB9ewdh/PY1JGi6fU+gIHv+ZPZC5ucv28NWOq4GH48AvW//T2S/bKl/Xi0Pq7NrJeG
	U32+FeIrBgkC3/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83AEB13AAC;
	Thu,  9 Oct 2025 08:01:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q6ZsHdZr52j2DQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 09 Oct 2025 08:01:26 +0000
Date: Thu, 9 Oct 2025 10:01:16 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH v2 1/5] mm/page_owner: introduce struct stack_print_ctx
Message-ID: <aOdrzAmu5zgCqT6m@localhost.localdomain>
References: <20251001175611.575861-1-mfo@igalia.com>
 <20251001175611.575861-2-mfo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001175611.575861-2-mfo@igalia.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[igalia.com:query timed out,suse.de:query timed out];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[igalia.com:query timed out,suse.de:query timed out];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, Oct 01, 2025 at 02:56:07PM -0300, Mauricio Faria de Oliveira wrote:
> Currently, struct seq_file.private is used as an iterator in stack_list
> by stack_start|next(), for stack_print().
> 
> Create a context struct for this, in order to add another field next.
> 
> No behavior change intended.
> 
> P.S.: page_owner_stack_open() is expanded with separate statements for
> variable definition and return just in preparation for the next patch.
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

