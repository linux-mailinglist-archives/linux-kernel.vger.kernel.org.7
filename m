Return-Path: <linux-kernel+bounces-899353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BC5C577BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1EE3A7492
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E801B350298;
	Thu, 13 Nov 2025 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RPw0uJlk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gg1j5u1f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ji5kgnrC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wry1EnLI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149634E772
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037908; cv=none; b=exuD1z6jTDLKu9FRMUW26cWSl/99BHMKHOIq8wkqgcaNuYxYdzpmBzg9DsaRmZFHNQPx0xkJE3S3Oy28BIMkphC3Ei1cNV+JYuo/gVQ4WELKeRtMet5q3iwzZZTUDPJQPChHxa/lDFnXiJ6xMD03VnbpXd7St+ptKLZ2C+tRO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037908; c=relaxed/simple;
	bh=7H4ZRKdmNtAnr1pjch+M6ja2ArgcMdGLpNJrzoayRVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMboVbswio4hoJhJEkp7q19t+bTOQWQZK5vDLXB9lhcGkhwjpBRNKd0z28AV4swu0m7Mp5fyXB/RbE7YlPY9faXjIcFpHexgrXTG2/FzDpOQAq5YdKlbSXsun+fPJAKywSq+iWqcUAn3amWZXz5PY5nfO8rJPAnBhUNXDwBfgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RPw0uJlk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gg1j5u1f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ji5kgnrC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wry1EnLI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF4A71F395;
	Thu, 13 Nov 2025 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763037903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDrPQtCGCXRXRgNjlUvAgDLUqhW+g1qFdV187j0GUYA=;
	b=RPw0uJlkj+4LFYUW3H570YX6LNV6Yd+MZ9BdQnpyD8SJus8E+SgtjksC3e1lkkr3KfcZDI
	BGmmj5w4iitibzk9kwgou/RzHjqH2tgMsic+mcyxZszcFwHJw97Cs+0rEGDrJDumer9SyL
	c7nWT+WbkiGYCohjxMXsQa+WGMKRIJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763037903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDrPQtCGCXRXRgNjlUvAgDLUqhW+g1qFdV187j0GUYA=;
	b=Gg1j5u1f6g/SO6raSeQ9wqpHcTBceO85etnRlTpw4KtytCDD/OkPhHND6GyycNm3tWSb83
	wqBgMRcYB/oDlbBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ji5kgnrC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wry1EnLI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763037902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDrPQtCGCXRXRgNjlUvAgDLUqhW+g1qFdV187j0GUYA=;
	b=ji5kgnrChrZxjeEAUjbjQ4a41Pn82zPbnTdiE0giniH2C4OLPkSmmlXdBoIXqveJRSQCgp
	vFP9z+n1At8mSQFBO7aWkGHIeQRZ2PGz3rYY5XjKn+TlWHl1pkXSwjh4gx1NN7qC/jXoTv
	JirmQDSdoUWBNev6SCHaIBoIRJaQjqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763037902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDrPQtCGCXRXRgNjlUvAgDLUqhW+g1qFdV187j0GUYA=;
	b=wry1EnLIfBie1FpvpqcqOl6AQWQGA1F0Wy8LKp2M2BIjk8s6W1cNtMkkbGeMDZfoc/f/Pq
	Un/RF1nvY+WNxgBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF11D3EA61;
	Thu, 13 Nov 2025 12:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YPK1Lc7SFWmTOgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 13 Nov 2025 12:45:02 +0000
Message-ID: <11987de2-b1ae-4a80-ba16-bf6c795bc1e2@suse.de>
Date: Thu, 13 Nov 2025 13:45:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] nvme: Expose the tls_configured sysfs for secure
 concat connections
To: Alistair Francis <alistair23@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-4-alistair.francis@wdc.com>
 <caadfcbb-8964-4447-a93d-8e49b4c14c7e@suse.de>
 <CAKmqyKNzi7OAq49b-aa1H8++ReTvWnHKBDwA88ionJshhOVp9g@mail.gmail.com>
 <2019e372-c079-4230-97ba-a3299ced0474@suse.de>
 <CAKmqyKOBr2eV6AeWH6SHz_UX4ciKgdf3zGJ9LMHEOuFz55kO+A@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKOBr2eV6AeWH6SHz_UX4ciKgdf3zGJ9LMHEOuFz55kO+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF4A71F395
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 11/13/25 13:22, Alistair Francis wrote:
> On Thu, Nov 13, 2025 at 5:21 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 11/13/25 03:08, Alistair Francis wrote:
>>> On Wed, Nov 12, 2025 at 5:08 PM Hannes Reinecke <hare@suse.de> wrote:
>>>>
>>>> On 11/12/25 00:45, alistair23@gmail.com wrote:
>>>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>>>
>>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>>> ---
>>>>> v2:
>>>>>     - New patch
>>>>>
>>>>>     drivers/nvme/host/sysfs.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>>>>> index 29430949ce2f..6d10e12136d0 100644
>>>>> --- a/drivers/nvme/host/sysfs.c
>>>>> +++ b/drivers/nvme/host/sysfs.c
>>>>> @@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
>>>>>             !ctrl->opts->tls && !ctrl->opts->concat)
>>>>>                 return 0;
>>>>>         if (a == &dev_attr_tls_configured_key.attr &&
>>>>> -         (!ctrl->opts->tls_key || ctrl->opts->concat))
>>>>> +         !ctrl->opts->concat)
>>>>>                 return 0;
>>>>>         if (a == &dev_attr_tls_keyring.attr &&
>>>>>             !ctrl->opts->keyring)
>>>>
>>>> ??
>>>>
>>>> How can you have a configured TLS Key for secure concatenation?
>>>
>>> I'm not sure I follow
>>>
>>> `ctrl->opts->tls_key` is directly set at the end of the
>>> `nvme_auth_secure_concat()` function, so it will be set for secure
>>> concatenation.
>>>
>> Right, sorry. Of course you are right.
>>
>> But I'm still a bit unsure about the interface here; just writing
>> anything into it doesn't feel like the correct way of doing it.
> 
> I'm happy to change that.
> 
> I was thinking a bool, so basically write 1 to trigger
> 

I would like to keep the interface consistent, so as it's displaying
a key serial number it should also accept a key serial number on writing.
(Or '0', which is 'invalid key serial number');

>>
>> I would rather modify the interface to allow a key serial number (or 0).
>> That would allow us to modify the configured key, which currently is
>> fixed for the lifetime of the connection.
> 
> Wouldn't a configured key (`tls_key`) be changed via the tlshd
> interface, not writing a key serial to sysfs?
> 

We would need to figure out the effects of REPLACETLSPSK with secure
concatenation.
Clearly for secure concatenation the resulting key is generated from
the secure key material negotiated during authentication. So the only
valid keys here should be generated keys, not persistent ones.
But in order to have _new_ generated keys we need to run authentication.
Consequently the key serial number can't be known when starting a
REPLACETLSPSK operation, and we need to write '0' into the
tls_configured_key attribute to a) reset the generated key and b)
start the authentication protocol.
That will then generate a new key, which will be visible via
'tls_configured_key'.

So all good, methinks.

>> And writing '0' would reset the configured key, reverting to automatic
>> key selection.
>> Having such an interface would actually be beneficial, as it would
>> remove some limitations from the current interface.
> 
> Anyway, I'm not sure your vision conflicts with allowing "write 1 to
> `tls_configured_key` to trigger a REPLACETLSPSK"
> 

Please don't use '1'. As mentioned earlier, I would like the sysfs
attribute to represent entries in the keystore (by displaying the key
serial number). '1' _is_ a valid number, and so the interface will try
to lookup a key with serial number '1'.
(And failing to do so :-)
'0' is _not_ valid key serial number, so writing '0' is equivalent to
'disable that key'.

Cheers,

Hannes--
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

