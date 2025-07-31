Return-Path: <linux-kernel+bounces-751912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548BAB16F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6F2581757
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071452BDC0B;
	Thu, 31 Jul 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P5jlmacJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FB19066D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956745; cv=none; b=gxYpS5VTChXElItLdq+9wHXRD2RA4my7nYekptnzcrKLg9Nb0i5TgTW76bCLAPmq+wXxnRAzBAx3GBYYw02qwvMhM5i5ZkSo3qUccYMUL8nWV3hdNajqEhHPiT2gbs1Xej+S9DI7ElwWPUAcqp2/S8sjg3jdNdWOY7cKIw0wufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956745; c=relaxed/simple;
	bh=vmOuvD2gebJGeJp/mgNi1ZkYn6G8Mc/7lUsj5Pe1NWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4iUa0oOV9mvgx+QA+kgcaMIQDGRGsrGjnmXWalfYLgPdq1/gYTQBP/jT92YwoXDipLbfTJvVXm38UT9ScXGN6kk4O5sThIy++FmB8i8agqzXwb7MbJDU7UwhCzg6tuUWuNCnQzDmv0c3L/wQLwJoMMHgwUCtVhpjdNu9IVEUwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P5jlmacJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V9fNam013448
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qvwHQvvH+17Jwk56yeRVBW4CP7kIswZF13PCDIQvzbY=; b=P5jlmacJR6IUgSxj
	2ccwm+uB1BTp26GbYLVchMrb0DiKrgEf3+rF4Yh6ozIKX19DyJ9LvHOkeIWiXGpG
	wXl4wpT/MCZqhFm0LCPUHDZt5JevuH1JPd8wKoL+K3X0Esm8wesgRDHu8DaYgaau
	Uzdcf7koKug1ZHoxsXkjaK19xrUdCM2pn//fG0hVJ66zNBvoiyNa/RILSkaMm7n4
	9xAJOVB0GJhIXUKvt29+m+Ao61ix1QAt7gxpGV1Pygy7adyleZZdMl277c9IhFWb
	1+2jGqlKON7EvEfBWcaxIgvwWjneKpYcPKVQuozGDhbQrdWs+24MwehcYSQZzYpl
	hKNsdQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2q6gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:12:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-707428e0cd2so308706d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753956734; x=1754561534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvwHQvvH+17Jwk56yeRVBW4CP7kIswZF13PCDIQvzbY=;
        b=IzecqPaQsAIC5O3whAzeITQ82GY1nGjpKQsTwpmQ3IcjhWpru29wQ+QXFsjglbqwgg
         77FHbUYUbXGRL1a3ghBRtcqmFG2JZMqp/P+dX/iqlme37tZwMXZlDm3xB5AUH0PZVyUj
         t/KQckJd3bgokHZGADge5wuUy0eUjGv6olepIDg4oyv3AsXxe3XE1XQNBQhyIqetfHs0
         hw2RQwpai8VTLl/gOXF9Z7Y1skNCbOFiug76LqVMG7uE7nwKcvE/dTovWawwx4RPiVHy
         ao5Dva2vZ5Vb9ycjKGoVeYrtctWRIE9iazFC7pbT9c42obIYsI1pEMIS0niZlRnUE7BW
         7FYg==
X-Forwarded-Encrypted: i=1; AJvYcCWYm8btgtscPcaeuR7OoIATuMkLqJJ/nhvcqtmFVHC5mub2c+NtxwBJq36GSEec5Av+fX0m+zeYcS2+JZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEv0ka208k3yybj7OInAMyBV3cUfiG9rNmotK1RgGN6kxm1r4z
	ChuKqOPXx0Xh79Kw6YnXcmDHhyy7uwx0w0cjqxjX5HkI7SxTiIkXyZc3oYhLYXxQq1hY/XdRx8w
	o6z+D8SaWO4bJdUN5F+eJzQmapo+dn7TOlLReJGq/sQUSiEF/p+momHjZqUIhU4kmqvQ=
X-Gm-Gg: ASbGncvQOPRu1N1bfJlokl0g4Zxu/Th8kDUF7u0wMLJJS2X6wwjuzQ/MfAY8B4eQMvd
	z6FIfqJhGFMJdrfaxUTRft0/fn0AOw6VVuysF+zF8YwnTOfB1ANWaC6KkgLyr+JeDtLCT0jIsvo
	+mraFdXtbz38CoqoWDzFLsiAVJjkvZ+Li7WveMEkZf4iUrjiwq5N+9mwMfJXaFP7GYwh36D2i0L
	xTYOo5102/L1c7Tsv0IUMHM+uYlKjmSxq3xXFUkFBBxN1iWLHJ+4guAtRnTSqd5oePq1BgGU5Rt
	i4G98orp1UF+jA2sCVK6FAgVjQnEF9cgCDg/2VXS/GZq+gtSNrgzcTOjhg7BYWa1n5mK9TimJUe
	Dr+BpyFQ1YYpAusS6bw==
X-Received: by 2002:a05:6214:dcc:b0:707:4831:b7ed with SMTP id 6a1803df08f44-707672aff59mr37985336d6.8.1753956733661;
        Thu, 31 Jul 2025 03:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTlbx2VL/KCLHn6A4JzGJRMYtiFUx6VGYkgtJzm4JIQStIWhLL4lP4KD+QcUQWXTwOXn1wkg==
X-Received: by 2002:a05:6214:dcc:b0:707:4831:b7ed with SMTP id 6a1803df08f44-707672aff59mr37985156d6.8.1753956733016;
        Thu, 31 Jul 2025 03:12:13 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911451csm863783a12.60.2025.07.31.03.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 03:12:12 -0700 (PDT)
Message-ID: <0cf62b7f-624c-4751-a126-f0a0b4a6d82d@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 12:12:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Add ACD levels for GPU
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-topic-sm8650-upstream-gpu-acd-level-v1-1-258090038a41@linaro.org>
 <63da4872-2365-40eb-9b2e-d3393ddd9b68@oss.qualcomm.com>
 <a88b22b6-4be5-4176-95b0-0a03530bfd76@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a88b22b6-4be5-4176-95b0-0a03530bfd76@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uD7V5FGjcgELtsm56fU09mLjvPMXRdOy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2OSBTYWx0ZWRfX8+kt79WGU3bB
 ILl+MD/tYGQ9vXestS7yODonTjBR1QFYOzQyoenBDrFhMjS93X8J5UXjYrAM1MuH2qQf79zlnKG
 /ZCp5ce32rShGegHc8WJEo0lLF59SFpMHshfzfkEUfncelRHnoTMmHHRLQ8WRSjNAIuus3Tap5+
 EUMuCoMcyBUiPrvVGtAPTX2CDEdaYFqziYLmhxB878seFiF1AyMlbdrj/TT86j02t73MjPS6lFU
 DH3GTPXa9bVFvrpDXj6O0hP6ClKE6bS+Y4cD12ZfrlsxgNq3+kywkbzuZF1DU7WcXYB6KuQzYV5
 /w20BoCkROKG5MwKTJU0iTE8Si5t6fgw2mArXapPArSKJwyBaIGGLaAaB2u+JDdzkqetbdCAx1B
 QBej3Ip5PwyL9OijhZu0h7n3H7jc8d60MjvdhQsIcHzc6cxfnpD10V7KAQiH9HYIVCGz3TYv
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688b417e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=qC_FGOx9AAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=dJUZX_0qjHRVC8eAntkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=fsdK_YakeE02zTmptMdW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uD7V5FGjcgELtsm56fU09mLjvPMXRdOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310069

On 7/30/25 4:28 PM, Neil Armstrong wrote:
> On 30/07/2025 12:00, Konrad Dybcio wrote:
>> On 7/29/25 4:40 PM, Neil Armstrong wrote:
>>> Update GPU node to include acd level values.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> index 495ea9bfd008500dd2c9f46ceca94cf5f972beca..4cd933219ce008bd1c603c87778e210b6332e29c 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> @@ -4127,72 +4127,84 @@ zap-shader {
>>>                 /* Speedbin needs more work on A740+, keep only lower freqs */
>>>               gpu_opp_table: opp-table {
>>> -                compatible = "operating-points-v2";
>>> +                compatible = "operating-points-v2-adreno",
>>> +                         "operating-points-v2";
>>>                     opp-231000000 {
>>>                       opp-hz = /bits/ 64 <231000000>;
>>>                       opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
>>>                       opp-peak-kBps = <2136718>;
>>> +                    qcom,opp-acd-level = <0xc82f5ffd>;
>>>                   };
>>>                     opp-310000000 {
>>>                       opp-hz = /bits/ 64 <310000000>;
>>>                       opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
>>>                       opp-peak-kBps = <2136718>;
>>> +                    qcom,opp-acd-level = <0xc82c5ffd>;
>>>                   };
>>
>> https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-devicetree/-/blob/gfx-devicetree-oss.lnx.1.0.r1-rel/gpu/pineapple-v2-gpu-pwrlevels.dtsi?ref_type=heads
>>
>> doesn't set ACD for D1/D2
>>
>>>                     opp-366000000 {
>>>                       opp-hz = /bits/ 64 <366000000>;
>>>                       opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
>>>                       opp-peak-kBps = <6074218>;
>>> +                    qcom,opp-acd-level = <0xc02e5ffd>;
>>
>> And other values differ too
>>
>> What release did you grab these from?
> 
> A much more recent non-public release with different gpu-pwrlevels for different SKU codes,
> all sets ACDs for D1/D2, and the ACD values are:
> 
> #define ACD_LEVEL_TURBO_L1    0x882a5ffd
> #define ACD_LEVEL_TURBO       0x882a5ffd
> #define ACD_LEVEL_NOM_L1      0x882a5ffd
> #define ACD_LEVEL_NOM         0x882a5ffd
> #define ACD_LEVEL_SVS_L2      0x882a5ffd
> #define ACD_LEVEL_SVS_L1      0x882a5ffd
> #define ACD_LEVEL_SVS_L0      0x882a5ffd
> #define ACD_LEVEL_SVS         0x882c5ffd
> #define ACD_LEVEL_LOW_SVS_L1  0xc02a5ffd
> #define ACD_LEVEL_LOW_SVS     0xc02d5ffd
> #define ACD_LEVEL_LOW_SVS_D0  0xc02e5ffd
> #define ACD_LEVEL_LOW_SVS_D1  0xc82c5ffd
> #define ACD_LEVEL_LOW_SVS_D2  0xc82f5ffd

I found sources confirming this, thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

