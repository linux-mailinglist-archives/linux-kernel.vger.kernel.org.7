Return-Path: <linux-kernel+bounces-890262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A00E2C3FA2C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9C464F079A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C131B804;
	Fri,  7 Nov 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iYRsj9oY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B923195E4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513519; cv=none; b=H9XAREsvtA60pKJ3KS1mWRK0UqD2Gnq6y+htCPcfbfB5sAmkE1bqr/DenIUTPsPvB8Xh4g1venbPVPJV0/Ba5w0m4evMWHNqI311POeJTbnPSGE2R2mLA0hcjgdYLjDJwuGi8/j+D9ghaIRnfO5HDCBKiqV4QFW4QGqrF05hr9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513519; c=relaxed/simple;
	bh=ODcL8SYb76gPGjPes1ZBf9PDcCYTi757gqJ3YtFG4OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mh8o3DrB25dIoRnhFAGz3xXSlMY2soiulIShxeRKi3y1MXAG7KeTzBcLWJVvzDWoekKhkN02PgZTcL7syGdod/gE9t4nJFRyyycIAt6AFSfhQS230zW/lOREdNXDzUR7bOaFCNPJX4A/HBfaA8R6mUzqngFOyBfQ591jaKcG458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iYRsj9oY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762513515;
	bh=ODcL8SYb76gPGjPes1ZBf9PDcCYTi757gqJ3YtFG4OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iYRsj9oYBywQlKcO0CzXLtxljnmCgh//zajN6afaUsbHIHpK0E0scsMrx/dl2jxD9
	 /frEXcivxX6gTPtuxThXgqWzPbNgj2fUVEHgcdEQJGI2KxllHrK+rYgG2NyPsfq03F
	 oWzoSFLb6PcZQur+7Z0W7kliEA+lUHYvJhnGU63SccIkDVYAmd5lTAEZJqu223YIkZ
	 BteoygNI+lb2NNr9Jub6dDBSXOpKHk0/xgtaASndXdFw1Hz3vCcld/woFdTezrmZ5g
	 FwpCNySIO2EEfnJBffLZLl36c1oUR9IcfB42nUjkYVivPDm6nr/Us3K+/HTXs16+Kd
	 DGiYf+hxCb7iw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E8C617E04D6;
	Fri,  7 Nov 2025 12:05:15 +0100 (CET)
Date: Fri, 7 Nov 2025 12:05:10 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] drm/panthor: Add support for Mali-G1 GPUs
Message-ID: <20251107120510.1ad142f9@fedora>
In-Reply-To: <20251027161334.854650-1-karunika.choo@arm.com>
References: <20251027161334.854650-1-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 16:13:26 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> This patch series extends the Panthor driver with basic support for
> Mali-G1 GPUs.
> 
> The v14 architecture introduces several hardware and register-level
> changes compared to prior GPUs. This series adds the necessary
> architecture-specific support infrastructure, power control and reset
> handling for Mali-G1 GPUs.
> 
> Patch Breakdown:
> [Patch 1-2]:  Refactor panthor_hw to introduce architecture-specific
>               hooks and abstractions to support the v14 architecture.
>               These patches introduce architecture-specific HW binding
>               for function pointers.
> [Patch 3-5]:  Adds basic L2 power on/off and soft reset support for the
>               PWR_CONTROL block introduced in v14.
> [Patch 6]:    Update MCU halt and warm boot operations to reflect the
>               GLB_REQ.STATE changes in v14. This ensures that the MCU is
>               properly halted and the correct operations are performed
>               on warm boot depending on the FW version.
> [Patch 7]:    Align endpoint_req with changes introduced in v14, where
>               the register is widened to 64-bit and shifed down by
>               4-bytes. This patch adds the necessary infrastructure to
>               discern the correct endpoint_req register to use.
> [Patch 8]:    Enables Mali-G1 support on Panthor by adding HW bindings
>               for v14 architecture, product names and path to FW binary.
> 
> v3:
>  * Updated include logic to enable static inline functions in
>    panthor_hw.h for function pointers and feature checks.
>  * Fixed missed replacement of CSF_IFACE_VERSION check with
>    panthor_fw_has_glb_state() check.
>  * Link to v2: https://lore.kernel.org/all/20251024202117.3241292-1-karunika.choo@arm.com/

Didn't thoroughly review the patchset, but I'm happy with the feature
checking changes, and I see that Steve has reviewed the whole thing, so
feel free to stick my

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>

> v2:
>  * Merged GPU_ID refactoring patch with the arch-specific panthor_hw
>    binding patch (formerly PATCH 01/10 and PATCH 02/10).
>  * Dropped panthor_hw feature bitmap patch in favor of functions that
>    performs the relevant architecture version checks.
>  * Fixed kernel test bot warnings.
>  * Replaced function pointer accessor MACROs with static inline
>    functions.
>  * Refined power control logic, removed unnecessary checks and redundant
>    stubs.
>  * Replaced explicit CSG_IFACE_VERSION checks with functions describing
>    the feature being checked for.
>  * General readability improvements, more consistent error handling,
>    behaviour clarifications, and formatting fixes.
>  * Link to v1: https://lore.kernel.org/all/20251014094337.1009601-1-karunika.choo@arm.com/
> 
> Karunika Choo (8):
>   drm/panthor: Add arch-specific panthor_hw binding
>   drm/panthor: Add architecture-specific function operations
>   drm/panthor: Introduce panthor_pwr API and power control framework
>   drm/panthor: Implement L2 power on/off via PWR_CONTROL
>   drm/panthor: Implement soft reset via PWR_CONTROL
>   drm/panthor: Support GLB_REQ.STATE field for Mali-G1 GPUs
>   drm/panthor: Support 64-bit endpoint_req register for Mali-G1
>   drm/panthor: Add support for Mali-G1 GPUs
> 
>  drivers/gpu/drm/panthor/Makefile         |   1 +
>  drivers/gpu/drm/panthor/panthor_device.c |  18 +-
>  drivers/gpu/drm/panthor/panthor_device.h |   7 +
>  drivers/gpu/drm/panthor/panthor_fw.c     | 131 +++++-
>  drivers/gpu/drm/panthor/panthor_fw.h     |  32 +-
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  12 +-
>  drivers/gpu/drm/panthor/panthor_gpu.h    |   1 +
>  drivers/gpu/drm/panthor/panthor_hw.c     | 108 ++++-
>  drivers/gpu/drm/panthor/panthor_hw.h     |  47 +-
>  drivers/gpu/drm/panthor/panthor_pwr.c    | 548 +++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_pwr.h    |  23 +
>  drivers/gpu/drm/panthor/panthor_regs.h   |  79 ++++
>  drivers/gpu/drm/panthor/panthor_sched.c  |  21 +-
>  13 files changed, 987 insertions(+), 41 deletions(-)
>  create mode 100644 drivers/gpu/drm/panthor/panthor_pwr.c
>  create mode 100644 drivers/gpu/drm/panthor/panthor_pwr.h
> 
> --
> 2.49.0
> 


