Return-Path: <linux-kernel+bounces-646980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58568AB6320
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 08:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7772C3AD73A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 06:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E54D1FECBD;
	Wed, 14 May 2025 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drMN6nqj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06911F4CBD
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204224; cv=none; b=YcQeC8l+BkZJ9VgVkjsKXTOhoNQYi0G+Jtud4AAlHAspweH8JkAbi7gHcDwyyjV8Wh3NTaO5Mu5KVLbpVB4u4A6pz3nkltu2qhN5DQ6nCA8t79URwgN4vP3f8/GAfh9dwIE5AuKi9wQ1Kt+zTB8g1DRSC5bcEgLOZCuTshoMXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204224; c=relaxed/simple;
	bh=4Fu/RdYe0cD2vuBPZ6g0OA+NwElbWIiLpI6udKPtunk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f90YFmcaWnAcN2LUZRRfmVaDSjRXlXmfk52aerLhDr6ljgXCgZxyAABhUluw8/7iXiGbiUzHsN0tBdfnRB83CzEirjSNnIprl9x15CvJj9+nFZxIZCN4ZD/1bYmKjQUQD2r6Jqpu3KhWG6dnqwo70HK+uLpzobdBvxna7LXotSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drMN6nqj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E1d1fs006070
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 06:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3OYdEv51QzKfvKyl8ZgwIQYfMr0WzoPUqWedNGx4V8o=; b=drMN6nqjFRSig3yV
	lDvbbLMYcz3VTLwBtALpmrmgjWr5A7C2sAmiLc0n9G9J3Cb9gZRrbvt2OA9MSndH
	8kEPalU6Wrlkl7vGymmxcj69V074a1+ztfi8sgZbIuVT6J52RKRzv7D9yprM6hxK
	i2NCka/ruOjlQH8AHhLBokDsg5dvMvZ71aB1sQ35yFnbdGx9tSFLLhRJno5g8/4i
	5uahPUKstKk8F+r1jupge0AQ1Xp6E785gcp39Y9lE7KE6+mSyIFMVN5J+xMcyZan
	aws38upccg/H3Eu5bdD3y4N4o4xsBLielPV3xSj6TOoOlAdoPaUzKxiWO2DXlWQ2
	oz5gFQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnsmbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 06:30:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7410079c4a6so4423360b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 23:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747204220; x=1747809020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OYdEv51QzKfvKyl8ZgwIQYfMr0WzoPUqWedNGx4V8o=;
        b=h4qrGSJxcaF91tLexLrNKya8SmQ1ofhcPsFAW2GzMjjL/CV4+CM+YffTPd6HfT+XFV
         B5UnXX49UZ6a7PRNpbt6+8Xi5CmVIl3s/IcHezkiTVJqR5rHUOycMDDiSrb1xKEeiVu1
         pr+BvjG5YbwFWo+gExCsJuIX+qgdqSc2UsWV+CrpHZM5u7A7NlWiDvBJlOq9HkFQKO0s
         GeY1D7XvA2YNsMebx8nPsA7GRwGabu5Vb6xD8PD/wxPMcsCggZ2MrSypgA/FRfVeUBzw
         ALCCYAmWx6PUpyledqv32abbXMxcmHnhkhk4Pd6qDEzdc1Z/1m9UaRZ5gOYBr72LIsHO
         xsYg==
X-Forwarded-Encrypted: i=1; AJvYcCXDGrpJanJCi7dNc2X3nxrZ4FCp3OVMM33CYaSEIKS9ShU27srM05j2ZdOqAzaq6MC+g+OgxCcFg7STlBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydGUoPvpmlyXgA5m8qwCezIhR61Z+EqoCdEJsgLYv6jGQ9w8Lg
	5PtZ6VbBQnKH5OEeP6p/MUAkV3bgBHGB0upMtxVUsBpnSYLz1AJAfaiHaTS7INbojIqKSb5F3EV
	OA/A2o9dr/O49FXnRJ9aVrdLYjbjUsItLLics/xmsw1IXIH5HzeVIm6XlbcveOuk=
X-Gm-Gg: ASbGncutkNGsz9oOHL4wyZXZ3trVu8z2EhuIoNiOjEC1sb/sdzfZPU9QWHX55GM0kFz
	6neR1d1I3nZcRD3E5CKt8xnfBVTL03x62/ALO/C6VaKVgSEXUmvRxG7EhiXy78b4O6KXna4jpvc
	1XLfacwt5Lo1eY4hcWCuB7uUktTEteKBFU8GKphZSGNfJ+t/lMJSb0zjohzvHsFbJ5Vav1a3Yan
	MxHfJgy1I9OXOh1Z5rNpM29aKjcFjUXmNU6ztUxsY7d5wCjauT8hzSlW5zr9NspdJVg0mFJQoaF
	ND4C7yqOgGhWQroww2RikJd9w413CBpJxf7kkrdLbQ==
X-Received: by 2002:a05:6a00:849:b0:740:6f69:dce9 with SMTP id d2e1a72fcca58-7428915208cmr2991301b3a.0.1747204220395;
        Tue, 13 May 2025 23:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo6KctwAue9F+Vx18ACg2bqMflRXZkaB6cash8mo/C9AGwxsZu65dw2flirVj1uPaGevYVIQ==
X-Received: by 2002:a05:6a00:849:b0:740:6f69:dce9 with SMTP id d2e1a72fcca58-7428915208cmr2991254b3a.0.1747204219961;
        Tue, 13 May 2025 23:30:19 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704ba3sm8811721b3a.31.2025.05.13.23.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 23:30:19 -0700 (PDT)
Message-ID: <8006a0ae-b45d-d22f-65a9-20a65f3224b0@oss.qualcomm.com>
Date: Wed, 14 May 2025 12:00:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
 <20250508-pcie-reset-slot-v4-4-7050093e2b50@linaro.org>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250508-pcie-reset-slot-v4-4-7050093e2b50@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ER6QTKTHoU34Bg03KTYUfFwc-665UR7F
X-Proofpoint-ORIG-GUID: ER6QTKTHoU34Bg03KTYUfFwc-665UR7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA1NSBTYWx0ZWRfX7F53yGg0YXZr
 P4IdpJJ62KnzzYEfwDz2UqzOQuflJRvPx/hdKF8PPIOiS9zDYHapXXHeqByBrYHERkCyy1FW05s
 ZavT/L08yur0nIvy4Kegj4SPCnQNjmI8NZBzo69sd548314a59G1c4ZCXphpqK9p85KdOv/ZMKj
 P7SASQ8xUT7fs97uyFc55K2qDrbX7t6BoV8Onss9JboL1BVr3g8Ez1rQLJDUwhq8kZhrMI9DStu
 fnMy5Cgc/2f/vMo5Rjah5Vw1/SwWN/nzzRx21J2i0lNuegmAWpESeVNHVAQhP5JfSXhP8yDn7dq
 m0gHjVOR3y+yQ+ZunXzcR8CdfzY1pDg4eRBWDh5ICnV+fzIHMnc4q0gufv0Ri+rWf8QdO6mLjMa
 BzKd762kUgCQA8N2oCSBmdGIWBlQ7/uqhhhMw/001G4p74mzADWmHgN9Wc1oyV6bSsAkRdu4
X-Authority-Analysis: v=2.4 cv=Gp9C+l1C c=1 sm=1 tr=0 ts=6824387d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=WP6hIalcOMfy4p2eL3AA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140055



On 5/8/2025 12:40 PM, Manivannan Sadhasivam wrote:
> The PCI link, when down, needs to be recovered to bring it back. But that
> cannot be done in a generic way as link recovery procedure is specific to
> host bridges. So add a new API pci_host_handle_link_down() that could be
> called by the host bridge drivers when the link goes down.
> 
> The API will iterate through all the slots and calls the pcie_do_recovery()
> function with 'pci_channel_io_frozen' as the state. This will result in the
> execution of the AER Fatal error handling code. Since the link down
> recovery is pretty much the same as AER Fatal error handling,
> pcie_do_recovery() helper is reused here. First the AER error_detected
> callback will be triggered for the bridge and the downstream devices. Then,
> pci_host_reset_slot() will be called for the slot, which will reset the
> slot using 'reset_slot' callback to recover the link. Once that's done,
> resume message will be broadcasted to the bridge and the downstream devices
> indicating successful link recovery.
> 
> In case if the AER support is not enabled in the kernel, only
> pci_bus_error_reset() will be called for each slots as there is no way we
> could inform the drivers about link recovery.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/pci-host-common.c | 58 ++++++++++++++++++++++++++++++++
>   drivers/pci/controller/pci-host-common.h |  1 +
>   drivers/pci/pci.c                        |  1 +
>   drivers/pci/pcie/err.c                   |  1 +
>   4 files changed, 61 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index f93bc7034e697250711833a5151f7ef177cd62a0..f916f0a874a61ddfbfd99f96975c00fb66dd224c 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -12,9 +12,11 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_pci.h>
> +#include <linux/pci.h>
>   #include <linux/pci-ecam.h>
>   #include <linux/platform_device.h>
>   
> +#include "../pci.h"
>   #include "pci-host-common.h"
>   
>   static void gen_pci_unmap_cfg(void *ptr)
> @@ -96,5 +98,61 @@ void pci_host_common_remove(struct platform_device *pdev)
>   }
>   EXPORT_SYMBOL_GPL(pci_host_common_remove);
>   
> +#if IS_ENABLED(CONFIG_PCIEAER)
> +static pci_ers_result_t pci_host_reset_slot(struct pci_dev *dev)
> +{
> +	int ret;
> +
> +	ret = pci_bus_error_reset(dev);
> +	if (ret) {
> +		pci_err(dev, "Failed to reset slot: %d\n", ret);
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +
> +	pci_info(dev, "Slot has been reset\n");
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +static void pci_host_recover_slots(struct pci_host_bridge *host)
> +{
> +	struct pci_bus *bus = host->bus;
> +	struct pci_dev *dev;
> +
> +	for_each_pci_bridge(dev, bus) {
> +		if (!pci_is_root_bus(bus))
bus here is always constant here, we may need to have check
for dev here like if (!pci_is_root_bus(dev->bus))
> +			continue;
> +
> +		pcie_do_recovery(dev, pci_channel_io_frozen,
> +				 pci_host_reset_slot);
> +	}
> +}
> +#else
> +static void pci_host_recover_slots(struct pci_host_bridge *host)
> +{
> +	struct pci_bus *bus = host->bus;
> +	struct pci_dev *dev;
> +	int ret;
> +
> +	for_each_pci_bridge(dev, bus) {
> +		if (!pci_is_root_bus(bus))Same comment as above.

- Krishna Chaitanya.
> +			continue;
> +
> +		ret = pci_bus_error_reset(dev);
> +		if (ret)
> +			pci_err(dev, "Failed to reset slot: %d\n", ret);
> +		else
> +			pci_info(dev, "Slot has been reset\n");
> +	}
> +}
> +#endif
> +
> +void pci_host_handle_link_down(struct pci_host_bridge *bridge)
> +{
> +	dev_info(&bridge->dev, "Recovering slots due to Link Down\n");
> +	pci_host_recover_slots(bridge);
> +}
> +EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
> +
>   MODULE_DESCRIPTION("Common library for PCI host controller drivers");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
> index d8be024ca68d43afb147fd9104d632b907277144..904698c1a2695888a0fc9c2fac360e456116eb1d 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h
> @@ -12,5 +12,6 @@
>   
>   int pci_host_common_probe(struct platform_device *pdev);
>   void pci_host_common_remove(struct platform_device *pdev);
> +void pci_host_handle_link_down(struct pci_host_bridge *bridge);
>   
>   #endif
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13709bb898a967968540826a2b7ee8ade6b7e082..4d396bbab4a8f33cae0ffe8982da120a9f1d92c9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5781,6 +5781,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
>   	mutex_unlock(&pci_slot_mutex);
>   	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
>   }
> +EXPORT_SYMBOL_GPL(pci_bus_error_reset);
>   
>   /**
>    * pci_probe_reset_bus - probe whether a PCI bus can be reset
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index b834fc0d705938540d3d7d3d8739770c09fe7cf1..3e3084bb7cb7fa06b526e6fab60e77927aba0ad0 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -270,3 +270,4 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   
>   	return status;
>   }
> +EXPORT_SYMBOL_GPL(pcie_do_recovery);
> 

