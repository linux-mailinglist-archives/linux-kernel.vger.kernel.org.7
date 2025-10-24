Return-Path: <linux-kernel+bounces-869357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A54C07B02
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CFD400483
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07EB347BB4;
	Fri, 24 Oct 2025 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hbIFI5LZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HoPgPMuv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CIKXMe5+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lyh8gb1x"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A8346E72
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329607; cv=none; b=a2ibctrbeUctuN/obYgpK5ZuS64p9ohrZVha28g6EKoIBuh/Hm//mfbn6iwvCrv2MEik6OHvDhylb6PeC2L2w/uSc9w0Xl4nrsrQWnKwHpcnoxZFx4nXwXGMvMEXo0VBPagxfYGd/G+wEwOZzoVo6UHMTBMy62RweNWyrtShnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329607; c=relaxed/simple;
	bh=HpnwwN94mZhx0Jsj+VCUCGvkfnupVRSgWf8BgU8xC58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blDm/ojvp15tGq4qgKmTHAtXbHU+u+wXPasq1FLVpofRYtmZTHVsFJhjuLtzuDSZZbeUUUNuw659wG1GowqY7Q0jeB+XMrswXuWDp/sQWMroAl5K99cF5OBixV3ZmWmJ7FUW+hD9AeR3outPVWtRVNIPWQhOf/GWShN62VabalA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hbIFI5LZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HoPgPMuv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CIKXMe5+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lyh8gb1x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B49A1F388;
	Fri, 24 Oct 2025 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761329603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6cajldIgDLiiisXFh5trizW5GaC58+xqdbWgMHBrLM=;
	b=hbIFI5LZv1lGAMOm2ffsiYQbay9zZ40Y0coZ6IMcIsBNxRYBuIUWR/vWZ6qB0o3ah2bICX
	2v3Pq6b7MKYgGLmRJ+ltogSuEDH9B2PY1YtakeCXmYUmFVgKlLRgb4lwyBP08yYzLOpDMm
	bpsFavBzbfT6C5xxPwu2bfPGiHcEamc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761329603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6cajldIgDLiiisXFh5trizW5GaC58+xqdbWgMHBrLM=;
	b=HoPgPMuvFzy9l/lUOCIG3kHTtaYBCZCOdqhMuRitZ0dDm7F3ofE9Xl9fayLiBPzOHKDwly
	kUKRXSXaZfUMPZDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761329602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6cajldIgDLiiisXFh5trizW5GaC58+xqdbWgMHBrLM=;
	b=CIKXMe5+kzdth/2nItCfUAL5GBHYsuNe6FaXkNwZ/4cCe1s9ag6d//pG1HlUZYbfeqmroD
	CGF9nI1ow/6ojPAXkADHzV5fjaheXfLRrx4Rwz7+pZer7aEKzPyBACWxKlt9oT0xIQ01ut
	4rjrnIwj/6R4gvLfZ3q7tbJMKuS09sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761329602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6cajldIgDLiiisXFh5trizW5GaC58+xqdbWgMHBrLM=;
	b=lyh8gb1xjLkkWko5itk0aQ5tG0sEkJ1dMouyKMYJNd6q+OpdiJut5pieJaKPhb7O2cwhE1
	fGwyQpnPLDVhW+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97D2013693;
	Fri, 24 Oct 2025 18:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xV1XIsHB+2hoGgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 24 Oct 2025 18:13:21 +0000
Date: Fri, 24 Oct 2025 20:13:15 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: muchun.song@linux.dev, david@redhat.com, akpm@linux-foundation.org,
	broonie@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v8] hugetlbfs: move lock assertions after early returns
 in huge_pmd_unshare()
Message-ID: <aPvBu5FIF7QpVhSB@localhost.localdomain>
References: <20251014113344.21194-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014113344.21194-1-kartikey406@gmail.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[f26d7c75c26ec19790e7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,localhost.localdomain:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Tue, Oct 14, 2025 at 05:03:44PM +0530, Deepanshu Kartikey wrote:
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
> Instead of checking locks in the caller or skipping VMAs, move the lock
> assertions in huge_pmd_unshare() to after the early return checks. The
> assertions are only needed when actual PMD unsharing work will be performed.
> If the function returns early because sz != PMD_SIZE or the PMD is not
> shared, no locks are required and assertions should not fire.
> 
> This approach reverts the VMA skipping logic from commit dd83609b8898
> ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
> while moving the assertions to avoid the assertion failure, keeping all the
> logic within huge_pmd_unshare() itself and allowing page unmapping and
> freeing to proceed for all VMAs.
> 
> Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
> Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/mm-commits/20250925203504.7BE02C4CEF7@smtp.kernel.org/ [v1]
> Link: https://lore.kernel.org/mm-commits/20250928185232.BEDB6C4CEF0@smtp.kernel.org/ [v2]
> Link: https://lore.kernel.org/linux-mm/20251003174553.3078839-1-kartikey406@gmail.com/ [v3]
> Link: https://lore.kernel.org/linux-mm/20251008052759.469714-1-kartikey406@gmail.com/ [v4]
> Link: https://lore.kernel.org/linux-mm/CADhLXY72yEVDjXWfxBUXfXhNfb8MWqwJmcb1daEHmDeFW+DRGw@mail.gmail.com/ [v5]
> Link: https://lore.kernel.org/linux-mm/e6bb05f7-8f05-409f-9d87-2d25f66942a9@redhat.com/ [v6]
> Link: https://lore.kernel.org/linux-mm/CADhLXY4WPxzvzuiZPJmhS-9xMqRZ_qf7ZcFf5MXPgXbgB3_Xzg@mail.gmail.com/ [v7]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

I got lost in the flow of multiple patches:

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

