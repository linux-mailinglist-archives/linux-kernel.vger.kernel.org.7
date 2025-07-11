Return-Path: <linux-kernel+bounces-727646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E6DB01D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862327681E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C8B2D3725;
	Fri, 11 Jul 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oj/bsEP2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A307298997
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240625; cv=none; b=aVWV3eN8jwKXFXLzZRUdcC+QVNllF8WV8RmBQmQMT9eiJldtxp9labofApF8FI/4fHnppDYFHjRXcugOaL44oi5B2AjXI7GPVmfitPdO3Zn8d5xYSpAccPzJ3g7MD6xMVamgZGe0jtsRj5bqPABL7XMY5Z4qiPwk1N6oSUH7ZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240625; c=relaxed/simple;
	bh=RBviiJM8e7A0n90vapmlXNzmXiF33YX206n+gYRNKHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpJfFzrabVcPdrzFKmtI8R31L71KFLovR5/SCnOwYT1Yne5k8nawqe9Cr1dBibhgH44nxnaZNUslhccs0yFC8wCES6UWM/Sofl46cniBixAsJ6YEb/2pqcW2C243JyJpb0S/YTNntve8jMP+0o1ksKhMqOmHUis4W307v3tuCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oj/bsEP2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BArelJ017350
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ugGPY7HB1MN48isl0Ga4J9P6wFQAlkyxD2Wpj5v5zAo=; b=oj/bsEP2bmM6cLM2
	49Wab/6780Rf9Me254aXp+8YNArnkVf5O4ZBPSjJkrTP3sBEbS3QSdW76PPnF+9y
	nL3/KxFeOe8y9jB3+RI5DIfCUqe9f1W1ZPD7GbMBWHKvAH7cXLGT6j5t+nEa04hm
	e05KjBxQ79waKmTjXzY/hkoRHd+ZX3q9Z0495PuOMNot46Vq19+n3AAKto1zS4Gd
	EXCsFQme2jp2/fEspARG8V16SISI4pSwBrvbAuE2G5CrjSiFZVpEGIl6t+lv/SJ0
	s3VAmU79VwK0IsPoNhXbEpHpmKVub3GmapFNE1lH3fOTtkXPXQ+4aZRJQ5/k7pqZ
	YzJsFg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap8q4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:30:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7cfb7ee97c5so32911185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240622; x=1752845422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugGPY7HB1MN48isl0Ga4J9P6wFQAlkyxD2Wpj5v5zAo=;
        b=bpVWPjz3Rhy53R20WazvH8vO7pmR4u5Adhgtom8xRPIURkhwHqoDB27GzIZDFK6tUb
         SSqwi5UY8EOiAwEcdgD+HLDHYmYrPQj9+Vniaf5v+X1oR8wMT2JncBfm1Ie51h9x1FcL
         7LyfqS30yGrfBSQiQRvSuiEWu6mjNxTdq66PPuxgJsXwm20AQSTSGu1rt7r3XcbxonfY
         YetjujEOSUVI+pdL/4906slu9ISgXdPCHL9UoSmZhi4r825lSRvSmLWLXesd5acYwcSe
         CVQea+jlWdGygkH3pYFj4aBfupn8dmx2XpDE0CQSC7MzMGzFwLP2Xv+LB2S1BrkCKl/x
         opVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj/OWzsbQJfnlmh9o9CZ9MhxTQdXQ12nb+cQzwnXMt2hmXs6JMtJt3OO2jZQjn6dsjvi9pJm3w3DLElP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwgUPpJurHcU+tnS0/IZHo3Vz2yE/9QEa+cOyEpmbLVA6ubpVH
	DLNbcwHWlGrpIbahry1abB14XJBfAA6wOFtRJJUZ58NIyyhODV47XUWCLjB3cYF5u92PCwFsfAt
	ejzUPR4Z1Pqir7Go5d6MgSI4YrfrobCX7sr1zhjnOyrqUyK3/JTtwkbDxjJM8m2q7W3o=
X-Gm-Gg: ASbGncub5dZWUuyjluyd5l6O/ucxFprJd/PS5BgG7Z+JaG/Gawao1Y5EE2oHWkMVdLD
	O71jEVkGkm3UFnjet+rAQcW4DB9q8acPWAJtxQ6stT7MrQaQnfckeDjvn0w2F9HQn1HwtwXgxcK
	maqAfgpyA255mW/6zf9laSL9wR4fGvbgJd1TFaPZvWPYpFP9/CPVWNN7HLsg+0YT3yjfeoQUS/v
	AF5NZiXEmeYsms4gWvsT+ZaL3zOnGWrErfJRDx2+Up7bbw3raiRlOGUE2Ne70B1kvW0a3/3gfpO
	lUfJzRdoWiGpdEHb3gsqtMLQ5KWSjRk1XUyBnx8InWae8cYSJKBULxRgFWHIZ7i8QOx+UDB44ja
	hLDKLQIcyckbQEXSVfmN7
X-Received: by 2002:a05:620a:29c7:b0:7d3:c688:a590 with SMTP id af79cd13be357-7dde9f3ffdbmr163374485a.4.1752240621634;
        Fri, 11 Jul 2025 06:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsp1g8FjvQHBY+1zEIqsJCVWoSQT8u3SuCm/JjGfMzQL7BPTgiKOwfjtpcw4oJxyfJ1QjdOg==
X-Received: by 2002:a05:620a:29c7:b0:7d3:c688:a590 with SMTP id af79cd13be357-7dde9f3ffdbmr163370785a.4.1752240620875;
        Fri, 11 Jul 2025 06:30:20 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8291bbesm292303766b.126.2025.07.11.06.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:30:20 -0700 (PDT)
Message-ID: <493987e4-2b1a-42b1-af5e-85cd9f2a5d7c@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 15:30:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: socinfo: Add support to retrieve APPSBL build
 details
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711-appsbl_crm_version-v1-1-48b49b1dfdcf@oss.qualcomm.com>
 <3cd5864e-e6cf-404f-94b5-b85866086d76@oss.qualcomm.com>
 <e5bb0197-70e4-4b4e-922f-baaaa2e514c7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e5bb0197-70e4-4b4e-922f-baaaa2e514c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=687111ee cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=AoRLLdadn5v-kRkyVHkA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 8sOq_Xbz5eEtssZhkWOgI3--P_hisaA3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5NSBTYWx0ZWRfX1SBZowfawzNX
 Y03NEfhWsPxT9OGc1svGelGuAqIck2x+1S1R4qarq6af0BbMs5vSrtY3PHFRkAslSZprT0j+JcP
 aCDcaFzc4csSRu+utihTAQChoLaCUs4TN9uaBJLplKVKgNf/SX9lhd3ctA2eJijUugFN/uNQOz0
 NlWlGDojpJCWfyg3p7xsUOd7anf/kuquSb+GRtcMkskUghXFNEOPDWqgDU4wQFwyAa/OFpkS/50
 xT4zSXhqkzqpSFF2pkZ68ZnYM7AmnSPDdBXrNYiD5qQEozAOPm6ldB/N0KimC39sfT4iwfaCp6k
 5b/aNpAkqjmlQ1PyQ2wFE1ffDbvtv4p9ws4fZhjKUM8FvSjTQ0oigOwNkQyooSHELQkk2RgCy0N
 +zF4ljwPXZpkJhsuufIt2wy01g6cHGxbwiNBkgABNBDSo3zdWiFt2Xe8C5GRGSCLJS1/xhdn
X-Proofpoint-GUID: 8sOq_Xbz5eEtssZhkWOgI3--P_hisaA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=555 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110095

On 7/11/25 3:24 PM, Kathiravan Thirumoorthy wrote:
> 
> On 7/11/2025 5:41 PM, Konrad Dybcio wrote:
>> On 7/11/25 1:03 PM, Kathiravan Thirumoorthy wrote:
>>> Add support to retrieve APPS (Application Processor Subsystem) Bootloader
>>> image details from SMEM.
>>>
>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>> ---
>> Can we expand the driver with all the known IDs at once instead?
> 
> With respect to the IPQ SoCs only APPSBL image detail is missing, which this change address it

Next week someone else will come around and say the same thing
for e.g. automotive platforms

> 
> I can expand the list, but unfortunately don't have ways to validate them. I can check internally with folks to test it or even send an RTF. Till then, can this patch go independently?

There is nothing to validate here really, the bootloader either
populates the data or not

For now, this one alone is good to go, but please look into the
broader scope

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

