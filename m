Return-Path: <linux-kernel+bounces-798264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55547B41B71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B19056094F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC042E8B9C;
	Wed,  3 Sep 2025 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ka8DlS8J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IFyZVI5p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TSk2r2yf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6QCIR5q4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD01A256E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894349; cv=none; b=V5CGcgUL95KjAbI9KgimS8d3Tabv+acNslF94HSghhQ5ohxfjZ5ryQcNxWxrv1foXn9s3gJe1hrRIPw9oNgmYBfo6LGRryiExrA0K2T8DKgDtHulaEfh/8wELbi09/JNCxChxGmBS0GnInakt5JRLFfMGWq6oYBQ9tHqbJOcpQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894349; c=relaxed/simple;
	bh=6yKZ4/92id+e4ufSMFTEN0uz3bkqxtN/V24a2vRd9sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tvgzzu6WRpKejUj8/jgN7YwI2VOhmEH5HkJt5pdlyDhulPbgliJwDcAx9g6hUua05GAEaZedA6YM4oFCuxyt/XF5qMnoS3khQSpWMuYfF5Hrbgwk2anBhXJlWFJT/Tt7eQCD1rimmhimRoB/5b1MtBEdWPPc41SpHGN82PnvLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ka8DlS8J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IFyZVI5p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TSk2r2yf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6QCIR5q4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF6C31F745;
	Wed,  3 Sep 2025 10:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756894345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JX2P414we82oQn/fjI5R8Qh1x2tILT3GyyIhOHEW2yQ=;
	b=Ka8DlS8J2iPhlxAyx45NPpVpQ4fI6CQAwzYiObY8zfH2s7bzh+I3tnvedfzh61Zv2snPq6
	CXy9q8oPCey8gOjS5c0JJpt+va02kHKjTBkVC3QMZjAJsXCbWPeMSWIQd694t620IiYyBs
	xSJ/p+FJYEsLPCUoQlexBlOpncnOBhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756894345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JX2P414we82oQn/fjI5R8Qh1x2tILT3GyyIhOHEW2yQ=;
	b=IFyZVI5pSZnAun+of2BkxaL1iZ0EaCDy7s7xEg5gUS0HIv3/tNnq2YJPm60ljOrnMJywFG
	Fo84HHIjbsJ2y2Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TSk2r2yf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6QCIR5q4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756894344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JX2P414we82oQn/fjI5R8Qh1x2tILT3GyyIhOHEW2yQ=;
	b=TSk2r2yf2nSQC7psvlaWPLjN8MSRQA86aaX1iPIH6qws0jz8urAjQw2QEmiHEwJnc+N0j3
	Nke0KyQMnhhIG5gXcZ6JPReGjOPMiR5b5xQh0TjdSq6GBKXl61TBywyCU1BH96fKvlZ7zN
	qEL3ekZ+LvdYL6qBc00fEDZ6VbdIUBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756894344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JX2P414we82oQn/fjI5R8Qh1x2tILT3GyyIhOHEW2yQ=;
	b=6QCIR5q47hG9OxuUw1nTe+Jbk13Pw7hTwC+HRE8yGfu0GGwaiwS40gO28ncd3UZ+AnlXvE
	C8ue/6RxqF8MZMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B69A913A31;
	Wed,  3 Sep 2025 10:12:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1o9BLIgUuGjcfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 10:12:24 +0000
Message-ID: <1e153ab8-57c3-466c-b56d-2c3967aee038@suse.cz>
Date: Wed, 3 Sep 2025 12:12:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/show_mem: Dump the status of the mem alloc
 profiling before printing
Content-Language: en-US
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Vishal Moola <vishal.moola@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif <usamaarif642@gmail.com>,
 linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <cover.1756827906.git.pyyjason@gmail.com>
 <8dc71d31de53afa4c0bb25234807b1e6ead5ba55.1756827906.git.pyyjason@gmail.com>
 <ef1b79ab-15cb-4720-ab05-d77617143a26@suse.cz>
 <aLgLoal9q7Zx7Yto@devbig569.cln6.facebook.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aLgLoal9q7Zx7Yto@devbig569.cln6.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,suse.com,cmpxchg.org,nvidia.com,gmail.com,linux.dev,kvack.org,meta.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: CF6C31F745
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On 9/3/25 11:34, Yueyang Pan wrote:
> On Wed, Sep 03, 2025 at 11:26:01AM +0200, Vlastimil Babka wrote:
>> On 9/2/25 17:57, Yueyang Pan wrote:
>> > This patch prints the status of the memory allocation profiling
>> > before __show_mem actually prints the detailed allocation info.
>> > This way will let us know the `0B` we saw in allocation info is
>> > because the profiling is disabled or the allocation is actually
>> > 0B.
>> > 
>> > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
>> > ---
>> >  mm/show_mem.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> > 
>> > diff --git a/mm/show_mem.c b/mm/show_mem.c
>> > index ecf20a93ea54..51892ce2efc4 100644
>> > --- a/mm/show_mem.c
>> > +++ b/mm/show_mem.c
>> > @@ -427,6 +427,8 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>> >  
>> >  		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
>> >  		if (nr) {
>> > +			pr_notice("Memory alloction profiling is turned %s\n",
>> 
>> There's a typo "alloction".
> 
> Nice catch. Thanks!
> 
>> 
>> > +				mem_alloc_profiling_enabled() ? "on" : "off");
>> >  			pr_notice("Memory allocations:\n");
>> 
>> But I think the message would be more obvious if it said e.g.:
>> 
>> "Memory allocations (profiling is currently [on/off]):"
> 
> I can change it in the next version. I saw Andrew gave approval. In this case, shall 
> I send v3 or create a new patch?

You can send v3 (given patch 2/2 needs warning fix too) and Andrew can
replace or convert to fixups.

>> 
>> >  			for (i = 0; i < nr; i++) {
>> >  				struct codetag *ct = tags[i].ct;
>> 
> 
> Thanks
> Pan


