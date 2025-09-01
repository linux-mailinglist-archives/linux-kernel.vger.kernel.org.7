Return-Path: <linux-kernel+bounces-794336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F8B3E023
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6507A501B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B6230AACC;
	Mon,  1 Sep 2025 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o5mX3sK+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ROkKFYzV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o5mX3sK+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ROkKFYzV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655317C203
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722550; cv=none; b=pLOLOAD9mn+MGwuX7xUJU157Enp74pvpaL822/qI6p0d8we3eg7mmrkVkN6LAtYQyzeZ/VFlfZ7TUfHJZUBrc1WGIEIV0EJ02zX9BDcRG2rupFhEW1Gl/T5U6jH80J22wE1FJqVKe1RoAr4qeHDvv7JgKc2FmR3QcFFt7ObCKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722550; c=relaxed/simple;
	bh=QBV0jxINzsvl7WbSLlgSDtVaOObhEIzMmtssUD2sTuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udk3QkMlBt6pikjvUNkDVIW1hrbIuqiQW1BZierfQMo6+45HUsWmUDf/7eq9GDAMwlJfY/uWVGw/nvSdyT+6xcmboMkm61zWX1hhe2GwYt5+YmOOD7utK3gsjb6P/jLxILrg62ak1YdIUJ4HDAcwUE6PJ4hhTTtriCFF09zT1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o5mX3sK+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ROkKFYzV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o5mX3sK+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ROkKFYzV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 536D621168;
	Mon,  1 Sep 2025 10:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756722547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IstnSSEM6WhAWS9C4yTrjF1j9Id2QMVd3M4qbSZkQLA=;
	b=o5mX3sK++eSAy2qDUmuR5hEyWelNlWLOA73OACqLo0g96WPBsRKyn5ScPIqYiku3p1YNQH
	oDMCXV+1JseOSAoINlTolNqbvmkEJiCxOGdfetKtBrf1pSjkbiqNeriR578kjvWcTjxrUZ
	BusA0NBYQg2V6fISaLVfqXDTwWaKndY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756722547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IstnSSEM6WhAWS9C4yTrjF1j9Id2QMVd3M4qbSZkQLA=;
	b=ROkKFYzVgxAFxj65pnf9qtvf3LkhVlzeFDDpjqx2rRuNm4AL5/ZQ/dQMgo0tk763wCnufh
	BzFd+LBbMfhBOLDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756722547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IstnSSEM6WhAWS9C4yTrjF1j9Id2QMVd3M4qbSZkQLA=;
	b=o5mX3sK++eSAy2qDUmuR5hEyWelNlWLOA73OACqLo0g96WPBsRKyn5ScPIqYiku3p1YNQH
	oDMCXV+1JseOSAoINlTolNqbvmkEJiCxOGdfetKtBrf1pSjkbiqNeriR578kjvWcTjxrUZ
	BusA0NBYQg2V6fISaLVfqXDTwWaKndY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756722547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IstnSSEM6WhAWS9C4yTrjF1j9Id2QMVd3M4qbSZkQLA=;
	b=ROkKFYzVgxAFxj65pnf9qtvf3LkhVlzeFDDpjqx2rRuNm4AL5/ZQ/dQMgo0tk763wCnufh
	BzFd+LBbMfhBOLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACD03136ED;
	Mon,  1 Sep 2025 10:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qlHpJnJ1tWg0AgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 01 Sep 2025 10:29:06 +0000
Date: Mon, 1 Sep 2025 11:29:05 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/4] tools: testing: Use existing atomic.h for
 vma/maple tests
Message-ID: <q5chl5fnmaj6wxlj3aclz7n3k4bz5sgjfliao37wdiefi32mgi@wxefcss6cmqp>
References: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
 <20250828-b4-vma-no-atomic-h-v2-4-02d146a58ed2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-b4-vma-no-atomic-h-v2-4-02d146a58ed2@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu, Aug 28, 2025 at 12:28:01PM +0000, Brendan Jackman wrote:
> The shared userspace logic used for unit-testing maple tree and VMA code
> currently has its own replacements for atomics helpers. This is not
> needed as the necessary APIs already have userspace implementations in
> the tools tree. Switching over to that allows deleting a bit of code.
> 
> Note that the implementation is different; while the version being
> deleted here is implemented using liburcu, the existing version in tools
> uses either x86 asm or compiler builtins. It's assumed that both are
> equally likely to be correct.
> 
> The tools tree's version of atomic_t is a struct type while the version
> being deleted was just a typedef of an integer. This means it's no
> longer valid to call __sync_bool_compare_and_swap() directly on it. One
> option would be to just peek into the struct and call it on the field,
> but it seems a little cleaner to just use the corresponding atomic.h
> API whic has been added recently. Now the fake mapping_map_writable() is
> copied from the real one.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

> ---
>  tools/testing/shared/linux/maple_tree.h |  6 ++----
>  tools/testing/vma/linux/atomic.h        | 17 -----------------
>  tools/testing/vma/vma_internal.h        | 12 +++---------
>  3 files changed, 5 insertions(+), 30 deletions(-)

Yay, less code! :)

-- 
Pedro

