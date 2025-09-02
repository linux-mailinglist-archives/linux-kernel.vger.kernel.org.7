Return-Path: <linux-kernel+bounces-796435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E21B400AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B2B1B60678
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B951221D88;
	Tue,  2 Sep 2025 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JrvnP5+t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E421FF50
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816392; cv=none; b=upSySRLRHgCN/4JkXR+eTisv1STEg6H+pJ3fKUu9jtw9E0losgSkU0Jg7zI3TVu24YBuP0UhwA71I0peXUTyeiIGFfAsWyE0dL6tZxRdZjJ0OJ8P47znDn5qJSz17+R0ES4AvkqdvRt4NOIUQy2xkX/BZgpjX3a5NDVrtW2/Zq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816392; c=relaxed/simple;
	bh=hhZxouj/zGjuFf+nEsL4SNs0kjckAEOFc/zIo2HWuMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4lGNbpa5x26KpKMebL7a9JmMy1Rs57UGEYxSIhZBCu0N8Bb3YJmG1zmDIJ5bB6stclsOiEI4UTgcijT4ECOmlj/naaFyFbAl/AJLpSr5LjL/YxYtaUBlG5ED8bRMEvXSfqMnEo/MbtYzxX4OkbV67uHYpVHxzgqlQaT8Yrn7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JrvnP5+t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AVlRD025749
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vSvPlAtycm0pq6Ig/4XPFbNEtXJ7S/Va70A53TQ5/A4=; b=JrvnP5+tLTWa98Ty
	yumJjQYn3dO0XnbKa5+FlBG7AHsOP6WEPFza7CP86KjUy292hW/VGjv0Z/fZqNmV
	0rvKK7CR/TlEESvwdAlnMBMpLvMwcjRpD7Dx27zkOSdeD/g4tCnTekR3VhJF7n6H
	VVSf/lt+s7aKADlobM5MeekYXFh/pxhHgUNInvKRdyX3683BFfIBjP5JOCXXMO+n
	ugzYWbBvv8Z+DY8ia+3PXOLCJZebNTnnLi/ahpupXgoNjlRZrt1igtgO2SJfOcoX
	NAt24AC2+I5TYLwb2BwI5xHtH6xdSFQ5f9FWnr32FeXAJ0jkMqe9UGtCdWnKVXmf
	Phq/6A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuytbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:33:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3387c826eso7436191cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816389; x=1757421189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSvPlAtycm0pq6Ig/4XPFbNEtXJ7S/Va70A53TQ5/A4=;
        b=DR+U0DXptMYKJbbXXVZ3HbdU6p+vn6cFY6z0lMjMYa6EfIRPpVrjCF6e2YcyyUG9od
         N7k9Vka+PcOnvIKOCi9qwnrX22hh3Exq6ld7StDeB/21H5tK8noKyGIWxT03vOFIxXrE
         e0Y1/J138bsDxC8KoHT7EdYYPVxZQ+tSjvqwICLvCgW4jm8uYpDvNai7SHfYDQHk96Hg
         q4rW9Pu5T9pxjGkrRN7TbcxpHKRUnYSwD3a6kIsUXFzx5YDWidfj9j01YNWjQ+j2SK/p
         Jo1pZkbG8uLWIi0E8G0tvUqMU/cUCy2JCIPIE0Q/wavy3KiVut8N46kdbcZwpfJjJiiW
         bt+g==
X-Forwarded-Encrypted: i=1; AJvYcCXJxAOixGW7QumazQsU/qCcVsGmGqSaLf0tkym9ip+yIBPLtp1exSD4C3CIZOo4JEQqy4+kZiR2524eqaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwfgOCIOsBr7MLrrfYCEtiDXXOjOhD3dvaaNSDeFXZQD7RejD
	SgKm2O+hi2GOB1KjY9ADpPUkfB/tQEN/QwLDFETDYZgy6I5Vkog8c9sOnxhUwNoRjWz4fnxBWK1
	mCfJb1WhW0KimH41pdQ1CrEGmuRO0MarsR12XOoya8OBNrYeunJ58WxwikXvV3/asvMg=
X-Gm-Gg: ASbGnctLoz91pOTCb+9rtl0qMmLxOv7Up7kdJQpjTeE4SzzhVLVsAY+ZnM9cVnpjf99
	7/MyNxS+TWCBe8o/ObzY7RtTEN+rgDmWVF0WcpSk2zGM4tZWq600V4N6yPdrkCPqcvkb9V77y46
	V/GKaWJwGdiQ1S8eHJ3fT0yE9ihvMtYho96hNSusdumhtKkTulPiS9rWVHf9utboZ6rAcwnA5l6
	eLB3EBdcQ/kRMViPiXW7tjoZDSIkF3HfwTxLOlk4P84ojn53zN6uBV9eAkBJ5PTZQ19/8OQG4Si
	REhVvMqZ5Fr55Wck0+Z/IKfu4xCc/vRcMYVuGCF7nGNJbrv4J/ioZjHDXptJ5eUljdDi63QzwNa
	A9Lb/JP7EwtWGTswHOsZanw==
X-Received: by 2002:ac8:5d87:0:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4b313dd02a0mr101705891cf.1.1756816389190;
        Tue, 02 Sep 2025 05:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFygbSXPmg/W2fjM/6E1xOIRsZDrVD2qEEhASg0Xx0E83kK/rba5OZ+uTMQ8o+BQvRuG1WRPQ==
X-Received: by 2002:ac8:5d87:0:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4b313dd02a0mr101705591cf.1.1756816388644;
        Tue, 02 Sep 2025 05:33:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040df6e19fsm723031766b.100.2025.09.02.05.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:33:08 -0700 (PDT)
Message-ID: <694f0989-64ea-4c3c-8613-863da1dd286a@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:33:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/msm/a6xx: Add a comment to acd_probe()
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
 <20250902-assorted-sept-1-v1-4-f3ec9baed513@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250902-assorted-sept-1-v1-4-f3ec9baed513@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXzWhwh9EA5s/p
 kol1qSLGQqNJDWMIpqNTuAT76V58Al/u5uxgePHentRT87y5VUZNeCKKYbb898H+k3T0pNmSVnG
 f6mTEsv2tfkOkvMyTGfkL9Z+uOwFqrcZlCv5WhYk1QSM7/F2qK2LCUs3n04Upfk+PSrMRSF30aw
 /Xpm/Xcm5kzrvC4nVQbrqdJcpUDU1g5c7yindEJL6OcOVmhWj8/uN0J2nDRgLmqss9gy/iqVd5v
 d9cmdcchl7/zQUlIJSJ6dSv5gMEjhnEq9xjh3g8hxQ5V6hEqDuEYQLqeWQkQgZQin5jVxQGgtt+
 wwwQ/js5LyhmatexEv4OujsrYdAbjI+S45COXbCsky73EFZ1n41zOkmoYolF3i4mOfE4TEl6kjk
 w4HlqetP
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6e406 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KrKh6rb5Vgb6-fdLxr8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: rjaEZQEc7AIiU0JXE3wv4L2LHTfFSgwh
X-Proofpoint-GUID: rjaEZQEc7AIiU0JXE3wv4L2LHTfFSgwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 9/2/25 1:50 PM, Akhil P Oommen wrote:
> It is not obvious why we can skip error checking of
> dev_pm_opp_find_freq_exact() API. Add a comment explaining it.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index ea52374c9fcd481d816ed9608e9f6eb1c2e3005a..de8f7051402bf0fd931fc065b5c4c49e2bfd5dc7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1694,6 +1694,7 @@ static int a6xx_gmu_acd_probe(struct a6xx_gmu *gmu)
>  		u32 val;
>  
>  		freq = gmu->gpu_freqs[i];
> +		/* This is unlikely to fail because we are passing back a known freq */

This could probably mention that known == we just retrieved it a couple
function calls above, but I suppose the reader can come up with such
conclusions

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

