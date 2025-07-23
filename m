Return-Path: <linux-kernel+bounces-742168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39CAB0EE33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7652568438
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F4A2797A4;
	Wed, 23 Jul 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYvXp/6H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPxPU7cX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYvXp/6H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPxPU7cX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC92E36FA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262240; cv=none; b=HPF2vX/nS7jwdhpgUkP7eXWEYSh9Eh0LBtlnlJviKeR03qhkkDJEBz9vFUhCq/3wRSfrJEWTkrd1u77iM/zA5eO4ad6lIFHkE05f2o3dIvVqmr2Gfde+XUuD0szWvJaK2hIY0Q6XQB0coRB7va6voOSwMtk3E0/9ggL72oSn/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262240; c=relaxed/simple;
	bh=PaAb598jBY05sm6JasHgvrnRu0WgD+bNWeelZuvx/gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRXx5E05xmAigNVPK9YIVh5t+TD29R/+MxF7/Bc3UFFNGfvxaFsd+wo9/e9FDJPAXpwjyyKF5QODBknjn4euhTWmrtXG4XpiQRY/LdukWofTtcivxazrsm1s+pKJB4qKMaJA3b27DsXgh0U5pSq/QLWT+5H7WLMpRwNYTVIFn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYvXp/6H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPxPU7cX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYvXp/6H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPxPU7cX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C646B1F449;
	Wed, 23 Jul 2025 09:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753262236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UVlMssvby1yb993DflorYya9fMf7ULYpb5K7ZCVR/QQ=;
	b=cYvXp/6HHgVExIjwjAVxinOeVgIZ30zRsCN2DZO6UBg45M33SS4maL4w4WMcNT0f3NFxP8
	UJDHKfVb70bodbsNkc8lL8GYEYTYeod8TQh+5q0SyFAsHh2mCetI+4Nw+c9R+QpwvL05CV
	3pvsKcuNGrCC4+GyEDnKXuXfZwqp4EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753262236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UVlMssvby1yb993DflorYya9fMf7ULYpb5K7ZCVR/QQ=;
	b=YPxPU7cXW0qfRn6uob62I8yoI1iOKTE501/jCr24E9+QhP3RvDXKS+ESDuSDntaUhDsfYi
	wZEremmY4d3Cz2BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753262236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UVlMssvby1yb993DflorYya9fMf7ULYpb5K7ZCVR/QQ=;
	b=cYvXp/6HHgVExIjwjAVxinOeVgIZ30zRsCN2DZO6UBg45M33SS4maL4w4WMcNT0f3NFxP8
	UJDHKfVb70bodbsNkc8lL8GYEYTYeod8TQh+5q0SyFAsHh2mCetI+4Nw+c9R+QpwvL05CV
	3pvsKcuNGrCC4+GyEDnKXuXfZwqp4EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753262236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UVlMssvby1yb993DflorYya9fMf7ULYpb5K7ZCVR/QQ=;
	b=YPxPU7cXW0qfRn6uob62I8yoI1iOKTE501/jCr24E9+QhP3RvDXKS+ESDuSDntaUhDsfYi
	wZEremmY4d3Cz2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EA5913302;
	Wed, 23 Jul 2025 09:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6NUHJpyogGgQVAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Jul 2025 09:17:16 +0000
Message-ID: <fb5426c1-c94b-4e79-b09a-fb6b8b1ce03b@suse.cz>
Date: Wed, 23 Jul 2025 11:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add stack trace when bad rss-counter state is
 detected
Content-Language: en-US
To: Xuanye Liu <liuqiye2025@163.com>, David Hildenbrand <david@redhat.com>,
 Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250723072350.1742071-1-liuqiye2025@163.com>
 <202507230031.52B5C2B53@keescook>
 <c7a32d87-efbd-47bd-9a18-9eb51e441a7f@163.com>
 <119c3422-0bb1-4806-b81c-ccf1c7aeba4d@redhat.com>
 <8dd1e8f6-f96d-4d36-ac2a-c258ac842f75@redhat.com>
 <5cdd3e44-3e3c-4697-905a-ecc61093f7bc@163.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <5cdd3e44-3e3c-4697-905a-ecc61093f7bc@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[163.com,redhat.com,kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/23/25 11:10, Xuanye Liu wrote:
> 
> 在 2025/7/23 16:42, David Hildenbrand 写道:
>> On 23.07.25 10:05, David Hildenbrand wrote:
>>> On 23.07.25 09:45, Xuanye Liu wrote:
>>>>
>>>> 在 2025/7/23 15:31, Kees Cook 写道:
>>>>> On Wed, Jul 23, 2025 at 03:23:49PM +0800, Xuanye Liu wrote:
>>>>>> The check_mm() function verifies the correctness of rss counters in
>>>>>> struct mm_struct. Currently, it only prints an alert when a bad
>>>>>> rss-counter state is detected, but lacks sufficient context for
>>>>>> debugging.
>>>>>>
>>>>>> This patch adds a dump_stack() call to provide a stack trace when
>>>>>> the rss-counter state is invalid. This helps developers identify
>>>>>> where the corrupted mm_struct is being checked and trace the
>>>>>> underlying cause of the inconsistency.
>>>>> Why not just convert the pr_alert to a WARN?
>>>> Good idea! I'll gather more feedback from others and then update to v2.
>>>
>>> Makes sense to me.
>>
>> After discussion this with Lorenzo off-list, isn't the stack completely misleading/useless in that case?
>>
>> Whatever caused the RSS counter mismatch (e.g., unmapped the wrong pages, missed to unmap pages) quite possibly happened in different context, way way earlier.
>>
>> Why would you think the stack trace would be of any value when destroying an MM (__mmdrop)?
>>
>> Having that said, I really hate these "pr_*("BUG: ...") with passion. Probably we'd want to invoke the panic_on_warn machinery, because something unexpected happened.
>>
> The stack trace dumped here may indeed not reflect the root cause ——
> the actual error could have occurred much earlier, for example during a
> failed or missing page map/unmap operation.
> The current stack (e.g., in __mmdrop() or exit_mmap()) is merely part
> of the cleanup phase.
> 
> Given that, how should we go about identifying the root cause when such an issue occurs?
> 
> Is there any existing way to trace it more effectively, or could we introduce a new mechanism
> to monitor and detect these inconsistencies earlier?                                         
> 
> Let’s brainstorm possible solutions together.

Excellent idea! How about we introduce a function that walks the whole page
tables and checks the numbers of individual pte types against the rss
counters. And if we invoke it before and after every single pte update, we
can pinpoint much sooner the moment it went wrong and the stack that lead to it?

