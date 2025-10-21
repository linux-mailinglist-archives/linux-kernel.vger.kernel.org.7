Return-Path: <linux-kernel+bounces-863146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1479CBF71CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AAC1884C79
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459FB1F237A;
	Tue, 21 Oct 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJVCQzYw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF93255F31
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057561; cv=none; b=Ka5WNS1iXe2ZQSWrilgQ6/0SvKktG2QRJRwtI2lk6reUXzQ+AmvYO9b9EwpSiGgBIlJtUGSKuYnxRUanG5YEfGnO2C5E77xDK2nVzUpv7lBoKMTZDtXZvPkSGpwhJBxP7ifLcfZrZqEzPgouEW/CJyGPem/q6QLR1gY8Lh0d3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057561; c=relaxed/simple;
	bh=/hA9NoFGhfnZrNa6jkAo1og2y48VWyOMESR2eTab7Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsDqiyfz2kAMfKM6EwFWsJiKP/QO31KGW/w29rtQvcbzSqI1GDnzBYvdZ5gTW5O+5c2DFdzunPjMvoLKbWNDPwtXBzmQSjJnYswE+16TZ3zEmLJGzgmvnzmmYslYR5g3GzhtHX3LzjUkqrdcEpTPpw1XIakld6GROtlCgjqch28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jJVCQzYw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LECWV7004443
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IYiRng46K/9s0YcunKwJaYrPPhduE6KoJmzcZ76VteI=; b=jJVCQzYwQGZ2K844
	iAMShQ/NzcPzQWK1iWtjhpn/v8B2BxbqzdaI46BQX8nO7+3oEImpKmQlHDN+L9pP
	zBO9E4kNaRdmEmslpv7FgUeMV9VL80gOUUwQ824W6+CRiypYnxvgzVH4brIWsOpv
	FihxEnberXZaEh9Nn8P+LxuLFpBHaeMnq0nz6dI74qjUcxP5AnFlNZMCl/MmPAdb
	QokuSTC/9XbSJFBGgd87imZFRQi3BWy6lxtgc3FNOedJEfzSUl3MU8yRrvmHIPUG
	+zKgY05LUKcdGB1T0+ZSXLaN36XB6D91LG5LcNWiMhCL/WhuffI4Qj3oSbj2vwO9
	mYDJBA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfh1p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:39:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28bd8b3fa67so54925625ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761057558; x=1761662358;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYiRng46K/9s0YcunKwJaYrPPhduE6KoJmzcZ76VteI=;
        b=u0OOovQL4QBa/nLaL8r/jvEPcOYsL9gXd+xEOvwQAh9BDR5PumvVH3/Yj812nIk0mT
         /Rtd0IvPCahu68gkylKNRZg21EEwnw1E1bRA46fodkSU+TTESdNyM1JrcWff/G0Pmkpa
         es/MkHOud9sYJt9uqlpI+5jRDKHHqBAPpn3FFAjPqIXyXKFvdZ+3tHxXU1EqqNaA3pMP
         toAWl04bt86SGhQ6XY6dGSC4Lj6vzcZEX0sS7Q4xyxbhYJTyr3//mJM/llrhvZ5bEqwH
         6Pk9KI3oBvNG9BKmeEUKDE4VTa3sRkbEYMAEk8pQsX5tNAS4DY/3jI27SVCdn+KhauXj
         3uXw==
X-Forwarded-Encrypted: i=1; AJvYcCUcLD2El8ZDhYzTDPsY5lyWtKqXYdAe0efBru/mn2nxBsF2ZENLrNCs9EKnBJNWi9kMmtjSscTRkIBAk4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/Zp/7xg4kinpAjMsA8x7AU9qIIrmQm+Yo/Q9n5aXdFvxRy/M
	rEovRZYmrZdepgpEEo6ZJFBxZP7GyPdjq4NhzaGBqNe239C1sxj93jcxI+So/efZ3yT6X1wHMcS
	zCWqaYB8kZ4dCu4Z1h77AoQn0W9pMBq8NAzX3l4cmUxykrGsk7bbGTRXi87AI8dwSukM=
X-Gm-Gg: ASbGncuWG3sw80eP34xN5A2AX39OjGSJqDGsnsr098WWjdv/NUAYFSoGnPa9xsAz85d
	LYvT/zTaMvQYg+GXRp8v2QU4/+F1Mt2tGzBFi/Vc2iWW+zQdnF5yr1tLBsjzu4PThZ7eWSFp1qC
	GSLuM3eCnuPVTUVTGb/KxEsTgCHxtu7+5iyG9JQM6t7HsWoOj22qRYj3fA75TN7jg/maiQRx4CX
	/pd+Hx2vnq61TLmu0q2zBOXlpw1tkFQ5LiC+XfwThXAuoOvaVcKETXGMaGevmf3rJRyvpu7QqwH
	01CD+rMsgovrxu9VJ/9AIE12Wd0ees0EhjHfQ7S3chaqWCLCBPKxsijysAWU1Th7H+UhfqRd4Jn
	XEKWCp7JxrylWKDrObTaOoA==
X-Received: by 2002:a17:902:e88e:b0:267:cdb8:c683 with SMTP id d9443c01a7336-290c9cf1785mr209130725ad.27.1761057558265;
        Tue, 21 Oct 2025 07:39:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7Xu3yqvqq7tM2Hj4ax162jdVvcEgPtgB391HBWPwgMC3PxAc2yK/s89219b9zTLDa4YQfTA==
X-Received: by 2002:a17:902:e88e:b0:267:cdb8:c683 with SMTP id d9443c01a7336-290c9cf1785mr209130335ad.27.1761057557695;
        Tue, 21 Oct 2025 07:39:17 -0700 (PDT)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcdefsm111879115ad.16.2025.10.21.07.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 07:39:17 -0700 (PDT)
Message-ID: <769b0fb2-75b3-45ef-b798-02ae5982b736@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 20:09:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: display/msm: gpu: Document A612 GPU
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
 <20251017-qcs615-spin-2-v1-2-0baa44f80905@oss.qualcomm.com>
 <811c728c-e2c9-462d-9c7a-dd79a683e301@kernel.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <811c728c-e2c9-462d-9c7a-dd79a683e301@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qL-ds54oJGHuWWvPBoxTe6qmaoMml8f8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX+SdRCdOhlphQ
 Sv+1uyLwhvFevxEEMkFspv5R7FGaPM6Bz/zD1f+ir4QJFhYSGQWpaUFAMq0sLVx3QYOuOKFXTQQ
 2W81OX3hVQXXrq0ffHaNBTlKC4ZF/N919wYGMU6qYAsy+gFuCctPEz8JTPQ0d0pelN0c0y41IBB
 ZsiIl70K+DrTwKggZkPeCc9w7I82TSZOwfwE8P0RaLeQSVUyVhm2UuWpCBqGG4XyF4yIrroWlHq
 79l6MLLY+TdFiB/zTyxFXZEtbmf5neXks6U7+HciAcOKVjz6ZIhQ0LI2PlAUhFlVk0d4KkfrzUK
 UwJNe3pEpwkCbRGWgyW/gI0njRsZc1yNossyqEPxaWhZTOckXydJqloAlssIl/nBiRXAYY/nYOZ
 jBViGpYd5Ep8udC16nVBBGGFkURztA==
X-Proofpoint-GUID: qL-ds54oJGHuWWvPBoxTe6qmaoMml8f8
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f79b17 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=PLUc99ambSscJNFV4OcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On 10/19/2025 2:40 PM, Krzysztof Kozlowski wrote:
> On 17/10/2025 19:08, Akhil P Oommen wrote:
>> A612 GPU has a new IP called RGMU (Reduced Graphics Management Unit)
>> which replaces GMU. But it doesn't do clock or voltage scaling. So we
>> need the gpu core clock in the GPU node along with the power domain to
>> do clock and voltage scaling from the kernel. Update the bindings to
>> describe this GPU.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/display/msm/gpu.yaml       | 31 ++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> index 3696b083e353031a496a1f299d8f373270ca562d..efc529e82bc198e7c3c89a5eecb6f929960a8de9 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> @@ -45,11 +45,11 @@ properties:
>>            - const: amd,imageon
>>  
>>    clocks:
>> -    minItems: 2
>> +    minItems: 1
>>      maxItems: 7
>>  
>>    clock-names:
>> -    minItems: 2
>> +    minItems: 1
>>      maxItems: 7
>>  
>>    reg:
>> @@ -388,6 +388,33 @@ allOf:
>>        required:
>>          - clocks
>>          - clock-names
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,adreno-612.0
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 1
> 
> Drop, it's implied.
> 
> 
>> +          maxItems: 1
>> +
>> +        clock-names:
>> +          items:
>> +            - const: core
>> +              description: GPU Core clock
>> +
> 
> Missing constraint for 'reg'.

I suppose we should add reg property with a list of (items:) reg
descriptions. No need for 'min/minxItems constraints as it is not flexible.

> 
>> +        reg-names:
>> +          minItems: 1
> 
> Drop. MMIO range is not flexible.

Ack.

-Akhil

> 
>> +          items:
>> +            - const: kgsl_3d0_reg_memory
>> +            - const: cx_dbgc
>> +
> Best regards,
> Krzysztof


