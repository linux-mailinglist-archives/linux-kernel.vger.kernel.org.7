Return-Path: <linux-kernel+bounces-770463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E842B27B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02D25C85C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89D2242D65;
	Fri, 15 Aug 2025 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pCqflBFJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8681F8F04
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246620; cv=none; b=KtxsUdMORxgppVdxNVWEbH1ySoCeBeFu61cLqMOSZOy9xVt/53+LwkUIoLExKhmBSFNhyDxXxCimoJgcbQVCUANfom2k9HBXYq0acJdcDpTO+obD/UJ1nbXDZpwOqvMCouefw0BYz+MvdJQDZ5eTbPkGqmpmp8hqVqrnKb7eKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246620; c=relaxed/simple;
	bh=FmjVh62gCljV2nTfbvJjcqmy+YAXiBC8ux88D8/fdLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRLM/zd2P6llwpzj9GJq7ve6wMpuItr2F34JdafZMDhF+Ixg7EWscL1inE04p4aJlZCa1aXRpolcb6F7a+eh4gKwxsC0QNOj/kIkSNEvFcsZY+GucHGYByOMtUWX8HiRd9fX0RnB89n3nZua9XkkwB/e+/vqHOFCDPfveRnbVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pCqflBFJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F7gEsc012072
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QebLpSI7tQ9noZzURxHg67s2/5ukonRzYWMzSKVz+Xg=; b=pCqflBFJI4IqiQ7J
	HAF4OUAeQSJMbu6j2QR79uhzh75gp1YDNzUce44AdQJCNtPBF7Txa+f1OWhxnQ7Q
	Ir/aEfuVoO8h7MiA/x5gsQduEhmU1e07d0jDDFtpliAfcgXiUv3NAcDCKsYIPWPX
	w4N8t1F/FnXCzZ1ZZsJ60cEloUIVEyu6CmoncWyhw3rd6LYAu7neAGPF6EkOFxFA
	OjvGRXuztpmbshrF+82QwLztQApw5+mprN0HS9eok6kTnVWbyag7qNuOcAfuEe4D
	XcP+U7gZHlrpSYqGVoe08yHXbd+IP6pygO00Col633buA6d6UoAbzOyrgwoliyk7
	mFfQUQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbnpqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:30:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-323266ccce3so643466a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755246617; x=1755851417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QebLpSI7tQ9noZzURxHg67s2/5ukonRzYWMzSKVz+Xg=;
        b=ZLShZOBi3sECLJEtrXJ+lj1rpvR+nTPV6X+Lyj//LaYrmJ2sM52AEZfcUwcIiOBrtd
         gssgYs456bWWKRqwjZlpriQ1+TxRKqZQG0MNr9hESGlO7NuebI9Cm6Z0L4yZRd2tqaiH
         eDarG+qByuvu49qfkScKRcx7xAMwilut+QeFhCN8kZXzWemqO04PX3AJUU+CRkRqL6V7
         OnPxuOGDru9fhnroYqQ1F8CCH/mGfmiZJhAV3fQUGaN2NEs7IdKMixBOcB3bZMpuEgU9
         XcQTxZLdSkZSGyFAKKjDk/XZcf+MQigwT+WbV5XrFqe5AifgiiXN8MFito8VM8igB6eP
         VGlA==
X-Forwarded-Encrypted: i=1; AJvYcCVX160nfbF8Wx2S5BvCRiUubUE14HXr4y3oHPwa3xmOIAcjmBknhRU6AwvKhUID1WFt/E/4/83pnQavgS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIzArkEJzr+1hVKZVg6e6bkkucfseaJRYFRbX8LROZcAd0hVw
	dSbfQJIFblkhx3xTDhvkTJsd7G1MQ7M17T1xUkaQLFlHRXwXY3VY1hxeLW3LOaofffenlsLSMYh
	pCnC+9ph5/XtaViRdPyG0HJzM12+J1COrcWLo0LVrRUcfU06oW5iSdgN7/nGYW6elbvE=
X-Gm-Gg: ASbGncukh1gmBBqwqhis432zgcCjuGwmvoC5GBpjCCfvUD/KwaDk4O8YuDqmDOHV2lq
	DQQdrAPBB/QvrQpMaOYFWdUy4g3FVpuqItW2tf0aEp2/iQkEz73Y+34ckIPKgMvGUbAew/nY2/O
	EV4H0zaLKMDZY0ntmy/e2Ock65QfWiuOb31j1CVY51Q0Fv8gz1nSWy19moeMF4wF4oinZeO1rUK
	JwofztupV/3OAUV+S1U5DxcNTDChW7YW5iZq6XSH/IQMQRG/Sn30jGGI6kSJjQl6CnRPTKxqdJA
	3Z4UfgY5VpKnAIikqv75EwBOsnO1N7DyitQ2N7qFX4yRoTpLg+Vd+jjmPZ4924NtEi0swXFCl6F
	o7gvm90a+L3RZCYLf58M8KK6FN9WQ
X-Received: by 2002:a17:902:e74e:b0:240:4b3b:333c with SMTP id d9443c01a7336-2446d91f8cemr8761305ad.9.1755246617094;
        Fri, 15 Aug 2025 01:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFln2KKznF1Tps3/NqBK7l91lHgqA0O4rpjpbh31rF6OlDm0+al8oFnjA7SdlXStf6njF2Khg==
X-Received: by 2002:a17:902:e74e:b0:240:4b3b:333c with SMTP id d9443c01a7336-2446d91f8cemr8760865ad.9.1755246616572;
        Fri, 15 Aug 2025 01:30:16 -0700 (PDT)
Received: from [10.133.33.10] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57e140sm8982125ad.156.2025.08.15.01.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 01:30:16 -0700 (PDT)
Message-ID: <f330e6a4-ec51-4682-aa35-bef9c6e8ad3a@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 16:30:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] dt-bindings: phy: qcom,msm8998-qmp-usb3-phy:
 support dual TCSR registers
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
 <20250722-add-displayport-support-for-qcs615-platform-v2-3-42b4037171f8@oss.qualcomm.com>
 <2fd202a6-2c92-469c-81c0-8852562d4e35@kernel.org>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <2fd202a6-2c92-469c-81c0-8852562d4e35@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689ef01a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=6sAUhDfBEk1Dn3Xrvb0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX7I7PSSXGcDg5
 erZS4695yJzS1gUFUY+JREB92pOCt0ynRCCMOkOEUy5eNQ0T44d6YWTxubOhwR75IjBoXqQq3tI
 MqmXN7l6n0MxlBY0Ac90GYHNj4hBFZnCrIPTdl/EXlQyIk4jiXD4DlFbpgzP947vNrl25ZbeeyP
 36kehdk/EPH1JcwMofvslNfM1+ZwqW6ZA0UMjBqrAySO0KV1J/ACk2/yGiTOC9PigZnvKjlNyoL
 hjeQ4r6enak/Vnyj3o5Hudiif9gxVaRr9WTJCmsBn+dRyLvD23YuWPK9IDaE9sPoMab1ICzCcIP
 KcuRbE/EVyq8crF7P8SiOz7khKzrpoql6ZvRw1UJiIOfY4Dbcgr80zeDeBYty4f9cfB/NaZWs2F
 JdsuxEF3
X-Proofpoint-ORIG-GUID: BpObskBPGdg07vTcaC7MrytxX7dveAjU
X-Proofpoint-GUID: BpObskBPGdg07vTcaC7MrytxX7dveAjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097


On 7/22/2025 5:19 PM, Krzysztof Kozlowski wrote:
> On 22/07/2025 09:22, Xiangxu Yin wrote:
>> Add support for specifying two TCSR register addresses in the
>> qcom,tcsr-reg property to enable DP-only mode switching. This change
>> maintains backward compatibility with the original single-register
>> format.
>>
>> Also update #clock-cells and #phy-cells to <1> to support clock and PHY
>> provider interfaces, respectively. This is required for platforms that
>> consume the PHY clock and select PHY mode dynamically.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  .../bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml    | 28 +++++++++++++++++-----
>>  1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml
>> index 1636285fbe535c430fdf792b33a5e9c523de323b..badfc46cda6c3a128688ac63b00d97dc2ba742d6 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml
>> @@ -44,13 +44,21 @@ properties:
>>    vdda-pll-supply: true
>>  
>>    "#clock-cells":
>> -    const: 0
>> +    oneOf:
>> +      - description: Set to 0 for legacy platforms without clock provider
>> +        const: 0
>> +      - description: Set to 1 to expose PHY pipe clock.
>> +        const: 1
>>  
>>    clock-output-names:
>>      maxItems: 1
>>  
>>    "#phy-cells":
>> -    const: 0
>> +    oneOf:
>> +      - description: Set to 0 for legacy platforms
>> +        const: 0
>> +      - description: Set to 1 to supports mode selection (e.g. USB/DP)
>> +        const: 1
> I don't understand why EXISTING platforms now get more clocks. What did
> you change in the hardware? This you must explain in the commit msg.
>
>
> Best regards,
> Krzysztof


As discussed in [PATCH v2 02/13], I misunderstood Dmitry's intent regarding backward compatibility in v1. 

This part will be dropped in the next patch to avoid affecting existing platform configurations. Thanks for pointing it out.



