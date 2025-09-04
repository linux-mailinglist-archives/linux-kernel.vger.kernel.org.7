Return-Path: <linux-kernel+bounces-800244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15CB43516
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA11C82FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726AE27A456;
	Thu,  4 Sep 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PAyrJXuf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCA2BEFE7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973493; cv=none; b=HTLHtP7Yww9E6owNJfBqcyUUg5T92AZKAQIMoey/SRzrHYo/T1MOH9emu/w3cSbhSwgSYve+GoRuYoKG1d0Ce6waca0tqjoNNH4HDqzhZ5RrbIeIukdQRzOowZ7p//9MgoDDxHlesDThtutlg+VpRfYXErk+xwFscsACJR2Y5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973493; c=relaxed/simple;
	bh=4h08wpz5drqqCtxh2Mgu2qUofUwO3S1QVgxWjKb5L3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXyahYxKtdTpaY+eEMQjHRUyCMD4wUKIpafMXaUPyiMYVRW4xI0+YnvK+HXa/PlU5O4YCi8TuNiZA6i1WW70+sSW1C4Gs6IEGfZd9rc3SncswXtJ3BUbbYsWf38rbR+0/I568CFPdYWBGeOZCy2XquKds1uGUkDUME9sNFWhrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PAyrJXuf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840dW9F023786
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 08:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L7t4dwQgkA12CDBLO/H8GwQ2txzuPeZic7pjO4qLBo4=; b=PAyrJXufetwiSgVz
	uAdzS+qwhc3dwJknZKxoaGTAS+xCPuTAIIoVT2ZUmCGZD/mIlEkCe9snuoRBm53y
	/N0daTcncnqxhGRTJ0qDB1TfUMCyJXFooAVkLKE6X8stOnVO6MGvOvMP9vjcmuZA
	Z5+CTZQ5KNtG7+FDlSHessrX60NHta3TYynN+kcjyjTM/9UAiD/FxVURjzXGTPgW
	FxFYtRn/7iBHcXiZ+Qi5HW3wDSnrSRhcX4cNPcWJBd09kqLClpPabkkpMFuak1Xm
	xbHPuwTAaNlrmmB3LLoMz5G9Q4BXBPwM9nhtEj0CVOW1DhmP0mZO7qBJdomwTKZF
	vSGHBw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0epv9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:11:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b3037bd983so3106171cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756973489; x=1757578289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7t4dwQgkA12CDBLO/H8GwQ2txzuPeZic7pjO4qLBo4=;
        b=PwEc+XTyN3TzeLN7A7fHbmIGP8rbmqH1LQs/t7J2W+FyUUMJoHNzmzBOxVQcZ+Jq2W
         5LisAyu/ZwcjNiv4qKgpMXdArbzmDbkX+h6yv+g1MqIGAon+iuv8jp6+s4LpNynAx2+R
         JZhNO//9DFSNlZPgN70muW9KbXEPCxjTrz5xvPbXVH8jFgaKor7dfnFyquG56MLEK9u/
         UPYHu5LwVhH265bEL+p7KYvtJGOY1lmAQEqEnaU78VQ5uUAIi0zPijMgMOGQiRGqGPiR
         hfruvzojQVXwErn7lui38bN+FlzxsS11aXHbypzxjDVilqaeJkyCCPapEghKttKVh2fr
         f9eg==
X-Forwarded-Encrypted: i=1; AJvYcCWgZyJogzasmKxZAbkqjwGgytzlbJ+NA9LlpAeZb57KtkqsdqqFdP5fkOcj+xo52BQMvKRr5/+1od3IjyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8F061dCOv+mrwGcr4Isxfb+iJEaqHDhZCn5lNKe0Eb/R9oZ7C
	/7T+ANOugkB0sRS/D8MdRrMNaL32NA89cYvwAQfDRzAAwtxgogRO4B+paRjCbFZJo2epOuzqGVw
	xJhTU67M8Gzr+JO26MdZy13Ue3m+4YNmGJZnERXOjAcTd9CwgTo9rWkcWkkR18pYCNKE=
X-Gm-Gg: ASbGnctgaeQ9QyAQr2nTPWQttACNwPzqmwv2jbLVXT8s9X/J6bCI4owjQOqTdSuTBOB
	77sLuAry/LRE8Zalkftwo0LsQcscW2u5verGxyc9fRsoHR3jfHXzTznTf9J8B2hQMAavNHMLsaI
	Q1UoVynKZqihM6nGZlJRAjDUIwA+zA6aeJpu0nYTI6Q2d36zRjnfxupb3fTbch332BV0K6yghHt
	vhExGjudAI2tbYS7s9wieREmIQUIW7kFUg1vM3UaET5/kFWiQ/SxIIYmaomgh/Ye+S7t2GYq2d5
	zyD28izqIEBJv/KSqvXnIa6/y1WXjN5MY5mGm+lsYMn+v2PsoayvobdcKe5vJj7GUcR4HwWXanm
	AQ7j8WJuj+06gqCmQbOQC1g==
X-Received: by 2002:ac8:5d12:0:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4b313f0e6e7mr174090951cf.8.1756973489284;
        Thu, 04 Sep 2025 01:11:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETRY11wlgI/tWg0eDPS0dRUFiv1L7olBCrkOPdcF5xbIyJYVEuM11SwnRqh3KhtLOSUAXIXw==
X-Received: by 2002:ac8:5d12:0:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4b313f0e6e7mr174090681cf.8.1756973488627;
        Thu, 04 Sep 2025 01:11:28 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041770913fsm1097170666b.107.2025.09.04.01.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:11:28 -0700 (PDT)
Message-ID: <1b92fe18-67bd-4fda-b7c2-952ed96aaa61@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 10:11:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom-edp: Add missing clock for
 X Elite
To: Rob Herring <robh@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
 <20250903-phy-qcom-edp-add-missing-refclk-v2-1-d88c1b0cdc1b@linaro.org>
 <11155d6c-cc11-4c5b-839b-2456e88fbb7f@oss.qualcomm.com>
 <20250903235138.GA3348310-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903235138.GA3348310-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: i6o95is3wjSJ8hcTCWN4yQF4-Io8Dofm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX7f9+LrvOffX1
 dZ/z4zMEXh8r8QdRBr6fC2Cq7YXlpCVSimAW42RTz+69iimjO8RTH3Y7riDU7k2RYQAyTJczY8/
 zZH0R3O/d7IXxkkhydRjmxDTaIWn2MUp7j+F4yFtbuB/cb3+J2e+RMSS3DknAAwTt67uH5DKQkR
 3GYQQlxgtno71uHDU7FZGlUEwt59rhNWwmvlS9edfiPrzaCkyDXshh/S4cOe1S0T3PEdk711rTG
 zw4KlsHQIQGmHFAGbfQvYjwLCSJCRbFdGXySUt+Sa6+mmMKULyUGBhu7L0/fPspQhJ/iaZ92ck1
 W0HkYGq8mhq6L1386C1j/nzv0BfpLADYgIoi7W/lqqicsQfyfYZhepc/s0AqKrua5+XUmF4kcxh
 M/tXSgEF
X-Proofpoint-ORIG-GUID: i6o95is3wjSJ8hcTCWN4yQF4-Io8Dofm
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b949b2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=_W-1yxQpv4NGZoZ9-g4A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On 9/4/25 1:51 AM, Rob Herring wrote:
> On Wed, Sep 03, 2025 at 03:37:25PM +0200, Konrad Dybcio wrote:
>> On 9/3/25 2:37 PM, Abel Vesa wrote:
>>> On X Elite platform, the eDP PHY uses one more clock called
>>> refclk. Add it to the schema.
>>>
>>> Cc: stable@vger.kernel.org # v6.10
>>> Fixes: 5d5607861350 ("dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles")
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>  .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
>>>  1 file changed, 27 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
>>> index eb97181cbb9579893b4ee26a39c3559ad87b2fba..a8ba0aa9ff9d83f317bd897a7d564f7e13f6a1e2 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
>>> @@ -37,12 +37,15 @@ properties:
>>>        - description: PLL register block
>>>  
>>>    clocks:
>>> -    maxItems: 2
>>> +    minItems: 2
>>> +    maxItems: 3
>>>  
>>>    clock-names:
>>> +    minItems: 2
>>>      items:
>>>        - const: aux
>>>        - const: cfg_ahb
>>> +      - const: refclk
>>
>> "ref"?
> 
> Certainly more consistent with other QCom phy bindings.

That, and the name of a clock-names entry ending in 'clk' is simply
superfluous

Konrad

