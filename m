Return-Path: <linux-kernel+bounces-740487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C2EB0D4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DB51C22AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA38C1EB9FF;
	Tue, 22 Jul 2025 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BoVWvkHA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDB02BEFE8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173495; cv=none; b=STFJ/8OEQevOKe/+JkH01ArHI5PDPZAzKffomY+b0WzFVJ7oGETjTVJ+K148zPgzz0Pv2DOfD46HyQ+KndlRKKErDkiXrI0wwn/z4GqNoVEBM8pYkIl7h4ZG+sRe2dlA7/kx3pWc0+AEolrTQi7hrow0DOnlEneIbxYpERdDJCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173495; c=relaxed/simple;
	bh=lmIvWyBDeEiVaN97TTNHpP5KW9wFUzTN08PUdWFTNPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK2vjLxMzo0AjCOlXx/MtF3nCGo4DIidaYv97S4KxcS6l0tXHafMvNYSNxSaKeD8JfPBLPqYHSW+V3F8rrv4UllL7RW/n7nDrHcfaZpoBMz2FClAC1hnEFthF3CyAUMKK1yyaJfLVEnea+9uaTTHU4V3Uug/XjVZlDQhbwrFFRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BoVWvkHA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7GInq015134
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1LN3juNr35Nerg/PZAItQ7sh
	/peCDRI4YAsD2qwMZyw=; b=BoVWvkHAGvdAI4rzH7r1eOMj16IDjtqa4Ny/iBq+
	mwlDIczIE1TwFupSa1JXzY8AWNzdlKSQY+kkxCOFOZiGfZpkCxbUnjdP6Ie6J75I
	aDS46WDDUjsAL08I9iJyVSvdz0UqXSxx2TBpTrCGaNtYvWqMjuiDA9IQ34yZBwYp
	Pc/+E3AAvKXl6JwXRqZXWzdPr82LHGc9+wOKc4Qayh3nMELJ2qlpjr9LX3Kv0ik6
	E8bKze18XmZJgAtwgKCk2EXECWMnKR1qWv3usaIlgwQw/r4T6bdbAmVJgNjlWzQk
	PMfmjttFiIhSKnyBKOYL8pk+qolWY5Oosb3qmA8+bzKAvg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804n9y4a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:38:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e095227f5dso825777885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173492; x=1753778292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LN3juNr35Nerg/PZAItQ7sh/peCDRI4YAsD2qwMZyw=;
        b=PmAUlQX+XRsBBXKEl4/i+i+WhEcALkTKDs6I/lcCOuS/IpoKYCc0wIU+qH16Yw+8vM
         oUlTBkwXESnUOx/6zOB4PYy6F2jtUcaxTAwMzP9WcG1t+q/8oaMTRKypOVb3+13MzYe9
         laW27h0j5y8i9ia/7wJikO34x+6pbafMW4gbZZmzmbKuM0MAgduN9A0oUMAg6GFICZ8F
         WvBnAdYSS7FIjQkJ9AGnCTLY02OVOKX97HChY21lidImlZYp2Yo5xKwRq0SJbjshMijI
         8TMpDav3Uh9KtQefe+XKzlrs57V50qqZFAEb9RRGZmA23TmqFxfiDfAnna2pTHMFoUkZ
         VUyw==
X-Forwarded-Encrypted: i=1; AJvYcCUFZ/KcYlRQpF8QSOqbsKVwbec4VHRxrgiogeLnLA3Bp1j50k0bHxnWFuW20oKzK0zm+OB5jO5P3IWsx/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bsFSs1LJfnsomJrRfnr76zdSBfsE6ko88rOzNK7GVr76bGST
	5oAYyfi9aj4XHxIaqxxUqOP9iwQX+R4P1NZJDOcjM4RNXsNAdbs12saUGmxERP3fohlBySn9QOr
	aF1eS+VZcZ8LoGDF/ZAoqnwJ0IVnOEkdI99Fd5wIDUVQMCMLONLa4VroLXY7vq+kgwEU=
X-Gm-Gg: ASbGncsnyabCR5cIdkjzRK1E6ebdrODshmv8+QH1Q5/BdJa/W3ZyGbSCoIlik3XmuKF
	ni8Mgs0km+ltWXEFI9dOpDG53qHE9l7oQA71h4I4qCna+Nm841dl5bkiFLOd9ONuUh/wrZ2bsHy
	0eJtufc41P8PXD9HRexGeuDhkCsQHVk3TWeHudph+tgd9N6WZB51m9PodQIxamnZl/HJXu2132o
	G8xlkFGxqreFJVTFSE5eP1IhCVdBP2bNmNWIB9kdj4HHuNblkDTKusd/5JLktKVyQQpS9Cf+lEE
	oo+HXMzE72aX4W3j5zbZS7+OaO4pdQixJAXhEcb3fD5C1s+53jrM1rpNys0cQzgBnZu2kUJFzWz
	RM8KcHNWfEKy0cKVnYbXmtkgt40mJiG62Tj1F/k8AKOKzynH9UHHo
X-Received: by 2002:a05:620a:406:b0:7e3:4413:e493 with SMTP id af79cd13be357-7e34413e881mr2290740885a.59.1753173491881;
        Tue, 22 Jul 2025 01:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFbsL3wu7P/XdnVzAH3W4UCqCA/Ov1LUyaPJbXnyrUZTuDLtE4QZ32mMPQ6V1IvABbTSx6EA==
X-Received: by 2002:a05:620a:406:b0:7e3:4413:e493 with SMTP id af79cd13be357-7e34413e881mr2290739285a.59.1753173491349;
        Tue, 22 Jul 2025 01:38:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a4ba29d2esm101582e87.59.2025.07.22.01.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:38:10 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:38:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        konrad.dybcio@oss.qualcomm.com, fange.zhang@oss.qualcomm.com,
        quic_lliu6@quicinc.com, quic_yongmou@quicinc.com
Subject: Re: [PATCH v2 02/13] dt-bindings: phy: Add binding for QCS615
 standalone QMP DP PHY
Message-ID: <jemfu5sy7k4a2iar55im5bhyhxzlrwpftmpqmps3b2tco7r6a2@oodls7gi45yy>
References: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
 <20250722-add-displayport-support-for-qcs615-platform-v2-2-42b4037171f8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-add-displayport-support-for-qcs615-platform-v2-2-42b4037171f8@oss.qualcomm.com>
X-Proofpoint-GUID: uRDgjNKtn-cdVXMPLeLDib1_j8gRock8
X-Proofpoint-ORIG-GUID: uRDgjNKtn-cdVXMPLeLDib1_j8gRock8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3MCBTYWx0ZWRfXx2e4iD2a9N7H
 QSlaCcgtp8HjG/qGuAyK4J5fY6kUiyQQiyuXIhkZSk+5ZV9oIkeW/QINdawnHZBoF/zyB+3i1g7
 0YVfdpiNogSuKmUXCvgn/tSklxTbhQSBr6uWRsCyx8o7LrQuwl+gKh4/FXmdnAzPJyzVVwSfiEy
 G9SBG4JJNnKYFX9qg2eBJqe4jgZXYHTpxlL7mhrsNC/4/zcSLPMKOlYuJrZMlC63Riff6JpL+Tq
 Cv5PQQm7k634fYJ0sFLnUA0kdbg7dIHcyEusFvKR+CvDhpkUhAciqOQvhXcwwWlaTH52bdoRqjN
 gzyjvcdAJusMFBOZJstwxiCI56DzSabKLgM2vyITVz0gZvuGuhZr+eJua+yIgZRnd80/vtyqksZ
 UuVCooNIzUnBWriMXEk1p13NzT4PZA8lmQy0WwBrw8TiJz609GdOrJvwCsRRmTJ94J9NlZrL
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687f4df5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=BMzRNCE2on2YpiivjS8A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220070

On Tue, Jul 22, 2025 at 03:22:03PM +0800, Xiangxu Yin wrote:
> Introduce device tree binding documentation for the Qualcomm QMP DP PHY
> on QCS615 SoCs. This PHY supports DisplayPort functionality and is
> designed to operate independently from the USB3 PHY.
> 
> Unlike combo PHYs found on other platforms, the QCS615 DP PHY is
> standalone and does not support USB/DP multiplexing. The binding
> describes the required clocks, resets, TCSR configuration, and clock/PHY
> cells for proper integration.

Simply put: no, this is not correct. Even if you go to the SM6150 block
diagram, it points out that DP uses the USB3 PHY, not a separate DP PHY.

I thought that we have discussed it beforehand.

I can quote my comment from the previous thread:

>> No. It means replacing extending existing entries with bigger reg and
>> #phy-cells = <1>. The driver must keep working with old node definitions
>> as is to ensure backwards compatibility. New nodes should make it
>> register two PHYs (USB3 and DP). On the driver side modify generic code
>> paths, all platforms supported by the driver should be able to support
>> USB3+DP combination.

Looking at the hardware memory maps:

MSM8998: USB3 PHY regs at 0xc010000, DP PHY regs at 0xc011000
SDM660: USB3 PHY regs at 0xc010000, DP PHY regs at 0xc011000
QCM2290: USB3 PHY regs at 0x1615000, DP PHY regs at 0x1616000
SM6115: USB3 PHY regs at 0x1615000, DP PHY regs at 0x1616000

Now:
SM6150: USB3 PHY regs at 0x88e6000
        USB3 PHY regs at 0x88e8000, DP PHY regs at 0x88e9000

I do not know, why msm-4.14 didn't describe second USB3 PHY. Maybe you
can comment on it.

But based on that list, the only special case that we need to handle is
the first USB3 PHY, which doesn't have a corresponding DP PHY block. But
it will be handled anyway by the code that implements support for the
existing DT entries. All other hardware blocks are combo USB+DP PHYs.

Having all of that in mind, please, for v3 patchset implement USB+DP
support in the phy-qcom-qmp-usbc driver and add the following logic
that also was requested in v1 review:

>> Not quite. Both USB3 and DP drivers should be calling power_on / _off.
>> If USB3 is on, powering on DP PHY should fail. Vice versa, if DP is on,
>> powering on USB should fail.

> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  .../bindings/phy/qcom,qcs615-qmp-dp-phy.yaml       | 111 +++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-dp-phy.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..17e37c1df7b61dc2f7aa35ee106fd94ee2829c5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-dp-phy.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,qcs615-qmp-dp-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QMP PHY controller (DP, QCS615)
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description:
> +  The QMP DP PHY controller supports DisplayPort physical layer functionality
> +  on Qualcomm QCS615 SoCs. This PHY is independent from USB3 PHY and does not
> +  support combo mode.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qcs615-qmp-dp-phy
> +
> +  reg:
> +    maxItems: 4
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: cfg_ahb
> +      - const: ref
> +
> +  clock-output-names:
> +    maxItems: 2
> +    description:
> +      Names of the clocks provided by the PHY.
> +
> +  qcom,tcsr-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to TCSR hardware block
> +          - description: offset of the DP PHY moode register
> +    description:
> +      DP PHY moode register present in the TCSR
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +
> +  vdda-phy-supply: true
> +
> +  vdda-pll-supply: true
> +
> +  "#clock-cells":
> +    const: 1
> +    description:
> +      See include/dt-bindings/phy/phy-qcom-qmp.h
> +
> +  "#phy-cells":
> +    const: 1
> +    description:
> +      See include/dt-bindings/phy/phy-qcom-qmp.h
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - clock-output-names
> +  - qcom,tcsr-reg
> +  - resets
> +  - reset-names
> +  - vdda-phy-supply
> +  - vdda-pll-supply
> +  - "#clock-cells"
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,qcs615-gcc.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +
> +    phy@88e9000 {
> +      compatible = "qcom,qcs615-qmp-dp-phy";
> +      reg = <0x088e9000 0x200>,
> +            <0x088e9400 0x10c>,
> +            <0x088e9800 0x10c>,
> +            <0x088e9c00 0x200>;
> +
> +      clocks = <&gcc GCC_AHB2PHY_WEST_CLK>,
> +               <&gcc GCC_USB3_SEC_CLKREF_CLK>;
> +      clock-names = "cfg_ahb", "ref";
> +      clock-output-names = "dp_phy_link_clk", "dp_phy_vco_div_clk";
> +
> +      qcom,tcsr-reg = <&tcsr 0xb24c>;
> +
> +      resets = <&gcc GCC_USB3_DP_PHY_SEC_BCR>;
> +      reset-names = "phy";
> +
> +      vdda-phy-supply = <&vreg_l11a>;
> +      vdda-pll-supply = <&vreg_l5a>;
> +
> +      #clock-cells = <1>;
> +      #phy-cells = <1>;
> +    };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

