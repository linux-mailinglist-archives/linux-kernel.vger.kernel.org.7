Return-Path: <linux-kernel+bounces-789249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 569A0B392C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0651B242F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471B26561E;
	Thu, 28 Aug 2025 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k4bGtHj/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96414F112
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756356680; cv=none; b=nHRDahv9b0ZJzHBUVHv4kVE8B0cStOVBMeqKT1bhbY1aN44nq+kdp235X/I+X6WFRreLH93AcsvDkty89nynBWIa1e5yzggzwHca4FuTNungfYiCGvJpdDN56JqVFYj4LQW+foqbiFMDyk3A4rWEOuteKb74QAtJzpxtu3gU58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756356680; c=relaxed/simple;
	bh=sW+H8loYGF2a7tRB3sx4xlDEPinDir8bUKJY/rco5A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+H0No2asb7C8hpzX5bTHrRxn6fm4tYKCP0IAhhHPaNSTozC4pLfraF65qaxaByBOeqUvVQi4dWNoZIk/C9xa6X62PU+/Ez9u2svEZqcrDYixf0+/i69jJUVGJGsBV22u/CH87nMiObalKjdtW24Iw65BeosgyM7/F+G9XyWOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k4bGtHj/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGpBwm030476
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jx+gQH4DjWBB2/iazSCQmloXHWcepkEB1b0fEXviJpw=; b=k4bGtHj/gKo8gjmQ
	A9eJvxG33infZlCbybUvdrkUHfTeucuGnhBKjiQxy7fRgFtO9KCY7utD1yQ+JdQ2
	a0Qi0JIaofhGapQPGrmZfhuRFSKuIh3cJKwOLgqpYhQaHU9VUpvmDaIkIMTLyVdW
	9RD28ON52PiubJqyM+RayTbLb9sbEdjHsBQspPQ0dTA18tI9tS2C6j4TV/LY9h/6
	heFCPQTDy6mWNg+udOCIy9Ft/5X/MIECfp3m64Eh6NOVStMiK5AYBLGuusENe/2p
	kQA7JXDo2AWC8YWA0x8nNKMUnqRVGShTJhyNHZ+MKYUDYnDvdP8tPmwpnorpubZc
	gwzNNw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unxrk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:51:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3276da8a3c9so86087a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756356674; x=1756961474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jx+gQH4DjWBB2/iazSCQmloXHWcepkEB1b0fEXviJpw=;
        b=S7NQPevuVDnsBb6L9whaUMbg6b/Qgzd2GA3D4XMsY0V1tuCwlOroHkVq9m7C5AlpZw
         VRc7pnFp4QtRxOXFetfE39T5TxjJJuK2AUHBkztHObrIzptjWLEUgzgfqqRp2atQKyDi
         oob3o+6747+RgQO5gym23Oavjgttq2yToV8wpCSF2T/PR2D3PUoUX9WLeKk5JRMzizg3
         RdJWyxCHg/bKp6YJ2pf7Emkt8T5CVzO0jWFf9PqFVBden5FGAkFY15C4P/XkEPF898Pa
         zZRimg4Z/ewNfjlPn+94mMOX9oR59Udv3Q9Smh1kAJWq5A88sSLoRlWjzurgId+dLYyH
         pejg==
X-Forwarded-Encrypted: i=1; AJvYcCV31d9k7W9agxUYW20X/SsYPuM6f8/nlafqg68qVXXyHIItWs7XqzZz7sbNYTV6blkvbQjPI7JYj5bvivg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQRhMvLBszANvWQKH6LNOvV0PD9NpV57Yp7QyajLiOHrUxeCo
	SvHynOouIKVqTtbzxkeGRzq42IiyDJtuHxlwHecGz67+VHo8KU2twyEL7EPbRr28Vmz29PzlhYd
	2530i63tQQFeVC3KzTmWWSUlYbt3c9TetIoqJ5DlmnHobZBC2wwKTXI3a0YyOawL1CKA=
X-Gm-Gg: ASbGncumTNdXIqTCrhGFYhjsuoYMSdmUu592tnfPKcyx+4jMzaVXgRjKGuWG61dTZBW
	M6e+7RuVJFJT7hcFRU5PuK2ZzmXQZTn3zLpSLUDYYOniZb3TQ4TIK2/F0lLz4OJl6g8/Uz7AsXj
	+eiG0L+VB9/qCXrMbwyOrLpkEwhFiZdyPvUEnZymO0T4i5ywF8TSNXbGRRANOH5L+p7i5LAnwZz
	K8LO8ArK16HCf01hUk4xEGDJovS3XWyEW6nmNCCwEiRMd3iU9ZrITdLbTfKlcKN1YqHxt7ML1KV
	8PUruU3/SVbDTK9n6Eg6Jr4s8KwxGbHW2y3U90Mj3k//vp5uJhQ0nwph45Io5uNyKKJwK/em8ZJ
	qbv2y6are9VK7S/eHt+FmGKNRBtDtiA==
X-Received: by 2002:a17:902:e5c7:b0:248:dfe0:2bac with SMTP id d9443c01a7336-248dfe02faamr4013815ad.8.1756356674463;
        Wed, 27 Aug 2025 21:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmRbZMzQhw30/ipLkmYDVQtFMWzPa3KvkwGn6LZpn9/xGeveJfUognFXSqr0kP7nvEeevGgA==
X-Received: by 2002:a17:902:e5c7:b0:248:dfe0:2bac with SMTP id d9443c01a7336-248dfe02faamr4013685ad.8.1756356673983;
        Wed, 27 Aug 2025 21:51:13 -0700 (PDT)
Received: from [10.133.33.166] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248e3e0b73csm2558005ad.132.2025.08.27.21.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 21:51:13 -0700 (PDT)
Message-ID: <8918feef-219e-4e69-8901-367189f5066d@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 12:51:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] dt-bindings: display/msm: dp-controller: Add
 sm6150
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
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
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
 <75ra2ofecqu6tid6kr4hnyuztpl6jjaq2ksyquafyajhq2sa4d@4tkggrdqky7y>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <75ra2ofecqu6tid6kr4hnyuztpl6jjaq2ksyquafyajhq2sa4d@4tkggrdqky7y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7tQnzZ_vLUC1H-6oVyAVRNmvglczO3yT
X-Proofpoint-ORIG-GUID: 7tQnzZ_vLUC1H-6oVyAVRNmvglczO3yT
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68afe043 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=RRKZIDRkA7xEvhLoEfwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX8LZILwNkFt7Y
 gehruuLE+yvy5PYUedhh2F4dABAOzI6WBoh+7SJFhxVW1aN5LYWXbMNfAZQhGX8hYjLLBl2DTas
 00+w+pqJzwulvlSONBHvJvkJUSILHIGJgdquAWu7yjM9+a5m6Rv024ZzQPXWxenYX0XmcPglTJJ
 oAaes7PgCyO/4IGqpxDmcnKcE8qI/89azbXpvsusuTiXDmBvWyYjhe45pZGNTXspiOFt8fODb/8
 4JDPI2tKvst/QJdfbHMwJvMt+gd3vIlMqJafl/CCj5xGdiXa5NGmRwDLbSti8AmmdTxuh64ZHqO
 jv+PFMmX1JZ1WNRWUU9AbCQ4StPX9PEQZZ22m+muSnfAErMJTrbiHTwoZB4obNrzjcA/D9om4F6
 aQtS6AVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031


On 8/20/2025 6:18 PM, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 05:34:43PM +0800, Xiangxu Yin wrote:
>> Add DisplayPort controller for Qualcomm SM6150 SoC.
>> While SM6150 currently shares the same configuration as SC7180,
>> its hardware capabilities differ. Explicitly listing it ensures clarity
>> and avoids potential issues if SC7180 support evolves in the future.
> I assume, it has no MST support. Am I right?


From sm6150 ipcat, I found MST-related registers and pixel1 clk definition.

According to the hardware spec, MST is supported, but due to limitations in clock and pipe resources, 

the maximum concurrency capability is restricted to 1920x1200@60 + 1280x720@60.


>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> index 9923b065323bbab99de5079b674a0317f3074373..996d0132e084d401db85014a1a4e445d00d62ed8 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> @@ -27,6 +27,7 @@ properties:
>>            - qcom,sc8280xp-dp
>>            - qcom,sc8280xp-edp
>>            - qcom,sdm845-dp
>> +          - qcom,sm6150-dp
>>            - qcom,sm8350-dp
>>            - qcom,sm8650-dp
>>        - items:
>>
>> -- 
>> 2.34.1
>>

