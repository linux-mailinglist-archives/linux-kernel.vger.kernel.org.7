Return-Path: <linux-kernel+bounces-847809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B284BCBC8B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CB8403408
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB6E24466D;
	Fri, 10 Oct 2025 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZS/Du9ps"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACCA247284
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077646; cv=none; b=eLnZ+BeBjv5xNhw7XYVtBIyhvLsqfJxeCRGLTuSAyIi5HnpYeC6Kszs/63/YjIUzblcvge3p+2YyPLeCeAhHPfmkq//BusCqUiFyXi6BxTGvCfIXDBSEg4wnUtFUu8yrfkGPKqNr+Q4O6yWI3f3xjVmHJOAFaF4fRHGeSkeR0g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077646; c=relaxed/simple;
	bh=pnGq//BMmE5bY73Ar2fzVMMFUkllb6bB1zHYfLKr9oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss/mHedwGSJnD2AEypHRNJYQclp9N/UO0KS3hK1vdaRkx+rFoTh5M+JdaZ13UbthLdQx+2U9k7jSxhwmpd1J/KOVS+lJEpmBeMYloFWIQKxElXCEYSidtKreobk3ZnD/6v75SCdBLbuoPsnP34V/s5RGU72T5OBach7OlkJRpOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZS/Du9ps; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6J1SO007029
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8KOlJ1KeODNmXdXyLJpBfhqY
	iV7WSitTJL7ZDmq9RSY=; b=ZS/Du9psdphoUphP4v5iSES+PKhNKQ+r2OENk8JG
	9Tlubmfx4AzXz0g2xsn4SQCq2mBJySL1YqJakn4eeIBjEJS/gzgD6Ys7GhCJ95ca
	PzzMHvw1pHub3PQqO7hm/v6X1R1MbyXtozpe49V/35ykvDP+2FZKz3fbiiWt0viO
	wgi+8XiphatwvH5b0YgfCb+T1tBAiRDefzM2MPY2oA5mVYk0r6iV7QY7R4g1D/5H
	r+wmeiAgxf1q/vESbVCJC2onK/PfcT2ZL70rYQpreJJeEmIzLk4zR8ypo1Vn2Rg0
	0mWMG3GGRDTSyMLDtIxjCiXhO1VQwPur/JUlGLW3T6Z26g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49pgdsst8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:27:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28e8112143fso42275095ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 23:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760077641; x=1760682441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KOlJ1KeODNmXdXyLJpBfhqYiV7WSitTJL7ZDmq9RSY=;
        b=qVye3xh+QRjpy1rQS3HHkhvL/0EbdqsS6NbSCsd9TIUZ90omTxqK8BcNCxLKhEJlwr
         k9ekjNox0g2txX288CGfD4IxeEQzr3p/FTgA1hQalYBXdvuxmLzhWSid/kbfn8djqXlG
         zXP/kyxe3cMCmChmPvGJYU3RpdyvWNYzx9CZ3d+SREgWXCU1OcSeezhB7EER8Wb/nvg0
         b34zv891YkSXW1rC2E5sk6ln2SC3EPZxJN3F0H33kq7CuubXWXPRaBPhzHyBCjgTaPQ2
         i28YkeSWdoHhuGepdWALTZlzpM/zwb2gmjpyVZmzd20eMkylUfPVLq6wuutODUKsGyjF
         xeAA==
X-Forwarded-Encrypted: i=1; AJvYcCWAV9YwShhJByVoZIXDVmg6NketgJyHDthEiynrRNV9wg2PS0wSl2qQU8wsOd15cU/nL9eb003WKNZNe0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWZ14jQ9lCS00pEr1/D/nH86x6xNQFrpe7O9uylNiHg5PT57o
	fzRgC5lZz9LUEE6UBY9x4/qEAzNtfJzowMVID15tQT9eHOzqj2GgmTv+VBtjdR73Cc9GSSFQEVV
	B6ML26+In+BKKTVu4IWFK700QFyPMAyM1T60eADtQNRn9LFRd72rMhYiA9hSX/IllwD8=
X-Gm-Gg: ASbGnct65kc6Z9+q4cVG9Fx1RYeQfAwAFqoU9pjJ8d4LXfdGXsJJCkAMHkv36fG+tGN
	J1Df/6c5dmsOCm5v++156mnAAvkjkXBK/kZRl1hj2DhSv3o6s55D2rb9twxmI+bl0vbypFuSQu0
	MAHhFtrGCO2tLyW3c6bSbGijQfiwYW16iiAW6a2pznvcXhf764OAUsJCZuazx1omWsZJaRKEVHx
	5dG6YdnHdXKDoC+G4eHjQx9IjNt/ijw4SluBwiam/cUZJ7HQ902uvWY7j3IndX78pd+BjXFckMb
	0zGncuMAx3Ut/BhvhzcSfeGmqOIWgG1FbRmvRQEIebvdegZ48iQOUGc70QP5JVu5uAQ=
X-Received: by 2002:a17:903:94f:b0:27e:c27f:b834 with SMTP id d9443c01a7336-290272f7e6fmr145372065ad.56.1760077640820;
        Thu, 09 Oct 2025 23:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfC4Z+Rtwh20NJKoWgbMQbKmnRvWnaw1tbJid4gWcGtL7HdfPaybNBG6CJfaeKuWX+dFJFFg==
X-Received: by 2002:a17:903:94f:b0:27e:c27f:b834 with SMTP id d9443c01a7336-290272f7e6fmr145371765ad.56.1760077640123;
        Thu, 09 Oct 2025 23:27:20 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de7871sm47073245ad.16.2025.10.09.23.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 23:27:19 -0700 (PDT)
Date: Fri, 10 Oct 2025 11:57:13 +0530
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
Subject: Re: [PATCH v4 12/12] arm64: dts: qcom: Add EL2 overlay for Lemans
Message-ID: <20251010062713.jff37ulgskv5xllf@hu-mojha-hyd.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-12-de841623af3c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-kvm_rprocv4_next-20251007-v4-12-de841623af3c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: t1L0KMjIzgM8CGNLu4CkBfmKclJ607iK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA5OCBTYWx0ZWRfX2m4eDHADLneR
 4SScQ4UyUimHo/xKmQm36BBDHMbg/Q/Ndyglkf+rityJctsbINahoxTxCaAgaR4NVLVZUJQUL9T
 jG+zKGK9y+j65otQEdDNcBGMryKdlyMb26ov0VVz+benFwQolNUVEdlhOzeOwetE4JUeZ0vNb71
 l8GHLLFg0aWom6Oioid7QWHanFLTZhbGejwnO8IFSkh9byGFhbiV0kYBr82EcK/eV9c2ZvT06H6
 UGywL5g2x5OZ67bwr2ny5o3WnbjlrhlP8HmRodFYF4Sh9zciopfom36/PquceuBnsQp7j2Jji0G
 wfr1VvShGUJ9+UC+4YtRjDV71STNBxjTq5zi+6Tjg35/JV5ndBiKYJdOPcEirh9/192o71b37/h
 U75K7KR194EJSLW7AnWOwyr5WLCHdQ==
X-Authority-Analysis: v=2.4 cv=DISCIiNb c=1 sm=1 tr=0 ts=68e8a74a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=oFCgBSb2_MPOKaEsi3wA:9
 a=CjuIK1q_8ugA:10 a=eSe6kog-UzkA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: t1L0KMjIzgM8CGNLu4CkBfmKclJ607iK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510090098

On Tue, Oct 07, 2025 at 10:18:57PM +0530, Mukesh Ojha wrote:
> All the Lemans IOT variants boards are using Gunyah hypervisor which
> means that, so far, Linux-based OS could only boot in EL1 on those
> devices.  However, it is possible for us to boot Linux at EL2 on these
> devices [1].
> 
> When running under Gunyah, remote processor firmware IOMMU streams is
> controlled by the Gunyah however when Linux take ownership of it in EL2,
> It need to configure it properly to use remote processor.
> 
> Add a EL2-specific DT overlay and apply it to Lemans IOT variant
> devices to create -el2.dtb for each of them alongside "normal" dtb.
> 
> [1]
> https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |  7 +++++-
>  arch/arm64/boot/dts/qcom/lemans-el2.dtso | 41 ++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 296688f7cb26..e2eb6c4f8e25 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -35,6 +35,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk.dtb
>  lemans-evk-camera-csi1-imx577-dtbs	:= lemans-evk.dtb lemans-evk-camera-csi1-imx577.dtbo
>  
>  dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera-csi1-imx577.dtb
> +lemans-evk-el2-dtbs := lemans-evk.dtb lemans-el2.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-el2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
> @@ -136,7 +138,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-vision-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8300-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb

Either this can be removed., or removed from below line.

> -dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
> +qcs9100-ride-el2-dtbs := qcs9100-ride.dtb lemans-el2.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb qcs9100-ride-el2.dtb
> +qcs9100-ride-r3-el2-dtbs := qcs9100-ride-r3.dtb lemans-el2.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb qcs9100-ride-r3-el2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
> diff --git a/arch/arm64/boot/dts/qcom/lemans-el2.dtso b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
> new file mode 100644
> index 000000000000..582b0a3a291a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/*
> + * Lemans specific modifications required to boot in EL2.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&iris {
> +	/* TODO: Add video-firmware iommus to start IRIS from EL2 */
> +	status = "disabled";
> +};
> +
> +/*
> + * When running under Gunyah, remote processor firmware IOMMU streams is
> + * controlled by the Gunyah however when we take ownership of it in EL2,
> + * we need to configure it properly to use remote processor.
> + */
> +&remoteproc_adsp {
> +	iommus = <&apps_smmu 0x3000 0x0>;
> +};
> +
> +&remoteproc_cdsp0 {
> +	iommus = <&apps_smmu 0x21c0 0x0400>;
> +};
> +
> +&remoteproc_cdsp1 {
> +	iommus = <&apps_smmu 0x29c0 0x0400>;
> +};
> +
> +&remoteproc_gpdsp0 {
> +       iommus = <&apps_smmu 0x38a0 0x0>;
> +};
> +
> +&remoteproc_gpdsp1 {
> +       iommus = <&apps_smmu 0x38c0 0x0>;
> +};
> 
> -- 
> 2.50.1
> 

-- 
-Mukesh Ojha

