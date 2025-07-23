Return-Path: <linux-kernel+bounces-742293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB5EB0EF99
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717FD1894372
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE328B7C9;
	Wed, 23 Jul 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RnAwaWWL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA2289E33
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265958; cv=none; b=aWOTWI5cSdFcazYVca+JzomkreGswPFHPYXJJbetBvmHvxFccRX1DcjXtXCwgn+2zmloxYkeal/Zk56QEGCKvokwQklVlq7QPU4MFL/MdMPpSuWyy1DG3vpO00Zr/zZHj69BHG1fSAs0NoMIi2iYAnGCrM/5y5B/Omb+qLsyjt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265958; c=relaxed/simple;
	bh=IZScodl0d280cLNmqTN/R/W3z9m94O1zjZPO497+k2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KREqMGMwndnCoUYxHiYIbawXYATBCGjHMQaPxcTw9XooSmjW3KgeUBdUNvs7Mgk/tsYmcvmzbpAlg5IHFzmzDJ/jW3XumnGNbFunAMoW1vk29hED4gkMZeqZWHIuNzNXx/6KepvK/yzgKM9cYx5WPLDnVAwHnR5d6Yr5fnl8VyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RnAwaWWL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9Xmnj030815
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V17Z+d0hImGw2HvJRpGbhQVJAXUpjz394Odn/ptEGBw=; b=RnAwaWWLrHfE57XP
	nhj6x2QQPoD0TcW84iojwQf4BBA2WEsS5cttmXK2FdIjSA+riCntCZiCKC2vg1Js
	IpksfbZV7Ad6pToZP+t7Mw2fJ6MvMvmZh/BWcwE8yqrp3yanbkkYeNryATXoHcHk
	dfBBeLCnTVuEww5C9k+w2xGmx3sn9YEIyrUJSwilwzEDrwhqthlc7sNRhCe5GWTw
	ZfL0SCHyrQXLXXmd56ZetbyAG0cqU8JcELt2s4jX67XLkIgqWe/T2sv3SqCAg1Pn
	S/59z4TzwKKSUo8n4cn9YWzVxSfth1i2SR32ErWs1bokUchZPyw/6bE1sWhv/gaz
	kaxmeA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s4shn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:19:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab61b91608so5814621cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265955; x=1753870755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V17Z+d0hImGw2HvJRpGbhQVJAXUpjz394Odn/ptEGBw=;
        b=E4W5dcpRLzbDUa6bGu5qXrPrII6uWpqMv0W2zOJyYLe7uWeop+J9y+HoJwjzQw6A2b
         IurwsTPEG0R+mGcRQgFsDwzogASyK0QwrnUazUKPbSHEh7Hh7YPOyEfnDemmScobIns3
         r/YWAvfS4IX1+sfNx65gGpXVMvufay0Pke98o3w4g9nTztXA4iYeu/2KWWtR1bZSv8s+
         QGeQc5GlNumjO8k52N1PrUT42nAF79bB+Tz0Y15HDhNm9q9Oe1jxhACvmMlXvhYbVhM/
         G4aUQRjAG2u5DX649bP9GntNIYCqR2odGgyMF0xgD5oIgcARbtKXI9eJIFl0NVqdcrt0
         vSGg==
X-Forwarded-Encrypted: i=1; AJvYcCUciDrNAi1oLNpUG08n4KBwxqA62j5KjiNsPISoIlyeltl+TcdyTI9coYYuWxNm9r21WfJwkJpEweTHGhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8DDTlkBDCmX5eD0K9f12nFtoOebjMp7g8Tyu4GqYUTDdD1jm
	LDgb3ATReKeTj2p5V7sxxxkC/sUTk/4AABNQphjEI9zR4FfFTtj1uZObAGMKgMiNOvQJEjNSzXd
	p6iRhLKRa0OyJIMEQWgVfPbH9QzyMaJuCT+yYVzXpdKN88SLpJy2zqhLZ7o3eAfUTsI4=
X-Gm-Gg: ASbGncuh9CCvRXGaOoX55pbWoc6738LvVVWVfjwPw2J3Km+mrHPETusjYop3LSzxbIU
	M+zrdDxsJXdEtqPHrnsE5yZ5/w56V1rLpEoBigDlOvBlVN/055gd013b5YwKhjythbUZ4UZsN0s
	aEQQjYNrfdMjY792XdXsm2AHbxURpkTGpSNCSqnH77nGOHBVhUAM0hlVFAwX/UdZJxJbSi6lbyx
	ilwXMOVJ8FdPalq9aNtOseoVPIHxJwJFeDzANzHQ8wHqB0Nkh+znCc2HxZUCBgvgHfGb8A4h+wl
	wEfm0oAVVrpHmpsq94k0n94nsXvCCP/w6nfybvzkmMuKJK1R7rU2oJt3fIoSdRl1db/3dekWQma
	KoSmIP/7U6OeT9NxEEQ==
X-Received: by 2002:ac8:7d13:0:b0:4ab:5d40:6f80 with SMTP id d75a77b69052e-4ae6dc82f5cmr14375701cf.0.1753265954950;
        Wed, 23 Jul 2025 03:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFby7S9+brNY6voLnyjlEtGVWjDtOvm42SqEKk7jFypebfRo0SRww046lz8A9ap0ikYoNWxlg==
X-Received: by 2002:ac8:7d13:0:b0:4ab:5d40:6f80 with SMTP id d75a77b69052e-4ae6dc82f5cmr14375521cf.0.1753265954448;
        Wed, 23 Jul 2025 03:19:14 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c795282sm1025387166b.6.2025.07.23.03.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:19:13 -0700 (PDT)
Message-ID: <0a2188e7-3919-48f7-b5c1-8f779f617f28@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:19:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] drm/msm/a6xx: Switch to GMU AO counter
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
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
 <20250720-ifpc-support-v1-9-9347aa5bcbd6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-9-9347aa5bcbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4NyBTYWx0ZWRfXzxYQN+tzPZRl
 wm8Z2PpwyYn9Se1CsrT7daOYwYkG7EpEePcs7Dvy0ux1DXugtevThomyGBpwMSeAsKH8ApR9Ec0
 +ZpSP5SQXBXElEMj8e2UnmC4+3DQejBMeEeroPQIo6MoRI6cbEBAozSwC9ntMNARbGvw+xvNFuu
 uOIpBEJKxtDkksO3YHTKJWiZwb4FziMq+T0VW9MV8DudP1PDfs+PoyjrpHWxjd2p6T7AmcQG+IK
 T7PopZynB9AHu6pa0Qn4C1zgCyJ7Wfc8gfBm2W/6CF3LQydaN4b+uP1scHM02kxa6B0tCCulKue
 qE7eCXF2H0cr20UihMnlUueZCP4D6Qau1V+6g6lp6cpOVgPZsGmywo/TwzxRsBUrm/TTJhQ094j
 +cB+K0r1SxEgcQZP9VgbL+ZTP18UNFaX5teNRlfV2XKla1iDJA7twcibUBF4ofZwALy5JOWP
X-Proofpoint-ORIG-GUID: sY44EwvmCjc5VnhVsxKZwSm1PchKx3-J
X-Proofpoint-GUID: sY44EwvmCjc5VnhVsxKZwSm1PchKx3-J
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=6880b723 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=oovjfIWShZiszQ5o9iAA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230087

On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> CP_ALWAYS_ON counter falls under GX domain which is collapsed during
> IFPC. So switch to GMU_ALWAYS_ON counter for any CPU reads since it is
> not impacted by IFPC. Both counters are clocked by same xo clock source.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 6770f0363e7284e4596b1188637a4615d2c0779b..f000915a4c2698a85b45bd3c92e590f14999d10d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -16,6 +16,19 @@
>  
>  #define GPU_PAS_ID 13
>  
> +static u64 read_gmu_ao_counter(struct a6xx_gpu *a6xx_gpu)
> +{
> +	u64 count_hi, count_lo, temp;
> +
> +	do {
> +		count_hi = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
> +		count_lo = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L);
> +		temp = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
> +	} while (count_hi != temp);

The original logic is as follows:

static u64 gen7_read_alwayson(struct adreno_device *adreno_dev)
{
        struct kgsl_device *device = KGSL_DEVICE(adreno_dev);
        u32 lo = 0, hi = 0, tmp = 0;

        /* Always use the GMU AO counter when doing a AHB read */
        gmu_core_regread(device, GEN7_GMU_ALWAYS_ON_COUNTER_H, &hi);
        gmu_core_regread(device, GEN7_GMU_ALWAYS_ON_COUNTER_L, &lo);

        /* Check for overflow */
        gmu_core_regread(device, GEN7_GMU_ALWAYS_ON_COUNTER_H, &tmp);

        if (hi != tmp) {
                gmu_core_regread(device, GEN7_GMU_ALWAYS_ON_COUNTER_L,
                                &lo);
                hi = tmp;
        }

        return (((u64) hi) << 32) | lo;
}

Doing this in a while-loop almost looks like you want a lot of time to
pass - REG_WIDTH(u32?)/19.2 MHz

Konrad

