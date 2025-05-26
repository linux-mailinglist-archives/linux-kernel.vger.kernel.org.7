Return-Path: <linux-kernel+bounces-662442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBCDAC3ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 09:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB22F172BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792131DE2BA;
	Mon, 26 May 2025 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ac4GeXDJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O4M2pN3x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ac4GeXDJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O4M2pN3x"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7679E1
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748245030; cv=none; b=mSnUER3ISE+CpEazkAUXCgRNa3bgzMkFuZDmW71TejpkS4VqPnFPc98mHDYXt7yEDK16K5sioxDDPC72+xL74YIrK5alKbLRahutLRyDps+Y8p/eqbHhV1bRP5ASSwY8+TVh19OKjmJhTGAsX2VNKsmtFo4Nb2uMJk5eOLMAQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748245030; c=relaxed/simple;
	bh=y0JAPnEp/e2MhifYcuGIVLYgqHE4KhhZBcqPYjeMNKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWnSjxDiSoWrmZpJucf0YiaNNNlxzfivuUO+rHmpkedZd/stKgVW5DX3TTWWT+aXnmsn7QkKEdu8s8gad4y6wIuctlQUfDD9sLBC/Zi61AOOc7UGnTvvFmeKnPiL5l995ZWRiKc8J8xPKUID4fgT+CdrnMCnyAZLaAsFQZEEgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ac4GeXDJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O4M2pN3x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ac4GeXDJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O4M2pN3x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 681B41F82E;
	Mon, 26 May 2025 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748245021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0tgYcHpg58AssMOpCtxIg59OVtioVv9oCAtVIXTJFyE=;
	b=Ac4GeXDJx/AIygOzUN7osijBAVw6fw3R14Jp5woKBoookSlAg10xGdmsAImXEGyhg4/Eja
	9TD7AP2wiq/uuzKJ0aGJRUeBp6ouHfyfxS6wPfctB/LWHhPCC4ifcC67L55Bq7v6gEWRcy
	hqvGQgjbipigpHjiVdioXv7Y+II91Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748245021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0tgYcHpg58AssMOpCtxIg59OVtioVv9oCAtVIXTJFyE=;
	b=O4M2pN3xZlqfaM/XfR+aJUMC9CTjBkCy+pvltIfj1JnbiCJX9d7mtsfPm42aLwcZ61AwxG
	LtRGOIhuPtU6C6Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748245021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0tgYcHpg58AssMOpCtxIg59OVtioVv9oCAtVIXTJFyE=;
	b=Ac4GeXDJx/AIygOzUN7osijBAVw6fw3R14Jp5woKBoookSlAg10xGdmsAImXEGyhg4/Eja
	9TD7AP2wiq/uuzKJ0aGJRUeBp6ouHfyfxS6wPfctB/LWHhPCC4ifcC67L55Bq7v6gEWRcy
	hqvGQgjbipigpHjiVdioXv7Y+II91Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748245021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0tgYcHpg58AssMOpCtxIg59OVtioVv9oCAtVIXTJFyE=;
	b=O4M2pN3xZlqfaM/XfR+aJUMC9CTjBkCy+pvltIfj1JnbiCJX9d7mtsfPm42aLwcZ61AwxG
	LtRGOIhuPtU6C6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21BB21397F;
	Mon, 26 May 2025 07:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HVfTBh0aNGgsOgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 26 May 2025 07:37:01 +0000
Message-ID: <13d467f7-a94a-4268-84e3-30cce57a4758@suse.de>
Date: Mon, 26 May 2025 09:37:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: drm_auth: Convert mutex usage to guard(mutex)
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, Kees Cook <keescook@chromium.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20250509142627.639419-1-andrealmeid@igalia.com>
 <7133e9b4-c05a-4901-940e-de3e70bbbb1e@suse.de>
 <df1d45c0-60f0-4850-9324-ab52a3f7f8e1@igalia.com>
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
In-Reply-To: <df1d45c0-60f0-4850-9324-ab52a3f7f8e1@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[igalia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hi

Am 22.05.25 um 20:28 schrieb André Almeida:
> Hi Thomas,
>
> Em 12/05/2025 03:52, Thomas Zimmermann escreveu:
>> Hi
>>
>> Am 09.05.25 um 16:26 schrieb André Almeida:
>>> Replace open-coded mutex handling with cleanup.h guard(mutex). This
>>> simplifies the code and removes the "goto unlock" pattern.
>>>
>>> Tested with igt tests core_auth and core_setmaster.
>>>
>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>
> Do you mind applying this patch at drm-misc?

Merged into drm-misc-next. Thanks for the patch.

Best regards
Thomas

>
> Thanks!
>     André

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


