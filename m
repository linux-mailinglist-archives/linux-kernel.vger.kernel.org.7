Return-Path: <linux-kernel+bounces-786299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48227B35802
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2FD7C1F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187252FF175;
	Tue, 26 Aug 2025 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d236II26"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACAC2F83AE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199035; cv=none; b=KCUZSBqBqBg77zVcT5O33ENQg4OVE6icyL3IfSt7t0HEc4WtLhuP9ayvb0bwK/wPWSscpZ7T1N4EyB41XS6IkZTw+7iL77hBYDEIWej6PvlybeTTAPLpwJ+qunVcepD9Qatm6m3vV9N7cfPI4vsbL75aF6Rs25bRknIRXWPLq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199035; c=relaxed/simple;
	bh=S7XfYWroMcqJr4J70jULvhjMOnxLbpFyYuwkU1J6IKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9H/g9Ikh9xZbhVHETrcCEoMVwVsJDANt/iMsLeJwmmc8mfh4JV737ewmh3RByMejTcc0na0a2K98aV1yihdtc+gNFNM95tXtu8Bp6UJRhimug46LXAw3hfcreinp/Fjs90zi6X8C6OmnFQSUWwZ6eIPjVKUuu0UfKKk3xdg/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d236II26; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q5WomB023627
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3kvnIpYaIhAPbwlvi0dXbhefeFgbqaAlt1t2ncj8BLw=; b=d236II26bVcjXaPc
	JiW3QkPR1qy8gmwZssbR4IQsrKGBqufL3K6hWg9ecioUqjvgHLld/0M5Il1i88kJ
	TQ6c1OQa+tXjgt2XNnj/9bD+PnM7p40m6O6xYhiiTyxkEuKDTeq3JrLDyW5iDcvA
	MjfQUVCP3cpJwzy52HAsLeZ3o4gFg5EMrLCzaj4foQu/jO9dmu6AQ/F0l0pDhsIa
	ti3jz5WjrKPXqfI8Lo1RAmwJ5M2IOVu28GtS3bBWsvCQ1EfU7079ksl/2fbPUPzf
	sRyVrEhK0DU+GY3lmWo7JdE8dWHld5OAPPMsKjAUfUPruAw7s/rtqL5zd12bVzY1
	lqcjMg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5um8983-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:03:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-325228e9bedso6985420a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199032; x=1756803832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kvnIpYaIhAPbwlvi0dXbhefeFgbqaAlt1t2ncj8BLw=;
        b=kuyUqTwCys4k8dbi/cBlciIX79tp3RGjkaHVYlBCy1yl1pf3hi+3bgVh6v43Zhrqja
         6dpwDYxMaJrB/3yvVegh05FPqzrQE20uSBaq3UUU2b5vcioUs5fatWDZDPHxHPwTafi3
         u7wpfSvaPoFXZjSr8Ue22gdsOhGbgc4khRm9PMBBrjqdpFQV1K348vOHMQvECI+zZFNb
         3Og7pr32ArdUeBWnMIz+WdfqYsQ57AVBX3sGiUbye4c8d1UGjVlEw2Oukj2iO/bFQAV8
         yf1wMxfmVBOJZ5RrrEpeZ0aPsVkA5VtDrtWYIcQaau8IDwpXkX6be66922SPIo+ON7xt
         DClw==
X-Forwarded-Encrypted: i=1; AJvYcCVSFj5sI8MG5y+RTZI7JbQuOZzW40BGCC1Gi8I5mPCFvjzDQhnekKZXCGsOKeRNaeiJQrQWsigQ+tvTHqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjEgXzBDd7o4gnkvQqSqCUM6FnY+4jVQf9r5J5cYZd4XT/6poj
	GC0j0iqfNPalMF1vIu80AC8UNqZG6qpVELdBPKeuY1uD2C9uyyx6MKm8fWhVOOAw/pRB8Z6IHyf
	17qn6nPLL8aD1bsfBrgrfXlZ2wXOXpgpEXvqC0ZRFDcXsugI6jcRXIzSAhfOAzbUeOVQ=
X-Gm-Gg: ASbGncvo2JqpigddNwYpakuRKzuzgbePIuQy7lYy6TtdHiSLhVf7X3v9pIWQ5h71aO2
	yYMzZF6xOuiYeGrL0d2mXN2hhJicQ/BLUsFyZ7RtnLsIMSySfq4OY5NKGjnZMT785rAYOr6drKH
	F8Y5G9R3/s1r8VPQlDgpGn/lOPHhAgEWjAiWUd/ycbxu07Io2rxKlnrcgchfSOsxf1G/jbXM6eL
	Un5pYfnZlsSKsi2InvUYw6em344rvCOmgtCm9Bjf07566KZTjUbMM5L82nJIkmZIBjv+1S+VxsV
	8ez1K+Hq4+zlS8HoxFWat8vL4aTbyBDtc2DGvsFFuKCg9UPnOj00Y7CBdGKQBUV3WjTheWm2
X-Received: by 2002:a17:90b:37d0:b0:325:6d98:dfc with SMTP id 98e67ed59e1d1-3256d98121dmr11898077a91.14.1756199031254;
        Tue, 26 Aug 2025 02:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa938tockH71GPIpyoO592wnzyXoNF3Ptho2VIjZN7GrxlXvdRpZ4Fvj3uY5yE/wnOsjtSbg==
X-Received: by 2002:a17:90b:37d0:b0:325:6d98:dfc with SMTP id 98e67ed59e1d1-3256d98121dmr11898041a91.14.1756199030665;
        Tue, 26 Aug 2025 02:03:50 -0700 (PDT)
Received: from [10.92.199.10] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f045b687sm2926609b3a.109.2025.08.26.02.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:03:50 -0700 (PDT)
Message-ID: <e2d23d22-de22-47ee-b715-e7b6c36976b1@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 14:33:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: qcom: Restrict port parsing only to pci child
 nodes
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
References: <20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com>
 <20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com>
 <4583bf66-737d-4029-8f14-ce6d6a75def6@kernel.org>
 <0c732ac6-2d1a-4341-94d4-dc6734bfb959@kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <0c732ac6-2d1a-4341-94d4-dc6734bfb959@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68ad7879 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=vYAcZcmFI8d52SuQJuAA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX3HtAbK4Pa61l
 4bhFOTbq4Gt+Y8tvXJtc3g34udAXndbOAXmk9wZ7BHAJmG+/I7kzP1ZdTPksXgycF09hgyUM0nB
 UGPY35bfIYL2hyos6klHom9y5E6oSwS16obetwVTPd1zFLve71PcB9z9P7J2kYPR5CnLj6bgXww
 NQOlisNI7Oj/0IsVSiEGKDuPyQNg0w1kWAkI2MOFG7RZIEcMIj03kGu+SkX3pIk0nGhi2bT8dnX
 LOGdree/hDNlPNTD0k3G0yCgju9Cg2h1sJg0YybkcDcvn5oQrbzgOMphC1hYMKnn7TLiOHIpJaq
 R16qY2GgAYH3hhP1DvLpQS3OLnEObdqgqzZDhW/R218ma8mGIU8UVWAVNx71fTqyyt3jH+hApNq
 wBZvbuuD
X-Proofpoint-GUID: yJrKsQdqG51I3sF7Ubglnu0aRecVggPn
X-Proofpoint-ORIG-GUID: yJrKsQdqG51I3sF7Ubglnu0aRecVggPn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032



On 8/26/2025 2:02 PM, Krzysztof Kozlowski wrote:
> On 26/08/2025 10:27, Krzysztof Kozlowski wrote:
>> On 26/08/2025 07:18, Krishna Chaitanya Chundru wrote:
>>> The qcom_pcie_parse_ports() function currently iterates over all available
>>> child nodes of the PCIe controller's device tree node. This can lead to
>>> attempts to parse unrelated nodes like OPP nodes, resulting in unnecessary
>>> errors or misconfiguration.
>>>
>>> Restrict the parsing logic to only consider child nodes named "pcie" or
>>> "pci", which are the expected node names for PCIe ports.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..5dbdb69fbdd1b9b78a3ebba3cd50d78168f2d595 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -1740,6 +1740,8 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>>>   	int ret = -ENOENT;
>>>   
>>>   	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>>> +		if (!(of_node_name_eq(of_port, "pcie") || of_node_name_eq(of_port, "pci")))
>>
>>
>> Huh? Where is this ABI documented?
> 
> I see it actually might be documented, but you did not mention it at
> all. I doubt you even checked.
> 
> Please reference exactly where is the ABI, so reviewing will be easier.
> 
> I still think though that it is wrong - we don't want device node names
> to be the ABI if we already have compatibles and the children here
> should have them, right?
I intended to check for device_type to be pci, my mistake I went with
the node name, I will update the patch with this logic

if (!of_node_is_type(np, "pci"))
	continue

Thanks for reviewing it.

- Krishna Chaitanya.

> Best regards,
> Krzysztof

