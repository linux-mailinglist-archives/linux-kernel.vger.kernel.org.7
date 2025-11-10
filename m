Return-Path: <linux-kernel+bounces-892926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8FC4624C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C44A1886942
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE53093C7;
	Mon, 10 Nov 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFdIXr6Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QJrYHMub"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C93081AC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772899; cv=none; b=gSD4RewcXETN/cdY8GXYx78RmZ2r5EgEB5WMre7bD4b4OWrfd3htxd4msJ1b1P+SAOphjJ8B+xUfl7DOeA0ACxdXJ9GIYIhk0eyIltL+RHdkQ04GdM5DNxbgyCI5VX1emdB4mDqFbhjdOBE5BHc+dU9bDWbdgJoCt1AXGkuqbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772899; c=relaxed/simple;
	bh=iG0pOqLXhCj91QIEhbeJ2Y8XYoSQwesjv+51amYq6Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPZFgYefBCRJq14Ll9cwjoG+sxBfQ0e433fjNOsHO2DLWZKZhXShxhbrOn5YiZKESncH7WKsmuuQQ6UiI653R5OBbrVJLyfLypHXhtsepTHSnwXqqESP+9iQTURSUC9WcM56G9f8diH7/5dn7IUDN07jI1zH0jE+dyRU9X72nmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SFdIXr6Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QJrYHMub; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8OMwk1500488
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J/PkyWpMb/cINNObNzm5jGZ1qHngyNuMAQKXyGQ+YzY=; b=SFdIXr6Za9mHghZ5
	Akkm6wVAGhMdrT0NyjuH4FDqj2VWToJTCsXqi71uvSFwPSOfwgg7jN6JQfxQBJWE
	/LpMl9ewRPxmcTqrV4YbWp0+UmuMA8ZLdtwHbCaPzV1ik3wbMNjpuWsGBv/2rnoT
	ZvlQr3CSxCgBhFd1OBTCXpiFq9aO56QVlX9E0Dcyzr0etVYQDpXcpIiUSQ/BF/mX
	W4KJ5rAl15vXBWLnhHShobKp9qEMaQqXzSBK2f9AiEuQbxPk6GY9vFEQfxSAck90
	bLM9nMPFsjRcaNaHxKHocNUM/8usgMACtUfjqi7LaXo6OnX9+nSt8/ApWCXW/AZ2
	zFcKrA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuemf0m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:08:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6317be8cso11362541cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762772896; x=1763377696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/PkyWpMb/cINNObNzm5jGZ1qHngyNuMAQKXyGQ+YzY=;
        b=QJrYHMubwd6dhmHHUVzDfEXm9Lsbpz9ocvCbHBEEXtgD5HpNldV21nY/k0dUzwVCcO
         pnG045z3DSU8mm2I+PDUqgq77niWDCcZJKptuHqldDBl2vZvz9WPe2CeEF7LwcA7ZxRa
         UvLOrNbLLqeaQOLOfAktmNSZ5kD+RVTXgO/qi8kNu5IrL0vsvAwJmhYXJmeXMH26AdKW
         WAx2OrENxPHmkbW22lvtDMMhxIKFaRXhonL/EWsUeNaN3RG4rsbF1UraXBb39+kvtRtC
         C5oBafXJqDqKjujK/+nlM0ymkPQponzwQLvt9U1mFI5tsHdeJXOxCl9RslFuuPTFBZ9W
         oK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772896; x=1763377696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/PkyWpMb/cINNObNzm5jGZ1qHngyNuMAQKXyGQ+YzY=;
        b=WRSjYC2ARbCeAu0Rfr7PgnVr7uhwXBIMLDG7gB+i3TF8dn4WhkSklXeUHWzLayjWaM
         6zg3lv1tStZPaT1IP6HF+zT5qt74Nfwpxe6ph3oG/Kr54/yO8Vu4aLOrX5bvKgb3rCBF
         jQWtaUJkZ7fuXFDEsZHtLYoEiGZ+74rcPsZibP3xa3fp8kFj2TJblNkHEtFQKwL6p/DH
         maHV2srcegsLm1mknAVzqiR1dXiAslLvUgSkH1TyWd+BSxHkDwAzft2lUoqOp8wJ+5Lt
         tR+7hyxE5KcSBYC8mwxEHmhkLEezrHbKvyr3CCKzQmcajB6pGxb1CSd1d6M/Gaho3ZwT
         andw==
X-Forwarded-Encrypted: i=1; AJvYcCXvYm5vAuQR0+UPvIE5+MZjiB/mQRHeKlUgifoeZoI14u+TKP1bTd9q8v21f/UDCz8hEM1Zl1WhwTwvO/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMpSfmoxD4l/vrIOEWuB/HR75ACeTlPYQaQOyU4UIiD7PSRk4
	oCSVTmdbrrOaKFOG7Ef1Mv6iYaSJSZLCf06c73w1djjLxUlsyc3MBOg3TOKSWAUSWuWpnitgfJP
	+QGP8a8v1Co2swAgAY4AlP41uj2TcjmGz83MHGZTlKVOCPvWQdyg0hV94N/p8Xyj6eTs=
X-Gm-Gg: ASbGncsl1EhgQn0Vsl33haNHvbX9WAmMtPlPZVTMH5D1sbq0vK3RpqYmdzLA7ojvJDL
	YD4bw+Yk2cNUIH4Q0UAV6xafV6YAYG7+jv3bc0bHP1/OKPzU0ifu/46gYXYOvQHMYlFq8zZMmxA
	JSB9djsCqVnAW101F2ZryL2fv9hwTVD0cJ3aGbOtwT+V/Aqh1B3X2NOJMd3N8GrBVR4r/FCZiO6
	U4siz3HRRgTioRQc5yW+LL05+JQIH8JPILl7IR3VMz66MmqznhcrFC3iGlLk9ClqiB6KYwO9z5D
	jtof3uNDLxXz7TS2I9BkcGlMjw02JJcSVDcly/1lrU3Uu3HInWbw+f0jEhL9P7B/NWX6nR10PXH
	RfGq7jRkeJGPLGcNIlYsECM1ym4SLO1CqN5rInw6uYrpW0nUbBSnCodFK
X-Received: by 2002:ac8:5dcc:0:b0:4ed:b2b1:18c1 with SMTP id d75a77b69052e-4edb2b13168mr34851901cf.6.1762772895646;
        Mon, 10 Nov 2025 03:08:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGApcQKy/u0KSP6Hvg8vtaRZ6wJn3tOg8UCW9LsuS+tewvaEF/qvX8YyUHnBwzpaULQN4+kIw==
X-Received: by 2002:ac8:5dcc:0:b0:4ed:b2b1:18c1 with SMTP id d75a77b69052e-4edb2b13168mr34851541cf.6.1762772895110;
        Mon, 10 Nov 2025 03:08:15 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d0f3sm1113416166b.48.2025.11.10.03.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:08:14 -0800 (PST)
Message-ID: <77898b11-e039-4c62-b651-219c971a3be0@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 12:08:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
References: <20251110085013.802976-1-sarthak.garg@oss.qualcomm.com>
 <20251110085013.802976-2-sarthak.garg@oss.qualcomm.com>
 <35e8ef89-3fbc-48ac-9b2b-10c2e95ab024@kernel.org>
 <268122d1-d629-4d8c-b88c-2999c77a1a18@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <268122d1-d629-4d8c-b88c-2999c77a1a18@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5NyBTYWx0ZWRfXz1YMNnZENWI7
 YPYbXZxe4Aosvgjn1RWSeFDvjZ23e2mMGS4NELNgnzrM+dEJq0DQZCWKYL6pIqsVJXnTEwOPMX5
 axxc9oigDQ16TFz3JDdCJD4TZ5jA1/sBnIN8ulmiQqH3HjyL+Vg+py2Emp7qt/J4N1s6redR7LB
 upB17eICXeRlBLNzONAbxkTBHAEEk5zGfXVdXMl7uYt4wRMZs0XvVgok/UmZVEuFpL1eb37hy+k
 p4z3aYoC56bPrM0OZ+SZk/ynH1NpW4g8p312HZMdbqtY6T6AfeHvmG1T12noHc3A1MbYx6WqKEQ
 F8KSBO4bIt3u/dsIHk5i3fKs9OoAS2ttoX2X4c4cpwuapsSxKnBebytfleulkbG80br6Bj5AL+2
 TlhkHymPxHuRuAeufAojrDuu2DJGjA==
X-Proofpoint-GUID: MJBaZboQ1b25Ti0XOeqzo8cvNY5Bn1jT
X-Proofpoint-ORIG-GUID: MJBaZboQ1b25Ti0XOeqzo8cvNY5Bn1jT
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=6911c7a0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VJ69uJtSnoo3sbBQX8kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100097

On 11/10/25 10:25 AM, Sarthak Garg wrote:
> 
> On 11/10/2025 2:43 PM, Krzysztof Kozlowski wrote:
>> On 10/11/2025 09:50, Sarthak Garg wrote:
>>> Add SD Card host controller for sm8750 soc.
>>>
>>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8750.dtsi | 54 ++++++++++++++++++++++++++++
>>>   1 file changed, 54 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>>> index a82d9867c7cb..95b210fbfead 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>>> @@ -3482,6 +3482,60 @@ pcie0_phy: phy@1c06000 {
>>>               status = "disabled";
>>>           };
>>>   +        sdhc_2: mmc@8804000 {
>> Nothing improved.
>>
>> Best regards,
>> Krzysztof
> 
> 
> I moved the sdhc_2 node to follow alphanumeric ordering and used hex in reg.
> What extra is needed ?

Nodes with a unit address (numbers after @) are supposed to be sorted
by that register, just like any other register map

Konrad

