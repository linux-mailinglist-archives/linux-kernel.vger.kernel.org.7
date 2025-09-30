Return-Path: <linux-kernel+bounces-837293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A777BABE13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BE23AE9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3327F18C;
	Tue, 30 Sep 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="npeydifp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EDE25D53C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218302; cv=none; b=kV6AuPdEJh2Iics39TByaAygNFO1TJs/2GULHmbzWDG7xx2fDG0x2QjEy7CVCCl4OwfwoPK6oIYlspXPbEKqKrNypdW/2zJSZrloxUGCVlbGD7JZb01PKdHwRXX6Y+jxwIzGtSYoaaEDEgHy6IjnZaWG2nyjDWK7dmTzX+oNqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218302; c=relaxed/simple;
	bh=dBrWI4k7VRL8/7l5jenag5KT5vNfN1jL50PovXpn0o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMZA0Q81ezXtIvPB1C94oeE5Wx9VcljPyTuS526l5sYUm5/qSuQXuVrr9SB+HwGC29qmDi7LdlAHVfz4tIN6DS1l9eOnnwCuSCCC+TpthkYnhBmmiL0u2WAkcVNj7+4CjcC8idKgMSPO3E8OrHa6cuF5RfKBcMUgq/ZZRgJyKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=npeydifp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HXCb027458
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L0rL1K4stDTkbsmTd2WNaHVP
	qbXC20UcSps85wcP1FI=; b=npeydifp7VIkU6lLbvZb32s9chsDMJjdPZtsL3o7
	QrAhnfKnIFg3jjq45Hd3XCQ5EUARez5j/D3KDj50hbrX3lRMsRyQe520e3QJcd9c
	HDaESntqdBx6o7Tk60okP41spp6Eo+/VwKmuvyoUwJtn1r+xE3Y93LnAYHlqx3KC
	RYJbdHyDmLc6H24+PuRI5KeDj/lVicdmqaIhXJ/+h77PsxejQdfLRkQODBZiylyI
	6UYKy44Ucy3nmh4InwuEXe46qERdclUqxMv+Hx5Btjm6NfUOpd8VoHkrTguBxKlp
	69Vkxw06Lht5losu4EU/rhekJgAm/dsfrqdhS5zorsUNBQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851g152-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:45:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-803339f345bso124839106d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218299; x=1759823099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0rL1K4stDTkbsmTd2WNaHVPqbXC20UcSps85wcP1FI=;
        b=nX7xbXGD+Gjgn3ARAmZ7L+tjNe5rUdhiB2I83d5CqAaTAITPRa2jk9znfh3BCtiIw9
         3ciqL+klYfieZ+0hdify3YwaWmqFOgfxwtzb2V1q8rYuVeCTY5Dlfz9YyqnRM2hVgMXv
         kmPcWe4PJaYbiWksBo20bQnRVSB/fvmVOVfJamXBHfx+LR1Asy2J7yQCUbSx/zxnAbjp
         B28onOsMdJUCD5fcSYCw9TFSINiU2QPoOXQ8k0YOil3NqktIYtayeyQO9P1L/KzjUs6J
         IQ1pvdMCGsDFOEVOdSpQUF7yPWd3tPjgXxh3TntEZzrCSn0i7vCoPo7Yc8MPum8+o+ss
         lHuA==
X-Forwarded-Encrypted: i=1; AJvYcCXIwcwrXPX+fAcFZE66p998Zag7ghLirDN6ljuYozlarAEpYu3MUDaFGGXaMmajv9Lz7oWtWbpQwzUNeZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9R71/vtfOM+kghQDo/QNHhqXLXqUUiw0SKJzeFJNLQ3JGPkRk
	rTWrXgSo9H2b1JDlfuAe64KzDzjbc4DlA222D1YlU3amHdbXpM2NXLhd21LCpwsRKYRRlc91KvH
	ZW0n5SD48EGWiH8CD+zrg5jKZoLH60N/cvH4spo6iFjqCnIywn1Q4s4yAYzf5Jkn1+AE=
X-Gm-Gg: ASbGnctQiCtEAv/17iLNFDqjNXfIVmhPex91SZ6wlV/1nAyBgZ3NAgbCdLESYv5hve5
	BR56fu0N8ypJPrvUMls4TdB1yiSDkvFt8kzpZZSrSolDFaOHxpq9syX92nVOmqoqDeYiKvXqKBQ
	8lcq7+BvtgvK7zFrW7eGVEI05HZNL1J6a3ldoHr6YJKp5fFfGKvcuDPcPxhzG2Nj7XzsFl3Y+j7
	r+b+Z8Or58YccEtzr3lzzUjCBykEwFDscHgDi0ol1esbutZZoQpHbxM66pqA4aoRLwEKFjWYFbi
	QWNHTMRRWmFFyz9UXP8JsddPmwq4qN0g85jwelV1ldLTYcfjHXJhdDzymTpuhS2AWV7QShUFr+2
	4ohglgi2d4OQF2mmcRCrK528UVa++Fbt6IMVLF9OuH3jQPdJGCXYl5uy0GQ==
X-Received: by 2002:ac8:5fd3:0:b0:4b5:dd8c:1d3 with SMTP id d75a77b69052e-4da4deafcbamr259012151cf.77.1759218298721;
        Tue, 30 Sep 2025 00:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMvWrBLJTnixQlCCVfJ6fxPCuqLo/1PDdaopR4B7IthrKclRoZlt9yFC/kXr5oTsXhYJdxcA==
X-Received: by 2002:ac8:5fd3:0:b0:4b5:dd8c:1d3 with SMTP id d75a77b69052e-4da4deafcbamr259011581cf.77.1759218298039;
        Tue, 30 Sep 2025 00:44:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139f9915sm4641758e87.39.2025.09.30.00.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:44:57 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:44:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 13/17] drm/msm/adreno: Support AQE engine
Message-ID: <nn64mvneylqqpf4a6imkp5mzsw26ju7iuym26hgyrjoqc7v2cz@dtjmmj5w776k>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-13-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-13-73530b0700ed@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68db8a7c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Vi7wF31NLlcTFLqBoF4A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX1IHpwBGKgGjv
 RhjFAuEzPwBLWUJAUCzKhsfWhrTu81KYhslQvcictShuEP8VvQpzdA3+rvfBT3COP0LLOKLf2GH
 f2oOyejhq9SC2nYtVripopcQy+1ovyRVMDOL5CPdlQE4rnP8uSwXFt/T47KKHyGLlvtjdz/cMnc
 kKjzdEHdtkE7pIQeeQeC/mHQ4B9SrhrfCiDhG7gLBOXHYWJfLJA1PjVGSmXs9gs6Rmym2JguNpI
 r5YzlzMOh3EWfiIHjYRiTMnE3IgaekH/vTfQaTF+hKQlII1i+KkEkUI8aNmaAjjOzISqkNfEr4y
 +sxs5LbHp5oR93ssZua1o5JngH6WPZRZJKDMUxIjqjOWOvaEw24pDtjMvCPob+8VZlugERAuRIi
 zpfFiY15jUEPl6iMyryKboBICjnSFg==
X-Proofpoint-ORIG-GUID: NCVEFBUVjl7xCLT1DYxijBW_UIhQkdIQ
X-Proofpoint-GUID: NCVEFBUVjl7xCLT1DYxijBW_UIhQkdIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On Tue, Sep 30, 2025 at 11:18:18AM +0530, Akhil P Oommen wrote:
> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
> in Raytracing related workloads. Add support for loading the AQE firmware
> and initialize the necessary registers.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  2 ++
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c   |  3 +++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>  4 files changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 4aeeaceb1fb30a9d68ac636c14249e3853ef73ac..07ac5be9d0bccf4d2345eb76b08851a94187e861 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1093,6 +1093,30 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
>  		}
>  	}
>  
> +	if (!a6xx_gpu->aqe_bo && adreno_gpu->fw[ADRENO_FW_AQE]) {
> +		a6xx_gpu->aqe_bo = adreno_fw_create_bo(gpu,
> +			adreno_gpu->fw[ADRENO_FW_AQE], &a6xx_gpu->aqe_iova);
> +
> +		if (IS_ERR(a6xx_gpu->aqe_bo)) {
> +			int ret = PTR_ERR(a6xx_gpu->aqe_bo);
> +
> +			a6xx_gpu->aqe_bo = NULL;
> +			DRM_DEV_ERROR(&gpu->pdev->dev,
> +				"Could not allocate AQE ucode: %d\n", ret);
> +
> +			return ret;
> +		}
> +
> +		msm_gem_object_set_name(a6xx_gpu->aqe_bo, "aqefw");
> +		if (!a6xx_ucode_check_version(a6xx_gpu, a6xx_gpu->aqe_bo)) {

Should this firmware be handled by a separate function?

> +			msm_gem_unpin_iova(a6xx_gpu->aqe_bo, gpu->vm);
> +			drm_gem_object_put(a6xx_gpu->aqe_bo);
> +
> +			a6xx_gpu->aqe_bo = NULL;
> +			return -EPERM;
> +		}
> +	}
> +
>  	/*
>  	 * Expanded APRIV and targets that support WHERE_AM_I both need a
>  	 * privileged buffer to store the RPTR shadow

-- 
With best wishes
Dmitry

