Return-Path: <linux-kernel+bounces-898794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BEEC56095
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40E6E4E33CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5DC289811;
	Thu, 13 Nov 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mFX1Ro8v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CBNccGxT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ngHRWq0q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bS6ha2zm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F426CE39
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018471; cv=none; b=qJn3szwkY1RbtA9DB1iBVte86LqZC87DiticD9PS04bYScgWLPS835D0HpIXUXAjBKSqaDemv6RyrAzimV97sHHsQoHTo3rbfJAf55MWW7Y4sdv7F1JdFeJcgIY5vCSE1kIOLXCfghuMSlWoLem1+qzayeLAGX6QP+/gQdExoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018471; c=relaxed/simple;
	bh=+e5vyuZtNunYpnjO09KC3VxITCJoLOIfNhP9xGTZhkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMaKSKucozPjYhTMxpfeR+ujzNvofPOdHs0gNk04w3FgmZg1hD+6C1lfoN12R8z2PajmdrOeVz9E02dKFLW7ACdM6VH7KNKdAeRAujthJmmLZ29MIEcqd7+qopcVw2kT+bijrNQ+57cRPTJPg9fCuUpUabNXY2lLwTO4VxLGkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mFX1Ro8v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CBNccGxT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ngHRWq0q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bS6ha2zm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2FD21F45A;
	Thu, 13 Nov 2025 07:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763018467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izWwmm75QloOQ0n7LfH2mcNAkauxG6c9HuiSvb7m4WA=;
	b=mFX1Ro8vHqtsDiUajsAj3tbAzeoME9+D7GjgaEqJ2M+cFlaX/1Agx7kcnGfH/PDx/rfzMf
	agJkL8l49BbsamMzclFcQ1zNqu1IXaTw0w41pwz51UYGUqRLcJ8tpBCyV6W/Kf9aXz0Lal
	vRjzm0DmBvrYpvbaLPLQ9FDqN9QUIuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763018467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izWwmm75QloOQ0n7LfH2mcNAkauxG6c9HuiSvb7m4WA=;
	b=CBNccGxT2DGuDlwUJdT6i5bvqubAxp4zxRAtd6zTm/v+iQP4WK8mq32qr18/VFIxehar2l
	zBYaYejGGncUpuBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ngHRWq0q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bS6ha2zm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763018466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izWwmm75QloOQ0n7LfH2mcNAkauxG6c9HuiSvb7m4WA=;
	b=ngHRWq0qxgRCLr8Imp7mmcNkr9APxHxI62ZQNeSqz9OdBEAxd20ygLk7GjT2VqzzIH+3Ln
	vsjJJR+vASYETp+1WqANlxSEfOhJh42etlO+E+3buYBvYu/Aiq6nvVXkTnXa/m5UQU+jRp
	0JxH4C+2w5332GkNtKIslQeJPqxJWTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763018466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izWwmm75QloOQ0n7LfH2mcNAkauxG6c9HuiSvb7m4WA=;
	b=bS6ha2zm6f46pAaAlZGb6+NFPfS/gM+h6Yd7s6j9lqUxcWzVDMPdGZxOZPaRpeILtFt3PE
	tEIB7dAe6W8boNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84A613EA61;
	Thu, 13 Nov 2025 07:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DssjHeKGFWkFcwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 13 Nov 2025 07:21:06 +0000
Message-ID: <2019e372-c079-4230-97ba-a3299ced0474@suse.de>
Date: Thu, 13 Nov 2025 08:21:06 +0100
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
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKNzi7OAq49b-aa1H8++ReTvWnHKBDwA88ionJshhOVp9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E2FD21F45A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,wdc.com:email]
X-Spam-Score: -4.51

On 11/13/25 03:08, Alistair Francis wrote:
> On Wed, Nov 12, 2025 at 5:08 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 11/12/25 00:45, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>> v2:
>>>    - New patch
>>>
>>>    drivers/nvme/host/sysfs.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>>> index 29430949ce2f..6d10e12136d0 100644
>>> --- a/drivers/nvme/host/sysfs.c
>>> +++ b/drivers/nvme/host/sysfs.c
>>> @@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
>>>            !ctrl->opts->tls && !ctrl->opts->concat)
>>>                return 0;
>>>        if (a == &dev_attr_tls_configured_key.attr &&
>>> -         (!ctrl->opts->tls_key || ctrl->opts->concat))
>>> +         !ctrl->opts->concat)
>>>                return 0;
>>>        if (a == &dev_attr_tls_keyring.attr &&
>>>            !ctrl->opts->keyring)
>>
>> ??
>>
>> How can you have a configured TLS Key for secure concatenation?
> 
> I'm not sure I follow
> 
> `ctrl->opts->tls_key` is directly set at the end of the
> `nvme_auth_secure_concat()` function, so it will be set for secure
> concatenation.
> 
Right, sorry. Of course you are right.

But I'm still a bit unsure about the interface here; just writing
anything into it doesn't feel like the correct way of doing it.

I would rather modify the interface to allow a key serial number (or 0).
That would allow us to modify the configured key, which currently is
fixed for the lifetime of the connection.
And writing '0' would reset the configured key, reverting to automatic
key selection.
Having such an interface would actually be beneficial, as it would
remove some limitations from the current interface.

Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

