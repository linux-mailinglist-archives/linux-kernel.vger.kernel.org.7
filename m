Return-Path: <linux-kernel+bounces-805702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D55B48C77
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE93B3B2297
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE8227B83;
	Mon,  8 Sep 2025 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I5xnFxMK"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22572A1D1;
	Mon,  8 Sep 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331985; cv=none; b=ZParEnsmmZYToIClDIwnAYVsp6aNZ0CaMWTgs0u4Dph+OpYS1KlD9c2GZr0tRONbqrwqSzpV5BgdDOZJO13mwaiDPBxkO+H+8avwga3TsP3x9N8iOA4s7WXrpX6mfUieoZyyCLl2/4TbBGHHANzE5HB2dgNbFAEzjww9vj4mX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331985; c=relaxed/simple;
	bh=rGxQg/bqqslzWLQ9PxYIu4U6b9Zw/zcHdcOiCANK9fg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVQ1liVl7W87OFBNGiWF0lMwbtapvrDDWRlXSo0D82TqVGQqpXZaWxXFe6+PDF2WfKldNEglBM/oa8xb4j3X3fsxBtKaJfhyVv40Nj4u3slzJPqaLxt+tyhXXsdDa+IieqZ32Dj3lX32Yn1NpTy9wb+BO5lVpkP8ZYJt978yXmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I5xnFxMK; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588BkFQi3857896;
	Mon, 8 Sep 2025 06:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757331975;
	bh=u+9oy/uQje1G1sxzVl3tUaa4mGAbbi+cglDFrnK+Tvs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=I5xnFxMKNKKvW3sZQJrZMLJKlFS9fn8WSKJIO1WI6P9EWNgaMBl+FmjNbz5tz1Bv2
	 8LpFCklIIDy6BliLz8tNAnrpy28W31pD9xFIOQTgE3pbe1GqWuYEm2FL51QicoxZJ4
	 xupgJuo/GZH8kSpIbuNrPsXFYbXHXhaAr6Ns3yWY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588BkFq42380265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 06:46:15 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 06:46:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 06:46:15 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588BkEd1540310;
	Mon, 8 Sep 2025 06:46:14 -0500
Date: Mon, 8 Sep 2025 17:16:13 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afd@ti.com>,
        <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v3 16/33] arm64: dts: ti: k3-am62-pocketbeagle2: Add
 missing cfg for TI IPC Firmware
Message-ID: <20250908114613.mfujvrzqzqudkmpl@lcpd911>
References: <20250905051846.1189612-1-b-padhi@ti.com>
 <20250905051846.1189612-17-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905051846.1189612-17-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 05, 2025 at 10:48:29 +0530, Beleswar Padhi wrote:
> The wkup_r5fss0_core0_memory_region is used to store the text/data
> sections of the Device Manager (DM) firmware itself and is necessary for
> platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
> for allocating the Virtio buffers needed for IPC with the DM core which
> could be optional. The labels were incorrectly used in the
> k3-am62-pocketbeagle2.dts file. Correct the firmware memory region label
> 
> Currently, only mailbox node is enabled with FIFO assignment for a
> single M4F remote core. Add the missing carveouts for WKUP R5F remote
> processor, and enable that by associating to the above carveout and
> mailbox. This config aligns with other AM62 boards and can be
> refactored out later.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Requesting for review/test of this patch
> 
> v3: Changelog:
> 1. None
> 
> Link to v2:
> https://lore.kernel.org/all/20250823160901.2177841-17-b-padhi@ti.com/
> 
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 19/33] to [PATCH v2 16/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-20-b-padhi@ti.com/
> 
>  .../boot/dts/ti/k3-am62-pocketbeagle2.dts     | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> index 2eee5f638e0f..729901b2ca10 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> @@ -78,7 +78,13 @@ secure_ddr: optee@9e800000 {
>  			no-map;
>  		};
>  
> -		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9da00000 {

As long as Francesco's comments [1] are addressed,
include my R-by in the next rev:
Reviewed-by: Dhruva Gole <d-gole@ti.com>

[1] https://lore.kernel.org/all/20250821060629.GB7503@francesco-nb

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

