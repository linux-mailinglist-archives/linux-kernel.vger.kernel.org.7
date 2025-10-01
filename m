Return-Path: <linux-kernel+bounces-838750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53159BB011D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCE9188B579
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857BD2C0F7D;
	Wed,  1 Oct 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oasM6Diy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pZNUj2vW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oasM6Diy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pZNUj2vW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7A2C0F93
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316173; cv=none; b=P4WQtR83dFO9S2n/IeQKkff8GFnqvd7SUadQ7FWaQrUApcqlb3C5S9T2hrUM/a9EqS7e2r7eFp4ge4gCMGVYN7t/Cg/sM8Dt+m4KSRmoM8b9CvH+OXLILskM2465F+TeZPoxX/tJNLWzU4dPE8FKuJQv+rttaQTkKgqNh0UcNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316173; c=relaxed/simple;
	bh=GzFCidf8TZm02g/wFHUsnPOxpLGXomChw4tgFQx2eeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2u0Dba7ndT/23/RIP2FRBTBRdeQYuFsoNNsxIgvud3ZZjyl/6tSpw6NMGQgyj0PU6Oc55jqY2+GnSsM6YHn7SjyH97s1v0jxfuVzTkVSwGh3uxskiO3Dp4DkkmX8H/pOnuvklRwQjxq04zKGyoLm5oNcy1L46Jh2rvFM9bCeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oasM6Diy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pZNUj2vW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oasM6Diy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pZNUj2vW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0AC922ACA;
	Wed,  1 Oct 2025 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759316169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpePL461P7LsNb38EA5EBCrLN87PvsNeyDTc8FDW4ww=;
	b=oasM6DiyM2kyMCNTGIAYlVkqmuNLZi8GAubQecgC+xqhk20yQDljW8iTL9YJmLPw1O5OFW
	z8pBByI1Z/DIrd9ncqSoxwme6OV4WBmIgVTl7F7AP+DSK6y2B/edVMEVU622UH7oq5awIt
	fyWkwEDG/TxDXiK8ToWQ3gNCaXhEjks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759316169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpePL461P7LsNb38EA5EBCrLN87PvsNeyDTc8FDW4ww=;
	b=pZNUj2vWzGza9ZshzzOh9mzR2No65ac/H9H9BRuOMF5WGnimvNxVZNMaGiBeOS2fsIe5HL
	OdWIUP3n5cPmGOCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oasM6Diy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pZNUj2vW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759316169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpePL461P7LsNb38EA5EBCrLN87PvsNeyDTc8FDW4ww=;
	b=oasM6DiyM2kyMCNTGIAYlVkqmuNLZi8GAubQecgC+xqhk20yQDljW8iTL9YJmLPw1O5OFW
	z8pBByI1Z/DIrd9ncqSoxwme6OV4WBmIgVTl7F7AP+DSK6y2B/edVMEVU622UH7oq5awIt
	fyWkwEDG/TxDXiK8ToWQ3gNCaXhEjks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759316169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpePL461P7LsNb38EA5EBCrLN87PvsNeyDTc8FDW4ww=;
	b=pZNUj2vWzGza9ZshzzOh9mzR2No65ac/H9H9BRuOMF5WGnimvNxVZNMaGiBeOS2fsIe5HL
	OdWIUP3n5cPmGOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9A6713A42;
	Wed,  1 Oct 2025 10:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l3XrLMkI3WgGYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 01 Oct 2025 10:56:09 +0000
Message-ID: <602271e2-86c9-4a63-845a-b84407d3aa51@suse.cz>
Date: Wed, 1 Oct 2025 12:58:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm/page_owner: add options 'print_handle' and
 'print_stack' for 'show_stacks'
To: Michal Hocko <mhocko@suse.com>,
 Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20250924174023.261125-1-mfo@igalia.com>
 <aNVpFn9W0jYYr9vs@tiehlicka> <4c2a467113efd085530eb055e4a4e1fe@igalia.com>
 <aNY49sdoFVe03m_Y@tiehlicka> <d9af42d5cb9d427632087c5f51e50501@igalia.com>
 <aNvjDsBuw3hqwy31@tiehlicka>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <aNvjDsBuw3hqwy31@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D0AC922ACA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 9/30/25 4:02 PM, Michal Hocko wrote:
> On Fri 26-09-25 13:47:15, Mauricio Faria de Oliveira wrote:
>>> My main question is whether this should squashed into the existing file
>>> with a rather strange semantic of controling the file content depending
>>> on a different file content. Instead, would it make more sense to add
>>> two more files, one to display your requested key:value data and another
>>> to resolve key -> stack trace?
>>
>> I see your point. Either way works for me, honestly.
>> Let me justify the current way, but it's certainly OK to change it, if
>> that is preferred.
>>
>> The use of option files has precedents in page_owner itself
>> (count_threshould) and ftrace (/sys/kernel/debug/trace/options/*).
>>
>> The use of output files needs more code/complexity for a similar result,
>> AFAICT (I actually started it this way, but changed it to minimize
>> changes). 
>> The reason is debugfs_create_bool() is more specialized/simpler to
>> handle than debugfs_create_file().
>>
>> It ends up with a similar pattern in a common "__stack_print()" to avoid
>> duplicate code (conditions on parameters to configure the output), and
>> it adds:
>> - 2 ops structs per file (file_operations and seq_operations, as in
>> 'show_stacks'), for plumbing different behaviors down to different
>> functions, to call the common function with different parameters.
>> - It should be possible to reduce it with private fields (from
>> debugfs_create_file(data) to seq_file.private), however, since
>> seq_file.private is used (iterator in stack_start|next()), this needs
>> more code: a new struct for the private field (to store the current
>> iterator and add the new parameters).
>>
>> So, I went for the (IMHO) simpler and smaller implementation with option
>> files instead of output files.
>>
>> Please let me know which way is preferred, and I'll send v2 with that
>> (in addition to the changelog suggestions).
> 
> Sure, I see. The main problem with the option file is that it is
> inherently suited for a single consumer which is a hard assumption to
> make at this stage. So I think it is worth having a separate 2 files
> which provide the missing functionality.

Agreed, we should prioritize a better userspace API over having simpler
kernel implementation.

Will count_threshold apply the same to the new file that prints only
handles? I guess it will?

Also the handles to stack translation file could perhaps support
"seeking" to a specific handle if you're interested in only a few
handles. Perhaps not necessary though if you plan to read it all just once.

> Thanks!


