Return-Path: <linux-kernel+bounces-844009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F41BC0D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1342834CB3E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C372D5940;
	Tue,  7 Oct 2025 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ljO1R0bB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BxvMRXFM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="axDO3gJN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PFqMaes1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D21192D68
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828307; cv=none; b=o7xUwqsE5EszY/jM9fzCabZYj4GRg2BbfxYtbDxUKUjyqGdjJOwGH4U6vDMzAsu7OxvsFzgabljfbqz6R0kayalgTBZ93UyXTCqJAUHz8PDbzHvOxHihCckq3ixwcJ8og1nDW/HhFA25sU/9RxWRY2DbdgcB27Yg0LZdfVKG6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828307; c=relaxed/simple;
	bh=UGEiUTwCseva8xZzmqHLyj3bDKqh0Jkv0kwO8vjCsOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8FYGhMzXGG2RlLXARss+gsArVoQdP1t4fRY6MOXisDWYP/yZwVXIgIlKMaG+YQCptmregFEJ0ZmPyvzDXJjA/NNGL8FiXHlQHjvVYapBOMJH9Wabmx+uTdX5K6JbVXq0pLQ1OgeGFB73ub9QEU01Z7Ye7ofSqk3oToHoAIOIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ljO1R0bB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BxvMRXFM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=axDO3gJN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PFqMaes1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id E2F5B336F3;
	Tue,  7 Oct 2025 09:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759828303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLP+glegqIJBcIb7jt0bclmibbjRxFmE8iklM/lj5FI=;
	b=ljO1R0bBwHZiKasEy6MhvQCSGMlm4+xEKkcMA41IC56HN4tKhzzPOFm+eTkjrQzqilrVK3
	UC/yHR6APtQGnjhomDeck1bgfmzaVQmrry8QRd0kPAGBVcwOP8DGrFPGvbqISCnAjhGulb
	rNU4Uie76wFo5+5DZz5J1iEYpTP2aB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759828303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLP+glegqIJBcIb7jt0bclmibbjRxFmE8iklM/lj5FI=;
	b=BxvMRXFMc97Quk4/ZugYs8ialO0F/RJfEsI5Q5x9B6YX01gaJ6jzvuX/oaR8uw2O4xZmKE
	tgpgxhSKqSLMDnBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759828302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLP+glegqIJBcIb7jt0bclmibbjRxFmE8iklM/lj5FI=;
	b=axDO3gJNswuZeSVfGNwO0ejXnMY06seTp6gjJMbJxdhX3zGYuYB+jGZzlZM9q38syn3Fsu
	PTTnLxfztDzoPNnl44gYiGimfP+ZKAa3Xa3bFoFZkLbFgvafB+E9gjyLbj6iSWDxovtWEu
	5ZB1LFMsTFU1K4kTHxrCz0+chEO9V9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759828302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLP+glegqIJBcIb7jt0bclmibbjRxFmE8iklM/lj5FI=;
	b=PFqMaes1rrVopcuRe9tYuxzoLI7wyEtAd2Tb16TNVlhte9BwGzUA/0Q8CyM/FJdYAMDYMS
	W9iYjQfFKU399tBA==
Date: Tue, 7 Oct 2025 11:11:42 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>
Cc: David Hildenbrand <dhildenb@redhat.com>,
	Breno Leitao <leitao@debian.org>, kas@kernel.org, riel@surriel.com,
	vbabka@suse.cz, nphamcs@gmail.com, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aOTZTji039KEJ1T0@dwarf.suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
 <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
 <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[redhat.com,debian.org,kernel.org,surriel.com,suse.cz,gmail.com,lists.infradead.org,linux-foundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Tue, Oct 07, 2025 at 11:55:36AM +0800, Baoquan He wrote:
> And I saw Jiri has excluded the crashk_cma_ranges[] from the dumped
> content via elf_header_exclude_ranges(). 

Exactly, thanks for pointing this out, while I was away from my e-mail.

The crashkernel CMA reservation ranges will not be seen at all by
makedumpfile.

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


