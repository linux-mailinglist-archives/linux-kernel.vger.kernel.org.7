Return-Path: <linux-kernel+bounces-782511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F8AB32169
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE47B1D62D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520052820C7;
	Fri, 22 Aug 2025 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsKQAFhx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACA1096F;
	Fri, 22 Aug 2025 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883192; cv=none; b=W3yYWW7jS3LmtilXZfXvAeWC+DJW9p0/DzILJ8TTBY2iY4C+PB3wURJPmE7UCOvUzk3LGUrUQ/ilfo8d2YeVPIFwu7O+jXa6za46br060XVkdMwe8CazlPjvYW/VPCVX1fVs6Q+dZL/UZpMnRxAxFeIKG/ONkI0bgt1Lc6XUljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883192; c=relaxed/simple;
	bh=L7VZUdX3MLspbO+BuCJOeSCnsEFhb0f9Kl8vZtDysSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drdztylgrJvpovhdy1ti8lTQO+3XkpXOuEkDVBwOwRglPOl+4bJTxxGm52e4b2b8BTm6jtf/a2PuJorBotYDiOH85M/fVviHS+X9vggU+6c2UL/opi6xDBR0SFzz6u6BHdzItipqMFRxg2Q1wYGWKa7nPEuH2y7jcvbOlj0bXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsKQAFhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BA0C4CEED;
	Fri, 22 Aug 2025 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755883192;
	bh=L7VZUdX3MLspbO+BuCJOeSCnsEFhb0f9Kl8vZtDysSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsKQAFhxdGePNlkVD4aEm20sTIPjMYYfRa6stb19nSTj9HjxHmB9goFCBQ92LmWew
	 X62qmO8SQICVukO3DyipX380hqA3IHaKf6ZQbymLkikdit4oohE7wNEBatKmhToLqp
	 sKYWiY4ty2IdRGPQBOx3ISVrCwxBjyr3DQeKcuSWy/FfHOZ/B5gV5mLVzBOrKf0gIT
	 PuILVn3n7Wr+Z1axv+T3JTzh1qwp3Vd1NRa49yHmB5yrrUNsnVoAbcVIbMA7X1/0+F
	 3ScSpZjtIo9xgr6SI4kulLAH/F0oCugR0cukDQne76w3rCAFPRrvy9xsNdZL/Dzx6z
	 MMUwh0vaHlfCg==
Date: Fri, 22 Aug 2025 22:49:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vivek.Pernamitta@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vivek Pernamitta <quic_vpernami@quicinc.com>
Subject: Re: [PATCH] bus: mhi: host: Add uevent support in MHI driver
Message-ID: <6g32g3zqzsdoo3h6d232jbtatp34tm3s5m6huc37h5sfir2bnf@syyou6tqyuxy>
References: <20250822-uevent_vdev_next-20250821-v1-1-9ed3a8162194@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822-uevent_vdev_next-20250821-v1-1-9ed3a8162194@quicinc.com>

On Fri, Aug 22, 2025 at 10:22:03AM GMT, Vivek.Pernamitta@quicinc.com wrote:
> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
> 
> Notify the MHI device's Execution Environment (EE) state via uevent,
> enabling applications to receive real-time updates and take appropriate
> actions based on the current state of MHI.
> 
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> ---
> Notify the MHI device's Execution Environment (EE) state via uevent,
> enabling applications to receive real-time updates and take appropriate
> actions based on the current state.
> 
> Signed-off-by:
> ---
> Usage:
> 
> Enabling 16 virtual fucntions for SRIOV device QDU100 once device reached
> mission mode from systemd service file
> 
> SUBSYSTEM=="mhi", ENV{EXEC_ENV}=="MISSION MODE", SUBSYSTEMS=="pci", ATTRS{device}=="0x0601",ATTR{../sriov_numvfs}="16"
> ---
> 
> ---
>  drivers/bus/mhi/host/internal.h |  1 +
>  drivers/bus/mhi/host/main.c     |  1 +
>  drivers/bus/mhi/host/pm.c       | 22 ++++++++++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 034be33565b78eff9bdefd93faa4f3ce93825bad..d455f0bf00133775fa23882a727782275640e43b 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -403,6 +403,7 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  				struct mhi_event *mhi_event, u32 event_quota);
>  int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  			     struct mhi_event *mhi_event, u32 event_quota);
> +void mhi_uevent_notify(struct mhi_controller *mhi_cntrl, enum mhi_ee_type ee);
>  
>  /* ISR handlers */
>  irqreturn_t mhi_irq_handler(int irq_number, void *dev);
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 52bef663e182de157e50f64c1764a52545c70865..8615512743199a59a58c3756d9cc3407079cee7e 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -512,6 +512,7 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>  		if (mhi_cntrl->rddm_image && mhi_is_active(mhi_cntrl)) {
>  			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
>  			mhi_cntrl->ee = ee;
> +			mhi_uevent_notify(mhi_cntrl, mhi_cntrl->ee);
>  			wake_up_all(&mhi_cntrl->state_event);
>  		}
>  		break;
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 33d92bf2fc3ed48db5f7fe80e4f0ef9fe2d2f2ab..1b849f334c49e52636821ed7587865a9254e9118 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -418,6 +418,7 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
>  	device_for_each_child(&mhi_cntrl->mhi_dev->dev, &current_ee,
>  			      mhi_destroy_device);
>  	mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_MISSION_MODE);
> +	mhi_uevent_notify(mhi_cntrl, mhi_cntrl->ee);
>  
>  	/* Force MHI to be in M0 state before continuing */
>  	ret = __mhi_device_get_sync(mhi_cntrl);
> @@ -631,6 +632,8 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
>  	/* Wake up threads waiting for state transition */
>  	wake_up_all(&mhi_cntrl->state_event);
>  
> +	mhi_uevent_notify(mhi_cntrl, mhi_cntrl->ee);
> +
>  	if (MHI_REG_ACCESS_VALID(prev_state)) {
>  		/*
>  		 * If the device is in PBL or SBL, it will only respond to
> @@ -829,6 +832,8 @@ void mhi_pm_st_worker(struct work_struct *work)
>  			mhi_create_devices(mhi_cntrl);
>  			if (mhi_cntrl->fbc_download)
>  				mhi_download_amss_image(mhi_cntrl);
> +
> +			mhi_uevent_notify(mhi_cntrl, mhi_cntrl->ee);
>  			break;
>  		case DEV_ST_TRANSITION_MISSION_MODE:
>  			mhi_pm_mission_mode_transition(mhi_cntrl);
> @@ -838,6 +843,7 @@ void mhi_pm_st_worker(struct work_struct *work)
>  			mhi_cntrl->ee = MHI_EE_FP;
>  			write_unlock_irq(&mhi_cntrl->pm_lock);
>  			mhi_create_devices(mhi_cntrl);
> +			mhi_uevent_notify(mhi_cntrl, mhi_cntrl->ee);
>  			break;
>  		case DEV_ST_TRANSITION_READY:
>  			mhi_ready_state_transition(mhi_cntrl);
> @@ -1240,6 +1246,8 @@ static void __mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful,
>  	write_unlock_irq(&mhi_cntrl->pm_lock);
>  	mutex_unlock(&mhi_cntrl->pm_mutex);
>  
> +	mhi_uevent_notify(mhi_cntrl, mhi_cntrl->ee);
> +
>  	if (destroy_device)
>  		mhi_queue_state_transition(mhi_cntrl,
>  					   DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE);
> @@ -1338,3 +1346,17 @@ void mhi_device_put(struct mhi_device *mhi_dev)
>  	read_unlock_bh(&mhi_cntrl->pm_lock);
>  }
>  EXPORT_SYMBOL_GPL(mhi_device_put);
> +
> +void mhi_uevent_notify(struct mhi_controller *mhi_cntrl, enum mhi_ee_type ee)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	char *buf[2];
> +	int ret;
> +
> +	buf[0] = kasprintf(GFP_KERNEL, "EXEC_ENV=%s", TO_MHI_EXEC_STR(ee));
> +	buf[1] = NULL;
> +
> +	ret = kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, buf);
> +	if (ret)
> +		dev_err(dev, "Failed to send %s uevent\n", TO_MHI_EXEC_STR(ee));

You are leaking buf[0] here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

