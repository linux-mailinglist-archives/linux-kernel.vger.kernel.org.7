Return-Path: <linux-kernel+bounces-786060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADEFB35483
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD1468795B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4832EF64A;
	Tue, 26 Aug 2025 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FufYbW21"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE2E2F4A11
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189453; cv=none; b=Br4D2mQhLa6lPJ4cN56LhlmPUQWS5gzoFkMBYG9k1U4/nVyyGrvhYisp4fAmuRN2gGx4CPb4B4fI5czs1/LVBSwRDAKLbyqqzacCyTgNrjQENZlmdqoL798wmUUXFB1KW5aeRLrA9qoB072IfJNgq5HMbGasKPkNeNvhDwSJicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189453; c=relaxed/simple;
	bh=ul90Ca6MD3k2RmH1jBXkn9THRXThzKvep5Dh7WNSVXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiO2jdjMNClmv9uqNk0CXIYKxU3rcZbNRh6J6LaxDhL+c0yzLjnNN4orTh21T83iIRcGhF0sRSTERV+dLd9L15pUklZKivPhHcgN8mgS8K9LpNbNEY9OkgaGbiwwI1mLj4S3lfoYAM8QJ7lG3U4zL+utacSiRzViqFd82am7ITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FufYbW21; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q44Ier010931
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aP57du5hI5dY/ksSUGXf2FChqaV+/pIdZ8ikNR5OOB4=; b=FufYbW21/Z4Nxji7
	s7cmCrjLiJ3DMReKZ9VFLLWTkvEcUuPPAFCj/JNLILg70oAgWKnwrsEqQzPgPAsb
	X5tmvr/D39rsUP3kJjnybP+xIzalZKyxxsOrolzwVA8gfiKKpH6JayWVPtzcNqbh
	u52IKh3dbNTe9Ub/MgLF4OKbIYEUNy/14xlerCZLvZbvngMAYw+foYTbbExKJQvi
	qv0Jx1rD4QhdhqQTDowmPLuKKO4OaDWytjcD6nUKVpE/W/ope0TyZajXyds/hSk5
	3fEHkJXj5ee7PhqANeqsqyuWG7QmNvXiuKrpWbUCFGqDD6BQ9N6HVVlCR/Ru5Wl3
	rAxkig==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unqjt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:24:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-325228e9bedso6794687a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189449; x=1756794249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aP57du5hI5dY/ksSUGXf2FChqaV+/pIdZ8ikNR5OOB4=;
        b=KHILkk92EE3GZD9rd/aujBy+UTxAXHwNLNmAcwNNw5FSLdaAQPb/V96Kjtt9W12dmQ
         oUhG91CL8h266eIRaOqWEpLuqFw92Wv2DJyJxHjUeRCoLdvIJJGhZ7BIic37z1BIahWL
         ul9uBb2iOxQpYvIHx93BUVrAPw8mXzpwQqWVeZT4nJgF84v8YJl1hUcI4QYx7K9xG0Go
         GojebJ9pLhuvVjDGwSr82oK/J/tkgoizgSbFOvO8ulSRQKnoBg/Jsx5CTNdHMv9x0lOP
         nUZ66fcBdcpCXVfAdexR2LQTMWx3nNftypVc4PWykYN++eriRNt4h4GiwjbrKECiec5K
         iTmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjjaOnr9CfQrIydS2iQTXq37JY9LXqBgWEO6kuon1VJWdbG/biVJs/v0Z6Qfzn+t4IZqFYvfGw9UuI53A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEX9XtWKfZBLpwy1HkryRlxt7xJ/zXIaY3G7HUwkerGg91HQ4q
	VnG1QQUYFxvF/vp9t+nlq33wuLKO+x8L2jgcfWtCHOVEsI47h68MaFCs1ogYn+pDCfCzDRoe21p
	LY6W4QMgQzQISElz0x5FWpJKJ0J0aypaL1ld8myJvxOZC0WIuXi/B4EZoSgZ7/LHqGj4=
X-Gm-Gg: ASbGncs5ero9ofDrv4XV1Booys702fTrcmW52QP8nFEwU3S9pr84nfX1n5A9+/QxA7b
	+1mi0662ICNexG5AAGWRVFMWujW+pngMfPfavveG2rXxazaBL9DhqPAu3ODfT+Xbkrsg2kUrft7
	QPnLTzEGJy4PUejrMYNEblCimkwryJHsfJTL1w6IC6/uKvKccXxaCGH54adDMTsUnA42Eg3UBnx
	QfrhZVL4o/TO2nbjlt0oRNyWDJFCKq6sQZEknjIgDvJ7xIjmsztREf1zP6HsLBDfaLa6BBj5/ZO
	hy03HXUNlyZxan6WGGFMQHsRpOSjJRur42wcGQKTskutM49ZWR2bTCczAjMaODXyQ/drsK2C
X-Received: by 2002:a17:90b:2f47:b0:321:87fa:e1ec with SMTP id 98e67ed59e1d1-32515ef197cmr18057502a91.34.1756189449190;
        Mon, 25 Aug 2025 23:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7DCRIKcIriYxv1vDQ4/mgZOlve2e/tBHGMXP/jORooseUlG1Jd2+iZHB/A+lalVnxpwBTHA==
X-Received: by 2002:a17:90b:2f47:b0:321:87fa:e1ec with SMTP id 98e67ed59e1d1-32515ef197cmr18057469a91.34.1756189448603;
        Mon, 25 Aug 2025 23:24:08 -0700 (PDT)
Received: from [10.92.199.10] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254ae761casm8785891a91.1.2025.08.25.23.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:24:08 -0700 (PDT)
Message-ID: <65755189-09e0-44f3-98d6-94e44e9b1dca@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 11:54:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: qcom: Restrict port parsing only to pci child
 nodes
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com>
 <20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com>
 <rurdrz3buvb7paqgjjr7ethzvaeyvylezexcwshpj73xf7yeec@i52bla6r5tx7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <rurdrz3buvb7paqgjjr7ethzvaeyvylezexcwshpj73xf7yeec@i52bla6r5tx7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NyJ8jwSU7hVJWCisE33LCaFxvakat3pm
X-Proofpoint-ORIG-GUID: NyJ8jwSU7hVJWCisE33LCaFxvakat3pm
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ad530a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=Mpemr54xhKQ9MbVj_C0A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX8Z8utxDrm3/f
 05zBkxyJyGmQZtu06TLDWZBOTKqjqVjQbdTpFX18nbOH2sNtPsdXbr91qe5ReSoPuIz12/puC4G
 T9/DGtDAfwkD9u3PTATJ2au1F1o03i7gmcoi+aZruysgAicp56JX55y85RxCIcw/yOQyS35lT7m
 srPc/lAlmybRSP+NOsTsgm3Cm4f+0RRo86ZL50P22270F+MlKd6ZxRNwLqNzEUydY4fKdT2K/EB
 QLj7DCng6PhQGthjUXq3jCaLY7UvifZzcfGlZGgboQ4uT0aMrJNL4yQ+oJUpMYYErA1K6JRQza6
 qzHG7Q5bbXNA0J/FSM6aDvOSSVDXELl0LU/aNkquu2TxE57xzybFOjc5OK0vZZ567bbwqfI0stJ
 3DqXWNmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031



On 8/26/2025 11:47 AM, Manivannan Sadhasivam wrote:
> On Tue, Aug 26, 2025 at 10:48:19AM GMT, Krishna Chaitanya Chundru wrote:
>> The qcom_pcie_parse_ports() function currently iterates over all available
>> child nodes of the PCIe controller's device tree node. This can lead to
>> attempts to parse unrelated nodes like OPP nodes, resulting in unnecessary
>> errors or misconfiguration.
>>
> 
> What errors? Errors you are seeing on your setup or you envision?
we see driver is searching for reset in OPP node as it is not able to
find it is falling to legacy way. where there is no phy nodes defined in
the controller node probe is failling. I will add this in commit text.
> 
>> Restrict the parsing logic to only consider child nodes named "pcie" or
>> "pci", which are the expected node names for PCIe ports.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> Since this is a fix, 'Fixes' tag is needed.
> 
ack.
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..5dbdb69fbdd1b9b78a3ebba3cd50d78168f2d595 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1740,6 +1740,8 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>>   	int ret = -ENOENT;
>>   
>>   	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>> +		if (!(of_node_name_eq(of_port, "pcie") || of_node_name_eq(of_port, "pci")))
> 
> May I know which platform has 'pci' as the node name for the bridge node? AFAIK,
> all platforms defining bridge nodes have 'pcie' as the node name.
>
I see most of the qcom platforms are using pci only. for reference i see
it  in sm8650[1] & sm8550.

[1] 
https://elixir.bootlin.com/linux/v6.16.3/source/arch/arm64/boot/dts/qcom/sm8650.dtsi#L3699

- Krishna Chaitanya.
> - Mani
> 

