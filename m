Return-Path: <linux-kernel+bounces-749194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A39EB14B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CA71AA423D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A562877D0;
	Tue, 29 Jul 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nCPWu8FI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LvD8E65l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nCPWu8FI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LvD8E65l"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34898F6E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781642; cv=none; b=ox7VaLt7Ud2JDpAgoendsOxqp04CJBnluA+1y76qjVvhUfAYE6U2hyaPHrmSYFeCd8X2LGcGGcg+OPKVN9xoYQMhL/VkaQPMUw6F2PvJtiiaLzfyVmfWXsDabtxn7P2yIkNb+yl49b374t78yALB4OCYu7VHzUygFFVX5OjB2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781642; c=relaxed/simple;
	bh=3yq5puzXs8S1PNbw2FX+acubrZNFWbyDyGp2L0ew7mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1tmBggwkiQIfrkS/KQuZsgDUiNgE8PdXy0q84KQ+LM7o+QkheAtSGmj2pPRDSmns8cpziA5lrL9xpByj1Xrr3zLi+CISDhTqA8NBMZ1mxa4MPtZeQFibL/sD10lsCsBuFm7XX0z0k7/MBE9HZ6g7OPRWaWPVIFWaiQfK8iWFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nCPWu8FI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LvD8E65l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nCPWu8FI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LvD8E65l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22EFB219EE;
	Tue, 29 Jul 2025 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753781639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1Ol3IOwokV2gFS2XNvt3TlezxClZn1L3WQLcEZeGBs=;
	b=nCPWu8FIoK/1/ulsLh86lMUXeFjGShnQcs45DiGutK5briCI1SSWpthEy+NSaCxUNQsgXY
	bPc99kzVGYtkKkB/K92ZA5cb8xFukx8KBMZiC70nyVNw0dxKTGtq+V0xk6907fea04KGGR
	Pm07rSAuuyhV053I4AKaTzzA6ZUVNlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753781639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1Ol3IOwokV2gFS2XNvt3TlezxClZn1L3WQLcEZeGBs=;
	b=LvD8E65lVyOAqmbwPDDWWKDL6hqYBrTDC2eio/p8MMfPSoDFu9DSatiUIKmXCG53nzVhr/
	/KyzMOHSXfUlnnAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nCPWu8FI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LvD8E65l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753781639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1Ol3IOwokV2gFS2XNvt3TlezxClZn1L3WQLcEZeGBs=;
	b=nCPWu8FIoK/1/ulsLh86lMUXeFjGShnQcs45DiGutK5briCI1SSWpthEy+NSaCxUNQsgXY
	bPc99kzVGYtkKkB/K92ZA5cb8xFukx8KBMZiC70nyVNw0dxKTGtq+V0xk6907fea04KGGR
	Pm07rSAuuyhV053I4AKaTzzA6ZUVNlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753781639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1Ol3IOwokV2gFS2XNvt3TlezxClZn1L3WQLcEZeGBs=;
	b=LvD8E65lVyOAqmbwPDDWWKDL6hqYBrTDC2eio/p8MMfPSoDFu9DSatiUIKmXCG53nzVhr/
	/KyzMOHSXfUlnnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C41E13876;
	Tue, 29 Jul 2025 09:33:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NYCLAoeViGizUQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 09:33:59 +0000
Message-ID: <41526d97-b3bc-423b-87f4-7e0ec6cd8292@suse.de>
Date: Tue, 29 Jul 2025 11:33:58 +0200
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
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <f859e5c3-7c96-4d97-a447-75070813450c@suse.de> <aId16W4EaqjANtKR@tiehlicka>
 <3e88642f-3914-42b0-b864-4ad374b659b5@redhat.com>
 <ac7add36-808d-4883-a09e-ef1bf6fd6834@suse.de> <aIiSEpQhWqPsvaST@tiehlicka>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aIiSEpQhWqPsvaST@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 22EFB219EE
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 7/29/25 11:19, Michal Hocko wrote:
> On Tue 29-07-25 09:24:37, Hannes Reinecke wrote:
>> On 7/28/25 15:08, David Hildenbrand wrote:
>>> On 28.07.25 15:06, Michal Hocko wrote:
>>>> On Mon 28-07-25 11:37:46, Hannes Reinecke wrote:
>>>>> On 7/28/25 11:10, David Hildenbrand wrote:
>>>>> And to make matters worse, we have two competing user-space programs:
>>>>> - udev
>>>>> - daxctl
>>>>> neither of which is (or can be made) aware of each other.
>>>>> This leads to races and/or inconsistencies.
>>>>
>>>> Would it help if generic udev memory hotplug rule exclude anything that
>>>> is dax backed? Is there a way to check for that? Sorry if this is a
>>>> stupid question.
>>> Parsing /proc/iomem, it's indicated as "System RAM (kmem)".
>>>
>> I would rather do it the other way round, and make daxctl aware of
>> udev. In the end, even 'daxctl' uses the sysfs interface to online
>> memory, which really is the territory of udev and can easily be
>> done via udev rules (for static configuration).
> 
> udev doesn't really have any context what user space wants to do with
> the memory and therefore how to online it. Therefore we have (arguably)
> ugly hacks like auto onlining and movable_ration etc. daxctl can take
> information from the admin directly and therfore it can do what is
> needed without further hacks.
> 
Huh?
I thought udev was _all_ about userspace preferences...
We can easily have udev rules onlining memory with whatever policy
the user want; the whole point of udev rules is that they are dynamic
and can include policy decisions.

>> Note, we do a similar thing on s/390; the configuration tool there
>> just spits out udev rules.
> 
> Those were easy times when you just need to online memory without any
> more requirements where it should land.

Sorry, I don't get that.
udev rules can easily parse any user-space policy, and you can have a
policy as detailed as you want.
And each installation can have its own udev rules.
Why wouldn't that work?

(Excluding main memory, obviously. We need memory to execute userspace
processes after all).

I do think we're talking past each other...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

