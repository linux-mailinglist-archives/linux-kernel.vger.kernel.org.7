Return-Path: <linux-kernel+bounces-685520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB9FAD8ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 13:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A5318981C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8952E0B56;
	Fri, 13 Jun 2025 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fGRcHaVg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NWneG4sG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fGRcHaVg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NWneG4sG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC992DFA2F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814859; cv=none; b=ltTxUOSHflOIPECCd5qFyWIZ6Xad7cyFEALq0O5Qt6sBKXYIlXGLE4BcWF4IqpEkP4TfQkghDoEKRMzULg4TMbH77IzoDj3SeEmf0aszMYU9ZtY7z1f8iKfapSLtsfNJnQ/msZOfe/rcFmKqN/7CALSlf7v1BMv2+cPGlO/SPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814859; c=relaxed/simple;
	bh=3uw5VUh/DqhrYkitcO3Ub7yKF46Sf6kT9VPpjmbdVok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eea/0oMUbzG8xLe7KPVTcd1xEJ2U2qb3nkNYn5ii3Abnh2ajLGRJifTLLXMpapvRTb7VokTo5ofGLfuFLZuSPdOm1QgfqZj5l9XhaXqB7bEP99cdbK2Jrm+JBw6j4OisPSh5C7rWCTVMbq4tHs/+PAU8ThuTpNYKXqGwfrH/x30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fGRcHaVg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NWneG4sG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fGRcHaVg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NWneG4sG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2DE2321749;
	Fri, 13 Jun 2025 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749814855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ui+2NR8PHPMbz98Hu9Hxy1TPwrhV0ozwjHMRatemvYY=;
	b=fGRcHaVgvbrdC12QLl5Tu3zycV9x8IvnsIYiepRSZ0eD+YtLWAx6tiqzhne+TSEOWwECLs
	ScbGUFNNwFvMuqlhcwA5Md7l8f4G1mh0QVvYrM+wMCq445n8arXDPsyK2mKyx5lg948dW3
	5F+nvKCMfV3BWGsnlRIi/HZL6878hPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749814855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ui+2NR8PHPMbz98Hu9Hxy1TPwrhV0ozwjHMRatemvYY=;
	b=NWneG4sGCSXJqDTn15f24iNneFd4DMcDjL2Xq9tb7igXbSxP/g6EzcZmuoyrPStFpbqcuj
	TwfC9DWon/94OlBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749814855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ui+2NR8PHPMbz98Hu9Hxy1TPwrhV0ozwjHMRatemvYY=;
	b=fGRcHaVgvbrdC12QLl5Tu3zycV9x8IvnsIYiepRSZ0eD+YtLWAx6tiqzhne+TSEOWwECLs
	ScbGUFNNwFvMuqlhcwA5Md7l8f4G1mh0QVvYrM+wMCq445n8arXDPsyK2mKyx5lg948dW3
	5F+nvKCMfV3BWGsnlRIi/HZL6878hPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749814855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ui+2NR8PHPMbz98Hu9Hxy1TPwrhV0ozwjHMRatemvYY=;
	b=NWneG4sGCSXJqDTn15f24iNneFd4DMcDjL2Xq9tb7igXbSxP/g6EzcZmuoyrPStFpbqcuj
	TwfC9DWon/94OlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF791137FE;
	Fri, 13 Jun 2025 11:40:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kOGQLUYOTGh2YgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 13 Jun 2025 11:40:54 +0000
Message-ID: <51d92681-188e-40d8-bda0-f4ff95eeccd7@suse.de>
Date: Fri, 13 Jun 2025 13:40:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm: panel: add support for Samsung S6E8AA5X01 panel
 controller
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250612-panel-samsung-s6e8aa5x01-v1-0-06dcba071ea6@disroot.org>
 <20250612-panel-samsung-s6e8aa5x01-v1-2-06dcba071ea6@disroot.org>
 <84ee6388-92af-49c8-988b-b79ed1453d5e@suse.de>
 <84663a88789b993a1cab8c55af4e03a7@disroot.org>
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
In-Reply-To: <84663a88789b993a1cab8c55af4e03a7@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,quicinc.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,oss.qualcomm.com,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,disroot.org:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi

Am 13.06.25 um 13:03 schrieb Kaustabh Chakraborty:
> On 2025-06-13 09:39, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 12.06.25 um 16:52 schrieb Kaustabh Chakraborty:
>>> Samsung S6E8AA5X01 is an AMOLED MIPI DSI panel controller. Implement
>>> a basic panel driver for such panels.
>>>
>>> The driver also initializes a backlight device, which works by changing
>>> the panel's gamma values and aid brightness levels appropriately, with
>>> the help of look-up tables acquired from downstream kernel sources.
>>>
>>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> [...]
>
>>> +
>>> +static void s6e8aa5x01_mcs_protect(struct mipi_dsi_multi_context *dsi,
>>> +				   struct s6e8aa5x01_ctx *ctx, bool protect)
>> I found this interface confusing. Rather split it up into .  It also does two different things AFAICT.
>>
>> - The mcs_mutex protects against concurrent access from update_status and enable
> mcs_mutex is meant to prevent any early access protection of the MCS commands.
> Suppose there are two functions, A and B, accessing MCS.
>
> ENTRY: A()
> (access protection disabled)
> ...
>
> ENTRY: B()
> (access protection disabled)
> ...
> (access protection enabled)
> EXIT: B()
>
> [!] cannot access MCS commands here anymore
> (access protection enabled)
> EXIT: A()
>
> And to avoid such errors a mutex is provided.

This mutex protects a lot more than just the access flags. It prevents 
backlight and enable code to concurrently set gamma on the device. Even 
if you move the MCS_ACCESSPROT to enable/disable helpers, you'll likely 
need the mutex around the gamma updates.

But there's maybe an easy fix. See that the panel code already calls the 
backlight helpers in its enable/disable [1][2] functions. They will 
invoke ->update_status with the proper locking. [3] This means that you 
shouldn't program gamma in the ->enable callback. Leave everything in 
->update_status and let your panel helpers deal with it. No need for 
mcs_mutex at all.

[1] 
https://elixir.bootlin.com/linux/v6.15.1/source/drivers/gpu/drm/drm_panel.c#L235
[2] 
https://elixir.bootlin.com/linux/v6.15.1/source/drivers/gpu/drm/drm_panel.c#L275
[3] 
https://elixir.bootlin.com/linux/v6.15.1/source/include/linux/backlight.h#L318

>
>> - MSC_ACCESSPROT enable access to hardware state.
>>
>> Maybe try this:
>>
>> - Move msc_mutex into the callers, so that ->update_status and ->enable acquire and release the lock.
>>
>> - Move MCS_ACCESSPROT into ->enable and ->disable and leave it accessible, if the hardware allows that.
> Yeah this is a good idea, I'll try it.
>
>>> +{
>>> +	if (protect) {
>>> +		mipi_dsi_dcs_write_seq_multi(dsi, MCS_ACCESSPROT, 0xa5, 0xa5);
>>> +		mutex_unlock(&ctx->mcs_mutex);
>>> +	} else {
>>> +		mutex_lock(&ctx->mcs_mutex);
>>> +		mipi_dsi_dcs_write_seq_multi(dsi, MCS_ACCESSPROT, 0x5a, 0x5a);
>>> +	}
>>> +}
>>> +
>>> +static int s6e8aa5x01_update_brightness(struct backlight_device *backlight)#
>> Maybe call this function s6e8aa5x01_update_status() to match the callback.
>>
>>> +{
>>> +	struct mipi_dsi_multi_context dsi = { .dsi = bl_get_data(backlight) };
>>> +	struct s6e8aa5x01_ctx *ctx = mipi_dsi_get_drvdata(dsi.dsi);
>>> +	u16 lvl = backlight->props.brightness;
>> backlight_get_brightness() here ?
>>
>>
>> I think you should also check panel->enabled and return if false. AFAIU there will be no gamma changes on disabled hardware anyway.
>>
> The enable function is never executed when the panel is disabled. This is
> because flag checking is done by drm_panel anyway. See drm_panel_enable()
> in drivers/gpu/drm/drm_panel.c [1]

What I mean is: the drm_panel.enabled flag is set at [4] and cleared at 
[5]. It tells you that the panel is running. If someone tries to update 
the backlight brightness while the panel is not enabled, you likely what 
to return here without touching hardware.

[4] 
https://elixir.bootlin.com/linux/v6.15.1/source/drivers/gpu/drm/drm_panel.c#L285
[5] 
https://elixir.bootlin.com/linux/v6.15.1/source/drivers/gpu/drm/drm_panel.c#L233

>
>>> +
>>> +static int s6e8aa5x01_probe(struct mipi_dsi_device *dsi)
>>> +{
>>> +	struct device *dev = &dsi->dev;
>>> +	struct s6e8aa5x01_ctx *ctx;
>>> +	int ret;
>>> +
>>> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> You're possibly using the instance after the hardware device has been removed. Alloc with drmm_kzalloc() or you might end up with UAF errors.
> Hmm, none of the panel drivers are using drmm_kzalloc(), or even any
> drmm_*(). Are you sure I must use it?

Then leave it as it is. Maybe one of the panel maintainers can confirm.

I still don't trust it to not possibly blow up. devm_ is released when 
the hardware device goes away.

Best regards
Thomas

>
>>> +	ret = devm_mutex_init(dev, &ctx->mcs_mutex);
>> You're taking this mutex in DRM code, so rather use drmm_mutex_init() here.
> (The comment by me above applies here too)
>
>> Best regards
>> Thomas
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/gpu/drm/drm_panel.c#n209

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


