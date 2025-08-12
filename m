Return-Path: <linux-kernel+bounces-764654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23EB225A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BBA566545
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692722ECEAC;
	Tue, 12 Aug 2025 11:12:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DCC2ECE8D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997165; cv=none; b=C637q+//fdHYb5aDdjjLONNdu3kDj4D8slINJA4PKsk7FtGyTee7CipiuqV31m3bBs/qWN/sobL35WmqPOdNiHK2wYj5bFD+ZocwkFOBpEPsof0MqCbN2qLQQudhelFalalOAXd0q2WHBPgniAE5MqmR2U5A9OZ2UgxJc9BKqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997165; c=relaxed/simple;
	bh=h9grR5wNq7vSsNhyWI964PPq2sKRTwXkKnK7shMCfxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0lEsteilzEnBqfCZrlvqWNblbNJUTSU5QdXCwrVgaQh4oYZ389+ups1xyFiYI/BaGsS5Cr59MxuGZU8CY4yhAeuC/rImvP6FPm0VyHuKBtdI769jFiM2elUjRJRjquhByySB0ICf//WKH7BSn2FmQupqUaDrc3KJj+bs9PJDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55D9425E1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:12:35 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C43F3F63F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:12:43 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:12:34 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Rahul Kumar <rk0006818@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH] drm/komeda: Convert logging in komeda_crtc.c to drm_*
 with drm_device parameter
Message-ID: <aJshoswGslcYQFLI@e110455-lin.cambridge.arm.com>
References: <20250812101119.2506-1-rk0006818@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250812101119.2506-1-rk0006818@gmail.com>

On Tue, Aug 12, 2025 at 03:41:19PM +0530, Rahul Kumar wrote:
> Replace all dev_err(), dev_warn(), dev_info() and DRM_ERROR/WARN/INFO()
> calls in drivers/gpu/drm/arm/display/komeda/komeda_crtc.c with the
> corresponding drm_err(), drm_warn(), and drm_info() helpers.
> 
> The new drm_*() logging functions take a struct drm_device * as the
> first argument. This allows the DRM core to prefix log messages with
> the specific DRM device name and instance, which is essential for
> distinguishing logs when multiple GPUs or display controllers are present.
> 
> This change aligns komeda with the DRM TODO item: "Convert logging to
> drm_* functions with drm_device parameter".
> 
> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

For future patches, when you make changes, please generate them with

git patch -v<version>

and include a change log so that reviewers can quickly figure out what
has changed between emails without having to go back and forth.

Best regards,
Liviu

> ---
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 27 +++++++++++--------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 2ad33559a33a..e4cc1fb34e94 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -111,6 +111,7 @@ komeda_crtc_atomic_check(struct drm_crtc *crtc,
>  static int
>  komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>  {
> +	struct drm_device *drm = kcrtc->base.dev;
>  	struct komeda_dev *mdev = kcrtc->base.dev->dev_private;
>  	struct komeda_pipeline *master = kcrtc->master;
>  	struct komeda_crtc_state *kcrtc_st = to_kcrtc_st(kcrtc->base.state);
> @@ -128,7 +129,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>  
>  	err = mdev->funcs->change_opmode(mdev, new_mode);
>  	if (err) {
> -		DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
> +		drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,",
>  			  mdev->dpmode, new_mode);
>  		goto unlock;
>  	}
> @@ -142,18 +143,18 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>  	if (new_mode != KOMEDA_MODE_DUAL_DISP) {
>  		err = clk_set_rate(mdev->aclk, komeda_crtc_get_aclk(kcrtc_st));
>  		if (err)
> -			DRM_ERROR("failed to set aclk.\n");
> +			drm_err(drm, "failed to set aclk.\n");
>  		err = clk_prepare_enable(mdev->aclk);
>  		if (err)
> -			DRM_ERROR("failed to enable aclk.\n");
> +			drm_err(drm, "failed to enable aclk.\n");
>  	}
>  
>  	err = clk_set_rate(master->pxlclk, mode->crtc_clock * 1000);
>  	if (err)
> -		DRM_ERROR("failed to set pxlclk for pipe%d\n", master->id);
> +		drm_err(drm, "failed to set pxlclk for pipe%d\n", master->id);
>  	err = clk_prepare_enable(master->pxlclk);
>  	if (err)
> -		DRM_ERROR("failed to enable pxl clk for pipe%d.\n", master->id);
> +		drm_err(drm, "failed to enable pxl clk for pipe%d.\n", master->id);
>  
>  unlock:
>  	mutex_unlock(&mdev->lock);
> @@ -164,6 +165,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>  static int
>  komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
>  {
> +	struct drm_device *drm = kcrtc->base.dev;
>  	struct komeda_dev *mdev = kcrtc->base.dev->dev_private;
>  	struct komeda_pipeline *master = kcrtc->master;
>  	u32 new_mode;
> @@ -180,7 +182,7 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
>  
>  	err = mdev->funcs->change_opmode(mdev, new_mode);
>  	if (err) {
> -		DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
> +		drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,",
>  			  mdev->dpmode, new_mode);
>  		goto unlock;
>  	}
> @@ -200,6 +202,7 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
>  void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
>  			      struct komeda_events *evts)
>  {
> +	struct drm_device *drm = kcrtc->base.dev;
>  	struct drm_crtc *crtc = &kcrtc->base;
>  	u32 events = evts->pipes[kcrtc->master->id];
>  
> @@ -212,7 +215,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
>  		if (wb_conn)
>  			drm_writeback_signal_completion(&wb_conn->base, 0);
>  		else
> -			DRM_WARN("CRTC[%d]: EOW happen but no wb_connector.\n",
> +			drm_warn(drm, "CRTC[%d]: EOW happen but no wb_connector.\n",
>  				 drm_crtc_index(&kcrtc->base));
>  	}
>  	/* will handle it together with the write back support */
> @@ -236,7 +239,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
>  			crtc->state->event = NULL;
>  			drm_crtc_send_vblank_event(crtc, event);
>  		} else {
> -			DRM_WARN("CRTC[%d]: FLIP happened but no pending commit.\n",
> +			drm_warn(drm, "CRTC[%d]: FLIP happened but no pending commit.\n",
>  				 drm_crtc_index(&kcrtc->base));
>  		}
>  		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> @@ -309,7 +312,7 @@ komeda_crtc_flush_and_wait_for_flip_done(struct komeda_crtc *kcrtc,
>  
>  	/* wait the flip take affect.*/
>  	if (wait_for_completion_timeout(flip_done, HZ) == 0) {
> -		DRM_ERROR("wait pipe%d flip done timeout\n", kcrtc->master->id);
> +		drm_err(drm, "wait pipe%d flip done timeout\n", kcrtc->master->id);
>  		if (!input_flip_done) {
>  			unsigned long flags;
>  
> @@ -562,6 +565,7 @@ static const struct drm_crtc_funcs komeda_crtc_funcs = {
>  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
>  			   struct komeda_dev *mdev)
>  {
> +	struct drm_device *drm = &kms->base;
>  	struct komeda_crtc *crtc;
>  	struct komeda_pipeline *master;
>  	char str[16];
> @@ -581,7 +585,7 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
>  		else
>  			sprintf(str, "None");
>  
> -		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
> +		drm_info(drm, "CRTC-%d: master(pipe-%d) slave(%s).\n",
>  			 kms->n_crtcs, master->id, str);
>  
>  		kms->n_crtcs++;
> @@ -613,6 +617,7 @@ static int komeda_attach_bridge(struct device *dev,
>  				struct komeda_pipeline *pipe,
>  				struct drm_encoder *encoder)
>  {
> +	struct drm_device *drm = encoder->dev;
>  	struct drm_bridge *bridge;
>  	int err;
>  
> @@ -624,7 +629,7 @@ static int komeda_attach_bridge(struct device *dev,
>  
>  	err = drm_bridge_attach(encoder, bridge, NULL, 0);
>  	if (err)
> -		dev_err(dev, "bridge_attach() failed for pipe: %s\n",
> +		drm_err(drm, "bridge_attach() failed for pipe: %s\n",
>  			of_node_full_name(pipe->of_node));
>  
>  	return err;
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

