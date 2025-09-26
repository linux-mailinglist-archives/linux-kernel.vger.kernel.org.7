Return-Path: <linux-kernel+bounces-833627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33816BA27BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F0B3AFA29
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A48279359;
	Fri, 26 Sep 2025 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hvPZ3DSz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NF0yFgte";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hvPZ3DSz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NF0yFgte"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43635950
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758866357; cv=none; b=LfJj/rTr7DRRyu9jxHwJaElpvP1acw9V7sOuY5cNa+l6VcL5ZyfnxDQjNT/0jUIQ2YMX350YHEpOfMNoVMffcOluL1nk7NRVGvZGON89Z1qdkI1xYkw1ERIxigbhey8v1nGnM7foMvZL/+ZxKKrRpLkqU1fi5aSrySPPgoNbiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758866357; c=relaxed/simple;
	bh=0jsBcHgW5oQn56NLA0qTVSiI7Wq+jWX5A7fxBGirz70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4BLLsqrhjZk1Em10rMMLcrdQ3FsJrAfo1c1yZuhu9lkoAW43xJCefVtVemtjdaK7cOb4WYK4YpGQo8akdkjRvQqHkMjQeNRtk1w926C1eIs2xzE7QqA0PZfh0cK313Vx0Lf2/N1kaOrCS2YZFFRGoJM3Kl5Av7KlVwn/bUo3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hvPZ3DSz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NF0yFgte; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hvPZ3DSz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NF0yFgte; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 923B923DA5;
	Fri, 26 Sep 2025 05:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758866352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5SOb0GpHFMXJPASeD7+yLW4LHfKmtU8UNjQsITaUnOU=;
	b=hvPZ3DSzpDKo5eaMucmz7qi67XH7qawFF7AGrtfHJOVexFnKDQpvDEgFncrz/Cb/icrnog
	BsYLX7ga+prNlrOO9WulYZhSoCKBlkFQYscp/XjMLB6RLD+hfBtzk1k7RJ3Y2U+flj65D7
	FrNW8zD+I/pne9vOZsHZTvsiEivvzWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758866352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5SOb0GpHFMXJPASeD7+yLW4LHfKmtU8UNjQsITaUnOU=;
	b=NF0yFgte6LfubLzZ/gs7slAIfNot4GqmMDE1jbe+gMP3MYD7Kd41uLI7i8Bhs4aO6LBS5s
	NZrSo0tLsSp05XAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758866352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5SOb0GpHFMXJPASeD7+yLW4LHfKmtU8UNjQsITaUnOU=;
	b=hvPZ3DSzpDKo5eaMucmz7qi67XH7qawFF7AGrtfHJOVexFnKDQpvDEgFncrz/Cb/icrnog
	BsYLX7ga+prNlrOO9WulYZhSoCKBlkFQYscp/XjMLB6RLD+hfBtzk1k7RJ3Y2U+flj65D7
	FrNW8zD+I/pne9vOZsHZTvsiEivvzWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758866352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5SOb0GpHFMXJPASeD7+yLW4LHfKmtU8UNjQsITaUnOU=;
	b=NF0yFgte6LfubLzZ/gs7slAIfNot4GqmMDE1jbe+gMP3MYD7Kd41uLI7i8Bhs4aO6LBS5s
	NZrSo0tLsSp05XAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60B5D1373E;
	Fri, 26 Sep 2025 05:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Sb9FbAr1mggSgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 26 Sep 2025 05:59:12 +0000
Message-ID: <104ebf51-a5e4-4df3-aaf7-cfd9da17562b@suse.de>
Date: Fri, 26 Sep 2025 07:59:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself as maintainer for GUD
To: Ruben Wauters <rubenru09@aol.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250924211557.6687-2-rubenru09.ref@aol.com>
 <20250924211557.6687-2-rubenru09@aol.com>
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
In-Reply-To: <20250924211557.6687-2-rubenru09@aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[aol.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,gitlab.freedesktop.org:url]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30



Am 24.09.25 um 23:10 schrieb Ruben Wauters:
> Since GUD has been without a maintainer for some time, and I have been
> working on it, This patch adds myself as maintainer for the GUD driver.
>
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>


> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 16f6013580e9..3fbeb41f8792 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7744,7 +7744,8 @@ F:	Documentation/devicetree/bindings/display/panel/panel-edp.yaml
>   F:	drivers/gpu/drm/panel/panel-edp.c
>   
>   DRM DRIVER FOR GENERIC USB DISPLAY
> -S:	Orphan
> +M:	Ruben Wauters <rubenru09@aol.com>
> +S:	Maintained
>   W:	https://github.com/notro/gud/wiki
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/gud/

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



