Return-Path: <linux-kernel+bounces-832153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ADEB9E7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55797188201F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB05212B0A;
	Thu, 25 Sep 2025 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9OToqBr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E40142A8B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793619; cv=none; b=r1WNpXp0Qnox+ZCO44x56ZpOLXywCihz/q80/x6aa/ar1ysXs863e3YNaeqX9LNYY/1BNAvlJBTvZlZK2I++LXZLKjjBprAu26O8LryJR1qNOnWogjwn5Xxl7OkHCB2pov3hWtP5QcfIezBniKaZs0O2wlg4Tr8bHHD7BskKxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793619; c=relaxed/simple;
	bh=vKCOhHuy6TQ6kFtJSKKwqi86Q88qrb8jlKLi6GehGjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1WqmwdpbCnwwxf0ACVQjwFdLCSfuMYYxsgropeepMvAsNeoFnobqBvzbuz5af1UxUMMWP8g+nGFppb6Qy0u0/UQZzGt2ndHXKx2dRsuo/k8JZeQBRUP3yWqUGQU8gzaasPxIEk4gxkJ0laCLidD2RSGvOIYClS3rQIOkEq/+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O9OToqBr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9ZM67029720
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JmHxfa71BrXt3BKcwJJc0tD11WKweUFsuFqsRUHNN94=; b=O9OToqBrXkQELy/9
	ImYchcD/a51+Yx2YVyZpMDQpHTqrGDPzCXTjVQOfrMffRCsKft5mF7q7YStgiit1
	3kPzalTid1tltptkaLZG0iRSnKnRK/k7NehCJ2KH3OTaZajPGOTHDk5kcAwpy0kG
	qT6aaNs5QglqOeU2q1haAoj8h7N4A6sK4hbB0+uNwnEKiIzAAcTWuzLkw4mcdyTX
	aQ4a+569R5ZGSZHSCNETPDH5P5GoefMpmaLzNcEk3OQOuSY1YlSJ4VjIhIzSamWn
	Mhwb6nROuFuMJqing0oqXjl7/ytmuSYW+V7ku+zuXoaU3s5KLK++vOhOFR72Zno3
	OrLUHA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fqgyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:46:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-796f103f50aso1816446d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793616; x=1759398416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmHxfa71BrXt3BKcwJJc0tD11WKweUFsuFqsRUHNN94=;
        b=FOgQWwt5yKKd5ktsGZS2S8QU64REMjpBB2s0RqekYPF9dlfUocKn1Y7mkW+l9M6Nce
         tnxSvru6ozGpyASCbmfQ3YMeKH/g3A4YzDHqRRPzWJ/+NhDfAAmyM7OPqlD7deaVBO5f
         c7UijGR3czekkNqwl4qeo2Bmkb8kxoC/9TxAU5Lic6zq3i9bF8NTMheqNViUWbIrvPfB
         Wk4NVbrv7bLnu1uwDsVyxuA7znNuU8FRQ05wU77Z+xAssvdEP7TlJvqUPTmJgTQ3lkfE
         j/H9Tb/NummjHC2H8zZsslEiWAhejrE5XfSMLSQoEPeqwiDTXBFX0zHcDv+gHmq8uhWG
         pP2w==
X-Forwarded-Encrypted: i=1; AJvYcCUM+kpiDq7DcP2gLKbsFYrV4arRgOyXGo9xFNGK1xbVdmfksN8KaP9Se64D4aawyBogkpMJN5MaXEM8AsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4W5IwY0d1qSwzfPHSM2BSpHM0plsqvow8t1AnpMw+LOJ9A7Hm
	F//9y5ua8FVpccyMgbo9MeGu7yRmSpXyjVQcgAfeDxq63mr26+XOtOHF47bjSxzA69wJhx8Yh25
	0mBNlrI8ANpeqRDxiHWAwICgkqHT20DR9KO/3Dno3uAF3PREqs3iIj3C5MM+CtPWnTUo=
X-Gm-Gg: ASbGncso3Wogxm15VDJXrNJksXkG680ysL4NjHL5GhVViVrD9Y+JZ1fHpLMjwDrudvW
	yhRB022sFa3fheKCcjHt+cmRdAa0mA6LHOZ8p6RXwHM+cY0W9omSrq8lMuNMPS8Utbm+WS3z/JN
	roAIu6Qac4iTyikElBYK5ryHHUZKJAu0iwcL4Z+oCTCarC4ecoeZ0jTadT9OjazqkBfyDqzaByV
	lR9mHGWT/I1pZMbpA5ia1jpTfR35mMv+Ech2beamBlio5vRlKvpV6liD/rMJfy37HIjDSQkPG0x
	//H05Fbu37JCkF3enn/nwKLuP0bX9HDAUVkr6BdfIA+b931F+5n68qO9qgN3eZE0GRXp0m96CJb
	R4cIzrxFraipGTRXl9C2nnA==
X-Received: by 2002:a05:6214:501d:b0:78f:baa:5712 with SMTP id 6a1803df08f44-7fc321f13dfmr26645926d6.1.1758793615934;
        Thu, 25 Sep 2025 02:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs3+VT2cJTyfYqoNxfO7ts00JlQscp5eBOdWL6WQlDnJsf/ApueNr/534dZ9xDeLw6b4HkNg==
X-Received: by 2002:a05:6214:501d:b0:78f:baa:5712 with SMTP id 6a1803df08f44-7fc321f13dfmr26645606d6.1.1758793615306;
        Thu, 25 Sep 2025 02:46:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae2cd7sm950965a12.31.2025.09.25.02.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:46:54 -0700 (PDT)
Message-ID: <f7b46afd-eeaf-4647-a721-0bf092ab8e09@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] arm64: dts: qcom: kaanapali: Add USB support for
 Kaanapali SoC
To: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-6-3fdbc4b9e1b1@oss.qualcomm.com>
 <sn5a3dqnd4xz3tgtw4vbmjr4pdow4qlo3jjryp5c2sx3wzke4j@fnbexj3kch6d>
 <00594112-36ac-47f9-bf26-2270b7cc3266@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <00594112-36ac-47f9-bf26-2270b7cc3266@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MkTyffQf6VLYMcEJ53ZwbYI3hM5xXkbW
X-Proofpoint-GUID: MkTyffQf6VLYMcEJ53ZwbYI3hM5xXkbW
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d50f91 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=uCnE5zM3HIJJKuD88EYA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX6sRG5y86pLCU
 /DRBsSVWvguCf29QwHpIRNWT3J8Vzm1iJEtS8VvTN8tGs+VojLgx7T2fKwRYT9ONwjPejzE0O2t
 xNQf3N0LhQ8JSauNm2FgljbYzp4+yn6dMKYEXgxVXGliXfUEu/5lzBah7sUR3NTjFrpfBYN2Hgb
 KCP3wv7T+G9DPKJgUBOUwqDebBrC+230Cwa0aYAJQipyv5QCLhoDOAk1Hjd7DYfaB6Bf/EWXHYI
 ityrZiuZTytusjaMyQl7i+FysxxN3hnLy36G/vV/BaMg3dieale5hJYIRbaEWko/ZMpUxtCeQTi
 3NHa0T4hOtRMzE/2ipVER7ETwcLpoDcCK29659TKwyQMG8YbK/qk9pTNry3TJZ2jQrpjOpBg+08
 4HzQ9K0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On 9/25/25 9:49 AM, Aiqun(Maria) Yu wrote:
> On 9/25/2025 11:20 AM, Dmitry Baryshkov wrote:
>> On Wed, Sep 24, 2025 at 05:17:23PM -0700, Jingyi Wang wrote:
>>> From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
>>>
>>> Add the base USB devicetree definitions for Kaanapali platform. The overall
>>> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
>>> (rev. v8) and M31 eUSB2 PHY.
>>>
>>> Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 155 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 155 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>>> index ae1721cfbffc..08ab267bf9a7 100644
>>> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>>> @@ -12,6 +12,7 @@
>>>  #include <dt-bindings/interconnect/qcom,kaanapali-rpmh.h>
>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>>> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> @@ -958,6 +959,160 @@ opp-202000000 {
>>>  			};
>>>  		};
>>>  
>>> +		usb_1_hsphy: phy@88e3000 {
>>
>> No update for GCC clocks?
>>
> 
> could you help to have more detailed comments here pls?
> For this driver phy-qcom-m31-eusb2, only ref clk is needed per my
> current information.

The QMPPHY acts as a clock provider, which we're expected to plug
it back into GCC (and DISP_CC), see e.g. sm8650.dtsi

Konrad

