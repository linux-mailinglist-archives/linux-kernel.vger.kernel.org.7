Return-Path: <linux-kernel+bounces-850125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A138CBD1F16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBAE14ED8A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7A2EA16D;
	Mon, 13 Oct 2025 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TuqFy/NK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DB+tZuxo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TuqFy/NK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DB+tZuxo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091021FF46
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342992; cv=none; b=SWK2fhaymzi7mNIZS7raO3zS9m76iad52f8FzRf65xsPC5ITOFUmL8eyzYeQtR7EkC7WHD9xIGS6L72FFGjtiNeQChWsQKcLN+/Pj3En1CfRi+bsTp1u8vIhfeoSxWDlZHwtehJiNiKKaoEYVmeOnsT5pkU0e3WRhhPssgAyBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342992; c=relaxed/simple;
	bh=4kBlkkU2cRPU5tTjb1xZWVyxj92NKlcuszSgY3etlZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pefxOd/r8wpkQLfcM+/ER2RN8SNyRZ03S7glz/8xmmlSC/wBjyLrSHGf0f1GfDBOdgPvRks0caF9A9NeZQKagZpsEZd87SpVqGXWp4WV0rmdf86RWJTIP1BozN0s86Dfv1tyqCAk4dooxmjHUDG0qTgHk2ChztrhEnSX17IGVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TuqFy/NK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DB+tZuxo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TuqFy/NK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DB+tZuxo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0F452122B;
	Mon, 13 Oct 2025 08:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mpX24lvqV7WFDDylZiXQr7peNkkr00zZ4SHlTRyubQ0=;
	b=TuqFy/NKSMlBhY54yA3qrMBpRcSFlcNTt8izqAemZxrstv5oAZdOPFaCUqyjhwXi7XTHnZ
	FL88B2rCk2NvT4gimbBukZi7x250pcP2xIuQ8fZuas+c8zIq0vFQKx7UzG4yb4v82sQOzp
	h0eqw3Wc23wfHq3MMvr9F3F47xe5p0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mpX24lvqV7WFDDylZiXQr7peNkkr00zZ4SHlTRyubQ0=;
	b=DB+tZuxoLCLj0jsrViySAGyPTmfJvtpxj0BMiDluFJXjHp0Df8DjuVUPNJ83vF18Rfzc/L
	IT/bGsqjU20EBICQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="TuqFy/NK";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DB+tZuxo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mpX24lvqV7WFDDylZiXQr7peNkkr00zZ4SHlTRyubQ0=;
	b=TuqFy/NKSMlBhY54yA3qrMBpRcSFlcNTt8izqAemZxrstv5oAZdOPFaCUqyjhwXi7XTHnZ
	FL88B2rCk2NvT4gimbBukZi7x250pcP2xIuQ8fZuas+c8zIq0vFQKx7UzG4yb4v82sQOzp
	h0eqw3Wc23wfHq3MMvr9F3F47xe5p0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mpX24lvqV7WFDDylZiXQr7peNkkr00zZ4SHlTRyubQ0=;
	b=DB+tZuxoLCLj0jsrViySAGyPTmfJvtpxj0BMiDluFJXjHp0Df8DjuVUPNJ83vF18Rfzc/L
	IT/bGsqjU20EBICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D4BB13874;
	Mon, 13 Oct 2025 08:09:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +lpJDMyz7GiMHAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 13 Oct 2025 08:09:48 +0000
Date: Mon, 13 Oct 2025 10:09:46 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: muchun.song@linux.dev, david@redhat.com, akpm@linux-foundation.org,
	broonie@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] hugetlbfs: check for shareable lock before calling
  huge_pmd_unshare()
Message-ID: <aOyzyt7irOiINLWq@localhost.localdomain>
References: <20251003174553.3078839-1-kartikey406@gmail.com>
 <20251008052759.469714-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008052759.469714-1-kartikey406@gmail.com>
X-Rspamd-Queue-Id: B0F452122B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[f26d7c75c26ec19790e7];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.de:email,suse.de:dkim,appspotmail.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

On Wed, Oct 08, 2025 at 10:57:59AM +0530, Deepanshu Kartikey wrote:
> When hugetlb_vmdelete_list() processes VMAs during truncate operations,
> it may encounter VMAs where huge_pmd_unshare() is called without the
> required shareable lock. This triggers an assertion failure in
> hugetlb_vma_assert_locked().
> 
> The previous fix in commit dd83609b8898 ("hugetlbfs: skip VMAs without
> shareable locks in hugetlb_vmdelete_list") skipped entire VMAs without
> shareable locks to avoid the assertion. However, this prevented pages
> from being unmapped and freed, causing a regression in fallocate(PUNCH_HOLE)
> operations where pages were not freed immediately, as reported by Mark Brown.
> 
> Instead of skipping VMAs or adding new flags, check __vma_shareable_lock()
> directly in __unmap_hugepage_range() right before calling huge_pmd_unshare().
> This ensures PMD unsharing only happens when the VMA has a shareable lock
> structure, while still allowing page unmapping and freeing to proceed for
> all VMAs.
> 
> Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Reported-by: Mark Brown <broonie@kernel.org>
> Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Link: https://lore.kernel.org/mm-commits/20250925203504.7BE02C4CEF7@smtp.kernel.org/ [v1]
> Link: https://lore.kernel.org/mm-commits/20250928185232.BEDB6C4CEF0@smtp.kernel.org/ [v2]
> Link: https://lore.kernel.org/linux-mm/20251003174553.3078839-1-kartikey406@gmail.com/ [v3]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

