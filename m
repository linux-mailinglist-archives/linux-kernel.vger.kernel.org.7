Return-Path: <linux-kernel+bounces-810252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE09B517CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BB33AE1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57541EF39F;
	Wed, 10 Sep 2025 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EN3GVk71";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aUhO4heT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EN3GVk71";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aUhO4heT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DF3F9D2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510644; cv=none; b=ieW9ZJknTluNCTrILt2cizMrvnsTGxbBQU1uCNswxlclNPdC6k67jkBKfD08jc7zhIFn0XlL2SnJ5Lt9gh1PtXxvva/vQcrmep6v6EjBVVkGjRiYh5F/2kYrvoHxIFuHc/wEn0scEe6f/V/cXEhbrTqbgpgrzCWQfVbxzKI62DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510644; c=relaxed/simple;
	bh=Awp4l7FE750ZgaqxuNsrOGFeOf7bHtFqJFHTWm/IBKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMh1jOROiC4eG5aau+8QELMpa1x9uQZg/wmNzgJ+9Al7/JHD9jSy4MODugNOOtRGqi+x6QyfI7jmZcB3USacB3fQ14lnBVWrxr6eeTnotM7A/D5mHB3fDGjrmYzJkSoLhnkiy5MOOtvjR13QAlQGBh2yXn2JYXsCnq99iPaXMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EN3GVk71; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aUhO4heT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EN3GVk71; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aUhO4heT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BF84207D8;
	Wed, 10 Sep 2025 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757510639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEVkkQ23Tqz5PvZ8ZMjLfQM9v76jgOVMVSW9/pqQol0=;
	b=EN3GVk717n+XCv5zPhcnnCg4H2xglDNEbba7tQxDxb/Re52c8H+m409AaCY97Z4jdaq9Xt
	w62tbVAyAWv19i3ikyBi1VPwuosqLAJAAYl4F2815G1LTQc3VcisOI1Wz5EsJtWsNHXVmG
	l6ERSLXqsacaTEtQjKBXO0oGOb0be6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757510639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEVkkQ23Tqz5PvZ8ZMjLfQM9v76jgOVMVSW9/pqQol0=;
	b=aUhO4heTLGa5w1Rrd9iYA2BECWWexmMcuvHvRJdpjDH+OiJG04YF9KZekpV2fe443cnnTc
	t+AIaPrU+pMCFmDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EN3GVk71;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aUhO4heT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757510639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEVkkQ23Tqz5PvZ8ZMjLfQM9v76jgOVMVSW9/pqQol0=;
	b=EN3GVk717n+XCv5zPhcnnCg4H2xglDNEbba7tQxDxb/Re52c8H+m409AaCY97Z4jdaq9Xt
	w62tbVAyAWv19i3ikyBi1VPwuosqLAJAAYl4F2815G1LTQc3VcisOI1Wz5EsJtWsNHXVmG
	l6ERSLXqsacaTEtQjKBXO0oGOb0be6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757510639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEVkkQ23Tqz5PvZ8ZMjLfQM9v76jgOVMVSW9/pqQol0=;
	b=aUhO4heTLGa5w1Rrd9iYA2BECWWexmMcuvHvRJdpjDH+OiJG04YF9KZekpV2fe443cnnTc
	t+AIaPrU+pMCFmDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4531813301;
	Wed, 10 Sep 2025 13:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tLSnDe57wWggDgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 10 Sep 2025 13:23:58 +0000
Date: Wed, 10 Sep 2025 14:23:48 +0100
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
Subject: Re: [PATCH v1 6/9] mm: Change dup_mmap() recovery
Message-ID: <fkfi4zldsecyio6xnd6blou27me4nno3v3tnsaxz6xlt63yy2z@nxl7izptm6yx>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-7-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190945.1030905-7-Liam.Howlett@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6BF84207D8
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,lists.infradead.org,kvack.org,vger.kernel.org,redhat.com,oracle.com,suse.cz,google.com,suse.com,quicinc.com,huaweicloud.com,tencent.com,gmail.com,kernel.org,infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

On Tue, Sep 09, 2025 at 03:09:42PM -0400, Liam R. Howlett wrote:
> When the dup_mmap() fails during the vma duplication or setup, don't
> write the XA_ZERO entry in the vma tree.  Instead, destroy the tree and
> free the new resources, leaving an empty vma tree.
> 
> Using XA_ZERO introduced races where the vma could be found between
> dup_mmap() dropping all locks and exit_mmap() taking the locks.  The
> race can occur because the mm can be reached through the other trees
> via successfully copied vmas and other methods such as the swapoff code.
> 
> XA_ZERO was marking the location to stop vma removal and pagetable
> freeing.  The newly created arguments to the unmap_vmas() and
> free_pgtables() serve this function.
> 
> Replacing the XA_ZERO entry use with the new argument list also means
> the checks for xa_is_zero() are no longer necessary so these are also
> removed.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

