Return-Path: <linux-kernel+bounces-838973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB475BB08CD
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4690C1926D45
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BD72EF65C;
	Wed,  1 Oct 2025 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tAZQS6W0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ImepUTZ9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qPDGAH8H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2vI/BOL5"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EB2EF662
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326278; cv=none; b=kyPHnf7B0xC2kLuZaT7S8JAzOrGxBpNCx02UhXapVq/LZL7f1gNnwIt5f90zeG7PbBqddl03N/3DKuPWHEVf/xyZgKcFeTqjqrhtzxFiq4kXzghY7t8HOJQ54/Mr6gRenlrhFIzYR2X79EIWxnV61Dy1155EPsitjdYXdaG6eVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326278; c=relaxed/simple;
	bh=qnkQn0A6KGDvcva2esuMlW0oO5TUAFsi8rVWOErsEy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6vR6l4OqwAFNqAj1LbJIoKsPsP0xpRN8lPpzEE0EVSZDz9QKOPDoVSiPqTAgA5PryxB2DGrgY5R+dAnQgp2uzkV09ZgDuScMu0Wo43y9Qg/thG2qep23sAfb4i+6tTL2Ka/9Klhgf5iP/ldRKuxQYzoz6AIvDOYX7c/fmWvwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tAZQS6W0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ImepUTZ9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qPDGAH8H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2vI/BOL5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DDEF91FB78;
	Wed,  1 Oct 2025 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759326270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXKm7uHno0RVrdO73gZiJiNWmspDgiTH3SIvPr6Kuoc=;
	b=tAZQS6W0FbVDQeHSwQjxvc272crMvd4NBWS1wZw7slpKHmXmg3kBzznZ0CS4RvhNlg9vJd
	65PsILbe+5cHsTQm2oDb107QA3clz2+qlkI5GvrPijUN62bGp5/XPp7rtZPvpTeViIrPCk
	kYVVZjXBFD8BTB4qhNkhrFQY1GfetT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759326270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXKm7uHno0RVrdO73gZiJiNWmspDgiTH3SIvPr6Kuoc=;
	b=ImepUTZ9j4xdyUYX1G71yNrcxM7HqH5lzp3dv9QxXsvjUY4EbsZ/7Z3E1vHNMtkaLUOMhW
	gXB2akPgAMVKoCAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qPDGAH8H;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="2vI/BOL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759326269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXKm7uHno0RVrdO73gZiJiNWmspDgiTH3SIvPr6Kuoc=;
	b=qPDGAH8HeVB1km9OJ37bqLFvz98qM5hOngA7YJgjUURS88LsWeKUPqMvM/CYAeDR7zyf30
	LYrvTMoaipqBdUYpmf35ZKHLjZzCg3B3G8g6lsfSoc9/Otyb0EAOUVBYW+VMRraNnb72Za
	GKrqsuLtv56952NDNWUVHG9h/Rj87KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759326269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXKm7uHno0RVrdO73gZiJiNWmspDgiTH3SIvPr6Kuoc=;
	b=2vI/BOL5LTZ2nP5Obmklz30pGvsvgQ5xks0R41jESgSffubPqLzvrfSdL9epIWClBCuGig
	5Tn8B/oXUBeUD2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C869E13A3F;
	Wed,  1 Oct 2025 13:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2MuFMD0w3WhwGAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 01 Oct 2025 13:44:29 +0000
Message-ID: <e261a18d-0ea3-4fba-9774-aa58270809af@suse.cz>
Date: Wed, 1 Oct 2025 15:47:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/page_owner: simplify zone iteration logic in
 init_early_allocated_pages()
To: Hu Song <husong@kylinos.cn>, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250930092153.843109-1-husong@kylinos.cn>
 <20250930092153.843109-2-husong@kylinos.cn>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250930092153.843109-2-husong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,kylinos.cn:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: DDEF91FB78
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 9/30/25 11:21 AM, Hu Song wrote:
> From: Song Hu <husong@kylinos.cn>
> 
> The current implementation uses nested loops: first iterating over all
> online nodes, then over zones within each node. This can be simplified
> by using the for_each_populated_zone() macro which directly iterates
> through all populated zones.
> 
> This change:
> 1. Removes the intermediate init_zones_in_node() function
> 2. Simplifies init_early_allocated_pages() to use direct zone iteration
> 3. Updates init_pages_in_zone() to take only zone parameter and access
>    node_id via zone->zone_pgdat
> 
> The functionality remains identical, but the code is cleaner and more
> maintainable.
> 
> Signed-off-by: Song Hu <husong@kylinos.cn>

LGTM.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


