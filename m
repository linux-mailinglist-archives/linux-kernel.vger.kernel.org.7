Return-Path: <linux-kernel+bounces-746262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC23B124BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A367ACC63
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F2239581;
	Fri, 25 Jul 2025 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DBQeTZm1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3mATE9kj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DBQeTZm1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3mATE9kj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC53D994
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472069; cv=none; b=bZa05skrea6Wt4E2defnDf+WEQDKy0XSp6PI10UdCQfE2r96CIKkbqEwslaDjd+FgFDycD1/hv9YeL8tR23coCF2JJMu9OEnGTUTLcTXuVYZ2RD+HMuuQuwmJGD3zGG38jQ7z7X+1JF8q2ksXsPx86+bAmYxWQ/f5U8q8LX7iU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472069; c=relaxed/simple;
	bh=hyo1xIRaV1m6pwLtC6r8J0wpQmRXUASW4BIHdr7jmiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idu6c7+ukHgBZrPRBJK5AJupxKw0GtVkej9xWKXY+EqqEd2qn1PM5p5Yv4/x1h51yMkLOlGNcBLrLWPfFAEl3SI6XulH0P65MyqHKN4yeBHLpKoTvQuTIWju0ZnLfWAVQMVmFgQKJX2Q2KTESgLoAkkNs0v5nwuM+x9Be7RuZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DBQeTZm1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3mATE9kj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DBQeTZm1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3mATE9kj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E4211F387;
	Fri, 25 Jul 2025 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753472065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8zF3UsrGFMPKubG6ZqWnuxzmTuTcmmFNvDMxw8EafA=;
	b=DBQeTZm1Vo0+SYvB87M7V0lMbobs+BnRZ5v+sDIOJWom5QKKetOoEqhVU6PHr27fhp/4os
	Tb8El594TwmzQx6s9oV9QNp5hs44C0cJKR+nipTK9FE8rIpcFdZ92lCx4kdKcVMEb1PmA5
	IZAWCQGGKAJHFHdegHD5kxb2/5Oq/r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753472065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8zF3UsrGFMPKubG6ZqWnuxzmTuTcmmFNvDMxw8EafA=;
	b=3mATE9kjfC1lgrzVxqPD6uXTII2kjCFimtM6LlKa0xaa1A9uDwQoyrBzMiypdF/CD9WyOP
	eDP/mINzScSgN2Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753472065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8zF3UsrGFMPKubG6ZqWnuxzmTuTcmmFNvDMxw8EafA=;
	b=DBQeTZm1Vo0+SYvB87M7V0lMbobs+BnRZ5v+sDIOJWom5QKKetOoEqhVU6PHr27fhp/4os
	Tb8El594TwmzQx6s9oV9QNp5hs44C0cJKR+nipTK9FE8rIpcFdZ92lCx4kdKcVMEb1PmA5
	IZAWCQGGKAJHFHdegHD5kxb2/5Oq/r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753472065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8zF3UsrGFMPKubG6ZqWnuxzmTuTcmmFNvDMxw8EafA=;
	b=3mATE9kjfC1lgrzVxqPD6uXTII2kjCFimtM6LlKa0xaa1A9uDwQoyrBzMiypdF/CD9WyOP
	eDP/mINzScSgN2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E57E4134E8;
	Fri, 25 Jul 2025 19:34:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8plJNEDcg2izKwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 25 Jul 2025 19:34:24 +0000
Date: Fri, 25 Jul 2025 20:34:23 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 4/5] mm/mseal: simplify and rename VMA gap check
Message-ID: <ybt4kjtepxaqy4d4ki6z2fzfa3t6mk4tzxe3nqtgoqnr5apipw@a2p55pe5ue2p>
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
 <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri, Jul 25, 2025 at 09:29:44AM +0100, Lorenzo Stoakes wrote:
> The check_mm_seal() function is doing something general - checking whether
> a range contains only VMAs (or rather that it does NOT contain any
> unmapped regions).
> 
> So rename this function to range_contains_unmapped().
> 
> Additionally simplify the logic, we are simply checking whether the last
> vma->vm_end has either a VMA starting after it or ends before the end
> parameter.
> 
> This check is rather dubious, so it is sensible to keep it local to
> mm/mseal.c as at a later stage it may be removed, and we don't want any
> other mm code to perform such a check.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

