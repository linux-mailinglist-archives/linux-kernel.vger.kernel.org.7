Return-Path: <linux-kernel+bounces-766129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E6B2429F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E988176E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1712EA159;
	Wed, 13 Aug 2025 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wn4mjGro";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xu2sy9er";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wn4mjGro";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xu2sy9er"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8A2D978B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069775; cv=none; b=UXeL82jgdjQAw8Wg2MPBcR2POc2UWEM3Sp7ooe1EGEm5m5GTZGdydjDTqPXtZx1qRe0K4BphomNOIpSOvsP6noEYeYFgX4pZPQSgE9FtN117LX5Xc/sU+otinHnzoptKPyzy5N0yzpUzFJrsi/GWABpG9JDeYRRDNzIWok4rAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069775; c=relaxed/simple;
	bh=zFJ4iIMHQelNwxdeGi0lskbhUPgNSfd3DIRpNnJko84=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qrjxAFdHbt3+uOV46ywabJiutbLoQ6/rDyVztpRwK1TXTDS5TMKZSbbnG9J+XKlu3j58EZXYtnKwru0wUbwWTljAm0BFQOwWah8R7F4JB2bbxxIjhQJiQE8gjNxyOydzS9hBd9rs2GcQsSUmoMfOiZiEwi5O92whdvhMPGCafJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wn4mjGro; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xu2sy9er; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wn4mjGro; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xu2sy9er; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B57E41F44E;
	Wed, 13 Aug 2025 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755069771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v6hS9FMp+fvANVjHDgtFRJRfOYDfEc9uJJItFEZThmk=;
	b=Wn4mjGrobRueYLtmFPHa3OLzyaWxv37GMyL+wS2pvoxQ4SltJm7cgHd3VOx8X3QpD5s7Qm
	RYV/pj1CFl6KdcgLCFv47FIfYng65mCwGkeNIo1EIsn/wtGtWsLHO3yj8BcuTi6YxyuH6l
	dYfi+oukNJ8G0/GlNSkhGLwqPItdDiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755069771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v6hS9FMp+fvANVjHDgtFRJRfOYDfEc9uJJItFEZThmk=;
	b=Xu2sy9erb/vzFu9q8FYjOuq6dBrATess/NTv+4LqQJg45v3OPAHB1QTN1lqoDbcgMqTscY
	fGVKYo/jlL3Rs4Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wn4mjGro;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xu2sy9er
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755069771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v6hS9FMp+fvANVjHDgtFRJRfOYDfEc9uJJItFEZThmk=;
	b=Wn4mjGrobRueYLtmFPHa3OLzyaWxv37GMyL+wS2pvoxQ4SltJm7cgHd3VOx8X3QpD5s7Qm
	RYV/pj1CFl6KdcgLCFv47FIfYng65mCwGkeNIo1EIsn/wtGtWsLHO3yj8BcuTi6YxyuH6l
	dYfi+oukNJ8G0/GlNSkhGLwqPItdDiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755069771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v6hS9FMp+fvANVjHDgtFRJRfOYDfEc9uJJItFEZThmk=;
	b=Xu2sy9erb/vzFu9q8FYjOuq6dBrATess/NTv+4LqQJg45v3OPAHB1QTN1lqoDbcgMqTscY
	fGVKYo/jlL3Rs4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70B9713479;
	Wed, 13 Aug 2025 07:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K3pwGUs9nGibdgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 13 Aug 2025 07:22:51 +0000
Message-ID: <57ec4e5a-64a9-4e44-9304-d41e6148da01@suse.de>
Date: Wed, 13 Aug 2025 09:22:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] gpu: drm: fix compilation errors in drm_vram_helper
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?B?R2FyeSBDaHUo5qWa5YWJ5bqGKQ==?= <chuguangqing@inspur.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5863c61a424545119df8ccb28dc1dbf8@inspur.com>
 <8e1f2b36-58b8-41fb-b514-e39c4d5081b9@suse.de>
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
In-Reply-To: <8e1f2b36-58b8-41fb-b514-e39c4d5081b9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B57E41F44E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[inspur.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Score: -4.51

Hi

Am 13.08.25 um 08:58 schrieb Thomas Zimmermann:
> Hi
>
> Am 13.08.25 um 03:38 schrieb Gary Chu(楚光庆):
>> Hi Thomas
>>
>> This is what I've done in the yhgch_drm driver.
>> See the link below:
>> https://lore.kernel.org/all/20250808053508.52202-1-chuguangqing@inspur.com/T/#t 
>>
>
> I see. I thought it was for an existing driver. In new drivers, please 
> don't use VRAM helpers any longer. VRAM helpers are based on TTM and 
> new drivers should use TTM directly. If you integrate the code from 
> VRAM helpers into your driver, you should be good.
>
> Note that for reliably using TTM, your hardware requires at least 3 
> times the memory as the largest resolution+depth requires. The driver 
> says 1920*1200@32bpp, which amounts to ~9 MiB of VRAM. For TTM usage, 
> your device requires at least 32 MiB of VRAM available.
>
> If your devices have smaller VRAM, rather use GEM SHMEM helpers instead.

And with TTM, buffer sharing is fairly hard to impossible. Shmem or DMA 
helpers provide it out of the box.

Best regards
Thomas


>
> Best regards
> Thomas
>
>>
>> In fact, through modifications in Patch v2, it allows only the 
>> selection of
>> DRM_VRAM_HELPER in the driver.
>> See the link below:
>> https://lore.kernel.org/all/20250729060728.82402-1-chuguangqing@inspur.com/T/#m3e33f8e155275ea548223c21777c191ecd392159 
>>
>>
>> Best regards
>> Chuguangqing
>>
>>> From: Thomas Zimmermann <tzimmermann@suse.de>
>>> To:chuguangqing <chuguangqing@inspur.com>; Maarten Lankhorst
>>> <maarten.lankhorst@linux.intel.com>; Maxime Ripard 
>>> <mripard@kernel.org>;
>>> David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>
>>> Cc: dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH 1/1] gpu: drm: fix compilation errors in 
>>> drm_vram_helper
>>>
>>> Hi
>>>
>>> Am 29.07.25 um 08:07 schrieb chuguangqing:
>>>> We encountered the following errors while compiling drm_vram_helper.ko
>>>>
>>>> ERROR: modpost: "drm_gem_ttm_print_info"
>>> [drivers/gpu/drm/drm_vram_helper.ko] undefined!
>>>> ERROR: modpost: "drm_gem_ttm_mmap"
>>> [drivers/gpu/drm/drm_vram_helper.ko] undefined!
>>>> The functions drm_gem_ttm_mmap and drm_gem_ttm_print_info are
>>> defined in drm_gem_ttm_helper.c. This patch adds 
>>> drm_gem_ttm_helper.o to
>>> DRM_VRAM_HELPER to resolve the undefined symbol errors.
>>>
>>> You need to select DRM_TTM_HELPER for your driver.
>>>
>>> Best regards
>>> Thomas
>>>
>>>> Signed-off-by: chuguangqing <chuguangqing@inspur.com>
>>>> ---
>>>>    drivers/gpu/drm/Makefile | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile index
>>>> 4dafbdc8f86a..abbe32ddf6d0 100644
>>>> --- a/drivers/gpu/drm/Makefile
>>>> +++ b/drivers/gpu/drm/Makefile
>>>> @@ -125,7 +125,7 @@ drm_suballoc_helper-y := drm_suballoc.o
>>>>    obj-$(CONFIG_DRM_SUBALLOC_HELPER) += drm_suballoc_helper.o
>>>>
>>>>    drm_vram_helper-y := drm_gem_vram_helper.o
>>>> -obj-$(CONFIG_DRM_VRAM_HELPER) += drm_vram_helper.o
>>>> +obj-$(CONFIG_DRM_VRAM_HELPER) += drm_vram_helper.o
>>>> +drm_gem_ttm_helper.o
>>>>
>>>>    drm_ttm_helper-y := drm_gem_ttm_helper.o
>>>>    drm_ttm_helper-$(CONFIG_DRM_FBDEV_EMULATION) +=
>>> drm_fbdev_ttm.o
>>>
>>> -- 
>>> -- 
>>> Thomas Zimmermann
>>> Graphics Driver Developer
>>> SUSE Software Solutions Germany GmbH
>>> Frankenstrasse 146, 90461 Nuernberg, Germany
>>> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman HRB
>>> 36809 (AG Nuernberg)
>>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



