Return-Path: <linux-kernel+bounces-747741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCE2B13782
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4DD1899828
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1E8234984;
	Mon, 28 Jul 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ioWZsHh7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZVY8ht/t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ioWZsHh7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZVY8ht/t"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9022F74B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694903; cv=none; b=AKMugs6wqSPx6eaAUWxoZoumEIW+aE6EyZSwUm86skqn4OqGjMDEUgba66H5iiWAow1niDrQfkoZOOKMEjR9Fa9Sgi8qN+XYsaAko9ELJRraYEhhS6nnIISSHYVJCAcV81k6CPS0wUe70fwDZpCZOxpL6Yl5Rgd55MqCJJOsgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694903; c=relaxed/simple;
	bh=gWcYkzDPjyeOgSC8rzQS4l0hOydtKGHRmteU/O+O9HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXB/jPaoLPHdFnm4JMdDj2mFlBM25td4c+zqa4PxrXXt7hTIvxvH/eFtxVgz7jRwJrknoOme1uW1YTLfEiZG25nToZWYl54eGsUFWeHaUmbE6vfeUEFQTpvGGQNnRnhrdH3t/vc2P2lNlXBR+v+flhdza3Wv7GxbTRv5XF5LtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ioWZsHh7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZVY8ht/t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ioWZsHh7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZVY8ht/t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF2E5211E8;
	Mon, 28 Jul 2025 09:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753694899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjYo15ietrTmGWvWcwTpqo5y+WyN26WO+iCcHTM/8SI=;
	b=ioWZsHh74FPZy5H5yUw+e8ewR6lhBj2FB5MoHptFtjEHVvUuqNSQDFzVK3anmHh/WC4F+s
	kAA+O9UfzikwL8MNBm6XZUI+a9PXndQpsdpZ499Ld5ppm0eaHJTfg6hUtEU6e/McUOE8iy
	NhJcUnipkTtCGHS1HNOtYubywmTfLGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753694899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjYo15ietrTmGWvWcwTpqo5y+WyN26WO+iCcHTM/8SI=;
	b=ZVY8ht/tSiPXpV6h5mOtv0cZNiXg+8NVSh/3fqq9iKzOwOkbcgfm7iui3B3ewFBmd2aRWm
	fJdF34E1+6wx4WBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753694899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjYo15ietrTmGWvWcwTpqo5y+WyN26WO+iCcHTM/8SI=;
	b=ioWZsHh74FPZy5H5yUw+e8ewR6lhBj2FB5MoHptFtjEHVvUuqNSQDFzVK3anmHh/WC4F+s
	kAA+O9UfzikwL8MNBm6XZUI+a9PXndQpsdpZ499Ld5ppm0eaHJTfg6hUtEU6e/McUOE8iy
	NhJcUnipkTtCGHS1HNOtYubywmTfLGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753694899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjYo15ietrTmGWvWcwTpqo5y+WyN26WO+iCcHTM/8SI=;
	b=ZVY8ht/tSiPXpV6h5mOtv0cZNiXg+8NVSh/3fqq9iKzOwOkbcgfm7iui3B3ewFBmd2aRWm
	fJdF34E1+6wx4WBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3BCC1368A;
	Mon, 28 Jul 2025 09:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VthqK7NCh2jBLQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 28 Jul 2025 09:28:19 +0000
Message-ID: <273a3376-c45a-4d41-85b4-9c4f3428f268@suse.de>
Date: Mon, 28 Jul 2025 11:28:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <4057479d-6ece-49a2-b823-99748e8c9c35@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <4057479d-6ece-49a2-b823-99748e8c9c35@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/28/25 10:44, David Hildenbrand wrote:
> On 28.07.25 10:15, Oscar Salvador wrote:
>> Hi,
[ .. ]
>>
>> One way to tackle this would be update the ratio every time a new CXL
>> card gets inserted, but this seems suboptimal.
>> Another way is that since CXL memory works with selfhosted memmap, we 
>> could relax
>> the check when 'auto-movable' and only look at the ratio if we aren't
>> working with selfhosted memmap.
> 
> The memmap is only a small piece of unmovable data we require late at 
> runtime (a bigger factor is user space page tables actually mapping that 
> memory). The zone ratio we have configured in the kernel dates back to 
> the highmem times, where such ratios were considered safe. Maybe there 
> are better defaults for the ratios today, but it really depends on the 
> workload.
> 
Point is, the ratio is accounted for the _entire_ memory.
Which means that you have to _know_ how much memory you are going to
plug in prior to plugging that in.
So to make that correct one would need to update the ratio prior to
plug in one module, check if that succeeded, update the ratio, plug
in the next module, check that, etc.

Really?

> One could find ways of subtracting the selfhosted part, to account it 
> differently in the kernel, but the memmap is not the only consumer that 
> affects the ratio.
> 
> I mean, the memmap is roughly 1.6%, I don't think that really makes a 
> difference for you, does it? Can you share some real-life examples?
> 
> 
> I have a colleague working on one of my old prototypes (memoryhotplugd) 
> for replacing udev rules.
> 
> The idea there is, to detect that CXL memory is getting hotplugged and 
> keep it offline. Because user space hotplugging that memory (daxctl) 
> will explicitly online it to the proper zone.
> 
> Things like virtio-mem, DIMMs etc can happily use the auto-movable 
> behavior. But the auto-movable behavior doesn't quite make sense if (a) 
> you want everything movable and (b) daxctl already expects to online the 
> memory itself, usually to ZONE_MOVABLE.
> 
> So I think this is mostly a user-space problem to solve.
> 
Hmm.
Yes, and no.

While CXL memory is hotpluggable (it's a PCI device, after all),
it won't be hotplugged on a regular basis.
So the current use-case I'm aware of is that the system will be
configured once, and then it will be expected to come up in the
very same state after reboot.
As such a daemon is a bit of an overkill, as the number of events
it would need to listen to is in the very low single-digit range.

Udev rules would work fine, though (in fact, we already have one ...)
so I'd be happy to keep CXL memory offline after boot / hotplug
and let udev / daxctl handle things.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

