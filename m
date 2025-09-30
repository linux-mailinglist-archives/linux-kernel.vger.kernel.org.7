Return-Path: <linux-kernel+bounces-837221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB61BABBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB2517252D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08D42367CF;
	Tue, 30 Sep 2025 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pazFXeSC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD3222586
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215844; cv=none; b=e8Xx1v134g35sa54WgLMf6ovyA6Wd8Gg7glaa6DaK+mc4LMsltG79/phv5lkG4Emn/Tsk+gw/P3gI+NfZb8wBKMQDB2r48+yGKY/0LzSMwbxP8VSAsnkhhVuFwWigtycfGmi5xrSRNtkb3DrbWu7yUrhzsSqWBXiZ1/vJ4kPAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215844; c=relaxed/simple;
	bh=U7r5lXTdsw9Eas2iK8J9LazmFVQXR2IcunJ0KlLWvAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evW+6h6S/mMjQF5ZYZzCi1EbBBqKpxrkck1f8SIQeEX8KhrvgbL441AoKwajDdfevG10zooKc7ckHpjsvMn/FE53wjaIsZcqiLgS7ekcV7k5+YNQMFMx5XmXMNfHSir06j+JAPK5x1n9qi8NSE8jNUIZxCxQCZIp3V4XLw4fs1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pazFXeSC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HPAl017557
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tnz5TqBen53zV+5c0hfw9xo0
	Ki5Ws5bufZFZJ5eyQqk=; b=pazFXeSCg6o5laK+b1VdfeBi/n+XWo/NDACcUXTe
	UThRpLJb+Di/Os6lyIJ2n2gB5DCHAf9Y9P4MKFydgDKh6p9L1lChuHqP7i6IKcZy
	ffNiiibIpJwhES1cDQkWs27bxgAwDm64aK/C87iSuqxqkx1hrN1glNoHKpIx+1pT
	12MUrxNMPV7xJf3dntnWub2mC1b65RUpB7Che2v89b96bVzQ0wTJd4L3yI0NkPbz
	1rt+1z5xtboyQ05MHbJ7hDBUds1Tfe5NjHwoS2//qqZ3+C9CySiLf3PNw7+9e5Yp
	jgJqQCm+uRBwMET1BkMmb7wAzbWV92jcVZotc1l0Gif/jA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tr2pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:04:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dfc05dec2fso89494161cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759215840; x=1759820640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnz5TqBen53zV+5c0hfw9xo0Ki5Ws5bufZFZJ5eyQqk=;
        b=cC6P30HXbNv7gmneQUe4atD4/7Ih+wQ849xpP1BvAx8560aPKf4FONIWe5yO0z3Jd5
         okmthbbbkq6Ldkj1v1+lzBgPro3jEptH/NEZpLLaNj5VtsOLYfv3A8Exp00r6bQLgtwQ
         qVl/U2s5S2YhnPi2HpgVH9Yb5qYLKjtWLR1pDu/cN7nMLAJq5hrYOnVRe5k3QagmzDMf
         GA1Maf2gTfKwl/s2fzBsAA/3RHizobyqY6OjVfuQv8jN7l/sKN2v46jx3HlWsE5zktED
         03VQfOf6Vua/5SoVr7JzkoUUPEsGTTLIAVQ4BFKWoYej9TTCYmhodBHdv3HgBgcENG9C
         HRYA==
X-Forwarded-Encrypted: i=1; AJvYcCU35t9g3doz4ZNKNlKUNiylhSBwb6pQj+yJkD/SCgRDxgwyrm/isIvnvEbwsLhRHNOIb5kfL84sQrnrcCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQJdRpgA3rmiHQ5CImvXPLuVmp3olc3W6ro13uyKcOT7gFGTUD
	6CAhP0+wYdcgIeO4HCsoLUNqNFaHuuuCZm/wuHbgPHgwo/RyflnozfLD8BJtaW80OKLukD7Lls3
	/cGpdlnvbUrppfCnLERBZ5YEhQrLcjr+3Nty5jkrj/dI6MP+SiUyNUj+0lVvQzfYuJiA=
X-Gm-Gg: ASbGnct5gSoDDnEmUKIsxM+Cy6twgVD9TLM/WnMFbXsKOPW2WO8FTcQJS88R/LzAjlU
	NVWHc2cHhVzVWXoeszfpLWbMt1E20SLuXbe26FJ+KsWH4iZjs3LAK7iVbDRCD0ckCHa5yXi1+Lw
	WLgPQ7OKtXz04lLXbrFhUTIsMlSkXl2IMMAIrLnsgF4DTC3ktcUGMlGH+slLnXJz5ryT6h97Ata
	yV/pJ3mN4BAjG9EQhF32wncSuSJmf/aoxhdQpZKKrsGmsbwGl9NjeSGdhKzOxgEsmKwt29vbnuo
	Lr3yjTVCy2oighWdPCVCYPpBQG6F4INcObMq02mUjJDx4aCiD201lwZvzC5Zz3SW7a91fElf2v/
	ykXueXV5WwpeHVPD6VPdK2hHGArpp/Pah0v3cT4+aJgLAJp38CRhalzbNjA==
X-Received: by 2002:a05:622a:560c:b0:4db:b5f1:84a5 with SMTP id d75a77b69052e-4dbb5f18dbfmr197539921cf.57.1759215840522;
        Tue, 30 Sep 2025 00:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB+47pVViAKJXbEvOe8O+nb1gHysifWQJ8Ow1s0HmR2oz9c6rHltLPTDn+bK5bbHz5yEbEhg==
X-Received: by 2002:a05:622a:560c:b0:4db:b5f1:84a5 with SMTP id d75a77b69052e-4dbb5f18dbfmr197539681cf.57.1759215840076;
        Tue, 30 Sep 2025 00:04:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139f990asm4623729e87.38.2025.09.30.00.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:03:59 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:03:57 +0300
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
Subject: Re: [PATCH 02/17] drm/msm/a6xx: Fix the gemnoc workaround
Message-ID: <7gjolux5eowgpbptxdnuys2fgzkz3we6hznldrmfwrkpym2gwl@e4e2tpiinyb4>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-2-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-2-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfXxlCD7YMY55wy
 XTKyrGrMl47aOOfSiRYZaEIdbqH8ON3F98TlyInWg7X+lVTyetptSF05UgJDcjYxc0w76YQn4yX
 LyehqE8MUJHtcQ0c06fNgs3ySwCuCfoZQo8GK2KozJfETBMHAX0bhxjMf/BD7UkGQ1p0n14hrQV
 yHPQkaSb45kMQoX0BBnyrAv04u2L0I6UBhy0Ni4JqRmC/YnBjOoyEc4j4cjeouY937csYZoKqTy
 QVbD3zG3YQcwtQF85gWzHqNN5n5dTgedyf8ZtaoxwUqcOojuG4ofed83CQXASqPuZopn5AsNtgL
 N4ijHuI++8waryBTszwMC04b7Xkv/GcjQWknM2CdflLvO517HGwNQvdMjYe6y888KfvvczcTYu+
 jIyQ8zkJvI4r9AMPjYdRB4TlqQ9TcQ==
X-Proofpoint-GUID: CNSifW0VjR86bVQdN7_ilJ99fhmXnOn6
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68db80e1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=EdiAtJSrrEaB_zXPBFQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: CNSifW0VjR86bVQdN7_ilJ99fhmXnOn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

On Tue, Sep 30, 2025 at 11:18:07AM +0530, Akhil P Oommen wrote:
> Correct the register offset and enable this workaround for all A7x
> and newer GPUs to match downstream. Also, downstream does this w/a after
> moving the fence to allow mode. So do the same.

Please adopt the 'why' style of commit messages. Describe the issue,
then describe what needs to be done.

> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index fc62fef2fed87f065cb8fa4e997abefe4ff11cd5..e22106cafc394ef85f060e4f70596e55c3ec39a4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -485,8 +485,9 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
>  	 * in the power down sequence not being fully executed. That in turn can
>  	 * prevent CX_GDSC from collapsing. Assert Qactive to avoid this.
>  	 */
> -	if (adreno_is_a621(adreno_gpu) || adreno_is_7c3(adreno_gpu))
> -		gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, BIT(0));
> +	if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
> +				adreno_is_7c3(adreno_gpu)))
> +		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));
>  }
>  
>  /* Let the GMU know that we are about to go into slumber */
> @@ -522,10 +523,9 @@ static int a6xx_gmu_notify_slumber(struct a6xx_gmu *gmu)
>  	}
>  
>  out:
> -	a6xx_gemnoc_workaround(gmu);
> -
>  	/* Put fence into allow mode */
>  	gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
> +	a6xx_gemnoc_workaround(gmu);
>  	return ret;
>  }
>  
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

