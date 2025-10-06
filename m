Return-Path: <linux-kernel+bounces-842690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB3BBD4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19BE8349943
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7616E25C6FF;
	Mon,  6 Oct 2025 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jEp70esJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A08258EF0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738208; cv=none; b=jIrgk2oGRVjHfAQCCxTLij2NqQweYlJ42Ob4DTlyj4zjsIMwpfJQwv4TidcSybgQ8hzpygA1irZzFAQY98WllVsrLXm+WuaEoGmYYfs2npvF2BaAhVC3ZsW8hutirfcfoIcbEswsMG9pCuipG0+Qwz7mcksbK6A/If5uqMhlhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738208; c=relaxed/simple;
	bh=rRqbDNJJozQdwKsc1j1gRxEQnE8tCHyuKOkR/azckzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiKWB05hs1P/LrbUZAPdS4QEMD8G7aU4Qtt+c4uyVmUZF28mMJUCZPUSeZno8wmP8srTNxqzYZzVlDxLTbV5uEMRJ4+TvtGOkq7Lr2Z9Cc19I/XEi6Kim+h0I2KGi0s/u6IuA0CL4jA3uP7W11rfqNjalwbSAIjsD/ioIM13oSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jEp70esJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595NSCn2017282
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 08:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	45B2sK23pf0jnxjuCOALGNeyqT1UiqcLuxhMNfIiCBw=; b=jEp70esJYas4wP69
	EowecLSY7WmaabZdARHwHT9ugwH54IG+TlFi/IhroB7Lz1f1yxlKOkS8J8Y4Z41o
	Px2+FrIDWNQqpLXwEM4IzeCtnPbtIN6o58bre1rNlNxnRxrd4t4k1B3Ry10++8TF
	mlvMshue8/KWZHpR2XMJDBtR2TNdm7LEzdbpNWPJaquD/OQ7u/j9PqUy1XxvcGyL
	o/LzQgyYOIHyGJYMVeVtcTOdsqE9vvSePh0mSsHdf0QpWWQqCmD7df3FBeQUcz99
	O9RqVrC1m+eA7D2i5hfzl8MQfDapQSlElEBIw6B/0KKGNAsQzWcMjoDgH2AbodBR
	Rh1i4Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jthpud3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:10:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-87d8621e4b5so8181885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759738204; x=1760343004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45B2sK23pf0jnxjuCOALGNeyqT1UiqcLuxhMNfIiCBw=;
        b=dBGyURANSimN7qkzJaYSAM/KFH8Gz4cJSyAFCNcBlPzzVsq+u+d6IbvdK7JsCXn/9r
         59L3T1PArDDRjVuHUr1thhGjYaV3ReZgWjG70tT8u4evGtFW7+crc5WB+Z0fpBUUeOCa
         oVwXYOIaV81lpoveSmSzBWbQ+NGwWmExLxcdjs16bLOI0dm+2KSdpJycKgefIUeZdVDx
         ICiTSmAFk9L+ckmBV3WvrgNuccRLDQbkh2/xfeq8gibyQF1anBQh8M5/upeqxMWSnJMl
         tgowKT4Yor+nUNGs1IQgRgYJHgAkTKKN/dTMjVi/3SxmFlZeNdh0H0dQ4BrvpyRNMQ+F
         b5ow==
X-Forwarded-Encrypted: i=1; AJvYcCV7Rdm+fQPOM8V6XaaJZxxZm7jCPMrw6XDLqiYA33VaJ6l+TNUe79b5kWB11G/uE0yCx+JCoh1nA9i6WP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxds3cCRZ0JkaIvP7+gBZfBQo6qaBADrOP2Lb0wCZIwwEQ+cBkk
	nqhYAUdI4BGUcAZGyMX+X4cmP17pG9ykTwtc+7H6d5TTIf+Ovye1ewVBVHGAEnuk4RXLh+rrQej
	nt6HwZmTXG2NI1HmiupQj/BGHLpqNxxHLfXDj1qMBMXB3M8prwkurtnHQm108TvwImnU=
X-Gm-Gg: ASbGnctC4TjI7ahu57JNmiBACoaXBb/FNSYFRVDVl1HaJMkSUaDjK8j1UI/1vP60pmN
	JpXA9f6h0eB8tJ7pQzbD/XcBgYx+496ZiTWZl8Xa/J63ZVmfUEWR+UeNyaIS6p8Hubeyzs1yc+q
	CHVXCzlCB1xDcAFQvq/DyRR2XwSDkPUJa74QL8awE5W0FOUn3lhkfpAiRN+88TE44RCyi4hOecw
	84T0SblSD9ZYzrLIKiokXsSkvpzpObOCu8XCw/qapbWAtsZhlPzPk15WzHcRd1Jaoa11WslZABm
	BrgPWp+nfLap7RHRUls5UliG3cJ9InRF4Es9zHR/tjqpGbrYHAE2fCXN0gkxTlAYK34dQyIYmw+
	V2UaJ2qtNsQK18ghc7OlSZaqBnds=
X-Received: by 2002:a05:620a:28cd:b0:866:6f75:5928 with SMTP id af79cd13be357-87a396bde94mr937573685a.10.1759738203797;
        Mon, 06 Oct 2025 01:10:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcCPRHpyle444crx8NKZd5cvmWSUSXE2YNbj6mR8rWkfiaXnSKsWJlcawCI5kXeKEqRWLX9g==
X-Received: by 2002:a05:620a:28cd:b0:866:6f75:5928 with SMTP id af79cd13be357-87a396bde94mr937571285a.10.1759738203331;
        Mon, 06 Oct 2025 01:10:03 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4f1d1sm1074256066b.71.2025.10.06.01.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:10:02 -0700 (PDT)
Message-ID: <6807638b-b212-44b9-b7cb-e53e1f11c0d9@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 10:09:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: dt-bindings: arm: qcom: Add Pixel 3
 and 3 XL
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, david@ixit.cz
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
 <20251005-pixel-3-v1-1-ab8b85f6133f@ixit.cz>
 <bq3jeaxksk33ntdk32ojsdyh2d3qkglvgj6segtc3acizlkrhm@fvdsccdbuook>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <bq3jeaxksk33ntdk32ojsdyh2d3qkglvgj6segtc3acizlkrhm@fvdsccdbuook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ca8pvEQ04uyZI7RDc_zdTQx6l4p28pI6
X-Authority-Analysis: v=2.4 cv=N5gk1m9B c=1 sm=1 tr=0 ts=68e3795d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=c5TqcUTYwFkuCHJDiosA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNiBTYWx0ZWRfXwJVHdnrbSxP7
 Vuygc1gpwnib1B9BKw19Lzz9IeFh0YeTTxP8PR0ZJuJu5S9FDb2hSKiGzyWkJz99hQidjzSjkBg
 h3f2y/oSaWEofrEWvT/39sAOM4SyCOBeDbd/ZOaOv2asWk5MOCyC5+jlDAwtjrcD7vD3WrF2f63
 YMMZfcTJAQL52P1ObdqEzLEupUk1drRY7FSNyJtWV0/ESEldgI2Js6L/AArvwB4cU15C/hW8RGX
 ZbWlWcc+j5Qezkbv7lfKBoayZBiX3dQwTDwWqs+DFKTTKLOk+txzxizkPsdRptMF/WwB8n3BJ4r
 PsinjoqSAAiuJfK4Zpp+mHZYQABmnKhVI+xHU3goLrIWhCbBLUXbzEew9SzHpXEQwEGb8jwsTVt
 n8G96XZqcX7zx2DpZK68ZJa3+JnUgw==
X-Proofpoint-ORIG-GUID: ca8pvEQ04uyZI7RDc_zdTQx6l4p28pI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040016

On 10/6/25 12:21 AM, Dmitry Baryshkov wrote:
> On Sun, Oct 05, 2025 at 03:16:28PM +0200, David Heidelberg via B4 Relay wrote:
>> From: David Heidelberg <david@ixit.cz>
>>
>> Document the bindings for the Pixel 3 and 3 XL.
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index ae43b35565808..2190c5b409748 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -976,9 +976,8 @@ properties:
>>  
>>        - items:
>>            - enum:
>> -              - google,cheza
>> -              - google,cheza-rev1
>> -              - google,cheza-rev2
> 
> Why are you removing those?

I removed these a long time ago, the base for this series is 6.17-release
instead of -next :/

Konrad

> 
>> +              - google,blueline
>> +              - google,crosshatch
>>                - lenovo,yoga-c630
>>                - lg,judyln
>>                - lg,judyp
>>
>> -- 
>> 2.51.0
>>
>>
> 

