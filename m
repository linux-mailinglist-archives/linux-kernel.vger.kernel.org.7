Return-Path: <linux-kernel+bounces-624025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF3A9FDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 01:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152941A85CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 23:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F02214A96;
	Mon, 28 Apr 2025 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OGr4DdkX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F731DF735;
	Mon, 28 Apr 2025 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745884681; cv=none; b=NUQHsPVGmkOCNhIaaTiuXchCikfH3sKj7jv6daImB8s3FWJfIkbJ45dUAqqN89C4qGRKAWBLKVLZ38KF5+MLtVFn4KUQ4HWsSKqyQ8HTqck7j3rtBH8Oo3j0+TTp4jIraZ/UqfuQea2qmfV/ISXV29/0qfpVRH+GBM6olxBxhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745884681; c=relaxed/simple;
	bh=PGKm98/kEERbLXcy0dB1rVGHlA4IvPiJDcEqrgef2do=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xpz0WjVhbNWwDIWGTIzCBtoUUM+CHWHKNglF1KOB2Y8r9TBgXf7E6yS26t318r4xjE1dy9PGdZ/H7aq0Zz5/AYGozyK/0/H2zZ36vLqw/Mn1qf1hpYRrB/pX/imPRSYwGzQIq3BvRZJmnGlD4Bv9fToopWDFyfLE5NoxAjZFVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OGr4DdkX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNq6EL011895;
	Mon, 28 Apr 2025 23:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	62tlxptsKm+Xca4dYWaxcNYVzDiPTYlvhlnnd/zPZr0=; b=OGr4DdkX0TcIjTLD
	BBRD92V/M91en2S1L0RZdQWv/SHEbRKhsR6XlxIqvHVyd8fg+bklvQEuG140d5Hr
	vbRnMI+8D5v1297NdwZ3b6SiX0qoIPZAVJt3sl5UGt9TEI2DJXBCCjrjAzmzUz0E
	IEdNPZJhYGYKq9w+pldoLHbJ+u9E0Il55qElDkr/xG+mP5gyjwFU9l/LCCaSWoiV
	CQ/jcapbX3jnVw/ljPWUNUGHXR7GAJNydrzfsawANU3jfORPG3eqDHRMhta7SBIC
	15Tamu9HI2EsDvsxHdxt+C5yu6Kg36BsKSId7fQgSqND0I2UYaiJ/hchtcgoN1Ge
	+VQtnQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468q322nnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 23:57:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53SNvgKx027421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 23:57:42 GMT
Received: from [10.134.71.99] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 16:57:41 -0700
Message-ID: <73258107-4a5b-4917-ab0b-81ff4cc96072@quicinc.com>
Date: Mon, 28 Apr 2025 16:57:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] drm/msm/dpu: use single CTL if it is the only CTL
 returned by RM
To: Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Neil
 Armstrong" <neil.armstrong@linaro.org>
References: <20250307-dpu-active-ctl-v3-0-5d20655f10ca@linaro.org>
 <20250307-dpu-active-ctl-v3-4-5d20655f10ca@linaro.org>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20250307-dpu-active-ctl-v3-4-5d20655f10ca@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=M7xNKzws c=1 sm=1 tr=0 ts=681015f7 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=tVI0ZWmoAAAA:8 a=COk6AnOGAAAA:8
 a=KP-GQx-2JpzWPZajO54A:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=-BPWgnxRz2uhmvdm1NTO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BHceIxuqT2dG4MX_Eis2DM6-khJVQYQf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE4OSBTYWx0ZWRfXyyTlK6Wl7B+f GHX3NpKQUOxTSBTZjD6K9KXFstuJiqdiPRivx/UfVOzkJZHX8wwKk9Po1eAkGmxUnQcnEw+W5pD dOT5bPkd01CN2zkqEDLd+axs0U4N+Q0chQ3ZBsh9pSQJ876sX4fj9GX3eXZaVQSAOETZmOIZPdh
 WsrlaEfL4SFPdUO7ulVtb7EEBbHnfuT86w+0ZKqritfkRF05MLFIp1LVPu66Wgv415uLzo4b4HU Tpf0eSirWlIB63lfVE82x3gP9eYUJ6DhF1Ee65W4eRBCWHDktUFfw9Stb3tgdqCpBhmwhitQ26G E6khsyxNkWo7Ru4agyKOVWMavrp03l7QZxi1iJfxo0aesNTGADkeF3OPR5l7zAAHSxnbcVrLktc
 uf30w/zvKdAshmQIl6tD7p/gkOJ4YiOoCWhp0xrf882iZl7XtIksNGHjOOjgHp3dAJXKZ33q
X-Proofpoint-ORIG-GUID: BHceIxuqT2dG4MX_Eis2DM6-khJVQYQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280189



On 3/6/2025 10:24 PM, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> On DPU >= 5.0 CTL blocks were reworked in order to support using a
> single CTL for all outputs. In preparation of reworking the RM code to
> return single CTL make sure that dpu_encoder can cope with that.
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 0eed93a4d056beda6b54c0d20f027a53c84f67db..b5e8ba592d8af298a52924d34a573d4f9e05c476 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1247,7 +1247,11 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>   			return;
>   		}
>   
> -		phys->hw_ctl = i < num_ctl ? to_dpu_hw_ctl(hw_ctl[i]) : NULL;
> +		/* Use first (and only) CTL if active CTLs are supported */
> +		if (num_ctl == 1)
> +			phys->hw_ctl = to_dpu_hw_ctl(hw_ctl[0]);
> +		else
> +			phys->hw_ctl = i < num_ctl ? to_dpu_hw_ctl(hw_ctl[i]) : NULL;
>   		if (!phys->hw_ctl) {
>   			DPU_ERROR_ENC(dpu_enc,
>   				"no ctl block assigned at idx: %d\n", i);
> 


