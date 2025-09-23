Return-Path: <linux-kernel+bounces-828560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16220B94E35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BF9168B80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D009317707;
	Tue, 23 Sep 2025 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ug5kf7vC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cjB69hDh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ug5kf7vC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cjB69hDh"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9FB314A90
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614235; cv=none; b=K17ks/iPMdvRNj8FtoHpdRSrE/kBqppZnI80/Jy9gBbBt9Oh2My71AdKNxoq4I2MXkPjVxlyLQHG0/5EKb+4iaLBO3/HG2bopTS7Nj8SL0a4TAhHhrsiOhnmyE2pWGOFm6UBJVlwbaQRCWMQnl8yrn4iOI1ZmD81bu8bXt/aTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614235; c=relaxed/simple;
	bh=3AoT8KdkLOc4maQZZuxm+PUN3VoGm2BtidVkKw/vhM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krB6XF0sywIdl0kzi22pddVBWZMScY57/IBq/n9ARZ6t4cDGdzGxRZoajoxgyCBZ6OBDfrwpTwVQcKAn4bkgdTrMzaTH2qv86UZSDIr/liEEcZvHSx+WEytpOk3BGsjNv9sJg3q3v7Zi29gGGqBbBJE1gYCvkjlLI9ess0dEcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ug5kf7vC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cjB69hDh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ug5kf7vC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cjB69hDh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CDA821247;
	Tue, 23 Sep 2025 07:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758614232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SRa0oo56Nc1/wXkI28v5M+pP/sqU1f7eNCaLPFfU8wo=;
	b=ug5kf7vCFGhOELgJv7r0kRmEEUqmsVRZFz6v3NTJiM+gRqAVvGkf+qEcUtoEgD5pwjcWQk
	WFm9Ssx38qBoxLw6ttMIBD4LqiLPsJC73RoFTnOkqGQva0PXuM1x8IOaDz3BZFq7YebngK
	+Ayw3RnbU7+V67wmEeXsiTXJ+cKQByU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758614232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SRa0oo56Nc1/wXkI28v5M+pP/sqU1f7eNCaLPFfU8wo=;
	b=cjB69hDhj52fQzrLtHZeDfrdNasqn+FSWRJhwNdi6EW94UD7OzeP0kLSWbRAktrDQ88G3O
	SEwBxQ5AQmEjECDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758614232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SRa0oo56Nc1/wXkI28v5M+pP/sqU1f7eNCaLPFfU8wo=;
	b=ug5kf7vCFGhOELgJv7r0kRmEEUqmsVRZFz6v3NTJiM+gRqAVvGkf+qEcUtoEgD5pwjcWQk
	WFm9Ssx38qBoxLw6ttMIBD4LqiLPsJC73RoFTnOkqGQva0PXuM1x8IOaDz3BZFq7YebngK
	+Ayw3RnbU7+V67wmEeXsiTXJ+cKQByU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758614232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SRa0oo56Nc1/wXkI28v5M+pP/sqU1f7eNCaLPFfU8wo=;
	b=cjB69hDhj52fQzrLtHZeDfrdNasqn+FSWRJhwNdi6EW94UD7OzeP0kLSWbRAktrDQ88G3O
	SEwBxQ5AQmEjECDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB21A132C9;
	Tue, 23 Sep 2025 07:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0DdrKNdS0mj9NgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 23 Sep 2025 07:57:11 +0000
Message-ID: <a8e2ce0c-0aed-41b6-9856-acf62f60551b@suse.de>
Date: Tue, 23 Sep 2025 09:57:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gud: fix accidentally deleted IS_ERR() check
To: Ruben Wauters <rubenru09@aol.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, lkp@intel.com,
 oe-kbuild@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250922173836.5608-1-rubenru09.ref@aol.com>
 <20250922173836.5608-1-rubenru09@aol.com>
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
In-Reply-To: <20250922173836.5608-1-rubenru09@aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[aol.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[aol.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,linaro.org:email,intel.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

FYI I got the following warnings. I'll fix them when I merge the patch.

-:6: ERROR:GIT_COMMIT_ID: Please use git commit description style 
'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 2d2f1dc74cfb 
("drm: gud: replace WARN_ON/WARN_ON_ONCE with drm versions")'
#6:
During conversion of WARN_ON_ONCE to drm_WARN_ON_ONCE in commit

-:15: WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately 
followed by Closes: with a URL to the report
#15:
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>


Am 22.09.25 um 19:32 schrieb Ruben Wauters:
> During conversion of WARN_ON_ONCE to drm_WARN_ON_ONCE in commit
> 2d2f1dc74cfb ("drm: gud: replace WARN_ON/WARN_ON_ONCE with drm
> versions"), the IS_ERR check was accidentally removed, breaking the
> gud_connector_add_properties() function, as any valid pointer in
> state_val would produce an error.
>
> The warning was reported by kernel test robot, and is fixed in this patch.
>
> Fixes: 2d2f1dc74cfb ("drm: gud: replace WARN_ON/WARN_ON_ONCE with drm versions")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202509212215.c8v3RKmL-lkp@intel.com/
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> ---
>   drivers/gpu/drm/gud/gud_connector.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
> index 62e349b06dbe..1726a3fadff8 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -593,7 +593,7 @@ int gud_connector_fill_properties(struct drm_connector_state *connector_state,
>   			unsigned int *state_val;
>   
>   			state_val = gud_connector_tv_state_val(prop, &connector_state->tv);
> -			if (drm_WARN_ON_ONCE(connector_state->connector->dev, state_val))
> +			if (drm_WARN_ON_ONCE(connector_state->connector->dev, IS_ERR(state_val)))
>   				return PTR_ERR(state_val);
>   
>   			val = *state_val;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



