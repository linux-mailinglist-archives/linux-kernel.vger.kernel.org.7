Return-Path: <linux-kernel+bounces-588978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D457A7C017
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 16:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF1317359D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7979C1F419D;
	Fri,  4 Apr 2025 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YJBZSFWg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8PTvIkqP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YJBZSFWg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8PTvIkqP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C61F416A
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778707; cv=none; b=IYubP6oQ9OQl/R//IxJb15d5YjERM2nE1Qby85Ww26S3GjG4LXNeBqwyYmJRcVNKwV/hm643GRtYti/USMIbF4fvXZc/cR46t51OIk6MDe2KMYdBqgfgeK7wmxS0JbEXk7uU23aVF3V+dJRZxP1bwwmoh5fGckQ0vjjvxzrcPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778707; c=relaxed/simple;
	bh=DuDXxPmeyV0AQ6HZWiHwwN2XpVrnDA8PZdKvA2mo+sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2rf0NptkXyG/OPrmrJnqKtRn3T1fK2ho1IYdq7mh297iRbWxKeV90ulvZfaKBwzPArbM84gqqzUSFonYCE/9HQ6+NrtBTTCYTZavnFLaCQBIR+h4/VK9mdbfgGcKTBjbRrb2VVEkqMxhOnzEfje/XtfT/+Gshc9dgnxGXySUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YJBZSFWg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8PTvIkqP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YJBZSFWg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8PTvIkqP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 815E7211A7;
	Fri,  4 Apr 2025 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743778701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zEjvuHDkGc5e4ViPRtssNgeC0CjY4cA3zlNgk3SctQI=;
	b=YJBZSFWg7wrm8E8alqbTNbmSw4TqTAt7mGba0+TjCeraIuaDqXcBgwn8dldciNH2V45vvV
	066qhH9PV7PWJSxpQ4LCfTu21z1CwRarU2kfehXuSVgFM6LZmkMy/1y166g8eLSJzpE41R
	EcQRgEv7KdqHDPKSj17EaYWVh9SZh3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743778701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zEjvuHDkGc5e4ViPRtssNgeC0CjY4cA3zlNgk3SctQI=;
	b=8PTvIkqPILLu2Yjf4YA/xbuiHkkdB92idPVaxYQiCKVMzksnSDvAfSuBO4s+Rh2KVdHHdd
	E2zyoN7GmyQeipCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743778701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zEjvuHDkGc5e4ViPRtssNgeC0CjY4cA3zlNgk3SctQI=;
	b=YJBZSFWg7wrm8E8alqbTNbmSw4TqTAt7mGba0+TjCeraIuaDqXcBgwn8dldciNH2V45vvV
	066qhH9PV7PWJSxpQ4LCfTu21z1CwRarU2kfehXuSVgFM6LZmkMy/1y166g8eLSJzpE41R
	EcQRgEv7KdqHDPKSj17EaYWVh9SZh3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743778701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zEjvuHDkGc5e4ViPRtssNgeC0CjY4cA3zlNgk3SctQI=;
	b=8PTvIkqPILLu2Yjf4YA/xbuiHkkdB92idPVaxYQiCKVMzksnSDvAfSuBO4s+Rh2KVdHHdd
	E2zyoN7GmyQeipCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CEFF13691;
	Fri,  4 Apr 2025 14:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9FHGBY3z72cedwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 04 Apr 2025 14:58:21 +0000
Message-ID: <edf93bc7-3289-4b1c-9698-e5e2cc5a6910@suse.de>
Date: Fri, 4 Apr 2025 16:58:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 09/10] drm/shmem-helper: Switch
 drm_gem_shmem_vmap/vunmap to use pin/unpin
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Qiang Yu <yuq825@gmail.com>,
 Steven Price <steven.price@arm.com>, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
 <20250322212608.40511-10-dmitry.osipenko@collabora.com>
 <ea4f4059-7748-4bfd-9205-8e95222144da@suse.de>
 <710cdbd4-2c6e-48b7-b12b-972ab6d12abf@collabora.com>
 <20250402152102.01d9cfee@collabora.com>
 <a8ed4b8b-5116-4ac2-bfce-21b2751f7377@suse.de>
 <20250403105053.788b0f6e@collabora.com>
 <29cfb98b-fe27-4243-abe4-ce66aa504573@suse.de>
 <20250404165233.139814ee@collabora.com>
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
In-Reply-To: <20250404165233.139814ee@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,amd.com,redhat.com,arm.com,imgtec.com,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi

Am 04.04.25 um 16:52 schrieb Boris Brezillon:
> On Fri, 4 Apr 2025 10:01:50 +0200
> Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
>>>> In your case, vmap an pin both intent to hold the shmem pages in memory.
>>>> They might be build on top of the same implementation, but one should
>>>> not be implemented with the other because of their different meanings.
>>> But that's not what we do, is it? Sure, in drm_gem_shmem_vmap_locked(),
>>> we call drm_gem_shmem_pin_locked(), but that's an internal function to
>>> make sure the pages are allocated and stay around until
>>> drm_gem_shmem_vunmap_locked() is called.
>>>
>>> I guess we could rename pin_count into hard_refcount or
>>> page_residency_count or xxx_count, and change the pin/unpin_locked()
>>> function names accordingly, but that's just a naming detail, it doesn't
>>> force you to call drm_gem_pin() to vmap() your GEM, it's something we
>>> do internally.
>> Such a rename would be much appreciated. page_residency_count seems
>> appropriate.
> On a second thought, I think I prefer
> 'unevictable_count/inc_unevictable()/dec_unevictable()'. But looking at

Ok

> the gem-vram changes you just posted, it looks like gem-shmem is not the
> only one to use the term 'pin' for this page pinning thing, so if we go
> and plan for a rename, I'd rather make it DRM-wide than gem-shmem being
> the outlier yet again :-).

Which one do you mean?

- The code in gem-vram does pinning in the TTM sense of the term.

- From the client code, the pinning got removed.

- The GEM pin/unpin callbacks are still there, but the long-term plan is 
to go to dma-buf pin callbacks AFAICT.

- Renaming the dma-buf pin/unpin would be a kernel-wide change. Not 
likely to happen.

Best regards
Thomas


-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


