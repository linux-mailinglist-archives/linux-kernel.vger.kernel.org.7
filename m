Return-Path: <linux-kernel+bounces-771509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26647B28839
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712D41CC76F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DF423A9A0;
	Fri, 15 Aug 2025 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZYORBlw2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8391922FB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755296130; cv=none; b=ElqZeCKa8LlqaPo24qFg41cslIY67dERAmVsm02834pNNptxYUB3fCUbkfrBjb6uPeTTzBFRuTEDv552Zq5ERJwAZLQ7COaGfocqz94soj3lrst1dtNHhrJps0xQZzfYgrUAYbGYEoCr1j6hO8+JP6ysXiKvsIIEU9DIZjeq9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755296130; c=relaxed/simple;
	bh=nUr5qFrjfTS8YbLDUJC+wXeA3Df2CTjn/ZgcuYA7T3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HytZyCxRb7KotI/TQlfrjNY7hkETw8CR54v9yE5JG5QEMvKyVkQzaB0m1pVCYhcvq651pDUiBlVPmdsqQRh6jjoc4Job/Jpd2kW8MVnWes2Ix936Bn5PfZxyWFqAwoxfhcpeLpAhf+yS/fxvausPITx7ioKdrCxoTqRMBEVrhWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZYORBlw2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FLnsJr000416
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vLwoZ01402e5OUdx+YObu7+diNTS+/oRxZLwC4jp6ok=; b=ZYORBlw2Y0wJA99p
	ZFQw/o9vfPMrDngZv/ZJrpowjeNtqjCvXoPnz8dwFhXQMh0hnRNlXrMyZ7OxaWQU
	2GrkL9yVwR22+jBq1SA2HN9k3vcRN8Zg9hY4rWLL4sO/VFkEjHZ0J6IjbOBKYhUZ
	2BIGXaeqjD7iN7mbiwO0wrvNv/6SBiXzY8GJ18sMTQbLE34ub381+H0PWg1/1ZKD
	Bd/ciQtTPW4pNNf+09k3IZ6mIb5jjk6Aro/Yv0ShHBGdpLSZGpCC9pHFKZ6UzQz/
	zURKTzyASfE5/CQ+uIqc7BzDHtNVJX5GGmcdh4QZYCxu1ykctE+D6vSycS+7MENN
	Z7trfw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhk04v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:15:27 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9f5b3601so55896666d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755296126; x=1755900926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLwoZ01402e5OUdx+YObu7+diNTS+/oRxZLwC4jp6ok=;
        b=CDv3H4piiZsbPRb6cO0C6Y1aVun1wXrzfuHrpdDryP8lAH9Ss7qIw76Zvn4A9rEG+Y
         PGE/9fJAQ3VwwmVlOG6zw/sehcbrp6lWCLHrUgP0hEjIT2RCMQDFSdCw0Vzvnq9aH0U3
         h0lNXy1MvYjTdMpr6JqL/7usSSVOPBbOUOOVQJ1qDUBGRA/zBZvcrs3lIE1BQ4fT2uPT
         ULZw5EIP6zcbEE9Ax7rnmXti6IwK3VzdvF+TUnW000Bb4RvURFzYVikY/PvGLny+ACT8
         edKVf9PinRLQNyyVkjfYfMPp5O1I531IbtzgW4dUKBD85K90mLt55+537VM2yufLU/eP
         SHiw==
X-Forwarded-Encrypted: i=1; AJvYcCVQL6IOTvFDUFxq4Ie61mUcxiicOaAu1joEZB/JYSrbjMPrIBGBk9fJh3UZ29w/NVnCkDgbDiXCoLqIxqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIOD2TkmivaQfKUik8IwwaaWPn9hW6m8ag3+q7RxBeta1p8NE3
	fWPvkJ5adnBAzWLey4rgiH3I019+4Qr4ydMOHZCk39SmTgxjbgLVm1chED67leahrwaawMX+bvp
	iFOJBpaB5WJ76yld8E2mukb24FwjbD8zJzLGWwjuXpcZlrhdX/g0k4oVoiupaWkZcUWxS2IzHe0
	Q=
X-Gm-Gg: ASbGnctPmJmfAiZm19Vo1YZIRHXD9kmdz+2UNcXbhdEkg+s6LLaV1UHCwTEVmPJ+VHU
	BmJmXWp2gUsWiUbVl1zEGbF95AqGAaxcoKQn26PH6971xo1ymGT/h4FRUNKuEI7gAmzAND3NR8J
	NjTi+BhZKabdgfWpWgMIhZ3CvqcaRbPvQhH9b338E1vY8O7JiH2n8CX7uPqUhOXCZL+2INlnWN2
	CEn/550R/54/LG96/gPa+aloqz4Xa15z+1/Su/wLXF9rxeQCp7YaJICSGpFP1I5+0aYrNrKrm2G
	4PVhvXoElUlO7wyPHdXSi/CYECbe17v3yf1XQ3p9nmHx2JznszGVjgsxI/rwRXPo8jl7bfVu4pB
	V7jyehFEkcKeCnuuA9zjJ32gZdcWl4EC7H4a7aNKVpB02TrA6+Q9W
X-Received: by 2002:a05:6214:1c47:b0:709:b94b:a6ad with SMTP id 6a1803df08f44-70bb060c40bmr6445206d6.29.1755296126524;
        Fri, 15 Aug 2025 15:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHetHJNt5dVNj424oIDhrEYTzfBXQUTAzwS+BLLxQUPTiMlfCIGu7YxB8m6v/QsySngCnMZ7A==
X-Received: by 2002:a05:6214:1c47:b0:709:b94b:a6ad with SMTP id 6a1803df08f44-70bb060c40bmr6444836d6.29.1755296125981;
        Fri, 15 Aug 2025 15:15:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a41d5a0sm5871491fa.2.2025.08.15.15.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 15:15:25 -0700 (PDT)
Date: Sat, 16 Aug 2025 01:15:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm: adreno: a6xx: enable GMU bandwidth voting
 for x1e80100 GPU
Message-ID: <ihpfgzrl4xizlhpm2w53oesmdhc63cwbjwq43ano7avbrd6emb@qjdgnzxsoo35>
References: <20250725-topic-x1e80100-gpu-bwvote-v2-1-58d2fbb6a127@linaro.org>
 <e7ddfe18-d2c7-4201-a271-81be7c814011@oss.qualcomm.com>
 <33442cc4-a205-46a8-a2b8-5c85c236c8d4@oss.qualcomm.com>
 <b4f283ce-5be1-4d2f-82e2-e9c3be22a37f@oss.qualcomm.com>
 <269506b6-f51b-45cc-b7cc-7ad0e5ceea47@linaro.org>
 <1727374d-0461-4442-ab35-9acb8ef7f666@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1727374d-0461-4442-ab35-9acb8ef7f666@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX5bqUaNcalKol
 A+7/9ek0ddMoOz/qaxw7eHhOjU1sQ9B0j3z8nZxlDq4u/3qff22o5u3shVSRysMl7BKmXFj4B8H
 fNhOjnWOq2s9NuIsrhHv9EcXe2Lu2dppLoxmYxSaFsxLDVIdkousEuA+p9SwgTHY9QeRYaBhwxx
 UwuIY/uYjokmyXQygA7oE01vM9bZ4Rlo/YjK3VZgXcf6Ly6LS7KgarbeykGkpTCdg2ku78Q710w
 +ja9JeL/Z+Xq51braYvmCpeW01phW2GpOkd0SmM5CDtJ80aQHGGcZvbUdnjYxPoNsCWkPmZh/yj
 dAcforKkhsLEXY39tMWlGZ4WH0AubMzKt4m2mnL0ylpWXdyakCW0PN/zANyGt64eu0l8BLGefsj
 0DV8yoM8
X-Proofpoint-GUID: v6Qo4hHgsQiZHdLxnplnC9ch1WC2nBet
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689fb17f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=2EPmbxBH5dp_UOPDRz4A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: v6Qo4hHgsQiZHdLxnplnC9ch1WC2nBet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_08,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

On Thu, Aug 14, 2025 at 10:08:26PM +0530, Akhil P Oommen wrote:
> On 8/14/2025 7:56 PM, Neil Armstrong wrote:
> > Hi,
> > 
> > On 14/08/2025 13:22, Konrad Dybcio wrote:
> >> On 8/14/25 1:21 PM, Konrad Dybcio wrote:
> >>> On 7/31/25 12:19 PM, Konrad Dybcio wrote:
> >>>> On 7/25/25 10:35 AM, Neil Armstrong wrote:
> >>>>> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth
> >>>>> along
> >>>>> the Frequency and Power Domain level, but by default we leave the
> >>>>> OPP core scale the interconnect ddr path.
> >>>>>
> >>>>> Declare the Bus Control Modules (BCMs) and the corresponding
> >>>>> parameters
> >>>>> in the GPU info struct to allow the GMU to vote for the bandwidth.
> >>>>>
> >>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>>>> ---
> >>>>> Changes in v2:
> >>>>> - Used proper ACV perfmode bit/freq
> >>>>> - Link to v1: https://lore.kernel.org/r/20250721-topic-x1e80100-
> >>>>> gpu-bwvote-v1-1-946619b0f73a@linaro.org
> >>>>> ---
> >>>>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
> >>>>>   1 file changed, 11 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/
> >>>>> gpu/drm/msm/adreno/a6xx_catalog.c
> >>>>> index
> >>>>> 00e1afd46b81546eec03e22cda9e9a604f6f3b60..892f98b1f2ae582268adebd758437ff60456cdd5 100644
> >>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >>>>> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
> >>>>>               .pwrup_reglist = &a7xx_pwrup_reglist,
> >>>>>               .gmu_chipid = 0x7050001,
> >>>>>               .gmu_cgc_mode = 0x00020202,
> >>>>> +            .bcms = (const struct a6xx_bcm[]) {
> >>>>> +                { .name = "SH0", .buswidth = 16 },
> >>>>> +                { .name = "MC0", .buswidth = 4 },
> >>>>> +                {
> >>>>> +                    .name = "ACV",
> >>>>> +                    .fixed = true,
> >>>>> +                    .perfmode = BIT(3),
> >>>>> +                    .perfmode_bw = 16500000,
> >>>>
> >>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>
> >>> Actually no, BIT(3) is for the CPU (OS), GPU should use BIT(2)
> 
> You are right that BIT(2) is GPU specific, but that support was
> commercialized from A7XX_GEN3. Anyway, the Win KMD uses BIT(2), so lets
> use that in Linux too.
> 
> I know some docs show BIT(2) support, but lets not bring in untested
> configurations.
> 

I'd say, I can't parse the comment. Should we use BIT(2) or BIT(3) here?

> -Akhil.
> 
> >>
> >> This is *very* platform-dependent, goes without saying..
> >>
> >> I see BIT(2) is also valid for X1P4
> > 
> > 
> > I'm confused, Akhil can you confirm ?
> > 
> > Neil>
> >>
> >> Konrad
> > 
> 

-- 
With best wishes
Dmitry

