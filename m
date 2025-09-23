Return-Path: <linux-kernel+bounces-828491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F4EB94B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8927A3331
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4852130FF28;
	Tue, 23 Sep 2025 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TJEbHV6f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LHbk2ecA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z9Hzu/RK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+lKNdqUp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E32571C7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611175; cv=none; b=avxuv39MX+OwB2aVjvuH92QtayynnYAxUDyrnr68/xDpwai6bE9NFy63tvAc0vo4JgK3eUTwwM1ZEQewwNb/00e1QPkEoEwNFt7xyS7MFYof5I0NZUgPJ5lbKPsNevoZ+XTbg6PwsnyGwYm+0Ij4DyMhJBjdqaE4WTUqpKSdvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611175; c=relaxed/simple;
	bh=PKtJHOhpjzm3pT0yldZezibPr2KlT9zmkoVj0Dqixk4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ANniuP4CnOsbPMmGKgCqWIHNcE2vfDrpk8e8wVHKphK2T4v8RGnj3YAXGBzj9QGbQYa927R6Oc8tWZ6mXXuShMcqlhNzcahPu1yehBY5LbmHX5LVMjfuIOe1BYrXTWmeXmzkAPpBUpv5qRXAxcP3j+bXsxTYqyDU9ZN3WsrlnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TJEbHV6f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LHbk2ecA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z9Hzu/RK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+lKNdqUp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE8D61F7A7;
	Tue, 23 Sep 2025 07:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758611172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=om3ymGVEgOYZkxH7h2o+iQHAkIkzP/oq9p4NUs/6iTE=;
	b=TJEbHV6fxtoOTiFsdBBQARzEZmGvOr1pp9sSAo+P/GlU/lOrFwx0VIamB/sO+m+NWc2IK2
	6iuNCZUlDjdbtkWa+sfxO7sENZyoJa/a8/Y+cPiqDOauJYi4zvgkJq/unOn3FgHAOZNXlG
	irPpN6FK24Tdfil6n3xxd/6GU6nL0as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758611172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=om3ymGVEgOYZkxH7h2o+iQHAkIkzP/oq9p4NUs/6iTE=;
	b=LHbk2ecAokH1cxjeH2efhX4+cfgznd8fR8DJAI57S+2HOcpLVZ6EFoohG2a3iec8TVYLgS
	4AnWAzxV/I3F79Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758611171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=om3ymGVEgOYZkxH7h2o+iQHAkIkzP/oq9p4NUs/6iTE=;
	b=z9Hzu/RKZ7C0arizexWPI/PdG8tVYiTYLiPHCe69hoSImNFdZNZdJ+oi9Eh7oQUqHMq8Fm
	NMUHSrrSn2gs1JxvZ3VbSJV1V8er9OrKf8mTLz0mLNwMESJ5qsRUoTjwkdm53ZyoJXF1PP
	P28dKDXLmAWYcnWvoGQZ80NGeZBJxic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758611171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=om3ymGVEgOYZkxH7h2o+iQHAkIkzP/oq9p4NUs/6iTE=;
	b=+lKNdqUpIzurlssiu+HKRw64nbWNwXhC9ZGSeI+AO8QmAhVEpNqinP5yNk0jNXjVWFIESK
	y2VtOrD48UdMnqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 301531388C;
	Tue, 23 Sep 2025 07:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ykk7O+BG0mhKJgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 23 Sep 2025 07:06:08 +0000
Message-ID: <fda2b300-dd91-4357-8cd0-a82347907164@suse.de>
Date: Tue, 23 Sep 2025 09:06:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gud: Use kmalloc_array() instead of kmalloc()
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, mingo@kernel.org, tglx@linutronix.de, jfalempe@redhat.com,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 Ruben Wauters <rubenru09@aol.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20250922174416.226203-1-mehdi.benhadjkhelifa@gmail.com>
 <063fbed8-915e-47e5-99fd-ffae22cfb6fa@suse.de>
Content-Language: en-US
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
In-Reply-To: <063fbed8-915e-47e5-99fd-ffae22cfb6fa@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,ffwll.ch,linutronix.de,redhat.com,linuxfoundation.org,aol.com];
	FREEMAIL_ENVRCPT(0.00)[aol.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Hi

Am 23.09.25 um 08:34 schrieb Thomas Zimmermann:
> cc Ruben
>
> Am 22.09.25 um 19:43 schrieb Mehdi Ben Hadj Khelifa:
>> Replace kmalloc with kmalloc array in drm/gud/gud_pipe.c since the
>> calculation inside kmalloc is dynamic "width * height" and added
>> u_char as the size of each element.
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>>   drivers/gpu/drm/gud/gud_pipe.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/gud/gud_pipe.c 
>> b/drivers/gpu/drm/gud/gud_pipe.c
>> index 8d548d08f127..eeea0cb4c7aa 100644
>> --- a/drivers/gpu/drm/gud/gud_pipe.c
>> +++ b/drivers/gpu/drm/gud/gud_pipe.c
>> @@ -70,7 +70,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const 
>> struct drm_format_info *format
>>       height = drm_rect_height(rect);
>>       len = drm_format_info_min_pitch(format, 0, width) * height;
>>   -    buf = kmalloc(width * height, GFP_KERNEL);
>> +    buf = kmalloc_array(width * height, sizeof(u_char), GFP_KERNEL);

u_char is more or less guaranteed to be 8 bit. So what's the point?

There's a potential overflow in width * height. If anything, you want to 
call kmalloc_array(height, width).

Best regards
Thomas


>>       if (!buf)
>>           return 0;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



