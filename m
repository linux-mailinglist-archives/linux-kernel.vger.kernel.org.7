Return-Path: <linux-kernel+bounces-788325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08BDB382D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3DD46178B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC096335BBB;
	Wed, 27 Aug 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WLlgGSvQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xjMmKgE4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WLlgGSvQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xjMmKgE4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2D29ACF7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299010; cv=none; b=Xgiq5aeYF75BJHjkoPNVqaYHyblwZkbz77XVQk/kDwMT1XYimXxsmIeSZo+8Lw4n2GOyu6Vgf13oelYyF17ktT6wqEUl2rX/Qu1yCyiMG6Je+OvrFwvefBz24LFlpE63BFQiKPEBf0jBj547gF9K+8eVpvhmpJw//wxMeI8siLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299010; c=relaxed/simple;
	bh=XKTOZcfNA5C/e61OoJFgohlt7HAssGalfhSBLI8klas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7Wm4rzIC2EuhEwWC2F99gelqOetJEQU3NC46CKiSkAVXKWutcu1JPBCxcjFwgUlmMBY9YhjCMRDigxq8QdCuZLQUWkqRJ61Olou2kOP8bfDPoIPdg5KqOxmEtVAFAN01EEvj/pQHRDv+z6/60v8GiVJnrI8AArDj8eyuuuFtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WLlgGSvQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xjMmKgE4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WLlgGSvQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xjMmKgE4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7ADD922158;
	Wed, 27 Aug 2025 12:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756299006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v54dIouATmnuSJr9b8zCG6xfHOxa95s8DPKUADFVBJ4=;
	b=WLlgGSvQdmBmSFqlypFXfova6OT68TCMH+3yNLF8/o7uBtjjqFEFw77UEAR6cfTwx2+l2B
	fViUzc2WvOhRBXNZXNWE5+k9fyxOtWTQa9k/b170NhVGylQcc6lBvP4MVuPm/RpiuIKD4T
	Q7dT4rjd4S8/EQBo6vzc2GdTYVNsAFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756299006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v54dIouATmnuSJr9b8zCG6xfHOxa95s8DPKUADFVBJ4=;
	b=xjMmKgE4nXH8y5ipv+22VMpKZxMeY+3yqCPtIXHNUAnDRsMKXmV+u3GC3oqj1OYj6R6nxl
	86QWtd6KWULJpwBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756299006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v54dIouATmnuSJr9b8zCG6xfHOxa95s8DPKUADFVBJ4=;
	b=WLlgGSvQdmBmSFqlypFXfova6OT68TCMH+3yNLF8/o7uBtjjqFEFw77UEAR6cfTwx2+l2B
	fViUzc2WvOhRBXNZXNWE5+k9fyxOtWTQa9k/b170NhVGylQcc6lBvP4MVuPm/RpiuIKD4T
	Q7dT4rjd4S8/EQBo6vzc2GdTYVNsAFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756299006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v54dIouATmnuSJr9b8zCG6xfHOxa95s8DPKUADFVBJ4=;
	b=xjMmKgE4nXH8y5ipv+22VMpKZxMeY+3yqCPtIXHNUAnDRsMKXmV+u3GC3oqj1OYj6R6nxl
	86QWtd6KWULJpwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7E9113310;
	Wed, 27 Aug 2025 12:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MuuRMf3+rmjIWQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 27 Aug 2025 12:50:05 +0000
Date: Wed, 27 Aug 2025 13:50:09 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] tools: testing: Allow importing arch headers in
 shared.mk
Message-ID: <j2vfxy4sr6wmuovlynvljvmy6as7esevp57hyqkhofxnxnjldf@ul6befrh7eqy>
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
 <20250827-b4-vma-no-atomic-h-v1-1-5d3a94ae670f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-b4-vma-no-atomic-h-v1-1-5d3a94ae670f@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed, Aug 27, 2025 at 11:04:41AM +0000, Brendan Jackman wrote:
> There is an arch/ tree under tools. This contains some useful stuff, to
> make that available, import the necessary Make helper file and then add
> it to the -I flags.
> 
> There still aren't that many headers so also just smush all of them into
> SHARED_DEPS instead of starting to do any header dependency hocus pocus.
>

I was a little confused as to why this patchset was safe, and - yeah - i missed
the arch/ under tools/.

There are asm-generic headers so hopefully those fully take care of !x86? Did
you check?

In any case:
Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

