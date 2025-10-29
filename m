Return-Path: <linux-kernel+bounces-875901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF51EC1A12C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9A71893BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A5B32F757;
	Wed, 29 Oct 2025 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KG9EwIAu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Ci7Qz2I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KG9EwIAu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Ci7Qz2I"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28630E825
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737626; cv=none; b=gttOaYo3vIMttPGraviEaLRZK8DOocSXJToe8BDgTmA6KVWttY8AGTnND8WpA2bR06x661wTZk5G/yNYyYzEsN9ohZPnWh07iOho6sNX/yj1aTw+wI90MU4udBPoFewOvBMsMJChMRmLgHj38UhzS9+qJjH6GmPe2MKDgX3rQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737626; c=relaxed/simple;
	bh=cOR1emcXjlxOIQFc2i7AbKh+nP4VcIb3yLzIYH2szHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tifXFVuV28T6iZBkLbEGqgqC8ApPEQ/W46uTikPVg6WcA/dt+IhwR3dS58uaukrKPVdITGx8SDjKFdC8bvGsmdC4fI9uDWV+lXqrFCxbYjQVuZSNtoDH8EO24dFxM5t9wOyptxM4nyyfagtfn4rl9EzbJ9y5NVO2ai3p/WkHEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KG9EwIAu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Ci7Qz2I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KG9EwIAu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Ci7Qz2I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9123E2081B;
	Wed, 29 Oct 2025 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761737622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQYL23754EV/nvlI2xYg3V2OO8lUab0H+SIPolSVX/I=;
	b=KG9EwIAuvPWxMLGAo5VGomGqoD9HEqR8wOypFpMFvqCRZxKjdpvUHIjL0kkf0EoHJ3kjpw
	FvA6WvCbXafeew2DkFVF93kNna+r6/JuEdcTmQpZquvfIMzgMuQy04UkAFRGBJAU4CUJv9
	nfjTToW3mtNHKwb6HVDtuouR357TYko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761737622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQYL23754EV/nvlI2xYg3V2OO8lUab0H+SIPolSVX/I=;
	b=3Ci7Qz2IDhksHG9hIMAmu+b/iKiu9J60wBgeA+wdmy1PWmWBuo/TzOXslmLyOIII4wJ0p9
	djPo36V8xfpKPcCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761737622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQYL23754EV/nvlI2xYg3V2OO8lUab0H+SIPolSVX/I=;
	b=KG9EwIAuvPWxMLGAo5VGomGqoD9HEqR8wOypFpMFvqCRZxKjdpvUHIjL0kkf0EoHJ3kjpw
	FvA6WvCbXafeew2DkFVF93kNna+r6/JuEdcTmQpZquvfIMzgMuQy04UkAFRGBJAU4CUJv9
	nfjTToW3mtNHKwb6HVDtuouR357TYko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761737622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQYL23754EV/nvlI2xYg3V2OO8lUab0H+SIPolSVX/I=;
	b=3Ci7Qz2IDhksHG9hIMAmu+b/iKiu9J60wBgeA+wdmy1PWmWBuo/TzOXslmLyOIII4wJ0p9
	djPo36V8xfpKPcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 287F21396A;
	Wed, 29 Oct 2025 11:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tkK/Bpb7AWmQBAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 29 Oct 2025 11:33:42 +0000
Message-ID: <72c291ff-8295-4bef-b368-68c24aa983ec@suse.de>
Date: Wed, 29 Oct 2025 12:33:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: update sc_c in target host hash calculation
To: Alistair Francis <alistair23@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251029045327.2035337-1-alistair.francis@wdc.com>
 <9b8d8baf-022a-49a9-b8b9-db699125e064@suse.de>
 <CAKmqyKMH4dNGP0aW1ufkHKXuzNGjixAQrMwFd0QjCy9UT00KTw@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKMH4dNGP0aW1ufkHKXuzNGjixAQrMwFd0QjCy9UT00KTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,wdc.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/29/25 12:20, Alistair Francis wrote:
> On Wed, Oct 29, 2025 at 6:10 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 10/29/25 05:53, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
>>> the sc_c variable to the dhchap queue context structure which is
>>> appropriately set during negotiate and then used in the host response.
>>>
>>> This breaks secure concat connections with a Linux target as the target
>>> code wasn't updated at the same time. This patch fixes this by adding a
>>> new sc_c variable to the host hash calculations.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>    drivers/nvme/host/auth.c               | 1 +
>>>    drivers/nvme/target/auth.c             | 3 ++-
>>>    drivers/nvme/target/fabrics-cmd-auth.c | 1 +
>>>    drivers/nvme/target/nvmet.h            | 1 +
>>>    4 files changed, 5 insertions(+), 1 deletion(-)
>>>
>> I've already send a similar patch for this, which actually should
>> already have been merged.
>> Can you check if that works for you?
> 
> I checked master when I sent this and there was nothing applied. Is it
> in a different tree?
> 

https://lore.kernel.org/linux-nvme/aPl4-6WQ940kUso7@kbusch-mbp/T/#t

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

