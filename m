Return-Path: <linux-kernel+bounces-760991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F935B1F2B4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06196727379
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AABC204C0C;
	Sat,  9 Aug 2025 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iko2mYdc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B4E56A
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754723121; cv=none; b=MIEuViJknizmStELMkRqUgyZnXLG931PjezadgW0NHYvW1NByPkKUzUuFE5MK1D2ZPTvS1hvHR+kMljPQ1Njhopwa+Qt+hpLxQTH5kPKr+Ut8h9SHxqyztKtLEoOmbRxVzArdjHNs0Lc2FjyOAOpFBpVpvJ36DQiBHoOWhpkOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754723121; c=relaxed/simple;
	bh=sYTSmcJkotvTu7QZEe4XTS5l8zwe6QRkj63he5GVBp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnzTRw6ulT93LZ0pG6zZrd5dg3BENfciaJ9v8l3yECFq/WvOfR6JmUd4t6d1/m57W9fDasofgnNDlQTDBGmquJaK/3B3HKLRTYNQWT2Ka7nrWoHJJ9M4RwCNxQW43IpCTTDMOllO0rWYEgyKBPGDQJpZ6OOUgvsK96V/5BIzigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iko2mYdc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794Bp4Q029633
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 07:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IdFPyk/N0CqFnry8GnZ1yS0v
	H+o/NnXQEhDzbjaO9KM=; b=Iko2mYdcetNqFKayH5eT3RdzEPnJG/nYw8E3uM2r
	OUMObJ0dH/D154RKzggug591bnw+OQYMyDvFjCNwA+hjZ3TJjStenuZC2Z0gr51N
	o6u3VQ7xHPPky5ppQO+0OXu5V4cyYhcs63KsvNvz9IQl9Gkou3fvL8zm0rjsUloN
	RxVS0ijVhth2DS5yeFTTAyP8eJJiQhroMQhnujjiOSHmw1qO2PgUJ4zyeeBvKpaN
	DO2YPITuNPnMkc/6Lnn3yy0EChKLV7uCAuH18mQdd8EK/6wVwNtQy83J1B5hmf3/
	uYk1r65W7jtBsA093zmoba8lOS7gZ+RzFIt/+ITSpg+zuQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g067m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:05:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e69e201c51so626939585a.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754723107; x=1755327907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdFPyk/N0CqFnry8GnZ1yS0vH+o/NnXQEhDzbjaO9KM=;
        b=GtHutxTbG+Cafcq75NnEDnW0VrfITGt5BdnMgXIWE5x52SI0OjDWUYBVzBMP48vg7L
         5VqqVOqZXXXXmGPxO+0BI3RqYC4s9leZonnV8Qdwx32xkbQ9xnt1qURekrmZ1kXJm7zg
         UmURIV66ZyUG6jgdEGPyvZvKUQ54TN4FmiE11TKxVZl1TXpgLUe73Od8Vuwon1roxx58
         LdcQw67Jg+PohzU+6z1Z5akSDhHhlkoKyaTe+KqI+d6QuijnPL5BEXONQhd/dWPPFZPL
         UQY9iIe5M0LJoevNeaz1oi4pE/ixBkGKxpvI3UF1AaOWKYcleF/YoYcPe9GT45VFoxyG
         53gA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2vidkLcbIH0NnCiKYsYWXjpK40JHNxU6gWqU32NsXT6Zn9e8eYRv7DAUFWwXkDAnocMTO/on9yDdcno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7X2LHK1v5XnE6jZT/9IVjMkKoqCN7HRgtk06WYKy0UiUVAv4e
	nGhCGIOTcM6aDN8K+V3YbxQMG9+JHMra0Rjnh5w9YRLMtmOpV/8zERtnWO9yuMwHxqqqcEXdG6J
	90HzHVvTy4pPEHpVkZeXe3KTtmkdBkda765/zdXcegEpX+C7di6wGUfMPDQPXxvNAL5g=
X-Gm-Gg: ASbGnct75In4cylzuoq/8IULkhU7bhlSv0wYEAN3T7NRESpFUqiM6qDjMjw+O6aH4qz
	OoG3MM+QTREPG3q/nlUP/2uu0WvDcJcVBxo6qvqVrNOwOPtoNUswrmOk2MuQT6YiAbef9JeOOXG
	RvgUXhPjNAtObhO7hp/iX/rvhXX22ZbrNBkP+4NWqJSX3giE49XHNnPFYan2PYHsbeiQxcyCY4/
	z598vlluxtt283Fc5hWrn03QD6n1LUcmYAW17Md6zxPlU0A0D2rdcQxXHi0HWAf6wMMe/UBJiMI
	mBGlw9UQrEcSCA03jwgdfYdEHDhYXX+QnVOwZj8iTDiVVhoL8Yfdukatlutbi396v3zgZv5TLoH
	QJago9HHzlsoqIgaoN6Yzy5CrTKlR1iup2V19pSDzN8+dgLaFKG/8
X-Received: by 2002:a05:622a:19a2:b0:4b0:6bbd:d308 with SMTP id d75a77b69052e-4b0aedd8496mr80508851cf.28.1754723107130;
        Sat, 09 Aug 2025 00:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElD8QkE3zUFgI76VPbPQqM6aKAIc4EivMafbCs3REjKQy/hcieyPP9hwVpo8pvPQk5cyycMw==
X-Received: by 2002:a05:622a:19a2:b0:4b0:6bbd:d308 with SMTP id d75a77b69052e-4b0aedd8496mr80508451cf.28.1754723106513;
        Sat, 09 Aug 2025 00:05:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca40f8sm3336245e87.139.2025.08.09.00.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:05:05 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:05:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH v2 07/12] drm/msm/dp: Handle internal HPD IRQ in
 hpd_notify()
Message-ID: <qxb2tqsnrjybml3iiarndqiov7qczdaubzckghzeyr7urnq7i4@lupcydmgxrqq>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
 <20250808-hpd-refactor-v2-7-7f4e1e741aa3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-hpd-refactor-v2-7-7f4e1e741aa3@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=6896f32e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=3-P-7CXywdz3aMBc3EMA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX7VHHAYe2xOuX
 vXX9pQ8yDKIzQHp+Dsk5L74CxGNGZQB3SNlOyWsYpOEMGppGKJdow/EtOUFAc5kvRuX+gRRwMDE
 lV/AffNfW/jzZ5R7eaaY8apfOfOMDY4hjeZj0YGaYBtmEokBRdAT9MQn7EDNgsBrAeegyjEO9wF
 g4me+J6EIBh1RiMZ5vyqD6+6IU83y041c3lbNf3bSyqXrHWr110jDXNGC8GaB0bBfE+kY64W6DI
 KFKDX2NPz2AS1sbBGj3q8PS1Z5FfU1XpQfmTBh96dAeKMEo8VpxvvAwYeIwIsgwaJWc/JomG51v
 7iGt2ZIPOU/dxg/nMz3GsBuVoCXp8Q/c8UtkNHlsxg9HT02y4TlVpzgBMD65CN5sgR1gDD+d85a
 QQc7QDKN
X-Proofpoint-GUID: sdALh-HZnx-L1WZEr5m2QTOQ2nAfn23o
X-Proofpoint-ORIG-GUID: sdALh-HZnx-L1WZEr5m2QTOQ2nAfn23o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On Fri, Aug 08, 2025 at 05:35:19PM -0700, Jessica Zhang wrote:
> Switch to using a threaded IRQ to handle HPD IRQ events and moving
> handling of internal HPD IRQ events to hpd_notify().
> 
> This will simplify the handling of HPD events by unifying the handling
> of both external and internal HPD events in hpd_notify(). Also, having
> internal HPD IRQ use the DRM framework calls removes the need for msm_dp
> to track the HPD state internally.

You should describe, why are you splitting the handler into two parts
rather than just moving existing handler to be a threaded handler.

> 
> Note: The setting of linked ready is moved out of
> *_send_hpd_notification() as it should only be set after the plug/unplug
> handling has been completed.

Unrelated

> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 127 +++++++++++++++++++++++++-----------
>  1 file changed, 90 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 8779bcd1b27c..b9e2e368c4a8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -96,6 +96,10 @@ struct msm_dp_display_private {
>  	/* wait for audio signaling */
>  	struct completion audio_comp;
>  
> +	/* HPD IRQ handling */
> +	spinlock_t irq_thread_lock;
> +	u32 hpd_isr_status;
> +
>  	/* event related only access by event thread */
>  	struct mutex event_mutex;
>  	wait_queue_head_t event_q;
> @@ -345,14 +349,8 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
>  	/* reset video pattern flag on disconnect */
>  	if (!hpd) {
>  		dp->panel->video_test = false;
> -		if (!dp->msm_dp_display.is_edp)
> -			drm_dp_set_subconnector_property(dp->msm_dp_display.connector,
> -							 connector_status_disconnected,
> -							 dp->panel->dpcd,
> -							 dp->panel->downstream_ports);
>  	}
>  
> -	dp->msm_dp_display.link_ready = hpd;
>  
>  	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
>  			dp->msm_dp_display.connector_type, hpd);
> @@ -407,6 +405,8 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  						 dp->panel->dpcd,
>  						 dp->panel->downstream_ports);
>  
> +	dp->msm_dp_display.link_ready = true;
> +
>  	dp->msm_dp_display.psr_supported = dp->panel->psr_cap.version && psr_enabled;
>  
>  	dp->audio_supported = info->has_audio;
> @@ -420,7 +420,8 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
>  
> -	msm_dp_display_send_hpd_notification(dp, true);
> +	if (!dp->msm_dp_display.internal_hpd)

Why?

> +		msm_dp_display_send_hpd_notification(dp, true);
>  
>  end:
>  	return rc;
> @@ -489,7 +490,16 @@ static int msm_dp_display_notify_disconnect(struct device *dev)
>  {
>  	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
>  
> -	msm_dp_display_send_hpd_notification(dp, false);
> +	if (!dp->msm_dp_display.is_edp)
> +		drm_dp_set_subconnector_property(dp->msm_dp_display.connector,
> +						 connector_status_disconnected,
> +						 dp->panel->dpcd,
> +						 dp->panel->downstream_ports);
> +
> +	dp->msm_dp_display.link_ready = false;
> +
> +	if (!dp->msm_dp_display.internal_hpd)
> +		msm_dp_display_send_hpd_notification(dp, false);
>  
>  	return 0;
>  }
> @@ -1182,40 +1192,56 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge)
>  static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
>  {
>  	struct msm_dp_display_private *dp = dev_id;
> -	irqreturn_t ret = IRQ_NONE;
>  	u32 hpd_isr_status;
> -
> -	if (!dp) {
> -		DRM_ERROR("invalid data\n");
> -		return IRQ_NONE;
> -	}
> +	unsigned long flags;
> +	irqreturn_t ret = IRQ_HANDLED;
>  
>  	hpd_isr_status = msm_dp_aux_get_hpd_intr_status(dp->aux);
>  
>  	if (hpd_isr_status & 0x0F) {
>  		drm_dbg_dp(dp->drm_dev, "type=%d isr=0x%x\n",
>  			dp->msm_dp_display.connector_type, hpd_isr_status);
> -		/* hpd related interrupts */
> -		if (hpd_isr_status & DP_DP_HPD_PLUG_INT_MASK)
> -			msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
>  
> -		if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
> -			msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0, 0);
> -		}
> +		spin_lock_irqsave(&dp->irq_thread_lock, flags);
> +		dp->hpd_isr_status |= hpd_isr_status;
> +		ret = IRQ_WAKE_THREAD;
> +		spin_unlock_irqrestore(&dp->irq_thread_lock, flags);
> +	}
>  
> -		if (hpd_isr_status & DP_DP_HPD_REPLUG_INT_MASK) {
> -			msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> -			msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 3);
> -		}
> +	/* DP controller isr */
> +	ret |= msm_dp_ctrl_isr(dp->ctrl);
>  
> -		if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
> -			msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> +	return ret;
> +}
>  
> -		ret = IRQ_HANDLED;
> +static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
> +{
> +	struct msm_dp_display_private *dp = dev_id;
> +	irqreturn_t ret = IRQ_NONE;
> +	unsigned long flags;
> +	u32 hpd_isr_status;
> +
> +	if (!dp) {
> +		DRM_ERROR("invalid data\n");
> +		return IRQ_NONE;
>  	}
>  
> -	/* DP controller isr */
> -	ret |= msm_dp_ctrl_isr(dp->ctrl);
> +	spin_lock_irqsave(&dp->irq_thread_lock, flags);

You don't need to save/restore flags in the IRQ handler.

> +	hpd_isr_status = dp->hpd_isr_status;
> +	dp->hpd_isr_status = 0;
> +	spin_unlock_irqrestore(&dp->irq_thread_lock, flags);
> +
> +	/* hpd related interrupts */
> +	if (hpd_isr_status & DP_DP_HPD_PLUG_INT_MASK)
> +		msm_dp_display_send_hpd_notification(dp, true);
> +
> +	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
> +		msm_dp_display_send_hpd_notification(dp, false);
> +
> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> +		msm_dp_display_send_hpd_notification(dp, true);
> +
> +	ret = IRQ_HANDLED;
>  
>  	return ret;
>  }
> @@ -1231,9 +1257,13 @@ static int msm_dp_display_request_irq(struct msm_dp_display_private *dp)
>  		return dp->irq;
>  	}
>  
> -	rc = devm_request_irq(&pdev->dev, dp->irq, msm_dp_display_irq_handler,
> -			      IRQF_TRIGGER_HIGH|IRQF_NO_AUTOEN,
> -			      "dp_display_isr", dp);
> +	spin_lock_init(&dp->irq_thread_lock);
> +	irq_set_status_flags(dp->irq, IRQ_NOAUTOEN);
> +	rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
> +				       msm_dp_display_irq_handler,
> +				       msm_dp_display_irq_thread,
> +				       IRQ_TYPE_LEVEL_HIGH,
> +				       "dp_display_isr", dp);
>  
>  	if (rc < 0) {
>  		DRM_ERROR("failed to request IRQ%u: %d\n",
> @@ -1413,6 +1443,7 @@ static int msm_dp_display_probe(struct platform_device *pdev)
>  	dp->wide_bus_supported = desc->wide_bus_supported;
>  	dp->msm_dp_display.is_edp =
>  		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
> +	dp->hpd_isr_status = 0;
>  
>  	rc = msm_dp_display_get_io(dp);
>  	if (rc)
> @@ -1822,13 +1853,35 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>  	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
>  	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
>  	struct msm_dp_display_private *dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +	u32 hpd_link_status = 0;
>  
> -	/* Without next_bridge interrupts are handled by the DP core directly */
> -	if (msm_dp_display->internal_hpd)
> -		return;
> +	if (msm_dp_display->internal_hpd) {

Why? The .internal_hpd should be gone completely, there should be no
difference between those two paths.

> +		if (pm_runtime_resume_and_get(&msm_dp_display->pdev->dev)) {
> +			DRM_ERROR("failed to pm_runtime_resume\n");
> +			return;
> +		}
> +
> +		hpd_link_status = msm_dp_aux_is_link_connected(dp->aux);
> +	}
>  
> -	if (!msm_dp_display->link_ready && status == connector_status_connected)
> +	drm_dbg_dp(dp->drm_dev, "type=%d link connected=0x%x, link_ready=%d, status=%d\n",
> +		   msm_dp_display->connector_type, hpd_link_status,
> +		   msm_dp_display->link_ready, status);
> +
> +	if ((!msm_dp_display->internal_hpd || hpd_link_status == ISR_CONNECTED) &&
> +	    status == connector_status_connected)
> +		msm_dp_hpd_plug_handle(dp, 0);
> +	else if ((hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT) &&
> +	    status == connector_status_connected)

wrong indentation

> +		msm_dp_irq_hpd_handle(dp, 0);
> +	else if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
>  		msm_dp_hpd_plug_handle(dp, 0);
> -	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
>  		msm_dp_hpd_unplug_handle(dp, 0);
> +	} else if ((!msm_dp_display->internal_hpd ||
> +		    hpd_link_status == ISR_DISCONNECTED) &&
> +		 status == connector_status_disconnected)
> +		msm_dp_hpd_unplug_handle(dp, 0);
> +
> +	if (msm_dp_display->internal_hpd)
> +		pm_runtime_put_sync(&msm_dp_display->pdev->dev);
>  }
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

