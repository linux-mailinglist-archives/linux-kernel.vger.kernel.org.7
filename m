Return-Path: <linux-kernel+bounces-655700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F849ABD9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 15:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F358B175D58
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE926241CB7;
	Tue, 20 May 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mly2KS3I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LRU268jS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mly2KS3I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LRU268jS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5527715
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748958; cv=none; b=XmyMlCIQImxkjouHKhUxLFlJYtQnBkkCwLH7aEflGRyCMvlci5uAgZz8W8PKw7OFQqq/BUYnvPKiflxg6GWPfHQqqOhHvFanTRHfWbFAlZeN6RUixDOtEdYx3xPgUTnH3OLNzPGlp4zvRRdnNfCIaGP0zLw5eRx2hMr7vUMjDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748958; c=relaxed/simple;
	bh=/7VWxyML0vhfRCRDPfsAONOkPvqvpuIQvH3cnTg6A0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmVf6V1LS/fqDc5U8+Mo4ZG0SauuQqS2B6WbwvvsBxOp6O+QZZP/UDpsZ425/uwRa6hm+gLZtyJa8V63JpV1cDwMwk7WEksa2YzjeMZLYq867ttVCzOuPr9io5cyIk2NnNzAGvpoxQCI1EvIoprXvyh5e7g01Wf1swqVviaz96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mly2KS3I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LRU268jS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mly2KS3I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LRU268jS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6921F21FD1;
	Tue, 20 May 2025 13:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747748954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RZM3TBrxZ9gV4DGlqhfK6QoDDrye6xmauHV1rnGmWSo=;
	b=Mly2KS3I0NbyhSJJz7h6ruYYwaHp/fHXCq11O1fT8DP7aV/C/Y30EYo2uiVDHJueRowmFb
	w/jClxindqho6mWfikBzmJmqhlH98/sDYtKKI8FzOrqJIQDJBL9g6hygCXICADEpJPc8wm
	6yY96T0WsokpVXC5hrrPFeyQD0AipKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747748954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RZM3TBrxZ9gV4DGlqhfK6QoDDrye6xmauHV1rnGmWSo=;
	b=LRU268jSD4WF+otrYrdGkTmH1eEoo/LZA++Bp0MzsNwIrUiKyjnHWzB1py/+OzeGrz6CtB
	0x16ubzzcNnE0cBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747748954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RZM3TBrxZ9gV4DGlqhfK6QoDDrye6xmauHV1rnGmWSo=;
	b=Mly2KS3I0NbyhSJJz7h6ruYYwaHp/fHXCq11O1fT8DP7aV/C/Y30EYo2uiVDHJueRowmFb
	w/jClxindqho6mWfikBzmJmqhlH98/sDYtKKI8FzOrqJIQDJBL9g6hygCXICADEpJPc8wm
	6yY96T0WsokpVXC5hrrPFeyQD0AipKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747748954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RZM3TBrxZ9gV4DGlqhfK6QoDDrye6xmauHV1rnGmWSo=;
	b=LRU268jSD4WF+otrYrdGkTmH1eEoo/LZA++Bp0MzsNwIrUiKyjnHWzB1py/+OzeGrz6CtB
	0x16ubzzcNnE0cBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C7EB13A3E;
	Tue, 20 May 2025 13:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TgiGCVqILGgbGwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 20 May 2025 13:49:14 +0000
Message-ID: <990c04a5-6477-42c0-986d-9b63a30ac90b@suse.de>
Date: Tue, 20 May 2025 15:49:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sitronix: Fix broken backwards-compatibility layer
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <1682cd80989f9ab98a7a9910a086a3a4d9769cc6.1747744752.git.geert+renesas@glider.be>
 <07088966-73f4-4b5d-898d-b596dede53e4@suse.de>
 <CAMuHMdU6XD_tqXaf4-h9KeC58XDOodUWa0d-Wmp6zcr2BHTA1w@mail.gmail.com>
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
In-Reply-To: <CAMuHMdU6XD_tqXaf4-h9KeC58XDOodUWa0d-Wmp6zcr2BHTA1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

Hi

Am 20.05.25 um 15:09 schrieb Geert Uytterhoeven:
> Hi Thomas,
>
> On Tue, 20 May 2025 at 15:04, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Am 20.05.25 um 14:40 schrieb Geert Uytterhoeven:
>>> When moving the Sitronix DRM drivers and renaming their Kconfig symbols,
>>> the old symbols were kept, aiming to provide a seamless migration path
>>> when running "make olddefconfig" or "make oldconfig".
>>>
>>> However, the old compatibility symbols are not visible.  Hence unless
>>> they are selected by another symbol (which they are not), they can never
>>> be enabled, and no backwards compatibility is provided.
>>>
>>> Fix this by making them visible, and inverting the selection logic.
>>> Add comments to make it clear why there are two symbols with the same
>>> description.
>> These symbols were only meant for variants of 'make oldconfig' to pick
>> up th enew symbols. They where never for being selected manually.
> But that pick-up does not work, unfortunately...
> (I know, I had one of them enabled in one of my configs ;-)

I see.

>
> The alternative is to just drop the old symbols, and ignore current users.
> Which is not that uncommon...

If there's no easy fix for the current setup, I'd prefer removing the 
old symbols.

Best regards
Thomas

>
> Gr{oetje,eeting}s,
>
>                          Geert
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


