Return-Path: <linux-kernel+bounces-874741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6E9C16FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F6A4026DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1235502B;
	Tue, 28 Oct 2025 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G7nBaMX2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jvuTF4Pc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F064354AFE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686625; cv=none; b=AwCUkPDoFoigG6p8ULXstHfRj6BGQCduyNUTMDrPZL0hTPsWL3JkdVltM5xWb4VuZFg9DnmUGzkgPIFBQhIwygD/HGsD4NBHaeZWmneMz8Q7LiJl1SVUQDoJlc6e+G1qAcrGEA9OUoB1ZcRMdnsSQSqV8NTO09Id3EkDrLePQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686625; c=relaxed/simple;
	bh=WngYaf9I9c2jzvtYx4c/BLYwQWN7XC1wBLWZHDIqVpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0OZslvFzTvzQetadL0hgkeyYbwD+2V9u9Z+uD61+Co+Mk3ln3+GrIlmt+2V6DWmmN4wLccf0A6nKcPhGui7gMWJYnyFdw4/oLYBt+ItyL6ICaTQBjj/qETmdJWWrVbGmUJLc12i+r3+i44mFKRVTwmQZJNBLtXgM8AITqZ+2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G7nBaMX2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jvuTF4Pc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlUD02575509
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7WqiEnjAgMfmsuJ0ixstPssdOKbvkewqIqpstd+r89s=; b=G7nBaMX2wopTqieT
	FOuyo9eyoR2LoFSFbXdxnJSnyIK/gpHEg0nKoO8jmyBe2pEvVkBYmhBo5bd8vMg8
	srXwJ9KT7g1LW1oWa2JfIcip74CVBe6NhZ1PH1SywrMmz6sN+8MaLUH8J0Z3S19b
	vqSIboFmODQRGPBMXEo6hWW1N+bfyLZKP08rHjCvkkRsp5jaIrsIK9VZHy6a6HKk
	AJ7DrYyPJOGUZZnywXiLqhyeCVokPe/+P5zcOx8UJ0tBgUu9Emm+EVHhIdFKPIHP
	AtQ5lzY3Z9c8XzMd3OtsN9+HX+wq6tdFYSnjTGlmYEManY6r5bgK0zYqjT76F36W
	c2y2+Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a207f7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:23:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e894937010so181831281cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761686622; x=1762291422; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7WqiEnjAgMfmsuJ0ixstPssdOKbvkewqIqpstd+r89s=;
        b=jvuTF4PcZ2WAEsKjEn5LHD3D6LHoi0mMjrauIaDJ2tynfqMSLzheoV56G3kaXOQ5ei
         J0QWfg5NiwvVtNbUzTZp+Js6Qfdl90ipKPzOiyg6dVBVAvetbHCcNP1l5Mc7KLZMMUC5
         soh2fQyjx3T60/Ri9goGaHZBWxdt017HQo+Jxhw0EsDMpYlIVu1dTX1UvQQb3BflYzSx
         80/BSvpkMxDhbarEE9Hf+fxM+p1WHGdLsbFEYLH4LMwdJ9xljZaw1kRSNq/TwhHxyZ/j
         ynr6a+AgAK7kO+RhcncnotFOrsShzJkTpNIlFluysPFSQv6ElYsQ7U5cu42MiuHr/jul
         Bkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686622; x=1762291422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WqiEnjAgMfmsuJ0ixstPssdOKbvkewqIqpstd+r89s=;
        b=BldYeCR04knhLyaz4GUWQWr7jsH7kXM8lX47eP0xtwHaMz488wmIy9bypVP9jWtxyq
         W/ohG2dIhQ0ULLSu3Pr+IktYscs+8yI8+O6n+rswGHNbjyLaPAQasnMol9QT61/WFozB
         0CfAeQxt9702DkYeULBvlR2GlLL57WZr4hnqfapEiDluM3L2z2FiGPUqoMgBFsd9bPf5
         USt9eQs9O3Cp5izx2azeipq+mipmVADGc8NKPjt+DLIYE+7HtqSDVCHNImWUFHyd6e3q
         SuggwHZpl2ZzZ/TzR5TpEM2bbOvf03pyKCjzHQHvJ/LcUFAGdwh/yH8dbwB24OalAu3l
         lYDA==
X-Forwarded-Encrypted: i=1; AJvYcCUawCFxP07M8Xx8Qrdf6tpBC8x+yKDW7qRbaK3yrZ1EXan3yWslXLbUk+JDy281B+waM8Eb2JVzVynSSHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPsHZUJOGsCSBzidq+MIGX3KfxLc0s4969Xnz1MbwQFIMF09m0
	qoOme4bjKXLQCnx2Z5IK03O4NCJF5FztCPNahmXf0MrDQv5w+vHCN7T0ptj/2oztD+toUUpjoGY
	IZ/2+LTgVoKphm6hVgg7LA0nJNOOC/LlXcTRcB2dR0kp/PM7Irg5xACHERrjVo9F/u7g=
X-Gm-Gg: ASbGncs91gnK4u90nSWEBXXpbba4udUSVEuhhtdNeCjrBp2oRnTxd6JSblsNzwYohqv
	KS5WbEE3HSLvQH2DejBruIcfcCkZ+GUWSTTwo6o8/Zv4pkRQ9ZPbuF5HGIOmeBEf/dUEhnlidQY
	nOKYftJan13azWte66XR4mNYwWUefAdaYF0u4s89e196gnLi+3HdbMl5e+X8fnCY3lttGwh5+bM
	MP4PPrrmJyT8fHQrpmGhLP6iZ0EEZYHdB2ffZ+x1NWOFh3vTnWTZqDyrgk+Zz3F9niNy+XHlI73
	GBWoJ7+s7iPD0F2pI/nvIXYL2VJ2tYjPVN4oE5sQWbvURHmXt8gQ+rI796pkBA9kHNZyKcFwDt5
	vmB5RfmmVWQb2OdAcOJTOEPCMAwkNg8K4gfov6gPgXFcYRNwx9wFDGSmsYuOPuxdXaVIbPB9oln
	nnd3g6Mb8JbNOF
X-Received: by 2002:a05:622a:4a13:b0:4e8:afdb:6f56 with SMTP id d75a77b69052e-4ed15c4caa1mr10464181cf.74.1761686621631;
        Tue, 28 Oct 2025 14:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIxBrdIO7mfWQKtvDvRPRtB9L8H/kLm56MKcuYi7AAbrvZ0yHrj06ejtcwIC3X95uJDXxrIg==
X-Received: by 2002:a05:622a:4a13:b0:4e8:afdb:6f56 with SMTP id d75a77b69052e-4ed15c4caa1mr10463691cf.74.1761686621070;
        Tue, 28 Oct 2025 14:23:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f749easm3402826e87.89.2025.10.28.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:23:40 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:23:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: federico@izzo.pro
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        nicola@corna.info, David Heidelberg <david@ixit.cz>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH v3] drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT
 DRM property
Message-ID: <gmk7aho74xb2wwlc27t6qaozfnqsjjyccmzm5moe53tyzuwm4o@ri7cfoqz23ks>
References: <20251019-dpu-add-dspp-gc-driver-v3-1-840491934e56@izzo.pro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251019-dpu-add-dspp-gc-driver-v3-1-840491934e56@izzo.pro>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE4MCBTYWx0ZWRfX+97MRfIMMaat
 ERf813ydd3LBL4oqQ19lYpzkg+RSwIYlPw6C9Jm6bI86J6Cz8LnSYwM7EtTL61G1ixRXXFc807M
 UXqZ3iXuBM0AkbKRGfi7my/dyvW2AT1N/BAM1kZWfZsJcAGO1XAe6Bna4pGRG4+G8VheqQog0O7
 mkgzQJzyZvkJOoFSH01IedMa7lhPKOs0qvNlnp04uj/FDgyjy2iX+oD0Nvq2c2pjv4bTUxPmLws
 fMjjnBFz6gME30LQEpdyeCv+4up3m8hkX6UF4YxYcosPqnAIGBbgFoVWZLlJOevre6OeMp79s32
 Ru+LaocnyvhEb6dRAOgvkmGXhla7jcPIJqgg3ESP7sBN86+6bYOORiItTnc9aRa+ugnPkledb48
 riOBrYzqN10Ad/RQqo1kZ7AbtvJLTw==
X-Authority-Analysis: v=2.4 cv=V5ZwEOni c=1 sm=1 tr=0 ts=6901345e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=ze386MxoAAAA:8 a=EUspDBNiAAAA:8
 a=WrUPyqytC3nuxuxCNLkA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=iBZjaW-pnkserzjvUTHh:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: bTvwClCIzfak11togY-_r2sMWf5RO2H-
X-Proofpoint-ORIG-GUID: bTvwClCIzfak11togY-_r2sMWf5RO2H-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510280180

On Sun, Oct 19, 2025 at 12:06:32PM +0200, Federico Amedeo Izzo via B4 Relay wrote:
> From: Federico Amedeo Izzo <federico@izzo.pro>
> 
> Add support for DSPP GC block in DPU driver for Qualcomm SoCs.
> Expose the GAMMA_LUT DRM property, which is needed to enable
> night light and basic screen color calibration.
> 
> I used LineageOS downstream kernel as a reference and found the LUT
> format by trial-and-error on OnePlus 6.
> 
> Tested on oneplus-enchilada (sdm845-mainline 6.16-dev) and xiaomi-tissot
> (msm8953-mainline 6.12/main).
> 
> Tested-by: David Heidelberg <david@ixit.cz>  # Pixel 3 (next-20251018)
> Tested-by: Guido Günther <agx@sigxcpu.org> # on sdm845-shift-axolotl
> Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
> ---
> DRM GAMMA_LUT support was missing on sdm845 and other Qualcomm SoCs using
> DPU for CRTC. This is needed in userspace to enable features like Night
> Light or basic color calibration.
> 
> I wrote this driver to enable Night Light on OnePlus 6, and after the
> driver was working I found out it applies to the 29 different Qualcomm SoCs
> that use the DPU display engine, including X1E for laptops.
> 
> I used the LineageOS downstream kernel as reference and found the correct 
> LUT format by trial-and-error on OnePlus 6.
> 
> This was my first Linux driver and it's been a great learning
> experience.
> 
> The patch was reviewed by postmarketOS contributors here: 
> https://gitlab.com/sdm845-mainline/linux/-/merge_requests/137
> During review the patch was tested successfully on hamoa (X1E).
> ---
> Changes in v3:
> - Remove memset() after kzalloc() in dpu_crtc.c
> - Simplify error messages in dpu_crtc.c and dpu_hw_dspp.c
> - Use 0 for DPU_REG_WRITE() instead of reg = 0 in dpu_hw_dspp.c
> - Link to v2: https://lore.kernel.org/r/20251019-dpu-add-dspp-gc-driver-v2-1-30c8cb79cb17@izzo.pro
> 
> Changes in v2:
> - Fix gc register .len and .version in dpu_hw_catalog.c
> - Apply coding style suggestions
> - Link to v1: https://lore.kernel.org/r/20251018-dpu-add-dspp-gc-driver-v1-1-ed0369214252@izzo.pro
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       | 86 +++++++++++++++++++++-----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  4 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  4 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     |  3 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c    | 54 ++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h    | 26 ++++++++
>  6 files changed, 163 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

