Return-Path: <linux-kernel+bounces-625558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956AEAA17F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 19:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCB39A601C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55AC250C0C;
	Tue, 29 Apr 2025 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BFbaX4nJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ipjcTets";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BFbaX4nJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ipjcTets"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1F22AE68
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948939; cv=none; b=sHBKv3AWknJufbP3/tMw69M96218DlJ8mk83/hPwFKsdvPgmS5PCXo1uEfoA/h233jd8XiZJtsQWu4groq48dscK8KSRYR5Dnqk3cqPq7FTtTsrpn6YB7hPbA/kiRoXomO5EE0rfoN4+sMeTD/wd1bgKq5ASe9AqpDOrNShwT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948939; c=relaxed/simple;
	bh=VUKN+GAIv79NtJdeoiY8Nk3o8/Qj9yVNEeAR87SZdPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtG8FKzok223F8KwJ1vLoN5b4e+8z8KzT6jyx+MEc8B+g5+jJ9fOm9+D5ITYgBMwVmz5Gw3PfTxu3XvZbZbAzlBp4iZ8Dm3Lw+mvz+TP1TXShOdYdPKmYL0fGKBMMIPxLKY6XZ/JTAkUM5ImDHgCbPCy1lcnktk5Vo6SUz0oXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BFbaX4nJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ipjcTets; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BFbaX4nJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ipjcTets; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5936E1F391;
	Tue, 29 Apr 2025 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745948935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTHNAhL1imP4GkDhXUvjZKI3AbLRKvWJAvbA1bxankc=;
	b=BFbaX4nJAwTBBAnxUyQSfr55ulQflvKe6ZAbSYX87t1Gp8kazIbi4MvzFuCLZWcRWlDAX9
	T7G9tUHmETHIa0vTsLhMGBzrIwhcknEAAV8IiCFdAfnxlzCckeMQ3fn4075GQAG0cmo+zc
	wUCnBPFXA0nn+soXRx1kWabTAQ5PQ0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745948935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTHNAhL1imP4GkDhXUvjZKI3AbLRKvWJAvbA1bxankc=;
	b=ipjcTetsXy8srqbFtLmajErI1oOrE4zMUG0JEo1kJajm73qrX+KYW5APKmFCHbQM5xDTcE
	B/Wo8ZuBM+EpBpBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BFbaX4nJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ipjcTets
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745948935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTHNAhL1imP4GkDhXUvjZKI3AbLRKvWJAvbA1bxankc=;
	b=BFbaX4nJAwTBBAnxUyQSfr55ulQflvKe6ZAbSYX87t1Gp8kazIbi4MvzFuCLZWcRWlDAX9
	T7G9tUHmETHIa0vTsLhMGBzrIwhcknEAAV8IiCFdAfnxlzCckeMQ3fn4075GQAG0cmo+zc
	wUCnBPFXA0nn+soXRx1kWabTAQ5PQ0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745948935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTHNAhL1imP4GkDhXUvjZKI3AbLRKvWJAvbA1bxankc=;
	b=ipjcTetsXy8srqbFtLmajErI1oOrE4zMUG0JEo1kJajm73qrX+KYW5APKmFCHbQM5xDTcE
	B/Wo8ZuBM+EpBpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D14D1340C;
	Tue, 29 Apr 2025 17:48:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t89uFwYREWhJNgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 29 Apr 2025 17:48:54 +0000
Date: Tue, 29 Apr 2025 18:48:52 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm: abstract initial stack setup to mm subsystem
Message-ID: <tb7ljmdnl2fazf47l6seqzln2dpva3kyoszug6g76wjio3dhmc@dns4n2zqrdqe>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <118c950ef7a8dd19ab20a23a68c3603751acd30e.1745853549.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118c950ef7a8dd19ab20a23a68c3603751acd30e.1745853549.git.lorenzo.stoakes@oracle.com>
X-Rspamd-Queue-Id: 5936E1F391
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email,suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon, Apr 28, 2025 at 04:28:15PM +0100, Lorenzo Stoakes wrote:
> There are peculiarities within the kernel where what is very clearly mm
> code is performed elsewhere arbitrarily.
> 
> This violates separation of concerns and makes it harder to refactor code
> to make changes to how fundamental initialisation and operation of mm logic
> is performed.
> 
> One such case is the creation of the VMA containing the initial stack upon
> execve()'ing a new process. This is currently performed in __bprm_mm_init()
> in fs/exec.c.
> 
> Abstract this operation to create_init_stack_vma(). This allows us to limit
> use of vma allocation and free code to fork and mm only.
> 
> We previously did the same for the step at which we relocate the initial
> stack VMA downwards via relocate_vma_down(), now we move the initial VMA
> establishment too.
> 
> Take the opportunity to also move insert_vm_struct() to mm/vma.c as it's no
> longer needed anywhere outside of mm.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

