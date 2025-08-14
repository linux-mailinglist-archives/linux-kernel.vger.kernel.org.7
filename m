Return-Path: <linux-kernel+bounces-769425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0FBB26E83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4D11CC822C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51D30496A;
	Thu, 14 Aug 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iH4Smz27"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50A29D298
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194359; cv=none; b=Yulqpelxwti5x/FaEmeE+wceEBYIvgI6ISHH3IPIuxou6LEZuSAuZu6qkTnWZoRNFO50TNIoAaKmuF1yq68pZ71YvYXn5BSAsHvoYYFZuAmIplJHCdPK1congRdOhDLq562RBM7mtVx5Hw+5eZ2fuYeCZ+waI2ZVHm+JEsOEHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194359; c=relaxed/simple;
	bh=JS9t65y1Tb1O6melp5jomNPznMIQx6bnOe95kV9Fp1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1vTaR8oSz93aOxzg5c4n6gVXBJFvUa2U5RrzVt9WQanPPQEX29OUdKqqupkNltg4rlFIfTsRj6GP5X16+lAxYwtiwbKthXeyiNPMN/iRmFBzHUL3GnPGKRrkEK7WO1kbEkAnEEgTUrm0fRfG4gYyuplqhJKEVjqWFgis8N8EjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iH4Smz27; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHkImT020600
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LO/W9ECJNjW/7mTqzpbQr9aX5cekagiWhhTTCfpUqyY=; b=iH4Smz27c7c6v8fC
	gd4IJ4GLcEUkrrX1oxWoEATx0vco95d3li0XOYATVXPe0c2hX/cjQQzzkwe9wMV3
	joDkba9hfIDuOe5X3SAs9c7+P935nusLu98V9W21ADk5dfZrXg4xKdZS9bKrhfIh
	XSVzFp8mB1l0WA1Z2C/vZGaHIXmev/SOnW2Zsk5NNllWmWDzUMqG3Sv5mH7fC9zy
	w1quCsa6Jc9s+i1bFXXdm1sWyWu+Nvs57+Y/Ovcf5OpgvwsjNIR/2rc0cF+wLRZO
	2WtWKVwOXHQXVUem3lWGCZPGHLqaGz3Sftt7p47Bw03BY982V4vGDJtzlBoq+j5J
	+uHwpQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmgpte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:59:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457f54bb2so26580295ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755194355; x=1755799155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LO/W9ECJNjW/7mTqzpbQr9aX5cekagiWhhTTCfpUqyY=;
        b=Scu8fGBDuVTQRrjCNCuP2DnUg9RCxsYGJtaYbTZ5ORhHbTHax3iZok7Xl4yROcAjiT
         8JGsZFH11vE8O+vuPgaXUaN08dbY25nyW9doL5nEQuYhkn5FcTpgEx/0gowuLIGY4SDs
         pk/sV9R0HLjyqvlO4wZozdsmLivPxvuveY3dGOOeCDDonV6oXA05u+xd2HGNPQcVNIa/
         JaxJKUa7vQoc4TwNJUt+vtzmIWGlSyCVv9AWzfZSY31/xSojmS2ApzhfYlKVl6pCDgDC
         b+0loM1dQAFE8MFyCGB7NI+/v/saHzE9VrTo0IoaGtujjl8yU4vmryrKiPG2nzXfkB7S
         e4FA==
X-Forwarded-Encrypted: i=1; AJvYcCXV2vVhRws2W146N4Bf4ym8KbDok4DAOe/cuy8Jcp1u6rmAo8EUgJzF87ZCjrFFwwFXwF845glLn+11aOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fsBQuQNWdj+PEalY4LVx2GfuP/V1qWeBhsMVrgxSWgnrgsEa
	SWZq7EXxBzVQj+MkUvsBjd0CeO3C15LTvJbxHVxhESs4LYs6991ldRyLTw0Y4T1bB5zjIjyjEKv
	d9XyK6DbGfHWJDn7o4WQ/eCjYadqyp4MxngEL/CPhDlBYU/irD2N82jLxVN1tx0lt0eg=
X-Gm-Gg: ASbGncuVKR9Ow4sKIKdJtZ7J/y1hugWZ8x7IGTRKR2+nvH1XfLolh/9a5zINY+u3PCR
	qx5V1d2EKKFJdoQhGa0c6lPMQ6HHMc/xqOcUzXwDFxJ46wjZPX3jbUhZW/O70fhCAiLNtG9zaF9
	qK5Z7Ho2PCpmShD9WdYjxvzeqIjOhrnFNXZOssudw8Sz5DKO0C3ygNdujG4y6gMJFZ2IobTMwGY
	E0zgfmIAyXeWc2qZ5fAqY/yngEkB8EmIsN3Hm53QwOoQyKNaW8wfbiUxqGhhxOirQJ3bpNDqMrX
	mOJjuHO+YiOR2q9K/F+gvwcLA1/T1HRFoFO0ki0dGvYvG+5C3n8ekwZXbwebzE87sxmo
X-Received: by 2002:a17:902:e78e:b0:242:460e:4ab8 with SMTP id d9443c01a7336-244586dbc4dmr58553205ad.46.1755194354947;
        Thu, 14 Aug 2025 10:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIklnR5m9SKzdIwzPoNhD2QB7ecbzwEviH7LYbrbwUTVp3FSf4QzZ8WYzFNV2mqkqnebnf1g==
X-Received: by 2002:a17:902:e78e:b0:242:460e:4ab8 with SMTP id d9443c01a7336-244586dbc4dmr58552725ad.46.1755194354475;
        Thu, 14 Aug 2025 10:59:14 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.31.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef595esm354448525ad.13.2025.08.14.10.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 10:59:14 -0700 (PDT)
Message-ID: <657a4915-fc24-4e6e-bd28-4e122e66c97d@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 23:29:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] dt-bindings: clock: qcom: document the Glymur
 Global Clock Controller
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
 <20250813-glymur-clock-controller-v4-v4-6-a408b390b22c@oss.qualcomm.com>
 <wttnza5lagqzda2qxeyksm464mmzycp7vwcwzrwynx7mmounti@ex7pbezr6eiy>
 <2ac5aaa8-18ba-466a-ba67-8212daf9c3b5@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <2ac5aaa8-18ba-466a-ba67-8212daf9c3b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX5mdrUGb/gjye
 9LrTQ64zJGkVKEWixWc3jereBlwyKwHQi6oFrbWwEBPAuhqzNwGti/Wd2U2+UUqHhiBL+MGtLmo
 D98po48rol2qGfhXMVvzQF7PXCOM72SEsOaZciTQht0jK+xPPe7daga8Mm2UmZnf9CD5ovCNNjf
 POG1GybNqCelh9VoP5/fMT74Hf2C8mxVu0YuUK4cpm3ua/kmGW2+Ydck+1HFiBv5mlRfrV2ANcb
 l/A+kc3w0fpLiQtbVnjrOr0of0z+4/a0p4Brt/d1/Olu7pBEH3coR+LbKkx5j4LxtsNubxq3UTD
 /EgZjM/lQd/syyjMPhqYwZJ/4Q2i3y9IYUBvGHwXb97FKt54M3BC0Yt6CWvSozIamn+4B3kgzs6
 QWDcSVay
X-Proofpoint-GUID: h_ImjdeDqHZAlTxSBjOp7iZZfDNi-m32
X-Proofpoint-ORIG-GUID: h_ImjdeDqHZAlTxSBjOp7iZZfDNi-m32
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689e23f4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=/kiP2gCwObMqexHosDfpNA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=_CSq4AhyHEGRIHh0IXIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119



>>> +      - description: USB 2 Phy PIPEGMUX clock source
>>> +      - description: USB 2 Phy SYS PCIE PIPEGMUX clock source
>>> +      - description: PCIe 3a pipe clock
>>> +      - description: PCIe 4b pipe clock

Bjorn, will fix this typo and the below one as well.

>>> +      - description: PCIe 4 pipe clock
>>> +      - description: PCIe 5 pipe clock
>>> +      - description: PCIe 6 pipe clock
>>> +      - description: PCIe 6b pipe clock

Got this extra due to huge list of external clocks.

>>
>> When I look at the documentation, we seem to have pipe clocks for pcie
>> 0, 1, 2, 3a, 3b, 4, 5, and 6. And this seems to better match the clock
>> defines below as well...
>>
> 
> Bjorn, the PCIE 0, 1, 2 are connected to USB4 PHY 0/1/2 pcie pipe clock
> source.
> 
>> Can you please confirm that the inputs you have listed here are complete
>> and correct? (It's not going to be possible to add things in the middle
>> later and adding 0, 1, and 2 at the bottom will not sit well with my
>> OCD).
>>
> 
> These are the complete list of external clocks and nothing else is required.
> 
>> Regards,
>> Bjorn
>>
>>> +      - description: QUSB4 0 PHY RX 0 clock source
>>> +      - description: QUSB4 0 PHY RX 1 clock source
>>> +      - description: QUSB4 1 PHY RX 0 clock source
>>> +      - description: QUSB4 1 PHY RX 1 clock source
>>> +      - description: QUSB4 2 PHY RX 0 clock source
>>> +      - description: QUSB4 2 PHY RX 1 clock source
>>> +      - description: UFS PHY RX Symbol 0 clock source
>>> +      - description: UFS PHY RX Symbol 1 clock source
>>> +      - description: UFS PHY TX Symbol 0 clock source
>>> +      - description: USB3 PHY 0 pipe clock source
>>> +      - description: USB3 PHY 1 pipe clock source
>>> +      - description: USB3 PHY 2 pipe clock source
>>> +      - description: USB3 UNI PHY pipe 0 clock source
>>> +      - description: USB3 UNI PHY pipe 1 clock source
>>> +      - description: USB4 PHY 0 pcie pipe clock source
>>> +      - description: USB4 PHY 0 Max pipe clock source
>>> +      - description: USB4 PHY 1 pcie pipe clock source
>>> +      - description: USB4 PHY 1 Max pipe clock source
>>> +      - description: USB4 PHY 2 pcie pipe clock source
>>> +      - description: USB4 PHY 2 Max pipe clock source
>>> +
>>> +required:
>>> +  - compatible
>>> +  - clocks
>>> +  - '#power-domain-cells'
>>> +
>>> +allOf:
>>> +  - $ref: qcom,gcc.yaml#
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/qcom,rpmh.h>
>>> +    clock-controller@100000 {
>>> +      compatible = "qcom,glymur-gcc";
>>> +      reg = <0x100000 0x1f9000>;
>>> +      clocks = <&rpmhcc RPMH_CXO_CLK>,
>>> +               <&rpmhcc RPMH_CXO_CLK_A>,
>>> +               <&sleep_clk>,
>>> +               <&usb_0_phy_dp0_gmux>,
>>> +               <&usb_0_phy_dp1_gmux>,
>>> +               <&usb_0_phy_pcie_pipegmux>,
>>> +               <&usb_0_phy_pipegmux>,
>>> +               <&usb_0_phy_sys_pcie_pipegmux>,
>>> +               <&usb_1_phy_dp0_gmux_2>,
>>> +               <&usb_1_phy_dp1_gmux_2>,
>>> +               <&usb_1_phy_pcie_pipegmux>,
>>> +               <&usb_1_phy_pipegmux>,
>>> +               <&usb_1_phy_sys_pcie_pipegmux>,
>>> +               <&usb_2_phy_dp0_gmux 2>,
>>> +               <&usb_2_phy_dp1_gmux 2>,
>>> +               <&usb_2_phy_pcie_pipegmux>,
>>> +               <&usb_2_phy_pipegmux>,
>>> +               <&usb_2_phy_sys_pcie_pipegmux>,
>>> +               <&pcie_3a_pipe>, <&pcie_4b_pipe>,

Fix here.

>>> +               <&pcie_4_pipe>, <&pcie_5_pipe>,
>>> +               <&pcie_6_pipe>, <&pcie_6b_pipe>,

Fix here as well.

>>> +               <&qusb4_0_phy_rx_0>, <&qusb4_0_phy_rx_1>,
>>> +               <&qusb4_1_phy_rx_0>, <&qusb4_1_phy_rx_1>,
>>> +               <&qusb4_2_phy_rx_0>, <&qusb4_2_phy_rx_1>,
>>> +               <&ufs_phy_rx_symbol_0>, <&ufs_phy_rx_symbol_1>,
>>> +               <&ufs_phy_tx_symbol_0>,
>>> +               <&usb3_phy_0_pipe>, <&usb3_phy_1_pipe>,
>>> +               <&usb3_phy_2_pipe>,
>>> +               <&usb3_uni_phy_pipe_0>, <&usb3_uni_phy_pipe_1>,
>>> +               <&usb4_phy_0_pcie_pipe>, <&usb4_phy_0_max_pipe>,
>>> +               <&usb4_phy_1_pcie_pipe>, <&usb4_phy_1_max_pipe>,
>>> +               <&usb4_phy_2_pcie_pipe>, <&usb4_phy_2_max_pipe>;
>>> +      #clock-cells = <1>;
>>> +      #reset-cells = <1>;
>>> +      #power-domain-cells = <1>;
>>> +    };
>>> +

-- 
Thanks,
Taniya Das


