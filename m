Return-Path: <linux-kernel+bounces-725642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F26B001F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D53B1CA02F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77782E973B;
	Thu, 10 Jul 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CJvsZi1q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED82E92B8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150592; cv=none; b=LIW7CckdU1NI3Kde8l8KRxp1K7oRAPQeB+9go/pLz6sygFlmW1GWsXq3Orf0giXv+YOOhwp4T4rYOEYACYvjLm16TWPOejl302KrNswLCu3yrkEjUKExs1a/eo8pt8y/Ep3JJborJJ/nGwzJewzhAIQuj94yM05ieNbFlMM0oHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150592; c=relaxed/simple;
	bh=aL3HjbrXqAD6L7Xc0fFY03lrdZxa+2iBQMhBs5Ndh+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gawKvpvhBYaUZz9MMzwsjJcQ6Wzi2YVfyXmUpD1QJKisEXhnmX4qB611c5dkcuG0JdyYxpyI9/MM3gUflLzfF+Mg0sQ3SA850X/EoVnLCD+gw4x5eUUyM5fTzw/3q2VAGc4fL/VrcG97POg74zB/zEwzxHbUaf7phZtKvcK7qxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CJvsZi1q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9HFrQ010099
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YMeQ302waQ/lVXch317TVOxg9bPEhO9O7NnF203imC0=; b=CJvsZi1q2495tCk9
	46Vx/lRJaGBGBSBROIyzMx+d79OA5D5UDuImKmIxj8N1mnV0JnLcCew72NyQkMrr
	SW8S+1Re4Xx45SpgGh3ysN9pN4WUZSARzaVfmlAY8rfifFl2U1+sj0oxEs7AgOJe
	+s1u2tRcBtvtfclseXQMyUF7RsgNg//DW3Ae+qXRKIEc6dHG4NLlKLo2IG+qQ34r
	OCBQFB14A7Cu2Rt0WVmrWPLsXat8FilyQKDZh9FgW/ySmthJrITPnyMAWVIGSFXM
	psxM0OH+e7CPLz3WKumov50EYpClIWZ+T2SprOBbJOQ9LcCE9iwvFG5vBV746lnT
	KIA5RA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9dvx0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:29:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d3ba561898so8931985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752150589; x=1752755389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMeQ302waQ/lVXch317TVOxg9bPEhO9O7NnF203imC0=;
        b=C/wkzpYc9yrRk70laWkqk+Txih81CG+VF1ZJtE+r4hb+20PVn8Hp8XovTETmTHYZbg
         rTBUKYEIQX2W7ON4shuwqCslgT2Bosgl0E3VkBQtPp1k8IY8d6TiJlR4QxtjYr5+WXSC
         yD8GkZYCXNUiprXMKlYV9GsS9uSvOPkt+VULurt8z7UguoHkbvB0MnzmV96gg1DGXoMW
         thDs721qs5KnjuC5PlC7jglKBECwMC1EvHzmGyJKWJglmplqsxZiFksDMnE7FFcXof47
         /9CmiQ+9Exw/eUtFDjezhpAtNTF1RFaj48NljiIFLSI9GaaqJ/dc7z7X6BQtdcj0BeWA
         LGWg==
X-Forwarded-Encrypted: i=1; AJvYcCXfWzIXj0+PQBkYIrsgyOy6yptQVDfPzPq/tbAb1/4Gse2U95qBMak2j8j9SN+Pr5akuz21p1izi+8kCvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZ5LbTIQj7BNc2WHmSb4AcMF6Cd7E92NHemmX5AjLkfKvjMqY
	YFBpnBG1GPz1CQuxgy4rPGpL2uEc6VOmFRQccVyDILEoqVCpnYf0U3Hi8lOOHNYSUbOFiUVS57v
	F9PgqYfSaoGi7z3kiNAHBSZL1u9EA2UVJ/pKPzLUBRPrTmelGfwmsQku7t0Zavnc7/+I=
X-Gm-Gg: ASbGncvI8g8/R+7kLA6lk78pf3vLVbSxvwNoLeb0WoHhrHjb+KJDiaLfFE08i0Iv8UY
	z0MK8e0RS65MpBKT9oOxLxFD6ut2FEiprZovskuD9x0KBuYae9UwqK4G4GnOTUE7YH+4iuUst0e
	FEa4iPea3cMFvdkjTjjCwuNJqEpHkMZURbhEkBmC+ZmGPLAh5ofwU9NU4M4ymOLZcnvtu4EoKns
	uGXHk/zbiHd0ZK/MG31WnMFcGxPcbarqduuFBskUTPF628IflH+05+UrYSSlol+epeuEzzYI0Fz
	RT3v/cawq4ZHneINWAm/nQzRgnnfbcOfSgI7Z6za6nqbsugf9KEInChcxRs8NjpqkpZzoS6pjWd
	37VE=
X-Received: by 2002:a05:620a:192a:b0:7ca:e392:2a1b with SMTP id af79cd13be357-7db7d3ad273mr306326785a.10.1752150588604;
        Thu, 10 Jul 2025 05:29:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoLijVe8n8HkS++sYfgSY4jCehRjGuNzgRewdZVKw6l0oW8rg4uJs1mwTv59gejgnKmNBoVQ==
X-Received: by 2002:a05:620a:192a:b0:7ca:e392:2a1b with SMTP id af79cd13be357-7db7d3ad273mr306323585a.10.1752150587891;
        Thu, 10 Jul 2025 05:29:47 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976f333sm803699a12.64.2025.07.10.05.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:29:47 -0700 (PDT)
Message-ID: <a2567891-1dd4-44ff-9853-6f9a451f0a74@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:29:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] phy: qcom: phy-qcom-snps-eusb2: Add extra register
 write for Milos
To: Luca Weiss <luca.weiss@fairphone.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250709-sm7635-eusb-phy-v2-0-4790eeee7ae0@fairphone.com>
 <20250709-sm7635-eusb-phy-v2-4-4790eeee7ae0@fairphone.com>
 <7d073433-f254-4d75-a68b-d184f900294a@oss.qualcomm.com>
 <DB8DGDEN23D2.1GFB8XI0P3YLR@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DB8DGDEN23D2.1GFB8XI0P3YLR@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GGavceq92ibG3_fWIaSJ62aq5uaYyDbB
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=686fb23d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=6H0WHjuAAAAA:8
 a=RC4AtmPg6BGSdlR6CyEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: GGavceq92ibG3_fWIaSJ62aq5uaYyDbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNiBTYWx0ZWRfX6qN8sIATMhBR
 WFvee148IFGJAjrYvKUjzBqg4gbWvgIvexZLYlHP1euFbLOo4GMBwoCS93DHAOYgHrg50+iFjst
 Bmors2t+9c5v1QVtwMFyXE3+3h0vZ7sRahS5TAe9yvegBL65Y1cL7ev0WXTIX1V4qro85CozStb
 nhByFMONy7RLF83wC7wYoz6dULJlGt1MTh62F1Nu94sm2ncz4h5kqXBjILAcNGTdMX4Uvj+Qay6
 dQ6w8bNgyDMqIoXESS7Fc9gMEhVeiwcyMzvUxMOkjWy9NXNYUcrq2fLVOCDojtK4fFubiLyq4aL
 BrQ8Xc0/SW2UOHipzYpVrx4Y7dSznh8ihaAFhmyCDaqqbHclFIzG7eF6q5QPzWikkCoYYRxDpP8
 lHxiNQmEvhYTX6LhVj5aNVyBH51JZOTP8qequsk4R/c3VpViQ6JQ4SlCAI29nSMD9nuuanGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100106

On 7/10/25 2:25 PM, Luca Weiss wrote:
> On Thu Jul 10, 2025 at 2:10 PM CEST, Konrad Dybcio wrote:
>> On 7/9/25 11:18 AM, Luca Weiss wrote:
>>> As per the downstream devicetree for Milos, add a register write for
>>> QCOM_USB_PHY_CFG_CTRL_1 as per the "eUSB2 HPG version 1.0.2 update".
>>>
>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>> The downstream driver supports an arbitrary extra init sequence via
>>> qcom,param-override-seq.
>>>
>>> volcano-usb.dtsi has the following which is implemented in this patch:
>>>
>>>     /* eUSB2 HPG version 1.0.2 update */
>>>     qcom,param-override-seq =
>>>             <0x00 0x58>;
>>> ---
>>>  drivers/phy/phy-snps-eusb2.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/phy/phy-snps-eusb2.c b/drivers/phy/phy-snps-eusb2.c
>>> index e232b8b4d29100b8fee9e913e2124788af09f2aa..87fc086424ba4d9fb3ce870aa7f7971a51d4a567 100644
>>> --- a/drivers/phy/phy-snps-eusb2.c
>>> +++ b/drivers/phy/phy-snps-eusb2.c
>>> @@ -420,6 +420,12 @@ static int qcom_snps_eusb2_hsphy_init(struct phy *p)
>>>  	/* set default parameters */
>>>  	qcom_eusb2_default_parameters(phy);
>>>  
>>> +	if (of_device_is_compatible(p->dev.of_node, "qcom,milos-snps-eusb2-phy")) {
>>> +		/* eUSB2 HPG version 1.0.2 update */
>>> +		writel_relaxed(0x0, phy->base + QCOM_USB_PHY_CFG_CTRL_1);
>>> +		readl_relaxed(phy->base + QCOM_USB_PHY_CFG_CTRL_1);
>>
>> Said HPG asks to clear bits [7:1] on all targets
> 
> Okay, so make this unconditional and only update those bits instead of
> writing the full register?

Yes

> 
> Keep the write at this location, or move the code somewhere else in the
> function?
Let's simply do this instead:

diff --git a/drivers/phy/phy-snps-eusb2.c b/drivers/phy/phy-snps-eusb2.c
index 87f323e758d6..6c44d0366f34 100644
--- a/drivers/phy/phy-snps-eusb2.c
+++ b/drivers/phy/phy-snps-eusb2.c
@@ -392,7 +392,7 @@ static int qcom_snps_eusb2_hsphy_init(struct phy *p)
 
        snps_eusb2_hsphy_write_mask(phy->base, QCOM_USB_PHY_CFG_CTRL_1,
                                    PHY_CFG_PLL_CPBIAS_CNTRL_MASK,
-                                   FIELD_PREP(PHY_CFG_PLL_CPBIAS_CNTRL_MASK, 0x1));
+                                   FIELD_PREP(PHY_CFG_PLL_CPBIAS_CNTRL_MASK, 0x0));
 
        snps_eusb2_hsphy_write_mask(phy->base, QCOM_USB_PHY_CFG_CTRL_4,
                                    PHY_CFG_PLL_INT_CNTRL_MASK


Konrad

