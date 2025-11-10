Return-Path: <linux-kernel+bounces-893325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55486C47131
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2248188DD58
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CA127280B;
	Mon, 10 Nov 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlnM8E5b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1b+LgyB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA625D527
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783360; cv=none; b=ueS9jYmO8+fooK0GNv6Xk/OVQ3ymzy5IcbvomSHuwCsTuBeYklXGCtWELuexOjzNYGNXmG24XqjOxUAOg/crlB2L/wXTnTE5KVu4BO8gFAbmQB1ltBMgU3r0A20bpfEDMT+B9VKvOZYb7mynhSksL0deVhEd0CoO5xRo+++r7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783360; c=relaxed/simple;
	bh=0Aig3teqTXZjp1WaCYovhcmFzxBrLGcLff4uioKRAfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJxor8P74Ve9Gp0WAqCH3nNWtZVyN5v3bAtV3cTS5LDWXwBVS/YkHna0/X+kmwDNXM+ZlSPPM625dLr0VCZ4iHc93FNG7bAaeKUX61npUKKwHGVM7DpWLmZ0ul8f8uHS9a3XEKZqZxgVI9Nt32hT3bQJvhZwh31w2ODJdCooSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlnM8E5b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1b+LgyB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762783357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+1NLhv4ynxcUSugYQr6fzZ4Za57RfULtHeBZTwsduU=;
	b=SlnM8E5belhv7qFCYykgBq0ywRcV7lA8HNRlyeGCWo6cjZNOLZqlujCzpYuUR+nR8ujOYn
	ZlKbU3Sl08B0bMdlSh7MldEpy6LfuFbll1X3rrAxoAJYhRL3SDLsxWtOvZ9DnIicsSwUQo
	CTnKiUc+G5PJZzkGd3EcMEMJSejihrk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-kuj8oaa9NKWfKQrhw9w7aA-1; Mon, 10 Nov 2025 09:02:36 -0500
X-MC-Unique: kuj8oaa9NKWfKQrhw9w7aA-1
X-Mimecast-MFC-AGG-ID: kuj8oaa9NKWfKQrhw9w7aA_1762783352
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4710d174c31so25042045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762783352; x=1763388152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+1NLhv4ynxcUSugYQr6fzZ4Za57RfULtHeBZTwsduU=;
        b=G1b+LgyBhevJmlQtNy/QNeJsNMMHD9qhRFpjO++Nr9h0Aldxc2QUyQIR1jlKGxSnzK
         7BCWRatHnh0iD39u3yiRE1KT5Q6G4WLIi4tUjUFlrL2WD6dmuKZUraJO+yZ+VYMD8shr
         PvtuxMXGVgAM84f5FU99wmzWvwjsjNjz6nTXYApJ5U/cYII77CgHvKeL7+SdtckXe573
         g6JYDeNoGuOEVH+WGlIrvLBj8wj6QSIQ0AEZgxNY9TmIi7Ile80jIhgLsff3JFM7DpVT
         rfL+uZWUOYhbpbuo8TlM8wYJEhw30bM/d/aDC+az2OqhRnvCHrCdXuGr1AZti+XnTQlb
         TszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762783352; x=1763388152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+1NLhv4ynxcUSugYQr6fzZ4Za57RfULtHeBZTwsduU=;
        b=AoKNTDTFeNVYpN9a1svjLywBz55vtYWKHAJJqKzsfSD1McaH7gvn4nVJr7N2OHhMev
         PAc7sdlaSwo23G+mWKEUAXOqnQXmtx8zyBeTYIDd6vuLfHHLI+Cpkch5OMXNvNGeZ18e
         jm1XU3o0wXit8LyfSRayMae8zVO4hjb3U7Az0Pf0NY/FBZnAZHUTGWyx1nJpLFiZNUIQ
         tCK66W3ri0Ot0pUjT8nt8XPKidavUbD1Uqq7LbT3a0OuV40V28nYIL6/QIqll1DBX+Nq
         Qo15Tl5aiu9rWil7xf0Z932socSaVE8iIiale8oOufd5pgaBKJhYfpSxSEcn8Jv90uW4
         5Mtg==
X-Forwarded-Encrypted: i=1; AJvYcCXMmrb7IWS+qegaL5K/zVoQHZ8vwkYcQbMUC59mjXuL6uzj7uyd3HbiOqmfFrCxsITAqiDSCaNEdF26Zu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHYPfgaPzkJFNO10+C6tYDCoPQ643UiyOQz+pKFLOLM2mzErYB
	wG5ClAYXWQqMpZQUNsnAJsMWapvzjxYLCn7bWfsOMTsXlYGnYvEQAKGEEEVXi/tUgHkyepuSVFj
	Ip8+FtvZRjuRvziKW1Q15FXrJ8yZVfqirRT5qiEhPK8DZfbKIytX1e18jMV2/9gB0ZQ==
X-Gm-Gg: ASbGncsKT7yu2LSPTj81NBUlLJVhK7o4/OGV1+Js4tFjOmNkCSYdnM/h0XO3xl3vaNZ
	EMUkMSyBwYmA+vyO0FmfEIDAJUlsoYSuVdsk8MXh22x9EzHu7KHEWisuGhesjWgo7D3tLBYXGKw
	Xk+BfeHmPBUdCUf2JgyGxTOp+FZjvNfMJQAVSOgT/RrCGxhZ+N3n7DwGiGBR545mOkJl+e43cCc
	oC4nsgCo3TIkLJP0dpgeiTu1dUqAUEf8j1obuVVyVnPnuPwDg4+xVXoVAookg+SnxIKF0hKSAjB
	SPCWzsQR3CRytRkW+QN0xjLnOcUe+RXN0pHKaV139buR7zivjpE6UHOlifHtMUD9tY5fr5uQDJt
	YYg7PvW+HJ805ahh/LuHzNA9F8cv6HdD3a42vguI=
X-Received: by 2002:a05:600c:6c90:b0:477:3f35:66d5 with SMTP id 5b1f17b1804b1-47773271a8fmr37054825e9.26.1762783351812;
        Mon, 10 Nov 2025 06:02:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaBKIohJ95g0BQDXG+Q59OIuRNMSygwDSAKhcDi9d3T3pdiSgJxUCU+yL0tt+Xh55xDeNIlw==
X-Received: by 2002:a05:600c:6c90:b0:477:3f35:66d5 with SMTP id 5b1f17b1804b1-47773271a8fmr37054405e9.26.1762783351241;
        Mon, 10 Nov 2025 06:02:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm325813385e9.15.2025.11.10.06.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:02:30 -0800 (PST)
Message-ID: <ac63816c-b12a-4127-b975-ee80b53ee11f@redhat.com>
Date: Mon, 10 Nov 2025 15:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/client: Pass force parameter to client restore
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 simona@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, gregkh@linuxfoundation.org,
 jirislaby@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20251107142612.467817-1-tzimmermann@suse.de>
 <20251107142612.467817-2-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251107142612.467817-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/11/2025 15:19, Thomas Zimmermann wrote:
> Add force parameter to client restore and pass value through the
> layers. The only currently used value is false.
> 
> If force is true, the client should restore its display even if it
> does not hold the DRM master lock. This is be required for emergency
> output, such as sysrq.
> 
> While at it, inline drm_fb_helper_lastclose(), which is a trivial
> wrapper around drm_fb_helper_restore_fbdev_mode_unlocked().

Thanks for this work, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/clients/drm_fbdev_client.c |  6 ++++--
>   drivers/gpu/drm/drm_client_event.c         |  4 ++--
>   drivers/gpu/drm/drm_fb_helper.c            | 24 ++++++----------------
>   drivers/gpu/drm/drm_file.c                 |  2 +-
>   include/drm/drm_client.h                   |  8 +++++---
>   include/drm/drm_client_event.h             |  4 ++--
>   include/drm/drm_fb_helper.h                |  8 ++------
>   7 files changed, 22 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
> index 47e5f27eee58..28951e392482 100644
> --- a/drivers/gpu/drm/clients/drm_fbdev_client.c
> +++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
> @@ -38,9 +38,11 @@ static void drm_fbdev_client_unregister(struct drm_client_dev *client)
>   	}
>   }
>   
> -static int drm_fbdev_client_restore(struct drm_client_dev *client)
> +static int drm_fbdev_client_restore(struct drm_client_dev *client, bool force)
>   {
> -	drm_fb_helper_lastclose(client->dev);
> +	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
> +
> +	drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, force);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/drm_client_event.c b/drivers/gpu/drm/drm_client_event.c
> index d25dc5250983..7b3e362f7926 100644
> --- a/drivers/gpu/drm/drm_client_event.c
> +++ b/drivers/gpu/drm/drm_client_event.c
> @@ -102,7 +102,7 @@ void drm_client_dev_hotplug(struct drm_device *dev)
>   }
>   EXPORT_SYMBOL(drm_client_dev_hotplug);
>   
> -void drm_client_dev_restore(struct drm_device *dev)
> +void drm_client_dev_restore(struct drm_device *dev, bool force)
>   {
>   	struct drm_client_dev *client;
>   	int ret;
> @@ -115,7 +115,7 @@ void drm_client_dev_restore(struct drm_device *dev)
>   		if (!client->funcs || !client->funcs->restore)
>   			continue;
>   
> -		ret = client->funcs->restore(client);
> +		ret = client->funcs->restore(client, force);
>   		drm_dbg_kms(dev, "%s: ret=%d\n", client->name, ret);
>   		if (!ret) /* The first one to return zero gets the privilege to restore */
>   			break;
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 53e9dc0543de..1392738ce2fe 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -255,6 +255,7 @@ __drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper,
>   /**
>    * drm_fb_helper_restore_fbdev_mode_unlocked - restore fbdev configuration
>    * @fb_helper: driver-allocated fbdev helper, can be NULL
> + * @force: ignore present DRM master
>    *
>    * This helper should be called from fbdev emulation's &drm_client_funcs.restore
>    * callback. It ensures that the user isn't greeted with a black screen when the
> @@ -263,9 +264,9 @@ __drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper,
>    * Returns:
>    * 0 on success, or a negative errno code otherwise.
>    */
> -int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper)
> +int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper, bool force)
>   {
> -	return __drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, false);
> +	return __drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, force);
>   }
>   EXPORT_SYMBOL(drm_fb_helper_restore_fbdev_mode_unlocked);
>   
> @@ -1328,9 +1329,9 @@ int drm_fb_helper_set_par(struct fb_info *info)
>   	 * the KDSET IOCTL with KD_TEXT, and only after that drops the master
>   	 * status when exiting.
>   	 *
> -	 * In the past this was caught by drm_fb_helper_lastclose(), but on
> -	 * modern systems where logind always keeps a drm fd open to orchestrate
> -	 * the vt switching, this doesn't work.
> +	 * In the past this was caught by drm_fb_helper_restore_fbdev_mode_unlocked(),
> +	 * but on modern systems where logind always keeps a drm fd open to
> +	 * orchestrate the vt switching, this doesn't work.
>   	 *
>   	 * To not break the userspace ABI we have this special case here, which
>   	 * is only used for the above case. Everything else uses the normal
> @@ -1955,16 +1956,3 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper)
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_fb_helper_hotplug_event);
> -
> -/**
> - * drm_fb_helper_lastclose - DRM driver lastclose helper for fbdev emulation
> - * @dev: DRM device
> - *
> - * This function is obsolete. Call drm_fb_helper_restore_fbdev_mode_unlocked()
> - * instead.
> - */
> -void drm_fb_helper_lastclose(struct drm_device *dev)
> -{
> -	drm_fb_helper_restore_fbdev_mode_unlocked(dev->fb_helper);
> -}
> -EXPORT_SYMBOL(drm_fb_helper_lastclose);
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index eebd1a05ee97..be5e617ceb9f 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -405,7 +405,7 @@ EXPORT_SYMBOL(drm_open);
>   
>   static void drm_lastclose(struct drm_device *dev)
>   {
> -	drm_client_dev_restore(dev);
> +	drm_client_dev_restore(dev, false);
>   
>   	if (dev_is_pci(dev->dev))
>   		vga_switcheroo_process_delayed_switch();
> diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> index 5ecde0f6f591..c972a8a3385b 100644
> --- a/include/drm/drm_client.h
> +++ b/include/drm/drm_client.h
> @@ -57,12 +57,14 @@ struct drm_client_funcs {
>   	 *
>   	 * Note that the core does not guarantee exclusion against concurrent
>   	 * drm_open(). Clients need to ensure this themselves, for example by
> -	 * using drm_master_internal_acquire() and
> -	 * drm_master_internal_release().
> +	 * using drm_master_internal_acquire() and drm_master_internal_release().
> +	 *
> +	 * If the caller passes force, the client should ignore any present DRM
> +	 * master and restore the display anyway.
>   	 *
>   	 * This callback is optional.
>   	 */
> -	int (*restore)(struct drm_client_dev *client);
> +	int (*restore)(struct drm_client_dev *client, bool force);
>   
>   	/**
>   	 * @hotplug:
> diff --git a/include/drm/drm_client_event.h b/include/drm/drm_client_event.h
> index 985d6f02a4c4..79369c755bc9 100644
> --- a/include/drm/drm_client_event.h
> +++ b/include/drm/drm_client_event.h
> @@ -10,7 +10,7 @@ struct drm_device;
>   #if defined(CONFIG_DRM_CLIENT)
>   void drm_client_dev_unregister(struct drm_device *dev);
>   void drm_client_dev_hotplug(struct drm_device *dev);
> -void drm_client_dev_restore(struct drm_device *dev);
> +void drm_client_dev_restore(struct drm_device *dev, bool force);
>   void drm_client_dev_suspend(struct drm_device *dev);
>   void drm_client_dev_resume(struct drm_device *dev);
>   #else
> @@ -18,7 +18,7 @@ static inline void drm_client_dev_unregister(struct drm_device *dev)
>   { }
>   static inline void drm_client_dev_hotplug(struct drm_device *dev)
>   { }
> -static inline void drm_client_dev_restore(struct drm_device *dev)
> +static inline void drm_client_dev_restore(struct drm_device *dev, bool force)
>   { }
>   static inline void drm_client_dev_suspend(struct drm_device *dev)
>   { }
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index c1d38d54a112..63e3af8dd5ed 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -254,7 +254,8 @@ int drm_fb_helper_set_par(struct fb_info *info);
>   int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>   			    struct fb_info *info);
>   
> -int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper);
> +int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper,
> +					      bool force);
>   
>   struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper);
>   void drm_fb_helper_release_info(struct drm_fb_helper *fb_helper);
> @@ -283,7 +284,6 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
>   int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
>   int drm_fb_helper_debug_enter(struct fb_info *info);
>   int drm_fb_helper_debug_leave(struct fb_info *info);
> -void drm_fb_helper_lastclose(struct drm_device *dev);
>   #else
>   static inline void drm_fb_helper_prepare(struct drm_device *dev,
>   					 struct drm_fb_helper *helper,
> @@ -409,10 +409,6 @@ static inline int drm_fb_helper_debug_leave(struct fb_info *info)
>   {
>   	return 0;
>   }
> -
> -static inline void drm_fb_helper_lastclose(struct drm_device *dev)
> -{
> -}
>   #endif
>   
>   #endif


