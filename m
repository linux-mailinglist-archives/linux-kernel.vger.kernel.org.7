Return-Path: <linux-kernel+bounces-885730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D8C33C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16C354ECD53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B303122D7B1;
	Wed,  5 Nov 2025 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EHeQhTrm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W39tpCEq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6B156F20
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310449; cv=none; b=ivYOoYenw/VGuMUEpJ+r1tswoLVTBfOXWIcgj9itfJR8UPbR6Ikvwdo6N7+hiAq2HgfuXv/QCzLPh9sLa6VJi0j1kSMGlXOy/Kd8dVT+EAMW+mRzR4og/FQmYsmHbjy7Yp0/Qd6+9Njd7c67q5wNZiAwOvP9v20d7I0FMeiL1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310449; c=relaxed/simple;
	bh=RzMk9aGtgDnb8dEWeT0ZQN/emHdjcDFr8OHuEyRsY0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4qCzF00oEA85xttqJOwOrUEPtlG7sDHx5wZoWkMH8LdCStExlVmAiEvldhFFl8XOp4cGE96mGK+jLFYEGwtik4anXTpOslJGUO9DUkPAoaCgwld+gi9jULZTZ9wiNQslJaxVUkwBeK74yqGl9jLO7JN7obSXJYq6JhWqfQtIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EHeQhTrm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W39tpCEq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Kg2EQ2904473
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 02:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z82SbUtYiowhkxe7KgzgwLjWQMrm7JLfiBO5E0UsegI=; b=EHeQhTrmpw09NDfx
	4muN/DAkeBwYbImq0BluHCo9G0IjWiXdviFtfODZiYFWYxHaw+DvRC92mNfJAwJi
	6I7lruuckhjJNEf1Hsr2DT4Q3a5E6KRfTklUrqSswEmc7odC3HU1pN0tY/3sWu+k
	ip44eTRjY1oPUDVaztRH/gxOlrCuhpea3/HH364rrNXKHjVav4DipFD0tNtTD31b
	5CMgNYFhj6o8JZjVui+s+P0VhJ84Mu+IytCdDFqVC93/8uCXmS+Mhv0Hrk0SOsGZ
	8WHZU8JrizA57AO4FhbEgWT8gNo9jXFP9+w2DPbI9Y8Sx5XEp+ZovUCP44T6b6Au
	ff6DUw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7mbbssp0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:40:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so9635347a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 18:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762310439; x=1762915239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z82SbUtYiowhkxe7KgzgwLjWQMrm7JLfiBO5E0UsegI=;
        b=W39tpCEqN53SRGMhtDItS+TxLRcwB6iTEXTBbkYpzeVck5LAybGJiqC9/HPrGiR7sF
         bs5WImkkNqxQHsDyYR0PCD1Mbfd4D4q9oCwRZVomy0NNdMqMQxMaAqWGLWtskFYDkz4K
         5SnEFN0xp5+lwrJGhW59KdCIQlzwjVKe1mONItBJ1I0i554HCscausKQv9a8qyq9bipZ
         tsku6o8e9bJ+tJGWnx7gzX/tWMpSpYIg5/18s6AxCUL3hsRWYJJirTggi2r9x7W37jev
         Tj26IMf3EIE7xw+VzaMBRwqZTTyPsC107WZ20QixV28hMLp2URb2cKDd7R215Us7tOx9
         V1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762310439; x=1762915239;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z82SbUtYiowhkxe7KgzgwLjWQMrm7JLfiBO5E0UsegI=;
        b=AF47jvNbhvy8GfqJ0j1okb8IPNR2Q68o9IxUzqaZqp6TNQme98B17mnus2M+VtDdJI
         n8Doz8B0LNSKhnbMytjmfO+F9l0xLyh4LqNWsLgSeWTkHxjP5mme2IWK2h3jEgDEfc9X
         kwkWB2RLlR6K+Tcnp93biVbzZ+VY7k0P9N0qJYkPrwvPt5zBvn7q6/AGGlLRlR4jFpb6
         +Twczd8Elb8ZFm+7dPUUM8OziIgg+KsFK7KO9NhHeGHUbTps0MiwSuKTFrCTqs/1LvGT
         eLspGednvVs3qbHJ3ysrF6zFgpJepYp96p3j0mPr8vHkXuwo2Xnxad/3zxKQOdfUEh4c
         Z33w==
X-Gm-Message-State: AOJu0Yz9ctRxbycHA4zMg3HJa50QgqsWb1yyfMdajZVm5Bh7UbrkMmda
	ZKmedZsbWY5vfi86SqvOUC9PtLJij23NeNzIUo2Rocw2ShC3aa9IdbnEcCLsDgh5FBlWt19qixa
	+zrj2Ifau3KIVKUQIYM/B9/VITzdakyh8FvuootoVaLkcibwk1IJ83YEU6JEUoSz/QiU=
X-Gm-Gg: ASbGncs0U3HJvqEnreJ9bQXkRGdbSLuoNo6vhUNAW63h0CEdQQQNq1f1tBs2ehqNm9w
	zxMsBHSY4Bm21nlcGdJPXU3tqdSOwPOKDjN4ZLFCFDtzDAehz/T3OmGyAiGVklqGoUcjGZL7gtQ
	1oI5OvU4yJHKnhZXHwW41VJP/QKk+4MeGeuzRMm51WsSwegNpI72UTk5VaKHEiQ/9179cIfIa0Z
	87351lEEkZbm2Eqt7buXTocmWaHgK1Jo/nIL1VEVLN1FwCE5PbW26LJ2YjrxRJIDJvAfgaFnl2z
	M6faisuyxH6fhGBdjt6OglLpSSVokiv6YaQUj7hWCK64U8MSxxa6tfkkgc+lCAlIShRGGGzbEog
	qVSdnEKmgGLgX4qHCgb1O26djBI6qt2n+bA4HufZAiaQmgZLrWSPsdl7MUjddHM4dmKFOo40=
X-Received: by 2002:a17:90b:3c08:b0:340:f05a:3eca with SMTP id 98e67ed59e1d1-341a6dc4b17mr1965628a91.20.1762310439056;
        Tue, 04 Nov 2025 18:40:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDuWiRwazftd6t2s4wdBPAp02THBe+Zs4XUJxxyHZqsHdFitgl1KE5K/oEAKb/kWJ93nt93g==
X-Received: by 2002:a17:90b:3c08:b0:340:f05a:3eca with SMTP id 98e67ed59e1d1-341a6dc4b17mr1965610a91.20.1762310438491;
        Tue, 04 Nov 2025 18:40:38 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba675d384f5sm121115a12.27.2025.11.04.18.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:40:38 -0800 (PST)
Message-ID: <809038ef-dd0b-4b42-9357-f4f0825a4857@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:40:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 1/6] wifi: ath11k: Add initialization and
 deinitialization sequence for CFR module
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
 <20251104162633.3007874-2-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251104162633.3007874-2-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SshhmV8waJ-rTmVYdB-gSTdvmL9jgwdQ
X-Proofpoint-GUID: SshhmV8waJ-rTmVYdB-gSTdvmL9jgwdQ
X-Authority-Analysis: v=2.4 cv=MK1tWcZl c=1 sm=1 tr=0 ts=690ab927 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=9cJcMz6cYvtNARQ-iUYA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxNSBTYWx0ZWRfX/gbdDGNstIcC
 xDh26TnUBq9Z+JjS0KWeVY56kd0bSDEVpLU656eF7VvECPX9D8YBwKx6qQHV/7ninnurowLvkkg
 l2AKoymkG9phdBX7TFfSCaYNZYUsrKZT4j0WXzWY8nrNtSmxQXfcjj78AkPAYJ4DfDctROcDtU0
 WFnSCaxjfKMgKKmHu9qqcO9oZf3a8/6OaEC9LMQmFwaSScJsGenjgMrB2wKVTek8UYNp/B2K8fC
 +88XysRle8RdEmbRadY9F1rBKAxm55jDcQFZmAtM1nx4BnuI/L+LYkBfy/Vfd99w9UVGpJqB8iy
 m0toWwD7za7KCysZ15dtOzvy6FFAbx4P7jf2r6vuBIT+7htYDks2WrBFkyXNeb9pDAlfvp7bkie
 b0NYse3hU67lxWZxWYHud9dMldjuWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050015



On 11/5/2025 12:26 AM, Yu Zhang(Yuriy) wrote:
> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> 
> Channel Frequency Response (CFR) module will be initialized only when
> the following criteria passes:
>  * Enabled CFR support for the hardware through the hardware param
>    'cfr_support'
>  * WMI service enabled for the CFR support
>    'WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT'
> 
> Also, provide a configuration option CONFIG_ATH11K_CFR to enable CFR
> feature support during the compilation time.
> 
> CFR module initialization includes Direct Buffer(DB) ring initialization
> where hardware uses the DB ring buffers to copy CFR data to host.
> Number of buffers and buffer size of the ring is based on the DB ring
> capabilities advertised by the firmware through WMI service ready.
> Also ring configurations are sent to firmware through
> ath11k_dbring_wmi_cfg_setup().
> 
> Predefine ath11k_cfr_dma_hdr, ath11k_look_up_table, and ath11k_cfr
> structs and fields for subsequent patches.
> 
> Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Co-developed-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
> Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/Kconfig  |  11 ++
>  drivers/net/wireless/ath/ath11k/Makefile |   1 +
>  drivers/net/wireless/ath/ath11k/cfr.c    | 160 +++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/cfr.h    |  84 ++++++++++++
>  drivers/net/wireless/ath/ath11k/core.c   |  41 +++++-
>  drivers/net/wireless/ath/ath11k/core.h   |   8 +-
>  drivers/net/wireless/ath/ath11k/dbring.c |  40 ++++--
>  drivers/net/wireless/ath/ath11k/dbring.h |   6 +-
>  drivers/net/wireless/ath/ath11k/hal.c    |   3 +-
>  drivers/net/wireless/ath/ath11k/hw.h     |   5 +-
>  drivers/net/wireless/ath/ath11k/wmi.h    |   1 +
>  11 files changed, 343 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
>  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
> 
> diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
> index 659ef134ef16..47dfd39caa89 100644
> --- a/drivers/net/wireless/ath/ath11k/Kconfig
> +++ b/drivers/net/wireless/ath/ath11k/Kconfig
> @@ -58,3 +58,14 @@ config ATH11K_SPECTRAL
>  	  Enable ath11k spectral scan support
>  
>  	  Say Y to enable access to the FFT/spectral data via debugfs.
> +
> +config ATH11K_CFR
> +	bool "ath11k channel frequency response support"
> +	depends on ATH11K_DEBUGFS
> +	depends on RELAY
> +	help
> +	  Enable ath11k channel frequency response dump support.
> +	  This option exposes debugfs nodes that will allow the user
> +	  to enable, disable, and dump data.
> +
> +	  Say Y to enable CFR data dump collection via debugfs.
> diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
> index d9092414b362..b1435fcf3e1b 100644
> --- a/drivers/net/wireless/ath/ath11k/Makefile
> +++ b/drivers/net/wireless/ath/ath11k/Makefile
> @@ -28,6 +28,7 @@ ath11k-$(CONFIG_THERMAL) += thermal.o
>  ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
>  ath11k-$(CONFIG_PM) += wow.o
>  ath11k-$(CONFIG_DEV_COREDUMP) += coredump.o
> +ath11k-$(CONFIG_ATH11K_CFR) += cfr.o
>  
>  obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
>  ath11k_ahb-y += ahb.o
> diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
> new file mode 100644
> index 000000000000..73ffe3510ffe
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath11k/cfr.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/relay.h>
> +#include "core.h"
> +#include "debug.h"
> +
> +static int ath11k_cfr_process_data(struct ath11k *ar,
> +				   struct ath11k_dbring_data *param)
> +{
> +	return 0;
> +}
> +
> +void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
> +				 u32 buf_id)
> +{
> +	struct ath11k_cfr *cfr = &ar->cfr;
> +
> +	if (cfr->lut)
> +		cfr->lut[buf_id].dbr_address = paddr;
> +}
> +
> +static void ath11k_cfr_ring_free(struct ath11k *ar)
> +{
> +	struct ath11k_cfr *cfr = &ar->cfr;
> +
> +	ath11k_dbring_buf_cleanup(ar, &cfr->rx_ring);
> +	ath11k_dbring_srng_cleanup(ar, &cfr->rx_ring);
> +}
> +
> +static int ath11k_cfr_ring_alloc(struct ath11k *ar,
> +				 struct ath11k_dbring_cap *db_cap)
> +{
> +	struct ath11k_cfr *cfr = &ar->cfr;
> +	int ret;
> +
> +	ret = ath11k_dbring_srng_setup(ar, &cfr->rx_ring,
> +				       ATH11K_CFR_NUM_RING_ENTRIES,
> +				       db_cap->min_elem);
> +	if (ret) {
> +		ath11k_warn(ar->ab, "failed to setup db ring: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ath11k_dbring_set_cfg(ar, &cfr->rx_ring,
> +			      ATH11K_CFR_NUM_RESP_PER_EVENT,
> +			      ATH11K_CFR_EVENT_TIMEOUT_MS,
> +			      ath11k_cfr_process_data);
> +
> +	ret = ath11k_dbring_buf_setup(ar, &cfr->rx_ring, db_cap);
> +	if (ret) {
> +		ath11k_warn(ar->ab, "failed to setup db ring buffer: %d\n", ret);
> +		goto srng_cleanup;
> +	}
> +
> +	ret = ath11k_dbring_wmi_cfg_setup(ar, &cfr->rx_ring, WMI_DIRECT_BUF_CFR);
> +	if (ret) {
> +		ath11k_warn(ar->ab, "failed to setup db ring cfg: %d\n", ret);
> +		goto buffer_cleanup;
> +	}
> +
> +	return 0;
> +
> +buffer_cleanup:
> +	ath11k_dbring_buf_cleanup(ar, &cfr->rx_ring);
> +srng_cleanup:
> +	ath11k_dbring_srng_cleanup(ar, &cfr->rx_ring);
> +	return ret;
> +}
> +
> +void ath11k_cfr_deinit(struct ath11k_base *ab)
> +{
> +	struct ath11k_cfr *cfr;
> +	struct ath11k *ar;
> +	int i;
> +
> +	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
> +	    !ab->hw_params.cfr_support)
> +		return;
> +
> +	for (i = 0; i <  ab->num_radios; i++) {
> +		ar = ab->pdevs[i].ar;
> +		cfr = &ar->cfr;
> +

don't you need to check whether the radio has WMI_DIRECT_BUF_CFR capability just as what
is done in the init path?

And for the other functions where CFR is involved, do we need to check it as well?
Checking spectral feature which seems to be similar to CFR, there is a 'enabled' flag
there indicating whether this capability is supported and initialized, maybe we need it as
well?

> +		ath11k_cfr_ring_free(ar);
> +
> +		spin_lock_bh(&cfr->lut_lock);
> +		kfree(cfr->lut);
> +		cfr->lut = NULL;
> +		spin_unlock_bh(&cfr->lut_lock);
> +	}
> +}
> +
> +int ath11k_cfr_init(struct ath11k_base *ab)
> +{
> +	struct ath11k_dbring_cap db_cap;
> +	struct ath11k_cfr *cfr;
> +	u32 num_lut_entries;
> +	struct ath11k *ar;
> +	int i, ret;
> +
> +	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
> +	    !ab->hw_params.cfr_support)
> +		return 0;
> +
> +	for (i = 0; i < ab->num_radios; i++) {
> +		ar = ab->pdevs[i].ar;
> +		cfr = &ar->cfr;
> +
> +		ret = ath11k_dbring_get_cap(ar->ab, ar->pdev_idx,
> +					    WMI_DIRECT_BUF_CFR, &db_cap);
> +		if (ret)
> +			continue;
> +
> +		idr_init(&cfr->rx_ring.bufs_idr);
> +		spin_lock_init(&cfr->rx_ring.idr_lock);
> +		spin_lock_init(&cfr->lock);
> +		spin_lock_init(&cfr->lut_lock);
> +
> +		num_lut_entries = min_t(u32, CFR_MAX_LUT_ENTRIES, db_cap.min_elem);
> +		cfr->lut = kcalloc(num_lut_entries, sizeof(*cfr->lut),
> +				   GFP_KERNEL);
> +		if (!cfr->lut) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		ret = ath11k_cfr_ring_alloc(ar, &db_cap);
> +		if (ret) {
> +			ath11k_warn(ab, "failed to init cfr ring for pdev %d: %d\n",
> +				    i, ret);
> +			spin_lock_bh(&cfr->lut_lock);
> +			kfree(cfr->lut);
> +			cfr->lut = NULL;
> +			spin_unlock_bh(&cfr->lut_lock);
> +			goto err;
> +		}
> +
> +		cfr->lut_num = num_lut_entries;
> +	}
> +
> +	return 0;
> +
> +err:
> +	for (i = i - 1; i >= 0; i--) {
> +		ar = ab->pdevs[i].ar;
> +		cfr = &ar->cfr;
> +

same here
> +		ath11k_cfr_ring_free(ar);
> +
> +		spin_lock_bh(&cfr->lut_lock);
> +		kfree(cfr->lut);
> +		cfr->lut = NULL;
> +		spin_unlock_bh(&cfr->lut_lock);
> +	}
> +	return ret;
> +}

