Return-Path: <linux-kernel+bounces-892701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C3DC45A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73683AC43B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53936303A12;
	Mon, 10 Nov 2025 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="De3hlYXT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQ70CQvT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60DF302CCA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766724; cv=none; b=ACp4cEhjYjsh6gDnh2x6JsRJ1yc5GXktnyjv7KnLLGN1zD4aP1INaWqINu4D34DPr1Drbi6NAzaV3d4hU7/R8hkrn+MiCdFd1S+IKuXr1rvHzjU9cZ/YoMqvY+ouHyvrjeTPykLeCwkp3jgeIioFIWnUZdSW0pARCEfdWFNnMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766724; c=relaxed/simple;
	bh=COyf3y4165U0Or1tBHla5IFTQQP+OVd+D2o972FPjOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOx+leSRzupdnd8DbmJIude+0KRJjr+w1a55ES+1Q2+4Pw51Q+DfB8taybEOhzvt+K3kf5PNFGlFHmRGf0TVmJVY+Drn2kv99IcQBfUy1+Lq0PeSrE4bbxzRgFdfOtzMWTFVi0EXwB7/njfi1QMTehflvl0dKRfwmqprNXp9mFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=De3hlYXT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CQ70CQvT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA7har22861774
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U3iwEuhqc+bI7sXi89DxMm3XXxk6P/2ZSBmsCLcSxb0=; b=De3hlYXTJX815q68
	l/+QzQ2fH/XE7rLTP22wGBHzJQJWsGNAYpVtyb/uuLSZfTyd41L2bcEsBwjcWWaV
	Ckba/GKSWEXwXm/hZtXkptD8jsBKxciL6wCWhxblVxeQ3Cceda0hJTutvF6GPnTB
	ZMXGz/sy3dcu3+LUFqrm46I0AJWRZWzTzqLbw2FeG6b/OMhZYkFjC5mXHocgnOXY
	5RAotxELpgokyTiMe9EIUQIvBRGeYbekiWyrtRMZvwKDuiu6EPvLThEPJWnXYk+i
	G55vqwkNQAQfyW8nB+DoO5ZoQNl4IdfvqcMKZO6irYpZ8sZvcRdYL2cTOqhldFnz
	t88cBw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abbwe0d20-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:25:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34376dd8299so682989a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762766721; x=1763371521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3iwEuhqc+bI7sXi89DxMm3XXxk6P/2ZSBmsCLcSxb0=;
        b=CQ70CQvTPgsIa8aevdLGHf8VYX3JjfbHOiPv6Q+Buo232OumQcsmiGDzt96xWzHqFH
         wHELCJglpSWQnAY8ifysov0w+PFMJ+ec/ouUQx3knXyd7TDAvWR/O6hG4DIeN9FE1Sht
         sQhqYSkp5x2GcHAsV3ixTOESnMGHyKhJ1SIgzPLBFLKAStxnwVO3VPslxqPoLYPu4jBv
         mQ9euobhtQ2/6nWKJaURAG/m9neTuoZyZ1GmhPzUTQ8adpr4N4xAlD1mnY+lky+nnT5c
         PPGls1mblJ22VYk5dlRVozkCwVc6KRmuCesYWbh1MXuEmgW2N1LlnOlNR8dgaRAMGr6l
         IpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766721; x=1763371521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3iwEuhqc+bI7sXi89DxMm3XXxk6P/2ZSBmsCLcSxb0=;
        b=Gc0qqANsyIKeoXvBBlkB949m6GBzpCJpkmbNQFVBEWsp/8D4hsC60HSP4+IX+BwIe/
         xW5Ii4zIOjBNMLIH3K8pA+dRfnOeWT0G+XuCqNQnF1UOacUR4HuEh95Cz92oFvoLUxhD
         V7pktAU0lXeD/1AIigRyU3rRjmnJ5nlV72WznYMy4Ao37xqDiJy9Yi3pvGfGiRaft9oe
         M+N264aivfeLCojRZvwpcWCJL2CoZYjrVZdpXH+1PkxqmIdRRjQ3zqsX+j2HA1QnUISb
         diKN7kn+uFajvdFJp158A8+3R9AowUR+dELmqBXZv+sHQ1uXU9UfI54P3OcTqRRYfROo
         LEQA==
X-Forwarded-Encrypted: i=1; AJvYcCWG2t8mfQlHXjgfQ2iN+TwtE0DUGZTImY55hK+5wNCWheQoRNGSY0qxZEkWYl/gjDJhtWBNu1Fbr3rWfas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMbpdgkrStbjhYvh0qFWk22FCdkufqToTOnx3wmFj2xPZefz4
	OUxKPJPLX5zy1wN9CNVkRuuyoaxHYtsp/xWzbZABMkOx8fAHNEu9fJmjWOyy/KdN47+pXZoaDqE
	Pv8B4Wdb/gz3lWG/TrsI/7f8f1Qdf6EKppepuEv7s+BRSu+sgSzVQfHF0NXJ0hk++kA==
X-Gm-Gg: ASbGnctH2x0nqdYchVt+QOHKvHKYcztBRrUlCrE2G9O/esHXzQe9mKr3oiP+UcB4Gof
	KnkG7HdkyPUWBmOoZHh73W4fBoLRyT7DIvk5hi43CAvVEEh/Ame88HmQJ1f2jB1K1etYJIkuZ4o
	zKkpO/s+TLQ49YcvGF8z1jKVPmBTc++mBERx1e2zedYx8M+caZCxkGcKxbpgQc0fRJp2FiyK9Ji
	oCuTVvWFZJgwH3adsW4HcEZVzVaTDMmK+uS+9SCTUmNYkNrZV3VkA9GEnRisVn76A9tmSE/hIc9
	pBtlDoGaH9FpaIb9nLyir5kMXQDkDbmFB/6T+w/YrkQpPunFHMDo2g3bueUs471d+WvXnh9Nq7R
	g6oa241TwISC+7+JfK9VsV/DL7IPR
X-Received: by 2002:a17:90b:380e:b0:340:dd41:df7d with SMTP id 98e67ed59e1d1-3436cbdb388mr5196369a91.3.1762766720769;
        Mon, 10 Nov 2025 01:25:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF6YvjN1MO27w0jr8y5nhHgQEsGq5JKghm93KJ5CAm3xZcf3PDc97izxyvMHS95tr8OFeHOA==
X-Received: by 2002:a17:90b:380e:b0:340:dd41:df7d with SMTP id 98e67ed59e1d1-3436cbdb388mr5196327a91.3.1762766720171;
        Mon, 10 Nov 2025 01:25:20 -0800 (PST)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68aa1edsm17045606a91.1.2025.11.10.01.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:25:19 -0800 (PST)
Message-ID: <268122d1-d629-4d8c-b88c-2999c77a1a18@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 14:55:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <35e8ef89-3fbc-48ac-9b2b-10c2e95ab024@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LNMVuS-54Vi3vLhjCO9Jw0nYdwnbWPfF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA4MiBTYWx0ZWRfX+4bHqldylISn
 YCaVpL7N5c4GGVzvSLsHYWUpYngxls+BttWTovpRwQJdljlkaLUWDsRF2NLboRGwZ/g/feSGgoj
 O2/3i6cb3VWFkATGLwr9EE6NQl8aorhflaJ/Et4HdAnZRp7pxUPmO3ukfv+kJR1vTggyUBD9OYj
 GJAvgtTmHtUwjhF//tlEQSfgUQAXYwE7abxEY2qJUu1CX8YGBq5UeV/xl39yDsAHUbP+uysJt/u
 EISuahpqz+22q+it8PBVQ9Q5+B920ICLXJroHfamONy/VfKSdYmhTwESmgWQthLQIJLBRZGEE/l
 aVHFRnDye33RpoZrGoF5j6s54TATZlds4QrNw26cFi0qGBzsfPVA+vpvU6VfJde8HNut3LHZ6Gd
 IIyiZXXIkVjMOd3D9ywoMElEpAujOw==
X-Authority-Analysis: v=2.4 cv=GbEaXAXL c=1 sm=1 tr=0 ts=6911af81 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-MylOgvtSvH4J1e3t7sA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: LNMVuS-54Vi3vLhjCO9Jw0nYdwnbWPfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100082


On 11/10/2025 2:43 PM, Krzysztof Kozlowski wrote:
> On 10/11/2025 09:50, Sarthak Garg wrote:
>> Add SD Card host controller for sm8750 soc.
>>
>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750.dtsi | 54 ++++++++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> index a82d9867c7cb..95b210fbfead 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> @@ -3482,6 +3482,60 @@ pcie0_phy: phy@1c06000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		sdhc_2: mmc@8804000 {
> Nothing improved.
>
> Best regards,
> Krzysztof


I moved the sdhc_2 node to follow alphanumeric ordering and used hex in reg.
What extra is needed ?


Regards,
Sarthak


