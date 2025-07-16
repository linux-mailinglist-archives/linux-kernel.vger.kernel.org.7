Return-Path: <linux-kernel+bounces-732847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C02B06CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A0D171AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9C81C84DF;
	Wed, 16 Jul 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A7IO801v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705C2222AF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752641676; cv=none; b=O8OJLXJKCqYMYUwjThQ279jDn04Wt+s/FoPXDT9jywhICVKYw4wGF1czYaHqI5LtUgksPbtRjVe3uvO5wU2PXz/QMTK1CfYtcfKiV1tci+QuWDCEpQtQ0hwVJOMuHTnEqhFR6EY+b3MrRPVpnVsB4XkhLpeMJHd0/K8YIbRuyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752641676; c=relaxed/simple;
	bh=JcgawIRkiXGDkejFfyGdNqbuJduoSCYxQVrXLGYc07A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXbJpfaTcX/keSxe8CmQVZuHx3J9d/VdUUEpXJyfPRxXsuuNrAV/ErFjRJFDapk4/iJnLgyKkpdxDvQb1DLrU/ehQnLCw23CR+nc9Id4VHNPL0U9p/NfbnS2FcXyMGXwbhx+I+R/TSZcOBOzMGgHKGROTO2z6+Tv9kBEizuO2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7IO801v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDVJ5031862
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HAPA/34RtxDjvhrdalVzCKzkycZXICqD7bav8h/cZ5Y=; b=A7IO801vj/WHxsyc
	lis9RxTSJKlG3BasMsC9MlRC7tl2x8Kgo0m7Az4WXe7DxeAwEiqsfT+//08TOKgo
	UPD3eAPbBDIKPNeGv2LRp+Fsmvk+Epeq8Xg/G3CvLrJtxpow6Wf0mr+kCpTpPqdt
	JDlTOql3RxaQV3CrDkQPWj302b7asJToVBhSsYgqchozVc9BD1IKNvWZOiX/Z53X
	YI0FsWij10XmjqcEU4ZZRNgh40Nmi04R6t9VxCl4B2VSApmB6hP5mo/T06fKRjve
	PKdSWOWj5R7x4AhZdc5648SvEtXkyL+9PCSxKKp4ZoxQgkG0TWaDAAxNW2b7M8vH
	5lZ6XA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufutadns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:54:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-234f1acc707so49493585ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752641671; x=1753246471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAPA/34RtxDjvhrdalVzCKzkycZXICqD7bav8h/cZ5Y=;
        b=WNouxsxSjzC8dwxy99JfYL7WoMiakNjPOH6Qv0HrlEXDpV7lelejQuEAtQ+EXn65eV
         ZcWuAncNk2MaaCTX4SgPeNs6IrUYAHdCADxNS6/1PQXF4LynZsWoWI2wuEBTPXyEWshr
         uEtgCv0Yf7kXy1a+oEVAHXE9X02/vKwFKIapsRwdWTvGfDEHhUkstc505m+ca3IjmDau
         BDq5YQivlvF/BB62rjYUz7gVUI2lmPoEhLhJJHh2ZKtOk6cDeF3LjzPPyJsjsFxi3Ky1
         5vpnwiYhF7Y1BqJIjCA4st+VAyVmq+gKHNR1n2ePD2KfcQ7WVDBdxxaop3o3CcZP928+
         riKg==
X-Forwarded-Encrypted: i=1; AJvYcCUk9gzbm/bzrQ6dVYw9aEv4SQPKow3zT4n0KgME/GV8AErPciUIyxyR0TeXUpawxN+ExpKmNsUbeSvEMwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrpoNkaUcx6zcDiPq16WhNkipw0kxUl6OKQmOU1yZPQlfeaAU1
	RTGmoeGEaL1JGWd+qPA0ya7WQTwVhHhYOwEXYgKbGMBXk3nyIr6IS1ez44mop4tgMuMy0n0rbhm
	zIP0M70QIa8GaT46Ld8V8R9R6AbkFieiodV0iZ4YHppVGsA43u5Fgd8BZaf6xNYo/aQ4=
X-Gm-Gg: ASbGncs4GcAIft0GARYOGrjx4GMEBLb8+Gf8OniVDo1UhUshXWcKB7ShFvI39pQUvO+
	xAQ2SYrzcjt0b6GutcSPtyDNXKkWvqct9SD8xAyDHBnbxBmOA2hne12b4a2no5HLWMrRChEnJV+
	XQKc0CmFFw0VSL8i+hUdirds9Z03gSMQZsCBda7hLvY1uk8d5jVUkYN/k9MYf1UwRJLqOu1c3Di
	iZ/NXb4II3CxI/8kZOpQZ4CLqkiD0NgvrRSFwzu3QCEiAzZBTdIyxkPxpis9v867OeK5oAEILXV
	qp0invm9yWjl6xVpykIKM5FXFK6gkk7THwR3cgeayCKd+GOZVjG5AsLpypvzspEQ/opKkA==
X-Received: by 2002:a17:902:f545:b0:234:ba37:879e with SMTP id d9443c01a7336-23e2574547dmr20717595ad.38.1752641670791;
        Tue, 15 Jul 2025 21:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3o8ZyYwDjR7aKMNEc/ivaUPzgonLNBGd7pGRCieP1Gp9KfqY+Mxb+hO4nDvgLn070PhIIpQ==
X-Received: by 2002:a17:902:f545:b0:234:ba37:879e with SMTP id d9443c01a7336-23e2574547dmr20717285ad.38.1752641670325;
        Tue, 15 Jul 2025 21:54:30 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435bbc1sm117686505ad.228.2025.07.15.21.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 21:54:29 -0700 (PDT)
Message-ID: <eccae2e8-f158-4501-be21-e4188e6cbd84@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 10:24:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
To: Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=68773088 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=uNiOjgRUHSxkwL6ZQ2AA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: xMJTXUd0zfW7SGClhHIyNtlPISx8dTAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA0MSBTYWx0ZWRfX0/yaZws8X2UI
 GBhoQgMbearLyNoXAJDFRtbEc3wJkg6h1C0BsPE45D69pJHTAHfpjTrpgyYI5QBE6F9D5ev8154
 HClK5RAQGfmNwSt2AdM6TNpWUaJp4Y4ttaYbENL644E6msmWxSQ6kSo9FCyvRiS5Xq2W54CtSoa
 Dl0Qol0D8aqVihvlKdRO3d7DygvkFvqzMdzrGRY5cVfXWXVOy/4Ljgxqy3f8uy8NhxHzO6LfYhk
 2DthNzVpqh/Uk7wP6GSFnV9WzUb58Ls/kYxqZVo5YxKuC95tlnuzG6xD4cETKbYGwwcHFbizSJL
 AX4+HzP7A9o2uHqVUWR4B5sdLe0DXAt4zvipczxb7yOQGSPTDKlpVvpPv655MGTKThtU6/kKgLi
 MExnDabZ8enYqM+r9XiKPvK5IW4eW4necm/puRDufrdp3rnG5tQoNEWCS2qN4qMhGi+Sp/Rb
X-Proofpoint-ORIG-GUID: xMJTXUd0zfW7SGClhHIyNtlPISx8dTAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160041



On 7/15/2025 4:06 PM, Manivannan Sadhasivam wrote:
> On Tue, Jul 15, 2025 at 11:54:48AM GMT, Konrad Dybcio wrote:
>> On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
>>> It allows us to group all the settings that need to be done when a PCI
>>> device is attached to the bus in a single place.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index b4993642ed90915299e825e47d282b8175a78346..b364977d78a2c659f65f0f12ce4274601d20eaa6 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>>>   		pci_lock_rescan_remove();
>>>   		pci_rescan_bus(pp->bridge->bus);
>>>   		pci_unlock_rescan_remove();
>>> -
>>> -		qcom_pcie_icc_opp_update(pcie);
>>>   	} else {
>>>   		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>>>   			      status);
>>> @@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
>>>   	switch (action) {
>>>   	case BUS_NOTIFY_BIND_DRIVER:
>>>   		qcom_pcie_enable_aspm(pdev);
>>> +		qcom_pcie_icc_opp_update(pcie);
>>
>> So I assume that we're not exactly going to do much with the device if
>> there isn't a driver for it, but I have concerns that since the link
>> would already be established(?), the icc vote may be too low, especially
>> if the user uses something funky like UIO
>>
> 
> Hmm, that's a good point. Not enabling ASPM wouldn't have much consequence, but
> not updating OPP would be.
> 
> Let me think of other ways to call these two APIs during the device addition. If
> there are no sane ways, I'll drop *this* patch.
> 
How about using enable_device in host bridge, without pci_enable_device
call the endpoints can't start the transfers. May be we can use that.

- Krishna Chaitanya.
> - Mani
> 

