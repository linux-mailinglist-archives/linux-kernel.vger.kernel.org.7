Return-Path: <linux-kernel+bounces-899387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F4CC57A94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8044A2E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCD352F8E;
	Thu, 13 Nov 2025 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TOqMaBTs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YYWpLi10"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF835295F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039462; cv=none; b=MDI4Gk8Z5dz3SzM+Jr/Sh/k0Bn+7hiRcTmoVBCyg7Ygl7XXOvcbsWtXEPH1z1mMzz9axUUnuqB2XXSJmy9/rz9PgbGT7DlC/zz8VpxSfs/SfJwbKAQyK1i5mPubUvkTTcm5qMdoWTR0cmEp0GxL5CWLrgA9C5FXihhlMmjErHI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039462; c=relaxed/simple;
	bh=bJLpgmhmTmJRQ1f2sjYlvMkh1MNjxIMj51sjDN0rwd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwITQnNVYGFgtz1y81apwZHx10iTbeXXTm4Ps6IybQ4+G2EVAmChU2TiTRlJtoGP6FnPzF/SsbgdZClIAoufXT2z6seMxy1mTZd+wxcmgc1h1ps39StWYOQHKoq2ZmBqnEatBUNqBAsOhXUrzM0KjUASzxb7GXlXMdXdaDTX0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TOqMaBTs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YYWpLi10; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8V9a92962117
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DRTlfmcA5G3RNmazWc6q+mJMqfQXqWOCzTyBT64u9rM=; b=TOqMaBTsjWUqDCE5
	HDed8I/iW2bdO1rwLxiMq7m7eb87aqzdumHxxMdVgZ8/CEnauG+fKxWLkRNspXks
	bM24P6wv/5ylAbR/OnXEbcJZ7VUmCaFSW7XylRBDABE5A18wVpNvXt3wrVDCVYBu
	bBiUrn4EVnTECSgSiRVGXRESIrU8cF1oWGyYOiusBeGhnMk5aI4KyfDGHegM4eW9
	qrfjzvuYHqpAvZv0/1Mfbpr4+NOqgHVqaSKtdgRLuWHj+9sT73RLQusyIZ4BZrSu
	vOWUFz6snmp1LvuBpdCipRhcr+7aKiHKnr4DTFsv5QxC+Fv+9CLXTFzHj8P0D5gd
	LN+fBA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acwbpumcr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:10:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edace8bc76so2823671cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763039459; x=1763644259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRTlfmcA5G3RNmazWc6q+mJMqfQXqWOCzTyBT64u9rM=;
        b=YYWpLi10U8hsY9jb8+rZPvy6H829smzR9wqMxvQq63ww96dQZlgSgEOvdom81tYkr3
         KmlczUrmS1eNHOZCiv9bk9WvD1FIEo1AypXGmOvSqr/RI8yd/PYk/PjLyk777xghBuaR
         WqpSOrRFx091uy8NXLG1GM33HE5YOzGArVc9G+JCMFHhfcqYffzeK7ibG1M0sUs96Daj
         O5VTZaLDX/kPSrugkeXj5MTvhVa8ONdUdg2U4iZsizQuUiibmdZuP12m0ijAkKhFsCU3
         4KnrSrvwQ6l1AzGN+rJ9UArNaaduEAFEJoUkzFa7wHrAly8N9tALDmgDJvo5e4/Vfxwz
         z+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763039459; x=1763644259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRTlfmcA5G3RNmazWc6q+mJMqfQXqWOCzTyBT64u9rM=;
        b=wuQfHzT+4d93uc5IUx1h3LAuzPcPqcsahGT3lyRmBO9cq+M6nSEWUjY93a3AXoKw4y
         55RInwWuQbkcDKryG2/zzsMXUv+ashipqadA5mdgsjScQqpFbCoe8j+iIwpGPLs2buwH
         xflpviMC68jSrobsYx5pXqKb1dQv19hIWlqq8rhD+D4V/AcqVLajhmHaDXw7Bb+Lbii9
         AZyL0Qmy1B9qG9gdNY/dgin57nAQbFZmE9vtA/hB5oPDVXrZ7/x/KPQqmGhJjKlsZI7l
         xDFnMWMXnPqhiqmK+riPJxJVvLH7QWJhvC3sunswQ9YQkfRtNKei92DSBBS1tgOjIJ05
         oQjg==
X-Forwarded-Encrypted: i=1; AJvYcCVtKnRytXmoER7I6AbKX+WETN43YVr4cxEfnG1CHv4RiaDp0OXPBQj1qjTpiahnCwu3q8SmbnZtIcDJFEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetQ+LANTy7HHXXINe/U+sJM4aWz1IWYoKI3q08THm1ElC+dko
	V+ImbE7z5eSCSo8YE6jkiIaYGCBJ3SxrOprmW8xi2nxOaU89taEGTbMMP3ufkz8U/ZrahOOZI6E
	xs0cWqxpqM6Lev/ie8tEbvhmq4xKtlYpXNOJeMm2u29AARg4kQXlOFiLyZbSPPykEdXg=
X-Gm-Gg: ASbGncsiujpNlQYFE/jY/Fy6mpgd+pFNnF6jXJIOVVoO4XHDj+hpiXp6zqB7vjR7Ilf
	AMqkU2vkPwRDJYIHWJ8UyHW0Qnt9to2zBoN76yTyt9nDjD1gPtebrS+cFgVhqkoiDaojwHkHlYY
	ftlaVBbYNpcuCT+SDqNxA3Ux+EFJRmPu5t7kd3E5+qU8uGFjUxQtMSDA5CXur+DL6IVyM97v7UM
	FBnzD5QxNgLFnFrbWLmMsWJmLmQ7Xr351TLa1JRFEVE8U0t/zZYBU0flnHEIkM49U3xw4/yIE0u
	ADa/n9HmKQiPO4jXFSQ8xARFE4JcbBXO9TdBtF7j6WFMvN2bc6vYsXjNiPs7IvCDVPdHgy9inKA
	Xf0TTiRYwwJDmpU6mq6LyWs/xaa7jMyXOWhjxeWohGmQ/IR3QOYZjugzY
X-Received: by 2002:a05:622a:316:b0:4b5:e4dc:1ee5 with SMTP id d75a77b69052e-4eddbc3b368mr66675671cf.3.1763039458857;
        Thu, 13 Nov 2025 05:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFubAqHtUuJnDF+wjB0W9VlEiOIp1rA9oYXxjeZ4nxOglG6BzzsPMTiYzTMIQ8sTZ3z4gCpOw==
X-Received: by 2002:a05:622a:316:b0:4b5:e4dc:1ee5 with SMTP id d75a77b69052e-4eddbc3b368mr66675131cf.3.1763039458247;
        Thu, 13 Nov 2025 05:10:58 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a498102sm1451965a12.24.2025.11.13.05.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:10:57 -0800 (PST)
Message-ID: <2a42b980-c037-4b08-85a0-07f5ca8dcc1e@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 14:10:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
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
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
 <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
 <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
 <os7rpbynyoeolwvbrocx3yrrxzhextx3srywal2i54jj6dw3mw@n6fbt3pzjvj6>
 <d87bea02-1a89-4854-b760-617c3655b287@oss.qualcomm.com>
 <kwf62e5l5n4pwfmetvhicupj7r6ow46dnlkkluyhl7s5wuazpw@q7vbdi7d6ul3>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <kwf62e5l5n4pwfmetvhicupj7r6ow46dnlkkluyhl7s5wuazpw@q7vbdi7d6ul3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NvjcssdJ c=1 sm=1 tr=0 ts=6915d8e3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WG-851GjljAyzOMNImgA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: lekvQWizR9aV-08G8DgK3Z1sq1YmyLLE
X-Proofpoint-ORIG-GUID: lekvQWizR9aV-08G8DgK3Z1sq1YmyLLE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA5OSBTYWx0ZWRfX+JLeLqaQpLJ6
 OA5WsFVQES/6MVfWlYCoGzYHI+V1EpccQ3wdmhpKIiLctu+FDT7dtw4jU/Ypl+/xHO4L7m2pq+/
 itetfptv5tYOTu3FzKAu9rJ1RGVCLib5KcXOLkJO0Ucl1LHZzx+GtXLzKBDhQnFWbbSM8bTfPkg
 CkBOITzlzfGvQmw7eYrlCXZybZpKq0c8g1Mj2K/xpH1bI0oCx89AlED1+5INBrV7VpGM9GSZ2Ed
 sRu2ihVy05nsMnGqgIcgKDmNgUQNSc8CQIS5O0V5gzCKX56CrKZsczO7/a8BD/snQgzuPxFFVC9
 QFLdFKVKo21fP/+HagBV1pHs22gzqlU4sgEICVFmRp9AFcqah/iU/nXmfLbR8wn8nckxZ/LK6/e
 T30etIg+s36LG+mvz6Xpx+KyJHLcZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130099

On 11/13/25 1:22 PM, Dmitry Baryshkov wrote:
> On Thu, Nov 13, 2025 at 10:27:09AM +0100, Konrad Dybcio wrote:
>> On 11/13/25 4:38 AM, Dmitry Baryshkov wrote:
>>> On Thu, Nov 13, 2025 at 03:32:51AM +0530, Akhil P Oommen wrote:
>>>> On 11/12/2025 3:52 PM, Konrad Dybcio wrote:
>>>>> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>>>>>> In A6x family (which is a pretty big one), there are separate
>>>>>> adreno_func definitions for each sub-generations. To streamline the
>>>>>> identification of the correct struct for a gpu, move it to the
>>>>>> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
>>>>>>
>>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>
>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>> index 44df6410bce1..9007a0e82a59 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {
>>>>>
>>>>> Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs
>>>>
>>>> Could you point me to the holi's devicetree? Currently I see only a610
>>>> (sm6115) and a702 (qcm2290) uses gmu_wrapper.
>>>
>>> I don't think upstream was ported to SM4350. SM6375 should need the same
>>> hook, but I don't know why Konrad didn't enable GPU on that platform.
>>
>> I'll try to fire up -next and confirm it hasn't bitrotten.
> 
> Maybe then a patch to enable it too?

I was hoping this would be implicitly obvious

Konrad

