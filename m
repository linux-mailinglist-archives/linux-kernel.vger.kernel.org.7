Return-Path: <linux-kernel+bounces-877101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A54C1D325
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AF13B8E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC03363354;
	Wed, 29 Oct 2025 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V6Kid69o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X+it/9Fd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V6Kid69o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X+it/9Fd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9A35BDDA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769670; cv=none; b=NaO48W+USfTZnb+gGiA8HvIbQh1oSLuanq3fsue4iiW5vQCdl2CTT7Ru2+q75YG3V0aJVVU5E2WPHq6xH7w3f7GYBAM5POsXqTWWSpkd2XMiahGJBPlT0U79UiXK2+mANdMddQ43lZJUfUtYv/MbVBfqTsF4TGzAwvXEJ3AjfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769670; c=relaxed/simple;
	bh=75pTJMrTKe3oDF01IHZkZpay5eJJ1BZyk4F2j4Bwtw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGc3dQHyWp8xvkiilXgvpxeltMCs0YTUaGmt9cubGKMcznZdYDXTBLBYx3Jt7WxcFYhSEW9/CcEYd6dGPamEjLDuoxynP4Ke4BAAECA7BGurwKaRhDUGPxdfZ4MFsZCvobsm1lXYLVq8CjTRG41XJLRXmr2EcWAwuxct3Y0nX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V6Kid69o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X+it/9Fd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V6Kid69o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X+it/9Fd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B2275C6FB;
	Wed, 29 Oct 2025 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761769666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JD2FUf38fOoTeMwlsMVywNN3B2fcbRWq5blQ0ApmDZQ=;
	b=V6Kid69oe95ElkUmg+y7J+s9eqdjQYAN5N/9aCmEUtanQHgv5w60OxiIJ4z9tZ+qlM5H9A
	k3PJEroWyVvJYaYH8AS+y2IMt+MLvbenk9QuNyxwBkEvYYWebX6IONQyBQujtpkQO/xD0X
	n3aCj5+RvltcX0Q70NT5BBx2FHgWG8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761769666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JD2FUf38fOoTeMwlsMVywNN3B2fcbRWq5blQ0ApmDZQ=;
	b=X+it/9Fdyaz51k9AIi1CDYk66gBp+10ZoLJ5FuPqovu/5SI1eQI5Ut+ZowY3SblvQDognI
	PTFcV+rrzwkrUFAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761769666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JD2FUf38fOoTeMwlsMVywNN3B2fcbRWq5blQ0ApmDZQ=;
	b=V6Kid69oe95ElkUmg+y7J+s9eqdjQYAN5N/9aCmEUtanQHgv5w60OxiIJ4z9tZ+qlM5H9A
	k3PJEroWyVvJYaYH8AS+y2IMt+MLvbenk9QuNyxwBkEvYYWebX6IONQyBQujtpkQO/xD0X
	n3aCj5+RvltcX0Q70NT5BBx2FHgWG8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761769666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JD2FUf38fOoTeMwlsMVywNN3B2fcbRWq5blQ0ApmDZQ=;
	b=X+it/9Fdyaz51k9AIi1CDYk66gBp+10ZoLJ5FuPqovu/5SI1eQI5Ut+ZowY3SblvQDognI
	PTFcV+rrzwkrUFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EF401349D;
	Wed, 29 Oct 2025 20:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5qzWAcJ4AmlkEwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 29 Oct 2025 20:27:46 +0000
Message-ID: <af053518-94fa-4650-97b1-f7f28706e0ad@suse.de>
Date: Wed, 29 Oct 2025 21:27:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arch/powerpc: Add missing includes
To: Thierry Reding <thierry.reding@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20251029150940.2523328-1-thierry.reding@gmail.com>
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
In-Reply-To: <20251029150940.2523328-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linux.ibm.com,ellerman.id.au];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,csgroup.eu,lists.ozlabs.org,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi

Am 29.10.25 um 16:09 schrieb Thierry Reding:
> From: Thierry Reding <treding@nvidia.com>
>
> Hi,
>
> I've recently been doing a few test builds for some of the more exotic
> platforms out there for a patch series that I'm working on and ran into
> some issues that seem to have been caused by the framebuffer include
> rework. I see that Thomas did address some of those already, but it
> looks like I've been running with slightly different configurations or
> something that caused these additional ones to come up.
>
> Given that theese seem to have been broken for more than a year and it's
> not exactly clear which commit it caused, I didn't bother adding a Fixes
> line, but still wanted to send these out in case we want to keep these
> platforms building.
>
> Thierry
>
> Thierry Reding (2):
>    arch/powerpc: Add missing linux/of.h include
>    macintosh/via-pmu-backlight: Include uapi/linux/fb.h

See 
https://lore.kernel.org/dri-devel/20251027140646.227025-1-tzimmermann@suse.de/

>
>   arch/powerpc/platforms/powermac/backlight.c | 1 +
>   drivers/macintosh/via-pmu-backlight.c       | 1 +
>   2 files changed, 2 insertions(+)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



