Return-Path: <linux-kernel+bounces-729498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD17B03789
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E36D16489A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76322E3FA;
	Mon, 14 Jul 2025 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wYpbPg2u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1hTz/oSQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GsPuPZSv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nXkMySLu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031B194A60
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476887; cv=none; b=kzb7AjYFcwfxLtlqwFWxd1vjsG4TdB7/OEKb07hVDsxOrnDyYitZFZqNj1r4JyM1IVvXPFhnxwesb85aOA31q9hKVmGy2CvIMYiedpA20ndpprCBRDsBjLdsHoki6S2rUK4Fu3cq0j0BBtZrpXSdRX+vRZZVvM2+yXjwoOppvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476887; c=relaxed/simple;
	bh=Oriz5VGKQltekX5NIL6mvm+mGd1Dre8yFLTxrpEH/Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SBWNiErZ3TDASCVpWgHuYH2wbe15i6dmUm43q/pdXJB4dZD7o26JWTV2/+sdlVk6hvcDB4ECuIy9FL6B5Dm6TE3UT+Kj615dUipB3TJiavIt0/Efnx/zYMgVJ+QrQ7SxQA4/YryCGRWJsl5Vkp77RUqk0ndxqLB2wjzv+8aNOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wYpbPg2u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1hTz/oSQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GsPuPZSv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nXkMySLu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3466210F9;
	Mon, 14 Jul 2025 07:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752476884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=31NPws7H+tcl3mR7XnbV9wl80HTHUksAbyl02AaLwG4=;
	b=wYpbPg2utPvlu6LB3aT67IuAl0U54vEOqaCKppLdYvHObvJGHS+khREECcpNaHQpyWSFBK
	b+YNzYE/nWtz6jJ2FkNkWIC4RPjqUlDOvO9DFtj+qM2xfqNvMZUy6p83LGvBMzAd6WIBKv
	ztcJanGbn7NlkPePszelnGgyi37ueZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752476884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=31NPws7H+tcl3mR7XnbV9wl80HTHUksAbyl02AaLwG4=;
	b=1hTz/oSQM7KbhLwAoTvo3FP9XPMSBGvHBUAmTZsmrIB3RRoxOKSiVFxC8NMg7h3ezLQ1ch
	xvStVUV07TWCWOCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GsPuPZSv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nXkMySLu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752476883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=31NPws7H+tcl3mR7XnbV9wl80HTHUksAbyl02AaLwG4=;
	b=GsPuPZSv416b3Iff/BjZclj+b71ub7cZIefc2Q4QNFsxLZn+14ywNNj0mRfRgNSxLVhzPv
	MA5yCeZVa1ogjPZwoD0gnFgIhT5dV1vmFLxuqvxxj98HVdKD4sxM8Tm4E9eLLyHBSpyQLx
	TevuUYm/pdglf08M/buiaBGrDPvVx8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752476883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=31NPws7H+tcl3mR7XnbV9wl80HTHUksAbyl02AaLwG4=;
	b=nXkMySLu/cZRzkHG4QlV5Fq+kekyL7eLR1WChB+FhDw/0GAzyYUaOTYkkgE1TctfaaaCPE
	mozND3GM8CAj/SBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAD82138A1;
	Mon, 14 Jul 2025 07:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IoxNJ9OsdGiXEwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 14 Jul 2025 07:08:03 +0000
Message-ID: <05b62107-902f-496a-aa0a-e9c3b38a7552@suse.de>
Date: Mon, 14 Jul 2025 09:08:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING at drm_gem_object_handle_put_unlocked+0xaa/0xe0
To: =?UTF-8?Q?Jacek_=C5=81uczak?= <difrost.kernel@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, christian.koenig@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
References: <04b26880-202e-428d-8aa2-cf83210ae72a@gmail.com>
 <b18cf3cf-eed1-4a30-9d01-3ea3015e126e@gmail.com>
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
In-Reply-To: <b18cf3cf-eed1-4a30-9d01-3ea3015e126e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,amd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: E3466210F9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

Hi

Am 12.07.25 um 12:05 schrieb Jacek Łuczak:
> Hi,
>
>> While checking on this issue I've found[2] and applied the patch 
>> posted by Thomes which fixed the issue.
>>
> After a longer use I find this is causing some weird graphics behavior 
> notably an attempt to start Wayland session sometimes timeouts with no 
> errors in the logs but e.g. reboot fails with attached errors (CC 
> @Mario).
>
> If I'll find some time to bisect the original issue I'll report it back.

You might be seeing the same epoll error that Linus saw and that is 
mentioned in the -rc6 announcement.

Best regards
Thomas

>
> Regards,
> -jacek

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


