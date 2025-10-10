Return-Path: <linux-kernel+bounces-847804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1AABCBC61
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E63423B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4005C227E83;
	Fri, 10 Oct 2025 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1KDE9Fw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05ED846F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077300; cv=none; b=HcoV92EAiairy9io6KRIXJEpyHGud2bLTudJJ1X0xSShPA1lMtx8cFtSSCVLQSArvOobsyjj/afdwd3VyRRtW6QkJs/aqQbzSmiffasQigpPiD7cUPxCR1mNdZmjYSLgM/Ys5nMS4Y3sQAlx68eOO+Zekj0yi3u2cOgWRq6P9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077300; c=relaxed/simple;
	bh=aMhdMuV/5n0XxxWRTIt0WPoXUXnD8K8moBE09tX22ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB1k8S2ClqRooF1TiVKYloHrsMwXh5K3UgcoPEjCu+F6ibxp3i5sUrQX6q63eog1C6D+FPHJQ1+Hcwv89115jahIMtsX9k32gBHTY0OG0A4XTxeeMVu6HAU5HAiNc8FRS4pGRBRorICsckNt1b+/xh7uR21r9fpZ6wXPET6/TQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1KDE9Fw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6JY4n031130
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e13hlBdIwI3NhYtoZcu6Tz3K
	/F+frP7s8cc8T89sknA=; b=S1KDE9FwlBShxZetwR2Wc3JULQL/BcRy5swN2OGM
	ngAirXrgZzpfEZUYf2uSUE2GrxEoWy3FW0k10ga6oymECKO+5BpXr/49AQvT5e61
	Ocfw1gKk/fFPHdKDx3k1a6y7lgBrEiToXG7bPE8J9owzVsglZWTOa/zh9B6c9rF9
	3hA2De7sBQTRqeLVcMvl/xqSS+JTRV2FRPPbz8Vx6OD0FVlmx49uXfm5er6dC8RP
	pVcauezBTcfpFDIYz01gKLl86YXTbvMP6NIyu/gCcmoFQp7UITPQuthPfCAzn0Qp
	c10mYEjrdiUgjX9lCbeuis97mnTyCJ5Y0/ovhu+GcJ1GQA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ndbuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:21:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b557abaad02so4440464a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 23:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760077297; x=1760682097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e13hlBdIwI3NhYtoZcu6Tz3K/F+frP7s8cc8T89sknA=;
        b=cwwi/sW9tXx7oov1xt0cOqt79g8bIZgyjwbr8qiofvA6j1Jz9mu4/7wpY2bcZKaubR
         LMv/eaVDwFKSdo5MscEX5lW+ofs7zzLCf83CXFzMAEn9vdvBNgM+dj/VQOHq8Q2SoxgI
         cPg12fijRptFa+6+1VnOhb4Pd5El9fULzpjISfAYjCVa+1aHr+NBDiiDXipHdd16yAHy
         hBo6YycdAbWkqxYS74bp4evEZcMx4n2e/Wrv/IZCfckZEsS6KRlv4qs2ICtrSMqdKshi
         1ZXvvGevyyuvx11inWykHrIw56W8K6t9nJO7bMKjPkOSF75mCsBVYPHLkJjOiIcGTlxt
         synw==
X-Forwarded-Encrypted: i=1; AJvYcCXF9LQuuWa2P1qMzsdaD3BczebldAMW5sNWqDuVjUYgqTF+zv0wcb6zrGcOCETvu1iobT5joAxkg8zOCNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvJfnYy12Y3lNuePqkfHFZ/jtOJzSeKW0HsxpYHHY/7X8ezox
	fNe7okmjeQG8RbArLqWnTdJ8tWrVdNxcUkDc/b3GWCl2RCZRSmY3CoBSabdTJSPblKSmPvvkE1J
	6LddGu6bJtjqx6NzKaLVtkUrkLg2+XSHJ1AMwLj7ejY+yq4u64iTphUgaXJlNbYYQyLc=
X-Gm-Gg: ASbGncuV7GPHGN1HrH4HlOTDSA8MTdAGQSMjkvZLdfiW2+BM9BQUPhusS9kHEKTRWah
	K4qawy9Oas+fccviWr8wkocQEqUqu7DDQtRl3IJVxyVgwxdES96s24f+890Wzk4gsRu7oSNAdE9
	8KkrPR/V1ZVHMUKqAyJO89/owCfgKL7D77TleMmi9L/96Ty8zp5EtwXvqMF9CeUxWd4xMsAiRp2
	E7kaWqJrKj2bVqmWyabjIq/WRWG2LRshabHl4fMb5VjXCIQ+scvRJUAJ9qR8Vn/sBlLrDHKgOHA
	zjEr4S9MXcHnvAPMDgUDkK6UE8R7qTV15fu/0Iuu1pD2nrTPtAZOFY0T/ZFGFfLdNTg=
X-Received: by 2002:a17:903:2c0c:b0:24c:cae9:77bd with SMTP id d9443c01a7336-290273032d9mr131306265ad.54.1760077296987;
        Thu, 09 Oct 2025 23:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm5rfxpK9hr9wzL70jfmd5cFc+zBjzoFBTNU0+gbJ7q4MWYYUoZ/cU4hiwJy2Hc0lOqq0CRg==
X-Received: by 2002:a17:903:2c0c:b0:24c:cae9:77bd with SMTP id d9443c01a7336-290273032d9mr131305985ad.54.1760077296377;
        Thu, 09 Oct 2025 23:21:36 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de658bsm46996665ad.22.2025.10.09.23.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 23:21:36 -0700 (PDT)
Date: Fri, 10 Oct 2025 11:51:29 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/12] soc: qcom: mdtloader: Add PAS context aware
 qcom_mdt_pas_load() function
Message-ID: <20251010062129.xuh63zgbc3pfp3ar@hu-mojha-hyd.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-4-de841623af3c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-kvm_rprocv4_next-20251007-v4-4-de841623af3c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e8a5f2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=hC_cApFbebj-mLVYSEcA:9
 a=CjuIK1q_8ugA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 81jMQSFgIo11YWE18L_gEVq7t-UiT80L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1ahhExd9Qk8o
 KMHolbkwVfsU0wjzMSJrZ4vLeuhCcQwrYloFRTc3J0dCdlKjumdwHpMnVIUHkwPQ5m267qZDjTz
 y82wbNm78H271i3G5DC4yvu3Al0HJaUqPrkgxerOI2VxReGNI0i25InQfbY6a2xLbUkSmDjikhW
 5HNMQWgBs2wMtUSI+pQ9YcOloqol+43Fk85p4IaJsJaDhEoECYvkyf+unIS6pEG7nMAXKKodnah
 6tJyHxdImb/VRV1WoJRj8gN1P2obmU5NnabCNOqDxNg2JKZZBZEZ7mQD45fmxv9BFhYHf2Uqcns
 WzfaCsT8XF9O2zqUIfSe2zrPKRwI5OhVPjvMCBU7kS4LrPS9gB8bPcQqD+GDdv4MfrbVtLDUIwY
 c749diubYAftFOMLTSpwFtORpPZ6FA==
X-Proofpoint-GUID: 81jMQSFgIo11YWE18L_gEVq7t-UiT80L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Tue, Oct 07, 2025 at 10:18:49PM +0530, Mukesh Ojha wrote:
> Add a PAS context-aware qcom_mdt_pas_load() function for remote
> processor drivers, which can use the context pointer returned from
> qcom_scm_pas_ctx_init() to perform metadata verification and memory
> setup via SMC calls.
> 
> The qcom_mdt_pas_load() and qcom_mdt_load() functions are almost
> similar. Clients using the PAS context-based data structure can adopt
> qcom_mdt_pas_load(), and in the future, all users of qcom_mdt_load()
> could be migrated to use qcom_mdt_pas_load() instead.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/mdt_loader.c       | 29 +++++++++++++++++++++++++++++
>  include/linux/soc/qcom/mdt_loader.h | 11 +++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index a5c80d4fcc36..31855836b251 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -486,5 +486,34 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
>  }
>  EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
>  
> +/**
> + * qcom_mdt_pas_load() - load the firmware which header is loaded as fw
> + *
> + * Client should initialize the PAS context with qcom_scm_pas_context_init()
> + * before calling this function.
> + *
> + * @ctx:	PAS context pointer
> + * @fw:		firmware object for the mdt file
> + * @firmware:	name of the firmware, for construction of segment file names
> + * @mem_region:	allocated memory region to load firmware into
> + * @reloc_base:	adjusted physical address after relocation
> + *
> + * Returns 0 on success, negative errno otherwise.
> + */
> +int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
> +		      const char *firmware, void *mem_region, phys_addr_t *reloc_base)
> +{
> +	int ret;
> +
> +	ret = qcom_mdt_pas_init(ctx->dev, fw, firmware, ctx->pas_id, ctx->mem_phys,
> +				ctx->metadata);

There is no user of qcom_mdt_pas_init() now after this, this can be
converted to __qcom_mdt_pas_init() and removed from exported list.


> +	if (ret)
> +		return ret;
> +
> +	return __qcom_mdt_load(ctx->dev, fw, firmware, mem_region, ctx->mem_phys,
> +			       ctx->mem_size, reloc_base);
> +}
> +EXPORT_SYMBOL_GPL(qcom_mdt_pas_load);
> +
>  MODULE_DESCRIPTION("Firmware parser for Qualcomm MDT format");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
> index 8ea8230579a2..2832e0717729 100644
> --- a/include/linux/soc/qcom/mdt_loader.h
> +++ b/include/linux/soc/qcom/mdt_loader.h
> @@ -11,6 +11,7 @@
>  struct device;
>  struct firmware;
>  struct qcom_scm_pas_metadata;
> +struct qcom_scm_pas_context;
>  
>  #if IS_ENABLED(CONFIG_QCOM_MDT_LOADER)
>  
> @@ -23,6 +24,9 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  		  phys_addr_t mem_phys, size_t mem_size,
>  		  phys_addr_t *reloc_base);
>  
> +int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
> +		      const char *firmware, void *mem_region, phys_addr_t *reloc_base);
> +
>  int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
>  			  const char *fw_name, void *mem_region,
>  			  phys_addr_t mem_phys, size_t mem_size,
> @@ -52,6 +56,13 @@ static inline int qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  	return -ENODEV;
>  }
>  
> +static inline int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx,
> +				    const struct firmware *fw, const char *firmware,
> +				    void *mem_region, phys_addr_t *reloc_base)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int qcom_mdt_load_no_init(struct device *dev,
>  					const struct firmware *fw,
>  					const char *fw_name, void *mem_region,
> 
> -- 
> 2.50.1
> 

-- 
-Mukesh Ojha

