Return-Path: <linux-kernel+bounces-777235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7F2B2D71D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD0E3B4DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9A52D9EDA;
	Wed, 20 Aug 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GhKKNkil"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC41FECA1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679892; cv=none; b=Ug2NhxDD/Br6srTNWFNcyswjZc+ENbGpcPHyYOtaCrSWR07+Prp4mL/ZgcJpS46waWlL7zvoRJhCVwF9pGDrpY4y91PKoRRzjH0mI8/wFV9RbTXvXmgeKRUOZUoc1HAxlWhtsatGWnmy2uydSvMo6YRJB8au9lnD8hqO6kzC9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679892; c=relaxed/simple;
	bh=/ds2ps/9fiQfLgnyFNZdjYCVb+MpjXSLLk6Lrhal8gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lel3ZkdxK7VktPjcWVF5nnbjsZer8lBMrjrAhDHP/GApHB49cfITaXk28ThO+kt4xNf06/vXcOP+d+cTKri16OmQwajxpdYhObk1uBd6rTrD6K9LwTKJ6mLqmoDA0biu53MHU8a1UvEZrqKCN+aFElVZFuJTNudMhRWXRxOvULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GhKKNkil; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oa63025126
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y4OMPtXQhdfS1IUPfrekUduc3f8tO3YSwKKo5NLCOZQ=; b=GhKKNkilIu9G/9Ca
	eNi6oFbDH8z4Sd+aRC/mlkWsbAJFSgM2bzmI3ygq7x0rs4sw2R36/Bt6ST42zrQ1
	U7MNMRdCd6uN0zoNCbWXHRxOyYXulay+DxAQZzvAdkQSQFEKOv0mRsYwTbXW3TM6
	VzWSlcihfaXgMF3Kovl7GWHRcuqHzI05IAGzV2CQZ4Aj/h26L32aomHpoFQtcvbh
	5rxbTiIXKS3LCbTiGvidjupSmFwh/YdJWa/MH4FFu5hkd1/iMqHYRHPRSoRZaPB/
	8q0DwSLI+26DrZvp+7uJemkGCtMTYPsKupz1CmcGPEOLslBdDroAsb2zHr48j1KT
	24cXUg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a92tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:51:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326e21dd6so11901536a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679889; x=1756284689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4OMPtXQhdfS1IUPfrekUduc3f8tO3YSwKKo5NLCOZQ=;
        b=FARtUUSkUpERBwf9uEMCM/F1mebK/GKc9qahmy3vU+3Fz2pNuPDoDkgYXtaFUDWrt8
         LRNQWJzucIZ5x3pcMuBVW+wrpNKYltVVgA3g0LLNT5StDEV97nF7DK8lNSbDyBM4NAaF
         /f/XSvrlNT6tKBPfcBTvB2o1NLvUbVw1ESRCGOvaAjUSGfmJzqMzctaQO2NGRJekD642
         J/r2qmaWkwNoJ++/4nXlYdnpBh7VSo7BMTztJrsxGgh2ToGossFQ3UWICkVOG+SjMcRn
         dUJbBmEWkWucwJT9C7y0OnfKRUvf+IxRpL9So7e717YGUBFUwuKLvi+SMnPbpkcf14cy
         kzSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2dHWMq/144a5rvqEPM2N/nCDXrdcCdU+irex1xaKmGRY3SUDP/Wa2Hf8P9mfPMDjmIcRW8Oqy38/0nIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGEK1owrZvdgEUr/WdVCzE9yQQXQ9TaBB6ne8kT9XA8zbBgRZQ
	OFh9pXozhaUunwRpM7rNIuBuNuHBgRTjLosPUBdY5w2Cs/eXtmOLUl1x7lxvJWuCV2pfRhN+9+C
	OlXJUaGG5eq+N1jpeI49PB/IoZDEwfcSPVHKMuWfu7uHGC6VFBYWoV/2ceUEf1l6KCQI=
X-Gm-Gg: ASbGncvFNkqLHmo0c+79L/xE2iPlMoiysoS6QHrBAm9yAc1DCzicipmXIBGxdnfXSPf
	14xzoCG810/czSDiviO7ngCbOOHI/nlX9g/pc1x1DTSYB1fOJb8TydFl+XyxvvdU4RFfFZYgGmr
	aHwUkU0Zx1qowKNZTlOwQoo8DEdV3UHXgNJm89Dij182ACzQSyXnhwp7jQYQe7yf+dHgpBnfDqe
	bREsguNiuwgBeiJVclEKztmYG/7lB3MsCvtDvxdohDLBe3ri7oC8Yulh3h72yCcbgsnVMSY8ffg
	zdEK8PoNnddsSixmKz3DFy1gBZu6cMJ0t2JrQashKsr8Nyw2WCP+qiVNfzGzPZ/8fIoBr5+P
X-Received: by 2002:a17:90b:48c6:b0:321:c0e3:a8ce with SMTP id 98e67ed59e1d1-324e140d2b1mr2658894a91.22.1755679888781;
        Wed, 20 Aug 2025 01:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT7ZIz0JNmDoMWE9x4Ai5P9gO4JkYSgLlzLle23lvK2iLaSkN70tzxtR9pL+Q06Be6RHXqWw==
X-Received: by 2002:a17:90b:48c6:b0:321:c0e3:a8ce with SMTP id 98e67ed59e1d1-324e140d2b1mr2658869a91.22.1755679888241;
        Wed, 20 Aug 2025 01:51:28 -0700 (PDT)
Received: from [10.217.216.215] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d1a44sm4787237b3a.1.2025.08.20.01.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 01:51:27 -0700 (PDT)
Message-ID: <7d3e5cf7-4167-4005-ba4b-c1915c254705@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 14:21:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on sa8775p
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-2-odelu.kukatla@oss.qualcomm.com>
 <90b51e31-3217-4483-bb5b-ec328665a723@kernel.org>
 <28b97952-1b67-411f-a7fb-ddd558739839@oss.qualcomm.com>
 <ac83c453-c24d-4c4d-83bc-9ed13f2f9d1e@kernel.org>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <ac83c453-c24d-4c4d-83bc-9ed13f2f9d1e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4DKo4atpyZaFQspzeS-1BeVF_Uwk_Eq-
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a58c91 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=tJ9fhpcgm4yphQaQ0K8A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4DKo4atpyZaFQspzeS-1BeVF_Uwk_Eq-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6sU1WZbiZL0y
 DrwhYZ6bBpz8FNcCBzNfw/SKx69ki6itgclyYF8dKJGe0ZtO5kXofpjLAWFWaEup2iZgAZl3JSh
 b0K0PCVVeMGo1mhSqJzhCM3APGZEVmhJPA7gI+V/LpIZKeUT+KRIZ2UvOqa3kO7icq53r2HbpZJ
 +udK2zP50/jGg9xCy5EDajhJ6N5Lthgap3VmbE+tpAkV6lnT9+tHgwLtVMzF7BJ8mLB1JONEhlV
 gq9XHpu+FYh6GFfn+xufI7Ixq5Wt7boiJqaI0ymOb/PuZZN2u5O9pcKyQKrhqk8N1rXJjcXGWOD
 wF3GUZ+L3OyE1J/PK8ztYsqn8yuxEJTpqXeCdmBITd9kAxekLHWGyPNWOyqAVhQiRSc1nnSIEZI
 czB4x94CwRCFhBmzaF1ayobZR4x8sA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/13/2025 11:32 AM, Krzysztof Kozlowski wrote:
> On 13/08/2025 07:55, Odelu Kukatla wrote:
>>
>>
>> On 8/12/2025 3:47 PM, Krzysztof Kozlowski wrote:
>>> On 08/08/2025 16:02, Odelu Kukatla wrote:
>>>> Add reg and clocks properties to enable the clocks required
>>>> for accessing QoS configuration.
>>>
>>>
>>> Nothing here explains why EXISTING hardware is being changed. I also
>>> remember big discussions and big confusing patches regarding sa8775p
>>> (its rename, dropping/changing all providers), and this patch feels like
>>> pieces of it without proper justification.
>>>
>> Thanks for the review.
>> I have added description in cover letter, i will add here as well in next revision.> And this is hidden ABI break, no justification, no mentioning either.
>>> Again we are discussing basics of ABI breaking patches?
>>>
>> If you are talking ABI break if we load old DT which may lead to crash, we have .qos_requires_clocks flag which takes care of skipping QoS if required clocks are not enabled.we have addressed this issue through https://lore.kernel.org/all/20240704125515.22194-1-quic_okukatla@quicinc.com/ 
> 
> Format your emails correctly, it's difficult to read.
> 
> Your binding did not require reg and clocks. Now it requires reg and
> clocks. This is called ABI break.
> 
> Please follow Qualcomm extensive upstreaming guide, it explains this,
> doesn't it? Or follow writing bindings...
> 

Thanks for your review and guidance.

I agree that adding reg and clocks properties to existing bindings is an
ABI break. The sa8775p is a relatively older platform, and when the
interconnect provider driver was initially upstreamed, QoS configuration
support was not available in the framework. As a result, QoS was not
enabled at that time.

The motivation for this change is that certain interconnect paths on
sa8775p require specific clocks to be enabled to access QoS registers.
QoS configuration is essential for managing latency and bandwidth across
subsystems such as CPU, GPU, and multimedia engines. Without it, the
system may experience performance degradation, especially under
concurrent workloads. Enabling QoS improves system responsiveness and
ensures more predictable behavior in high-throughput scenarios.

We previously discussed ABI concerns when introducing QoS support on the
SC7280 platform. To address this, we added a .qos_requires_clocks flag
in the driver, which ensures that QoS configuration is skipped if the
required clocks are not defined. This mechanism prevents crashes when
older DTs are used, thereby preserving compatibility.

I will update the commit message to include this justification. We also
plan to follow a similar approach for other platforms like SA8775P,
where the provider driver is already upstreamed and QoS enablement will
be submitted as a separate patch series.

Thanks again for your feedback.

Best regards,
Odelu


> Best regards,
> Krzysztof


