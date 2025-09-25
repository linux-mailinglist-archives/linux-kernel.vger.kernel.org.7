Return-Path: <linux-kernel+bounces-832986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF5DBA0E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0117C1C24F50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91E031159C;
	Thu, 25 Sep 2025 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jehT06DN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A43101AA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821489; cv=none; b=MFNX0Trygp8rwJyIw0BnRMLWuRZ7/WMz2QAMAx2c5n/9z0hH9OA6qNwZnqiRhEj4FTIyFH3pClbp9DOdxbn2PkhfpMHL7EFafDSKfxSlir60bjeQf9h5mp/TO3t8eUXKcYFcOhqgZu+nHaNTc06cZfC1HV5Nz96I/B2fedagQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821489; c=relaxed/simple;
	bh=pRTuQaQ5en7xRjzPn1i8iKKqSfcyIsaYI0MlEMrRtnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE4c0DhY4GPd5FFqa5TnKE+lyC7KOuyo+terAKLMNulO5vH4K7mztxqHYQvXi2z1mNg+kOoRUACbCb1ectNHFjwoIB4S2QKEoRkXHvuFywLugjR4LhEyEOp4I5++eCeFeZqZRrb87N1RagSk74iPVlwsS8//1xbB5HLs2+8awjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jehT06DN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PH2dJv027912
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XcofA0/e9bp5+FqjFDfqB18S
	Cd6t6q5WsiniwBz90Bg=; b=jehT06DNHpLwwAIG4mLJAES1aY1nxYUcC8f8/ncv
	jJa9a+D3h7EOpBRzdPA9Q4ZZ5fNJYEnPEWNKkPVFvV8+Fvl33Nz5qUtbFzGcxLZf
	tF3jUpp9vK23zqzGiiD7lVNq9u3YseE4YH6E/2zd3zcizehzdOJCASr4TQ/Dk/gN
	ONtnbUCrEaaDJ4wV+IrelMs0KD3sVEMwM6fQ8lUKjEGV90zhHjCAVBqce4egEIEi
	Lmhat6NefDppD7Dscq/Y39xr5m9YKARjALmgo6SLlOSzs8LplDBVYyfbZw/Hw9HG
	QQbWxJOv71BzC0dygv2AjtE09kIWrA+th4BCENY28Ov0Tg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmp1d7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:31:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dbd8484abbso15373721cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821486; x=1759426286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcofA0/e9bp5+FqjFDfqB18SCd6t6q5WsiniwBz90Bg=;
        b=X9mNtg3FTJInC3Li6tbn5zWygQRmHOIyIKCmuWBmE6SZGBGQ0hwlVq8Ib8lNKFzooK
         zD4snUFhzXu/uwAK5NX0vWe8ecYE72nr4qUU9+PlHNi/1umHNxp5owa0j2eeMKp1f1+m
         kdnFSPEzUNHBLj7RlEuLa/45n9ClT7joVi8WOXLrC2sErXcXKqMmIxemW0SC5QG59MeY
         SL2ap4gJddjZ+E1u6xdmBSuWpyeHWnrSlEUPA1tncgx5zlVo9zB6uXJnQObbQ2mtN76x
         2Br0nr6OB0mXgi0N/3hj+EjC7kXOSAbHHOrdg/quxqaFiGxnj5P+JN+jYbLtmHNivq5z
         TYEw==
X-Forwarded-Encrypted: i=1; AJvYcCWng3R4fZi6hcVN7iISC6WMkiTPRjxd67N+q6pqF3VYSktuG4RvZF1FoO04GvSZ4vto7IQU1RVNoWjR4Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRr6tZPRZbXTPbF7fg8Opu063lHOeqNX0yimzuhzolJr9UMyu
	/7wihROZdQDm3+CzcFCsX+hSTz44IOHx3sjrwTRmL4yK18YdyMhmQcgCroCkfxzK28zK8y/Fdqi
	+oUdRs7P4TUajgI8ch9sP5GHLDPEapSUZcHDoJmG1rkyHyMOCnl1s+sWaAZNmp71WGi1ZcMtcNB
	0=
X-Gm-Gg: ASbGncv/K7QmP7A+c2gGnG+TgPlJVSWLxrhGY5bErLqdlJsw17+IWaG1eAGjczS2JT4
	n68PRkqtOliVu9EwBD59Owdtl5VxFWxhHKiVss2cTWNNeoBXIiUWfGrUzhwqQDDhmLQe1vZXQL3
	QIF268XrTVK+FUaZ0hHWjQ81gs7J82Ox8Ika0UB+A7P0bk79XMWlyGaEzrf935P1o3Msfk6DpKv
	RhCl3pGEACM45zSjW/vqHjLx+UVIq/6N3eMiY83bDm2XXtNA/43HUZfSMj888htoT0oDtyMofQc
	sxO4f9JurZELiCri6gj7MHFldNaDItu1imcNAnzVDt5+9etyv0kIlFNbPxzSHrlpFpvY9HhC37o
	bMLf8mnBIruNRpg9UHkOWxHmbbciPQ1pQpQFFgFyPWpgeCESoiKxZ
X-Received: by 2002:a05:622a:995:b0:4b5:fc2a:f37c with SMTP id d75a77b69052e-4da4c77c867mr59738991cf.74.1758821486029;
        Thu, 25 Sep 2025 10:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs34jOTuU/q9ApiNico/KaHV2NeRqlRXEj+YF6SNVDCulahwsTp214FKxT+pGvyE4hKawF7g==
X-Received: by 2002:a05:622a:995:b0:4b5:fc2a:f37c with SMTP id d75a77b69052e-4da4c77c867mr59738011cf.74.1758821485285;
        Thu, 25 Sep 2025 10:31:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4773b19sm6900451fa.13.2025.09.25.10.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 10:31:23 -0700 (PDT)
Date: Thu, 25 Sep 2025 20:31:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/24] arm64: defconfig: Enable Glymur configs for boot
 to shell
Message-ID: <wzhfv4v5urehjjlldsdznrnv244pdzpuolofalvj3cerscipch@7gkb5dvjwl4i>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-2-24b601bbecc0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v1-2-24b601bbecc0@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d57c6f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=h_zAmc7I_mnZi0L7CD4A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: XMRURLelvfWrLP9XQUGseIBF0afbWLmX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX/OPAnfO29rYf
 kTv+kOXnbWH+uCNrlRuk1PcT0be94ST+lMRb/OswXVv0MgpryA5l+eCDd9VL3KYLMNgjaE2GJd1
 hbYepmOHbGxwXcnbl0hfhoFGs+EbfCM0w87Sn8w9pMZHpmNyUs2evdOgz2Cl7mrJRbi8k/h39Zm
 4iUXir6xWMV9K3DgigspMCi0bB5YjJR2UDsYMsqMHqs5p6Uvbl6knT38lV6WcGNN63I+Zo1H1TM
 10xnfQ6CqI/EflgZpBqz9kaIlenJQVGSB0FM8yRd0Ji/0ROwl+NF/wqTjLUv0CjT4jTd2CmUxWt
 THeRExHWECmvjOQnEV6VHDBEHCOKlk4zpadGf9gKLU1JGzuUErMXuNVQUhNujh8jfxwsD09gC9r
 K56NtSvE
X-Proofpoint-GUID: XMRURLelvfWrLP9XQUGseIBF0afbWLmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On Thu, Sep 25, 2025 at 12:02:10PM +0530, Pankaj Patil wrote:
> The serial engine must be properly setup before kernel reaches
> "init",so UART driver and its dependencies needs to be built in.
> Enable its dependency clocks,interconnect and pinctrl as built-in
> to boot Glymur CRD board to UART console with full USB support.
> 
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..9dfec01d347b57b4eae1621a69dc06bb8ecbdff1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -616,6 +616,7 @@ CONFIG_PINCTRL_IMX8ULP=y
>  CONFIG_PINCTRL_IMX91=y
>  CONFIG_PINCTRL_IMX93=y
>  CONFIG_PINCTRL_MSM=y
> +CONFIG_PINCTRL_GLYMUR=y
>  CONFIG_PINCTRL_IPQ5018=y
>  CONFIG_PINCTRL_IPQ5332=y
>  CONFIG_PINCTRL_IPQ5424=y
> @@ -1363,6 +1364,9 @@ CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
>  CONFIG_COMMON_CLK_MT8192_VDECSYS=y
>  CONFIG_COMMON_CLK_MT8192_VENCSYS=y
>  CONFIG_COMMON_CLK_QCOM=y
> +CONFIG_CLK_GLYMUR_DISPCC=y

DISPCC should not be required for the UART, it can go to =m

> +CONFIG_CLK_GLYMUR_GCC=y
> +CONFIG_CLK_GLYMUR_TCSRCC=y
>  CONFIG_CLK_X1E80100_CAMCC=m
>  CONFIG_CLK_X1E80100_DISPCC=m
>  CONFIG_CLK_X1E80100_GCC=y
> @@ -1641,6 +1645,7 @@ CONFIG_PHY_QCOM_QMP=m
>  CONFIG_PHY_QCOM_QUSB2=m
>  CONFIG_PHY_QCOM_EUSB2_REPEATER=m
>  CONFIG_PHY_QCOM_M31_USB=m
> +CONFIG_PHY_QCOM_M31_EUSB=m

Is this also a dependency for UART?

>  CONFIG_PHY_QCOM_USB_HS=m
>  CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
>  CONFIG_PHY_QCOM_USB_HS_28NM=m
> @@ -1718,6 +1723,7 @@ CONFIG_INTERCONNECT_IMX8MN=m
>  CONFIG_INTERCONNECT_IMX8MQ=m
>  CONFIG_INTERCONNECT_IMX8MP=y
>  CONFIG_INTERCONNECT_QCOM=y
> +CONFIG_INTERCONNECT_QCOM_GLYMUR=y
>  CONFIG_INTERCONNECT_QCOM_MSM8916=m
>  CONFIG_INTERCONNECT_QCOM_MSM8996=y
>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

