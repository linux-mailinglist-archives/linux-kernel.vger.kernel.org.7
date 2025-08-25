Return-Path: <linux-kernel+bounces-784287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE33B33982
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE7417A09D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535302D5A01;
	Mon, 25 Aug 2025 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gBLsDGoq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856AD2C0F92
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110878; cv=none; b=E5nBQcMTX3t/XNi+FENGd/Ylt5U8aiV6wMCj1wRVzvBTSqEhGZROLLCLGm7CkJO7wDVsShupTfVZ2WNpc9IaDQyARrVM6fHmt9snUs1UXPeskbyxqV0US01z8IU016Q0R54tU6Fh3kNti5y6l2ffWKYmht2CyKS1kxQnUP9jGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110878; c=relaxed/simple;
	bh=gEsEg64VijZ/pTtad733OV7S7W1NORMwb8cQ0DXAEp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cktO7aM40I5uQpa5GoTugS7+8gU1JmuKdINmxSFydRtPwh/dvH++keyNQc4KOepJEsiMpn8WuiuZYcZvH4uO9CJ4q94PDq/QuBksEJ2GyPOzdRAdUiXcz8Pdmvr7fbnteZRDaESh9niPYZzedGtZ2X6QW1kHkDV8K/2JbkOsNlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gBLsDGoq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8XFO5009700
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5WdVS1PidWtUzr3BYuRhDZBH122A8Dffpl49SOKSaHo=; b=gBLsDGoqZqt7zEcQ
	p+ZsLj3dGgw/sR1k8ZNtGC6+CMfdRAdA7+jN9qOZEEu0Cr9mSBOfFZ1ijkXAspaM
	+7/Upe1qOnzbdKmtvZXBpqixPSnfoSuQ17PAgsTw2rLq4xwaQzRkMwad5Ug/YkD/
	dEdi7Xh5RLdpE6B/TTSIDHbNCI/+A50if8SILz+wekvLH0Chf5Yzjs2kB/0Xvjqm
	Knnmtbuhl8OGz0xbT8HVEVYot6m8eg+XZvCpLVVp5/njjQf49znqsv4GNfaziTW6
	d67oisB4PtMrTUj0aUSkM6t0RrEsRHDjWgWVM2Jg0ezZsL0/+G9G96m8lSzxgyDU
	3mknPQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2mg3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:34:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-246cf6af36dso9381035ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756110875; x=1756715675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WdVS1PidWtUzr3BYuRhDZBH122A8Dffpl49SOKSaHo=;
        b=DiFU9t80aN2BBQ0VbJLLEGP1m87ncx8LG87xJX1MpvD04tD0Phxmry2ciORTb3TCgi
         UHT8qpaJ4orn8pQndS2nDF6EW9q/NhkffA7aTta9EFwx34DVZaO7hIt4Cwbfg/ALUz5G
         GQQT3lNC60m4UY7Rz5drf0JCOdD1vIDoV2d9yfS9v/mo9LwLvUK0BCbu7Dc06EcrzNsY
         fpgB9rBJ2X5x2BI9yZkVmITofxvCSUh67Nus6GoPAjH3PIAm5SAly6fkfWaI9Tu/60tS
         TJ80k0oFgesb0tt4NFn7Fwrt1ZvIOKr5iVO7GSLR4d4xozB8H+Ni15bRYAPivMXTxdeo
         whtA==
X-Forwarded-Encrypted: i=1; AJvYcCUzxyViBD7/H4036shMUe39xysaQf+WjGpRkZvSatGcTNsgsa4CAA1GbeY0njT97UhWA5Nb1SSswMgZ634=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqsh/SHYapTsW+aCDX/Dy/8v191G3qPgs1VWYiDdfqRxeCLiXP
	4SjnHVkr+6OVLOOGq+DIm62HieGbuaTvrsE6sxADYG5ZO4om/lNvIqmdVHPdmJtPRhSxepeTCb1
	RD7+zdHAyXt5ASG5QnVMnFH8WExI+JAtUIIqykYl4vNWdgTY7qECfl3rAobzvYnzH7NE=
X-Gm-Gg: ASbGncvYorBJNu7Szz5l+afzNzm67SkSBW7rwesv3aWC0KmEsrEV4wRBByirSaZNO+S
	2zUx5Le/IARbRxfz22L977F3Yvv3LmszL7SP9inRsnnqGNDw8OLLXOKoxdf/pMsIBzgNRnjJGxE
	SaoJ4PQEjgDyFqWQMeTRWWlWz43tmifgFeo6hF7W9EuW2H/5CmPQE8gsTKiGKk7M6hpVUY+jNWH
	AVZ8rPqnIOA62ZBJzg7hm2dil8j5UTX8WAZb5oD5jyZre67uA28zF8ZPJYF8PxWSoIWpMmZDSgh
	29MJLka9J6/9ZE+wjrX1pXS7BeoISjBuan08c8P+zdQ3m6wKUYlN2cZ+QynoCMmatKGpxoqQ
X-Received: by 2002:a17:902:f64f:b0:246:9673:70a with SMTP id d9443c01a7336-24696730b7bmr60715585ad.13.1756110874743;
        Mon, 25 Aug 2025 01:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsaJeEk4MkiKQ0XmlLCSFVZmi71JUVovkgjbQWRrwLYYGlkOS8fK+M7e3A/GaOsmbYQmBsmA==
X-Received: by 2002:a17:902:f64f:b0:246:9673:70a with SMTP id d9443c01a7336-24696730b7bmr60715255ad.13.1756110874227;
        Mon, 25 Aug 2025 01:34:34 -0700 (PDT)
Received: from [10.92.199.10] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324fb2fee00sm4973089a91.9.2025.08.25.01.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 01:34:33 -0700 (PDT)
Message-ID: <c68046c7-24fc-4877-9493-3a40c952e2d0@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 14:04:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: qcom: Use pci_host_set_default_pcie_link_state()
 API to enable ASPM for all platforms
To: manivannan.sadhasivam@oss.qualcomm.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David E. Box" <david.e.box@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, stable+noautosel@kernel.org
References: <20250825-qcom_aspm_fix-v3-1-02c8d414eefb@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250825-qcom_aspm_fix-v3-1-02c8d414eefb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ac201b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QyXUC8HyAAAA:8 a=-SNkuYFjfyYS1ayC9ZUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX8hIu78+M8KF/
 UaiOivJkPWQbCbNFV/ASQlbd54+939iEKeO6JoR7Ak7xniXIoITiFJEsQb9PlZcBQO6Z2yl2d4Q
 7Ht1/+SZwCDdKtzQlbXTSap56F6uMECvMEQuQe1KIylQxh+V1yplCWGy6yApmmEyXIMjR1zHl00
 Jx80NI/TsY0HVNSEDW5bEGAWpNKnnvbj5oT9v+eej4+9k8fPaBsqjpDe7w6ELSnNFRLRkW5QIC1
 2CvzKMYZa0DsUlgatwngCrW5GG15aEc0KKBqHAP5ddndSFwV13UlPEjuJQxqQS41zpQa+zjGRkw
 fHCoJwhahsluB7QP3+4X9RPf5Nr7+jhlG1Dyntvrxbf+CLmgT/S/+bOZDyCuGQNWmpVX62OH37r
 pi0r2DXW
X-Proofpoint-GUID: gRIoUfC1OCGUGwAcdqTTcR-uW0Pfndb_
X-Proofpoint-ORIG-GUID: gRIoUfC1OCGUGwAcdqTTcR-uW0Pfndb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/25/2025 1:52 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
> ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
> enumerated at the time of the controller driver probe. It proved to be
> useful for devices already powered on by the bootloader, as it allowed
> devices to enter ASPM without user intervention.
> 
> However, it could not enable ASPM for the hotplug capable devices i.e.,
> devices enumerated *after* the controller driver probe. This limitation
> mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
> and also the bootloader has been enabling the PCI devices before Linux
> Kernel boots (mostly on the Qcom compute platforms which users use on a
> daily basis).
> 
> But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
> pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
> started to block the PCI device enumeration until it had been probed.
> Though, the intention of the commit was to avoid race between the pwrctrl
> driver and PCI client driver, it also meant that the pwrctrl controlled PCI
> devices may get probed after the controller driver and will no longer have
> ASPM enabled. So users started noticing high runtime power consumption with
> WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
> T14s, etc...
> 
> Obviously, it is the pwrctrl change that caused regression, but it
> ultimately uncovered a flaw in the ASPM enablement logic of the controller
> driver. So to address the actual issue, use the newly introduced
> pci_host_set_default_pcie_link_state() API, which allows the controller
> drivers to set the default ASPM state for *all* devices. This default state
> will be honored by the ASPM driver while enabling ASPM for all the devices.
> 
> So with this change, we can get rid of the controller driver specific
> 'qcom_pcie_ops::host_post_init' callback.
> 
> Also with this change, ASPM is now enabled by default on all Qcom
> platforms as I haven't heard of any reported issues (apart from the
> unsupported L0s on some platorms, which is still handled separately).
> 
> Cc: stable+noautosel@kernel.org # API dependency
> Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
> Reported-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

- Krishna Chaitanya.
> ---
> Changes in v3:
> 
> - Moved the ASPM change to qcom_pcie_host_init()
> - Link to v2: https://lore.kernel.org/r/20250823-qcom_aspm_fix-v2-1-7cef4066663c@oss.qualcomm.com
> 
> Changes in v2:
> 
> * Used the new API introduced in this patch instead of bus notifier:
> https://lore.kernel.org/linux-pci/20250822031159.4005529-1-david.e.box@linux.intel.com/
> 
> * Enabled ASPM on all platforms as there is no specific reason to limit it to a
> few.
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 34 ++--------------------------------
>   1 file changed, 2 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..0c6741b9a9585bd5566b23ba68ef12f1febab56b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -247,7 +247,6 @@ struct qcom_pcie_ops {
>   	int (*get_resources)(struct qcom_pcie *pcie);
>   	int (*init)(struct qcom_pcie *pcie);
>   	int (*post_init)(struct qcom_pcie *pcie);
> -	void (*host_post_init)(struct qcom_pcie *pcie);
>   	void (*deinit)(struct qcom_pcie *pcie);
>   	void (*ltssm_enable)(struct qcom_pcie *pcie);
>   	int (*config_sid)(struct qcom_pcie *pcie);
> @@ -1040,25 +1039,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>   	return 0;
>   }
>   
> -static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
> -{
> -	/*
> -	 * Downstream devices need to be in D0 state before enabling PCI PM
> -	 * substates.
> -	 */
> -	pci_set_power_state_locked(pdev, PCI_D0);
> -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> -
> -	return 0;
> -}
> -
> -static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
> -{
> -	struct dw_pcie_rp *pp = &pcie->pci->pp;
> -
> -	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
> -}
> -
>   static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>   {
>   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> @@ -1336,6 +1316,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>   			goto err_assert_reset;
>   	}
>   
> +	pci_host_set_default_pcie_link_state(pp->bridge, PCIE_LINK_STATE_ALL);
> +
>   	return 0;
>   
>   err_assert_reset:
> @@ -1358,19 +1340,9 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
>   	pcie->cfg->ops->deinit(pcie);
>   }
>   
> -static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
> -{
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> -
> -	if (pcie->cfg->ops->host_post_init)
> -		pcie->cfg->ops->host_post_init(pcie);
> -}
> -
>   static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>   	.init		= qcom_pcie_host_init,
>   	.deinit		= qcom_pcie_host_deinit,
> -	.post_init	= qcom_pcie_host_post_init,
>   };
>   
>   /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
> @@ -1432,7 +1404,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>   	.get_resources = qcom_pcie_get_resources_2_7_0,
>   	.init = qcom_pcie_init_2_7_0,
>   	.post_init = qcom_pcie_post_init_2_7_0,
> -	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>   	.deinit = qcom_pcie_deinit_2_7_0,
>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>   	.config_sid = qcom_pcie_config_sid_1_9_0,
> @@ -1443,7 +1414,6 @@ static const struct qcom_pcie_ops ops_1_21_0 = {
>   	.get_resources = qcom_pcie_get_resources_2_7_0,
>   	.init = qcom_pcie_init_2_7_0,
>   	.post_init = qcom_pcie_post_init_2_7_0,
> -	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>   	.deinit = qcom_pcie_deinit_2_7_0,
>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>   };
> 
> ---
> base-commit: 681accdad91923ef4938b96ff3eea62e29af74c3
> change-id: 20250823-qcom_aspm_fix-3264926b5b14
> 
> Best regards,

