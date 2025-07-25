Return-Path: <linux-kernel+bounces-745509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBE8B11AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8E616ADFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C82D3749;
	Fri, 25 Jul 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgWkHBuN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E541265630
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436206; cv=none; b=im3XNuVJ2GvdWXEBTiODtPkoOTVBjHrHhpNV1TNBjVAXUelP/hGxJBVusTcLfwq2BuwR09WZuZllA/DiAtwB1l0vx0oHliJFMRPyyQRo2MfDPPw22IbNyBBMRrreiSTGtW2P+K40zJdjLrQAz4C+TztM4ioUl0c++OxqGJmRUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436206; c=relaxed/simple;
	bh=khoTYrfoYnB9YM56nKHfbl2OMpC++rooCel5p6UgM4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qz7+A01J66PXA2tVzaPx/zHo2x8eFVCnKDsHZaHwI1W1VgHSaDTw9MH1q6OOMCiuP7xvDFTjmDUruQ6eYEau5afzhlH2qognuR+9zCAsgtj/LqSOAiVuBXVrmNSSH9tl8cMntrFCqi1TTWw0fhDMg2hirCyMSoWY1M87AyicTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fgWkHBuN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P2vRac020076
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8fGqVCbKdUD5IhTQGdpZfzscjaHJZUBYNn64bhKqYT4=; b=fgWkHBuNJDbkhIhw
	AxC2uJTLEXRNI8Ix3WR2RQZmmj5gMWrJoBAEo6B0XdtZVZXXR93wW50fjRUiNS0t
	bGPoXKI3lEby69VBbAungCRQP3dLfzKbC2iTCBtAjCXn1Bflb/wcgHghS34xzChW
	PGh9XzboVYVRcLUtADuwPCt5WiCBOcN717oLozASa6xdq0R3rB9t783wu3SIOd/J
	AEat6Alg2isnhwI6/vp/1WKG1TkgmCh+CsG73cSdLeJy+vPo1i2jeJIHnI5NFAVj
	hrgsxRG16BKyZZDuUdUVWswCfxqThM85gRuBJTiAHhHg8WKHo+pILan2+NiXnlwu
	Qyrq+g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2xhhkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:36:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so2205935a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753436203; x=1754041003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fGqVCbKdUD5IhTQGdpZfzscjaHJZUBYNn64bhKqYT4=;
        b=Pnp5cOvFv8nlKSNHhw6hSmfD33T4IYtYxn5Q2Lc0mASTxGQQxwfuzKzuQg3kh2xHD5
         TJbRkWPMHxMYPC55dQYEnF70AD29GWVsdf7CkcN+1xpHl8U8hWcFcC9vPedFpssE677p
         ADCdZf7SIfKHx8UZlrd6v2SNo1S6BlUWwpIqNM4srYeFgiObUA4adJmPCv1iqoTjQe6R
         +jfrYC5ru8zdFgxPmnQoGPFbm3QyDDPWUal5HBX69JdnRvq56Q4d9cGEjFNj1YGn8aTU
         UEUVfPC9hZWaNj/v7VhZivWhxAafkyWilOrfojUKlIe0AWx8j3MYdkPMov41LCDLnUc/
         m+Og==
X-Forwarded-Encrypted: i=1; AJvYcCVEQcHf8WvV6y1cdXc20b3w8SK4L6nuqqqPY5Hqq1A/IWd69B/PdLDcxqez+ABspx36aB6Yi0FqpjnqHmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfhGG4QsCE/43dXSJ1jvl2bOdQ1YWE5oqJKoksP/cKGRExeVb
	f1nnlicNQHc/szzL/vn3nBeLKgjFzxdWzXmLM0q+8y9Yaq13ukahX4y4NO/DEW1RV7Zd2os3qio
	Gp3hmOwGS3E8eENdr3ZjiVDn0OTETnWZt66hzfEEbFlzlH5xL0Y8DnHbGZpyRN4PsOlA=
X-Gm-Gg: ASbGnct9tjYpYMzveQqXww5mfnmnoLd9n040jxadc+c87fvO4VI6RynKWOKXCQqSSFR
	dpR6EDEBDHcLPowvuDrYmtJmypY3878zTDa02Fr57meAa4nKafZ0tFZa/8+DYvvNLYl1I3DecVe
	YQipRMINy0gRfL+RCKEP8JlFCTsRuajQ2588yrxRuHFjMvfHeftOCsGgW1vN03dYHUn/PTiAB9+
	2TlvyOIIAyLoVxuRY+vdWWdNZe9aED5i1f0COkp+DNA2Ft1XvC1DLvVvHXLdAA6dDn0mtWw8x1+
	iP5hA9iwDd22plZ6Vr+KI5XddvG53mFYhzLS08l79F2xlDV4ID9qgWgNU67TWdNVgyzdMMF66v9
	rB5jw6m3/k5N4ptoi/X1k2vwQVTo=
X-Received: by 2002:a17:90b:2d8b:b0:311:e8cc:424c with SMTP id 98e67ed59e1d1-31e779fce5amr1572774a91.25.1753436202675;
        Fri, 25 Jul 2025 02:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6VQ+hjM+9VTW1JluX17yS5gKOukl9PngNrV2/3XdW+Tv7bW62cUA8gef6d9gMhfXtDXlJ2Q==
X-Received: by 2002:a17:90b:2d8b:b0:311:e8cc:424c with SMTP id 98e67ed59e1d1-31e779fce5amr1572748a91.25.1753436202270;
        Fri, 25 Jul 2025 02:36:42 -0700 (PDT)
Received: from [10.133.33.89] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6628b1fbsm3127948a91.12.2025.07.25.02.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:36:41 -0700 (PDT)
Message-ID: <20829683-b2ce-4aaa-beb4-4ca5774350a2@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 17:36:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <3f03b1c0-94a2-4081-adb0-aac4f42ee430@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hrYn5BB6gghDLSUsvGXzH6PncnXFeFLd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4MSBTYWx0ZWRfX9UrLtbYTg/8+
 GzRtn8vEw58L1/jqRhaWRZ4RJNThRjzo5eCHXZj/p39/MlgCAjr8+Nb0oORmqogf4juHKQ7SraP
 dDoa/pKz/2GexslbkDLSjgSPTuOcNulZstMc8MknDTmRZ/5zRnAqciQwK/7gC1u3nWVrt5ZL6Bf
 rJg1TkWde9kxAd1IetWJoMMnV6ChqIJxG17leey2ri4VOk6bXa5uC+2uPs8Wftj+rUQ1Go0lCa+
 DH5SvW0hRdDNBTwXA2gGDB8C2Xmfi8ajb8jT4g0PTEMmdwzLig5LWW34gHS3pENqXv+MCMupQI5
 WQbqOb/04iKvhLJ03Xb0FoxwHoqfmjcJsC+VEtxBILQ4Lr1ZM39mYpbvrtE1tWohMaVA0wvTNrr
 3Y0loNquJCjMIMVBItc+0ARJv6XkPCakJc2J/oJJSpyfDCsAsJa/pWiRqdfAox6ETK3lMoqk
X-Proofpoint-GUID: hrYn5BB6gghDLSUsvGXzH6PncnXFeFLd
X-Authority-Analysis: v=2.4 cv=S8bZwJsP c=1 sm=1 tr=0 ts=6883502c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=kD3CWL0wyOYqigJ9jOwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250081



On 2025-07-25 17:18, Krzysztof Kozlowski wrote:
> On 25/07/2025 11:01, Yijie Yang wrote:
>>
>> wcn7850_pmu: wcn7850-pmu@xxxx {
>>       compatible = "qcom,wcn7850-pmu";
>>       reg = <0x...>;
>>       vdd-supply = <&dummy_reg>;
>>       vddaon-supply = <&dummy_reg>;
>>       vdddig-supply = <&dummy_reg>;
>>       vddrfa1p2-supply = <&dummy_reg>;
>>       vddrfa1p8-supply = <&dummy_reg>;
>> };
>> This approach ensures the DTB passes schema checks while keeping the
>> implementation clean and consistent with the actual platform setup. Do
>> you think this is appropriate?
> 
> No. There is no dummy regulator in the hardware, so you cannot add it to
> the DTS.

What should I do in this case? Is it acceptable to deviate from the 
dt-binding rules due to differences in firmware behavior? Otherwise, 
I’ll need to revert to the first version, leave a TODO in the DTS, and 
wait for someone to properly model the M.2 card.

> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


