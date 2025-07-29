Return-Path: <linux-kernel+bounces-749386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F7B14DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D96118A2CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D8F290DBB;
	Tue, 29 Jul 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="acKyah/V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MGkdUfoQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="acKyah/V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MGkdUfoQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C824235072
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792117; cv=none; b=ZKjymfbj/VT0YYbMkn1ympMNWON89Q0+5Y9+u5BVao01Qjo6kfx2AAklbx7kV9uWR3iI3q7AOUHciv0qfpg5ZLKkSwY+/vcmIsgy92Iy47xbGV5wLaukzeYQX6+8UX6oYZM2yovayKRL521txuC4ffXhxi8mHpurSu41U6A/pQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792117; c=relaxed/simple;
	bh=0Qod0OiT05hAmdQgOJT7iKyErKXfQ2rvZW6nw1ngvkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE/7AcFoa4BWHYiCAQ9YBVS38VCI+n9mxIzuoVcUZhFEYmuxKAkgv1XAqRNGFIhOEOffi15s1s/5Lq0UkZeC9bN1SV//9DkuNa0KpQv09uvKfJZPR0LHr0OfIMRoqiopomVChe2u/4rol8CqauEsbotwZPNSN/7/f1z1hyB4K/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=acKyah/V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MGkdUfoQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=acKyah/V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MGkdUfoQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3235D1F750;
	Tue, 29 Jul 2025 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753792114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MEoIMXx8uWeBAUTt3qneNgLxCWwpKhWrTNGeluKmiDc=;
	b=acKyah/V2u7tElhJw8/r4m4gyKxaRh244JwlcjhgKIQGDq+zRCZRiEMsSmh/QvJSfL18Qa
	m1pObE7/Aa985ugQcIxHgmjKWeBoCJp5g62pCjedTvsb5eiYukYUSjrFjhrpOHqJa5bL15
	Q6wutLuggczcqd2WRJTtz8ghyZVIB3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753792114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MEoIMXx8uWeBAUTt3qneNgLxCWwpKhWrTNGeluKmiDc=;
	b=MGkdUfoQMMdA1OI31PtcuYUJxUY+pxLEU/umpZLBeWiYLRIhRGcEZhZhvg3XYGW+FDArR0
	sMKKsww9gbaUyaAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753792114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MEoIMXx8uWeBAUTt3qneNgLxCWwpKhWrTNGeluKmiDc=;
	b=acKyah/V2u7tElhJw8/r4m4gyKxaRh244JwlcjhgKIQGDq+zRCZRiEMsSmh/QvJSfL18Qa
	m1pObE7/Aa985ugQcIxHgmjKWeBoCJp5g62pCjedTvsb5eiYukYUSjrFjhrpOHqJa5bL15
	Q6wutLuggczcqd2WRJTtz8ghyZVIB3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753792114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MEoIMXx8uWeBAUTt3qneNgLxCWwpKhWrTNGeluKmiDc=;
	b=MGkdUfoQMMdA1OI31PtcuYUJxUY+pxLEU/umpZLBeWiYLRIhRGcEZhZhvg3XYGW+FDArR0
	sMKKsww9gbaUyaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B43C13A73;
	Tue, 29 Jul 2025 12:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k7sVD3G+iGjJCwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 29 Jul 2025 12:28:33 +0000
Date: Tue, 29 Jul 2025 13:28:31 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm: correct type for vmalloc vm_flags fields
Message-ID: <5sm4k5dms2ryfxzj4v5jfzfthlzwrsournupl6kakipiuyty7m@to7gbjenmfyj>
References: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,oracle.com,suse.cz,google.com,suse.com,kvack.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue, Jul 29, 2025 at 12:49:06PM +0100, Lorenzo Stoakes wrote:
> Several functions refer to the unfortunately named 'vm_flags' field when
> referencing vmalloc flags, which happens to be the precise same name used
> for VMA flags.
> 
> As a result these were erroneously changed to use the vm_flags_t type
> (which currently is a typedef equivalent to unsigned long).
> 
> Currently this has no impact, but in future when vm_flags_t changes this
> will result in issues, so change the type to unsigned long to account for
> this.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: Harry Yoo <harry.yoo@oracle.com>
> Closes: https://lore.kernel.org/all/aIgSpAnU8EaIcqd9@hyeyoo/

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

I think the existence of this mistake really tells us that we _really_ need some sort
of type checking of this stuff, in the future.

-- 
Pedro

