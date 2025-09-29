Return-Path: <linux-kernel+bounces-835784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284DEBA80CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E233B1D63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80921FF60A;
	Mon, 29 Sep 2025 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QvCqcVRQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579415E90
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125763; cv=none; b=cc9hZj84ipfAi/Fj0eHzsWeOEHGYVYUqz3ym0B7ui2kU7zQm3QB2z8XN39kenhIqY8jj+k2qL6Gd11WNQBpnu26GSbWOQIW3Gsv0CV3kpP+LSEAVMC2QRttS3H6SMSTT3WkKodbnQCAtyBkmctOmSedBFMOAtiVSYw2PaF8Z+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125763; c=relaxed/simple;
	bh=EVwKZ9ffdaADDxMp/oxfmX/duyCcrAcbHorH6J6Cjhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMUkFerFFm/Vn2VL85/13lhw8jNbR0/8/e1J1PPg8TElVEgI0lbUE2EtmhCDFQ/PZHBFUETW9vZnNj4rmZE4HAYdD49Wvz+siBhKsga9p6o+Mh2JugFbpWQZAtItSvbM06vcMgLdUHj0duOJQFQN95RnpAk2+LU6boNVmoDZX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QvCqcVRQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T0AgG0016746
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c84sJy294lRAsvdayLiR1jZLIpH9uaxLIGDdgwQe68o=; b=QvCqcVRQzLPsbawx
	s58RDUfGswe4txwaxDvqG8Rr0YstVhEvzpYtaw18yl+ljSv2A9AFa+gnvXerbPVS
	ogWP0HXpP7HPbpUieUNh6Fr4CpTbyPcOCEuFz9yaBW4x4p8QZkOIZ3koQlXRHJ5l
	GL5Du2iVZS81Q83/tq3gTb750URX8G/4dBtel4uNq4cCcU1aQMYq0GxPZ4oVqLgX
	ALSGbfLHApjQdhNXVCwzfiqgeFjX7OPYH/a3gIYtz6m4cfWVNQrdEtJeoIicJac3
	eY/HKQ0sUMxNTXEbjEYnCkGBpA6EFKdigFb3vR//5y6WNkOnLEYuOEXkW2avFOiT
	HDiHwA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mcm9t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:02:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2698b5fbe5bso64747355ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125759; x=1759730559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c84sJy294lRAsvdayLiR1jZLIpH9uaxLIGDdgwQe68o=;
        b=mTrvxgjwq2KpXr77LIjzvqdJMwds1nrNP8fcSFCkLZoKtgQm0nNKQCCWZUiX1TXfhq
         xIbz8mrJ/XRWn1426chG5nECCyOLM5l21sqoAydFmEjDZ67WrR7ngvnmBGukl+8WQMuV
         f0Iu6MzHF2rkV13d3g+JqNgHo+ezBFvoP82n1+p6HEJYywh3UCvg1vD4+5PjANvsgBp5
         k4ez2uoUqq02ykjvaeJaR+JKkhY1PCuH0wKHAF57CWChnQ8An+E98B95S06qaP/B1IiK
         7A8qAzesTvFL+DBz74JquBra1zicQfyasH2rczQxidEc0NtfVxIwSKeaqNOOxpT1CrVY
         rpjA==
X-Forwarded-Encrypted: i=1; AJvYcCUpWWBXpiI6toKaQ9YyCVV/lnyBzGLNZM8RPXyLTZ7iRIzlFthbnJqiFKi+sYu/alxqwurJUW1vbZr1UU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7P69XOuIfEmPG7gVGJI5DkVxWrebEQ2eeaj4h3Ogn4yy2t4Bw
	2b2M/4p9XtfIhPwSqyH3DHJmctPIpx9akyXRYDIsLJlOAQ3i6vD1EJ3Ifyuw0evY4xSX9OvjwyE
	lgNgbunPjmHd7wwHVTw5bQQQaFeTAjxwCr0n2WfKt44g3+sy/h1P+1L26+tE6xAem3Ko=
X-Gm-Gg: ASbGncv1Q/62IQgOQ7i6Tw5nmePf/Zyy56RebOnABrZW5iEJCMnQTvkNnjl73rwD9Er
	2nxBa5B6YtCtRTnjldRuYt+HcFq/8M2BJK0/jcuyso70++og7nepOc/goja4JTi/XublHk79/E5
	dCPZJoA/aCdCocJBj/mXqJvBaOH7l/6pEEe/SlBZZXUz3K1tOP6ew2dqpIMtSP4L8bJIUy1xeZT
	gMwfaiV9csDMa24v33o+8BrjCnDjoYPLzVWDkTj77A6OP4IVrq4NYN13DN7WodV/mUPkWYSjDwP
	dlS27oW6lhD10OHB6K7wQXHwfl/oAiCavgF4SkbKvyF4a+eSHvM3ZG8x1shPfRZhs0LxJ8SU87X
	b5245sTW0Hcrx1II4GPxHzUALVAOE9tA9c8k=
X-Received: by 2002:a17:903:38cd:b0:27e:d4a8:56ad with SMTP id d9443c01a7336-27ed4a85a82mr165732335ad.61.1759125759079;
        Sun, 28 Sep 2025 23:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ70u453/jxOUh+G0kG8uuIYknKfil7i8PuspUU15QgIdesSV8W24AVurbFTeHJcYwjL3wwA==
X-Received: by 2002:a17:903:38cd:b0:27e:d4a8:56ad with SMTP id d9443c01a7336-27ed4a85a82mr165732105ad.61.1759125758595;
        Sun, 28 Sep 2025 23:02:38 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882133sm120557875ad.89.2025.09.28.23.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 23:02:38 -0700 (PDT)
Message-ID: <7f4bcb3e-2469-41d0-b3a7-392ffcbba515@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 14:02:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: phy: qcom,m31-eusb2-phy: Document M31
 eUSB2 PHY for Kaanapali
To: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Ronak Vijay Raheja <ronak.raheja@oss.qualcomm.com>
References: <20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com>
 <20250924-knp-usb-v1-2-48bf9fbcc546@oss.qualcomm.com>
 <CAJKOXPfVhixCk0_Xh=9XokjHObM=P+SP=itaXHv7xTr69pc3_Q@mail.gmail.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <CAJKOXPfVhixCk0_Xh=9XokjHObM=P+SP=itaXHv7xTr69pc3_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68da2100 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=nQufxc_MvbZzznxDM0EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 1WKi-ceeUsTYbWXTiV7fbzHN9xNAFt4a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfX3qbkloB2zqnJ
 pSVgCRlGJqgXgh3pNSIhf8I+/QJ0xu2wZNBlk705M+CbNbTntRJciSjhoxtcuxt7t40kiZ1jtz2
 csO/VvUglIMpGi/mEUVfxUbej7mwpvHWIPMncuN9ZXJELzjL7R6liNCCOjlOVUFEEeM9lwoo+Uh
 r+ro3mt6WkzwFmNgQm0I9HmGC+ZgaZpndGnjXg0twgjLtQeSm5Csbx6NQDVgO4MAFZ9mqb00eW7
 kowr8d8GJA/nvrB1RYROdFfZQoDjLO4IXUwHRmuqlsnNxOvcZbeIam1fB3JndIpy7FnLgAL4F2E
 scMUq3eDZJYdFO6KEpVOEfnAJIPjzuXXekp6O08yytOGQuC1/6iDnUb65xJXtGHzwIVTU4TIzm5
 NqKAlDW+7RW6Bk8eu6+5ZiHkY4WBXA==
X-Proofpoint-GUID: 1WKi-ceeUsTYbWXTiV7fbzHN9xNAFt4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004



On 9/25/2025 9:46 AM, Krzysztof Kozłowski wrote:
> On Thu, 25 Sept 2025 at 08:35, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
> 
>>  Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
>> index c84c62d0e8cb..ab1cdedac05c 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
>> @@ -15,7 +15,11 @@ description:
>>
>>  properties:
>>    compatible:
>> -    items:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - qcom,kaanapali-m31-eusb2-phy
>> +          - const: qcom,sm8750-m31-eusb2-phy
> 
> This time maybe without HTML:
> 
> There's no such code AFAIK, because original work was never resent and
> never merged
> 
> You create some convoluted big dependency chain and I suggest first to
> finish upstreaming previous project, because otherwise it's difficult
> to review and impossible to apply.

The SM8750 USB support was partly merged,
The qcom,sm8750-m31-eusb2-phy binding was merged in commit 1166a2ca0900beafbe5b6d1bb357bc26a87490f1,
Link: https://lore.kernel.org/r/20250527-sm8750_usb_master-v6-2-d58de3b41d34@oss.qualcomm.com

Thanks,
Jingyi


