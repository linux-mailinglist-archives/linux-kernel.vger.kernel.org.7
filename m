Return-Path: <linux-kernel+bounces-741011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A34AB0DE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725B37A4F32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0CA2EA740;
	Tue, 22 Jul 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RxG/FZr4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08262EA174
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194625; cv=none; b=lAVhVtyB5q0C+/QbOXbqUIX4J43d5Pq1cBJDBAKFV72Qb4/A7okJQU6QeEdluNkFZqt6ARsdQqnQ361XyWbzGW+UOuQ85tzRSItyevtbNM9D3X8RddTnbKMkAPWecsqcrDLcaQ9c3wHBL+vVenVXuYV8fA+5fw9/X5Nal70IbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194625; c=relaxed/simple;
	bh=Bxv9ni4w1PYvtb96P2XChyJnbKJIDZlbHmmvm46D96Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnD0T6E0fZNFE8oPtic8CqoFSJHdY9iFikdqZODZdD92ZtsU6PVN0t4fuDEBtu4/DTBbUUpdzqNgaNcETzXmiY/4mYORALtl3ErFqDCx8BvCP9a9DduL+50ZqdmbO1h4tn7Yu8Jepjapr1dvFvUj0ngswMkCBR5/ZY23YQ6mdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RxG/FZr4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MCSoXP001178
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x/SZ0lHFoJHSAX7MLV7k/Qc97OKQJ9c7d2vsYjpczs4=; b=RxG/FZr4xEQeY5vn
	qX0sSrMzgTq88IcR0hMrfzu1DG7zz++O/Lr4qUiZ4BpYMf1H1giGoptn5fgASdYu
	1ObLnGbCwr1ZmFHNUcOOmgpWZl25DwCALBpE2u5ybbdzbmO1VPC05IU2x5xntwY2
	9LvZmsMFtEBiobzrI4UnwVd5wAWazVZpkFS0un7Gj8j2sF23onazRJsScif5oee+
	DdN63Eqg1ZaLwfSLz8/hoH5rdt49Rib7jtZxL+HW5gCDDYuHT42RWz2axWsv5Sru
	YnJ56uXovMXv+pKNUgcbcA0r8R+R+h2H+krvNdnxXN4vapRvF8XVPE9IGygnMAZy
	+oeBJg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dhkss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:30:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6facde431b2so18296976d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194622; x=1753799422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/SZ0lHFoJHSAX7MLV7k/Qc97OKQJ9c7d2vsYjpczs4=;
        b=S2hMaARa6W4NmtzfLSoOqLaUaD+aJpjGZAzlpsX6KrbuMlHJGDUggHtpI6aOC7hRGB
         uTyKDDv0i7ZbKOAUPtrqjZ6eMF7N4j7uHZ6wPWRXqo8p2rffRk8n/lAPTAXf9WKuGIuJ
         5euCpjDaWpIcFcFYckTM9JaV7QKfcPliFNu+ckQh9zk69fZpPFCseq4pCVLhyxA5yFfU
         teOWHSaO3g1Nnfdyi4tzEZGyrL6J6htRtLg8o6MbvIjh4jMUIJb07WET50Uhmpo1bvmS
         TjpugkbxZw+NR8kU39qv8NSg0dg7VJxUShb3Wi/E7BoDZY7xNpfp1h/7xJaZnzFu69A9
         AnIw==
X-Forwarded-Encrypted: i=1; AJvYcCXqG0QYOkm44Tv8XqoEUGFxMzk0h4KX1Hqe5q4oUjbwXAmInMpc7dE44W7Qu7fE723MxXY2+3ElPScxrnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqn9kgoyAuEpvRa65qJ0GfrKGnF9ycQnMErlRx/02k+H6mvn6j
	VWaavYtdwBdjTXjwX29D3ZQ/za7bXo1jKazbtznXMSqOt9Km/EB/NUMVC6Z2ddEwisNXQcfbRVP
	pSZIXALJH+Rz+xs/kdOQ7WZ2fFfPgtyZWDPiUOoW5X6LehMsDD5nFv2QRTNkTCJugmdQ=
X-Gm-Gg: ASbGncvhkY/BGmmh3QZz6YR3ZJUngWvylB09R7YyHvKnGK+kEzQdtPCX8TiaA01b3/0
	sMRWvNM85rWUbk7dc1iEM3CSv7oUVDS13ekzwDwk0oeaipqw/Vu2a2TBJfIFz6TWzbw/YNOe1Ps
	SkgI2jGCsLlLzYR+1BnquGTl8nz2QnZoMffKM2yvk1V+wn92u42dr953UPMM3ZBsaYZF3GLC4zZ
	KPZhqQZ6K8+4L8MDeP0cDm3LKV+ICXhQUxjGCH75zazbn7RNT2Y0l7/Ea8Mvf46MqqB7dyIGf9Z
	851X0bFKJtJn72D+qdrwm5Ao0PXL+GNfmm8FXLxgSdQmyfIwBZQb5v8FLuljUEqKc0lDV8iSvaF
	FGZQL3uEti1Cw7JhLuaFp
X-Received: by 2002:a05:620a:a48b:b0:7e6:2435:b6a4 with SMTP id af79cd13be357-7e62435bac5mr97898985a.12.1753194621226;
        Tue, 22 Jul 2025 07:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELIFe7dttYXlWKLb8+yk+ojhPQpxXLFbOGTgUNnufmtAMzR7XiOb6CgD79dyMxVD6171XqNg==
X-Received: by 2002:a05:620a:a48b:b0:7e6:2435:b6a4 with SMTP id af79cd13be357-7e62435bac5mr97890885a.12.1753194619840;
        Tue, 22 Jul 2025 07:30:19 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aeefb091e4dsm486326866b.12.2025.07.22.07.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:30:19 -0700 (PDT)
Message-ID: <d4b46652-c4d0-44b4-aef5-e8bcf606de06@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] drm/msm: a6xx: Refactor a6xx_sptprac_enable()
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
 <20250720-ifpc-support-v1-2-9347aa5bcbd6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-2-9347aa5bcbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687fa07e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=68B5CXoyvkL1tjfyVhIA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: y76dN_ER7MgakMeKut6tjJKRGaRN7tcL
X-Proofpoint-ORIG-GUID: y76dN_ER7MgakMeKut6tjJKRGaRN7tcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEyMCBTYWx0ZWRfX2rTxyOXOxQ8b
 b84jekgJL7hMbZPP/2OwCmeuhSDqCC5NCxQEQEQY2wFpru7kbMR40dgzB/4tnbRnLD60e5dtk3C
 u4bbeHgoVxOsm2J696w/LUV/pXtpQf1zfm61x8ds+A99YxdoslFzYsrbBVyHmUhwOaHVilFXy7m
 4vuPQYfwtlOwb6ouOtEATorJXc5yv8Gkv6XTpXuaVFfZCaO2Tt6v587ahXiTIL6rUDNS36D7xYM
 FYdZdlimx+3QkeLcA1OT9giBzEd3NBFCcpeuSuTuJ4r0QBuKsdBzHg5r09IWMvpaDhDvYaFQkGc
 3Zipn2YaIsqacuQ120QCV+aSvGy0j05xjm7bKSPFktGpyAqON+kW0XKtAJRNx+QXty31f/PhHc1
 pumc1FJ1i4R8OBQsPeRBQLfmXI3QK34i/EPyuXJC4VFySPyQgNDSTs45D1kiWps2opLZKfz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=825 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220120

On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> A minor refactor to combine the subroutines for legacy a6xx GMUs under
> a single check. This helps to avoid an unnecessary check and return
> early from the subroutine for majority of a6xx gpus.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 38c0f8ef85c3d260864541d83abe43e49c772c52..41129692d127b70e9293b82bea5ccb6b911b0bfb 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -403,7 +403,10 @@ int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
>  	int ret;
>  	u32 val;
>  
> -	if (!gmu->legacy)
> +	WARN_ON(!gmu->legacy);
> +
> +	/* Nothing to do if GMU does the power management */
> +	if (gmu->idle_level > GMU_IDLE_STATE_ACTIVE)

This isn't quite a no-op, but I can't seem to find what the '1' value
would map to, even in 845 kernel sources. Do we have to worry about it?

Konrad

