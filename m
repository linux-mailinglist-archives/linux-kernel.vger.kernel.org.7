Return-Path: <linux-kernel+bounces-762469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B05EB20707
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB7F18C2284
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE942BF001;
	Mon, 11 Aug 2025 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mHvdNXM4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051A2BE7DC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910786; cv=none; b=fzhfBjjuCLbh8A9sioTgr1XzVjtWGt3ACXAuisLMQTpdl7tx7leUv/kZr+mvMVtpJBaYVfG+YVWfFCb0kLrdWIT+KsHzS8KjHSBqpXacZpKqnCqPJ04JRdz6ToBcdt5DCbePhzRfgNtwMJ/vIfaOh0tEsbPcHGEKjLcBEx3FcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910786; c=relaxed/simple;
	bh=lEuV8cb9kowURNTyypZITqyna8vIdGy3JqFnkYezfh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNuc1gtY/Fjg5vaIga9Ro2Vdto59Vr3s1vjyU1piNseNBaYkui6PYyFfjos4c4WUhIchp55WI2MUNDYAwI5OG3WcodKfuw/L/8wSBlwwca4BVvqYwIUTf7d+UiyKa8pdNcgkt4BU0rMc19bH7wjQtt9wNER8a5QtDdKu4/MiWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mHvdNXM4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dEIh013175
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	URReqVGPLDf+FTpAoIchtSx7YISeSz/3xo0Fm79Dgds=; b=mHvdNXM4HBdMH7W5
	6CcQL6+te8F8+Dxc6iZqp2RPt6o80vUW8TeoQrZUX1VUM2vnSqCmbDs3E90hkyr1
	YJiHUGxYZsywpV7qVqEhurquMschCcrIVdvk4OLDUdIXU7Qi7PuFiI2r24qwe0cE
	mmL1I7eTgmvINwd5sOF5uhiGB9sZHPM1WJVP79YeqrNskmJ4fKXXPQrhvQZjjw5n
	6i1Nty/cKpbFO+uw7o36YlkA0Zsy7GgoUmjMG3EEDBZ/Glvpy3okNFGpbO7WM7BA
	3wYOsHgDb/GQgwbEIOBk0WWpf50b4rlpBn25JUQooMIFNJ9HUDMECUbALkFEoQsL
	L8tsgA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmma51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:13:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b07ae72350so10985191cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910783; x=1755515583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URReqVGPLDf+FTpAoIchtSx7YISeSz/3xo0Fm79Dgds=;
        b=EzEbaBjrNVi42iWlYJsTZ0S5BB0obuRfNsMIwKl5Wt5mwkLLLYjXr92M0GsuudxL4u
         KqOZapDj/kP171uY/eKYuW4rQLSCDC/E5PMiYgdDQV3LDovbgf3NdgzC2MuVedA2nF4S
         dU3Pvzh1TCdLREoibbl/AeKjCoD3sDF3iAOHIUB8DFInEyjWj7BNUaRZR7BEZ0Vb2/xq
         pHb8l73ydn2qz0Af7XOl9bNxw/Du8QqmpJ9rSldVVENF+a8HGlsX5K7UMppiWPO/EbPr
         px9mPCyKoushbu0tKIktEPLifShUOev4ZP1u7R+hHti5y+nPslsrIVFFgOsYzpptu9Sw
         QtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUP/a6tQmOZLfguw4uuPSdvctOWMWMTa6PVjrJKRBDwr5x8tjE6Awg/SpZkFVzIThWRJ8JXB03OybH0jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Y5dYFoRg66qU7FTBF+kOCT9X4lZTCWcBCVBCzhvup7a4WWDt
	hJtqIe79NeUGz5MeuIG2gpyh91abqykoAa2/H/BFAymRKcycUuHr3IlxdtkxJc1yizPRJf/iaMh
	lbhdUw+F29lgQu+qkdzlpxs5hOx/6KSuaLm8ZV08P8z4eV5y+HYAoVKHUXGDLzY8kbfo=
X-Gm-Gg: ASbGncsNWymzZXiD0VcwaJ1QAsbogdfu5nhrn/HOT6PpwOi5AKxenoMTUTGyzTvDEV+
	4vjD9OO+xyFD6XUqTwJAfnc8+uHi9pfDc72Jn5N0rbGc/ptsngETqjXDv+ZIIojB04GJiKZxTIi
	McUv2orrbeRNVAmV9ITodiqYld9Bp0NBeHay7yMON+6ZsBiMfypvO61JelQ9ccuG97mC/KQXohF
	jeN7t9EZ0V3ACb5QPjPt3yVQ34kMeHnk1W6IjFpUrdL3lZ/dEx4Q7ZooF9HuSVu9DUT7w6iViKl
	0aGJdKE8HxoRNt2N4HFbP+r4NBSrsRGrpcKeVOpTrSSIMy68Za+lpsdGPJEMRk2EHSg7kkEyVlD
	nTUwLon+3Q6qgLo+ghQ==
X-Received: by 2002:a05:622a:24e:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b0c18feedemr57354791cf.3.1754910782732;
        Mon, 11 Aug 2025 04:13:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7A0+Y98Xy74689qvBQIGVL869VUV1Q2Mn0tA1F9GaDJPsmzmzsKoUL0ebMPuxgorWRDYqVQ==
X-Received: by 2002:a05:622a:24e:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b0c18feedemr57354411cf.3.1754910782197;
        Mon, 11 Aug 2025 04:13:02 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076620sm1997071666b.10.2025.08.11.04.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:13:01 -0700 (PDT)
Message-ID: <4f6a7dc5-b0f8-491b-aa12-78be5f47ef2b@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 13:12:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] phy: qcom: qmp-combo: register a typec mux to
 change the QMPPHY_MODE
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com>
 <20250807-topic-4ln_dp_respin-v4-5-43272d6eca92@oss.qualcomm.com>
 <ibrupwvn5frzb4vo3eukb7p7pzonaxwhygshz743wmyrbprkcq@xcpt4ryzvwqr>
 <619efc83-37f3-4b4e-b756-c53ecd2f6867@oss.qualcomm.com>
 <y4yiyokoo7fclwlpyhct4o7mt6swustuciigqnte5pruust26q@ryvuwpd6h4qm>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <y4yiyokoo7fclwlpyhct4o7mt6swustuciigqnte5pruust26q@ryvuwpd6h4qm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=6899d03f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=l4QWMBroLdz4_K-1UwwA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5L5xgHCPMDmuTIs4immY-spVFPSAlr8N
X-Proofpoint-ORIG-GUID: 5L5xgHCPMDmuTIs4immY-spVFPSAlr8N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfXx5MHwFRct78T
 KWZ7tBkhkWK++bFy2Gjf0I8aM5VLsFAIog0r/VNNOxO2ekURe4btZbweoje7AeAj9G1I95/AyCo
 bkS/+f1oBV6YFHhG94jEqIY/MD4w4lUnjS2qYndQQSe8KS+ArqlkPCIkWVUwFgyGpJM18kvpDbQ
 OpUKjdBApIJIODeK6mQFNYmP0kj3Y6M+McgebSRokI0dmtlPvJfW673NFwFhqfl84SsFLfiTfap
 EwZ5iLIvVVm8bDBTgMPSc7muXg6zFKX+jDeGU31kxV5TkIJjmn9eslvfrfun4NdYycg5K3CNoEc
 JIf9TYMeXvfzLWE7CVbMA9lqxs9qN5mb5TOUWkX8cwltXnNC5bCcAApKZ8GHq0GnaQlZ36i2uYY
 0yU+dGkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000

On 8/11/25 12:55 PM, Dmitry Baryshkov wrote:
> On Mon, Aug 11, 2025 at 12:37:00PM +0200, Konrad Dybcio wrote:
>> On 8/9/25 10:13 AM, Dmitry Baryshkov wrote:
>>> On Thu, Aug 07, 2025 at 06:33:23PM +0200, Konrad Dybcio wrote:
>>>> From: Neil Armstrong <neil.armstrong@linaro.org>
>>>>
>>>> Register a typec mux in order to change the PHY mode on the Type-C
>>>> mux events depending on the mode and the svid when in Altmode setup.
>>>>
>>>> The DisplayPort phy should be left enabled if is still powered on
>>>> by the DRM DisplayPort controller, so bail out until the DisplayPort
>>>> PHY is not powered off.
>>>>
>>>> The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
>>>> will be set in between of USB-Only, Combo and DisplayPort Only so
>>>> this will leave enough time to the DRM DisplayPort controller to
>>>> turn of the DisplayPort PHY.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> [konrad: renaming, rewording, bug fixes]
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> ---
>>>>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 118 ++++++++++++++++++++++++++++--
>>>>  1 file changed, 113 insertions(+), 5 deletions(-)
>>>>
>>>> +
>>>> +	if (qmp->qmpphy_mode != QMPPHY_MODE_USB3_ONLY && qmp->dp_powered_on) {
>>>> +		dev_dbg(qmp->dev, "typec_mux_set: DP PHY is still in use, delaying switch\n");
>>>> +		return 0;
>>>> +	}
>>>
>>> I can't say that I'm fully happy about it, nevertheless:
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>
>> IIUC we'll be able to get rid of it after the dp rework?
> 
> Which one? The HPD? not really. My unhappiness is about the sync between
> USB and DP. I'm unsure whether we need higher level of sync for
> USB-or-DP PHYs.

Unfortunately it'll only get worse with usb4, where the DP PLL may
need to be online (or not) for when we're tunneling DP data :(

Konrad


