Return-Path: <linux-kernel+bounces-747750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF6B1379E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5F67A203F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6625228F;
	Mon, 28 Jul 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MV3XvI68";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EOCcelY1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uy2a9FaF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3qE+6ezY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91619A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695470; cv=none; b=koNnl3tTfrKG1ZF5EgLPO+VzDcl7OEqNTVpyMPdXJDOZcWhaqhvCOi52U2EPD+erI1OKmfdpFgEjUs50ZO5iKLHSocJxrBlFSA9D31yGAovknEnk5c9wAOY3hjAjdHz8s6+Zr/AzxJxEplw2kVQrP8Wlp61rNA5dRoPgCGB5Ors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695470; c=relaxed/simple;
	bh=40sZnwx669YtA+xdRLx1Qh3tj22ZHgEWNQ1ZijbgY4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmOJ38nWSu85ME5IzSgHFi0vk/9MzhJ9haF/rT6Xf7Pncefx7mYsh5j/TD/5YNxaSDmoKuTMhocSJVJ7744j6znS9ohvVyv5060gxH6vx8Kmfs09WFnITH+03B4qNFR656bdzlRkVSIKaMNs/GZ+i6/wh8ltaSY4mT97d5I6rrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MV3XvI68; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EOCcelY1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uy2a9FaF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3qE+6ezY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D57651F46E;
	Mon, 28 Jul 2025 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753695467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IE9U6OMxCGjM6BaaeVh2n1CZTcMjCiAKBAY0TDI91Y=;
	b=MV3XvI68EaAhDVxo0SZpjxp/6+QieP/lRCdrWRKZWAMej5hc6P4zIfWpOx79wULT+OGIEW
	aGpl623uhF7n0xsjjSz4+881P7cDIv2r3cC1oazCPP+03yYgeeLCWBBOT70PqWnBdV1soJ
	IQAyzoHRwyicmdJyHT0iu4MLtiXK5lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753695467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IE9U6OMxCGjM6BaaeVh2n1CZTcMjCiAKBAY0TDI91Y=;
	b=EOCcelY1PknPkxy+zT3zymPiusp/dZaPQL+COkF+RX0VbjVEP6p2cYFdadD4t7rq8RPbko
	MAag9Sxia71ViIDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Uy2a9FaF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3qE+6ezY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753695466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IE9U6OMxCGjM6BaaeVh2n1CZTcMjCiAKBAY0TDI91Y=;
	b=Uy2a9FaFYIDG3OYqn39VLGXtjI/s8QZ5CGKpXmC2k5OnmIT8c/6d2AxcxqZDyx2zaTT/59
	6JFf3kt4YUdYC+b2WO842Nyvp5NJyw1fyfvLkQIY5ZWby4F/XGsUGdVmfGXgJgQAa49Lqs
	IAPihb/JepChPq4DjVpq97c00MOhkIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753695466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IE9U6OMxCGjM6BaaeVh2n1CZTcMjCiAKBAY0TDI91Y=;
	b=3qE+6ezYP763Q8OH6fEKmjdCrsQfo1PxQVfXs6yD3tiQaRvWTKOdceZM4bCkNMd0aj821d
	QI7sDSOdgyTVuyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE8D01368A;
	Mon, 28 Jul 2025 09:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gZvDLepEh2jjMAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 28 Jul 2025 09:37:46 +0000
Message-ID: <f859e5c3-7c96-4d97-a447-75070813450c@suse.de>
Date: Mon, 28 Jul 2025 11:37:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D57651F46E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 7/28/25 11:10, David Hildenbrand wrote:
> On 28.07.25 11:04, Michal Hocko wrote:
>> On Mon 28-07-25 10:53:08, David Hildenbrand wrote:
>>> On 28.07.25 10:48, Michal Hocko wrote:
>>>> On Mon 28-07-25 10:15:47, Oscar Salvador wrote:
>>>>> Hi,
>>>>>
>>>>> Currently, we have several mechanisms to pick a zone for the new 
>>>>> memory we are
>>>>> onlining.
>>>>> Eventually, we will land on zone_for_pfn_range() which will pick 
>>>>> the zone.
>>>>>
>>>>> Two of these mechanisms are 'movable_node' and 'auto-movable' policy.
>>>>> The former will put every single hotpluggled memory in ZONE_MOVABLE
>>>>> (unless we can keep zones contiguous by not doing so), while the 
>>>>> latter
>>>>> will put it in ZONA_MOVABLE IFF we are within the established ratio
>>>>> MOVABLE:KERNEL.
>>>>>
>>>>> It seems, the later doesn't play well with CXL memory where CXL 
>>>>> cards hold really
>>>>> large amounts of memory, making the ratio fail, and since CXL cards 
>>>>> must be removed
>>>>> as a unit, it can't be done if any memory block fell within
>>>>> !ZONE_MOVABLE zone.
>>>>
>>>> I suspect this is just an example of how our existing memory hotplug
>>>> interface based on memory blocks is just suoptimal and it doesn't fit
>>>> new usecases. We should start thinking about how a new v2 api should
>>>> look like. I am not sure how that should look like but I believe we
>>>> should be able to express a "device" as whole rather than having a very
>>>> loosely bound generic memblocks. Anyway this is likely for a longer
>>>> discussion and a long term plan rather than addressing this particular
>>>> issue.
>>>
>>> We have that concept with memory groups in the kernel already.
>>
>> I must have missed that. I will have a look, thanks! Do we have any
>> documentation for that? Memory group is an overloaded term in the
>> kernel.
> 
> It's an internal concept so far, the grouping is not exposed to user space.
> 
> We have kerneldoc for e.g., "struct memory_group". E.g., from there
> 
> "A memory group logically groups memory blocks; each memory block 
> belongs to at most one memory group. A memory group corresponds to a 
> memory device, such as a DIMM or a NUMA node, which spans multiple 
> memory blocks and might even span multiple non-contiguous physical 
> memory ranges."
> 
>>
>>> In dax/kmem we register a static memory group. It will be considered one
>>> union.
>>
>> But we still do export those memory blocks and let udev or whoever act
>> on those right? If that is the case then ....
> 
> Yes.
> 
>>
>> [...]
>>
>>> daxctl wants to online memory itself. We want to keep that memory 
>>> offline
>>> from a kernel perspective and let daxctl handle it in this case.
>>>
>>> We have that problem in RHEL where we currently require user space to
>>> disable udev rules so daxctl "can win".
>>
>> ... this is the result. Those shouldn't really race. If udev is suppose
>> to see the device then only in its entirity so regular memory block
>> based onlining rules shouldn't even see that memory. Or am I completely
>> missing the picture?
> 
> We can't break user space, which relies on individual memory blocks.
> 
> So udev or $whatever will right now see individual memory blocks. We 
> could export the group id to user space if that is of any help, but at 
> least for daxctl purposes, it will be sufficient to identify "oh, this 
> was added by dax/kmem" (which we can obtain from /proc/iomem) and say 
> "okay, I'll let user-space deal with it."
> 
> Having the whole thing exposed as a unit is not really solving any 
> problems unless I am missing something important.
> 
Basically it boils down to:
Who should be responsible for onlining the memory?

As it stands we have two methods:
- user-space as per sysfs attributes
- kernel policy

And to make matters worse, we have two competing user-space programs:
- udev
- daxctl
neither of which is (or can be made) aware of each other.
This leads to races and/or inconsistencies.

As we've seen the current kernel policy (cf the 'ratio' discussion)
doesn't really fit how users expect CXL to work, so one is tempted to
not having the kernel to do the onlining. But then the user is caught
in the udev vs daxctl race, requiring awkward cludges on either side.

Can't we make daxctl aware of udev? IE updating daxctl call out to
udev and just wait for udev to complete its thing?
At worst we're running into a timeout if some udev rules are garbage,
but daxctl will be able to see the final state and we would avoid
the need for modifying and/or moving udev rules.
(Which, incidentally, is required on SLES, too :-)

Discussion point for LPC?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

