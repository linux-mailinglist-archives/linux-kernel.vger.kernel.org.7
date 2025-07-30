Return-Path: <linux-kernel+bounces-750273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3775B1595F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B05E7AA4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06273199FAB;
	Wed, 30 Jul 2025 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DWa6q10i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4F2AE74
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859620; cv=none; b=T38BHwHSMIoiVqzJzrqfJQXWGxwWkQpm25wotmW0CfrxKgMTViE7OMVDePc667O88DlV/fNt6QeLxlGUw4YqY6AXRIW2Rd8iZK55g21ciH7j6DMORpqyV88a0qbe4q6NPJyhlsUWGKMJenq8HKs81Ka6oe1PO4+ZLTTDKrL9T6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859620; c=relaxed/simple;
	bh=vmUflXSGCAnmNZdKwZ7wh505u43Wn5ozCPkxfiUYfmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ur+8BLL76wXJWOcHZUQVdOYKj5klu5MIXV5xA9+Qb8gGIbm+QCHLbE2RjS0UuB8WiI6iBuOZAI+zwpP9yiLcp/eKHFjXsx6XPUAhOQzkimbRM8Kqf3U6bsy9tBBd1ed4W2PwMeyl2YM3xkfVstcXDnee1fVOHBzUDUWY2TSOhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DWa6q10i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6Iq9w023447
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zi4hLFTfLsENP9BcQU47FniUdDHHPw1lNFtITuRJfNw=; b=DWa6q10izEGWmSDl
	S/M17ssL91ttl56WYwWQ/5ja7Qj/BZUG+TM0s1vEent+V4DHzFI6GesQzJh4cV6D
	zldbf/efcuTSMsho4oe/KUFwDcN5CZjyi+bHKcvyu9ZreP3cFL943zzuPgMbTioz
	+RHbZHIm9VWJNulnSqSRXqDXwKUZ6Em44yPjcwud/7eyY7zv5GOtzd3OEkWTVLJM
	WXP1XCMAfBscMlqtgr+TDXEQLnR5ZlQsphpoUallj4osrPyangdkf0nI86SawqqT
	+UK9BVHCMAUhuuajBC/8RXHbt3GcKmgcVh4Leoh/pk589rRY0HjaHZHMp471ismq
	UY6P2g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qtsgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:13:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748d96b974cso696061b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753859617; x=1754464417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi4hLFTfLsENP9BcQU47FniUdDHHPw1lNFtITuRJfNw=;
        b=mA/rCxfTbdx/XlHkgddq5wVI2hWoiS3ddOMcDU+ZoFsQzw4p0xbnuQ/dgblBvZnyxF
         5g6AzG/G3zhl9xfOlWP4FbCE3Qervo9soWKUyP9BgQgMnYAVgKJUZxySFwTyloCexMxV
         OmAUq7QiXvxOFEHtAEMFjmYSpyroInAAIxTyQOrtLSVDqTY9gQOaC3TEZ5GLENibzCc7
         VRO+8auUL4dj/TyYbk05MzzVQOQthOm2q8g9LytG5gfTXnWje8yFRQL8SC2CZ2e+5Eut
         nHRHkGv3EdKIpRkVHOVa/hRXFfMqdPw/9A3wwWkRBl0ZaNNsWGrmXOxxnacHYgtKB/Or
         YkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUNvzaQ1POdFGRnyO16Z+AukUkPm0a6/mWrTBo5Aab2ohxy9SaoulOXFoC2ULFMMbW2UrWma+6mMa+6Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVb04IPe/q7CzfB+YmXYvd61bGvCpfH/p+DNfsp/TjxJ9WZlfu
	RQ4ciVhaUsPyn2GHVQ5bVCoRYTRIzCBmC6JTBp12VoKqbCJcf3MMKeGB1LXUp+0YZWjteVfKOIh
	z6gdYU/pDstrQJwjHudNrBaAMBj7+6jJgOmTVKXrXyNOWlrbbz96xWC3ReJtz9B0Fv/I=
X-Gm-Gg: ASbGnctiBGxDl1TtYtSs7v3GUyX6MErVn53YqSL6yPvg/bdagOQ51hNFJ3iYb41tkpO
	GFpZ61uAq6DqB85cpQ/13R5MgYmL7xp7ebSk3yrLnHsg27rpvDKv5EP+/DOe9p+wv2XoG5SFBwQ
	TONd8oz1yIuusx5Eu0bXaibLe2RZYk4gUrOTutfsl2lOdyfLXSsujv+czQvVRyAwOnLH2BIA5Jz
	2zLvoCo3aGaf/gVmZTkMJENzuAXvmJ37OqaEENGCT3IEUbKEjY0kv2ZTwu6Wg2Eca8Vw6bCnB0s
	y46hJclpfKiWLkPS2tzwkJ1XT1gnDM7YiTZ6ce/CNZpiPbUz9fN3pPShLtnHwQVcXlvhRQpjODM
	xtEOuiUbSZoA9kqVDO2hfBiXYESbd
X-Received: by 2002:a05:6a00:92a1:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-76ab0524cf4mr3703851b3a.4.1753859617192;
        Wed, 30 Jul 2025 00:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbXQYxhS9eJG8PBKNZPRJWC9eSH9QH/OsK0s8qRXktswYT2gefhDurx3LdITYkb5XL0Tqqkw==
X-Received: by 2002:a05:6a00:92a1:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-76ab0524cf4mr3703820b3a.4.1753859616834;
        Wed, 30 Jul 2025 00:13:36 -0700 (PDT)
Received: from [10.133.33.143] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640adfbf7asm9833105b3a.75.2025.07.30.00.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 00:13:36 -0700 (PDT)
Message-ID: <7d1bb8b1-da77-4594-abd5-7da9bb713910@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 15:13:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
 <20250729-hamoa_initial-v3-3-806e092789dc@oss.qualcomm.com>
 <5hgynbka274jerw5x6ekfuoj45k6bqt2hdbsx2puniqornil4s@pdgavjb2jeci>
 <ef9c302a-28f9-4bc9-912c-92bf5ca7bbf3@oss.qualcomm.com>
 <157fee28-e6b9-4c81-9698-57302117c885@kernel.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <157fee28-e6b9-4c81-9698-57302117c885@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA0OSBTYWx0ZWRfX6/upxhALgSPR
 pjwgYkjuuSqKZDV04jBMKN306fmskf5SkJ2Jb6RW4OBHfJ7R/xmatoHSUZbUdfVV4Dpo1GUACBq
 kNMWf3PhdK24jitmcdiQqwQWEyM47LDEr+/uDuExURe2oSxFiLMzixo6mQ9NQfbcPWwluMwP93I
 Q3QJL+Y7Wnz56AdtFydz2tlg1xAdra8H1/FR+DKnOERwOYiwClnta991b9tT6MNnKUKea1qf6tr
 +VRXpcZ4pAFA11Rc/7pNygvywlBzuTMAdbuONb0hN5giYWm4BKcXUBM7ReZyXRmJ4YEHKStz1wh
 y1WlZDbBzk5hi7rE4qCoEmfGr5XjJvVlNINgs/0FFt26icuV3ZBHha1733lXMY5zWB4XHTlWeLs
 dAgUTdnLHaLYN/FPlllkqSwVPZ7KekCO3L+a85lpd0gOVWMVKgTi1uctrPUZqQCm9gSGmLcW
X-Proofpoint-ORIG-GUID: yO0xUakF3J1coh8ySCVFbSdM0EaaymCs
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6889c622 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6jahUQGBau2IMRXzWEoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: yO0xUakF3J1coh8ySCVFbSdM0EaaymCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_02,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300049



On 2025-07-30 14:44, Krzysztof Kozlowski wrote:
> On 30/07/2025 03:11, Yijie Yang wrote:
>>
>>
>> On 2025-07-29 18:44, Dmitry Baryshkov wrote:
>>> On Tue, Jul 29, 2025 at 09:31:59AM +0800, Yijie Yang wrote:
>>>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>>>> on Chip (SoC) — specifically the x1e80100 — along with essential
>>>> components optimized for IoT applications. It is designed to be mounted on
>>>> carrier boards, enabling the development of complete embedded systems.
>>>>
>>>> This change enables and overlays the following components:
>>>
>>> What does this mean, how can it overlay something?
>>
>> What I want to convey here is that I referenced some nodes defined in
>> x1e80100.dtsi within this file to add additional properties. I’ll revise
>> the wording to make this clearer.
> 
> That is not an overlay. Use proper, not misleading terms.

Thanks for pointing that out. I take care of it.

> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


