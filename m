Return-Path: <linux-kernel+bounces-810239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A461B5179A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317FE487138
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387030E0D3;
	Wed, 10 Sep 2025 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RU/uBY3b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FfUSJVXS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RH6Xz5OP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1XKXjTvv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE79330CD9C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509693; cv=none; b=NCHhMIS/u9jDJTyQJwsYNPQo8gk4vgT2TqFegdJuagemhdxBT8UOhNwQEpbYkoftTsPUAoMKNOaUPv5KtUQKG9DjwO1bLb3wE31EcY0v35rSUeMtfujOw/XGIC+34g1HzNlaymaJNtWOMrXr7kSJEEPk80xsajdCwJF09aB8ShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509693; c=relaxed/simple;
	bh=URvDUjc3xIkeiYuFXs8TEGGMYq8tBPCrcKr7xiCvNwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daFsldYTglxisCOehXyhIwWURDc3tCEuZGpvVIFkpOx+dU+V0KEqAYGyFHNc4a4OU2K+S0aqb33zmzXkeeES4YKFgW7Gt3rzQ6ne2S/5MhPbDlhVcIV2wvVS7vl6iTqGs4xiqcYXt00WUFpw6971zDPxDOhsRHoWwLWO9ApSxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RU/uBY3b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FfUSJVXS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RH6Xz5OP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1XKXjTvv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8306533B96;
	Wed, 10 Sep 2025 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757509689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=relwdfeW8kjZZ1uxYeqyI8QEzX2UIZebEjkKJ/MG6xE=;
	b=RU/uBY3bu5qdZoymGdLMbFNaHP87hzrIm4JlKiqr+A0G42mR4xkT5hIgsbZdGwfXLjeFjG
	CAxNVMc/N5jiOc5lVxyQ8WZm14T4jmCOcTbkzTyMijboYGYPI6+VkZ31VG9zLv1kZXh//H
	CteRLaPxqZp1Novq/ouvykFIIoCsEDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757509689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=relwdfeW8kjZZ1uxYeqyI8QEzX2UIZebEjkKJ/MG6xE=;
	b=FfUSJVXSupM6eUZwikrTwms564oNH/d811+wd144+RvJ8T1R6OVGUXHyLBNGipFlRj994g
	FVOFX5iSZ+FKP0Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RH6Xz5OP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1XKXjTvv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757509688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=relwdfeW8kjZZ1uxYeqyI8QEzX2UIZebEjkKJ/MG6xE=;
	b=RH6Xz5OPsrpHDxiYvgyJitqo4x5gbm1HaQ9VoKhsBdxR/M3VHDWYafhiogful84XwBvZ/9
	c6W/ddQcZ85/eHy6wnGWVNq/gtD89aP0ur5i3FvvfAgWD4imeoFzvYx4FCWwpRl8osMGCS
	R7/MUzqoe82UdzyWCvR7dMuqAHOz9RI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757509688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=relwdfeW8kjZZ1uxYeqyI8QEzX2UIZebEjkKJ/MG6xE=;
	b=1XKXjTvv1yKKqXqNwnkonB7EBS2FBpX9Pt9rKzZGr7mioCktm16jXskHfTpEA5tVtlsues
	zD7RU4YmZo/PjHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 528B613301;
	Wed, 10 Sep 2025 13:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /BQ0EDd4wWjGCAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 10 Sep 2025 13:08:07 +0000
Date: Wed, 10 Sep 2025 14:08:01 +0100
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
Subject: Re: [PATCH v1 4/9] mm/memory: Add tree limit to free_pgtables()
Message-ID: <3pn4anukobmyhul2zw6cqwl4nvu47ecji4cldgsfer24p35k6s@km5dfxpzvzzf>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-5-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190945.1030905-5-Liam.Howlett@oracle.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8306533B96
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Tue, Sep 09, 2025 at 03:09:40PM -0400, Liam R. Howlett wrote:
> The ceiling and tree search limit need to be different arguments for the
> future change in the failed fork attempt.
> 
> Add some documentation around free_pgtables() and the limits in an
> attempt to clarify the floor and ceiling use as well as the new
> tree_max.
> 
> Test code also updated.
> 
> No functional changes intended.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

