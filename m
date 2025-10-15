Return-Path: <linux-kernel+bounces-854035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A79BDD677
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EA7D4EDE08
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA233304984;
	Wed, 15 Oct 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FvLfJ/xJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352C30496A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516892; cv=none; b=OzNuxk/yPug+L2CzJ1s5XhKm9twp2Gv6jbPvgnpXDTIDzOUmCZkNrjylkciEKTy6qOJr8n/mGp+AdvPstiqCkMP4/eRj0gDBAryCQrRgOW2OzrAXH6h+tZzvkqTi7BT43fe0oKfMJg4SPyQ/+ei3OPiGrXcDb+u02QKHY6R/esM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516892; c=relaxed/simple;
	bh=DUUJBOVgAjUbcI8pA66M3DD2k8SXU/r4JDMSjC3z394=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5nT3+cfs8LhIHo1hapLclIXkNhIUaatm/Nia/cx5NlXzO1ERZlDLn4eBQTY8jdMXF4EYSISuynHoS87osNuF+r70tqy5uEid0pOOOCHHUFu4wuq46l/5yibiT6Qzoi8Rjvcg4S215LQGIbpkeslGXQIexHv0H0kk0YknENO8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FvLfJ/xJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760516888;
	bh=DUUJBOVgAjUbcI8pA66M3DD2k8SXU/r4JDMSjC3z394=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FvLfJ/xJxx6wLRijUOEzPZKYFnfRPvS8dcWujwZlm1EE0BZjj9YXqI0xdky7904+c
	 N3FhXaK2aCHPLv8+BcOH/wUoyfsFM4kxVtmbzbQcgM3UFej0JzPUUDQ2SNM4WgL2hZ
	 bNCV6B4tvYIk8wQDGV56rSqEi8q9g/SB0ZffvP8ePDKuFbbc5A/JytuBf1BQ5ifqrO
	 ZiH/XG5OGjvblENgJz/9oE6jcA4ZEV7fYsg7sceTVaHFV+X4py8caZw5JCGSSJYmJ/
	 CHLhhgHDkWaiG1GOQi0baQCZaoos5xAZceVxPVCpn/1SuEmPIR/V5N5VsWm8yUp/F+
	 EZv80MmWNG8vw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F047917E1305;
	Wed, 15 Oct 2025 10:28:07 +0200 (CEST)
Message-ID: <234053da-7f1c-4642-b410-21d24a28a936@collabora.com>
Date: Wed, 15 Oct 2025 10:28:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] Some Panfrost fixes and improvements
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com
References: <20251015000930.356073-1-adrian.larumbe@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251015000930.356073-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 15/10/25 02:09, Adrián Larumbe ha scritto:
> This is v6 of https://lore.kernel.org/dri-devel/20251007150216.254250-1-adrian.larumbe@collabora.com/
> 
> This patch series is a collection of minor fixes and improvements I came up
> with while working on driver related stuff.
> 

Whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Changelog:
>   v6:
>    - Don't optimise page range walk in the event of a double MMU fault
>    - Handle some minots and minor style changes
>    - Rebase patch series onto latest drm-misc-next
>   v5:
>   - Move devfreq record keeping further down job submission function to
>   keep busy count balanced in case of an early bail-out.
>   - In MMU page fault ISR, bail out when sgt for 2MiB page is not assigned,
>   rather than when the page array is populated. Add new commit for this.
>   - Add commit with myself as a new Panfrost maintainer
> 
>   v4:
>    - Rebased older patch series onto latest drm-misc-next
>    - Added patch for renaming JM functions to reflect their actual role
>    - Fixed treatment of error code in perfcnt when enabling sample buffer AS
> 
>   v3:
>    - Minor convenience fixes to patches 3 and 4 in the series
>    - Move unmapping of maped range of BO to the function's error path
>    in case of BO mapping failure, also for putting BO's pages
>    - Split patch 6/8 into two: one makes sure the Job IRQ enablement mask
>    isn't recalculated at every device reset and uses the same expression
>    everywhere in the driver, and another one that breaks the enablement
>    function into two stages.
> 
>   v2:
>    - Removed commit that provided an explicit fence cleanup function
>    - Added commit for removing unused Panfrost device structure member
>    - Refactored how optional job interrupt reenabling during reset is handled
>    - Make the way errors and successful return values are delivered from inside
>     panfrost_mmu_as_get more according to standard.
>    - Simplify unmapping of already mapped area when mapping the pages of a BO
>    - Fixing management of runtime-PM reference counts when failing HW job submission.
> 
> Adrián Larumbe (12):
>    drm/panfrost: Replace DRM driver allocation method with newer one
>    drm/panfrost: Handle inexistent GPU during probe
>    drm/panfrost: Handle job HW submit errors
>    drm/panfrost: Handle error when allocating AS number
>    drm/panfrost: Check sgt to know whether pages are already mapped
>    drm/panfrost: Handle page mapping failure
>    drm/panfrost: Don't rework job IRQ enable mask in the enable path
>    drm/panfrost: Make re-enabling job interrupts at device reset optional
>    drm/panfrost: Add forward declaration and types header
>    drm/panfrost: Remove unused device property
>    drm/panfrost: Rename panfrost_job functions to reflect real role
>    MAINTAINERS: Panfrost: Add Steven Price and Adrian Larumbe
> 
>   MAINTAINERS                                   |   3 +-
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c   |   4 +-
>   drivers/gpu/drm/panfrost/panfrost_device.c    |  68 +++++----
>   drivers/gpu/drm/panfrost/panfrost_device.h    |  13 +-
>   drivers/gpu/drm/panfrost/panfrost_drv.c       |  78 ++++------
>   drivers/gpu/drm/panfrost/panfrost_dump.c      |   8 +-
>   drivers/gpu/drm/panfrost/panfrost_gem.c       |   8 +-
>   .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   4 +-
>   drivers/gpu/drm/panfrost/panfrost_gpu.c       |  64 ++++----
>   drivers/gpu/drm/panfrost/panfrost_job.c       | 139 +++++++++---------
>   drivers/gpu/drm/panfrost/panfrost_job.h       |  15 +-
>   drivers/gpu/drm/panfrost/panfrost_mmu.c       | 112 +++++++++-----
>   drivers/gpu/drm/panfrost/panfrost_mmu.h       |   3 +-
>   drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |  26 ++--
>   14 files changed, 301 insertions(+), 244 deletions(-)
> 
> 
> base-commit: 7fb19ea1ec6aa85c75905b1fd732d50801e7fb28
> --
> 2.51.0



