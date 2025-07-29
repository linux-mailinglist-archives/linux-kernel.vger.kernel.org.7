Return-Path: <linux-kernel+bounces-749472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8993EB14EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD71189839C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667C1A0B0E;
	Tue, 29 Jul 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="09CbSNjb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y30teTyJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="09CbSNjb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y30teTyJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB779C0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797163; cv=none; b=eXhwhBAiBRc4EP/L65waOi77lEUcDwRsydcccTBR0mC5R1Vag8gGcUNfAYpg5ztWV/S9PgW+gQKHoW5Y1ywr/fgeafjTLAu+KEO3bDOQcDn1s/93tjOF9tYrXBCMWCYCXcBnXZ3E8FaaU39P+6kFQ8kdwlAMvIwYjy8U3Wgw7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797163; c=relaxed/simple;
	bh=xkKjPxVb5ugAjahjCh90kyqCzUluysq+yVEA8GUmfgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8wv2igvsSJBrhzKT7KSfXjD/29BpcHVk/AWJ0YnqbHhbqmFL4EsjaaW96aFzMhoMdLsRGnKwyKl6XGJjH0f3ebwgl0/riFE1MZo3T9U5h2KFjJeDR0WgRRwq9W71aaL89IJZ7uaPDcPOqsiEaPwxbsaqrEmaVoCSOaZJGpfLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=09CbSNjb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y30teTyJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=09CbSNjb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y30teTyJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 358F01F385;
	Tue, 29 Jul 2025 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753797159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5UptxTlc7NV15QNmaQUOhxOZX0UPYQKqfHL7gIMJik=;
	b=09CbSNjbuqrVikMD+7H4izSIWfIEYIC6+yBgvwka+tVU3JZ+6DYqAWCdh01Mo0gdkqVABk
	z69i16Fsu0B05b/9evPTjsrPXac2fL0TY5TZUGJJK15uA6Zp4uZZzVXok86n/1oKHolTY1
	UrkmncEXO4OkxEiiau2fbZwxW0q/Yqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753797159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5UptxTlc7NV15QNmaQUOhxOZX0UPYQKqfHL7gIMJik=;
	b=Y30teTyJHv1aRlrlTEZR0cVmdygViEie19/02UqXtJnHS2j4H6GezefvOkvFdGDLLQlq4D
	dMNEnOuzQ/9F8eDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=09CbSNjb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y30teTyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753797159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5UptxTlc7NV15QNmaQUOhxOZX0UPYQKqfHL7gIMJik=;
	b=09CbSNjbuqrVikMD+7H4izSIWfIEYIC6+yBgvwka+tVU3JZ+6DYqAWCdh01Mo0gdkqVABk
	z69i16Fsu0B05b/9evPTjsrPXac2fL0TY5TZUGJJK15uA6Zp4uZZzVXok86n/1oKHolTY1
	UrkmncEXO4OkxEiiau2fbZwxW0q/Yqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753797159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5UptxTlc7NV15QNmaQUOhxOZX0UPYQKqfHL7gIMJik=;
	b=Y30teTyJHv1aRlrlTEZR0cVmdygViEie19/02UqXtJnHS2j4H6GezefvOkvFdGDLLQlq4D
	dMNEnOuzQ/9F8eDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EF6013A73;
	Tue, 29 Jul 2025 13:52:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9+xVBifSiGiJJwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 13:52:39 +0000
Message-ID: <568fbe41-e73e-41b9-b147-a5ef419a2251@suse.de>
Date: Tue, 29 Jul 2025 15:52:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>
References: <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <f859e5c3-7c96-4d97-a447-75070813450c@suse.de> <aId16W4EaqjANtKR@tiehlicka>
 <3e88642f-3914-42b0-b864-4ad374b659b5@redhat.com>
 <ac7add36-808d-4883-a09e-ef1bf6fd6834@suse.de> <aIiSEpQhWqPsvaST@tiehlicka>
 <41526d97-b3bc-423b-87f4-7e0ec6cd8292@suse.de> <aIi3ao2PV8GrYtRA@tiehlicka>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aIi3ao2PV8GrYtRA@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 358F01F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 7/29/25 13:58, Michal Hocko wrote:
> On Tue 29-07-25 11:33:58, Hannes Reinecke wrote:
>> On 7/29/25 11:19, Michal Hocko wrote:
>>> On Tue 29-07-25 09:24:37, Hannes Reinecke wrote:
>>>> On 7/28/25 15:08, David Hildenbrand wrote:
>>>>> On 28.07.25 15:06, Michal Hocko wrote:
>>>>>> On Mon 28-07-25 11:37:46, Hannes Reinecke wrote:
>>>>>>> On 7/28/25 11:10, David Hildenbrand wrote:
>>>>>>> And to make matters worse, we have two competing user-space programs:
>>>>>>> - udev
>>>>>>> - daxctl
>>>>>>> neither of which is (or can be made) aware of each other.
>>>>>>> This leads to races and/or inconsistencies.
>>>>>>
>>>>>> Would it help if generic udev memory hotplug rule exclude anything that
>>>>>> is dax backed? Is there a way to check for that? Sorry if this is a
>>>>>> stupid question.
>>>>> Parsing /proc/iomem, it's indicated as "System RAM (kmem)".
>>>>>
>>>> I would rather do it the other way round, and make daxctl aware of
>>>> udev. In the end, even 'daxctl' uses the sysfs interface to online
>>>> memory, which really is the territory of udev and can easily be
>>>> done via udev rules (for static configuration).
>>>
>>> udev doesn't really have any context what user space wants to do with
>>> the memory and therefore how to online it. Therefore we have (arguably)
>>> ugly hacks like auto onlining and movable_ration etc. daxctl can take
>>> information from the admin directly and therfore it can do what is
>>> needed without further hacks.
>>>
>> Huh?
>> I thought udev was _all_ about userspace preferences...
>> We can easily have udev rules onlining memory with whatever policy
>> the user want; the whole point of udev rules is that they are dynamic
>> and can include policy decisions.
> 
> My experience with memory hotplug and udev doesn't match that. Udev
> sees memory blocks showing up rather than understanding any concept of
> what is the memory behind that. So any actual policy is rather hard to
> define. You would need to backtrack what kind of memory blocks you are
> seeing and what the initiator could have intended with them.
> 
> While this could work reasonably for regular RAM appearing to your
> system asynchronously (e.g. physical memory plugged in or virtual system
> getting more memory) when you always want to online it in a certain way
> I suspect this falls short for synchronous daxctl like usecase where you
> know what to do with that memory and you can operate on sysfs directly.
> Udev just makes the life much more complicated for the later IMO.

Not disagreeing with that.
Problem is that memory hotplug is tied to sysfs (and, with that, to
udev) such that currently there is no way of _not_ sending uevents
(and, consequently, udev interfering).

We could (for any of the 'auto' modes) disable uevent generation
via the dev_set_uevent_suppress() thingie.
Or we could teach daxctl to wait for uevents after an action has
been triggered.

But the current situation is really daft, requiring the user to move
away udev rules in specific situations.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

