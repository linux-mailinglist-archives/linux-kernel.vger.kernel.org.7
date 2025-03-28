Return-Path: <linux-kernel+bounces-579459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F04CA74370
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 06:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA64A3BB518
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4C221018A;
	Fri, 28 Mar 2025 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iWcIy2WA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8723211285
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743140061; cv=none; b=pVTn2X1X3WEr5NzrlOBwsU4dcd2SFM7ZaT60HmucHoBxwgQcipsk3N9kaM123XOpS7njX+1uKUDqqp81bIHFtwf3BqZrmOEDbrNQ1xwD8pxYh5dqJeO3ZvVwV7CoxvS+4xnK1zNGN9+FGJlJFGkvfi9juaAbM5p8HNY4OebRYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743140061; c=relaxed/simple;
	bh=CbPaDrJ4FeoIlwmsZWy9972ejo3BehiVxWsy5g+KDxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQZy6E5I9eKghyRY+nPd+ioWtJatJIGX4QutQGp5AO8qddxTL6adGqMgA7dGdczwRDgEiLF/tSQEhwiWB1O1WVszn9EjxYmpF2G1M1J9kjnXltRK6/GfJVs6SvTaVuIhWF5Un84OjpuDtAaXcNPuQTUBacJkM8BE5Ywumcwj6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iWcIy2WA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S2C9YI023702
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 05:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FjBfrj2rWschU4104LLg8r3y5KOZRiF6HP0sk4jVTlY=; b=iWcIy2WADSWLEdWY
	ygDy0oPZI1ilHOtA+DAp6T3xh5/e4Lh4CcB1fkelt+pNTVtQSVWwN3uDbCiVOUxj
	VJm+b6ZWGLBA6ymUM12eLG/srpFqriW6cjClUIdZO+KjCWMQMyxxZ72ayuebYxjZ
	MkihhDZRconTxNXeVEMonwVgfCfqkBMwTKjgz2KNmP9z+tMaSze+PPXn+iaAVeoo
	OHHLn82zFdMq4aHwnZyhaPPakI3AadO/cHZwOFDbQ1gqzVeLZLKOHZ1NUZYCc9cP
	gLpp9sLQDn0B8eGfrji66MOKukoCNMv0eg/43+TSYWPCEvzcwLod2brkdDGQZtrC
	uC1/9Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45njsc0cuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 05:34:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2265a09dbfcso51379055ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 22:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743140058; x=1743744858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjBfrj2rWschU4104LLg8r3y5KOZRiF6HP0sk4jVTlY=;
        b=uBnj/EpnNuulS1UcONF5Gqd5UdiKo0eLKSRflgYB/lIT5JEnjg6/kN9H3JeLmBx823
         dNWWiO4HbRNTPhNSAhWq/kEPOPAOt5PUoGUwmqOhOwvpC7CKEW5m0k9oHLEKppNFCM4e
         NU1wZ1+Qet8fP/hL3P1mvjT70+UaijlYYDkh0qRkoqseeOrhGEgH4s67OijNCV5/hzcO
         yjq7crE5CSTK5USnRcBMJ0DKMYwZ1Gbk8Lo+/y0/V8+n1VSxrwE/Tqp5+pFrr8i2aqJ9
         GqP073IzTfMfJm/CLyDo5rwrxhwdaBYgUUPtt8BVbjcMZAtIq4wrDHBeZOKQmOtjklWJ
         10Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVLA7OhOGfSfgusn+/V1fE3Jc1pWqgukGFr46mNRKl/LApqlrZfKvrUpHTI3xAGrVo8gTAVAILUFhKen9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2721MRitIE5ZchADxJhUZB4op374Da6HW/JUDp29j/7HIb67S
	LjOsHuotgUO9QplixWDQ87JQ2m1y9zPXVYUpbZNyHqaWRWoQGpzJzgcKy3x1OERUI7C/PF7b+1+
	hg8AACyR6f1uFKgcNVXf4OQrJc+B7tcebxEGDCFK8+gyNuesMXVJoRX1qYk82AAM=
X-Gm-Gg: ASbGnct3lWGyUY9B9s4SY8HOvSxBOVJBP4Mz0FN9y0mesg8FX5+yZXOmAqanUVa0cqx
	++7r1n4WoZxRXZm6/gnGLvTkhI1qPcamUpwHyhIDFAz1avDohSfDuPVYjE2sQnabQLJxIFpMCV2
	rv7BedOFtzYQUz8w9CrLmoi7geYkH4DMaYf7dta1uKelfsdlCzAkGJ9bVkFZgoSFyFGnaJBMGHm
	cLNbNINK1zJhRVFTTq6m/ySgBavQ7xwP5GLZRlV27YpHsK90bqSKOitgrtTjTervC5TNa1tKDg2
	bpsAY+Dw1avOU7KkHA4ZTX9I3KN/Okl+yN84etBYKvPAqA==
X-Received: by 2002:a17:902:db0a:b0:224:23be:c569 with SMTP id d9443c01a7336-22804845097mr102527895ad.22.1743140057922;
        Thu, 27 Mar 2025 22:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcD4IHX1W6f3V7a/135vsdoU5XAVFg/3bKjgHWhLDGDdOc4qwiWlsAX+wTGlesaJO8h2QWrQ==
X-Received: by 2002:a17:902:db0a:b0:224:23be:c569 with SMTP id d9443c01a7336-22804845097mr102527305ad.22.1743140057391;
        Thu, 27 Mar 2025 22:34:17 -0700 (PDT)
Received: from [10.92.192.202] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec6f91sm9510475ad.17.2025.03.27.22.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 22:34:16 -0700 (PDT)
Message-ID: <92c4854d-033e-c7b5-ca92-cf44a1a8c0cc@oss.qualcomm.com>
Date: Fri, 28 Mar 2025 11:04:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
 <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
References: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
 <20250316-preset_v6-v8-4-0703a78cb355@oss.qualcomm.com>
 <3sbflmznjfqpcja52v6bso74vhouv7ncuikrba5zlb74tqqb5u@ovndmib3kgqf>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <3sbflmznjfqpcja52v6bso74vhouv7ncuikrba5zlb74tqqb5u@ovndmib3kgqf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fJk53Yae c=1 sm=1 tr=0 ts=67e634db cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=wBt9fhMRhOodALO6grUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: F-Pksyot7O5bRcHTfmg_xhsw9o9Ye1sD
X-Proofpoint-ORIG-GUID: F-Pksyot7O5bRcHTfmg_xhsw9o9Ye1sD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280036



On 3/28/2025 10:23 AM, Manivannan Sadhasivam wrote:
> On Sun, Mar 16, 2025 at 09:39:04AM +0530, Krishna Chaitanya Chundru wrote:
>> PCIe equalization presets are predefined settings used to optimize
>> signal integrity by compensating for signal loss and distortion in
>> high-speed data transmission.
>>
>> Based upon the number of lanes and the data rate supported, write
>> the preset data read from the device tree in to the lane equalization
>> control registers.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 60 +++++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
>>   include/uapi/linux/pci_regs.h                     |  3 ++
>>   3 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index dd56cc02f4ef..7c6e6a74383b 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -507,6 +507,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   	if (pci->num_lanes < 1)
>>   		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
>>   
>> +	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
>> +	if (ret)
>> +		goto err_free_msi;
>> +
>>   	/*
>>   	 * Allocate the resource for MSG TLP before programming the iATU
>>   	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
>> @@ -808,6 +812,61 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>>   	return 0;
>>   }
>>   
>> +static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	u8 lane_eq_offset, lane_reg_size, cap_id;
>> +	u8 *presets;
>> +	u32 cap;
>> +	int i;
>> +
>> +	if (speed == PCIE_SPEED_8_0GT) {
>> +		presets = (u8 *)pp->presets.eq_presets_8gts;
>> +		lane_eq_offset =  PCI_SECPCI_LE_CTRL;
>> +		cap_id = PCI_EXT_CAP_ID_SECPCI;
>> +		/* For data rate of 8 GT/S each lane equalization control is 16bits wide*/
>> +		lane_reg_size = 0x2;
>> +	} else if (speed == PCIE_SPEED_16_0GT) {
>> +		presets = pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS - 1];
>> +		lane_eq_offset = PCI_PL_16GT_LE_CTRL;
>> +		cap_id = PCI_EXT_CAP_ID_PL_16GT;
>> +		lane_reg_size = 0x1;
>> +	} else {
> 
> Can you add conditions for other data rates also? Like 32, 64 GT/s. If
> controller supports them and if the presets property is defined in DT, then you
> should apply the preset values.
> 
> If the presets property is not present in DT, then below 'PCI_EQ_RESV' will
> safely return.
> 
I am fine to add it, but there is no GEN5 or GEN6 controller support
added in dwc, isn't it best to add when that support is added and
tested.

- Krishna Chaitanya.

>> +		return;
>> +	}
>> +
>> +	if (presets[0] == PCI_EQ_RESV)
>> +		return;
>> +
>> +	cap = dw_pcie_find_ext_capability(pci, cap_id);
>> +	if (!cap)
>> +		return;
>> +
>> +	/*
>> +	 * Write preset values to the registers byte-by-byte for the given
>> +	 * number of lanes and register size.
>> +	 */
>> +	for (i = 0; i < pci->num_lanes * lane_reg_size; i++)
>> +		dw_pcie_writeb_dbi(pci, cap + lane_eq_offset + i, presets[i]);
>> +}
>> +
>> +static void dw_pcie_config_presets(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	enum pci_bus_speed speed = pcie_link_speed[pci->max_link_speed];
>> +
>> +	/*
>> +	 * Lane equalization needs to be perfomed for all data rates
>> +	 * the controller supports and for all supported lanes.
>> +	 */
>> +
>> +	if (speed >= PCIE_SPEED_8_0GT)
>> +		dw_pcie_program_presets(pp, PCIE_SPEED_8_0GT);
>> +
>> +	if (speed >= PCIE_SPEED_16_0GT)
>> +		dw_pcie_program_presets(pp, PCIE_SPEED_16_0GT);
> 
> Add other data rates also.
> 
> - Mani
> 

