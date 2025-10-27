Return-Path: <linux-kernel+bounces-871841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFBBC0E7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A4D462B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7830C350;
	Mon, 27 Oct 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JFCRzvik"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6D30AD04
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575506; cv=none; b=f2xolQhidV1oQCcsHAnwdwFpcbYBf//vY2N+WulaOAuBgq7noeLUkHlSpMzd35ozLTBpQSv62Vwi32I5a7JYcYjQpy+SeszkhkUAtO8FTJSZu1OGV2VRR6GZyckvAOgNvqKF2cgQ8OpoVg38dezlixm3J7/oxNy2TuLU6B6QDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575506; c=relaxed/simple;
	bh=VdWLvlec4owgKSLuZPZ5AeOCOOq3PaC0ucUYJYVqsAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Umhk6ZI1bGRLVd5jTtuIa1aVP2sLIQ878pj0f6AANpMyHd/0LnY37Xn2VXnIMKdsknOcIuw+2iRYC28sds2r7YbObi0HQzkU4seDcfs8Y4hw7FcJCROYT7ZsPEOTFoXbbKxA0zddTeugWMdKKM/LDr+Ssw1rHFKHZ5qU3sSA7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JFCRzvik; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761575501;
	bh=VdWLvlec4owgKSLuZPZ5AeOCOOq3PaC0ucUYJYVqsAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JFCRzvikkg0zalCE058zIPnyylLwZMQ3GhgSH4FDe8dgcbDs5qmsiaTXnogTsic+Y
	 +r0H2l5aXJb7jTXzKKU/q20dlfSxuWKEDyPDiABiFABOVYt7x9J3Qvm4lVbc2FxUsg
	 PZbxPxmi0kXgVWeygww0Try/IDhuip8Pk22enS1mJv8xMsT2hdzWUc9ZPihm0rSykC
	 Lzy/0r5OjDpA663JCCu70T+MmydQlONWeKIWWAwha2Qy0+pBsEuhIchRT1rn5+TU7m
	 0Jg9rcrhkK84Bmgc0TXU//vyFNv38903TU5Z/g2nqsDDz2Ywesmy8D77gYRbZIId/J
	 9M0Jp0i7UoljQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3ED3F17E12D5;
	Mon, 27 Oct 2025 15:31:41 +0100 (CET)
Date: Mon, 27 Oct 2025 15:31:30 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/panthor: Fix UAF race between device unplug and
 FW event processing
Message-ID: <20251027153130.2e9ccee2@fedora>
In-Reply-To: <20251027140217.121274-1-ketil.johnsen@arm.com>
References: <20251027140217.121274-1-ketil.johnsen@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 15:02:15 +0100
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> The function panthor_fw_unplug() will free the FW memory sections.
> The problem is that there could still be pending FW events which are yet
> not handled at this point. process_fw_events_work() can in this case try
> to access said freed memory.
> 
> Simply call disable_work_sync() to both drain and prevent future
> invocation of process_fw_events_work().
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Fixes: de85488138247 ("drm/panthor: Add the scheduler logical block")

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Would you mind sending a patch on top of this one turning all
cancel_[delayed_]work_sync() happening in the unplug path int
disable_[delayed_]work_sync(), so we're sure we won't face other "work
in queued after being cancelled" issues in the future.

> ---
> v2:
> - Followed Boris's advice and handle the race purely within the
>   scheduler block (by adding a destroyed state)
> 
> v3:
> - New approach, one single call to disable_work_sync()
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 0cc9055f4ee52..b7595beaa0205 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3880,6 +3880,7 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
>  	struct panthor_scheduler *sched = ptdev->scheduler;
>  
>  	cancel_delayed_work_sync(&sched->tick_work);
> +	disable_work_sync(&sched->fw_events_work);
>  
>  	mutex_lock(&sched->lock);
>  	if (sched->pm.has_ref) {


