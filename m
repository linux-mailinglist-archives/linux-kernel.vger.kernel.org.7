Return-Path: <linux-kernel+bounces-886097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEF6C34B54
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E6A19213A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD92F363A;
	Wed,  5 Nov 2025 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="glrENEia"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720621D3F2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333702; cv=none; b=eP6jcv5O8EkMy3TXi+Bi/7GsCBLoE6QUPvBpDPJJhsJlb0g3d/92g2xpibkf4vxjVWTWA0V5OH2C82gnJXuB4bxSbGaI6rqhiXbXk50avgONGf4uk2P9ysGaF9JyRZ0macN5iscb6msoV82zkgXE+8/FvJrn+7zHP0pGLjqMME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333702; c=relaxed/simple;
	bh=UPpt5D+T8aS8D17SDIspUvBP99f7bpTMGd6mYcDH9qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSSP1Y6ylzVKTn0PdNK+BeI+wHxoGxmLYIhlBDhmhr7WgC4ypOupFCtybrmhY9bZN/yZQneBiutUNeLQxgMWrz44n5Hr9n07EKlInlecmWiCHFqKmDOMFCl6n+/x7p2dxkAv8VCUrsASqqw7K6/rQQ/cd6j9/hPjdbu6qlif1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=glrENEia; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=8x8hr0Snx4ROvN9D0th3HkayD2fcX/9tr04MOrHRCz0=;
	b=glrENEiaVSupa/2NIGPZyZ092RQKMKiRQKsj7mTTU2Bt3MxeImcUJSYzRc6VwQ
	G8Uods4H10G+AOOOsu6u7WAkwB/IoUvzikZza5ku02rKEodzd41qsfNDsoMoHJsb
	XI5FL82fLptk2u2qExO4hOWFm3eb1JmBR753/7FBUBTIk=
Received: from [10.42.17.251] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAHFcnTEwtpGde0BQ--.107S2;
	Wed, 05 Nov 2025 17:07:33 +0800 (CST)
Message-ID: <e82274a2-9e60-4344-9d54-78232f42b05d@163.com>
Date: Wed, 5 Nov 2025 17:07:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/udl: Increase get urb timeout for modeset
To: Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>
Cc: Sean Paul <sean@poorly.run>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20251105083037.237925-1-oushixiong1025@163.com>
 <38110178-0f27-44ba-9925-5bbe74a1bf9b@suse.de>
Content-Language: en-US
From: oushixiong <oushixiong1025@163.com>
In-Reply-To: <38110178-0f27-44ba-9925-5bbe74a1bf9b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHFcnTEwtpGde0BQ--.107S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WryrJw4DWryxZF4kZr45GFg_yoW7GF48pF
	4DJ3yjyrWUAF4UK3Wj9F4kAF4fJa13Ka92krW8GasI93Wqkr1DJa48CryYgFyDAry7CF1a
	qrs2qFZ09F4Ykw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Un0edUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXA78D2kLChsbMAACs7

If the wait times for all operations increase, it would likely cause 
significant blocking in the display process.
Should we make a distinction between the two, or base it on what you 
said about increasing  the regular GET_URB_TIMEOUT for all operations ?

Best regards
Shixiong

在 2025/11/5 16:57, Thomas Zimmermann 写道:
> Hi
>
> Am 05.11.25 um 09:30 schrieb oushixiong1025@163.com:
>> From: Shixiong Ou <oushixiong@kylinos.cn>
>>
>> [WHY]
>> There is a situation where udl_handle_damage() was running successfully
>> but the screen was black. it was because 
>> udl_crtc_helper_atomic_enable() failed,
>> and there were no error messages.
>>
>> [HOW]
>> The priority for mode settings needs to be higher than damage handle, 
>> requiring
>> a higher success rate than ordinary operations.
>> Increase get urb timeout for modeset.
>>
>> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
>> ---
>>   drivers/gpu/drm/udl/udl_drv.h      |  5 ++++-
>>   drivers/gpu/drm/udl/udl_main.c     |  5 ++---
>>   drivers/gpu/drm/udl/udl_modeset.c  | 11 +++++++----
>>   drivers/gpu/drm/udl/udl_transfer.c |  2 +-
>>   4 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/udl/udl_drv.h 
>> b/drivers/gpu/drm/udl/udl_drv.h
>> index 145bb95ccc48..38b3bdf1ae4a 100644
>> --- a/drivers/gpu/drm/udl/udl_drv.h
>> +++ b/drivers/gpu/drm/udl/udl_drv.h
>> @@ -31,6 +31,9 @@ struct drm_mode_create_dumb;
>>   #define DRIVER_MINOR        0
>>   #define DRIVER_PATCHLEVEL    1
>>   +#define GET_URB_TIMEOUT    HZ
>> +#define MODESET_GET_URB_TIMEOUT    (HZ*2)
>> +
>
> Just increase the regular GET_URB_TIMEOUT for all operations.
>
> Best regards
> Thomas
>
>>   struct udl_device;
>>     struct urb_node {
>> @@ -72,7 +75,7 @@ static inline struct usb_device 
>> *udl_to_usb_device(struct udl_device *udl)
>>   int udl_modeset_init(struct udl_device *udl);
>>   struct drm_connector *udl_connector_init(struct drm_device *dev);
>>   -struct urb *udl_get_urb(struct udl_device *udl);
>> +struct urb *udl_get_urb(struct udl_device *udl, long timeout);
>>     int udl_submit_urb(struct udl_device *udl, struct urb *urb, 
>> size_t len);
>>   void udl_sync_pending_urbs(struct udl_device *udl);
>> diff --git a/drivers/gpu/drm/udl/udl_main.c 
>> b/drivers/gpu/drm/udl/udl_main.c
>> index bc58991a6f14..891996f0f74b 100644
>> --- a/drivers/gpu/drm/udl/udl_main.c
>> +++ b/drivers/gpu/drm/udl/udl_main.c
>> @@ -285,13 +285,12 @@ static struct urb *udl_get_urb_locked(struct 
>> udl_device *udl, long timeout)
>>       return unode->urb;
>>   }
>>   -#define GET_URB_TIMEOUT    HZ
>> -struct urb *udl_get_urb(struct udl_device *udl)
>> +struct urb *udl_get_urb(struct udl_device *udl, long timeout)
>>   {
>>       struct urb *urb;
>>         spin_lock_irq(&udl->urbs.lock);
>> -    urb = udl_get_urb_locked(udl, GET_URB_TIMEOUT);
>> +    urb = udl_get_urb_locked(udl, timeout);
>>       spin_unlock_irq(&udl->urbs.lock);
>>       return urb;
>>   }
>> diff --git a/drivers/gpu/drm/udl/udl_modeset.c 
>> b/drivers/gpu/drm/udl/udl_modeset.c
>> index 231e829bd709..6adca5e3e471 100644
>> --- a/drivers/gpu/drm/udl/udl_modeset.c
>> +++ b/drivers/gpu/drm/udl/udl_modeset.c
>> @@ -21,6 +21,7 @@
>>   #include <drm/drm_gem_framebuffer_helper.h>
>>   #include <drm/drm_gem_shmem_helper.h>
>>   #include <drm/drm_modeset_helper_vtables.h>
>> +#include <drm/drm_print.h>
>>   #include <drm/drm_probe_helper.h>
>>   #include <drm/drm_vblank.h>
>>   @@ -217,7 +218,7 @@ static int udl_handle_damage(struct 
>> drm_framebuffer *fb,
>>           return ret;
>>       log_bpp = ret;
>>   -    urb = udl_get_urb(udl);
>> +    urb = udl_get_urb(udl, GET_URB_TIMEOUT);
>>       if (!urb)
>>           return -ENOMEM;
>>       cmd = urb->transfer_buffer;
>> @@ -341,9 +342,11 @@ static void udl_crtc_helper_atomic_enable(struct 
>> drm_crtc *crtc, struct drm_atom
>>       if (!drm_dev_enter(dev, &idx))
>>           return;
>>   -    urb = udl_get_urb(udl);
>> -    if (!urb)
>> +    urb = udl_get_urb(udl, MODESET_GET_URB_TIMEOUT);
>> +    if (!urb) {
>> +        DRM_ERROR("Udl get urb failed when enabling crtc");
>>           goto out;
>> +    }
>>         buf = (char *)urb->transfer_buffer;
>>       buf = udl_vidreg_lock(buf);
>> @@ -374,7 +377,7 @@ static void udl_crtc_helper_atomic_disable(struct 
>> drm_crtc *crtc, struct drm_ato
>>       if (!drm_dev_enter(dev, &idx))
>>           return;
>>   -    urb = udl_get_urb(udl);
>> +    urb = udl_get_urb(udl, MODESET_GET_URB_TIMEOUT);
>>       if (!urb)
>>           goto out;
>>   diff --git a/drivers/gpu/drm/udl/udl_transfer.c 
>> b/drivers/gpu/drm/udl/udl_transfer.c
>> index 7d670b3a5293..858b47522d78 100644
>> --- a/drivers/gpu/drm/udl/udl_transfer.c
>> +++ b/drivers/gpu/drm/udl/udl_transfer.c
>> @@ -202,7 +202,7 @@ int udl_render_hline(struct udl_device *udl, int 
>> log_bpp, struct urb **urb_ptr,
>>               int ret = udl_submit_urb(udl, urb, len);
>>               if (ret)
>>                   return ret;
>> -            urb = udl_get_urb(udl);
>> +            urb = udl_get_urb(udl, GET_URB_TIMEOUT);
>>               if (!urb)
>>                   return -EAGAIN;
>>               *urb_ptr = urb;
>


