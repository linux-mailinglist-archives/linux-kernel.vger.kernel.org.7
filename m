Return-Path: <linux-kernel+bounces-581628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626C0A762F8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 11:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91DF3A667C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8D71D89F0;
	Mon, 31 Mar 2025 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Ky7qT/4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5xNYbIDA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Ky7qT/4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5xNYbIDA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935C1876
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412336; cv=none; b=CGqwF0eHrXvHQ3GYw1xKUAMQsUiiC6g3ByHyIlMeAuSOBT+62+rj5hJbddOCgL3AqKgBGDNZjAzDEfssFq0hhzTd4xlxgnH/N/TpQu/M7uRWj9aL2+myOMITPTUF4x1xwGZGeK4WCFDVtiPcHNWZOzd52K5ay2uV+6zLDLeU5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412336; c=relaxed/simple;
	bh=jQEefqsaFQ5JVl1WyD7y4k8V3KJl31aWu30TIrr7DYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN76DhPWFWdcW2lErZzdByzJlTYj2WKYFn2Qr9fDj4uFFQ8pBUFrM0teP55UVvwFDTWBqrqNC+M3yuc3fhiooAPi8/6ti/E9oReU4NVRpwclQsw3J2CA2daj8cC03bby45ljhmpUV7HExBJH0beNWmiVlILR4y3b6U0E+1/6xUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Ky7qT/4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5xNYbIDA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Ky7qT/4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5xNYbIDA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0FAC211E5;
	Mon, 31 Mar 2025 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743412332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FBNvhUODLr5wrTft+mbN6gA9NBfsMyAzWYEeziZemCM=;
	b=0Ky7qT/4CPAWKoJK20bS0zRSUYBw4mVpm1FMtakdX28HNzw+tBLvP4cerHS8wQz4MDR4op
	htsVQvf+vE+2g8nMA1luQ3XzQ4kFQVkrPiY6o+OOpf3tOrpgbVuc+orz12f9XnGo+yz+eJ
	TisSybQgCG8rwWHp9/T8l9ghq3iVa2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743412332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FBNvhUODLr5wrTft+mbN6gA9NBfsMyAzWYEeziZemCM=;
	b=5xNYbIDAPWPYR+qBthBJgb2fUcAJG7MHIGLcQ+Tapv05LkCi/4xt49aO12emtH0H8brQ4P
	eSO5NEsRMhhZxKBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="0Ky7qT/4";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5xNYbIDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743412332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FBNvhUODLr5wrTft+mbN6gA9NBfsMyAzWYEeziZemCM=;
	b=0Ky7qT/4CPAWKoJK20bS0zRSUYBw4mVpm1FMtakdX28HNzw+tBLvP4cerHS8wQz4MDR4op
	htsVQvf+vE+2g8nMA1luQ3XzQ4kFQVkrPiY6o+OOpf3tOrpgbVuc+orz12f9XnGo+yz+eJ
	TisSybQgCG8rwWHp9/T8l9ghq3iVa2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743412332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FBNvhUODLr5wrTft+mbN6gA9NBfsMyAzWYEeziZemCM=;
	b=5xNYbIDAPWPYR+qBthBJgb2fUcAJG7MHIGLcQ+Tapv05LkCi/4xt49aO12emtH0H8brQ4P
	eSO5NEsRMhhZxKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C77613A1F;
	Mon, 31 Mar 2025 09:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pii9FGxc6mdlSwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 31 Mar 2025 09:12:12 +0000
Message-ID: <08b645e4-1a48-4f73-a26d-419966533de0@suse.de>
Date: Mon, 31 Mar 2025 11:12:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/6] Introduce sparse DRM shmem object allocations
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250326021433.772196-1-adrian.larumbe@collabora.com>
 <c1809502-e9b7-43f7-9d88-0e615bf1ff94@suse.de>
 <20250331103102.22be5363@collabora.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20250331103102.22be5363@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B0FAC211E5
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[collabora.com,linux-foundation.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,arm.com,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 31.03.25 um 10:31 schrieb Boris Brezillon:
> Hi Thomas,
>
> On Mon, 31 Mar 2025 09:13:59 +0200
> Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
>> Hi
>>
>> Am 26.03.25 um 03:14 schrieb Adrián Larumbe:
>>> This patch series is a proposal for implementing sparse page allocations
>>> for shmem objects. It was initially motivated by a kind of BO managed by
>>> the Panfrost driver, the tiler heap, which grows on demand every time the
>>> GPU faults on a virtual address within its drm_mm-managed ranged.
>> I've looked at panfrost_gem.h and found that the driver's gem structure
>> has grown quite a bit. It seems to have outgrown gem-shmem already.  I
>> think you should consider pulling a copy of gem-shmem into the driver
>> and building a dedicated memory manager on top.
> Actually, it's not just something we need for panfrost. I plan to use
> the same non-blocking allocation mechanism for panthor's heap
> chunks/buffers, and lima could use it for its heap buffers too. The
> non-blocking page allocation is also something i915 has been
> open-coding here [1], and I believe that some of this logic could
> (and should IMHO) live in common code rather than each driver coming
> with its own solution, thus increasing the risk of bugs/inconsistencies.
> That's even more important if we provide a common gem-shmem shrinker
> like Dmitry's has been proposing.

Thanks for the note.

Best regards
Thomas

>
> Best Regards,
>
> Boris
>
> [1]https://elixir.bootlin.com/linux/v6.13.7/source/drivers/gpu/drm/i915/gem/i915_gem_shmem.c#L89

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


