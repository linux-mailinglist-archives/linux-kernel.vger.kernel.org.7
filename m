Return-Path: <linux-kernel+bounces-773634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE62B2A2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78AA7AEB5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9702431B107;
	Mon, 18 Aug 2025 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oIJCQ8UY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o8EgLg+d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u+yiZr6y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LOLao4zZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241C231B13E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522209; cv=none; b=S9bLJmpaRgQefBhFdQoddDACdKcCyia/u8fQNTQjr6OgPxwZ4HvqVU1GJ0x1x3Yxy9FiQplIaxw6hdNZKJYRR95A2Z+BJSBdgcmVF/6EX8lBriNPEzjLAbRiMvT7S9gGid0Tvl2BmihKZrcwKvdtso4rjIwMGFHRr4qhM22eU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522209; c=relaxed/simple;
	bh=3cS1hJkWEvQhg3u/OJ+VnPRBbAhIKpCfd0WJ83Bg21I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lk5spgdScLJ6S1DVDmvy1GYpff3oo5xssYksGsDz+LmTZdZt07UHkSmWkats9oBdf0sH0fsN1Pez5D5hXjMQjvuO7bMaxRlm0gpi+v0o6lfez46NpnozfDHCtezxkr9l5n1rwEiv1QYSgxExdR/V6Dh9+ytRvBAPRMuKO8NVv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oIJCQ8UY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o8EgLg+d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u+yiZr6y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LOLao4zZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4673E1F387;
	Mon, 18 Aug 2025 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755522205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/bUJbG86JgbU2HrIojB8n3uukjzYWuC6Sx8leLNt9/k=;
	b=oIJCQ8UYReB9kJdNoqoC92YDDQ4GPuZHHPJqJRFmywscgJHcLx6imk31M5GVURJDIQod2L
	0rn4s2OFGVNIY4ZTvQvnPD+h+qqRIPBz8BJVABJOdNs8xNjo/2TkJoBgW3EEH39viObjud
	Z4ywgeh8+B2t8pdc3W4/+Px2l7xhCM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755522205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/bUJbG86JgbU2HrIojB8n3uukjzYWuC6Sx8leLNt9/k=;
	b=o8EgLg+dnNTcGj+G3DZ20LeVe5djMMHxfR/y++C+HYco2WjcDtzK8xms+TrBh4RIU7aM1G
	hA9R9eDyVVXA3UBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u+yiZr6y;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LOLao4zZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755522204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/bUJbG86JgbU2HrIojB8n3uukjzYWuC6Sx8leLNt9/k=;
	b=u+yiZr6y/8mksRn7O40ku4IX2SpoparHNld2gs1aDbudYA31Va1ykMX/eKsrsIpbaBND5G
	UBc4fYmxvJo4c5lTK8hJVZbuwEhBTrpCCJBbRvUxCTjZQ9RUDmGM56+IyXvKMyQu8QopJG
	0Y6LzhQ9ebf7ix4fiEG0cUyeXjq2oZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755522204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/bUJbG86JgbU2HrIojB8n3uukjzYWuC6Sx8leLNt9/k=;
	b=LOLao4zZ8JjuaYKzD3+wfhHBDSIJBzCajBm6ZgW1VsaXn+HcHUWqk7iJUhP+7sIWzvpVeo
	lBIQw1S7Nrqo5BCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D917713686;
	Mon, 18 Aug 2025 13:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id btRvM5sko2gpfwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 18 Aug 2025 13:03:23 +0000
Message-ID: <1f70e353-002c-40c4-878d-6b884adf2bbf@suse.de>
Date: Mon, 18 Aug 2025 15:03:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] drm/gud: Replace simple display pipe with DRM atomic
 helpers
To: Ruben Wauters <rubenru09@aol.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jani Nikula <jani.nikula@intel.com>,
 Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250816100223.5588-1-rubenru09.ref@aol.com>
 <20250816100223.5588-1-rubenru09@aol.com>
Content-Language: en-US
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
In-Reply-To: <20250816100223.5588-1-rubenru09@aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[aol.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,linutronix.de,intel.com,redhat.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[aol.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4673E1F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

Hi

Am 16.08.25 um 11:57 schrieb Ruben Wauters:
> The simple display pipe is obsolete and the atomic helpers allow for
> more control over the rendering process. As such, this patch replaces
> the old simple display pipe system with the newer atomic helpers.
>
> As the code is mainly the same, merely replaced with the new atomic
> system, there should be no change in functionality.
>
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> ---
> I have been able to test this now, having obtained the hardware, and it
> works fine, though some other unrelated issues have popped up, which I
> shall try and debug and address in other patches.

Thanks for the update. Great to hear that it works. What's that other 
problem? Maybe it's a known issue with a known workaround.

I left additional comments below.


>
> v2 changes:
> - address review comments by reorganising gud_probe()
> ---
> drivers/gpu/drm/gud/gud_connector.c | 24 +++++-----
> drivers/gpu/drm/gud/gud_drv.c | 52 +++++++++++++++++-----
> drivers/gpu/drm/gud/gud_internal.h | 13 +++---
> drivers/gpu/drm/gud/gud_pipe.c | 69 ++++++++++++++++++++---------
> 4 files changed, 108 insertions(+), 50 deletions(-)

AFAICT you should be able to un-include <drm/drm_simple_kms_helper.h> 
from the various files within the driver.


>
> diff --git a/drivers/gpu/drm/gud/gud_connector.c 
> b/drivers/gpu/drm/gud/gud_connector.c
> index 0f07d77c5d52..75f404ec08b4 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -607,13 +607,16 @@ int gud_connector_fill_properties(struct 
> drm_connector_state *connector_state,
> return gconn->num_properties;
> }
> +static const struct drm_encoder_funcs 
> gud_drm_simple_encoder_funcs_cleanup = {
> + .destroy = drm_encoder_cleanup,
> +};
> +
> static int gud_connector_create(struct gud_device *gdrm, unsigned int 
> index,
> struct gud_connector_descriptor_req *desc)
> {
> struct drm_device *drm = &gdrm->drm;
> struct gud_connector *gconn;
> struct drm_connector *connector;
> - struct drm_encoder *encoder;
> int ret, connector_type;
> u32 flags;
> @@ -681,20 +684,13 @@ static int gud_connector_create(struct 
> gud_device *gdrm, unsigned int index,
> return ret;
> }
> - /* The first connector is attached to the existing simple pipe 
> encoder */
> - if (!connector->index) {
> - encoder = &gdrm->pipe.encoder;
> - } else {
> - encoder = &gconn->encoder;
> -
> - ret = drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_NONE);
> - if (ret)
> - return ret;
> -
> - encoder->possible_crtcs = 1;
> - }
> + gdrm->encoder.possible_crtcs = drm_crtc_mask(&gdrm->crtc);
> + ret = drm_encoder_init(drm, &gdrm->encoder, 
> &gud_drm_simple_encoder_funcs_cleanup,
> + DRM_MODE_ENCODER_NONE, NULL);

The display pipeline sends pixels from plane to CRTC to a number of 
encoder/connector pairs. Hence you have to initialize the encoder at 
gconn->encoder. The encoder in gud_device should  be removed.


> + if (ret)
> + return ret;
> - return drm_connector_attach_encoder(connector, encoder);
> + return drm_connector_attach_encoder(connector, &gdrm->encoder);
> }
> int gud_get_connectors(struct gud_device *gdrm)
> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
> index 5385a2126e45..65c3a83c4037 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -16,6 +16,7 @@
> #include <drm/clients/drm_client_setup.h>
> #include <drm/drm_atomic_helper.h>
> #include <drm/drm_blend.h>
> +#include <drm/drm_crtc_helper.h>
> #include <drm/drm_damage_helper.h>
> #include <drm/drm_debugfs.h>
> #include <drm/drm_drv.h>
> @@ -289,7 +290,7 @@ static int gud_get_properties(struct gud_device *gdrm)
> * but mask out any additions on future devices.
> */
> val &= GUD_ROTATION_MASK;
> - ret = drm_plane_create_rotation_property(&gdrm->pipe.plane,
> + ret = drm_plane_create_rotation_property(&gdrm->plane,
> DRM_MODE_ROTATE_0, val);
> break;
> default:
> @@ -338,10 +339,30 @@ static int gud_stats_debugfs(struct seq_file *m, 
> void *data)
> return 0;
> }
> -static const struct drm_simple_display_pipe_funcs gud_pipe_funcs = {
> - .check = gud_pipe_check,
> - .update = gud_pipe_update,
> - DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS
> +static const struct drm_crtc_helper_funcs gud_crtc_helper_funcs = {
> + .atomic_check = drm_crtc_helper_atomic_check
> +};
> +
> +static const struct drm_crtc_funcs gud_crtc_funcs = {
> + .reset = drm_atomic_helper_crtc_reset,
> + .destroy = drm_crtc_cleanup,
> + .set_config = drm_atomic_helper_set_config,
> + .page_flip = drm_atomic_helper_page_flip,
> + .atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> + .atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> +};
> +
> +static const struct drm_plane_helper_funcs gud_plane_helper_funcs = {
> + DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> + .atomic_check = gud_plane_atomic_check,
> + .atomic_update = gud_plane_atomic_update,
> +};
> +
> +static const struct drm_plane_funcs gud_plane_funcs = {
> + .update_plane = drm_atomic_helper_update_plane,
> + .disable_plane = drm_atomic_helper_disable_plane,
> + .destroy = drm_plane_cleanup,
> + DRM_GEM_SHADOW_PLANE_FUNCS,
> };
> static const struct drm_mode_config_funcs gud_mode_config_funcs = {
> @@ -350,7 +371,7 @@ static const struct drm_mode_config_funcs 
> gud_mode_config_funcs = {
> .atomic_commit = drm_atomic_helper_commit,
> };
> -static const u64 gud_pipe_modifiers[] = {
> +static const u64 gud_plane_modifiers[] = {
> DRM_FORMAT_MOD_LINEAR,
> DRM_FORMAT_MOD_INVALID
> };
> @@ -567,12 +588,17 @@ static int gud_probe(struct usb_interface *intf, 
> const struct usb_device_id *id)
> return -ENOMEM;
> }
> - ret = drm_simple_display_pipe_init(drm, &gdrm->pipe, &gud_pipe_funcs,
> - formats, num_formats,
> - gud_pipe_modifiers, NULL);
> + ret = drm_universal_plane_init(drm, &gdrm->plane, 0,
> + &gud_plane_funcs,
> + formats, num_formats,
> + gud_plane_modifiers,
> + DRM_PLANE_TYPE_PRIMARY, NULL);
> if (ret)
> return ret;
> + drm_plane_helper_add(&gdrm->plane, &gud_plane_helper_funcs);
> + drm_plane_enable_fb_damage_clips(&gdrm->plane);
> +
> devm_kfree(dev, formats);
> devm_kfree(dev, formats_dev);
> @@ -582,7 +608,13 @@ static int gud_probe(struct usb_interface *intf, 
> const struct usb_device_id *id)
> return ret;
> }
> - drm_plane_enable_fb_damage_clips(&gdrm->pipe.plane);
> + ret = drm_crtc_init_with_planes(drm, &gdrm->crtc, &gdrm->plane, NULL,
> + &gud_crtc_funcs, NULL);
> +
> + if (ret)
> + return ret;
> +
> + drm_crtc_helper_add(&gdrm->crtc, &gud_crtc_helper_funcs);
> ret = gud_get_connectors(gdrm);
> if (ret) {
> diff --git a/drivers/gpu/drm/gud/gud_internal.h 
> b/drivers/gpu/drm/gud/gud_internal.h
> index d6fb25388722..6152a9b5da43 100644
> --- a/drivers/gpu/drm/gud/gud_internal.h
> +++ b/drivers/gpu/drm/gud/gud_internal.h
> @@ -15,7 +15,9 @@
> struct gud_device {
> struct drm_device drm;
> - struct drm_simple_display_pipe pipe;
> + struct drm_plane plane;
> + struct drm_crtc crtc;
> + struct drm_encoder encoder;

As mentioned above, the encoder field should be removed.

> struct work_struct work;
> u32 flags;
> const struct drm_format_info *xrgb8888_emulation_format;
> @@ -62,11 +64,10 @@ int gud_usb_set_u8(struct gud_device *gdrm, u8 
> request, u8 val);
> void gud_clear_damage(struct gud_device *gdrm);
> void gud_flush_work(struct work_struct *work);
> -int gud_pipe_check(struct drm_simple_display_pipe *pipe,
> - struct drm_plane_state *new_plane_state,
> - struct drm_crtc_state *new_crtc_state);
> -void gud_pipe_update(struct drm_simple_display_pipe *pipe,
> - struct drm_plane_state *old_state);
> +int gud_plane_atomic_check(struct drm_plane *plane,
> + struct drm_atomic_state *state);
> +void gud_plane_atomic_update(struct drm_plane *plane,
> + struct drm_atomic_state *atomic_state);
> int gud_connector_fill_properties(struct drm_connector_state 
> *connector_state,
> struct gud_property_req *properties);
> int gud_get_connectors(struct gud_device *gdrm);
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c 
> b/drivers/gpu/drm/gud/gud_pipe.c
> index 8d548d08f127..6a0e6234224a 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -451,14 +451,15 @@ static void gud_fb_handle_damage(struct 
> gud_device *gdrm, struct drm_framebuffer
> gud_flush_damage(gdrm, fb, src, !fb->obj[0]->import_attach, damage);
> }
> -int gud_pipe_check(struct drm_simple_display_pipe *pipe,
> - struct drm_plane_state *new_plane_state,
> - struct drm_crtc_state *new_crtc_state)
> +int gud_plane_atomic_check(struct drm_plane *plane,
> + struct drm_atomic_state *state)
> {
> - struct gud_device *gdrm = to_gud_device(pipe->crtc.dev);
> - struct drm_plane_state *old_plane_state = pipe->plane.state;
> - const struct drm_display_mode *mode = &new_crtc_state->mode;
> - struct drm_atomic_state *state = new_plane_state->state;
> + struct gud_device *gdrm = to_gud_device(plane->dev);
> + struct drm_plane_state *old_plane_state = 
> drm_atomic_get_old_plane_state(state, plane);
> + struct drm_plane_state *new_plane_state = 
> drm_atomic_get_new_plane_state(state, plane);
> + struct drm_crtc *crtc = new_plane_state->crtc;
> + struct drm_crtc_state *crtc_state;
> + const struct drm_display_mode *mode;
> struct drm_framebuffer *old_fb = old_plane_state->fb;
> struct drm_connector_state *connector_state = NULL;
> struct drm_framebuffer *fb = new_plane_state->fb;
> @@ -472,17 +473,35 @@ int gud_pipe_check(struct 
> drm_simple_display_pipe *pipe,
> if (WARN_ON_ONCE(!fb))
> return -EINVAL;
> + if (WARN_ON_ONCE(!crtc))

Please use drm_WARN_ON_ONCE() here.

> + return -EINVAL;
> +
> + crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +
> + mode = &crtc_state->mode;
> +
> + ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
> + DRM_PLANE_NO_SCALING,
> + DRM_PLANE_NO_SCALING,
> + false, false);
> +

No empty line here and before similar "if (ret)" statements.

> + if (ret)
> + return ret;
> +
> + if (!new_plane_state->visible)
> + return 0;
> +
> if (old_plane_state->rotation != new_plane_state->rotation)
> - new_crtc_state->mode_changed = true;
> + crtc_state->mode_changed = true;
> if (old_fb && old_fb->format != format)
> - new_crtc_state->mode_changed = true;
> + crtc_state->mode_changed = true;
> - if (!new_crtc_state->mode_changed && 
> !new_crtc_state->connectors_changed)
> + if (!crtc_state->mode_changed && !crtc_state->connectors_changed)
> return 0;
> /* Only one connector is supported */
> - if (hweight32(new_crtc_state->connector_mask) != 1)
> + if (hweight32(crtc_state->connector_mask) != 1)
> return -EINVAL;

In case you're wondering: this is really a problem with user-space 
programs. Most compositors (Xorg, Gnome, etc) don't support a single 
display that is mirrored to multiple outputs. It's only found in low-end 
hardware and complicated to get right; hence there's little incentive 
for user space to fix the problem.


> if (format->format == DRM_FORMAT_XRGB8888 && 
> gdrm->xrgb8888_emulation_format)
> @@ -500,7 +519,7 @@ int gud_pipe_check(struct drm_simple_display_pipe 
> *pipe,
> if (!connector_state) {
> struct drm_connector_list_iter conn_iter;
> - drm_connector_list_iter_begin(pipe->crtc.dev, &conn_iter);
> + drm_connector_list_iter_begin(plane->dev, &conn_iter);
> drm_for_each_connector_iter(connector, &conn_iter) {
> if (connector->state->crtc) {
> connector_state = connector->state;
> @@ -567,16 +586,19 @@ int gud_pipe_check(struct 
> drm_simple_display_pipe *pipe,
> return ret;
> }
> -void gud_pipe_update(struct drm_simple_display_pipe *pipe,
> - struct drm_plane_state *old_state)
> +void gud_plane_atomic_update(struct drm_plane *plane,
> + struct drm_atomic_state *atomic_state)
> {
> - struct drm_device *drm = pipe->crtc.dev;
> + struct drm_device *drm = plane->dev;
> struct gud_device *gdrm = to_gud_device(drm);
> - struct drm_plane_state *state = pipe->plane.state;
> - struct drm_shadow_plane_state *shadow_plane_state = 
> to_drm_shadow_plane_state(state);
> - struct drm_framebuffer *fb = state->fb;
> - struct drm_crtc *crtc = &pipe->crtc;
> + struct drm_plane_state *old_state = 
> drm_atomic_get_old_plane_state(atomic_state, plane);
> + struct drm_plane_state *new_state = 
> drm_atomic_get_new_plane_state(atomic_state, plane);
> + struct drm_shadow_plane_state *shadow_plane_state = 
> to_drm_shadow_plane_state(new_state);
> + struct drm_framebuffer *fb = new_state->fb;
> + struct drm_crtc *crtc = new_state->crtc;
> struct drm_rect damage;
> + struct drm_rect dst_clip;
> + struct drm_atomic_helper_damage_iter iter;
> int ret, idx;
> if (crtc->state->mode_changed || !crtc->state->enable) {
> @@ -611,8 +633,15 @@ void gud_pipe_update(struct 
> drm_simple_display_pipe *pipe,
> if (ret)
> goto ctrl_disable;
> - if (drm_atomic_helper_damage_merged(old_state, state, &damage))
> + drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
> + drm_atomic_for_each_plane_damage(&iter, &damage) {
> + dst_clip = new_state->dst;
> +
> + if (!drm_rect_intersect(&dst_clip, &damage))
> + continue;

Where did you get this code snippet? This test should not be necessary 
here and can even lead to incorrect display updates. Just call 
gud_fb_handle_damage() with the damage area.

Best regards
Thomas

> +
> gud_fb_handle_damage(gdrm, fb, &shadow_plane_state->data[0], &damage);
> + }
> drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



