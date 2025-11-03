Return-Path: <linux-kernel+bounces-883411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE430C2D5CB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 664D64F4ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9831A545;
	Mon,  3 Nov 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ayktmef4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bemaWx7n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5D319873
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189557; cv=none; b=czTTXdmZPyZOm0KJTNvKGuHwaUnR4F/mRaTOf5C30yTuYjcTnyuGdxlL8llnPKtzqDz1vpki7mDG1AbttbGZalFCUkyoAZxW2b3T/mrmlM4Gtndo3VxcwMle+e0wU0xW15OQZpwvXrPnN8ve1etPH31G5hiSK5Cjtc85Xp2dmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189557; c=relaxed/simple;
	bh=SE/JWvyl1mVhMRUT/t0i96Y2UjirOWJdmQMPTIz8GUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ub76OaBEb9e1JSzSf7dVORvobbzBXF6pMz76wMcmUUGQy0pOcEGNSbaxvjkxG3w6ueROyfhNCBLyjeFMsJNSqJUEeXA1VZoD85dn/g3NWPLp9t/zwvV8PSVZ6OwOZuRYPt9y4p49kRSWOOpCC/sT/POwRUB3X9HMRmSISCBspOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ayktmef4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bemaWx7n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3GgJjU3694634
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 17:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tMJonf3eoZDqZvJkMJ+tV/tTp+QvimJZ4zN78pLFBkw=; b=ayktmef4GFrMH0qO
	4E3/O9c3IJhUzymEbDS3WHY9Q/xXl8Q5wV9rMlhU2zFz+HPs9DMDyRIfuJMaqlfB
	x37WvIZazXcM7jrsQ0rzuuYZom4xc6t8//ZlGWHFrvG24HOS7OC4q3JN2f/gFz9u
	VaAegXsY2mCslBWcPdtapggbIGE4T4ZqzDwn8+qf7nxw8wkxOWLTandYamSU/i5x
	h0bEEZY5EkzJvBOy+N4kk0Dm2xs7y9chGD7ovNhY/u+H9kjZYhqahHT00uZHHC82
	fjL1PPlmlIqNHRuue2t3ehQS1wRwBeAy2phAwMB3T7R+fNijfcR7TOUCVuNWdphi
	U91cLw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b0y4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 17:05:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso4309562b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762189552; x=1762794352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMJonf3eoZDqZvJkMJ+tV/tTp+QvimJZ4zN78pLFBkw=;
        b=bemaWx7nWClpfHiXrCUCGBZ/9/KP2vC3mLZojhPCKypfM9/wVJWLIvtUv8OoF9d5By
         ewvCpYci9JYw1YqcopoPDoRYCXpzW+NDCF18Xybai/jDuRiNzuCtfXsq8tVDZ0ZKGP4m
         EF5SGOmIzhE5yJG+vWCvXpjf+PQcwe86oGS8Pp4Kcj9Uom4k1PqdfDXacdLDss9n3A3g
         w8Ce+dYzFz+nYXL3QDkIQzhgGorWawE69RcyllNAeDOzxYWQjHDFFOuHf3TY4cyvd6ti
         LAwKUQlN/CaXyk/CTkY1jXDSYTA4wIYMRIK6XXuw6L3LhJGeGS3XZLavCMDW2Ppzo3e+
         r1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189552; x=1762794352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMJonf3eoZDqZvJkMJ+tV/tTp+QvimJZ4zN78pLFBkw=;
        b=BXOMtbtXF4/ED1LsBss5C3X4COCmZ7y6P+uMFI5BUjBRYZVyq9Vy1yPo13p48CEphx
         jCxjb7ZS+oU5+JX4FAraPOOKLRP2MY1pVS9Q0XRcg5xOhh8D4pgfrQ+kq1L+mEvuT3Je
         PT8M420ohCNkYaZkXdoR+DVlpZt796QBFWaProf+C7MxPprgHt7mvTF4zxif3UtM0v+x
         J/CGhVfu13lGByKX0DR/uU6fYdi251DE2hrkLJKDW2dK10HqI4C6hSDu9HUGJgCNEUKB
         92QtSPJAAVb1CnC1w7ghFLVmauwlyuZJMeel10M/uPreYbMXVudWdKlT5MAGF4UQHoAs
         WPrA==
X-Forwarded-Encrypted: i=1; AJvYcCUGG1a7kMaCKBcaQHC/4YtTqaoeHvy/+9KeMHSsSUZ/wccK9Oy+4Yvt76ERhIooOJcMLuHTUqYXLCYpDyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8e5pE5M+YvOYvGT3ztg+2EezgrzVfnTxlTu/E6DYxw+FN7La3
	Ups51B3EB/93D01mABn1FluwIxUlgjdy6/g+836V4XI4UFpX05Nh0X4zhybxXj3ZnSPLRgEOvOx
	Ni4xhTEGKsManlxV1aPoztNnM2bbKZN/LkpT5qHLfr6uy7PJ5njWqtVPRJEWGJA1y0Q8=
X-Gm-Gg: ASbGncs0elTTGY1YcWMjXrxXXrEqy7upoot3iIV3uwA5udpmSLh8wsStTP3/pyGThAD
	4u+YGWzO6Dt021qiiEU0qtPmkKyq1GxUl5EhHiwGTw3b9kC8YZPcsux4EoIT7daK7omjbuXbinf
	NARVrxf1nq7yEWnJqelwcAVJJRbTJduGrhvjl48lRptUrfzCzxuDACrFo0TsZvDi1/Xgw417J1f
	Go4TKH0mLXFCHp9Q0X8rpAAdN4zhNuyDfcciUCy/kT6UgOz3mEAW+0lFRBoSHzoAvi+tTwyK5aG
	znqGgUM9xZXVWXoE1ttVNxbnnKTm5vH0x9sr06kLletsYu5sUYgb1UBXKZbCy0nIGMdjpWJ56JC
	lbZmZqe2izkHUr6p3roLGJHY0oed8UpVplA==
X-Received: by 2002:a05:6a00:1b57:b0:7a9:d1ca:8a44 with SMTP id d2e1a72fcca58-7a9d1d9d2c1mr6108941b3a.24.1762189552365;
        Mon, 03 Nov 2025 09:05:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7nCpt2pmA1p/z363FYH3kIpWcm8j5TSHch0KWpmzexTdxO5el0iJ6fZJaaxezvkDjSttQfQ==
X-Received: by 2002:a05:6a00:1b57:b0:7a9:d1ca:8a44 with SMTP id d2e1a72fcca58-7a9d1d9d2c1mr6108911b3a.24.1762189551653;
        Mon, 03 Nov 2025 09:05:51 -0800 (PST)
Received: from [10.216.41.187] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7aa3e645220sm5955873b3a.72.2025.11.03.09.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 09:05:51 -0800 (PST)
Message-ID: <1846a8df-62b4-2ee1-6d32-4d2937357b30@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 22:35:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v8 2/3] firmware: qcom_scm: Support multiple waitq
 contexts
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
References: <20251102-multi_waitq_scm-v8-0-d71ee7b93b62@oss.qualcomm.com>
 <20251102-multi_waitq_scm-v8-2-d71ee7b93b62@oss.qualcomm.com>
 <CAMRc=Mfh+WQx-vasZed6jWi5nUjg=K+ScVRBMCiFgK397=JbVg@mail.gmail.com>
 <da04aa57-f3dc-9bcd-5ba3-05088a6661ab@oss.qualcomm.com>
 <CAMRc=Mcj_6g3ory9zqxEWCHmpxh3hf4C-iBK0XT82F8nGVcFKQ@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=Mcj_6g3ory9zqxEWCHmpxh3hf4C-iBK0XT82F8nGVcFKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE1MiBTYWx0ZWRfXxDNWVR8nmQlA
 pP7a82c4FkRxKrzgXOotqsb/oKTzk/+kLf0llLcT1OqZF6eJv8DfDKzn6E07oHpLz1vkUHCaQP/
 IHV8+OyS1NhQqJwS3zn55pqQsiCta0zSX1hpjhY5zZZcK5F9ZYdVSwhGVmdEDyFnFHG1mhYkO/Y
 Fh5XP4bopt/P/pii6j8vIdMC4tNuInd6CFBV+4IcygYZYg11tT3mLAlSRJO9jTMOwNu+/j6TiPo
 X63cGGAbUUW39ODwp7KVDRxZMXbm2qYHqoHDk4XnZYNXamqi1f8WtLoOTgH9d1e9s+499N1tWyB
 Uul+p/aqiwM8l74KpSfIiOSEyXxxkdNTxr4tTWk8BByXdQT4LqulNTxaJmNnuhK4diNVKeaP+eB
 PVVuHHL8eO8Z+WXXViZVAQcAU92qUQ==
X-Proofpoint-GUID: z3bO9FuOYzzktulVKrqPYSTYFXmuzD2m
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6908e0f1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=oVS8WQ759SglhW3IA7sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: z3bO9FuOYzzktulVKrqPYSTYFXmuzD2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_03,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030152



On 11/3/2025 10:29 PM, Bartosz Golaszewski wrote:
> On Mon, Nov 3, 2025 at 5:16 PM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>>>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>>>> index 28979f95e51fbee94b84c1570a4d88a76f72db4e..0b6efa7c2bdc25a3ba152c25d5451d1154779ddd 100644
>>>> --- a/drivers/firmware/qcom/qcom_scm.c
>>>> +++ b/drivers/firmware/qcom/qcom_scm.c
>>>> @@ -47,7 +47,7 @@ struct qcom_scm {
>>>>         struct clk *iface_clk;
>>>>         struct clk *bus_clk;
>>>>         struct icc_path *path;
>>>> -       struct completion waitq_comp;
>>>> +       struct completion *waitq;
>>>
>>> Why this change? This makes the name less descriptive if not misleading.
>>
>> Want to make it dynamic array of waitq`s. Should the name be kept as
>> struct completion *waitq_comp; ?
>>
> 
> Yeah, can me waitq_comps if it's plural.
> 

Ack, Will change the name to struct completion *waitq_comps;.

thanks,
Shivendra

