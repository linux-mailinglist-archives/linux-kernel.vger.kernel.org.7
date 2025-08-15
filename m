Return-Path: <linux-kernel+bounces-770453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D8B27AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5DF3BE741
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEFC246768;
	Fri, 15 Aug 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W1t5KgYc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7D23FC66
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246358; cv=none; b=JndCy5yL1aVajqsa7yxlxXSK7mbx35uvhXtN2mNq1FddjHDBLUI/aa8Y/lIwDWcG6nk0BrTVroOzgS/MI/ygws0+MWQyvWrGb9g2DRlvh/oJOj+cbKPX3fc6knkD5eLF/6dYT/oA99M7pcmhCnr2uYI4jFLd/qhY31LufIEne/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246358; c=relaxed/simple;
	bh=lKzv15kx6PiT4yQ5MvzV7iQEkZsn6csnKE++bWbXk1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VElcq3FQ1ca9E2V+sxkBcNn1EGJngG3Nfl/eEnjfeXFd1uQR6iA+K8V4ztiycXytnx5Xrf+ZLFq/3eV/58QS7fKYN0T4koQ253ucNkxETAEPlHoxdv6jaHx82/KTm0Ljmiwllji4psgRqrDYhoJ6GnOfldSspwGp5wtLD9zvvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W1t5KgYc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F85kOO011413
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NUp9id380DZ/OObz+oDgJw+5UIsJFHPyVrQSjaIg6Ws=; b=W1t5KgYcqdcplNA4
	+D82pGSLq3f6/jEw27m8UaioPHPr5G0p56AbZj8pd/ObiLuCLZtHBBkrYhVFtRUp
	+F/NSRM/ZTFYeiXX57+JgQcIQoDKrSrLDmH4tcxoF8+gFapaaDONaUWtHMAy7pR9
	4CziGzqTrHUqJGg13hwGUJfAVKPp6XdA86OuwVE6XvP+zyuCrLudrV2ufFnkMmOd
	k5RrWiYxKwEVbN13T3ynLEH+idGR4d1d3+NY9LPlaMbpd1FxRvviBZ1G5jqHMQDg
	yllh8mrD3zg7QkmZsTW9ZPxubBe5sfvCjmFWLGn/tDzr0aiodKs75icaFxS++avr
	yZ2wEQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbnp9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:25:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4716fb7571so35348a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755246355; x=1755851155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NUp9id380DZ/OObz+oDgJw+5UIsJFHPyVrQSjaIg6Ws=;
        b=RWUrpZ+Xz4xw40mTy/s/NnhGKdu4aAVWdR5+i2YWBKcUyWllRgZBFUlmpN1qlubAp2
         vYBKgtnU49mY/35kIWcwJdNPS4gcmGPU2QKwFnI4XJ6aoNFyoPlulG6TJ6cwoz+ymIp6
         s9FQuLTwEtE0qp2Wi6HP74jmLBLSWGlnKVaJNVTdDl/Qp7KcW2bqFAwe7Ph8ZJlj7gzt
         0Hoa9HdA66vYXCk8efaVrGhdRoyuJwFONh3QU/AtAQfrcl7qSG5pN5skSdJMPIuwdyKK
         8t+C04znv7gRRHJkpL0kZ9j4yWd6E+oPCM6W59F61zZq4sr5lC3qQzpfRsAxMtWSup8E
         ncsw==
X-Forwarded-Encrypted: i=1; AJvYcCWbPgqLc5QOsJ2lVCYhEDrpsDC39Nvq17l/J2uceY8j2fDOkmV4/S5cpausWV1VDT8yAMYj+/6WiwN+S38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLEZDlvVy3sVUsN6efFqavLTBhwpDopjI4cpNRyY0t+vYtibs
	qWu7VWjM+FjibaYJUZvd6/Ua1R0MYJvBDnOHHkgaR5okZnS4W/yAffbaGOdme8ShBsfIB+yCQJq
	syacDUr+6U/YxVD6SR/6sQmyyfJrG4V+VOKXW9zLbKBTsoA3oYPL2C63CyDg1CYHyaCs=
X-Gm-Gg: ASbGncu8vp9sfghkSpsFa7RH/IzJz7Aqv8X0svJpVV0mr+rR1tEyt3liN9kJK5j1mjU
	vPXe15LzG2OcKJV40Vkgm5Vi3AQVPkkJoVx+JjL17BXJD/Cf2a64vDxI7sRwqI5K1N/EPFs+PAR
	+OTK682OAlIMIVneI2FazwDSeRi5OVnT5jH15L/u+KCydNuY8KXAXRKX89kw3N92nSNa7It03DD
	qZom0+1FxouvttwOGWmhWM0M0gwarPq0mOH/3qbv/grmiz7saGR/1kylCVb7gK5FDqli+wFkUZx
	eXQ056br3ooz2CVUl3ggO8kERpOldJLrxbks62c+3FgbM4xlo2Pc9bOdSu/j3CJQfrTZOhTaJFt
	2d5qPlPJWeESrITiC7PoXxhjRYOYu
X-Received: by 2002:a05:6a00:1393:b0:76b:cf2b:18ab with SMTP id d2e1a72fcca58-76e446b43d3mr731552b3a.1.1755246354608;
        Fri, 15 Aug 2025 01:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlOGconyNmSJveNt3MkVQqNUPji6K3KxwQpbezFFRgXr8JkSt+WNcYJk1eoULrcB7MfzyFyg==
X-Received: by 2002:a05:6a00:1393:b0:76b:cf2b:18ab with SMTP id d2e1a72fcca58-76e446b43d3mr731532b3a.1.1755246354054;
        Fri, 15 Aug 2025 01:25:54 -0700 (PDT)
Received: from [10.133.33.10] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558a81asm629191b3a.83.2025.08.15.01.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 01:25:53 -0700 (PDT)
Message-ID: <661789d6-5fbe-4915-b70a-5ff2466c7a26@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 16:25:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] dt-bindings: phy: Add binding for QCS615
 standalone QMP DP PHY
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
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
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        fange.zhang@oss.qualcomm.com, quic_lliu6@quicinc.com,
        quic_yongmou@quicinc.com
References: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
 <20250722-add-displayport-support-for-qcs615-platform-v2-2-42b4037171f8@oss.qualcomm.com>
 <0c94206c-f70f-4bed-81ec-bb2870748121@kernel.org>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <0c94206c-f70f-4bed-81ec-bb2870748121@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689eef13 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=0gnJL556ed7yCVVD25sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfXzD6olhmEmyUy
 hgMkj37Y9uJOUuLYC2/y0KhLk6pTvQPA7FilDT4Kx1wrQq69DhdNlhv4Qm0frmA/gSijqOclaQU
 QzzbBbsbu4IRhCmXdJdpjK9KV/G1yUu2cZGBs4gdVlhdUAGxAPaxnTu2OX7ht7uo3ZPKGFKqW40
 SIzEjhRg/R4UjohOkpLsPGL7vWVbeyhhszjQVv98H4mXuz7fqirFPBzJSV1/giMJ2u0+svixy93
 imcrIu46RCXjK4GTVga/iXqvLcUPWHmuJBe5rcCSldC5HlYMLP8uqRQJE15Ojh4D8GfYOd/keWP
 1vYL9aiBj1TCUezqR9fglK5WnuWx0iQvxyl2rmHmWTs1zeZDEFqLagwx9vYQGSq5S3fpWepsyCx
 6xePbzV7
X-Proofpoint-ORIG-GUID: mPGlrxi2nknyrf4JeIBy4KYFwP2WVBvs
X-Proofpoint-GUID: mPGlrxi2nknyrf4JeIBy4KYFwP2WVBvs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097


On 7/22/2025 5:18 PM, Krzysztof Kozlowski wrote:
> On 22/07/2025 09:22, Xiangxu Yin wrote:
>> Introduce device tree binding documentation for the Qualcomm QMP DP PHY
>> on QCS615 SoCs. This PHY supports DisplayPort functionality and is
>> designed to operate independently from the USB3 PHY.
> A nit, subject: drop second/last, redundant "binding for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Ok, will update subject in next patch.

>> Unlike combo PHYs found on other platforms, the QCS615 DP PHY is
>> standalone and does not support USB/DP multiplexing. The binding
>> describes the required clocks, resets, TCSR configuration, and clock/PHY
>> cells for proper integration.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  .../bindings/phy/qcom,qcs615-qmp-dp-phy.yaml       | 111 +++++++++++++++++++++
>>  1 file changed, 111 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-dp-phy.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..17e37c1df7b61dc2f7aa35ee106fd94ee2829c5f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-dp-phy.yaml
>> @@ -0,0 +1,111 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/qcom,qcs615-qmp-dp-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QMP PHY controller (DP, QCS615)
> That's too vague title. You are not adding here Qualcomm QMP PHY
> controllers.

Will update to 'Qualcomm QMP USB3-DP PHY controller (DP, QCS615)' in next patch.

>
>> +
>> +maintainers:
>> +  - Vinod Koul <vkoul@kernel.org>
> Hm? Why?


I referred to the definitions in qcom,msm8998-qmp-usb3-phy.yaml and qcom,sc8280xp-qmp-usb43dp-phy.yaml.

I also found that Vinod Koul is listed as the maintainer of the GENERIC PHY FRAMEWORK in linux-next/MAINTAINERS.

Did I misunderstand anything here?


>> +
>> +description:
>> +  The QMP DP PHY controller supports DisplayPort physical layer functionality
>> +  on Qualcomm QCS615 SoCs. This PHY is independent from USB3 PHY and does not
>> +  support combo mode.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qcs615-qmp-dp-phy
>> +
>> +  reg:
>> +    maxItems: 4
> I don't understand what you are doing here. Why previous patch evolved
> into this? Where is any reasoning for that in the changelog? You said:
>
> "- Add new binding qcom,qcs615-qmp-dp-phy.yaml for QCS615 standalone DP
> [Krzysztof]"
>
> but you must say WHY you are doing things...
>
> Anyway, missing constraints. Look at other Qualcomm bindings.


I misunderstood your earlier comment in '20241129-add-displayport-support-for-qcs615-platform-v1-2-09a4338d93ef@quicinc.com' and mistakenly included "[Krzysztof]" in the commit message as if it were a quote. 

Apologies for the confusion and will drop this part in cover letter in next patch.

In next patch, the address regions will be consolidated into a single range, similar to other QMP PHYs, and |maxItems| will be updated to |1|.


>
>> +
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: cfg_ahb
>> +      - const: ref
>> +
>> +  clock-output-names:
>> +    maxItems: 2
>> +    description:
>> +      Names of the clocks provided by the PHY.
> Drop description, redundant. It cannot be anything else.


Ok, will drop it.


>
>> +
>> +  qcom,tcsr-reg:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to TCSR hardware block
>> +          - description: offset of the DP PHY moode register
>> +    description:
>> +      DP PHY moode register present in the TCSR
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    items:
>> +      - const: phy
> Drop reset-names, useless.


In next patch, this config will be updated to USB or DP PHY binding with two resets: 'phy_phy' for USB and 'dp_phy' for DP.
Shall I keep 'reset-names' prop here?

>
>> +
>> +  vdda-phy-supply: true
>> +
>> +  vdda-pll-supply: true
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +    description:
>> +      See include/dt-bindings/phy/phy-qcom-qmp.h
>> +
>> +  "#phy-cells":
>> +    const: 1
>> +    description:
>> +      See include/dt-bindings/phy/phy-qcom-qmp.h
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - clock-output-names
>> +  - qcom,tcsr-reg
>> +  - resets
>> +  - reset-names
>> +  - vdda-phy-supply
>> +  - vdda-pll-supply
>> +  - "#clock-cells"
>> +  - "#phy-cells"
>> +
> Why introducing completely different order? See existing binding and DTS
> coding style.
>
> Best regards,
> Krzysztof


Ok, will update to follow the existing order.

compatible
reg
clocks
clock-names
resets
reset-names
vdda-phy-supply
vdda-pll-supply
#clock-cells
#phy-cells
qcom,tcsr-reg


