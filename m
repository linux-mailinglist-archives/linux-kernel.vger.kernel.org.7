Return-Path: <linux-kernel+bounces-745503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BF6B11ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A9F3B4017
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96B52D320B;
	Fri, 25 Jul 2025 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0AgewKN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A62D0278
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435865; cv=none; b=RZsC9mV0mgPkY7XXVIBPnhjQL/BoHu+if1knouTDIxCdFDKcdY6BYvrrKi9oPB2/zrm3peZsIztoL4DjHaTeMpHfV2YNptKZleJy3P9FJQSCkVsIfonjNBwNUXFI+WRAB2WJvDHAZLTSuwbJRlZTLyrtZTY/6Sry/jGbVFRKXU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435865; c=relaxed/simple;
	bh=nUHw6qP239Oq8jyKrq+quvMkdXJhaA8f0RlXWhVYRvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Or0NhUPnOm5I1LVCKlLRY4t8MCMiEqO8hzVlmyvxWH1K3xZwV56ec/YOCFHg83jdnX7VhEo/2W2Q785CuCJnOTeyqjT2XfLWnxgwMA+LDq2VwMYjOJAT03Yx6G/NsLEU+N+wAZpEqugGunZFTRLZhU4kQL+cwJT2y8GTH6RPYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H0AgewKN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P97I3c023660
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UHICGwDwDl8daLhetFxgvsPtxOilAqYGnlpMT/3FILM=; b=H0AgewKNMaOsW8EU
	f62QnRdnuAMqJkLNTgd73eMxoIxelTBzL/moR+Xlwlx7jqG2DmfoV0xu/YRgdZlB
	xjV9TT2nKmIbjxQATJhS+BIeiFTG5vIA03BIWcbpbBGzfFltb0IR/rRhLfAtDeRp
	yeurOMn+YsbaQwf5K4mjwMG/wUExUPmXs+udOFOY/qTko0jTHZ65VCxPNYa4iN/G
	BiNliyjDAnj3cAD38IzoXaFCZV5OcalSlh8toeYKFqyNMJmeyBeNaJ7mKg2iTo3b
	BE/W8zYo8dhDtnMyHKfyg9/+nbf4yr4J8Z3r+KlJ6+tb//C+uJb2Tylf7ctol42n
	MLmBbQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2r9jh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:31:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e33e133f42so53496685a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753435862; x=1754040662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHICGwDwDl8daLhetFxgvsPtxOilAqYGnlpMT/3FILM=;
        b=ACHSXe3BJ6ckbvhDTOu5biVONZjA6zmOJ4ZIhIg6VdJjAQ9b/C1JYi6E2h6+M3Xh4R
         MQJPsC44Duj8i4e3wWwyPCfnZa8/pwiJ4vj3pO2DIhq+KMNM6YZjOf4X/CCuNfNsqbHG
         Id9GbxKACD9Jrsy+YLkWvV3FL5iBqar0DAKcLemIuGlH0FViAgpMG9nZyR7nZH1sW97j
         8TjLYgiAIFL0efeGtQXezhUM91+sSoYCNl9dS53NyYGiJs108diAwNds00nc5TDhAnbN
         beQqnyNQkDwlAPF0zUCEROUjjOgXre45ecVXeksYo3hoYwQxsU4NnPP5cvrk1L3TLFy9
         dDpg==
X-Forwarded-Encrypted: i=1; AJvYcCVc7NStHtLviFdhUXdpaLPOObdJT39e22h9Mgy2vdFaEIsWWqqSqLlnFZQDNMgy165dg3L6wOcdz/zpCpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSoL+L74A7+QcjOlgd0R08MW2UE6PVwFmq35zl388uITVWn7e
	hWQLgw+wpr4Xm/BdbNgCtcXvkbj1qH3mk0IBHy+yr3lMqoFL1P5dfaP7RNZkhAwZnMGVlOuW0lC
	mLtPYbqTGtx3hGc4S+TzAvLWkdPmHmBoWYUBLeGJBPo6To9j+qdVHqmzkBLsv7/YBI4o=
X-Gm-Gg: ASbGncsx633WIWiNq2nT+z/gK2pnKd6HQyWJNetJrbI0WB48SyPpIv6SDa/9kbprl/b
	9NaY8BlRXJ9Fq4VjN34NMzRdo6AaxgrnvOim971zqfgSY0cULBJ6l+ZqTEHwogaX5EKYA13IQRt
	dvqLM+ekODOGpoY36MoERszDJi8hZ0p+sXBbfvFMsq9IgEzqCZ1WcrvKwgEZkrA0td/0WpxAt8N
	IQQhGUDxsS9i7G2Q7xzIEfEDolFbBbbvZx8u1UwFjZlSVT3kBiICgf48fPzX8wvgZQ9d0zBZzeU
	5tJ6sOV3emCyXP3xOpRtRa0a2/PFvxkYcb7rDpcaLN6AJAMLc5jW9prRAAUrFYDkN38VmAL9LEW
	GvGxokasTnJRfFTEx7A==
X-Received: by 2002:a05:620a:472b:b0:7e3:49b9:d06a with SMTP id af79cd13be357-7e63bfa59f0mr48179585a.9.1753435861408;
        Fri, 25 Jul 2025 02:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2nBHxoBD5pfk+D4HZkaX/oRldqRoW3uOXw1dgDzm0zFAJsz26a1olh1gz5zMUTAt4W1if2w==
X-Received: by 2002:a05:620a:472b:b0:7e3:49b9:d06a with SMTP id af79cd13be357-7e63bfa59f0mr48176885a.9.1753435860738;
        Fri, 25 Jul 2025 02:31:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cd650basm240182766b.58.2025.07.25.02.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:31:00 -0700 (PDT)
Message-ID: <54b617c1-bd1b-4244-b75d-57eaaa2c083d@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 11:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: qcom: Add SM8750 GPU clocks
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723-topic-8750_gpucc-v2-0-56c93b84c390@oss.qualcomm.com>
 <20250723-topic-8750_gpucc-v2-1-56c93b84c390@oss.qualcomm.com>
 <20250724-blazing-therapeutic-python-1e96ca@kuoka>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724-blazing-therapeutic-python-1e96ca@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NfTm13D4 c=1 sm=1 tr=0 ts=68834ed7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZXpw8kv6nMavt5JzddgA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Y7Wt39yZ7pVPBQStDQJFZonSXFyIVaTK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4MCBTYWx0ZWRfX46I9Im0s7KYG
 prjcP7G2P0ygGv56bb87qX1n4ykt+pMmPKp2YpupF54jkCQNWmxWnw8fBcYE2EXJbuAUh/cayFl
 MlLw/vH6KIVLjMa2J3ikxuCUTS45JCQyFpz6lUEyqxywu7Az1r/KsfUUkKHx3mrYFsT5ha01qfC
 pM23jxFDMqAD3jVTRy+q5VTxdt5OQ0YDQe10SVbcHoUb7I/miXRbnqbJMnVAIvdkvCP46ikIVFx
 3/1E93MCghWG4fPZYrtIoiOUFn5LekefLBzCMSCjGqPVp04hpxLVT6ufAY/W+TukM4JcCQoEqG8
 8BLeR85Spcyr41bOggqIK8cs0BCihLkP4C5oSVenhbaluCqxgwigMRtlv6Br7vYj7GhSLGyfuPg
 X1smwD4zZ23yeURsGx0JPoloeLGx8gtLHi1+CxOkQsyDbEax+K18J4by1L6OdD1q+T/uj2tc
X-Proofpoint-GUID: Y7Wt39yZ7pVPBQStDQJFZonSXFyIVaTK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250080

On 7/24/25 10:18 AM, Krzysztof Kozlowski wrote:
> On Wed, Jul 23, 2025 at 10:38:48PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The SM8750 features a "traditional" GPU_CC block, much of which is
>> controlled through the GMU microcontroller. Additionally, there's
>> an separate GX_CC block, where the GX GDSC is moved.
>>
>> Add bindings to accommodate for that.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  .../bindings/clock/qcom,sm8450-gpucc.yaml          |  5 ++
>>  .../bindings/clock/qcom,sm8750-gxcc.yaml           | 61 ++++++++++++++++++++++
>>  include/dt-bindings/clock/qcom,sm8750-gpucc.h      | 53 +++++++++++++++++++
>>  3 files changed, 119 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
>> index 02968632fb3af34d6b3983a6a24aa742db1d59b1..d1b3557ab344b071d16dba4d5c6a267b7ab70573 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
>> @@ -20,6 +20,7 @@ description: |
>>      include/dt-bindings/clock/qcom,sm8550-gpucc.h
>>      include/dt-bindings/reset/qcom,sm8450-gpucc.h
>>      include/dt-bindings/reset/qcom,sm8650-gpucc.h
>> +    include/dt-bindings/reset/qcom,sm8750-gpucc.h
>>      include/dt-bindings/reset/qcom,x1e80100-gpucc.h
>>  
>>  properties:
>> @@ -31,6 +32,7 @@ properties:
>>        - qcom,sm8475-gpucc
>>        - qcom,sm8550-gpucc
>>        - qcom,sm8650-gpucc
>> +      - qcom,sm8750-gpucc
>>        - qcom,x1e80100-gpucc
>>        - qcom,x1p42100-gpucc
>>  
>> @@ -40,6 +42,9 @@ properties:
>>        - description: GPLL0 main branch source
>>        - description: GPLL0 div branch source
>>  
>> +  power-domains:
>> +    maxItems: 1
> 
> This should be a different binding or you need to restrict other
> variants here.

Actually looks like this is the same case as the recent videocc changes
(15 year old technical debt catching up to us..)

I'll send a mass-fixup for this.

Some platforms require 2 and some require 3 entries here. Do I have to
restrict them very specifically, or can I do:

power-domains:
  description:
    Power domains required for the clock controller to operate
  minItems: 2
  items:
    - description: CX power domain
    - description: MX power domain
    - description: MXC power domain

?

Konrad

