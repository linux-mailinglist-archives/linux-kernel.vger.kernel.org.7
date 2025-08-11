Return-Path: <linux-kernel+bounces-762352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6025FB20551
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A2F164CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7B22A4F4;
	Mon, 11 Aug 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d9sOpvJs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AEB188A0C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908091; cv=none; b=khHOa+emtof7mOIv8tY9U+MntKavRmwHkzO/vNcVJHyJUgTy35K7T7FyzEuAAr9vPngrSc4xgFSnG7znUHSmOMcSl+iblFQl/lNA9XlkZ3aHFmzGcq5e7kLQAW9A2r9uEDBJQ8HZGKtJq5Q7VHU3HkmpyQmHSUCPCpuWjikiRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908091; c=relaxed/simple;
	bh=XtGwNiccSx/oE8Nnvkf2MQowzzMS1Wn6pPdzqhfwf0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fq5xmHKmnX9YQ9uliYkim5a1zZ1V4yFqJ5dwQW7uQYhjkZ5BnbzBms1Bk1xVT+jvl1ML8z5kavzGm3XjmkU9KHISomLW3RTCsSooSE9w3w8eZvd2SvHTFlJgNPOFlqXb6ylPRXvmI+sDb/a52/ML7oMlgiYqU60KcwkL0YmJ120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d9sOpvJs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dHS1005283
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=S0wh/vf9/ahF7czkuW2zqdi/
	QK9zgAaa0tIwnSvWMPo=; b=d9sOpvJshStdAy5fa3QCF2K0LlzG6kYdh0u51C12
	tq/CY6gep0XLjkozWPaZQAAVnQKqRxdS22XjMpXF9KpTa/xwmJklZcYi58+wVtBz
	uccjxAgMX3MC0JIAnZBb19FrvZGpx6IfkxOaa+Oaw4McjQGiTFsw+pKUpU8mxJjs
	7N8dBL8C/OS0coltbGBCZHdG9r++tckpKwCpGwDM/DS10wGnY6qgBbwKEhy1sYxr
	kOIn4k/qhvBDr23TfRdX3tXIKif+NCPm8UvNEutjTP9aa6ceDjrb26lTlYkSltQp
	1okPKCG5h7mnm9HBgpDlZUdf7Uhjsf8pf+jXYzOJhqBDmw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx27rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:28:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b06908ccacso100656151cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908088; x=1755512888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0wh/vf9/ahF7czkuW2zqdi/QK9zgAaa0tIwnSvWMPo=;
        b=o3fTY7N/VFQJTf1GPl99OKbL8XR5rgWg1HzDBcZVfb5lP5EscGYdXDVW4/gkHRX3E1
         yrOOrQQ25ohxEbIQ2cIeabID5WvS2xTO/3+sbw7DtJEJsEJjZG43dNZgjiZxy2f7gcFO
         dCKhfL5WTMiQ7OBceMKgllzZX/kGFkKDJIOrnsFhPnAKA7WzoDxOfIX8dhmJlqCnWTcX
         bPS2TFTQENucJeMbrsrJW+ZL+mEBwDipmoPAqBGj2zRMFymfP42++V4yik+8zjwON+Uv
         uWCXM/4JmJYKENYe68zuhXlQuW3d5EHpx2ZM9Q9/9xRQ7U7L5Ji5ZlusCr9VoggrNfCV
         9SiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuw/4SfSR1Z84sgQm0LioBRUHBBZu8U4+LCOtua5x7NQemYPQlh8EJ4AQpSnaqE46Gt/wJMlK1UUgrbxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziKUt2KTsHThzgeXojvMn4jdwbR6EyQ0EGPrGQGKmibfQu665K
	GdzHXOB7owwjA6dXo2CoBruqLJfDZi8mT0deEszIa0V6bdPTXxygct2wZlilCojHgucoH8TTPC2
	jl2V5HS0nE7T9MfpXQsh+xniUcUX2oUO99bNMkY7lUSwhbY62a1hJUd95hXqKD1PdjSw=
X-Gm-Gg: ASbGncuBMH0FUdOCPrFCu6P3EfAjRLdmGT8PpUmX2ZG/4g7w1d+ivt2FkInf+plWWJU
	L4vUKj6mS19c29qrNRV9X5Qix4GH2JkpBA7SkjZ5QolS700TVwqzhITblJhEOghAraa1QQJrfII
	5fouf5kKh2qZMeUsDreGdqW+ut0PWhSFoQxcE7dofg1pzPffLMGjBxAefcFSmABCfX1eLOfCxH/
	kj9nnCwLpEhCHeZCJOaun9VjdFP2KLmzl96zVaN9+yWxxZ0aM256apil8CS3RCvAdLDcErS+Cod
	/3yYwym0yuHfCB1oQHo1bF1kReCHxCaiUn+SMS7HgIjzG7GGQKSqaEE7FlR+N/rNVSlyKYTl6la
	HHDdUuCgwRmEMRKHesI/NGecT7QDYtHftW9YTsoPP6wAGPTmdK5Ao
X-Received: by 2002:a05:622a:348:b0:4b0:889b:bc5e with SMTP id d75a77b69052e-4b0ca69c598mr83121231cf.22.1754908088374;
        Mon, 11 Aug 2025 03:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGChlYy+rk1d69F1ULSQJbZUJQYjmNVQhVTyYQ4mc1AGZP7o17UaEkItyvfAe/6wocgG6cF7g==
X-Received: by 2002:a05:622a:348:b0:4b0:889b:bc5e with SMTP id d75a77b69052e-4b0ca69c598mr83120731cf.22.1754908087789;
        Mon, 11 Aug 2025 03:28:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabb7fsm4247040e87.146.2025.08.11.03.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:28:06 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:28:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, ankit.k.nautiyal@intel.com,
        arun.r.murthy@intel.com, uma.shankar@intel.com, jani.nikula@intel.com,
        harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
        liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, robin.clark@oss.qualcomm.com,
        abhinav.kumar@linux.dev, tzimmermann@suse.de,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org,
        laurent.pinchart+renesas@ideasonboard.com, mcanal@igalia.com,
        dave.stevenson@raspberrypi.com,
        tomi.valkeinen+renesas@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com
Subject: Re: [RFC PATCH 1/8] drm: writeback: Refactor drm_writeback_connector
 structure
Message-ID: <g7ny277cnctr3edw53qyutiyv3yxah2m7pulg2u6gud6f2gla6@micq4aliwx3i>
References: <20250811092707.3986802-1-suraj.kandpal@intel.com>
 <20250811092707.3986802-2-suraj.kandpal@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811092707.3986802-2-suraj.kandpal@intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX+pvThhCXhOED
 B/Kkf/aY9f1uC53zKbOquIfLAckimTIMF3Vqx707ncJ2J1WyocDZl4HJ40r+tRoTKw0jP6OmuBd
 P/nK7Jbxl7BOpudFHbrWyROJ53Vy9qrlP2NcKVNmn77APX4y9cROfiAXGLH6Qc7T7jeL4PUi2IJ
 fbK25CM/gLMz+vC4OT8u590VPx0iITi5ciVwg/JU8sKoE19AvH8Yw0SZn968GyWhVn8h/L9bDG8
 KdQFikZWUInE4+kq747qi8oKpUjLC/YNaPLOSjTBmarKw68IN8yXBrqjwCTeYwvZoEO5oAWGBLC
 XL8JgRZ2RjwTRANj6X8iKTVydkt8Y2Ce/KZdXjPxMaTLb1eq+AgsSdKzjYwpRg1ZMiJ1qClEcE9
 ESB/Ia5o
X-Proofpoint-GUID: -yRMWFppAdso-9296ju4EAbtL0jny8PL
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=6899c5b9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=-zeacxS0QVZa6ZkZsZMA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: -yRMWFppAdso-9296ju4EAbtL0jny8PL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On Mon, Aug 11, 2025 at 02:57:00PM +0530, Suraj Kandpal wrote:
> Some drivers cannot work with the current design where the connector
> is embedded within the drm_writeback_connector such as intel and
> some drivers that can get it working end up adding a lot of checks
> all around the code to check if it's a writeback conenctor or not.
> To solve this we move the drm_writeback_connector within the
> drm_connector and remove the drm_connector base which was in
> drm_writeback_connector. We do all other required
> modifications that come with these changes along with addition
> of new function which returns the drm_connector when
> drm_writeback_connector is present.
> All drivers will be expected to allocate the drm_connector.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  drivers/gpu/drm/drm_writeback.c | 33 ++++++++++------
>  include/drm/drm_connector.h     | 60 +++++++++++++++++++++++++++++
>  include/drm/drm_writeback.h     | 68 ++++-----------------------------
>  3 files changed, 89 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index ec2575c4c21b..198b8c488056 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -89,8 +89,10 @@ static const char *drm_writeback_fence_get_driver_name(struct dma_fence *fence)
>  {
>  	struct drm_writeback_connector *wb_connector =
>  		fence_to_wb_connector(fence);
> +	struct drm_connector *connector =
> +		drm_writeback_to_connector(wb_connector);
>  
> -	return wb_connector->base.dev->driver->name;
> +	return connector->dev->driver->name;
>  }
>  
>  static const char *
> @@ -187,7 +189,8 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>  					  struct drm_encoder *enc, const u32 *formats,
>  					  int n_formats)
>  {
> -	struct drm_connector *connector = &wb_connector->base;
> +	struct drm_connector *connector =
> +		drm_writeback_to_connector(wb_connector);
>  	struct drm_mode_config *config = &dev->mode_config;
>  	struct drm_property_blob *blob;
>  	int ret = create_writeback_properties(dev);
> @@ -269,7 +272,8 @@ int drm_writeback_connector_init(struct drm_device *dev,
>  				 struct drm_encoder *enc,
>  				 const u32 *formats, int n_formats)
>  {
> -	struct drm_connector *connector = &wb_connector->base;
> +	struct drm_connector *connector =
> +		drm_writeback_to_connector(wb_connector);

Please pass drm_connector instead (to all init functions). It would make
more sense.

>  	int ret;
>  
>  	ret = drm_connector_init(dev, connector, con_funcs,
> @@ -339,7 +343,8 @@ int drmm_writeback_connector_init(struct drm_device *dev,
>  				  struct drm_encoder *enc,
>  				  const u32 *formats, int n_formats)
>  {
> -	struct drm_connector *connector = &wb_connector->base;
> +	struct drm_connector *connector =
> +		drm_writeback_to_connector(wb_connector);
>  	int ret;
>  
>  	ret = drmm_connector_init(dev, connector, con_funcs,

-- 
With best wishes
Dmitry

