Return-Path: <linux-kernel+bounces-831716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B392B9D62A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5731BC1C02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC992E7194;
	Thu, 25 Sep 2025 04:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nr61GEqe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F8239562
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758774518; cv=none; b=TE916byXMGcZWvRhuAPD5RnMG9aHns1Xk6XB/ObW10GwpF9h7/J8pPu87wB+rVfrluW/ccfPpEdvVhdtNcBtJ/ZMH+9Y5QVslHkeGeFZSlX5qdL7edQLQtUL/C0PldTUaMcZ3vwMYO9QePtRSnwK2eOlNeLu45DX+ECh1Z5FMdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758774518; c=relaxed/simple;
	bh=ZvvhtAOgBSbLqZItrq7zesgwF7vj/QMySAgYL4Smkd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktchTmwF82RgBwovccaRFpQvJfN8qrtbGA/JUKgjIEEHUGbAFD7hGNMyzU7cDtHaPiDxJkgYsJHzuXyAJaXqfYYg/6ZGEDI2T9yaBWVq+g7Jcgs91gLYDDSTTjcHe3TcnZKR5E/tyvQ1EMmNp0d8B8jLxO44wGfPKav56hjObms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nr61GEqe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONte5E022115
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YKdKu5Uqj/R+R4nSJrnpuBnD
	76XZWXqaLeu9ryAtfrQ=; b=nr61GEqeDS6O/9bCZklUE+4xbaVEsGbDtw8rEDjS
	WsKS/6S3x9s3mMJBQuFiDE0rE1Jdc1LQRQZyLR2kUhWjzi4l/d/6PCVLXh4wb7Dy
	nG7fxDu6V4MEpQBSHHGmcLUs4wGrtPJfePi3npnTv9Qdrht4xPU3l5K7osAAdOEa
	QYXtdYk95S3abI7Zl1VnMOn5aKhIgDHyVFaojWFLmB5ZRCbNOjXCuhYkOvzvbbC1
	HyqV5hmwlnI/lCIRV3RTgA7OFzazV0M3tWtPu7eASldRFGm27EFLHtyZ82cCB4lJ
	NxPyGKBdrinFdhwZ8UBEyiNrRO5C/GRf2HswVqqYVvG15A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budaea0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:28:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d413127749so11723771cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758774514; x=1759379314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKdKu5Uqj/R+R4nSJrnpuBnD76XZWXqaLeu9ryAtfrQ=;
        b=m74l9kn2Y3h+nLcF/5x7LmN0DlvYtF54B4/oYt4OaBP9VCLv2K/wzy6Pf/hVd0v2Py
         pOV8iC7pmdYw4W6WrDh0JoIxLxLRk6yI85Lzf5wni9sEvVXV+b0oE+49DF0cztwDH4YD
         krVfMEWGk8fOENTCayfh86qdfSa0g8TbBZcCncP+xBi2zZE9XGchcP3T7h5eNMOqeaH6
         ehbI/Opr9xhWQBmTqWw3kNBNxkYQChznxOl4fe6JFZWtjXsUGFvX33jkWMHHaz+AbXPD
         5ia1WQQEzhMZc5LGXSq+roYI9xMG0I9v49NWpQIDuTFLhrVs+tblHqjEOVhq8OWHZJio
         uifg==
X-Forwarded-Encrypted: i=1; AJvYcCUgz774OZ06hmU+k49/aGuo76Lb1Pmp5LIdvvXk8wHUrjlv12pDw5oN4MJRThrDvXkbtj7s8PtO2gVx9g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1LLYcHFXM//nrk/DpnkYaFRPXX2Vu8x0gBXQIyooRpFDxAzH
	XO5gC/wA8QC525Rq99XGXWhmf+nDIj+eBSd0nXvGi4kguf9MmL2wzZ5fMkv+JNFDaeRxbtlXIc5
	SwKZcwXtUOsK2gddL2AIN9wj2eZZnZoLxzjrYQ+73t4x9mCoV3rWK8dvdtXu2O8G5rdfLxNz8rZ
	Y=
X-Gm-Gg: ASbGncvZtss6GgW5KJ6GRZR9/p8VDjDgd6D4+i9jKh1lmwOr08ZGrs2UQ3j0CU3Vz1q
	H5HerKcsFHhg8wYu3i53ZOyYZz1LpJMX0dL8Z/coP/qDoYdc3Gd/iL1YCdEc+Nd4djO9gbUjbLY
	YwGh65Yp7KnonAvFVpVlWMxbDzqi130Wx7IeWFpPd8lRrW7xjOAkddDvSjS3c4zwcef30moA9XV
	8E78fe9p0xHyjaloX+3wnXO0EDRBLNK2+fhRnTpg+wZwsbFDS5in0P5vDL4ScBtCnhvMPWSD83N
	qiqpKU+M3WkCwYmnCvCDd07ti1/3lH3Z0dihMRaDteyBaN04xANYrtMjXCllMnTY0YH8UUXSV4m
	YRH5FVMOhgfD8I2URtJtD/OB9VEbHSd3l9ohOnhHrvs/Hbd49kF22
X-Received: by 2002:a05:622a:4aca:b0:4b6:18f2:358c with SMTP id d75a77b69052e-4da4744ead4mr32115481cf.3.1758774514411;
        Wed, 24 Sep 2025 21:28:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAvX5v8YtwH7wuM9PLnsvtwTPCrF2EfJwUTqgkXbR5VNh7MBSXNyhpks3LE2KBzyG0d145jA==
X-Received: by 2002:a05:622a:4aca:b0:4b6:18f2:358c with SMTP id d75a77b69052e-4da4744ead4mr32115321cf.3.1758774513968;
        Wed, 24 Sep 2025 21:28:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7710256sm2613491fa.45.2025.09.24.21.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 21:28:31 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:28:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, Xilin Wu <sophon@radxa.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: Re: [PATCH v2] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
Message-ID: <46q2pje4hginnm2wld6ejyo36hfkmkzydaa4qggx47gd2p4q4z@q6vmomtgqihv>
References: <20250925040530.20731-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925040530.20731-1-liujianfeng1994@gmail.com>
X-Proofpoint-GUID: IouvUIj556IaU7fGxLediC9ohhBP_TqQ
X-Proofpoint-ORIG-GUID: IouvUIj556IaU7fGxLediC9ohhBP_TqQ
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d4c4f3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=vfsuxmVtCGY_ofmyA3EA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX9CHDZRmPsBp8
 mGlp9TjawThlJWtpDyyEB800ANWJonChuYUtu07vQU4GtWznGMid3y9F0bVrIrzgWQir23sfBwb
 FxmjgunkwlZaCF0x/0RU5IR0Rn0t4o1BB8G7N83HGHwJKOxCCC70WBQwdDxEqmoF98V8P5g5hl6
 PaXCC2QZWP3KPYlhVpdEVLyVZ2phaQfJWum27FCLN/mI1MGvbgFefWZhScEa6fnZy9ZYb2XJeLA
 2+U1Q3TD0YQAFT07smiY40jQL5++GzohfWXBTXhvqrIxa2nr9RSDFx5GPRI/flVpvk9+eMY7jSN
 +3fjXMXRc/X187MKMzDifr8EO+Mdw6cDcijq86T9S/G0ty5V5T2KnrgGfW9z2VY2VtSku486lkj
 tDKXdY9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

On Thu, Sep 25, 2025 at 12:05:09PM +0800, Jianfeng Liu wrote:
> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
> use msm_dp_audio_prepare instead. While userspace is still calling
> hw_params to do audio initialization, and we get the following errors:
> 
> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback

And a call to hdmi_codec_prepare() comes only at this place.

Srini, Mark, when selecting to only implement .prepare for codec ops I
was following the commit 2fef64eec23a ("ASoC: hdmi-codec: Add a prepare
hook"), which documents that IEC958 status bit is set after
.hw_params(), so it's only visible during .prepare(). Is it okay to
implement both callbacks? Or should the audioreach DAI driver be fixed
somehow instead (I suppose it assumes that the port is available after
.hw_params(), not sure if that assumption is correct)?

> 
> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
> hdmi-codec driver can work with userspace alsa.
> 
> Tested with Radxa Dragon Q6A.
> 
> Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

The patch LGTM, but I would wait for response from audio maintainers.

> ---
> 
> Changes in v2:
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20250924085804.34183-1-liujianfeng1994@gmail.com/
> - Use more detailed trace log in commit message.
> - Drop the empty line between Fixex and SoB.
> 
>  drivers/gpu/drm/display/drm_hdmi_audio_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> index 7d78b02c1446..6ca1c7ad0632 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> @@ -130,6 +130,7 @@ EXPORT_SYMBOL(drm_connector_hdmi_audio_plugged_notify);
>  
>  static const struct hdmi_codec_ops drm_connector_hdmi_audio_ops = {
>  	.audio_startup = drm_connector_hdmi_audio_startup,
> +	.hw_params = drm_connector_hdmi_audio_prepare,
>  	.prepare = drm_connector_hdmi_audio_prepare,
>  	.audio_shutdown = drm_connector_hdmi_audio_shutdown,
>  	.mute_stream = drm_connector_hdmi_audio_mute_stream,
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

