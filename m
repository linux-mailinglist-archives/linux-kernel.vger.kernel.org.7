Return-Path: <linux-kernel+bounces-898615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91122C5598E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96D964E4B61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E0E295DA6;
	Thu, 13 Nov 2025 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E2ibn0Ny";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RRki9Dse"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3292877DC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763005840; cv=none; b=r0JgdypnHto2HOhDo1KyQdK0rCN6FpNIuVcIup5Pf7Zjq9C5inmP8bWvpD6/cEvx6hVRVHyHQw6HyGg4+0wbNDvtU6Zmu+8k4H7+geD+ThdLNOxE2PJfF3Tx0iuu3lTuUYMZqb/fJiauLoPOqqERutJY1FlbdXmCqhSpL5GqX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763005840; c=relaxed/simple;
	bh=6M1vecMqKiWdmjUo6/b6CpU1SEobhoEpqL15kBJf/kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8/N9glVJZkH2AQZowNZG/uQnj8gaftXGYn4Mzfuypcq1gkNW//VucS+o/lkBWUu/vq43qYqsXXao62xut0UBgzzhPYT/59unBmo62TfnqDqB+ZKYqAgqzIAaWFY3kZXVb2MGzq37xByyNJqdOErg+HH6iGuXoVUvIUmxBvEgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E2ibn0Ny; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RRki9Dse; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD11OqR2993501
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V6gfFLOMNYMkWUfdwrHHvmuf
	2M4FWVMTiIkqm7l+1fA=; b=E2ibn0NyZbA3Ts+3iEG8rYsonyqGqBzb7Ro76wZb
	zZI6L5WNFI2zNwHFMTt1D3mIn9JJkfiezHMBwBbUCufUcQ52HHeuYSd1IGIbgy0/
	i15vALVjKL7pBHbSItp4nT4HPtQPzOTuiTWmS2Hahj0/nmRjhSWHhrTIs6FDus2Q
	zUTOp36uw5ratHgr1ZWk47v6meB2RtMc4I6Cr2gKtG160X3rO12oU16zHLyahNMu
	gut8iqAP7KRZaFGftoPYKn9K58Li8a5M9ARctTc6gEhu6JIYX4PR2UfxXw21WY1y
	WnAKCz9A95GPo7BfBo3BIX+rps6T1yMgr1Y9Bf3lr0zBzw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad47jgn03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:50:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed6ceab125so11748531cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763005837; x=1763610637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6gfFLOMNYMkWUfdwrHHvmuf2M4FWVMTiIkqm7l+1fA=;
        b=RRki9Dse5ZgJ+FyoHlhPfLRmMPj8xxPjefS/w9IYIiflM1ySvQDgZwplTIacyff1jT
         YzyRHlnGUr9VQMv498jsv0nSKVC/Rni7YkpHQSh5/BuyZvWzgWzY95oCS+cyYDn4AWDi
         b97EAk3xEX/X7nV4GWbGgYlYc8kBjywXxViG59pvwpsb1/HkTEIlZDknSiuH/r8bynkF
         QjzyDlLqkxfcA4U72dZTGR+co6QovNyDFF21EIBtpIobacPhX4qn+5M71CtAf3O7rbVG
         LMv3tIGBGTDVc+LXNn4TgN36sjtWEdu4SaKf28ckZQlI/O5NSt6bt8DqvLr7fJqh3FfC
         VimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763005837; x=1763610637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6gfFLOMNYMkWUfdwrHHvmuf2M4FWVMTiIkqm7l+1fA=;
        b=uTMKZIvU5iMefrekvNaew8xycuGoO43NOtBVHOoJUiq/5q/7xNPCJBZy5cvkoWmYYj
         aKLpFcPVFYqMPNKWWH1/skHHOxKFW5rBUCi2HZSOly6ixPqrXS8ozi9gsDFRjFF4A66x
         OoCJ8FIwQcD3jbBHLdl3CpcJMULaOK1Xk9anL3I3ylxdQeBWUg94QSI2gSJXcwaQKoBZ
         8exUWLl2szuGGKSW0ezLmlyt+c5gBYjSNbVGKgnMRPiZxvFCeZ2IxCkRF3xAr163aYjq
         U8XzclFcYNX4WdoO8a6ryHNg/cs1ozrRgT4LQLbA8TcPHRxNHbRDOVlgHJaZq4KYbvZk
         VCVA==
X-Forwarded-Encrypted: i=1; AJvYcCULUFhDrwjtgaRwk78Z4Stq8G2AU4UcIPzSeY0kKBHW/wxb3v5J/LfSzP7PDRUKA4aJItm6u/BQThczpss=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5RXNAz17WbV3dujYmRKVR1T+WUZ0CtlVvgfXIc3cF6TPTAbp
	15KBkFynxevNbSETVev8ZyAHnPivAPkRiik3pL1L3/II2VwqUyt+P/ZfcgL82n5upk0S5zGmGS4
	UusxJxMo/pyY1EkxjwxlvlXfGSrbu8566KfpbpwVMpAXnT3i0eovS+d/5nwqOs5hmeSs=
X-Gm-Gg: ASbGnctP8DV7QPcDDl1PPPXMg/yUkXwyLdn9vcRB1xnvnDR/UFvQ10QZJAyfjv76yPL
	f1HWvJHORCwEZcLUS4eO/KzHhLxFWB25/QXs0/iZ2QA2WZgrrG7/2gr/qsIJnEWdCAFJBp/7w3o
	MsCCKep4shzx0Ayf1uLg3gJaJ2M1rakaJvHXYaT+yyEpLS6EeheYh299HEYVWqSkPkj0kOTt2qc
	4Ibf+c7hfEj/aYfzD7n2ncxT7A79tltMY7Hp0hWPUEi0cp2HX/5nUOJf21j+neeKuJ76i71ELn8
	N2XAR9X+CvINJt/Fpg69jA95c+QD8AOzY3pbidtRks9xKxe6fo47Tkx18iB+BCxB1i58kbZT5Oa
	eK4KKJW28jta32r0JaAWHoIZZzV3Ex4amzpahi3DPimMp7EVI5e6X9V1AdbDDqze1TkzwCz9eWj
	01qm1HAK4vU9dO
X-Received: by 2002:ad4:5ca6:0:b0:880:541c:8243 with SMTP id 6a1803df08f44-882718ce64cmr59684806d6.1.1763005140637;
        Wed, 12 Nov 2025 19:39:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLs3C0c93KWlGhuQL2zqwisxhLVaS3eXXtyZ+U1XHiyIF0ajQExCpK2eFHj8X6rYEd79M4mA==
X-Received: by 2002:ad4:5ca6:0:b0:880:541c:8243 with SMTP id 6a1803df08f44-882718ce64cmr59684426d6.1.1763005140130;
        Wed, 12 Nov 2025 19:39:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595804057b0sm118302e87.85.2025.11.12.19.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:38:58 -0800 (PST)
Date: Thu, 13 Nov 2025 05:38:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
Message-ID: <os7rpbynyoeolwvbrocx3yrrxzhextx3srywal2i54jj6dw3mw@n6fbt3pzjvj6>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
 <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
 <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyMyBTYWx0ZWRfX7wIjhnv5Gds3
 Jc1y7mcq1C5d46ljmTCNb3O60pVyaOl0RA7Xffso3LRCwq2s4I3AytIVDUXUyARxFYGrHKZJsHd
 nZHgtXz33GM3CKr62lBRrNQhnel/GeGycte2s59OT3HCNKwUUTuKXR7M5fsuSyenosfYoiBtsv0
 jKDhUrzMPs4uuS12oEMrVW9Mx6YAwMGe/iXDSrRfRe3mpuVDdWkEsmZSplith718aUgrcb62i02
 gHop4z4qTFBetFms2QJ7FBCyNZ+M+MIfCrWFK3si1R7zmxcQozDzuD+7hWuYXxZGcR9TVWxnXCG
 dkF0aA2v6Gq3yNmUUe+xz0slwUW6JPPjtnJ9SCKBgCfzf3/gs0QZy3Kh+IK8Bl++jWzbVrMxDtA
 ea5GFzu+lgeyJICzpKkkWVlMXMDljg==
X-Proofpoint-GUID: W_TtMHs308uos2KT8sv8U1oYriKdTuEr
X-Authority-Analysis: v=2.4 cv=A5Fh/qWG c=1 sm=1 tr=0 ts=6915558d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=CJ44idKeuHZi8Vt8iyEA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: W_TtMHs308uos2KT8sv8U1oYriKdTuEr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130023

On Thu, Nov 13, 2025 at 03:32:51AM +0530, Akhil P Oommen wrote:
> On 11/12/2025 3:52 PM, Konrad Dybcio wrote:
> > On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> >> In A6x family (which is a pretty big one), there are separate
> >> adreno_func definitions for each sub-generations. To streamline the
> >> identification of the correct struct for a gpu, move it to the
> >> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
> >>
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> > 
> > [...]
> > 
> > 
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> index 44df6410bce1..9007a0e82a59 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {
> > 
> > Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs
> 
> Could you point me to the holi's devicetree? Currently I see only a610
> (sm6115) and a702 (qcm2290) uses gmu_wrapper.

I don't think upstream was ported to SM4350. SM6375 should need the same
hook, but I don't know why Konrad didn't enable GPU on that platform.

> 
> In the driver, adreno_is_a619_holi() checks for both 619 rev id and the
> gmu_wrapper.
> 
> -Akhil
> 
> > instead
> > 
> > Konrad

-- 
With best wishes
Dmitry

