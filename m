Return-Path: <linux-kernel+bounces-602349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA203A879B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF2B3ABC72
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D7D1F2360;
	Mon, 14 Apr 2025 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aBHAiRM7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D651F3B8C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617796; cv=none; b=i+yExx3SHmEWGPpBiDKn2Njtc/D5yfZg/INuRfPHAwAOu0pjfyS90STwrUCn396e6t6X/YNRq3bDoHlRELgLQlo8O8haTPQeok0dOEK1MP7W4FoXLmdSLvuitYo0D48RTbcKqbX2m49oWTWaW2rQ7Yhlf7JdGXNR8srDgUEzU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617796; c=relaxed/simple;
	bh=uph4zHoLG9oMayUKP51V7Ui3CVrfNf+hdd0i3wJU+DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei33MPbL2U//P7UeDEjx+0vsEncn+cx1f3VIstL0RBwy0qoPKehQ6D7ve5ncK7QiqBrDudkpvN/RjLmKX4GxyGszfaZHnlNVdn4bVicIgdu4bi80X8h/23kk6qPmjC81E35+8XDk7vIalkvpijniSTRlaGQrp4yc4A2f6C/Q3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aBHAiRM7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DM140m016697
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 08:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EiwHhk5vFVCbL/7IZb2Z7mJo
	tSciivUHSnNHCf6n2sg=; b=aBHAiRM7Q1VfL1y0K6s3z+x/5ZKAsAY9QlbSd8aC
	iSd30+jetXyNpi/691BqB/PwLpKDQN+bfF5wqA0zU3pLQpj1rmoS2IZXDFBxA/Bd
	eauPqAO1Pe/YZDPATzcvLVY5Bl9SpJqgsN6YmNVhugyyJi/jFkZeVXZaPuSjW5sx
	oHMMDsDWKytXXloFN2OALp80xj9Wj8NX06CYtrU9IV7IgT+oNmw7QJlqgFPwnPmB
	BpvFDqpuEPRF5giNDnF1yrxE3+174py2MJfShAcEKKtvvzdXVa8fDvqVj3mBzheM
	vhlOjbTq9n3qvzgP1t9jE/SXcd2hxZlJtLi/HIpN7SZveg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhfcuna2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 08:03:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c790dc38b4so664097585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 01:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744617792; x=1745222592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiwHhk5vFVCbL/7IZb2Z7mJotSciivUHSnNHCf6n2sg=;
        b=lTpX1Unxy5ZqURHLpeIaqJ+GfH5RRRQvta59AvI6Mi3l8E1iaUedsiXZkd1awt+w7q
         WeSX/LRz0lEYLzURIvgo/1G08kgXjezd2eR4lrgciCGxTzak6ulw4PChCOf4mB266kja
         iYvHPrEOkKIApDqSYJD525rvVOkc1rsnnC5pJ3y7Spvio+MbGISIiukcFmI2jf1QUKOf
         whN87w4T8fT+rLEfKkvV4qkBWCEKIPUsAhk/pVwTnOVqhQdoTs7Cf76SbdBBJtmqAgzw
         XIgS8xmHVOoYAOGkUnDLNKeMI96Vmz/usZvmBZLEENqeZ/3iP0/4Tcc/1hxLSJWEx13s
         w6YA==
X-Forwarded-Encrypted: i=1; AJvYcCUPbxKMW2iRnvkAE3eteQ3a/W7GBIqrGKFsyprzp5H9OOLqJqjGnxJXVMv0lxZNh5ov2j3ygibuS5Jqr1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmk1byG+zNzZSmmA6HUcD8CsJfHreG/ceFGHxuk+YyaKnZu6tP
	uQ+6/h9Ewu1OL8RMxiNHXjSv5+SCUo7PZ+W4Q8g47TMjlVubJazJJtuai7tEfyELcq5kNzk9rrc
	U49z/n0cZFVcGIdn19Y6hlAHiV24Yt6lP2lEHeZDj++u9Ex0bl//Dd583NHP6OfSSwAxTzOA=
X-Gm-Gg: ASbGncuhbt5U69tjNsbADMDsI/eu/Nc3miVxKixTH8qmd15U1w1IeTpYM9t61zNArgg
	LU18BOsNtnQxDx6XzsYHDhbdhGLD1A9892fOICD41+kc+paJ5p0yhcHGFKhvMB2h2SbnZ8WF2f7
	rHVMHsGgebY1yQF5iiAfSS3HcrReYE53ux+6632JPbdBAQNdDed5Va/+5uD0k5EwDhmR9xUVx+4
	sPvVrqrvH8r5YC0j7dW5GOQobosBHEOj5sBmJp4p1zn+7vo78224oyu5FZkToHQd8xKfWpbqNHx
	DUXlIXS+s0fJk7N2ouVjYandoatyMuC2wFKTvuUAn5izOB+QgpyLrEVD5WFwsoZyqBPd8LZfk/c
	=
X-Received: by 2002:a05:620a:d87:b0:7c3:b7c2:acf6 with SMTP id af79cd13be357-7c7a7675c27mr2162277085a.15.1744617791923;
        Mon, 14 Apr 2025 01:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESZN07wYmkacvSwp8lFk2vRdDEFr2/a3rzDrW2cfKAF3hpIHMbwXYQcEMnw4snP4Wfu7vADQ==
X-Received: by 2002:a05:620a:d87:b0:7c3:b7c2:acf6 with SMTP id af79cd13be357-7c7a7675c27mr2162273685a.15.1744617791394;
        Mon, 14 Apr 2025 01:03:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d521931sm1022102e87.257.2025.04.14.01.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 01:03:10 -0700 (PDT)
Date: Mon, 14 Apr 2025 11:03:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
Subject: Re: [PATCH v2 0/3] PCI: qcom: Move PERST# GPIO & phy retrieval from
 controller to PCIe bridge node
Message-ID: <b5ucd2ypwk3qv3pl7cij5geg6e2bt72xqb4hx3yvpei44wdc7c@ub5cujnfvz3d>
References: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=67fcc141 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1xens5CjvSCak2KtytIA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Zvl5kHXfwKIxyfVi7ZDTZ1KAo9mGsYrn
X-Proofpoint-ORIG-GUID: Zvl5kHXfwKIxyfVi7ZDTZ1KAo9mGsYrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140057

On Mon, Apr 14, 2025 at 11:09:11AM +0530, Krishna Chaitanya Chundru wrote:
> There are many places we agreed to move the wake and perst gpio's
> and phy etc to the pcie root port node instead of bridge node[1].

Which problem are you trying to solve?

> 
> So move the phy, phy-names, wake-gpio's in the root port.

Is there a reason why you've selected only these properties? Is there a
plan to 

> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
> start using that property instead of perst-gpio.
> 
> For backward compatibility, not removing any existing properties in the
> bridge node.

'don't remove', rather than 'not removing'.

> There are some other properties like num-lanes, max-link-speed which
> needs to be moved to the root port nodes, but in this series we are
> excluding them for now as this requires more changes in dwc layer and
> can complicate the things.
> 
> The main intention of this series is to move wake# to the root port node.
> After this series we wil come up with a patch which regiters for wake IRQ
> from the pcieport driver. The wake IRQ is needed for the endpoint to wakeup
> the host from D3cold.

This should have been in the beginning of the series. In the next run
please include the functional change to prove that this is enough and
that you won't have to restrucutre DT bindings again.

Please include the note about merging order. You have to mention
explicitly that DT bits must go after the driver changes. Ask
maintainers to provide the immutable branch with the PCIe changes.

> 
> [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v2:
> - Remove phy-names property and change the driver, dtsi accordingly (Rob)
> - Link to v1: https://lore.kernel.org/r/20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (3):
>       dt-bindings: PCI: qcom: Move phy, wake & reset gpio's to root port
>       arm64: qcom: sc7280: Move phy, perst to root port node
>       PCI: qcom: Add support for multi-root port

This order of patches suggests that one can merge DT bits before the
driver changes and that it will still work. Is that the case?

> 
>  .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  18 +++
>  .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  17 ++-
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   5 +-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi     |   5 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |   5 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |   6 +-
>  drivers/pci/controller/dwc/pcie-qcom.c             | 149 +++++++++++++++++----
>  7 files changed, 168 insertions(+), 37 deletions(-)
> ---
> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
> change-id: 20250101-perst-cb885b5a6129
> 
> Best regards,
> -- 
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

