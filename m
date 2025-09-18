Return-Path: <linux-kernel+bounces-822902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C546B84EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCBB621AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79167231836;
	Thu, 18 Sep 2025 13:58:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A3E22A7E2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203933; cv=none; b=UPa/fV7FfqSM8BK6rOughY0bX7/j3H7GCAgfB63VbdloBV2WnNP0nPcJ+O9w+QX4KWMftjjjPhIl2tOM43qlO17T+dsQIO10oG/iW07YTLfATFcz34qeJTviN0akGRKhy0AV9b5jO22n3FZfbO9QrF6czhxV6jlfLUSBNCmrtMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203933; c=relaxed/simple;
	bh=PJP4NK4VelC8Rw+kHuB3WSkmtrtYp28ztXFSFMb9llU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrcsqZisE6iawVRnN1/Argq4Ytwt5NFPYPQM63OpriXMUTv2GeUnnP5Nc7rDyLf4FO2BM+/oQxrjiWPY4/Nj0faz2RtnIqxsl10eugjQas4+R+OmeIGLgpRqne/oqwdfMCaPu0/BHDa7pRr7upUegOTCu8m7WppXz9UDycJHLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44B731A25;
	Thu, 18 Sep 2025 06:58:41 -0700 (PDT)
Received: from [10.1.32.53] (e122027.cambridge.arm.com [10.1.32.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 414293F673;
	Thu, 18 Sep 2025 06:58:48 -0700 (PDT)
Message-ID: <8434d14e-827d-4652-b4f8-06e2aa4caa41@arm.com>
Date: Thu, 18 Sep 2025 14:58:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Introduce Panfrost JM contexts
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com
References: <20250917191859.500279-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250917191859.500279-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/09/2025 20:18, Adrián Larumbe wrote:
> This patch series brings the notion of JM contexts into Panfrost.
> UM will be able to create contexts, get a handle for them and attach
> it to a job submission. Contexts describe basic HW resource assignment
> to jobs, but at the moment that includes priorities only.
> 
> There's a MR for a Mesa commit series that makes use of these changes:
> https://lore.kernel.org/dri-devel/20250904001054.147465-1-adrian.larumbe@collabora.com/
> 
> Discussion of the previous patch series revision can be found at:
> https://lore.kernel.org/dri-devel/20250912132002.304187-1-adrian.larumbe@collabora.com/

Pushed to drm-misc-next.

Thanks,
Steve

> 
> Changelog:
> v4:
>  - Iterate over all the indices for the scheduler entity array when creating,
>  releasing or otherwise destroying a job context, in case someone would want to
>  implement compute support in the future.
>  - Add R-b tags to other patches.
> v3:
>  - Cut down number of available contexts per file to 64.
>  - Conservatively restored JS thread priority back to 8.
>  - Rework of the context destruction and scheduler entity release
>  logic to avoid races and that no new jobs are run after ctx destruction.
>  - Refactor privilege checks when allowing high context priorities.
>  - Checked that uapi struct padding fields are zeroed in ioctls
> 
> v2:
>  - Core and L2 cache affinities are not longer part of the context uAPI
>  - Individual JS priorites are no longer possible, and the same context
>  priority is applied onto all the JS and scheduler entities.
>  - Minor changes in the debugfs knob to reflect all the above.
> 
> Boris Brezillon (4):
>   drm/panfrost: Introduce uAPI for JM context creation
>   drm/panfrost: Introduce JM contexts for manging job resources
>   drm/panfrost: Expose JM context IOCTLs to UM
>   drm/panfrost: Display list of device JM contexts over debugfs
> 
>  drivers/gpu/drm/panfrost/panfrost_device.h |  11 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c    | 150 +++++++++++++++-
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 195 +++++++++++++++++----
>  drivers/gpu/drm/panfrost/panfrost_job.h    |  25 ++-
>  include/uapi/drm/panfrost_drm.h            |  50 ++++++
>  5 files changed, 391 insertions(+), 40 deletions(-)
> 
> 
> base-commit: a3ae3384be7704fcf41279f13190bd8a11204bea
> --
> 2.51.0


