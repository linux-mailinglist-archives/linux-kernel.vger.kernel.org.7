Return-Path: <linux-kernel+bounces-831618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4937B9D24C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14941BC19F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E109127F754;
	Thu, 25 Sep 2025 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kMJ9nqtc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7FD2FB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767304; cv=none; b=B437t5AcPiqLNVqQU/NQ6Z0h6tWUO1aRKANRZBvBM/oys/dLrdRhy+cHN7hwyx8cHZGd1EUTo0+qF49dfyMQnTqM53ogMc8kT866H5+h1PiEzT83UOL+bt+475Q/xQXC0FKcpxmYTj8VpjQ8ZLMbYFBh/SUfAcQmQI+VCTmmP1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767304; c=relaxed/simple;
	bh=VeW+/dxWBFokkjVS0wYtTsWpjpgB19ZpOQMGvhrWa2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCntJh53Bxx2geR0I4U+4MQFBdFlqikF6k5iplPj1OhWNskMPVMFDe9CY1BxxLcf2TPHKDl9QCYDUKx9nqhrhnNf6X6pfgiH2eujdZxAZVBBnanxb25dedtZhhSGxIlTE6chGu0IMzqAhwXeV3kYx49e7lmeeM5Y07yr3xrWAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kMJ9nqtc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0Wnbl020144
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wXSfj1wi08RKzF1L2ephokkz
	/QuwdGIgQuSB3kutQM8=; b=kMJ9nqtcoBmAhHEvQshcaEBd68YJo37OKD8KDaQu
	IjF+2n/fEIA87dyZpcu8b1ho+xbcqXGUXCQVHGvHhxUpQdymjPQoUkg9MDAp+MeZ
	4RnYUJ98E7cA5NSsXzKBFF08xLTCKqsOhCX5tYhIUV7SUYJIaVL/+28GOai7mAiU
	9pNRwJYaUjdgKyAHmXcD8J3yfoqnz4d7yVPapdBfbFrX76Ew4w4EYod7IjH3zfeR
	LOJHic8ZdFBNOSmPETGO2HBHp1JYzY6FxVSCWPhB00jVYjB/ztt2bhZ+4PtGBF5T
	fjfs97a/RdhC1aoDkWmaz9uvRpJQbQcFDLgXTiwVmiQCVg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdyneb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d905ce4749so9397871cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767300; x=1759372100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXSfj1wi08RKzF1L2ephokkz/QuwdGIgQuSB3kutQM8=;
        b=rYUHVR9Aw8HCfx9iO0voJu1jDJl/L7aK1cT0mWcpriEP9S4pNj4VEJII52ru6NMJ4I
         E07trBdLCdS9CKGk6R8ZU3u36sVNC1nhVvik1BjDkfMoL0x/AC9sV31Wa+AC0hbgARKK
         dc73SO6KrpHsCTM0qiQQaljF+gGh00rDkzNr84gi4ylG5axtDbMDwJTIMWOSH4MurLKt
         qTCKitEPbBMsE0GDZ6jMGKf9gHASkr2Y68VixHmsm1TagfFyuaHzBXml/Id7jQpDOlqf
         /3aZAUP/cCOjrUUldItDMf0i6SJRTfUZDqYDevQ51m0IivOpDAt8l0XqGJXQTYWt2J0d
         p0mw==
X-Forwarded-Encrypted: i=1; AJvYcCWRStZOOutPEbMr89JYcA6Yh2E8EH3PMCj/Cijq69jPmZMKCGZWbmQlJoFrMaowp+1dkNU6Bs//gnje7TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRwZ6mkO+8J3HlOmda2+VaDGhj5SOB53lkwVN7L6lXHWAxqN2
	Bx3cATXL29B9qXee+Y48xzsoa7sCcZkgJke1F4zH7ln7hJBagioIZJdQZyztsfgCmX8twbTACdQ
	sM3rwuNoj4P1HlvaQ5xRqE1E9+GMBFgXjrKf09dhAtOdyC1wHy8qdDm1FTXo3fMuOOQo=
X-Gm-Gg: ASbGncvhVlilPK3aPdAkDvgpTHBrkhQUVpBp1Tej8jlJNixv/ZSA9BwEpJ7+7vVM4bD
	/vu003wZBwPuVWt/w8mf3InZKgNZ9M1fP/LzQpbjVV/1SoIXEwiouhU8grgsxDq1gJGkG+TAlA7
	2BSCjQkQYbZEnAUBGUL5MVNAVhP1R810P3+PBFJOSLwxm+j08KGW5pRuLJ3lrDsGjIc468kPjCi
	/9dzf+2yj2bYJdwo+co9Vs2XlqhOBWGKWdEz+evj3YH0L9/cdu+a6JKJu1tamDZazdE7zgbtGYc
	Wf3l/4Hm5yfS0A1EvLRxkBpPcZSZ/lseovEDcgdF/qjEdaKrtiQMHHNHrtm2xNono7/fB/35PM9
	/FYnDDzgD5Gmva2l0mV9wzzsVDGsPn16npwcRVGZvLWFOcWRUJ22z
X-Received: by 2002:ac8:5856:0:b0:4b6:2be2:e816 with SMTP id d75a77b69052e-4da4735508amr26619231cf.8.1758767300299;
        Wed, 24 Sep 2025 19:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4UEfkhO1mpjxW8ifjJvdLmt7J0vNk2R3BrhhdTbo1+/m7PrsyR8BHP8zagES/AEoTWgsM8A==
X-Received: by 2002:ac8:5856:0:b0:4b6:2be2:e816 with SMTP id d75a77b69052e-4da4735508amr26618921cf.8.1758767299822;
        Wed, 24 Sep 2025 19:28:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166561c0sm243601e87.81.2025.09.24.19.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:28:18 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:28:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 3/6] phy: qcom-qmp: qserdes-txrx: Add QMP PCIe PHY
 v8-specific register offsets
Message-ID: <fw5hf4p2mjybvfo756dhdm6wwlgnkzks4uwgo7k3dy7hyjhzyr@bv4p7msxapcb>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
 <20250924-knp-pcie-v1-3-5fb59e398b83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-pcie-v1-3-5fb59e398b83@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: kN-wpkEd3pMq3oj6oXWQn8sHBd9lVFjt
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d4a8c5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KS3u3L2nYUaZ2k-SVKIA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: kN-wpkEd3pMq3oj6oXWQn8sHBd9lVFjt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXyUqtPtJ/wSh5
 DLQsPXe1jYjsZFQlKdtWgoQ6c1mHjEmzuIAZkWXj/bRALezUHupQORwJIbOo2OFQkVTX2tXnre+
 /yMem1iy74PoJeYMmMPhz6e+eSXkliFaEyaOaopxQu7okJC9Z3LnAYrVOxoymtHQVHTbrZpBjeF
 hzOOeo5X3lADTSG9sZl3PwJF1iglG9PAIxuUa/2+3O+JSlKJ2v233nVttfWfOwBL/nenxYNNGIw
 HsYTK2lum20HBMbSuR89jjR7d6eDyGRDlpFbqlmxJ+lOLWCeRrCrDOqGPTXxrCm8DJnBwrw5Cqe
 ZBi6/jTyUXtevNPQuB8ujRNk7TssuVMqcUsd8hHoGr2RAMAaj25xmBLuA6rpYsikxnV307Nou86
 b2HNn6T5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On Wed, Sep 24, 2025 at 04:33:19PM -0700, Jingyi Wang wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Kaanapali SoC uses QMP PHY with version v8 for PCIe Gen3 x2, but its
> qserdes-txrx register offsets differ from the existing v8 offsets. To
> accommodate these differences, add the qserdes-txrx specific offsets in
> a dedicated header file.

With this approach it's not obvious, which register names are shared
with the existing header and which fields are unique. Please provide a
full set of defines in this header.

> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h   | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h
> new file mode 100644
> index 000000000000..181846e08c0f
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V8_H_
> +#define QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V8_H_
> +
> +#define QSERDES_V8_PCIE_TX_RES_CODE_LANE_OFFSET_TX		0x030
> +#define QSERDES_V8_PCIE_TX_RES_CODE_LANE_OFFSET_RX		0x034
> +#define QSERDES_V8_PCIE_TX_LANE_MODE_1		0x07c
> +#define QSERDES_V8_PCIE_TX_LANE_MODE_2		0x080
> +#define QSERDES_V8_PCIE_TX_LANE_MODE_3		0x084
> +#define QSERDES_V8_PCIE_TX_TRAN_DRVR_EMP_EN		0x0b4
> +#define QSERDES_V8_PCIE_TX_TX_BAND0		0x0e0
> +#define QSERDES_V8_PCIE_TX_TX_BAND1		0x0e4
> +#define QSERDES_V8_PCIE_TX_SEL_10B_8B		0x0f4
> +#define QSERDES_V8_PCIE_TX_SEL_20B_10B		0x0f8
> +#define QSERDES_V8_PCIE_TX_PARRATE_REC_DETECT_IDLE_EN		0x058
> +#define QSERDES_V8_PCIE_TX_TX_ADAPT_POST_THRESH1		0x118
> +#define QSERDES_V8_PCIE_TX_TX_ADAPT_POST_THRESH2		0x11c
> +#define QSERDES_V8_PCIE_TX_PHPRE_CTRL		0x128
> +#define QSERDES_V8_PCIE_TX_EQ_RCF_CTRL_RATE3		0x148
> +#define QSERDES_V8_PCIE_TX_EQ_RCF_CTRL_RATE4		0x14c
> +
> +#define QSERDES_V8_PCIE_RX_UCDR_FO_GAIN_RATE4		0x0dc
> +#define QSERDES_V8_PCIE_RX_UCDR_SO_GAIN_RATE3		0x0ec
> +#define QSERDES_V8_PCIE_RX_UCDR_SO_GAIN_RATE4		0x0f0
> +#define QSERDES_V8_PCIE_RX_UCDR_PI_CONTROLS		0x0f4
> +#define QSERDES_V8_PCIE_RX_VGA_CAL_CNTRL1		0x170
> +#define QSERDES_V8_PCIE_RX_VGA_CAL_MAN_VAL		0x178
> +#define QSERDES_V8_PCIE_RX_RX_EQU_ADAPTOR_CNTRL4		0x1b4
> +#define QSERDES_V8_PCIE_RX_SIGDET_ENABLES			0x1d8
> +#define QSERDES_V8_PCIE_RX_SIGDET_LVL			0x1e0
> +#define QSERDES_V8_PCIE_RX_RXCLK_DIV2_CTRL			0x0b8
> +#define QSERDES_V8_PCIE_RX_RX_BAND_CTRL0			0x0bc
> +#define QSERDES_V8_PCIE_RX_RX_TERM_BW_CTRL0			0x0c4
> +#define QSERDES_V8_PCIE_RX_RX_TERM_BW_CTRL1			0x0c8
> +#define QSERDES_V8_PCIE_RX_SVS_MODE_CTRL			0x0b4
> +#define QSERDES_V8_PCIE_RX_UCDR_PI_CTRL1			0x058
> +#define QSERDES_V8_PCIE_RX_UCDR_PI_CTRL2			0x05c
> +#define QSERDES_V8_PCIE_RX_UCDR_SB2_THRESH2_RATE3			0x084
> +#define QSERDES_V8_PCIE_RX_UCDR_SB2_GAIN1_RATE3			0x098
> +#define QSERDES_V8_PCIE_RX_UCDR_SB2_GAIN2_RATE3			0x0ac
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B0			0x218
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B1			0x21c
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B2			0x220
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B4			0x228
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B7			0x234
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B0			0x260
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B1			0x264
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B2			0x268
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B3			0x26c
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B4			0x270
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B0			0x284
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B1			0x288
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B2			0x28c
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B3			0x290
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B4			0x294
> +#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B5			0x298
> +#define QSERDES_V8_PCIE_RX_Q_PI_INTRINSIC_BIAS_RATE32			0x31c
> +#define QSERDES_V8_PCIE_RX_Q_PI_INTRINSIC_BIAS_RATE4			0x320
> +#define QSERDES_V8_PCIE_RX_EOM_MAX_ERR_LIMIT_LSB			0x11c
> +#define QSERDES_V8_PCIE_RX_EOM_MAX_ERR_LIMIT_MSB			0x120
> +#define QSERDES_V8_PCIE_RX_AUXDATA_BIN_RATE23			0x108
> +#define QSERDES_V8_PCIE_RX_AUXDATA_BIN_RATE4			0x10c
> +#define QSERDES_V8_PCIE_RX_VTHRESH_CAL_MAN_VAL_RATE3			0x198
> +#define QSERDES_V8_PCIE_RX_VTHRESH_CAL_MAN_VAL_RATE4			0x19c
> +#define QSERDES_V8_PCIE_RX_GM_CAL			0x1a0
> +
> +#endif
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

