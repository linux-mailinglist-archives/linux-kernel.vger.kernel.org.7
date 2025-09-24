Return-Path: <linux-kernel+bounces-831199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2537AB9BD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5D97B2279
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467A1327A3C;
	Wed, 24 Sep 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8/loSfS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AF2153E7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745058; cv=none; b=luEJFOgKP83uEi0Bc8YaTN147IzseVJDu5SX1goXzqmPM+C1UVOi7nmDsTHvmZC3wJza6B+W99xGF4fxipWxOxcnl4GZTp6Ie24CSuoHILp0YGAVMOR0RC9KTmHvXddEfKQv172ICbqqB0HArl1Mjoye9HP+4iaX3nNRECI2SyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745058; c=relaxed/simple;
	bh=o6NvGxbCbScKyYSzkKl7NvYCUEvgKeIRjGzob+GbanQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB39HyRCnjj3GA1RoGwTnVWl2kkC5V217jQ/H2eGaYAbx1X0n91R1g//laQ6s5B6nqeuiYm6TNC/6Qt0zuYmbsxFmRntbwdzRwqflbKwjPAWc4VD3gh40bSPxBx9YZ4d4OipbOE618UP6jwxxdbjPkf5N9sreB+reAsX37/L3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H8/loSfS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCTQBv017434
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rNscl5fXPcxVylZp5rvGQzAn
	4wkFIbURvBdkFv3nYKA=; b=H8/loSfSik35YsP20ovZE7rZYpmzfKcrfLqog1aw
	kXmw6xU3Xoa9owShkrAz+Xqv5GsUl9OZLMAN8sp83mUnjtDO6d/S+saLAphokrWG
	N8+fmmznGR8geaEXUtvJ+xhwR0CxkvB2FsoZXlH4grpmtB35mACqxuzNuXEAX4o9
	Pk7wuoprtLKWkU+eoBfdL/eQcITVXB/3DH+0hzLHHFxQqVW5oV938WXiF1sOF8dq
	tDFlUk8KAIqaHRuQUkUXjGoFJaFKpH+g938ZuMTUSxtqcqQ0SXEbdQm/JOfaP8+b
	ypFK+x7tpMkGd2Y7+MdoSHVErnqCLzwevtfLUY301Qz6BQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjxyq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:17:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4cce66e91e3so7230201cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758745054; x=1759349854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNscl5fXPcxVylZp5rvGQzAn4wkFIbURvBdkFv3nYKA=;
        b=EtbMrJbOayKl9clu5GVaYiIi1oAaiEMdWn5uLF5Ok3xkF8dpAeNZsWSQN/zkH7lKrX
         1h6Ra3xidGi5gW5EZ1Wi2JAkXlmQEzDjQt7wtJupb6hLM85IMzABPhp5909iK/l0KN6k
         2mtfnzil9rbc7YdlLoUCQ69TACO6qq5YjVQ64zuwfZMRkbR0W1xMIWzc0ldneSsTZ6Y9
         3x1uSrMK7GQ33+yZr8MOQD6sBmNGKM+DFFG6I1fgHetC1iq2Sxn9ywqIxuHu6gzJuGq4
         WwlczAzchtsEZHOnHTdk7N3h9Ji8E4GuxpzLfesvFoa8MARhITfa4G6+qXHgn/LKZyD3
         I4oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO23tEzL/oxtFJGDCo+GOBtbsDxnv/0G8refAdmPh5IU/VkhFoi8KXesboZdt3X2r3rtDNVyH7GojIbJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkLch7w/CDDOWqkHCzaW5A6AXJexCXX61F9W4OvLhpjhtIg3JB
	IIZJJWP3qDUq6MXzQeuy2CP+0Lu7V0ycPiGtTCkgQZ0z5PF4jz8xU2vmZpwkWdUL8QdejdtkJ6A
	dmpTh8Lqh0K3Qnzuclxda4QDHoN5kcWDvZnt2vDfXpzbT3ncUfL3by1wEHBSbayPfYck=
X-Gm-Gg: ASbGncu7jcxVlIfQQjgIU8LS3vAUjsAH4b6i1v1A8G5/6IGMkGZ0N29hh0Qpc0fJi2Z
	jWeqnRK1etlemfAs+iUz+mIxVPUEgPG96k5HoANxmnMXIal17nCkFLUV7nAEh+//4tPHx41FBW8
	MXQYzDIPH0XKddIm9AwThyBrSzmpc+pfd3SXc6eHU/1dfWRUDNwIe8Z+L8zZy8s2gYJz0HBpLm6
	xgI9qx0XEfhh87/gotYS0M4qEnWa+19cjayJM2Ev0HFdaXAr/k1KU+xpoKl9cRyYaQ/EUrm724p
	fVUf32TtxZMIRt+CVaPbHK9x63+iqGGMbDDTHWrJGVUqaaY8zfQ0CfKSppSx8B54f/w7cQd7XiD
	qdumax5crPbmw2NjNleBVzREcpGkfoyg1NPlhmiuU48BHoGxY2ZKf
X-Received: by 2002:ac8:57c9:0:b0:4b5:da5f:d9b7 with SMTP id d75a77b69052e-4da4e09ba07mr14293451cf.78.1758745054128;
        Wed, 24 Sep 2025 13:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8fbq+QXzg7RxLwLK5HpzuaTx1WyIg89KWF8NF6iS/V7e/38Tey51cL9lzdyOFvS6uwyzg7Q==
X-Received: by 2002:ac8:57c9:0:b0:4b5:da5f:d9b7 with SMTP id d75a77b69052e-4da4e09ba07mr14293071cf.78.1758745053560;
        Wed, 24 Sep 2025 13:17:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57ef9b9bdf7sm2651004e87.146.2025.09.24.13.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:17:32 -0700 (PDT)
Date: Wed, 24 Sep 2025 23:17:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Xilin Wu <sophon@radxa.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
Message-ID: <zopgbudg67lygconkv3bl43xogzl6rncif7wdpclbyc4wblan2@n7v75dbnaqqd>
References: <20250924085804.34183-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924085804.34183-1-liujianfeng1994@gmail.com>
X-Proofpoint-ORIG-GUID: eIacYGA1ZCkWJwW1xAm_0UnWqUOCWu6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX03QNkKvEqqxF
 lQS5uxOMELLI6FUnKhsW2BknSnJq9dxZpqlqsyUu7vJ5ZFz0y3cLSlgt3kV4OQ9HZrdL1rFsdQV
 UuyRn1gyyaSd+TwQPQJ+pTJhiSwK43gs7nba6s//BfL80h2Ni5Us16Q83zgcLOMb6DfviJ8zpYi
 7YpxEm3zJXqkFlgfXeBfZG2ov5fnqUVi8XD2r9tuSF4rLRxm40tlF34WUOEQO35KxNBJ+iUAPxe
 M8Hommu4Mt6Mxoyb9jfg8pv5FDJdVo98LtgvPt+Us1MdTW65ys4IbagKWXQSwPQErHurZod9AcM
 G/IVT+f3aQpbRUOGGaTrwlxDXrioRNFU8bppQsB47xl1cDO6JBj1otMxMLR8lIKLVkKKTHGQHaS
 5XoXlLEP
X-Proofpoint-GUID: eIacYGA1ZCkWJwW1xAm_0UnWqUOCWu6X
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d451df cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=bYjh5Db1ZrtGeT73nCYA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On Wed, Sep 24, 2025 at 04:57:43PM +0800, Jianfeng Liu wrote:
> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
> use msm_dp_audio_prepare instead. While userspace is still calling
> hw_params to do audio initialization, and we get the following errors:
> 
> [ 784.904566] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> [ 784.912185] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> [ 784.918927] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> [ 784.929947] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> 
> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> and runs hw_params. This commit will add hw_params callback function
> same as drm_connector_hdmi_audio_prepare, so that hdmi-codec driver can
> work with userspace alsa.

I think something is wrong here. The prepare callback also should be
called. Is it that the prepare callback is called too late?

> 
> Tested with Radxa Dragon Q6A.
> 
> Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
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

