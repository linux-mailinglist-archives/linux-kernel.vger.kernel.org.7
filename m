Return-Path: <linux-kernel+bounces-816208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1DB57109
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451BD17189F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE82D46A1;
	Mon, 15 Sep 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGcuCdqg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564361D130E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920699; cv=none; b=ApjUDVmrPZHGh0AnqPeBekwmuSuxemYte2EvQmGtb42tXMgnuEZWT+yRui42Mt75FjHTAjhV4myQNDSwv40vienUNG3KhbmVRJ3zGKplfLU3NlEp/oVe6ThpdveyCIvdC5f4EuGmYlnJnpvV9gS3xxMHrlTJ/UKPLEdq3btNQdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920699; c=relaxed/simple;
	bh=nAsCYTXGf9eOH9DqKr7uy1RsKThIOBKqKGJ3mluvl2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oi31+CSPDpRqwAsc3GYu+1vtazBSGJ6S66yV0FQC00er3zi/J950lDevNF78SxpEUmV8SC3aLqmFQM6PF6CoT1x3id0MSbmGYJALl06i75gQsy3nfy95u8Ofs0U2qyourqd89fqeKdKPfzAijukFmH/J4ozJ7euc3CCHT+vCXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DGcuCdqg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F7I4gH014249
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	az5/tFhF9OYwOyEXfh7D3P2lxslrh49EA4QJPqQZJr0=; b=DGcuCdqgF6rk1a17
	x5XwN3MmoNdmAa9ZNlDYIZ7CFN48sDZkWQmv3olOWrY65Wfwueaho7oG59YArUs4
	GLAzd7G4YIsI9menK0IiHYCsblGRC1e1gBDM/dctWGsJcNrJAH4uid0qCybzHltN
	es+PhX3+Zi7ePvaJVUomoFYAqPgXovGJFUGnwQiTCeMINgYlblAi7e06U+oAJyvM
	4zxAzCVzBPOaGERh6DlmR3oy3ruDcbDybT4HAdn2N92y2lh6qONiXAMdzdpi/TPA
	MCSOs9AHi+LLYj/6dXVFZpymDFB/ImwZx9mPSAvSYOHyHJZFKejinPzZDeL5uXkc
	7d1kvA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da985xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:18:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77288e1ce43so3414111b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757920694; x=1758525494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=az5/tFhF9OYwOyEXfh7D3P2lxslrh49EA4QJPqQZJr0=;
        b=bWfMfcb3lhB2+WImPWpzWS+PfyC5+3LuetL8DFW/g9/vS1ZG0SdI8iwyje5B2jAQ3k
         n/kz9lLqyPG186PKFM/X5Pd9HNOeM05hW7SxcZhfd09Mj3gkFfJ2z+3UpxShBahdQ0lb
         GPL0wqdReHoeHgK8ELrYHw3ctW8Mz1xHESvswEEanzXn/tp4+haMnx7oDT2+2BoINOJS
         39MJnQwwxW49tb26wUIF3bDhYpccFSW8eXT7gtTr4fms/XuvHXaJpM3FsGJfK3IZN6CX
         Nvdi65bK02S/TzQeXERMRrnVrkzqs8eT5gX235+jmzgFw7spRLm3olhNmoDh9W/+JuFk
         hoiw==
X-Forwarded-Encrypted: i=1; AJvYcCV4y1RI7nDJeuMe2a/qssmK1Lgb8w+hR+5tHsSFVbPpRUXhaq0/r/xUiWpH+hpDh5zQdRh02m+9CxOhChs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPM5koHtE8ME07iFpjnFtkpKw30VvwtZUWv/F4AOcn4fzD/iJ
	X6fdUKj/F+zOuXodbC/qVVj58ZRrMh56tJOT8B+UUGb1WCB0Fr0OmhoR+v+eMzrtv5+NeMqYsbz
	tYDtOPI0ESfJNy5st33cugg9b6BdT7bUHasS3tA0NR3Vx6IsIds+XcbWTG1yER0uW5oA=
X-Gm-Gg: ASbGncs5uoGONbBkJU0siwgLPh7tU3V7ZzR7obgKmV8C4rKCviLkxWFZkmhbl6XDDU4
	rUf7k3kcQYOJ+ZD7ilmgFI1OfLg8d4c5nNGVNwYHRoCuwV9fh9P8E63dzdBB1GSTQUkH0xjn0wY
	1NA0Z8tBjjVRrUGIFxu35601cqitUUVmCJrwLJwwjXPMRfTSz2tkXKg3tduTcV9NjJdb8q2Yyzg
	8udeearsRhM+EezAAfIahT5S3BpcYRLzJQUs1NU5WFU7xD3yI6wN0IwPM1Gw59YLs6nZygXnqV5
	vH3aMQ6nqAM38u+nxZU/hqhcS49RE3d8o7Hubg7fRlPzatVqpsAegWpjMSSbrkaDtHJnXrcQgA=
	=
X-Received: by 2002:a05:6a21:32a7:b0:251:e4b4:7a37 with SMTP id adf61e73a8af0-2602a894843mr15205979637.19.1757920694542;
        Mon, 15 Sep 2025 00:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv532VEINyJKzuRlK20kwmlZeepldz6c/cEpUCjiPLpOVLguw7I7OkWPk+IJShxhNAMoygCA==
X-Received: by 2002:a05:6a21:32a7:b0:251:e4b4:7a37 with SMTP id adf61e73a8af0-2602a894843mr15205936637.19.1757920694038;
        Mon, 15 Sep 2025 00:18:14 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b18400sm12317233b3a.59.2025.09.15.00.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:18:13 -0700 (PDT)
Message-ID: <d12e002b-e99e-4963-a732-4873e13c5419@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 12:48:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] PCI: qcom: Add support for ECAM feature
To: Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250912210756.GA1639208@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250912210756.GA1639208@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c7bdb7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=IE8jCCfkdm6DJ3MH_s0A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: fUQZNHY8plulCFymhxSSXdBL2PAJa9h_
X-Proofpoint-ORIG-GUID: fUQZNHY8plulCFymhxSSXdBL2PAJa9h_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfXzQxsssAxBa9j
 +D3RJwY3SfROP5KRn2jWRI2j+VOyTZkVd2TLEwwC7LyhR3UB+A9Awp3a4u1xDSO0v29pDx9WXv+
 tyXABJtx1kUgYQPumM2ZTxnUmIwZn1UYhFLJNzat9CpJ6aOwJ1fm3D9DlAxaaKZtxLeNbpGPQ54
 63i3E0EeSECBRq4THRYzFJkHOmlqYF4Z+mWXgtPWFZy7QDG91/yTrUBqQvjBngcdWeErrmukQQG
 VBbHwprd4d+Fzn3ZlVOmvcJHhlkrRCoxb+3eLs4suynIhqshq6cKPC2xJvA5Sd/9n0ytQJwKkoA
 b43tSZmbGfKMGOEQTH1MHO6bUE4t1KoFzBwtl4ZCt4vPrbAji9vCYhHHd/NWJCfP2Z51/b94tUz
 5G8J7qMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056



On 9/13/2025 2:37 AM, Bjorn Helgaas wrote:
> On Wed, Sep 03, 2025 at 02:57:21PM -0500, Bjorn Helgaas wrote:
>> On Thu, Aug 28, 2025 at 01:04:26PM +0530, Krishna Chaitanya Chundru wrote:
>>> The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
>>> gives us the offset from which ELBI starts. So override ELBI with the
>>> offset from PARF_SLV_DBI_ELBI and cfg win to map these regions.
>>>
>>> On root bus, we have only the root port. Any access other than that
>>> should not go out of the link and should return all F's. Since the iATU
>>> is configured for the buses which starts after root bus, block the
>>> transactions starting from function 1 of the root bus to the end of
>>> the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
>>> outside the link through ECAM blocker through PARF registers.
> 
>>> +static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
>>> +{
>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>> +	u64 addr, addr_end;
>>> +	u32 val;
>>> +
>>> +	/* Set the ECAM base */
>>> +	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
>>> +	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
>>> +
>>> +	/*
>>> +	 * The only device on root bus is the Root Port. Any access to the PCIe
>>> +	 * region will go outside the PCIe link. As part of enumeration the PCI
>>> +	 * sw can try to read to vendor ID & device ID with different device
>>> +	 * number and function number under root bus. As any access other than
>>> +	 * root bus, device 0, function 0, should not go out of the link and
>>> +	 * should return all F's. Since the iATU is configured for the buses
>>> +	 * which starts after root bus, block the transactions starting from
>>> +	 * function 1 of the root bus to the end of the root bus (i.e from
>>> +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
>>> +	 */
>>> +	addr = pci->dbi_phys_addr + SZ_4K;
>>> +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
>>> +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
>>> +
>>> +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
>>> +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
>>> +
>>> +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
>>
>> I guess this is an implicit restriction to a single Root Port on the
>> root bus at bb:00.0, right?  So when the qcom IP eventually supports
>> multiple Root Ports or even a single Root Port at a different
>> device/function number, this would have to be updated somehow?
> 
> The driver already supported ECAM in the existing "firmware_managed"
> path (which looks untouched by this series and doesn't do any of this
> iATU configuration).
> 
The firmware_manages doesn't use dwc way of reading/writing to the
config space, except for MSI's that doen't touch dwc core.

> And IIUC, this series adds support for ECAM whenever the DT 'config'
> range is sufficiently aligned.  In this new ECAM support, it looks
> like we look for and pay attention to 'bus-range' in this path:
> 
>    qcom_pcie_probe
>      dw_pcie_host_init
>        devm_pci_alloc_host_bridge
>          devm_of_pci_bridge_init
>            pci_parse_request_of_pci_ranges
>              devm_of_pci_get_host_bridge_resources
>                of_pci_parse_bus_range
>                  of_property_read_u32_array(node, "bus-range", ...)
>        dw_pcie_host_get_resources
>          res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config")
>          pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res)
> 
> Since qcom_pci_config_ecam() doesn't look at the root bus number at
> all, is this also an implicit restriction that the root bus must be
> bus 0?  Does qcom support root buses other than 0?
> 
QCOM supports only bus 0.
>>> +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
>>> +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
>>> +
>>> +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
>>> +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
>>> +
>>> +	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
>>> +	val |= PCIE_ECAM_BLOCKER_EN;
>>> +	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
>>> +}
>>> +
>>>   static int qcom_pcie_start_link(struct dw_pcie *pci)
>>>   {
>>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>> @@ -326,6 +383,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>>>   		qcom_pcie_common_set_16gt_lane_margining(pci);
>>>   	}
>>>   
>>> +	if (pci->pp.ecam_enabled)
>>> +		qcom_pci_config_ecam(&pci->pp);
> 
> qcom_pcie_start_link() seems like a strange place to do this
> ECAM-related iATU configuration.  ECAM is a function of the host
> bridge, not of any particular Root Port or link.
> 
There is no API in pci-qcom.c related to the host bridge configuration
currently, as we want to configure before enumeration starts we added
it here, we can move this to qcom_pcie_host_init() if you are ok with
it.

- Krishna Chaitanya.
>>>   	/* Enable Link Training state machine */
>>>   	if (pcie->cfg->ops->ltssm_enable)
>>>   		pcie->cfg->ops->ltssm_enable(pcie);

