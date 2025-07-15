Return-Path: <linux-kernel+bounces-731528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B42B055B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BD3189451F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE8C2D4B5B;
	Tue, 15 Jul 2025 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pc+0A6W6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488B27510A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570100; cv=none; b=QpIDS8fweR6wRmoc6NnSSAlJA+LFqRYWvsusSozskgOc8N+jfAsk/d/F4LQoxwFFgPsXqPt5c9Yt7+CcJaRn29sRXBO1qna0tb0zl3w4ctn7JYF+pHuDOFAvCN6wgeL0Iydt4YyhO3Eg8Tf4ljoj9VhwTsmIJSCOS/b3eBMOyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570100; c=relaxed/simple;
	bh=eWKL2Pfk9Fvzk6xqq6xZOUlHF4Q+kqfHm4qTAQTuWGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3eXrIJqGDZTHfxVYelIQxwob9BAW09UDp5yY2Iz67hBBJdtxBYwnreJRQwSdNd4yZ05b/zGtSVikI2PB7okyGdocOux64cuRGRCO4qYpFseVai5IWtLGdZvE1isMHBPo7oPvydhHDBfSosV/MxtZOvzBQ237egYZjk87R+ZcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pc+0A6W6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F5k2bt018610
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8a77/rgWkOVThBy9w14I7Q1+EzmtuydM2ty3lJNP9g=; b=pc+0A6W6hdxvvbE/
	KhUzixK2WYyLJVnPP7GZ6SneWqH7VulEb0DCMvvJ/ujn/NY0TbR5AmIdeh/H6PhI
	Otyb9R2HiWAu8GOQzgMeEcEZuwlM6Z9dkqQXXutnGIyeiFIVriqr+VZLiQ4/iIbo
	gf7CuLT2TJl5W9SSnA6flTwVL33qPTiYKtM0pOX9N9xnnPvNdW6IpbN466GU7NGw
	P8GwpKtC7vkc63+j/5x099za08UDBk3P8yx6TqKwMEUoeE24sSEw2ydqpbx838xm
	oNzShPGdHuWQ3Q+e3B4EnteR/w7siLyOSLkOgzfOUzdZ0Yedq0P0v4dcmq5soszo
	JIRIOg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu87fwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:01:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7dea67756f4so101215585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570096; x=1753174896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8a77/rgWkOVThBy9w14I7Q1+EzmtuydM2ty3lJNP9g=;
        b=tn8847NGtMf2g4KBWWx16oZ6h/RwUVuHgNO0lChwlPljZYeBw5GSVumgmYIRTjA/pl
         +5IXfA7Xp1rAyw2ak8TfIJ3gxvzKC6CspB86+L90xgQROK7KWybAqXW49PwKT5GXCFjm
         SSu3oYwdDEJR/H9SC1GctRYIpWtc3JZ6mRqdGJzrDhnYxeWINhIbDBQcUa+Elp6joexU
         bT7BoiixnuWMvPw1y4AAD1BItfk3T/nKb5e/iNOqOj5wySCdt/tlTJ+ti6ydRMdhHKJX
         Xxf14+LwPkjVg5CzcQu9heNEXS7moDm+cK4zpJZm6cc1qUNCpNFk0phex8IS+A2Ced3z
         LaSw==
X-Forwarded-Encrypted: i=1; AJvYcCU+aBakPfyxn0rS4Hq2NSpDSq8iGrsXh7Gu6TUPP0nP5/j9TmBRn3CVguIJPl1idCRVrXZN0CvcUCMY7xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTftuneQFqeTTV3M03i6A66oyuA9VMLp4JX+uYL8eQVD6S2r3
	zPouKhtrMJDwhMH/lc327qTvd8UytLCvwPbrpZPC7e1UCGA+ZBCa1ccgFscG5yAon+QIm3fufN4
	Ye17pUrst5lapFaGG2WAFujTHpP21ionQOCB60ptGX8G9wuL1abFBMK76eQGa3ZJto+0=
X-Gm-Gg: ASbGncuSUiFCOysQ9DJlL4HoiLqhtbjManGhoxX/B7m3tTXpM5N6mbTLmzyhF79yAnp
	7cIqQXVphwTmJUEkZq5mBVp0BOktMc4y5Imi/SZMFAWlpd6LVO6LIWHSDb40ogkuu2ColZ4kVSu
	zeHTXWE3PlbpQ7C4WGoqnmpMUo7fldylvv5ClkL+qZ6ksU38uwTxbrDI1K1SKp4eFn68CEH4/UO
	djG1/TUkuK5zRYgYy15hfysLX2OkWk8qT3p+2Ep62lVEUWep/k4HCxjGw//8LCPAoCocD2UkzGW
	zaYWI+i4P/8xWu5ZTEd7yQS56b5ehBjuhtGL6RGgrXL1fDYU9x179a5bVPZ8YpGi7tJsN5NvYv5
	5No0h8qr8H+edhZIs3EFb
X-Received: by 2002:a05:620a:2953:b0:7e3:31c2:2808 with SMTP id af79cd13be357-7e33c74677cmr44164985a.5.1752570095541;
        Tue, 15 Jul 2025 02:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnFcI+xso0wXHQrA1YLMhJJGyjMb4Uc71Eps9YMyLdxP02OOfX8h0vUGMbiD85MbssFlE5nQ==
X-Received: by 2002:a05:620a:2953:b0:7e3:31c2:2808 with SMTP id af79cd13be357-7e33c74677cmr44163085a.5.1752570094928;
        Tue, 15 Jul 2025 02:01:34 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611ed4c1830sm5595614a12.69.2025.07.15.02.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:01:34 -0700 (PDT)
Message-ID: <3b760685-97db-46e3-80a3-7fad69ad31cd@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 11:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vinod Koul
 <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-2-74acbb5b162b@linaro.org>
 <11b573d5-ce4d-476c-b94c-216d427cd838@linaro.org>
 <08261aa4-689b-4d6b-bfd2-221c1976d254@linaro.org>
 <a7f64b31-4767-4281-b452-a2bc5351d745@mleia.com>
 <c93624bb-ee7b-45ac-8b53-b5391f11c9c9@linaro.org>
 <eac3a877-a4aa-4789-9013-ab8b6c91e0f3@linaro.org>
 <0a12879f-dc4a-47fb-87a0-ac4b8bcd4d75@linaro.org>
 <53a19b1d-5665-4937-a07c-5dd1fcde06c5@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <53a19b1d-5665-4937-a07c-5dd1fcde06c5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MSBTYWx0ZWRfX4dBoHMLHI/yF
 aeJ9BxlCKR8jnkvx0WZ95y2U8HajzPoXyI1H92dfs+XNnJKE/v424SZcitDp+mA/sEaGnOAonML
 pS73cLrDK7wxoK6110vhJ+BpOEutilbn9dQsVWv4EtrW0M7kOy9H7HzuihWAmfuYcUR8FyZVc8V
 YmOiIcQEYlRVzHekenzbFA3X1bsCUsZSC4dDB2prckjea8oFpv5nXDMN+oG+dUbIdpCJ5VG5v4f
 fdt2kI/RlWZUh4h13v4FA1HGdftJD2WHsMdgGLwioFnwgTbR0zYNeJjXsHktbG9jKiEFOPO1ATn
 ac1Wo6F2pKp/5D0JjaMEMs8iOlRedVaHF02MucmGR60xIq6VLzEsq/jc+KFlQqD/lIvgIKksE80
 3Amrll9uTe0x3wLiubNTLAZPRCANzrt+RRQHKcrPJ6xSgnphDgq0mC5fHezH1AJWiMoLhvm1
X-Proofpoint-ORIG-GUID: AkeEmi3ZBbTgJAKe-K5Dug2RDgVY738c
X-Proofpoint-GUID: AkeEmi3ZBbTgJAKe-K5Dug2RDgVY738c
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=687618f0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Smkn-MmeJTYLAJgBHQQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150081

On 7/15/25 8:35 AM, Vladimir Zapolskiy wrote:
> On 7/15/25 03:13, Bryan O'Donoghue wrote:
>> On 14/07/2025 16:30, Vladimir Zapolskiy wrote:
>>>>
>>>> I think that is genuinely something we should handle in camss-csid.c
>>>> maybe with some meta-data inside of the ports/endpoints..
>>>>
>>>
>>> This is a CSIPHY property, a CSIPHY hardware configuration and a wiring
>>> of sensors to a CSIPHY. Where is the relation to CSID here? There is no.
>>
>> All the PHY really needs to know is the # of lanes in aggregate, which
>> physical lanes to map to which logical lanes and the pixel clock.
>>
>> We should add additional support to the Kernel's D-PHY API parameters
>> mechanism to support that physical-to-logical mapping but, that's not
>> required for this series or for any currently know upstream user of CAMSS.
>>
>>> Please share at least a device tree node description, which supports
>>> a connection of two sensors to a single CSIPHY, like it shall be done
>>> expectedly.
>> &camss {
>>       port@0 {
>>           csiphy0_lanes01_ep: endpoint0 {
>>               data-lanes = <0 1>;
>>               remote-endpoint = <&sensor0_ep>;
>>           };
>>
>>           csiphy0_lanes23_ep: endpoint0 {
>>               data-lanes = <2 3>;
>>               remote-endpoint = <&sensor1_ep>;
>>           };
>>        };
>> };
> 
> Don't you understand that this is broken?.. That's no good.
> 
> Please listen and reread the messages given to you above, your proposed
> "solution" does not support by design a valid hardware setup of two
> sensors connected to the same CSIPHY.
> 
> I would propose to stop force pushing an uncorrectable dt scheme, it
> makes no sense.

If all you're asking for is an ability to grab an of_graph reference
from the camss (v4l2) driver, you can simply do something along the
lines of of_graph_get_remote_port(phy->dev->of_node)

Konrad

