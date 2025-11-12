Return-Path: <linux-kernel+bounces-897274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421F2C527E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997DE3AFB97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F40337BAE;
	Wed, 12 Nov 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="FUj2SeR3"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765425A640
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953835; cv=none; b=PjXJJdzT+4tGa1zyQv0+SsNG5inwVWcjT/WOe2z+8hz1Wt1vKnknr7K1Eahnmbn+bZlrm8Ng+8PKga2LgVBhUe8uciDrPHqjp7L5UgUJ8gSqckwkR5Ema3DHgs497AgvyImF1y3jlQkk1YKjiGKtDe8AojV+0qE3Kn11eIiXVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953835; c=relaxed/simple;
	bh=ryAI02Zk6l+eJO/YP6ylxtEesQOzInyaFJEqJs0HycI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=uI3oPZ2VGYvGFOMMH5dKeayTd9HTuoPv0hRDVCqKyEkZa6uhTBNn7Kshck7AE8IvU9I2e53e0sTtbMZtBbgTeEUdDFp1aZnJYhRxlsbyokYjmMjpFo/fOL18yFM0fxLTmKp2BhuwBaGaaxMRugNrocfnlGSoyzuuLV+2yc83O0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=FUj2SeR3; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762953831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPEMzOztpJUvojsoCi0pzhR593btKmY4mmBboMedZFk=;
	b=FUj2SeR3Zs+ZRsouks+uTMRzsGS/+tSLpSv253fR3UUjDL+BQ2S3m34Yh0dI7DCEZI7Cfu
	55dAosTlW4PwMF/bGCNfazJAgDxKDz1/Il8+5JSJ3O0vfxl2CFzZuf2YOTPFJi3GCSeUvX
	mJy2TTAxM593CxFrMyJbdyuKlCumHyAaHFJqlDw7SXhj54fcFzCcX2zRx6aUDOIwpI6ULo
	bQ4aYDtlnPjSnv87GRO4e0QfCf8vPmrfw2jNGOEZFuE/syUzmA7B+lfpsIcits0RLGdQM2
	MtRYv/ZXy837jnNB7kpR78SlcKgjvquiQDGJmXLH0n+2VW1X5ys7euxSSsrBUg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Nov 2025 14:23:49 +0100
Message-Id: <DE6QZ4EILEX2.1MQSX07ZMQLCW@cknow-tech.com>
To: "Andy Yan" <andyshrk@163.com>, <heiko@sntech.de>
Cc: <hjc@rock-chips.com>, <diederik@cknow-tech.com>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>, "Andy
 Yan" <andy.yan@rock-chips.com>
Subject: Re: [PATCH] drm/rockchip: vop2: Use OVL_LAYER_SEL configuration
 instead of use win_mask calculate used layers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
References: <20251112085024.2480111-1-andyshrk@163.com>
In-Reply-To: <20251112085024.2480111-1-andyshrk@163.com>
X-Migadu-Flow: FLOW_OUT

Hi Andy,

On Wed Nov 12, 2025 at 9:50 AM CET, Andy Yan wrote:
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

Thanks a lot for this patch!
I've tested it on my PineTab2 and the 'black box under cursor' problem
is now fixed :-) So feel free to add my

Tested-by: Diederik de Haas <diederik@cknow-tech.com>

Cheers,
  Diederik

> Note: as the configuration of OVL_LAYER_SEL is take effect when the
> vsync is come, so we use the value backup in vop2->old_layer_sel instead
> of read OVL_LAYER_SEL directly.
>
> Fixes: 3e89a8c68354 ("drm/rockchip: vop2: Fix the update of LAYER/PORT se=
lect registers when there are multi display output on rk3588/rk3568")
> Reported-by: Diederik de Haas <diederik@cknow-tech.com>
> Closes: https://bugs.kde.org/show_bug.cgi?id=3D511274
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
>
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 49 +++++++++++++++++---
>  1 file changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/d=
rm/rockchip/rockchip_vop2_reg.c
> index d22ce11a4235..f3950e8476a7 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -1369,6 +1369,25 @@ static const struct vop2_regs_dump rk3588_regs_dum=
p[] =3D {
>  	},
>  };
> =20
> +/*
> + * phys_id is used to identify a main window(Cluster Win/Smart Win, not
> + * include the sub win of a cluster or the multi area) that can do overl=
ay
> + * in main overlay stage.
> + */
> +static struct vop2_win *vop2_find_win_by_phys_id(struct vop2 *vop2, uint=
8_t phys_id)
> +{
> +	struct vop2_win *win;
> +	int i;
> +
> +	for (i =3D 0; i < vop2->data->win_size; i++) {
> +		win =3D &vop2->win[i];
> +		if (win->data->phys_id =3D=3D phys_id)
> +			return win;
> +	}
> +
> +	return NULL;
> +}
> +
>  static unsigned long rk3568_set_intf_mux(struct vop2_video_port *vp, int=
 id, u32 polflags)
>  {
>  	struct vop2 *vop2 =3D vp->vop2;
> @@ -1842,15 +1861,31 @@ static void vop2_parse_alpha(struct vop2_alpha_co=
nfig *alpha_config,
>  	alpha->dst_alpha_ctrl.bits.factor_mode =3D ALPHA_SRC_INVERSE;
>  }
> =20
> -static int vop2_find_start_mixer_id_for_vp(struct vop2 *vop2, u8 port_id=
)
> +static int vop2_find_start_mixer_id_for_vp(struct vop2_video_port *vp)
>  {
> -	struct vop2_video_port *vp;
> -	int used_layer =3D 0;
> +	struct vop2 *vop2 =3D vp->vop2;
> +	struct vop2_win *win;
> +	u32 layer_sel =3D vop2->old_layer_sel;
> +	u32 used_layer =3D 0;
> +	unsigned long win_mask =3D vp->win_mask;
> +	unsigned long phys_id;
> +	bool match;
>  	int i;
> =20
> -	for (i =3D 0; i < port_id; i++) {
> -		vp =3D &vop2->vps[i];
> -		used_layer +=3D hweight32(vp->win_mask);
> +	for (i =3D 0; i < 31; i +=3D 4) {
> +		match =3D false;
> +		for_each_set_bit(phys_id, &win_mask, ROCKCHIP_VOP2_ESMART3) {
> +			win =3D vop2_find_win_by_phys_id(vop2, phys_id);
> +			if (win->data->layer_sel_id[vp->id] =3D=3D ((layer_sel >> i) & 0xf)) =
{
> +				match =3D true;
> +				break;
> +			}
> +		}
> +
> +		if (!match)
> +			used_layer +=3D 1;
> +		else
> +			break;
>  	}
> =20
>  	return used_layer;
> @@ -1935,7 +1970,7 @@ static void vop2_setup_alpha(struct vop2_video_port=
 *vp)
>  	u32 dst_global_alpha =3D DRM_BLEND_ALPHA_OPAQUE;
> =20
>  	if (vop2->version <=3D VOP_VERSION_RK3588)
> -		mixer_id =3D vop2_find_start_mixer_id_for_vp(vop2, vp->id);
> +		mixer_id =3D vop2_find_start_mixer_id_for_vp(vp);
>  	else
>  		mixer_id =3D 0;
> =20


