Return-Path: <linux-kernel+bounces-733151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A42B070E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9DF189BA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C542EF664;
	Wed, 16 Jul 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U61TvNhN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gt/aMXa5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="isY3VxF3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0mObNsGL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C525C80D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655848; cv=none; b=KSYcDKSKI5LK2dUMriyYkStPoeMQSPASJM33uAsLTWFFJHiaPo0TBW8ii5VppU/xElYI+je/7o+eohDbXH/kJAocAVk0DBGEaypkYZbxAS6DWz0e2iYW8Ba5OZVMskBH6uDDZig4+ITHl4crV+dL00U3yP9YrZftQwaIQb47jzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655848; c=relaxed/simple;
	bh=wy+f5D8LmDN6LUBBv5rUnF5bo9w1aBz+Wyg5ydZKGHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUBgeccY7ReuflumvdMB5WJTK8SLa2OyBnOT2CtMt8rxz9/vgU/7NrDI+t6eblXeOY6h6jIwyPsBtJXBDjASMVBl68dT3wG8cZFUAGWdelmKp4qnKo6tIQF49VkgYghcFYFK+QiXPPvkNC3wMUqppzXiNyV0CWx2wRW7M9cmVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U61TvNhN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gt/aMXa5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=isY3VxF3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0mObNsGL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3C1E2123E;
	Wed, 16 Jul 2025 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752655844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCZko7UZBpxJOlg1wzquiji/vAwok1QlBeM7zAMal8s=;
	b=U61TvNhNkB+3imsXS0CyMr6wRRO7vKkmEJhi9L7Vgw2nCSMfIUFY4OHWuV7jF1qKIO8hT9
	tYG8zdGHYYRDiwkMf+gbYOZv5dkbjm1/hGfGoQ94BAi459xEn/135gL5Tj5/3/dTYtNRlV
	vGJseWn3cy8xS1JQ9SnSH68SkdFlup8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752655844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCZko7UZBpxJOlg1wzquiji/vAwok1QlBeM7zAMal8s=;
	b=Gt/aMXa5CQj+8qEHnr7IQNTL6LB51/8nSln3LQCtrAAbwIesPivZ77eJAQaIXPGx21Ub+4
	j05moHbzd0BgaLCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752655843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCZko7UZBpxJOlg1wzquiji/vAwok1QlBeM7zAMal8s=;
	b=isY3VxF3PrqOpxRZ4mSdGTLG8i0gNWKcKI1p+deZgKuVWJZFleu/9sVi1IlRc7qr6CSP0s
	+nSglWu91zDbd7M2QbqQQdSaGyEr+pie4eSZZE+i65h4pRNXcQn583QiErf9xbmcCVlhly
	lS6g/8zmU5JjPm0ZhUu24a1d8cJg1U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752655843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCZko7UZBpxJOlg1wzquiji/vAwok1QlBeM7zAMal8s=;
	b=0mObNsGL7jJ+dpQEXUZWmYCFNdgvslYZj2vJgKkEY4+Ce1onCoV8KX1Tea+R/0rJnwxj5B
	PCL6SVNVqtOcz/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6328E13306;
	Wed, 16 Jul 2025 08:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KcZvFeNnd2jnGwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 16 Jul 2025 08:50:43 +0000
Date: Wed, 16 Jul 2025 10:50:41 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, willy@infradead.org,
	muchun.song@linux.dev, ziy@nvidia.com, vbabka@suse.cz
Subject: Re: [PATCH] mm/page_owner: convert set_page_owner_migrate_reason()
 to folios
Message-ID: <aHdn4cjjpvm3Em2S@localhost.localdomain>
References: <20250711145910.90135-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711145910.90135-1-sidhartha.kumar@oracle.com>
X-Spam-Level: 
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,localhost.localdomain:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Fri, Jul 11, 2025 at 10:59:10AM -0400, Sidhartha Kumar wrote:
> Both callers of set_page_owner_migrate_reason() use folios. Convert the
> function to take a folio directly and move the &folio->page conversion
> inside __set_page_owner_migrate_reason().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

