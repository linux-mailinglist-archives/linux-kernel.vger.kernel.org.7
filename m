Return-Path: <linux-kernel+bounces-898865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1CC562DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F533ABD97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DDC322768;
	Thu, 13 Nov 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="lSElVo+/";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="eEms2L9p"
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4D32ED2F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021527; cv=none; b=gLsLmx1E/F3Yrl0sGUdJbtQAJafO0Tm3qVmmme1N+H+4aUA7WHsBYgB+dWy4D1Qvo/IPZyy+LSu+D9ggTvBbYmjHGjF3NveAu853/ODk6RSX5p/sM5w9vG3jifwn0W6fgV+cmN1+aVSS3sluk+JyWICp1pxqnVL+S0RL0J96JI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021527; c=relaxed/simple;
	bh=+DM5MFB+QWB5E+8IqCXTM9sKzwOVYlEeQw5XCQrjAcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqtjY4Uvfm8nFUDMYrYHBKXDycbJCKKz+iMqeimBFgBXlPdcc62D6lAE277QjjaY8ytKE6Y9Qx7w0uPK3AFhSnnYppoO6YOs3Vj7SSHvm/i2q5x8uaVMDavc4wt/YF/SEBmTaODgfpvMGM/2EGlMRqw7fCEDe5k1TvY/lwlFhtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=lSElVo+/; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=eEms2L9p; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1763021517; bh=UQ0Zawjrn6mGPTbD3atXc93
	18us47Y+fSjJpkoi/xlM=; b=lSElVo+/j2SKfOktwAsi3WPLJIwtof0o/I7lLv/poZnDTK4pFi
	NZEBQZL2WjoJSQVR4ddTbj09UwcdrTckOeVLCnCNIfuU4K0lhWvyHt9g3JE4T40TAwWeqCiEoPI
	E9lA8X4jDPrP3slLGINsO7TdKdPDZyewIDTc4JtFL0lf0e6CsocahjaewC6pt+NdUnPDnCm7xAo
	pGPVngAJGoV1QjxXbo94lh1b8OsxEbysamhm19Cwwx5aj7rUf6REXOj4IkObkWYWCBeQPlbOBrc
	ErWtw7wo+lGTdkV0tNnh84/airRtlbPMWUew6BLiGbA96prWQKzeAesWrAdIcZ4cYnA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1763021517; bh=UQ0Zawjrn6mGPTbD3atXc93
	18us47Y+fSjJpkoi/xlM=; b=eEms2L9pNlEDACbD68HMjauy0sB1F9d5hpzgOJhFLgyDMceV64
	+16i95/KtOYh93iiP0tsgO+/Zwl0FlxIufAg==;
Date: Thu, 13 Nov 2025 15:11:52 +0700
From: Dang Huynh <dang.huynh@mainlining.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, diederik@cknow-tech.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] drm/rockchip: vop2: Use OVL_LAYER_SEL configuration
 instead of use win_mask calculate used layers
Message-ID: <hrg6geclph37olvqr3o5v4d4mifvl25kaemh7f2z3hwega7h2b@muf2gkfqzvvz>
References: <20251112085024.2480111-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112085024.2480111-1-andyshrk@163.com>

Hi Andy,

This fix works on my device. No more black box around the cursor.

Tested-by: Dang Huynh <dang.huynh@mainlining.org>

On Wed, Nov 12, 2025 at 04:50:23PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> When there are multiple Video Ports, and only one of them is working
> (for example, VP1 is working while VP0 is not), in this case, the
> win_mask of VP0 is 0. However, we have already set the port mux for VP0
> according to vp0->nlayers, and at the same time, in the OVL_LAYER_SEL
> register, there are windows will also be assigned to layers which will
> map to the inactive VPs. In this situation, vp0->win_mask is zero as it
> now working, it is more reliable to calculate the used layers based on
> the configuration of the OVL_LAYER_SEL register.
> 
> Note: as the configuration of OVL_LAYER_SEL is take effect when the
> vsync is come, so we use the value backup in vop2->old_layer_sel instead
> of read OVL_LAYER_SEL directly.
> 
> Fixes: 3e89a8c68354 ("drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568")
> Reported-by: Diederik de Haas <diederik@cknow-tech.com>
> Closes: https://bugs.kde.org/show_bug.cgi?id=511274
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 49 +++++++++++++++++---
>  1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index d22ce11a4235..f3950e8476a7 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -1369,6 +1369,25 @@ static const struct vop2_regs_dump rk3588_regs_dump[] = {
>  	},
>  };
>  
> +/*
> + * phys_id is used to identify a main window(Cluster Win/Smart Win, not
> + * include the sub win of a cluster or the multi area) that can do overlay
> + * in main overlay stage.
> + */
> +static struct vop2_win *vop2_find_win_by_phys_id(struct vop2 *vop2, uint8_t phys_id)
> +{
> +	struct vop2_win *win;
> +	int i;
> +
> +	for (i = 0; i < vop2->data->win_size; i++) {
> +		win = &vop2->win[i];
> +		if (win->data->phys_id == phys_id)
> +			return win;
> +	}
> +
> +	return NULL;
> +}
> +
>  static unsigned long rk3568_set_intf_mux(struct vop2_video_port *vp, int id, u32 polflags)
>  {
>  	struct vop2 *vop2 = vp->vop2;
> @@ -1842,15 +1861,31 @@ static void vop2_parse_alpha(struct vop2_alpha_config *alpha_config,
>  	alpha->dst_alpha_ctrl.bits.factor_mode = ALPHA_SRC_INVERSE;
>  }
>  
> -static int vop2_find_start_mixer_id_for_vp(struct vop2 *vop2, u8 port_id)
> +static int vop2_find_start_mixer_id_for_vp(struct vop2_video_port *vp)
>  {
> -	struct vop2_video_port *vp;
> -	int used_layer = 0;
> +	struct vop2 *vop2 = vp->vop2;
> +	struct vop2_win *win;
> +	u32 layer_sel = vop2->old_layer_sel;
> +	u32 used_layer = 0;
> +	unsigned long win_mask = vp->win_mask;
> +	unsigned long phys_id;
> +	bool match;
>  	int i;
>  
> -	for (i = 0; i < port_id; i++) {
> -		vp = &vop2->vps[i];
> -		used_layer += hweight32(vp->win_mask);
> +	for (i = 0; i < 31; i += 4) {
> +		match = false;
> +		for_each_set_bit(phys_id, &win_mask, ROCKCHIP_VOP2_ESMART3) {
> +			win = vop2_find_win_by_phys_id(vop2, phys_id);
> +			if (win->data->layer_sel_id[vp->id] == ((layer_sel >> i) & 0xf)) {
> +				match = true;
> +				break;
> +			}
> +		}
> +
> +		if (!match)
> +			used_layer += 1;
> +		else
> +			break;
>  	}
>  
>  	return used_layer;
> @@ -1935,7 +1970,7 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
>  	u32 dst_global_alpha = DRM_BLEND_ALPHA_OPAQUE;
>  
>  	if (vop2->version <= VOP_VERSION_RK3588)
> -		mixer_id = vop2_find_start_mixer_id_for_vp(vop2, vp->id);
> +		mixer_id = vop2_find_start_mixer_id_for_vp(vp);
>  	else
>  		mixer_id = 0;
>  
> -- 
> 2.43.0
> 
> base-commit: ded94ec6167e84195507237100f6278941e36fdd
> branch: drm-misc-next-2025-1016
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

