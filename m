Return-Path: <linux-kernel+bounces-892820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C2C45E56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF583A6C24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B630103A;
	Mon, 10 Nov 2025 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ekezcl0q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NPHspo++"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8F82F7AAC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770125; cv=none; b=N9h9AOmukYzuw+19nvF16G5neq44Pb0c0QaPHrv17YPFxv17FQIzSBQsLCxP9rv1dJC0uM49yRQnaV4UkswU7PkzLGJfvyBguGPxy7zx4LjkF3VT3jLfxOR3MCRM7bkS2UBdAm5E6v2jn3PIz6SyRcqo94noLCKli4dzpNNPrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770125; c=relaxed/simple;
	bh=BYFGMXA/UXxp1mCIzOizUs/qzKuKUPoAJ3Q6wLSw51I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lK+6Ir9WiU2BkMm5vuFLHU3cXAotoDjqy+y05ZDfcO0cAabexxtc4RuDScfr9sPATGPoGeOJ7ymQeOAoxL2D5VATMoT3tmzJ1cnmpP8plMgTSh3OyzSbZZ+BeaDKaf/h/eJB04ShxcF6GRnxKTjZGsVCll8dAkGcCatVoljS+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ekezcl0q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NPHspo++; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA6Srew2408556
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4vgVa6+vfpuHHyT/6RavB+XSFElugjvayi2iI6sahjk=; b=Ekezcl0q9Lbj91vq
	kjEzJYMIIXuYpcKx88PQMDaK/dx5fmdm5SictKhofLHzdU33P3G/HB7E9hrn+wR3
	c5OcZXvuMG7C1U7gWs5fSMSfQfs02OqVoWaJZ4HJAz+nazUoCODEI2coYTaF5rvH
	EQXfS89a+4MoNpaVDTrWs79/0BCxbvdK8uX4prncAES82CayO+sjNIuJm4tm8jJw
	FQmhr/CTykqh2JdY0ubyaSI8oKov8DiPyPLpVoJodBQE+iW1vud9f76Ojbu5z9PJ
	lAOOEFiqlUCO9HNn6lKmo3rmPb8P6cM8d6qx82i5AoCAcn6az8sHBR69TRJaPqzE
	m0M46g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd8ra4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:22:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6317be8cso11259451cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762770121; x=1763374921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4vgVa6+vfpuHHyT/6RavB+XSFElugjvayi2iI6sahjk=;
        b=NPHspo++FFQX9XYCPVjZCGTMDBKQh+JbLr4dy1LpGqaPY05zB6/on/lCnj4LudMGS7
         y2JbP+pKX0vl1mS0H983c6XbVPBCod1XUuAaIeYLACCEAVbvnhET1wKz4TIwDQo27FqE
         Cet4k56+Y+ibO68njmemV7bro04wYJyY7fnNVOBuLHrzcDvVZFGPPcXbQO1iIsUcX9Xc
         AlRZRhO5fbD3jmVOhoJyMxtdvKpNnMtZEs4EQ3fzqLv5cxf1rIpKfkxQjr7Bb3kAlABB
         2Mr80OcPsSeh1sArhjsJMHRHQ5O9lOht/OAnUsEBCzxRYVMl7Z54DBV6SVa4dMp9Y5Q4
         NkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770121; x=1763374921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vgVa6+vfpuHHyT/6RavB+XSFElugjvayi2iI6sahjk=;
        b=I1oyJDmrCLABSZsWEmVKUnvi2X9xcW/XxjXY8KEpBUcOyOk4ukRmkqsjVuhabygCPp
         8AfwRm3KdaBbGTZKUWAY5O5+lmg6pJ4IaG2jNgeKErTwSM/s2buH9JuFgDZGVNAVy/35
         AHWIaWiKLinfDdBeH719fFoX/tuHm7aSEE1KzIT+6/CigrehF06Wdkxcg4f1w4z+8pcj
         VagWLUY/FWrirjSklZ3R48+DZS1qhiu7T6RgaOYfHpcpUEw+Et/SXJ8eA4Ok0IudgLqs
         bk+EBAwOABdZ+al/J+dZw3FHDTGiqtlMpRbwjh4h3J9bc88SZK3ioiKS92VgiMVMvN9D
         RHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0NVlaq3FQUvIGUm7SA7ywtqNpYaQq2EosIOZ6xdU+SE36YZYIQv0uGU3oNuT9Wbpt1FroqPWh6CFpSbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+bj2//1t324DreO2tsAVMyR0B9VF9pBCre0BpDkTB2K1Fk0d8
	8L36r7CNrmxzn92GCimNM49CR29sMVvz1f2TzeXR7nImxVzhtmOhlCyIfrbJECkBBRwUZdTzfOK
	50WlaMMB1dkG3VcMu0TskayPFy6AAlSPqDpW+asccu5W1dvz5r219xWraIGJzZTJEk1o=
X-Gm-Gg: ASbGnctHqQ93a56WdY+3HA0w/8rqaP4SQx0HkcaRgQ0lEsISsc3Y+S//gFxzgC2cGlH
	3RCNX1kAyO/lO0BGCDpKzatE88AaRV/+M5B8eSQfyj+eZuZvyzJMEU2CKzCB6RuLobSl3m7CNOl
	1eViBs090t886QgvyY5pBCWqT/TrWV4ukd4OcxTn/ST2BYpUvWrl9EKtb6Umjo9Rcao80ha4y6j
	Ra+j/SsN8s+B7rww+qE2I7WrrGbzDQlK6f/iRCTy8mFP3eoC9K7lnVX3eOBZYXZN8v1k1oPPVS5
	2WiZle0m0h072mHu/UGL8r9qKPLx3HO9zUnAbFUEi1MQhWN25YAVBMkfRv0foeK8c76A4e+emdf
	xhgtaV/e/vewodcKufIVbJzJjhclGUms0iFepWldwjJZuG89224wzhm7G
X-Received: by 2002:a05:622a:24a:b0:4ed:7f85:225c with SMTP id d75a77b69052e-4eda4f9ab05mr68489121cf.10.1762770121014;
        Mon, 10 Nov 2025 02:22:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMZeSyWG1kpIQ0TUH1bX2pG4Eapv1I51CVFEMZ6ksXeC/t9idk6nZNtkUGmJLq10rhDDTVBA==
X-Received: by 2002:a05:622a:24a:b0:4ed:7f85:225c with SMTP id d75a77b69052e-4eda4f9ab05mr68489031cf.10.1762770120650;
        Mon, 10 Nov 2025 02:22:00 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d461sm1104993766b.47.2025.11.10.02.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 02:22:00 -0800 (PST)
Message-ID: <55870352-eb6d-4cc2-840f-9de1a59ead93@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 11:21:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm6350: Add clocks for aggre1 &
 aggre2 NoC
To: Luca Weiss <luca.weiss@fairphone.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
 <20251107-sm6350-icc-qos-v1-5-8275e5fc3f61@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251107-sm6350-icc-qos-v1-5-8275e5fc3f61@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wn9R5tCUmi6KFcHLT5z1VJHvbU461C9i
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911bcca cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=WWQFUNGd85j635JlVwcA:9 a=QEXdDO2ut3YA:10 a=AYr37p2UDEkA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: wn9R5tCUmi6KFcHLT5z1VJHvbU461C9i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MCBTYWx0ZWRfX06lQZ9khyhtL
 t6NmdWVwqVpXojKL+lYTK9cayaJbBnOy2a2uUdCtorirKzNzuINtOZg5//yLMZNhcgnZPRGMI/5
 t93gCelXWHcgcMEf/pHYel+jDSKKE+KsNR3Kw+4GwUUbMAwX5KDXvP3JWKEaf3JhrmLrshv5pMX
 Zpctct8zB72PrUW29c0hZYPTe+NmfovtmZHv7yobaydTt5okHv+FkojJzndw5ATWYbiNxHQl8PL
 doejOtqV1QoqRBLUFuhG7sBLqcivNTIlYALAt5CUbn/7kLf30GhK6jQsHZU5MgqGuU69dfyPI5P
 eMDebrAAWNOrPaNTurSEzK07icjG5n0b5qLEWLmK7qYzEmxadN3+jNRAhsZGnKPnVnm4ryIMP8j
 MNhGcOs/fuwRBbS1LpOC4qHW3hrJFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100090

On 11/7/25 5:08 PM, Luca Weiss wrote:
> As per updated bindings, add the clocks for those two interconnects,
> which are required to set up QoS correctly.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

