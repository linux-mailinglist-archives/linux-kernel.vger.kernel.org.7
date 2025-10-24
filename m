Return-Path: <linux-kernel+bounces-869521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74967C080FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9253ADD3F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD852F25FA;
	Fri, 24 Oct 2025 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AIkWIZE5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/nrS+TbN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AIkWIZE5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/nrS+TbN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B112D0C73
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337665; cv=none; b=FmoFWmrdPDiyzvCI6B43rC6cW7HThK5RcRR8Vs1ykQ6W7B+AS69o8sl91szWF3NWKApdBRb/2owemGRUlQoBF7+BMJgZmmfKVvGU5N6obn0gAI46vhQ4y91ccO7GyQRaWFujNpD8ub5wtUOEChFfWPrZEzomUf6WdTl21j+P+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337665; c=relaxed/simple;
	bh=nY3PZXSRaHiWdPJicaRqeVYSaxkDbZIzFXuDhgWf0b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcRy4NRKlxSuWD5G2+xAZ7Y+HnIyQ/VEVnEq3OGwy56nw8Mk+zinSt6rxA8Dfx16qkADZHeg4lNwoZVhAys9CNlBuHVRqjpSbaBJsVHhKjcCYu0OU+5wTt0s64EZQq4uq8BHTvCJZJhOs8wOwQOY545ghUe39m/uTFRzVM3w7K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AIkWIZE5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/nrS+TbN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AIkWIZE5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/nrS+TbN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54D6A211EC;
	Fri, 24 Oct 2025 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761337662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELyIlQzQ6F11bcetd/x8qz7X8Qn+ndTekMrwM+UQPLU=;
	b=AIkWIZE5Lh5VyQp9olqjiRRSajvSl0wY7y7PonFyKPc/eiWzNIM4CHBM+sSYeG8UL5pQ6G
	MHwPnramYA4EDg+iim9q1JaO2uTsYe2khe4wGCoOU/g0QgswD8UBE2oRsaEHniTYvfTSjy
	7MebrAya+pU3oefIlmZ6S87bfTcMoy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761337662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELyIlQzQ6F11bcetd/x8qz7X8Qn+ndTekMrwM+UQPLU=;
	b=/nrS+TbNbB5XXKGd4NY7Gu5/NQ0KnEteayJKib+4ik2/5vLAIcvfpKtvFOeTim3fFSZjOH
	oUX9ifHN0MkyWFBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761337662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELyIlQzQ6F11bcetd/x8qz7X8Qn+ndTekMrwM+UQPLU=;
	b=AIkWIZE5Lh5VyQp9olqjiRRSajvSl0wY7y7PonFyKPc/eiWzNIM4CHBM+sSYeG8UL5pQ6G
	MHwPnramYA4EDg+iim9q1JaO2uTsYe2khe4wGCoOU/g0QgswD8UBE2oRsaEHniTYvfTSjy
	7MebrAya+pU3oefIlmZ6S87bfTcMoy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761337662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELyIlQzQ6F11bcetd/x8qz7X8Qn+ndTekMrwM+UQPLU=;
	b=/nrS+TbNbB5XXKGd4NY7Gu5/NQ0KnEteayJKib+4ik2/5vLAIcvfpKtvFOeTim3fFSZjOH
	oUX9ifHN0MkyWFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48CB213693;
	Fri, 24 Oct 2025 20:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hwbIDT3h+2hOGAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 24 Oct 2025 20:27:41 +0000
Date: Fri, 24 Oct 2025 21:27:39 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: shmem/tmpfs hugepage defaults config choice
Message-ID: <5dt6roxyx3h4zojls7cvr4nyjtahi33ti2sir2ijr3w4wjliyz@fl32rra6phll>
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu, Oct 23, 2025 at 06:12:02PM +0000, Dmitry Ilvokhin wrote:
> Allow to override defaults for shemem and tmpfs at config time. This is
> consistent with how transparent hugepages can be configured.
> 
> Same results can be achieved with the existing
> 'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' settings
> in the kernel command line, but it is more convenient to define basic
> settings at config time instead of changing kernel command line later.

Why do you need these options instead of using CONFIG_CMDLINE?
They should pull off exactly what you want, but without changing the kernel?

-- 
Pedro

