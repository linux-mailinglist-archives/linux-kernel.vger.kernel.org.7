Return-Path: <linux-kernel+bounces-745511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED25AB11AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96083AD83B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC182D3758;
	Fri, 25 Jul 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gqf/xXQE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DA2D3759
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436404; cv=none; b=PrSM80s3HjgAMrvf/qQi1Z5M2a7GtdiRhxErqzFtJNrw5dBHHhwUSVi0nmDroiP54GD8A7Xm3MOf/xdqjGjxsextHykQa876oxB804is34aqj2SPHZtKfJinyT5+QFgsG5Lk6VPjKPbcTbeSm7URjM8KUKwdY3wGidQszamhWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436404; c=relaxed/simple;
	bh=u0Be70tRO8EucRz4c+aHCHMlZERAFH526qljtMYSsec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lalunZZJmGCKNlXCjT5KzR0m2Tzhk05rmKCknB0ySOxmUhHKgQfeq9NqHbLNKC5IdHe3OtZRPcZ2UJaDotYNubUoq4mg/+OD2bIcCvCdVm6DOlTAGFhNBXMfjiseWnHe/8yWNcGZAo5UW1xts3lG6UBV7+07Lp+PIzlOXa7SnCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gqf/xXQE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8gCr2024424
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qGcapkNoG5xSntx/Dgx3xqxnAeNgJFQJV/nU/XJef4A=; b=Gqf/xXQEOFebvRx8
	XyK3eCnTrzKmwM1uDjdaH2eFRpMMQmx+3PpkTagn6hs9bICbHjUn0imzTozg8Izd
	3FKrowK3Fm5yvmHSEFeD3WbKuXNLw7fPbWqOqq0PFOWJdxru026LvhoS9zPbvLyL
	mnaUDhf34SrzEZeSywpPiuTYk8FDJLfqIo2cK7BfeWzT2xhJcdQ625c6isBNThMT
	aPbbHCYl9rH8wNq9r1qogQy6oR8Se91OUUnCeoWZiiOJANyNGWsnOLq1jjVBkMCK
	HtRcxdqRshQ7l7/+IzApShTDRJpJCnjfTZvgpAIv6SfXpOz/DMMBEr2oZMJA/Mzq
	GYk0sQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2r9kcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:40:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4aba4196db7so2406061cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753436400; x=1754041200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGcapkNoG5xSntx/Dgx3xqxnAeNgJFQJV/nU/XJef4A=;
        b=nvqhaO2eEdcAW8cG53jgj+4LcI7K3BhK3WTWGpVPevzY0FELscjLU2AJU6J1aOXVTM
         sUSSTprDu/huQBXQ8r74tQvuFAxsyaedOJZWs1tJTtmzepbf3oL0OGOas02rElDqRAZn
         SYk6cKX+C1FfSnjKMzMXQyR1t6IkyejnHUPVhxAi8bSrPkkcYjwLmstVatvWmyC3Hdpd
         BhAhwhjIrRkQlzrjSoPC9R4z9YNVpJbNn46yMs/uRR9EDF8GmexkRwhw1zMWsATuFnX0
         HRW7SK+JWgwmgcow/EnD9fZjps+s4IZyd5ZuG8pqQQecrSmusEaboEQpyRH+oztlLjmb
         1YYg==
X-Forwarded-Encrypted: i=1; AJvYcCU6W/IpnjEvHKUPF8GYP0koRcQmgGkYp0YyLcBeiO9g0hC/7HTdmBaveG2WKHhD5TCQmmTp2qo0XbznB/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQqLFZsQ0CitYSOhsQbI5fWkRAdttj66Ke2CVfgJj2gicIXPj
	5X3UDcQx5sV8jpymb9yP2wTTK2SsKYjVSSoJ97Dnyv8akz5ohXJ4YgmtODtQ11z6w52Rt+yc4jL
	MtfZqhbm+leylEPNz1IQWnZcahM8eaNg/BmTfYI5RiNfbP4GWPhpbnBzGaEWjo3V4eG4=
X-Gm-Gg: ASbGncsB00t3Ol6JPFUqmxPqxezDg1T7ifVjd+3PgdhIpat5Ruj4kR45n0nj4wRIs9n
	1inMPMw43Yj7iJb64stIESIAwZRhdFz19M02RHgiHWID+2gvPKCXsk8bRczw2ViO4g1BbJi4+7O
	BLWq6XtlIDnwu5pKazGIRWDlFvr4UNQHn5DjuNHN5ZH8y7/cPkeZXPnGhF1Jd8xO23jyRFAKYfp
	W4xubSnTAE8MnaXlXyrN+RElUh8Y9MCKp5StWE28VXuOXOEiuHkSLUc5fSF/Nsskx6CIvEAWb7q
	U03jtFyhyOxhMJgJ2h46XWhpppx1Z81WRXX5NKHedyBQf8601rlhseC+ZENkOLNOW738y2s70Kr
	Vr+t3DgUWWMsJHnwyHA==
X-Received: by 2002:a05:622a:155:b0:4ab:806f:e30f with SMTP id d75a77b69052e-4ae8f07c679mr6020981cf.14.1753436400451;
        Fri, 25 Jul 2025 02:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYMeHjcnVI44EcDI70Yucz+FRHkluZa7QI89wpXOAoApZO7jDs/RWusaJ8gN/WVwuN+Ojkqw==
X-Received: by 2002:a05:622a:155:b0:4ab:806f:e30f with SMTP id d75a77b69052e-4ae8f07c679mr6020891cf.14.1753436400072;
        Fri, 25 Jul 2025 02:40:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f44d758sm240579766b.76.2025.07.25.02.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:39:59 -0700 (PDT)
Message-ID: <c28b7ee4-e438-41c8-8033-6ca94a096dc5@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 11:39:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-hamoa_initial-v2-0-91b00c882d11@oss.qualcomm.com>
 <20250724-hamoa_initial-v2-4-91b00c882d11@oss.qualcomm.com>
 <d55f79ed-0bec-4045-8bc6-9005d19f865d@kernel.org>
 <cf84a8ef-9f4e-4f13-b41e-9525e21a913b@oss.qualcomm.com>
 <3f03b1c0-94a2-4081-adb0-aac4f42ee430@kernel.org>
 <20829683-b2ce-4aaa-beb4-4ca5774350a2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20829683-b2ce-4aaa-beb4-4ca5774350a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NfTm13D4 c=1 sm=1 tr=0 ts=688350f1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=3OGU9N5RSJw_tsRa1MMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Yl469E72i36dluYpiRv6a-bpgRYsWpxc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4MSBTYWx0ZWRfX9j4hg15W6DF5
 Z+x1JzHHcKHTlp+z8iDYGOhfVFMu64R7gwV4gBED0y74If2MbjE/lgQh7xT1VipJ4LEoXSQPsld
 vobSEzn3SIt3eskO+UCVgFanGDFn4leqgSxCDlipye9Xau5MjccpbGm+zB6ljk9LDlmy5RoR09e
 9e3MKP60UyW4z1mp8hTPCy0Tgmr7argumNrlKUNRb1LkK3F7mPwfY09Xj5qLEXlDpjdaFv1ZHnn
 WRq+xGbTJNupvq8BOvB8q1qhF2e7Gz0U4boANhgZRuW3KHoHlcIFWnWFtCA2UbqgO3aAe+jPUnA
 xb/B1OxZ1YadYJfTKLFyz25ySmaGvK0lgrKtgtaqh1zF4QBsVtH7bH1jrn9ryE1PR1AntAnzgo0
 l9gjXRCu2cQvh/iCi3mycHOfIBkx9c1VgWYthXwOba0wSBDFg8izjd9za7kGPW6YwtkR/U4f
X-Proofpoint-GUID: Yl469E72i36dluYpiRv6a-bpgRYsWpxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250081

On 7/25/25 11:36 AM, Yijie Yang wrote:
> 
> 
> On 2025-07-25 17:18, Krzysztof Kozlowski wrote:
>> On 25/07/2025 11:01, Yijie Yang wrote:
>>>
>>> wcn7850_pmu: wcn7850-pmu@xxxx {
>>>       compatible = "qcom,wcn7850-pmu";
>>>       reg = <0x...>;
>>>       vdd-supply = <&dummy_reg>;
>>>       vddaon-supply = <&dummy_reg>;
>>>       vdddig-supply = <&dummy_reg>;
>>>       vddrfa1p2-supply = <&dummy_reg>;
>>>       vddrfa1p8-supply = <&dummy_reg>;
>>> };
>>> This approach ensures the DTB passes schema checks while keeping the
>>> implementation clean and consistent with the actual platform setup. Do
>>> you think this is appropriate?
>>
>> No. There is no dummy regulator in the hardware, so you cannot add it to
>> the DTS.
> 
> What should I do in this case? Is it acceptable to deviate from the dt-binding rules due to differences in firmware behavior? Otherwise, I’ll need to revert to the first version, leave a TODO in the DTS, and wait for someone to properly model the M.2 card.

The reason we describe the regulators is so that the Wi-Fi can be
powered off and back on. Please don't invent any hacks.

Konrad

