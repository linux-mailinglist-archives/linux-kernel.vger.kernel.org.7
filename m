Return-Path: <linux-kernel+bounces-895984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B10C4F6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D69634E5D61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E033CEA1;
	Tue, 11 Nov 2025 18:25:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095A2BEC30
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885525; cv=none; b=A+6BwKnvERjcHtaXB5AirCDM1kZWhEUoluop88aLo9XAZycFmEVZzN48mq9cuKpv9N56B/DmZoQy86POxMMT1VQ4Q6MVbbv/UAqgnXxFQ6muRCieMcgPKos7gWmN8w6J2+DPLoRYGlib3vEwwNAKAGdMVYg1/Dz/4EtMbZCaPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885525; c=relaxed/simple;
	bh=z/UugIN6hkJvej4eEcdyJ5wMM00ODVEszw4un8w8rXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCI/kem3/q/opi/YHaBzROsm22x+Z+rGht6ZaAsjbYvxWFXb5Rd93EnRoAe66BSPkMCwr8UG3g0lxdAA+xYvClldtiJbl9/7pN768gKDEWAsJhWYxbXjwDPYvdSLo6rxl6X51prADdIRtoA3hvW0VUHq1Hh5QrNDXZ3kyzY7E48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71BC8497
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:25:14 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4C123F63F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:25:21 -0800 (PST)
Date: Tue, 11 Nov 2025 18:25:13 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Abhishek Rajput <abhiraj21put@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/komeda: Convert logging in d71_component.c to drm_*
 with drm_device parameter
Message-ID: <aRN_ierYW0i1VT0E@e110455-lin.cambridge.arm.com>
References: <20251111113717.139401-1-abhiraj21put@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251111113717.139401-1-abhiraj21put@gmail.com>

On Tue, Nov 11, 2025 at 05:07:17PM +0530, Abhishek Rajput wrote:
> Replace DRM_ERROR() calls in
> drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> with the corresponding drm_err() helper.
> 
> The drm_*() logging helpers take a struct drm_device * as the first
> argument, allowing the DRM core to prefix log messages with the
> corresponding device instance. This improves log traceability when
> multiple display controllers are present.
> 
> The drm_device pointer is now safely obtained using
> komeda_kms_attach(d71->mdev), ensuring proper initialization and
> alignment with Komeda’s internal design.

That is absolutely not safe! komeda_kms_attach() is a heavy operation
that allocates a new drm device and it is meant to be used only at
probe time to "attach" a komeda KMS device. You cannot call it
from deep inside the implementation of a komeda_component.

When you've sent the previous patch I did have a look at d71_component.c
before replying but I've realised that it is not that easy to convert
to drm_err(). So we either remove all the error messages, which I'm
reluctant to do as they are useful for bring up, or we leave the file
alone.

For this patch:

NACKED by Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> 
> This change aligns komeda with the DRM TODO item:
> "Convert logging to drm_* functions with drm_device parameter".
> 
> Signed-off-by: Abhishek Rajput <abhiraj21put@gmail.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    | 34 ++++++++++++++-----
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 67e5d3b4190f..3524ca623d6e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -409,6 +409,8 @@ static const struct komeda_component_funcs d71_layer_funcs = {
>  static int d71_layer_init(struct d71_dev *d71,
>  			  struct block_header *blk, u32 __iomem *reg)
>  {
> +	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
> +	struct drm_device *drm = &kms->base;
>  	struct komeda_component *c;
>  	struct komeda_layer *layer;
>  	u32 pipe_id, layer_id, layer_info;
> @@ -421,7 +423,7 @@ static int d71_layer_init(struct d71_dev *d71,
>  				 get_valid_inputs(blk),
>  				 1, reg, "LPU%d_LAYER%d", pipe_id, layer_id);
>  	if (IS_ERR(c)) {
> -		DRM_ERROR("Failed to add layer component\n");
> +		drm_err(drm, "Failed to add layer component\n");
>  		return PTR_ERR(c);
>  	}
>  
> @@ -527,6 +529,8 @@ static const struct komeda_component_funcs d71_wb_layer_funcs = {
>  static int d71_wb_layer_init(struct d71_dev *d71,
>  			     struct block_header *blk, u32 __iomem *reg)
>  {
> +	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
> +	struct drm_device *drm = &kms->base;
>  	struct komeda_component *c;
>  	struct komeda_layer *wb_layer;
>  	u32 pipe_id, layer_id;
> @@ -539,7 +543,7 @@ static int d71_wb_layer_init(struct d71_dev *d71,
>  				 1, get_valid_inputs(blk), 0, reg,
>  				 "LPU%d_LAYER_WR", pipe_id);
>  	if (IS_ERR(c)) {
> -		DRM_ERROR("Failed to add wb_layer component\n");
> +		drm_err(drm, "Failed to add wb_layer component\n");
>  		return PTR_ERR(c);
>  	}
>  
> @@ -837,6 +841,8 @@ static const struct komeda_component_funcs d71_scaler_funcs = {
>  static int d71_scaler_init(struct d71_dev *d71,
>  			   struct block_header *blk, u32 __iomem *reg)
>  {
> +	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
> +	struct drm_device *drm = &kms->base;
>  	struct komeda_component *c;
>  	struct komeda_scaler *scaler;
>  	u32 pipe_id, comp_id;
> @@ -851,7 +857,7 @@ static int d71_scaler_init(struct d71_dev *d71,
>  				 pipe_id, BLOCK_INFO_BLK_ID(blk->block_info));
>  
>  	if (IS_ERR(c)) {
> -		DRM_ERROR("Failed to initialize scaler");
> +		drm_err(drm, "Failed to initialize scaler");
>  		return PTR_ERR(c);
>  	}
>  
> @@ -945,6 +951,8 @@ static const struct komeda_component_funcs d71_splitter_funcs = {
>  static int d71_splitter_init(struct d71_dev *d71,
>  			     struct block_header *blk, u32 __iomem *reg)
>  {
> +	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
> +	struct drm_device *drm = &kms->base;
>  	struct komeda_component *c;
>  	struct komeda_splitter *splitter;
>  	u32 pipe_id, comp_id;
> @@ -959,7 +967,7 @@ static int d71_splitter_init(struct d71_dev *d71,
>  				 "CU%d_SPLITTER", pipe_id);
>  
>  	if (IS_ERR(c)) {
> -		DRM_ERROR("Failed to initialize splitter");
> +		drm_err(drm, "Failed to initialize splitter");
>  		return -1;
>  	}
>  
> @@ -1015,6 +1023,8 @@ static const struct komeda_component_funcs d71_merger_funcs = {
>  static int d71_merger_init(struct d71_dev *d71,
>  			   struct block_header *blk, u32 __iomem *reg)
>  {
> +	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
> +	struct drm_device *drm = &kms->base;
>  	struct komeda_component *c;
>  	struct komeda_merger *merger;
>  	u32 pipe_id, comp_id;
> @@ -1030,7 +1040,7 @@ static int d71_merger_init(struct d71_dev *d71,
>  				 "CU%d_MERGER", pipe_id);
>  
>  	if (IS_ERR(c)) {
> -		DRM_ERROR("Failed to initialize merger.\n");
> +		drm_err(drm, "Failed to initialize merger.\n");
>  		return PTR_ERR(c);
>  	}
>  
> @@ -1126,6 +1136,8 @@ static const struct komeda_component_funcs d71_improc_funcs = {
>  static int d71_improc_init(struct d71_dev *d71,
>  			   struct block_header *blk, u32 __iomem *reg)
>  {
> +	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
> +	struct drm_device *drm = &kms->base;
>  	struct komeda_component *c;
>  	struct komeda_improc *improc;
>  	u32 pipe_id, comp_id, value;
> @@ -1139,7 +1151,7 @@ static int d71_improc_init(struct d71_dev *d71,
>  				 get_valid_inputs(blk),
>  				 IPS_NUM_OUTPUT_IDS, reg, "DOU%d_IPS", pipe_id);
>  	if (IS_ERR(c)) {
> -		DRM_ERROR("Failed to add improc component\n");
> +		drm_err(drm, "Failed to add improc component\n");
>  		return PTR_ERR(c);
>  	}
>  
> @@ -1253,6 +1265,8 @@ static const struct komeda_component_funcs d71_timing_ctrlr_funcs = {
>  static int d71_timing_ctrlr_init(struct d71_dev *d71,
>  				 struct block_header *blk, u32 __iomem *reg)
>  {
> +	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
> +	struct drm_device *drm = &kms->base;
>  	struct komeda_component *c;
>  	struct komeda_timing_ctrlr *ctrlr;
>  	u32 pipe_id, comp_id;
> @@ -1266,7 +1280,7 @@ static int d71_timing_ctrlr_init(struct d71_dev *d71,
>  				 1, BIT(KOMEDA_COMPONENT_IPS0 + pipe_id),
>  				 BS_NUM_OUTPUT_IDS, reg, "DOU%d_BS", pipe_id);
>  	if (IS_ERR(c)) {
> -		DRM_ERROR("Failed to add display_ctrl component\n");
> +		drm_err(drm, "Failed to add display_ctrl component\n");
>  		return PTR_ERR(c);
>  	}
>  
> @@ -1280,6 +1294,8 @@ static int d71_timing_ctrlr_init(struct d71_dev *d71,
>  int d71_probe_block(struct d71_dev *d71,
>  		    struct block_header *blk, u32 __iomem *reg)
>  {
> +	struct komeda_kms_dev *kms = komeda_kms_attach(d71->mdev);
> +	struct drm_device *drm = &kms->base;
>  	struct d71_pipeline *pipe;
>  	int blk_id = BLOCK_INFO_BLK_ID(blk->block_info);
>  
> @@ -1346,8 +1362,8 @@ int d71_probe_block(struct d71_dev *d71,
>  		break;
>  
>  	default:
> -		DRM_ERROR("Unknown block (block_info: 0x%x) is found\n",
> -			  blk->block_info);
> +		drm_err(drm, "Unknown block (block_info: 0x%x) is found\n",
> +			blk->block_info);
>  		err = -EINVAL;
>  		break;
>  	}
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

