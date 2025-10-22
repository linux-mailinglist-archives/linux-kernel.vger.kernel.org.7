Return-Path: <linux-kernel+bounces-865073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D6BFC237
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFB1622A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45D26ED28;
	Wed, 22 Oct 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZF6RMT/b"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3B26ED55
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139154; cv=none; b=Y5LpyTk0sQB7WE+L0W55ltK5zZIS/xNMMR5kfnzst0n7iYcS+4t1VupFZJYjM25Hc8dvySjgSQYaux6R5aMabk77r/LdtQjbGJDULJS2iTyamQSckYQnFG5PxhpwO1S+i3zSSIRWpW69MiTBUVFlfi1RD0KhXpZLAA58DHDj4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139154; c=relaxed/simple;
	bh=T/wwnudikjJfd0WN5sp4fJr1hbP7yzlQ2sE97iqYGoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J3TyROrHUiwSjr3wTdVaVR9zCJkSvVRD2u6bqy5bHHLmi/N349LCCFD0jJ70JDfMeYhUY3kJAhVj9yRCO2NbTGBxa4O8mzQTUyLGXAL16riUHUXl/Qkz25m/I2QPFncFWtDThozAbRKN5RoPkaKkn1BPcC5mPLtzEkw1fNpXC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZF6RMT/b; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MDIdRk1421518;
	Wed, 22 Oct 2025 08:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761139119;
	bh=Ydsu4zXx6nfJv25fwi+Bi7oHLbaay9yVkBdRqmrZmF8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZF6RMT/bADxoYcyC89BYKqPkVKCFBPYn+T0SQDYrugd2U4qnDo97W6g8Y/PKW/c3x
	 7Q3wx2chYW0j88Duvpac1hsMp73PvWj1PkD+Fcq4KncfG7mpEdmlmlulhRaC0FBKfe
	 PHt6VkKGjKCLCVA+Dq2r07K2jZXPV0j8Sk7q4aBk=
Received: from DLEE210.ent.ti.com (dlee210.ent.ti.com [157.170.170.112])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MDIcDp1622638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 08:18:39 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 08:18:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 08:18:38 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.233.62])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MDIZlg1236923;
	Wed, 22 Oct 2025 08:18:35 -0500
Message-ID: <58893f84-c161-4bf9-ac70-c37ff1607a03@ti.com>
Date: Wed, 22 Oct 2025 18:48:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/tidss: Set vblank (event) time at
 crtc_atomic_enable
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha
	<jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pekka Paalanen <pekka.paalanen@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>
References: <20250905-tidss-fix-timestamp-v1-0-c2aedf31e2c9@ideasonboard.com>
 <20250905-tidss-fix-timestamp-v1-2-c2aedf31e2c9@ideasonboard.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20250905-tidss-fix-timestamp-v1-2-c2aedf31e2c9@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Tomi,

Thanks for the patch.

On 05/09/25 19:28, Tomi Valkeinen wrote:
> It was reported that Weston stops at an assert, which checks that the
> page flip event timestamp is the same or newer than the previous
> timestamp:
> 
> weston_output_finish_frame: Assertion `timespec_sub_to_nsec(stamp, &output->frame_time) >= 0' failed.
> 

As I understand, this patch fixes above assertion error related to bad 
time-stamping. I believe it is fixing this issue [0] and probably this 
[1] ?. So I think it should be better to use a Fixes tag.

> With manual tests, I can see that when I enable the CRTC, I get a page
> flip event with a timestamp of 0. Tracking this down led to
> drm_reset_vblank_timestamp() which does "t_vblank = 0" if
> "high-precision query" is not available.
> 
> TI DSS does not have any hardware timestamping, and thus the default
> ktime_get() is used in the DRM framework to get the vblank timestamp,
> and ktime_get() is not "high precision" here.
> 
> It is not quite clear why the framework behaves this way, but I assume
> the idea is that drm_crtc_vblank_on(), which calls
> drm_reset_vblank_timestamp(), can be called at any time, and thus
> ktime_get() wouldn't give a good timestamp. And, the idea is that the
> driver would wait until next vblank after the CRTC enable, and then we
> could get a good timestamp. This is hinted in the comment: "reinitialize
> delayed at next vblank interrupt and assign 0 for now".
> 
> I think that makes sense. However, when we enable the CRTC in TI DSS,
> i.e. we write the enable bit to the hardware, that's the exact moment
> when the "vblank cycle" starts. It is the zero point in the cycle, and
> thus ktime_get() would give a good timestamp.
> 
> I am not sure if this is applicable to other hardware, and if so, how
> should it be solved in the framework. So, let's fix this in the tidss
> driver at least for now.
> 
> This patch updates the vblank->time manually to ktime_get() just before
> sending the vblank event, and we enable the crtc just before calling
> ktime_get(). To get even more exact timing, the dispc_vp_enable() is
> moved inside the event_lock spinlock.
> 
> With this, we get a proper timestamp for the page flip event from
> enabling the CRTC, and Weston is happy.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

With the Fixes tag applied,
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

[0]: 
https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1553964/processor-sdk-am62x-weston-fails-to-wake-from-idle-time-sleep-restarts-after-sigterm
[1]: 
https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1416342/am625-am625-doesn-t-wake-up-from-standy-when-idle-time-is-configured-in-weston-ini

Regards
Devarsh


> ---
>   drivers/gpu/drm/tidss/tidss_crtc.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
> index 1b767af8e1f6..6898f12bb364 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -244,11 +244,16 @@ static void tidss_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	dispc_vp_prepare(tidss->dispc, tcrtc->hw_videoport, crtc->state);
>   
> -	dispc_vp_enable(tidss->dispc, tcrtc->hw_videoport);
> -
>   	spin_lock_irqsave(&ddev->event_lock, flags);
>   
> +	dispc_vp_enable(tidss->dispc, tcrtc->hw_videoport);
> +
>   	if (crtc->state->event) {
> +		unsigned int pipe = drm_crtc_index(crtc);
> +		struct drm_vblank_crtc *vblank = &ddev->vblank[pipe];
> +
> +		vblank->time = ktime_get();
> +
>   		drm_crtc_send_vblank_event(crtc, crtc->state->event);
>   		crtc->state->event = NULL;
>   	}
> 


