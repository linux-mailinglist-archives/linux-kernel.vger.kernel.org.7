Return-Path: <linux-kernel+bounces-838693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED58BAFF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6825F2A01BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA1F29A31C;
	Wed,  1 Oct 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B9FzD2Cm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rE7Fvyhn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Q34JIqo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MoEEEght"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBB274FF9
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759312937; cv=none; b=nGTvPo2swfhp7TtsQYKma0xqjnButxxjC1nGtQvempsQFSfvuGFKN/hkS7mPFKPW4UYvVuC6eCt1P3uy4R4iJd84IKzJNWew0UYssmXaazstZF1oXVUs4FdMpHT5JWaYtrLl5YM+D40xKcg+1xu9JzfHClIEsumqNEQaUHk779Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759312937; c=relaxed/simple;
	bh=N2u3ve/1Lf+ttycZJO2sIPHhofQDe7Vrp8ijoawtE7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEuPewoz0ixctON6AF5DFeLCqxXQAfk4hQGt1tzkQf1BpyjLZpi8zu6lgx3bU/ssf2FRLKMdlJDzj99vF8N3y81TIT6ep+hWVr70YjAsNampSxyNgc9IrA18Nr8nkgBxiWOh6OOfZVyDmzUvQ+0b9oB5tE2HaEkgYYujsylAZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B9FzD2Cm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rE7Fvyhn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Q34JIqo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MoEEEght; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73D05337A4;
	Wed,  1 Oct 2025 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759312927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TeD8soTHHIxNG6f1XpozFfG0T75bKxyP4oAiQvd6izY=;
	b=B9FzD2CmxCKFVebzqdQFEmlFPt22S5EjbPIZsp5yuBxLvpL2KhgiMsO3t/8Vmqt6K1UNZT
	49/iHf+B2diTqIB7UsT74yjk/ZCBv0ScegguvGT/1yls0y5ZoCs6zYctvXUbmNXskGi5JR
	xBdFGx79WsPyL+7Y5KjxhnTJ059SYdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759312927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TeD8soTHHIxNG6f1XpozFfG0T75bKxyP4oAiQvd6izY=;
	b=rE7Fvyhn6OtfaFyfpp7h8JxLtJ8put0GTFpJcbtzTgPtwUTzJoOAEruZQ4AJ2JHU610MGn
	yryK6oe4i9gtjyCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759312922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TeD8soTHHIxNG6f1XpozFfG0T75bKxyP4oAiQvd6izY=;
	b=1Q34JIqoIlXithAOEHLzWztElhn0iwwC96rDV8SdaTwxGABhyDCYq0uAV83MN0P8ZucKDs
	l/iVkqQEMJkjsTKhEn+KKP/Pw5mo0K+R4l05nHz6X8/O++069/pdI8niE5plSB2kocUShZ
	GdbvO75HMwJgqdVLP4CP3/pIzRDVdNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759312922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TeD8soTHHIxNG6f1XpozFfG0T75bKxyP4oAiQvd6izY=;
	b=MoEEEght4a9SSGw6MaP8wY4NdyUJBcKUM41d2/gKPD11aN9SydwUf+/RU3WfNcMLBOzQVQ
	AyqDU9CCA+2KtXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6185313A42;
	Wed,  1 Oct 2025 10:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eeKCFxr83GhJTwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 01 Oct 2025 10:02:02 +0000
Message-ID: <689e36d4-d828-42c5-9e57-ba663adc9ea9@suse.cz>
Date: Wed, 1 Oct 2025 12:04:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm/page_alloc: Batch page freeing in
 free_frozen_page_commit
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Chris Mason <clm@fb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Kiryl Shutsemau <kirill@shutemov.name>, Brendan Jackman
 <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>,
 Suren Baghdasaryan <surenb@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20250929151744.2922386-1-joshua.hahnjy@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250929151744.2922386-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[intel.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 9/29/25 5:17 PM, Joshua Hahn wrote:
> On Sun, 28 Sep 2025 13:17:37 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> 
> Hello Kernel Test Robot,
> 
>> Hello,
>>
>> kernel test robot noticed "WARNING:bad_unlock_balance_detected" on:
>>
>> commit: 7e86100bfb0d65a17f3228a9af4c2a49ac38f057 ("[PATCH v2 4/4] mm/page_alloc: Batch page freeing in free_frozen_page_commit")
>> url: https://github.com/intel-lab-lkp/linux/commits/Joshua-Hahn/mm-page_alloc-vmstat-Simplify-refresh_cpu_vm_stats-change-detection/20250925-044532
>> patch link: https://lore.kernel.org/all/20250924204409.1706524-5-joshua.hahnjy@gmail.com/
>> patch subject: [PATCH v2 4/4] mm/page_alloc: Batch page freeing in free_frozen_page_commit
>>
>> in testcase: trinity
>> version: 
>> with following parameters:
>>
>> 	runtime: 300s
>> 	group: group-03
>> 	nr_groups: 5
>>
>> config: x86_64-randconfig-161-20250927
>> compiler: gcc-14
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202509281204.3086f707-lkp@intel.com
>>
>>
>> [  414.880298][ T7549] WARNING: bad unlock balance detected!
>> [  414.881071][ T7549] 6.17.0-rc6-00147-g7e86100bfb0d #1 Not tainted
>> [  414.881924][ T7549] -------------------------------------
>> [  414.882695][ T7549] date/7549 is trying to release lock (&pcp->lock) at:
>> [ 414.883649][ T7549] free_frozen_page_commit+0x425/0x9d0 
>> [  414.884764][ T7549] but there are no more locks to release!
>> [  414.885539][ T7549]
>> [  414.885539][ T7549] other info that might help us debug this:
>> [  414.886704][ T7549] 2 locks held by date/7549:
>> [ 414.887353][ T7549] #0: ffff888104f29940 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap (include/linux/seqlock.h:431 include/linux/mmap_lock.h:88 include/linux/mmap_lock.h:398 mm/mmap.c:1288) 
>> [ 414.888591][ T7549] #1: ffff8883ae40e858 (&pcp->lock){+.+.}-{3:3}, at: free_frozen_page_commit+0x46a/0x9d0 
> 
> So based on this, it seems like I must have overlooked a pretty important
> consideration here. When I unlock the pcp, it allows both the zone and pcp
> lock to be picked up by another task (pcp lock less likely), but it also
> means that this process can be migrated to a different CPU, where it will
> be trying to unlock & acquire a completely different pcp.

Yes.

> For me the most simple solution looks to be migrate_disable() and
> migrate_enable() in the function to ensure that this task is bound to the
> CPU it originally started runing on.
> 
> I'm not sure how this will affect performance, but I think in terms of

It is somewhat expensive, I'd rather avoid if possible.

> desired behavior it does seem like this is the correct way to do it.

I'd rather detect this happened (new pcp doesn't match old pcp after a
relock) and either give up (should be rare enough hopefully so won't
cause much imbalance) or recalculate how much to free on the other cpu
and continue there (probably subtract how much we already did so we
don't end up unlucky flushing all kinds of cpus "forever").

> Joshua


