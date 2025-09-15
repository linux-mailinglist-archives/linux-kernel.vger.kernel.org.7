Return-Path: <linux-kernel+bounces-816577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25278B575AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51732189FB45
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F50321E087;
	Mon, 15 Sep 2025 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bRi20XHi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41A2FABE2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931013; cv=none; b=ZisxJE1EOPd5eLudtJzAn9M2te1FA+LVnubJwG85nu0/iyVd1joyw5H7BALoQgF8Zkoy/uJ3V4Dx+OVGJPytChV/Vzcte8MTwtbsQGOMvjifcYHjZzXrz5cKew7dQEYZaRbQ9eINULuvZXTFwap2Kk/GxV8KvWsNvuGDFutA/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931013; c=relaxed/simple;
	bh=oJqDS6EtytX/4EwWe7RLhEzC5GGSyQ3r5FauvRmpSDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpF/H2yze/pNmW7GQbQ6iPsTneTBuUAO3mZkIbA73ZiG2CNOoCW2r1q0U4hCaKLvv+IOJUmw5P3m15HDAnzy5aQnM4fASOEMDQ9kuZURZCOM317/G9s5Elk/wuYyNPf63oCFYx9EKEsbe+r/uqHNRsyeqtkWW6Oj1OqpEmb0eXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bRi20XHi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9GHBD005059
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oJqDS6EtytX/4EwWe7RLhEzC5GGSyQ3r5FauvRmpSDM=; b=bRi20XHiacZCWbyD
	nnFhvTKCYKBcrF6pLVVEY/ILkKCb2u5bF6NaJll6ONizwWc5ANhK62NewCl44joo
	eajx0d9CD72YWNjWaTDFmScq8uDJY1Jps2ZCSkg87U0JNvta5DeJ4lPF+jnzPGVz
	KT2BtL2oLJJBlt7WyE7V0veIBLTpwQV2VRY3vsh6ZgU8PlaP5V2RTtmkTUOYpejL
	Jt5oYmVCftVRI1ConQJrqSposZdQ9caCDCpeguEuH5KeJg8B70aKv/y/5YsidhBH
	F1YN2ptpqvXsFzhMscvyrGoluMF7MRokDvrGpbfXl7YzixcZJajCETPRe6zwKB2T
	AgDvMA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g12g65r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:10:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b522934761fso551611a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757931004; x=1758535804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oJqDS6EtytX/4EwWe7RLhEzC5GGSyQ3r5FauvRmpSDM=;
        b=FkTKRq5clUqCyK0VHS9iky2c8qPqLfMY1Lm9rhkMJOYPvitlbDA3KSYcnbhPnFi4n4
         /J6VduNdaNedSwiIfz2J9E8enlKeI7dLXdAjH5cB9aZzw53Ot3hnCg6OMLDwRz5vL2vx
         O/B99xfNvoXYagRpo4Z8IxViu+VMvRW3JSUrhgrv5b9MA0s8e8Hi9xC9m5lqNnDwJUmV
         54vBNymxHwQSPN7yuwmlHP7G8fp8V1QGJvwgjo0LOe30TJFPoRyzgP2H6B5H8Y0uWra1
         BThU40DWYb/lGcDvopRgcYc53at4zC5ElmqWQ6bQAoDaevGyKPCfcsW3eC8jowc6B8En
         cD0A==
X-Forwarded-Encrypted: i=1; AJvYcCXjaXCUqo4uhBN6dgURlrbF/IwgEdUMJ6JZMlKDQsJdMcJYERX6EJxXBB9reL2cIwAQfxwI3OhdQMWPL94=@vger.kernel.org
X-Gm-Message-State: AOJu0YycxhKAtKT4EMiW696OhVt/dWWbZvXm/OBJo8LbtCAUSoOWal2h
	5j8XI9z84+jZFYyHKTKzP3VdpWU9Gpadphm2ux1H4HEvZKTAOVcUrWGCNUtkcPuOmIDaco9Hx9E
	SNevIEqb0kdVwOioMhd5HJEgklGBBGZk57UukMf01VW7WpjEYjX5NzztoKR8T7ySRAdI=
X-Gm-Gg: ASbGnct8Scm5AD9NRBoEerTNBwhSuGsTSJwdLsCcNv9jbcHAJGuzqjkO2OAqO6mIG17
	5HPp+QTBhZAw//njkqbQSM85/QpbHirpXjTi7QtrDmfVHOQ+xsBJsL8U3ZZjxyothLIN23sauXh
	JbmeByiANNsYFlD1xc+DejzSLLNuE3VmVP8tREKZAosfZq3jcY8juCP8rNbL8g+N+oz7rSly0tZ
	mhS+hqUuoC2DLuYD9qNDyEtRc1ECu8lp6JQKNq5tYf6LJd5UDnVSyVq3/KnBsuAALkGrI/6Vam5
	BB+6N975wps5MMeP9fROLauzcH5ceyy3fHJUfBAkJvpDvgxrzfGNozY8WHTsIvXg6cYMAxioyY7
	Jc5EwnnTPvk7tDIPeGnDcgS6n0Fx7YPvEfzE=
X-Received: by 2002:a05:6a00:7608:b0:776:165d:e0df with SMTP id d2e1a72fcca58-776165de1e8mr5272821b3a.0.1757931003877;
        Mon, 15 Sep 2025 03:10:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL+aEaZbmtt8mkehB/0dhBi1/0r9uuMfBdz44WzDP2mKLR/7wRH7bmQR6ne33XUYpBhPwb1w==
X-Received: by 2002:a05:6a00:7608:b0:776:165d:e0df with SMTP id d2e1a72fcca58-776165de1e8mr5272797b3a.0.1757931003421;
        Mon, 15 Sep 2025 03:10:03 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b5fasm13129962b3a.16.2025.09.15.03.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:10:03 -0700 (PDT)
Message-ID: <4dd37b1f-2175-4759-a250-fee4ed2bd39c@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 18:09:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: dp-controller: Add SM6150
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
References: <20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com>
 <20250912-add-dp-controller-support-for-sm6150-v1-1-02b34b7b719d@oss.qualcomm.com>
 <sx64y6vfov4yag46erckpbl7avwmqlsqt3siebckn76m6jqxjh@f5lueyih6n3q>
 <d3743c52-4e84-4729-9f64-af856419d504@oss.qualcomm.com>
 <droyp5atpjauyttqkwqzk64kkghg6jkkubvfz3zlbrodyzlvoe@fbns762o6vcq>
 <6bb0cbd0-d3b2-4359-a2d0-6b757f66d0e0@oss.qualcomm.com>
 <v3vuphn3n4w6ynpaqeosechjdcelomn53atwfotka7izqvjuid@nnvdwxqlelrp>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <v3vuphn3n4w6ynpaqeosechjdcelomn53atwfotka7izqvjuid@nnvdwxqlelrp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MkdKIu3oCQjyL1gQL0sZwbvUMMPTXcL4
X-Proofpoint-GUID: MkdKIu3oCQjyL1gQL0sZwbvUMMPTXcL4
X-Authority-Analysis: v=2.4 cv=E5PNpbdl c=1 sm=1 tr=0 ts=68c7e603 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=3s9BUBv2AkJYRnd1iEsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX0vFLZlywmN9V
 a4rQnhsQVURMmcNULE730RCE9Km5f72GXl1gjjK4XeWQjWJsiiHnhAdTWEq3XEvFnFzCwjlO6sd
 n8LAUg2jDZqt+mIhs9S9bCGS1Cfr/SefPeo0Hqc+Z/vgbQeVtnfUwuXbXG05x0wi7EVcuYz3bdL
 fs4Nzw+ba+hQmvKLm/N85DmV5h0FR3mkTjMhIgrQ/WsvY1Kx/yJ+cU0zlECD+I/Kc3sJBuSZoKf
 2mJi+0T+991z4uh0n3tCLwcuIsBRh2simtGxSF/e7KM+YlEyjmQTUijiY9ZuiX1xD6JsGQeJo4r
 rgenYgXgZgh8xCIq2ymYULpcfpHPtnMHP/t1/9lnh6E5MTo8ZOOX/8Wvi8bzwZM2huKHz7QRqOk
 MhnMbdEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086


On 9/15/2025 6:03 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 15, 2025 at 02:26:12PM +0800, Xiangxu Yin wrote:
>> On 9/12/2025 8:10 PM, Dmitry Baryshkov wrote:
>>> On Fri, Sep 12, 2025 at 07:54:31PM +0800, Xiangxu Yin wrote:
>>>> On 9/12/2025 7:46 PM, Dmitry Baryshkov wrote:
>>>>> On Fri, Sep 12, 2025 at 07:39:16PM +0800, Xiangxu Yin wrote:
>>>>>> Add DisplayPort controller for Qualcomm SM6150 SoC.
>>>>>> SM6150 shares the same configuration as SM8350, its hardware capabilities
>>>>>> differ about HBR3. Explicitly listing it ensures clarity and avoids
>>>>>> potential issues if SM8350 support evolves in the future.
>>>>> The controller is exactly the same as the one present on SM8150. HBR3 is
>>>>> a property of the PHY.
>>>> Ok, will update commit msg.
>>> Please red my response again. What does it says to you wrt bindings?
>>>
>> Yes, SM6150 uses the same DisplayPort controller IP as SM8150. I wasn’t
>> previously familiar with how fallback compatibility is defined in the
>> bindings. Since SM6150 will be declared as a fallback to sm8350-dp, is it
>> fine to drop the driver patch ([2/2])?
> Yes
>
>> Here’s the updated commit message for [1/2], does it match your expectation?
>> 'SM6150 uses the same controller IP as SM8150. Declare SM6150 as a fallback
>> compatible to sm8350-dp for consistency with existing bindings and to ensure
>> correct matching and future clarity.'
> I'd prefer if we have "qcom,sm6150-dp", "qcom-sm8150-dp",
> "qcom-sm8350-dp".


Ok. will update next patch.
'qcom,sm6150-dp' uses the same controller IP as 'qcom,sm8150-dp' ...
fallback compatible to 'qcom-sm8350-dp' ...



