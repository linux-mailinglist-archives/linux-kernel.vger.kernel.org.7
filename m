Return-Path: <linux-kernel+bounces-741073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98249B0DFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07877A64E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2752D8DCA;
	Tue, 22 Jul 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QcfPf5cg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C123ED5E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196157; cv=none; b=XLJ7E+9OGjZo6uE8+Z0kWpWgQ5tM4iR7W13QcRyglizfw6qHllivtGnd//W+tr3OFYeKUUtDr5uKqCclB/0V/l20s0KN20Rv9AzUk44uFF4lj7HOFFr0w6hMMPqb81FPTzauhHTPHXGiEMfIvessOrC0Bu3Tr13uy48Qwgxgiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196157; c=relaxed/simple;
	bh=UAK5VSHn3YTUfIZVUDIaLTsAANEcnDyMXuOk5OsDE6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBpRk2PC71yd/tBAidk2bcX6wUxSU4q9pTZAN8kPkcjbwiR8kqYsKFfoe2p/8VbdB9q4/XZYa4CL/vKI4wGhyksyNm2QqwADkAIOyFbETdSyEJ4NJGG/vqsGQ6ElUG3KqyofTLg0ePFnEdBKZm4eZ7ZmYaiPsR+rI5koL74g1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QcfPf5cg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M99FHu016274
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C0hlxJyA1IJ9h6I+V+ie87W0rqn0HSylQG7JgAg/IlM=; b=QcfPf5cgQ5enNMgB
	P5Jir3+SM7xsRHoRsYLCP7SeEg5OUvk46GS/jNhYJaMwxPIbzcmzPYlmdkyUm2FM
	Mq14j5LID/7xsk7g5zwP2V6WkEy4P8EWYDhJMRRL5OZrV1TUrhwbOdR7ZYPOvG6t
	5fw3TVNOGOpQXCgBl9glQoQNcvlQii3bWU7l40PkDXN6HVaQztBM4dtimAryAWwo
	ObNfrd944+6O64maA1Ss8cjyPjXoIXRyfVzEA4cyWVln6L6xElKxBQ7/pOcskAnp
	dZWUa5gBjqDn4sHGavri3Mz5+t6bJb6Pebraf+x1n7P89eOdwIfZ0l0cLGlCZdq2
	IFoluQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s1wxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:55:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab3ab7f74bso19889951cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196154; x=1753800954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0hlxJyA1IJ9h6I+V+ie87W0rqn0HSylQG7JgAg/IlM=;
        b=WCZleGLgMcUT003ePUIzAiqK/Z90iFhIBd+GYTX+jxhRkUSVF3/KN5ayu8YeuCliD1
         l5AbABVWAnDTR9S1Y7K93OTE0fxRExBBnlz80JSNgBFTJnX143qThASFoosC8RxJuvfm
         vg5i/WbBbhehprvgPZJVPg/LuXLOYEw8Hy5PsX/0Sd5vwL7Uo+J+/sHUbCT6IGeJt+Td
         0yJM+pCJgML6c+yA8+I4L2ClMPgg6a1sziZBnzp+9lqoLSq9SGmGhmBYa4GoyhLq6HNj
         gCjFlFJqZeGNGK7L8u6Sy0oSs0TkLPECSWmVIz4gML2Gxyo8UQwsQ/uIIb3I7qXM3Ugh
         HJkg==
X-Forwarded-Encrypted: i=1; AJvYcCWlaBYx3ev41C2DNNIVLk999YE2NIH+OmNpvEe8nIILFPG5doEniari8UAprwQIX0tYKrtKE+KpU28UxR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKkxI1PJyP+NAJKYvPwMXH0+RvuKQePbQlYdIIm9HIWcxzuypn
	B67DanKacQdmOB2htJo3cbGgw88XuP+pGonDzusn0itlKV4TJbszxwBO8xAPieRqIckv+IppPa4
	xrKu5QWkl/cwrCTBaV3cUY4U2yPJxgmvjrGwL+aaBd3mnNpLkFKhkIfXHnJULHYYe7zM=
X-Gm-Gg: ASbGncvTBkzJT5J5J6pfJXratneYsKZATuIyhGVvBgJq50RRj6LUxyFhKihEOGgQBjH
	CF1kXX1QpMvErsqYP/7JCV7jZBJzQUU4cJ/Lekm4dAQqgrOTsr7OLKD0qYENFS0FIICWMSatuFY
	XrxCnxidY9ceGc+H8hxMw1ZYKSMsxrEqqHpeAaGRLc+uu22SOEq3PHo+IlFjvhLcHmlksEkBfwY
	0IBks1ykODQMeSe3NcYo1vKw0g6K6HNrIN39wSJS3throN3sZXIA5CVeoP6DHB74VsAxlM1JNtR
	6IeNf/E2Hd63UnlhO6sGVY+2/ypBEQLviKnHKfegWjZHDqT0zoWkIRPXKfTkku7yeO3+CGePTp8
	u+VH2yAKD9hF7qo2VYSla
X-Received: by 2002:a05:620a:4586:b0:7e1:79eb:18a3 with SMTP id af79cd13be357-7e342b3fcbemr1355052185a.10.1753196153071;
        Tue, 22 Jul 2025 07:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnVBwZCXiywWrdb3FDM9RN4tirxT5EabZ2Ai1SNmjP7E/TXKdb3AzhUWjSu0iEK7NCe3JGkg==
X-Received: by 2002:a05:620a:4586:b0:7e1:79eb:18a3 with SMTP id af79cd13be357-7e342b3fcbemr1355047085a.10.1753196151593;
        Tue, 22 Jul 2025 07:55:51 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af22f6fa6afsm73454166b.120.2025.07.22.07.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:55:51 -0700 (PDT)
Message-ID: <38100984-df2c-4a15-a192-7f38b8671145@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:55:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] drm/msm/a6xx: Enable IFPC on Adreno X1-85
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
 <20250720-ifpc-support-v1-16-9347aa5bcbd6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-16-9347aa5bcbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEyNCBTYWx0ZWRfX55NGM1DxHkOV
 7OVyaOgdsMK3DUsBTpx4PJdyQjhAMhzSPPmCpMgQRa8re3Syoxj2q3iwhgiBHgULUgiPIg16XoA
 mxYNduxNM/sX1cGJRrOSu1H9vYdBBYT9l3COA3sDIAQXq8MFG6lVCKfISBNpZyWTLj6cB8Jlcmo
 DZNMANdHfkr9VayvWTp0DwTX5miS9oxvgdqIRrUAGBbkQJilHijzGwjOj1pqMW+pR9qJmuFTvLm
 hE4u175nLyKavSn/1y8mhQfg3TSqLO+CQc2k7JmLexJrNpgwUVQczHmvxtZNow+SKvPYLkwIXjE
 nYb8ZxcHOuUwTb+hN18ZonnLGYQB43M2KiVr+iROhUy17zyTaR4JwMu5N35LGaAijTFOqxN1F2K
 DkSpTtVOLIxG/JofE2bTrd0BMiXyL8igltPJCy4lrTJogdK1oIdMma5U+AI0zBiOA2se5dZn
X-Proofpoint-ORIG-GUID: Pu16BMGyxIIKaAaUh_sG84UNjK-EswM9
X-Proofpoint-GUID: Pu16BMGyxIIKaAaUh_sG84UNjK-EswM9
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687fa67a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=eUh3tnNZifY16eYFU8cA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=653 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220124

On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> Add the IFPC restore register list and enable IFPC support on Adreno
> X1-85 gpu.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 67 ++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 15 +++++--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>  3 files changed, 78 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 70f7ad806c34076352d84f32d62c2833422b6e5e..07fcabed472c3b9ca47faf1a8b3f7cf580801981 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1343,6 +1343,69 @@ static const uint32_t a7xx_pwrup_reglist_regs[] = {
>  
>  DECLARE_ADRENO_REGLIST_LIST(a7xx_pwrup_reglist);
>  
> +/* Applicable for X185, A750 */
> +static const u32 a750_ifpc_reglist_regs[] = {
> +	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_0,
> +	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_1,
> +	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_2,
> +	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_3,
> +	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_4,
> +	REG_A6XX_TPL1_NC_MODE_CNTL,
> +	REG_A6XX_SP_NC_MODE_CNTL,
> +	REG_A6XX_CP_DBG_ECO_CNTL,
> +	REG_A6XX_CP_PROTECT_CNTL,
> +	REG_A6XX_CP_PROTECT(0),
> +	REG_A6XX_CP_PROTECT(1),

Is it fair to assume that we'd like to saverestore all CP_PROT
registers on all SKUs, always? We can save some space in .rodata
this way..

Konrad

