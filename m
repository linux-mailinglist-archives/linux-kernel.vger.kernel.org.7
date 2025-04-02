Return-Path: <linux-kernel+bounces-585031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6214FA78EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 14:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD3918968D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 12:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBC8239581;
	Wed,  2 Apr 2025 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dlDLPCQC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iAPsw+WH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xz/WrCm2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w1q0GM1x"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752241EA7DE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598028; cv=none; b=I6nIjyL3wQK9UEuc7vOIWmP3YDKG0NtM8HZWHnaZgh58T3Tkp9KSI5kUF2vdUBSh4XJVhxbzoVIPm8O0O5PAc/w8ThYcfHD7hqN5CPH9Q2T1OSBUfZux0KD1Z8Trqzwfy9oMvRgFAz68gG67mPuk7fS8Qk4wSVNCGuAIW9UIc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598028; c=relaxed/simple;
	bh=q4QAZWL05vzCVVCfGsFAB1fGWnJTOhsJMa6MRoKeV7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC6D5/f+9En7BfmKPOAU4C0RXdtFId/jqc52ocbOHmj4AAQJq3+p9waisR/sID7786DWPzYf8vb4T5Qc2iyolrsyeEG/nWh4NjwgAmN/8CLgP0DJ4faOzOQ2w41LJ+M86ut+eToiUASAhkkvhf82xA9pwLaNUbs8dYKE0EJ0Hro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dlDLPCQC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iAPsw+WH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xz/WrCm2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w1q0GM1x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9EFA21172;
	Wed,  2 Apr 2025 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743598024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ElqFvgxjPkjYF8Bx7orqIMCixUoDwOI1ydmXi7drOuk=;
	b=dlDLPCQC38s2Vt6YYlfh0ut1JJ8AsrLItkXFLL4AILVBIEGekiycdqRzY0QdAssUG3WxYg
	ZUf1VbRecELLcC6kwo0nZ1PvVLL/RAl5ixpYUSt3ZE0ipGNCsD3uZpCDT//thyprqqN5JB
	9/V2mBQ3gYWiajkO++UprZQMlBm9Q1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743598024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ElqFvgxjPkjYF8Bx7orqIMCixUoDwOI1ydmXi7drOuk=;
	b=iAPsw+WHlZ6ogDEFS8dDqdqBcmo/HrZb4GS4lUV9KIJ2s782QTZe45/JYP12CDQXWs0JfM
	AJoXCKnIC09+RACQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743598023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ElqFvgxjPkjYF8Bx7orqIMCixUoDwOI1ydmXi7drOuk=;
	b=xz/WrCm29cg4d7/Lt5WxE9R5HtWiI518of+Ew5FF1FdSG7fIQ+CsVOTPn1DN6dHif8fr34
	lPXdtHUTaWv/gaiMKbrB1aAef1doNrGouQrDHkRVH5rw87gD6HqWgGJJ4MyaqFdIKENjVG
	++fl+7cT3xhEGqZK8gr6SnaesSZEAy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743598023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ElqFvgxjPkjYF8Bx7orqIMCixUoDwOI1ydmXi7drOuk=;
	b=w1q0GM1xEyIPatRyh7jNfqyudtvlDS2FNfqnM55Ml+hrnEXjv4R/8t9t1jP4flzkVLqt7g
	69puapUqy2yVZmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79111137D4;
	Wed,  2 Apr 2025 12:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VaUzHMcx7WfsBwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 02 Apr 2025 12:47:03 +0000
Message-ID: <ea4f4059-7748-4bfd-9205-8e95222144da@suse.de>
Date: Wed, 2 Apr 2025 14:47:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 09/10] drm/shmem-helper: Switch
 drm_gem_shmem_vmap/vunmap to use pin/unpin
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Qiang Yu <yuq825@gmail.com>,
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
 <20250322212608.40511-10-dmitry.osipenko@collabora.com>
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
In-Reply-To: <20250322212608.40511-10-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[collabora.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,amd.com,redhat.com,arm.com,imgtec.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,collabora.com:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 22.03.25 um 22:26 schrieb Dmitry Osipenko:
> The vmapped pages shall be pinned in memory and previously get/put_pages()
> were implicitly hard-pinning/unpinning the pages. This will no longer be
> the case with addition of memory shrinker because pages_use_count > 0 won't
> determine anymore whether pages are hard-pinned (they will be soft-pinned),
> while the new pages_pin_count will do the hard-pinning. Switch the
> vmap/vunmap() to use pin/unpin() functions in a preparation of addition
> of the memory shrinker support to drm-shmem.

I've meanwhile rediscovered this patch and I'm sure this is not correct. 
Vmap should not pin AFAIK. It is possible to vmap if the buffer has been 
pinned, but that's not automatic.  For other vmaps it is necessary to 
hold the reservation lock to prevent the buffer from moving.

Best regards
Thomas

>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   drivers/gpu/drm/drm_gem_shmem_helper.c | 6 +++---
>   include/drm/drm_gem_shmem_helper.h     | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 6fb96e790abd..84a196bbe44f 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -360,7 +360,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>   			return 0;
>   		}
>   
> -		ret = drm_gem_shmem_get_pages_locked(shmem);
> +		ret = drm_gem_shmem_pin_locked(shmem);
>   		if (ret)
>   			goto err_zero_use;
>   
> @@ -383,7 +383,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>   
>   err_put_pages:
>   	if (!drm_gem_is_imported(obj))
> -		drm_gem_shmem_put_pages_locked(shmem);
> +		drm_gem_shmem_unpin_locked(shmem);
>   err_zero_use:
>   	shmem->vmap_use_count = 0;
>   
> @@ -420,7 +420,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
>   			return;
>   
>   		vunmap(shmem->vaddr);
> -		drm_gem_shmem_put_pages_locked(shmem);
> +		drm_gem_shmem_unpin_locked(shmem);
>   	}
>   
>   	shmem->vaddr = NULL;
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 3a4be433d5f0..8b9bba87ae63 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -130,7 +130,7 @@ int drm_gem_shmem_madvise_locked(struct drm_gem_shmem_object *shmem, int madv);
>   static inline bool drm_gem_shmem_is_purgeable(struct drm_gem_shmem_object *shmem)
>   {
>   	return (shmem->madv > 0) &&
> -		!shmem->vmap_use_count && shmem->sgt &&
> +		!refcount_read(&shmem->pages_pin_count) && shmem->sgt &&
>   		!shmem->base.dma_buf && !drm_gem_is_imported(&shmem->base);
>   }
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


