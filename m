Return-Path: <linux-kernel+bounces-874826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E39C172D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05371405A75
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC42830171D;
	Tue, 28 Oct 2025 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMyhG0ol";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K50UTRzP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2351F4CBE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689740; cv=none; b=rSVmjs8YZhKCSDohUZQpe1VuMpQEsahfg+LZKmRjcJbQEqP3KL0oMe9rOnqCq6Re0gAIYAGI7BuFUehYGpEK5y/frA8gZUeel6ZFCqFZpbjETovVe96KQGadtLQgbm31Wh6mEL1qP6/p0d2DZcd1mHqX+eiX/VUAjF8MpeQNerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689740; c=relaxed/simple;
	bh=lle28fA+/FsfsFiMjIFNUPMWMj2reJ/0jOe6OP2GZbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqWoELw90FzYd/JWOxdYb7FQcq+7ZcrDg9j+VSnVSdTAOGWb+LOYDgIbqqrYnZ98nevCeg3BBiRmGSkQuoXCC45M2EOEgAtp86NuAne96X5MdRAaAc6IDjG9lKoftLc+vUgB/gGHuLwdEEpbLblbKYlTWzTOJzgoLnh0r6QRaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PMyhG0ol; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K50UTRzP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJqSUA2510887
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PS6ekir5CeFEH7JucC+vlZ0WAP2bE+Fzy0K0FeebiUI=; b=PMyhG0olPjS96Jx/
	x2tXxTffEfyrPAnO0oNzytWtDYAx0v0+5tHJ0y7r6++HrJSO5Sod5KeXTf6ByR8S
	l2fNOaQszPaoMVZ3tGBhQ0kBfvPBr7JTmX9ThgL70FIIdFNYUCrSnUQ6NDeARUWm
	59P96FUCS6SFsZaKlpVzleUj2mqe1FqnXJ3DVJL2KUzQ1Nq2IIdNFxrXzP+mS2y7
	GTGcJho6RYvrcbiVshT2eEcpfJ+tIA04uNT4iQQRvn9cAsdyXglT18SLDvjy0jnF
	F9WmWX54vWbp/Fj+rp4QzQOWIb9wnVnrdEmjCH8qEme7h1CqijhiApqcpFOSdJ+u
	kUNrCw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34cd8a9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:15:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-272b7bdf41fso78913985ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761689737; x=1762294537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PS6ekir5CeFEH7JucC+vlZ0WAP2bE+Fzy0K0FeebiUI=;
        b=K50UTRzPLMOwDXSBxTwlrzSPD5XUzbiESIPTxhkUw7ytBp1yyheiAEawVnr/VfZL9C
         oTDYRE3lhmKOFuN9EcyYOXVAZ3tinRBX3c9LXRWOL7QGNPqsb2buPHx8IOwIi7ZVu2vd
         2TNnSA6KfqNDH2qw/5xLKQoJvgIlPI3k+C7yWuYrTtmf4J0dE2szej7MAtmqBBb5D+B7
         K4CUszMs9iS01y2Eqeet3ePFNc7lTnlly0VVS85QvxKW/VLZlU94pdVdiRfFhe+szFIx
         5B8vgWBKzfhl+Lcjk6MoX14O+4JNpBXaPyKdnuwccnhwfpwrev2FfWVuypJJFJCiNMHq
         rPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689737; x=1762294537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PS6ekir5CeFEH7JucC+vlZ0WAP2bE+Fzy0K0FeebiUI=;
        b=uEjBESzEiR+jU5VCsp7SCY+iGoa4jFcs0l0bi8ZX5WU/6fOFRPZswB5HR+MnOYAaf0
         jgtqZxBydNx4UqfVQxSpCVVzEqxAcjjahmzpODNVppDpmkUY+qY33JE1j+InCQ4GqPNA
         DjE/m2TFm9d+1y15Y9sPGC2Ou2nRTtv3Rvk1MoFAFVfqayBtA8kea+v1VPLoEk5mpXnY
         8QtgxRI06A3+9cUm7zvczT4LtaRLBrg2/IeVAEQtMmNPX2oHpBxDN+Eae9r/hl039t03
         eT5xs4nWXhTQq49iA2MxrbKeD2nHTa66HNaKQf2S1C0DVmf1cI59xos00RXvoedaoNMa
         n4IA==
X-Forwarded-Encrypted: i=1; AJvYcCUB/YjFy0fNR6BOoPX7bR1DjFCeyFQYrOjYdBobynFSL6TQ80eaM5ZgjS2e3c+R+Z9JQGLHcVwivvY+3sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybiSGRLuV5qGXus+vhUiP0Jt4SG3wOWJ3SL30brMhWROoW3a6W
	P8PnO5Q24Lr6kw/FuCFr6FKvsDt5ixk+Orxok6pvaTz1cDAgb7lRIEBtrz3f4TFJtBVBpgRO657
	NRkhnB+6wfw2Koz68ZAShZDj8vJK4QV9MFDCYk6IEklf3gIJmbAa5DNID34PO8qdsM9s=
X-Gm-Gg: ASbGnctNnXs/pk1x53WA6O/EoUFZuCqo0sE6rkKvD58J2EPNyZDnEPFDBHe9/LfA6VP
	Txwx/0Uv4QmHSuZCZgR2LpEyF6Ki+ItmV6Eb6XUaWFCSUdF6hA3F5NCaP0L/FHKPfIW55N7O+zN
	p9gKr48qrMHB997ueLI+oJKT54XmW+RdT/YmvZ97tSceARyC0G0SkO1ZY+4kLMcu3p4oZ0dPxtJ
	qv44FLbEYoK/9LgnuMpuPk0xhDomCb3+dlo6+Q95QOFKzHzZgfOLyeLBlHddag6uzfA2zViXNKK
	uUkdBIGQvP5Jthx+6AiUUatw9foUj4PXcZpPuOqXZghr+smPO1LI1N6WmmGR0BrjsAte/tR3TL5
	kdQByWzZZt8Xx6quUwGhysFfWYdEm3PV6lAGa1mTe
X-Received: by 2002:a17:903:1a4e:b0:246:80b1:8c87 with SMTP id d9443c01a7336-294deef8844mr8457085ad.43.1761689736887;
        Tue, 28 Oct 2025 15:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJLEA9v/Mv48Jjv867SnWr65AkZTGjkRGkYR1Ak8CozEzyX9IDMyOTK3TzmbNEefmRul/yqw==
X-Received: by 2002:a17:903:1a4e:b0:246:80b1:8c87 with SMTP id d9443c01a7336-294deef8844mr8456645ad.43.1761689736213;
        Tue, 28 Oct 2025 15:15:36 -0700 (PDT)
Received: from [10.73.53.19] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127afff91sm11487662a12.13.2025.10.28.15.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:15:35 -0700 (PDT)
Message-ID: <7ae01221-868e-d5dc-4297-8006a69e7a7c@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 15:15:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 6/8] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
 <20251024-glymur_usb-v6-6-471fa39ff857@oss.qualcomm.com>
 <ktjmbmfd37tm6ij3pqbrbhfounizz4znmqvearvh4spvuky6i6@pw5czztggbjm>
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <ktjmbmfd37tm6ij3pqbrbhfounizz4znmqvearvh4spvuky6i6@pw5czztggbjm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ewWMhQ1NWK4uar5Tl7fpehPcmXC_Lsy_
X-Proofpoint-GUID: ewWMhQ1NWK4uar5Tl7fpehPcmXC_Lsy_
X-Authority-Analysis: v=2.4 cv=avi/yCZV c=1 sm=1 tr=0 ts=69014089 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wlTfea_xsf4MiaLh13MA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE4NyBTYWx0ZWRfXz5RHpu3ZJEGt
 7ldKDXYNRISv+iwZwXrgsHm9nP2mKhv1zwVLtm9GtlQbonyyMuHiPwog8rJe9d37uZe0P15B9ww
 y8tuoo4jHrxamio1UVja8/oZI1EUMTdFTzMBmIiO3xtogAuRasrd5v0Jz6ywonZIc2c9iYP9YKZ
 wfTpaXzrXQIx7tcw0pmnyH1pGQN2aSe7/bhx30J1tKReqPDad6DaYTT80cZyvMQf9u3cOFUViDv
 2bpG6PRtwUuwg6MsKIFHP0rg+17DthRTVSFvn75yAU/DuvcwPPnalI4Mx3QeoaqEdFl3a/SUbIw
 +94ddT139ti3HYfBGVcDlLOfitIrs88OlZvDK106j5lvSicFQxQJOldBbyGPqy8kYPzjyX8L4Ya
 TFzDmU6LC1lxhKTKBAXq7laPDc4ZQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510280187



On 10/27/2025 7:21 AM, Dmitry Baryshkov wrote:
> On Fri, Oct 24, 2025 at 05:47:44PM -0700, Wesley Cheng wrote:
>> For SuperSpeed USB to work properly, there is a set of HW settings that
>> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
>> these settings follow the latest settings mentioned in the HW programming
>> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
>> new ways to define certain registers, such as the replacement of TXA/RXA
>> and TXB/RXB register sets.  This was replaced with the LALB register set.
>>
>> There are also some PHY init updates to modify the PCS MISC register space.
>> Without these, the QMP PHY PLL locking fails.
>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 288 ++++++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h     |  17 +
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v8.h    |  12 +
>>   .../phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h    | 639 +++++++++++++++++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h   |  33 ++
>>   .../qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h   | 224 ++++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp.h                |   2 +
>>   7 files changed, 1215 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> index 1caa1fb6a8c7..d1534ed7200b 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> @@ -30,9 +30,11 @@
>>   
>>   #include "phy-qcom-qmp.h"
>>   #include "phy-qcom-qmp-pcs-aon-v6.h"
>> +#include "phy-qcom-qmp-pcs-aon-v8.h"
>>   #include "phy-qcom-qmp-pcs-misc-v3.h"
>>   #include "phy-qcom-qmp-pcs-misc-v4.h"
>>   #include "phy-qcom-qmp-pcs-misc-v5.h"
>> +#include "phy-qcom-qmp-pcs-misc-v8.h"
>>   #include "phy-qcom-qmp-pcs-usb-v4.h"
>>   #include "phy-qcom-qmp-pcs-usb-v5.h"
>>   #include "phy-qcom-qmp-pcs-usb-v6.h"
>> @@ -46,6 +48,8 @@
>>   #include "phy-qcom-qmp-dp-phy-v5.h"
>>   #include "phy-qcom-qmp-dp-phy-v6.h"
>>   
>> +#include "phy-qcom-qmp-usb43-pcs-v8.h"
>> +
>>   /* QPHY_V3_DP_COM_RESET_OVRD_CTRL register bits */
>>   /* DP PHY soft reset */
>>   #define SW_DPPHY_RESET				BIT(0)
>> @@ -97,6 +101,7 @@ enum qphy_reg_layout {
>>   	QPHY_TX_HIGHZ_DRVR_EN,
>>   	QPHY_TX_TRANSCEIVER_BIAS_EN,
>>   
>> +	QPHY_AON_TOGGLE_ENABLE,
>>   	/* Keep last to ensure regs_layout arrays are properly initialized */
>>   	QPHY_LAYOUT_SIZE
>>   };
>> @@ -259,6 +264,236 @@ static const unsigned int qmp_v8_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
>>   	[QPHY_TX_TRANSCEIVER_BIAS_EN]	= QSERDES_V8_TX_TRANSCEIVER_BIAS_EN,
>>   };
>>   
>> +static const unsigned int qmp_v8_n3_usb43dpphy_regs_layout[QPHY_LAYOUT_SIZE] = {
>> +	[QPHY_SW_RESET]			= QPHY_V6_N4_PCS_SW_RESET,
>> +	[QPHY_START_CTRL]			= QPHY_V6_N4_PCS_START_CONTROL,
>> +	[QPHY_PCS_STATUS]			= QPHY_V6_N4_PCS_PCS_STATUS1,
>> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_N4_PCS_POWER_DOWN_CONTROL,
> 
> V8 PHY should not be using V6 register offsets.
> 
>> +
>> +	/* In PCS_USB */
>> +	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
>> +	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR]	= QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
>> +
>> +	[QPHY_AON_TOGGLE_ENABLE]		= QPHY_V8_PCS_AON_USB3_AON_TOGGLE_ENABLE,
>> +
>> +	[QPHY_COM_RESETSM_CNTRL]		= QSERDES_V6_COM_RESETSM_CNTRL,
>> +	[QPHY_COM_C_READY_STATUS]		= QSERDES_V6_COM_C_READY_STATUS,
>> +	[QPHY_COM_CMN_STATUS]		= QSERDES_V6_COM_CMN_STATUS,
>> +	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN,
>> +
>> +	[QPHY_DP_PHY_STATUS]		= QSERDES_V6_DP_PHY_STATUS,
>> +	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V6_DP_PHY_VCO_DIV,
>> +
>> +	[QPHY_TX_TX_POL_INV]		= QSERDES_V6_N4_TX_TX_POL_INV,
>> +	[QPHY_TX_TX_DRV_LVL]		= QSERDES_V6_N4_TX_TX_DRV_LVL,
>> +	[QPHY_TX_TX_EMP_POST1_LVL]		= QSERDES_V6_N4_TX_TX_EMP_POST1_LVL,
>> +	[QPHY_TX_HIGHZ_DRVR_EN]		= QSERDES_V6_N4_TX_HIGHZ_DRVR_EN,
>> +	[QPHY_TX_TRANSCEIVER_BIAS_EN]	= QSERDES_V6_N4_TX_TRANSCEIVER_BIAS_EN,
>> +};
>> +
>> @@ -2528,6 +2784,27 @@ static const struct qmp_phy_cfg sm8750_usb3dpphy_cfg = {
>>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>>   };
>>   
>> +static const struct qmp_phy_cfg glymur_usb3dpphy_cfg = {
>> +	.offsets		= &qmp_combo_usb43dp_offsets_v8,
>> +
>> +	.serdes_tbl		= glymur_usb43dp_serdes_tbl,
>> +	.serdes_tbl_num		= ARRAY_SIZE(glymur_usb43dp_serdes_tbl),
>> +	.tx_tbl			= glymur_usb43dp_lalb_tbl,
>> +	.tx_tbl_num		= ARRAY_SIZE(glymur_usb43dp_lalb_tbl),
>> +	.pcs_tbl		= glymur_usb43dp_pcs_tbl,
>> +	.pcs_tbl_num		= ARRAY_SIZE(glymur_usb43dp_pcs_tbl),
>> +	.pcs_usb_tbl		= glymur_usb43dp_pcs_usb_tbl,
>> +	.pcs_usb_tbl_num	= ARRAY_SIZE(glymur_usb43dp_pcs_usb_tbl),
>> +	.pcs_misc_tbl		= glymur_usb43dp_pcs_misc_tbl,
>> +	.pcs_misc_tbl_num	= ARRAY_SIZE(glymur_usb43dp_pcs_misc_tbl),
> 
> DP tables are missing.
> 

Hi Dmitry,

I think I discussed this with Abel on the previous patch revision.  At 
the moment I did not add support for DP, so we shouldn't add the tables, 
unless you think we should still have placeholder?

Thanks
Wesley Cheng

>> +
>> +	.regs			= qmp_v8_n3_usb43dpphy_regs_layout,
>> +	.reset_list		= msm8996_usb3phy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>> +	.vreg_list		= qmp_phy_vreg_refgen,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_refgen),
>> +};
>> +
>>   static int qmp_combo_dp_serdes_init(struct qmp_combo *qmp)
>>   {
>>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> @@ -3024,6 +3301,7 @@ static int qmp_combo_com_init(struct qmp_combo *qmp, bool force)
>>   {
>>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>>   	void __iomem *com = qmp->com;
>> +	void __iomem *pcs_aon = qmp->pcs_aon;
>>   	int ret;
>>   	u32 val;
>>   
>> @@ -3059,6 +3337,10 @@ static int qmp_combo_com_init(struct qmp_combo *qmp, bool force)
>>   			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
>>   			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>>   
>> +	/* override hardware control for reset of qmp phy */
>> +	if (pcs_aon && cfg->regs[QPHY_AON_TOGGLE_ENABLE])
>> +		qphy_clrbits(pcs_aon, cfg->regs[QPHY_AON_TOGGLE_ENABLE], 0x1);
>> +
>>   	/* Use software based port select and switch on typec orientation */
>>   	val = SW_PORTSELECT_MUX;
>>   	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
>> @@ -3236,6 +3518,8 @@ static int qmp_combo_usb_power_on(struct phy *phy)
>>   	qmp_configure_lane(qmp->dev, rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
>>   
>>   	qmp_configure(qmp->dev, pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
>> +	qmp_configure(qmp->dev, qmp->pcs_misc, cfg->pcs_misc_tbl, cfg->pcs_misc_tbl_num);
>> +
> 
> Extra empty line.
> 
>>   
>>   	if (pcs_usb)
>>   		qmp_configure(qmp->dev, pcs_usb, cfg->pcs_usb_tbl,
> 

