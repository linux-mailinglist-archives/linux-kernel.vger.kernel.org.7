Return-Path: <linux-kernel+bounces-802039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF3B44D07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CBFA45A2F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CAC26F28F;
	Fri,  5 Sep 2025 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="epZ4vg8Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17D1229B02
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757048932; cv=none; b=u2LMqVK/vJHQ3rcSzESYI+0RIhV724b/eS3LZGNc/csb1X5tuaquUhDc5W0ipcPnd4OM9YFFcWNnaSB73skMtmLDd9lUStumgyaoS8u1GTq5oraTdd0KrbD2LDZ6VBByoyM67v0Jr3pygKMilX2UaTz6WzldzC2aXt2r70p3LoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757048932; c=relaxed/simple;
	bh=GrlHgzC2CZ+jmdFYYWA4oPGmFL26PhRfAOttrHjSV9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAmH0EIhQfQyH/vIiMVFpzlMKyEE9erdKXeGTLZoKYS1AzEGrfGR6l8QUXVq4nAbjxMCy7zwAakPXjd4cJQfZcxUiVZg0tUG0kKDGcHCsnj6oeODWrnjXTTg79oQo7gvpokBB8O4eevb9tkloi3Dytq1vbRduEU5VUbtRX2scao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=epZ4vg8Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IxYrc022433
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 05:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XSV9LgvcNte42quuPILmy53FTfP05rNvZ3H6trDOXVA=; b=epZ4vg8Q70qC1xld
	puI/ROAD5P/CthQU8IE5XlFXgzay+DSbRwaOQbNNOggo+CiB36b56WGomeuSsdug
	BP18rYqte3BjTsNugRsKAECwO17jHSGN/fvlrIeQvY9Pqq2Sq2kqxuvZ1uCsNN9Z
	FIaq65y2AYAPxFSsYzSRS9+Q9qZrTeCA5VXcKIS2cWaaHf13tDGk2ZTYHvfXQyiP
	+p1IcAH8tVNC/87cMnxdu09vKTCO3lPJn39luw1j/8fC/41dClzL17aqpx1eJfAd
	W1kKfsYJAXwpE0CSyFZO4J9YrOAfObh59rT3wGwoPIsneg7KOxJRbqIRAkaSkBGf
	gmUr4g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk99qrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:08:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so1738195a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 22:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757048929; x=1757653729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSV9LgvcNte42quuPILmy53FTfP05rNvZ3H6trDOXVA=;
        b=D3z/CsmI1TcJtZhW/UAqiLwi9oxZ/7ZJzBU7zIe/K7UyWp2J38ORv9k7xtP/UCi1Sv
         fY/YmR7ndgI1RIDPMu24zJJoiaR+RI+NxBxoI6jCP4wgRzbhqQjEmOPgNjpg7iLAEZuU
         pHhBo9k7cPn+9BNu/cYk49auoSop7RWN5utHBY7ANII1YdjcV/+rQdlXOREXs3kIAGHi
         mJJmOdZ2HdMROl3LSgzhAFZIYKgtHG79M6lKMMcmKfB8TIk971Xbk1IkLiriD17d0GzR
         HdJc7FFNtXpBzNIfHYLGE938DTz6S6LEEvlHhRqz/CWyJITylq/x8v4Sj5AlSZu75oAL
         vdig==
X-Forwarded-Encrypted: i=1; AJvYcCVeA2Yk//0hSV9kz1hvItehA4e93NWsvJ4sTLXEv4wQJ2v2v3yy5GF8dSonA5wrUDXEtBPFCGzQzoOtlL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjTR7MoVUK4p6IfMnM87fp9C0uy3+sujPuoXo0YK5DMKERsJ9
	C2oQwUPbLrTra40s7U4qDAUo5rmMeAsNH1tfhY1yf1oI34h4Pc7OdcuFaSq4ahwhgMJ+HXnrndE
	n4s15rzEgBb1QzlCNTD+fsB/vWWvMy6wgM10uYRW3jGLhl4H+9oi4oAL0cZ1VN45lvqs=
X-Gm-Gg: ASbGncuo0JRU+QI3vHPnVmP5yvzZRNPqmSGguI3GPzLeIPql+i63UNBFjpTDmyXoSjJ
	8crrcekvAtHysR27swn0BPm0nDpEQ7pUpP+FyTHUKHAuFksYU3hqxHjvQj5uuA70HH+sYCEPblz
	G11pay8uXyfYbawNW7bcHm+FxqwL3RlIFortfdaQdaFpT7afhysVV8MbWvR20OBTsbyQ0XvXryY
	IF/bM6oJnyTSU+9z65bd7D3XHB7t9pZwmuO0q39k05Zx3ubKW8ffuNzFze376w7ADxDRkuDpnSz
	kqrt3IGTwrm+Vy6NcIJNAvk90TKYf1LJkIka5OHYnszbWe3PkU6TITF1Woyb0pwkMfOkDO9rhA=
	=
X-Received: by 2002:a17:90b:5244:b0:32b:ca6f:1245 with SMTP id 98e67ed59e1d1-32bca6f141dmr1311375a91.5.1757048929152;
        Thu, 04 Sep 2025 22:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA9P7tB6lmJr0rcbxhQN37YFyHdHYmxjMpVxRBmu7y9F8iQWpn84IECj7yyO8YLxvQprRcOQ==
X-Received: by 2002:a17:90b:5244:b0:32b:ca6f:1245 with SMTP id 98e67ed59e1d1-32bca6f141dmr1311329a91.5.1757048928543;
        Thu, 04 Sep 2025 22:08:48 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329f633749bsm8709767a91.27.2025.09.04.22.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 22:08:48 -0700 (PDT)
Message-ID: <54c527c5-e464-4596-a195-064da441c58d@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 10:38:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] PCI: qcom: Add support for ECAM feature
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250903195721.GA1216663@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250903195721.GA1216663@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dfcB-UVWTJjIbecDVFpa7loekyuNQ171
X-Proofpoint-ORIG-GUID: dfcB-UVWTJjIbecDVFpa7loekyuNQ171
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68ba7062 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=9HwtANXkhL7ZsJXsY_EA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX3c1RNEysOBh+
 EMiGuAKhn37pjea9KRXZH1tkUs78j8ep83hQ/RSnhdWRUvaci6iv6Sah6+Oxs60QA7UXtBAF4Vp
 0mg4Uo8UqAebH8VmSkGav2AdRhpZgN59ppXL6Up6zQxygMPkEXPpi0qQVbodFQJMHhfGOMWCMIy
 lFHfzcLQ+AaOsk9Fz3pwNy3KrFBtgB6EZTw4YGRCkNHPcBC0C3zuAFPOEWjgxTOBilo4CvZTcFf
 NyDRMmV3IVrUbLkvww+q+KQ/KreYy77k4UD6nqjEmtDO0GqvMXkc7sMtM4DWGudW4rMHIHp5tzc
 qvI5IRzWPFjgR3F1uDUWjAyddejzJkhz/odwsAJDd3gi9ZhM3sdl9Vdd/UoSK8gbR2CeaoJjTV/
 DW5xQcPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042



On 9/4/2025 1:27 AM, Bjorn Helgaas wrote:
> On Thu, Aug 28, 2025 at 01:04:26PM +0530, Krishna Chaitanya Chundru wrote:
>> The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
>> gives us the offset from which ELBI starts. So override ELBI with the
>> offset from PARF_SLV_DBI_ELBI and cfg win to map these regions.
>>
>> On root bus, we have only the root port. Any access other than that
>> should not go out of the link and should return all F's. Since the iATU
>> is configured for the buses which starts after root bus, block the
>> transactions starting from function 1 of the root bus to the end of
>> the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
>> outside the link through ECAM blocker through PARF registers.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 70 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 5092752de23866ef95036bb3f8fae9bb06e8ea1e..8f3c86c77e2604fd7826083f63b66b4cb62a341d 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -55,6 +55,7 @@
>>   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>>   #define PARF_Q2A_FLUSH				0x1ac
>>   #define PARF_LTSSM				0x1b0
>> +#define PARF_SLV_DBI_ELBI			0x1b4
>>   #define PARF_INT_ALL_STATUS			0x224
>>   #define PARF_INT_ALL_CLEAR			0x228
>>   #define PARF_INT_ALL_MASK			0x22c
>> @@ -64,6 +65,16 @@
>>   #define PARF_DBI_BASE_ADDR_V2_HI		0x354
>>   #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
>>   #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
>> +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
>> +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
>> +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
>> +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
>> +#define PARF_ECAM_BASE				0x380
>> +#define PARF_ECAM_BASE_HI			0x384
>>   #define PARF_NO_SNOOP_OVERRIDE			0x3d4
>>   #define PARF_ATU_BASE_ADDR			0x634
>>   #define PARF_ATU_BASE_ADDR_HI			0x638
>> @@ -87,6 +98,7 @@
>>   
>>   /* PARF_SYS_CTRL register fields */
>>   #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
>> +#define PCIE_ECAM_BLOCKER_EN			BIT(26)
>>   #define MST_WAKEUP_EN				BIT(13)
>>   #define SLV_WAKEUP_EN				BIT(12)
>>   #define MSTR_ACLK_CGC_DIS			BIT(10)
>> @@ -134,6 +146,9 @@
>>   /* PARF_LTSSM register fields */
>>   #define LTSSM_EN				BIT(8)
>>   
>> +/* PARF_SLV_DBI_ELBI */
>> +#define SLV_DBI_ELBI_ADDR_BASE			GENMASK(11, 0)
>> +
>>   /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
>>   #define PARF_INT_ALL_LINK_UP			BIT(13)
>>   #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
>> @@ -317,6 +332,48 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>>   	qcom_perst_assert(pcie, false);
>>   }
>>   
>> +static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +	u64 addr, addr_end;
>> +	u32 val;
>> +
>> +	/* Set the ECAM base */
>> +	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
>> +	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
>> +
>> +	/*
>> +	 * The only device on root bus is the Root Port. Any access to the PCIe
>> +	 * region will go outside the PCIe link. As part of enumeration the PCI
>> +	 * sw can try to read to vendor ID & device ID with different device
>> +	 * number and function number under root bus. As any access other than
>> +	 * root bus, device 0, function 0, should not go out of the link and
>> +	 * should return all F's. Since the iATU is configured for the buses
>> +	 * which starts after root bus, block the transactions starting from
>> +	 * function 1 of the root bus to the end of the root bus (i.e from
>> +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
>> +	 */
>> +	addr = pci->dbi_phys_addr + SZ_4K;
>> +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
>> +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
>> +
>> +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
>> +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
>> +
>> +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
> 
> I guess this is an implicit restriction to a single Root Port on the
> root bus at bb:00.0, right?  So when the qcom IP eventually supports
> multiple Root Ports or even a single Root Port at a different
> device/function number, this would have to be updated somehow?
> 
> No need to change anything here; just making sure I understand what's
> going on.
> 
You are correct Bjorn, this is for single root port on the root bus.
when there is multi root port we need to change this logic in future if
QCOM decides to have multi root port devices.

- Krishna Chaitanya.
>> +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
>> +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
>> +
>> +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
>> +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
>> +
>> +	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
>> +	val |= PCIE_ECAM_BLOCKER_EN;
>> +	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
>> +}
>> +
>>   static int qcom_pcie_start_link(struct dw_pcie *pci)
>>   {
>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> @@ -326,6 +383,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>>   		qcom_pcie_common_set_16gt_lane_margining(pci);
>>   	}
>>   
>> +	if (pci->pp.ecam_enabled)
>> +		qcom_pci_config_ecam(&pci->pp);
>> +
>>   	/* Enable Link Training state machine */
>>   	if (pcie->cfg->ops->ltssm_enable)
>>   		pcie->cfg->ops->ltssm_enable(pcie);
>> @@ -1314,6 +1374,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +	u16 offset;
>>   	int ret;
>>   
>>   	qcom_ep_reset_assert(pcie);
>> @@ -1322,6 +1383,15 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   	if (ret)
>>   		return ret;
>>   
>> +	if (pp->ecam_enabled) {
>> +		/*
>> +		 * Override ELBI when ECAM is enabled, as when ECAM
>> +		 * is enabled ELBI moves along with the dbi config space.
>> +		 */
>> +		offset = FIELD_GET(SLV_DBI_ELBI_ADDR_BASE, readl(pcie->parf + PARF_SLV_DBI_ELBI));
>> +		pci->elbi_base = pci->dbi_base + offset;
>> +	}
>> +
>>   	ret = qcom_pcie_phy_power_on(pcie);
>>   	if (ret)
>>   		goto err_deinit;
>>
>> -- 
>> 2.34.1
>>
> 

