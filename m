Return-Path: <linux-kernel+bounces-823147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC7B85A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1DAD7B6A47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CBF30EF94;
	Thu, 18 Sep 2025 15:33:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2E421B9D2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209610; cv=none; b=AfYTB8aWGEAvHYJseToZK+7UQiaYEe2/OJVTPmwHfGSKzLeqq7RdUA4vw1A2TYa+UApZBjkhTZVf90KZWMh1aC3haJrWiCdywcqg5KxJT9vzYwuvRXcmPTw5yg7rJ+Et0zQ4GM84UIAiWL2PBsBdEsPYAEvXQHqzPcUN6AbK1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209610; c=relaxed/simple;
	bh=PAHIAT0T24sdTp2kfnjp+LQE/CGQa3a2moUgjgk86xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A8o6Sz6401mb1LArwOqIJatbcWxS0LcqKKWpj1yGeQTR/t0q6nZqgXdxJaUuXcJiqwtaUrUoQ3UGAzhVJEEWUCW5VENEtZq7mNOR+avh3BsKk00c1DTGcYkGKNP1/FoV/qeECvH1GFuJXnWfglypUwI8U0/mCHLPCRrlJAvaz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2B4176C;
	Thu, 18 Sep 2025 08:33:20 -0700 (PDT)
Received: from [10.1.32.53] (e122027.cambridge.arm.com [10.1.32.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636A23F694;
	Thu, 18 Sep 2025 08:33:26 -0700 (PDT)
Message-ID: <9a229053-3e2e-4de4-82b4-a0589d0e5003@arm.com>
Date: Thu, 18 Sep 2025 16:33:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: always set fence errors on CS_FAULT
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250828200419.3533393-1-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250828200419.3533393-1-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/08/2025 21:04, Chia-I Wu wrote:
> It is unclear why fence errors were set only for CS_INHERIT_FAULT.
> Downstream driver also does not treat CS_INHERIT_FAULT specially.
> Remove the check.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-next.

Thanks,
Steve

> ---
> v2: add rb from Boris
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index ba5dc3e443d9c..231f42c67f175 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1412,7 +1412,7 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
>  	fault = cs_iface->output->fault;
>  	info = cs_iface->output->fault_info;
>  
> -	if (queue && CS_EXCEPTION_TYPE(fault) == DRM_PANTHOR_EXCEPTION_CS_INHERIT_FAULT) {
> +	if (queue) {
>  		u64 cs_extract = queue->iface.output->extract;
>  		struct panthor_job *job;
>  


