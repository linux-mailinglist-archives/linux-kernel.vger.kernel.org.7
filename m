Return-Path: <linux-kernel+bounces-729881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E39B03CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387E51897F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4FC245031;
	Mon, 14 Jul 2025 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="guGQsJX9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U/13GNpM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="guGQsJX9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U/13GNpM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570C244660
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490959; cv=none; b=C224U7RV3u9yBMrKy+5MuuYKYkJDk22rKqodV0hnTZ8Ha5Xap0+NSPlYYmODhj4VMoSMPDwYD+4fBMUC4l3uX24WAaqt357xkDxqsV8XjAbFDKA3GMDf2uploCd7xaXX27zLgvXyMbMioJl7d4akJeQt7yX4CF9RbcuR1f7x8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490959; c=relaxed/simple;
	bh=yMnMf9OjK34RZX4RllQsdRX7wtSf7Fg4Ks6c9hnhjoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Onmh2cYfRU9hUbZSFO8mCPB1QyGz0A8qE0+LVgxfcjZlmHzdnlU2wPXk0z5agWIteyUhEbKAgF89zAnGNDyQ1ZiMerIT4cv60R+iOi3U69jL4NcP1vktksp7kmfww1tDjgSrfPVNlFsAUff/2/5OqR5lYa078ShbfaHrrPao8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=guGQsJX9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U/13GNpM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=guGQsJX9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U/13GNpM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52BEA211D4;
	Mon, 14 Jul 2025 11:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752490954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jImuvTpF+YHjYKjFbeAcxsIVCLL9cH+SQxZdVF7L18c=;
	b=guGQsJX9kMttFP1NNxLcHDWSFpkDlipoafeO6QWP1TQCy5ba1CCLx+M+WH2Z6HNvUe1SfQ
	MPsbL+j6NM+Ot0/N2WeK8U+O7J7deDfrR0QtVC7viqSsFpOHt+h/LwN+Cs0HokDO0YgEh5
	FeID+34XAVv+140yfoennWruAkc+8vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752490954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jImuvTpF+YHjYKjFbeAcxsIVCLL9cH+SQxZdVF7L18c=;
	b=U/13GNpMQ7ZXc1DuBfKJ6ja63+DWCOfOZpPoCw78hWw/wxsS1lRXfPqxpcdxoiQaS+mLIC
	kBf3wY3L5wyXTlBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752490954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jImuvTpF+YHjYKjFbeAcxsIVCLL9cH+SQxZdVF7L18c=;
	b=guGQsJX9kMttFP1NNxLcHDWSFpkDlipoafeO6QWP1TQCy5ba1CCLx+M+WH2Z6HNvUe1SfQ
	MPsbL+j6NM+Ot0/N2WeK8U+O7J7deDfrR0QtVC7viqSsFpOHt+h/LwN+Cs0HokDO0YgEh5
	FeID+34XAVv+140yfoennWruAkc+8vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752490954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jImuvTpF+YHjYKjFbeAcxsIVCLL9cH+SQxZdVF7L18c=;
	b=U/13GNpMQ7ZXc1DuBfKJ6ja63+DWCOfOZpPoCw78hWw/wxsS1lRXfPqxpcdxoiQaS+mLIC
	kBf3wY3L5wyXTlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18DDC138A1;
	Mon, 14 Jul 2025 11:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D6WkBMrjdGhwXgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 14 Jul 2025 11:02:34 +0000
Message-ID: <046193df-bb11-4d84-98a4-c6d46d359316@suse.de>
Date: Mon, 14 Jul 2025 13:02:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/tests: edid: Update CTA-861 HDMI Vendor Specific
 Data Block
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250625-drm-update-edid-v1-0-2d963743ab9e@kernel.org>
 <20250625-drm-update-edid-v1-2-2d963743ab9e@kernel.org>
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
In-Reply-To: <20250625-drm-update-edid-v1-2-2d963743ab9e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

Hi

Am 25.06.25 um 17:14 schrieb Maxime Ripard:
> For some reason, the HDMI VSDBs in our kunit EDIDs had a length longer
> than expected.
>
> While this was harmless, we should get rid of it to make it somewhat
> predictable.

Dump question: should these errors be kept in another test specifically 
for detecting this problem?

Best regards
Thomas

>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/tests/drm_kunit_edid.h | 85 ++++++++++++++++------------------
>   1 file changed, 40 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.h b/drivers/gpu/drm/tests/drm_kunit_edid.h
> index ac311804b36ccb21f865ecec90dd2557bff0e4b2..14782a3840f00c50c7daee38bba98585003c13a2 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_edid.h
> +++ b/drivers/gpu/drm/tests/drm_kunit_edid.h
> @@ -71,18 +71,18 @@ static const unsigned char test_edid_dvi_1080p[] = {
>    * 45 00 40 84 63 00 00 1e 00 00 00 fc 00 54 65 73
>    * 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd 00 32
>    * 46 1e 46 0f 00 0a 20 20 20 20 20 20 00 00 00 10
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 92
>    *
> - * 02 03 1b 81 e3 05 00 20 41 10 e2 00 4a 6d 03 0c
> - * 00 12 34 00 14 20 00 00 00 00 00 00 00 00 00 00
> + * 02 03 15 81 e3 05 00 20 41 10 e2 00 4a 67 03 0c
> + * 00 12 34 00 14 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> - * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e4
> + * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10
>    *
>    * ----------------
>    *
>    * Block 0, Base EDID:
>    *   EDID Structure Version & Revision: 1.3
> @@ -133,12 +133,11 @@ static const unsigned char test_edid_dvi_1080p[] = {
>    *     IT scan behavior: Always Underscanned
>    *     CE scan behavior: Always Underscanned
>    *   Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
>    *     Source physical address: 1.2.3.4
>    *     Maximum TMDS clock: 100 MHz
> - *     Extended HDMI video details:
> - * Checksum: 0xe4  Unused space in Extension Block: 100 bytes
> + * Checksum: 0x10  Unused space in Extension Block: 106 bytes
>    */
>   static const unsigned char test_edid_hdmi_1080p_rgb_max_100mhz[] = {
>   	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
>   	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
> @@ -147,22 +146,22 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_100mhz[] = {
>   	0x2d, 0x40, 0x58, 0x2c, 0x45, 0x00, 0x40, 0x84, 0x63, 0x00, 0x00, 0x1e,
>   	0x00, 0x00, 0x00, 0xfc, 0x00, 0x54, 0x65, 0x73, 0x74, 0x20, 0x45, 0x44,
>   	0x49, 0x44, 0x0a, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xfd, 0x00, 0x32,
>   	0x46, 0x1e, 0x46, 0x0f, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
>   	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x92, 0x02, 0x03, 0x1b, 0x81,
> -	0xe3, 0x05, 0x00, 0x20, 0x41, 0x10, 0xe2, 0x00, 0x4a, 0x6d, 0x03, 0x0c,
> -	0x00, 0x12, 0x34, 0x00, 0x14, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x92, 0x02, 0x03, 0x15, 0x81,
> +	0xe3, 0x05, 0x00, 0x20, 0x41, 0x10, 0xe2, 0x00, 0x4a, 0x67, 0x03, 0x0c,
> +	0x00, 0x12, 0x34, 0x00, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0xe4
> +	0x00, 0x00, 0x00, 0x10
>   };
>   
>   /*
>    * edid-decode (hex):
>    *
> @@ -173,18 +172,18 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_100mhz[] = {
>    * 45 00 40 84 63 00 00 1e 00 00 00 fc 00 54 65 73
>    * 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd 00 32
>    * 46 1e 46 0f 00 0a 20 20 20 20 20 20 00 00 00 10
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 92
>    *
> - * 02 03 1b 81 e3 05 00 20 41 10 e2 00 4a 6d 03 0c
> - * 00 12 34 00 28 20 00 00 00 00 00 00 00 00 00 00
> + * 02 03 15 81 e3 05 00 20 41 10 e2 00 4a 67 03 0c
> + * 00 12 34 00 28 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> - * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 d0
> + * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
>    *
>    * ----------------
>    *
>    * Block 0, Base EDID:
>    *   EDID Structure Version & Revision: 1.3
> @@ -235,12 +234,11 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_100mhz[] = {
>    *     IT scan behavior: Always Underscanned
>    *     CE scan behavior: Always Underscanned
>    *   Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
>    *     Source physical address: 1.2.3.4
>    *     Maximum TMDS clock: 200 MHz
> - *     Extended HDMI video details:
> - * Checksum: 0xd0  Unused space in Extension Block: 100 bytes
> + * Checksum: 0xfc  Unused space in Extension Block: 106 bytes
>    */
>   static const unsigned char test_edid_hdmi_1080p_rgb_max_200mhz[] = {
>   	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
>   	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
> @@ -249,22 +247,22 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_200mhz[] = {
>   	0x2d, 0x40, 0x58, 0x2c, 0x45, 0x00, 0x40, 0x84, 0x63, 0x00, 0x00, 0x1e,
>   	0x00, 0x00, 0x00, 0xfc, 0x00, 0x54, 0x65, 0x73, 0x74, 0x20, 0x45, 0x44,
>   	0x49, 0x44, 0x0a, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xfd, 0x00, 0x32,
>   	0x46, 0x1e, 0x46, 0x0f, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
>   	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x92, 0x02, 0x03, 0x1b, 0x81,
> -	0xe3, 0x05, 0x00, 0x20, 0x41, 0x10, 0xe2, 0x00, 0x4a, 0x6d, 0x03, 0x0c,
> -	0x00, 0x12, 0x34, 0x00, 0x28, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x92, 0x02, 0x03, 0x15, 0x81,
> +	0xe3, 0x05, 0x00, 0x20, 0x41, 0x10, 0xe2, 0x00, 0x4a, 0x67, 0x03, 0x0c,
> +	0x00, 0x12, 0x34, 0x00, 0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0xd0
> +	0x00, 0x00, 0x00, 0xfc
>   };
>   
>   /*
>    * edid-decode (hex):
>    *
> @@ -275,18 +273,18 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_200mhz[] = {
>    * 45 00 40 84 63 00 00 1e 00 00 00 fc 00 54 65 73
>    * 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd 00 32
>    * 46 1e 46 0f 00 0a 20 20 20 20 20 20 00 00 00 10
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 92
>    *
> - * 02 03 1b 81 e3 05 00 20 41 10 e2 00 4a 6d 03 0c
> - * 00 12 34 00 28 20 00 00 00 00 00 00 00 00 00 00
> + * 02 03 15 81 e3 05 00 20 41 10 e2 00 4a 67 03 0c
> + * 00 12 34 00 44 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> - * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 d0
> + * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e0
>    *
>    * ----------------
>    *
>    * Block 0, Base EDID:
>    *   EDID Structure Version & Revision: 1.3
> @@ -337,12 +335,11 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_200mhz[] = {
>    *     IT scan behavior: Always Underscanned
>    *     CE scan behavior: Always Underscanned
>    *   Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
>    *     Source physical address: 1.2.3.4
>    *     Maximum TMDS clock: 340 MHz
> - *     Extended HDMI video details:
> - * Checksum: 0xd0  Unused space in Extension Block: 100 bytes
> + * Checksum: 0xe0  Unused space in Extension Block: 106 bytes
>    */
>   static const unsigned char test_edid_hdmi_1080p_rgb_max_340mhz[] = {
>   	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
>   	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
> @@ -351,22 +348,22 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_340mhz[] = {
>   	0x2d, 0x40, 0x58, 0x2c, 0x45, 0x00, 0x40, 0x84, 0x63, 0x00, 0x00, 0x1e,
>   	0x00, 0x00, 0x00, 0xfc, 0x00, 0x54, 0x65, 0x73, 0x74, 0x20, 0x45, 0x44,
>   	0x49, 0x44, 0x0a, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xfd, 0x00, 0x32,
>   	0x46, 0x1e, 0x46, 0x0f, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
>   	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x92, 0x02, 0x03, 0x1b, 0x81,
> -	0xe3, 0x05, 0x00, 0x20, 0x41, 0x10, 0xe2, 0x00, 0x4a, 0x6d, 0x03, 0x0c,
> -	0x00, 0x12, 0x34, 0x00, 0x44, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x92, 0x02, 0x03, 0x15, 0x81,
> +	0xe3, 0x05, 0x00, 0x20, 0x41, 0x10, 0xe2, 0x00, 0x4a, 0x67, 0x03, 0x0c,
> +	0x00, 0x12, 0x34, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0xd0
> +	0x00, 0x00, 0x00, 0xe0
>   };
>   
>   /*
>    * edid-decode (hex):
>    *
> @@ -377,18 +374,18 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_340mhz[] = {
>    * 45 00 40 84 63 00 00 1e 00 00 00 fc 00 54 65 73
>    * 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd 00 32
>    * 46 1e 46 0f 00 0a 20 20 20 20 20 20 00 00 00 10
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 7a
>    *
> - * 02 03 1b b1 e3 05 00 20 41 10 e2 00 ca 6d 03 0c
> - * 00 12 34 78 28 20 00 00 00 00 00 00 00 00 00 00
> + * 02 03 15 b1 e3 05 00 20 41 10 e2 00 ca 67 03 0c
> + * 00 12 34 78 28 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> - * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8
> + * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 d4
>    *
>    * ----------------
>    *
>    * Block 0, Base EDID:
>    *   EDID Structure Version & Revision: 1.3
> @@ -445,12 +442,11 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_340mhz[] = {
>    *     DC_48bit
>    *     DC_36bit
>    *     DC_30bit
>    *     DC_Y444
>    *     Maximum TMDS clock: 200 MHz
> - *     Extended HDMI video details:
> - * Checksum: 0xa8  Unused space in Extension Block: 100 bytes
> + * Checksum: 0xd4  Unused space in Extension Block: 106 bytes
>    */
>   static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz[] = {
>   	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
>   	0x1a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
> @@ -459,22 +455,22 @@ static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz[] = {
>   	0x2d, 0x40, 0x58, 0x2c, 0x45, 0x00, 0x40, 0x84, 0x63, 0x00, 0x00, 0x1e,
>   	0x00, 0x00, 0x00, 0xfc, 0x00, 0x54, 0x65, 0x73, 0x74, 0x20, 0x45, 0x44,
>   	0x49, 0x44, 0x0a, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xfd, 0x00, 0x32,
>   	0x46, 0x1e, 0x46, 0x0f, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
>   	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x7a, 0x02, 0x03, 0x1b, 0xb1,
> -	0xe3, 0x05, 0x00, 0x20, 0x41, 0x10, 0xe2, 0x00, 0xca, 0x6d, 0x03, 0x0c,
> -	0x00, 0x12, 0x34, 0x78, 0x28, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x7a, 0x02, 0x03, 0x15, 0xb1,
> +	0xe3, 0x05, 0x00, 0x20, 0x41, 0x10, 0xe2, 0x00, 0xca, 0x67, 0x03, 0x0c,
> +	0x00, 0x12, 0x34, 0x78, 0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0xa8
> +	0x00, 0x00, 0x00, 0xd4
>   };
>   
>   /*
>    * edid-decode (hex):
>    *
> @@ -485,18 +481,18 @@ static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz[] = {
>    * 45 00 40 84 63 00 00 1e 00 00 00 fc 00 54 65 73
>    * 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd 00 32
>    * 46 1e 46 0f 00 0a 20 20 20 20 20 20 00 00 00 10
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 8a
>    *
> - * 02 03 1b b1 e3 05 00 20 41 10 e2 00 ca 6d 03 0c
> - * 00 12 34 78 44 20 00 00 00 00 00 00 00 00 00 00
> + * 02 03 15 b1 e3 05 00 20 41 10 e2 00 ca 67 03 0c
> + * 00 12 34 78 44 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> - * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c
> + * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 b8
>    *
>    * ----------------
>    *
>    * Block 0, Base EDID:
>    *   EDID Structure Version & Revision: 1.3
> @@ -553,12 +549,11 @@ static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz[] = {
>    *     DC_48bit
>    *     DC_36bit
>    *     DC_30bit
>    *     DC_Y444
>    *     Maximum TMDS clock: 340 MHz
> - *     Extended HDMI video details:
> - * Checksum: 0x8c  Unused space in Extension Block: 100 bytes
> + * Checksum: 0xb8  Unused space in Extension Block: 106 bytes
>    */
>   static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz[] = {
>   	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
>   	0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
> @@ -567,20 +562,20 @@ static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz[] = {
>   	0x2d, 0x40, 0x58, 0x2c, 0x45, 0x00, 0x40, 0x84, 0x63, 0x00, 0x00, 0x1e,
>   	0x00, 0x00, 0x00, 0xfc, 0x00, 0x54, 0x65, 0x73, 0x74, 0x20, 0x45, 0x44,
>   	0x49, 0x44, 0x0a, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xfd, 0x00, 0x32,
>   	0x46, 0x1e, 0x46, 0x0f, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
>   	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x8a, 0x02, 0x03, 0x1b, 0xb1,
> -	0xe3, 0x05, 0x00, 0x20, 0x41, 0x10, 0xe2, 0x00, 0xca, 0x6d, 0x03, 0x0c,
> -	0x00, 0x12, 0x34, 0x78, 0x44, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x8a, 0x02, 0x03, 0x15, 0xb1,
> +	0xe3, 0x05, 0x00, 0x20, 0x41, 0x10, 0xe2, 0x00, 0xca, 0x67, 0x03, 0x0c,
> +	0x00, 0x12, 0x34, 0x78, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0x8c
> +	0x00, 0x00, 0x00, 0xb8
>   };
>   
>   #endif // DRM_KUNIT_EDID_H_
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


