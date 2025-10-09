Return-Path: <linux-kernel+bounces-846264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC42BC76D9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171513A7495
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB6260578;
	Thu,  9 Oct 2025 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCYyPtY5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C825D53C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987422; cv=none; b=nabEbgV6FiJXgGZg8URLL1ABRTAzXhnkL9IfBmvAtAjPhlwJmz9WQD9mdg9XtI9op96jWlVszooHVgAVEWb5qauoA+HDgLrS8ts0/AfgvyNhl1uOR0CEQbO3cI2ML4acQ3A8EVOwRuOo/v4SeND4Mwl/4e92u3HXt6sKEL/25bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987422; c=relaxed/simple;
	bh=QlyxEsfXkhbrl16DZnPv708U/7TfNxCMN6rg1+bcFis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rS+BBUMmb/a+wAibPwAwT/IDnKljBmL7OH/oXVCNLWPOLdmsndqYEEJisrYB41/rs6qmS02juvgw3ZFet0Pamq6ORjZYi7enguv+WZzAwLs1IH9mAZu+VBLnGtJfXkiX+U/K38mN27WyD5qoNwqjiHclpj5TyL7YaB3kX/4KZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YCYyPtY5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5Xmb028672
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 05:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	akZLWiuVBZdWjm46LZFqg6S6C2WUS52lS0cYaephgKg=; b=YCYyPtY5XU7jd2TM
	nP1nbgL2lPhSjMTAqCYV8vtfvo7qf3GiY+70asOznAe6KiuwaXAE/r7xN9pLiceL
	kj9BvPs7etVa/C1MW5AZMhLcClvfQpBWAhv3TUks7igM46snnmz7h4eO8Gzd3rJz
	mwXspHyQJNx9bmx0mMepHOUYgvtBzc2tjxIfFYNIP723SGpHPcbnoTl90y5wofW2
	FJacArLE00tl/gupWesrPVbnILMGVMv52p8fziHVzM5IgPbnDEhyvE/+VHEPxnD7
	JldvFVoAJ8Z64aQUO4SeSQpaH2oxcG9sv0/4Jx0ujavy0WyMd4TevDa6Vig23SAh
	WjxZYQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u1h0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:23:39 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5516e33800so1137667a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759987418; x=1760592218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akZLWiuVBZdWjm46LZFqg6S6C2WUS52lS0cYaephgKg=;
        b=ixdiGoT0tF/Ndy3MwTEwHMmEg4lWPu4GK2pP1QxFXVwWcwP4sMpRGYu6YkbL8Cwavr
         fI8DACFMjHpdopNMkxomAZU24mxwpzQFzo++8jEb5o40m6RrJ+oEcCHo9SrgBdSeNUaA
         OQnnwRq5A76mpp/qYOb+LLJXHm1XuWK31BRVVwJXc2FNfaCuselbImkbUEtoSN8uEJRe
         CebfuDlQilYbQ1f0FllentckrKTN4b58xLY1zA6Q5tz/tCtgqMBC1eWdimSrI7D4P7mL
         cUlNG6es7cNHRw6JnWUU8Hfeia+n3QFEyI5QRRYwIcUuzn5Di66ngIBQefAlUlBwDAm8
         MFKA==
X-Forwarded-Encrypted: i=1; AJvYcCW+fymI1Ph3LOb3OgZyx6mo4Xsdgk4l+B3D7LhMrj9KXR2++pCGArgAw3ieGHn7Nc5KLeInjwctNUzLlos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKGQQEpFBh8pYnffwapzw35+AxK6J0pIOdlBL13fSctbBujnU
	TWapwfXLHfUSrTSnimUY/heLJwUoNcDOnktwd64GmFavAAXxpzf0Gytv0HBAggGfPduX71/jGOk
	4FVVz0ppoA4ZES0Hy+Zv2CksanO0S1Z+npHo1kofMFASevZGvf6q+r1CklOgr0jaUQnY=
X-Gm-Gg: ASbGncuQfuQsRgzTE7dE+hPxdXtkSqhpoqt+N/9kwoCbHq9urUBgHsxHFUAWECeMY90
	64YKgas0mGkVABiUl70PclIl2ajbXW5WVMgq/gwvrsleuMvpHqxYRWu1p3mWp4o/SxuLVQEe0sB
	/n800mynHF1YcN77D9kXIS9hNiV0462BB92eMt3mkG0epvFzIvSkILL8LsPq8E+WeXUEGiAX1tB
	bOsJuZKdPBoH9tZCMJL/PEJX8Y2SCWdcH2gFOa/J/8QQlWQyZ1UIZa61fXuBdYOF9lfVsoiXTyN
	15UYVjaqEoSnF5fSfJkl9QlrtWAYvpHnpwp7YXZvFrLtNsAzh/ZTqEzP2BdMsqTKZdq0z9nkJs2
	W
X-Received: by 2002:a17:902:f64a:b0:275:8110:7a48 with SMTP id d9443c01a7336-290273eddb9mr74232605ad.39.1759987417769;
        Wed, 08 Oct 2025 22:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDg7iAaHqOJbCGEhRnwGpr8mzkkDt1BuPM1pConZNQaoF4SP+MQRXUQle4Yzd+hhSSIL/1Eg==
X-Received: by 2002:a17:902:f64a:b0:275:8110:7a48 with SMTP id d9443c01a7336-290273eddb9mr74232285ad.39.1759987417301;
        Wed, 08 Oct 2025 22:23:37 -0700 (PDT)
Received: from [192.168.1.3] ([122.181.197.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm15046985ad.104.2025.10.08.22.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 22:23:36 -0700 (PDT)
Message-ID: <6ead45a6-aac8-464d-9812-f5e0d1395709@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 10:53:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Introduce "non-pixel" sub node within iris video
 node
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Bryan O'Donoghue <bod.linux@nxsw.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <7b6db4fa-2f73-376d-4eb3-64c1c7e6cda3@quicinc.com>
 <7da769b4-88e9-401f-bb21-0ff123818b9c@kernel.org>
 <6840d462-8269-4359-a6e5-d154842b62db@oss.qualcomm.com>
 <af0da28c-3ca0-41dc-aaa4-572723ea74bf@linaro.org>
 <klhvgzizub33f46buqsog54wqksqp24a5tijwyv355l2ao2imo@wdkojfebc6s2>
 <e1a6e75a-2a5d-44a2-8bbc-140eb86d1806@linaro.org>
 <2hh3zkdwgqbdurpr4tibr3gjat6arwl3dd3gxakdaagafwjdrm@aj5em4tbsjen>
 <Ujyoj3HGLVFhS2b0XzcYAMjSiCAuO-lSJ8PMEQLOaaX83tk_0D5zjrL0VDyZAmD3i4zLB3ElKSZBltISb5jJHA==@protonmail.internalid>
 <4a32bbec-2baf-4210-a7c1-1ddcd45d30c8@oss.qualcomm.com>
 <SuwJuCIcLVJwN3YeN1il6tB9wO9OH6bYcnbRpxpuI9Dl7piYLN-hVdnyv0Mal6N-W5pi2aCZI8MxHZDEkoE63A==@protonmail.internalid>
 <4d87d1ca-55b2-426e-aa73-e3fd8c6fe7bd@kernel.org>
 <10a8ccda-4e27-4b06-9a0e-608d6ade5354@nxsw.ie>
 <4cb4a92d-2f20-47c7-881e-aadcc6f83aa0@kernel.org>
 <1516f21e-aee3-42cf-b75e-61142dc9578d@oss.qualcomm.com>
 <9bae595a-597e-46e6-8eb2-44424fe21db6@linaro.org>
 <bcfbf35b-69ed-4f39-8312-6a53123cd898@kernel.org>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <bcfbf35b-69ed-4f39-8312-6a53123cd898@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BMW+bVQG c=1 sm=1 tr=0 ts=68e746db cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=2UNsNDcC2suIOuNS33efzA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=cU1SgpNRDqoFvKGT_TMA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: r0khJ-M0LvFnxywcTxNZNYIGhrl5NVGE
X-Proofpoint-ORIG-GUID: r0khJ-M0LvFnxywcTxNZNYIGhrl5NVGE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8N7lpcr8Sf8l
 6WRdZgyOkapnEUG/5jMGnkCuIlKGF5O8mEptjeh4aKVY9IF6lfDLmdQvfHC1LNbktIi3VGNJNwr
 XuD++NnZzo+KgG0HnO1dwyGqLpxxEQQfwjjQ4+svkunrTGAcXKNAk+UpDezXjHKVy31LdNVJXz5
 rHrVq/iJARcWka8PF2EGtHPxAtWkjN/z0lk1fEpJzI8GU4Qn6TseABemmxRCfwa1NfcceKssN31
 WjZbYd3qN5OmRP/dw4mFpOzMSvaFAi4qlfgX+cPlBecCqb6wWjmvmXsa5VrUKydebdr+4CsQ4Y1
 n05rZobG/MKeNeUETaBNtb1CWfM1lzCryfCfrxMdh91K0V4kQGNjzX11BtFUl2d7vP8kkDl8a85
 KicvGZsHem+kqqscU0TDt3QXQEg/1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/9/2025 6:02 AM, Krzysztof Kozlowski wrote:
>> If it is legitimate meta-data for the SMMU setup then why _shouldn't_ it 
>> go into the DT ?
>>
> We talked about this two or three months ago. I don't understand why you
> just ignored that entire part and come with new binding just to not
> touch iommu code. List of entries in iommu must have strict order, just
> like for every other list, and you should rely on that.
Hi Krzysztof,

I want to understand a bit more about the statement -- "List of entries
in iommu must have strict order."

per my understanding:
iommus = <&apps_smmu sid1 mask1>, <&apps_smmu sid2 mask2>;

     and

iommus = <&apps_smmu sid2 mask2>, <&apps_smmu sid1 mask1>;

The end result is same with no breakage as they still end up in using
the same translation unit, i.e., ordering doesn't matter.

May be you imply something else(may be ABI[1]) here about the order,
which I am unable to catch...

[1]
https://lore.kernel.org/linux-media/8b88cea4-b9f2-4365-829c-2a255aed6c69@kernel.org/



