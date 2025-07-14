Return-Path: <linux-kernel+bounces-730395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE3B0440F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F837B9522
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E21225C6EE;
	Mon, 14 Jul 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SE3SddxO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u4d0yk6R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UMphqWFs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4wOlm/q1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064D258CF1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506822; cv=none; b=KBzjF6/oP+g3skQ9fJ52PMm6Ilp0oPqUb9CBBrLL/xUpvtHQwCt5EslV+xUVAuDmrM/dD+s/kHMhIT7m8oyyYvInWB8A56kJI4k358yx64EB2oyzoKc7RVQI+0NmN0mPI5V4vJnBqGWiSWda4L6EDL4/+uFRCdNDhx5EZ1qdmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506822; c=relaxed/simple;
	bh=fwsw7X6rcthUEQV6Sztu2J9jzvvOh67vwFCbCOFrVpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCMht+Pe1NrHysrAcxG4zOBWV8VXqXq1hZ7q2zHwyjbXSN97elqUDnzxo1MB9ndwvBQZ0HUOa8K8OFZ4YvMMEe0xfK620iZTB8FwHCA2kDr1Q6lWkBxFFP1DuitXKrp042G0Ds8S1dw3hwWdLSkALjJWumO+qqIY3VIcAv47eqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SE3SddxO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u4d0yk6R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UMphqWFs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4wOlm/q1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB17A2125D;
	Mon, 14 Jul 2025 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752506818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r6WQrf9B06ZXx01gkGQoiXd/J1IoGxJsRrJoLtPvLM=;
	b=SE3SddxOCTwN1L/MmCMb7LwPLOViMLfWaxLUIdzbh4U6qWYjky0OIdDg48ZQEIAdTO/+kq
	XAXFCvlnIuXI5AuOziuxrkbwJFU7f7JgNk1Db1nHZRCRywSwS0N7iDYSwjdwlQVzyPNJ9G
	3MgvfX6pA40Rpzklqg6px5/xwlmNOEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752506818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r6WQrf9B06ZXx01gkGQoiXd/J1IoGxJsRrJoLtPvLM=;
	b=u4d0yk6R6ldBuBEAZ2Sl/CwCLcUmO4YQqCmc2c1Z4XfRikEScj81BvLv4HUsNPOh3jMWIY
	Pp4N1VXwYKF+fTCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UMphqWFs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4wOlm/q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752506817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r6WQrf9B06ZXx01gkGQoiXd/J1IoGxJsRrJoLtPvLM=;
	b=UMphqWFsu4UhqLwUOLBxsvdGH9BY0EaXQse0B4fg/8I5iPWnVI9g3GyDHTLI2qSjMg5Xtd
	CCiJtXdgiJo9XRRXLiXv7/QdbGpS9VebtQEtQIrnoFPAdKyJn/v1AYia2vOsSe02sofu4T
	tRVhrWCOVWG1biNWSVAafp7F+WaeaIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752506817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r6WQrf9B06ZXx01gkGQoiXd/J1IoGxJsRrJoLtPvLM=;
	b=4wOlm/q1lR3EwH0TVqNlwc1ll8I34amY4R+Yy6Q316IyOqFb/qsS2RzwSHZ+so2nccLIhD
	qEz4izHjOMk0OiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25E62138A1;
	Mon, 14 Jul 2025 15:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CDM7BcEhdWh6NQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 14 Jul 2025 15:26:57 +0000
Date: Mon, 14 Jul 2025 16:26:55 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 5/5] mm/mseal: rework mseal apply logic
Message-ID: <363qa5eh6npsayupoovhetjco25mrslwzxai5nh4pkm2ept2ej@okwehntdckfr>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <7ff13c42220bc3fc19610e93d5b73637146aa7ae.1752497324.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff13c42220bc3fc19610e93d5b73637146aa7ae.1752497324.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DB17A2125D
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On Mon, Jul 14, 2025 at 02:00:40PM +0100, Lorenzo Stoakes wrote:
> The logic can be simplified - firstly by renaming the inconsistently named
> apply_mm_seal() to mseal_apply().
> 
> We then wrap mseal_fixup() into the main loop as the logic is simple enough
> to not require it, equally it isn't a hugely pleasant pattern in mprotect()
> etc. so it's not something we want to perpetuate.
> 
> We remove some redundant comments, and then avoid the entirely unnecessary
> and slightly bizarre invocation of vma_iter_end() on each loop - really
> what we want, given we have asserted there are no gaps in the range - is to
> handle start, end being offset into a VMAs. This is easily handled with
> MIN()/MAX().
> 
> There's no need to have an 'out' label block since on vma_modify_flags()
> error we abort anyway.
> 
> And by refactoring like this we avoid the rather horrid 'pass pointer to
> prev around' pattern used in mprotect() et al.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks for the cleanup all around :)

-- 
Pedro

