Return-Path: <linux-kernel+bounces-698032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A33AE3C28
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1423B76EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298E71519BC;
	Mon, 23 Jun 2025 10:23:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F4B188CC9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674222; cv=none; b=SuPHyhQHSu0iRyYjJG5el0myJ554VRa2xRAmfSjYU0ER733pApfXnuaAyfUwl91ISDRcXtqUhdskqA16INU/Op3S9LmA6GdxLGSM1oran1HsuuoCl7TRTgbD+FFfCa7zJWKGp8VBbSSE0DhYyD/9ARTFfo00leND6CbC+GN6HYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674222; c=relaxed/simple;
	bh=WI5ZmTVkd6U4k9kC0I2oB1mm4hCgW/bc8fbdEB856cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORwyyBNi3dGqKkSo4ru2X8e/l4EuwCgU+YDZ8Nah93OfJBfXRI7Zdb8EKPQt9qhzMFtPopidrocxi3T/oJy80DcL1oFRDcZFo+MTRyN1XaO9LNVDSGD84hAsB0bZKVk0k8nbqWM2e34spclyxfd9qZmVT0K0in0EMl0f0VBBTyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E312113E;
	Mon, 23 Jun 2025 03:23:21 -0700 (PDT)
Received: from [10.57.29.183] (unknown [10.57.29.183])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 310703F58B;
	Mon, 23 Jun 2025 03:23:37 -0700 (PDT)
Message-ID: <397a2f12-1601-4cc3-a013-5250dde2a8f5@arm.com>
Date: Mon, 23 Jun 2025 11:23:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Add GPU specific initialization framework to
 support new Mali GPUs
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20250602143216.2621881-1-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250602143216.2621881-1-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Karunika,

On 02/06/2025 15:32, Karunika Choo wrote:
> This patch series introduces a GPU HW abstraction to Panthor, to enable
> support for new Mali GPUs.
> 
> Key changes:
> - Addition of GPU-specific initialization framework to standardize and
>   streamline support new GPUs.
> - Support for cache maintenance via the FLUSH_CACHES GPU command.
> - Support for Mali-Gx10, Mali-Gx15, Mali-Gx20, and Mali-Gx25 GPUs.

The changes mostly look fine to me - just some comments on patch 6 which
I'll send separately. Also as Chia-I Wu has already pointed out I think
there's some excess baggage with unused fields. It's best to keep things
minimal and we can add extra fields when they are actually needed rather
than having dead code which might end up never being used.

Thanks,
Steve

> 
> Firmware for these GPUs can be found here:
> https://gitlab.com/dliviu/linux-firmware
> 
> Patch Breakdown:
> [PATCH 1]:   Implements the GPU-specific initialization framework to
>              handle differences between GPU architectures by enabling
>              definition of architecture-specific initialization routines
> [PATCH 2-3]: Refactors gpu_info initialization in preparation for GPU
>              register changes and at the same time simplifies and makes
>              extensible the process of determining the GPU model name.
> [PATCH 4]:   Adds support for Mali-G710, Mali-G510 and Mali-G310.
> [PATCH 5]:   Adds support for Mali-Gx15 GPUs.
> [PATCH 6]:   Adds cache maintenance via the FLUSH_CACHES GPU command due
>              to deprecation of FLUSH_MEM and FLUSH_PT MMU_AS commands
>              from Mali-Gx20 onwards.
> [PATCH 7]:   Adds support for Mali-Gx20 and Mali-Gx25 GPUs.
> 
> 
> v4:
> - Split 64-bit register accessor patches into another patch series.
>   - link: https://lore.kernel.org/dri-devel/20250417123725.2733201-1-karunika.choo@arm.com/
> - Switched to using arch_major for comparison instead of arch_id in
>   panthor_hw.c.
> - Removed the gpu_info_init function pointer in favour of a single
>   function to handle minor register changes. The function names have
>   also been adjusted accordingly.
> - Moved the patch to support Mali-G710, Mali-G510 and Mali-G310 forwards
>   to [PATCH 4/7].
> - Extended support to perform cache maintenance via GPU_CONTROL to
>   Mali-Gx10 and Mali-Gx15 GPUs.
> - Link to v2: https://lore.kernel.org/all/20250320111741.1937892-1-karunika.choo@arm.com/
> v3:
> - Kindly ignore this patch series as there were duplicate patches being
>   included.
> v2:
> - Removed handling for register base addresses as they are not yet
>   needed.
> - Merged gpu_info handling into panthor_hw.c as they depend on the same
>   arch_id matching mechanism.
> - Made gpu_info initialization a GPU-specific function.
> - Removed unnecessary changes for cache maintenance via GPU_CONTROL.
> - Removed unnecessary pre-parsing of register fields from v1. Retaining
>   current implementation as much as possible.
> - Added support for G710, G715, G720, and G725 series of Mali GPUs.
> - Link to v1: https://lore.kernel.org/all/20241219170521.64879-1-karunika.choo@arm.com/
> 
> Thanks,
> Karunika Choo
> 
> Karunika Choo (7):
>   drm/panthor: Add GPU specific initialization framework
>   drm/panthor: Move GPU info initialization into panthor_hw.c
>   drm/panthor: Simplify getting the GPU model name
>   drm/panthor: Add support for Mali-G710, Mali-G510 and Mali-G310
>   drm/panthor: Add support for Mali-Gx15 family of GPUs
>   drm/panthor: Support GPU_CONTROL cache flush based on feature bit
>   drm/panthor: Add support for Mali-Gx20 and Mali-Gx25 GPUs
> 
>  drivers/gpu/drm/panthor/Makefile         |   1 +
>  drivers/gpu/drm/panthor/panthor_device.c |   5 +
>  drivers/gpu/drm/panthor/panthor_device.h |   4 +
>  drivers/gpu/drm/panthor/panthor_fw.c     |   5 +
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  95 -----------
>  drivers/gpu/drm/panthor/panthor_hw.c     | 197 +++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_hw.h     |  66 ++++++++
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  35 ++++
>  drivers/gpu/drm/panthor/panthor_regs.h   |  25 +++
>  include/uapi/drm/panthor_drm.h           |   3 +
>  10 files changed, 341 insertions(+), 95 deletions(-)
>  create mode 100644 drivers/gpu/drm/panthor/panthor_hw.c
>  create mode 100644 drivers/gpu/drm/panthor/panthor_hw.h
> 
> --
> 2.49.0
> 


