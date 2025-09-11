Return-Path: <linux-kernel+bounces-811716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F87B52CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F21C20B27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1F2E9EDF;
	Thu, 11 Sep 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+EtQOfO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D952E972C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582341; cv=none; b=dEofVosn1Y4WdqIDpvBNM67VZ8dQSiOGflR7QRYWTcFEnuHfdlQzsVefgJmfMKofnvpijctMitMcBIFM2r7n3GufcYqqLfrbGwgEbliGC0rYLSPKW5xZ2r8uMHxe3AsL4ax7aMW72mniARxlDdJf+GqLkl0m3Y8RhwRgoDQpL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582341; c=relaxed/simple;
	bh=BVZPqK4yiZr+zCprTIFb581qJ4VMxjfjDLW3iCiUq+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofL+fAQki017fvdH/v6N+poEf64MU31miqbYCK7xCL1SELwla6I3ufugE6F9HT5n2C9PV0xuJ0NydQ3enknJdvUoPCNpqqVwyKf0mtPdSXPUFCGoqxJZI+/7B13ITGC6AlEWw8dPALe+FmmYPTBHMn2+PsmWaq7Z4aKWfRfOf5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k+EtQOfO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IkXL002496
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5bezhBuF4V+ybzXrQaFEQjpHR9x111qy3qVqkDZWxW0=; b=k+EtQOfO9mI+GZxn
	FMOypxcStoOpBCYlG4Un8ZZOteM61Qkd8OJ/bu/BEVe5mIXr4D+ZasyrSX/wU9gm
	PRzlGy28CC7qaKvGR7E151JuWJAzzebDYm9cPeYgViBl7pNZ7lzVGpBCNzrKet18
	mhbk426TWGWdMdvznD/sP0LQe4WiJD9GH0HibFhaGjOEtmvJNnGXAyJ6rxjRmme2
	gbrnNOsxOquarYPI9HHqegWp/dc2P0YArLYFQhcEgFZJmNN869G7tV5MDCQp9GvW
	+NND/QaewL2P4pAp7941R2qTnl9p11Zf+T9rrhzWakZjrrUeFFg0+i4Rp6DGT8ia
	54+mgQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8q3rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:18:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b600d0a59bso1675631cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582338; x=1758187138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bezhBuF4V+ybzXrQaFEQjpHR9x111qy3qVqkDZWxW0=;
        b=htpIde/SS/V34/1KkgzbSjHbLN4rWCT/YxPO01wp1oA899hlC2+HdZ/1aTJTZ4KvaC
         Hr/Z2JByCQIL4UWaClRbPPC+S1ssB2gXBQrvW/th1No5XHZgjifyRaSBP6zxpAn9oPpT
         QfV7kp1JglyBmjcE3skl5Fpy/0NVjtHdbkJafkP0T/OSgQasTnixvj4Mces6xX1w0axi
         S7szg8F+mb2lbX8bf7d+n/9o0M6wojnh1i0WLoXtC4ZQeYSfWAP0q9vYSPBtAjdU756n
         s+V7lAYQnJWZUZw7YligkqZiEwpYGgxymCDjT56jiss3cO8q4F7G5FaTCme2KTx0Lp7l
         nEag==
X-Forwarded-Encrypted: i=1; AJvYcCVS7+HaeE83kV8Dmfvf1aZVhq6Gf9djCP5xCIyybDovQTd9n8HDEY3gFKbD+EtE2FhlHtunLoRGgSLYNT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbyFUa0bhYtTnbVwJ51tWeh1p84Stj/QSHsasotd51d89GT3e
	H4rQUzIV4byL2uh5Rn1Dy3EkRV7WNQagihNCFAkAM+NWZz5OwYfnOrgtS4jQAlJlSAyZB2Swgc2
	VvB2YQXWfPFrHmRgmBQi1QtkocpBdF9LE+3E8OFHvEndeBW+9paOTt20x0BOqrOsKK5U=
X-Gm-Gg: ASbGncvHzS3WWJ2fXn09XIBUuOxa7s4tBkClEbUMJAKcDQS+mpeRMHmAy+CWw7ObMvS
	3xLncJD9wybFwPUsK//S13m9mmJkLDgdM+MgTPy/vT//zm5e+5MZOqbkUL13KFgeLuU609BQpJt
	E+/mRWrtFFPGZtbM/KZi3gcuMFgmjzc5qbCrrpUh21JydJpqoJQ0fuawydAvbJk6BN9CenoiEq4
	mCKv0yX6XSCCwEJHihecNR0y1o9r972xsOf7w81UpWWtRuvI/M9H8wrZzfOz5iqy7jp+3DqU/aL
	LpUHWBIugOoNn5u3b0UVTQohIdG1tDLDbxETvoKo/2XYGowcHREwUYe0oWyH1s71DVzkwSrGNnh
	7qEcd6gSbFJNjAGOXWBI04Q==
X-Received: by 2002:a05:622a:13d4:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4b5f835b943mr127330321cf.1.1757582337858;
        Thu, 11 Sep 2025 02:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHej3+Jv2aNe7UGy/rc68B8SuvBsniqqU8vGxQjkNQ7UnfITPBTfccyXJrxQognHpUtMSpmCg==
X-Received: by 2002:a05:622a:13d4:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4b5f835b943mr127330081cf.1.1757582337152;
        Thu, 11 Sep 2025 02:18:57 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dcf77sm88434166b.64.2025.09.11.02.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:18:56 -0700 (PDT)
Message-ID: <fff688c9-af7d-43fd-a3f1-00209842bcc9@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 11:18:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] phy: qcom: edp: Add Glymur platform support
To: Abel Vesa <abel.vesa@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
 <20250909-phy-qcom-edp-add-glymur-support-v2-3-02553381e47d@linaro.org>
 <3bo2xr3jb3hrzsetjzd62dmcif2biizvoanxwtyhr2dmkb4g7x@dgrcvzujcwgq>
 <wetzewmbraeawwintmxqntjhvennq5iu2jeegel3glk7y6rsnf@4vwscm5bwezr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <wetzewmbraeawwintmxqntjhvennq5iu2jeegel3glk7y6rsnf@4vwscm5bwezr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX6EXx0cisV5vD
 0qHex03w9CfljRys+bw2GDysGwqgfQEnDXGNjNkzSwKM4ZTz1a2p5dCBU3JE/mecbST/F8Clwlh
 F9Bv35jd9DyYtHZOjdTQf6dslEATb3sizQoPfzHdFrhaTEuoj42B1eKnZs2KqlmAlrQWennIwoe
 uS+8ZyFTW/kQ0fC1Rz0fJMpaIXujzq8EWbyj/ML45jfPa9/3GWXdhNGGQsVSQfzWVz7VJGvfLGX
 hwRfrVdyWAcO+riaNeyR0gyY/VrlwAAG+EqwwV7zGRdNsuLFiT88rc6lYCKJ9cQtMJKCZMChsKH
 Mew8HfeDO93ZesoZMPbHz7/1IhRHVeXrDA+gGocFm1O2oAQNsYFEGK4FKimULTPE/ENvPeOzaiZ
 jxLBwhHa
X-Proofpoint-ORIG-GUID: pGPoohOS0UaiMUZ6ksmEGOTKrjU0LYsm
X-Proofpoint-GUID: pGPoohOS0UaiMUZ6ksmEGOTKrjU0LYsm
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c29402 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=XHNhzRT3Os4RIKAzT70A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On 9/11/25 10:52 AM, Abel Vesa wrote:
> On 25-09-09 14:12:46, Dmitry Baryshkov wrote:
>> On Tue, Sep 09, 2025 at 01:07:28PM +0300, Abel Vesa wrote:
>>> The Qualcomm Glymur platform has the new v8 version
>>> of the eDP/DP PHY. So rework the driver to support this
>>> new version and add the platform specific configuration data.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>  drivers/phy/qualcomm/phy-qcom-edp.c | 242 ++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 235 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
>>> index ca9bb9d70e29e1a132bd499fb9f74b5837acf45b..b670cda0fa066d3ff45c66b73cc67e165e55b79a 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
>>> @@ -26,13 +26,15 @@
>>>  #include "phy-qcom-qmp-qserdes-com-v4.h"
>>>  #include "phy-qcom-qmp-qserdes-com-v6.h"
>>>  
>>> +#include "phy-qcom-qmp-dp-qserdes-com-v8.h"
>>> +
>>>  /* EDP_PHY registers */
>>>  #define DP_PHY_CFG                              0x0010
>>>  #define DP_PHY_CFG_1                            0x0014
>>>  #define DP_PHY_PD_CTL                           0x001c
>>>  #define DP_PHY_MODE                             0x0020
>>>  
>>> -#define DP_AUX_CFG_SIZE                         10
>>> +#define DP_AUX_CFG_SIZE                         13
>>
>> If it differs from platform to platform, do we need to continue defining
>> it?
>>
>> Also, if the AUX CFG size has increased, didn't it cause other registers
>> to shift too?
> 
> AFAICT, all platforms have AUX_CFG0 through AUX_CFG12, we just didn't
> need to write anything to the last two so far.

I checked 7180/7280/8180/8280/x1e/Glymur and they all do

It would make sense to perhaps spell this out explicitly in a separate
patch

Konrad

