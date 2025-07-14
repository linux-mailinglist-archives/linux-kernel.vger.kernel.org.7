Return-Path: <linux-kernel+bounces-730350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5101B0437D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634671889097
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EB925DAFC;
	Mon, 14 Jul 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMbY1MfK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zVYdg2Ze";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMbY1MfK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zVYdg2Ze"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D026462C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506249; cv=none; b=hn7Icng1+LGz2YL1GDAICvCQkXEw9mqsdBCvrDyxPHCLwJLZRqePVWv1ThoDkjDFHSIpFmwfl4W85BpbSHoWLaN8kc1g2SbLHDBDf76wSqipF5qgXK04XtTf4hXAxAd1k6/stNh7pmzFj/F4ZWnF3B0ARSVrbBNe3eUPRSM7OdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506249; c=relaxed/simple;
	bh=pvx+rnEG+pRdnEsmGBRt2WAcbaVmmfHZwiZQyRlW8fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpjQYTxoz8Ql3wjWCNun64sGG3pKswnp6BI9vxUeDuBhAx7AHmW/4IEbHDZ3o2BGp+xu8dLB786w35W3bblkBaK3y23+8bIVBILIOF7lsPgWWCQbU2TiuX51qnoKWOwnD+lp3iFugLfuSojXzzqYIoLZeH5NS4/GgfrthMPHTLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMbY1MfK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zVYdg2Ze; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMbY1MfK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zVYdg2Ze; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F0E21F798;
	Mon, 14 Jul 2025 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752506246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01705O/qpAXgfDjMNMcfb/7BJ30UiGgLyw1fsG6kHyc=;
	b=TMbY1MfKHhUcAXOR5da6cdsvh+oxEVnMjyvc5DRsvdLKWSd4Nu5pojzUUNqtJxOvKYxiO6
	3IfJFNu1phpXZqp1TmUvoHrL60PLZ7yyJESTr7nRhmRLA/tjv0JGsEbV+BD/jtExHZJWMH
	pt15mAN2oxjwrDcpc/LSJGGy/on72qM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752506246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01705O/qpAXgfDjMNMcfb/7BJ30UiGgLyw1fsG6kHyc=;
	b=zVYdg2Ze1q8ei92tN7s0DY/8YEMOmO8CuOMZ1YFKfex0mrWBSGl2+7Mn0i0ooapDq8HCFI
	DR2pgh7NqV+Kw3CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752506246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01705O/qpAXgfDjMNMcfb/7BJ30UiGgLyw1fsG6kHyc=;
	b=TMbY1MfKHhUcAXOR5da6cdsvh+oxEVnMjyvc5DRsvdLKWSd4Nu5pojzUUNqtJxOvKYxiO6
	3IfJFNu1phpXZqp1TmUvoHrL60PLZ7yyJESTr7nRhmRLA/tjv0JGsEbV+BD/jtExHZJWMH
	pt15mAN2oxjwrDcpc/LSJGGy/on72qM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752506246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01705O/qpAXgfDjMNMcfb/7BJ30UiGgLyw1fsG6kHyc=;
	b=zVYdg2Ze1q8ei92tN7s0DY/8YEMOmO8CuOMZ1YFKfex0mrWBSGl2+7Mn0i0ooapDq8HCFI
	DR2pgh7NqV+Kw3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64784138A1;
	Mon, 14 Jul 2025 15:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id syvNFIUfdWgXMgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 14 Jul 2025 15:17:25 +0000
Date: Mon, 14 Jul 2025 16:17:23 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
Message-ID: <ky2jvl6uyi75qwfmpwzmwu6qfnlwxshk2zunywe3pve2pshdxj@p2ihhzov3imx>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Mon, Jul 14, 2025 at 02:00:39PM +0100, Lorenzo Stoakes wrote:
> The check_mm_seal() function is doing something general - checking whether
> a range contains only VMAs (or rather that it does NOT contain any unmapped
> regions).
> 
> Generalise this and put the logic in mm/vma.c - introducing
> range_contains_unmapped(). Additionally we can simplify the logic, we are
> simply checking whether the last vma->vm_end has either a VMA starting
> after it or ends before the end parameter.
>

I don't like this. Unless you have any other user for this in mind,
we'll proliferate this awful behavior (and add this into core vma code).

I have some patches locally to fully remove this upfront check, and AFAIK
we're somewhat in agreement that we can simply nuke this check (for
various reasons, including that we *still* don't have a man page for the
syscall). I can send them for proper discussion after your series lands.

-- 
Pedro

