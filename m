Return-Path: <linux-kernel+bounces-897203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC60C52413
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FC91892B90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6D931C567;
	Wed, 12 Nov 2025 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DukIzBAk"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D33246EB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950542; cv=none; b=qkXYSkMB3/3q8elJQ9YZ999+igrR79vA2Z+rkCnFmHLBUFH3vIWiBux0woj0X7328jCuf2mZcO781WVwYF85IMDczpoyfcgsctoShntdgbrwMQk1ho3JHOjiNRsPgc3Jhjgbl1OklTOqyDfTHutHiynKTulh9iaGWYaPrn2TY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950542; c=relaxed/simple;
	bh=4RlZERf+TmhUSqGBvRYpkFB9gjMHOCHsDV35eP+khYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmZvPFePMM3XW+EiETwHnZKSGUjHsOm/QuHMQAy8FXF2tVtB9yJjlGnlxhA9xzFQeuOa8tzI0fEssso6DsU2ldAol8lkKXU3Oq+fmhGEAENs6dDDsKD3z7N1nNmMX4wAUp4Ys6A48Qi+/rOFS9jpDk6O8wfQoUGvaylHESlI2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DukIzBAk; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z/oFAOOmMQ0/xmq4cK9tIn6jRgDAk04qzI7JFjovQ8Y=; b=DukIzBAkAnixVqORGlyaGIFYbr
	9LfCkYJjWBa0fqrwQlD10XNHtrgGUhDSLfFm2qbshu+LGjeA/Qba7Feevaeg7BiYuLnonba4ze239
	BEtNCNpv05WkadkaFVaheazB/h1jLyLCyfboNx7Ssvf+AMmRZwACOhYlyYL1TD66Qxz9gq9FkJayj
	eDnvxMYNCUgxQ+Dc9KKxF4PD+VFrWy1Soi4NvG2Nu5fT9FZEo8uZIKeklUTPkh8fftaOYYcpBvurx
	px2RiTrbk9xMv70d2r1G9Hoq3TQj/VZbyv9w8mU2papyZQuWb5Dp69fnf+Uil9+KRp1umohXASLbZ
	mxyIRUUQ==;
Received: from gwsc.sc.usp.br ([143.107.225.16] helo=[172.24.35.236])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vJ9xk-005YHq-29; Wed, 12 Nov 2025 13:28:36 +0100
Message-ID: <7d1df5ed-7119-4e59-b1e0-e54aa572282b@igalia.com>
Date: Wed, 12 Nov 2025 09:28:30 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vc4: Replace lock/unlock pattern to use guard
To: Erick Karanja <karanja99erick@gmail.com>, mripard@kernel.org,
 dave.stevenson@raspberrypi.com
Cc: kernel-list@raspberrypi.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251112080220.223318-1-karanja99erick@gmail.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
In-Reply-To: <20251112080220.223318-1-karanja99erick@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Erick,

On 12/11/25 05:02, Erick Karanja wrote:
> Replace manual lock/unlock patterns with guard.
> This simplifies the code.
> 
> Generated-by: Coccinelle SmPL
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>   drivers/gpu/drm/vc4/vc4_v3d.c | 45 ++++++++++++++---------------------
>   1 file changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> index bb09df5000bd..8271a6610d6e 100644
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> @@ -130,17 +130,15 @@ vc4_v3d_pm_get(struct vc4_dev *vc4)
>   	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>   		return -ENODEV;
>   
> -	mutex_lock(&vc4->power_lock);
> +	guard(mutex)(&vc4->power_lock);
>   	if (vc4->power_refcount++ == 0) {
>   		int ret = pm_runtime_get_sync(&vc4->v3d->pdev->dev);
>   
>   		if (ret < 0) {
>   			vc4->power_refcount--;
> -			mutex_unlock(&vc4->power_lock);
>   			return ret;
>   		}
>   	}
> -	mutex_unlock(&vc4->power_lock);
>   
>   	return 0;
>   }
> @@ -151,12 +149,11 @@ vc4_v3d_pm_put(struct vc4_dev *vc4)
>   	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>   		return;
>   
> -	mutex_lock(&vc4->power_lock);
> +	guard(mutex)(&vc4->power_lock);
>   	if (--vc4->power_refcount == 0) {
>   		pm_runtime_mark_last_busy(&vc4->v3d->pdev->dev);
>   		pm_runtime_put_autosuspend(&vc4->v3d->pdev->dev);
>   	}
> -	mutex_unlock(&vc4->power_lock);
>   }
>   
>   static void vc4_v3d_init_hw(struct drm_device *dev)
> @@ -173,7 +170,6 @@ static void vc4_v3d_init_hw(struct drm_device *dev)
>   int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
>   {
>   	struct drm_device *dev = &vc4->base;
> -	unsigned long irqflags;
>   	int slot;
>   	uint64_t seqno = 0;
>   	struct vc4_exec_info *exec;
> @@ -182,23 +178,22 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
>   		return -ENODEV;
>   
>   try_again:
> -	spin_lock_irqsave(&vc4->job_lock, irqflags);
> -	slot = ffs(~vc4->bin_alloc_used);
> -	if (slot != 0) {
> -		/* Switch from ffs() bit index to a 0-based index. */
> -		slot--;
> -		vc4->bin_alloc_used |= BIT(slot);
> -		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> -		return slot;
> -	}
> +	scoped_guard (spinlock_irqsave, &vc4->job_lock) {
> +		slot = ffs(~vc4->bin_alloc_used);
> +		if (slot != 0) {
> +			/* Switch from ffs() bit index to a 0-based index. */
> +			slot--;
> +			vc4->bin_alloc_used |= BIT(slot);
> +			return slot;
> +		}
>   
> -	/* Couldn't find an open slot.  Wait for render to complete
> +		/* Couldn't find an open slot.  Wait for render to complete
>   	 * and try again.
>   	 */

Could you please align the rest of the comment?

Best Regards,
- Maíra

