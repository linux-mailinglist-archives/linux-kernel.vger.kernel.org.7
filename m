Return-Path: <linux-kernel+bounces-776351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249DAB2CC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7FB3B53E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8113101B7;
	Tue, 19 Aug 2025 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pb5DAA+c"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DC24469E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629008; cv=none; b=bS0WzaycLdU8DBNwDeK6/67IRyhdm907Y5joCZn1bKhAftIblK3PyLhBIkTXugyRzXRL/T2aXge2efszfq073Zh7SjQ4ZgNOmBelKbEL871fj5uQlbyYhoEtJ2kReEWSAf0qsE01fsXqgxmO2sgDAnvn/wYIlI2qvAvMacwmkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629008; c=relaxed/simple;
	bh=eC6MPHc/rm5FJ5KXRZT+EhHEfoD8NtKXQo2RF2/rrHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b33RIiFga7mVcNPLuoaeJkZOVL1mi+UPQ3Q92Uk4BDGU27B15UExGehVXq3+DqZowVZ6ctf/1LpST8feb8BeylK8rJoAd7iL8+7fq7n3NctJvdYAMUJYV3BWYttb8wtQ3WAmC79P+vAsatyXSgE/SsfmtHdnHNBMj97JHnHIzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pb5DAA+c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JH1h90023335
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rr9m4DMV8aM3HvFiWVF1zTeq
	HFmihXvF2giDIBU/QsQ=; b=pb5DAA+coH5BVtUjj8b5Hu1IkemhWAwRmVfAElzp
	cBSBiiL2CPX1NDt68CG5HsjIbYaiFd4tp7qMyl4O6NClQI52Umk7mTOaLrVr4WWZ
	cEzrDll4UydgZlofzt7bftqaxQxxuSKR0XtkG0TAdFmGZ4GfiphiW8NbValyFYqW
	5p2OzUMCA5vyCW1ZBaQdllPryjXxhRBvmHGUMdCIIRctKaxMxW7ChxRFRug8w4X7
	f+tgfjoYm6JVL+me04SF7OyWii9AG6KTNQt5UXJd1fn3buPPnGqjtBbbeas+MG7k
	HjB8tXs8JHiy/lo1bpuczgHHofOFFsGmzbnzAm4vuJA9Xg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vmkb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:43:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a88dd0193so128288876d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629005; x=1756233805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr9m4DMV8aM3HvFiWVF1zTeqHFmihXvF2giDIBU/QsQ=;
        b=Hkrn8O6fOWI1OWtNYvTbn6oJ1ylAg8GJt2i52dc3pda78HAv7o8KOIP2BHEeKK6T2b
         l/QA/826VjcY/iLMm6n42tiaQDcLsPuNtPw6qXCZa+Yn3LWxp83Xg83kKkC+mYvbw5sL
         8p1vHKbWyhpzuYkp1H83ABtZgpvLXln+hU0peiHdavE0kMtnq5+uMbNmqhM1HqMn6EbV
         vYfg1hV9lbttzgqe9IyQnXSA5GNeENz+XJzL3sEKDj/fM6ZtU3ApoT1h8Vl3PUDpSCIo
         z6Xk6dBjvUNqyuRGdfBwSLUFLpAiq4RrGf5PNYc9ynGoEsNaol498OY2/xkzq1lMz40h
         k30A==
X-Forwarded-Encrypted: i=1; AJvYcCWTAI9MF+JELfrUkBBDmfCBCtjaKaSJKuDo9n3Q2AKmCPcFuaXNgpY+Y4+e7Y9CztSI+oeiL11/9vu1Te8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSIYivnFX8Ud14jJhTF0e/6zSQniP75fB9XQ9s6uhM9Jpx916
	5LFD7bfTLVow6jdkqokgkG5+fKxQCUiT09bk1TRJF6X48wNbcdDQLhbeHGjtScal88zY7/1MwWB
	EemRn6fWRXJXSd3KONTV+EnLaJWC0yhc9Q79Wnwcl29YDYpV6ahQa+rOgZ4FOBQNzzQA=
X-Gm-Gg: ASbGncvI75NwXd4a02gvuA/GtPj8nUJRYEatson/6Px5Bv06632WrQnsPZsr2snTRei
	6D+cprnl5+WStHTuk8DmXJxGyEjcJJpRjTyxzoY88nWhCAFkymziBufgu13EHoy6hSFYav20LP6
	gun36iPlmA/Hvm3LLflezz3tY+Y7MnRNMRb9SXg/SYz4Fu2N1FXtHrOmvpsuzPAQz0Xq9kixY6J
	KItn5VlLWhDldbpC9juYUpB36+8VP1Qg2iz0QL3pqxc7xXR0foOmYIvak79OcMs2gpg2E9kStrr
	ojfFQqQvfc2EAoeIHCII9dUo49OqI7fYx8K9xElReAbsNbFXm3Kkr0kLAGiXHradT993Unt4DF6
	8pOwNWDDVJeNGHkxkVZI4HjBV0xI63Ws9SAYNKMHyvXmkh7xEx1Cz
X-Received: by 2002:a05:6214:509c:b0:709:8665:f839 with SMTP id 6a1803df08f44-70d770c81d0mr481276d6.43.1755629005007;
        Tue, 19 Aug 2025 11:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT7lpRowLXX5OExQQfbvb5w4hCurs0f1Zuh/FVoSxEHFuy1zmq+FiaB/ZvhSvytDdn5I2dtg==
X-Received: by 2002:a05:6214:509c:b0:709:8665:f839 with SMTP id 6a1803df08f44-70d770c81d0mr480776d6.43.1755629004281;
        Tue, 19 Aug 2025 11:43:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a43a34asm25743821fa.24.2025.08.19.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:43:23 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:43:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Message-ID: <6zlydkdgmowqg7cv5eeoaf7mrpnhzokyvhh5xasvznqaxnhdji@xol3jiz2lzld>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
 <20250819-glymur_pcie5-v1-4-2ea09f83cbb0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-glymur_pcie5-v1-4-2ea09f83cbb0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfX52STC9Gzkqsg
 au+xfi+YNnViNLLzmRutnjla5bY43FleilFPTPJCk8xqTYs3aA9DyDXh2BvEKgB2KwW3s0oKnEo
 hHZHmqQghWbg13dmFyKcXUNXuLb+Ni9vl33cDMFpU12hcnTmvnpr7uPYJEw6sel8R1hTvIr5RoS
 iAGRT9hZ/L/MOOxQ4G0P3mjfVkZCEzCJlLd5eu+oqEigRHPpB+vuapZ3bm0gGAV2UBj3Hy0z3Vr
 JvjwJSF4NSxhHScwGH3+qvae9+XQqCBjeXxjtzc8BBDT1QV3LGxBrfgE+CM1hocaahlmm+49j51
 FO7ZdT7yih0jsaNcIIXdUSUAAKHYCPAr+Ny9wnIPDjV8Vj2/90Qby3XqtPLVau2ZNxOLHli5iYe
 mcLSYKny
X-Proofpoint-GUID: WXFx5fgpAnzHmfF_bNwnQaT83YiCn5gh
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a4c5cd cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7qyaTA0qGF2Sjt_gT38A:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WXFx5fgpAnzHmfF_bNwnQaT83YiCn5gh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139

On Tue, Aug 19, 2025 at 02:52:08AM -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..e422cf6932d261074ed3419ed8806e9ed212c26c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -93,6 +93,12 @@ static const unsigned int pciephy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
>  	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
>  };
>  
> +static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_START_CTRL]		= QPHY_V8_50_PCS_START_CONTROL,
> +	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V8_50_PCS_POWER_DOWN_CONTROL,
> +};
> +
>  static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>  	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
> @@ -3229,6 +3235,10 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
>  	.ln_shrd	= 0x8000,
>  };
>  
> +static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
> +	.pcs        = 0x9000,

Even if the driver uses only PCS regs for 8.50 currently, I'd suggest
describing the whole picture here. Otherwise it might backfire later, if
we add offsets for other blocks later and they won't match the ones used
for Glymur.

> +};
> +
>  static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>  	.lanes			= 1,
>  
> @@ -4258,6 +4268,22 @@ static const struct qmp_phy_cfg qmp_v6_gen4x4_pciephy_cfg = {
>  	.phy_status             = PHYSTATUS_4_20,
>  };
>  
> +static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
> +	.lanes = 4,
> +
> +	.offsets        = &qmp_pcie_offsets_v8_50,
> +
> +	.reset_list     = sdm845_pciephy_reset_l,
> +	.num_resets     = ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.vreg_list      = sm8550_qmp_phy_vreg_l,
> +	.num_vregs      = ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
> +
> +	.regs           = pciephy_v8_50_regs_layout,
> +
> +	.pwrdn_ctrl     = SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status     = PHYSTATUS_4_20,
> +};
> +
>  static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
>  {
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> @@ -5114,6 +5140,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy",
>  		.data = &qmp_v6_gen4x4_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
> +		.data = &glymur_qmp_gen5x4_pciephy_cfg,
>  	},
>  	{ },
>  };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

