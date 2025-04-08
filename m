Return-Path: <linux-kernel+bounces-593248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1EAA7F726
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 09:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65ECE3B68DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 07:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5B4262802;
	Tue,  8 Apr 2025 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i3pOW+UA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iTAJqycX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i3pOW+UA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iTAJqycX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39325F987
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098977; cv=none; b=dYXxFZtD8soktL47r97Q6pr5+HiTncQgHHP+7TanVnDxjU1cav/nXbJB8sDCqTBJwyEyYGpfTITVQe2AIo1dMjFxgMUvRNFO42zNQTs2HyODKvaowOT4g2h4dYRsA6DsCWgjSJ58Yt6ootbg49LMinhbRSj5sGHfdKZAtCw0FaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098977; c=relaxed/simple;
	bh=RMoKcTxk8eYUoYsVduEpTMY19PBdshWyUZnjQDLGKm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRHerqoAgGK4peJY/00PZqLfOG/dzxI8pFvDfA9yOudadtHjpni2MdaGWjMsglrXqwVLqjfoujYhr2gOILSlijaB/KRVRZGmXi3So5LRZhMHwOiFs59zJYgOs+VMs3hDsg0ECyz3wVZaVC5T95aQeLoRBG6JqRiPf56bgrCls5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i3pOW+UA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iTAJqycX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i3pOW+UA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iTAJqycX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C7771F457;
	Tue,  8 Apr 2025 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744098967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0lkhxYJUuqfCDX57IYN493q9tMuE5ous2NwIddIpcEo=;
	b=i3pOW+UA4q810bZjC9iWLpSOC2HDqeOuXFArmJQqBJpcOG+J0QaCbJPEdr3xoRn4pq3RNe
	URHmuUULw11NpTQeoON4jPE6aaD69/G9ml4O5uzF/J7II4mk67IvxRpNC34SXo0vuYcKTv
	402gu9yTZPmQ7OL8jSdnMi2/lHXhOO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744098967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0lkhxYJUuqfCDX57IYN493q9tMuE5ous2NwIddIpcEo=;
	b=iTAJqycXAXiSgKF9FgRDUDJa4CySIQXTGuTFM8wu+VkrA9u2eMYOggEaI8SPd2S+UjjmZj
	pBaMcjq8hJkxGPBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744098967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0lkhxYJUuqfCDX57IYN493q9tMuE5ous2NwIddIpcEo=;
	b=i3pOW+UA4q810bZjC9iWLpSOC2HDqeOuXFArmJQqBJpcOG+J0QaCbJPEdr3xoRn4pq3RNe
	URHmuUULw11NpTQeoON4jPE6aaD69/G9ml4O5uzF/J7II4mk67IvxRpNC34SXo0vuYcKTv
	402gu9yTZPmQ7OL8jSdnMi2/lHXhOO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744098967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0lkhxYJUuqfCDX57IYN493q9tMuE5ous2NwIddIpcEo=;
	b=iTAJqycXAXiSgKF9FgRDUDJa4CySIQXTGuTFM8wu+VkrA9u2eMYOggEaI8SPd2S+UjjmZj
	pBaMcjq8hJkxGPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CE0313A1E;
	Tue,  8 Apr 2025 07:56:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZR5SFZfW9Gd9RgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 08 Apr 2025 07:56:07 +0000
Message-ID: <34f3cdf6-ca11-4eea-aecb-6d7bc5e82a1b@suse.de>
Date: Tue, 8 Apr 2025 09:56:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/tests: Fix drm_display_mode memory leaks
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Philipp Stanner <phasta@mailbox.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250408-drm-kunit-drm-display-mode-memleak-v1-0-996305a2e75a@kernel.org>
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
In-Reply-To: <20250408-drm-kunit-drm-display-mode-memleak-v1-0-996305a2e75a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 



Am 08.04.25 um 09:34 schrieb Maxime Ripard:
> Hi,
>
> Here's a series that fixes some memory leaks in our kunit tests that
> eventually show up in kmemleak.
>
> Let me know what you think,
> Maxime
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

On the series:

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> Maxime Ripard (7):
>        drm/tests: helpers: Create kunit helper to destroy a drm_display_mode
>        drm/tests: modeset: Fix drm_display_mode memory leak
>        drm/tests: modeset: Fix drm_display_mode memory leak
>        drm/tests: cmdline: Fix drm_display_mode memory leak
>        drm/tests: modes: Fix drm_display_mode memory leak
>        drm/tests: modes: Fix drm_display_mode memory leak
>        drm/tests: probe-helper: Fix drm_display_mode memory leak
>
>   drivers/gpu/drm/tests/drm_client_modeset_test.c |  9 ++++++++-
>   drivers/gpu/drm/tests/drm_cmdline_parser_test.c | 10 +++++++++-
>   drivers/gpu/drm/tests/drm_kunit_helpers.c       | 23 ++++++++++++++++++++++
>   drivers/gpu/drm/tests/drm_modes_test.c          | 26 +++++++++++++++++++++++++
>   drivers/gpu/drm/tests/drm_probe_helper_test.c   |  8 +++++++-
>   include/drm/drm_kunit_helpers.h                 |  3 +++
>   6 files changed, 76 insertions(+), 3 deletions(-)
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250408-drm-kunit-drm-display-mode-memleak-49d05334c16e
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


