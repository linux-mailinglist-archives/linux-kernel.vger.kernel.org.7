Return-Path: <linux-kernel+bounces-860335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CA6BEFE59
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 001E64EEE31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81692E093C;
	Mon, 20 Oct 2025 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wl5q8KU1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+/hQyYlA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KjN4XHH0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eh22V2By"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434F2E1F13
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948492; cv=none; b=mHUqeJHLLeOfejjwe2SXR1iMsk5atRFhUQmwr8BIrLZWam/LbIPSzOrIk3EUz5afUS5W38F2goHPgE+W0YUVEmPrbWm+ais8WLP3ESQaTGaPHnHVkE1jG7nKj/R2Zwi4n8AZ3y312eKlQyQ7k3Ru7wVjcFLfwrdCSEfMHhwz4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948492; c=relaxed/simple;
	bh=XY1HEXtzgvQJs0wvcQOM+HtR8vO+DhqmEickokUF4kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+bjqFqUmLH4L968TW9675OjfiPdxQvF3T7IuvPWN+SB4zl+ymt0nqNuCxwWDT4dJVZQWJmfZioFGrI2Td13TBkj11weub0Nn92Jriq4+6j27nYOugiXUdpzxjmTzfJh/Mi9M/s0o4j7QVCoBjdpmPrsDnhDChD36QKbMlhkHGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wl5q8KU1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+/hQyYlA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KjN4XHH0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eh22V2By; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08A212123A;
	Mon, 20 Oct 2025 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760948486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fym7/MfvMmAWCR/2f9MTtMKZ7XaRlSNrE7oKTd790Vk=;
	b=Wl5q8KU1V+QOwJDvaGiF+np2/cC875lKDlZJGBWCY+u1jvoh6KdB6iRy9pYBSUjjspn+ID
	fZbT0nakfbf0qh2QVqbAdhhaa6c1FftX0csOJscTSroAXWPRpxklEeky/HTdjeVNm4MlVs
	0KeQyIdWD4duJuTE1QHDlybRMnfz1pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760948486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fym7/MfvMmAWCR/2f9MTtMKZ7XaRlSNrE7oKTd790Vk=;
	b=+/hQyYlAN8zCli36UBg8fdNtO1LQVkOCeUWMGevls//KRvl4rJuuysIYg8b+/G7tpM5155
	VZnWHncEYwiERZAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KjN4XHH0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eh22V2By
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760948482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fym7/MfvMmAWCR/2f9MTtMKZ7XaRlSNrE7oKTd790Vk=;
	b=KjN4XHH0jctC5WGbwSYmbuvwE/UMpLEKX82N499QrExjrnnFljOIE7wxk7Bh0EPW3Hrk9T
	34zrv/Vz71M6QCx+w2me0eOMqGYlZZdNWWP7Jxi86nwTznag/VKgSNZUfFiFzFLLMgn9vi
	up8M+AlhJ6MWCKuYk4Vq6nlWH1tBUTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760948482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fym7/MfvMmAWCR/2f9MTtMKZ7XaRlSNrE7oKTd790Vk=;
	b=eh22V2ByHZJSNT8mmTsuFNziO/0u0QKTBW+lq2Ih6xmrTYCZZ3OnqUqo1xeMfx8G320d07
	9X87GzsSDyN/AWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B68FC13AAD;
	Mon, 20 Oct 2025 08:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n99lKwHx9Wj6QwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 20 Oct 2025 08:21:21 +0000
Message-ID: <5d237d1a-a528-4205-a4d8-71709134f1e1@suse.de>
Date: Mon, 20 Oct 2025 10:21:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: bitblit: bound-check glyph index in bit_putcs*
To: Junjie Cao <junjie.cao@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Zsolt Kajtar <soci@c64.rulez.org>
Cc: Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
References: <20251019235331.1243671-1-junjie.cao@intel.com>
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
In-Reply-To: <20251019235331.1243671-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 08A212123A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,ffwll.ch,gmx.de,c64.rulez.org];
	URIBL_BLOCKED(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,appspotmail.com:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.freedesktop.org,googlegroups.com,syzkaller.appspotmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[793cf822d213be1a74f2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,appspotmail.com:email,syzkaller.appspot.com:url]
X-Spam-Score: -3.01

Hi

Am 20.10.25 um 01:53 schrieb Junjie Cao:
> bit_putcs_aligned()/unaligned() derived the glyph pointer from the
> character value masked by 0xff/0x1ff, which may exceed the actual font's
> glyph count and read past the end of the built-in font array.
> Clamp the index to the actual glyph count before computing the address.
>
> This fixes a global out-of-bounds read reported by syzbot.
>
> Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
> Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   drivers/video/fbdev/core/bitblit.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
> index a9ec7f488522..710883831826 100644
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
> @@ -79,12 +79,15 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
>   				     struct fb_image *image, u8 *buf, u8 *dst)
>   {
>   	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
> +	unsigned int charcnt = vc->vc_font.charcount;
>   	u32 idx = vc->vc_font.width >> 3;
>   	u8 *src;
>   
>   	while (cnt--) {
> -		src = vc->vc_font.data + (scr_readw(s++)&
> -					  charmask)*cellsize;
> +		u16 ch = scr_readw(s++) & charmask;
> +	if (ch >= charcnt)
> +		ch = 0;
> +	src = vc->vc_font.data + (unsigned int)ch * cellsize;

Indention looks off.

>   
>   		if (attr) {
>   			update_attr(buf, src, attr, vc);
> @@ -112,14 +115,17 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
>   				       u8 *dst)
>   {
>   	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
> +	unsigned int charcnt = vc->vc_font.charcount;
>   	u32 shift_low = 0, mod = vc->vc_font.width % 8;
>   	u32 shift_high = 8;
>   	u32 idx = vc->vc_font.width >> 3;
>   	u8 *src;
>   
>   	while (cnt--) {
> -		src = vc->vc_font.data + (scr_readw(s++)&
> -					  charmask)*cellsize;
> +		u16 ch = scr_readw(s++) & charmask;
> +	if (ch >= charcnt)
> +		ch = 0;
> +	src = vc->vc_font.data + (unsigned int)ch * cellsize;

Same here.

Best regards
Thomas

>   
>   		if (attr) {
>   			update_attr(buf, src, attr, vc);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



