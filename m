Return-Path: <linux-kernel+bounces-743234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4566BB0FC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5134B16E548
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C45227BB5;
	Wed, 23 Jul 2025 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VjClZdQ1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F4207DE2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307015; cv=none; b=Az08CZKh8w9pNJxdEvzT85I+kulp1C/FLa94oCZgZQot80gpNl96ZhzrtiHO/p5N40NCViNM61zZqix4eZk3g5S41wmnt6i74IkLdq+rngi6nLO1MRB61JG6zuNyzPFPJV9p1bI4hbZ5XuLpPki2LEjJuddZx5GYARETu8aEkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307015; c=relaxed/simple;
	bh=DdZBJuqK6v04qPpfb3bnK53HYuyPqR1JM0r/nUPg7WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3v05fLfBW6fFb3Us0fIcjZ42pmsjCrLmOAxa5xkzu5ra99GLHxg32hJT9luAqzS7xUmry1mIzL35juw4I10XpGK5qzrZxDILrxP0ouuJEELq93ZsNLpr7FoE7ui7IYZPFT/xgs9ZnqkzDKJrrnEmn9cOVZB+jGkAezMacSqPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VjClZdQ1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH7KKG025715
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uzsd1xcUKgsxCpgkX2HBRK56tDWw0kgTphmNT2IrLUU=; b=VjClZdQ1R/6nAsi4
	mu+I9PBYb7YhfPNj0w8Fs2qNGeoI0KcHczcDEQM4o5IUFyS2ten/n4F2EaZ0523J
	rwSbI+nGvi6txycqRvmmWqGt4TqoqVyFrRTQQ8wJ2wdvV9Utxuk7JKTuhjRe+Y/+
	dzkhAyUuM20VVUAL1cUngxGKagZdTcdJO1ATwOvU7z8zjcqd478DxIqT6vGHIlBK
	l0QMIf7/80G4LjaVbL6jEL3SommuCkoaEr45iupaESdgvCqTe/FsONjzPSlsr8kd
	HOCt8TtVevPIk2MBl2ZMRe6Wejvy2H80sbG19DlAexLixjDP8noHmMTSjUhbaWW8
	klxYZA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ud6hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:43:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso223318a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753307010; x=1753911810;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uzsd1xcUKgsxCpgkX2HBRK56tDWw0kgTphmNT2IrLUU=;
        b=HqFPbbGM+NmJ8D2vG6njamOKArDbHIzrbU1lwmJrM13GS48+Zwnh7f1fKgEHX1Sdn8
         pJ6SsE0beJo0VUK8m2To5rC2qA2qJycWOjABPKw0307MyA55BmXoueyZYrGqvHIlTKGM
         L0KG7Te/2DL8s3qbHxfZs9hem6fuL1U2mYNtK/JEjOtjTsHFlCY+su6YcfEo0chvUJ68
         EeXHh3L2jnMbQce5PAuK3cqhI2rD6d9VTyVnSMM1uTx0/nC7kdPHZwT3AjWa0k8c2foL
         TvF2CMl5cEnplahVRl5UylwJKVL0ekM4bQrQaCMoaM4QUKJyeczPvfgpNpXatKIKmLj3
         /DeA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2cgO1LVFy51tj8XF4a18qiJy48bAXLlA6oeK+SOAXpRT+gk9RaxPlyF8dfzaHojDUESi9KGK20TrHPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2tzvkQmatyTFOsvvDw2h8XCuVJCmcvO7zSc3HN2g78S7BiSeS
	Mk668s9QOgQCTr4jfUEs77vkN5sOcR5alHKtt9Aq0kYxoyLaJw3zZhF5uKDtxroh6drDUWoNW//
	V4rDxcD4bSCCQ5VLFn2rZZYPLRS2A08AqLj6nDbnFMiFLQMHwAGX5OeUo5yOo1kd86Lk=
X-Gm-Gg: ASbGncvCJtbgyIj9xAHvci1IWJzw+tQ8zk21/4R0Zh7Is7d0tc6c9VsEEOAfhbtpAvm
	258arpjdgoJSOsibkAz0OzrmZZWdUA3N5dV/8CS7JrfzwslS+8dhm1+bHB1JP9I6ksMv+T/CcJA
	ZUekon4TTcJzbxv2Uta/lJL6GccUtdZ9ubcVpke84DMER8g3bVc5326+7TyZtioS5HSaTSGpKxk
	E5EdtQpeYO+vdHqzgTt+41Wg9jpKHgxhMJ5/lxfo0vxM/w4LYdMrKNINdmVRuLLCE/u4ZFQxgdZ
	P80Pa0psj/sMt4ZVKMZPyHoB1MPz/N0LYRZwyOaGy3W+ftv3sdwTvYFJDxrZYA==
X-Received: by 2002:a17:90b:2e4f:b0:311:b0ec:1360 with SMTP id 98e67ed59e1d1-31e507e27ccmr6472068a91.29.1753307010589;
        Wed, 23 Jul 2025 14:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzTDpyK8uhEHXdusySPe7kL1WJwqg+L63lFCGjVnLvsY2leb5rLrYmu0tDVWGGC6nfTLKVxw==
X-Received: by 2002:a17:90b:2e4f:b0:311:b0ec:1360 with SMTP id 98e67ed59e1d1-31e507e27ccmr6471989a91.29.1753307009327;
        Wed, 23 Jul 2025 14:43:29 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e63a6677esm18638a91.3.2025.07.23.14.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 14:43:29 -0700 (PDT)
Message-ID: <d06c6b86-2aa0-4f59-af8f-0130897c7b26@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 03:13:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] drm/msm: Add support for IFPC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-11-9347aa5bcbd6@oss.qualcomm.com>
 <k653qq6a4xkvwadeum5kbr7cheje773vobehpzq33ec44vyxjj@vi3ekv4jwext>
 <6472bc1a-9546-4cb1-85b9-d826f76ba9f4@oss.qualcomm.com>
 <5471754b-5dec-4107-96d6-a6075328d824@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5471754b-5dec-4107-96d6-a6075328d824@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=68815783 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=pSIa2sKh8ADkebnh61Ypzg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=-ImCKyWHiv6jzAo2IrkA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE4NiBTYWx0ZWRfX4TIXgtj03w0X
 Y8fnMWgK60fbc6ihMZsaG023xBOIK0kwN+fZiQVYhqnVxnWy2bSDM7OH/sTgooBI9AtJ8Bj/QC6
 PijwwRyeHAtDHn9h+utlvtJf2KexQiTfNDP9em0wJKrjiqql13t8bq+vl+QV6Yj4sON+4Gdk43K
 mmjTztVShPs98LDyYCyzISaKF/BAaP/2XvuCc64e0Pkp8f2H9R5y3DBfUwO06LXDPSsJPPYIHLd
 ysea+gGQgGj5AGncaNVrxaxQ91O7JpBVRwsjAUaxhiFe6cIngEJYlznvVs8Sw6E5UUIS4yUQ7NY
 fwAQ0t1q+NOqpfCgp2Yx933E+87DAcuMbZLJC55BcrwpDo90C9er5dGEKTwQbW65oqFyrKbxPhB
 eibX/c3X9rfGdLTFJwSNEYH4OgZxr8Qg911UffjsJxIiT++HO/5/7Yv5s3C+xlD8Uw1SWZb2
X-Proofpoint-ORIG-GUID: _0gi0HKhf1pXTIfEtiTCILI1roxw9neh
X-Proofpoint-GUID: _0gi0HKhf1pXTIfEtiTCILI1roxw9neh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230186

On 7/23/2025 3:57 PM, Konrad Dybcio wrote:
> On 7/22/25 11:27 PM, Akhil P Oommen wrote:
>> On 7/22/2025 7:19 PM, Dmitry Baryshkov wrote:
>>> On Sun, Jul 20, 2025 at 05:46:12PM +0530, Akhil P Oommen wrote:
>>>> Add a new quirk to denote IFPC (Inter-Frame Power Collapse) support
>>>> for a gpu. Based on this flag send the feature ctrl hfi message to
>>>> GMU to enable IFPC support.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
> 
> [...]
> 
>>>> +static int a6xx_hfi_enable_ifpc(struct a6xx_gmu *gmu)
>>>> +{
>>>> +	if (gmu->idle_level != GMU_IDLE_STATE_IFPC)
>>>> +		return 0;
>>>> +
>>>> +	return a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_IFPC, 1, 0x1680);
>>>
>>> magic number?
>>>
>>
>> Let me check.
> 
> techpack-graphics/adreno_a6xx_gmu.c:
> 537:#define A6X_GMU_LONG_IFPC_HYST      FIELD_PREP(GENMASK(15, 0), 0x1680)
> 541:#define A6X_GMU_LONG_IFPC_HYST_FLOOR        FIELD_PREP(GENMASK(15, 0), 0x0F00)
> 
> (same value for a7/a8)
> 
> 0x0f00 is 3840, which smells oddly like the XO clock rate (possibly mul/div2)
> 
> (38.4 MHz or 19.2) / 3840 is (1000 or 500) (ms? us? cycles?) and the other one is
> (333 or 667) - without any further information I'd estimate this is some sort of
> scheduler tuning

Thats right. It is around 300us. Will add the same macro in the next rev.

-Akhil

> 
> Konrad


