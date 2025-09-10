Return-Path: <linux-kernel+bounces-810240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E736B51799
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1488B546BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAD431353D;
	Wed, 10 Sep 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w3VfEV+G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="30OH4Hw/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w3VfEV+G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="30OH4Hw/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64333296BCC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509721; cv=none; b=tCf6Me3mL22I/YBnZ89AzoUmocJQI6KTptjseubf7Y6Z3rDlj8UNL56HTan/dHDudVUC8Ip9y2gyKkVYS9p/pJNSIMWX0iJ/nBOQBO4a7hKY/571KNT83ewRgt2HX0KVO3JIw42tDi9mQnkL60Kb96whuqYz/FT8w7BOrxg3U/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509721; c=relaxed/simple;
	bh=+NfVlU/mcB1ivog8OEN/LEa7hx9kQlxMZ4XcovRcGOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em4gvdu7I09OGC1tphxb0terfXnyH9tS+FA/By9uyXv71YY89ByKQ4Hpo0nUY6ruHqgK9/7XeCQ6G1kZtar650pLMziaabzOReDRBNWEOWjGlLX1APnKywsT4mtQyj+jORoTT4/ga5EX3BPF4L9rYX2mwe1BqubV4oVqxVxFiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w3VfEV+G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=30OH4Hw/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w3VfEV+G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=30OH4Hw/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 591135CC91;
	Wed, 10 Sep 2025 13:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757509717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+oSyfzNJLGLfUyM48/ZQpqckel3kTsMsG7r1q37tt4=;
	b=w3VfEV+GvLc3BqHxYCsKiYnp3HqbXCScgXCDJQRuFN6nGskMG4Hwo+srXkp2cDJDhGLSjm
	GW4tL6mOgjcftLjnrXTR0BnANiMKmdzZjl2E3CE+oIug3JlWdHOY9/RUKguY6N7HF02CPr
	nOCuID7P1fzS6UX/TlAR9wqrBG21E9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757509717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+oSyfzNJLGLfUyM48/ZQpqckel3kTsMsG7r1q37tt4=;
	b=30OH4Hw/M1AubeXskn4o+uZbIK1J6Nmyq4HG/zNVTj077HQguHkz47u9GO/MtBs+FY49O+
	bwDhJ5o/sc5wkSDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w3VfEV+G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="30OH4Hw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757509717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+oSyfzNJLGLfUyM48/ZQpqckel3kTsMsG7r1q37tt4=;
	b=w3VfEV+GvLc3BqHxYCsKiYnp3HqbXCScgXCDJQRuFN6nGskMG4Hwo+srXkp2cDJDhGLSjm
	GW4tL6mOgjcftLjnrXTR0BnANiMKmdzZjl2E3CE+oIug3JlWdHOY9/RUKguY6N7HF02CPr
	nOCuID7P1fzS6UX/TlAR9wqrBG21E9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757509717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+oSyfzNJLGLfUyM48/ZQpqckel3kTsMsG7r1q37tt4=;
	b=30OH4Hw/M1AubeXskn4o+uZbIK1J6Nmyq4HG/zNVTj077HQguHkz47u9GO/MtBs+FY49O+
	bwDhJ5o/sc5wkSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CBF713301;
	Wed, 10 Sep 2025 13:08:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g3y3B1R4wWgDCQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 10 Sep 2025 13:08:36 +0000
Date: Wed, 10 Sep 2025 14:08:34 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1 5/9] mm/vma: Add page table limit to unmap_region()
Message-ID: <5li7vx377obryqypk34l7aw4plsulyg7jqbdhfwkx3mawlzugd@yqqjkvy4uzou>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-6-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190945.1030905-6-Liam.Howlett@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 591135CC91
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lists.infradead.org,kvack.org,vger.kernel.org,redhat.com,oracle.com,suse.cz,google.com,suse.com,quicinc.com,huaweicloud.com,tencent.com,gmail.com,kernel.org,infradead.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLh8z4oz4h5odj6x1w8p1nxoya)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.de:dkim,suse.de:email]
X-Spam-Score: -4.01

On Tue, Sep 09, 2025 at 03:09:41PM -0400, Liam R. Howlett wrote:
> The unmap_region() calls need to pass through the page table limit for a
> future patch.
> 
> No functional changes intended.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

