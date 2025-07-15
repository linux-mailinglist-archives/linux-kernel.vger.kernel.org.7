Return-Path: <linux-kernel+bounces-731638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB3AB05786
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754CB3B47A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6902D63F4;
	Tue, 15 Jul 2025 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tzh9VO3/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD3274B41
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574191; cv=none; b=X86swpnK6bSgQvZDfEh0Jlq4l/phviU6s8JtbQgV0slqpOX8Rr+N1Z9N+k1FK3rteR1Xf43xrhIceh5YBqp9IdCWnp45fKXsmQpPXRnfO+u87CjVSXYv/vyK0IodJMlD7kUDotUhdt2wCruH21DxroLs/MTjS3bjkvG+jtqi/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574191; c=relaxed/simple;
	bh=i+gH7R0LZRVIIIuYrUj5ZHZ2SixenD8ZXHuSoR9aPY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMH9uiwigTuu+I0HuW0h1nT4O3voBe4KB3gnMrfHN5g+YcsvJo/xI0MCA4psDk+hGs635xVS5eF94KOUdfU5X5MM8pmo99MYVeZ0C8P8Ff6S5gH1h6khvOZqX8AgVaGTnJn4l0jO5yoskRg/AxFUFpoNYfJ/3Kbp46VtYOgMS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tzh9VO3/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8kIQl026626
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p/9yPeCO/DS01G52hKx0pmh8Iyn7M6trOa1KExfG4Fg=; b=Tzh9VO3/UhkfHXiL
	gRXOgUowcGJmhRtEl3SS/6PqtsHwzKmxonGt/FvvYtHL3SVaz5HHePbWOs5OnfIm
	8TBvU4VyqJOb6v//P0V4Ruk0qqP1j91JUrTdfGWgDpmssohpb44PP/4fTBo/2l1h
	wF5kMuLThOH/gUmVm0ZXfncX1eXO2aY6g/MW4tz8eQQQH2T5ecluEU/L2clwSYoo
	7IK3uekaQ7htGH4dthfoo79zMeCQ/5I7uNJ8/N0o8/wZ6aksF5fJXfqHRChVASbX
	tgKf2+tHQX9Txuc93PkCITZRtpwefATgUob6WQl1KYVZmQz9lMYtt5bxm8478wfp
	VOX/sQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkrugap2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:09:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fd1dcf1c5bso13584586d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752574188; x=1753178988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/9yPeCO/DS01G52hKx0pmh8Iyn7M6trOa1KExfG4Fg=;
        b=sXG0QmWEBWJogQQ8Cey3x738tn0ujxZH55vMyP20OuEvc3hnrV6R1dOSUVCo6XmUAZ
         I5Oh9HJKR/d04JYxBO4sXnTATtZLJAxiEDwrPS9EdKJsxCqW6fqVl9HHL2s2xTVAwEGp
         YSNSCmvP9qIGJPFu7Q9cIJor81O3h8mm0a4/YesE10SOTcW5WAjEX/s4eHhVcpkW7Hme
         dtkBwTwvqMxXPKiRZViVDeMUbzFygYwxLwG6Mx+CSzhMwZ/0+jDMkzV3goDrQcSO3cDX
         YcyE5wjwogbNuKZf2/RdXrQRbNk9hTMIOIfLYKGPQlOhgqGQeClOvEBReDqjGm6UpsP0
         xSgg==
X-Forwarded-Encrypted: i=1; AJvYcCXTf1ZtTssrvhDv9vdK4V3wbuzh23kSBWSpyR9+yaElzeW96nWRg0b9mJs4amAECVG3ECqdu6Dnn13Y4sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdi74/ocHxKOksyPYwBeeonn5wMmYQ/SrdyEUh82nFg40QxHtn
	U4k734XmoyOjkI2xkpBkGBdPc1JJhdvBDoKICHSHo/DYQZkIZXwS5l3o09EKo06WDXY8SEagdsy
	mymffDl3lR9xsNvbmRyM72egqIioB70pZJ0ttg3T6cT39Z8snudzeMv//U7XJpuYgcbQ=
X-Gm-Gg: ASbGncvYLgbVKkFQTBnAei7hEdF+lJaf5WdXq9zfD2X+/FViPXk68JrB6BU2+eU8c97
	uOVRmZVQregiFuRS6Soad6/6gZ1CZ34LeT/YK+oBkFaNbgPm/8rh5+xcZs3DsoPO5VHhz5bl8X5
	oo88r9y6Q+VwbSZMTuRP8dC3dZTSjfnxlCAveW3HSI0+GCMZEkHgDQi+dQod+iIRQckdIA92YjJ
	zQW1SbNtF4MBrTq/iXfEHive6E+apLgR5lwckJE0pindPWJoYre6cfoSv5KneoqabSSZI0lsAOq
	X080GaiKuHyohkr4yPibICon5gCLPSnQlfGqnL3G3/y6PHr4eix53/NFZFbFSmaTCFbktgLAGJT
	qMCeBHuxaJnjbZVi1IS9C
X-Received: by 2002:a05:620a:294a:b0:7d5:c29a:b41d with SMTP id af79cd13be357-7e33c732767mr48852485a.6.1752574187599;
        Tue, 15 Jul 2025 03:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEucUXdsrXGUZIWwqatrgphc74gzCF2olPTtlwfbIxpe9espEQV4QYSpJZP78hbow6C50+e0A==
X-Received: by 2002:a05:620a:294a:b0:7d5:c29a:b41d with SMTP id af79cd13be357-7e33c732767mr48850285a.6.1752574187039;
        Tue, 15 Jul 2025 03:09:47 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c94f2bcdsm7032397a12.4.2025.07.15.03.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:09:46 -0700 (PDT)
Message-ID: <b5a68138-4eca-4bdd-8f72-d80236b02c0a@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 12:09:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
 <20250714-b4-sm8750-iris-dts-v1-1-93629b246d2e@linaro.org>
 <5dd36649-821c-450e-bdcc-871735d10059@linaro.org>
 <15b8b9e0-a211-4102-9b68-994c8ab50a7a@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <15b8b9e0-a211-4102-9b68-994c8ab50a7a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TVhXmc7QH7NRLxJ31EByCkVIXnV0Uku_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5MSBTYWx0ZWRfX3MFk5Gu14aCi
 L/n5ixUlL0lQa99pXAu7r/6lAeVahcmg11aqsWJvRivP0o6TZrI9eZ5m8Xv9zAnRrbcdvq6CJZu
 e1cswk8qIOGNm7aiAG+VgB2aapu8r6MqYD4YRD3+Q9nCyh0gzgbleNBZJ7KNtwU1aiPpae7bW6a
 wB9NaY/DsD+axyDteGRKJfl6zE/Ak6MX0Qbp2LqqpPheKCexfXH7N/eWK4y17LLd7N8vBSyKKz1
 Oxb/D47CpHVgMOv+uArJ74VlD/BCO+xYd0NmY+VT+SFz+nibWwh3vtD3W9vJmrmKlLjqGzH35pp
 O/KM4Am2QEK7DwpMGCSXkqaJ4/N9d3F4Zq3xLjFySy/imzn5ifRG5pssDrHeBlESaSeWd71JEoB
 /A1oeyVhzmnmk4awQnl/bpZuZ3pQaRUUpDFDdwxZz4kAkZBc/vgaTsRLtUp2qDS4eMXAmTCr
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=687628ed cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=DXF70n8Wv7XxJ0iPIvEA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: TVhXmc7QH7NRLxJ31EByCkVIXnV0Uku_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=768 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150091

On 7/15/25 12:07 PM, Krzysztof Kozlowski wrote:
> On 15/07/2025 11:32, Krzysztof Kozlowski wrote:
>> On 14/07/2025 15:55, Krzysztof Kozlowski wrote:
>>> +
>>> +		videocc: clock-controller@aaf0000 {
>>> +			compatible = "qcom,sm8750-videocc";
>>> +			reg = <0x0 0x0aaf0000 0x0 0x10000>;
>>> +			clocks = <&bi_tcxo_div2>,
>>> +				 <&gcc GCC_VIDEO_AHB_CLK>;
>>> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
>>
>> This is incomplete, need second power domain and I did not check against
>> qcom,sm8750-videocc schema before sending. I will send a v2 a bit later
>> (maybe some reviews pop up).
> 
> Heh, no. The DTS here is correct. The videocc bindings are not correct
> (and that's not my patch).

Well, you want two power domains here in either case..

Konrad

