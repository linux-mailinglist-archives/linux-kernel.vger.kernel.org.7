Return-Path: <linux-kernel+bounces-760610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53528B1EDC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C3E7A7C36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C618871F;
	Fri,  8 Aug 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SENV1KcE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AC7082F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673748; cv=none; b=sg+JMVS3onRuS/0RjJ8HV5nD9DWX0QMslTbBsTyDeSz1l8MC0YGZ6BsW8+BlAhv4vFP6hl7inqt+iUyeMB0uX0Df/R/Iy8jIvfv3aWO5v24oCVVkvecBfvu9kr1qB/arOrfcKTwx89JoLg5vYfslyPqFohcToAMhU25UFzCCL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673748; c=relaxed/simple;
	bh=3WAdGz/hYjVsYN/qu58ud+DcdAdBOjsHo8ffxFaZN5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOTYJw2eHVt/7Wgt5x6BxkvcTatQWyLalgar1FxseMnpLEnXaYnt0cJrWRkaOT//fJ/6hGpFb6oIuJ/kvB8YH7LvJwcqhFLHoSDwLrhE/J841IOh2P3hbRd9c/J7OJharl+v1N+xicnyA3BPofK6Q7DQz7tY/f33ga0uZY+PcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SENV1KcE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578EtEen022513
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 17:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jyBcXhZj2R8UGlkk97Lt6qighcQ9HpYxu7rqj/QliiY=; b=SENV1KcELHeGZRqf
	IjVMPy8ZWUeiLQ9+XVXT2Zp/RN2dvaXHHww0ldnOYODlJn+b1e4NdpvZ8Ey2bKZB
	2Lpvvn7SkQs1xRzHkfMY8AujzQ256aLJEb/fu09g77Xg/7znQPZw3y7Roa2v166I
	kVdyoDW6bRGVl1mRIV5tYIXvGqG/InfGDP3sKL9AXYFjpMHnM2B2f4m4ctKPJiDm
	mMySRYZvJoslz8SBkVrZ0U9fQ6HpgiPBI7/0OWBmts9g1wVsxCJoebg9WVMrXbBn
	4iODIWDyfbeLZaNPu9OuzRbzcUPr8BRHFzFy62/v2/TpvLSFvMdsf0nn9MOa1V1A
	VmuGhg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cs5nd25b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:22:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b38ec062983so1887631a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 10:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754673746; x=1755278546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyBcXhZj2R8UGlkk97Lt6qighcQ9HpYxu7rqj/QliiY=;
        b=e2mw1SlQCIdVQqPPinCSDfTo5r9OlXuZzzW6b4ldD/u0QHQoujAehywzqrE+6C7NbS
         APgoEOsRl8mdgrwUZ2tvz2+uUdyFPJTI5g5+WqFwaOamGlHQpESBk+XZf3CH2vm6G458
         jC2eGKRPuf1AV6JQrk6qu/sW5jYt99J3VaX207Ijlf7mJAGsguykT1imxzHuYYa6gv3K
         6xaHJwo8ubDHCRFxyFPf3boJY9Bb+sH0C59O9hbvh+KvuDFAhbewENMSQgqGKSNHGqg8
         8QNRwI9AjX2I0BbPh5WujkHLlEKxK72ngfTKlE7o8BuFPvR88rDxQsKWuhtHbNStfj1m
         u3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXaBGlNqoPTSk3wEs722mw1stYNhVgRK1jgwiAI+UYZaJOgyW4O9ZkI4XvkPIH5LvMMVM4lfD2HxXxwcLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/NUorE4WE0WouwQCh6j8EfNJ28zusXgqJHc/37oFfQ+ftuLv
	HK7GsgQCsg5WOK+SvWtmyG9meRVm56vkixeAvTHRTpSuJTfLyXXP+qIxKiMSY9trw+dyiu5Vdqb
	gF9a0IUMFF/nd9wQadtKLJOrY7xIFT0m+fEfad7jWnMz/lUq4msbsOreGqoG01scmyOA=
X-Gm-Gg: ASbGnctl0ZOzjbL5xJjL+77YtKRElIdsptumYiULH/BX9QjCtifWJnNFuKXsMGg5WLo
	FxBcROALTqePGYDtpgEuo7EB4TonohPWRV06zjXuG8FwumrOa0U1XNlrZhfF5GDiFbxAPYgJj2l
	+cWjRmV7JUxXnQQuEhN5nsQrNwrxM6koGIDoEgMwLW1HdOrsDb4bgTSqz4J71IH6kg4cuX4wR5H
	jcsLW65r2rOUF15Eb5IMHk0fqbQCoEUHB0nJ2WcnBtpiChkxOUTDMK7zjbRUKbLH02MpKloDXja
	VsMsZCLdfN4at4/iDv3ZQnlbIBlWm2s2EvLZA3KcrKszFewO5IeTI0rYk0TJrL40
X-Received: by 2002:a05:6a20:7d9f:b0:240:1132:6f0 with SMTP id adf61e73a8af0-240551eeac0mr6475870637.43.1754673745703;
        Fri, 08 Aug 2025 10:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi0ezLAvd5RkULpFWK7WLTaadsd+/Ps2gsqlHJKq3156s96y5T3Pq4HOvg12o43Wrff+vHAA==
X-Received: by 2002:a05:6a20:7d9f:b0:240:1132:6f0 with SMTP id adf61e73a8af0-240551eeac0mr6475822637.43.1754673745264;
        Fri, 08 Aug 2025 10:22:25 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.234.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0d14sm18058211a12.41.2025.08.08.10.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 10:22:24 -0700 (PDT)
Message-ID: <ba1d97d0-3420-4cca-8823-4d27cbe7bae6@oss.qualcomm.com>
Date: Fri, 8 Aug 2025 22:52:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] drm/msm/a6xx: Fix PDC sleep sequence
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-5-9347aa5bcbd6@oss.qualcomm.com>
 <937197e9-09dd-4f3c-bdb4-4001f5217c07@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <937197e9-09dd-4f3c-bdb4-4001f5217c07@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Q+XS452a c=1 sm=1 tr=0 ts=68963252 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=YZlS21pjlsXJIaRBoB+Oqw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=g_v6zqOf2VaQD3ULXM8A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: Dkv68EAeFkimVdSPM4ZVu9iQONRaQ2bz
X-Proofpoint-ORIG-GUID: Dkv68EAeFkimVdSPM4ZVu9iQONRaQ2bz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA2OSBTYWx0ZWRfX6BA6mb9JKjld
 MULjoilqy7M+h12Ld2O7qGm5p365hrUPbY8z5hzzf9v9EnApWfipQUGfV+sX1O41XtZb+GRAuqV
 PARJhDRafyO4bj7eA8ucnerAiNRUgnHR/QUjzt0+Ftw/Om5xKEBrz+YvIoamQbd+gLnPfOhHUe1
 u5v73dJn+gmrmQNfA8nlwKNxUJq29CU2WVxFGzhz6bFLOzfFRZ+Kjy0379WsV8+pR36/YGJ3Hr1
 jjLLlSojjdqgMb0/oEc5G1UVhJAAggwlABy+dOIXyMtJibRZWiMaT/zoKT0IZuOzjV7PHUBU02U
 gRnmJRwsk0sAbhGbk/TtsYs5RlmU1CMnLPNunZJnyn/68sK9u4Ey+FInTWEfrID3ArcCPEhFmZY
 FBwWQIR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508070069

On 8/7/2025 7:21 PM, Konrad Dybcio wrote:
> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>> Since the PDC resides out of the GPU subsystem and cannot be reset in
>> case it enters bad state, utmost care must be taken to trigger the PDC
>> wake/sleep routines in the correct order.
>>
>> The PDC wake sequence can be exercised only after a PDC sleep sequence.
>> Additionally, GMU firmware should initialize a few registers before the
>> KMD can trigger a PDC sleep sequence. So PDC sleep can't be done if the
>> GMU firmware has not initialized. Track these dependencies using a new
>> status variable and trigger PDC sleep/wake sequences appropriately.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> FWIW some time ago I made this patch, which tackles a similar issue,
> perhaps it's a good idea to merge both:
> 
> From 7d6441fc6ec5ee7fe723e1ad86d11fdd17bee922 Mon Sep 17 00:00:00 2001
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Date: Thu, 20 Feb 2025 10:28:51 +0100
> Subject: [PATCH] drm/msm/adreno: Delay the Adreno RPMh startup to HFI init
> 
> There's no use in trying to power up the GX logic before we're almost
> ready to fire up the GPU. In fact, with A8xx the PDC and RSC uCode are
> loaded by the GMU firmware, so we *must* wait for the GMU to fully
> initialize before trying to do so.
> 

iirc, this wake up sequence should be done before fw start. That aligns
with downstream sequence order too.

-Akhil

> Move it to right before HFI init.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 12 ++----------
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c |  2 +-
>  3 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 28e6705c6da6..3335583ada45 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -513,7 +513,7 @@ static int a6xx_gmu_notify_slumber(struct a6xx_gmu *gmu)
>  	return ret;
>  }
>  
> -static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
> +int a6xx_rpmh_start(struct a6xx_gmu *gmu)
>  {
>  	int ret;
>  	u32 val;
> @@ -842,19 +842,11 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
>  	else
>  		gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
>  
> -	if (state == GMU_WARM_BOOT) {
> -		ret = a6xx_rpmh_start(gmu);
> -		if (ret)
> -			return ret;
> -	} else {
> +	if (state == GMU_COLD_BOOT) {
>  		if (WARN(!adreno_gpu->fw[ADRENO_FW_GMU],
>  			"GMU firmware is not loaded\n"))
>  			return -ENOENT;
>  
> -		ret = a6xx_rpmh_start(gmu);
> -		if (ret)
> -			return ret;
> -
>  		ret = a6xx_gmu_fw_load(gmu);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index d1ce11131ba6..309305298a45 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -216,5 +216,6 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
>  bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
>  void a6xx_sptprac_disable(struct a6xx_gmu *gmu);
>  int a6xx_sptprac_enable(struct a6xx_gmu *gmu);
> +int a6xx_rpmh_start(struct a6xx_gmu *gmu);
>  
>  #endif
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index 8e69b1e84657..9ea01daf2995 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -910,7 +910,7 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state)
>  	if (ret)
>  		return ret;
>  
> -	return 0;
> +	return a6xx_rpmh_start(gmu);
>  }
>  
>  void a6xx_hfi_stop(struct a6xx_gmu *gmu)


