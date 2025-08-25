Return-Path: <linux-kernel+bounces-783985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016AFB33504
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A14417AA1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A7263F38;
	Mon, 25 Aug 2025 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W34SVOQy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7123CEF9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096011; cv=none; b=Syh0l5E3cbjc+RPpetzEO6qFupn6iQBO4ZEdoLSVeIY0HQU6hnDYdnq7TRxQVfzEXFbcpKJ1SnNOKbzGilAJLtsdjj9y0LbDCQkdFjF5ak55T5kiL4yy1XP5LkNhXI/GBHBLOhecuIakCwdcvEyeFa3bI44fvgr0tBJXE2+on2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096011; c=relaxed/simple;
	bh=a9n17Pp87nFPpPJ8hCwWLrrAUSmfPsMPJ5jQsLaAx2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwVVJCeeEQxsFPpfbR3wjZcAgSceOdVnSb5L59WEhyi1jPI4BuFMdIVQncPp9M2fawHNMNYDm69jwjCPYLx0DwRMyTHg7wFNcLQmy92XjfM2EonqBNDvpmUC2/HMrkQYbZAYKjBH2tKcgS4XS5fyFGd6pIpAVlj8fzt5p3Iv0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W34SVOQy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OLs0YS018809
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NlAwHntaMSF8ydAogxPU5Y3pfmmg9g4CHbeq5yhKSxE=; b=W34SVOQyeU6gWdO0
	zEyPXL3Wwmqhctsg5GjaWEuObLdC7WCfo6InEaRrjFs/1MS/NNMJhic0/9XJC8vb
	gSRa/YBTmUB4irDUIt2nxbCuEAn0jgQaE8h+bvOYCHjVAouwDJOLMI0HGlJF5jf5
	2QTM6CI5gtXWW8R5/ytKbGtGr+8pkce/VovYictTx/SA6h6nJ1igK73GMM7m0ykY
	v0h1vzl9a1+3WEYPODyFo/zKwefTLmiEX6741wYRNdXghaE/WHQiV6Cs15KZAYzx
	Dmjy9oQtMznH96Dbi+UX0L5UhEuKuLWQY+SpsYFBY3zpKvrCPdHb138Ggez7F/0X
	8krrZA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfbm5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:26:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-246a8d8a091so24065565ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 21:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756096007; x=1756700807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlAwHntaMSF8ydAogxPU5Y3pfmmg9g4CHbeq5yhKSxE=;
        b=F5QwE2RZhkibC89Dxoq+FTEDAF9aSP8XWYfor7uLYi56IqxW3jsT9tUTeROG0HIolj
         F2AqaYWlLicoj3fo7CUegjAeofJaeIVJ+sP9THmj6uWsRW1NkuO030YxORMG9AdtOedS
         qL0tBpsHLXZIvvAAocZrOHqjkDd3XcFLZV13lceFsvGYla4Z59GHX3UsBSD5HmuqJtwi
         TeMUS20BOhqkKm42ky4XlzL1G6xepRk1uB24/d8D0r8eRXsd8+SoYSVogID1ui4LEK0o
         S573hhFdflMCxyG4r6SLta2fbVTd5g8oyRcMe/kUdc/zlf3FHyDKW25E7IIynVr4pKvC
         oIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRV1pbZ3S403hAvaQ+GCuCpG9xMDhJ2dg003qTaI+g9Z1d4K3HLTduqplh6xyZfUL7YVh4gFY6ihWP8RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2azA7uDdV1sVzxFMcy7YC65wOxt14G44aVcdTnOKDwlquaUB
	ViDzsKufDXZ1vaT/a5Pac20NiAjpaRebeANoHgbQHGwhkPrIrZ+XI39Z/BQreZWDn4jRl7wUU9C
	J3C7VBtqx/hmOt0OtS6jq7HEFjpEXAy59+HVwQMdp7moAExsser1zFeDSLm3Lvziqqo47ifuklg
	Q=
X-Gm-Gg: ASbGncsPYoT7wbtgMUl9nHCXEk5LCOhk6+p8k9Zo5mZFSOrpXixVgadb6chVEQ+z58F
	tLwE3OflRagLPSBddZuxiK7s5qhZ7B3yc8L/VspdJGNb6nTFQZ6nQwVtU0d3DfQoZWmRlhmSiao
	aDobXcwuBYqIL4inWjO5zT1Z9STuKIJTa1VavNYUaTHsdxQeif7i9tRsIX9kL2SiBdoxMrybbFl
	WANG1gYlpNLwMFsJ8K27ZGjnJSF7Bf+vGai86bQsCK6JOc4+O62tZhKxovCIJBP2FG+icv85P4g
	8fxo48xyU3cyF0Hno/a36oHWOIhBBmdaS/5Cafyb7qb2vzV0Cm+sQQ/Omf//yE26Ky4Z0NRgtA=
	=
X-Received: by 2002:a17:903:3805:b0:23f:e869:9a25 with SMTP id d9443c01a7336-2462ef6a8aemr135591495ad.44.1756096007450;
        Sun, 24 Aug 2025 21:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHixQBbnc0DdWGq6Af/ITt7Ss76QxVat1WmepXEy8SewWASn4eLQ0Rvbb4Y5+B07Zee/JGJZQ==
X-Received: by 2002:a17:903:3805:b0:23f:e869:9a25 with SMTP id d9443c01a7336-2462ef6a8aemr135591185ad.44.1756096006976;
        Sun, 24 Aug 2025 21:26:46 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880368sm54939105ad.109.2025.08.24.21.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 21:26:46 -0700 (PDT)
Message-ID: <7deae6e0-44ad-4b2c-9657-e83ffc77b4f7@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 09:56:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: qcom: Use pci_host_set_default_pcie_link_state()
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
References: <20250823-qcom_aspm_fix-v2-1-7cef4066663c@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250823-qcom_aspm_fix-v2-1-7cef4066663c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX2BO+QkUfX+Mt
 UdEAy9+BgHLGkUlm2vdyHAvrKJg0hZ6n6udBjxN+br4CodtjWu0FSSTclZkqgUAgO7tXgjm/+4T
 U/SEkbmPzGi1SM/k89rqCi7iMMxUqrTFTwRJDTXFOX2ykdLJLAzzD30RBwIs3UUzkFDn8HOdBTQ
 BbS3Nf6/MR2wNQ2NytrERin2pZNVtLiFXG0FydsY8W6Pk2GyODn8k8/ZmhToU5BRPfJ3Vfh76Wt
 W7qQ4CbCJKzOwu6jZQoq1XziC1yhz0ZsugR7nUVHQw261H3h7E7SlxUbwnQxjmbXVXO6gUJXivN
 5p3oM+HGe7KnsdWR2f6V5zH0y5bbqC+LHHRtVQ1+yQy5Eck0boFKm9wZGlCFDU2EEtVGlM6ADeD
 Xq+eqJVI
X-Proofpoint-GUID: msUZR0QvjX1NB9IMTOb1V0uN7BoJi3B0
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68abe609 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=dzoEsyrRel7NccpsXiUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: msUZR0QvjX1NB9IMTOb1V0uN7BoJi3B0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/23/2025 11:14 PM, Manivannan Sadhasivam via B4 Relay wrote:
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
> ---
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
> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..71f14bc3a06ade1da1374e88b0ebef8c4e266064 100644
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
> @@ -1358,19 +1338,9 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
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
> @@ -1432,7 +1402,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>   	.get_resources = qcom_pcie_get_resources_2_7_0,
>   	.init = qcom_pcie_init_2_7_0,
>   	.post_init = qcom_pcie_post_init_2_7_0,
> -	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>   	.deinit = qcom_pcie_deinit_2_7_0,
>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>   	.config_sid = qcom_pcie_config_sid_1_9_0,
> @@ -1443,7 +1412,6 @@ static const struct qcom_pcie_ops ops_1_21_0 = {
>   	.get_resources = qcom_pcie_get_resources_2_7_0,
>   	.init = qcom_pcie_init_2_7_0,
>   	.post_init = qcom_pcie_post_init_2_7_0,
> -	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>   	.deinit = qcom_pcie_deinit_2_7_0,
>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>   };
> @@ -1979,6 +1947,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   	if (pcie->mhi)
>   		qcom_pcie_init_debugfs(pcie);
>   
> +	pci_host_set_default_pcie_link_state(pp->bridge, PCIE_LINK_STATE_ALL);
> +
It is better to call this before starting link training, if the endpoint
is already powered on by the time execution comes here link enumeration
and ASPM init might be already done. This might not have any impact.

- Krishna Chaitanya.
>   	return 0;
>   
>   err_host_deinit:
> 
> ---
> base-commit: 681accdad91923ef4938b96ff3eea62e29af74c3
> change-id: 20250823-qcom_aspm_fix-3264926b5b14
> 
> Best regards,

