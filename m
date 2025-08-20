Return-Path: <linux-kernel+bounces-777588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F5CB2DB47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762215C7737
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886832D372A;
	Wed, 20 Aug 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I/khlice"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EDC217716
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689828; cv=none; b=WY0PLPbCNoaB4GsbcSND3+30BGMU1mYbVwmMhOXDqO8OuvnZhBWUq9/2ozO4vwjh+RWk72guCj7c7dpqrY4dYaScB8OA/+jxSnQueH9CXCDHtydAOHCR7sGLl6Z9BmgVZjPdMOnuHy0kkmTnVj2+tAMwnreGV8RRjrawlf4qBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689828; c=relaxed/simple;
	bh=McQx1552YMg8zQBWoN19odePlUMnW+PahZRcsctyceg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsdD7fhPE41SzECLEYgMdRnvUrvePsgAywS6mGoIOCaLQ1uhjzkk+WzHq6SWVwtJZjlZVbiw5T2NixenE8NNhub7FoL/f1p5HPaZKnX+BOZkVPC/3c2VxbMnkYSbDgQDP69FpHbf2eSO20UPkKvtAWEdq64RP1dUbTHTtZ1v3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I/khlice; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9loZJ008771
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kG5EvtRUaQfCBV/YBpEi6527
	Mm9dhLGyA7HIWyFmk/A=; b=I/khliceukaDzXQ4a8TO8U8d64C7c9DcfnKPgEeI
	MMsXt7NdF862BBfRS+lSt2wt+/vskLgWr1umAzOsSxswVBPai8z0YCfJYyvnOCT9
	Ypygujq0WaGH8GRWYcmBe9HZeySZTPrQ/DjBhYRdAHf7alncQvu3s3OXFDmRIPhS
	0sfrPgtsH7V4ng8jaxFIqTUfdoY3lvQjdZjMHkvB5kNhUmnbov2elZvLSBaWY0sH
	dSudDwJQwoL99/4IT9IVXYTcisHes0jI2f7FtdbS7JZf0lPoqWCvl0X9bCVS5yP2
	OnxWbSZ8bXMKzmhFnEFdp8LsbChMmrv1TptxzocLl9jQAA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a1kaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:37:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8706a5e78so2889819885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689825; x=1756294625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG5EvtRUaQfCBV/YBpEi6527Mm9dhLGyA7HIWyFmk/A=;
        b=Q8y7jaGoVGL2cG2pz2TI0eCo0YnqkafJaPR/UCRPsgwg3ouoJOZ2don9EMd4dhFaan
         AvZgXgr9iD+ZPt6CVYCdc2272zuWGassYZ+JF0htU7J3jU8tM2+hNWR7NfKQVPWwNekI
         cCosLUYV0+CASlIJzn0bd/Po4cfCyRb42aQYS25NkAPaR3Xo3RIl+vKRQqbxw+Vy6zKQ
         FdOmyyjTFV1/Pu6eQuQlvQIjn6qq8sT/bNFCU2p444UrFntGluDdy5eGNme9G3pFfonh
         wKst+huepvIxF0MBSw95eBAxC57YTaRvSO7sTIUSDeh+UdrQLanwpVn+c7DkOMne9XSA
         g1dw==
X-Forwarded-Encrypted: i=1; AJvYcCUj9zXPnhotLJEnDXEQIY0RFQFEbJIoRUFaPqk9DdLcGSPqL6PNWhp8LtVrptn6a8j52NwUYJtE8pqZC5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmps5cu5N94EaaeTGe0DotCvtQIJVkdHcwdJnwmvU9/Lchxs7m
	HEIntNkd9Na+EcHODVZXikgVy3+U2xW3gS3QPdGRtProHNJ4QRrN1rH7HK58Dae9Uxb85SJZYbn
	M8b1vs15/9shQSSyCoXP7iLqEKIuoaKe5vjxtVOgazf8LLQdiGPEmgOykaNF+qOB9WtQ=
X-Gm-Gg: ASbGnct3JJ0bYc9y5NI596h/sXoBz24tffvqkMRVwGJUe72Oo+CCEwvNDpmON+yOFNH
	FEi1PF/9guiq2tVlZGhCbJrrAbBaGXJG0JeR8GXqWqwirPAlZKJExgtLzlB0gGduuDyVHoIV5x+
	JlN2S/M+m9bLPNzkWrxHcSI227/CxGEADcLc+nL4DPa7Clt16F+V9bPFiCT23Fb6HQttHlLgBus
	9IhqVh0vQYBbO8oYuXr5LZIjipRD/WtvABrd8h71i7gxXuxvlgeuXO6Sm833a8/IrAq9bQOBlJP
	/Meyy+FuybgUYwmxyiWGko/6pK/k0Tdbt92/YAgIZ0ZLxSwmu5xWZKUqNiKVrhWpbuejDWzxmd4
	wDK9FmrphIfaudquosL1Yqs1fGOnFWx2guvcSrv1C6KUwFkuuCszI
X-Received: by 2002:a05:6214:c28:b0:70b:af39:8596 with SMTP id 6a1803df08f44-70d76fae59cmr27614586d6.28.1755689824719;
        Wed, 20 Aug 2025 04:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF8uDY/KF39ETwmmHdeKUKsc98VcWiJ/Iu9zjHm6WFS5DWcH3CpZlDmrVqK45d2lN37i/9GQ==
X-Received: by 2002:a05:6214:c28:b0:70b:af39:8596 with SMTP id 6a1803df08f44-70d76fae59cmr27613786d6.28.1755689823518;
        Wed, 20 Aug 2025 04:37:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a41e3cfsm27543291fa.6.2025.08.20.04.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:37:02 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:37:00 +0300
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
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
Subject: Re: [PATCH v3 02/14] dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
Message-ID: <tlilctwavwqw6oy46l5fote2pa6f4hdy2im6meo56cjaawba3a@a42bwbbfnsuw>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-2-a43bd25ec39c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-2-a43bd25ec39c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a5b362 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=7souUVsdAZ2KeZQVA08A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: pQi2PdTP64gFWPsAkHI4wGpRhMzV6_Vk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX9+Orr/ASmHeE
 +H1KCaYVrK5qyF5UzTuk97KHr7nX7ovJT+Gvh0EIEcO9/or7psYvOxt93dlP7iW3u7y2F2eG0IO
 KSX/i5fmTO2qJ0xZXCv4NXuHa+xnj8o1NCZ5nggjYB4fI7011JK0NM7EZjW/VYMrON0Ry5PfuCc
 y2S8g9ifzG5WinQ4o9A/1Q/zTz9HREtmG8NV4hVUn0olAuGodmQCxbW5j13KE44R9MlpSe7Clij
 1hkaFDB9Mbi4kG5u7m8SPsKq6AZVIMTs/0giyYua4R6D5vDbRN6HeYKz492JsqWXAgBnkO/l+j6
 f1cekCrIn30BtqgQaWywcheA4cBIMhzRCI7AlMaUFEq4JYD7lhtwn0DeNKZQTrDucr9gPA/ZhmV
 nnis5/gqaLreF+LyGOqUVR9CnkrZrA==
X-Proofpoint-GUID: pQi2PdTP64gFWPsAkHI4wGpRhMzV6_Vk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 05:34:44PM +0800, Xiangxu Yin wrote:
> Add device tree binding documentation for the Qualcomm QMP USB3+DP PHY
> on QCS615 Platform. This PHY supports both USB3 and DP functionality
> over USB-C, with PHY mode switching capability. It does not support
> combo mode.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  .../bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml   | 108 +++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..c2b1fbab2930f0653f4ddb95f7b54d8fe994f92d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,qcs615-qmp-usb3dp-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QMP USB3-DP PHY controller (DP, QCS615)
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description:
> +  The QMP PHY controller supports physical layer functionality for both
> +  USB3 and DisplayPort over USB-C. While it enables mode switching
> +  between USB3 and DisplayPort, but does not support combo mode.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qcs615-qmp-usb3-dp-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2

Missing GCC_USB2_SEC_PHY_AUX_CLK and GCC_USB2_SEC_PHY_PIPE_CLK

> +
> +  clock-names:
> +    items:
> +      - const: cfg_ahb
> +      - const: ref
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: phy_phy
> +      - const: dp_phy
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
> +  qcom,tcsr-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to TCSR hardware block
> +          - description: offset of the VLS CLAMP register
> +      - items:
> +          - description: phandle to TCSR hardware block
> +          - description: offset of the DP PHY mode register
> +    description: Clamp and PHY mode register present in the TCSR
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - vdda-phy-supply
> +  - vdda-pll-supply
> +  - "#clock-cells"
> +  - "#phy-cells"
> +  - qcom,tcsr-reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,qcs615-gcc.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +
> +    phy@88e8000 {
> +      compatible = "qcom,qcs615-qmp-usb3-dp-phy";
> +      reg = <0x88e8000 0x2000>;
> +
> +      clocks = <&gcc GCC_AHB2PHY_WEST_CLK>,
> +               <&gcc GCC_USB3_SEC_CLKREF_CLK>;
> +      clock-names = "cfg_ahb",
> +                    "ref";
> +
> +      resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR >,
> +               <&gcc GCC_USB3_DP_PHY_SEC_BCR>;
> +      reset-names = "phy_phy",
> +                    "dp_phy";
> +
> +      vdda-phy-supply = <&vreg_l11a>;
> +      vdda-pll-supply = <&vreg_l5a>;
> +
> +      #clock-cells = <1>;
> +      #phy-cells = <1>;
> +
> +      qcom,tcsr-reg = <&tcsr 0xbff0>,
> +                      <&tcsr 0xb24c>;
> +    };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

