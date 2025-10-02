Return-Path: <linux-kernel+bounces-839885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F32BB2A63
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C2019C3190
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395342BEFF9;
	Thu,  2 Oct 2025 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gq3aGnqm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7l3JkK7g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gq3aGnqm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7l3JkK7g"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376F29B793
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759387944; cv=none; b=bComNTKYYKBcDQKpbuZfs644sCkzUUXiNyEkB3Jg1Pv8Vq8yMKHYjQnbwMsno1nZE8tTdGv6kNIJ9ukSe0b8LzUkgeyqMqC9J3VTPzzoosKd01lU/GxwBSH3l86zrFWGgCXgp92X5Vh+REMsIMrl7LtFpLcsn9suRJEoGAUxV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759387944; c=relaxed/simple;
	bh=vBtjUYfL5XawyKktYeASRIFujrDGiGAVw08JYbW6ye0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AklbKyriYdJxxKeMu6bTPBTorndphYsy9bT5fpAU/K1QqTCPA9xABJ5KitpZh4zbxpT4G78nKH2Sdv6BTqOSNvBD7HSBxM57HkqkFD4IoOmvBlQrVq9RLxUuivnl7JNjAtN87Mj405Avmz2q2OqubvRiO7h7yYgGglgJrlueKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gq3aGnqm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7l3JkK7g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gq3aGnqm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7l3JkK7g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B59E1F441;
	Thu,  2 Oct 2025 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759387938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l+ZTQ1bmTapXB3Hii4bhClrslIo1fiFAaICxXgyG7wU=;
	b=gq3aGnqm/qdYCtgHNzdM9ETWuUxei1byGHI2fsIF25XXx16FKmxI8l2ab9FlIs8A06QHxs
	qD/2Gh8p9RsGWM1P1jdPMMXwdj0FCcdgg6362pXJzUldpqSBvyuA/mZfKLZQo+24EmnYBJ
	189CFL2vIcvH7TNvzPrIqJL9ho976aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759387938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l+ZTQ1bmTapXB3Hii4bhClrslIo1fiFAaICxXgyG7wU=;
	b=7l3JkK7gGlqf3vheWFT9idRnUsckBcP6efEI918L4rU1sHQVAWmGd/aKp01vO0Y+ePPt+N
	67ydMFokKrfDiTAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gq3aGnqm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7l3JkK7g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759387938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l+ZTQ1bmTapXB3Hii4bhClrslIo1fiFAaICxXgyG7wU=;
	b=gq3aGnqm/qdYCtgHNzdM9ETWuUxei1byGHI2fsIF25XXx16FKmxI8l2ab9FlIs8A06QHxs
	qD/2Gh8p9RsGWM1P1jdPMMXwdj0FCcdgg6362pXJzUldpqSBvyuA/mZfKLZQo+24EmnYBJ
	189CFL2vIcvH7TNvzPrIqJL9ho976aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759387938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l+ZTQ1bmTapXB3Hii4bhClrslIo1fiFAaICxXgyG7wU=;
	b=7l3JkK7gGlqf3vheWFT9idRnUsckBcP6efEI918L4rU1sHQVAWmGd/aKp01vO0Y+ePPt+N
	67ydMFokKrfDiTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFDAC13990;
	Thu,  2 Oct 2025 06:52:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U6kBMSEh3mjvNQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 Oct 2025 06:52:17 +0000
Message-ID: <41ef536d-2399-43f8-8041-c6b0e642aba2@suse.de>
Date: Thu, 2 Oct 2025 08:52:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
To: Helge Deller <deller@gmx.de>, sukrut heroorkar <hsukrut3@gmail.com>,
 David Hunter <david.hunter.linux@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Bernie Thompson <bernie@plugable.com>,
 Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zsolt Kajtar <soci@c64.rulez.org>,
 Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org
References: <20250924175743.6790-1-hsukrut3@gmail.com>
 <202509272320.3K8kdDCw-lkp@intel.com>
 <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com>
 <CAHCkknrZ-ieNKeg-aj3-NVqgGSk770jJpUpCvn_SuffkPu+ZrQ@mail.gmail.com>
 <edccab86-321b-4e6e-998f-3ce320ee0193@gmx.de>
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
In-Reply-To: <edccab86-321b-4e6e-998f-3ce320ee0193@gmx.de>
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.de,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FREEMAIL_CC(0.00)[intel.com,plugable.com,arndb.de,infradead.org,linaro.org,c64.rulez.org,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev,linuxfoundation.org];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4B59E1F441
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Hi

Am 02.10.25 um 08:41 schrieb Helge Deller:
>>>> kernel test robot noticed the following build errors:
>>>
>>> Did you compile and test this code before submitting this patch?
>>
>> Yes, I had compiled & loaded the udlfb module with no errors. Please
>> let me know how to proceed in this case.
>
> Look at the reported build error, which seems to happen in dev_dbg().
> So, maybe in your testing you did not have debugging enabled?
> The report contains the .config file with which you can test.

Can we rather make an effort to remove the udlfb driver entirely? A few 
years back, there was one user who was still using it because of some 
problems with the DRM udl driver. But I think we've addressed them. The 
discussion is at [1].

[1] 
https://lore.kernel.org/dri-devel/20201130125200.10416-1-tzimmermann@suse.de/

Best regards
Thomas

>
> Helge

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



