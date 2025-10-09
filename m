Return-Path: <linux-kernel+bounces-846462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4472BC8112
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E88C3AA8F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E792857F2;
	Thu,  9 Oct 2025 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kL3ktFL5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FD6L3X29";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="taOkQvsj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ISTxMOjt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44134BA38
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999034; cv=none; b=dwF+fbsHj0vqTDRrQVXVJa2WEwLxAG/C3fhVO5G4RJndYQSYr+pz47LXU1vwLx9VGOkn1c0Wm/r0rvMXJfjhpuGe4Ov2GYWmm5dTZt9Z1axyyAzcDCILrBHOKrEF0/8oFrEKFOWda7/9UrwXAFGfrdfjGBT8GwV9x45GCGzp6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999034; c=relaxed/simple;
	bh=kHnHsSDN4lvamCyp10kKr6nZ74n4jqO3Ig2S+14bxDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKGVKFz1fJ3w8+wnuzdvVV8Wl1edIQsCs1ILa4OZLJUOxPMffdcgo2g4BOV2QK6lMcRuTYwIJWjTpX/p8wgfiS4t00qZBfb8Uy/nxR3Ex/49MkMsXsniZtDzkOZcAGVM4wbabRwehMFzGL34BfF2iUy47u0/PsCPghJyFVMSz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kL3ktFL5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FD6L3X29; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=taOkQvsj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ISTxMOjt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63EE51F849;
	Thu,  9 Oct 2025 08:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759999030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLHJUMcs8cKGTkdNpbowpIOfVp7jR8lMa18VcOcGcw4=;
	b=kL3ktFL5hdwhjBRZxX8bVvsngqhOPMdItNsNESeUQHBJAb37gPz//iFhlg5oCsURRqGBVG
	tuVxNCxbPGtE2UKQ+Vbc93hWGOVRdofTIQbUt2QdhAOwp6Zbcj4XbEX6G2J+x8JR3KouLC
	UDXgdzz6pBlRmSZC8GkeOebvCibv8+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759999030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLHJUMcs8cKGTkdNpbowpIOfVp7jR8lMa18VcOcGcw4=;
	b=FD6L3X29KJtnzCYzRQhYaWzmqyit5mavYQjURUl7+Woi0MZdjo75/LrpS33M2L3U7/b7f3
	kPWhalWE60PhCDDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759999029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLHJUMcs8cKGTkdNpbowpIOfVp7jR8lMa18VcOcGcw4=;
	b=taOkQvsjGVo9HZOqqJ2gid452GUv4Orc56MeYjjPORpBERlPaspov1MtIH/k9tCW0igW80
	+o5qCrspooCetfuRg9xp7+wN9KfEA/Yo+ffAE2U7efxjsdOAYIAjrcQkA0yo83jbomKhUb
	SWEcS5Vo6yno/uPw+5+iqp5doo6aSqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759999029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLHJUMcs8cKGTkdNpbowpIOfVp7jR8lMa18VcOcGcw4=;
	b=ISTxMOjtEEOdFTgIVvxdSkW7De1IQ5tv4BqHh2g6R/sb4mTWPhaqxlX7NcBY7IlQdn49Jg
	PP2HAfxF0qWUhcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF1E213AAC;
	Thu,  9 Oct 2025 08:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tIrmKzR052iDGgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 09 Oct 2025 08:37:08 +0000
Date: Thu, 9 Oct 2025 10:37:03 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH v2 3/5] mm/page_owner: add debugfs file 'show_handles'
Message-ID: <aOd0L1asypia7HB9@localhost.localdomain>
References: <20251001175611.575861-1-mfo@igalia.com>
 <20251001175611.575861-4-mfo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001175611.575861-4-mfo@igalia.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On Wed, Oct 01, 2025 at 02:56:09PM -0300, Mauricio Faria de Oliveira wrote:
> Add the flag STACK_PRINT_FLAG_HANDLE to print a stack's handle number
> from stackdepot, and add the file 'show_handles' to show just handles
> and their number of pages.
> 
> This is similar to 'show_stacks', with handles instead of stack traces.
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

