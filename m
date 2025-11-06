Return-Path: <linux-kernel+bounces-887805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC9C39212
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6BE189AD44
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC802D46CE;
	Thu,  6 Nov 2025 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fN2DOnbK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7jN9jgJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA612B94
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762405255; cv=none; b=RgUi+hLorrqSTMVKSLvNyE5jA/XulUeaaP3aFJwdpTFdp1dIQAhb2IBmN99j3P/qe/fCXrb7u7bd1Q98B3KQNQ3g2znkFo2tHn3qWctUxqUJqYKu2IE5F8w/iovPDn3hHUJv9AM+ruti7y9VwbMBXIDzMA1tc2y2iSLiI5sdIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762405255; c=relaxed/simple;
	bh=XRjGtf1Knh3hgzogzHExgaV4xgq+KvChXNiYIl0g/c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMB9XYFkJxWExO19gJvbdccZMGaWXoYKmCekNIVQsXuj3VAfIyQizfdY2CVfF8CrZ3eDB/1JUlkQZnJ/te7np+Y0iK4pcbeRusclwt4q3azKnAqEuS8qyXxGOqfO2PFQuBH1kaB5h8lAW8tHr3Cm1YIrDg2B+nPXqc6GJ3CRRGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fN2DOnbK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7jN9jgJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5N5gaD2148200
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 05:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7VcUQ37bTN6AllIXQSzVCUA/2pHn6xqb/TkBAa8Q0CI=; b=fN2DOnbKlk18IDdZ
	JRzOJqy4w4y6+I+1DfSz5x5TtGgU3/dtCYnYNe/rF35V1R6oOUw4q0c9jGL97io6
	kTwx14la8sv72w7TfflGhSpukAckXn+2muBMWJi9kAMi31KLp6Og6Z7cBv2Tj507
	2MtZPiBZq1CoRt3vZBfG2Kv1csFPA0HXqA4bLJtJozkRDKg38kVNsotjUtdiajmy
	0z4nWe+yUT8qMaEIN7UknmBTU6TVjVoHzR27VlcINCKQYPKIF3/byXr5YaXIHeHZ
	JR4TI9Pc+Uw1KfWmavDNw0AvmtckjXTZcbK+t1a4o/IQzgb4AKF4Yn+uT4emctJc
	RjBgeg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8fxvru02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:00:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a998ab7f87so69243b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762405251; x=1763010051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VcUQ37bTN6AllIXQSzVCUA/2pHn6xqb/TkBAa8Q0CI=;
        b=D7jN9jgJKh64hq3oyO7whil7ekreY+mLoOhVydP2hsKVdIxQdvOMnLbb8uUbXh8+b0
         YGtWKwKU6OqiZCzhxQQF03bIZW9iSxd1AclolhwB5y+s/RfCyPMWYnn/6loqGi5iFiPE
         mcKBwVRamn6gUj7iTRtW1lvuIfMV3ejt6LTj85qazP5ZcJBRAOWEmVK4K0a9X/uMTr6H
         DzETnUb2IKaK7MfUqu+3QjZKjoDxtULx+2i/EtLbNUzeUz7uv9SsIbTME/IvveXc2Ujz
         nfzT2kiN4MJw/6iDA4C4BrJJJtqar727C5pMirGlT0SO7S0oyp1kqDYfb9Fynr9Jf0l3
         +JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762405251; x=1763010051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VcUQ37bTN6AllIXQSzVCUA/2pHn6xqb/TkBAa8Q0CI=;
        b=AzFzC+G3eUYPoeaB1DgHB4kOGkE0JrTdDjPrtENL/4LwMBJJiCVZeE35awZztqyVg7
         uJsrWB0dQES/ajDviE4wBxZ3jAKWlSMmihe9svPWwo5nD5+PUg0cQ3l0nzOon9P08SaL
         llbKT4u0znPiRKpNdj3ti/yd6Irp8jZxQ4CAmgZ4EuUxmLKD1zgdGzFyFlf2cMyG5fPI
         rHmfsLiXCDIsJlu88Arl4P1Tbfi325kok1fNzL1On+sebJQR8uDSvaU3e5qWDjC/pkTg
         CLjSwD+odp2YFGzRHjCGvIqgCVwGd9XqIA7NUOzZH6PdJXJZxqxPgIpAn3q86w0XnNBK
         cYXA==
X-Forwarded-Encrypted: i=1; AJvYcCVofJdf7W/Z83MVy+ST8O+PvvKqYDrxnDMgt/3IqRA9/UbmnNQHHT5B16C/IxNJxfPAaj/dE/UOS6bR29g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTjRQ9FRc9PWoq502DLbSgeDWI3sS1sfamDFFxf1n0bKagk2Q
	1suIqtko+4it/JzY2NCYEfKUo8n+pz4nbtedIHAvj7D91FFPX34lje4z+f6NZvdMgLX85UMBTwL
	M8P4WDNcQZiKBhkbITjpOIvTzhIpDGBDlIpncu0F6x/Zt+/lNB5sV7iITDrtYpQavacg=
X-Gm-Gg: ASbGncvT0eXFGj3ta08u32hSBkX/dYmAs723bT3C4LivsqpenNT47fglCOxKRN24D9P
	4VoyNPvP8YTBlM4UPpa/gpZlW+NxrZ8sg1YDI8csKqWP9XON5xF3JIyYdEPbshPwm0yYqMzJrOK
	RbGgJ6l28kGoNiOlZJUetCeg5kvL2IvfO2Eg72Re6JJFOj8UfFAtdc9NJznZdHC4yThysbI8FZW
	BYlUwqKRxe11XWxsEXkfGoA4indS+DYc8w13yvK8G62ShLTklsng52lRUgu0KMnmRhXMtNtsx+c
	P/85CQE2c95kbXkTtg7rlSxEQvW7W83YsxG01M+UENN9KYnF3MCxrxA3LrZerTunV3qOMvVjVb6
	S1a3t7eVbgbo/sRttQqidVt6F/eTcwAY=
X-Received: by 2002:a05:6a21:3294:b0:341:a18c:dd80 with SMTP id adf61e73a8af0-34f839e02cdmr8281579637.4.1762405251004;
        Wed, 05 Nov 2025 21:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoZvD3PSRV3YeZCJj9DTySpLI8Sq4of4sBAy+31LPEveUTKkYFf/liRbgSaGeyzkkY9H6wag==
X-Received: by 2002:a05:6a21:3294:b0:341:a18c:dd80 with SMTP id adf61e73a8af0-34f839e02cdmr8281525637.4.1762405250453;
        Wed, 05 Nov 2025 21:00:50 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d098fdd7sm540915a91.0.2025.11.05.21.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 21:00:50 -0800 (PST)
Message-ID: <e459b4de-52f1-4c20-be84-07efdc9fed93@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 10:30:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
 timing
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
References: <20251104175657.GA1861670@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251104175657.GA1861670@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAzNyBTYWx0ZWRfXzLoLTqQZNIbq
 vVA9wfys0LZ3830j7pEW+jHFw+QDahxVLeYXoulmpvZYINj5PghwGpwM14Lrg8RVx1ntsnZ5mhu
 emVj0Fn5g0WGQedGqC0oBIONZXCJyGuGi8ehL4CmDyk2FromotjJlH5jw8S5tfNk+dSOUEEWAIq
 foq8Kc8gz7f8y5bXFSnOUvRgWMx/+V9Ecm8i26UMfE6HEmXe035M87w/uirBG+lbDEB04pkmlmJ
 Ob860Rxql3GaqG0OyDemDHSluCdge+qMkSMY2fje13783pHKebI/4MGKLz6BGHlz9TpZW8XcTv2
 XfKnIpMbDnW6WYCvA6+CGX3s2d2aRhEBIf7/w0v38jo9QokSJmKhGT4jwLJHXeHnUR+aV62XYXq
 x9Iaf0D0T1SriUJagAGu6XahmxlQgA==
X-Proofpoint-ORIG-GUID: WLZTNoml5N6GrPX5U31Pdc5BBnWZ36S_
X-Authority-Analysis: v=2.4 cv=OZSVzxTY c=1 sm=1 tr=0 ts=690c2b84 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wBt9fhMRhOodALO6grUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: WLZTNoml5N6GrPX5U31Pdc5BBnWZ36S_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060037


On 11/4/2025 11:26 PM, Bjorn Helgaas wrote:
> On Tue, Nov 04, 2025 at 05:42:45PM +0530, Krishna Chaitanya Chundru wrote:
>> The T_POWER_ON indicates the time (in μs) that a Port requires the port
>> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
>> asserted before actively driving the interface. This value is used by
>> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
>>
>> Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
>> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
>> This can result in improper L1.2 exit behavior and can trigger AER's.
>>
>> To address this, program the T_POWER_ON value to 80us (scale = 1,
>> value = 8) in the PCI_L1SS_CAP register during host initialization. This
>> ensures that ASPM can take the root port's T_POWER_ON value into account
>> while calculating the LTR_L1.2_THRESHOLD value.
> I think the question is whether the value depends on the circuit
> design of a particular platform (and should therefore come from DT),
> or whether it depends solely on the qcom device.
Yes it depends on design.
> PCIe r7.0, sec 5.5.4, says:
>
>    The T_POWER_ON and Common_Mode_Restore_Time fields must be
>    programmed to the appropriate values based on the components and AC
>    coupling capacitors used in the connection linking the two
>    components. The determination of these values is design
>    implementation specific.
>
> That suggests to me that maybe there should be devicetree properties
> related to these.  Obviously these would not be qcom-specific since
> this is standard PCIe stuff.

Yes Bjorn these are PCIe stuff only, I can go to Device tree route if we 
have different values for each target, as of now we are using this same 
value in all targets as recommended by our HW team. If there is at least 
one more target or one more vendor who needs to program this we can take 
devicetree property route.

I am ok to go with devicetree way also if you insists. - Krishna Chaitanya.

> Use "μs" or "us" consistently; there's a mix above.
>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index c48a20602d7fa4c50056ccf6502d3b5bf0a8287f..52a3412bd2584c8bf5d281fa6a0ed22141ad1989 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1252,6 +1252,27 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
>>   	return val & PCI_EXP_LNKSTA_DLLLA;
>>   }
>>   
>> +static void qcom_pcie_program_t_pwr_on(struct dw_pcie *pci)
>> +{
>> +	u16 offset;
>> +	u32 val;
>> +
>> +	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
>> +	if (offset) {
>> +		dw_pcie_dbi_ro_wr_en(pci);
>> +
>> +		val = readl(pci->dbi_base + offset + PCI_L1SS_CAP);
>> +		/* Program T power ON value to 80us */
>> +		val &= ~(PCI_L1SS_CAP_P_PWR_ON_SCALE | PCI_L1SS_CAP_P_PWR_ON_VALUE);
>> +		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_SCALE, 1);
>> +		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_VALUE, 8);
>> +
>> +		writel(val, pci->dbi_base + offset + PCI_L1SS_CAP);
>> +
>> +		dw_pcie_dbi_ro_wr_dis(pci);
>> +	}
>> +}
>> +
>>   static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
>>   {
>>   	struct qcom_pcie_port *port;
>> @@ -1302,6 +1323,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   			goto err_disable_phy;
>>   	}
>>   
>> +	qcom_pcie_program_t_pwr_on(pci);
>> +
>>   	qcom_ep_reset_deassert(pcie);
>>   
>>   	if (pcie->cfg->ops->config_sid) {
>>
>> ---
>> base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
>> change-id: 20251104-t_power_on_fux-70dc68377941
>>
>> Best regards,
>> -- 
>> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>

