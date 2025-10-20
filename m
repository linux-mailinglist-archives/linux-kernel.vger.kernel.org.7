Return-Path: <linux-kernel+bounces-861213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A98BF215F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B30884F7B97
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48308245014;
	Mon, 20 Oct 2025 15:24:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE4148830
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973881; cv=none; b=ISjZtiGC8GZmFAPGgyTmrkvVDCMLM0ymhHkbXPTtOoe6Ka4wH+BJIE9JW5c5Lt/wn2Eh2osm9hMJTfCK506eByPGK10DwsD6Jr1tWK4JeUvJn7ZiGVMi/kl1U5PUCWo7dgQDT+52jaCVrNwSB0GAhQEq2kIHwjaqoUkS65P3Z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973881; c=relaxed/simple;
	bh=k1cnJl76gghokC/OSDt5Bfpinf5+i+Zat+vTFHvC43o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBzZte4Wu7W0DiMq7l25uB+8nr3KXMg08JEqld/NGTrx6ClkHTLM4BQ+UaJfSTeKAOTlxXDgcSlUjUGKm7lPFWSM8WAFR+ih63pyUz+P4TqjmOqRmcfqV6sW3/LEfsC/EXYWO05AbLeVWEswGJ1jjeFztaLv5xB7sZnjRcaHzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4396B1063;
	Mon, 20 Oct 2025 08:24:31 -0700 (PDT)
Received: from [10.57.36.117] (unknown [10.57.36.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A5F13F66E;
	Mon, 20 Oct 2025 08:24:38 -0700 (PDT)
Message-ID: <0cecb6d8-7c8c-4b93-b35e-d085f9f0fcee@arm.com>
Date: Mon, 20 Oct 2025 16:24:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] Some Panfrost fixes and improvements
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com
References: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/10/2025 15:52, Adrián Larumbe wrote:
> This is v7 of https://lore.kernel.org/dri-devel/20251015000930.356073-1-adrian.larumbe@collabora.com/
> 
> This patch series is a collection of minor fixes and improvements I came up
> with while working on driver related stuff.

Merged to drm-misc-next.

> 
> Changelog:
>  v7:
>   - Fixed bug when handling AS number allocation. In case of error and early
>   bail-out, AS lock was being left in held state. This was uncovered by smart.
>   - Added new R-b tags.
>  v6:
>   - Don't optimise page range walk in the event of a double MMU fault
>   - Handle some minots and minor style changes
>   - Rebase patch series onto latest drm-misc-next
>  v5:
>  - Move devfreq record keeping further down job submission function to
>  keep busy count balanced in case of an early bail-out.
>  - In MMU page fault ISR, bail out when sgt for 2MiB page is not assigned,
>  rather than when the page array is populated. Add new commit for this.
>  - Add commit with myself as a new Panfrost maintainer
> 
>  v4:
>   - Rebased older patch series onto latest drm-misc-next
>   - Added patch for renaming JM functions to reflect their actual role
>   - Fixed treatment of error code in perfcnt when enabling sample buffer AS
> 
>  v3:
>   - Minor convenience fixes to patches 3 and 4 in the series
>   - Move unmapping of maped range of BO to the function's error path
>   in case of BO mapping failure, also for putting BO's pages
>   - Split patch 6/8 into two: one makes sure the Job IRQ enablement mask
>   isn't recalculated at every device reset and uses the same expression
>   everywhere in the driver, and another one that breaks the enablement
>   function into two stages.
> 
>  v2:
>   - Removed commit that provided an explicit fence cleanup function
>   - Added commit for removing unused Panfrost device structure member
>   - Refactored how optional job interrupt reenabling during reset is handled
>   - Make the way errors and successful return values are delivered from inside
>    panfrost_mmu_as_get more according to standard.
>   - Simplify unmapping of already mapped area when mapping the pages of a BO
>   - Fixing management of runtime-PM reference counts when failing HW job submission.
> 
> Adrián Larumbe (12):
>   drm/panfrost: Replace DRM driver allocation method with newer one
>   drm/panfrost: Handle inexistent GPU during probe
>   drm/panfrost: Handle job HW submit errors
>   drm/panfrost: Handle error when allocating AS number
>   drm/panfrost: Check sgt to know whether pages are already mapped
>   drm/panfrost: Handle page mapping failure
>   drm/panfrost: Don't rework job IRQ enable mask in the enable path
>   drm/panfrost: Make re-enabling job interrupts at device reset optional
>   drm/panfrost: Add forward declaration and types header
>   drm/panfrost: Remove unused device property
>   drm/panfrost: Rename panfrost_job functions to reflect real role
>   MAINTAINERS: Panfrost: Add Steven Price and Adrian Larumbe
> 
>  MAINTAINERS                                   |   3 +-
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c   |   4 +-
>  drivers/gpu/drm/panfrost/panfrost_device.c    |  68 +++++----
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  13 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  78 ++++------
>  drivers/gpu/drm/panfrost/panfrost_dump.c      |   8 +-
>  drivers/gpu/drm/panfrost/panfrost_gem.c       |   8 +-
>  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   4 +-
>  drivers/gpu/drm/panfrost/panfrost_gpu.c       |  64 ++++----
>  drivers/gpu/drm/panfrost/panfrost_job.c       | 139 +++++++++---------
>  drivers/gpu/drm/panfrost/panfrost_job.h       |  15 +-
>  drivers/gpu/drm/panfrost/panfrost_mmu.c       | 114 +++++++++-----
>  drivers/gpu/drm/panfrost/panfrost_mmu.h       |   3 +-
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |  26 ++--
>  14 files changed, 303 insertions(+), 244 deletions(-)
> 
> 
> base-commit: 7fb19ea1ec6aa85c75905b1fd732d50801e7fb28
> --
> 2.51.0


