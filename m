Return-Path: <linux-kernel+bounces-870971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A7C0C1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BE618A24E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFE32DECA0;
	Mon, 27 Oct 2025 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O6t3yN7H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f2SBiat1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O6t3yN7H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f2SBiat1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947112DCF52
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549859; cv=none; b=dT5cq56OhwVX1C4XGZ+2dzPd2skwFyOde0c7rd1bG4epWKA20SvYxN0uT62apXgtK+cwtQ2tJCqODQ1s5TX6kZP4ItQ3bpcHiJ/yuPK6y4pS4NNjCN+SSQEY+08hoALFY48fBOqyZxXKmQ5okhfX4Q35gj3RFTygxwYrqdNmny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549859; c=relaxed/simple;
	bh=JNjGa8idN23koh5nsHZAd0wdkU/eiHfFwRa946nqX3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pcGSXssfVADhqaHIHSGIvG2m2YZhAdp+5K1h58bkiAVxVYejDwbt12DcmuAX5eaMnUZORl3np6gSXdpBCC0mSovjRhGR6IBFEEJLOyc/HG1RNAtPEv2jGXGT6RrGPFaUw/mTCRMiUmcfWImBFhyWC72/Fbr4XP+I0waRedHkgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O6t3yN7H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f2SBiat1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O6t3yN7H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f2SBiat1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A20EB21A70;
	Mon, 27 Oct 2025 07:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761549855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iMe8dRWv3FNYb5B9g/tXMzwkBNkIkqzHS237Oj8Eliw=;
	b=O6t3yN7H2+lSQlGx4Wrs9KeFAtz/Gs5U7ps7mraNimP+iFahedVCdy7zevEHpB6rEqqWxE
	XYyCkm7T9CNpxYb1F7LRvbrYVTD2WcL8cmnzoF0+c7AEmjTS3z4s77YK+wWKanFoGkM1hK
	3i+wvHY0sZNsfIBdsfMkhrx0KqZkap8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761549855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iMe8dRWv3FNYb5B9g/tXMzwkBNkIkqzHS237Oj8Eliw=;
	b=f2SBiat1S9g5jhqEsFvu6U4v9SC0lsgh3z8Jf8f0m/ReSnA13VzNlHlC4pDItWa1MPZOCA
	tT749p7iGmEAbfBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761549855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iMe8dRWv3FNYb5B9g/tXMzwkBNkIkqzHS237Oj8Eliw=;
	b=O6t3yN7H2+lSQlGx4Wrs9KeFAtz/Gs5U7ps7mraNimP+iFahedVCdy7zevEHpB6rEqqWxE
	XYyCkm7T9CNpxYb1F7LRvbrYVTD2WcL8cmnzoF0+c7AEmjTS3z4s77YK+wWKanFoGkM1hK
	3i+wvHY0sZNsfIBdsfMkhrx0KqZkap8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761549855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iMe8dRWv3FNYb5B9g/tXMzwkBNkIkqzHS237Oj8Eliw=;
	b=f2SBiat1S9g5jhqEsFvu6U4v9SC0lsgh3z8Jf8f0m/ReSnA13VzNlHlC4pDItWa1MPZOCA
	tT749p7iGmEAbfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57825136CF;
	Mon, 27 Oct 2025 07:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U+/xEh8e/2hRXQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 27 Oct 2025 07:24:15 +0000
Message-ID: <305e7ccf-82bc-43dd-8fac-1c39ffe183d3@suse.de>
Date: Mon, 27 Oct 2025 08:24:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Resolve the issue of VGA not detecting
 disconnection
To: 2564278112@qq.com, lyude@redhat.com, dakr@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlie@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jiangwang@kylinos.cn
References: <tencent_7EF61E8ABB90946288975CE501E2D9673C06@qq.com>
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
In-Reply-To: <tencent_7EF61E8ABB90946288975CE501E2D9673C06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,redhat.com,kernel.org,linux.intel.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,kylinos.cn];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,qq.com:email,suse.de:email,suse.de:mid,kylinos.cn:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30



Am 27.10.25 um 04:16 schrieb 2564278112@qq.com:
> From: Wang Jiang <jiangwang@kylinos.cn>
>
> When using the GT730, I found that the VGA could recognize when it was plugged in,
> but could not detect when it was disconnected.
> The reason is that the polled flag for the connector is missing DRM_CONNECTOR_POLL_DISCONNECT.
>
> Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/nouveau/nouveau_connector.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 63621b1510f6..dfff01edf65a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1421,7 +1421,7 @@ nouveau_connector_create(struct drm_device *dev, int index)
>   	connector->doublescan_allowed = false;
>   
>   	drm_connector_helper_add(connector, &nouveau_connector_helper_funcs);
> -	connector->polled = DRM_CONNECTOR_POLL_CONNECT;
> +	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
>   
>   	if (nvif_object_constructed(&nv_connector->conn.object)) {
>   		ret = nvif_conn_event_ctor(&nv_connector->conn, "kmsHotplug",

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



