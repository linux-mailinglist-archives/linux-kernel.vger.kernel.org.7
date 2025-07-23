Return-Path: <linux-kernel+bounces-742173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B31B0EE49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16913568292
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3433828643D;
	Wed, 23 Jul 2025 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V7zfWItt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC11E2834
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262507; cv=none; b=B7nv8wHT9IN0jfo23n9yXrpZKFuCQ4uVq7gZWiB7+xBMKkUvQUE2+reAU747ERAe9apdvopKmmnon62q0mZO+ciaSZNUELJZrHST2w63OFUhI6WVjLmqz+FnbD+lTk4ix9ILMJiyGQYR3PE7RDyS2xQ8L0UdPxXsXLbdwshcIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262507; c=relaxed/simple;
	bh=lhb31hAfmJWv+pFCSk8uxuRQUATQK2rglMLyJJynjCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nO8OEvAPx/7rjyTY4f9gZ7qJWxXQ2RaB7M1h76AetsZ+CFreSh4nYwoY6ShED6NB5XXSkfU2bH/j49jFOe2TUAjOu1ONlHfDb6jgGDCLz1/DBgWnBgeix6wfVmjJn6f3Ozf7u8cQG9uDACKj0YOMFiuKXfa0dTAm7wzVqL0KDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V7zfWItt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMNtV0032299
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nb/6O3iiOkNyz5fp5T+ekQVrNaBGU510DuWWGBJBlD4=; b=V7zfWItt8+wifj2c
	wRGy4DMLzDM013wvEXJwXusO5btF7AzB+r6aldVoaL5uO4VAa6viLxSt+a4Pmgt3
	HcKWLrUAeu7vl7TThd4d8/7sGJcCtgCIdAuy9cPKWRqj1CTQG05IF7dbC3oS+7eU
	m48Pm468vZl/Gtt4NnuL+y7V1RBIq2ci8OfqdxKGSSMx7a9P7y82wn0LqzV0lQIQ
	i/c6t3dCmbMZtg+wNAN389e0dJElI7niMdLrT8Xij8HFmEVn+kSd2dut2gcFD16l
	7JfeqonA4DxqDUvnLzzWwKF1fUXnAWFLzbWeN6sTddgjYz6dt1q1PS4yjIw4kSy1
	XiDzgg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1bwgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:21:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311d670ad35so6115082a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753262503; x=1753867303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nb/6O3iiOkNyz5fp5T+ekQVrNaBGU510DuWWGBJBlD4=;
        b=mtkxTHt1DcSK3/ORJtRdcdXOhILK75Q6j5xSMDhApL/WIvTyt+YFe7xU3CEznISCIM
         xEedyYTkvaftuzDzwRsy5GcboTkYAh76Q9IVjG6ODk0Jl2KiObmaGSCAoeVFXnM6VD08
         ILtDrGo2VBTkHAoVhq7Dvg2y8eQaAnpHhOLRcvjqMGVrQsHUS/yYt5JmW+unP4WJjn5O
         YoYmWT+3bufylaioj1nLWTc7WWM65iXgs/ZDVRycfzeD+G0GsuYFBlCHGnQrSixzsFos
         MKy1Ml9q3r5+jAU+R/glnOHomhXqjv+5n2fxuktbL1mZd1QhJqPdoqoyoKqpRR3K0fhm
         XoxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbMpJMQuGNnuPMyLzFudmPP0YXFnj/zGg5BacADU7hRqleAAdZM5dxvBOX0MxO/vcG2UNwo3TYsajJ1zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywva06DFLwt0K81usxOnPuJn8Mf5tGEXppTMLVDIdy4IYBlTRlB
	24utTYSyTXo21xLD1eWTL8q3pWlBMldfioLwAVYfH9MkR0WDkfpmx38KNloU/B8uwDfEgVa8pf0
	E6EgzjHP6/tUnMyRuT35pHTAB7gSnSNyyW7bDbLS5VdvHOCz2FP6eG5/ME3bB6+TPfd0=
X-Gm-Gg: ASbGncvHcA87qsPny0Kggs+iEsZEkXpw7J4zL29LhGo8/Vm7MaOxRhujZ1askLUl9Cu
	xVPzeL9S48Kbd3C32vTlfQfsSKyQv37LIAlkbtxj2wh3CEqOtl6vfNLsLTXGiPoi0XV6RVNwM6l
	sCtgh8iNETtBahDe7efOtOXGPZO7pNmY2+nrtYm0Ez/qr/qleAj+0ShdVAccKhEt2Yjwv6PWx7d
	rRCdBa6iyWgQII79WfK4C7FvzsdzMQRSsGQJTC2SYAtfCIjWVXekscpMCz16JcEyI3XPdFXVK0A
	euICCVlGCPcqll1Yx+TwkTklKx/zYwbMQ/jpSP+QZ2pRPVKTqya/yMIkkPD5JG1QQw4=
X-Received: by 2002:a17:90b:3f8f:b0:312:639:a058 with SMTP id 98e67ed59e1d1-31e5082e792mr3737782a91.27.1753262503142;
        Wed, 23 Jul 2025 02:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt87+pV3bznhTxSzIjTAcYlS83i2dw2B8Ky3HyJPtNmRuAysXZs8ygxv0dO+g66ulY7n8p3A==
X-Received: by 2002:a17:90b:3f8f:b0:312:639:a058 with SMTP id 98e67ed59e1d1-31e5082e792mr3737742a91.27.1753262502629;
        Wed, 23 Jul 2025 02:21:42 -0700 (PDT)
Received: from [10.217.216.26] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff63683sm7223957a12.41.2025.07.23.02.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:21:42 -0700 (PDT)
Message-ID: <ff05ceaf-6e32-4d66-ac2b-a1b55f41adbb@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 14:51:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] dt-bindings: clock: qcom: Add bindings documentation
 for the Glymur TCSR
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        quic_rjendra@quicinc.com, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
 <20250716152017.4070029-3-pankaj.patil@oss.qualcomm.com>
 <20250721-striped-defiant-hippo-6dee44@kuoka>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20250721-striped-defiant-hippo-6dee44@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IOxKlm-OdmG03PFCf4AybAwYqGGypX-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA3OCBTYWx0ZWRfXxxfakUW3dDd5
 KlRdWclWsQS91g/8ZJ5GfUV23PoszjWi1iQveqeUrsklZVt5yCzCrFIzgwIju7td3UzPgEcv/J1
 5pcr8zL0Dtid4XlSGeoEOE8jjbXxRZq9DPcbg8kebk0/H9RQ+rNmqi2SFuNNivbyENC1KphY+tw
 EcJx6vYbIRZ36yKkz8hHeycvKWxFG1ZAsVOTrlQ41hOuYhwPLMrrb+FfRpI8uLgrxrtGNI5Nz8F
 83O6vx9aEFyUEB56sGgKZB8ZuDVgSH5ZRoC8cVLrpEvhQenTOvrsXjo4n6N/6OJN3mf7niSLQvV
 tF2wmCY44yG/veD4wsixKKOBxBqdQPCzGw3M9ghVUb5PlVfa4/VExq6dtG9zgOE5EBrp4SQP2Fn
 xYvDGx1cfmH/X7HeqFvSvQRHuOk4abuFu5psv3ZCAVwwx8xn53IDOn4L3jRq3M0mAmOXJcsA
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=6880a9a8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=CvYCOFMdU_owP9l6gQwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: IOxKlm-OdmG03PFCf4AybAwYqGGypX-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230078



On 7/21/2025 2:49 PM, Krzysztof Kozlowski wrote:
> On Wed, Jul 16, 2025 at 08:50:12PM +0530, Pankaj Patil wrote:
>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>
>> The Glymur TCSR block provides CLKREF clocks for EDP, PCIe, and USB. Add
>> this to the TCSR clock controller binding together with identifiers for
>> the clocks
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> And same for documentation...
>

Will fix this as well.


>> ---
>>  .../bindings/clock/qcom,sm8550-tcsr.yaml      |  3 +++
>>  .../dt-bindings/clock/qcom,glymur-tcsrcc.h    | 24 +++++++++++++++++++
>>  2 files changed, 27 insertions(+)
>>  create mode 100644 include/dt-bindings/clock/qcom,glymur-tcsrcc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
>> index f3afbb25e868..9fbf88836782 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
>> @@ -8,12 +8,14 @@ title: Qualcomm TCSR Clock Controller on SM8550
>>  
>>  maintainers:
>>    - Bjorn Andersson <andersson@kernel.org>
>> +  - Taniya Das <taniya.das@oss.qualcomm.com>
>>  
>>  description: |
>>    Qualcomm TCSR clock control module provides the clocks, resets and
>>    power domains on SM8550
>>  
>>    See also:
>> +  - include/dt-bindings/clock/qcom,glymur-tcsr.h
>>    - include/dt-bindings/clock/qcom,sm8550-tcsr.h
>>    - include/dt-bindings/clock/qcom,sm8650-tcsr.h
>>    - include/dt-bindings/clock/qcom,sm8750-tcsr.h
>> @@ -22,6 +24,7 @@ properties:
>>    compatible:
>>      items:
>>        - enum:
>> +          - qcom,glymur-tcsr
>>            - qcom,sar2130p-tcsr
>>            - qcom,sm8550-tcsr
>>            - qcom,sm8650-tcsr
>> diff --git a/include/dt-bindings/clock/qcom,glymur-tcsrcc.h b/include/dt-bindings/clock/qcom,glymur-tcsrcc.h
>> new file mode 100644
>> index 000000000000..72614226b113
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,glymur-tcsrcc.h
> 
> Filename matching compatible.
> 
> Best regards,
> Krzysztof
> 


Yes, I will take care.
-- 
Thanks,
Taniya Das


