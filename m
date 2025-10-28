Return-Path: <linux-kernel+bounces-872979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 315B8C12C28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D013D4E671C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D827A461;
	Tue, 28 Oct 2025 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UVUL36IU"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795B38F9C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622118; cv=none; b=hski179HjH/4o2eaqgg9nbDu1UeYKpo/XWsVH4iEf/BdOjYkR0Un1reulPJAFRcmRp7UFWgYnKqKIV42o8TnSnpL7vyT/jkbOk/ta2Z5+9TVOpUWpRk2JtQyyd1ks2pLXsUjvXkUvN73wrWNGC4Es0JLuxQjeCgqSs2ajFZcIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622118; c=relaxed/simple;
	bh=V0KSmCVMuI+FIlneQKxiqL3uRw23wD7fa+uMyNjyZ54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mfGEQrmNwUdKAyzX+w5On9+jmt3+o+VKi8hAIGaEHxk9i5AdXsgPFUJRZkZOwhmrYy6NvG2X/cPGNCEz7dP5I50yl8wYLowg14lv34DBjNnuP769iEw3FRGTc4XdiihyJ5qrspjcBFsZ7UhkXdFrn5/DwFFLvqlakAlIdfzj3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UVUL36IU; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59S3S9ek2563347;
	Mon, 27 Oct 2025 22:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761622089;
	bh=SokHI3gbW0CM5UxYqOGcXWx0ix+zGTlPjnprPVmhxx0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UVUL36IUlJUphl9pTXw/RQwYV3s/CR1oxvonDXlqOAkbiCOk+oBWGjne+o2sFhOxw
	 KGveqRLCVjYk9UZFRIqtzteEZVJilXUIp5FOOv9WI07BZXf5OkTs+ERg4AGz9bCAnG
	 YnWfnxyvAi75xBAalznPUDK0L/0oh2yNDuHeZMgQ=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59S3S91L1390877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 22:28:09 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 22:28:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 22:28:08 -0500
Received: from [10.249.128.221] ([10.249.128.221])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59S3S3mm1671754;
	Mon, 27 Oct 2025 22:28:03 -0500
Message-ID: <b6ce2b26-d941-4620-9544-e72d1d3d0d73@ti.com>
Date: Tue, 28 Oct 2025 08:58:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Decouple max/min_pclk_khz check from constant
 display feats
To: <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <mripard@kernel.org>,
        <tomi.valkeinen@ideasonboard.com>, <jyri.sarha@iki.fi>,
        <maarten.lankhorst@linux.intel.com>, <simona@ffwll.ch>,
        <airlied@gmail.com>, <tzimmermann@suse.de>, <h-shenoy@ti.com>
CC: <praneeth@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20251027212624.359235-1-s-jain1@ti.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20251027212624.359235-1-s-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 28-10-2025 02:56, Swamil Jain wrote:
> In an effort to make the existing compatibles more usable, we are
> removing the max/min_pclk_khz form dispc_features structure and doing
> the supported pixel clock checks using clk_round_rate().
> 
> Changes are fully backwards compatible.
> 
> - Remove max/min_pclk_khz and use clk_round_rate to validate modes
> - Skip OLDI mode validate through dispc_vp_mode_valid and add
>    mode_valid hook to validate modes for OLDI bridge in tidss_oldi.c
> 
> ---

NACK. I will resend v7 with some modifications in the cover letter.

Regards,
Swamil> Changelog v6->v7
> - Remove both max/min_pclk_khz as suggested by Tomi
> - Use mode_valid() instead of atomic_check()
> - Squash patches v6 PATCH 1/3 and PATCH 2/3 which is a fix to OLDI
>    series[1]
> - Minor fixes in commit message
> - Update comments to include more reasoning to add Fixes tag to
>    Patch v7 2/2
> 
> [1]: https://lore.kernel.org/all/20250528122544.817829-1-aradhya.bhatia@linux.dev/
> 
> v6 patch link:
> https://lore.kernel.org/all/20250911110715.2873596-1-s-jain1@ti.com/
> 
> Changelog v5->v6
> - Drop caching logic
> - Add comments for tolerance value
>    (We are targeting another series for reducing tolerance value)
> - Minor fixes in commit message
> 
> v5 patch link:
> https://lore.kernel.org/all/20250819192113.2420396-1-s-jain1@ti.com/
> 
> Changelog v4->v5
> - Rename is_oldi_vp[] to is_ext_vp_clk[]
> - Store both pixel clock round_rate and attempted_rate to reduce
>    clk_round_rate() calls while validating modes
> - Code changes suggested by Tomi[2]
> - Minor fixes in comments and commit message
> 
> [2]: https://lore.kernel.org/all/8cd9d1c4-2e9f-4766-b224-21925c4f991d@ideasonboard.com/
> 
> v4 patch link:
> https://lore.kernel.org/all/20250704094851.182131-1-j-choudhary@ti.com/
> 
> Changelog v3->v4:
> - Minor cosmetic fixes in code, comments and commit message
> - Pick up R-by and add Fixes tag
> 
> v3 patch link:
> https://lore.kernel.org/all/20250701095541.190422-1-j-choudhary@ti.com/
> 
> Changelog v2->v3:
> - Add changes for OLDI
> - Rename max_pclk as it is misleading
> - Change commit message to make it more appropriate
> - Drop unnecessary zero initialization
> 
> v2 patch link:
> https://lore.kernel.org/all/20250618100509.20386-1-j-choudhary@ti.com/
> 
> Changelog v1->v2:
> - Rebase it on linux-next after OLDI support series as all of its
>    patches are reviewed and tested and it touches one of the functions
>    used.
>    
> v1 patch link:
> https://lore.kernel.org/all/20250618075804.139844-1-j-choudhary@ti.com/
> 
> ---
> Jayesh Choudhary (2):
>    drm/tidss: Remove max_pclk_khz and min_pclk_khz from tidss display
>      features
>    drm/tidss: Move OLDI mode validation to OLDI bridge mode_valid hook
> 
>   drivers/gpu/drm/tidss/tidss_dispc.c | 87 +++++++++++------------------
>   drivers/gpu/drm/tidss/tidss_dispc.h |  3 -
>   drivers/gpu/drm/tidss/tidss_drv.h   |  2 +
>   drivers/gpu/drm/tidss/tidss_oldi.c  | 21 +++++++
>   4 files changed, 55 insertions(+), 58 deletions(-)
> 


