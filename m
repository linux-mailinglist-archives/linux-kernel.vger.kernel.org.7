Return-Path: <linux-kernel+bounces-891146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D2CC41F38
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B77734EF59C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656E314A7E;
	Fri,  7 Nov 2025 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mVAKHJnT"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2913148BE;
	Fri,  7 Nov 2025 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558094; cv=none; b=lkMuKYk0HkyZPVEbyJ5dr6/9uKJ03gdm2Lw84oDIoxBMsL3qgHSmLRceWcV+MNf1JIk0RfcncxlHeJEB4+9/gydxNN+qBwYO6zuTIUFXg3pMh6bg/oTg1HV+8cPGLRe93z9t6Yj5JWUblT/0GvQueWfz1jOFhUaCiCB93ZqP0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558094; c=relaxed/simple;
	bh=7puJJp7k1pUN31SftlxdSwkX5r60eraOi6UVLDs0viY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHdrAhrJrCwCz5OZlQDp3tiWlNL5MUtnFOjEqBZAM/B6KF1i0LDze87aWIRgG2UWTvIQz9pA4PfEEnaI4LQyeVhpRYFr8pLG9UhTvH+fmURQOjSfgtYXJb6/DBADrLaFIGHUflIshR3LAyMkMUWqSf8XEqfR/LDF6RiRf6wCm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mVAKHJnT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id E1949C67;
	Sat,  8 Nov 2025 00:26:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762557972;
	bh=7puJJp7k1pUN31SftlxdSwkX5r60eraOi6UVLDs0viY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVAKHJnTiEcxsDrfnz4OXSjxAADFIvxUb5psoFfkB+jals4HV7n8+G2sztMVnQk9F
	 LsGyaflml20tC0LfmmXGZg/o3bS2yShkroaWw1AvTQ1uIND1hN94Hr3pTbLqbiJohL
	 DZpoLz4T5BnleqTyCfZaDLt3+EXzJgIEqAjFg+4w=
Date: Sat, 8 Nov 2025 01:28:02 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Dafna Hirschfeld <dafna@fastmail.com>, Keke Li <keke.li@amlogic.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dan Scally <dan.scally@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Antoine Bouyer <antoine.bouyer@nxp.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 7/8] media: amlogic-c3: Use v4l2-isp for validation
Message-ID: <20251107232802.GJ5558@pendragon.ideasonboard.com>
References: <20251020-extensible-parameters-validation-v8-0-afba4ba7b42d@ideasonboard.com>
 <20251020-extensible-parameters-validation-v8-7-afba4ba7b42d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020-extensible-parameters-validation-v8-7-afba4ba7b42d@ideasonboard.com>

Hi Jacopo,

Thank you for the patch.

On Mon, Oct 20, 2025 at 10:24:53AM +0200, Jacopo Mondi wrote:
> Convert c3-isp-params.c to use the helpers defined in v4l2-isp.h
> to perform validation of a ISP parameters buffer.

s/a ISP/an ISP/

> 
> Reviewed-by: Keke Li <keke.li@amlogic.com>
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> ---
>  drivers/media/platform/amlogic/c3/isp/Kconfig      |   1 +
>  .../media/platform/amlogic/c3/isp/c3-isp-params.c  | 124 +++++----------------
>  2 files changed, 27 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/media/platform/amlogic/c3/isp/Kconfig b/drivers/media/platform/amlogic/c3/isp/Kconfig
> index 02c62a50a5e88eac665e27abf163e5d654faed3f..809208cd7e3aa7ca0821cb07366ec73a47edb278 100644
> --- a/drivers/media/platform/amlogic/c3/isp/Kconfig
> +++ b/drivers/media/platform/amlogic/c3/isp/Kconfig
> @@ -10,6 +10,7 @@ config VIDEO_C3_ISP
>  	select VIDEO_V4L2_SUBDEV_API
>  	select VIDEOBUF2_DMA_CONTIG
>  	select VIDEOBUF2_VMALLOC
> +	select V4L2_ISP
>  	help
>  	  Video4Linux2 driver for Amlogic C3 ISP pipeline.
>  	  The C3 ISP is used for processing raw images and
> diff --git a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
> index c80667dd766210d2b2e1ee60c8254a5814b9d81b..0e031d64de312cfdf0a52a46f70edbaf07563359 100644
> --- a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
> +++ b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
> @@ -8,6 +8,7 @@
>  #include <linux/pm_runtime.h>
>  
>  #include <media/v4l2-ioctl.h>
> +#include <media/v4l2-isp.h>
>  #include <media/v4l2-mc.h>
>  #include <media/videobuf2-vmalloc.h>
>  
> @@ -51,11 +52,6 @@ union c3_isp_params_block {
>  typedef void (*c3_isp_block_handler)(struct c3_isp_device *isp,
>  				     const union c3_isp_params_block *block);
>  
> -struct c3_isp_params_handler {
> -	size_t size;
> -	c3_isp_block_handler handler;
> -};
> -
>  #define to_c3_isp_params_buffer(vbuf) \
>  	container_of(vbuf, struct c3_isp_params_buffer, vb)
>  
> @@ -523,38 +519,41 @@ static void c3_isp_params_cfg_blc(struct c3_isp_device *isp,
>  				   ISP_TOP_BEO_CTRL_BLC_EN);
>  }
>  
> -static const struct c3_isp_params_handler c3_isp_params_handlers[] = {
> +static const c3_isp_block_handler c3_isp_params_handlers[] = {
> +	[C3_ISP_PARAMS_BLOCK_AWB_GAINS] = c3_isp_params_cfg_awb_gains,
> +	[C3_ISP_PARAMS_BLOCK_AWB_CONFIG] = c3_isp_params_cfg_awb_config,
> +	[C3_ISP_PARAMS_BLOCK_AE_CONFIG] = c3_isp_params_cfg_ae_config,
> +	[C3_ISP_PARAMS_BLOCK_AF_CONFIG] = c3_isp_params_cfg_af_config,
> +	[C3_ISP_PARAMS_BLOCK_PST_GAMMA] = c3_isp_params_cfg_pst_gamma,
> +	[C3_ISP_PARAMS_BLOCK_CCM] = c3_isp_params_cfg_ccm,
> +	[C3_ISP_PARAMS_BLOCK_CSC] = c3_isp_params_cfg_csc,
> +	[C3_ISP_PARAMS_BLOCK_BLC] = c3_isp_params_cfg_blc,
> +};
> +
> +static const struct v4l2_isp_params_block_info c3_isp_params_blocks_info[] = {
>  	[C3_ISP_PARAMS_BLOCK_AWB_GAINS] = {
>  		.size = sizeof(struct c3_isp_params_awb_gains),
> -		.handler = c3_isp_params_cfg_awb_gains,
>  	},
>  	[C3_ISP_PARAMS_BLOCK_AWB_CONFIG] = {
>  		.size = sizeof(struct c3_isp_params_awb_config),
> -		.handler = c3_isp_params_cfg_awb_config,
>  	},
>  	[C3_ISP_PARAMS_BLOCK_AE_CONFIG] = {
>  		.size = sizeof(struct c3_isp_params_ae_config),
> -		.handler = c3_isp_params_cfg_ae_config,
>  	},
>  	[C3_ISP_PARAMS_BLOCK_AF_CONFIG] = {
>  		.size = sizeof(struct c3_isp_params_af_config),
> -		.handler = c3_isp_params_cfg_af_config,
>  	},
>  	[C3_ISP_PARAMS_BLOCK_PST_GAMMA] = {
>  		.size = sizeof(struct c3_isp_params_pst_gamma),
> -		.handler = c3_isp_params_cfg_pst_gamma,
>  	},
>  	[C3_ISP_PARAMS_BLOCK_CCM] = {
>  		.size = sizeof(struct c3_isp_params_ccm),
> -		.handler = c3_isp_params_cfg_ccm,
>  	},
>  	[C3_ISP_PARAMS_BLOCK_CSC] = {
>  		.size = sizeof(struct c3_isp_params_csc),
> -		.handler = c3_isp_params_cfg_csc,
>  	},
>  	[C3_ISP_PARAMS_BLOCK_BLC] = {
>  		.size = sizeof(struct c3_isp_params_blc),
> -		.handler = c3_isp_params_cfg_blc,
>  	},
>  };

Same comment as with 6/8.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>  
> @@ -568,14 +567,14 @@ static void c3_isp_params_cfg_blocks(struct c3_isp_params *params)
>  
>  	/* Walk the list of parameter blocks and process them */
>  	while (block_offset < config->data_size) {
> -		const struct c3_isp_params_handler *block_handler;
>  		const union c3_isp_params_block *block;
> +		c3_isp_block_handler block_handler;
>  
>  		block = (const union c3_isp_params_block *)
>  			 &config->data[block_offset];
>  
> -		block_handler = &c3_isp_params_handlers[block->header.type];
> -		block_handler->handler(params->isp, block);
> +		block_handler = c3_isp_params_handlers[block->header.type];
> +		block_handler(params->isp, block);
>  
>  		block_offset += block->header.size;
>  	}
> @@ -771,26 +770,15 @@ static int c3_isp_params_vb2_buf_prepare(struct vb2_buffer *vb)
>  	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>  	struct c3_isp_params_buffer *buf = to_c3_isp_params_buffer(vbuf);
>  	struct c3_isp_params *params = vb2_get_drv_priv(vb->vb2_queue);
> -	struct c3_isp_params_cfg *cfg = buf->cfg;
>  	struct c3_isp_params_cfg *usr_cfg = vb2_plane_vaddr(vb, 0);
>  	size_t payload_size = vb2_get_plane_payload(vb, 0);
> -	size_t header_size = offsetof(struct c3_isp_params_cfg, data);
> -	size_t block_offset = 0;
> -	size_t cfg_size;
> -
> -	/* Payload size can't be greater than the destination buffer size */
> -	if (payload_size > params->vfmt.fmt.meta.buffersize) {
> -		dev_dbg(params->isp->dev,
> -			"Payload size is too large: %zu\n", payload_size);
> -		return -EINVAL;
> -	}
> +	struct c3_isp_params_cfg *cfg = buf->cfg;
> +	int ret;
>  
> -	/* Payload size can't be smaller than the header size */
> -	if (payload_size < header_size) {
> -		dev_dbg(params->isp->dev,
> -			"Payload size is too small: %zu\n", payload_size);
> -		return -EINVAL;
> -	}
> +	ret = v4l2_isp_params_validate_buffer_size(params->isp->dev, vb,
> +						   params->vfmt.fmt.meta.buffersize);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * Use the internal scratch buffer to avoid userspace modifying
> @@ -798,70 +786,10 @@ static int c3_isp_params_vb2_buf_prepare(struct vb2_buffer *vb)
>  	 */
>  	memcpy(cfg, usr_cfg, payload_size);
>  
> -	/* Only v0 is supported at the moment */
> -	if (cfg->version != C3_ISP_PARAMS_BUFFER_V0) {
> -		dev_dbg(params->isp->dev,
> -			"Invalid params buffer version: %u\n", cfg->version);
> -		return -EINVAL;
> -	}
> -
> -	/* Validate the size reported in the parameter buffer header */
> -	cfg_size = header_size + cfg->data_size;
> -	if (cfg_size != payload_size) {
> -		dev_dbg(params->isp->dev,
> -			"Data size %zu and payload size %zu are different\n",
> -			cfg_size, payload_size);
> -		return -EINVAL;
> -	}
> -
> -	/* Walk the list of parameter blocks and validate them */
> -	cfg_size = cfg->data_size;
> -	while (cfg_size >= sizeof(struct c3_isp_params_block_header)) {
> -		const struct c3_isp_params_block_header *block;
> -		const struct c3_isp_params_handler *handler;
> -
> -		block = (struct c3_isp_params_block_header *)
> -			&cfg->data[block_offset];
> -
> -		if (block->type >= ARRAY_SIZE(c3_isp_params_handlers)) {
> -			dev_dbg(params->isp->dev,
> -				"Invalid params block type\n");
> -			return -EINVAL;
> -		}
> -
> -		if (block->size > cfg_size) {
> -			dev_dbg(params->isp->dev,
> -				"Block size is greater than cfg size\n");
> -			return -EINVAL;
> -		}
> -
> -		if ((block->flags & (C3_ISP_PARAMS_BLOCK_FL_ENABLE |
> -				     C3_ISP_PARAMS_BLOCK_FL_DISABLE)) ==
> -		    (C3_ISP_PARAMS_BLOCK_FL_ENABLE |
> -		     C3_ISP_PARAMS_BLOCK_FL_DISABLE)) {
> -			dev_dbg(params->isp->dev,
> -				"Invalid parameters block flags\n");
> -			return -EINVAL;
> -		}
> -
> -		handler = &c3_isp_params_handlers[block->type];
> -		if (block->size != handler->size) {
> -			dev_dbg(params->isp->dev,
> -				"Invalid params block size\n");
> -			return -EINVAL;
> -		}
> -
> -		block_offset += block->size;
> -		cfg_size -= block->size;
> -	}
> -
> -	if (cfg_size) {
> -		dev_dbg(params->isp->dev,
> -			"Unexpected data after the params buffer end\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> +	return v4l2_isp_params_validate_buffer(params->isp->dev, vb,
> +					(struct v4l2_isp_params_buffer *)cfg,
> +					c3_isp_params_blocks_info,
> +					ARRAY_SIZE(c3_isp_params_blocks_info));
>  }
>  
>  static int c3_isp_params_vb2_buf_init(struct vb2_buffer *vb)

-- 
Regards,

Laurent Pinchart

