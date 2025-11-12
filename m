Return-Path: <linux-kernel+bounces-897320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C288C52941
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9D71883E67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23BB22A4FC;
	Wed, 12 Nov 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSWdgjYk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kIWfDQrI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78A1EB9E3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955572; cv=none; b=RweyQlSmFbQzVUnbPeJRfcqgg8dUZvlUafPBv6IOxugfdGdnqBkhTYlV1g2XUIs13p/lZn8Aq8A5M6WS2r82/UQf/IOg+IGRuR+/zxGkhzHT/llAUtiLhDJrJmLDR7QpKwkakIU2TROwUAMId9FYknSuFvSbbf8MIZspAfLqrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955572; c=relaxed/simple;
	bh=OAryLYQkLLUmB/WMe+NZx5UWRsH3+TBfVnEaugxiuw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZr8QcruW5ZM4n70Hw1f9/4qtVnD8GK1ifuLEQ1LF9sQiAZOcjjE6rV8tNdZVE1RCR97p+oikrBzrr33QFR+IBi2/JCD26LP2vKgZelFYjFuf5mpePRjvJXASgNm53OE/cpawAFSJv04tz/EvWOQJrh/SKNS9ysqUa4wN1GKYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cSWdgjYk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kIWfDQrI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9hVFf907726
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RTdtyUKWWBMzxYsC5nXPivGVgsscMtomVbfKa/HEHHo=; b=cSWdgjYkemJrNc1g
	pFfqjO1NFr+lWhKcYSBN7fNg0B9phMoU5W7dun4wLxb4ZFE12v6b/qKyaFp1z+dh
	pI3/hIHiz4SZqa7t7qWngw21byrArSI5wl3ivV1IRxI4VuIwTyj+HxHHT6182eNZ
	BiYCPXszvnAGl7xVByzRqLw9c4AntRPbjLeb8F3P8hVYotjfjT61CEKh6mVFSz4A
	wg1jy04dv8QNy1J7vR6T4BMUZoiVJ5dOqJeI4m68iIzg33F1GsFOhe5Vb7qe43/g
	PDlJm8t4vw4a51B4h4ZbmL3tqMfjC4a6EoP6PPyR7o+l9nwCWno+z9i6gDKe3TAP
	FG8EXg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqur8nwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:52:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-882414eeb90so2567116d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762955569; x=1763560369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTdtyUKWWBMzxYsC5nXPivGVgsscMtomVbfKa/HEHHo=;
        b=kIWfDQrIJBtStUVPG5OOQ0u9wapUKkqhPb64DyeYh5cxCF5YAUiJqzRZ3WlBgOtkP7
         CvZzfAbuH2/f/ONxpRxVdmSdgzy/fH65JXT3mUQgRMgodyIUKAjGV8ZP9PegW23r2SsX
         HWNclf2A0BTCDHmInTUgEfXH0xz6fI1Vvvp2Z/90mHRT/Ks5VGcBTcgfgBLzkvnhtaVC
         tHqsYNXSoAta2qAaOof9tvTZU1YecU4+Ku4b0QiEE8mvrtiF0MI2ur2cENZJCI0ZlNJ9
         maOWiAcMAI7UZznHPvqZeoLLvMYBqG87J9F3f6LlRvwq6NvtPLKK1WTw/xG4fBhzu21I
         m20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955569; x=1763560369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTdtyUKWWBMzxYsC5nXPivGVgsscMtomVbfKa/HEHHo=;
        b=iKdB3ai8d+7aOGtHDpY3vRi+x0HHpMQlds/fFqF6mammqVUfqjVpoSgF11tM1QWj23
         YwtFMjO5YqT/EgRSuVhcEAL56OLC6R3DNGld9m9RjWfSBz871dmGz6Xr5VIeSCmB/1CC
         LduRtMe8oUko3rwZ8/hrXWFMv8KWeiiW+332MIAfV+LjojqhN7UjLCexGbzYd+HDSuvH
         JPK1mieZsXbK7ETcJrtBJkRP3nLIdHlyyhBqFZAtiUDl34hmCnS9RxFIuBfK1Z/dKD05
         v0LSXsq7Gw+4ZhGTSm2TulvvH/fVoz+Z5RkCUBBO5uC+Zf30qRSkqEDrK1U6vAGQc/QB
         gxvw==
X-Forwarded-Encrypted: i=1; AJvYcCW6/02WEBNn0wmy6jKtRD4H4yyYJP3W6nVamYQIgzGviI9vz2+yZ9Rh5dhuttZf0MQS9cZ/MRzaUSHAOmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzVC/V+RST4f4OBAjhqEPsPh20g26n/1W960KMSYegCG1lE4G
	Z/yQcz+iGOS/lka+cZYULXIJmnRgzlGIrMi8Zof528HnorwIDV+lsKKv1o8sXJ/M1ayvK0UkoJd
	Cymov4OWfDfFDKvc5sWJiZt67Sv3kx0nhIV0oC5OChi1l7kZmc5oPrMT4bVJkvUVwmf2DiZEMwq
	g=
X-Gm-Gg: ASbGncus5FKWTvaHA3FpfJwSNgKyvbcK0MbBEmFqeZUMbBz8T24EV15SUVUQJYY3HYi
	1Zt/mzGYWEXzk8kYY+YBBbCu+6XLuMvV55b1v0u8AXvon2QW47lOjBE067aV/xCfLYinYxQowc6
	GgE7/u3zEV2wq5ttnBkk1awM32vYgBQkYwhz5gLBMSehI8nyQMwcWiZ+RdfPCUKoJHxT8F1JjUf
	5JK7pG4aspUiNJ+rbh+UldglhsxQ1D4xJO3zYkzdSExh+813ZMF6Xq/eSN6kx/tQYrQW74sE6y5
	IyTmM8QR92VCtQYT0TyPJcqRoOTlHpQ8r3VR6l21oa1+fP5uQCDqLY40h6Eg9/zIgc2G4CUUfgl
	itswKtzcSfrY4aftoavnssFXf8+EVFO3IAhMvTYvEZ2odiFRQKXbHt+C2
X-Received: by 2002:a05:622a:1209:b0:4ec:ed46:ab6d with SMTP id d75a77b69052e-4eddbdad3damr29223811cf.9.1762955569048;
        Wed, 12 Nov 2025 05:52:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcy1zE3l/tMASsQZC9DN852+GpFxCEn0w3eDqVGBouDX1a9/hlv2AeSAGGjvnQlClfa38f9w==
X-Received: by 2002:a05:622a:1209:b0:4ec:ed46:ab6d with SMTP id d75a77b69052e-4eddbdad3damr29223501cf.9.1762955568364;
        Wed, 12 Nov 2025 05:52:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf723172sm1585335666b.32.2025.11.12.05.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 05:52:47 -0800 (PST)
Message-ID: <f5c7eb1c-28b1-4cf1-afb0-b993384b7712@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 14:52:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sdm630/660: Add CDSP-related
 nodes
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20251023-qcom-sdm660-cdsp-adsp-dts-v2-0-895ffe50ab5f@mainlining.org>
 <20251023-qcom-sdm660-cdsp-adsp-dts-v2-1-895ffe50ab5f@mainlining.org>
 <07066c46-4121-48da-846a-3a180d245589@oss.qualcomm.com>
 <47b40a91-8365-4431-9fd9-1e48fad2a4e1@mainlining.org>
 <a3cb6633-1595-41e7-8e87-ca48a98f822c@mainlining.org>
 <83c3aea5-764e-4e60-8b16-67b474f19357@oss.qualcomm.com>
 <d17548bb-ddce-4d60-8dc4-2c0633989299@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d17548bb-ddce-4d60-8dc4-2c0633989299@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExMiBTYWx0ZWRfX3oR8hxMiJxKq
 +KrvIJPriEVk4xcJolMh5uU414iir/USM7TDQ9aGG6GXkFxlIFP8lyVPylgD2B4otfA2PrvQDEq
 6hm7srod32MWrapfbSwiVpWedWEQjOtgjl+h53+Z+o/XeuICt/gO5tLOVljISoPm2GhVm6K1Q11
 bFkVIQ3Z4F7PP8WfwV7B5LUNb6QlbU5t1PdKnDagQq8D7M6BgyIdH/TLvPSgK/TjJQQTELvam+W
 XESQy3dX1dQQafXWLDoBg/6r4BYWDNl13QxAvTVpHpaf+MuGEu5vDfj2z6XnLjvU1I3gIJ8EVtF
 s1kS+PXkatfkTjVDM/f70T8N2pnRu7UuvARHqVAO2WdxtwJi5sh2l20UZJ8f8wVNmsTt5KCWubc
 wBTZc94/4AgfaRO90v9uwbzoglfcaw==
X-Proofpoint-GUID: j40z3dvjvW8-YiML1LTZn7qSUGNb5B-T
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69149132 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=eRqVM4IRrQ2YyvCDTyEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: j40z3dvjvW8-YiML1LTZn7qSUGNb5B-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120112

On 11/10/25 6:41 PM, Srinivas Kandagatla wrote:
> On 11/3/25 12:52 PM, Konrad Dybcio wrote:
>> On 10/31/25 12:30 PM, Nickolay Goppen wrote:
>>>
>>> 24.10.2025 16:58, Nickolay Goppen пишет:
>>>>
>>>> 24.10.2025 11:28, Konrad Dybcio пишет:
>>>>> On 10/23/25 9:51 PM, Nickolay Goppen wrote:
>>>>>> In order to enable CDSP support for SDM660 SoC:
>>>>>>   * add shared memory p2p nodes for CDSP
>>>>>>   * add CDSP-specific smmu node
>>>>>>   * add CDSP peripheral image loader node
>>>>>>
>>>>>> Memory region for CDSP in SDM660 occupies the same spot as
>>>>>> TZ buffer mem defined in sdm630.dtsi (which does not have CDSP).
>>>>>> In sdm660.dtsi replace buffer_mem inherited from SDM630 with
>>>>>> cdsp_region, which is also larger in size.
>>>>>>
>>>>>> SDM636 also doesn't have CDSP, so remove inherited from sdm660.dtsi
>>>>>> related nodes and add buffer_mem back.
>>>>>>
>>>>>> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
>>>>>> ---
>>>>> [...]
>>>>>
>>>>>> +            label = "turing";
>>>>> "cdsp"
>>>> Ok, I'll change this in the next revision.
>>>>>> +            mboxes = <&apcs_glb 29>;
>>>>>> +            qcom,remote-pid = <5>;
>>>>>> +
>>>>>> +            fastrpc {
>>>>>> +                compatible = "qcom,fastrpc";
>>>>>> +                qcom,glink-channels = "fastrpcglink-apps-dsp";
>>>>>> +                label = "cdsp";
>>>>>> +                qcom,non-secure-domain;
>>>>> This shouldn't matter, both a secure and a non-secure device is
>>>>> created for CDSP
>>>> I've added this property, because it is used in other SoC's, such as SDM845 and SM6115 for both ADSP and CDSP
>>> Is this property not neccessary anymore?
>>
>> +Srini?
> 
> That is true, we do not require this for CDSP, as CDSP allows both
> unsigned and signed loading, we create both secured and non-secure node
> by default. May be we can provide that clarity in yaml bindings so that
> it gets caught during dtb checks.
> 
> 
> However in ADSP case, we only support singed modules, due to historical
> reasons how this driver evolved over years, we have this flag to allow
> compatiblity for such users.

Does that mean that we can only load signed modules on the ADSP, but
the driver behavior was previously such that unsigned modules were
allowed (which was presumably fine on devboards, but not on fused
devices)?

Konrad

