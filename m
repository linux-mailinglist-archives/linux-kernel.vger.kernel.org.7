Return-Path: <linux-kernel+bounces-581442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F090FA75F56
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE0E1889A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 07:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148B273F9;
	Mon, 31 Mar 2025 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oFg1gK8o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wjDRYzhA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lSquOEQz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fs5PfK5y"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B66F9CB
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405356; cv=none; b=pbsLJQ8H5MPcf/TeCIecULrfqnF56jxPHKb98rpyIKicdcAVj3TJULsXkWtjN8OKLXW1yftx2M1GlB/vQwU+EvDRiXGzlU7XD0MHGOk6VDpw+29/9FUGENhePpzQRSjiCcwtoewgxB4bw5qyCm+o5WBmMzc4rREmNnc9rboc1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405356; c=relaxed/simple;
	bh=joxQy1bFW31ooU1HyYRwusWAaZWU4tjw4mSSUMaI3as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5x3w40XDGlBPPTqTOwgaO2aLZFX4zk4CdXKAjGgI0heYZxvFYRF1XuVkfWFPi2u8OtzrJzatfjXV4unir81rnqcW06N3mq7iD/D5C0J8k3OCZ9P7HPVD9MsLMd4QLTnILj1UImK7CyCU1ajH6P1PpO6BoRBLJNQqkJ/0A0bXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oFg1gK8o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wjDRYzhA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lSquOEQz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fs5PfK5y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E367021174;
	Mon, 31 Mar 2025 07:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743405352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lMf7BkFlomVn+3BURC4WMY8EIFh7cIxFbkZYJjSmOcQ=;
	b=oFg1gK8oYgDm0BYgjjE0o00jaDhwF4zU+m1ZCM+CnlzuxocY4mRusay1ktTvxYmYFYcsY3
	IU0MvYefx154OHWqzzEZTazpeVJFVzWCEHsPR6A7UsUt/yBnTRCTU2PBSAEEHvd3VhqvTh
	yv80s15wV+83jgqTLezX1xxt1rEhHwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743405352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lMf7BkFlomVn+3BURC4WMY8EIFh7cIxFbkZYJjSmOcQ=;
	b=wjDRYzhAL0Q/1g2LwtQ34pmRZB153FlysclNkYS3ZEC3dl+5JfXpnfBOpOoMH7zN7Mfef+
	AR69fliOOv51XiDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lSquOEQz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fs5PfK5y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743405351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lMf7BkFlomVn+3BURC4WMY8EIFh7cIxFbkZYJjSmOcQ=;
	b=lSquOEQzoPg3mN+gUxOkaaq+a3ytZci6RkeoOPGPsgvIsmgRskaCO2GuZHp3wWC7I51e08
	M5Hd0779ZJrHJipzpaiIxgj+/zUyq7HtcaqbP/EaJzklHDT0oIqCm86+MNz+KsvejeQzbm
	DuSrRSleCqVfoegP488fMwTqz6+tHP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743405351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lMf7BkFlomVn+3BURC4WMY8EIFh7cIxFbkZYJjSmOcQ=;
	b=fs5PfK5yh3dlShBtsjela1JvaYgQMWj1AH2vhJ839R7d2vP67FFmJ8nfSswFiJ3W4bhNc8
	7Fbaxe2DLGI6E9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8718013A1F;
	Mon, 31 Mar 2025 07:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TpiZHydB6meOJAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 31 Mar 2025 07:15:51 +0000
Message-ID: <e2085799-e235-436a-8c5c-f6a51cbaeaaa@suse.de>
Date: Mon, 31 Mar 2025 09:15:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/6] drm/shmem: Add a helper to check object's page
 backing status
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250326021433.772196-1-adrian.larumbe@collabora.com>
 <20250326021433.772196-6-adrian.larumbe@collabora.com>
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
In-Reply-To: <20250326021433.772196-6-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E367021174
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[collabora.com,linux-foundation.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,arm.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi

Am 26.03.25 um 03:14 schrieb Adrián Larumbe:
> Provide a helper function that lets shmem API users know whether a given
> object is backed by physical pages, or else in the case of a sparse
> shmem object, at least one of them is populated.
>
> The obvious user is fdinfo, which needs to know an object's resident
> status.
>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>   drivers/gpu/drm/drm_gem_shmem_helper.c | 18 ++++++++++++++++++
>   include/drm/drm_gem_shmem_helper.h     |  2 ++
>   2 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 1bf33e5a1c4c..79ac7c7c953f 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -1033,6 +1033,24 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
>   }
>   EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_sg_table);
>   
> +/**
> + * drm_gem_shmem_is_populated - Tell whether the shem object is backed by
> + *                 at least one page of physical memory
> + * @shmem: shmem GEM object
> + *
> + * Returns:
> + * A boolean, where the 'true' value depends on at least one page being preset
> + * in a sparse object's xarray, or all the shmem file pages for PRIME buffers
> + * and regular shmem objects.
> + */
> +bool drm_gem_shmem_is_populated(struct drm_gem_shmem_object *shmem)
> +{
> +	return (shmem->base.import_attach ||

The field import_attach should no longer be tested for detecting 
imported buffers. Use drm_gem_is_imported() instead.

Best regards
Thomas

> +		(!shmem->sparse && shmem->pages) ||
> +		(shmem->sparse && !xa_empty(&shmem->xapages)));
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_is_populated);
> +
>   MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
>   MODULE_IMPORT_NS("DMA_BUF");
>   MODULE_LICENSE("GPL v2");
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index cbe4548e3ff6..60d2b8ef230b 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -302,6 +302,8 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
>   int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>   			      struct drm_mode_create_dumb *args);
>   
> +bool drm_gem_shmem_is_populated(struct drm_gem_shmem_object *shmem);
> +
>   /**
>    * DRM_GEM_SHMEM_DRIVER_OPS - Default shmem GEM operations
>    *

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


