Return-Path: <linux-kernel+bounces-810563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2176DB51C73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DE01C85846
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3632A3D8;
	Wed, 10 Sep 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wvQI8UMs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k3yvW2Oi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wvQI8UMs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k3yvW2Oi"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3A263F32
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519338; cv=none; b=SzatGkZLS96tIdK8vRGkxXVnsBAiE1AgDWnuiyNoX88EF3Z5cvypQkrx0rnUutjOm48LtY38pd0Bs/xHV8iCrLLEbztnwMyWUZsyjP3gsn+mJNk365TegU5ak8txVGywRTTKhXkrTZHtP2Au1YGi0YxvustjhzKBGWwcQHk4xZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519338; c=relaxed/simple;
	bh=1zieRllMd/VK2edR6+sZzJN9lZfn0rTroobUlj/6uYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MW54+AnVqI05yAy2xTjW+x4LGMBK4T/6sB55iobu4MrrBK91mHaWBqBy4RQYv6jX47Dhuz2oE0HDCgj8QPISTIrTAS9fv28eiNn0EAHYKnlmPmGjhAS8FNp5GcPrJlAN4bTCTYKGwj/oW6GHleEp/VEKbEde+nFWJTypzbDDstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wvQI8UMs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k3yvW2Oi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wvQI8UMs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k3yvW2Oi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F07237EF1;
	Wed, 10 Sep 2025 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757519333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yBVL7srJiNT7NEluSsuL96mfRyRtVk421jqNwvKTG00=;
	b=wvQI8UMszCg/6KdMiq5WmXV5Q88H2tmFIsy8RsXHrgcxspMmHZjm3LHZIKjALzTeONG5rA
	ngi3vk3RN7nKcxi3sS4o5pCa8Oo/oiAJd+aJUMDetAgo8I/LY/AM8VjG/P3OxyEeW1TETF
	BzXLqqlXMvuW25BedSH/3hCrorKrjS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757519333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yBVL7srJiNT7NEluSsuL96mfRyRtVk421jqNwvKTG00=;
	b=k3yvW2OitZA3WZIBuzinAF3nI/jNTDjxxIQLSgGppjRhccpufFS0OyQcmstSvnu7TNccJt
	3NTDvx0tUAYHX0BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wvQI8UMs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k3yvW2Oi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757519333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yBVL7srJiNT7NEluSsuL96mfRyRtVk421jqNwvKTG00=;
	b=wvQI8UMszCg/6KdMiq5WmXV5Q88H2tmFIsy8RsXHrgcxspMmHZjm3LHZIKjALzTeONG5rA
	ngi3vk3RN7nKcxi3sS4o5pCa8Oo/oiAJd+aJUMDetAgo8I/LY/AM8VjG/P3OxyEeW1TETF
	BzXLqqlXMvuW25BedSH/3hCrorKrjS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757519333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yBVL7srJiNT7NEluSsuL96mfRyRtVk421jqNwvKTG00=;
	b=k3yvW2OitZA3WZIBuzinAF3nI/jNTDjxxIQLSgGppjRhccpufFS0OyQcmstSvnu7TNccJt
	3NTDvx0tUAYHX0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B66713310;
	Wed, 10 Sep 2025 15:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RJAiCeWdwWi3PQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Sep 2025 15:48:53 +0000
Message-ID: <77576214-a849-41d7-bcfe-f9af20ff263b@suse.de>
Date: Wed, 10 Sep 2025 17:48:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] fbdev: hyperv_fb: Remove hyperv_fb driver
To: Michael Kelley <mhklinux@outlook.com>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 "deller@gmx.de" <deller@gmx.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "soci@c64.rulez.org" <soci@c64.rulez.org>,
 "gonzalo.silvalde@gmail.com" <gonzalo.silvalde@gmail.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <E2D7F2119CB4>
 <1757437112-2509-1-git-send-email-ptsm@linux.microsoft.com>
 <8a958fe8-fbba-4bd6-a79d-fd310f08f8d7@suse.de>
 <SN6PR02MB415755A10BD2C9D0E7F847FCD40EA@SN6PR02MB4157.namprd02.prod.outlook.com>
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
In-Reply-To: <SN6PR02MB415755A10BD2C9D0E7F847FCD40EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,linux.microsoft.com,gmx.de,arndb.de,c64.rulez.org,gmail.com,infradead.org,linaro.org,kernel.org,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,outlook.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7F07237EF1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Hi

Am 10.09.25 um 17:25 schrieb Michael Kelley:
> From: Thomas Zimmermann <tzimmermann@suse.de> Sent: Wednesday, September 10, 2025 2:36 AM
>> Hi
>>
>> Am 09.09.25 um 18:58 schrieb Prasanna Kumar T S M:
>>> The Hyper-V DRM driver is available since kernel version 5.14 and
>>> provides full KMS support along with fbdev emulation via the DRM fbdev
>>> helpers. This makes the hyperv_fb driver redundant, remove it.
>> I'm all for removing obsolete drivers. But hyperv_drm likely first needs
>> to merge the patch at
>> https://lore.kernel.org/dri-devel/20250904145806.430568-5-tzimmermann@suse.de/
>> It's been tested and works well. If maintainers from Microsoft have a
>> look at the patch first, we could possibly land it fairly soon.
> Thomas --
>
> My testing of your v3 patch series for vblank timers ended up getting a
> WARN_ON after about 3 days of usage. See [1]. So I don't think it's 100%
> ready yet.

Yeah, I've seen your message, but didn't have time to investigate yet. 
It might not be that much of an issue.

>
> But I agree we need your synthetic vblank timer support to address the
> Hyper-V DRM driver performance issue, before removing the Hyper-V
> fbdev driver. (See [2] for a description of the performance issue.)
>
> Second, isn't it customary to mark a driver as deprecated for a period
> of time, before removing it entirely? I don't see any documentation
> on the deprecation process, but I've seen it done in other cases. If you
> grep through all the kernel Kconfig files, you'll see entries tagged with
> DEPRECATED. Also the driver should be updated to output a deprecated
> message when it loads.

Sure, we can do that.

Best regards
Thomas

>
> Michael
>
> [1] https://lore.kernel.org/dri-devel/BN7PR02MB4148E80C13605F6EAD2B0A03D40FA@BN7PR02MB4148.namprd02.prod.outlook.com/
> [2] https://lore.kernel.org/dri-devel/SN6PR02MB415702B00D6D52B0EE962C98D46CA@SN6PR02MB4157.namprd02.prod.outlook.com/
>
>> Best regards
>> Thomas
>>
>>> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
>>> ---
>>>    MAINTAINERS                     |    1 -
>>>    drivers/video/fbdev/Kconfig     |    8 -
>>>    drivers/video/fbdev/Makefile    |    1 -
>>>    drivers/video/fbdev/hyperv_fb.c | 1386 -------------------------------
>>>    4 files changed, 1396 deletions(-)
>>>    delete mode 100644 drivers/video/fbdev/hyperv_fb.c
>>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



