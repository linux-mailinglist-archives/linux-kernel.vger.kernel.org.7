Return-Path: <linux-kernel+bounces-856238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB75BE3964
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C3E408431
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FB4335BA3;
	Thu, 16 Oct 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4Pu6sI6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89469335BA2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619682; cv=none; b=CJ/5ChjFCMPHXZGVRjijD6njn6K2LQG2TcWnzMMloAdXkPT+rUj1C94yLDallcJVCW5OK2wSWepYzS269F6CqEi0P5uj2Ux/nqymQWs34TnlS4PBm1SC37AEXF3DUFeKRSZHW/kwLGocVdiFtgnYLLPKOJ2pT29toNjWnDLzD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619682; c=relaxed/simple;
	bh=qXb1XoO8Rcab2MwMwV+iHpjwImn+WrVqCpt7sZr6S+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ducVV0w/BqurPTH/JEThSoAfN7KzXXyOr3X0xs2gQPANpDxwQWQnjkSEeagIbJMbx1MUbCOpWyXt72fvVtNlW7dcysga+CXVHHK3K5IY1dNkAWRdSeIQ2i9F3hHI0EL4J0y7iTrw+1/yoT+Lc/zB85zGXziTgPV6/ed6uV+YS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4Pu6sI6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7PGOk003643
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lOoCmU3FK8p4YHctcwVkp7NyEzPdsNMWVTf99V0SNrE=; b=H4Pu6sI6SfYCZoNv
	DPzGruOLqKRTVLTOaFOMP/wSawUuQWp5R4UxceBhvYN1+FUAApxbbc94dzXkZTsJ
	NU4iy4adLXNlts40YBdM7eVJtrtpK9I9ki8qDC9vDxiqEbhfeAZPsUbTWCUK8WW1
	Bx0Li/FZK63IiZv0UvPveSiB1MFgchv7bJJMZNytdUnnTZG7wh60z56eTjZiU8hi
	f9UchSdO+pMJW4hOTRq3TFniAZfqiDZvfNKIhlxfDAP/P0R+sCyY8KCZrtyxo6ot
	GaoGch/EbtJKoOyozGWzn/gC1Y65M5FkPDuvu/NJR8p07rY20ehN+35/8snnjyEB
	vYb7TA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd98dw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:01:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-89022a2981eso78633385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760619678; x=1761224478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOoCmU3FK8p4YHctcwVkp7NyEzPdsNMWVTf99V0SNrE=;
        b=vCFVFFRzqi+WCe+C5EFrgnuI8ivgzvbrlFAZtWfsgFyw5WCacsNC0iO5Tp87HGLFWd
         4oxB+gqz+o28GUf6PywSJuH6GYI2jKAAOHiWkG4/Er5OjEaI2r8+0iab5gSsDUP96LoI
         0fpGCFoZcBvvYdDnB2B6ZLoIO7i4GifH2HlRe8/PwpkDSWCUYKkYPIF9W8okRwVWafLF
         bQMak/219d8uUfTx0UxR5/EHWgxN3oAiIMN1fdgWKstLhpcwGCgbeH5AqD9TiG2mZRF3
         Pt4QF2UNNvl3eP26AicoDeptZprjlhWpJlCkvPJakvKnTxU1mUsNpwXZnsXkbzw3sZhp
         ym0g==
X-Forwarded-Encrypted: i=1; AJvYcCVn1JxnsFapaKMTRc12CpfHXPcS/ypMuDmhnTww1z4en+Rm0YtzheBeA57ciMU8MkR7lYQWq/AnmbtSFKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57MdupJydg2Mfe2Ohe6cXGbsMezL241Rtyk4N+JjaYl5CVMw0
	3X/OCRfiTPIYe/KqwkB8lPfzJwEdbvZyTRZavHeRckyiwNiHskhcwUZFLOlNv/PrEhky3PG6F8b
	Ryie6ckAIV2m5VQILQlaStlZQdVV73Xb/jk+5NlZu4xJ0GYLxln5or2FDwNskE6Hej+c=
X-Gm-Gg: ASbGnctaNWF9Zt6ZLx0mcgURY+QX6TbhzeGZ0PIFrPmN7p9drdDi4L5K7vcB39KLUZo
	5Z+39vHTCFsP6fCB1YBeDmy7n8ZJwH+p3ZJ1oiTF1rW5yCytQGrx2fW5zvLZ/EmtlIaEM1fTA2A
	GyWbpMTmw9/DqOgZElxgjWIy+dBVU4uK/SR4ZtOvdrZvzisIgDghFoFA0KjxRa4BL0evKwY4W1q
	pZ55liL3O5fWBZeshFanb3/XcIMSS6qAZOXgYSxNxqynlBgaSHFMfegBDvKrhnEy/UEOUiR9w7Z
	FpyO3dQ9QGwCxX52oZ5nZoHrkyWJcyV8LlhJUUUKYs89E2GL8rCIApEFHr9JJ4CnxMdVB2WhhW+
	AOA5wTUb36MyCtDQjph4Jk/aHRyjlywV9lZuBQTY5Ip5mesJzf6LpqwuSsEPqZSk=
X-Received: by 2002:a05:620a:45a6:b0:852:b230:2202 with SMTP id af79cd13be357-88354ea76afmr4310617185a.49.1760619673947;
        Thu, 16 Oct 2025 06:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1cYR672WhfNwRUL4xIcz1CTBk3GVUXvgO9v8Ao4Y5P8X2lqJHJSvMIx09uSEnclFHZLcREw==
X-Received: by 2002:a05:620a:45a6:b0:852:b230:2202 with SMTP id af79cd13be357-88354ea76afmr4310491085a.49.1760619663149;
        Thu, 16 Oct 2025 06:01:03 -0700 (PDT)
Received: from [10.111.161.126] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f38bf1f80sm190854185a.55.2025.10.16.06.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 06:01:02 -0700 (PDT)
Message-ID: <b4489d48-6ce3-4a48-a374-3852f4afc71e@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 21:00:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: dt-bindings: Add qcom,sm6150-camss
To: Bryan O'Donoghue <bod@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251016-sm6150-camss-v1-0-e7f64ac32370@oss.qualcomm.com>
 <20251016-sm6150-camss-v1-1-e7f64ac32370@oss.qualcomm.com>
 <edcdb19f-619b-4dc8-b3d2-8d54c9594aeb@kernel.org>
Content-Language: en-US
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <edcdb19f-619b-4dc8-b3d2-8d54c9594aeb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iI9EGH5s5RMwDLdvpbAzTbRjXhv4THZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX7AKMT2NHq8Gc
 RQQPSzfa32kK+oujmy9/zL1qO0pfhLX9RFlHOZVyaaXc8ATJNNREmBqU+Ecrhax+Usfm5purjUP
 t6L4AJCu97GaglKp0c1Uoo/F9jkInYp0Pmy13sCT+LUpAUlNYgPQSy0xCAEmHZjiTZMw0qLbdQE
 xlAuIRVGpAVTnAXXgDWOOoX+wErA6UtNWLTA4683g782cC7oQ/nH5iB23yewwnjoq0G+7/YpJh9
 VRVp+Izc+y8ePMCgVSHsbpGoF36gxhdTaEHVjYLfOjHhxbefaQTj6j/r9Gs5Ly6kbpWUsqju49k
 9dR4bzwY1riTmS9aINLHJyXC2rETm1nJKaYYxkS0/mwZb353Y/39PZF6dA4YAWi27tbfQGy6r+d
 GPRurQqMNLVlGU0F86qR26aHWRd2TA==
X-Proofpoint-GUID: iI9EGH5s5RMwDLdvpbAzTbRjXhv4THZi
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f0ec9f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=tlDJjdemDny6dp0K7XAA:9
 a=8-qNIi-7vQFwNDMI:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/16/2025 6:43 PM, Bryan O'Donoghue wrote:
> On 16/10/2025 11:22, Wenmeng Liu wrote:
>> Add bindings for qcom,sm6150-camss in order to support the camera
>> subsystem found in Qualcomm Talos EVK board.
> 
> Understood you are doing this to support the Talos EVK but the yaml 
> should describe the specific SoC.
> 
ACK>>
>> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>> ---
>>   .../bindings/media/qcom,sm6150-camss.yaml          | 283 +++++++++++ 
>> ++++++++++
>>   1 file changed, 283 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,sm6150- 
>> camss.yaml b/Documentation/devicetree/bindings/media/qcom,sm6150- 
>> camss.yaml
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..758bed0970f2ceee7df30b579a0f60d583a9230c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/qcom,sm6150-camss.yaml
>> @@ -0,0 +1,283 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/qcom,sm6150-camss.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SM6150 Camera Subsystem (CAMSS)
>> +
>> +maintainers:
>> +  - Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>> +
>> +description:
>> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sm6150-camss
>> +
>> +  reg:
>> +    maxItems: 9
>> +
>> +  reg-names:
>> +    items:
>> +      - const: csid0
>> +      - const: csid1
>> +      - const: csid_lite
>> +      - const: csiphy0
>> +      - const: csiphy1
>> +      - const: csiphy2
>> +      - const: vfe0
>> +      - const: vfe1
>> +      - const: vfe_lite
>> +
>> +  clocks:
>> +    maxItems: 21
>> +
>> +  clock-names:
>> +    items:
>> +      - const: camnoc_axi
>> +      - const: cpas_ahb
>> +      - const: csiphy0
>> +      - const: csiphy0_timer
>> +      - const: csiphy1
>> +      - const: csiphy1_timer
>> +      - const: csiphy2
>> +      - const: csiphy2_timer
>> +      - const: gcc_axi_hf
>> +      - const: soc_ahb
>> +      - const: vfe0
>> +      - const: vfe0_axi
>> +      - const: vfe0_cphy_rx
>> +      - const: vfe0_csid
>> +      - const: vfe1
>> +      - const: vfe1_axi
>> +      - const: vfe1_cphy_rx
>> +      - const: vfe1_csid
>> +      - const: vfe_lite
>> +      - const: vfe_lite_cphy_rx
>> +      - const: vfe_lite_csid
>> +
>> +  interrupts:
>> +    maxItems: 9
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: csid0
>> +      - const: csid1
>> +      - const: csid_lite
>> +      - const: csiphy0
>> +      - const: csiphy1
>> +      - const: csiphy2
>> +      - const: vfe0
>> +      - const: vfe1
>> +      - const: vfe_lite
>> +
>> +  interconnects:
>> +    maxItems: 2
>> +
>> +  interconnect-names:
>> +    items:
>> +      - const: ahb
>> +      - const: hf_mnoc
>> +
>> +  iommus:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    items:
>> +      - description: IFE0 GDSC - Image Front End, Global Distributed 
>> Switch Controller.
>> +      - description: IFE1 GDSC - Image Front End, Global Distributed 
>> Switch Controller.
>> +      - description: Titan GDSC - Titan ISP Block, Global Distributed 
>> Switch Controller.
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: ife0
>> +      - const: ife1
>> +      - const: top
>> +
>> +  vdd-csiphy-1p2-supply:
>> +    description:
>> +      Phandle to a 1.2V regulator supply to CSI PHYs.
>> +
>> +  vdd-csiphy-1p8-supply:
>> +    description:
>> +      Phandle to 1.8V regulator supply to CSI PHYs pll block.
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    description:
>> +      CSI input ports.
>> +
>> +    patternProperties:
>> +      "^port@[0-2]+$":
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>> +        unevaluatedProperties: false
>> +
>> +        description:
>> +          Input port for receiving CSI data from a CSIPHY.
>> +
>> +        properties:
>> +          endpoint:
>> +            $ref: video-interfaces.yaml#
>> +            unevaluatedProperties: false
>> +
>> +            properties:
>> +              data-lanes:
>> +                minItems: 1
>> +                maxItems: 4
>> +
>> +            required:
>> +              - data-lanes
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - interconnects
>> +  - interconnect-names
>> +  - iommus
>> +  - power-domains
>> +  - power-domain-names
>> +  - vdd-csiphy-1p2-supply
>> +  - vdd-csiphy-1p8-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,rpmh.h>
>> +    #include <dt-bindings/clock/qcom,qcs615-camcc.h>
>> +    #include <dt-bindings/clock/qcom,qcs615-gcc.h>
> 
> rpmh should come after qcs615.
> 
ACK>> +    #include <dt-bindings/interconnect/qcom,icc.h>
>> +    #include <dt-bindings/interconnect/qcom,qcs615-rpmh.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        camss: isp@acb3000 {
>> +            compatible = "qcom,sm6150-camss";
>> +
>> +            reg = <0x0 0x0acb3000 0x0 0x1000>,
>> +                  <0x0 0x0acba000 0x0 0x1000>,
>> +                  <0x0 0x0acc8000 0x0 0x1000>,
>> +                  <0x0 0x0ac65000 0x0 0x1000>,
>> +                  <0x0 0x0ac66000 0x0 0x1000>,
>> +                  <0x0 0x0ac67000 0x0 0x1000>,
>> +                  <0x0 0x0acaf000 0x0 0x4000>,
>> +                  <0x0 0x0acb6000 0x0 0x4000>,
>> +                  <0x0 0x0acc4000 0x0 0x4000>;
>> +            reg-names = "csid0",
>> +                        "csid1",
>> +                        "csid_lite",
>> +                        "csiphy0",
>> +                        "csiphy1",
>> +                        "csiphy2",
>> +                        "vfe0",
>> +                        "vfe1",
>> +                        "vfe_lite";
>> +
>> +            clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
>> +                     <&camcc CAM_CC_CPAS_AHB_CLK>,
>> +                     <&camcc CAM_CC_CSIPHY0_CLK>,
>> +                     <&camcc CAM_CC_CSI0PHYTIMER_CLK>,
>> +                     <&camcc CAM_CC_CSIPHY1_CLK>,
>> +                     <&camcc CAM_CC_CSI1PHYTIMER_CLK>,
>> +                     <&camcc CAM_CC_CSIPHY2_CLK>,
>> +                     <&camcc CAM_CC_CSI2PHYTIMER_CLK>,
>> +                     <&gcc GCC_CAMERA_HF_AXI_CLK>,
>> +                     <&camcc CAM_CC_SOC_AHB_CLK>,
>> +                     <&camcc CAM_CC_IFE_0_CLK>,
>> +                     <&camcc CAM_CC_IFE_0_AXI_CLK>,
>> +                     <&camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
>> +                     <&camcc CAM_CC_IFE_0_CSID_CLK>,
>> +                     <&camcc CAM_CC_IFE_1_CLK>,
>> +                     <&camcc CAM_CC_IFE_1_AXI_CLK>,
>> +                     <&camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
>> +                     <&camcc CAM_CC_IFE_1_CSID_CLK>,
>> +                     <&camcc CAM_CC_IFE_LITE_CLK>,
>> +                     <&camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
>> +                     <&camcc CAM_CC_IFE_LITE_CSID_CLK>;
>> +
>> +            clock-names = "camnoc_axi",
>> +                          "cpas_ahb",
>> +                          "csiphy0",
>> +                          "csiphy0_timer",
>> +                          "csiphy1",
>> +                          "csiphy1_timer",
>> +                          "csiphy2",
>> +                          "csiphy2_timer",
>> +                          "gcc_axi_hf",
>> +                          "soc_ahb",
>> +                          "vfe0",
>> +                          "vfe0_axi",
>> +                          "vfe0_cphy_rx",
>> +                          "vfe0_csid",
>> +                          "vfe1",
>> +                          "vfe1_axi",
>> +                          "vfe1_cphy_rx",
>> +                          "vfe1_csid",
>> +                          "vfe_lite",
>> +                          "vfe_lite_cphy_rx",
>> +                          "vfe_lite_csid";
>> +
>> +            interconnects = <&gem_noc MASTER_APPSS_PROC 
>> QCOM_ICC_TAG_ACTIVE_ONLY
>> +                             &config_noc SLAVE_CAMERA_CFG 
>> QCOM_ICC_TAG_ACTIVE_ONLY>,
>> +                            <&mmss_noc MASTER_CAMNOC_HF0 
>> QCOM_ICC_TAG_ALWAYS
>> +                             &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>> +            interconnect-names = "ahb",
>> +                                 "hf_mnoc";
>> +
>> +            interrupts = <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
>> +                         <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
>> +                         <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
>> +                         <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>,
>> +                         <GIC_SPI 478 IRQ_TYPE_EDGE_RISING>,
>> +                         <GIC_SPI 479 IRQ_TYPE_EDGE_RISING>,
>> +                         <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
>> +                         <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
>> +                         <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>;
>> +            interrupt-names = "csid0",
>> +                              "csid1",
>> +                              "csid_lite",
>> +                              "csiphy0",
>> +                              "csiphy1",
>> +                              "csiphy2",
>> +                              "vfe0",
>> +                              "vfe1",
>> +                              "vfe_lite";
>> +
>> +            iommus = <&apps_smmu 0x820 0x40>;
>> +
>> +            power-domains = <&camcc IFE_0_GDSC>,
>> +                            <&camcc IFE_1_GDSC>,
>> +                            <&camcc TITAN_TOP_GDSC>;
>> +            power-domain-names = "ife0",
>> +                                 "ife1",
>> +                                 "top";
>> +
>> +            vdd-csiphy-1p2-supply = <&vreg_l11a_1p2>;
>> +            vdd-csiphy-1p8-supply = <&vreg_l12a_1p8>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@0 {
>> +                    reg = <0>;
>> +                    csiphy_ep0: endpoint {
>> +                        data-lanes = <0 1>;
>> +                        remote-endpoint = <&sensor_ep>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>>
> 

will update in next version.

Thanks,
Wenmeng


