Return-Path: <linux-kernel+bounces-771247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59A5B284AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D86E1777E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3E33090D8;
	Fri, 15 Aug 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gQBfVZCz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/p860hM2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gQBfVZCz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/p860hM2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E62D7D21
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277612; cv=none; b=Grq7LJxU6kb7dtkB1wkuo3+JEC/6aRj5HMEML67qQQM8e85mb+wn0w4JvezvXjOO/9e7+Egvq2907LE9QuNayZmCavg0f9ymbl3i9JviVJ2bSAjHYhZdAbp9GJWbYTDpUq5C/QTAzssai9LWUJ0rdNCHugwZIvd5ZbbD/6dYtWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277612; c=relaxed/simple;
	bh=u+Q2BrTDVWucSdgFqnUhNllAzs/iEDgWQ5oD4jUk5Zc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaozFM/ldq8ZaaT0Kuid8LlE/PLxCXjGKBtjvdVZaU67YzZwdBpBxrVuXG07wpjhqDt1gE0kQ/dPYlA4DvrjAZUWvYp/ow0jvgeeky15ueyKE164pOMdO85bVif8664o9GVscU7SE6olo661Ffwc5aBlPvHgWN/jA2Oocey1MO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gQBfVZCz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/p860hM2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gQBfVZCz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/p860hM2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 804701F83C;
	Fri, 15 Aug 2025 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755277608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uccM8kZmqedgGup1mx23o04K/x+hNFFVdcMyZEbPEOA=;
	b=gQBfVZCzL8XjVvRVv1xBNgvLDmCwe4Mr6G9J7e7FgwHAOh5HB9WWbi8C2USx89PfWl+SFO
	2BYWOQh4rvoAJvzGJ3yMZZ2UAAn8COQxt31orjfgBl97wj0fOSF3Sq5BCrwCGmvrgtbvDG
	efIJf+gq5NIJivDUHrAA3WTW1FklRMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755277608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uccM8kZmqedgGup1mx23o04K/x+hNFFVdcMyZEbPEOA=;
	b=/p860hM23pO0TV79cBNHKMQE8xdvZJW/8aBzhr/3i/Joh9yE6JubdeBQYa9Z29672nudLp
	4ylUlxeaHKfPfCAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755277608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uccM8kZmqedgGup1mx23o04K/x+hNFFVdcMyZEbPEOA=;
	b=gQBfVZCzL8XjVvRVv1xBNgvLDmCwe4Mr6G9J7e7FgwHAOh5HB9WWbi8C2USx89PfWl+SFO
	2BYWOQh4rvoAJvzGJ3yMZZ2UAAn8COQxt31orjfgBl97wj0fOSF3Sq5BCrwCGmvrgtbvDG
	efIJf+gq5NIJivDUHrAA3WTW1FklRMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755277608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uccM8kZmqedgGup1mx23o04K/x+hNFFVdcMyZEbPEOA=;
	b=/p860hM23pO0TV79cBNHKMQE8xdvZJW/8aBzhr/3i/Joh9yE6JubdeBQYa9Z29672nudLp
	4ylUlxeaHKfPfCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E98071368C;
	Fri, 15 Aug 2025 17:06:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rJHZNSdpn2hzMgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 15 Aug 2025 17:06:47 +0000
Date: Fri, 15 Aug 2025 18:06:49 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH v2 1/3] testing/radix-tree/maple: Hack around kfree_rcu
 not existing
Message-ID: <ttrjb4dhf7w6da3qqlav3kydcpohtimmdewvuxiojdvd3drn5n@rlxb6q656olb>
References: <20250812162124.59417-1-pfalcato@suse.de>
 <rocriz7qo5is6m2dcimj3qiczgv3eoneqwrqvrcpsrtgqnnmmy@eswbhyo2a6w4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rocriz7qo5is6m2dcimj3qiczgv3eoneqwrqvrcpsrtgqnnmmy@eswbhyo2a6w4>
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri, Aug 15, 2025 at 11:11:30AM -0400, Liam R. Howlett wrote:
> * Pedro Falcato <pfalcato@suse.de> [250812 12:21]:
> > liburcu doesn't have kfree_rcu (or anything similar). Despite that, we
> > can hack around it in a trivial fashion, by adding a wrapper.
> > 
> > This wrapper only works for maple_nodes, and not anything else (due to
> > us not being able to know rcu_head offsets in any way), and thus we take
> > advantage of the type checking to avoid future silent breakage.
> > 
> > Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> 
> Andrew,
> 
> Please drop this patch set.  We will have it go through Vlastimil's tree
> to avoid conflicts with other work and to maintain the userspace testing
> in mm-new while that happens.

In case this helps, Andrew, it's maple_tree-use-kfree_rcu-in-ma_free_rcu.patch
and testing-radix-tree-maple-hack-around-kfree_rcu-not-existing.patch in your series file.

(Yes, I should have used a cover letter here, it would've made it easier to
manage, my mistake)

-- 
Pedro

