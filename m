Return-Path: <linux-kernel+bounces-712653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21622AF0CB4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC704E0C64
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B822A80D;
	Wed,  2 Jul 2025 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V57CvC3Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JfYZA4zf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V57CvC3Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JfYZA4zf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1F1D514E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441805; cv=none; b=DnnpPmv4MTKkTBHmyTsqD8QUn7Z80evhUPDDEdEpR2NWQk/ztM5PzsMIGengpBHVEQekwg72mFbjUxRXd9QFG5+4PVm9bqID+g9hTi0wYJXs6ioGXfB/exhhn+wUh8WxoyjGf1o3NppJEQcqBzyjTUB4UHRMLBs4kNYXwEFVn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441805; c=relaxed/simple;
	bh=QlJNFD14+/t76b26IIImT69hMg3hdPOCkvkWXn9fLsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wu3fBYwaDb+UsMd82lwv87EvrvPRkfprzj71yfP5u0A9+8mofITfINTxTmYVr5vaihNf34LlbSWbg0rcaukzQTXkHgr6yC0dWcU+iP/NI7y9IVq0cyPeMLwk5tkYB/czV8657AiquCkPk94UaoA3NfM5HwnQSeznoAuUpsI092o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V57CvC3Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JfYZA4zf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V57CvC3Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JfYZA4zf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1ABED2117C;
	Wed,  2 Jul 2025 07:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751441801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RdG1nqaPq8l4Djf1EYlJutK/D8t6Oqi7agbVuceryAk=;
	b=V57CvC3ZPGV+UIVihiYHhBw3xn/s1by2z71ppreMUcrqLSQFM6aXBP9yTWXWvF1KkBpgeL
	AVCqMeYXpAURwC1KNwtf3LM3rm1RAKtll2eklXUzV4Phw0Wk3FvPyJAU/fuagEcrKDIbFg
	UrG7nSuyY08tybZeziX0xrk4nhhkCS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751441801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RdG1nqaPq8l4Djf1EYlJutK/D8t6Oqi7agbVuceryAk=;
	b=JfYZA4zfKIowvCbPUhfREXMviQoLwks7FR7+Qlt5URyf9MpEHvhuGXL1BZryKGe1kxhPvF
	/sHdCf0/w1Po08CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751441801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RdG1nqaPq8l4Djf1EYlJutK/D8t6Oqi7agbVuceryAk=;
	b=V57CvC3ZPGV+UIVihiYHhBw3xn/s1by2z71ppreMUcrqLSQFM6aXBP9yTWXWvF1KkBpgeL
	AVCqMeYXpAURwC1KNwtf3LM3rm1RAKtll2eklXUzV4Phw0Wk3FvPyJAU/fuagEcrKDIbFg
	UrG7nSuyY08tybZeziX0xrk4nhhkCS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751441801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RdG1nqaPq8l4Djf1EYlJutK/D8t6Oqi7agbVuceryAk=;
	b=JfYZA4zfKIowvCbPUhfREXMviQoLwks7FR7+Qlt5URyf9MpEHvhuGXL1BZryKGe1kxhPvF
	/sHdCf0/w1Po08CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6A0D13A24;
	Wed,  2 Jul 2025 07:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0LAyMojhZGgCPgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 02 Jul 2025 07:36:40 +0000
Message-ID: <42d0f819-87ae-44d0-a9c5-ae4fa91b1227@suse.de>
Date: Wed, 2 Jul 2025 09:36:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/vgem/vgem_drv convert to use faux_device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Lyude Paul <lyude@redhat.com>
References: <2025070114-iron-shiny-b92e@gregkh>
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
In-Reply-To: <2025070114-iron-shiny-b92e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,redhat.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,intel.com:email,linuxfoundation.org:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi

Am 01.07.25 um 12:51 schrieb Greg Kroah-Hartman:
> The vgem driver does not need to create a platform device, as there is
> no real platform resources associated it,  it only did so because it was
> simple to do that in order to get a device to use for resource
> management of drm resources.  Change the driver to use the faux device
> instead as this is NOT a real platform device.
>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v5: - rebased against 6.16-rc4 and resent as it seems to have been lost

Not lost, but thanks for the update. This patch and the one for vkms 
depend on "drm/gem-shmem: Do not map s/g table by default". [1] It'll 
land soon and the faux_device updates soon after.

Best regards
Thomas

[1] https://patchwork.freedesktop.org/series/150968/

> v4: - api tweaked due to parent pointer added to faux_device create
>        function.
> v3: - new patch in the series.  For an example of the api working, does
>        not have to be merged at this time, but I can take it if the
>        maintainers give an ack.
>
>   drivers/gpu/drm/vgem/vgem_drv.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index 2752ab4f1c97..260c64733972 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -32,7 +32,7 @@
>   
>   #include <linux/dma-buf.h>
>   #include <linux/module.h>
> -#include <linux/platform_device.h>
> +#include <linux/device/faux.h>
>   #include <linux/shmem_fs.h>
>   #include <linux/vmalloc.h>
>   
> @@ -52,7 +52,7 @@
>   
>   static struct vgem_device {
>   	struct drm_device drm;
> -	struct platform_device *platform;
> +	struct faux_device *faux_dev;
>   } *vgem_device;
>   
>   static int vgem_open(struct drm_device *dev, struct drm_file *file)
> @@ -127,27 +127,27 @@ static const struct drm_driver vgem_driver = {
>   static int __init vgem_init(void)
>   {
>   	int ret;
> -	struct platform_device *pdev;
> +	struct faux_device *fdev;
>   
> -	pdev = platform_device_register_simple("vgem", -1, NULL, 0);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> +	fdev = faux_device_create("vgem", NULL, NULL);
> +	if (!fdev)
> +		return -ENODEV;
>   
> -	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
> +	if (!devres_open_group(&fdev->dev, NULL, GFP_KERNEL)) {
>   		ret = -ENOMEM;
>   		goto out_unregister;
>   	}
>   
> -	dma_coerce_mask_and_coherent(&pdev->dev,
> +	dma_coerce_mask_and_coherent(&fdev->dev,
>   				     DMA_BIT_MASK(64));
>   
> -	vgem_device = devm_drm_dev_alloc(&pdev->dev, &vgem_driver,
> +	vgem_device = devm_drm_dev_alloc(&fdev->dev, &vgem_driver,
>   					 struct vgem_device, drm);
>   	if (IS_ERR(vgem_device)) {
>   		ret = PTR_ERR(vgem_device);
>   		goto out_devres;
>   	}
> -	vgem_device->platform = pdev;
> +	vgem_device->faux_dev = fdev;
>   
>   	/* Final step: expose the device/driver to userspace */
>   	ret = drm_dev_register(&vgem_device->drm, 0);
> @@ -157,19 +157,19 @@ static int __init vgem_init(void)
>   	return 0;
>   
>   out_devres:
> -	devres_release_group(&pdev->dev, NULL);
> +	devres_release_group(&fdev->dev, NULL);
>   out_unregister:
> -	platform_device_unregister(pdev);
> +	faux_device_destroy(fdev);
>   	return ret;
>   }
>   
>   static void __exit vgem_exit(void)
>   {
> -	struct platform_device *pdev = vgem_device->platform;
> +	struct faux_device *fdev = vgem_device->faux_dev;
>   
>   	drm_dev_unregister(&vgem_device->drm);
> -	devres_release_group(&pdev->dev, NULL);
> -	platform_device_unregister(pdev);
> +	devres_release_group(&fdev->dev, NULL);
> +	faux_device_destroy(fdev);
>   }
>   
>   module_init(vgem_init);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


